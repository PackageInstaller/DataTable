class = var_0_10000

local var_0_0 = "MainActInsBtnMellowAdapt"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainDifferentStyleSpActBtnAdapt"))

function var_0_1.GetContainer(arg_1_0)
	local var_1_0 = arg_1_0.root

	return var_1.Find(var_1_0, "left")
end

function var_0_1.OnInit(arg_2_0)
	getProxy = var_1_10001
	InstagramProxy = var_1_10002

	local var_2_0 = var_1_10001(var_1_10002)
	local var_2_1

	if not var_1.ShouldShowTip(var_2_0) then
		getProxy = var_2_1
		InstagramProxy = var_2_0
		var_2_0 = var_2_1(var_2_0)

		if not var_2_1.ShouldShowTip(var_2_0) then
			getProxy = var_2_1
			InstagramChatProxy = var_2_0
			var_2_0 = var_2_1(var_2_0)
			var_2_1 = var_2_1.ShouldShowTip(var_2_0)
		end
	end

	setActive = var_2_0

	local var_2_2 = arg_2_0._tf

	var_2_0(var_3.Find(var_2_2, "tip"), var_2_1)

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_2.Find(var_2_3, "Text")
	local var_2_5 = var_2.GetComponent

	typeof = var_4
	Text = var_5
	arg_2_0.textTr = var_2_5(var_2_4, var_4(var_5))

	local var_2_6

	if not arg_2_0.systemTimeUtil then
		SystemTimeUtil = var_2_6
		var_2_6 = var_2_6.New()
	end

	arg_2_0.systemTimeUtil = var_2_6

	arg_2_0:AddTimer()

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_2.GetComponent

	typeof = var_4
	Animation = var_5

	local var_2_9 = var_2_8(var_2_7, var_4(var_5))
	local var_2_10

	if var_2_1 then
		var_2_10 = var_2_9

		var_2_9.Play(var_2_10, "shake")
	else
		var_2_10 = var_2_9

		var_2_9.Stop(var_2_10)

		var_2_7 = arg_2_0._tf
		Vector3 = var_2_10
		var_2_7.localEulerAngles = var_2_10.zero
	end

	getProxy = var_2_7
	AppreciateProxy = var_2_10

	local var_2_11 = var_2_7(var_2_10)
	local var_2_12 = var_3.CanPlayMainMusicPlayer(var_2_11)

	setActive = var_2_11

	local var_2_13 = arg_2_0._tf

	var_2_11(var_5.Find(var_2_13, "base"), not var_2_12)

	setActive = var_2_11

	local var_2_14 = arg_2_0._tf

	var_2_11(var_5.Find(var_2_14, "music"), var_2_12)

	return
end

function var_0_1.AddTimer(arg_3_0)
	local var_3_0 = arg_3_0.systemTimeUtil

	var_1.SetUp(var_3_0, function(arg_4_0, arg_4_1, arg_4_2)
		arg_3_0.textTr.text = arg_4_0 .. ":" .. arg_4_1

		return
	end)

	return
end

function var_0_1.RemoveTimer(arg_5_0)
	if arg_5_0.systemTimeUtil then
		local var_5_0 = arg_5_0.systemTimeUtil

		var_1.Dispose(var_5_0)

		arg_5_0.systemTimeUtil = nil
	end

	return
end

function var_0_1.OnClear(arg_6_0)
	arg_6_0:RemoveTimer()

	return
end

function var_0_1.OnDisable(arg_7_0)
	arg_7_0:RemoveTimer()

	return
end

return var_0_1
