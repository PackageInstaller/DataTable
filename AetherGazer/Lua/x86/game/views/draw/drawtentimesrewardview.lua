local var_0_0 = class("DrawTenTimesRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Pool/PoolTenTimesUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.list = LuaList.New(handler(arg_5_0, arg_5_0.IndexItem), arg_5_0.m_list, DrawTenTimesRewardItem)

	SetActive(arg_5_0.goShare_, OperationData:IsOperationOpen(OperationConst.SHARE_FLAG))
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.m_maskBtn, nil, function()
		arg_6_0:Back()

		if arg_6_0.params_.callBack_afterTen then
			arg_6_0.params_.callBack_afterTen()
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.buttonShare_, nil, function()
		manager.share:Share(function()
			SetActive(arg_6_0.goShare_, false)
			SetActive(arg_6_0.goTips_, false)
			manager.notify:Invoke(SHAER_DAW_TEN_TIMES_START)
		end, function()
			SetActive(arg_6_0.goShare_, true)
			SetActive(arg_6_0.goTips_, true)
			manager.notify:Invoke(SHAER_DAW_TEN_TIMES_END)
		end, function()
			return
		end)
	end)
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.rewards = formatRewardCfgList(arg_12_0.params_.reward)
	arg_12_0.animePlayed = {}

	table.sort(arg_12_0.rewards, function(arg_13_0, arg_13_1)
		local var_13_0 = ItemCfg[arg_13_0.id]
		local var_13_1 = ItemCfg[arg_13_1.id]

		if ItemWillConvert(arg_13_0) then
			var_13_0 = ItemCfg[arg_13_0.convert_from.id]
		end

		if ItemWillConvert(arg_13_1) then
			var_13_1 = ItemCfg[arg_13_1.convert_from.id]
		end

		local var_13_2 = arg_13_0.index or 0
		local var_13_3 = arg_13_1.index or 0

		if var_13_0.type ~= var_13_1.type then
			return var_13_0.type < var_13_1.type
		elseif var_13_0.display_rare ~= var_13_1.display_rare then
			return var_13_0.display_rare > var_13_1.display_rare
		else
			return var_13_2 < var_13_3
		end
	end)

	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.rewards) do
		if iter_12_1.newTag then
			if not var_12_0[iter_12_1.id] then
				var_12_0[iter_12_1.id] = true
			else
				iter_12_1.newTag = false
			end
		end
	end

	arg_12_0.list:StartScroll(#arg_12_0.rewards)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_14_0)
	for iter_14_0 = 1, #arg_14_0.rewards do
		arg_14_0.list:GetItemByIndex(iter_14_0):OnExit()
	end
end

function var_0_0.IndexItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.rewards[arg_15_1]

	arg_15_2:SetData(arg_15_1, var_15_0, arg_15_0.animePlayed[arg_15_1])

	arg_15_0.animePlayed[arg_15_1] = true
end

function var_0_0.Dispose(arg_16_0)
	if arg_16_0.list then
		arg_16_0.list:Dispose()

		arg_16_0.list = nil
	end

	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
