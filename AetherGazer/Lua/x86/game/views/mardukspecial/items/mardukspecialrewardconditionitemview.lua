local var_0_0 = class("MardukSpecialRewardConditionItemView", ReduxView)

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
	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.uilistGo_, FactorySoloChallengeRewardCommonItem)
end

function var_0_0.indexItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:SetData(arg_4_0.cfg_.reward_item_list[arg_4_1], POP_ITEM)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.getBtn_, nil, function()
		ActivityAction.GetBonus({
			arg_5_0.rewardId_
		})
	end)
end

function var_0_0.AddEventListeners(arg_7_0)
	arg_7_0:RegistEventListener(MARDUK_SPECIAL_REWARD_UPDATE, function(arg_8_0)
		if table.indexof(arg_8_0, arg_7_0.rewardId_) then
			arg_7_0:UpdateView()
		end
	end)
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0.activityId_ = arg_9_3
	arg_9_0.index_ = arg_9_1
	arg_9_0.rewardId_ = arg_9_2
	arg_9_0.cfg_ = ActivityPointRewardCfg[arg_9_2]

	arg_9_0:UpdateView()
end

function var_0_0.UpdateView(arg_10_0)
	arg_10_0.conditionLabel_.text = string.format(GetTips("FACTORY_ACTIVITY_POINT_REWARD"), arg_10_0.cfg_.need)

	arg_10_0.uiList_:StartScroll(#arg_10_0.cfg_.reward_item_list)

	local var_10_0 = MardukSpecialData:GetPoint(arg_10_0.activityId_)

	if MardukSpecialData:HaveGotReward(arg_10_0.activityId_, arg_10_0.rewardId_) then
		arg_10_0.statusController_:SetSelectedState("haveGet")
	elseif var_10_0 >= arg_10_0.cfg_.need then
		arg_10_0.statusController_:SetSelectedState("canGet")
	else
		arg_10_0.statusController_:SetSelectedState("unFinish")
	end
end

function var_0_0.OnEnter(arg_11_0)
	return
end

function var_0_0.OnExit(arg_12_0)
	return
end

function var_0_0.OnMainHomeViewTop(arg_13_0)
	return
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0:RemoveAllEventListener()

	arg_14_0.data_ = nil

	if arg_14_0.uiList_ then
		arg_14_0.uiList_:Dispose()

		arg_14_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
