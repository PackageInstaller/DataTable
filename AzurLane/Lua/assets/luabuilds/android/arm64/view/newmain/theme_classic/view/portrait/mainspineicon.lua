class = var_0_10000

local var_0_0 = "MainSpineIcon"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainBaseIcon"))

function var_0_1.Resume(arg_1_0)
	if arg_1_0.spineChar then
		local var_1_0 = arg_1_0.spineChar

		var_1.Resume(var_1_0)
	end

	return
end

function var_0_1.Pause(arg_2_0)
	if arg_2_0.spineChar then
		local var_2_0 = arg_2_0.spineChar

		if var_1.GetPauseStatue(var_2_0) ~= nil then
			IsNil = var_1

			local var_2_1 = arg_2_0.spineChar

			if not var_1(var_3.GetAnimationState(var_2_1)) then
				local var_2_2 = arg_2_0.spineChar

				var_1.Pause(var_2_2)
			end
		end
	end

	return
end

function var_0_1.Load(arg_3_0, arg_3_1)
	arg_3_0.loading = true
	SpineAnimChar = var_2
	arg_3_0.spineChar = var_2.New()

	local var_3_0 = arg_3_0.spineChar

	var_2.SetPaint(var_3_0, arg_3_1)

	local var_3_1 = arg_3_0.spineChar

	var_2.Load(var_3_1, true, function(arg_4_0)
		if arg_3_0.exited then
			local var_4_0 = arg_3_0

			var_1.Unload(var_4_0)

			return
		end

		arg_3_0.loading = false

		local var_4_1 = arg_3_0

		var_4_1.shipModel = arg_4_0:GetModel()
		LeanTween = var_4_1

		var_4_1.cancel(arg_3_0.shipModel)
		arg_4_0:SetNormalAction("normal")
		arg_4_0:SetAction("normal", 0)

		local var_4_2 = arg_4_0
		local var_4_3 = arg_4_0.SetLocalScale

		Vector3 = var_4

		var_4_3(var_4_2, var_4(0.75, 0.75, 1))

		pg = var_4_3

		local var_4_4

		if not var_4_3.ship_spine_shift[arg_3_1] or not var_1.mainui_shift[1] then
			var_4_4 = 0
		end

		local var_4_5

		if not var_1 or not var_1.mainui_shift[2] then
			var_4_5 = 0
		end

		local var_4_6 = -130 + var_4_5

		arg_4_0:SetParent(arg_3_0._tf)

		local var_4_7 = arg_4_0
		local var_4_8 = arg_4_0.SetLocalPosition

		Vector3 = var_7

		var_4_8(var_4_7, var_7(var_4_4, var_4_6, 0))

		onNextTick = var_4_8

		var_4_8(function()
			local var_5_0 = arg_4_0

			var_0.Resume(var_5_0)

			return
		end)

		return
	end)

	arg_3_0.name = arg_3_1

	return
end

function var_0_1.Unload(arg_6_0)
	if arg_6_0.spineChar then
		local var_6_0 = arg_6_0.spineChar

		var_1.Resume(var_6_0)

		local var_6_1 = arg_6_0.spineChar

		var_1.Dispose(var_6_1)

		arg_6_0.spineChar = nil
	end

	arg_6_0.name = nil
	arg_6_0.shipModel = nil
	arg_6_0.spineAnim = nil

	return
end

return var_0_1
