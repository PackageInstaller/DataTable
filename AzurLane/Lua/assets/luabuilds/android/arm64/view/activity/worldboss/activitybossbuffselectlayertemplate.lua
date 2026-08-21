local var_0_0 = class("ActivityBossBuffSelectLayerTemplate", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	error("Need Complete")

	return
end

function var_0_0.init(arg_2_0)
	arg_2_0.buffList = arg_2_0._tf:Find("BuffList")
	arg_2_0.buffScrollComp = arg_2_0.buffList:Find("ScrollView"):GetComponent("LScrollRect")
	arg_2_0.activeBuffRect = arg_2_0._tf:Find("Active")
	arg_2_0.activeBuffScrollComp = arg_2_0.activeBuffRect:Find("ScrollView"):GetComponent("LScrollRect")
	arg_2_0.startBtn = arg_2_0._tf:Find("Start")
	arg_2_0.top = arg_2_0._tf:Find("top")

	setText(arg_2_0._tf:Find("BuffList/Title/Text"), i18n("activityboss_sp_all_buff"))
	setText(arg_2_0._tf:Find("Rewards/Desc"), i18n("activityboss_sp_best_score"))
	setText(arg_2_0._tf:Find("Rewards/Reward/Text"), i18n("activityboss_sp_display_reward"))
	setText(arg_2_0._tf:Find("Active/Title/Text"), i18n("activityboss_sp_active_buff"))
	setText(arg_2_0._tf:Find("Active/PT/Title"), i18n("activityboss_sp_score_bonus"))

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0.buffDatas = {}
	arg_3_0.buffs = _.map(arg_3_0.contextData.spEnemyInfo:GetSelectableBuffs(), function(arg_4_0)
		local var_4_0 = ActivityBossBuff.New({
			configId = arg_4_0
		})

		arg_3_0.buffDatas[var_4_0] = {}

		return var_4_0
	end)

	local var_3_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2)

	_.each(var_3_0:GetHistoryBuffs(), function(arg_5_0)
		arg_3_0.buffDatas[_.detect(arg_3_0.buffs, function(arg_6_0)
			return arg_6_0:GetConfigID() == arg_5_0
		end)].selected = true

		return
	end)

	arg_3_0.rewards = arg_3_0.contextData.spEnemyInfo:GetRewards()
	arg_3_0.targets = arg_3_0.contextData.spEnemyInfo:GetScoreTargets()
	arg_3_0.score = arg_3_0.contextData.score

	function arg_3_0.buffScrollComp.onUpdateItem(arg_7_0, arg_7_1)
		arg_3_0:UpdateBuffItem(arg_7_0 + 1, arg_7_1)

		return
	end

	function arg_3_0.activeBuffScrollComp.onUpdateItem(arg_8_0, arg_8_1)
		arg_3_0:UpdateActiveBuffItem(arg_8_0 + 1, arg_8_1)

		return
	end

	onButton(arg_3_0, arg_3_0.top:Find("back_btn"), function()
		arg_3_0:closeView()

		return
	end, SOUND_BACK)
	onButton(arg_3_0, arg_3_0.top:Find("option"), function()
		arg_3_0:quickExitFunc()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("Rewards/Reward"), function()
		arg_3_0:emit(ActivityBossBuffSelectMediator.SHOW_REWARDS, arg_3_0.rewards, arg_3_0.targets, var_3_0:GetHighestScore())

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.startBtn, function()
		arg_3_0:emit(ActivityBossBuffSelectMediator.ON_START, arg_3_0.activeBuffs)

		return
	end, SFX_PANEL)
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0._tf)
	setText(arg_3_0._tf:Find("Rewards/Score"), var_3_0:GetHighestScore())
	arg_3_0:UpdateView()

	return
end

function var_0_0.UpdateView(arg_13_0)
	arg_13_0.buffScrollComp:SetTotalCount(#arg_13_0.buffs)
	arg_13_0:UpdateActiveBuffs()

	return
end

function var_0_0.UpdateBuffItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = tf(arg_14_2)

	setActive(var_14_0:Find("Selected"), arg_14_0.buffDatas[arg_14_0.buffs[arg_14_1]].selected)
	setText(var_14_0:Find("Name/Text"), arg_14_0.buffs[arg_14_1]:GetDesc())
	setText(var_14_0:Find("PT/Text"), "+" .. arg_14_0.buffs[arg_14_1]:GetBonusText())
	GetImageSpriteFromAtlasAsync(arg_14_0.buffs[arg_14_1]:GetIconPath(), "", var_14_0:Find("Item/Icon"))
	onButton(arg_14_0, var_14_0, function()
		var_0.selected = not var_0.selected

		arg_14_0:UpdateView()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateActiveBuffs(arg_16_0)
	arg_16_0.activeBuffs = _.select(arg_16_0.buffs, function(arg_17_0)
		return arg_16_0.buffDatas[arg_17_0].selected
	end)

	arg_16_0.activeBuffScrollComp:SetTotalCount(math.max(math.floor((#arg_16_0.activeBuffs - 1) / 5) + 1, 4) * 5)
	setText(arg_16_0.activeBuffRect:Find("PT/Text"), "+" .. Mathf.Round(_.reduce(arg_16_0.activeBuffs, 0, function(arg_18_0, arg_18_1)
		return arg_18_0 + arg_18_1:GetBonus()
	end) * 100) .. "%")

	return
end

function var_0_0.UpdateActiveBuffItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = tf(arg_19_2)

	setActive(var_19_0:Find("Icon"), tobool(arg_19_0.activeBuffs[arg_19_1]))

	if not arg_19_0.activeBuffs[arg_19_1] then
		return
	end

	GetImageSpriteFromAtlasAsync(arg_19_0.activeBuffs[arg_19_1]:GetIconPath(), "", var_19_0:Find("Icon"))

	return
end

function var_0_0.willExit(arg_20_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_20_0._tf)

	return
end

return var_0_0
