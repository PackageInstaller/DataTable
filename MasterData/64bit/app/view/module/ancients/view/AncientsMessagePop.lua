local AncientsMessagePop = class("AncientsMessagePop", require("app.fairyGUI.ancients.UI_AncientsMessagePop"), function()
	return fgui.GComponent:create({
		resName = "AncientsMessagePop",
		pkgName = "ancients",
		pkgPath = "ui/ancients/ancients"
	}, ...)
end)
local var_0_1 = g.core.const.ConstMgr.AncientsConst.NOTICE_TYPE

function AncientsMessagePop:ctor()
	self:getView():center(true)
	self.m_Btn_message:addClickListener(handler(self, self._onClickBtnMessage))
	self.m_List_message:setVirtual(self)
	self.m_List_message:setItemRenderer(handler(self, self._onRenderListMessageCell))

	self._messageData = {}
	self._addNum = 0
end

function AncientsMessagePop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_GETMESSAGEBOARD, handler(self, self._onRcvGetMessage), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_ADDMESSAGE, handler(self, self._onRcvAddMessage), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onGetCommonSimpleUserSnapshot), self)
	g.core.network.GameNetProxy:send_C2S_Ancient_GetMessageBoard({})
end

function AncientsMessagePop:_addMessage(arg_4_1)
	if #arg_4_1 == 0 then
		return
	end

	g.core.network.GameNetProxy:send_C2S_Ancient_AddMessage({
		content = arg_4_1
	})
	g.core.module.ModuleManager:popComponent()
end

function AncientsMessagePop:_updateView()
	self.m_List_message:setNumItems(#self._messageData)
end

function AncientsMessagePop:_onClickBtnMessage()
	local var_6_0 = g.core.model.User.ancientsData:getParamById(50)

	if self._addNum > 0 then
		self:addPopup(require("app.view.base.pop.BaseInputPop").new({
			showCnt = true,
			isMulti = true,
			title = g.core.lang:get(433390),
			btnTitle = g.core.lang:get(1160),
			placeHolder = g.core.lang:get(433391, {
				num = var_6_0
			}),
			length = var_6_0,
			bindInfo = {
				txtType = var_0_1.MESSAGE
			}
		}), {
			ignoreTouch = true
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(433354))
	end
end

function AncientsMessagePop:_onRcvGetMessage(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self._addNum = g.core.config.ancients_parameter_info.get(19).parameter - arg_7_4.daily_add_message_num
	self._messageData = arg_7_4.messages or {}

	if #self._messageData == 0 then
		self.m_is_emptyController:setSelectedIndex(1)

		return
	end

	self.m_is_emptyController:setSelectedIndex(0)

	local var_7_0 = {}
	local var_7_1 = 0

	table.sort(self._messageData, function(arg_8_0, arg_8_1)
		return arg_8_0.create_time > arg_8_1.create_time
	end)

	for iter_7_0, iter_7_1 in ipairs(self._messageData) do
		table.insert(var_7_0, iter_7_1.member_id)

		local var_7_2 = iter_7_1.id or 0

		if var_7_1 < var_7_2 then
			var_7_1 = var_7_2
		end
	end

	g.core.model.User.ancientsData:setMaxMessageId(var_7_1)
	g.core.network.GameNetProxy:send_C2S_GetUserSnapShot({
		user_ids = var_7_0
	})
end

function AncientsMessagePop:_onRcvAddMessage(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	g.core.network.GameNetProxy:send_C2S_Ancient_GetMessageBoard({})
end

function AncientsMessagePop:_onGetCommonSimpleUserSnapshot(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	self._snapshots = arg_10_4.snapshots or {}

	self:_updateView()
end

function AncientsMessagePop:_onRenderListMessageCell(arg_11_1, arg_11_2)
	local var_11_0 = self._messageData[arg_11_1 + 1]
	local var_11_1

	if self._messageData[arg_11_1 + 1].member_id == g.core.model.User:getId() then
		var_11_1 = g.core.model.User:packUser()
	else
		for iter_11_0, iter_11_1 in ipairs(self._snapshots) do
			if self._messageData[arg_11_1 + 1].member_id == iter_11_1.id then
				var_11_1 = iter_11_1
			end
		end
	end

	arg_11_2:updateCell({
		snapshot = var_11_1,
		message = var_11_0
	}, arg_11_1)
end

function AncientsMessagePop:receiveCompEvent(arg_12_1, arg_12_2)
	if arg_12_1 == "input_pop_confirm" then
		self:_addMessage(arg_12_2.text)
	end
end

return AncientsMessagePop
