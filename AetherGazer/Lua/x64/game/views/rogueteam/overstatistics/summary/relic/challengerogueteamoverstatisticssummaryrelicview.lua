local var_0_0 = class("ChallengeRogueTeamOverStatisticsSummaryRelicView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.emptyController_ = arg_1_0.controllerEx_:GetController("empty")
	arg_1_0.relicItemList_ = {}
	arg_1_0.relicDataList_ = ChallengeRogueTeamData:EffectItemGetDataList(ChallengeRogueTeamConst.ITEM_TYPE.RELIC)

	arg_1_0:RefreshUI()
end

function var_0_0.Dispose(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.relicItemList_) do
		iter_2_1:Dispose()
	end

	arg_2_0.relicItemList_ = nil

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	return
end

function var_0_0.RefreshUI(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.relicDataList_) do
		if arg_4_0.relicItemList_[iter_4_0] == nil then
			arg_4_0.relicItemList_[iter_4_0] = ChallengeRogueTeamOverStatisticsSummaryRelicItem.New(arg_4_0.item_, arg_4_0.parent_)
		end

		arg_4_0.relicItemList_[iter_4_0]:SetData(iter_4_1)
	end

	for iter_4_2 = #arg_4_0.relicDataList_ + 1, #arg_4_0.relicItemList_ do
		arg_4_0.relicItemList_[iter_4_2]:Show(false)
	end

	if #arg_4_0.relicDataList_ <= 0 then
		arg_4_0.emptyController_:SetSelectedState("off")
	else
		arg_4_0.emptyController_:SetSelectedState("on")
	end
end

function var_0_0.GetHeight(arg_5_0)
	return arg_5_0.rectTransform_.rect.height
end

function var_0_0.Show(arg_6_0, arg_6_1)
	arg_6_0.animator_.enabled = arg_6_1

	if arg_6_1 == false then
		arg_6_0.canvasGroup_.alpha = 0
	end
end

return var_0_0
