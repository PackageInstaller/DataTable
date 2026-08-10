local var_0_0 = class("BattleMultipleResultReward", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObejct_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObejct_.transform

	arg_1_0:BindCfgUI(arg_1_0.gameObejct_)

	arg_1_0.rewardUIList_ = LuaList.New(handler(arg_1_0, arg_1_0.RefreshRenderer), arg_1_0.uiList_, CommonItemView)
end

function var_0_0.Dispose(arg_2_0)
	if arg_2_0.rewardUIList_ then
		arg_2_0.rewardUIList_:Dispose()

		arg_2_0.rewardUIList_ = nil
	end

	var_0_0.super.Dispose(arg_2_0)

	arg_2_0.gameObejct_ = nil
end

function var_0_0.SetRewardList(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0.index_ ~= arg_3_1 then
		arg_3_0.index_ = arg_3_1
		arg_3_0.rewardList_ = arg_3_2

		arg_3_0:RefreshUI()
	end
end

function var_0_0.RefreshUI(arg_4_0)
	arg_4_0.indexText_.text = arg_4_0.index_

	local var_4_0 = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_0.rewardList_) do
		table.insert(var_4_0, iter_4_1)
	end

	local var_4_1 = formatRewardCfgList(var_4_0)
	local var_4_2 = mergeReward(var_4_1)
	local var_4_3 = sortReward(var_4_2)

	arg_4_0.rewardList_ = var_4_3

	arg_4_0.rewardUIList_:StartScroll(#var_4_3, 1)
end

function var_0_0.RefreshRenderer(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.rewardList_[arg_5_1]
	local var_5_1 = clone(ItemTemplateData)

	var_5_1.id = var_5_0.id
	var_5_1.number = var_5_0.num

	if ItemCfg[var_5_0.id] and ItemConst.ITEM_TYPE.EQUIP == ItemCfg[var_5_0.id].type then
		var_5_1.race = EquipCfg[var_5_0.id] and EquipCfg[var_5_0.id].race or 0
	end

	function var_5_1.clickFun(arg_6_0)
		ShowPopItem(POP_OTHER_ITEM, {
			arg_6_0.id,
			arg_6_0.number
		})
	end

	arg_5_2:SetData(var_5_1)
end

return var_0_0
