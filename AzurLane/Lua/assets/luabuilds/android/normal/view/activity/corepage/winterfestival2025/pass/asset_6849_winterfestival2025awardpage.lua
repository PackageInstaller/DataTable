class = var_0_10000

local var_0_0 = "WinterFestival2025AwardPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...PSS.Hei5.PSSHei5AwardPage"))

function var_0_1.getUIName(arg_1_0)
	return "WinterFestival2025AwardPage"
end

function var_0_1.initTplVar(arg_2_0)
	arg_2_0.btnAllTip = "winter_cruise_btn_all"

	return
end

function var_0_1.UpdateAwardInfo(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3.id < 10 then
		setText = var_4

		var_4(arg_3_2:Find("Text"), "0" .. arg_3_3.id)
	else
		setText = var_4

		var_4(arg_3_2:Find("Text"), arg_3_3.id)
	end

	local var_3_0 = arg_3_3.pt <= arg_3_0.pt

	Drop = var_5

	local var_3_1 = var_5.Create(arg_3_3.award)

	onButton = var_6

	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_2:Find("base")

	local function var_3_4()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		BaseUI = var_2_10002

		var_4_1(var_4_0, var_2_10002.ON_NEW_STYLE_DROP, {
			drop = var_3_1
		})

		return
	end

	SFX_CONFIRM = var_10

	var_6(var_3_2, var_3_3, var_3_4, var_10)

	setActive = var_6

	var_6(arg_3_2:Find("base/lock"), not var_3_0)

	updateDrop = var_6

	var_6(arg_3_2:Find("base/mask/IconTpl"), var_3_1)

	setActive = var_6

	var_6(arg_3_2:Find("base/get"), var_3_0 and not arg_3_0.awardDic[arg_3_3.pt])

	setActive = var_6

	var_6(arg_3_2:Find("base/got"), arg_3_0.awardDic[arg_3_3.pt])

	Drop = var_6

	local var_3_5 = var_6.Create(arg_3_3.award_pay)

	onButton = var_7

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_2:Find("pay")

	local function var_3_8()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		BaseUI = var_2_10002

		var_5_1(var_5_0, var_2_10002.ON_NEW_STYLE_DROP, {
			drop = var_3_5
		})

		return
	end

	SFX_CONFIRM = var_11

	var_7(var_3_6, var_3_7, var_3_8, var_11)

	updateDrop = var_7

	var_7(arg_3_2:Find("pay/mask/IconTpl"), var_3_5)

	setActive = var_7

	var_7(arg_3_2:Find("pay/no_pay"), not var_3_0 or not arg_3_0.isPay)

	setActive = var_7

	local var_3_9 = arg_3_2:Find("pay/get")
	local var_3_10

	if arg_3_0.isPay then
		var_3_10 = var_3_0 and not arg_3_0.awardPayDic[arg_3_3.pt]
	end

	var_7(var_3_9, var_3_10)

	setActive = var_7

	var_7(arg_3_2:Find("pay/got"), arg_3_0.awardPayDic[arg_3_3.pt])

	return
end

return var_0_1
