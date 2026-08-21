local var_0_0 = class("ActivityNoobBpRechargeView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = Asset.Load(arg_1_0:GetUIName(arg_1_2))

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_1.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.type_ = arg_1_2

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.statusController_ = ControllerUtil.GetController(arg_1_0.transform_, "status")
	arg_1_0.typeController_ = ControllerUtil.GetController(arg_1_0.transform_, "type")
	arg_1_0.rewardItemList_ = {}
	arg_1_0.itemDataList_ = {}
	arg_1_0.rewardCfgList_ = {}
end

function var_0_0.GetUIName(arg_2_0, arg_2_1)
	if arg_2_1 == 0 then
		return "Widget/System/Activitynewbie/NewbieBpRechargeUI"
	else
		return "Widget/System/Activitynewbie/NewbieBpRechargeUI_old"
	end
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.rewardItemList_) do
		iter_3_1:Dispose()
	end

	Object.Destroy(arg_3_0.gameObject_)

	arg_3_0.gameObject_ = nil
	arg_3_0.transform_ = nil
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.sourceBtn_, nil, function()
		if TimeMgr.GetInstance():GetServerTime() < PassportData:GetStartTimestamp() then
			ShowTips("SYSTEM_LOCK")

			return
		end

		if TimeMgr.GetInstance():GetServerTime() >= PassportData:GetEndTimestamp() then
			ShowTips("NO_ACTIVE_BATTLEPASS")

			return
		end

		local var_5_0 = GameSetting.first_battle_pass_reward.value[3]

		JumpTools.JumpToPage2(var_5_0)
	end)
	arg_4_0:AddBtnListener(arg_4_0.receiveBtn_, nil, function()
		ActivityNewbieTools.ReceiveRechargeReward(3, 0, function(arg_7_0)
			arg_4_0:RefreshStatus()
		end)
	end)
end

function var_0_0.SetData(arg_8_0)
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

	if arg_8_0.typeController_ then
		arg_8_0.typeController_:SetSelectedIndex(arg_8_0.type_)
	end

	ActivityNewbieTools.SetSelectBpRecharge()
end

function var_0_0.RefreshStatus(arg_10_0)
	arg_10_0.status_ = ActivityNewbieTools.GetBpRewardStatus()

	arg_10_0.statusController_:SetSelectedIndex(arg_10_0.status_)
end

function var_0_0.SetActive(arg_11_0, arg_11_1)
	SetActive(arg_11_0.gameObject_, arg_11_1)
end

return var_0_0
