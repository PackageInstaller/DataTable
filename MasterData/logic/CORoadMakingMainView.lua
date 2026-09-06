-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/view/copy/making/CORoadMakingMainView.lua

module("logic.extensions.cantonoperaroad.view.copy.making.CORoadMakingMainView", package.seeall)

local CORoadMakingMainView = class("CORoadMakingMainView", ViewComponent)

function CORoadMakingMainView:buildUI()
	CORoadMakingMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._bubbleGo = goutil.findChild(self.mainGO, "role/bubble")
	self._txtBubble = goutil.findChildTextComponent(self.mainGO, "role/bubble/txt")
	self._btnStart = goutil.findChild(self.mainGO, "startCol/btnStart")
	self._txtRemainTimes = goutil.findChildTextComponent(self.mainGO, "startCol/txtRemainTimes")
	self._txtCost = goutil.findChildTextComponent(self.mainGO, "startCol/txtCost")
	self._costIcon = goutil.findChild(self.mainGO, "startCol/txtCost/icon")
	self._goldBarCon = goutil.findChild(self.mainGO, "goldBarCon")
end

function CORoadMakingMainView:bindEvents()
	CORoadMakingMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
end

function CORoadMakingMainView:unbindEvents()
	CORoadMakingMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnStart)
end

function CORoadMakingMainView:onEnter()
	CORoadMakingMainView.super.onEnter(self)

	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.CantonOperaRoad)

	if actCfg then
		self._activityId = actCfg.activityId
	else
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	self._activityInfo = MakingMoonCakeController.instance:getActivityInfo()

	if self._activityInfo == nil then
		self:close()

		return
	end

	self._modelId = GameEnum.ModelTypeAsCOR.CAKE

	self:_onSetUI()
	GlobalDispatcher:addListener(MakingMoonCakeController.PM_MakingMoonCakeInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(MakingMoonCakeController.PM_MakingMoonCakeReceiveCumulativePrizeRes, self._onUpdate, self)
	GlobalDispatcher:addListener(MakingMoonCakeController.PM_MakingMoonCakeBuyTimesRes, self._onUpdate, self)
	GlobalDispatcher:addListener(MakingMoonCakeController.PM_MakingMoonCakeStartGameRes, self._handlePM_MakingMoonCakeStartGameRes, self)
	GlobalDispatcher:addListener(GlobalNotify.CORGetInfoRes, self._checkIsCanEnter, self)
	MakingMoonCakeAgent.instance:sendPM_MakingMoonCakeInfoReq(self._activityInfo.activityId)
end

function CORoadMakingMainView:onExit()
	CORoadMakingMainView.super.onExit(self)
	GlobalDispatcher:removeListener(MakingMoonCakeController.PM_MakingMoonCakeInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(MakingMoonCakeController.PM_MakingMoonCakeReceiveCumulativePrizeRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(MakingMoonCakeController.PM_MakingMoonCakeBuyTimesRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(MakingMoonCakeController.PM_MakingMoonCakeStartGameRes, self._handlePM_MakingMoonCakeStartGameRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.CORGetInfoRes, self._checkIsCanEnter, self)
	MaterialMgr.resetAll(self._costIcon)
end

function CORoadMakingMainView:_onSetUI()
	local actData = CantonOperaRoadConfig.instance:getCorActData(self._activityId)
	local energyList = CantonOperaRoadController.instance:getEnergyListAsCOR(self._activityId)

	if self._goldBarCon then
		local list = {
			energyList
		}

		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)
	end

	local modelData = CantonOperaRoadConfig.instance:getCorModelDataById(self._activityId, self._modelId)

	if not string.nilorempty(modelData.costEnergy) then
		local matType, matId, matNum = MaterialMgr.getMatParams(modelData.costEnergy)

		MaterialMgr.setIcon(self._costIcon, matType, matId, nil, nil)
	else
		MaterialMgr.resetAll(self._costIcon)
	end
end

function CORoadMakingMainView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function CORoadMakingMainView:_onUpdateData()
	return
end

function CORoadMakingMainView:_onUpdateUI()
	self:_onUpdatePlaneUI()
end

function CORoadMakingMainView:_onUpdatePlaneUI()
	self._txtCost.text = CantonOperaRoadController.instance:getEnergyCostAsCORModel(self._modelId)

	local remainTimes = MakingMoonCakeModel.instance:getSurplusTimes()

	self._txtRemainTimes.text = string.format("剩余次数:<color=#20b376>%d</color>次", remainTimes)
end

function CORoadMakingMainView:_checkIsCanEnter()
	if not CantonOperaRoadController.instance:isCanEnterModelAsCOR(self._modelId) then
		local tipsStr = CantonOperaRoadController.instance:getTipsStrByEnterResultAsCOR(self._modelId)

		if not string.nilorempty(tipsStr) then
			FloatWordMgr.instance:show(tipsStr)
		end

		self:close()
	end
end

function CORoadMakingMainView:_onClickBtnTip()
	return
end

function CORoadMakingMainView:_onClickBtnStart()
	local result = CantonOperaRoadController.instance:getEnterChallengeResultAsCORMaking()

	if result ~= GameEnum.ResultCode.Success then
		local str = ""

		str = result == GameEnum.ResultCode.NoEnergy and "能量不足" or CantonOperaRoadController.instance:getTipsStrByEnterResultAsCOR(self._modelId)

		if not string.nilorempty(str) then
			FloatWordMgr.instance:show(str)
		end

		return
	end

	if self._activityInfo == nil then
		return
	end

	local curTimes = MakingMoonCakeModel.instance:getSurplusTimes()
	local weekScore = MakingMoonCakeModel.instance:getWeekScore()

	if curTimes > 0 and weekScore <= self._activityInfo.weekMax then
		local _clientKey = math.random(0, 16384)

		MakingMoonCakeAgent.instance:sendPM_MakingMoonCakeStartGameReq(self._activityInfo.activityId, _clientKey)
	elseif curTimes <= 0 then
		if self._activityInfo.buyTimesPlanId > 0 then
			FloatWordMgr.instance:show(MakingMoonCakeController.instance:getText("TEXT_12"))
		else
			FloatWordMgr.instance:show(MakingMoonCakeController.instance:getText("TEXT_12"))
		end
	else
		FloatWordMgr.instance:show(MakingMoonCakeController.instance:getText("TEXT_13"))
	end
end

function CORoadMakingMainView:_handlePM_MakingMoonCakeStartGameRes()
	UIStateManager.instance:push(ViewName.CORoadMakingScenceView)
end

return CORoadMakingMainView
