local WinterFestival2025AwardPage = class("WinterFestival2025AwardPage", import("...PSS.Hei5.PSSHei5AwardPage"))

function WinterFestival2025AwardPage:getUIName()
	return "WinterFestival2025AwardPage"
end

function WinterFestival2025AwardPage:initTplVar()
	self.btnAllTip = "winter_cruise_btn_all"

	return
end

function WinterFestival2025AwardPage:UpdateAwardInfo(arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3.id < 10 then
		setText(arg_3_2:Find("Text"), "0" .. arg_3_3.id)
	else
		setText(arg_3_2:Find("Text"), arg_3_3.id)
	end

	local var_3_0 = arg_3_3.pt <= self.pt
	local var_3_1 = Drop.Create(arg_3_3.award)

	onButton(self, arg_3_2:Find("base"), function()
		self:emit(BaseUI.ON_NEW_STYLE_DROP, {
			drop = var_3_1
		})

		return
	end, SFX_CONFIRM)
	setActive(arg_3_2:Find("base/lock"), not var_3_0)
	updateDrop(arg_3_2:Find("base/mask/IconTpl"), var_3_1)
	setActive(arg_3_2:Find("base/get"), var_3_0 and not self.awardDic[arg_3_3.pt])
	setActive(arg_3_2:Find("base/got"), self.awardDic[arg_3_3.pt])

	local var_3_2 = Drop.Create(arg_3_3.award_pay)

	onButton(self, arg_3_2:Find("pay"), function()
		self:emit(BaseUI.ON_NEW_STYLE_DROP, {
			drop = var_3_2
		})

		return
	end, SFX_CONFIRM)
	updateDrop(arg_3_2:Find("pay/mask/IconTpl"), var_3_2)
	setActive(arg_3_2:Find("pay/no_pay"), not var_3_0 or not self.isPay)
	setActive(arg_3_2:Find("pay/get"), self.isPay and var_3_0 and not self.awardPayDic[arg_3_3.pt])
	setActive(arg_3_2:Find("pay/got"), self.awardPayDic[arg_3_3.pt])

	return
end

return WinterFestival2025AwardPage
