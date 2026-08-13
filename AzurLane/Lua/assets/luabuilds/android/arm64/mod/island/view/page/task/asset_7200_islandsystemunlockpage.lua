class = var_0_10000

local var_0_0 = "IslandSystemUnlockPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".Island3dTaskAcceptPage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandSystemUnlockMsgBox"
end

function var_0_1.Show(arg_2_0, arg_2_1, arg_2_2)
	var_0_1.super.super.Show(arg_2_0)
	arg_2_0:BlurPanel()

	setText = var_3

	local var_2_0 = arg_2_0.tipText

	i18n = var_1_10006

	var_3(var_2_0, var_1_10006("word_unlock"))

	pg = var_3

	local var_2_1

	if not var_3.island_ability_template[arg_2_1] then
		var_2_1 = {}
	end

	string = var_1_10004

	local var_2_2 = var_1_10004.split
	local var_2_3

	if not var_2_1.show_pop_text then
		var_2_3 = ""
	end

	local var_2_4 = var_2_2(var_2_3, "|")

	setText = var_2_0

	local var_2_5 = arg_2_0.chapterText
	local var_2_6

	if not var_2_4[2] then
		var_2_6 = ""
	end

	var_2_0(var_2_5, var_2_6)

	setText = var_2_0

	local var_2_7 = arg_2_0.nameText
	local var_2_8

	if not var_2_4[1] then
		var_2_8 = ""
	end

	var_2_0(var_2_7, var_2_8)

	arg_2_0.onExit = arg_2_2

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_5.GetComponent

	typeof = var_2_8
	Animation = var_1_10010

	local var_2_11 = var_2_10(var_2_9, var_2_8(var_1_10010))
	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_6.GetComponent

	typeof = var_1_10009
	DftAniEvent = var_1_10011

	local var_2_14 = var_2_13(var_2_12, var_1_10009(var_1_10011))

	var_6.SetEndEvent(var_2_14, function()
		local var_3_0 = var_0

		var_0.SetEndEvent(var_3_0, nil)

		local var_3_1 = var_2_11

		var_0.Play(var_3_1, "Anim_Island3dTaskAcceptUI_loop")

		arg_2_0.onAnimationLoop = true

		return
	end)

	return
end

function var_0_1.BlurPanel(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_4_0, arg_4_0._go.transform)

	arg_4_0.isBlurPanel = true

	return
end

function var_0_1.UnBlurPanel(arg_5_0)
	if arg_5_0.isBlurPanel then
		pg = var_1

		local var_5_0 = var_1.UIMgr.GetInstance()
		local var_5_1 = var_1.UnOverlayPanel
		local var_5_2 = arg_5_0._go.transform

		pg = var_1_10005

		var_5_1(var_5_0, var_5_2, var_1_10005.UIMgr.GetInstance().UIMain)
	end

	arg_5_0.isBlurPanel = false

	return
end

function var_0_1.OnDestroy(arg_6_0)
	var_0_1.super.OnDestroy(arg_6_0)
	arg_6_0:UnBlurPanel()

	return
end

function var_0_1.Hide(arg_7_0)
	var_0_1.super.Hide(arg_7_0)
	arg_7_0:UnBlurPanel()

	return
end

function var_0_1.TouchEvent(arg_8_0)
	local var_8_0 = arg_8_0._tf
	local var_8_1 = var_1.GetComponent

	typeof = var_1_10004
	Animation = var_1_10006

	local var_8_2 = var_8_1(var_8_0, var_1_10004(var_1_10006))

	if not arg_8_0.onAnimationLoop then
		var_8_2:Play("Anim_Island3dTaskAcceptUI_loop")

		arg_8_0.onAnimationLoop = true

		return
	end

	local var_8_3 = arg_8_0._tf
	local var_8_4 = var_2.GetComponent

	typeof = var_1_10005
	DftAniEvent = var_1_10007

	local var_8_5 = var_8_4(var_8_3, var_1_10005(var_1_10007))

	var_2.SetEndEvent(var_8_5, function()
		local var_9_0 = var_0

		var_0.SetEndEvent(var_9_0, nil)

		if arg_8_0.onExit then
			arg_8_0.onExit()

			arg_8_0.onExit = nil
		end

		local var_9_1 = arg_8_0

		var_0.Hide(var_9_1)

		return
	end)
	var_8_2:Play("Anim_Island3dTaskAcceptUI_out")

	return
end

return var_0_1
