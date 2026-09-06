-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroNormalStageView.lua

module("logic.extensions.aoqihero.view.AoqiHeroNormalStageView", package.seeall)

local AoqiHeroNormalStageView = class("AoqiHeroNormalStageView", ViewComponent)

function AoqiHeroNormalStageView:ctor()
	AoqiHeroNormalStageView.super.ctor(self)

	self._nodePosList = {
		Vector2(0, 73),
		Vector2(31.3, -103.1),
		Vector2(-35.9, 167.9),
		(Vector2(-27.8, -60))
	}
	self._linePosList = {
		Vector3(155, -69, -128),
		Vector3(46.5, 133.98, -26.88),
		Vector3(132, -100.6, -136.1),
		(Vector3(88.3, 84.9, -55.9))
	}
	self._cycleCount = #self._nodePosList
end

function AoqiHeroNormalStageView:unbindEvents()
	AoqiHeroNormalStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function AoqiHeroNormalStageView:bindEvents()
	AoqiHeroNormalStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTips, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnBag, self._onClickBag, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
end

function AoqiHeroNormalStageView:buildUI()
	AoqiHeroNormalStageView.super.buildUI(self)

	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._tableList = ScrollerList.New()
	self._prizeTableView = self:getGo("info/prizeTableView")
	self._prizeTableCell = self:getGo("info/prizeTableView/prizeTableCell")
	self._prizeTableList = ScrollerList.create(self._prizeTableView, self._prizeTableCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

	self._prizeTableList:setCenterMode(true)

	self._petCon = self:getGo("info/imgBg/petCon/con")
	self._txtDesc = self:getTxt("info/txtDesc")
	self._txtName = self:getTxt("info/txtName")
	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnChallenge = self:getGo("info/btnChallenge")
	self._btnRank = self:getGo("btnRank")
	self._btnBag = self:getGo("btnBag")
end

function AoqiHeroNormalStageView:onExit()
	AoqiHeroNormalStageView.super.onExit(self)
	uGuiUtil.clearImage(self._petCon)
	self._prizeTableList:dispose()
	self._tableList:dispose()
end

function AoqiHeroNormalStageView:onEnter()
	AoqiHeroNormalStageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_NotifyAoQiHeroNormalChallengeEndRes, self._refreshView, self)
	self._tableList:init(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._tableList:regValueChanged(function(view)
		self:_onUpdatePosition(view)
	end)
	self:_initView()
end

function AoqiHeroNormalStageView:_initView()
	self._activityId = checknumber(self:getFirstParam())
	self._stageCfgs = AoQiHeroConfig.instance:getNormalStageCfgs(self._activityId)
	self._curStageId = AoQiHeroModel.instance:getPassStage(self._activityId)

	if checknumber(self._curStageId) > 0 then
		if #self._stageCfgs > self._curStageId then
			self._curStageId = self._curStageId + 1
		end
	else
		self._curStageId = 1
	end

	self._firstEnter = true

	self:_refreshView()
end

function AoqiHeroNormalStageView:_refreshView()
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

	self._firstEnter = false

	local curCfg = self._stageCfgs[self._curStageId]
	local prizeArray = string.split(curCfg.prize, "#")

	self._prizeTableList:reloadData(prizeArray)

	self._txtName.text = langPara("第%s关", GameUtil.getChineseNumber(self._curStageId))

	local teamCfg = AoQiHeroConfig.instance:getTeamCfg(self._activityId, curCfg.creepsMasterId)

	self._txtDesc.text = teamCfg.description

	local showRaceId = curCfg.raceId
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(showRaceId))

	if not modelCo then
		printError("t_model id not exist:" .. showRaceId)

		return
	end

	uGuiUtil.clearImage(self._petCon)
	uGuiUtil.setSpriteToImage(self._petCon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
end

function AoqiHeroNormalStageView:_onUpdatePosition(tableView)
	local count = tableView:GetVisibleCount()

	for i = 0, count - 1 do
		local cell = tableView:GetCellByIndex(i)

		if cell then
			cell.transform:SetSiblingIndex(cell.index)
		end
	end
end

function AoqiHeroNormalStageView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "node/txtName")
	local lockGo = goutil.findChild(go, "node/imgLocked")
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

	txtName.text = langPara("第%s关", GameUtil.getChineseNumber(data.index))

	GameUtil.rmClickHandler(btnClick)
	GameUtil.addClickHandler(btnClick, function()
		return
	end)

	local isReachLevel = AoQiHeroModel.instance:getPassStage(self._activityId) + 1 >= cfg.stageId
	local isLock = not isReachLevel

	GameUtil.SetActive(selectGo, cfg.stageId == self._curStageId)
	GameUtil.SetActive(lockGo, isLock)
	GameUtil.SetActive(txtName, not isLock)
	GameUtil.SetActive(passGo, cfg.stageId <= AoQiHeroModel.instance:getPassStage(self._activityId))
end

function AoqiHeroNormalStageView:_clearCell(cell)
	local go = cell.gameObject
	local btnClick = goutil.findChild(go, "node/btnClick")

	GameUtil.rmClickHandler(btnClick)
end

function AoqiHeroNormalStageView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
	MaterialMgr.setCellByCfg(data, go)
end

function AoqiHeroNormalStageView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function AoqiHeroNormalStageView:_onClickStage(stageId)
	if stageId > AoQiHeroModel.instance:getPassStage(self._activityId) + 1 then
		FloatWordMgr.instance:show(lang("请先通关上一关卡"))

		return
	end

	self._curStageId = stageId

	self:_refreshView()
end

function AoqiHeroNormalStageView:_onClickChallenge()
	if AoQiHeroModel.instance:getPassStage(self._activityId) + 1 < self._curStageId then
		FloatWordMgr.instance:show(lang("请先通关上一关卡"))

		return
	elseif AoQiHeroModel.instance:getPassStage(self._activityId) >= self._curStageId then
		FloatWordMgr.instance:show(lang("已通关"))

		return
	end

	UIStateManager.instance:push(ViewName.AoQiHeroFormationView, self._activityId, self._curStageId)
end

function AoqiHeroNormalStageView:_onClickTips()
	TipsFacade.instance:openRulesView("aoqi_hero_rule_normal")
end

function AoqiHeroNormalStageView:_onClickBag()
	UIStateManager.instance:push(ViewName.AoqiHeroStrengthenView, self._activityId)
end

function AoqiHeroNormalStageView:_onClickRank()
	UIStateManager.instance:push(ViewName.AoqiHeroRankView, self._activityId, 1)
end

return AoqiHeroNormalStageView
