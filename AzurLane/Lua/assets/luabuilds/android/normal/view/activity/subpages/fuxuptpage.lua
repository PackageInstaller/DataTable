class = var_0_10000

local var_0_0 = "FuxuPtPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PtTemplatePage"))

function var_0_1.OnFirstFlush(arg_1_0)
	var_0_1.super.OnFirstFlush(arg_1_0)

	onButton = var_1

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bg
	local var_1_2 = var_3.Find(var_1_1, "build_btn")

	local function var_1_3()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_2_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		local var_2_3 = var_2_10003.GETBOAT
		local var_2_4 = {}

		BuildShipScene = var_2_10005
		var_2_4.projectName = var_2_10005.PROJECTS.HEAVY

		var_2_1(var_2_0, var_2_2, var_2_3, var_2_4)

		return
	end

	SFX_PANEL = var_5

	var_1(var_1_0, var_1_2, var_1_3, var_5)

	return
end

function var_0_1.OnUpdateFlush(arg_3_0)
	var_0_1.super.OnUpdateFlush(arg_3_0)

	local var_3_0 = arg_3_0.ptData
	local var_3_1, var_3_2, var_3_3 = var_1.GetLevelProgress(var_3_0)
	local var_3_4 = arg_3_0.ptData
	local var_3_5, var_3_6, var_3_7 = var_4.GetResProgress(var_3_4)

	setText = var_1_10007

	var_1_10007(arg_3_0.step, var_3_1)

	setText = var_1_10007

	local var_3_8 = arg_3_0.progress

	if 1 <= var_3_7 then
		setColorStr = var_9

		local var_3_9

		if not var_9(var_3_5, "#df9e38") then
			var_3_9 = var_3_5
		end

		var_1_10007(var_3_8, var_3_9 .. "/" .. var_3_6)

		local var_3_10
		local var_3_11
		local var_3_12 = arg_3_0.activity

		if var_9.getConfig(var_3_12, "config_client") ~= "" then
			local var_3_13 = arg_3_0.activity

			if var_3_12.getConfig(var_3_13, "config_client").linkActID then
				getProxy = var_3_12
				ActivityProxy = var_3_13

				local var_3_14 = var_3_12(var_3_13)

				var_3_11 = var_3_12.getActivityById(var_3_14, var_3_10)
			end
		end

		if var_3_10 and not var_3_11 or var_3_11 and var_3_11:isEnd() then
			setActive = var_3_12

			var_3_12(arg_3_0.battleBtn, false)

			setActive = var_3_12

			local var_3_15 = arg_3_0.bg

			var_3_12(var_11.Find(var_3_15, "build_btn"), false)
		end

		return
	end
end

return var_0_1
