-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anchorsimulator/view/AnchorSimulatorMainView.lua

module("logic.extensions.anchorsimulator.view.AnchorSimulatorMainView", package.seeall)

local AnchorSimulatorMainView = class("AnchorSimulatorMainView", ViewComponent)

function AnchorSimulatorMainView:buildUI()
	AnchorSimulatorMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._con = self:getGo("con")
	self._btnRank = self:getGo("btnCol/btnRank")
	self._redBtnRank = self:getGo("btnCol/btnRank/redPoint")
	self._btnTask = self:getGo("btnCol/btnTask")
	self._redBtnTask = self:getGo("btnCol/btnTask/redPoint")
	self._btnPlay = self:getGo("btnPlay")
	self._redBtnPlay = self:getGo("btnPlay/redPoint")
	self._imgPassBtnPlay = self:getGo("btnPlay/imgPass")
	self._btnHot = self:getGo("btnHot")
	self._redBtnHot = self:getGo("btnHot/redPoint")
	self._imgPassBtnHot = self:getGo("btnHot/imgPass")
end

function AnchorSimulatorMainView:bindEvents()
	AnchorSimulatorMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnPlay, self._onClickBtnPlay, self)
	GameUtil.addClickHandler(self._btnHot, self._onClickBtnHot, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickBtnTask, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
end

function AnchorSimulatorMainView:unbindEvents()
	AnchorSimulatorMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnPlay)
	GameUtil.rmClickHandler(self._btnHot)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnRank)
end

function AnchorSimulatorMainView:onEnter()
	AnchorSimulatorMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = AnchorSimulatorController.instance:getActivityId()
	end

	self._activityType = AnchorSimulatorController.instance:getActivityType()

	local isInTime = AnchorSimulatorController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._actData = AnchorSimulatorConfig.instance:getActData(self._activityId)
	self._anchorSimulatorMo = AnchorSimulatorController.instance:getAnchorSimulatorMo(self._activityId)

	AnchorSimulatorController.instance:sendPM_AnchorSimulatorGetInfoReq(self._activityId)
	self:_onSetUI()
end

function AnchorSimulatorMainView:onExit()
	AnchorSimulatorMainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redBtnTask)

	if self._loader then
		self._loader = RoleObjectPool.instance:removeRole(self._loader)
	end
end

function AnchorSimulatorMainView:_onSetUI()
	self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)

	local redId = AnchorSimulatorController.instance:getEventTaskRedId()

	if redId then
		RedPointController.instance:regRedPoint(self._redBtnTask, redId)
	end

	local skinId = 10385
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

	if not modelCfg[3] then
		local x, y, scale = modelCfg[1] or 0, modelCfg[2] or 0, 1

		self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, skinId, self._con, scale, nil, true, x, y)
	end
end

function AnchorSimulatorMainView:_onClickBtnTip()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function AnchorSimulatorMainView:_onClickBtnPlay()
	if self._anchorSimulatorMo:isCanStartLive() then
		UIStateManager.instance:push(ViewName.AnchorSimulatorLiveReadyView, self._activityId)
	else
		UIStateManager.instance:push(ViewName.AnchorSimulatorLiveTrainMainView, self._activityId)
	end
end

function AnchorSimulatorMainView:_onClickBtnHot()
	local activityId = NaiLongHotSearchController.instance:getActivityId()
	local result = NaiLongHotSearchController.instance:getTryOpenHotSeachMainViewResultAndTips(true, activityId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIStateManager.instance:push(ViewName.NaiLongHotSearchMainView, activityId)
end

function AnchorSimulatorMainView:_onClickBtnTask()
	AnchorSimulatorController.instance:opEventTask()
end

function AnchorSimulatorMainView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.AnchorSimulatorRankView, self._activityId)
end

return AnchorSimulatorMainView
