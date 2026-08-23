local var_0_0 = {
	CLOSE = 0,
	OPEN = 1
}
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.event.enum
local var_0_3 = g.core.model.User.hlTrainData
local HLTrainRoomWorkPop = require("app.view.module.homeLandTrain.view.HLTrainRoomWorkPop")
local HLTrainOneKeyDispatchPop = require("app.view.module.homeLandTrain.view.HLTrainOneKeyDispatchPop")
local KnightVoiceCommon = require("app.view.module.knight.common.KnightVoiceCommon")
local var_0_7 = g.core.event.EventManager
local var_0_8 = g.core.module.ModuleManager
local var_0_9 = g.core.common.ModuleUnlock
local HomeLandTrainLayer = class("HomeLandTrainLayer", require("app.fairyGUI.homeLandTrain.UI_HomeLandTrainLayer"), function()
	return fgui.GComponent:create({
		resName = "HomeLandTrainLayer",
		pkgPath = "ui/homeLandTrain/homeLandTrain",
		isFullScreen = true,
		pkgName = "homeLandTrain"
	}, ...)
end)

function HomeLandTrainLayer:ctor()
	self._curOpenAdvId = nil
	self._isOpen = false
	self._scheduler_60s = nil

	self:_initView()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	self:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end, 1)
end

function HomeLandTrainLayer:onLoad()
	self:_addListeners()
	g.core.sound.SoundManager:playMusic(var_0_1.SoundConst.BGM.MUSIC_SCENE_LIFE)
	self.m_oneKeyDispatchBtn:setVisible((var_0_9:isModuleUnlock(var_0_1.FUNCTION_TYPE.HL_TRAIN_ONE_KEY_DISPATCH)))
	self.m_getAllBtn:setVisible((var_0_9:isModuleUnlock(var_0_1.FUNCTION_TYPE.HL_TRAIN_ONE_KEY_GET_AWARD)))
	self.m_roomsPart:refreshAllRoomCell()
	self.m_roomComp:setVisible(false)
	self.m_roomComp:setTouchable(false)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	self.m_enterTransition:play(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end)

	self._scheduler_60s = self._scheduler_60s or self:newSchedule(handler(self, self._onSchedulerUpdate_60s), 60)

	var_0_7:dispatchEvent(var_0_2.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_getAllBtn
	})
	var_0_7:dispatchEvent(var_0_2.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_oneKeyDispatchBtn
	})
	g.core.model.User.functionUnlockData:saveUnlockedFunc(var_0_1.FUNCTION_TYPE.HOME_LAND_TRAIN)
	self.m_subTipsComp:updateViewById(g.core.const.ConstMgr.ActivityConst.PRIVILEGE_TYPE.HOMELAND_TRAIN)
end

function HomeLandTrainLayer:onUnload()
	self:cancelAllSchedule()
	KnightVoiceCommon.stopVoice()
end

function HomeLandTrainLayer:receiveCompEvent(arg_7_1, arg_7_2)
	if arg_7_1 == "UI_OPEN_TRAIN_TOOM" then
		self:_onOpenSubRoom(arg_7_2)
	end
end

function HomeLandTrainLayer:_initView()
	self.m_topBar:setHelpId(var_0_1.HelpConst.HELP_TYPE.HOME_LAND_TRAIN)
	self.m_topBar:setReturnCallBack(handler(self, self._onBackClicked))
	self:_updateTopBarResItems()
	self.m_statePart:setVisible(false)
	self.m_inSubRoomController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onRoomStateChange))
	self.m_inSubRoomController:setSelectedIndex(var_0_0.CLOSE)
	self.m_oneKeyDispatchBtn:addClickListener(handler(self, self._onOneKeyDispatchClick))
	self.m_getAllBtn:addClickListener(handler(self, self._onGetAllClick))
	self.m_buildUpgradeBtn:addClickListener(handler(self, self._onBuildUpgradeClick))
	self.m_roomWorkBtn:addClickListener(handler(self, self._onRoomWorkBtnClick))
	self.m_gotoFurnitureBtn:addClickListener(handler(self, self._onGotoFurnitureBtnClick))
end

function HomeLandTrainLayer:_addListeners()
	var_0_7:addEventListener(var_0_2.EVENT_NET_S2C_HOME_LAND_TRAIN_GETINFO, self._onS2CHLTrainGetInfo, self)
	var_0_7:addEventListener(var_0_2.EVENT_NET_S2C_HOME_LAND_TRAIN_UPLEVEL, self._onS2CHLTrainUpLevel, self)
	var_0_7:addEventListener(var_0_2.EVENT_NET_S2C_HOME_LAND_TRAIN_DISPATCH, self._onS2CHLTrainDispatch, self)
	var_0_7:addEventListener(var_0_2.EVENT_NET_S2C_HOME_LAND_TRAIN_DISPATCHAWARD, self._onS2CHLTrainDispatchAward, self)
	var_0_7:addEventListener(var_0_2.EVENT_NET_S2C_FURNITURE_ROOM_GETINFO, self._onS2CFurnitureRoomGetInfo, self)
end

function HomeLandTrainLayer:_refreshRedPoints()
	return
end

function HomeLandTrainLayer:_onRoomStateChange()
	self.m_subTipsComp:setShowState(self.m_inSubRoomController:getSelectedIndex() == var_0_0.CLOSE)
end

function HomeLandTrainLayer:_onS2CHLTrainGetInfo()
	self.m_roomComp:updateRolesMobility()
	self.m_roomsPart:refreshAllRoomCell()
	var_0_7:dispatchEvent(var_0_2.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_getAllBtn
	})
end

function HomeLandTrainLayer:_onS2CHLTrainUpLevel(arg_13_1, arg_13_2)
	var_0_8:awardSummary(arg_13_2.awards, true)

	if self._curOpenAdvId == arg_13_2.adv_id then
		self.m_statePart:updateComp(arg_13_2.adv_id)
		self.m_roomComp:refreshRoom(arg_13_2.adv_id)
		self.m_roomsPart:onRefreshRoomCell(arg_13_2.adv_id)
	end

	self.m_roomsPart:refreshAllRoomCell(arg_13_2)
end

function HomeLandTrainLayer:_onS2CHLTrainDispatch(arg_14_1, arg_14_2)
	local var_14_0

	if not arg_14_2.dispatch then
		do return end

		var_14_0 = true
	end

	for iter_14_0, iter_14_1 in pairs(arg_14_2.dispatch) do
		if iter_14_1.knight_ids and #iter_14_1.knight_ids > 0 then
			var_14_0 = false
		end

		self.m_roomsPart:onRefreshRoomCell(iter_14_1.adv_id)
	end

	if self._curOpenAdvId then
		self.m_statePart:updateComp(self._curOpenAdvId)
		self.m_roomComp:refreshRoom(self._curOpenAdvId)
	end

	self.m_roomsPart:refreshAllRoomCell()

	if var_14_0 then
		var_0_8:tip(g.core.lang:get(111056))
	else
		var_0_8:tip(g.core.lang:get(111025))
	end
end

function HomeLandTrainLayer:_onS2CHLTrainDispatchAward(arg_15_1, arg_15_2, arg_15_3)
	for iter_15_0, iter_15_1 in pairs(arg_15_3.adv_id) do
		self.m_roomsPart:onRefreshRoomCell(iter_15_1)
	end

	self.m_roomsPart:refreshAllRoomCell()

	if arg_15_3.surprise then
		for iter_15_2, iter_15_3 in ipairs(arg_15_3.surprise) do
			iter_15_3.iconTagType = var_0_1.BASE_CONST.ICON_TAG_TYPE.LUCKY
		end

		var_0_8:awardSummary(arg_15_3.surprise)
	end
end

function HomeLandTrainLayer:_onS2CFurnitureRoomGetInfo(arg_16_1, arg_16_2, arg_16_3)
	var_0_8:replaceModule(g.view.entrance.FURNITURE)
end

function HomeLandTrainLayer:_onOpenSubRoom(arg_17_1)
	if self._isOpen then
		return
	end

	self._isOpen = true
	self._curOpenAdvId = arg_17_1

	self.m_statePart:updateComp(arg_17_1)
	self.m_roomsPart:onOpenTrainRoom(arg_17_1)
	self.m_roomComp:refreshRoom(arg_17_1)
	self:_updateTopBarResItems()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	self["m_enterRoom" .. arg_17_1 .. "Transition"]:play(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end)
	self["m_enterRoom" .. arg_17_1 .. "Transition"]:setHook("openDoor", handler(self, function()
		self.m_statePart:setVisible(true)
		self.m_roomComp:setVisible(true)
		self.m_roomComp:setRoomOpen(true)
		self.m_roomComp:setTouchable(true)
		self.m_inSubRoomController:setSelectedIndex(var_0_0.OPEN)
		KnightVoiceCommon.stopVoice()

		local var_19_0 = {
			advId = arg_17_1
		}

		var_0_7:dispatchEvent(var_0_2.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_buildUpgradeBtn,
			customData = var_19_0
		})
		var_0_7:dispatchEvent(var_0_2.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_roomWorkBtn,
			customData = var_19_0
		})
	end))
end

function HomeLandTrainLayer:_onCloseSubRoom()
	if not self._isOpen then
		return
	end

	self._isOpen = false

	self.m_statePart:setVisible(false)
	self.m_roomComp:setRoomOpen(false)
	self.m_roomComp:setTouchable(false)
	self:newScheduleOnce(handler(self, function()
		self["m_backRoom" .. self._curOpenAdvId .. "Transition"]:play()
		self.m_inSubRoomController:setSelectedIndex(var_0_0.CLOSE)
		KnightVoiceCommon.stopVoice()
		self.m_roomComp:setVisible(false)
		self:_updateTopBarResItems()

		self._curOpenAdvId = nil

		var_0_7:dispatchEvent(var_0_2.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_getAllBtn
		})
		var_0_7:dispatchEvent(var_0_2.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_oneKeyDispatchBtn
		})
	end), 0.3)
end

function HomeLandTrainLayer:_onBuildUpgradeClick()
	local var_22_0

	if not self._curOpenAdvId then
		do return end

		var_22_0 = require("app.view.module.homeLandTrain.view.HLTrainUpPop").new
	end

	var_0_8:pushPopup((require("app.view.module.homeLandTrain.view.HLTrainUpPop").new((var_0_3:getRoomStruct(self._curOpenAdvId)))))
end

function HomeLandTrainLayer:_onRoomWorkBtnClick()
	if not self._curOpenAdvId then
		return
	end

	var_0_8:pushPopup(HLTrainRoomWorkPop.new(self._curOpenAdvId))
end

function HomeLandTrainLayer:_onGotoFurnitureBtnClick()
	if var_0_9:checkModuleUnlockStatus(var_0_1.FUNCTION_TYPE.HOME_LAND_FURNITURE) then
		g.core.network.GameNetProxy:send_C2S_FurnitureRoom_GetInfo({})
	end
end

function HomeLandTrainLayer:_onOneKeyDispatchClick()
	var_0_8:pushPopup(HLTrainOneKeyDispatchPop.new(), {
		withoutAni = true
	})
end

function HomeLandTrainLayer:_onGetAllClick()
	if var_0_3:isExistAward() then
		var_0_3:reqGetAllRoomsAward()
	else
		var_0_8:tip(g.core.lang:get(111037))
	end
end

function HomeLandTrainLayer:_onBackClicked()
	if self._curOpenAdvId then
		self:_onCloseSubRoom()
	else
		self.m_topBar:checkFullPageExitAnim()
	end
end

function HomeLandTrainLayer:_onSchedulerUpdate_60s()
	if var_0_3:isExpired() then
		g.core.network.GameNetProxy:send_C2S_HomeLandTrain_GetInfo({})
	end
end

function HomeLandTrainLayer:_updateTopBarResItems()
	if self._isOpen then
		self.m_topBar:updateTopRes({})
	else
		self.m_topBar:setResInfoById(71, true)
	end
end

return HomeLandTrainLayer
