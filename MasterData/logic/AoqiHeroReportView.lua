-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroReportView.lua

module("logic.extensions.aoqihero.view.AoqiHeroReportView", package.seeall)

local AoqiHeroReportView = class("AoqiHeroReportView", ViewComponent)
local SHOW_TYPE_MY = 1
local SHOW_TYPE_ENEMY = 2
local SHOW_TYPE_SCORE = 3

function AoqiHeroReportView:ctor()
	AoqiHeroReportView.super.ctor(self)
end

function AoqiHeroReportView:unbindEvents()
	AoqiHeroReportView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSelf)
	GameUtil.rmClickHandler(self._btnEnemy)
	GameUtil.rmClickHandler(self._btnScore)
end

function AoqiHeroReportView:bindEvents()
	AoqiHeroReportView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnSelf, self._onClickSelf, self)
	GameUtil.addClickHandler(self._btnEnemy, self._onClickEnemy, self)
	GameUtil.addClickHandler(self._btnScore, self._onClickScore, self)
end

function AoqiHeroReportView:buildUI()
	AoqiHeroReportView.super.buildUI(self)

	self._petTablecell = self:getGo("petTablecell")
	self._txtTitleNameLeft = self:getTxt("Left/TitleName")
	self._leftTableView = self:getGo("Left/leftTableView")
	self._leftTableList = ScrollerList.create(self._leftTableView, self._petTablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtTitleNameRight = self:getTxt("Right/TitleName")
	self._rightTableView = self:getGo("Right/rightTableView")
	self._rightTableList = ScrollerList.create(self._rightTableView, self._petTablecell, GameUtil.handler(self._updateEnemyCell, self), GameUtil.handler(self._clearEnemyCell, self))
	self._txtAttackTeamName = self:getTxt("TeamName")
	self._txtResultText = self:getTxt("ResultText2")

	local txtResultGo = self:getGo("ResultText2")

	self._resultTextUIGradient = txtResultGo:GetComponent(ComponentType.UIGradient)
	self._txtHp = self:getTxt("hpInfo/txtHp")

	local txtTitleGo = self:getGo("hpInfo/txtTitle")

	self._hpTitileUIGradient = txtTitleGo:GetComponent(ComponentType.UIGradient)

	local txtHpGo = self:getGo("hpInfo/txtHp")

	self._hpUIGradient = txtHpGo:GetComponent(ComponentType.UIGradient)
	self._scoreview = self:getGo("scoreview")
	self._txtEnemyScores = self:getTxt("scoreview/scoresresult/EnemyScores")
	self._txtMyScores = self:getTxt("scoreview/scoresresult/MyScores")
	self._winTimesGo = self:getGo("scoreview/wintimesresult")
	self._txtWinTimes = self:getTxt("scoreview/wintimesresult/WinTimes")
	self._txtRankValue = self:getTxt("scoreview/widRank/txtRankValue")
	self._txtRankChange = self:getTxt("scoreview/widRank/txtRankChange")
	self._imgRankChange = goutil.findChildComponent(self.mainGO, "scoreview/widRank/imgRankChange", ComponentType.UIImageSpriteChange)
	self._txtRankScoreOri = self:getTxt("scoreview/widRank/txtRankScoreOri")
	self._txtRankScoreCur = self:getTxt("scoreview/widRank/txtRankScoreCur")
	self._imgRankScoreChange = goutil.findChildComponent(self.mainGO, "scoreview/widRank/imgRankScoreChange", ComponentType.UIImageSpriteChange)
	self._txtName = self:getTxt("scoreview/widRank/txtName")
	self._btnSelf = self:getGo("tabList/btnSelf")
	self._uiChangeBtnSelf = self._btnSelf:GetComponent(ComponentType.UIChangeGroup)
	self._btnEnemy = self:getGo("tabList/btnEnemy")
	self._uiChangeBtnEnemy = self._btnEnemy:GetComponent(ComponentType.UIChangeGroup)
	self._btnScore = self:getGo("tabList/btnScore")
	self._uiChangeBtnScore = self._btnScore:GetComponent(ComponentType.UIChangeGroup)
	self._btnClose = self:getGo("BtnClose")
	self._ResultText3 = self:getTxt("ResultText3")

	local resultText3Go = self:getGo("ResultText3")

	self._resultText3UIGradient = resultText3Go:GetComponent(ComponentType.UIGradient)
	self._headIcon = self:getGo("scoreview/headIcon")
	self._txtAreaName = self:getTxt("scoreview/txtAreaName")
end

function AoqiHeroReportView:onExit()
	AoqiHeroReportView.super.onExit(self)
	HeadItemController.instance:resetHeadCell(self._headIcon)
end

function AoqiHeroReportView:onEnter()
	AoqiHeroReportView.super.onEnter(self)

	local param = self:getOpenParam()

	self._activityId = checknumber(param[1])
	self._recordData = param[2]

	self:_initView()
	self:_onClickSelf()
end

function AoqiHeroReportView:_initView()
	self._txtRankValue.text = self._recordData.oldRank > 0 and langPara("排名：%d", self._recordData.oldRank) or lang("排名：未上榜")
	self._txtRankChange.text = self._recordData.newRank > 0 and langPara("%d", self._recordData.newRank) or lang("未上榜")

	if self._recordData.oldRank < self._recordData.newRank then
		self._imgRankChange:SetState(0)
		GameUtil.setLocalRotation(self._imgRankChange.gameObject, 0, 0, 90)
	else
		self._imgRankChange:SetState(1)
		GameUtil.setLocalRotation(self._imgRankChange.gameObject, 0, 0, -90)
	end

	self._txtRankScoreOri.text = langPara("积分：%d", self._recordData.oldScore)
	self._txtRankScoreCur.text = langPara("%d", self._recordData.newScore)

	if self._recordData.oldScore <= self._recordData.newScore then
		self._imgRankScoreChange:SetState(1)
		GameUtil.setLocalRotation(self._imgRankScoreChange.gameObject, 0, 0, -90)
	else
		self._imgRankScoreChange:SetState(0)
		GameUtil.setLocalRotation(self._imgRankScoreChange.gameObject, 0, 0, 90)
	end

	self._txtWinTimes.text = self._recordData.winStreak

	GameUtil.SetActive(self._winTimesGo, self._recordData.winStreak > 0)

	if self._recordData.result == 0 then
		local color = GameUtil.getColorByHexColor("#8CCDFFFF", true)

		self._resultText3UIGradient.TopColor = UnityEngine.Color32.New(color.r, color.g, color.b, color.a)
		self._ResultText3.text = lang("平局")
	elseif self._recordData.result == 1 then
		local color = GameUtil.getColorByHexColor("#FFDFABFF", true)

		self._resultText3UIGradient.TopColor = UnityEngine.Color32.New(color.r, color.g, color.b, color.a)
		self._ResultText3.text = lang("胜利")
	else
		local color = GameUtil.getColorByHexColor("#9F9F9FFF", true)

		self._resultText3UIGradient.TopColor = UnityEngine.Color32.New(color.r, color.g, color.b, color.a)
		self._ResultText3.text = lang("失败")
	end

	self._txtMyScores.text = string.format("%.2f%%", self._recordData.myLeftHp * 100)
	self._txtEnemyScores.text = string.format("%.2f%%", self._recordData.enemyLeftHp * 100)

	local headInfo = RoleModel.instance:getHeadInfo()

	HeadItemController.instance:setHeadCellByInfo(self._headIcon, headInfo, false)

	self._txtAreaName.text = langPara("%s-%s", RoleModel.instance:getAreaName(), RoleModel.instance:getUserName())
end

function AoqiHeroReportView:_refreshView()
	local battleResult = self._recordData.myBattleResult

	self._uiChangeBtnSelf:SetState(0)
	self._uiChangeBtnEnemy:SetState(0)
	self._uiChangeBtnScore:SetState(0)

	if self._showType == SHOW_TYPE_MY then
		local color = GameUtil.getColorByHexColor("#FFDFABFF", true)

		self._hpTitileUIGradient.TopColor = UnityEngine.Color32.New(color.r, color.g, color.b, color.a)
		self._hpUIGradient.TopColor = UnityEngine.Color32.New(color.r, color.g, color.b, color.a)
		self._txtTitleNameLeft.text = lang("我方攻阵")
		self._txtTitleNameRight.text = lang("敌方守阵")
		self._txtAttackTeamName.text = lang("【我方】")
		battleResult = self._recordData.myBattleResult
		self._txtHp.text = string.format("%.2f%%", self._recordData.myLeftHp * 100)

		self._uiChangeBtnSelf:SetState(1)
	elseif self._showType == SHOW_TYPE_ENEMY then
		local color = GameUtil.getColorByHexColor("#8CCDFFFF", true)

		self._hpTitileUIGradient.TopColor = UnityEngine.Color32.New(color.r, color.g, color.b, color.a)
		self._hpUIGradient.TopColor = UnityEngine.Color32.New(color.r, color.g, color.b, color.a)
		self._txtTitleNameLeft.text = lang("敌方攻阵")
		self._txtTitleNameRight.text = lang("我方守阵")
		self._txtAttackTeamName.text = lang("【敌方】")
		battleResult = self._recordData.opBattleResult
		self._txtHp.text = string.format("%.2f%%", self._recordData.enemyLeftHp * 100)

		self._uiChangeBtnEnemy:SetState(1)
	elseif self._showType == SHOW_TYPE_SCORE then
		self._uiChangeBtnScore:SetState(1)
	end

	self._deadMap = {}

	if battleResult.killDefRaceIds then
		for i, v in ipairs(battleResult.killDefRaceIds) do
			self._deadMap[v] = true
		end
	end

	self._leftTableList:reloadData(battleResult.attackRaceIds)

	local list = {}

	for i, v in ipairs(battleResult.defItems) do
		table.insert(list, v.raceId)
	end

	self._rightTableList:reloadData(list)

	if battleResult.isWin == true then
		local color = GameUtil.getColorByHexColor("#FFDFABFF", true)

		self._resultTextUIGradient.TopColor = UnityEngine.Color32.New(color.r, color.g, color.b, color.a)
		self._txtResultText.text = lang("成功")
	else
		local color = GameUtil.getColorByHexColor("#9F9F9FFF", true)

		self._resultTextUIGradient.TopColor = UnityEngine.Color32.New(color.r, color.g, color.b, color.a)
		self._txtResultText.text = lang("失败")
	end

	GameUtil.SetActive(self._scoreview, self._showType == SHOW_TYPE_SCORE)
end

function AoqiHeroReportView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local petCon = goutil.findChild(go, "petCon")
	local dead = goutil.findChild(go, "dead")
	local petCfg = AoQiHeroConfig.instance:getPetCfg(self._activityId, data)

	MaterialMgr.setIcon(petCon, MatType.Pet, checknumber(petCfg.faceIds))
	GameUtil.SetActive(dead, false)
end

function AoqiHeroReportView:_clearCell(cell)
	local go = cell.gameObject
	local petCon = goutil.findChild(go, "petCon")

	MaterialMgr.resetAll(petCon)
end

function AoqiHeroReportView:_updateEnemyCell(view, cell, data, tag)
	local go = cell.gameObject
	local petCon = goutil.findChild(go, "petCon")
	local dead = goutil.findChild(go, "dead")
	local petCfg = AoQiHeroConfig.instance:getPetCfg(self._activityId, data)

	MaterialMgr.setIcon(petCon, MatType.Pet, checknumber(petCfg.faceIds))
	GameUtil.SetActive(dead, self._deadMap[data])
end

function AoqiHeroReportView:_clearEnemyCell(cell)
	local go = cell.gameObject
	local petCon = goutil.findChild(go, "petCon")

	MaterialMgr.resetAll(petCon)
end

function AoqiHeroReportView:_onClickSelf()
	if self._showType ~= SHOW_TYPE_MY then
		self._showType = SHOW_TYPE_MY

		self:_refreshView()
	end
end

function AoqiHeroReportView:_onClickEnemy()
	if self._showType ~= SHOW_TYPE_ENEMY then
		self._showType = SHOW_TYPE_ENEMY

		self:_refreshView()
	end
end

function AoqiHeroReportView:_onClickScore()
	if self._showType ~= SHOW_TYPE_SCORE then
		self._showType = SHOW_TYPE_SCORE

		self:_refreshView()
	end
end

function AoqiHeroReportView:_onClickClose()
	self:close()
end

return AoqiHeroReportView
