-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualfuben/view/AnnualFubenBrokenStageView.lua

module("logic.extensions.annualfuben.view.AnnualFubenBrokenStageView", package.seeall)

local AnnualFubenBrokenStageView = class("AnnualFubenBrokenStageView", ViewComponent)

function AnnualFubenBrokenStageView:ctor()
	AnnualFubenBrokenStageView.super.ctor(self)
end

function AnnualFubenBrokenStageView:unbindEvents()
	AnnualFubenBrokenStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnChangle)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnTip)
end

function AnnualFubenBrokenStageView:bindEvents()
	AnnualFubenBrokenStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnChangle, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function AnnualFubenBrokenStageView:buildUI()
	AnnualFubenBrokenStageView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnChangle = self:getGo("btnChangle")
	self._btnTip = self:getGo("btnTip")
	self._prizeTableView = self:getGo("prizeTableView")
	self._prizeTableCell = self:getGo("prizeTableCell")
	self._prizeTableList = ScrollerList.create(self._prizeTableView, self._prizeTableCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

	self._prizeTableList:setCenterMode(true)

	self._levelTableView = self:getGo("levelTableView")
	self._levelTableCell = self:getGo("levelTableCell")
	self._levelTableList = ScrollerList.create(self._levelTableView, self._levelTableCell, GameUtil.handler(self._updateLevelCell, self), GameUtil.handler(self._clearLevelCell, self))
	self._firstFormation = self:getGo("teamSelf1")
	self._firstPetList = {}

	for i = 1, 9 do
		local go = goutil.findChild(self._firstFormation, "cell_" .. i)

		self._firstPetList[i] = {
			go = go,
			con = goutil.findChild(go, "con")
		}
	end

	self._enemyFormation = self:getGo("teamEnemy")
	self._enemyPetList = {}

	for i = 1, 9 do
		local go = goutil.findChild(self._enemyFormation, "cell_" .. i)

		self._enemyPetList[i] = {
			go = go,
			con = goutil.findChild(go, "con")
		}
	end

	self._txtChangle = self:getTxt("btnChangle/txt")
	self._btnReset = self:getGo("btnReset")
	self._btnPrize = self:getGo("btnPrize")
end

function AnnualFubenBrokenStageView:onExit()
	AnnualFubenBrokenStageView.super.onExit(self)
end

function AnnualFubenBrokenStageView:onEnter()
	AnnualFubenBrokenStageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AnnualFubenInfoRes, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())

	self:_refreshView()
end

function AnnualFubenBrokenStageView:_refreshView()
	local stageCfgs = AnnualFubenConfig.instance:getBrokenStageCfgs(self._activityId)

	self._stageId = AnnualFubenModel.instance:getBrokenStageId(self._activityId) + 1

	if self._stageId > #stageCfgs then
		self._stageId = #stageCfgs

		GameUtil.SetActive(self._btnChangle, false)
		FloatWordMgr.instance:show(lang("已通关全部关卡"))
		self:close()

		return
	else
		GameUtil.SetActive(self._btnChangle, true)
	end

	self._levelTableList:reloadData(stageCfgs)

	local curStageCfg = AnnualFubenConfig.instance:getBrokenStageCfg(self._activityId, self._stageId)
	local prizeArray = string.split(curStageCfg.prize, "#")

	self._prizeTableList:reloadData(prizeArray)

	for i = 1, 9 do
		MaterialMgr.resetAll(self._firstPetList[i].con)
		GameUtil.SetActive(self._firstPetList[i].go, false)
	end

	local lockRace = AnnualFubenModel.instance:getLockRaces(self._activityId)
	local lockNum = table.nums(lockRace)

	if lockNum > 0 then
		for raceId, posId in pairs(lockRace) do
			if self._firstPetList[posId] and raceId > 0 then
				GameUtil.setLocalScale(self._firstPetList[posId].con, 0.8, 0.8, 0.8)

				local proxy = MaterialMgr.setCell(MatType.Pet, raceId, self._firstPetList[posId].con)

				if proxy then
					proxy.binder:setAutoTips(false)
				end

				GameUtil.SetActive(self._firstPetList[posId].go, true)
			end
		end

		self._txtChangle.text = lang("二次挑战")
	else
		self._txtChangle.text = lang("挑战")
	end

	GameUtil.SetActive(self._btnReset, lockNum > 0)

	for i = 1, 9 do
		MaterialMgr.resetAll(self._enemyPetList[i].con)
		GameUtil.SetActive(self._enemyPetList[i].go, false)
	end

	local enemyCreepCfg = AnnualFubenConfig.instance:getCreepsCfg(curStageCfg.creepsMasterId)

	for i, v in ipairs(enemyCreepCfg) do
		if self._enemyPetList[v.posId] then
			GameUtil.setLocalScale(self._enemyPetList[v.posId].con, 0.8, 0.8, 0.8)

			local proxy = MaterialMgr.setCell(MatType.Pet, v.raceId, self._enemyPetList[v.posId].con)

			if proxy then
				proxy.binder:setAutoTips(false)
			end

			GameUtil.SetActive(self._enemyPetList[v.posId].go, true)
		end
	end
end

function AnnualFubenBrokenStageView:_updatePrizeCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
	MaterialMgr.setCellByCfg(data, go)
end

function AnnualFubenBrokenStageView:_clearPrizeCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function AnnualFubenBrokenStageView:_updateLevelCell(view, cell, data, tag)
	local go = cell.gameObject
	local bg_1 = goutil.findChild(go, "btnClick/btnBg_1")
	local bg_2 = goutil.findChild(go, "btnClick/btnBg_2")
	local changeText = goutil.findChildComponent(go, "btnClick/txt", ComponentType.UITextColorChange)
	local txtName = goutil.findChildTextComponent(go, "btnClick/txt")

	txtName.text = langPara("第%d关", data.stageId)

	GameUtil.SetActive(bg_1, self._stageId ~= data.stageId)
	GameUtil.SetActive(bg_2, self._stageId == data.stageId)

	if changeText then
		changeText:SetState(self._stageId == data.stageId and 1 or 0)
	end

	txtName.fontSize = self._stageId == data.stageId and 30 or 26
end

function AnnualFubenBrokenStageView:_clearLevelCell(cell)
	return
end

function AnnualFubenBrokenStageView:_onClickChallenge()
	AnnualFubenController.instance:openBrokenMissionView(self._activityId, self._stageId)
end

function AnnualFubenBrokenStageView:_onClickReset()
	TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否重置当前关卡"), function()
		AnnualFubenAgent.instance:sendPM_AnnualFubenStageResetReq(self._activityId, self._stageId)
	end)
end

function AnnualFubenBrokenStageView:_onClickPrize()
	UIStateManager.instance:push(ViewName.AnnualFubenStagePrizeView, self._activityId, AnnualFubenStagePrizeView.STAGE_TYPE_BROKEN)
end

function AnnualFubenBrokenStageView:_onClickTip()
	TipsFacade.instance:openRulesView("annual_fuben_chapter_two_rule")
end

return AnnualFubenBrokenStageView
