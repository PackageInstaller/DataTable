local var_0_0 = class("XH1stSealSealItemView", ReduxView)

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
	arg_3_0:StopAnimators()

	arg_3_0.rewardController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "reward")
	arg_3_0.commonItem_ = CommonItem.New(arg_3_0.commonItemGo_)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0.commonItem_:RegistCallBack(function(arg_5_0)
		if arg_4_0.onItemClick_ ~= nil then
			arg_4_0.onItemClick_(arg_5_0)
		end
	end)
end

function var_0_0.SetItemClick(arg_6_0, arg_6_1)
	arg_6_0.onItemClick_ = arg_6_1
end

function var_0_0.AddEventListeners(arg_7_0)
	return
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.index_ = arg_8_1
	arg_8_0.id_ = arg_8_2
	arg_8_0.cfg_ = ActivitySealTicketCfg[arg_8_2]

	arg_8_0:UpdateView()
end

function var_0_0.UpdateView(arg_9_0)
	arg_9_0.commonItem_:RefreshData({
		id = arg_9_0.cfg_.reward_item_list[1][1],
		number = arg_9_0.cfg_.reward_item_list[1][2]
	})

	if XH1stSealData:HaveGotSeal(arg_9_0.cfg_.ticket_id, arg_9_0.cfg_.row, arg_9_0.cfg_.column) then
		arg_9_0.rewardController_:SetSelectedState("normal")
	else
		arg_9_0.rewardController_:SetSelectedState("seal")
	end
end

function var_0_0.EnableReward(arg_10_0)
	arg_10_0.rewardController_:SetSelectedState("normal")
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:AddEventListeners()
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_13_0)
	return
end

function var_0_0.StopAnimators(arg_14_0)
	arg_14_0.sealAnimator_:Play("sealAnimator", -1, 0)

	arg_14_0.sealAnimator_.speed = 0

	arg_14_0.linkAnimator_:Play("linkAnimator", -1, 0)

	arg_14_0.linkAnimator_.speed = 0
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0.onItemClick_ = nil
	arg_15_0.data_ = nil

	if arg_15_0.commonItem_ then
		arg_15_0.commonItem_:Dispose()

		arg_15_0.commonItem_ = nil
	end

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
