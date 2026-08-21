local var_0_0 = import("game.views.activity.Submodule.slayer.HellaSlayerRewardView")
local var_0_1 = class("HellaSlayerRewardView", var_0_0)

function var_0_1.Refresh(arg_1_0)
	local var_1_0 = 0
	local var_1_1 = 0
	local var_1_2 = 0

	for iter_1_0 = #arg_1_0.regionList, 1, -1 do
		local var_1_3 = arg_1_0.regionList[iter_1_0]
		local var_1_4 = ActivitySlayerPointRewardCfg.get_id_list_by_activity_id[var_1_3] or {}

		var_1_0 = var_1_0 + #var_1_4

		local var_1_5 = SlayerData:GetPoint(arg_1_0.slayer_activity_id, var_1_3)

		for iter_1_1, iter_1_2 in ipairs(var_1_4) do
			if var_1_5 >= ActivitySlayerPointRewardCfg[iter_1_2].need and not SlayerData:GetReceivedReward(arg_1_0.slayer_activity_id, iter_1_2) then
				var_1_2 = iter_1_0
			end
		end
	end

	local var_1_6 = var_1_1 + SlayerData:GetRewardCount(arg_1_0.slayer_activity_id)

	arg_1_0.m_receiveLab.text = var_1_6 .. "/" .. var_1_0

	local var_1_7 = #arg_1_0.regionList

	for iter_1_3 = 1, var_1_7 do
		if not arg_1_0.rewardItems[iter_1_3] then
			local var_1_8 = Object.Instantiate(arg_1_0.m_item, arg_1_0.m_content)

			arg_1_0.rewardItems[iter_1_3] = SlayerTools.GetRewardItemClass(arg_1_0.slayer_activity_id).New(var_1_8)
		end

		local var_1_9 = arg_1_0.regionList[iter_1_3]

		arg_1_0.rewardItems[iter_1_3]:SetData(arg_1_0.slayer_activity_id, var_1_9)
		arg_1_0.rewardItems[iter_1_3]:SetActive(true)
	end

	local var_1_10 = #arg_1_0.rewardItems

	for iter_1_4 = var_1_7 + 1, var_1_10 do
		arg_1_0.rewardItems[iter_1_4]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_0.m_content)

	if var_1_2 ~= 0 then
		local var_1_11 = 0
		local var_1_12 = var_1_2 - 1

		for iter_1_5 = 1, var_1_12 do
			var_1_11 = var_1_11 + (arg_1_0.rewardItems[iter_1_5] and arg_1_0.rewardItems[iter_1_5]:GetHeight() or 0)
		end

		arg_1_0.m_content.anchoredPosition = Vector2.New(0, var_1_11)
	end
end

return var_0_1
