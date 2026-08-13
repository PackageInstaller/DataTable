class = var_0_10000

local var_0_0 = "AEBCSPtPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CorePtTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD/task_bg")

	local var_1_1 = arg_1_0.bg

	arg_1_0.progress = var_1.Find(var_1_1, "progress")

	local var_1_2 = arg_1_0.bg

	arg_1_0.progres = var_1.Find(var_1_2, "progres")

	local var_1_3 = arg_1_0.bg

	arg_1_0.slider = var_1.Find(var_1_3, "slider")

	local var_1_4 = arg_1_0.bg

	arg_1_0.step = var_1.Find(var_1_4, "step")

	local var_1_5 = arg_1_0.bg

	arg_1_0.displayBtn = var_1.Find(var_1_5, "display_btn")

	local var_1_6 = arg_1_0.bg

	arg_1_0.awardTF = var_1.Find(var_1_6, "award")

	local var_1_7 = arg_1_0.bg

	arg_1_0.getBtn = var_1.Find(var_1_7, "get_btn")

	local var_1_8 = arg_1_0.bg

	arg_1_0.gotBtn = var_1.Find(var_1_8, "got_btn")

	local var_1_9 = arg_1_0.bg

	arg_1_0.battleBtn = var_1.Find(var_1_9, "battle_btn")
	setText = var_1

	local var_1_10 = arg_1_0.displayBtn
	local var_1_11 = var_2.Find(var_1_10, "Text")

	i18n = var_1_10

	var_1(var_1_11, var_1_10("other_world_temple_award"))

	setText = var_1

	local var_1_12 = arg_1_0.bg
	local var_1_13 = var_2.Find(var_1_12, "Text")

	i18n = var_1_12

	var_1(var_1_13, var_1_12("Outpost_20250904_Progress"))

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	arg_2_0.super.OnFirstFlush(arg_2_0)

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.battleBtn

	local function var_2_2()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_3_1(var_3_0, var_2_10002.SPECIAL_BATTLE_OPERA)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_0, var_2_1, var_2_2, var_1_10005)

	return
end

function var_0_1.OnUpdateFlush(arg_4_0)
	var_0_1.super.OnUpdateFlush(arg_4_0)

	local var_4_0 = arg_4_0.ptData
	local var_4_1, var_4_2, var_4_3 = var_1.GetResProgress(var_4_0)

	setText = var_1_10004

	var_1_10004(arg_4_0.progress, "/" .. var_4_2)

	setText = var_1_10004

	local var_4_4 = arg_4_0.progres

	if 1 <= var_4_3 then
		setColorStr = var_6

		local var_4_5

		if not var_6(var_4_1, "#6ef0ff") then
			var_4_5 = var_4_1
		end

		var_1_10004(var_4_4, var_4_5)

		return
	end
end

return var_0_1
