local var_0_0 = class("IdolV3MainPage", import(".TemplatePage.PreviewTemplatePage"))
local var_0_1 = {
	"1",
	"2",
	"3",
	"4",
	"5",
	"6"
}
local var_0_2 = 2
local var_0_3 = 0.4

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.paintTF = arg_1_0.bg:Find("Image")

	return
end

function var_0_0.OnUpdateFlush(arg_2_0)
	arg_2_0.timer = Timer.New(function()
		arg_2_0:ShowNextPainting()

		return
	end, var_0_2 + var_0_3, -1)

	arg_2_0.timer:Start()

	return
end

function var_0_0.ShowNextPainting(arg_4_0)
	arg_4_0.curIndex = arg_4_0.curIndex or 1
	arg_4_0.curIndex = arg_4_0.curIndex + 1

	if arg_4_0.curIndex > #var_0_1 then
		arg_4_0.curIndex = 1
	end

	local var_4_0 = var_0_1[arg_4_0.curIndex]

	seriesAsync({
		function(arg_5_0)
			arg_4_0:managedTween(LeanTween.value, nil, go(arg_4_0.paintTF), 1, 0, var_0_3 / 2):setOnUpdate(System.Action_float(function(arg_6_0)
				GetOrAddComponent(arg_4_0.paintTF, typeof(CanvasGroup)).alpha = arg_6_0

				return
			end)):setOnComplete(System.Action(function()
				arg_5_0()

				return
			end))

			return
		end,
		function(arg_8_0)
			GetSpriteFromAtlasAsync("ui/activityuipage/idolv3mainpage_atlas", var_4_0, function(arg_9_0)
				arg_4_0.paintTF:GetComponent(typeof(Image)).sprite = arg_9_0

				arg_8_0()

				return
			end)

			return
		end,
		function(arg_10_0)
			arg_4_0:managedTween(LeanTween.value, nil, go(arg_4_0.paintTF), 0, 1, var_0_3 / 2):setOnUpdate(System.Action_float(function(arg_11_0)
				GetOrAddComponent(arg_4_0.paintTF, typeof(CanvasGroup)).alpha = arg_11_0

				return
			end)):setOnComplete(System.Action(function()
				arg_10_0()

				return
			end))

			return
		end
	})

	return
end

function var_0_0.OnHideFlush(arg_13_0)
	if arg_13_0.timer then
		arg_13_0.timer:Stop()

		arg_13_0.timer = nil
	end

	arg_13_0:cleanManagedTween()

	return
end

function var_0_0.OnDestroy(arg_14_0)
	if arg_14_0.timer then
		arg_14_0.timer:Stop()

		arg_14_0.timer = nil
	end

	return
end

return var_0_0
