local var_0_0 = class("PassportShowRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Passport/PassportRewardUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.itemViewList = {}
	arg_4_0.normalController = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "contract")
	arg_4_0.lockController = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "lock")
	arg_4_0.normalList = LuaList.New(handler(arg_4_0, arg_4_0.NormalIndexItem), arg_4_0.list1Go_, CommonItemView)
	arg_4_0.payList = LuaList.New(handler(arg_4_0, arg_4_0.PayIndexItem), arg_4_0.list2Go_, CommonItemView)
end

function var_0_0.NormalIndexItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.normalRewardList[arg_5_1]

	CommonTools.SetCommonData(arg_5_2, {
		id = var_5_0.id,
		number = var_5_0.number,
		clickFun = function(arg_6_0)
			ShowPopItem(POP_OTHER_ITEM, {
				arg_6_0.id
			})
		end
	})
end

function var_0_0.PayIndexItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.payRewardList[arg_7_1]

	CommonTools.SetCommonData(arg_7_2, {
		id = var_7_0.id,
		number = var_7_0.number,
		clickFun = function(arg_8_0)
			ShowPopItem(POP_OTHER_ITEM, {
				arg_8_0.id
			})
		end
	})
end

function var_0_0.AddUIListener(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.unlockBtn_, nil, function()
		arg_9_0:Back()
		JumpTools.OpenPageByJump("/passportBuy")
	end)
	arg_9_0:AddBtnListener(arg_9_0.maskBtn_, nil, function()
		arg_9_0:Back()
	end)
end

function var_0_0.UpdateView(arg_12_0)
	arg_12_0.rewardIdList_ = BattlePassCfg.get_id_list_by_type[BattlePassListCfg[PassportData:GetId()].battlepass_type]

	arg_12_0.normalController:SetSelectedState(arg_12_0.type == 2 and "expand2" or "base")

	arg_12_0.nameTxt_.text = GetTips(arg_12_0.type == 1 and "BATTLEPASS_FREE" or "BATTLEPASS_CHARGE")

	if arg_12_0.type == 2 and PassportData:GetLevel() > 0 and PassportData:GetPayLevel() <= 0 and not arg_12_0.isPassPortBuy then
		arg_12_0.normalController:SetSelectedState("expand")

		arg_12_0.nameTxt_.text = GetTips("BATTLEPASS_CHARGE")
	end

	arg_12_0.lockController:SetSelectedState((PassportData:GetPayLevel() > 0 or arg_12_0.type == 1 or arg_12_0.isPassPortBuy) and "unlock" or "lock")

	if arg_12_0.type == 2 then
		arg_12_0.payRewardList = arg_12_0:GetPayList()

		arg_12_0.payList:StartScroll(#arg_12_0.payRewardList)
	end

	arg_12_0.normalRewardList = arg_12_0:GetNormalList()

	arg_12_0.normalList:StartScroll(#arg_12_0.normalRewardList)
end

function var_0_0.GetNormalList(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = {}

	for iter_13_0 = 1, PassportData:GetMaxLevel() do
		local var_13_2 = BattlePassCfg[arg_13_0.rewardIdList_[iter_13_0]]["reward_" .. (arg_13_0.type == 1 and "free" or "pay")]

		var_13_0[var_13_2[1][1]] = (var_13_0[var_13_2[1][1]] or 0) + var_13_2[1][2]
	end

	for iter_13_1, iter_13_2 in pairs(var_13_0) do
		table.insert(var_13_1, {
			id = iter_13_1,
			number = iter_13_2
		})
	end

	table.sort(var_13_1, function(arg_14_0, arg_14_1)
		local var_14_0 = ItemCfg[arg_14_0.id]
		local var_14_1 = ItemCfg[arg_14_1.id]

		if var_14_0.rare ~= var_14_1.rare then
			return var_14_0.rare > var_14_1.rare
		end

		return arg_14_0.id > arg_14_1.id
	end)

	return var_13_1
end

function var_0_0.GetPayList(arg_15_0)
	local var_15_0 = PassportData:GetLevel()

	if var_15_0 == 0 then
		return {}
	end

	local var_15_1 = {}
	local var_15_2 = {}

	for iter_15_0 = 1, var_15_0 do
		local var_15_3 = BattlePassCfg[arg_15_0.rewardIdList_[iter_15_0]]

		var_15_1[var_15_3.reward_pay[1][1]] = (var_15_1[var_15_3.reward_pay[1][1]] or 0) + var_15_3.reward_pay[1][2]
	end

	for iter_15_1, iter_15_2 in pairs(var_15_1) do
		table.insert(var_15_2, {
			id = iter_15_1,
			number = iter_15_2
		})
	end

	table.sort(var_15_2, function(arg_16_0, arg_16_1)
		local var_16_0 = ItemCfg[arg_16_0.id]
		local var_16_1 = ItemCfg[arg_16_1.id]

		if var_16_0.rare ~= var_16_1.rare then
			return var_16_0.rare > var_16_1.rare
		end

		return arg_16_0.id > arg_16_1.id
	end)

	return var_15_2
end

function var_0_0.OnEnter(arg_17_0)
	arg_17_0.type = arg_17_0.params_.type
	arg_17_0.isPassPortBuy = arg_17_0.params_.isPassPortBuy
	arg_17_0.params_.isPassPortBuy = nil

	arg_17_0:UpdateView()
end

function var_0_0.OnExploreUpdate(arg_18_0)
	arg_18_0:UpdateView()
end

function var_0_0.Dispose(arg_19_0)
	var_0_0.super.Dispose(arg_19_0)

	if arg_19_0.normalList then
		arg_19_0.normalList:Dispose()

		arg_19_0.normalList = nil
	end

	if arg_19_0.payList then
		arg_19_0.payList:Dispose()

		arg_19_0.payList = nil
	end

	Object.Destroy(arg_19_0.gameObject_)
end

return var_0_0
