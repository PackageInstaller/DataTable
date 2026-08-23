local var_0_0 = g.core.config.knight_info
local var_0_1 = g.core.model.User.themeData
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.event.enum
local var_0_4 = g.core.const.ConstMgr.ThemeConst
local BattleConst = require("app.view.battle.const.BattleConst")
local KnightSkillDescTip = require("app.view.module.tip.view.KnightSkillDescTip")
local var_0_7 = g.core.config.activity_theme_display_info
local var_0_8 = g.core.config.activity_theme_boss_integral_info
local ThemeBossWarLayer = class("ThemeBossWarLayer", require("app.fairyGUI.summerThemeBoss.UI_ThemeBossWarLayer"), function()
	local var_1_1 = {
		pkgName = "summerThemeBoss",
		pkgPath = "ui/summerThemeBoss/summerThemeBoss",
		isFullScreen = true
	}

	var_1_1.resName = var_0_4.THEME_ACTIVITY_BOSS_WAR_LAYER[({
		...
	})[1].themeValue or var_0_4.THEME_VALUE.GRYPH] or "ThemeBossWarLayer"

	return fgui.GComponent:create(var_1_1, ...)
end)
local var_0_10 = 2
local var_0_11 = 3
local var_0_12 = 3

function ThemeBossWarLayer:ctor(arg_2_1)
	local var_2_0

	if arg_2_1 then
		var_2_0 = arg_2_1.themeValue or var_0_4.THEME_VALUE.GRYPH
	end

	self._activeThemeType = var_0_4.THEME_TYPE
	self._activeThemeValue = var_2_0
	self._curScoreRewardList = {}
	self._isGetAward = false
	self._lastShowId = 0
	self._lastShowScore = 0
	self._isInBattle = false
	self._awardEffect = nil

	self:_initSummerThemeBossUI()
	self.m_enterTransition:play()
	self.m_enterTransition:setHook("award", handler(self, self.playScoreAwardEffect))
	g.core.model.User.themeData:getThemeData(self._activeThemeValue):getBossData():redDoBossNewPhase()
end

function ThemeBossWarLayer:_initSummerThemeBossUI()
	self.m_skill1:addClickListener(handler(self, self._onSkill1Click))
	self.m_skill2:addClickListener(handler(self, self._onSkill2Click))
	self.m_skill3:addClickListener(handler(self, self._onSkill3Click))
	self.m_rankBtn:addClickListener(handler(self, self._onOpenRankClick))
	self.m_formationBtn:addClickListener(handler(self, self._onFormationBtnClick))
	self.m_challengeBtn:addClickListener(handler(self, self._onStartChallengeClick))
	self.m_tipTitleBg:addClickListener(handler(self, self._onClickTipsTitle))
	self.m_previewBtn:addClickListener(handler(self, self._onClickPreviewBtn))
	self.m_getAllAwardLoader:addClickListener(handler(self, self._onClickGetAllAwardBtn))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))

	self._displayInfo = var_0_7.get(self._activeThemeValue)

	self.m_topBarComp:setResInfoById(self._displayInfo.boss_top_bar)
	self.m_topBarComp:setTitle(self._displayInfo.boss_name)

	local var_3_0 = self.m_tipsComp:getChild("tipList")

	var_3_0:resizeToFit(var_3_0:getNumItems())
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
	self.m_progressList:setVirtual()
	self.m_progressList:setItemRenderer(handler(self, self._onRenderScoreProgressList))
	self.m_progressList:getScrollPane():cancelDragging()
	self.m_progressList:getScrollPane():setMouseWheelEnabled(false)
end

function ThemeBossWarLayer:onLoad()
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_DEMON_AUTO_BOSS_GETINFO, handler(self, self._onGetInfo), self)
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_DEMON_AUTO_BOSS_BEGINCHALLENGE, handler(self, self._onRcvDemonBossChallengeBegin), self)
	var_0_2:addEventListener(var_0_3.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_DEMON_AUTO_BOSS_GETAWARD, handler(self, self._onRcvGetAward), self)

	local var_4_0 = var_0_1:getThemeData(self._activeThemeValue):getBossData()

	if var_4_0:getCurPhase() <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(1005))
		self:newScheduleOnce(handler(self, self._timeEnd))

		return
	end

	var_4_0:refreshBossCrossDay()
	var_4_0:requestAutoBossGetInfo()
	self:_refreshUIBaseInfo()

	if self._activeThemeValue == var_0_4.THEME_VALUE.SUMMER then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.SWIM_MENUSLIDE)
	end
end

function ThemeBossWarLayer:_refreshUIBaseInfo()
	local var_5_0 = var_0_1:getThemeData(self._activeThemeValue):getBossData()

	self.m_phaseText:setText("0" .. var_5_0:getCurPhase())
	self.m_skillTitleText:setText(g.core.lang:get(405951, {
		num = var_5_0:getCurPhase()
	}))

	local var_5_1 = var_5_0:getBaseInfo() or var_5_0:getDefaultBaseInfo()
	local var_5_2 = "bg/theme/bg_boss_" .. var_5_1.back .. ".jpg"
	local var_5_3 = self:isHasBgComp()

	if var_5_3 then
		var_5_3:setURL(var_5_2)
	else
		self:addBg(var_5_2)
	end

	;({
		resId = var_5_1.show
	}).isShowBg = false

	self.m_knightComp:updateKnight({
		resId = var_5_1.show
	})

	local var_5_7 = var_0_4.THEME_ACTIVITY_BOSS_LEFT_RIGHT_BG[(var_0_0.fetch(var_5_1.show) or {}).group or 1] or var_0_4.THEME_ACTIVITY_BOSS_LEFT_RIGHT_BG[1]

	self.m_leftBg:setURL("ui://summerThemeBoss/" .. var_5_7.LEFT)
	self.m_rightBg:setURL("ui://summerThemeBoss/" .. var_5_7.RIGHT)
	self.m_descTxt:setText(var_5_1.phase_des)
	self.m_bossNameTxt:setText(var_5_1.phase_name)
	self.m_remainTimeTxt:setText((g.core.lang:get(107065, {
		time = var_5_0:getCurLeaveTime()
	})))

	self._skillTip1 = {
		isForceStyle = true,
		skillId = var_5_1.common_id
	}
	self._skillTip2 = {
		isForceStyle = true,
		skillId = var_5_1.active_skill_id
	}
	self._skillTip3 = {
		isPassive = true,
		isForceStyle = true,
		skillId = var_5_1.passive_skill
	}

	self.m_skill1:updateIcon(self._skillTip1)
	self.m_skill2:updateIcon(self._skillTip2)
	self.m_skill3:updateIcon(self._skillTip3)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_challengeBtn,
		customData = {
			themeValue = self._activeThemeValue
		}
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_previewBtn,
		customData = {
			themeValue = self._activeThemeValue
		}
	})
end

function ThemeBossWarLayer:_refreshUIRankInfo()
	local var_6_0 = var_0_1:getThemeData(self._activeThemeValue):getBossData().totalRank or 0

	if var_6_0 == 0 then
		self.m_rankText:setText("")
		self.m_noneText:setText(g.core.lang:get(405805))
	else
		self.m_rankText:setText(var_6_0)
		self.m_noneText:setText(g.core.lang:get(405952))
	end
end

function ThemeBossWarLayer:_onGetInfo()
	self:_refreshUIBaseInfo()
	self:_refreshUIScoreInfo()
	self:_refreshUIRankInfo()
end

function ThemeBossWarLayer:_refreshUIScoreInfo()
	if not self or not self.m_challengeCountTxt then
		return
	end

	local var_8_0 = var_0_1:getThemeData(self._activeThemeValue):getBossData()

	self.m_getAllAwardLoader:setVisible(var_8_0:redCheckBossHasAwardCanGet())
	self.m_challengeCountTxt:setText(g.core.lang:get(1007, {
		num = var_8_0.fightNum
	}))
	self.m_progressList:setNumItems(#var_8_0:getScoreInfoList() + var_0_10 + var_0_11)

	local var_8_1 = var_8_0:getScoreListCurIndex()
	local var_8_2 = var_8_0:getTotalScore()
	local var_8_3, var_8_4, var_8_5 = var_8_0:getCurProgressValue()

	if var_8_2 > self._lastShowScore then
		self.m_curScoreText:runChangeAni(self._lastShowScore, var_8_2, false)
	else
		self.m_curScoreText:setText(var_8_2)
	end

	self._lastShowScore = var_8_2

	local var_8_6, var_8_7 = var_8_0:getShowAwardInfo()

	self.m_needScoreText:setText(var_8_6.integral_demand)

	local var_8_8 = var_8_0:getScoreInfoByIndex(var_8_7 + 1)
	local var_8_9 = 0
	local var_8_10 = 0

	if var_8_8 then
		var_8_9 = var_8_6.integral_demand - var_8_8.integral_demand
		var_8_10 = var_8_2 - var_8_8.integral_demand
	else
		var_8_9 = var_8_6.integral_demand
		var_8_10 = var_8_2
	end

	self.m_progressComp:setMax(var_8_9)

	if var_8_10 < var_8_9 then
		self.m_progressComp:tweenValue(var_8_10, 0.5)
	else
		self.m_progressComp:setValue(var_8_9)
	end

	if self._lastShowId ~= var_8_6.id then
		self._lastShowId = var_8_6.id
		self._curScoreRewardList = {}

		while var_0_8.hasKey("reward_type_" .. 1) do
			if var_8_6["reward_type_" .. 1] > 0 then
				table.insert(self._curScoreRewardList, {
					type = var_8_6["reward_type_" .. 1],
					value = var_8_6["reward_value_" .. 1],
					size = var_8_6["reward_size_" .. 1]
				})
			end
		end

		local var_8_12 = var_8_6.reward_token_type

		if var_8_6.reward_token_type > 0 then
			table.insert(self._curScoreRewardList, {
				type = var_8_12,
				value = var_8_6.reward_token_value,
				size = var_8_6.reward_token_size
			})
		end

		if self._isInBattle then
			self._isInBattle = false

			self.m_progressList:scrollToView(math.max(var_8_7, 0))
			self.m_progressList:scrollToView(var_8_7 - 1, true)
			self.m_refreshTransition:play(handler(self, self.playScoreAwardEffect))
		else
			self.m_progressList:getScrollPane():scrollBottom()
			self.m_progressList:scrollToView(var_8_7 - 1, true)
		end
	else
		self:playScoreAddEffect()
		self.m_progressList:scrollToView(var_8_7 - 1)
	end

	self._isGetAward = var_8_0:isGetAwardById(var_8_6.id)

	self.m_awardList:setNumItems(#self._curScoreRewardList)
end

function ThemeBossWarLayer:_onStartChallengeClick()
	local var_9_0 = var_0_1:getThemeData(self._activeThemeValue):getBossData()

	if var_9_0:getCurPhase() <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(1008))

		return
	end

	if var_9_0.fightNum <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get((var_0_4.THEME_LANG_FIGHT_ID[self._activeThemeValue] == nil or nil) and 405716))

		return
	end

	var_9_0:requestAutoBossFight()
end

function ThemeBossWarLayer:_onOpenRankClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.summerThemeBoss.newBossView.ThemeBossRankPop").new({
		themeValue = self._activeThemeValue
	})))
end

function ThemeBossWarLayer:_onFormationBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION, {
		hideSuccuba = true
	})
end

function ThemeBossWarLayer:_onRenderAwardList(arg_12_1, arg_12_2)
	arg_12_2:updateIconCell(self._curScoreRewardList[arg_12_1 + 1], self._isGetAward)
end

function ThemeBossWarLayer:_onRenderScoreProgressList(arg_13_1, arg_13_2)
	arg_13_2:updateScoreCell(var_0_1:getThemeData(self._activeThemeValue):getBossData():getScoreInfoByIndex(arg_13_1 + 1 - var_0_11), arg_13_1 + 1 - var_0_11, self._activeThemeValue)
end

function ThemeBossWarLayer:_onTouchBegin(arg_14_1)
	if self.m_hasTipsCompController:getSelectedIndex() == 1 then
		if not self.m_tipsComp:containPoint((arg_14_1:getInput():getTouch():getLocation())) then
			self.m_hasTipsCompController:setSelectedIndex(0)
		end
	end
end

function ThemeBossWarLayer:_onClickTipsTitle()
	if self.m_hasTipsCompController:getSelectedIndex() == 0 then
		self.m_hasTipsCompController:setSelectedIndex(1)
	else
		self.m_hasTipsCompController:setSelectedIndex(0)
	end
end

function ThemeBossWarLayer:_onClickGetAllAwardBtn()
	local var_16_0 = var_0_1:getThemeData(self._activeThemeValue):getBossData()

	if var_16_0:getCurPhase() <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(1008))

		return
	end

	var_16_0:requestAutoBossGetAllAward()
end

function ThemeBossWarLayer:_onClickPreviewBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.summerThemeBoss.newBossView.ThemeBossScorePreviewPop").new({
		themeValue = self._activeThemeValue
	})))
end

function ThemeBossWarLayer:_onSkill1Click()
	g.core.module.ModuleManager:pushPopup(KnightSkillDescTip.new(self._skillTip1), {
		touchDisappear = true
	})
end

function ThemeBossWarLayer:_onSkill2Click()
	g.core.module.ModuleManager:pushPopup(KnightSkillDescTip.new(self._skillTip2), {
		touchDisappear = true
	})
end

function ThemeBossWarLayer:_onSkill3Click()
	g.core.module.ModuleManager:pushPopup(KnightSkillDescTip.new(self._skillTip3), {
		touchDisappear = true
	})
end

function ThemeBossWarLayer:_onRcvDemonBossChallengeBegin(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	local var_21_0 = var_0_1:getThemeData(arg_21_4.act_id):getBossData():getBaseInfo()

	if not var_21_0 then
		return
	end

	self._isInBattle = true

	g.core.battle.BattleProxy:enterBattle({
		soundType = 4,
		type = BattleConst.TYPE_DEMON_BOSS,
		battle_id = arg_21_4.battle_id,
		skip = BattleConst.SKIP_TYPE.ACTIVE,
		battleType = BattleConst.BATTLE_TYPE.PVE,
		bgId = var_21_0.battle_stage,
		bossBaseInfo = var_21_0
	})
end

function ThemeBossWarLayer:_onRcvGetAward(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	g.core.module.ModuleManager:awardSummary(arg_22_4.awards or {}, false, nil, nil, handler(self, self._refreshUIScoreInfo))
end

function ThemeBossWarLayer:_onCrossDayUpdate()
	local var_23_0 = var_0_1:getThemeData(self._activeThemeValue):getBossData()

	var_23_0:refreshBossCrossDay()

	if var_23_0:getCurPhase() <= 0 then
		self:_timeEnd()

		return
	end

	var_23_0:requestAutoBossGetInfo()
end

function ThemeBossWarLayer:_timeEnd()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function ThemeBossWarLayer:playScoreAddEffect()
	self:_playScoreEffect("play_jindu")
end

function ThemeBossWarLayer:_playScoreEffect(arg_26_1)
	if not self._awardEffect then
		self._awardEffect = self.m_effAward:addEffectSpine({
			name = "eff_ui_themeboss_awardrefresh",
			isLoop = false,
			anim = arg_26_1
		})
	else
		self._awardEffect:setAnimation(0, arg_26_1, false)
	end
end

function ThemeBossWarLayer:playScoreAwardEffect()
	if #self._curScoreRewardList > 0 then
		self:_playScoreEffect("play_" .. math.min(#self._curScoreRewardList, var_0_12))
	end
end

return ThemeBossWarLayer
