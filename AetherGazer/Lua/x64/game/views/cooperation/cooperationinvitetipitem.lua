local var_0_0 = class("CooperationInviteTipItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.commonPortrait_ = CommonHeadPortrait.New(arg_2_0.headItem_)

	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.isShow = false

	SetActive(arg_3_0.gameObject_, false)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(nil, arg_4_0.m_okBtn, function()
		if arg_4_0.inviteTip then
			local var_5_0 = arg_4_0.inviteTip.invite.uid

			CooperationAction.ReceiveInvite(var_5_0)
		end

		CooperationData:ClearNewInviteTip()
		arg_4_0:Hide()
		manager.redPoint:setTip(RedPointConst.COOPERATION_INVIT, 0)
	end)
	arg_4_0:AddBtnListener(nil, arg_4_0.m_cancelBtn, function()
		if arg_4_0.inviteTip then
			local var_6_0 = arg_4_0.inviteTip.invite.uid

			CooperationAction.DelectInvite({
				var_6_0
			})
		end

		CooperationData:ClearNewInviteTip()
		arg_4_0:HideInvite()
		manager.redPoint:setTip(RedPointConst.COOPERATION_INVIT, 0)
	end)
end

function var_0_0.Show(arg_7_0)
	if not arg_7_0.isShow then
		arg_7_0:RegistEventListener(COOPERATION_NEW_INVITE, function()
			arg_7_0:Check()
		end)

		arg_7_0.isShow = true
	end

	arg_7_0:Check()
end

function var_0_0.Hide(arg_9_0)
	if arg_9_0.isShow then
		arg_9_0:RemoveAllEventListener()

		arg_9_0.isShow = false
	end

	arg_9_0:HideInvite()
end

function var_0_0.HideInvite(arg_10_0)
	if arg_10_0.timer_ then
		arg_10_0.timer_:Stop()

		arg_10_0.timer_ = nil
	end

	SetActive(arg_10_0.gameObject_, false)
end

function var_0_0.Check(arg_11_0)
	if manager.guide:IsPlaying() then
		arg_11_0:HideInvite()

		return
	end

	arg_11_0.inviteTip = CooperationData:GetNewInviteTip()

	local var_11_0 = manager.time:GetServerTime()

	if not arg_11_0.inviteTip or var_11_0 > arg_11_0.inviteTip.overdue_time then
		arg_11_0:HideInvite()

		return
	end

	local var_11_1 = arg_11_0.inviteTip.invite

	arg_11_0.m_name.text = var_11_1.nick

	arg_11_0.commonPortrait_:RenderHead(var_11_1.icon)
	arg_11_0.commonPortrait_:RenderFrame(var_11_1.icon_frame)

	local var_11_2 = arg_11_0.inviteTip.overdue_time - var_11_0

	arg_11_0.m_des.text = var_11_2

	SetActive(arg_11_0.gameObject_, true)

	if arg_11_0.timer_ == nil then
		arg_11_0.timer_ = Timer.New(function()
			arg_11_0:Process()
		end, 1, -1)
	end

	arg_11_0.timer_:Start()
	arg_11_0:Process()
end

function var_0_0.Process(arg_13_0)
	local var_13_0 = manager.time:GetServerTime()

	if not arg_13_0.inviteTip or var_13_0 > arg_13_0.inviteTip.overdue_time then
		arg_13_0:HideInvite()

		return
	end

	local var_13_1 = arg_13_0.inviteTip.overdue_time - var_13_0

	arg_13_0.m_des.text = string.format(GetTips("ACTIVITY_STRONGHOLD_INVITED"), var_13_1)
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.commonPortrait_:Dispose()

	arg_14_0.commonPortrait_ = nil

	if arg_14_0.timer_ then
		arg_14_0.timer_:Stop()

		arg_14_0.timer_ = nil
	end

	arg_14_0:RemoveAllEventListener()

	arg_14_0.isShow = false

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
