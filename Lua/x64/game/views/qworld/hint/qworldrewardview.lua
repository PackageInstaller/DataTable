local var_0_0 = class("QWorldRewardView", QWorldHintBaseView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SandPlay/SandPlay_InScenes/item/SandPlay_Get"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0.rewardList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.uiList_, CommonItemView)

	arg_3_0:AddBtnListener(arg_3_0.closeBtn_, nil, function()
		arg_3_0:Hide()
	end)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.rewards_[arg_5_1]

	if ItemCfg[var_5_0.id] and ItemConst.ITEM_TYPE.EQUIP == ItemCfg[var_5_0.id].type then
		var_5_0.race = EquipCfg[var_5_0.id] and EquipCfg[var_5_0.id].race or 0
	end

	local var_5_1 = clone(ItemTemplateData)

	var_5_1.id = var_5_0.id
	var_5_1.number = var_5_0.num
	var_5_1.race = var_5_0.race

	function var_5_1.clickFun(arg_6_0)
		ShowPopItemOnly(POP_OTHER_ITEM, {
			arg_6_0.id,
			arg_6_0.number
		})
	end

	arg_5_2:SetData(var_5_1)
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0.rewards_ = {}

	for iter_7_0 = 1, math.min(#arg_7_1, 8) do
		local var_7_0 = arg_7_1[1]

		table.remove(arg_7_1, 1)
		table.insert(arg_7_0.rewards_, var_7_0)
	end

	arg_7_0.rewards_ = ItemTools.SortRewardItemList(arg_7_0.rewards_)
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0.rewardList_:StartScroll(#arg_8_0.rewards_)

	arg_8_0.titleText_.text = GetTips("SANDPLAY_TIP_REWARD")
end

function var_0_0.Dispose(arg_9_0)
	if arg_9_0.rewardList_ then
		arg_9_0.rewardList_:Dispose()

		arg_9_0.rewardList_ = nil
	end

	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
