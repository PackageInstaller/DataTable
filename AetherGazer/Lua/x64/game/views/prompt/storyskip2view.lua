local var_0_0 = class("StorySkip2View", ReduxView)

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
	arg_4_0:AddBtnListener(arg_4_0.okBtn_, nil, function()
		manager.ui:SetUISeparateRender(false)

		if arg_4_0.handler_ then
			arg_4_0.handler_()

			arg_4_0.handler_ = nil
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.bgmaskBtn_, nil, function()
		arg_4_0:CancelFun()
	end)
	arg_4_0:AddBtnListener(arg_4_0.cancelBtn_, nil, function()
		arg_4_0:CancelFun()
	end)
end

function var_0_0.CancelFun(arg_8_0)
	SetActive(arg_8_0.gameObject_, false)
	manager.ui:SetUISeparateRender(false)

	if arg_8_0.handler_ then
		arg_8_0.handler_(true)

		arg_8_0.handler_ = nil
	end
end

function var_0_0.SetCallback(arg_9_0, arg_9_1)
	arg_9_0.handler_ = arg_9_1
end

function var_0_0.SetContentTitle(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.content_ = arg_10_2
	arg_10_0.title_ = arg_10_1

	arg_10_0:OnEnter()
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.titleText_.text = GetI18NText(arg_11_0.title_) or ""
	arg_11_0.contentText_.text = arg_11_0.content_ or ""
end

function var_0_0.Dispose(arg_12_0)
	Object.Destroy(arg_12_0.gameObject_)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
