local var_0_0 = class("MoonPartyVisitItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.commonPortrait_ = CommonHeadPortrait.New(arg_2_0.headItem_)
	arg_2_0.statusController_ = ControllerUtil.GetController(arg_2_0.transform_, "status")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.visitBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_3_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		MoonCakeData:SetTempVisitIndex(arg_3_0.activityID_, arg_3_0.type_, arg_3_0.index_)

		local var_4_0 = arg_3_0.visitorData_.uid
		local var_4_1

		if arg_3_0.type_ == MoonCakeConst.VISIT_TYPE.ALL then
			var_4_1 = MoonCakeConst.VISIT_WAY.ALL
		else
			var_4_1 = MoonCakeConst.VISIT_WAY.FRIEND
		end

		MoonCakeAction.VisitParty(arg_3_0.activityID_, var_4_0, var_4_1)
	end)
	arg_3_0:AddBtnListener(arg_3_0.headBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_3_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		ForeignInfoAction:TryToCheckForeignDetailInfo(arg_3_0.visitorData_.uid)
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_0.type_ = arg_6_1
	arg_6_0.index_ = arg_6_2
	arg_6_0.visitorData_ = arg_6_3
	arg_6_0.activityID_ = arg_6_4

	arg_6_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0:RefreshPrincipal()
	arg_7_0:RefreshStatus()
end

function var_0_0.RefreshPrincipal(arg_8_0)
	arg_8_0.userName_.text = arg_8_0.visitorData_.nick
	arg_8_0.userLevel_.text = "LV." .. arg_8_0.visitorData_.level

	arg_8_0.commonPortrait_:RenderHead(arg_8_0.visitorData_.portrait)
	arg_8_0.commonPortrait_:RenderFrame(arg_8_0.visitorData_.frame)
end

function var_0_0.RefreshStatus(arg_9_0)
	local var_9_0 = arg_9_0.visitorData_.isVisited

	arg_9_0.statusController_:SetSelectedState(var_9_0 == true and "off" or "on")
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.commonPortrait_:Dispose()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
