local var_0_0 = class("NewActivityBossSPResultGradePage", import(".NewActivityBossResultGradePage"))

function var_0_0.LoadBGAndGrade(arg_1_0, arg_1_1)
	parallelAsync({
		function(arg_2_0)
			arg_1_0:LoadBG(arg_2_0)

			return
		end,
		function(arg_3_0)
			arg_1_0:LoadGrade(arg_3_0)

			return
		end,
		function(arg_4_0)
			arg_1_0:LoadActivityBossSPRes(arg_4_0)

			return
		end
	}, arg_1_1)

	return
end

function var_0_0.LoadActivityBossSPRes(arg_5_0, arg_5_1)
	ResourceMgr.Inst:getAssetAsync("BattleResultItems/ActivitybossSP", "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_6_0)
		if arg_5_0.exited then
			return
		end

		arg_5_0:InitActivityPanel(Object.Instantiate(arg_6_0, arg_5_0.bgTr).transform)
		arg_5_1()

		return
	end), true, true)

	return
end

function var_0_0.InitActivityPanel(arg_7_0, arg_7_1)
	arg_7_1:SetSiblingIndex(1)

	arg_7_0.playAgain = arg_7_1:Find("playAgain")
	arg_7_0.toggle = arg_7_1:Find("playAgain/ticket/checkbox")

	local var_7_0 = getProxy(ActivityProxy):GetActivityBossRuntime(arg_7_0.contextData.actId)

	var_7_0.spScore = {
		score = 0
	}

	setText(arg_7_1:Find("Score/Text"), var_7_0.spScore.score)
	setActive(arg_7_1:Find("Score/NewText"), var_7_0.spScore.new)
	setActive(arg_7_1:Find("Score/NotNewText"), not var_7_0.spScore.new)
	arg_7_0:UpdateActiveBuffs(arg_7_1:Find("Active"), var_7_0.buffIds)
	setText(arg_7_1:Find("Score/Title"), i18n("activityboss_sp_score"))
	setText(arg_7_1:Find("Score/NewText"), i18n("activityboss_sp_score_update"))
	setText(arg_7_1:Find("Score/NotNewText"), i18n("activityboss_sp_score_not_update"))
	setText(arg_7_1:Find("Active/PTTitle"), i18n("activityboss_sp_score_bonus"))
	setText(arg_7_1:Find("Active/BuffTitle"), i18n("activityboss_sp_active_buff"))

	return
end

function var_0_0.UpdateActiveBuffs(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = _.map(arg_8_2, function(arg_9_0)
		return ActivityBossBuff.New({
			configId = arg_9_0
		})
	end)
	local var_8_1 = arg_8_1:Find("ScrollView"):GetComponent("LScrollRect")

	function var_8_1.onUpdateItem(arg_10_0, arg_10_1)
		arg_10_0 = arg_10_0 + 1

		local var_10_0 = tf(arg_10_1)

		setActive(var_10_0:Find("Icon"), tobool(var_8_0[arg_10_0]))

		if not var_8_0[arg_10_0] then
			return
		end

		GetImageSpriteFromAtlasAsync(var_8_0[arg_10_0]:GetIconPath(), "", var_10_0:Find("Icon"))

		return
	end

	var_8_1:SetTotalCount(20)
	setText(arg_8_1:Find("Text"), "+" .. Mathf.Round(_.reduce(_.map(arg_8_2, function(arg_9_0)
		return ActivityBossBuff.New({
			configId = arg_9_0
		})
	end), 0, function(arg_11_0, arg_11_1)
		return arg_11_0 + arg_11_1:GetBonus()
	end) * 100) .. "%")

	return
end

return var_0_0
