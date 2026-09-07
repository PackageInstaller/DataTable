local BlackFridayWithManualSignPageInCH = class("BlackFridayWithManualSignPageInCH", import(".BlackFridayWithManualSignPage"))

function BlackFridayWithManualSignPageInCH:OnInit()
	BlackFridayWithManualSignPageInCH.super.OnInit(self)
	setText(self._tf:Find("AD/signMask/Image/Text"), i18n("challenge_end_tip"))

	return
end

function BlackFridayWithManualSignPageInCH:FlushSignBtn()
	BlackFridayWithManualSignPageInCH.super.FlushSignBtn(self)

	local var_2_0 = getProxy(ActivityProxy):getActivityById(self.signInActId)

	setActive(self._tf:Find("AD/signMask"), not var_2_0 or var_2_0:isEnd())

	return
end

return BlackFridayWithManualSignPageInCH
