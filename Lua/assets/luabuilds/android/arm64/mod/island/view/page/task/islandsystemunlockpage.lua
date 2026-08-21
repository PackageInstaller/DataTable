local var_0_0 = class("IslandSystemUnlockPage", import(".Island3dTaskAcceptPage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandSystemUnlockMsgBox"
end

function var_0_0.Show(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.super.Show(arg_2_0)
	arg_2_0:BlurPanel()
	setText(arg_2_0.tipText, i18n("word_unlock"))

	local var_2_0 = pg.island_ability_template[arg_2_1] or {}
	local var_2_2 = var_2_0.show_pop_text or ""
	local var_2_3 = var_2_1(var_2_2, "|")
	local var_2_4 = var_2_3[2] or ""

	setText(arg_2_0.chapterText, var_2_4)

	local var_2_5 = var_2_3[1] or ""

	setText(arg_2_0.nameText, var_2_5)

	arg_2_0.onExit = arg_2_2

	local var_2_6 = arg_2_0._tf:GetComponent(typeof(Animation))
	local var_2_7 = arg_2_0._tf:GetComponent(typeof(DftAniEvent))

	arg_2_0._tf:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		var_2_7:SetEndEvent(nil)
		var_2_6:Play("Anim_Island3dTaskAcceptUI_loop")

		arg_2_0.onAnimationLoop = true

		return
	end)

	return
end

function var_0_0.BlurPanel(arg_4_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_4_0._go.transform)

	arg_4_0.isBlurPanel = true

	return
end

function var_0_0.UnBlurPanel(arg_5_0)
	if arg_5_0.isBlurPanel then
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_5_0._go.transform, pg.UIMgr.GetInstance().UIMain)
	end

	arg_5_0.isBlurPanel = false

	return
end

function var_0_0.OnDestroy(arg_6_0)
	var_0_0.super.OnDestroy(arg_6_0)
	arg_6_0:UnBlurPanel()

	return
end

function var_0_0.Hide(arg_7_0)
	var_0_0.super.Hide(arg_7_0)
	arg_7_0:UnBlurPanel()

	return
end

function var_0_0.TouchEvent(arg_8_0)
	local var_8_0 = arg_8_0._tf:GetComponent(typeof(Animation))

	if not arg_8_0.onAnimationLoop then
		var_8_0:Play("Anim_Island3dTaskAcceptUI_loop")

		arg_8_0.onAnimationLoop = true

		return
	end

	local var_8_1 = arg_8_0._tf:GetComponent(typeof(DftAniEvent))

	var_8_1:SetEndEvent(function()
		var_8_1:SetEndEvent(nil)

		if arg_8_0.onExit then
			arg_8_0.onExit()

			arg_8_0.onExit = nil
		end

		arg_8_0:Hide()

		return
	end)
	var_8_0:Play("Anim_Island3dTaskAcceptUI_out")

	return
end

return var_0_0
