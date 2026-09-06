-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/view/copy/answer/CORoadAnswerResultView.lua

module("logic.extensions.cantonoperaroad.view.copy.answer.CORoadAnswerResultView", package.seeall)

local CORoadAnswerResultView = class("CORoadAnswerResultView", ViewComponent)

function CORoadAnswerResultView:buildUI()
	CORoadAnswerResultView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._txtAnswerNum = goutil.findChildTextComponent(self.mainGO, "txtAnswerNum/txt")
	self._txtRightNum = goutil.findChildTextComponent(self.mainGO, "txtRightNum/txt")
	self._txtCostNum = goutil.findChildTextComponent(self.mainGO, "txtCost")
	self._costIcon = goutil.findChild(self.mainGO, "txtCost/icon")
	self._txtAddProgress = goutil.findChildTextComponent(self.mainGO, "txtAddProgress")
	self._txtRate = goutil.findChildTextComponent(self.mainGO, "txtRate")
	self._sliderComp = self:getSlider("slider")

	local rewardScrollerview = goutil.findChild(self.mainGO, "rewardCol/rewardScrollerview")
	local rewardScrollercell = goutil.findChild(self.mainGO, "rewardCol/rewardScrollercell")

	self._rewardScrollList = ScrollerList.create(rewardScrollerview, rewardScrollercell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
end

function CORoadAnswerResultView:bindEvents()
	CORoadAnswerResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function CORoadAnswerResultView:unbindEvents()
	CORoadAnswerResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function CORoadAnswerResultView:onEnter()
	CORoadAnswerResultView.super.onEnter(self)

	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.CantonOperaRoad)

	if actCfg then
		self._activityId = actCfg.activityId
	else
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	self._modelId = GameEnum.ModelTypeAsCOR.ANSWER
	self._rightNum = CantonOperaRoadModel.instance:getRightAnswerRecord()
	self._wrongNum = CantonOperaRoadModel.instance:getWrongAnswerRecord()

	self:_onSetUI()
	self:_onUpdate()
	GlobalDispatcher:addListener(GlobalNotify.CORGetInfoRes, self._onUpdate, self)
	CantonOperaRoadController.instance:sendPM_CantonOperaRoadGetInfoReq(self._activityId)
end

function CORoadAnswerResultView:onExit()
	CORoadAnswerResultView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.CORGetInfoRes, self._onUpdate, self)
	self._rewardScrollList:dispose()
	CantonOperaRoadModel.instance:clearPrizeIdListAsAnswer()
	MaterialMgr.resetAll(self._costIcon)
end

function CORoadAnswerResultView:_onSetUI()
	local modelData = CantonOperaRoadConfig.instance:getCorModelDataById(self._activityId, self._modelId)

	if not string.nilorempty(modelData.costEnergy) then
		local matType, matId, matNum = MaterialMgr.getMatParams(modelData.costEnergy)

		MaterialMgr.setIcon(self._costIcon, matType, matId, nil, nil)
	else
		MaterialMgr.resetAll(self._costIcon)
	end
end

function CORoadAnswerResultView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function CORoadAnswerResultView:_onUpdateData()
	return
end

function CORoadAnswerResultView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateRewardColUI()
end

function CORoadAnswerResultView:_onUpdatePlaneUI()
	local totalNum = self._rightNum + self._wrongNum

	self._txtAnswerNum.text = totalNum

	local cost = CantonOperaRoadController.instance:getEnergyCostAsCORModel(self._modelId)

	self._txtCostNum.text = cost * totalNum
	self._txtRightNum.text = self._rightNum

	local corAnswerData = CantonOperaRoadConfig.instance:getCorAnswerDataById(self._activityId)

	if not string.nilorempty(corAnswerData.prize) then
		local matType, matId, matNum = MaterialMgr.getMatParams(corAnswerData.prize)
		local addProgress = self._rightNum * matNum

		self._txtAddProgress.text = string.format("考核分数：+%d", addProgress)
	end

	local curProgress = CantonOperaRoadModel.instance:getModelProgress(self._modelId)
	local maxProgress = CantonOperaRoadController.instance:getMaxProgressAsCORModel(self._modelId)

	self._txtRate.text = string.format("%d/%d", curProgress, maxProgress)

	local percentage = CantonOperaRoadController.instance:getProgressPercentageAsCORModel(self._modelId)

	self._sliderComp:SetValue(percentage)
end

function CORoadAnswerResultView:_onUpdateRewardColUI()
	local prizeIdList = CantonOperaRoadModel.instance:getPrizeIdListAsAnswer()
	local prizeStrList = {}

	for _, prizeId in ipairs(prizeIdList) do
		local data = CantonOperaRoadConfig.instance:getCorAnswerPrizeDataById(self._activityId, prizeId)

		if data and not string.nilorempty(data.prize) then
			local prizeStrArray = string.split(data.prize, "#")

			for _, prizeStr in ipairs(prizeStrArray) do
				table.insert(prizeStrList, prizeStr)
			end
		end
	end

	self._rewardScrollList:reloadData(prizeStrList)
end

function CORoadAnswerResultView:_updateRewardCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function CORoadAnswerResultView:_clearRewardCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return CORoadAnswerResultView
