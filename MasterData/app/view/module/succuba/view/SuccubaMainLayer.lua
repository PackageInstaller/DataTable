local var_0_0 = g.core.const.ConstMgr.SuccubaConst
local DrawSuccuba = require("app.view.common.DrawSuccuba")
local SuccubaMainLayer = class("SuccubaMainLayer", require("app.fairyGUI.succuba.UI_SuccubaMainLayer"), function()
	return fgui.GComponent:create({
		resName = "SuccubaMainLayer",
		pkgPath = "ui/succuba/succuba",
		isFullScreen = true,
		pkgName = "succuba"
	}, ...)
end)

function SuccubaMainLayer:ctor(arg_2_1)
	self._curSuccuba = nil
	self._curRoomId = 0
	self._succubaList = {}
	self._checkTimer = nil
	self._selectedIdx = 0

	self:_initView()
	self:updateRoomList()

	self._defaultRoomId, self._defaultSuccuba = self:_getDefaultRoomIdAndSuccuba(arg_2_1.succuba)

	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.SUCCUBA)
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.Music_PsychedelicRoom)
end

function SuccubaMainLayer:_initView(arg_3_1)
	self.m_chatBtn:addClickListener(handler(self, self._onChatBtnClicked))
	self.m_interactionBtn:addClickListener(handler(self, self._onInteractionBtnClicked))
	self.m_developBtn:addClickListener(handler(self, self._onDevelopBtnClicked))
	self.m_checkBtn:addClickListener(handler(self, self._onCheckBtnClicked))
	self.m_handbookBtn:addClickListener(handler(self, self._onHandbookBtnClicked))
	self.m_formationBtn:addClickListener(handler(self, self._onFormationBtnClicked))
	self.m_fragSellBtn:addClickListener(handler(self, self._onFragSellBtnClicked))
	self.m_callBtn:addClickListener(handler(self, self._onCallBtnClicked))
	self.m_dailyTouch:addClickListener(handler(self, self._onDailyTouchClick))
	self.m_succubaList:setVirtual(self)
	self.m_succubaList:setItemRenderer(handler(self, self._onRenderSuccubaItem))
	self.m_succubaList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickSuccubaItem))
	self.m_succubaList:addEventListener(fgui.UIEventType.ScrollEnd, handler(self, self._onListScrollEnd))
	self.m_succubaList:doFairyBatching(false)
end

function SuccubaMainLayer:_addCustomListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SUCCUBA_GETINFO, handler(self, self.updateView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SUCCUBA_INTERACTIVEGET, handler(self, self._onS2CSuccubaInterActiveGet), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SUCCUBA_INTERACTIVEFINISH, handler(self, self._onSuccubaInterActiveFinish), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SUCCUBA_SETMAINSUCCUBA, handler(self, self._onS2CSuccubaSetMainSuccuba), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRAGMENT_COMPOSE, handler(self, self._onS2CFragmentCompose), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
end

function SuccubaMainLayer:onLoad()
	if self._curSuccuba then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_developBtn,
			customData = {
				sid = self._curSuccuba:getSid()
			}
		})
	end

	self:_addCustomListener()

	if #g.core.model.User.succubaData:getSuccubaList() > 0 then
		self:updateMainView()
	else
		self:updateEmptySuccuba()
	end
end

function SuccubaMainLayer:updateEmptySuccuba()
	self:addBg("bg/succuba/zhiliao.jpg", false, nil, 1)
	self.m_interactionStateController:setSelectedIndex(5)

	self._succubaList = g.core.model.User.succubaData:getAllSuccubaList()

	self.m_succubaList:setNumItems(#self._succubaList)
end

function SuccubaMainLayer:updateMainView()
	self._succubaList = g.core.model.User.succubaData:getAllSuccubaList()

	self:updateRoomList()
	self:newScheduleOnce(handler(self, self._checkWaitInteraction), 0.3)

	local var_7_0 = g.core.model.User.succubaData:getSuccubaList()

	if not g.core.model.User.succubaData:getMainShowSuccuba() and #var_7_0 > 0 then
		self._lastMainSid = 0

		self:_setMainSuccuba(var_7_0[1]:getSid())
	end

	if self._curRoomId == 0 then
		self.m_roomListComp:setSelectedRoom(self._defaultRoomId or 1)
	else
		self:updateView()
	end

	local var_7_2 = self.m_formationBtn:getChild("redPointComp")

	var_7_2:setVisible(true)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = var_7_2
	})
end

function SuccubaMainLayer:onUnload()
	return
end

function SuccubaMainLayer:onClickBackBtn()
	local var_9_0 = self.m_interactionStateController:getSelectedIndex()

	if var_9_0 == 1 or var_9_0 == 3 or var_9_0 == 5 then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	else
		self[table.concat({
			"m_back",
			var_9_0,
			"Transition"
		})]:play(handler(self, function(arg_10_0)
			g.core.module.ModuleManager:onlyPopSelfByDisplay(arg_10_0)
		end))
	end
end

function SuccubaMainLayer:_onRenderSuccubaItem(arg_11_1, arg_11_2)
	arg_11_2:updateIconItem(self._succubaList[arg_11_1 + 1])
end

function SuccubaMainLayer:_onClickSuccubaItem()
	self:_changeSuccuba((self.m_succubaList:getSelectedIndex()))
end

function SuccubaMainLayer:_onListScrollEnd()
	return
end

function SuccubaMainLayer:_checkSuccubaFragCanCompose(arg_14_1)
	local var_14_0 = arg_14_1:getCurStarCfg()

	return var_14_0.next_star_num <= math.min(g.core.model.User.fragmentsData:getFragmentNumById(var_14_0.fragment), var_14_0.next_star_num)
end

function SuccubaMainLayer:_changeSuccuba(arg_15_1)
	local var_15_0 = self._succubaList[arg_15_1 + 1]

	if not self._succubaList[arg_15_1 + 1]:isOwn() then
		if not self:_checkSuccubaFragCanCompose(var_15_0) then
			g.core.module.ModuleManager:tip(g.core.lang:get(431038))
			self.m_succubaList:setSelectedIndex(self._selectedIdx)
			g.core.module.ModuleManager:pushPopup(require("app.view.module.succuba.view.SuccubaInfoPop").new({
				succubaStruct = var_15_0
			}), {
				touchDisappear = false,
				ignoreTouch = false
			})

			return
		else
			local var_15_1 = {
				num = 1
			}

			var_15_1.id = var_15_0:getCurCfg().fragment

			g.core.network.GameNetProxy:send_C2S_Fragment_Compose(var_15_1)

			return
		end
	end

	self._selectedIdx = arg_15_1
	self._curSuccuba = var_15_0

	self.m_infoComp:updateCompUI(self._curSuccuba)
	self:_onUpdateRoomBg(self._curSuccuba:getAdvanceId())
	self:_onUpdateSuccubaSpine()

	local var_15_3 = g.core.model.User.succubaData:getMainShowSuccuba()

	self.m_checkBtn:setSelected(var_15_0:getSid() == ((var_15_3 or nil) and var_15_3:getSid()))
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_chatBtn:getChild("redPointComp"),
		customData = {
			sid = self._curSuccuba:getSid()
		}
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_developBtn,
		customData = {
			sid = self._curSuccuba:getSid()
		}
	})
end

function SuccubaMainLayer:_onUpdateSuccubaSpine(arg_16_1)
	arg_16_1 = arg_16_1 or self._curSuccuba

	local var_16_0 = arg_16_1:getShowCfg()

	if not self._drawSuccuba or self._drawSuccuba and self._drawSuccuba:getShowInfo().res ~= var_16_0.res then
		self.m_spineHold:removeChildren()

		self._drawSuccuba = DrawSuccuba.new({
			showCfg = var_16_0,
			bgUrl = self._bgUrl
		})

		self.m_spineHold:addChild(self._drawSuccuba)
	end
end

function SuccubaMainLayer:_onUpdateRoomBg(arg_17_1)
	local var_17_0 = {
		"bg/succuba/",
		g.core.config.succuba_room_info.get(self._curRoomId).general
	}

	if arg_17_1 then
		var_17_0[#var_17_0 + 1] = "_"
		var_17_0[#var_17_0 + 1] = arg_17_1
	end

	var_17_0[#var_17_0 + 1] = ".jpg"
	self._bgUrl = table.concat(var_17_0)

	if not self._commonBg then
		self:addBg(self._bgUrl, false, nil, 1)
	else
		self._commonBg:setURL(self._bgUrl)
	end

	self._commonBg:setVisible(not arg_17_1)
end

function SuccubaMainLayer:updateRoomList()
	self.m_roomListComp:updateListComp()
end

function SuccubaMainLayer:_updateViewAndChangeRoom(arg_19_1)
	self._succubaList = g.core.model.User.succubaData:getAllSuccubaList()

	self.m_succubaList:setNumItems(#self._succubaList)

	for iter_19_0, iter_19_1 in ipairs(self._succubaList) do
		if iter_19_1:getSid() == arg_19_1 then
			self._selectedIdx = iter_19_0 - 1

			break
		end
	end

	self.m_succubaList:setSelectedIndex(self._selectedIdx)
	self:_onClickSuccubaItem()
	self:updateRoomList()
	self:updateActionTimes()
	self:_onListScrollEnd()
end

function SuccubaMainLayer:updateView()
	self._succubaList = g.core.model.User.succubaData:getAllSuccubaList()

	self.m_succubaList:setNumItems(#self._succubaList)

	if self.m_succubaList:getSelectedIndex() ~= self._selectedIdx then
		self.m_succubaList:setSelectedIndex(self._selectedIdx)
		self:_onClickSuccubaItem()
	else
		self.m_infoComp:refreshCompUI()
	end

	self:updateRoomList()
	self:updateActionTimes()
	self:_onListScrollEnd()
end

function SuccubaMainLayer:updateActionTimes()
	self.m_interactionBtn:setTitle(g.core.lang:get(431025, {
		num = g.core.config.succuba_parameter_info.get(var_0_0.PARAMETER_ID.INTERACTION_TIMES_ID).parameter - g.core.model.User.succubaData:getInteractionActionTimes()
	}))
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_interactionBtn:getChild("redPointComp")
	})
end

function SuccubaMainLayer:receiveCompEvent(arg_22_1, arg_22_2)
	if arg_22_1 == "clickRoomIcon" then
		self._selectedIdx = 0

		self:changeRoom(arg_22_2.room)

		return true
	end
end

function SuccubaMainLayer:changeRoom(arg_23_1)
	self.m_topBarComp:setResInfoById(355)
	self.m_topBarComp:setDefaultResNum(0)

	self._curRoomId = arg_23_1

	local var_23_0 = g.core.model.User.succubaData:getSuccubaByRoom(arg_23_1)
	local var_23_1

	if var_23_0 then
		self:_updateViewAndChangeRoom(var_23_0:getSid())
		self.m_interactionStateController:setSelectedIndex(0)

		var_23_1 = var_23_0:getAdvanceId()

		if self._defaultSuccuba and self._defaultSuccuba == g.core.model.User.succubaData:getMainShowSuccuba() and not self:_getWaitSuccubaEvent() then
			self:_playDailyTalk(self._defaultSuccuba)

			self._defaultRoomId = nil
			self._defaultSuccuba = nil
		end

		if self._curRoomId == 0 then
			self.m_switch0Transition:play()
		end
	else
		self:_waitCheckInRoom()
	end

	self:_onUpdateRoomBg(var_23_1)
end

function SuccubaMainLayer:_waitCheckInRoom()
	local var_24_0 = g.core.model.User.succubaData:getRandomAlongSuccubaList()

	self._roomSuccubaList = var_24_0

	for iter_24_0 = 1, 3 do
		local var_24_1 = self[table.concat({
			"m_succbaIcon",
			iter_24_0
		})]
		local var_24_2 = var_24_0[iter_24_0]

		if var_24_0[iter_24_0] then
			var_24_1:updateIconItem(var_24_2)
		end

		var_24_1:setVisible(var_24_2 ~= nil)
	end

	self.m_interactionStateController:setSelectedIndex(2)
	self.m_enter2Transition:play()
end

function SuccubaMainLayer:_onChatBtnClicked()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.succuba.view.SuccubaAIChatPop").new(self._curSuccuba, handler(self, function(arg_26_0)
		arg_26_0.m_switch0Transition:play()
		arg_26_0.m_interactionStateController:setSelectedIndex(0)
	end)), {
		touchDisappear = true,
		blackOpacity = 0
	})
	self.m_interactionStateController:setSelectedIndex(3)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Click_Middle_01)
end

function SuccubaMainLayer:_onInteractionBtnClicked()
	local var_27_0

	if g.core.model.User.succubaData:getLeftInteractionTimes() < 1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(431039))

		do return end

		var_27_0 = require("app.view.base.pop.BaseConfirmPop").new
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(111026),
		desc = g.core.lang:get(431036, {
			name = self._curSuccuba:getCurCfg().name
		}),
		onConfirm = handler(self, function(arg_28_0)
			g.core.network.GameNetProxy:send_C2S_Succuba_InterActiveGet({
				id = arg_28_0._curSuccuba:getSid()
			})
		end)
	}), {
		touchDisappear = true
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Click_Middle_01)
end

function SuccubaMainLayer:_onDevelopBtnClicked()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Click_Middle_01)
	g.core.module.ModuleManager:pushModule(g.view.entrance.SUCUBA_DEV_LAYER, {
		advId = self._succubaList[self.m_succubaList:getSelectedIndex() + 1]:getAdvanceId()
	})
end

function SuccubaMainLayer:_onCheckBtnClicked()
	local var_30_0 = g.core.model.User.succubaData:getMainShowSuccuba()

	if not self.m_checkBtn:isSelected() and var_30_0 and var_30_0:getSid() == self._curSuccuba:getSid() then
		self.m_checkBtn:setSelected(true)
		g.core.module.ModuleManager:tip(g.core.lang:get(431037))

		return
	end

	self:_setMainSuccuba((self._curSuccuba:getSid()))
end

function SuccubaMainLayer:_setMainSuccuba(arg_31_1)
	g.core.network.GameNetProxy:send_C2S_Succuba_SetMainSuccuba({
		id = arg_31_1
	})
end

function SuccubaMainLayer:_onHandbookBtnClicked()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SUCUBA_HANDBOOK_LAYER, {
		bgUrl = self._bgUrl,
		sid = (self._curSuccuba or nil) and self._curSuccuba:getSid()
	})
end

function SuccubaMainLayer:_onCallBtnClicked()
	if self.m_interactionStateController:getSelectedIndex() == 2 then
		local var_33_0 = self._roomSuccubaList[self.m_selectedIdxController:getSelectedIndex() + 1]

		if var_33_0 then
			g.core.model.User.succubaData:checkInRoom(var_33_0:getSid(), self._curRoomId)
			g.core.module.ModuleManager:tip(g.core.lang:get(431020))
		end

		self.m_interactionStateController:setSelectedIndex(0)
		self:_updateViewAndChangeRoom(var_33_0:getSid())
	end
end

function SuccubaMainLayer:_onFormationBtnClicked()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION)
end

function SuccubaMainLayer:_onFragSellBtnClicked()
	g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.FragSellPop").new(g.core.model.User.succubaData:getCanSellFrag(), {
		fragNameId = 431032,
		qualityArr = {
			g.core.const.ConstMgr.QUALITY_TYPE.MR,
			g.core.const.ConstMgr.QUALITY_TYPE.UR
		},
		title = g.core.lang:get(431031),
		emptyTitle = g.core.lang:get(431033)
	})))
end

function SuccubaMainLayer:_onS2CSuccubaInterActiveGet(arg_36_1, arg_36_2, arg_36_3, arg_36_4)
	self:_showInteraction(arg_36_4.event_id)
end

function SuccubaMainLayer:_getDefaultRoomIdAndSuccuba(arg_37_1)
	arg_37_1 = arg_37_1 or g.core.model.User.succubaData:getMainShowSuccuba()

	return (arg_37_1 or nil) and arg_37_1:getRoomId(), arg_37_1
end

function SuccubaMainLayer:_getWaitSuccubaEvent()
	local var_38_0

	for iter_38_0, iter_38_1 in ipairs(self._succubaList) do
		local var_38_1 = iter_38_1:getEventId()
		local var_38_2

		if var_38_1 ~= 0 then
			var_38_0 = iter_38_1
			var_38_2 = var_38_1

			break
		end
	end

	return var_38_0, nil
end

function SuccubaMainLayer:_checkWaitInteraction()
	local var_39_0, var_39_1 = self:_getWaitSuccubaEvent()

	if var_39_0 then
		self:_onUpdateSuccubaSpine(var_39_0)
		self:_showInteraction(var_39_1, var_39_0)
	end
end

function SuccubaMainLayer:_playDailyTalk(arg_40_1)
	self.m_dailyTalkComp:getChild("nameTxt"):setText(arg_40_1:getCurCfg().name)

	self._typeWriter = require("app.view.common.TypeWriter").new({
		label = self.m_dailyTalkComp:getChild("dialogTxt"),
		str = arg_40_1:getRandomDailyTalk(),
		callback = handler(self, self._playDailyTalkEnd)
	})

	self._typeWriter:start()
	self.m_dailyTouch:setVisible(false)
	self.m_interactionStateController:setSelectedIndex(4)
	self.m_enter4Transition:play()
end

function SuccubaMainLayer:_playDailyTalkEnd()
	self._typeWriter = nil

	self.m_dailyTalkComp:getTransition("continue"):play(99, 0, function()
		return
	end)
	self.m_dailyTalkComp:getController("isShowContinue"):setSelectedIndex(1)
	self.m_dailyTouch:setVisible(true)
end

function SuccubaMainLayer:_onDailyTouchClick()
	self.m_dailyTouch:setVisible(false)
	self.m_dailyTalkComp:getController("isShowContinue"):setSelectedIndex(0)
	self.m_dailyTalkComp:getTransition("continue"):stop()
	self.m_interactionStateController:setSelectedIndex(0)
	self.m_enter0Transition:play()
end

function SuccubaMainLayer:_showInteraction(arg_44_1, arg_44_2)
	arg_44_2 = arg_44_2 or self._curSuccuba

	if not arg_44_2 then
		arg_44_2 = self._curSuccuba
	elseif arg_44_2 ~= self._curSuccuba then
		self:_onUpdateSuccubaSpine(arg_44_2)
	end

	local var_44_0 = g.core.config.succuba_interaction_info.get(arg_44_1)

	if not self._interactionComp then
		self._interactionComp = fgui.UIPackage:createObject("succuba", "SuccubaMainInteractionComp")

		self._interactionComp:setSize(cc.size(display.width, display.height))
		self.m_interactionNode:addChild(self._interactionComp)
		self._interactionComp:setTouchable(true)
	end

	local var_44_1 = {
		netSync = true,
		cfg = var_44_0,
		callback = handler(self, self._hideInteraction),
		succuba = arg_44_2,
		drawSuccuba = self._drawSuccuba
	}
	local var_44_2 = arg_44_2:getProgress()

	if var_44_2 > 0 then
		var_44_1.idx = var_44_2
	end

	self._interactionComp:playInteraction(var_44_1)
	self._interactionComp:setVisible(true)

	self._lastState = self.m_interactionStateController:getSelectedIndex()

	self.m_interactionStateController:setSelectedIndex(1)
	self.m_topBarComp:setResInfoById(356)
	self.m_topBarComp:setDefaultResNum(0)
end

function SuccubaMainLayer:_hideInteraction(arg_45_1)
	self.m_topBarComp:setResInfoById(355)
	self.m_topBarComp:setDefaultResNum(0)
	self._interactionComp:setVisible(false)
	self.m_interactionStateController:setSelectedIndex(self._lastState)

	if arg_45_1 ~= self._curSuccuba then
		self:_onUpdateSuccubaSpine(self._curSuccuba)
	else
		self._drawSuccuba:playIdle()
	end

	if self._lastState == 0 then
		self.m_switch0Transition:play()
	end
end

function SuccubaMainLayer:_onSuccubaInterActiveFinish(arg_46_1, arg_46_2, arg_46_3, arg_46_4)
	if arg_46_4.tp == 1 then
		local var_46_0 = fgui.UIPackage:createObject("succuba", "SuccubaMainExpTipComp")

		var_46_0:setTipText(g.core.lang:get(431027, {
			num = g.core.config.succuba_interaction_info.get(arg_46_4.event_id).exp
		}))
		g.core.module.ModuleManager:tipByCustomComp(var_46_0)
	end

	self:updateView()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_chatBtn:getChild("redPointComp"),
		customData = {
			sid = self._curSuccuba:getSid()
		}
	})
end

function SuccubaMainLayer:_onS2CSuccubaSetMainSuccuba(arg_47_1, arg_47_2, arg_47_3, arg_47_4)
	if arg_47_4.id then
		g.core.module.ModuleManager:tip(g.core.lang:get(100529))
		self.m_checkBtn:setSelected(self._curSuccuba:getSid() == arg_47_4.id)

		if self._lastMainSid == 0 then
			self:_playDailyTalk(self._curSuccuba)
		end

		self._lastMainSid = nil
	end
end

function SuccubaMainLayer:_onS2CFragmentCompose(arg_48_1, arg_48_2, arg_48_3, arg_48_4)
	local var_48_0

	if not arg_48_4.id then
		do return end

		var_48_0 = {
			num = 1
		}
	end

	var_48_0.showType = g.core.const.ConstMgr.ShowConst.SUCCUBA_SHOW
	var_48_0.id = arg_48_4.id
	var_48_0.func = handler(self, self.updateMainView)

	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOW, var_48_0)
end

function SuccubaMainLayer:_onCrossDayUpdate()
	g.core.network.GameNetProxy:send_C2S_Succuba_GetInfo({})
end

return SuccubaMainLayer
