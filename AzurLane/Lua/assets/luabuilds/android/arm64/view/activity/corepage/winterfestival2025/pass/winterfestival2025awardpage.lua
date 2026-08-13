class = var_0_10000

local var_0_0 = "WinterFestival2025AwardPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...PSS.Hei5.PSSHei5AwardPage"))

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

	onButton = var_1_10006

	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_2
	local var_3_4 = arg_3_2.Find(var_3_3, "base")

	local function var_3_5()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		BaseUI = var_2_10003

		var_4_1(var_4_0, var_2_10003.ON_NEW_STYLE_DROP, {
			drop = var_3_1
		})

		return
	end

	SFX_CONFIRM = var_3_3

	var_1_10006(var_3_2, var_3_4, var_3_5, var_3_3)

	setActive = var_1_10006

	var_1_10006(arg_3_2:Find("base/lock"), not var_3_0)

	updateDrop = var_1_10006

	var_1_10006(arg_3_2:Find("base/mask/IconTpl"), var_3_1)

	setActive = var_1_10006

	var_1_10006(arg_3_2:Find("base/get"), var_3_0 and not arg_3_0.awardDic[arg_3_3.pt])

	setActive = var_1_10006

	var_1_10006(arg_3_2:Find("base/got"), arg_3_0.awardDic[arg_3_3.pt])

	Drop = var_1_10006

	local var_3_6 = var_1_10006.Create(arg_3_3.award_pay)

	onButton = var_7

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_2
	local var_3_9 = arg_3_2.Find(var_3_8, "pay")

	local function var_3_10()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		BaseUI = var_2_10003

		var_5_1(var_5_0, var_2_10003.ON_NEW_STYLE_DROP, {
			drop = var_3_6
		})

		return
	end

	SFX_CONFIRM = var_3_8

	var_7(var_3_7, var_3_9, var_3_10, var_3_8)

	updateDrop = var_7

	var_7(arg_3_2:Find("pay/mask/IconTpl"), var_3_6)

	setActive = var_7

	var_7(arg_3_2:Find("pay/no_pay"), not var_3_0 or not arg_3_0.isPay)

	setActive = var_7

	local var_3_11 = arg_3_2:Find("pay/get")
	local var_3_12

	if arg_3_0.isPay then
		var_3_12 = var_3_0 and not arg_3_0.awardPayDic[arg_3_3.pt]
	end

	var_7(var_3_11, var_3_12)

	setActive = var_7

	var_7(arg_3_2:Find("pay/got"), arg_3_0.awardPayDic[arg_3_3.pt])

	return
end

return var_0_1
