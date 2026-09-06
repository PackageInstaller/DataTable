-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/view/copy/answer/CORoadAnswerMainView.lua

module("logic.extensions.cantonoperaroad.view.copy.answer.CORoadAnswerMainView", package.seeall)

local CORoadAnswerMainView = class("CORoadAnswerMainView", ViewComponent)

function CORoadAnswerMainView:buildUI()
	CORoadAnswerMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._txtTrueNum = goutil.findChildTextComponent(self.mainGO, "infoCol/trueNum/txtTrueNum")
	self._txtRemainNum = goutil.findChildTextComponent(self.mainGO, "infoCol/remainNum/txtRemainNum")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "infoCol/txtDesc")
	self._sliderComp = self:getSlider("infoCol/progress/slider")
	self._txtProgress = goutil.findChildTextComponent(self.mainGO, "infoCol/progress/txtProgress")
	self._btnStart = goutil.findChild(self.mainGO, "btnStart")
	self._txtCost = goutil.findChildTextComponent(self.mainGO, "txtCost")
	self._costIcon = goutil.findChild(self.mainGO, "txtCost/icon")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "openTime/txt")
	self._goldBarCon = goutil.findChild(self.mainGO, "goldBarCon")
end

function CORoadAnswerMainView:bindEvents()
	CORoadAnswerMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
end

function CORoadAnswerMainView:unbindEvents()
	CORoadAnswerMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnStart)
end

function CORoadAnswerMainView:onEnter()
	CORoadAnswerMainView.super.onEnter(self)

	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.CantonOperaRoad)

	if actCfg then
		self._activityId = actCfg.activityId
	else
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	self._modelId = GameEnum.ModelTypeAsCOR.ANSWER

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.CORAnswerInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.CORAnswerRes, self._handleCORAnswerRes, self)
	GlobalDispatcher:addListener(GlobalNotify.CORGetInfoRes, self._checkIsCanEnter, self)
	CantonOperaRoadController.instance:sendPM_CantonOperaRoadAnswerInfoReq(self._activityId)
	CantonOperaRoadController.instance:sendPM_CantonOperaRoadGetInfoReq(self._activityId)
end

function CORoadAnswerMainView:onExit()
	CORoadAnswerMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.CORAnswerInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.CORAnswerRes, self._handleCORAnswerRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.CORGetInfoRes, self._checkIsCanEnter, self)
	MaterialMgr.resetAll(self._costIcon)
end

function CORoadAnswerMainView:_onSetUI()
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

	local startTime = AnswerSceneConfig.instance:getParamsValue("START_TIME")
	local endTime = AnswerSceneConfig.instance:getParamsValue("END_TIME")

	if self._txtOpenTime then
		self._txtOpenTime.text = string.format("每日开放时间：%s - %s", startTime, endTime)
	end
end

function CORoadAnswerMainView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function CORoadAnswerMainView:_onUpdateData()
	return
end

function CORoadAnswerMainView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateInfoColUI()
end

function CORoadAnswerMainView:_onUpdatePlaneUI()
	self._txtCost.text = CantonOperaRoadController.instance:getEnergyCostAsCORModel(self._modelId)
end

function CORoadAnswerMainView:_checkIsCanEnter()
	if not CantonOperaRoadController.instance:isCanEnterModelAsCOR(self._modelId) then
		local tipsStr = CantonOperaRoadController.instance:getTipsStrByEnterResultAsCOR(self._modelId)

		if not string.nilorempty(tipsStr) then
			FloatWordMgr.instance:show(tipsStr)
		end

		self:close()
	end
end

function CORoadAnswerMainView:_onUpdateInfoColUI()
	self._txtTrueNum.text = CantonOperaRoadModel.instance:getCorrectNumAsAnswer()

	local lastNum = CantonOperaRoadModel.instance:getLastNumAsAnswer()

	self._txtRemainNum.text = Mathf.Max(lastNum, 0)

	local maxProgress = CantonOperaRoadController.instance:getMaxProgressAsCORModel(self._modelId)
	local curProgress = CantonOperaRoadModel.instance:getModelProgress(self._modelId)

	self._txtProgress.text = string.format("%s/%s", curProgress, maxProgress)

	local percentage = CantonOperaRoadController.instance:getProgressPercentageAsCORModel(self._modelId)

	self._sliderComp:SetValue(percentage)
end

function CORoadAnswerMainView:_onClickBtnTip()
	return
end

function CORoadAnswerMainView:_onClickBtnStart()
	local result = CantonOperaRoadController.instance:getEnterChallengeResultAsCORAnswer()

	if result ~= GameEnum.ResultCode.Success then
		local str = ""

		str = result == GameEnum.ResultCode.NoEnergy and "能量不足" or CantonOperaRoadController.instance:getTipsStrByEnterResultAsCOR(self._modelId)

		if not string.nilorempty(str) then
			FloatWordMgr.instance:show(str)
		end

		return
	end

	CantonOperaRoadController.instance:sendPM_CantonOperaRoadAnswerReq(self._activityId)
end

function CORoadAnswerMainView:_handleCORAnswerRes(status, msg)
	if status ~= 0 then
		return
	end

	AnswerSceneController.instance:enterAnswerScene()
end

return CORoadAnswerMainView
