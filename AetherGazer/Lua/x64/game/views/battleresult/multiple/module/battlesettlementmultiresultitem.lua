local var_0_0 = class("BattleSettlementMultiResultItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.TryInitScroll(arg_2_0, arg_2_1)
	arg_2_0.parentScrollRect = arg_2_1

	arg_2_0:BuildEventDispatch()
end

function var_0_0.BuildEventDispatch(arg_3_0)
	arg_3_0.eventTrigger = arg_3_0.rewardsListObj_.transform:GetComponent(typeof(EventTriggerListener))

	if not isNil(arg_3_0.eventTrigger) then
		function arg_3_0.eventTrigger.onBeginDrag(arg_4_0, arg_4_1)
			if not isNil(arg_3_0.parentScrollRect) then
				arg_3_0.parentScrollRect:OnBeginDrag(arg_4_1)
			end
		end

		function arg_3_0.eventTrigger.onEndDrag(arg_5_0, arg_5_1)
			if not isNil(arg_3_0.parentScrollRect) then
				arg_3_0.parentScrollRect:OnEndDrag(arg_5_1)
			end
		end

		function arg_3_0.eventTrigger.onDrag(arg_6_0, arg_6_1)
			if not isNil(arg_3_0.parentScrollRect) then
				arg_3_0.parentScrollRect:OnDrag(arg_6_1)
			end
		end
	end
end

function var_0_0.ClearRef(arg_7_0)
	if not isNil(arg_7_0.eventTrigger) then
		arg_7_0.eventTrigger:RemoveAllListeners()
	end

	arg_7_0.eventTrigger = nil
	arg_7_0.parentScrollRect = nil
end

function var_0_0.Init(arg_8_0)
	arg_8_0:BindCfgUI()

	arg_8_0.scrollHelper = LuaList.New(handler(arg_8_0, arg_8_0.RenderItem), arg_8_0.rewardsListObj_, CommonItemView)
end

function var_0_0.OnEnter(arg_9_0)
	return
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.RenderView(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0.index_ = arg_11_1
	arg_11_0.rewardList_ = arg_11_2 or {}
	arg_11_0.extraReward = arg_11_3 or {}

	arg_11_0:Render()
end

function var_0_0.Render(arg_12_0)
	arg_12_0.indexTxt_.text = arg_12_0.index_

	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(arg_12_0.rewardList_) do
		table.insert(var_12_0, iter_12_1)
	end

	local var_12_1 = formatRewardCfgList(var_12_0)
	local var_12_2 = mergeReward(var_12_1)

	arg_12_0.rewardList_ = sortReward(var_12_2)

	if #arg_12_0.extraReward > 0 then
		local var_12_3 = {}

		for iter_12_2, iter_12_3 in pairs(arg_12_0.extraReward) do
			table.insert(var_12_3, iter_12_3)
		end

		local var_12_4 = formatRewardCfgList(var_12_3)
		local var_12_5 = mergeReward(var_12_4)

		arg_12_0.extraReward = sortReward(var_12_5)

		local var_12_6, var_12_7, var_12_8 = ActivityMultiRewardData:GetLastBattleMultiData()

		if not var_12_8 or not var_12_6 or not (var_12_6 > 0) then
			_, _, var_12_8 = RegressionDataNew:GetMultipleValue()
		end

		arg_12_0.multiRatioText_.text = var_12_8 / 100

		SetActive(arg_12_0.multiGo_, true)
	else
		SetActive(arg_12_0.multiGo_, false)
	end

	arg_12_0.scrollHelper:StartScroll(#arg_12_0.rewardList_ + #arg_12_0.extraReward, 1)
end

function var_0_0.RenderItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0

	if arg_13_1 > #arg_13_0.rewardList_ then
		var_13_0 = arg_13_0.extraReward[arg_13_1 - #arg_13_0.rewardList_]
	else
		var_13_0 = arg_13_0.rewardList_[arg_13_1]
	end

	local var_13_1 = clone(ItemTemplateData)

	var_13_1.id = var_13_0.id
	var_13_1.number = var_13_0.num

	if ItemCfg[var_13_0.id] and ItemConst.ITEM_TYPE.EQUIP == ItemCfg[var_13_0.id].type then
		var_13_1.race = EquipCfg[var_13_0.id] and EquipCfg[var_13_0.id].race or 0
	end

	function var_13_1.clickFun(arg_14_0)
		ShowPopItemOnly(POP_OTHER_ITEM, {
			arg_14_0.id,
			arg_14_0.number
		})
	end

	arg_13_2:SetData(var_13_1)
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0.scrollHelper:Dispose()

	arg_15_0.scrollHelper = nil

	arg_15_0:ClearRef()
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
