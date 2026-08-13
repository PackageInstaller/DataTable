class = var_0_10000

local var_0_0 = "NewActivityBossSPResultGradePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NewActivityBossResultGradePage"))

function var_0_1.LoadBGAndGrade(arg_1_0, arg_1_1)
	parallelAsync = var_1_10002

	var_1_10002({
		function(arg_2_0)
			local var_2_0 = arg_1_0

			var_1.LoadBG(var_2_0, arg_2_0)

			return
		end,
		function(arg_3_0)
			local var_3_0 = arg_1_0

			var_1.LoadGrade(var_3_0, arg_3_0)

			return
		end,
		function(arg_4_0)
			local var_4_0 = arg_1_0

			var_1.LoadActivityBossSPRes(var_4_0, arg_4_0)

			return
		end
	}, arg_1_1)

	return
end

function var_0_1.LoadActivityBossSPRes(arg_5_0, arg_5_1)
	ResourceMgr = var_1_10002

	local var_5_0 = var_1_10002.Inst
	local var_5_1 = var_2.getAssetAsync
	local var_5_2 = "BattleResultItems/ActivitybossSP"
	local var_5_3 = ""

	UnityEngine = var_1_10007

	var_5_1(var_5_0, var_5_2, var_5_3, var_1_10007.Events.UnityAction_UnityEngine_Object(function(arg_6_0)
		if arg_5_0.exited then
			return
		end

		Object = var_1

		local var_6_0 = var_1.Instantiate(arg_6_0, arg_5_0.bgTr)
		local var_6_1 = arg_5_0

		var_2.InitActivityPanel(var_6_1, var_6_0.transform)
		arg_5_1()

		return
	end), true, true)

	return
end

function var_0_1.InitActivityPanel(arg_7_0, arg_7_1)
	arg_7_1:SetSiblingIndex(1)

	arg_7_0.playAgain = arg_7_1:Find("playAgain")

	local var_7_0 = arg_7_1

	arg_7_0.toggle = arg_7_1.Find(var_7_0, "playAgain/ticket/checkbox")
	getProxy = var_2
	ActivityProxy = var_7_0

	local var_7_1 = var_2(var_7_0)
	local var_7_2 = var_2.GetActivityBossRuntime(var_7_1, arg_7_0.contextData.actId).spScore

	var_2.spScore = {
		score = 0
	}
	setText = var_4

	var_4(arg_7_1:Find("Score/Text"), var_7_2.score)

	setActive = var_4

	var_4(arg_7_1:Find("Score/NewText"), var_7_2.new)

	setActive = var_4

	var_4(arg_7_1:Find("Score/NotNewText"), not var_7_2.new)

	local var_7_3 = var_2.buffIds

	arg_7_0:UpdateActiveBuffs(arg_7_1:Find("Active"), var_7_3)

	setText = var_5

	local var_7_4 = arg_7_1:Find("Score/Title")

	i18n = var_8

	var_5(var_7_4, var_8("activityboss_sp_score"))

	setText = var_5

	local var_7_5 = arg_7_1:Find("Score/NewText")

	i18n = var_8

	var_5(var_7_5, var_8("activityboss_sp_score_update"))

	setText = var_5

	local var_7_6 = arg_7_1:Find("Score/NotNewText")

	i18n = var_8

	var_5(var_7_6, var_8("activityboss_sp_score_not_update"))

	setText = var_5

	local var_7_7 = arg_7_1:Find("Active/PTTitle")

	i18n = var_8

	var_5(var_7_7, var_8("activityboss_sp_score_bonus"))

	setText = var_5

	local var_7_8 = arg_7_1:Find("Active/BuffTitle")

	i18n = var_8

	var_5(var_7_8, var_8("activityboss_sp_active_buff"))

	return
end

function var_0_1.UpdateActiveBuffs(arg_8_0, arg_8_1, arg_8_2)
	_ = var_1_10003

	local var_8_0 = var_1_10003.map(arg_8_2, function(arg_9_0)
		ActivityBossBuff = var_2_10001

		return var_2_10001.New({
			configId = arg_9_0
		})
	end)
	local var_8_1 = arg_8_1:Find("ScrollView")
	local var_8_2 = var_4.GetComponent(var_8_1, "LScrollRect")

	function var_8_2.onUpdateItem(arg_10_0, arg_10_1)
		arg_10_0 = arg_10_0 + 1
		tf = var_2_10002

		local var_10_0 = var_2_10002(arg_10_1)
		local var_10_1 = var_8_0[arg_10_0]

		setActive = var_4

		local var_10_2 = var_10_0:Find("Icon")

		tobool = var_2_10007

		var_4(var_10_2, var_2_10007(var_10_1))

		if not var_10_1 then
			return
		end

		GetImageSpriteFromAtlasAsync = var_4

		var_4(var_10_1:GetIconPath(), "", var_10_0:Find("Icon"))

		return
	end

	local var_8_3 = 20

	var_8_2:SetTotalCount(var_8_3)

	_ = var_6

	local var_8_4 = var_6.reduce(var_8_0, 0, function(arg_11_0, arg_11_1)
		return arg_11_0 + arg_11_1:GetBonus()
	end)

	Mathf = var_7

	local var_8_5 = var_7.Round(var_8_4 * 100)

	setText = var_7

	var_7(arg_8_1:Find("Text"), "+" .. var_8_5 .. "%")

	return
end

return var_0_1
