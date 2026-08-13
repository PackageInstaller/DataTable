class = var_0_10000

local var_0_0 = "EnemyConductor"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.miniGame.gameView.RyzaMiniGame.character.MoveEnemy"))

var_0_1.ConfigShildList = {
	2,
	0,
	0,
	0
}
var_0_1.BlockRange = 1

local var_0_2 = {
	"S",
	"E",
	"N",
	"W"
}

function var_0_1.InitUI(arg_1_0, arg_1_1)
	underscore = var_1_10002
	arg_1_0.shieldCount = var_1_10002.rest(arg_1_0.ConfigShildList, 1)

	local var_1_0 = {}
	local var_1_1 = arg_1_0.rtScale

	var_1_0.S = var_3.Find(var_1_1, "front/Shield_S")

	local var_1_2 = arg_1_0.rtScale

	var_1_0.E = var_3.Find(var_1_2, "front/Shield_E")

	local var_1_3 = arg_1_0.rtScale

	var_1_0.N = var_3.Find(var_1_3, "back/Shield_N")

	local var_1_4 = arg_1_0.rtScale

	var_1_0.W = var_3.Find(var_1_4, "front/Shield_W")
	arg_1_0.rtShieldDic = var_1_0
	ipairs = var_1_0

	for iter_1_0, iter_1_1 in var_1_0({
		"front",
		"back"
	}) do
		eachChild = var_1_10007

		local var_1_5 = arg_1_0.rtScale

		var_1_10007(var_9.Find(var_1_5, iter_1_1), function(arg_2_0)
			local var_2_0 = arg_2_0:Find("Image")
			local var_2_1 = var_1.GetComponent

			typeof = var_4
			DftAniEvent = var_2_10006

			local var_2_2 = var_2_1(var_2_0, var_4(var_2_10006))

			var_1.SetEndEvent(var_2_2, function()
				setActive = var_3_10000

				local var_3_0 = arg_2_0

				var_3_10000(var_2.Find(var_3_0, "Image"), false)

				setActive = var_3_10000

				var_3_10000(arg_2_0, false)

				setImageAlpha = var_3_10000

				var_3_10000(arg_2_0, 1)

				return
			end)

			local var_2_3 = arg_2_0:Find("Protect")
			local var_2_4 = var_1.GetComponent

			typeof = var_4
			DftAniEvent = var_2_10006

			local var_2_5 = var_2_4(var_2_3, var_4(var_2_10006))

			var_1.SetEndEvent(var_2_5, function()
				setActive = var_3_10000

				local var_4_0 = arg_2_0

				var_3_10000(var_2.Find(var_4_0, "Protect"), false)

				table = var_3_10000

				local var_4_1 = var_3_10000.indexof
				local var_4_2 = var_0_2

				string = var_3

				local var_4_3 = var_4_1(var_4_2, var_3.split(arg_2_0.name, "_")[2])

				table = var_3_10001

				local var_4_4 = (var_4_3 - var_3_10001.indexof(var_0_2, arg_1_0.statusMark) + 4) % 4 + 1

				if arg_1_0.shieldCount[var_4_4] <= 0 then
					setImageAlpha = var_1

					var_1(arg_2_0, 0)

					setActive = var_1

					local var_4_5 = arg_2_0

					var_1(var_3.Find(var_4_5, "Image"), true)
				end

				return
			end)

			return
		end)
	end

	var_0_1.super.InitUI(arg_1_0, arg_1_1)

	local var_1_6

	if not arg_1_1.hp then
		var_1_6 = 2
	end

	arg_1_0.hp = var_1_6
	arg_1_0.hpMax = arg_1_0.hp

	local var_1_7

	if not arg_1_1.speed then
		var_1_7 = 3
	end

	arg_1_0.speed = var_1_7

	return
end

function var_0_1.InitRegister(arg_5_0, arg_5_1)
	var_0_1.super.InitRegister(arg_5_0, arg_5_1)
	arg_5_0:Register("block", function(arg_6_0)
		arg_5_0.shieldCount[arg_6_0] = arg_5_0.shieldCount[arg_6_0] - 1

		local var_6_0 = arg_5_0.rtShieldDic
		local var_6_1 = var_0_2

		table = var_2_10003

		local var_6_2 = var_6_0[var_6_1[(var_2_10003.indexof(var_0_2, arg_5_0.statusMark) + arg_6_0 + 2) % 4 + 1]]

		setActive = var_2

		var_2(var_6_2:Find("Protect"), true)

		return
	end, {})

	return
end

function var_0_1.CheckBlock(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_0.pos.x == arg_7_1.x and arg_7_0.pos.y == arg_7_1.y then
		do return end

		goto label_7_0
	end

	if arg_7_0.pos.x == arg_7_1.x then
		math = var_4

		if var_4.clamp(arg_7_0.pos.y - arg_7_1.y, -arg_7_2[3], arg_7_2[1]) ~= arg_7_0.pos.y - arg_7_1.y then
			if arg_7_0.pos.y == arg_7_1.y then
				math = var_4

				if var_4.clamp(arg_7_0.pos.x - arg_7_1.x, -arg_7_2[4], arg_7_2[2]) == arg_7_0.pos.x - arg_7_1.x then
					local var_7_0
					local var_7_1

					if arg_7_1.x < arg_7_0.pos.x then
						var_7_0 = "W"
					else
						var_7_1 = arg_7_1.x

						if arg_7_0.pos.x < var_7_1 then
							var_7_0 = "E"
						elseif arg_7_1.y < arg_7_0.pos.y then
							var_7_0 = "N"
						else
							var_7_1 = arg_7_1.y

							if arg_7_0.pos.y < var_7_1 then
								var_7_0 = "S"
							else
								assert = var_7_1

								var_7_1(false)
							end
						end
					end

					table = var_7_1

					local var_7_2 = var_7_1.indexof(var_0_2, var_7_0)

					table = var_6

					local var_7_3 = (var_7_2 - var_6.indexof(var_0_2, arg_7_0.statusMark) + 4) % 4 + 1
					local var_7_4 = arg_7_0.shieldCount[var_7_3]

					if 0 < var_7_4 then
						table = var_7_4

						local var_7_5 = (var_7_4.indexof(var_0_2, var_7_0) + 1) % 4 + 1

						math = var_7

						local var_7_6 = var_7.max

						math = var_9

						local var_7_7 = var_9.max

						math = var_1_10011

						local var_7_8 = var_1_10011.abs(arg_7_0.pos.x - arg_7_1.x)

						math = var_1_10012
						arg_7_2[var_7_5] = var_7_6(var_7_7(var_7_8, var_1_10012.abs(arg_7_0.pos.y - arg_7_1.y)) - arg_7_0.BlockRange, 0)
						arg_7_3[var_7_5] = {
							arg_7_0,
							var_7_3
						}
					end
				end
			end

			::label_7_0::

			return
		end
	end
end

function var_0_1.PlayAnim(arg_8_0, arg_8_1)
	var_0_1.super.PlayAnim(arg_8_0, arg_8_1)

	local var_8_0 = arg_8_0.statusMark

	string = var_1_10003

	if var_8_0 ~= var_1_10003.split(arg_8_0.status, "_")[2] then
		string = var_8_0
		arg_8_0.statusMark = var_8_0.split(arg_8_0.status, "_")[2]

		arg_8_0:UpdateShieldDisplay()
	end

	return
end

function var_0_1.UpdateShieldDisplay(arg_9_0)
	table = var_1_10001

	local var_9_0 = var_1_10001.indexof(var_0_2, arg_9_0.statusMark)

	for iter_9_0 = 0, 3 do
		local var_9_1 = arg_9_0.rtShieldDic[var_0_2[(var_9_0 - 1 + iter_9_0) % 4 + 1]]

		eachChild = var_7

		var_7(var_9_1, function(arg_10_0)
			setActive = var_2_10001

			var_2_10001(arg_10_0, false)

			return
		end)

		setImageAlpha = var_7

		var_7(var_9_1, 1)

		setActive = var_7

		var_7(var_9_1, arg_9_0.shieldCount[iter_9_0 + 1] > 0)
	end

	return
end

return var_0_1
