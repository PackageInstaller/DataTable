class = var_0_10000

local var_0_0 = "EffectLaser"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.miniGame.gameView.RyzaMiniGame.effect.TargetEffect"))

function var_0_1.GetBaseOrder(arg_1_0)
	if arg_1_0.mark == "N" then
		return var_0_1.super.GetBaseOrder(arg_1_0)
	else
		return 500
	end

	return
end

function var_0_1.InitUI(arg_2_0, arg_2_1)
	arg_2_0.mark = arg_2_1.mark

	arg_2_0:UpdatePos(arg_2_0.pos)

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_2.Find(var_2_0, "scale/" .. arg_2_0.mark)

	setActive = var_1_10003

	var_1_10003(var_2_1, true)

	local var_2_2 = var_2_1:Find("base")
	local var_2_3 = var_3.GetComponent

	typeof = var_6
	DftAniEvent = var_1_10008

	local var_2_4 = var_2_3(var_2_2, var_6(var_1_10008))

	var_3.SetEndEvent(var_2_4, function()
		local var_3_0 = arg_2_0

		var_0.Destroy(var_3_0)

		return
	end)

	local var_2_5 = arg_2_0.responder

	if var_4.CollideRyza(var_2_5, arg_2_0) then
		local var_2_6 = arg_2_0
		local var_2_7 = arg_2_0.Calling
		local var_2_8 = "hit"
		local var_2_9 = {
			1,
			arg_2_0.realPos
		}

		MoveRyza = var_9

		var_2_7(var_2_6, var_2_8, var_2_9, var_9)
	end

	return
end

function var_0_1.GetCollideRange(arg_4_0)
	local var_4_0

	switch = var_1_10002

	var_1_10002(arg_4_0.mark, {
		N = function()
			var_4_0 = {
				{
					-0.5,
					0.5
				},
				{
					-25,
					-0.5
				}
			}

			return
		end,
		S = function()
			var_4_0 = {
				{
					-0.5,
					0.5
				},
				{
					0.5,
					25
				}
			}

			return
		end,
		W = function()
			var_4_0 = {
				{
					-25,
					-0.5
				},
				{
					-0.5,
					0.5
				}
			}

			return
		end,
		E = function()
			var_4_0 = {
				{
					0.5,
					25
				},
				{
					-0.5,
					0.5
				}
			}

			return
		end
	})

	return {
		var_4_0
	}
end

return var_0_1
