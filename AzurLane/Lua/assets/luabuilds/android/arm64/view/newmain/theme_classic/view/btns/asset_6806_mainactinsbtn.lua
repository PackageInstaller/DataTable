class = var_0_10000

local var_0_0 = "MainActInsBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainBaseSpcailActBtn"))

function var_0_1.GetContainer(arg_1_0)
	return arg_1_0.root
end

function var_0_1.InShowTime(arg_2_0)
	return true
end

function var_0_1.GetUIName(arg_3_0)
	return "MainUIInsBtn"
end

function var_0_1.OnClick(arg_4_0)
	local var_4_0 = arg_4_0.event
	local var_4_1 = var_1.emit

	NewMainMediator = var_1_10004

	var_4_1(var_4_0, var_1_10004.SKIP_INS)

	return
end

function var_0_1.OnRegister(arg_5_0)
	getAnchoredPosition = var_1_10001
	arg_5_0.initX = var_1_10001(arg_5_0._tf).x

	return
end

function var_0_1.OnInit(arg_6_0)
	local var_6_0 = arg_6_0._tf
	local var_6_1 = var_1.Find(var_6_0, "icon")
	local var_6_2 = var_1.GetComponent

	typeof = var_4
	Animator = var_1_10006
	arg_6_0.animator = var_6_2(var_6_1, var_4(var_1_10006))
	getProxy = var_1
	InstagramProxy = var_6_1

	local var_6_3 = var_1(var_6_1)
	local var_6_6

	if not var_1.ShouldShowTip(var_6_3) then
		getProxy = var_6_6
		InstagramChatProxy = var_6_3

		local var_6_4 = var_6_6(var_6_3)

		if not var_6_6.ShouldShowTip(var_6_4) then
			getProxy = var_6_6
			InstagramProxy = var_6_4

			local var_6_5 = var_6_6(var_6_4)

			var_6_6 = var_6_6.ShouldShowTip(var_6_5)
		end
	end

	local var_6_7 = arg_6_0.animator

	var_6_7.enabled = var_6_6
	setActive = var_6_7

	local var_6_8 = arg_6_0._tf

	var_6_7(var_4.Find(var_6_8, "Tip"), var_6_6)

	local var_6_9 = arg_6_0._tf

	if arg_6_0.isScale then
		Vector3 = var_6_10

		local var_6_10

		if not var_6_10(0.85, 0.85, 1) then
			Vector3 = var_6_10
			var_6_10 = var_6_10(1, 1, 1)
		end

		var_6_9.localScale = var_6_10

		local var_6_11

		if not arg_6_0.isOverflow or not (arg_6_0.initX - 200) then
			var_6_11 = arg_6_0.initX
		end

		setAnchoredPosition = var_6_10

		var_6_10(arg_6_0._tf, {
			x = var_6_11,
			y = arg_6_0.isScale and -950 or -752.5
		})

		return
	end
end

return var_0_1
