class = var_0_10000

local var_0_0 = "MainPlayerInfoBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainBaseBtn"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	findTF = var_3
	arg_1_0.playerInfoBtn = var_3(arg_1_0._tf, "iconBack")
	findTF = var_3

	local var_1_0 = var_3(arg_1_0._tf, "name")
	local var_1_1 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.playerNameTxt = var_1_1(var_1_0, var_6(var_1_10008))
	findTF = var_3

	local var_1_2 = var_3(arg_1_0._tf, "level")
	local var_1_3 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.playerLevelTxt = var_1_3(var_1_2, var_6(var_1_10008))
	findTF = var_3

	local var_1_4 = var_3(arg_1_0._tf, "exp")
	local var_1_5 = var_3.GetComponent

	typeof = var_6
	Slider = var_1_10008
	arg_1_0.expSlider = var_1_5(var_1_4, var_6(var_1_10008))

	return
end

function var_0_1.GetTarget(arg_2_0)
	return arg_2_0.playerInfoBtn
end

function var_0_1.OnClick(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.emit

	NewMainMediator = var_1_10004

	local var_3_2 = var_1_10004.GO_SCENE

	SCENE = var_1_10005

	var_3_1(var_3_0, var_3_2, var_1_10005.PLAYER_INFO)

	return
end

function var_0_1.Flush(arg_4_0, arg_4_1)
	arg_4_0:UpdateLevelAndName()
	arg_4_0:UpdateExp()

	if not arg_4_1 then
		arg_4_0.playerNameTxt.enabled = false
		arg_4_0.playerNameTxt.enabled = true
		arg_4_0.playerLevelTxt.enabled = false
		arg_4_0.playerLevelTxt.enabled = true
	end

	return
end

function var_0_1.UpdateLevelAndName(arg_5_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_5_0 = var_1_10001(var_1_10003)
	local var_5_1 = var_1.getRawData(var_5_0)

	arg_5_0.playerNameTxt.text = var_5_1.name
	arg_5_0.playerLevelTxt.text = "LV." .. var_5_1.level

	return
end

function var_0_1.UpdateExp(arg_6_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)
	local var_6_1

	if var_1.getRawData(var_6_0).level == var_1:getMaxLevel() then
		var_6_1 = arg_6_0.expSlider
		var_6_1.value = 1
	else
		getConfigFromLevel1 = var_6_1
		pg = var_1_10004

		local var_6_2 = var_6_1(var_1_10004.user_level, var_1.level)

		arg_6_0.expSlider.value = var_1.exp / var_6_2.exp_interval
	end

	return
end

return var_0_1
