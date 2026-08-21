local var_0_0 = class("MonopolyPtPage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	onToggle(arg_1_0, findTF(arg_1_0._tf, "AD/toggle/1"), function()
		arg_1_0:changeToggle(1)

		return
	end, SFX_CONFIRM)
	onToggle(arg_1_0, findTF(arg_1_0._tf, "AD/toggle/2"), function()
		arg_1_0:changeToggle(2)

		return
	end, SFX_CONFIRM)
	onToggle(arg_1_0, findTF(arg_1_0._tf, "AD/toggle/3"), function()
		arg_1_0:changeToggle(3)

		return
	end, SFX_CONFIRM)
	triggerToggle(findTF(arg_1_0._tf, "AD/toggle/1"), true)
	onButton(arg_1_0, findTF(arg_1_0._tf, "AD/btnShop"), function()
		arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SHOP)

		return
	end, SFX_CONFIRM)
	onButton(arg_1_0, findTF(arg_1_0._tf, "AD/btnGo"), function()
		arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.MONOPOLY_PT, {
			config_id = arg_1_0.activity.id
		})

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.changeToggle(arg_7_0, arg_7_1)
	for iter_7_0 = 1, 3 do
		setActive(findTF(arg_7_0._tf, "AD/toggle/" .. iter_7_0 .. "/on/desc"), iter_7_0 == arg_7_1)
	end

	return
end

function var_0_0.OnFirstFlush(arg_8_0)
	if arg_8_0.ptData then
		arg_8_0.ptData:Update(arg_8_0.activity)
	else
		arg_8_0.ptData = ActivityPtData.New(arg_8_0.activity)
	end

	return
end

function var_0_0.OnUpdateFlush(arg_9_0)
	if arg_9_0.ptData then
		arg_9_0.ptData:Update(arg_9_0.activity)
	else
		arg_9_0.ptData = ActivityPtData.New(arg_9_0.activity)
	end

	local var_9_0, var_9_1, var_9_2 = arg_9_0.ptData:GetLevelProgress()
	local var_9_3, var_9_4, var_9_5 = arg_9_0.ptData:GetResProgress()
	local var_9_6 = arg_9_0.ptData:GetLevel()
	local var_9_7 = math.floor(var_9_3 / 500) - var_9_6

	if 20 - var_9_6 < var_9_7 then
		var_9_7 = 20 - var_9_6
	end

	if 20 - var_9_6 == 0 then
		setActive(findTF(arg_9_0._tf, "AD/clear"), true)
	else
		setActive(findTF(arg_9_0._tf, "AD/clear"), false)
	end

	setActive(findTF(arg_9_0._tf, "AD/count"), var_9_7 > 0)
	setText(findTF(arg_9_0._tf, "AD/count/txt"), var_9_7)

	return
end

return var_0_0
