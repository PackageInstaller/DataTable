local var_0_0 = class("FishingRewardItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
	arg_2_0:AddEventListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.statusController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "status")
	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.bonusListGo_, CommonItem)
end

function var_0_0.indexItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:RegistCallBack(function(arg_5_0)
		ShowPopItem(POP_ITEM, {
			arg_5_0.id
		})
	end)
	arg_4_2:RefreshData({
		id = arg_4_0.cfg_.reward_item_list[arg_4_1][1],
		number = arg_4_0.cfg_.reward_item_list[arg_4_1][2]
	})
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.getBtn_, nil, function()
		FishingAction.GetBonus(ActivityConst.SUMMER_FISHING, arg_6_0.id_)
	end)
end

function var_0_0.AddEventListeners(arg_8_0)
	return
end

function var_0_0.OnTop(arg_9_0)
	arg_9_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_10_0)
	return
end

function var_0_0.SetId(arg_11_0, arg_11_1)
	arg_11_0.id_ = arg_11_1
	arg_11_0.cfg_ = ActivityPointRewardCfg[arg_11_1]

	arg_11_0:UpdateView()
end

function var_0_0.UpdateView(arg_12_0)
	arg_12_0.uiList_:StartScroll(#arg_12_0.cfg_.reward_item_list)

	arg_12_0.conditionLabel_.text = tostring(arg_12_0.cfg_.need)

	local var_12_0 = 0
	local var_12_1 = FishingData:GetActivityData()

	if var_12_1 then
		var_12_0 = var_12_1.score
	end

	if var_12_0 < arg_12_0.cfg_.need then
		arg_12_0.statusController_:SetSelectedState("cannotGet")
	else
		local var_12_2 = FishingData:GetActivityData().received_award_list

		if table.indexof(var_12_2, arg_12_0.cfg_.id) then
			arg_12_0.statusController_:SetSelectedState("haveGet")
		else
			arg_12_0.statusController_:SetSelectedState("canGet")
		end
	end
end

function var_0_0.OnEnter(arg_13_0)
	return
end

function var_0_0.OnExit(arg_14_0)
	return
end

function var_0_0.OnMainHomeViewTop(arg_15_0)
	return
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0:RemoveAllEventListener()

	if arg_16_0.uiList_ then
		arg_16_0.uiList_:Dispose()

		arg_16_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
