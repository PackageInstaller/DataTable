-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroPvPResultView.lua

module("logic.extensions.aoqihero.view.AoqiHeroPvPResultView", package.seeall)

local AoqiHeroPvPResultView = class("AoqiHeroPvPResultView", ViewComponent)
local SHOW_TYPE_MY = 1
local SHOW_TYPE_ENEMY = 2
local SHOW_TYPE_SCORE = 2

function AoqiHeroPvPResultView:ctor()
	AoqiHeroPvPResultView.super.ctor(self)
end

function AoqiHeroPvPResultView:unbindEvents()
	AoqiHeroPvPResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._imgBg)
end

function AoqiHeroPvPResultView:bindEvents()
	AoqiHeroPvPResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._imgBg, self._onClickBg, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function AoqiHeroPvPResultView:buildUI()
	AoqiHeroPvPResultView.super.buildUI(self)

	self._imgTitle = self:getGo("imgTitle")
	self._imgChangeTitle = self._imgTitle:GetComponent(ComponentType.UIImageSpriteChange)
	self._petTablecell = self:getGo("petTablecell")
	self._txtTitleNameLeft = self:getTxt("Left/TitleName")
	self._leftTableView = self:getGo("Left/leftTableView")
	self._leftTableList = ScrollerList.create(self._leftTableView, self._petTablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtTitleNameRight = self:getTxt("Right/TitleName")
	self._rightTableView = self:getGo("Right/rightTableView")
	self._rightTableList = ScrollerList.create(self._rightTableView, self._petTablecell, GameUtil.handler(self._updateEnemyCell, self), GameUtil.handler(self._clearEnemyCell, self))
	self._txtAttackTeamName = self:getTxt("TeamName")
	self._txtResultText = self:getTxt("ResultText3")

	local txtResultGo = self:getGo("ResultText3")

	self._resultTextUIGradient = txtResultGo:GetComponent(ComponentType.UIGradient)
	self._txtHp = self:getTxt("ResultText2")

	local txtTitleGo = self:getGo("hpInfo/txtTitle")

	self._hpTitileUIGradient = txtTitleGo:GetComponent(ComponentType.UIGradient)

	local txtHpGo = self:getGo("ResultText2")

	self._hpUIGradient = txtHpGo:GetComponent(ComponentType.UIGradient)
	self._imgBg = self:getGo("imgBg")
	self._scoreview = self:getGo("scoreview")
	self._imgChangeScoreTitle = goutil.findChildComponent(self._scoreview, "Title", ComponentType.UIImageSpriteChange)
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
	self._btnSure = self:getGo("scoreview/BtnSure")
	self._headIcon = self:getGo("scoreview/headIcon")
	self._animator = self.mainGO:GetComponent("Animator")
end

function AoqiHeroPvPResultView:onExit()
	AoqiHeroPvPResultView.super.onExit(self)
	HeadItemController.instance:resetHeadCell(self._headIcon)
end

function AoqiHeroPvPResultView:onEnter()
	AoqiHeroPvPResultView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())
	self._showType = SHOW_TYPE_MY

	self:_initView()
	self:_refreshTeamView()
	self:_animatorReBind()
	GameUtil.SetActive(self._scoreview, false)
end

function AoqiHeroPvPResultView:_initView()
	local pvpInfo = AoQiHeroModel.instance:getTempPvpInfo()

	self._txtRankValue.text = pvpInfo.oldRank
	self._txtRankChange.text = pvpInfo.newRank
	self._txtRankValue.text = pvpInfo.oldRank > 0 and langPara("排名：%d", pvpInfo.oldRank) or lang("排名：未上榜")
	self._txtRankChange.text = pvpInfo.newRank > 0 and langPara("%d", pvpInfo.newRank) or lang("未上榜")

	if pvpInfo.oldRank < pvpInfo.newRank then
		self._imgRankChange:SetState(0)
		GameUtil.setLocalRotation(self._imgRankChange.gameObject, 0, 0, 90)
	else
		self._imgRankChange:SetState(1)
		GameUtil.setLocalRotation(self._imgRankChange.gameObject, 0, 0, -90)
	end

	self._txtRankScoreOri.text = langPara("积分：%d", pvpInfo.oldScore)
	self._txtRankScoreCur.text = langPara("%d", pvpInfo.newScore)

	if pvpInfo.oldScore <= pvpInfo.newScore then
		self._imgRankScoreChange:SetState(1)
		GameUtil.setLocalRotation(self._imgRankScoreChange.gameObject, 0, 0, -90)
	else
		self._imgRankScoreChange:SetState(0)
		GameUtil.setLocalRotation(self._imgRankScoreChange.gameObject, 0, 0, 90)
	end

	GameUtil.SetActive(self._winTimesGo, pvpInfo.winStreak > 0)

	self._txtWinTimes.text = pvpInfo.winStreak

	if pvpInfo.result == 0 then
		self._imgChangeScoreTitle:SetState(1)
	elseif pvpInfo.result == 1 then
		self._imgChangeScoreTitle:SetState(0)
	else
		self._imgChangeScoreTitle:SetState(2)
	end

	local myBattleResult = pvpInfo.myBattleResult

	self._txtMyScores.text = string.format("%.2f%%", myBattleResult.leftHp / myBattleResult.maxHp * 100)

	local enemyBattleResult = pvpInfo.opBattleResult

	self._txtEnemyScores.text = enemyBattleResult and string.format("%.2f%%", enemyBattleResult.leftHp / enemyBattleResult.maxHp * 100) or lang("未布阵")
	self._txtName.text = langPara("%s-%s", RoleModel.instance:getAreaName(), RoleModel.instance:getUserName())

	local headInfo = RoleModel.instance:getHeadInfo()

	HeadItemController.instance:setHeadCellByInfo(self._headIcon, headInfo, false)
end

function AoqiHeroPvPResultView:_refreshTeamView()
	local pvpInfo = AoQiHeroModel.instance:getTempPvpInfo()
	local battleResult = pvpInfo.myBattleResult

	if self._showType == SHOW_TYPE_MY then
		local color = GameUtil.getColorByHexColor("#FFDFABFF", true)

		self._hpTitileUIGradient.TopColor = UnityEngine.Color32.New(color.r, color.g, color.b, color.a)
		self._hpUIGradient.TopColor = UnityEngine.Color32.New(color.r, color.g, color.b, color.a)

		self._imgChangeTitle:SetState(0)

		self._txtTitleNameLeft.text = lang("我方精灵")
		self._txtTitleNameRight.text = lang("敌方精灵")
		self._txtAttackTeamName.text = lang("【我方】")
		battleResult = pvpInfo.myBattleResult
	elseif self._showType == SHOW_TYPE_ENEMY then
		local color = GameUtil.getColorByHexColor("#8CCDFFFF", true)

		self._hpTitileUIGradient.TopColor = UnityEngine.Color32.New(color.r, color.g, color.b, color.a)
		self._hpUIGradient.TopColor = UnityEngine.Color32.New(color.r, color.g, color.b, color.a)

		self._imgChangeTitle:SetState(1)

		self._txtTitleNameLeft.text = lang("敌方精灵")
		self._txtTitleNameRight.text = lang("我方精灵")
		self._txtAttackTeamName.text = lang("【敌方】")
		battleResult = pvpInfo.opBattleResult
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

	self._txtHp.text = string.format("%.2f%%", battleResult.leftHp / battleResult.maxHp * 100)
end

function AoqiHeroPvPResultView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local petCon = goutil.findChild(go, "petCon")
	local deadGo = goutil.findChild(go, "dead")
	local petCfg = AoQiHeroConfig.instance:getPetCfg(self._activityId, data)

	MaterialMgr.setIcon(petCon, MatType.Pet, checknumber(petCfg.faceIds))
	GameUtil.SetActive(deadGo, false)
end

function AoqiHeroPvPResultView:_clearCell(cell)
	local go = cell.gameObject
	local petCon = goutil.findChild(go, "petCon")

	MaterialMgr.resetAll(petCon)
end

function AoqiHeroPvPResultView:_updateEnemyCell(view, cell, data, tag)
	local go = cell.gameObject
	local petCon = goutil.findChild(go, "petCon")
	local deadGo = goutil.findChild(go, "dead")
	local petCfg = AoQiHeroConfig.instance:getPetCfg(self._activityId, data)

	MaterialMgr.setIcon(petCon, MatType.Pet, checknumber(petCfg.faceIds))
	GameUtil.SetActive(deadGo, self._deadMap[data] == true)
end

function AoqiHeroPvPResultView:_clearEnemyCell(cell)
	local go = cell.gameObject
	local petCon = goutil.findChild(go, "petCon")

	MaterialMgr.resetAll(petCon)
end

function AoqiHeroPvPResultView:_onClickBg()
	local pvpInfo = AoQiHeroModel.instance:getTempPvpInfo()
	local hasEnemyReport = pvpInfo.opBattleResult ~= nil

	if self._showType == SHOW_TYPE_MY then
		if hasEnemyReport == true then
			self._showType = SHOW_TYPE_ENEMY

			self:_refreshTeamView()
		else
			self._showType = SHOW_TYPE_SCORE

			self:_refreshTeamView()
			GameUtil.SetActive(self._scoreview, true)
		end

		self:_animatorReBind()
	elseif self._showType == SHOW_TYPE_ENEMY then
		self._showType = SHOW_TYPE_SCORE

		self:_refreshTeamView()
		GameUtil.SetActive(self._scoreview, true)
	end
end

function AoqiHeroPvPResultView:_onClickSure()
	AoQiHeroModel.instance:clearPvpOpInfo()
	self:close()
end

function AoqiHeroPvPResultView:_animatorReBind()
	if self._animator then
		self._animator:Rebind()
	end
end

return AoqiHeroPvPResultView
