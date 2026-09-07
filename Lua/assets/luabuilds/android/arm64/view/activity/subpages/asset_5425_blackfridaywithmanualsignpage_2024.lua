local BlackFridayWithManualSignPage_2024 = class("BlackFridayWithManualSignPage_2024", import(".BlackFridayWithManualSignPage"))

function BlackFridayWithManualSignPage_2024:OnInit()
	BlackFridayWithManualSignPage_2024.super.OnInit(self)
	setActive(self.shopBtn, false)
	setText(self._tf:Find("AD/signMask/Image/Text"), i18n("challenge_end_tip"))

	return
end

function BlackFridayWithManualSignPage_2024:FlushSignBtn()
	BlackFridayWithManualSignPage_2024.super.FlushSignBtn(self)

	local var_2_0 = getProxy(ActivityProxy):getActivityById(self.signInActId)

	setActive(self._tf:Find("AD/signMask"), not var_2_0 or var_2_0:isEnd())

	return
end

return BlackFridayWithManualSignPage_2024
