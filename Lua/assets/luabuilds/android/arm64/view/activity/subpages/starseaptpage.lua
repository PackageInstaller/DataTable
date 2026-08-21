local var_0_0 = class("StarSeaPtPage", import(".TemplatePage.PtTemplatePage"))
local var_0_1 = "#CCB5FF"

function var_0_0.OnUpdateFlush(arg_1_0)
	local var_1_0 = arg_1_0.ptData:getTargetLevel()
	local var_1_1 = arg_1_0.activity:getConfig("config_client").story

	if checkExist(var_1_1, {
		var_1_0
	}, {
		1
	}) then
		pg.NewStoryMgr.GetInstance():Play(var_1_1[var_1_0][1])
	end

	if arg_1_0.step then
		local var_1_2, var_1_3, var_1_4 = arg_1_0.ptData:GetLevelProgress()

		setText(arg_1_0.step, setColorStr(var_1_2, var_0_1) .. "/" .. var_1_3)
	end

	local var_1_5, var_1_6, var_1_7 = arg_1_0.ptData:GetResProgress()
	local var_1_8 = var_1_7 >= 1 and setColorStr(var_1_5, var_0_1) or var_1_5

	setText(arg_1_0.progress, var_1_8 .. "/" .. var_1_6)
	setSlider(arg_1_0.slider, 0, 1, var_1_7)

	local var_1_9 = arg_1_0.ptData:CanGetAward()
	local var_1_10 = arg_1_0.ptData:CanGetNextAward()

	setActive(arg_1_0.battleBtn, arg_1_0.ptData:CanGetMorePt() and not var_1_9 and var_1_10)
	setActive(arg_1_0.getBtn, var_1_9)
	setActive(arg_1_0.gotBtn, not var_1_10)
	updateDrop(arg_1_0.awardTF, (arg_1_0.ptData:GetAward()))
	onButton(arg_1_0, arg_1_0.awardTF, function()
		arg_1_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	return
end

return var_0_0
