local SpecialWeaponActPage = class("SpecialWeaponActPage", import(".LevelOpenActPage"))

function SpecialWeaponActPage:OnInit()
	SpecialWeaponActPage.super.OnInit(self)
	setText(self._tf:Find("AD/task_list/content/tpl/status/got/Text"), i18n("word_status_inEventFinished"))
	setText(self._tf:Find("AD/tips/Text"), i18n("spweapon_activity_ui_text1"))
	setText(self._tf:Find("AD/tips/Text (1)"), i18n("spweapon_activity_ui_text2"))

	return
end

function SpecialWeaponActPage:UpdateTask(arg_2_1, arg_2_2)
	SpecialWeaponActPage.super.UpdateTask(self, arg_2_1, arg_2_2)

	local var_2_0 = arg_2_2:getTaskStatus()
	local var_2_1 = arg_2_1:Find("canvas")

	setCanvasGroupAlpha(var_2_1, 1)
	setActive(arg_2_1:Find("mask"), var_2_0 == 2)

	local var_2_2 = arg_2_2:getConfig("desc")

	if var_2_0 == 2 then
		setSlider(var_2_1:Find("progress"), 0, 1, 1)
	else
		local var_2_3 = arg_2_2:getProgress()
		local var_2_4 = arg_2_2:getConfig("target_num")

		var_2_2 = var_2_2 .. " " .. setColorStr("(" .. var_2_3 .. "/" .. var_2_4 .. ")", "#FFD585FF")

		setSlider(var_2_1:Find("progress"), 0, var_2_4, var_2_3)
	end

	setText(arg_2_1:Find("canvas/Text"), var_2_2)

	return
end

return SpecialWeaponActPage
