class = var_0_10000

local var_0_0 = "IslandAsidePlayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("Mgr.Story.model.animation.StoryAnimtion"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0)

	UIItemList = var_2
	arg_1_0.asideUIlist = var_2.New(arg_1_1:Find("list"), arg_1_1:Find("list/tpl"))

	return
end

function var_0_1.Play(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0.asideUIlist

	var_3.make(var_2_0, function(arg_3_0, arg_3_1, arg_3_2)
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			setText = var_3

			var_3(arg_3_2, arg_2_1[arg_3_1 + 1].text)

			GetOrAddComponent = var_3

			local var_3_0 = arg_3_2

			typeof = var_6
			CanvasGroup = var_2_10008
			var_3(var_3_0, var_6(var_2_10008)).alpha = 0
		end

		return
	end)

	local var_2_1 = arg_2_0.asideUIlist

	var_3.align(var_2_1, #arg_2_1)

	local var_2_2 = {}
	local var_2_3 = arg_2_0.asideUIlist

	var_4.eachActive(var_2_3, function(arg_4_0, arg_4_1)
		table = var_2_10002

		var_2_10002.insert(var_2_2, function(arg_5_0)
			local var_5_0 = arg_2_0
			local var_5_1 = var_1.TweenValueForcanvasGroup

			GetOrAddComponent = var_3_10004

			local var_5_2 = arg_4_1

			typeof = var_3_10007
			CanvasGroup = var_3_10009

			var_5_1(var_5_0, var_3_10004(var_5_2, var_3_10007(var_3_10009)), 0, 1, 0.2, arg_2_1[arg_4_0 + 1].delay, arg_5_0)

			return
		end)

		return
	end)

	parallelAsync = var_4

	var_4(var_2_2, function()
		local var_6_0 = arg_2_0

		var_0.Clear(var_6_0)

		local var_6_1 = arg_2_0

		var_0.DelayCall(var_6_1, 1, arg_2_2)

		return
	end)

	return
end

function var_0_1.Clear(arg_7_0)
	arg_7_0:ClearAnimation()

	return
end

function var_0_1.Dispose(arg_8_0)
	arg_8_0:Clear()

	return
end

return var_0_1
