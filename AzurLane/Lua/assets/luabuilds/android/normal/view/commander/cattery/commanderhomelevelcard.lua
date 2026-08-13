class = var_0_10000

local var_0_0 = var_0_10000("CommanderHomeLevelCard")
local var_0_1 = "#9A9898"
local var_0_2 = "#a59897"
local var_0_3 = "#6a5a5a"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.view = arg_1_2
	findTF = var_3

	local var_1_0 = var_3(arg_1_0._tf, "mask")
	local var_1_1 = var_3.GetComponent

	typeof = var_5
	RectMask2D = var_1_10006
	arg_1_0.mask = var_1_1(var_1_0, var_5(var_1_10006))
	findTF = var_3
	arg_1_0.progress = var_3(arg_1_0._tf, "mask/progress/bar")
	findTF = var_3
	arg_1_0.unlockTF = var_3(arg_1_0._tf, "unlock")
	findTF = var_3
	arg_1_0.doingTF = var_3(arg_1_0._tf, "doing")
	findTF = var_3
	arg_1_0.lockTF = var_3(arg_1_0._tf, "lock")
	findTF = var_3

	local var_1_2 = var_3(arg_1_0._tf, "level")
	local var_1_3 = var_3.GetComponent

	typeof = var_5
	Text = var_1_10006
	arg_1_0.levelTxt = var_1_3(var_1_2, var_5(var_1_10006))
	findTF = var_3
	arg_1_0.descUnLockIcon = var_3(arg_1_0._tf, "desc/icon_pass")
	findTF = var_3
	arg_1_0.descDoingIcon = var_3(arg_1_0._tf, "desc/icon_doing")
	findTF = var_3

	local var_1_4 = var_3(arg_1_0._tf, "desc/Text")
	local var_1_5 = var_3.GetComponent

	typeof = var_5
	Text = var_1_10006
	arg_1_0.descTxt = var_1_5(var_1_4, var_5(var_1_10006))
	findTF = var_3

	local var_1_6 = var_3(arg_1_0._tf, "exp")
	local var_1_7 = var_3.GetComponent

	typeof = var_5
	Text = var_1_10006
	arg_1_0.expTxt = var_1_7(var_1_6, var_5(var_1_10006))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:Clear()

	arg_2_0.home = arg_2_1
	arg_2_0.config = arg_2_2

	local var_2_0 = arg_2_2.level
	local var_2_1 = arg_2_0.mask

	var_2_1.enabled = arg_2_2.tail == true
	setActive = var_2_1

	var_2_1(arg_2_0.unlockTF, false)

	setActive = var_2_1

	var_2_1(arg_2_0.doingTF, false)

	setActive = var_2_1

	var_2_1(arg_2_0.lockTF, false)

	setActive = var_2_1

	var_2_1(arg_2_0.descUnLockIcon, false)

	setActive = var_2_1

	var_2_1(arg_2_0.descDoingIcon, false)

	local var_2_2
	local var_2_3

	if arg_2_1.level + 1 == arg_2_2.level then
		var_2_3 = arg_2_0

		arg_2_0.UpdateDoingState(var_2_3)

		var_2_2 = var_0_3
	elseif arg_2_1.level < arg_2_2.level then
		var_2_3 = arg_2_0

		arg_2_0.UpdateLockState(var_2_3)

		var_2_2 = var_0_1
	else
		local var_2_4 = arg_2_1.level

		if arg_2_2.level <= var_2_4 then
			var_2_3 = arg_2_0

			arg_2_0.UpdateUnlockState(var_2_3)

			var_2_2 = var_0_2
		end
	end

	local var_2_5 = arg_2_0.levelTxt

	setColorStr = var_2_3
	var_2_5.text = var_2_3("LV." .. arg_2_2.level, var_2_2)

	local var_2_6 = arg_2_0.descTxt

	setColorStr = var_6
	shortenString = var_7
	var_2_6.text = var_6(var_7(arg_2_2.desc, 12), var_2_2)

	local var_2_7 = arg_2_0.expTxt

	setColorStr = var_6
	var_2_7.text = var_6(arg_2_2.totalExp, var_2_2)

	return
end

function var_0_0.UpdateLockState(arg_3_0)
	setFillAmount = var_1_10001

	var_1_10001(arg_3_0.progress, 0)

	setActive = var_1_10001

	var_1_10001(arg_3_0.lockTF, true)

	onButton = var_1_10001

	local var_3_0
	local var_3_1 = arg_3_0.lockTF

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.ShowDesc(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	return
end

function var_0_0.UpdateDoingState(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.commander_home[arg_5_0.config.level - 1]
	local var_5_1 = 0

	if var_5_0 then
		var_5_1 = var_5_0.home_exp
	end

	setFillAmount = var_1_10003

	var_1_10003(arg_5_0.progress, arg_5_0.home.exp / var_5_1)

	setActive = var_1_10003

	var_1_10003(arg_5_0.doingTF, true)

	setActive = var_1_10003

	var_1_10003(arg_5_0.descDoingIcon, true)

	onButton = var_1_10003

	local var_5_2
	local var_5_3 = arg_5_0.doingTF

	local function var_5_4()
		local var_6_0 = arg_5_0

		var_0.ShowDesc(var_6_0)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10003(var_5_2, var_5_3, var_5_4, var_1_10007)

	return
end

function var_0_0.UpdateUnlockState(arg_7_0)
	setFillAmount = var_1_10001

	var_1_10001(arg_7_0.progress, 1)

	setActive = var_1_10001

	var_1_10001(arg_7_0.unlockTF, true)

	setActive = var_1_10001

	var_1_10001(arg_7_0.descUnLockIcon, true)

	onButton = var_1_10001

	local var_7_0
	local var_7_1 = arg_7_0.unlockTF

	local function var_7_2()
		local var_8_0 = arg_7_0

		var_0.ShowDesc(var_8_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_0, var_7_1, var_7_2, var_1_10005)

	return
end

function var_0_0.ShowDesc(arg_9_0)
	local var_9_0 = arg_9_0.view

	var_1.ShowDescWindow(var_9_0, arg_9_0.config.desc, arg_9_0.config.level)

	return
end

function var_0_0.Clear(arg_10_0)
	removeOnButton = var_1_10001

	var_1_10001(arg_10_0.lockTF)

	removeOnButton = var_1_10001

	var_1_10001(arg_10_0.doingTF)

	removeOnButton = var_1_10001

	var_1_10001(arg_10_0.unlockTF)

	return
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:Clear()

	return
end

return var_0_0
