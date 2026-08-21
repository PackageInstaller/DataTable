local var_0_0 = class("StickerBubbleView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.bubbles_ = {}
end

function var_0_0.AddUIListeners(arg_4_0)
	return
end

function var_0_0.OnEnter(arg_5_0)
	return
end

function var_0_0.RefreshBubbleView(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:GetBubble(arg_6_1):SetData(arg_6_1, arg_6_2)
end

function var_0_0.GetBubble(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.bubbles_[arg_7_1]

	if not var_7_0 then
		local var_7_1 = GameObject.Instantiate(arg_7_0.bubbleTemplate_, arg_7_0.transform_)

		var_7_0 = StickerBubbleItem.New(var_7_1)
		arg_7_0.bubbles_[arg_7_1] = var_7_0
	end

	return var_7_0
end

function var_0_0.OnExit(arg_8_0)
	arg_8_0:RemoveAllEventListener()

	for iter_8_0, iter_8_1 in pairs(arg_8_0.bubbles_) do
		iter_8_1:OnExit()
	end
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:RemoveAllListeners()

	for iter_9_0, iter_9_1 in pairs(arg_9_0.bubbles_) do
		iter_9_1:Dispose()
	end

	arg_9_0.bubbles_ = {}

	arg_9_0.super.Dispose(arg_9_0)
end

return var_0_0
