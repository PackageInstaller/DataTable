local WinterFestival2025CoreActivityUI = class("WinterFestival2025CoreActivityUI", import("view.activity.CorePage.CoreAdaptActivityMainScene"))

function WinterFestival2025CoreActivityUI:getUIName()
	return "WinterFestival2025CoreActivityUI"
end

function WinterFestival2025CoreActivityUI:GetButtonNameText(arg_2_1)
	local var_2_0 = arg_2_1:getConfig("type")

	if var_2_0 == ActivityConst.ACTIVITY_TYPE_TASK_POOL or var_2_0 == ActivityConst.ACTIVITY_TYPE_SHRINE then
		return i18n(arg_2_1:getConfig("title_res_tag"))
	end

	if var_2_0 == ActivityConst.ACTIVITY_TYPE_PT_HEI5 then
		return i18n("general_activity_side_bar2")
	end

	return (i18n("general_activity_side_bar" .. arg_2_1:getConfig("is_show")))
end

function WinterFestival2025CoreActivityUI:didEnter()
	WinterFestival2025CoreActivityUI.super.didEnter(self)

	if self.contextData.actID then
		self:verifyTabs(self.contextData.actID)
	end

	return
end

function WinterFestival2025CoreActivityUI:CustomInit()
	setText(self._tf:Find("adapt/TopPage/top/deco/Text"), i18n("HelenaCoreActivity_title"))
	setText(self._tf:Find("adapt/TopPage/top/deco/Text/Text_1"), i18n("HelenaCoreActivity_title2"))

	return
end

function WinterFestival2025CoreActivityUI:selectActivity(arg_5_1)
	WinterFestival2025CoreActivityUI.super.selectActivity(self, arg_5_1)

	local var_5_0 = arg_5_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_SHRINE

	SetActive(self._tf:Find("adapt/bg"), not var_5_0)
	SetActive(self._tf:Find("adapt/bg_1"), not var_5_0)
	SetActive(self._tf:Find("adapt/bg_shrine"), var_5_0)
	SetActive(self._tf:Find("adapt/bg_shrine_1"), var_5_0)

	return
end

return WinterFestival2025CoreActivityUI
