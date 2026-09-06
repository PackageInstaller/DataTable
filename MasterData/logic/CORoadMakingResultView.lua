-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/view/copy/making/CORoadMakingResultView.lua

module("logic.extensions.cantonoperaroad.view.copy.making.CORoadMakingResultView", package.seeall)

local CORoadMakingResultView = class("CORoadMakingResultView", ViewComponent)

function CORoadMakingResultView:buildUI()
	CORoadMakingResultView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._txtAnswerNum = goutil.findChildTextComponent(self.mainGO, "txtAnswerNum/txt")
	self._txtRightNum = goutil.findChildTextComponent(self.mainGO, "txtRightNum/txt")
	self._txtWrongNum = goutil.findChildTextComponent(self.mainGO, "txtWrongNum/txt")
	self._txtCostNum = goutil.findChildTextComponent(self.mainGO, "txtCostNum/txt")
	self._txtAddProgress = goutil.findChildTextComponent(self.mainGO, "txtAddProgress")
	self._txtRate = goutil.findChildTextComponent(self.mainGO, "txtRate")
	self._sliderComp = self:getSlider("slider")

	local rewardScrollerview = goutil.findChild(self.mainGO, "rewardCol/rewardScrollerview")
	local rewardScrollercell = goutil.findChild(self.mainGO, "rewardCol/rewardScrollercell")

	self._rewardScrollList = ScrollerList.create(rewardScrollerview, rewardScrollercell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
end

function CORoadMakingResultView:bindEvents()
	CORoadMakingResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function CORoadMakingResultView:unbindEvents()
	CORoadMakingResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function CORoadMakingResultView:onEnter()
	CORoadMakingResultView.super.onEnter(self)

	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.CantonOperaRoad)

	if actCfg then
		self._activityId = actCfg.activityId
	else
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	self._modelId = GameEnum.ModelTypeAsCOR.CAKE

	local params = self:getOpenParam()

	if params == nil then
		self:close()
		printError("缺少传入参数")

		return
	end

	self._score = checknumber(params[1])

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.CORGetInfoRes, self._onUpdatePlaneUI, self)
	GlobalDispatcher:addListener(MakingMoonCakeController.PM_MakingMoonCakeReceiveAllPrizeRes, self._onUpdatePrizeUI, self)
	CantonOperaRoadController.instance:sendPM_CantonOperaRoadGetInfoReq(self._activityId)

	local activityInfoAsMaking = MakingMoonCakeController.instance:getActivityInfo()

	if activityInfoAsMaking then
		MakingMoonCakeAgent.instance:sendPM_MakingMoonCakeReceiveAllPrizeReq(activityInfoAsMaking.activityId)
	end
end

function CORoadMakingResultView:onExit()
	CORoadMakingResultView.super.onExit(self)
	self._rewardScrollList:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.CORGetInfoRes, self._onUpdatePlaneUI, self)
	GlobalDispatcher:removeListener(MakingMoonCakeController.PM_MakingMoonCakeReceiveAllPrizeRes, self._onUpdatePrizeUI, self)
	UIStateManager.instance:popByName(ViewName.CORoadMakingScenceView)
end

function CORoadMakingResultView:_onSetUI()
	return
end

function CORoadMakingResultView:_onUpdatePlaneUI()
	local scorePrizeStr = MakingMoonCakeConfig.instance:getParamByKey("SCORE_PRIZE")

	if not string.nilorempty(scorePrizeStr) then
		local matType, matId, matNum = MaterialMgr.getMatParams(scorePrizeStr)

		self._txtAddProgress.text = string.format("考核分数：+%d", self._score * matNum)
	end

	local curProgress = CantonOperaRoadModel.instance:getModelProgress(self._modelId)
	local maxProgress = CantonOperaRoadController.instance:getMaxProgressAsCORModel(self._modelId)

	self._txtRate.text = string.format("%d/%d", curProgress, maxProgress)

	local percentage = CantonOperaRoadController.instance:getProgressPercentageAsCORModel(self._modelId)

	self._sliderComp:SetValue(percentage)
end

function CORoadMakingResultView:_onUpdatePrizeUI(msg)
	local prizeStrList = {}

	if msg.changeSetId ~= nil then
		local moList = MaterialController.instance:getItemsByChangeSetId(msg.changeSetId)

		if moList then
			for _, mo in pairs(moList) do
				table.insert(prizeStrList, mo:toString())
			end
		end
	end

	self._rewardScrollList:reloadData(prizeStrList)
end

function CORoadMakingResultView:_updateRewardCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function CORoadMakingResultView:_clearRewardCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return CORoadMakingResultView
