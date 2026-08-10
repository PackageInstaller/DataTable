local var_0_0 = class("BubbleItem", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.uiFollow = arg_1_1:GetComponent("UIFollow")

	arg_1_0:BindCfgUI()
end

local function var_0_1(arg_2_0, arg_2_1)
	arg_2_0.task = nil
	arg_2_0.text.text = ""

	arg_2_0.content:SetActive(false)
end

function var_0_0.ShowSubtitle(arg_3_0, arg_3_1, arg_3_2)
	return
end

local function var_0_2(arg_4_0)
	return arg_4_0 == nil or arg_4_0 == "" or IsAllSpace(arg_4_0)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.text.text = arg_5_1

	if not var_0_2(arg_5_1) then
		arg_5_0.content:SetActive(true)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_5_0.content.transform)
	end
end

function var_0_0.Hide(arg_6_0)
	if arg_6_0.task then
		arg_6_0.task:Abort()

		arg_6_0.task = nil
	end
end

function var_0_0.IsPlaying(arg_7_0)
	return arg_7_0.task ~= nil
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)

	if arg_8_0.task then
		arg_8_0.task:Abort()

		arg_8_0.task = nil
	end

	arg_8_0.gameObject_:Destroy()
end

return var_0_0
