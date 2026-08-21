local var_0_0 = class("SimBusinessBubbleView", BaseView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/SummerUI_3_5_BubbleView"
end

function var_0_0.BubbleRoot(arg_2_0)
	return arg_2_0.transform_
end

function var_0_0.Ctor(arg_3_0)
	var_0_0.super.Ctor(arg_3_0)

	arg_3_0.gameObject_ = GameObject.Instantiate(Asset.Load(arg_3_0:UIName()), manager.ui.uiMain.transform)
	arg_3_0.transform_ = arg_3_0.gameObject_.transform
	arg_3_0.bubbles = {}
end

function var_0_0.Dispose(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.bubbles) do
		iter_4_1:Dispose()
	end

	arg_4_0.bubbles = nil

	var_0_0.super.Dispose(arg_4_0)
	GameObject.Destroy(arg_4_0.gameObject_)

	arg_4_0.transform_, arg_4_0.gameObject_ = nil
end

function var_0_0.GetBubble(arg_5_0, arg_5_1)
	return arg_5_0.bubbles[arg_5_1]
end

function var_0_0.EmplaceBubble(arg_6_0, arg_6_1, arg_6_2, ...)
	local var_6_0 = arg_6_0:GetBubble(arg_6_1)

	if var_6_0 then
		return false, var_6_0
	end

	local var_6_1 = arg_6_2.New(...)

	var_6_1.transform_:SetParent(arg_6_0.transform_)

	arg_6_0.bubbles[arg_6_1] = var_6_1

	return true, var_6_1
end

function var_0_0.RemoveBubble(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:GetBubble(arg_7_1)

	if var_7_0 then
		var_7_0:Dispose()

		arg_7_0.bubbles[arg_7_1] = nil
	end
end

function var_0_0.ClearAllBubble(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.bubbles) do
		iter_8_1:Dispose()
	end

	arg_8_0.bubbles = {}
end

return var_0_0
