local EighthAnniversaryJpCoreActivityUI = class("EighthAnniversaryJpCoreActivityUI", import("view.activity.CorePage.CoreAdaptActivityMainScene"))

function EighthAnniversaryJpCoreActivityUI:getUIName()
	return "AnniversaryEightCoreActivityUI"
end

EighthAnniversaryJpCoreActivityUI.optionsPath = {
	"adapt/TopPage/top/btn_home"
}

function EighthAnniversaryJpCoreActivityUI:CustomInit()
	quickPlayAnimation(self._tf:Find("adapt/TopPage/top"), "Anim_SecretsAbyssCoreActivityUI_top_In")
	setText(self._tf:Find("adapt/TopPage/top/deco/Text"), i18n("activity_ninjia_main_title"))
	setText(self._tf:Find("adapt/TopPage/top/deco/Text/Text_1"), i18n("activity_ninjia_main_title_en"))

	return
end

function EighthAnniversaryJpCoreActivityUI:GetButtonNameText(arg_3_1)
	return i18n(string.format("activity_ninjia_main_sheet%s", arg_3_1:getConfig("is_show")))
end

function EighthAnniversaryJpCoreActivityUI:OnClickBtn(arg_4_1, arg_4_2)
	quickPlayAnimation(arg_4_1, "Anim_SecretsAbyssCoreActivityUI_tabs_on_In")

	return
end

return EighthAnniversaryJpCoreActivityUI
