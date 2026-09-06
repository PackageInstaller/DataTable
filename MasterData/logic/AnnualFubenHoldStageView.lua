-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualfuben/view/AnnualFubenHoldStageView.lua

module("logic.extensions.annualfuben.view.AnnualFubenHoldStageView", package.seeall)

local AnnualFubenHoldStageView = class("AnnualFubenHoldStageView", ViewComponent)
local MAX_STAGE_COUNT = 5

function AnnualFubenHoldStageView:ctor()
	AnnualFubenHoldStageView.super.ctor(self)
end

function AnnualFubenHoldStageView:unbindEvents()
	AnnualFubenHoldStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnTip)
end

function AnnualFubenHoldStageView:bindEvents()
	AnnualFubenHoldStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function AnnualFubenHoldStageView:buildUI()
	AnnualFubenHoldStageView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._prizeTableView = self:getGo("prizeTableView")
	self._prizeTableCell = self:getGo("prizeTableCell")
	self._prizeTableList = ScrollerList.create(self._prizeTableView, self._prizeTableCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

	self._prizeTableList:setCenterMode(true)

	self._txtDesc = self:getTxt("txtDesc")
	self._txtName = self:getTxt("txtName")
	self._btnChallenge = self:getGo("btnChallenge")
	self._btnPrize = self:getGo("btnPrize")
	self._btnGainBuff = self:getGo("buffCol/btnGain")
	self._txtDescBuff = self:getTxt("buffCol/txtDesc")
	self._redBuff = self:getGo("buffCol/cell/red")
	self._stage = self:getGo("stage")
	self._stageCon = self:getGo("stage/stageCon")
	self._posRecord = self._stage:GetComponent(ComponentType.TestRecordPos)
end

function AnnualFubenHoldStageView:onExit()
	AnnualFubenHoldStageView.super.onExit(self)
	SignInBuffController.instance:unregSignInBuffPartSimple(self._activityId, self._btnGainBuff)
	GameUtil.clearCells(self._stage, self._clearStageCell, self, false)
end

function AnnualFubenHoldStageView:onEnter()
	AnnualFubenHoldStageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AnnualFubenInfoRes, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())

	SignInBuffController.instance:regSignInBuffPartSimple(self._activityId, self._btnGainBuff, function(param)
		self:_updateBuffUI(param)
	end)
	self:_refreshView()
end

function AnnualFubenHoldStageView:_refreshView()
	local stageCfgs = AnnualFubenConfig.instance:getHoldStageCfgs(self._activityId)

	self._curStageId = AnnualFubenModel.instance:getHoldStageId(self._activityId) + 1

	if self._curStageId > #stageCfgs then
		self._curStageId = #stageCfgs

		self:close()

		return
	end

	local curStageCfg = AnnualFubenConfig.instance:getHoldStageCfg(self._activityId, self._curStageId)
	local prizeArray = string.split(curStageCfg.prize, "#")

	self._prizeTableList:reloadData(prizeArray)

	self._txtName.text = langPara("第%d关", self._curStageId)

	local teamCfg = AnnualFubenConfig.instance:getTeamCfg(curStageCfg.creepsMasterId)

	self._txtDesc.text = teamCfg.ruleDesc

	local stageList = {}
	local layoutState = 2
	local minState = math.floor(MAX_STAGE_COUNT / 2)

	if minState < self._curStageId and self._curStageId < #stageCfgs - minState then
		for i = self._curStageId - 2, self._curStageId + 2 do
			if stageCfgs[i] then
				table.insert(stageList, stageCfgs[i])
			end
		end

		layoutState = minState + 1
	elseif minState >= self._curStageId then
		for i = 1, self._curStageId + 2 do
			if stageCfgs[i] then
				table.insert(stageList, stageCfgs[i])
			end
		end

		layoutState = self._curStageId
	elseif self._curStageId >= #stageCfgs - minState then
		for i = self._curStageId - 1, #stageCfgs do
			if stageCfgs[i] then
				table.insert(stageList, stageCfgs[i])
			end
		end

		layoutState = MAX_STAGE_COUNT - (#stageCfgs - self._curStageId)
	end

	GameUtil.updateCellsList(self._stage, self._stageCon, stageList, self._updateStageCell, self)
	self._posRecord:LoadPlan(layoutState - 1)
end

function AnnualFubenHoldStageView:_updateStageCell(cell, data, index)
	local go = cell.gameObject
	local txtStageName = goutil.findChildTextComponent(go, "txtName")
	local curStageGo = goutil.findChild(go, "curStage")
	local canvasGroup = go:GetComponent(ComponentType.CanvasGroup)

	canvasGroup.alpha = math.abs(self._curStageId - data.stageId) == 0 and 1 or math.abs(self._curStageId - data.stageId) == 1 and 0.7 or math.abs(self._curStageId - data.stageId) == 2 and 0.5 or 0.3

	GameUtil.SetActive(curStageGo, data.stageId == self._curStageId)

	txtStageName.text = langPara("第%d关", data.stageId)
end

function AnnualFubenHoldStageView:_clearStageCell(cell)
	return
end

function AnnualFubenHoldStageView:_updatePrizeCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
	MaterialMgr.setCellByCfg(data, go)
end

function AnnualFubenHoldStageView:_clearPrizeCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function AnnualFubenHoldStageView:_updateBuffUI(param)
	GameUtil.SetActive(self._redBuff, param.isCanGain)

	local buffCfg = param.buffCfg

	if buffCfg then
		self._txtDescBuff.text = buffCfg.des or "点击激活Buff"
	end
end

function AnnualFubenHoldStageView:_onClickChallenge()
	AnnualFubenController.instance:openHoldMissionView(self._activityId, self._curStageId)
end

function AnnualFubenHoldStageView:_onClickPrize()
	UIStateManager.instance:push(ViewName.AnnualFubenStagePrizeView, self._activityId, AnnualFubenStagePrizeView.STAGE_TYPE_HOLD)
end

function AnnualFubenHoldStageView:_onClickTip()
	TipsFacade.instance:openRulesView("annual_fuben_chapter_two_rule")
end

return AnnualFubenHoldStageView
