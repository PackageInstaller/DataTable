class = var_0_10000

local var_0_0 = "BattleContributionResultLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BattleActivityBossResultLayer"))

function var_0_1.setActId(arg_1_0, arg_1_1)
	arg_1_0._actID = arg_1_1
	pg = var_1_10002

	local var_1_0 = var_1_10002.activity_template[arg_1_1]

	pg = var_1_10003
	arg_1_0._resourceID = var_1_10003.activity_event_worldboss[var_1_0.config_id].damage_resource

	return
end

function var_0_1.didEnter(arg_2_0)
	var_0_1.super.didEnter(arg_2_0)
	arg_2_0:setPoint()

	return
end

function var_0_1.setPoint(arg_3_0)
	arg_3_0._contributionPoint = 0
	ipairs = var_1

	for iter_3_0, iter_3_1 in var_1(arg_3_0.contextData.drops) do
		if iter_3_1.configId == arg_3_0._resourceID then
			arg_3_0._contributionPoint = iter_3_1.count
		end
	end

	return
end

function var_0_1.setGradeLabel(arg_4_0)
	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_1.Find(var_4_0, "grade/Xyz/bg13")
	local var_4_2 = arg_4_0._tf
	local var_4_3 = var_2.Find(var_4_2, "grade/Xyz/bg14")

	setActive = var_4_0

	var_4_0(var_4_1, false)

	local var_4_4 = "battlescore/grade_label_clear"

	LoadImageSpriteAsync = var_4_2

	var_4_2(var_4_4, var_4_3, false)

	return
end

function var_0_1.rankAnimaFinish(arg_5_0)
	setActive = var_1_10001

	var_1_10001(arg_5_0._conditionBGNormal, false)

	setActive = var_1_10001

	var_1_10001(arg_5_0._conditionBGContribute, true)

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.setCondition

	i18n = var_4

	local var_5_2 = var_4("battle_result_total_damage")
	local var_5_3 = arg_5_0.contextData.statistics.specificDamage

	COLOR_BLUE = var_6

	var_5_1(var_5_0, var_5_2, var_5_3, var_6)

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.setCondition

	i18n = var_5_2

	local var_5_6 = var_5_2("battle_result_contribution")
	local var_5_7 = arg_5_0._contributionPoint

	COLOR_YELLOW = var_6

	var_5_5(var_5_4, var_5_6, var_5_7, var_6)

	LeanTween = var_5_5

	local var_5_8 = var_5_5.delayedCall
	local var_5_9 = 1

	System = var_5_6

	local var_5_10 = var_5_8(var_5_9, var_5_6.Action(function()
		local var_6_0 = arg_5_0

		var_6_0._stateFlag = var_0_1.STATE_REPORTED
		SetActive = var_6_0

		local var_6_1 = arg_5_0._bg

		var_6_0(var_2.Find(var_6_1, "jieuan01/tips"), true)

		return
	end))

	table = var_1_10002

	var_1_10002.insert(arg_5_0._delayLeanList, var_5_10.id)

	arg_5_0._stateFlag = var_0_1.STATE_REPORT

	return
end

function var_0_1.setCondition(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	cloneTplTo = var_1_10004

	local var_7_0 = var_1_10004(arg_7_0._conditionContributeTpl, arg_7_0._conditionContainer)

	setActive = var_1_10005

	var_1_10005(var_7_0, false)

	local var_7_1
	local var_7_2 = var_7_0:Find("text")
	local var_7_3 = var_6.GetComponent

	typeof = var_9
	Text = var_1_10011

	local var_7_4 = var_7_3(var_7_2, var_9(var_1_10011))

	setColorStr = var_7
	var_7_4.text = var_7(arg_7_1, "#FFFFFFFF")

	local var_7_5 = var_7_0:Find("value")
	local var_7_6 = var_7.GetComponent

	typeof = var_10
	Text = var_1_10012

	local var_7_7 = var_7_6(var_7_5, var_10(var_1_10012))

	setColorStr = var_7_2
	var_7_7.text = var_7_2(arg_7_2, arg_7_3)

	local var_7_8 = arg_7_0._conditionContainer.childCount - 1
	local var_7_9

	if 0 < var_7_8 then
		LeanTween = var_7_9
		var_7_9 = var_7_9.delayedCall

		local var_7_10 = var_0_1.CONDITIONS_FREQUENCE * var_7_8

		System = var_1_10012
		var_7_9 = var_7_9(var_7_10, var_1_10012.Action(function()
			setActive = var_2_10000

			var_2_10000(var_7_0, true)

			return
		end))
		table = var_10

		var_10.insert(arg_7_0._delayLeanList, var_7_9.id)
	else
		setActive = var_7_9

		var_7_9(var_7_0, true)
	end

	return
end

return var_0_1
