local var_0_0 = class("IslandAsidePlayer", import("Mgr.Story.model.animation.StoryAnimtion"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0.asideUIlist = UIItemList.New(arg_1_1:Find("list"), arg_1_1:Find("list/tpl"))

	return
end

function var_0_0.Play(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.asideUIlist:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			setText(arg_3_2, arg_2_1[arg_3_1 + 1].text)

			GetOrAddComponent(arg_3_2, typeof(CanvasGroup)).alpha = 0
		end

		return
	end)
	arg_2_0.asideUIlist:align(#arg_2_1)

	local var_2_0 = {}

	arg_2_0.asideUIlist:eachActive(function(arg_4_0, arg_4_1)
		table.insert(var_2_0, function(arg_5_0)
			arg_2_0:TweenValueForcanvasGroup(GetOrAddComponent(arg_4_1, typeof(CanvasGroup)), 0, 1, 0.2, arg_2_1[arg_4_0 + 1].delay, arg_5_0)

			return
		end)

		return
	end)
	parallelAsync({}, function()
		arg_2_0:Clear()
		arg_2_0:DelayCall(1, arg_2_2)

		return
	end)

	return
end

function var_0_0.Clear(arg_7_0)
	arg_7_0:ClearAnimation()

	return
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:Clear()

	return
end

return var_0_0
