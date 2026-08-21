local var_0_0 = import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")
local var_0_1 = class("ChallengeRogueTeamBagRelicPanelItem", var_0_0)

function var_0_1.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.relicItemList_ = {}
end

function var_0_1.AddListeners(arg_2_0)
	return
end

function var_0_1.SetData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:Show(true)

	arg_3_0.index_ = arg_3_2

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		if arg_3_0.relicItemList_[iter_3_0] == nil then
			arg_3_0.relicItemList_[iter_3_0] = ChallengeRogueTeamBagRelicItem.New(arg_3_0.itemGo_, arg_3_0.gameObject_)
		end

		arg_3_0.relicItemList_[iter_3_0]:SetData(iter_3_1)
		arg_3_0.relicItemList_[iter_3_0]:SetSelectID(arg_3_0.selectID_)
	end

	for iter_3_2 = #arg_3_1 + 1, #arg_3_0.relicItemList_ do
		arg_3_0.relicItemList_[iter_3_2]:Show(false)
	end
end

function var_0_1.SetSelectID(arg_4_0, arg_4_1)
	arg_4_0.selectID_ = arg_4_1

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.relicItemList_) do
		iter_4_1:SetSelectID(arg_4_1)
	end
end

function var_0_1.Show(arg_5_0, arg_5_1)
	SetActive(arg_5_0.gameObject_, arg_5_1)
end

function var_0_1.Dispose(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.relicItemList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.relicItemList_ = nil

	var_0_1.super.Dispose(arg_6_0)
	Object.Destroy(arg_6_0.gameObject_)

	arg_6_0.gameObject_ = nil
	arg_6_0.transform_ = nil
end

return var_0_1
