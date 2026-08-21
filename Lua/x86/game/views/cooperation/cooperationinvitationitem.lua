local var_0_0 = class("CooperationInvitationItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.commonPortrait_ = CommonHeadPortrait.New(arg_2_0.headItem_)

	arg_2_0:AddUIListener()

	arg_2_0.stateController_ = arg_2_0.controlerEx_:GetController("state")
	arg_2_0.onlineController_ = ControllerUtil.GetController(arg_2_0.transform_, "online")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(nil, arg_4_0.invitBtn_, function()
		local var_5_0 = CooperationData:GetRoomData()
		local var_5_1 = var_5_0.activity_id

		if var_5_0:IsFull() then
			ShowTips("COOPERATION_NO_ALLOW_INVITE_FULL")

			return
		end

		if not CooperationTools.IsInvitationValid(var_5_1, arg_4_0.uid, arg_4_0.playerData_.activity_data_list) then
			return
		end

		CooperationAction.InvitePlayer(arg_4_0.uid, arg_4_0.type)
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.index_ = arg_6_1
	arg_6_0.type = arg_6_2
	arg_6_0.playerData_ = arg_6_3
	arg_6_0.nameText_.text = arg_6_3.nick

	local var_6_0 = arg_6_3.icon_frame ~= 0 and arg_6_3.icon_frame or 2001

	arg_6_0.commonPortrait_:RenderHead(arg_6_3.icon)
	arg_6_0.commonPortrait_:RenderFrame(var_6_0)

	local var_6_1 = arg_6_3.timestamp or 0

	arg_6_0.uid = arg_6_3.uid

	if var_6_1 == 0 then
		arg_6_0.onlineController_:SetSelectedIndex(0)
	else
		arg_6_0.offlineText_.text = manager.time:GetOnLineText(var_6_1)

		arg_6_0.onlineController_:SetSelectedIndex(1)
	end

	arg_6_0:UpdateState()
end

function var_0_0.UpdateState(arg_7_0)
	local var_7_0 = CooperationData:GetRoomData().activity_id

	if CooperationData:GetHadInvited(arg_7_0.uid) then
		arg_7_0.stateController_:SetSelectedIndex(1)
	elseif not CooperationTools.IsInvitationValid(var_7_0, arg_7_0.uid, arg_7_0.playerData_.activity_data_list) then
		arg_7_0.stateController_:SetSelectedIndex(2)
	else
		arg_7_0.stateController_:SetSelectedIndex(0)
	end
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.commonPortrait_:Dispose()
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
