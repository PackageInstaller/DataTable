local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_1 = g.core.const.ConstMgr.SpineConst
local var_0_2 = g.core.config.knight_info
local var_0_3 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_4 = g.core.config.massive_monster_team_info
local var_0_5 = g.core.config.guild_alliance_trial_monster_group_info
local var_0_6 = g.core.model.User.allianceTrialData
local KnightStruct = require("app.view.module.knight.model.KnightStruct")
local AllianceTrialChallengePop = class("AllianceTrialChallengePop", require("app.fairyGUI.allianceTrial.UI_AllianceTrialChallengePop"), function()
	return fgui.GComponent:create({
		resName = "AllianceTrialChallengePop",
		pkgName = "allianceTrial",
		isFullScreen = true,
		pkgPath = "ui/allianceTrial/allianceTrial"
	}, ...)
end)

function AllianceTrialChallengePop:ctor(arg_2_1)
	self._monsterInfo = arg_2_1.monsterInfo
	self._monsterGroupList = {}
	self._enemyList = {}
	self._tabIndex = 1
	self._isChallengeSending = false

	self:initData()
	self:initView()
	self.m_enterTransition:play()
end

function AllianceTrialChallengePop:initData()
	for iter_3_0, iter_3_1 in var_0_5.ipairs() do
		if iter_3_1.monster_group == self._monsterInfo.monster_group then
			table.insert(self._monsterGroupList, iter_3_1)
		end
	end

	table.sort(self._monsterGroupList, function(arg_4_0, arg_4_1)
		return arg_4_0.difficulty < arg_4_1.difficulty
	end)
end

function AllianceTrialChallengePop:initView()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
	self.m_enemyList:setVirtual()
	self.m_enemyList:setItemRenderer(handler(self, self._onRenderEnemyList))
	self.m_battleBtn:addClickListener(handler(self, self._onClickBattleBtn))
	self.m_formationBtn:addClickListener(handler(self, self._onClickFormationBtn))
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onClickTabController))
	self.m_starComp:initStar({
		index = 3,
		num = 0,
		gap = -5,
		style = 2
	})
	self.m_progressComp:setMax(self._monsterInfo.monster_group_hp)
end

function AllianceTrialChallengePop:_onClickTabController()
	local var_6_0 = self.m_tabController:getSelectedIndex() + 1

	if var_6_0 == self._tabIndex then
		return
	end

	self._tabIndex = var_6_0

	self:updateView()
end

function AllianceTrialChallengePop:_onClickFormationBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION)
end

function AllianceTrialChallengePop:_onRenderAwardList(arg_8_1, arg_8_2)
	arg_8_2:updateIcon(self._awardList[arg_8_1 + 1])
end

function AllianceTrialChallengePop:_onRenderEnemyList(arg_9_1, arg_9_2)
	local var_9_0 = g.core.config.knight_info.get(self._enemyList[arg_9_1 + 1])
	local var_9_1 = KnightStruct.new(var_9_0.advance_id)

	var_9_1:addCfgInfo(var_9_0)
	arg_9_2:updateIcon({
		isFogNightPop = true,
		type = g.core.common.Goods.TYPE_KNIGHT,
		struct = var_9_1,
		star = var_9_0.star
	})
end

function AllianceTrialChallengePop:_onClickBattleBtn()
	if self._isChallengeSending then
		return
	end

	if var_0_6:getLastChallengeCount() <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(430401))

		return
	end

	if self._tabIndex ~= #self._monsterGroupList and var_0_4.get(self._monsterGroupList[#self._monsterGroupList].monster).fight < g.core.model.User:getFightValue() then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = g.core.lang:get(430409),
			onConfirm = handler(self, self._startChallenge)
		}), {
			touchDisappear = true
		})

		return
	end

	self:_startChallenge()
end

function AllianceTrialChallengePop:_startChallenge()
	g.core.network.GameNetProxy:send_C2S_AllianceTrial_ChallengeBegin({
		monster_id = self._monsterInfo.id,
		difficulty = self._monsterGroupList[self._tabIndex].difficulty,
		is_sweep = var_0_6:isPassMonster(self._monsterInfo.id, self._monsterGroupList[self._tabIndex].difficulty) == true
	})

	self._isChallengeSending = true
end

function AllianceTrialChallengePop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_CHALLENGEBEGIN, handler(self, self.onChallengeBegin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_CHALLENGEFINISH_SWEEP, handler(self, self.onChallengeSweep), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_UPDATEMONSTER, self.updateMonsterHp, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	self.m_tabController:setSelectedIndex(var_0_6:getSuggestDiffByMonsterId(self._monsterInfo.id) - 1)
	self:updateView()
end

function AllianceTrialChallengePop:_onCrossDayUpdate()
	self.m_lastChallengeCount:setText(var_0_6:getLastChallengeCount())
end

function AllianceTrialChallengePop:updateView()
	self.m_btnTextController:setSelectedIndex(var_0_6:isPassMonster(self._monsterInfo.id, self._monsterGroupList[self._tabIndex].difficulty) and 1 or 0)
	self.m_lastChallengeCount:setText(var_0_6:getLastChallengeCount())

	local var_14_0 = var_0_4.get(self._monsterGroupList[self._tabIndex].monster)

	self._enemyList = {}

	for iter_14_0 = 1, var_0_3.LINEUP_MAX do
		table.insert(self._enemyList, var_14_0["knight_id_" .. iter_14_0])
	end

	self.m_enemyList:setNumItems(#self._enemyList)
	self.m_fightValueText:setText(var_14_0.fight)

	self._awardList = g.core.common.Drops:getGoodsArray(self._monsterGroupList[self._tabIndex].win_drop)

	self.m_awardList:setNumItems(#self._awardList)

	local var_14_1 = var_0_2.get(self._monsterInfo.knight_id)

	self.m_monsterName:setText(var_14_1.name)
	self.m_starComp:setStarNum(var_14_1.star)
	self:updateHp()
	self.m_knightPicComp:updateKnight({
		resId = var_14_1.res_id
	})
	self.m_knightPicComp:setAlphaRect(var_0_1.MASK_TYPE.HORIZON, cc.rect(-250, 0, 500, 0), 250)
end

function AllianceTrialChallengePop:updateHp()
	self.m_progressComp:setValue(var_0_6:isLevelFinish() and self._monsterInfo.monster_group_hp or var_0_6:getMonsterHp(self._monsterInfo.id))
end

function AllianceTrialChallengePop:onChallengeSweep(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	if arg_16_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_16_4.awards)
	end

	self:updateView()

	self._isChallengeSending = false
end

function AllianceTrialChallengePop:onChallengeBegin(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	self._isChallengeSending = false

	if arg_17_4.battle_id and arg_17_4.battle_id > 0 then
		g.core.battle.BattleProxy:enterBattle({
			canSkip = true,
			soundType = 5,
			battle_id = arg_17_4.battle_id,
			type = BattleConst.TYPE_ALLIANCE_TRIAL,
			skip = BattleConst.SKIP_TYPE.ACTIVE,
			battleType = BattleConst.BATTLE_TYPE.PVE
		})
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function AllianceTrialChallengePop:updateMonsterHp()
	if not var_0_6:canChallengeMonster(self._monsterInfo.id) then
		g.core.module.ModuleManager:tip(g.core.lang:get(309010))
		self:_onClickClose()
	else
		self:updateHp()
	end
end

function AllianceTrialChallengePop:_onClickClose()
	if self._isClose then
		return
	end

	self._isClose = true

	self.m_backTransition:play(function()
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end)
end

return AllianceTrialChallengePop
