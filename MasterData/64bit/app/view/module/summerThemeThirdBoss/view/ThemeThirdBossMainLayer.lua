local var_0_0 = g.core.const.ConstMgr.GuideConst
local var_0_1 = g.core.const.ConstMgr.LineUpConst
local var_0_2 = g.core.config.knight_info
local var_0_3 = g.core.model.User.themeData
local var_0_4 = g.core.event.EventManager
local var_0_5 = g.core.event.enum
local var_0_6 = g.core.const.ConstMgr.ThemeConst
local BattleConst = require("app.view.battle.const.BattleConst")
local KnightSkillDescTip = require("app.view.module.tip.view.KnightSkillDescTip")
local var_0_9 = g.core.config.activity_theme_display_info
local var_0_10 = g.core.config.talent_skill_info
local var_0_11 = g.core.const.ConstMgr.ThemeThirdBossConst
local ThemeThirdBossMainLayer = class("ThemeThirdBossMainLayer", require("app.fairyGUI.summerThemeThirdBoss.UI_ThemeThirdBossMainLayer"), function()
	return fgui.GComponent:create({
		pkgName = "summerThemeThirdBoss",
		isFullScreen = true,
		pkgPath = "ui/summerThemeThirdBoss/summerThemeThirdBoss",
		resName = "ThemeThirdBossMainLayer"
	}, ...)
end)

function ThemeThirdBossMainLayer:ctor(arg_2_1)
	self._activeThemeType = var_0_6.THEME_TYPE
	self._activeThemeValue = arg_2_1.themeValue
	self._curScoreRewardList = {}
	self._isGetAward = false
	self._lastShowId = 0
	self._lastShowScore = 0
	self._isInBattle = false
	self._awardEffect = nil
	self._isPlayed = false
	self._bossData = var_0_3:getThemeData(self._activeThemeValue):getBossData()

	self:initView()
	self._bossData:redDoBossNewPhase()
	self.m_enterTransition:play(handler(self, self.onTranEnd))
end

function ThemeThirdBossMainLayer:onTranEnd()
	if not g.core.model.User.guideData:getServerDataById(var_0_0.SAVE_SERVER_DATA_IDS.THEME_THIRD_BOSS_GUIDE) then
		g.core.model.User.guideData:setSaveServerData(var_0_0.SAVE_SERVER_DATA_IDS.THEME_THIRD_BOSS_GUIDE)

		local var_3_0 = self.m_tipTitleBg
		local var_3_1 = self.m_talentBtn

		self:newScheduleOnce(function()
			g.core.service.ServiceManager:getServiceByName("TipGuideService"):reset()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_TIP_GUIDE_TICK, false, {
				key = "THEME_THIRD_BOSS_GUIDE",
				objects = {
					var_3_0,
					var_3_1
				}
			})
		end, 0)
	end
end

function ThemeThirdBossMainLayer:initView()
	self.m_skill1:addClickListener(handler(self, self._onSkill1Click))
	self.m_skill2:addClickListener(handler(self, self._onSkill2Click))
	self.m_skill3:addClickListener(handler(self, self._onSkill3Click))
	self.m_skill4:addClickListener(handler(self, self._onSkill4Click))
	self.m_skill5:addClickListener(handler(self, self._onSkill5Click))
	self.m_rankBtn:addClickListener(handler(self, self._onOpenRankClick))
	self.m_talentBtn:addClickListener(handler(self, self._onClickTalentBtn))
	self.m_talentBtn:setVisible(g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.THEME_THIRD_BOSS_TALENT))
	self.m_formationBtn:addClickListener(handler(self, self._onFormationBtnClick))
	self.m_challengeBtn:addClickListener(handler(self, self._onStartChallengeClick))
	self.m_tipTitleBg:addClickListener(handler(self, self._onClickTip))

	self._displayInfo = var_0_9.get(self._activeThemeValue)

	self.m_topBarComp:setResInfoById(self._displayInfo.boss_top_bar)
	self.m_topBarComp:setTitle(self._displayInfo.boss_name)
	self.m_scoreComp:initData(self._bossData)
	self.m_scoreComp:setVisible(false)
end

function ThemeThirdBossMainLayer:_onClickTip()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.HelpPop").new({
		id = 353
	}), {
		touchDisappear = true
	})
end

function ThemeThirdBossMainLayer:onLoad()
	var_0_4:addEventListener(var_0_5.EVENT_NET_S2C_NEW_DEMON_BOSS_GETINFO, handler(self, self._onGetInfo), self)
	var_0_4:addEventListener(var_0_5.EVENT_NET_S2C_NEW_DEMON_BOSS_BEGINCHALLENGE, handler(self, self._onRcvDemonBossChallengeBegin), self)
	var_0_4:addEventListener(var_0_5.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
	var_0_4:addEventListener(var_0_5.EVENT_NET_S2C_DEMON_AUTO_BOSS_GETAWARD, handler(self, self._onRcvGetAward), self)
	var_0_4:addEventListener(var_0_5.EVENT_NET_S2C_FORMATION_SAVE, self._onSaveSucc, self)

	if self._bossData:getCurPhase() <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(1005))
		self:newScheduleOnce(handler(self, self._timeEnd))

		return
	end

	self._bossData:refreshBossCrossDay()
	self._bossData:requestBossInfo()
	self:_refreshUIBaseInfo()
end

function ThemeThirdBossMainLayer:playEnterTran()
	self.m_enterTransition:play(handler(self, self.onTranEnd))
end

function ThemeThirdBossMainLayer:_onSaveSucc(arg_9_1, arg_9_2, arg_9_3)
	if var_0_3:checkBossChallengeTime(self._activeThemeValue, self._bossData:getCurBoss()) then
		g.core.network.GameNetProxy:send_C2S_NewDemonBoss_BeginChallenge({
			act_id = self._activeThemeValue,
			boss_id = self._bossData:getCurBoss(),
			phase = self._bossData:getCurPhase()
		})
	end
end

function ThemeThirdBossMainLayer:_onRcvDemonBossChallengeBegin(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = self._bossData:getBaseInfo()

	self._isInBattle = true

	g.core.battle.BattleProxy:enterBattle({
		soundType = 4,
		type = BattleConst.TYPE_DEMON_BOSS,
		battle_id = arg_10_4.battle_id,
		skip = (self._bossData:isFirstPassDone() or nil) and (BattleConst.SKIP_TYPE.ACTIVE or BattleConst.SKIP_TYPE.CANT_SKIP),
		battleType = BattleConst.BATTLE_TYPE.PVE,
		bgId = var_10_0.battle_stage,
		bossBaseInfo = var_10_0,
		extraParams = {
			isSkip = self._bossData:isFirstPassDone()
		}
	})
end

function ThemeThirdBossMainLayer:_onStartChallengeClick()
	if self._bossData:getCurPhase() <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(1008))

		return
	end

	local var_11_0

	if self._bossData:getFightNum() <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(405716))

		do return end

		var_11_0 = {
			tp = var_0_1.MulTeamType.THEME_THIRD_BOSS
		}
	end

	var_11_0.formations = self._bossData:getOutBaseFormationArr()

	g.core.network.GameNetProxy:send_C2S_Formation_Save(var_11_0)
end

function ThemeThirdBossMainLayer:_onOpenRankClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.summerThemeThirdBoss.view.ThemeThirdBossRankPop").new({
		themeValue = self._activeThemeValue
	})))
end

function ThemeThirdBossMainLayer:_onClickTalentBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.THEME_THIRD_TALENT_LAYER, {
		themeValue = self._activeThemeValue
	})
end

function ThemeThirdBossMainLayer:_onFormationBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION, {
		hideSuccuba = true
	})
end

function ThemeThirdBossMainLayer:_onRcvGetAward(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	g.core.module.ModuleManager:awardSummary(arg_15_4.awards or {}, false, nil, nil, handler(self, self._refreshUIScoreInfo))
end

function ThemeThirdBossMainLayer:_onCrossDayUpdate()
	self._bossData:refreshBossCrossDay()

	if self._bossData:getCurPhase() <= 0 then
		self:_timeEnd()

		return
	end

	self._bossData:requestBossInfo()
end

function ThemeThirdBossMainLayer:_timeEnd()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function ThemeThirdBossMainLayer:_onGetInfo()
	self:_refreshUIBaseInfo()
	self:_refreshUIScoreInfo()
	self:_refreshUIRankInfo()
end

function ThemeThirdBossMainLayer:_refreshUIBaseInfo()
	local var_19_0 = self._bossData:getCurPhase()

	self.m_phaseText:setText("0" .. var_19_0)
	self.m_skillTitleText:setText(g.core.lang:get(405951, {
		num = var_19_0
	}))

	local var_19_1 = self._bossData:getBaseInfo()

	self._skillTip1 = {
		isForceStyle = true,
		skillId = var_19_1.common_id
	}
	self._skillTip2 = {
		isForceStyle = true,
		skillId = var_19_1.active_skill_id
	}
	self._skillTip3 = {
		isPassive = true,
		isForceStyle = true,
		skillId = var_19_1.passive_skill
	}

	self.m_skill1:updateIcon(self._skillTip1)
	self.m_skill2:updateIcon(self._skillTip2)
	self.m_skill3:updateIcon(self._skillTip3)

	if var_19_1.special_skill > 0 then
		self._skillTip4 = {
			isPassive = true,
			isForceStyle = true,
			skillId = var_19_1.special_skill
		}

		self.m_skill4:setVisible(true)
	else
		self.m_skill4:setVisible(false)
	end

	if var_19_1.energy_skill_id > 0 then
		self._skillTip5 = {
			isForceStyle = true,
			skillId = var_19_1.energy_skill_id
		}

		self.m_skill5:updateIcon(self._skillTip5)
		self.m_skill5:setVisible(true)
	else
		self.m_skill5:setVisible(false)
	end

	local var_19_2 = "bg/theme/bg_boss_" .. var_19_1.back .. ".jpg"
	local var_19_3 = self:isHasBgComp()

	if var_19_3 then
		var_19_3:setURL(var_19_2)
	else
		self:addBg(var_19_2)
	end

	self.m_knightComp:updateKnight({
		resId = var_19_1.show
	})
	self.m_showGroupController:setSelectedIndex((var_0_2.fetch(var_19_1.show) or {}).group - 1)
	self.m_descTxt:setText(var_19_1.phase_des)
	self.m_bossNameTxt:setText(var_19_1.phase_name)
	self.m_remainTimeTxt:setText((g.core.lang:get(107065, {
		time = self._bossData:getCurLeaveTime()
	})))

	local var_19_4 = var_0_10.fetch(self._bossData:getBaseInfo().phase_talent)

	if var_19_4 then
		self.m_talentDesc:setText(var_19_4.description)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_challengeBtn,
		customData = {
			themeValue = self._activeThemeValue
		}
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_talentBtn,
		customData = {
			themeValue = self._activeThemeValue
		}
	})
end

function ThemeThirdBossMainLayer:_refreshUIScoreInfo()
	if self._bossData:getBaseInfo().daily_times >= var_0_11.DAILY_TIMES then
		self.m_challengeCountTxt:setText(g.core.lang:get(405959, {
			num = self._bossData:getRewardNum() .. "/" .. self._bossData:getBaseInfo().daily_award_times
		}))
	else
		self.m_challengeCountTxt:setText(g.core.lang:get(1007, {
			num = self._bossData:getFightNum()
		}))
	end

	self.m_scoreComp:setVisible(true)
	self.m_scoreComp:updateCompView()
	self.m_rewardTypeController:setSelectedIndex(self._bossData:getScoreInfoList()[1].reward_type)

	local var_20_0 = self._bossData:getTotalScore()

	if var_20_0 > self._lastShowScore then
		self.m_totalScoreText:runChangeAni(self._lastShowScore, var_20_0, false)
	else
		self.m_totalScoreText:setText(var_20_0)
	end

	self._lastShowScore = var_20_0
end

function ThemeThirdBossMainLayer:_refreshUIRankInfo()
	local var_21_0 = self._bossData:getTotalRank() or 0

	if var_21_0 == 0 then
		self.m_rankText:setText("")
		self.m_noneText:setText(g.core.lang:get(405805))
	else
		self.m_rankText:setText(var_21_0)
		self.m_noneText:setText(g.core.lang:get(405952))
	end
end

function ThemeThirdBossMainLayer:_onSkill1Click()
	g.core.module.ModuleManager:pushPopup(KnightSkillDescTip.new(self._skillTip1), {
		touchDisappear = true
	})
end

function ThemeThirdBossMainLayer:_onSkill2Click()
	g.core.module.ModuleManager:pushPopup(KnightSkillDescTip.new(self._skillTip2), {
		touchDisappear = true
	})
end

function ThemeThirdBossMainLayer:_onSkill3Click()
	g.core.module.ModuleManager:pushPopup(KnightSkillDescTip.new(self._skillTip3), {
		touchDisappear = true
	})
end

function ThemeThirdBossMainLayer:_onSkill4Click()
	g.core.module.ModuleManager:pushPopup(KnightSkillDescTip.new(self._skillTip4), {
		touchDisappear = true
	})
end

function ThemeThirdBossMainLayer:_onSkill5Click()
	g.core.module.ModuleManager:pushPopup(KnightSkillDescTip.new(self._skillTip5), {
		touchDisappear = true
	})
end

return ThemeThirdBossMainLayer
