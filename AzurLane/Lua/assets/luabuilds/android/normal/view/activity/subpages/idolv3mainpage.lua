class = var_0_10000

local var_0_0 = "IdolV3MainPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PreviewTemplatePage"))
local var_0_2 = {
	"1",
	"2",
	"3",
	"4",
	"5",
	"6"
}
local var_0_3 = 2
local var_0_4 = 0.4

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.paintTF = var_1.Find(var_1_0, "Image")

	return
end

function var_0_1.OnUpdateFlush(arg_2_0)
	Timer = var_1_10001
	arg_2_0.timer = var_1_10001.New(function()
		local var_3_0 = arg_2_0

		var_0.ShowNextPainting(var_3_0)

		return
	end, var_0_3 + var_0_4, -1)

	local var_2_0 = arg_2_0.timer

	var_1.Start(var_2_0)

	return
end

function var_0_1.ShowNextPainting(arg_4_0)
	if not arg_4_0.curIndex then
		arg_4_0.curIndex = 1
	end

	arg_4_0.curIndex = arg_4_0.curIndex + 1

	if arg_4_0.curIndex > #var_0_2 then
		arg_4_0.curIndex = 1
	end

	local var_4_0 = var_0_2[arg_4_0.curIndex]

	seriesAsync = var_2

	var_2({
		function(arg_5_0)
			local var_5_0 = arg_4_0
			local var_5_1 = var_1.managedTween

			LeanTween = var_2_10003

			local var_5_2 = var_2_10003.value
			local var_5_3

			go = var_2_10005

			local var_5_4 = var_5_1(var_5_0, var_5_2, var_5_3, var_2_10005(arg_4_0.paintTF), 1, 0, var_0_4 / 2)
			local var_5_5 = var_1.setOnUpdate

			System = var_5_2

			local var_5_6 = var_5_5(var_5_4, var_5_2.Action_float(function(arg_6_0)
				GetOrAddComponent = var_3_10001

				local var_6_0 = arg_4_0.paintTF

				typeof = var_3_10003
				CanvasGroup = var_3_10004
				var_3_10001(var_6_0, var_3_10003(var_3_10004)).alpha = arg_6_0

				return
			end))
			local var_5_7 = var_1.setOnComplete

			System = var_3

			var_5_7(var_5_6, var_3.Action(function()
				arg_5_0()

				return
			end))

			return
		end,
		function(arg_8_0)
			GetSpriteFromAtlasAsync = var_2_10001

			var_2_10001("ui/activityuipage/idolv3mainpage_atlas", var_4_0, function(arg_9_0)
				local var_9_0 = arg_4_0.paintTF
				local var_9_1 = var_1.GetComponent

				typeof = var_3_10003
				Image = var_3_10004
				var_9_1(var_9_0, var_3_10003(var_3_10004)).sprite = arg_9_0

				arg_8_0()

				return
			end)

			return
		end,
		function(arg_10_0)
			local var_10_0 = arg_4_0
			local var_10_1 = var_1.managedTween

			LeanTween = var_2_10003

			local var_10_2 = var_2_10003.value
			local var_10_3

			go = var_2_10005

			local var_10_4 = var_10_1(var_10_0, var_10_2, var_10_3, var_2_10005(arg_4_0.paintTF), 0, 1, var_0_4 / 2)
			local var_10_5 = var_1.setOnUpdate

			System = var_10_2

			local var_10_6 = var_10_5(var_10_4, var_10_2.Action_float(function(arg_11_0)
				GetOrAddComponent = var_3_10001

				local var_11_0 = arg_4_0.paintTF

				typeof = var_3_10003
				CanvasGroup = var_3_10004
				var_3_10001(var_11_0, var_3_10003(var_3_10004)).alpha = arg_11_0

				return
			end))
			local var_10_7 = var_1.setOnComplete

			System = var_3

			var_10_7(var_10_6, var_3.Action(function()
				arg_10_0()

				return
			end))

			return
		end
	})

	return
end

function var_0_1.OnHideFlush(arg_13_0)
	if arg_13_0.timer then
		local var_13_0 = arg_13_0.timer

		var_1.Stop(var_13_0)

		arg_13_0.timer = nil
	end

	arg_13_0:cleanManagedTween()

	return
end

function var_0_1.OnDestroy(arg_14_0)
	if arg_14_0.timer then
		local var_14_0 = arg_14_0.timer

		var_1.Stop(var_14_0)

		arg_14_0.timer = nil
	end

	return
end

return var_0_1
