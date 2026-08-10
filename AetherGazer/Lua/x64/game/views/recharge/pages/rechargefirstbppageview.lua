local var_0_0 = import("game.views.recharge.pages.RechargePageBase")
local var_0_1 = class("ActivityNoobBpRechargeView", var_0_0)

function var_0_1.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.statusController_ = ControllerUtil.GetController(arg_1_0.transform_, "status")
	arg_1_0.typeController_ = ControllerUtil.GetController(arg_1_0.transform_, "type")
	arg_1_0.rewardItemList_ = {}
	arg_1_0.itemDataList_ = {}
	arg_1_0.rewardCfgList_ = {}
end

function var_0_1.Dispose(arg_2_0)
	var_0_1.super.Dispose(arg_2_0)

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.rewardItemList_) do
		iter_2_1:Dispose()
	end

	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.gameObject_ = nil
	arg_2_0.transform_ = nil
end

function var_0_1.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.sourceBtn_, nil, function()
		if TimeMgr.GetInstance():GetServerTime() < PassportData:GetStartTimestamp() then
			ShowTips("SYSTEM_LOCK")

			return
		end

		if TimeMgr.GetInstance():GetServerTime() >= PassportData:GetEndTimestamp() then
			ShowTips("NO_ACTIVE_BATTLEPASS")

			return
		end

		local var_4_0 = GameSetting.first_battle_pass_reward.value[3]

		JumpTools.JumpToPage2(var_4_0)
	end)
	arg_3_0:AddBtnListener(arg_3_0.receiveBtn_, nil, function()
		ActivityNewbieTools.ReceiveRechargeReward(3, 0, function(arg_6_0)
			arg_3_0:RefreshStatus()
		end)
	end)
end

function var_0_1.OnEnter(arg_7_0)
	arg_7_0:RefreshUI()
end

function var_0_1.RefreshUI(arg_8_0)
	local var_8_0 = GameSetting.first_battle_pass_reward.value

	arg_8_0.rewardCfgList_ = {}

	for iter_8_0 = 1, #var_8_0 - 1 do
		arg_8_0.rewardCfgList_[#arg_8_0.rewardCfgList_ + 1] = var_8_0[iter_8_0]
	end

	for iter_8_1, iter_8_2 in ipairs(arg_8_0.rewardCfgList_) do
		if not arg_8_0.rewardItemList_[iter_8_1] then
			local var_8_1 = arg_8_0.rewardPanelTrans_:GetChild(iter_8_1 - 1).gameObject

			arg_8_0.rewardItemList_[iter_8_1] = CommonItemView.New(var_8_1, true)
			arg_8_0.itemDataList_[iter_8_1] = clone(ItemTemplateData)
			arg_8_0.itemDataList_[iter_8_1].clickFun = function(arg_9_0)
				ShowPopItem(POP_ITEM, {
					arg_9_0.id,
					arg_9_0.number
				})
			end
		end

		arg_8_0.itemDataList_[iter_8_1].id = iter_8_2[1]
		arg_8_0.itemDataList_[iter_8_1].number = iter_8_2[2]

		arg_8_0.rewardItemList_[iter_8_1]:Show(true)
		arg_8_0.rewardItemList_[iter_8_1]:SetData(arg_8_0.itemDataList_[iter_8_1])
	end

	arg_8_0:RefreshStatus()
	arg_8_0.typeController_:SetSelectedIndex(1)
	ActivityNewbieTools.SetSelectBpRecharge()
end

function var_0_1.Show(arg_10_0)
	SetActive(arg_10_0.gameObject_, true)
	arg_10_0:RefreshUI()
end

function var_0_1.RefreshStatus(arg_11_0)
	arg_11_0.status_ = ActivityNewbieTools.GetBpRewardStatus()

	arg_11_0.statusController_:SetSelectedIndex(arg_11_0.status_)
end

return var_0_1
