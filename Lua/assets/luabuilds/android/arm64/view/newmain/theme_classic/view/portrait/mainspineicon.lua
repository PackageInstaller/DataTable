local var_0_0 = class("MainSpineIcon", import(".MainBaseIcon"))

function var_0_0.Resume(arg_1_0)
	if arg_1_0.spineChar and arg_1_0.spineChar:GetPauseStatue() ~= nil and not IsNil(arg_1_0.spineChar:GetAnimationState()) then
		arg_1_0.spineChar:Resume()
	end

	return
end

function var_0_0.Pause(arg_2_0)
	if arg_2_0.spineChar and arg_2_0.spineChar:GetPauseStatue() ~= nil and not IsNil(arg_2_0.spineChar:GetAnimationState()) then
		arg_2_0.spineChar:Pause()
	end

	return
end

function var_0_0.Load(arg_3_0, arg_3_1)
	arg_3_0.loading = true
	arg_3_0.spineChar = SpineAnimChar.New()

	arg_3_0.spineChar:SetPaint(arg_3_1)
	arg_3_0.spineChar:Load(true, function(arg_4_0)
		if arg_3_0.exited then
			arg_3_0:Unload()

			return
		end

		arg_3_0.loading = false
		arg_3_0.shipModel = arg_4_0:GetModel()

		LeanTween.cancel(arg_3_0.shipModel)
		arg_4_0:SetNormalAction("normal")
		arg_4_0:SetAction("normal", 0)
		arg_4_0:SetLocalScale(Vector3(0.75, 0.75, 1))

		local var_4_0 = pg.ship_spine_shift[arg_3_1]

		if pg.ship_spine_shift[arg_3_1] then
			if var_4_0 then
				local var_4_2 = var_4_0.mainui_shift[2] or 0

				arg_4_0:SetParent(arg_3_0._tf)
				arg_4_0:SetLocalPosition(Vector3(var_4_1, var_4_3, 0))
				onNextTick(function()
					arg_4_0:Resume()

					return
				end)

				return
			end
		end
	end)

	arg_3_0.name = arg_3_1

	return
end

function var_0_0.Unload(arg_6_0)
	if arg_6_0.spineChar then
		arg_6_0.spineChar:Resume()
		arg_6_0.spineChar:Dispose()

		arg_6_0.spineChar = nil
	end

	arg_6_0.name = nil
	arg_6_0.shipModel = nil
	arg_6_0.spineAnim = nil

	return
end

return var_0_0
