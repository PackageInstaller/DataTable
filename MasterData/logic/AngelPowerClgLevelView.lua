-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/angelpowerclg/view/AngelPowerClgLevelView.lua

module("logic.extensions.angelpowerclg.view.AngelPowerClgLevelView", package.seeall)

local AngelPowerClgLevelView = class("AngelPowerClgLevelView", ViewComponent)

function AngelPowerClgLevelView:ctor()
	AngelPowerClgLevelView.super.ctor(self)

	self._nodePosList = {
		Vector2(-30.2, 70),
		Vector2(31.3, -103.1),
		Vector2(-35.9, 167.9),
		(Vector2(-27.8, -60))
	}
	self._linePosList = {
		Vector3(181.86, -86.64, -124.36),
		Vector3(46.5, 133.98, -26.88),
		Vector3(132, -100.6, -136.1),
		(Vector3(88.3, 84.9, -55.9))
	}
	self._cycleCount = #self._nodePosList
end

function AngelPowerClgLevelView:unbindEvents()
	AngelPowerClgLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnTransfer)
end

function AngelPowerClgLevelView:bindEvents()
	AngelPowerClgLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnTransfer, self._onClickTransfer, self)
end

function AngelPowerClgLevelView:buildUI()
	AngelPowerClgLevelView.super.buildUI(self)

	self._btnChallenge = self:getGo("info/btnChallenge")
	self._txtDesc = self:getTxt("info/txtDesc")
	self._tablecell = self:getGo("tablecell")
	self._tableview = self:getGo("tableview")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnTransfer = self:getGo("btnTransfer")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._tableList = ScrollerList.New()
	self._teamEnemy = self:getGo("info/teamEnemy")
	self._enemyList = {}

	for i = 1, 9 do
		self._enemyList[i] = {
			go = goutil.findChild(self._teamEnemy, "cell_" .. i),
			con = goutil.findChild(self._teamEnemy, "cell_" .. i)
		}
	end

	self._prizeTableView = self:getGo("info/prizeTableView")
	self._prizeTableCell = self:getGo("info/prizeTableCell")
	self._prizeTableList = ScrollerList.create(self._prizeTableView, self._prizeTableCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

	self._prizeTableList:setCenterMode(true)

	self._txtTips = self:getTxt("txtTips")
end

function AngelPowerClgLevelView:destroyUI()
	AngelPowerClgLevelView.super.destroyUI(self)
	self._prizeTableList:dispose()
	self._tableList:dispose()
end

function AngelPowerClgLevelView:onExit()
	AngelPowerClgLevelView.super.onExit(self)
	self._prizeTableList:dispose()
	self._tableList:dispose()

	for i = 1, 9 do
		MaterialMgr.resetAll(self._enemyList[i].con)
		GameUtil.SetActive(self._enemyList[i].go, false)
	end
end

function AngelPowerClgLevelView:onEnter()
	AngelPowerClgLevelView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	self.addGEvent(self, GlobalNotify.PM_AngelPowerGetInfoRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_Notify_AngelPowerChallengeEndRes, self._PM_Notify_AngelPowerChallengeEndRes, self)
	self._tableList:init(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._tableList:regValueChanged(function(view)
		self:_onUpdatePosition(view)
	end)
	self:_initView()
	self:_refreshView()
	AngelPowerAgent.instance:sendPM_AngelPowerGetInfoReq(self._activityId)
end

function AngelPowerClgLevelView:_initView()
	self._actCfg = AngelPowerClgConfig.instance:getActivityCfg(self._activityId)
	self._stageCfgs = AngelPowerClgConfig.instance:getStageCfgs(self._activityId)
	self._curStageId = AngelPowerClgModel.instance:getPassStage(self._activityId)

	if checknumber(self._curStageId) > 0 then
		if #self._stageCfgs > self._curStageId then
			self._curStageId = self._curStageId + 1
		end
	else
		self._curStageId = 1
	end

	self._firstEnter = true
	self._txtTips.text = langPara("第%s个回合结束时，敌阵精灵统一变身为面具精灵", GameUtil.getChineseNumber(self._actCfg.transferRoundCount))

	GameUtil.SetActive(self._prizeTableView, not self._isAoqiGodProcessType)
end

function AngelPowerClgLevelView:_refreshView()
	local list = {}

	for i, v in ipairs(self._stageCfgs) do
		table.insert(list, {
			cfg = v,
			index = i
		})
	end

	self._tableList:reloadData(list)

	if self._firstEnter == true then
		self._tableList:MoveCellToCenter(self._curStageId - 1)
	end

	local curCfg = self._stageCfgs[self._curStageId]
	local transferPetCfg = AngelPowerClgConfig.instance:getTransferPetCfg(curCfg.transferPetPlanId)
	local winScoreList = string.split(curCfg.winScoreRequirements, "#")
	local descNeedList = {}

	for i, v in ipairs(winScoreList) do
		local infos = string.split(v, "=")
		local raceType = checknumber(infos[1])
		local maskTypeCfg = transferPetCfg[raceType]
		local info = langPara("%s(%s)≥%d", maskTypeCfg.maskName, ConstString.RaceIdToTxt[raceType], checknumber(infos[2]))

		table.insert(descNeedList, info)
	end

	local enemyCfg = AngelPowerClgConfig.instance:getTeamCfg(curCfg.creepsMasterId)

	self._txtDesc.text = enemyCfg.ruleDesc

	local creepCfg = AngelPowerClgConfig.instance:getCreepsCfg(curCfg.creepsMasterId)

	for i = 1, 9 do
		MaterialMgr.resetAll(self._enemyList[i].con)
		GameUtil.SetActive(self._enemyList[i].go, false)
	end

	for i, v in ipairs(creepCfg) do
		if self._enemyList[v.posId] then
			GameUtil.setLocalScale(self._enemyList[v.posId].con, 0.8, 0.8, 0.8)

			local proxy = MaterialMgr.setCell(MatType.Pet, v.raceId, self._enemyList[v.posId].con)

			if proxy then
				proxy.binder:setAutoTips(false)
			end

			GameUtil.SetActive(self._enemyList[v.posId].go, true)
		end
	end

	local prizeList = string.split(curCfg.prize, "#")

	self._prizeTableList:reloadData(prizeList)

	self._firstEnter = false
end

function AngelPowerClgLevelView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "node/txtName")
	local lockGo = goutil.findChild(go, "node/imgLocked")
	local bg1 = goutil.findChild(go, "node/bg1")
	local bg2 = goutil.findChild(go, "node/bg2")
	local btnClick = goutil.findChild(go, "node/btnClick")
	local selectGo = goutil.findChild(go, "node/imgSelect")
	local passGo = goutil.findChild(go, "node/passGo")
	local node = goutil.findChild(go, "node")
	local line = goutil.findChild(go, "node/line")
	local cfg = data.cfg
	local index = data.index % self._cycleCount

	if index == 0 then
		index = self._cycleCount
	end

	GameUtil.setAnchoredPos(node, self._nodePosList[index].x, self._nodePosList[index].y)
	GameUtil.setAnchoredPos(line, self._linePosList[index].x, self._linePosList[index].y)
	GameUtil.setLocalRotation(line, 0, 0, self._linePosList[index].z)
	GameUtil.SetActive(line, data.index ~= #self._stageCfgs)

	txtName.text = cfg.stageId

	GameUtil.rmClickHandler(btnClick)
	GameUtil.addClickHandler(btnClick, function()
		self:_onClickStage(cfg.stageId)
	end)

	local isReachLevel = AngelPowerClgModel.instance:getPassStage(self._activityId) + 1 >= cfg.stageId
	local isLock = not isReachLevel

	GameUtil.SetActive(selectGo, cfg.stageId == self._curStageId)
	GameUtil.SetActive(lockGo, isLock)
	GameUtil.SetActive(bg1, not isLock and cfg.stageId == self._curStageId)
	GameUtil.SetActive(bg2, isLock or cfg.stageId ~= self._curStageId)
	GameUtil.SetActive(passGo, cfg.stageId <= AngelPowerClgModel.instance:getPassStage(self._activityId))
end

function AngelPowerClgLevelView:_clearCell(cell)
	local go = cell.gameObject
	local btnClick = goutil.findChild(go, "node/btnClick")

	GameUtil.rmClickHandler(btnClick)
end

function AngelPowerClgLevelView:_updatePrizeCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
	MaterialMgr.setCellByCfg(data, go)
end

function AngelPowerClgLevelView:_clearPrizeCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function AngelPowerClgLevelView:_onClickStage(stageId)
	if stageId > AngelPowerClgModel.instance:getPassStage(self._activityId) + 1 then
		FloatWordMgr.instance:show(lang("请先通关上一关卡"))

		return
	end

	self._curStageId = stageId

	self:_refreshView()
end

function AngelPowerClgLevelView:_onClickChallenge()
	if checknumber(self._curStageId) <= 0 then
		return
	end

	if AngelPowerClgModel.instance:getPassStage(self._activityId) >= self._curStageId then
		FloatWordMgr.instance:show(lang("已通关"))

		return
	end

	if AngelPowerClgModel.instance:getPassStage(self._activityId) + 1 < self._curStageId then
		FloatWordMgr.instance:show(lang("请先通关上一关卡"))

		return
	end

	if self._isAoqiGodProcessType then
		local allPass = AngelPowerClgController.instance:allStagePass(self._activityId)

		if allPass then
			AoqiGodController.instance:doHandleChallengeFinishReady(GameEnum.ActivityType.AngelPowerClg, self._activityId)
		end
	end

	local fmtMo = AngelPowerClgModel.instance:getFmtMo()

	fmtMo:initParams(self._activityId, self._curStageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function AngelPowerClgLevelView:_onClickTip()
	TipsFacade.instance:openRulesView("angel_power_clg_rule")
end

function AngelPowerClgLevelView:_onClickTransfer()
	UIStateManager.instance:push(ViewName.AngelPowerClgPetView, self._activityId, self._curStageId)
end

function AngelPowerClgLevelView:_onUpdatePosition(tableView)
	local count = tableView:GetVisibleCount()

	for i = 0, count - 1 do
		local cell = tableView:GetCellByIndex(i)

		if cell then
			cell.transform:SetSiblingIndex(cell.index)
		end
	end
end

function AngelPowerClgLevelView:_PM_Notify_AngelPowerChallengeEndRes()
	self._curStageId = AngelPowerClgModel.instance:getPassStage(self._activityId)

	if checknumber(self._curStageId) > 0 then
		if #self._stageCfgs > self._curStageId then
			self._curStageId = self._curStageId + 1
		end
	else
		self._curStageId = 1
	end

	self:_refreshView()
end

return AngelPowerClgLevelView
