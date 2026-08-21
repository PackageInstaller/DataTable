local var_0_0 = class("MainPlayerInfoBtn", import(".MainBaseBtn"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.playerInfoBtn = findTF(arg_1_0._tf, "iconBack")
	arg_1_0.playerNameTxt = findTF(arg_1_0._tf, "name"):GetComponent(typeof(Text))
	arg_1_0.playerLevelTxt = findTF(arg_1_0._tf, "level"):GetComponent(typeof(Text))
	arg_1_0.expSlider = findTF(arg_1_0._tf, "exp"):GetComponent(typeof(Slider))

	return
end

function var_0_0.GetTarget(arg_2_0)
	return arg_2_0.playerInfoBtn
end

function var_0_0.OnClick(arg_3_0)
	arg_3_0:emit(NewMainMediator.GO_SCENE, SCENE.PLAYER_INFO)

	return
end

function var_0_0.Flush(arg_4_0, arg_4_1)
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

function var_0_0.UpdateLevelAndName(arg_5_0)
	local var_5_0 = getProxy(PlayerProxy):getRawData()

	arg_5_0.playerNameTxt.text = var_5_0.name
	arg_5_0.playerLevelTxt.text = "LV." .. var_5_0.level

	return
end

function var_0_0.UpdateExp(arg_6_0)
	local var_6_0 = getProxy(PlayerProxy):getRawData()

	arg_6_0.expSlider.value = var_6_0.level == var_6_0:getMaxLevel() and 1 or var_6_0.exp / getConfigFromLevel1(pg.user_level, var_6_0.level).exp_interval

	return
end

return var_0_0
