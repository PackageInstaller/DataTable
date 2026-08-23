local SuccubaAIChatPop = class("SuccubaAIChatPop", require("app.fairyGUI.succuba.UI_SuccubaAIChatPop"), function()
	return fgui.GComponent:create({
		resName = "SuccubaAIChatPop",
		pkgPath = "ui/succuba/succuba",
		isFullScreen = true,
		pkgName = "succuba"
	}, ...)
end)

function SuccubaAIChatPop:ctor(arg_2_1, arg_2_2)
	self._chatList = {}
	self._succuba = arg_2_1
	self._callback = arg_2_2
	self._aiData = g.core.model.User.succubaData:getAIData()
	self._loadingTimer = nil

	self:_initPop()

	if g.core.platform.PlatformProxy:isChannelOfChina() then
		self.m_aiTipTxt:setText("以下内容均由AI生成")
		self.m_showAITipController:setSelectedIndex(1)
	end
end

function SuccubaAIChatPop:_initPop()
	self.m_mask:addClickListener(handler(self, self._onCloseSelf))
	self.m_sendBtn:addClickListener(handler(self, self._onSendBtnClicked))
	self.m_clearBtn:addClickListener(handler(self, self._onClearBtnClicked))
	self.m_chatList:setVirtual(self)
	self.m_chatList:setItemRenderer(handler(self, self._onRenderChatItem))
	self.m_chatList:setItemProvider(handler(self, self._onChatItemProvider))
	self.m_chatList:doFairyBatching(false)

	if not self._aiData:checkInitAI() then
		self:_onGetModelList(nil, nil, nil, {
			isSuc = true
		})
	end
end

function SuccubaAIChatPop:_onChatItemProvider(arg_4_1)
	if self._chatList[arg_4_1 + 1].icon then
		return "ui://succuba/SuccubaAIChatLeftCell"
	else
		return "ui://succuba/SuccubaAIChatRightCell"
	end
end

function SuccubaAIChatPop:_onRenderChatItem(arg_5_1, arg_5_2)
	arg_5_2:updateChatItem(self._chatList[arg_5_1 + 1])
end

function SuccubaAIChatPop:addCustomListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.AI_INIT_FINISH, handler(self, self._onGetModelList), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.AI_GET_MODEL_LIST_FINISH, handler(self, self._onSwitchRole), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.AI_SWITCH_TYPE_AND_MODEL_FINISH, handler(self, self._onGetChatList), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.AI_GET_HISTORY_FINISH, handler(self, self._onShowHistory), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.AI_CLEAR_HISTORY_FINISH, handler(self, self._onClearHistory), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.AI_SEND_TOPIC_CONTENT_FINISH, handler(self, self._onSendFinish), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SUCCUBA_INTERACTIVEFINISH, handler(self, self._onSuccubaInterActiveFinish), self)
end

function SuccubaAIChatPop:onLoad()
	self:addCustomListener()
end

function SuccubaAIChatPop:_onGetModelList(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_4.isSuc then
		self._aiData:getModelList()
	end
end

function SuccubaAIChatPop:_onSwitchRole(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	print("_onSwitchRole")

	if arg_9_4.isSuc then
		local var_9_0

		for iter_9_0, iter_9_1 in pairs(arg_9_4.data) do
			if tonumber(iter_9_1.game_role_id) == self._succuba:getAdvanceId() then
				var_9_0 = iter_9_0

				break
			end
		end

		self._aiData:switchAITypeAndModelType(nil, var_9_0)
	end
end

function SuccubaAIChatPop:_onGetChatList(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	print("_onGetChatList")

	if arg_10_4.isSuc then
		self._aiData:getHistory()
	end
end

function SuccubaAIChatPop:_onShowHistory(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if arg_11_4.isSuc then
		self._chatList = {}

		for iter_11_0, iter_11_1 in ipairs(arg_11_4.data) do
			if iter_11_1.content ~= arg_11_4.keyWorld then
				self._chatList[#self._chatList + 1] = self:_getChatInfo(iter_11_1)
			end
		end

		table.sort(self._chatList, function(arg_12_0, arg_12_1)
			return arg_12_0.sortTime < arg_12_1.sortTime
		end)

		self._chatList[#self._chatList + 1] = self:_getChatInfo({
			type = 2,
			content = self._succuba:getTempAIChatContent()
		})

		self:_updateChatList()
	end
end

function SuccubaAIChatPop:_onClearHistory(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if arg_13_4.isSuc then
		self._chatList = {}

		self:_updateChatList()
	end
end

function SuccubaAIChatPop:_getChatInfo(arg_14_1)
	local var_14_0 = {
		time = g.core.common.ServerTime:getTimeStringEx(arg_14_1.create_time),
		sortTime = arg_14_1.create_time,
		content = arg_14_1.content
	}

	if arg_14_1.type == 2 then
		var_14_0.icon = g.core.common.Path:getSuccubaIconById(self._succuba:getShowCfg().icon)
		var_14_0.name = self._succuba:getCurCfg().name
	end

	return var_14_0
end

function SuccubaAIChatPop:_updateChatList()
	self.m_chatList:setNumItems(#self._chatList)
	self.m_chatList:scrollToView(#self._chatList - 1)
	self.m_chatList:getScrollPane():scrollBottom()
end

function SuccubaAIChatPop:_onSendBtnClicked()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Click_Small_02)

	local var_16_0 = self.m_inputTxt:getText()

	if #var_16_0 == 0 then
		return
	end

	if not g.core.platform.PlatformProxy:isChannelOfChina() then
		if #var_16_0:gsub("[%d%s%p]", "") == 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(431045))

			return
		end
	elseif g.core.utils.Black:isMatchText(var_16_0, true) then
		g.core.module.ModuleManager:tip(g.core.lang:get(431034))

		return
	end

	self:_sendContent(var_16_0)
end

function SuccubaAIChatPop:_sendContent(arg_17_1, arg_17_2)
	self._isSp = arg_17_2

	if not arg_17_2 then
		self._chatList[#self._chatList + 1] = self:_getChatInfo({
			content = arg_17_1
		})

		self:_updateChatList()
	end

	self._aiData:sendTopicContent(arg_17_1)
	g.core.module.ModuleManager:showLoading(true)
	self:_doLoadingTimer()
end

function SuccubaAIChatPop:_doLoadingTimer()
	self:_stopLoadingTimer()

	self._loadingTimer = self:newScheduleOnce(handler(self, self._onHttpTimeOut), 15)
end

function SuccubaAIChatPop:_onHttpTimeOut()
	self:_stopLoadingTimer()
	g.core.module.ModuleManager:showLoading(false)
	g.core.module.ModuleManager:tip(g.core.lang:get(2504))
end

function SuccubaAIChatPop:_stopLoadingTimer()
	if self._loadingTimer then
		self:cancelSchedule(self._loadingTimer)
	end

	self._loadingTimer = nil
end

function SuccubaAIChatPop:_onSendFinish(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	self:_stopLoadingTimer()

	if arg_21_4.isSuc then
		if not self._isSp then
			g.core.module.ModuleManager:tip(g.core.lang:get(109052))
		end

		self.m_inputTxt:setText("")

		local var_21_0

		if self._chatList[#self._chatList] and not self._chatList[#self._chatList].icon then
			g.core.network.GameNetProxy:send_C2S_Succuba_InterActiveFinish({
				event_id = 0,
				tp = 2,
				id = self._succuba:getSid()
			})

			var_21_0 = {
				type = 2
			}
		end

		var_21_0.content = arg_21_4.data.message
		self._chatList[#self._chatList + 1] = self:_getChatInfo(var_21_0)

		self:_updateChatList()
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(431029))
	end

	g.core.module.ModuleManager:showLoading(false)
end

function SuccubaAIChatPop:_onCloseSelf()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function SuccubaAIChatPop:onRemoved()
	if self._callback then
		self._callback()
	end
end

function SuccubaAIChatPop:onCancelCallback()
	self.m_backTransition:play(handler(self, function(arg_25_0)
		g.core.module.ModuleManager:onlyPopSelfByDisplay(arg_25_0)
	end))
end

function SuccubaAIChatPop:_onSuccubaInterActiveFinish(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	if arg_26_4.tp == 2 and g.core.model.User.succubaData:succubaHasLeftAIExpTimes(arg_26_4.id, true) then
		local var_26_0 = fgui.UIPackage:createObject("succuba", "SuccubaMainExpTipComp")

		var_26_0:setTipText(g.core.lang:get(431027, {
			num = g.core.config.succuba_parameter_info.get(g.core.const.ConstMgr.SuccubaConst.PARAMETER_ID.INTERACTION_EXP_ID).parameter
		}))
		g.core.module.ModuleManager:tipByCustomComp(var_26_0)
	end
end

function SuccubaAIChatPop:_onClearBtnClicked()
	local var_27_0 = g.core.lang:get(431051) or ""

	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(111026),
		desc = var_27_0,
		onConfirm = handler(self, function(arg_28_0)
			arg_28_0._aiData:clearHistory()
		end)
	}), {
		touchDisappear = true
	})
end

return SuccubaAIChatPop
