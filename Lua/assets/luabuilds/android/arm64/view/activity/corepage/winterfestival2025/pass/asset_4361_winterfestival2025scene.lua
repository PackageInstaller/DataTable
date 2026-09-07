local WinterFestival2025Scene = class("WinterFestival2025Scene", import("...PSS.Hei5.PSSHei5Scene"))

function WinterFestival2025Scene:getUIName()
	return "WinterFestival2025UI"
end

function WinterFestival2025Scene:initTplVar()
	self.helpBtnTip = "battlepass_main_help_1211"
	self.awardPageCls = WinterFestival2025AwardPage
	self.taskPageCls = WinterFestival2025TaskPage
	self.chargePageCls = WinterFestival2025CruiseChargePage
	self.dayTextTip = "winter_battlepass_main_time_title"
	self.titleTextTip = "winter_cruise_title_1211"
	self.rewardTip = "winter_battlepass_rewards"
	self.missionTip = "winter_battlepass_mission"

	setText(self._tf:Find("frame/phase/btn_pay/Text"), i18n("winter_cruise_btn_pay"))
	setText(self._tf:Find("frame/phase/AwardTipText"), i18n("winter_cruise_pay_reward"))

	return
end

return WinterFestival2025Scene
