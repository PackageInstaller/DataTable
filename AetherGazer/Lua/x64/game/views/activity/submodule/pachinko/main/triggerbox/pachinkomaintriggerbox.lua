local var_0_0 = class("PaChinKoMainTriggerBox", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.triggerItem_ = {}

	for iter_1_0 = 1, 3 do
		arg_1_0.triggerItem_[iter_1_0] = PaChinKoMainTriggerItem.New(arg_1_0[string.format("uiTriggerGo%s_", iter_1_0)], iter_1_0)
	end

	arg_1_0.spaceValue_ = arg_1_0.uiLayoutGroup_.spacing
	arg_1_0.widthValue = arg_1_0.uiRectTf_.rect.width
	arg_1_0.greyController_ = arg_1_0.uiControllerEx_:GetController("grey")
	arg_1_0.baffleWidth_ = arg_1_0[string.format("uiBaffleGo%s_", 1)]:GetComponent(typeof(RectTransform)).sizeDelta.x
end

function var_0_0.Dispose(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.triggerItem_) do
		iter_2_1:Dispose()
	end

	arg_2_0.triggerItem_ = nil

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	return
end

function var_0_0.RefreshTrigger(arg_4_0, arg_4_1)
	arg_4_0.activityID_ = arg_4_1

	arg_4_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_5_0)
	local var_5_0 = {}
	local var_5_1 = PaChinKoTools.GetPrizeDistribution(arg_5_0.activityID_)

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		table.insert(var_5_0, #var_5_1 - iter_5_0 + 1, iter_5_1)
	end

	local var_5_2 = 0

	for iter_5_2, iter_5_3 in ipairs(var_5_0) do
		if iter_5_3 == 0 then
			var_5_2 = var_5_2 + 1
		end

		SetActive(arg_5_0[string.format("uiBaffleGo%s_", iter_5_2)], iter_5_3 ~= 0)
		SetActive(arg_5_0[string.format("uiTriggerGo%s_", iter_5_2)], iter_5_3 ~= 0)
	end

	if var_5_2 == #var_5_0 then
		arg_5_0.greyController_:SetSelectedState("grey")

		return
	end

	arg_5_0.greyController_:SetSelectedState("normal")

	local var_5_3 = (arg_5_0.widthValue - arg_5_0.spaceValue_ * ((#var_5_0 - var_5_2) * 2) - arg_5_0.baffleWidth_ * (#var_5_0 - var_5_2)) / 10

	for iter_5_4, iter_5_5 in ipairs(var_5_0) do
		arg_5_0.triggerItem_[iter_5_4]:SetWidth(iter_5_5 * var_5_3)
	end
end

function var_0_0.PlayEffect(arg_6_0, arg_6_1)
	arg_6_0.triggerItem_[arg_6_1]:PlayEffect()
end

return var_0_0
