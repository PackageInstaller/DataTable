local var_0_0 = class("ChallengeRogueTeamRelicPanelBaseView", ReduxView)

var_0_0.OBJECT_TYPE = {
	TITLE = 1,
	NEWITEM = 3,
	ITEM = 2
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	local var_1_0 = arg_1_0.contentTf_.rect.height
	local var_1_1 = arg_1_0.gridTrs_:GetComponent("VerticalLayoutGroup").spacing

	arg_1_0.loopScrollView_ = LoopScrollView.New(arg_1_0, arg_1_0.scrollRectEx_, arg_1_0.gridTrs_, arg_1_0.contentTf_, var_1_0, var_1_1)

	arg_1_0:InitCustomUI()

	arg_1_0.onSelectRelicHandler_ = handler(arg_1_0, arg_1_0.OnSelectRelic)
	arg_1_0.titleItemPool_ = {}
	arg_1_0.relicItemPool_ = {}
	arg_1_0.newRelicItemPool_ = {}
end

function var_0_0.AddListeners(arg_2_0)
	return
end

function var_0_0.OnEnter(arg_3_0)
	arg_3_0:RefreshUI()
	manager.notify:RegistListener(CHALLENGER_ROGUE_TEAM_BAG_RELIC_SELECTED, arg_3_0.onSelectRelicHandler_)
end

function var_0_0.OnExit(arg_4_0)
	manager.notify:RemoveListener(CHALLENGER_ROGUE_TEAM_BAG_RELIC_SELECTED, arg_4_0.onSelectRelicHandler_)

	arg_4_0.selectRelicID_ = 0
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.onSelectRelicHandler_ = nil

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.titleItemPool_) do
		iter_5_1.itemView:Dispose()
	end

	arg_5_0.titleItemPool_ = nil

	for iter_5_2, iter_5_3 in ipairs(arg_5_0.relicItemPool_) do
		iter_5_3.itemView:Dispose()
	end

	arg_5_0.relicItemPool_ = nil

	for iter_5_4, iter_5_5 in ipairs(arg_5_0.newRelicItemPool_) do
		iter_5_5.itemView:Dispose()
	end

	arg_5_0.newRelicItemPool_ = nil

	arg_5_0.loopScrollView_:Dispose()

	arg_5_0.loopScrollView_ = nil

	var_0_0.super.Dispose(arg_5_0)

	arg_5_0.itemDataList_ = nil
end

function var_0_0.AddListeners(arg_6_0)
	return
end

function var_0_0.InitCustomUI(arg_7_0)
	return
end

function var_0_0.OnSelectRelic(arg_8_0, arg_8_1)
	arg_8_0.selectRelicID_ = arg_8_1

	arg_8_0:ShowItemInfo(arg_8_0.selectRelicID_)
end

function var_0_0.GetAllRelicData(arg_9_0)
	return
end

function var_0_0.ShowItemInfo(arg_10_0, arg_10_1)
	return
end

function var_0_0.RefreshUI(arg_11_0)
	return
end

function var_0_0.LsAddItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1.objectType
	local var_12_1

	if var_12_0 == var_0_0.OBJECT_TYPE.TITLE then
		var_12_1 = arg_12_0:GetFreeTitleItem(arg_12_0.titleItemPool_, function()
			return ChallengeRogueTeamBagRelicTitleItem.New(arg_12_0.titleItem_, arg_12_0.parent_)
		end)
	else
		var_12_1 = arg_12_0:GetFreeTitleItem(arg_12_0.relicItemPool_, function()
			return ChallengeRogueTeamBagRelicPanelItem.New(arg_12_0.relicItem_, arg_12_0.parent_)
		end)
	end

	var_12_1.itemView:SetData(arg_12_1.data, arg_12_2)

	if var_12_0 == var_0_0.OBJECT_TYPE.ITEM then
		var_12_1.itemView:SetSelectID(arg_12_0.selectRelicID_)
	end

	return var_12_1
end

function var_0_0.LsRemoveItem(arg_15_0, arg_15_1, arg_15_2)
	arg_15_1.itemView:Show(false)

	arg_15_1.isFree = true
end

function var_0_0.LsGetItemData(arg_16_0)
	return arg_16_0.uiDataList_
end

function var_0_0.LsUpdateItem(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_1.itemView:SetData(arg_17_2, arg_17_3)
end

function var_0_0.GetFreeTitleItem(arg_18_0, arg_18_1, arg_18_2)
	for iter_18_0, iter_18_1 in pairs(arg_18_1) do
		if iter_18_1.isFree == true then
			iter_18_1.isFree = false

			return iter_18_1
		end
	end

	local var_18_0 = {
		isFree = false,
		itemView = arg_18_2()
	}

	table.insert(arg_18_1, var_18_0)

	return var_18_0
end

return var_0_0
