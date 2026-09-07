local WinterFestival2025CruiseChargePage = class("WinterFestival2025CruiseChargePage", import("...PSS.Hei5.PSSCruiseChargePage"))

function WinterFestival2025CruiseChargePage:getUIName()
	return "WinterFestival2025CruiseChargePage"
end

function WinterFestival2025CruiseChargePage:initTplVar()
	self.descTip = "winter_battlepass_pay_acquire"
	self.payTip = "winter_battlepass_pay_tip"
	self.tplMaskName = "mask"

	return
end

return WinterFestival2025CruiseChargePage
