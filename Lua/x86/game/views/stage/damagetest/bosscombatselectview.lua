local var_0_0 = class("BossCombatSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/DamageTest/BossCombatSelectUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.affixList_ = LuaList.New(handler(arg_3_0, arg_3_0.RefreshAffixItem), arg_3_0.affixUIList_, DamageTestConditionItem)
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_4_0.damageTestId_ = arg_4_0.params_.damageTestId

	arg_4_0:RefreshUI()

	local var_4_0 = DamageTestCfg[arg_4_0.damageTestId_]

	arg_4_0.affixList_:StartScroll(#var_4_0.time_pool + #var_4_0.affix_pool, 1)
end

function var_0_0.OnExit(arg_5_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	arg_6_0.chooseConditionHandler_ = nil

	if arg_6_0.affixList_ then
		arg_6_0.affixList_:Dispose()

		arg_6_0.affixList_ = nil
	end
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.battleBtn_, nil, function()
		local var_8_0 = DamageTestCfg[arg_7_0.damageTestId_]

		arg_7_0:Go("/sectionSelectHero", {
			section = var_8_0.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.DAMAGE_TEST,
			activityID = arg_7_0.damageTestId_
		})
	end)
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0 = DamageTestCfg[arg_9_0.damageTestId_]
	local var_9_1 = BossChallengeUICfg[var_9_0.boss_id]

	arg_9_0.bossHealthText_.text = var_9_0.boss_base_hp
	arg_9_0.bossImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.BossLittlePaint.path, var_9_1.icon))
end

function var_0_0.RefreshAffixItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = DamageTestCfg[arg_10_0.damageTestId_]
	local var_10_1
	local var_10_2

	if arg_10_1 <= #var_10_0.time_pool then
		var_10_1 = BossConst.TYPE_STAGE
		var_10_2 = var_10_0.time_pool[arg_10_1]
	else
		var_10_1 = BossConst.TYPE_AFFIX
		var_10_2 = var_10_0.affix_pool[arg_10_1 - #var_10_0.time_pool]
	end

	arg_10_2:SetData(arg_10_0.damageTestId_, var_10_1, var_10_2)
end

return var_0_0
