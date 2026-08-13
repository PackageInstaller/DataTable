class = var_0_10000

local var_0_0 = "IslandMainSeasonBtn"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandMainBaseBtn"))

function var_0_1.Init(arg_1_0)
	var_0_1.super.Init(arg_1_0)

	local var_1_0 = arg_1_0._tf

	arg_1_0.invitePanel = var_1.Find(var_1_0, "invitePanel")
	GetComponent = var_1

	local var_1_1 = arg_1_0.invitePanel
	local var_1_2 = var_2.Find(var_1_1, "Slider")

	typeof = var_1_1
	Image = var_4
	arg_1_0.inviteSlider = var_1(var_1_2, var_1_1(var_4))
	setText = var_1

	local var_1_3 = arg_1_0.invitePanel
	local var_1_4 = var_2.Find(var_1_3, "Text")

	i18n = var_1_3

	var_1(var_1_4, var_1_3("match_ui_matching_invitation"))

	FrameTimer = var_1
	arg_1_0.timer = var_1.New(function()
		local var_2_0 = arg_1_0

		var_0.RefreshInvite(var_2_0)

		return
	end, 3, -1)

	local var_1_5 = arg_1_0.timer

	var_1.Start(var_1_5)

	return
end

function var_0_1.Dispose(arg_3_0)
	if arg_3_0.timer then
		local var_3_0 = arg_3_0.timer

		var_1.Stop(var_3_0)

		arg_3_0.timer = nil
	end

	arg_3_0:StopLeanTween()
	var_0_1.super.Dispose(arg_3_0)

	return
end

function var_0_1.RefreshInvite(arg_4_0)
	getProxy = var_1_10001
	PlayRoomProxy = var_1_10002

	local var_4_0 = var_1_10001(var_1_10002)
	local var_4_1 = var_1.GetInviteList(var_4_0)

	setActive = var_4_0

	var_4_0(arg_4_0.invitePanel, var_4_1[1] ~= nil)

	if var_4_1[1] and arg_4_0.endTime ~= var_4_1[1].timestamp then
		arg_4_0.endTime = var_4_1[1].timestamp
		pg = var_2

		local var_4_2 = var_2.gameset.match_refuseCD.key_value
		local var_4_3 = arg_4_0
		local var_4_4 = arg_4_0.StartLeanTween

		pg = var_1_10005

		local var_4_5 = var_1_10005.TimeMgr.GetInstance()

		var_4_4(var_4_3, var_5.GetServerTime(var_4_5), var_4_1[1].timestamp + var_4_2)
	end

	return
end

function var_0_1.StartLeanTween(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:StopLeanTween()

	if arg_5_2 <= arg_5_1 then
		return
	end

	LeanTween = var_3

	local var_5_0 = var_3.value
	local var_5_1 = arg_5_0._tf.gameObject
	local var_5_2 = arg_5_2 - arg_5_1

	pg = var_1_10006

	local var_5_3 = var_5_0(var_5_1, var_5_2 / var_1_10006.gameset.match_refuseCD.key_value, 0, arg_5_2 - arg_5_1)
	local var_5_4 = var_3.setOnUpdate

	System = var_5

	local var_5_5 = var_5_4(var_5_3, var_5.Action_float(function(arg_6_0)
		arg_5_0.inviteSlider.fillAmount = arg_6_0

		return
	end))
	local var_5_6 = var_3.setOnComplete

	System = var_5

	var_5_6(var_5_5, var_5.Action(function()
		local var_7_0 = arg_5_0

		var_0.StopLeanTween(var_7_0)

		return
	end))

	return
end

function var_0_1.StopLeanTween(arg_8_0)
	LeanTween = var_1_10001

	var_1_10001.cancel(arg_8_0._tf.gameObject)

	return
end

return var_0_1
