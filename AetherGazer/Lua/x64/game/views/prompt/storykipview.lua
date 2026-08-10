local var_0_0 = class("StoryKipView", ReduxView)

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

	arg_3_0.textTyper_ = arg_3_0.m_content.transform:GetComponent("TextTypeWrite")
	arg_3_0.skipBtnCon_ = ControllerUtil.GetController(arg_3_0.transform_, "skip")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_sureBtn, nil, function()
		arg_4_0:Back()

		if arg_4_0.handler_ then
			arg_4_0.handler_()

			arg_4_0.handler_ = nil
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.m_cancelBtn, nil, function()
		arg_4_0:Back()
	end)
	arg_4_0:AddBtnListener(arg_4_0.m_maskBtn, nil, function()
		if arg_4_0.textTyper_:isTypeing() then
			arg_4_0.textTyper_:ShowAllText()
		elseif arg_4_0.handler_ then
			arg_4_0.handler_()

			arg_4_0.handler_ = nil
		end
	end)
end

function var_0_0.SetCallback(arg_8_0, arg_8_1)
	arg_8_0.handler_ = arg_8_1
end

function var_0_0.SetContentTitle(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.content_ = arg_9_2
	arg_9_0.title_ = arg_9_1

	arg_9_0:OnEnter()
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.skipBtnCon_:SetSelectedState(0)
	arg_10_0.textTyper_:StartTyping(arg_10_0.content_ or "", function()
		arg_10_0.skipBtnCon_:SetSelectedState(1)
	end)
	arg_10_0.textTyper_:ClearLinePrefixSymbol()

	arg_10_0.m_title.text = GetI18NText(arg_10_0.title_) or ""
end

function var_0_0.Dispose(arg_12_0)
	Object.Destroy(arg_12_0.gameObject_)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
