class = var_0_10000

local var_0_0 = "SpringFestivalMainPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PreviewTemplatePage"))
local var_0_2 = {
	2,
	3,
	4,
	8,
	9,
	10,
	14,
	15,
	17,
	18
}
local var_0_3 = 1
local var_0_4 = 3.5

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0._tf

	arg_1_0.rtPrint = var_1.Find(var_1_0, "AD/print")

	local var_1_1 = {}
	local var_1_2 = arg_1_0.rtPrint

	var_1_1[1] = var_2.Find(var_1_2, "front")

	local var_1_3 = arg_1_0.rtPrint

	var_1_1[2] = var_2.Find(var_1_3, "back")
	arg_1_0.prints = var_1_1

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.btnList
	local var_2_2 = var_4.Find(var_2_1, "mountain")

	local function var_2_3()
		pg = var_2_10000

		local var_3_0 = var_2_10000.m02
		local var_3_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_3_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_3_1(var_3_0, var_3_2, var_2_10004.SPRING_FESTIVAL_BACKHILL_2023)

		return
	end

	SFX_PANEL = var_2_1

	var_1(var_2_0, var_2_2, var_2_3, var_2_1)

	arg_2_0.printCount = 0
	setImageAlpha = var_1

	var_1(arg_2_0.prints[1], 0)

	setImageAlpha = var_1

	var_1(arg_2_0.prints[2], 0)

	return
end

function var_0_1.OnUpdateFlush(arg_4_0)
	if arg_4_0.LT then
		ipairs = var_1

		for iter_4_0, iter_4_1 in var_1(arg_4_0.LT) do
			LeanTween = var_1_10006

			var_1_10006.resume(iter_4_1)
		end
	else
		arg_4_0.tempImg = nil

		local var_4_0 = true
		local var_4_1

		local function var_4_2()
			local var_5_0 = arg_4_0

			var_5_0.LT = {}
			parallelAsync = var_5_0

			var_5_0({
				function(arg_6_0)
					local var_6_0 = arg_4_0

					var_6_0.printCount = arg_4_0.printCount % #var_0_2 + 1
					LoadSpriteAtlasAsync = var_6_0

					var_6_0("clutter/springfestivalmainpage_" .. var_0_2[arg_4_0.printCount], nil, function(arg_7_0)
						IsNil = var_4_10001

						if var_4_10001(arg_4_0.rtPrint) then
							return
						else
							arg_4_0.tempImg = arg_7_0

							arg_6_0()
						end

						return
					end)

					return
				end,
				function(arg_8_0)
					table = var_3_10001

					local var_8_0 = var_3_10001.insert
					local var_8_1 = arg_4_0.LT

					LeanTween = var_3_10004

					local var_8_2 = var_3_10004.alpha(arg_4_0.prints[1], 0, var_0_3)
					local var_8_3 = var_4.setOnComplete

					System = var_7

					local var_8_4 = var_8_3(var_8_2, var_7.Action(arg_8_0))

					var_8_0(var_8_1, var_4.setDelay(var_8_4, var_4_0 and 0 or var_0_4).uniqueId)

					return
				end,
				function(arg_9_0)
					table = var_3_10001

					local var_9_0 = var_3_10001.insert
					local var_9_1 = arg_4_0.LT

					LeanTween = var_3_10004

					local var_9_2 = var_3_10004.alpha(arg_4_0.prints[2], 1, var_0_3)
					local var_9_3 = var_4.setOnComplete

					System = var_7

					local var_9_4 = var_9_3(var_9_2, var_7.Action(arg_9_0))

					var_9_0(var_9_1, var_4.setDelay(var_9_4, var_4_0 and 0 or var_0_4).uniqueId)

					return
				end
			}, function()
				var_4_0 = false

				local var_10_0 = arg_4_0.prints

				var_10_0[2], arg_4_0.prints[1] = arg_4_0.prints[1], arg_4_0.prints[2]
				setImageSprite = var_10_0

				var_10_0(arg_4_0.prints[2], arg_4_0.tempImg, true)
				var_4_2()

				return
			end)

			return
		end

		seriesAsync = var_1_10003

		var_1_10003({
			function(arg_11_0)
				local var_11_0 = arg_4_0

				var_11_0.printCount = arg_4_0.printCount % #var_0_2 + 1
				LoadSpriteAtlasAsync = var_11_0

				var_11_0("clutter/springfestivalmainpage_" .. var_0_2[arg_4_0.printCount], nil, function(arg_12_0)
					IsNil = var_3_10001

					if var_3_10001(arg_4_0.rtPrint) then
						return
					else
						setImageSprite = var_1

						var_1(arg_4_0.prints[2], arg_12_0, true)
						arg_11_0()
					end

					return
				end)

				return
			end
		}, var_4_2)
	end

	return
end

function var_0_1.OnHideFlush(arg_13_0)
	if arg_13_0.LT then
		ipairs = var_1

		for iter_13_0, iter_13_1 in var_1(arg_13_0.LT) do
			LeanTween = var_1_10006

			var_1_10006.pause(iter_13_1)
		end
	end

	return
end

function var_0_1.OnDestroy(arg_14_0)
	if arg_14_0.LT then
		ipairs = var_1

		for iter_14_0, iter_14_1 in var_1(arg_14_0.LT) do
			LeanTween = var_1_10006

			var_1_10006.cancel(iter_14_1)
		end
	end

	return
end

return var_0_1
