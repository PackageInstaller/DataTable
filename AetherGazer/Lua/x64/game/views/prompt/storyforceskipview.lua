local var_0_0 = class("StoryForceSkipView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.maskBtn_, nil, function()
		if arg_4_0.handler_ then
			arg_4_0.handler_()

			arg_4_0.handler_ = nil
		end
	end)
end

function var_0_0.SetCallback(arg_6_0, arg_6_1)
	arg_6_0.handler_ = arg_6_1
end

function var_0_0.SetContentTitle(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.content_ = arg_7_2
	arg_7_0.title_ = arg_7_1

	arg_7_0:OnEnter()
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.titleText_.text = GetI18NText(arg_8_0.title_) or ""
	arg_8_0.contentText_.text = arg_8_0.content_ or ""
end

function var_0_0.Dispose(arg_9_0)
	Object.Destroy(arg_9_0.gameObject_)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
