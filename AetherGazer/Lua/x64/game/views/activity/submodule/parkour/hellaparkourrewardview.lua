local var_0_0 = class("HellaParkourRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/HellaUI/Parkour/HellaParkourRewardUI"
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

	arg_4_0.rewardIndexs = {}
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.list = LuaList.New(handler(arg_5_0, arg_5_0.IndexItem), arg_5_0.m_list, HellaParkourRewardItem)
	arg_5_0.singleController = ControllerUtil.GetController(arg_5_0.transform_, "single")
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0.list:SetPageChangeHandler(handler(arg_6_0, arg_6_0.OnPageChange))
	arg_6_0:AddBtnListener(arg_6_0.m_preBtn, nil, function()
		arg_6_0.list:SwitchToPage(arg_6_0.pageIndex_ - 1)
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_nextBtn, nil, function()
		arg_6_0.list:SwitchToPage(arg_6_0.pageIndex_ + 1)
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_maskBtn, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.OnPageChange(arg_10_0, arg_10_1)
	arg_10_0.pageIndex_ = arg_10_1

	SetActive(arg_10_0.m_preBtn.gameObject, arg_10_1 > 1)
	SetActive(arg_10_0.m_nextBtn.gameObject, arg_10_1 < #arg_10_0.pages)
	arg_10_0:UpdateRedPoint()
end

function var_0_0.OnTop(arg_11_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.parkour_activity_id = arg_12_0.params_.parkour_activity_id

	if arg_12_0.params_.entrust_activity_id then
		arg_12_0.pages = {
			arg_12_0.params_.entrust_activity_id
		}
	else
		arg_12_0.pages = {}

		local var_12_0 = ActivityCfg[arg_12_0.parkour_activity_id]

		for iter_12_0, iter_12_1 in ipairs(var_12_0.sub_activity_list) do
			if ActivityData:GetActivityIsOpen(iter_12_1) then
				table.insert(arg_12_0.pages, iter_12_1)
			end
		end
	end

	arg_12_0.list:StartScroll(#arg_12_0.pages, 1, true, false)
	arg_12_0:OnPageChange(1)
	arg_12_0.singleController:SetSelectedIndex(#arg_12_0.pages > 1 and 0 or 1)
	arg_12_0:UpdateRewardIndex()
end

function var_0_0.UpdateRewardIndex(arg_13_0)
	arg_13_0.rewardIndexs = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.pages) do
		local var_13_0 = ParkourData:GetParkourEntrustData(iter_13_1)

		if var_13_0 then
			for iter_13_2, iter_13_3 in ipairs(var_13_0.stars) do
				if not table.indexof(var_13_0.rewards, iter_13_3) then
					table.insert(arg_13_0.rewardIndexs, iter_13_0)

					break
				end
			end
		end
	end

	arg_13_0:UpdateRedPoint()
end

function var_0_0.UpdateRedPoint(arg_14_0)
	local var_14_0 = false
	local var_14_1 = false

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.rewardIndexs) do
		if iter_14_1 > arg_14_0.pageIndex_ then
			var_14_1 = true
		elseif iter_14_1 < arg_14_0.pageIndex_ then
			var_14_0 = true
		end
	end

	manager.redPoint:SetRedPointIndependent(arg_14_0.m_preBtn.transform, var_14_0)
	manager.redPoint:SetRedPointIndependent(arg_14_0.m_nextBtn.transform, var_14_1)
end

function var_0_0.IndexItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.pages[arg_15_1]

	arg_15_2:SetData(var_15_0)
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0.list:Dispose()
	var_0_0.super.Dispose(arg_16_0)
end

function var_0_0.OnParkourReward(arg_17_0)
	arg_17_0.list:StartScroll(#arg_17_0.pages, arg_17_0.pageIndex_, true, false)
	arg_17_0:UpdateRewardIndex()
end

return var_0_0
