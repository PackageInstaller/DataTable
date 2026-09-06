-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/view/copy/jigsaw/CORJigsawResultView.lua

module("logic.extensions.cantonoperaroad.view.copy.jigsaw.CORJigsawResultView", package.seeall)

local CORJigsawResultView = class("CORJigsawResultView", ViewComponent)

function CORJigsawResultView:buildUI()
	CORJigsawResultView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._txtAnswerNum = goutil.findChildTextComponent(self.mainGO, "txtAnswerNum/txt")
	self._txtRightNum = goutil.findChildTextComponent(self.mainGO, "txtRightNum/txt")
	self._txtWrongNum = goutil.findChildTextComponent(self.mainGO, "txtWrongNum/txt")
	self._txtCostNum = goutil.findChildTextComponent(self.mainGO, "txtCostNum/txt")
	self._txtAddProgress = goutil.findChildTextComponent(self.mainGO, "txtAddProgress")
	self._txtRate = goutil.findChildTextComponent(self.mainGO, "txtRate")
	self._txtResule = goutil.findChildTextComponent(self.mainGO, "resule/txt")
	self._sliderComp = self:getSlider("slider")

	local rewardScrollerview = goutil.findChild(self.mainGO, "rewardCol/rewardScrollerview")
	local rewardScrollercell = goutil.findChild(self.mainGO, "rewardCol/rewardScrollercell")

	self._rewardScrollList = ScrollerList.create(rewardScrollerview, rewardScrollercell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
end

function CORJigsawResultView:bindEvents()
	CORJigsawResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function CORJigsawResultView:unbindEvents()
	CORJigsawResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function CORJigsawResultView:onEnter()
	CORJigsawResultView.super.onEnter(self)

	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.CantonOperaRoad)

	if actCfg then
		self._activityId = actCfg.activityId
	else
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	self._modelId = GameEnum.ModelTypeAsCOR.JIGSAW

	local changeSetId = CantonOperaRoadModel.instance:getChangeSetIdAsLightUp()
	local moList = MaterialController.instance:getTempItemsByChangeSetId(changeSetId)
	local matStrList = {}

	if moList then
		for _, mo in pairs(moList) do
			table.insert(matStrList, mo:toString())
		end
	end

	local data = CantonOperaRoadConfig.instance:getCorModelDataById(self._activityId, self._modelId)
	local filterMatStr = data.modelProgressItem

	self._normalMatStrList, self._progressMatStrList = MaterialMgr.filterMatStrList(matStrList, filterMatStr)

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.CORGetInfoRes, self._onUpdatePlaneUI, self)
	CantonOperaRoadController.instance:sendPM_CantonOperaRoadGetInfoReq(self._activityId)
	self:_onUpdatePlaneUI()
end

function CORJigsawResultView:onExit()
	CORJigsawResultView.super.onExit(self)
	self._rewardScrollList:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.CORGetInfoRes, self._onUpdatePlaneUI, self)
end

function CORJigsawResultView:_onSetUI()
	return
end

function CORJigsawResultView:_onUpdatePlaneUI()
	local curProgress = CantonOperaRoadModel.instance:getModelProgress(self._modelId)
	local maxProgress = CantonOperaRoadController.instance:getMaxProgressAsCORModel(self._modelId)

	self._txtRate.text = string.format("%d/%d", curProgress, maxProgress)

	local percentage = CantonOperaRoadController.instance:getProgressPercentageAsCORModel(self._modelId)

	self._sliderComp:SetValue(percentage)
	self._rewardScrollList:reloadData(self._normalMatStrList)

	local progressMat = self._progressMatStrList[1]
	local addProgress = 0

	if not string.nilorempty(progressMat) then
		local matType, matId, matNum = MaterialMgr.getMatParams(progressMat)

		addProgress = matNum
	end

	self._txtAddProgress.text = string.format("考核分数：+%d", addProgress)

	local jigsawId = CantonOperaRoadModel.instance:getCurJigsawIdAsLightUp()
	local jigsawdata = CantonOperaRoadConfig.instance:getCorJigsawDataById(self._activityId, jigsawId)

	self._txtResule.text = jigsawdata.txtTitle
end

function CORJigsawResultView:_updateRewardCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function CORJigsawResultView:_clearRewardCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return CORJigsawResultView
