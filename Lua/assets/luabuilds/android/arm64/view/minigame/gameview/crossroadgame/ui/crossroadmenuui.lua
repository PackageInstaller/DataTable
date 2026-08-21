local var_0_0 = class("CrossRoadMenuUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3
	arg_1_0.totalTimes = arg_1_0._gameVo:GetTotalTimes()

	arg_1_0:initUI()

	return
end

function var_0_0.initUI(arg_2_0)
	arg_2_0.menuUI = findTF(arg_2_0._tf, "ui/menuUI")
	arg_2_0.ui = findTF(arg_2_0.menuUI, "ui")

	onButton(arg_2_0._event, findTF(arg_2_0.menuUI, "ui/btnBack"), function()
		arg_2_0:Show(false)
		arg_2_0._event:emit(SimpleMGEvent.CLOSE_GAME)

		return
	end, SFX_CANCEL)

	arg_2_0.btnRule = findTF(arg_2_0.menuUI, "ui/btnRule")

	onButton(arg_2_0._event, arg_2_0.btnRule, function()
		arg_2_0._event:emit(SimpleMGEvent.SHOW_RULE, true)

		return
	end, SFX_CANCEL)

	arg_2_0.btnStart = findTF(arg_2_0.menuUI, "ui/btnStart")

	onButton(arg_2_0._event, arg_2_0.btnStart, function()
		arg_2_0:Show(false)
		arg_2_0._event:emit(SimpleMGEvent.READY_START)

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.Show(arg_6_0, arg_6_1)
	local var_6_0 = pg.UIMgr.GetInstance()

	if arg_6_1 then
		setActive(arg_6_0.menuUI, true)
		var_6_0:BlurPanel(arg_6_0.menuUI)
	else
		var_6_0:UnOverlayPanel(arg_6_0.menuUI, arg_6_0._tf)
		setActive(arg_6_0.menuUI, false)
	end

	return
end

function var_0_0.Update(arg_7_0)
	return
end

return var_0_0
