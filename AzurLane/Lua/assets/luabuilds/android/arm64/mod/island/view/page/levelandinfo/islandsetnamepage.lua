class = var_0_10000

local var_0_0 = "IslandSetNamePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandEditNamePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandNewNameUI"
end

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.OnLoaded(arg_2_0)

	setText = var_1

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_3.Find(var_2_0, "frame/title")

	i18n = var_1_10004

	var_1(var_2_1, var_1_10004("island_rename_subtitle"))

	setActive = var_1

	var_1(arg_2_0.closeBtn, false)

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.confirmBtn

	local function var_3_2()
		getInputText = var_2_10000

		local var_4_0 = var_2_10000(arg_3_0.input)
		local var_4_1 = arg_3_0
		local var_4_2 = var_1.emit

		IslandMediator = var_2_10004

		var_4_2(var_4_1, var_2_10004.SET_NAME, var_4_0, 2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	return
end

function var_0_1.UpdateContent(arg_5_0)
	setText = var_1_10001

	var_1_10001(arg_5_0.content, "")

	return
end

return var_0_1
