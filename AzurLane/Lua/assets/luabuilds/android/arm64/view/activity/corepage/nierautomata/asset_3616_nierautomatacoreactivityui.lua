class = var_0_10000

local var_0_0 = "NieRAutomataCoreActivityUI"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreAdaptActivityMainScene"))

function var_0_1.getUIName(arg_1_0)
	return "NieRAutomataCoreActivityUI"
end

var_0_1.optionsPath = {
	"adapt/TopPage/top/btn_home"
}

function var_0_1.CustomInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.resTime = var_1.Find(var_2_0, "adapt/TopPage/top/time/Text")
	setActive = var_1

	var_1(arg_2_0.upper, true)

	onButton = var_1

	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_4.Find(var_2_2, "adapt/shopbtn")

	local function var_2_4()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_3_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_3_1(var_3_0, var_3_2, var_2_10004.SKINSHOP)

		return
	end

	SFX_PANEL = var_2_2

	var_1(var_2_1, var_2_3, var_2_4, var_2_2)

	return
end

function var_0_1.GetButtonNameText(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getConfig("title_res_tag")

	i18n = var_1_10003

	return var_1_10003(var_4_0)
end

function var_0_1.OnClickBtn(arg_5_0, arg_5_1, arg_5_2)
	getProxy = var_1_10003
	ActivityProxy = var_1_10005

	local var_5_0 = var_1_10003(var_1_10005)
	local var_5_1 = var_3.getActivityById(var_5_0, arg_5_2)

	arg_5_0:refreshTime(var_5_1)

	return
end

function var_0_1.refreshTime(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.stopTime

	pg = var_1_10003

	local var_6_1 = var_1_10003.TimeMgr.GetInstance()
	local var_6_2 = var_6_0 - var_3.GetServerTime(var_6_1)

	setText = var_3

	local var_6_3 = arg_6_0.resTime

	i18n = var_1_10006

	local var_6_4 = "nier_core_countdown"

	math = var_1_10009

	local var_6_5 = var_1_10009.floor(var_6_2 / 0)

	math = var_1_10010

	var_3(var_6_3, var_1_10006(var_6_4, var_6_5, var_1_10010.floor(var_6_2 % 0 / 16)))

	return
end

function var_0_1.UpdateAdapt(arg_7_0)
	var_0_1.super.UpdateAdapt(arg_7_0)

	return
end

return var_0_1
