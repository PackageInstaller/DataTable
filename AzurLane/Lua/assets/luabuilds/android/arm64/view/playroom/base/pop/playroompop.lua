local var_0_0 = class("PlayRoomPop", import("view.base.BasePanel"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_0.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	arg_2_0.playRoomInvitePop = PlayRoomInvitePop.New(arg_2_0._tf:Find("invitePanel"), arg_2_0._parentClass)
	arg_2_0.playRoomMatchPop = PlayRoomMatchPop.New(arg_2_0._tf:Find("matchPanel"), arg_2_0._parentClass)

	return
end

function var_0_0.didEnter(arg_3_0)
	setParent(arg_3_0._go, pg.UIMgr.GetInstance().OverlayToast)
	arg_3_0.playRoomInvitePop:Hide()
	arg_3_0.playRoomMatchPop:Hide()
	arg_3_0:RefreshUI()

	arg_3_0.timer = Timer.New(function()
		arg_3_0:RefreshUI()

		return
	end, 0.5, -1)

	arg_3_0.timer:Start()
	arg_3_0.playRoomInvitePop:didEnter()
	arg_3_0.playRoomMatchPop:didEnter()

	return
end

function var_0_0.RefreshUI(arg_5_0)
	if getProxy(PlayRoomProxy):GetMatchFlag() then
		arg_5_0.playRoomMatchPop:RefreshMatch()
		arg_5_0.playRoomInvitePop:Show(false)
	else
		arg_5_0.playRoomInvitePop:RefreshInvite()
		arg_5_0.playRoomMatchPop:Show(false)
	end

	return
end

function var_0_0.willExit(arg_6_0)
	if arg_6_0.timer then
		arg_6_0.timer:Stop()

		arg_6_0.timer = nil
	end

	arg_6_0:detach()
	arg_6_0.playRoomInvitePop:willExit()

	arg_6_0.playRoomInvitePop = nil

	arg_6_0.playRoomMatchPop:willExit()

	arg_6_0.playRoomMatchPop = nil

	Object.Destroy(arg_6_0._go)

	return
end

function var_0_0.Show(arg_7_0, arg_7_1)
	setActive(arg_7_0._go, arg_7_1)
	arg_7_0.playRoomInvitePop:Hide(false)
	arg_7_0.playRoomMatchPop:Hide(false)

	return
end

return var_0_0
