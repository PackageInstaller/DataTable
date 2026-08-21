local var_0_0 = class("SlayerFoldItem_3_6", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:InitRewardItem()

	arg_3_0.buttonController = ControllerUtil.GetController(arg_3_0.m_btnController, "stateBtn")
end

function var_0_0.InitRewardItem(arg_4_0)
	arg_4_0.rewardItemList = {}
	arg_4_0.itemDataList = {}

	local var_4_0 = arg_4_0.m_rewardPanelTrans.childCount

	for iter_4_0 = 1, var_4_0 do
		arg_4_0.rewardItemList[iter_4_0] = CommonItemView.New(arg_4_0.m_rewardPanelTrans:GetChild(iter_4_0 - 1).gameObject)
		arg_4_0.itemDataList[iter_4_0] = clone(ItemTemplateData)
		arg_4_0.itemDataList[iter_4_0].clickFun = function(arg_5_0)
			ShowPopItem(POP_ITEM, {
				arg_5_0.id,
				arg_5_0.number
			})
		end
	end
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.m_receiveBtn, nil, function()
		SlayerAction.QueryPointReward(arg_6_0.slayer_activity_id, arg_6_0.pointRewardId)
	end)
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.slayer_activity_id = arg_8_1
	arg_8_0.pointRewardId = arg_8_2

	arg_8_0:RefreshDesc()
	arg_8_0:RefreshRewardItem()
	arg_8_0:RefreshState()
end

function var_0_0.RefreshRewardItem(arg_9_0)
	local var_9_0 = ActivitySlayerPointRewardCfg[arg_9_0.pointRewardId]
	local var_9_1 = SlayerData:GetReceivedReward(arg_9_0.slayer_activity_id, arg_9_0.pointRewardId)

	for iter_9_0, iter_9_1 in ipairs(var_9_0.reward_item_list) do
		arg_9_0.itemDataList[iter_9_0].id = iter_9_1[1]
		arg_9_0.itemDataList[iter_9_0].number = iter_9_1[2]

		arg_9_0.rewardItemList[iter_9_0]:SetData(arg_9_0.itemDataList[iter_9_0])
		arg_9_0.rewardItemList[iter_9_0]:RefreshGray(var_9_1)
	end

	for iter_9_2 = #var_9_0.reward_item_list + 1, #arg_9_0.rewardItemList do
		arg_9_0.rewardItemList[iter_9_2]:SetData(nil)
	end
end

function var_0_0.RefreshState(arg_10_0)
	local var_10_0 = ActivitySlayerPointRewardCfg[arg_10_0.pointRewardId]
	local var_10_1 = SlayerData:GetPoint(arg_10_0.slayer_activity_id, var_10_0.activity_id)

	if SlayerData:GetReceivedReward(arg_10_0.slayer_activity_id, arg_10_0.pointRewardId) then
		arg_10_0.buttonController:SetSelectedIndex(2)
	elseif var_10_1 >= var_10_0.need then
		arg_10_0.buttonController:SetSelectedIndex(0)
	else
		arg_10_0.buttonController:SetSelectedIndex(1)
	end
end

function var_0_0.RefreshDesc(arg_11_0)
	local var_11_0 = ActivitySlayerPointRewardCfg[arg_11_0.pointRewardId]

	arg_11_0.m_pointLab.text = var_11_0 and var_11_0.need or ""
end

function var_0_0.Dispose(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.rewardItemList) do
		iter_12_1:Dispose()
	end

	arg_12_0.rewardItemList = nil

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
