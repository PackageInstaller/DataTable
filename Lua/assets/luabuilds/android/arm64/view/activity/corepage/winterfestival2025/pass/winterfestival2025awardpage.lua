local var_0_0 = class("WinterFestival2025AwardPage", import("...PSS.Hei5.PSSHei5AwardPage"))

function var_0_0.getUIName(arg_1_0)
	return "WinterFestival2025AwardPage"
end

function var_0_0.initTplVar(arg_2_0)
	arg_2_0.btnAllTip = "winter_cruise_btn_all"

	return
end

function var_0_0.UpdateAwardInfo(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3.id < 10 then
		setText(arg_3_2:Find("Text"), "0" .. arg_3_3.id)
	else
		setText(arg_3_2:Find("Text"), arg_3_3.id)
	end

	local var_3_0 = arg_3_3.pt <= arg_3_0.pt
	local var_3_1 = Drop.Create(arg_3_3.award)

	onButton(arg_3_0, arg_3_2:Find("base"), function()
		arg_3_0:emit(BaseUI.ON_NEW_STYLE_DROP, {
			drop = var_3_1
		})

		return
	end, SFX_CONFIRM)
	setActive(arg_3_2:Find("base/lock"), not var_3_0)
	updateDrop(arg_3_2:Find("base/mask/IconTpl"), var_3_1)
	setActive(arg_3_2:Find("base/get"), var_3_0 and not arg_3_0.awardDic[arg_3_3.pt])
	setActive(arg_3_2:Find("base/got"), arg_3_0.awardDic[arg_3_3.pt])

	local var_3_2 = Drop.Create(arg_3_3.award_pay)

	onButton(arg_3_0, arg_3_2:Find("pay"), function()
		arg_3_0:emit(BaseUI.ON_NEW_STYLE_DROP, {
			drop = var_3_2
		})

		return
	end, SFX_CONFIRM)
	updateDrop(arg_3_2:Find("pay/mask/IconTpl"), (Drop.Create(arg_3_3.award_pay)))
	setActive(arg_3_2:Find("pay/no_pay"), not var_3_0 or not arg_3_0.isPay)

	local var_3_3 = arg_3_0.isPay and var_3_0 and not arg_3_0.awardPayDic[arg_3_3.pt]

	setActive(arg_3_2:Find("pay/get"), var_3_3)
	setActive(arg_3_2:Find("pay/got"), arg_3_0.awardPayDic[arg_3_3.pt])

	return
end

return var_0_0
