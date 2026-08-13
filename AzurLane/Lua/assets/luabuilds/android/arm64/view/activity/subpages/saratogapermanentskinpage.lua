class = var_0_10000

local var_0_0 = "SaratogaPermanentSkinPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PtTemplatePage"))

function var_0_1.OnUpdateFlush(arg_1_0)
	var_0_1.super.OnUpdateFlush(arg_1_0)

	onButton = var_1

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.battleBtn

	local function var_1_2()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_2_1(var_2_0, var_2_10003.SPECIAL_BATTLE_OPERA)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_1_0, var_1_1, var_1_2, var_1_10006)

	local var_1_3 = arg_1_0.ptData
	local var_1_4, var_1_5, var_1_6 = var_1.GetResProgress(var_1_3)

	setText = var_1_1

	local var_1_7 = arg_1_0.progress

	setColorStr = var_1_10007

	var_1_1(var_1_7, var_1_10007(var_1_4, "#FF8DB5") .. "/" .. var_1_5)

	setText = var_1_1

	local var_1_8 = arg_1_0.bg
	local var_1_9 = var_6.Find(var_1_8, "Text")

	i18n = var_7

	var_1_1(var_1_9, var_7("activity_kill"))

	return
end

return var_0_1
