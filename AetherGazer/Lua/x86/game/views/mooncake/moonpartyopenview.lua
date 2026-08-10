local var_0_0 = class("MoonPartyOpenView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonPartyOpenUI"
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

	arg_4_0.selectController_ = ControllerUtil.GetController(arg_4_0.transform_, "select")
	arg_4_0.planController1_ = ControllerUtil.GetController(arg_4_0.planTrans1_, "status")
	arg_4_0.planController2_ = ControllerUtil.GetController(arg_4_0.planTrans2_, "status")
end

function var_0_0.AddUIListener(arg_5_0)
	for iter_5_0 = 1, 2 do
		arg_5_0:AddBtnListener(arg_5_0[string.format("planBtn%d_", iter_5_0)], nil, function()
			if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
				ShowTips("TIME_OVER")

				return
			end

			arg_5_0:SelectPlan(iter_5_0)
		end)
	end

	arg_5_0:AddBtnListener(arg_5_0.confirmBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if arg_5_0.selectPlan_ == 0 then
			return
		end

		ShowMessageBox({
			title = GetTips("COMFIRM"),
			content = GetTips("MID_AUTUMN_FESTIVAL_PARTY_BEGIN"),
			OkCallback = function()
				MoonCakeAction.OpenParty(arg_5_0.activityID_, arg_5_0.selectPlan_)
			end
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.cancelBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.activityID_ = arg_11_0.params_.activityID

	local var_11_0, var_11_1, var_11_2 = MoonCakeTools.CheckPartyPlanValid(arg_11_0.activityID_, MoonCakeConst.PARTY_TYPE.CAKE)

	arg_11_0.planDescText1_.text = string.format(GetTips("MID_AUTUMN_FESTIVAL_PARTY_CONSUME_1"), var_11_2)
	arg_11_0.progressText1_.text = string.format(GetTips("%d/%d"), var_11_1, var_11_2)

	arg_11_0.planController1_:SetSelectedState(var_11_0 and "on" or "off")

	local var_11_3, var_11_4, var_11_5 = MoonCakeTools.CheckPartyPlanValid(arg_11_0.activityID_, MoonCakeConst.PARTY_TYPE.VISIT)

	arg_11_0.planDescText2_.text = string.format(GetTips("MID_AUTUMN_FESTIVAL_PARTY_CONSUME_2"), var_11_5)
	arg_11_0.progressText2_.text = string.format(GetTips("MID_AUTUMN_FESTIVAL_PARTY_CONSUME_PROGRESS"), var_11_4, var_11_5)

	arg_11_0.planController2_:SetSelectedState(var_11_3 and "on" or "off")

	arg_11_0.selectPlan_ = 0

	if var_11_0 then
		arg_11_0.selectPlan_ = 1
	elseif var_11_3 then
		arg_11_0.selectPlan_ = 2
	end

	arg_11_0:SelectPlan(arg_11_0.selectPlan_)
	arg_11_0:BindRedPoint()
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0:UnBindRedPoint()
end

function var_0_0.SelectPlan(arg_13_0, arg_13_1)
	arg_13_0.selectPlan_ = arg_13_1

	arg_13_0.selectController_:SetSelectedIndex(arg_13_1)
end

function var_0_0.OnPartyOpen(arg_14_0)
	arg_14_0:Back()
end

function var_0_0.OnPartyReset(arg_15_0)
	if not manager.messageBox:GetIsAllFree() then
		manager.messageBox:HideAll()
	end
end

function var_0_0.BindRedPoint(arg_16_0)
	local var_16_0 = string.format("%s_%s", RedPointConst.MOON_PARTY_OPEN, arg_16_0.activityID_)

	manager.redPoint:bindUIandKey(arg_16_0.confirmBtn_.transform, var_16_0)
end

function var_0_0.UnBindRedPoint(arg_17_0)
	local var_17_0 = string.format("%s_%s", RedPointConst.MOON_PARTY_OPEN, arg_17_0.activityID_)

	manager.redPoint:unbindUIandKey(arg_17_0.confirmBtn_.transform, var_17_0)
end

return var_0_0
