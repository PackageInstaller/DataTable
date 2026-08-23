local var_0_0 = g.core.const.ConstMgr.ThemeConst
local var_0_1 = g.core.const.ConstMgr.SpineConst
local BattleConst = require("app.view.battle.const.BattleConst")
local KnightSkillDescTip = require("app.view.module.tip.view.KnightSkillDescTip")
local KsMath = require("app.core.utils.KsMath")
local var_0_5 = g.core.config.activity_theme_display_info
local var_0_6 = "once_trans_phase_1"
local var_0_7 = "once_trans_phase_2"
local var_0_8 = "once_trans_phase_3"
local SummerThemeBossWarLayer = class("SummerThemeBossWarLayer", require("app.fairyGUI.summerThemeBoss.UI_SummerThemeBossWarLayer"), function()
	local var_1_0 = ({
		...
	})[1].themeValue or var_0_0.THEME_VALUE.GRYPH

	return fgui.GComponent:create({
		pkgPath = "ui/summerThemeBoss/summerThemeBoss",
		isFullScreen = true,
		pkgName = "summerThemeBoss",
		resName = var_0_0.THEME_ACTIVITY_BOSS_WAR_LAYER[var_1_0]
	}, ...)
end)

function SummerThemeBossWarLayer:ctor(arg_2_1)
	local var_2_0

	if arg_2_1 then
		var_2_0 = arg_2_1.themeValue or var_0_0.THEME_VALUE.GRYPH
	end

	self._activeThemeType = var_0_0.THEME_TYPE
	self._activeThemeValue = var_2_0
	self._tmpAwardArr = nil

	self:initSummerThemeBoss()
	g.core.model.User.themeData:getThemeData(self._activeThemeValue):getBossData():redDoBossNewPhase()
end

function SummerThemeBossWarLayer:onLoad()
	self:_initRegisterMSG()

	local var_3_0 = g.core.model.User.themeData:getThemeData(self._activeThemeValue):getBossData()

	var_3_0:refreshBossCrossDay()
	var_3_0:requestBossInfo()
	self:_refreshUIInfo()
	self:_playEnterTransition(var_3_0:getCurPhase())

	if self._activeThemeValue == var_0_0.THEME_VALUE.SUMMER then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.SWIM_MENUSLIDE)
	end
end

function SummerThemeBossWarLayer:onUnload()
	self._tmpAwardArr = nil
end

function SummerThemeBossWarLayer:receiveCompEvent(arg_5_1, arg_5_2)
	if arg_5_1 == "UI_REBEL_" then
		-- block empty
	end
end

function SummerThemeBossWarLayer:initSummerThemeBoss()
	self:_initSummerThemeBossData()
	self:_initSummerThemeBossUI()
end

function SummerThemeBossWarLayer:_initSummerThemeBossData()
	return
end

function SummerThemeBossWarLayer:_initSummerThemeBossUI()
	self.m_skill1:addClickListener(handler(self, self._onSkill1Click))
	self.m_skill2:addClickListener(handler(self, self._onSkill2Click))
	self.m_skill3:addClickListener(handler(self, self._onSkill3Click))
	self.m_rankBtn:addClickListener(handler(self, self._onOpenRankClick))
	self.m_formationBtn:addClickListener(handler(self, self._onFormationBtnClick))
	self.m_challengeBtn:addClickListener(handler(self, self._onStartChallengeClick))

	self._displayInfo = var_0_5.get(self._activeThemeValue)

	self.m_topBarComp:setResInfoById(self._displayInfo.boss_top_bar)
	self.m_topBarComp:setTitle(self._displayInfo.boss_name)
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))

	local var_8_0 = g.core.model.User.themeData:getThemeData(self._activeThemeValue):getBossData():getCurBoss()
	local var_8_1 = g.core.config.activity_theme_boss_info.match(function(arg_9_0)
		return arg_9_0.boss_id == var_8_0
	end)
	local var_8_2 = false

	for iter_8_0 = 1, 3 do
		if self["m_showIcon" .. iter_8_0] then
			if var_8_1[1]["recommend_" .. iter_8_0] ~= 0 then
				self["m_showIcon" .. iter_8_0]:updateIcon({
					type = g.core.common.Goods.TYPE_KNIGHT,
					baseId = var_8_1[1]["recommend_" .. iter_8_0]
				})
				self["m_showIcon" .. iter_8_0]:setVisible(true)

				var_8_2 = true
			else
				self["m_showIcon" .. iter_8_0]:setVisible(false)
			end
		end
	end

	if not var_8_2 then
		self.m_recommendController:setSelectedIndex(0)
	else
		self.m_recommendController:setSelectedIndex(1)
	end
end

function SummerThemeBossWarLayer:_initRegisterMSG()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DEMON_BOSS_GETINFO, self._refreshUIScoreInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DEMON_BOSS_BEGINCHALLENGE, self._onRcvDemonBossChallengeBegin, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
end

function SummerThemeBossWarLayer:_playEnterTransition(arg_11_1)
	if arg_11_1 == 0 then
		self.m_enter_0Transition:play()

		return
	elseif arg_11_1 == 1 then
		if KsMath.transitionNeedPlayOnce(var_0_6) then
			self.m_enter_1Transition:play(function()
				KsMath.transitionPlayOnceSet(var_0_6)
			end)

			return
		end
	elseif arg_11_1 == 2 then
		if KsMath.transitionNeedPlayOnce(var_0_7) then
			self.m_enter_2Transition:play(function()
				KsMath.transitionPlayOnceSet(var_0_7)
			end)

			return
		end
	elseif arg_11_1 == 3 and KsMath.transitionNeedPlayOnce(var_0_8) then
		self.m_enter_3Transition:play(function()
			KsMath.transitionPlayOnceSet(var_0_8)
		end)

		return
	end

	self.m_enterTransition:play()
end

function SummerThemeBossWarLayer:_refreshUIInfo()
	self:_refreshUIBaseInfo()
	self:_refreshUIScoreInfo()
end

function SummerThemeBossWarLayer:_refreshUIBaseInfo()
	local var_16_0 = g.core.model.User.themeData:getThemeData(self._activeThemeValue):getBossData()

	self.m_phaseLevelController:setSelectedIndex(var_16_0:getCurPhase())

	local var_16_1 = var_16_0:getBaseInfo() or var_16_0:getDefaultBaseInfo()
	local var_16_2 = "bg/theme/bg_boss_" .. var_16_1.back .. ".jpg"
	local var_16_3 = self:isHasBgComp()

	if var_16_3 then
		var_16_3:setURL(var_16_2)
	else
		self:addBg(var_16_2)
	end

	self.m_knightComp:updateKnight({
		resId = var_16_1.show
	})

	if self._activeThemeValue ~= var_0_0.THEME_VALUE.OVERLORD and self._activeThemeValue ~= var_0_0.THEME_VALUE.ANUBIS then
		self.m_knightComp:setAlphaRect(var_0_1.MASK_TYPE.HORIZON, cc.rect(-350, 0, 500, 0), 250)
	end

	self.m_descTxt:setText(var_16_1.phase_des)
	self.m_bossNameTxt:setText(var_16_1.phase_name)
	self.m_remainTimeTxt:setText((g.core.lang:get(107065, {
		time = var_16_0:getCurLeaveTime()
	})))

	self._skillTip1 = {
		isForceStyle = true,
		skillId = var_16_1.common_id
	}
	self._skillTip2 = {
		isForceStyle = true,
		skillId = var_16_1.active_skill_id
	}
	self._skillTip3 = {
		isPassive = true,
		isForceStyle = true,
		skillId = var_16_1.passive_skill
	}

	self.m_skill1:updateIcon(self._skillTip1)
	self.m_skill2:updateIcon(self._skillTip2)
	self.m_skill3:updateIcon(self._skillTip3)

	self._tmpAwardArr = var_16_0.mergeAwardArr

	self.m_awardList:setNumItems(#self._tmpAwardArr)
end

function SummerThemeBossWarLayer:_refreshUIScoreInfo()
	local var_17_0 = g.core.model.User.themeData:getThemeData(self._activeThemeValue):getBossData()
	local var_17_1 = var_17_0.dayRank and var_17_0.dayRank > 0 and g.core.lang:get(303501, {
		rank = var_17_0.dayRank
	}) or g.core.lang:get(405703)
	local var_17_2 = var_17_0.totalRank and var_17_0.totalRank > 0 and g.core.lang:get(303501, {
		rank = var_17_0.totalRank
	}) or g.core.lang:get(405703)

	self.m_rankTxt:setText(var_17_0.dayScore .. var_17_1)
	self.m_totalRankTxt:setText(var_17_0:getTotalScore() .. var_17_2)
	self.m_challengeCountTxt:setText(var_17_0.fightNum)
end

function SummerThemeBossWarLayer:_onStartChallengeClick()
	local var_18_0 = g.core.model.User.themeData:getThemeData(self._activeThemeValue):getBossData()

	if var_18_0:getCurPhase() <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(1008))

		return
	end

	if var_18_0.fightNum <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get((var_0_0.THEME_LANG_FIGHT_ID[self._activeThemeValue] == nil or nil) and 405716))

		return
	end

	var_18_0:requestBossFight()
end

function SummerThemeBossWarLayer:_onOpenRankClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.summerThemeBoss.oldBossView.SummerThemeBossRankPop").new({
		themeValue = self._activeThemeValue
	})))
end

function SummerThemeBossWarLayer:_onFormationBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION, {
		hideSuccuba = true
	})
end

function SummerThemeBossWarLayer:_onRenderAwardList(arg_21_1, arg_21_2)
	self._tmpAwardArr[arg_21_1 + 1].hideNum = true

	arg_21_2:updateIcon(self._tmpAwardArr[arg_21_1 + 1])
end

function SummerThemeBossWarLayer:_onSkill1Click()
	g.core.module.ModuleManager:pushPopup(KnightSkillDescTip.new(self._skillTip1), {
		touchDisappear = true
	})
end

function SummerThemeBossWarLayer:_onSkill2Click()
	g.core.module.ModuleManager:pushPopup(KnightSkillDescTip.new(self._skillTip2), {
		touchDisappear = true
	})
end

function SummerThemeBossWarLayer:_onSkill3Click()
	g.core.module.ModuleManager:pushPopup(KnightSkillDescTip.new(self._skillTip3), {
		touchDisappear = true
	})
end

function SummerThemeBossWarLayer:_onRcvDemonBossChallengeBegin(arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = g.core.model.User.themeData:getThemeData(arg_25_3.act_id):getBossData():getBaseInfo()

	if not var_25_0 then
		return
	end

	g.core.battle.BattleProxy:enterBattle({
		soundType = 4,
		type = BattleConst.TYPE_DEMON_BOSS,
		battle_id = arg_25_3.battle_id,
		skip = BattleConst.SKIP_TYPE.ACTIVE,
		battleType = BattleConst.BATTLE_TYPE.PVE,
		bgId = var_25_0.battle_stage,
		bossBaseInfo = var_25_0
	})
end

function SummerThemeBossWarLayer:_onCrossDayUpdate()
	local var_26_0 = g.core.model.User.themeData:getThemeData(self._activeThemeValue):getBossData()

	var_26_0:refreshBossCrossDay()

	local var_26_1 = var_26_0:getCurPhase()

	if var_26_1 <= 0 then
		g.core.module.ModuleManager:popModule()

		return
	end

	var_26_0:requestBossInfo()
	self:_refreshUIInfo()
	self:_playEnterTransition(var_26_1)
end

return SummerThemeBossWarLayer
