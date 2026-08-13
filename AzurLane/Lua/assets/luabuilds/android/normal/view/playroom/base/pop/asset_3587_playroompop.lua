class = var_0_10000

local var_0_0 = "PlayRoomPop"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BasePanel"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_1.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	PlayRoomInvitePop = var_1_10001

	local var_2_0 = var_1_10001.New
	local var_2_1 = arg_2_0._tf

	arg_2_0.playRoomInvitePop = var_2_0(var_2.Find(var_2_1, "invitePanel"), arg_2_0._parentClass)
	PlayRoomMatchPop = var_1

	local var_2_2 = var_1.New
	local var_2_3 = arg_2_0._tf

	arg_2_0.playRoomMatchPop = var_2_2(var_2.Find(var_2_3, "matchPanel"), arg_2_0._parentClass)

	return
end

function var_0_1.didEnter(arg_3_0)
	setParent = var_1_10001

	local var_3_0 = arg_3_0._go

	pg = var_1_10003

	var_1_10001(var_3_0, var_1_10003.UIMgr.GetInstance().OverlayToast)

	local var_3_1 = arg_3_0.playRoomInvitePop

	var_1.Hide(var_3_1)

	local var_3_2 = arg_3_0.playRoomMatchPop

	var_1.Hide(var_3_2)
	arg_3_0:RefreshUI()

	Timer = var_1
	arg_3_0.timer = var_1.New(function()
		local var_4_0 = arg_3_0

		var_0.RefreshUI(var_4_0)

		return
	end, 0.5, -1)

	local var_3_3 = arg_3_0.timer

	var_1.Start(var_3_3)

	local var_3_4 = arg_3_0.playRoomInvitePop

	var_1.didEnter(var_3_4)

	local var_3_5 = arg_3_0.playRoomMatchPop

	var_1.didEnter(var_3_5)

	return
end

function var_0_1.RefreshUI(arg_5_0)
	getProxy = var_1_10001
	PlayRoomProxy = var_1_10002

	local var_5_0 = var_1_10001(var_1_10002)

	if var_1.GetMatchFlag(var_5_0) then
		local var_5_1 = arg_5_0.playRoomMatchPop

		var_1.RefreshMatch(var_5_1)

		local var_5_2 = arg_5_0.playRoomInvitePop

		var_1.Show(var_5_2, false)
	else
		local var_5_3 = arg_5_0.playRoomInvitePop

		var_1.RefreshInvite(var_5_3)

		local var_5_4 = arg_5_0.playRoomMatchPop

		var_1.Show(var_5_4, false)
	end

	return
end

function var_0_1.willExit(arg_6_0)
	if arg_6_0.timer then
		local var_6_0 = arg_6_0.timer

		var_1.Stop(var_6_0)

		arg_6_0.timer = nil
	end

	arg_6_0:detach()

	local var_6_1 = arg_6_0.playRoomInvitePop

	var_1.willExit(var_6_1)

	arg_6_0.playRoomInvitePop = nil

	local var_6_2 = arg_6_0.playRoomMatchPop

	var_1.willExit(var_6_2)

	arg_6_0.playRoomMatchPop = nil
	Object = var_1

	var_1.Destroy(arg_6_0._go)

	return
end

function var_0_1.Show(arg_7_0, arg_7_1)
	setActive = var_1_10002

	var_1_10002(arg_7_0._go, arg_7_1)

	local var_7_0 = arg_7_0.playRoomInvitePop

	var_2.Hide(var_7_0, false)

	local var_7_1 = arg_7_0.playRoomMatchPop

	var_2.Hide(var_7_1, false)

	return
end

return var_0_1
