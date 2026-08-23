local DebugCommon = require("app.view.module.debug.common.DebugCommon")
local DebugGameSetListComp = class("DebugGameSetListComp", require("app.fairyGUI.debug.UI_DebugGameSetListComp"))

function DebugGameSetListComp:ctor()
	self:_init()
end

function DebugGameSetListComp:_init()
	self.m_closeGuideBtn:addClickListener(handler(self, self._onCloseGuideBtnClick))
	self.m_skipBattleBtn:addClickListener(handler(self, self._onSkipBattleBtnClick))
	self.m_fpsBtn:addClickListener(handler(self, self._onFpsBtnClick))
	self.m_upgradeBtn:addClickListener(handler(self, self._onUpgradeBtnClick))
	self.m_furnitureDebugBtn:addClickListener(handler(self, self._onFurnitureDebugTouchClick))
	self.m_closeOpenScreenBtn:addClickListener(handler(self, self._onCloseOpenScreenClick))
	self.m_gvePathCheckBtn:addClickListener(handler(self, self._onGvePathCheckClick))
	self.m_closeSilentBtn:addClickListener(handler(self, self._onClosedSilentDownClick))
	self.m_fightValueBtn:addClickListener(handler(self, self._onFightValueBtnClick))
	self.m_fightValueBtn:setSelected(DebugCommon.getDebugGlobalValueByKey("fight_value_dump") == true)
	self.m_newGuideBtn:addClickListener(handler(self, self._onNewGuideBtnClick))
	self.m_newGuideBtn:setSelected(DebugCommon.getDebugGlobalValueByKey("new_guide") == true)
	self.m_gveBattleFastBtn:setSelected(DebugCommon.getDebugGlobalValueByKey("gve_skip_battle"))
	self.m_gveBattleFastBtn:addClickListener(handler(self, self._onGveBattleFast))
	self.m_fogBattleFastBtn:setSelected(DebugCommon.getDebugGlobalValueByKey("fog_skip_battle"))
	self.m_fogBattleFastBtn:addClickListener(handler(self, self._onFogBattleFast))
	self.m_stormMiddleBtn:setSelected(DebugCommon.getDebugGlobalValueByKey("storm_middle_battle"))
	self.m_stormMiddleBtn:addClickListener(handler(self, self._onStormMiddleBattleFast))
	self.m_themeDungeonBtn:setSelected(DebugCommon.getDebugGlobalValueByKey("theme_dungeon_skip_battle"))
	self.m_themeDungeonBtn:addClickListener(handler(self, self._onThemeDungeonBattleFast))
	self.m_logActInfoCheckBtn:addClickListener(handler(self, self._onLogActInfoCheckBtn))
	self.m_every5SyncTimeCheckBtn:addClickListener(handler(self, self._on5SyncTimeCheckBtn))
	self.m_actTypeInput:addEventListener(fgui.UIEventType.Submit, handler(self, self._onActTypeInputEnd))
	self.m_guessSetTimeBtn:setSelected(DebugCommon.getDebugGlobalValueByKey("guess_set_time_99999"))
	self.m_guessSetTimeBtn:addClickListener(handler(self, self._onGuessSetTimeCheckBtn))
	self.m_guessDefaultBtn:setSelected(DebugCommon.getDebugGlobalValueByKey("guess_default_not_des"))
	self.m_guessDefaultBtn:addClickListener(handler(self, self._onGuessDefaultCheckBtn))
	self.m_recruitJumpBtn:setSelected(DebugCommon.getDebugGlobalValueByKey("recruit_jump_effect"))
	self.m_recruitJumpBtn:addClickListener(handler(self, self._onClickRecruitJumpBtn))
	self.m_skipAwardBtn:setSelected(DebugCommon.getDebugGlobalValueByKey("skip_award_summary"))
	self.m_skipAwardBtn:addClickListener(handler(self, self._onClickSkipAwardBtn))
	self.m_wushTowerBattleFastBtn:setSelected(DebugCommon.getDebugGlobalValueByKey("wushTower_skip_battle"))
	self.m_wushTowerBattleFastBtn:addClickListener(handler(self, self._onWushTowerBattleFast))
	self.m_weddingHideUI:setSelected(DebugCommon.getDebugGlobalValueByKey("wedding_action_hide_ui"))
	self.m_weddingHideUI:addClickListener(handler(self, self._onWeddingHideUI))
	self.m_simpleHomeUI:setSelected(DebugCommon.getDebugGlobalValueByKey("debug_home_simple_ui"))
	self.m_simpleHomeUI:addClickListener(handler(self, self._onSimpleHomeUI))
	self.m_redPointCache:setSelected(g.core.model.User.redPointRefreshCache:getCacheState())
	self.m_redPointCache:addClickListener(handler(self, self._onRedPointCacheClick))
	self.m_spireAutoAttack:setSelected(DebugCommon.getDebugGlobalValueByKey("spire_tower_auto"))
	self.m_spireAutoAttack:addClickListener(handler(self, self._onSpireAutoAttackClick))
	self.m_battleHideLogBtn:addClickListener(handler(self, self._onBattleHideLog))

	if (g.core.common.Setting:getValue(g.core.common.Setting.FUNC_FPS) or 0) == 1 then
		self.m_frameBtn:setSelected(true)
	else
		self.m_frameBtn:setSelected(false)
	end

	self.m_frameBtn:addClickListener(handler(self, self._onClickFrameBtn))
	self.m_IgnorePlotReviewBtn:setSelected((g.core.common.Storage:load("ignorePlotReview.json", false) or {}).open)
	self.m_IgnorePlotReviewBtn:addClickListener(handler(self, self._onIgnorePlotReviewBtnClick))

	local var_2_0 = g.core.common.Storage:load("silent_close_state.json", false)

	if var_2_0 then
		self.m_closeSilentBtn:setSelected(var_2_0.open)
	else
		self.m_closeSilentBtn:setSelected(false)
	end

	local var_2_1 = g.core.common.Storage:load("guide_open_state.json", false)

	if var_2_1 then
		self.m_closeGuideBtn:setSelected(var_2_1.open)
	else
		self.m_closeGuideBtn:setSelected(false)
	end

	local var_2_2 = g.core.common.Storage:load("battle_skip_open.json", false)

	if var_2_2 then
		self.m_skipBattleBtn:setSelected(var_2_2.open)
	else
		self.m_skipBattleBtn:setSelected(false)
	end

	local var_2_3 = g.core.common.Storage:load("activity_log_switch.json", false) or {}

	self.m_logActInfoCheckBtn:setSelected(checkbool(var_2_3.openActLog))
	self.m_actTypeInput:setText(checknumber(var_2_3.logActType))
	self.m_every5SyncTimeCheckBtn:setSelected(checkbool((g.core.common.Storage:load("sync_server_time.json", false) or {}).every5s))

	local var_2_4 = g.core.common.Storage:load("furniture_spine_touch_debug.json", false)

	if var_2_4 then
		self.m_furnitureDebugBtn:setSelected(var_2_4.show)
	else
		self.m_furnitureDebugBtn:setSelected(false)
	end

	local var_2_5 = g.core.common.Storage:load("closeOpenScreen.json", false)

	if var_2_5 then
		self.m_closeOpenScreenBtn:setSelected(var_2_5.isClose)
	else
		self.m_closeOpenScreenBtn:setSelected(false)
	end

	self.m_upgradeBtn:setSelected(not DebugCommon.isDebugUpgradeClose())
	self.m_gvePathCheckBtn:setSelected(g.core.model.User.gveDataMgr:getGveData():isCheckSkipPath())
	self.m_ruleBtn:addClickListener(handler(self, self._onClickRuleBtn))
	self.m_explorationMapBtn:setSelected(DebugCommon.getDebugGlobalValueByKey("exploration_map_btn"))
	self.m_explorationMapBtn:addClickListener(handler(self, self._onExplorationMapCheckBtn))
	self.m_redCliffMapBtn:setSelected(DebugCommon.getDebugGlobalValueByKey("redCliff_map_btn"))
	self.m_redCliffMapBtn:addClickListener(handler(self, self._onRedCliffMapCheckBtn))
	self.m_rerunEasyBtn:setSelected(DebugCommon.getDebugGlobalValueByKey("rerun_easy"))
	self.m_rerunEasyBtn:addClickListener(handler(self, self._onRerunEasyCheckBtn))
	self.m_onlineRuleBtn:setSelected(DebugCommon.getDebugGlobalValueByKey("online_rule"))
	self.m_onlineRuleBtn:addClickListener(handler(self, self._onOnlineRuleCheckBtnClick))

	if DebugCommon.getDebugGlobalValueByKey("online_rule") then
		g.core.utils.Rule.doOnlineRulePatch()
	end

	self.m_packageCloseBtn:setSelected(DebugCommon.getDebugGlobalValueByKey("package_close"))
	self.m_packageCloseBtn:addClickListener(handler(self, self._onPackageCloseBtnClick))
	self.m_rigidBtn:setSelected(DebugCommon.getDebugGlobalValueByKey("force_rigid"))
	self.m_rigidBtn:addClickListener(handler(self, self._onRigidBtnClick))
end

function DebugGameSetListComp:_onBattleHideLog()
	local BattleConst = require("app.view.battle.const.BattleConst")

	BattleConst.DEBUG = false
	BattleConst.SKIP_ENABLE = false
	BattleConst.FUNCTION_DEBUG = false
end

function DebugGameSetListComp:_onCloseGuideBtnClick(arg_4_1)
	if arg_4_1:getSender():isSelected() then
		GUIDE_CLOSE = false

		g.core.common.Storage:save("guide_open_state.json", {
			open = true
		}, false)
	else
		GUIDE_CLOSE = true

		g.core.common.Storage:save("guide_open_state.json", {
			open = false
		}, false)
	end
end

function DebugGameSetListComp:_onGvePathCheckClick(arg_5_1)
	g.core.model.User.gveDataMgr:getGveData():setCheckSkipPath((arg_5_1:getSender():isSelected()))
end

function DebugGameSetListComp:_onFpsBtnClick(arg_6_1)
	cc.Director:getInstance():setDisplayStats((arg_6_1:getSender():isSelected()))
end

function DebugGameSetListComp:_onSkipBattleBtnClick(arg_7_1)
	if arg_7_1:getSender():isSelected() then
		g.core.common.Storage:save("battle_skip_open.json", {
			open = true
		}, false)
	else
		g.core.common.Storage:save("battle_skip_open.json", {
			open = false
		}, false)
	end
end

function DebugGameSetListComp:_onFurnitureDebugTouchClick(arg_8_1)
	if arg_8_1:getSender():isSelected() then
		g.core.common.Storage:save("furniture_spine_touch_debug.json", {
			show = true
		}, false)
	else
		g.core.common.Storage:save("furniture_spine_touch_debug.json", {
			show = false
		}, false)
	end
end

function DebugGameSetListComp:_onCloseOpenScreenClick(arg_9_1)
	if arg_9_1:getSender():isSelected() then
		g.core.common.Storage:save("closeOpenScreen.json", {
			isClose = true
		}, false)
	else
		g.core.common.Storage:save("closeOpenScreen.json", {
			isClose = false
		}, false)
	end
end

function DebugGameSetListComp:_onClosedSilentDownClick(arg_10_1)
	local var_10_0 = {
		open = true
	}

	var_10_0.open = not not arg_10_1:getSender():isSelected()

	g.core.common.Storage:save("silent_close_state.json", var_10_0, false)
end

function DebugGameSetListComp:onShow()
	self:setVisible(true)
end

function DebugGameSetListComp:onHide()
	self:setVisible(false)
end

function DebugGameSetListComp:_onGveBattleFast(arg_13_1)
	DebugCommon.setDebugGlobalValueByKey("gve_skip_battle", (arg_13_1:getSender():isSelected()))
end

function DebugGameSetListComp:_onFogBattleFast(arg_14_1)
	DebugCommon.setDebugGlobalValueByKey("fog_skip_battle", (arg_14_1:getSender():isSelected()))
end

function DebugGameSetListComp:_onStormMiddleBattleFast(arg_15_1)
	DebugCommon.setDebugGlobalValueByKey("storm_middle_battle", (arg_15_1:getSender():isSelected()))
end

function DebugGameSetListComp:_onThemeDungeonBattleFast(arg_16_1)
	DebugCommon.setDebugGlobalValueByKey("theme_dungeon_skip_battle", (arg_16_1:getSender():isSelected()))
end

function DebugGameSetListComp:_onGuessDefaultCheckBtn(arg_17_1)
	DebugCommon.setDebugGlobalValueByKey("guess_default_not_des", (arg_17_1:getSender():isSelected()))
end

function DebugGameSetListComp:_onClickRecruitJumpBtn(arg_18_1)
	DebugCommon.setDebugGlobalValueByKey("recruit_jump_effect", (arg_18_1:getSender():isSelected()))
end

function DebugGameSetListComp:_onClickSkipAwardBtn(arg_19_1)
	DebugCommon.setDebugGlobalValueByKey("skip_award_summary", (arg_19_1:getSender():isSelected()))
end

function DebugGameSetListComp:_onWushTowerBattleFast(arg_20_1)
	DebugCommon.setDebugGlobalValueByKey("wushTower_skip_battle", (arg_20_1:getSender():isSelected()))
end

function DebugGameSetListComp:_onWeddingHideUI(arg_21_1)
	DebugCommon.setDebugGlobalValueByKey("wedding_action_hide_ui", (arg_21_1:getSender():isSelected()))
end

function DebugGameSetListComp:_onSimpleHomeUI(arg_22_1)
	DebugCommon.setDebugGlobalValueByKey("debug_home_simple_ui", (arg_22_1:getSender():isSelected()))
end

function DebugGameSetListComp:_onRedPointCacheClick(arg_23_1)
	local var_23_0 = arg_23_1:getSender():isSelected()

	g.core.model.User.redPointRefreshCache:setCacheOn(not g.core.model.User.redPointRefreshCache:getCacheState())
end

function DebugGameSetListComp:_onSpireAutoAttackClick(arg_24_1)
	DebugCommon.setDebugGlobalValueByKey("spire_tower_auto", (arg_24_1:getSender():isSelected()))
end

function DebugGameSetListComp:_onClickFrameBtn(arg_25_1)
	local var_25_0 = arg_25_1:getSender():isSelected()

	if var_25_0 then
		cc.Director:getInstance():setAnimationInterval(0.016666666666666666)
	else
		cc.Director:getInstance():setAnimationInterval(0.03333333333333333)
	end

	DebugCommon.setDebugGlobalValueByKey("set_frame", var_25_0)
end

function DebugGameSetListComp:_onGuessSetTimeCheckBtn(arg_26_1)
	DebugCommon.setDebugGlobalValueByKey("guess_set_time_99999", (arg_26_1:getSender():isSelected()))
end

function DebugGameSetListComp:_onLogActInfoCheckBtn(arg_27_1)
	local ActivityTimeData = require("app.view.module.activity.model.ActivityTimeData")
	local var_27_1 = arg_27_1:getSender():isSelected()

	if var_27_1 ~= ActivityTimeData:isActLogEnable() then
		ActivityTimeData:setActLogEnable(var_27_1)

		local var_27_2 = g.core.common.Storage:load("activity_log_switch.json", false) or {}

		var_27_2.openActLog = var_27_1

		g.core.common.Storage:save("activity_log_switch.json", var_27_2, false)
	end
end

function DebugGameSetListComp:_onClickRuleBtn(arg_28_1)
	if arg_28_1:getSender():isSelected() then
		g.core.utils.Rule.doRulePatchLogic()
	end
end

function DebugGameSetListComp:_onActTypeInputEnd()
	local ActivityData = require("app.view.module.activity.model.ActivityData")
	local var_29_1 = checknumber(self.m_actTypeInput:getText())

	if ActivityData:getLogActType() ~= var_29_1 then
		ActivityData:setLogActType(var_29_1)

		local var_29_2 = g.core.common.Storage:load("activity_log_switch.json", false) or {}

		var_29_2.logActType = var_29_1

		g.core.common.Storage:save("activity_log_switch.json", var_29_2, false)
	end
end

function DebugGameSetListComp:_on5SyncTimeCheckBtn(arg_30_1)
	local var_30_0 = arg_30_1:getSender():isSelected()
	local var_30_1 = g.core.common.Storage:load("sync_server_time.json", false) or {}

	if var_30_1.every5s ~= var_30_0 then
		var_30_1.every5s = var_30_0

		g.core.common.Storage:save("sync_server_time.json", var_30_1, false)
	end
end

function DebugGameSetListComp:_onFightValueBtnClick()
	DebugCommon.setDebugGlobalValueByKey("fight_value_dump", not DebugCommon.getDebugGlobalValueByKey("fight_value_dump"))
end

function DebugGameSetListComp:_onNewGuideBtnClick()
	DebugCommon.setDebugGlobalValueByKey("new_guide", not DebugCommon.getDebugGlobalValueByKey("new_guide"))
end

function DebugGameSetListComp:_onUpgradeBtnClick(arg_33_1)
	DebugCommon.setDebugUpgradeClose(not arg_33_1:getSender():isSelected())
end

function DebugGameSetListComp:_onIgnorePlotReviewBtnClick(arg_34_1)
	local var_34_0 = arg_34_1:getSender():isSelected()
	local var_34_1 = g.core.common.Storage:load("ignorePlotReview.json", false) or {}

	if var_34_1.open ~= var_34_0 then
		var_34_1.open = var_34_0

		g.core.common.Storage:save("ignorePlotReview.json", var_34_1, false)
	end
end

function DebugGameSetListComp:_onExplorationMapCheckBtn(arg_35_1)
	local var_35_0 = arg_35_1:getSender():isSelected()

	if DebugCommon.getDebugGlobalValueByKey("exploration_map_btn") ~= var_35_0 then
		DebugCommon.setDebugGlobalValueByKey("exploration_map_btn", var_35_0)
	end
end

function DebugGameSetListComp:_onRedCliffMapCheckBtn(arg_36_1)
	local var_36_0 = arg_36_1:getSender():isSelected()

	if DebugCommon.getDebugGlobalValueByKey("redCliff_map_btn") ~= var_36_0 then
		DebugCommon.setDebugGlobalValueByKey("redCliff_map_btn", var_36_0)
	end
end

function DebugGameSetListComp:_onRerunEasyCheckBtn(arg_37_1)
	local var_37_0 = arg_37_1:getSender():isSelected()

	if DebugCommon.getDebugGlobalValueByKey("rerun_easy") ~= var_37_0 then
		DebugCommon.setDebugGlobalValueByKey("rerun_easy", var_37_0)
	end
end

function DebugGameSetListComp:_onOnlineRuleCheckBtnClick(arg_38_1)
	local var_38_0 = arg_38_1:getSender():isSelected()

	if var_38_0 then
		g.core.utils.Rule.doOnlineRulePatch()
	end

	DebugCommon.setDebugGlobalValueByKey("online_rule", var_38_0)
end

function DebugGameSetListComp:_onPackageCloseBtnClick(arg_39_1)
	DebugCommon.setDebugGlobalValueByKey("package_close", (arg_39_1:getSender():isSelected()))
end

function DebugGameSetListComp:_onRigidBtnClick(arg_40_1)
	DebugCommon.setDebugGlobalValueByKey("force_rigid", (arg_40_1:getSender():isSelected()))
end

function DebugGameSetListComp:_save(arg_41_1)
	g.core.common.Storage:save(arg_41_1, ...)
end

function DebugGameSetListComp:_load(arg_42_1)
	return g.core.common.Storage:load(arg_42_1, ...) or {}
end

return DebugGameSetListComp
