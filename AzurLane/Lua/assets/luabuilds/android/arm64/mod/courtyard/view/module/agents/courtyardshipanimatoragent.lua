class = var_0_10000

local var_0_0 = "CourtYardShipAnimatorAgent"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".CourtYardAgent"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.name = nil

	return
end

function var_0_1.State2AnimationName(arg_2_0, arg_2_1)
	CourtYardShip = var_1_10002

	if arg_2_1 ~= var_1_10002.STATE_IDLE then
		CourtYardShip = var_2

		if arg_2_1 == var_2.STATE_STOP then
			return "stand2"
		else
			CourtYardShip = var_2

			if arg_2_1 == var_2.STATE_MOVE then
				return "walk"
			else
				CourtYardShip = var_2

				if arg_2_1 == var_2.STATE_DRAG then
					return "tuozhuai2"
				else
					CourtYardShip = var_2

					if arg_2_1 == var_2.STATE_TOUCH then
						return "touch"
					else
						CourtYardShip = var_2

						if arg_2_1 == var_2.STATE_GETAWARD then
							return "motou"
						else
							CourtYardShip = var_2

							if arg_2_1 == var_2.STATE_INTERACT then
								-- block empty
							end
						end
					end
				end
			end
		end

		return
	end
end

function var_0_1.SetState(arg_3_0, arg_3_1)
	arg_3_0:RemoveAnimFinishTimer()

	if not arg_3_0:State2AnimationName(arg_3_1) or arg_3_0.name == var_2 then
		return
	end

	arg_3_0:PlayAction(var_2, function()
		local var_4_0 = arg_3_0

		var_0.OnAnimtionFinish(var_4_0, arg_3_1)

		return
	end)

	return
end

function var_0_1.PlayInteractioAnim(arg_5_0, arg_5_1)
	arg_5_0:PlayAction(arg_5_1, function()
		local var_6_0 = arg_5_0
		local var_6_1 = var_0.OnAnimtionFinish

		CourtYardShip = var_2_10003

		var_6_1(var_6_0, var_2_10003.STATE_INTERACT)

		return
	end)
	arg_5_0:CheckMissTagAction(arg_5_1)

	return
end

function var_0_1.PlayAction(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:RemoveAnimFinishTimer()

	local var_7_0 = arg_7_0.spineAnimUI

	var_3.SetActionCallBack(var_7_0, nil)

	local function var_7_1(arg_8_0)
		if arg_8_0 == "finish" then
			local var_8_0 = arg_7_0.spineAnimUI

			var_1.SetActionCallBack(var_8_0, nil)
			arg_7_2()
		end

		return
	end

	local var_7_2 = arg_7_0.spineAnimUI

	var_4.SetActionCallBack(var_7_2, var_7_1)

	local var_7_3 = arg_7_0._role

	var_4.SetAction(var_7_3, arg_7_1)

	arg_7_0.name = arg_7_1

	return
end

function var_0_1.CheckMissTagAction(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.data
	local var_9_1 = var_2.GetInterActionData(var_9_0)

	pg = var_1_10003

	if var_1_10003.furniture_specail_action[var_9_1:GetOwner().configId] then
		_ = var_4

		if var_4.detect(var_3.actions, function(arg_10_0)
			return arg_10_0[1] == arg_9_1
		end) then
			arg_9_0:AddAnimFinishTimer(var_4[2])
		end
	end

	return
end

function var_0_1.AddAnimFinishTimer(arg_11_0, arg_11_1)
	Timer = var_1_10002
	arg_11_0.animFinishTimer = var_1_10002.New(function()
		local var_12_0 = arg_11_0.animFinishTimer

		var_0.Stop(var_12_0)

		arg_11_0.animFinishTimer = nil

		local var_12_1 = arg_11_0
		local var_12_2 = var_0.OnAnimtionFinish

		CourtYardShip = var_2_10003

		var_12_2(var_12_1, var_2_10003.STATE_INTERACT)

		return
	end, arg_11_1, 1)

	local var_11_0 = arg_11_0.animFinishTimer

	var_2.Start(var_11_0)

	return
end

function var_0_1.RemoveAnimFinishTimer(arg_13_0)
	if arg_13_0.animFinishTimer then
		local var_13_0 = arg_13_0.animFinishTimer

		var_1.Stop(var_13_0)

		arg_13_0.animFinishTimer = nil
	end

	return
end

function var_0_1.Dispose(arg_14_0)
	arg_14_0:RemoveAnimFinishTimer()
	var_0_1.super.Dispose(arg_14_0)

	local var_14_0 = arg_14_0.spineAnimUI

	var_1.SetActionCallBack(var_14_0, nil)

	return
end

return var_0_1
