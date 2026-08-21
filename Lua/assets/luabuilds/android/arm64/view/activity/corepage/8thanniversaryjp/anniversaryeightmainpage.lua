local var_0_0 = class("AnniversaryEightMainPage", import("view.activity.CorePage.CoreActivityPage"))

function var_0_0.OnInit(arg_1_0)
	return
end

function var_0_0.OnDataSetting(arg_2_0)
	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	onButton(arg_3_0, findTF(arg_3_0._tf, "AD/btn_act"), function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.CITY_REBUILD_MAP)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, findTF(arg_3_0._tf, "AD/btn_hotspring"), function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.EIGHTH_HOTSPRING)

		return
	end, SFX_PANEL)
	setText(findTF(arg_3_0._tf, "AD/desc"), i18n("anniversary_eight_main_page_desc"))

	if CityRebuildBookLayer.ShouldShowTip() or CityRebuildTasksLayer.ShouldShowTip() then
		setActive(findTF(arg_3_0._tf, "AD/btn_act/red"), true)
	else
		setActive(findTF(arg_3_0._tf, "AD/btn_act/red"), false)
	end

	return
end

function var_0_0.OnUpdateFlush(arg_6_0)
	return
end

return var_0_0
