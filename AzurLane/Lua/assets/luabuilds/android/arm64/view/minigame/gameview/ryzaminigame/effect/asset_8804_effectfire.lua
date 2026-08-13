class = var_0_10000

local var_0_0 = "EffectFire"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.miniGame.gameView.RyzaMiniGame.effect.TargetEffect"))

function var_0_1.GetBaseOrder(arg_1_0)
	return "floor"
end

local var_0_2 = {
	"S",
	"E",
	"N",
	"W"
}

function var_0_1.InitUI(arg_2_0, arg_2_1)
	arg_2_0.power = arg_2_1.power
	eachChild = var_2

	var_2(arg_2_0._tf, function(arg_3_0)
		setActive = var_2_10001

		var_2_10001(arg_3_0, arg_3_0.name == "C")

		return
	end)

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_2.Find(var_2_0, "C/Image")
	local var_2_2 = var_2.GetComponent

	typeof = var_5
	DftAniEvent = var_1_10007

	local var_2_3 = var_2_2(var_2_1, var_5(var_1_10007))

	var_2.SetTriggerEvent(var_2_3, function()
		local var_4_0 = arg_2_0

		defaultValue = var_2_10001
		var_4_0.triggerCount = var_2_10001(arg_2_0.triggerCount, 0) + 1
		switch = var_4_0

		var_4_0(arg_2_0.triggerCount, {
			function()
				local var_5_0 = arg_2_0.responder
				local var_5_1, var_5_2, var_5_3 = var_0.GetCrossFire(var_5_0, arg_2_0.pos, arg_2_0.power)

				ipairs = var_3

				for iter_5_0, iter_5_1 in var_3(var_5_1) do
					local var_5_4 = arg_2_0._tf

					for iter_5_2 = var_8.Find(var_5_4, var_0_2[iter_5_0]).childCount + 1, iter_5_1 do
						cloneTplTo = iter_5_3
						iter_5_3 = iter_5_3(var_8:Find("7"), var_8, iter_5_2)

						if iter_5_0 < 3 then
							iter_5_3:SetAsLastSibling()
						end
					end

					local var_5_5 = var_8.childCount

					for iter_5_3 = 1, var_5_5 do
						setActive = var_3_10014

						var_3_10014(var_8:Find(iter_5_3), iter_5_3 <= iter_5_1)
					end

					setActive = var_10

					var_10(var_8, true)
				end

				local var_5_6 = arg_2_0

				var_3.Calling(var_5_6, "burn", {}, var_5_2)

				arg_2_0.lenList = var_5_1

				local var_5_7 = arg_2_0

				var_3.Register(var_5_7, "move", function(arg_6_0)
					local var_6_0 = arg_2_0

					var_1.Calling(var_6_0, "burn", {}, arg_6_0)

					return
				end, var_5_2)

				pairs = var_3

				for iter_5_4, iter_5_5 in var_3(var_5_3) do
					local var_5_8 = arg_2_0

					var_8.Calling(var_5_8, "block", {
						iter_5_5[2]
					}, iter_5_5[1])
				end

				return
			end,
			function()
				arg_2_0.lenList = nil

				local var_7_0 = arg_2_0

				var_0.Deregister(var_7_0, "move")

				return
			end
		})

		return
	end)
	var_2:SetEndEvent(function()
		local var_8_0 = arg_2_0

		var_0.Destroy(var_8_0)

		return
	end)

	pg = var_3

	local var_2_4 = var_3.CriMgr.GetInstance()

	var_3.PlaySoundEffect_V3(var_2_4, "ui-ryza-minigame-bomb")

	return
end

function var_0_1.GetCollideRange(arg_9_0)
	if arg_9_0.lenList then
		return {
			{
				{
					-0.5 - arg_9_0.lenList[4],
					0.5 + arg_9_0.lenList[2]
				},
				{
					-0.5,
					0.5
				}
			},
			{
				{
					-0.5,
					0.5
				},
				{
					-0.5 - arg_9_0.lenList[3],
					0.5 + arg_9_0.lenList[1]
				}
			}
		}
	else
		return {}
	end

	return
end

return var_0_1
