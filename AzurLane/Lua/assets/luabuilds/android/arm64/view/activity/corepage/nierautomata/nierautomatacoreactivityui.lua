local var_0_0 = class("NieRAutomataCoreActivityUI", import("view.activity.CorePage.CoreAdaptActivityMainScene"))

function var_0_0.getUIName(arg_1_0)
	return "NieRAutomataCoreActivityUI"
end

var_0_0.optionsPath = {
	"adapt/TopPage/top/btn_home"
}

function var_0_0.CustomInit(arg_2_0)
	arg_2_0.resTime = arg_2_0._tf:Find("adapt/TopPage/top/time/Text")

	setActive(arg_2_0.upper, true)
	onButton(arg_2_0, arg_2_0._tf:Find("adapt/shopbtn"), function()
		arg_2_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.GetButtonNameText(arg_4_0, arg_4_1)
	return i18n((arg_4_1:getConfig("title_res_tag")))
end

function var_0_0.OnClickBtn(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:refreshTime((getProxy(ActivityProxy):getActivityById(arg_5_2)))

	return
end

function var_0_0.refreshTime(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.stopTime - pg.TimeMgr.GetInstance():GetServerTime()

	setText(arg_6_0.resTime, i18n("nier_core_countdown", math.floor(var_6_0 / 0), math.floor(var_6_0 % 0 / 16)))

	return
end

function var_0_0.UpdateAdapt(arg_7_0)
	var_0_0.super.UpdateAdapt(arg_7_0)

	return
end

return var_0_0
