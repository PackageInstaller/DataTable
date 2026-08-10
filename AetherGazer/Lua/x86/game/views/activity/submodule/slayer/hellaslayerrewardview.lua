local var_0_0 = class("HellaSlayerRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return SlayerTools.GetRewardUIName(arg_1_0.params_.slayer_activity_id or 61131)
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

	arg_4_0.rewardItems = {}
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_maskBtn, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.slayer_activity_id = arg_7_0.params_.slayer_activity_id or 61131

	local var_7_0 = ActivityCfg[arg_7_0.slayer_activity_id]

	if arg_7_0:IsOpenRoute("slayerSctionInfo") and arg_7_0.params_.region_activity_id then
		arg_7_0.regionList = {
			arg_7_0.params_.region_activity_id
		}

		SetActive(arg_7_0.m_receiveLab.gameObject, false)
	else
		arg_7_0.regionList = var_7_0 and var_7_0.sub_activity_list or {}

		SetActive(arg_7_0.m_receiveLab.gameObject, true)
	end

	arg_7_0:Refresh()
end

function var_0_0.Refresh(arg_8_0)
	local var_8_0 = 0
	local var_8_1 = 0
	local var_8_2 = 1

	for iter_8_0 = #arg_8_0.regionList, 1, -1 do
		local var_8_3 = arg_8_0.regionList[iter_8_0]
		local var_8_4 = ActivitySlayerPointRewardCfg.get_id_list_by_activity_id[var_8_3] or {}

		var_8_0 = var_8_0 + #var_8_4

		local var_8_5 = SlayerData:GetPoint(arg_8_0.slayer_activity_id, var_8_3)

		for iter_8_1, iter_8_2 in ipairs(var_8_4) do
			if var_8_5 >= ActivitySlayerPointRewardCfg[iter_8_2].need and not SlayerData:GetReceivedReward(arg_8_0.slayer_activity_id, iter_8_2) then
				var_8_2 = iter_8_0
			end
		end
	end

	local var_8_6 = var_8_1 + SlayerData:GetRewardCount(arg_8_0.slayer_activity_id)

	arg_8_0.m_receiveLab.text = var_8_6 .. "/" .. var_8_0

	local var_8_7 = #arg_8_0.regionList

	for iter_8_3 = 1, var_8_7 do
		if not arg_8_0.rewardItems[iter_8_3] then
			local var_8_8 = Object.Instantiate(arg_8_0.m_item, arg_8_0.m_content)

			arg_8_0.rewardItems[iter_8_3] = SlayerTools.GetRewardItemClass(arg_8_0.slayer_activity_id).New(var_8_8)
		end

		local var_8_9 = arg_8_0.regionList[iter_8_3]

		arg_8_0.rewardItems[iter_8_3]:SetData(arg_8_0.slayer_activity_id, var_8_9)
		arg_8_0.rewardItems[iter_8_3]:SetActive(true)
	end

	local var_8_10 = #arg_8_0.rewardItems

	for iter_8_4 = var_8_7 + 1, var_8_10 do
		arg_8_0.rewardItems[iter_8_4]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.m_content)

	if var_8_2 ~= 0 then
		local var_8_11 = 0
		local var_8_12 = var_8_2 - 1

		for iter_8_5 = 1, var_8_12 do
			var_8_11 = var_8_11 + (arg_8_0.rewardItems[iter_8_5] and arg_8_0.rewardItems[iter_8_5]:GetHeight() or 0)
		end

		arg_8_0.m_content.anchoredPosition = Vector2.New(0, var_8_11)
	end
end

function var_0_0.Dispose(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.rewardItems) do
		iter_9_1:Dispose()
	end

	arg_9_0.rewardItems = {}

	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.OnSlayerReward(arg_10_0)
	arg_10_0:Refresh()
end

return var_0_0
