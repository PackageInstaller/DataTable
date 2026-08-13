class = var_0_10000

local var_0_0 = "ShanchengPTOilPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PtTemplatePage"))

function var_0_1.OnFirstFlush(arg_1_0)
	var_0_1.super.OnFirstFlush(arg_1_0)

	local var_1_0 = var_0_1
	local var_1_1 = arg_1_0.awardTF

	var_1_0.scrolltext = var_2.Find(var_1_1, "name")

	return
end

function var_0_1.OnUpdateFlush(arg_2_0)
	var_0_1.super.OnUpdateFlush(arg_2_0)

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.battleBtn

	local function var_2_2()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_3_1(var_3_0, var_2_10003.SPECIAL_BATTLE_OPERA)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_0, var_2_1, var_2_2, var_1_10006)
	arg_2_0:SetAwardName()

	local var_2_3 = arg_2_0.ptData
	local var_2_4, var_2_5, var_2_6 = var_1.GetResProgress(var_2_3)

	setText = var_2_1

	local var_2_7 = arg_2_0.progress

	if 1 <= var_2_6 then
		setColorStr = var_7

		local var_2_8

		if not var_7(var_2_4, "#A2A2A2FF") then
			var_2_8 = var_2_4
		end

		var_2_1(var_2_7, var_2_8 .. "/" .. var_2_5)

		return
	end
end

function var_0_1.SetAwardName(arg_4_0)
	local var_4_0 = arg_4_0.ptData
	local var_4_1 = var_1.GetAward(var_4_0)

	Item = var_1_10002

	if var_1_10002.getConfigData(var_4_1.id) then
		changeToScrollText = var_4_0

		var_4_0(var_0_1.scrolltext, var_4_1:getName())
	else
		setActive = var_4_0

		local var_4_2 = arg_4_0.awardTF

		var_4_0(var_5.Find(var_4_2, "name"), false)
	end

	return
end

return var_0_1
