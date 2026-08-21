local var_0_0 = class("SubPageStoryPlayer", import(".StoryPlayer"))

function var_0_0.OnEnter(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	seriesAsync({
		function(arg_2_0)
			arg_1_0:OpenPage(arg_1_1, arg_2_0)

			return
		end
	}, arg_1_3)

	return
end

function var_0_0.OpenPage(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.page = arg_3_1:GetSubPageCls().New(pg.NewStoryMgr.GetInstance()._tf)

	arg_3_0.page:ExecuteAction("Show", arg_3_2)

	return
end

function var_0_0.RegisetEvent(arg_4_0, arg_4_1, arg_4_2)
	var_0_0.super.RegisetEvent(arg_4_0, arg_4_1, arg_4_2)

	if arg_4_0.page then
		arg_4_0.page:Destroy()
	end

	arg_4_0.page = nil

	triggerButton(arg_4_0._go)

	return
end

return var_0_0
