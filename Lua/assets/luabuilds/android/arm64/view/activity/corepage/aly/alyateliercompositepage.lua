local var_0_0 = class("ALYAtelierCompositeRePage", import("view.activity.CorePage.CoreActivityPage"))

function var_0_0.OnInit(arg_1_0)
	setText(arg_1_0._tf:Find("bg/goBtn/Text"), i18n("yumia_atelier_tip24"))
	onButton(arg_1_0, arg_1_0._tf:Find("bg/goBtn"), function()
		arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.ATELIER_COMPOSITE, {
			activityID = 50043,
			versionIndex = 2
		})

		return
	end)

	return
end

return var_0_0
