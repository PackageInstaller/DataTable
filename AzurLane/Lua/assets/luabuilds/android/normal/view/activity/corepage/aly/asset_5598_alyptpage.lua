class = var_0_10000

local var_0_0 = "ALYPtPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..CorePageNewPtTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_1.Find(var_1_0, "bg/Image_back")
	local var_1_2 = var_1.GetComponent

	typeof = var_3
	Animation = var_1_10004
	arg_1_0.anim = var_1_2(var_1_1, var_3(var_1_10004))

	local var_1_3 = arg_1_0.anim

	var_1.Play(var_1_3, "anim_AlyptPage_BackImage")

	local var_1_4 = arg_1_0.anim
	local var_1_5 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004
	arg_1_0.animEvent = var_1_5(var_1_4, var_3(var_1_10004))

	local var_1_6 = arg_1_0.animEvent

	var_1.SetStartEvent(var_1_6, function()
		local var_2_0 = arg_1_0._tf
		local var_2_1 = var_0.GetComponent

		typeof = var_2_10002
		Animation = var_2_10003

		local var_2_2 = var_2_1(var_2_0, var_2_10002(var_2_10003))

		var_0.Play(var_2_2, "anim_AlyptPage_In")

		return
	end)

	local var_1_7 = arg_1_0._tf
	local var_1_8 = var_1.GetComponent

	typeof = var_3
	Animation = var_1_10004
	arg_1_0._tfanim = var_1_8(var_1_7, var_3(var_1_10004))

	local var_1_9 = arg_1_0._tfanim
	local var_1_10 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004
	arg_1_0._tfanimEvent = var_1_10(var_1_9, var_3(var_1_10004))

	local var_1_11 = arg_1_0._tfanimEvent

	var_1.SetEndEvent(var_1_11, function()
		setActive = var_2_10000

		local var_3_0 = arg_1_0._tf

		var_2_10000(var_1.Find(var_3_0, "bg/Image_back_Loop"), true)

		setActive = var_2_10000

		local var_3_1 = arg_1_0._tf

		var_2_10000(var_1.Find(var_3_1, "bg/VX"), true)

		return
	end)

	arg_1_0.itemAlpha = 0
	setCanvasGroupAlpha = var_1

	var_1(arg_1_0.awardTpl, arg_1_0.itemAlpha)

	local var_1_12 = arg_1_0._tf
	local var_1_13 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004
	arg_1_0.awardanimEvent = var_1_13(var_1_12, var_3(var_1_10004))

	local var_1_14 = arg_1_0.awardanimEvent

	var_1.SetTriggerEvent(var_1_14, function(arg_4_0)
		local var_4_0 = arg_1_0

		var_4_0.itemAlpha = 1
		setCanvasGroupAlpha = var_4_0

		var_4_0(arg_1_0.awardTpl, arg_1_0.itemAlpha)

		local var_4_1 = arg_1_0.content.transform.childCount

		for iter_4_0 = 0, var_4_1 - 1 do
			local var_4_2 = arg_1_0.content
			local var_4_3 = var_6.GetChild(var_4_2, iter_4_0)

			onDelayTick = var_4_2

			var_4_2(function()
				if arg_1_0._state == var_0_1.STATES.DESTROY then
					return
				end

				setCanvasGroupAlpha = var_0

				var_0(var_4_3, arg_1_0.itemAlpha)

				quickPlayAnimation = var_0

				var_0(var_4_3, "anim_AlyptPage_awardtpl_In")

				return
			end, 0.08)
		end

		onDelayTick = var_2

		var_2(function()
			if arg_1_0._state == var_0_1.STATES.DESTROY then
				return
			end

			quickPlayAnimation = var_0

			var_0(arg_1_0.sptf, "anim_AlyptPage_sp_award_In")

			return
		end, 0.08)

		return
	end)

	return
end

function var_0_1.UpdateAward(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1 + 1
	local var_7_1 = arg_7_0.awardList[var_7_0].drop

	updateDrop = var_1_10005

	var_1_10005(arg_7_2:Find("icon"), var_7_1)

	setText = var_1_10005

	var_1_10005(arg_7_2:Find("pt"), arg_7_0.awardList[var_7_0].target)

	local var_7_2 = arg_7_0.ptData

	if not (var_7_0 <= var_5.GetLevel(var_7_2)) then
		local var_7_3 = arg_7_0.ptData
		local var_7_4

		if not (var_7_0 <= var_6.GetMaxAvailableTargetIndex(var_7_3)) then
			var_7_4 = false
		else
			var_7_4 = true
		end

		local var_7_5 = not var_5 and not var_7_4

		setText = var_8

		local var_7_6 = arg_7_2
		local var_7_7 = arg_7_2.Find(var_7_6, "got/got_text")

		i18n = var_7_6

		var_8(var_7_7, var_7_6("yumia_pt_4"))

		setActive = var_8

		var_8(arg_7_2:Find("got"), var_5)

		setActive = var_8

		var_8(arg_7_2:Find("get"), var_7_4)

		setActive = var_8

		var_8(arg_7_2:Find("lock"), var_7_5)

		onButton = var_8

		local var_7_8 = arg_7_0
		local var_7_9 = arg_7_2

		local function var_7_10()
			local var_8_0 = arg_7_0
			local var_8_1 = var_0.emit

			BaseUI = var_2_10002

			var_8_1(var_8_0, var_2_10002.ON_DROP, var_7_1)

			return
		end

		SFX_PANEL = var_1_10012

		var_8(var_7_8, var_7_9, var_7_10, var_1_10012)

		return
	end
end

function var_0_1.OnFirstFlush(arg_9_0)
	var_0_1.super.OnFirstFlush(arg_9_0)

	setText = var_1

	local var_9_0 = arg_9_0._tf
	local var_9_1 = var_2.Find(var_9_0, "Text (Legacy)", arg_9_0.shopBtn)

	i18n = var_9_0

	var_1(var_9_1, var_9_0("yumia_pt_3"))

	setText = var_1

	local var_9_2 = arg_9_0._tf
	local var_9_3 = var_2.Find(var_9_2, "Text (Legacy)", arg_9_0.getBtn)

	i18n = var_9_2

	var_1(var_9_3, var_9_2("yumia_pt_2"))

	setText = var_1

	local var_9_4 = arg_9_0.bg
	local var_9_5 = var_2.Find(var_9_4, "rule_bg/rule_text")

	i18n = var_9_4

	var_1(var_9_5, var_9_4("yumia_pt_1"))

	setText = var_1

	local var_9_6 = arg_9_0._tf
	local var_9_7 = var_2.Find(var_9_6, "pt_bg/Text (Legacy)", arg_9_0.bg)

	i18n = var_9_6

	var_1(var_9_7, var_9_6("yumia_pt_tip"))

	return
end

function var_0_1.UpdateNextAward(arg_10_0, arg_10_1)
	math = var_1_10002
	arg_10_1 = var_1_10002.min(arg_10_1, 1)
	pairs = var_2

	for iter_10_0, iter_10_1 in var_2(arg_10_0.importantPos) do
		if arg_10_1 + var_0_1.AWARD_OFFSET < iter_10_1.pos then
			arg_10_0:UpdateAward(iter_10_1.index - 1, arg_10_0.spAward)

			break
		elseif iter_10_0 == #arg_10_0.importantPos then
			arg_10_0:UpdateAward(iter_10_1.index - 1, arg_10_0.spAward)
		end
	end

	return
end

function var_0_1.OnUpdateFlush(arg_11_0)
	local var_11_0 = var_0_1.OFFSET
	local var_11_1 = arg_11_0.ptData
	local var_11_2 = var_11_0 * var_2.GetLevel(var_11_1)

	isActive = var_2

	local var_11_4

	if var_2(arg_11_0._tf) then
		local var_11_3 = arg_11_0.scrollCom

		var_11_4 = var_11_4.ScrollTo
		math = var_1_10004
		var_1_10004 = var_1_10004.clamp

		local var_11_5 = arg_11_0.scrollCom
		local var_11_6 = var_5.HeadIndexToValue
		local var_11_7 = arg_11_0.ptData

		var_11_4(var_11_3, var_1_10004(var_11_6(var_11_5, var_7.GetLevel(var_11_7)) / arg_11_0.impTotalPos + var_11_2, 0, 1), true)
	end

	setText = var_11_4

	local var_11_8 = arg_11_0.get

	i18n = var_1_10004

	var_11_4(var_11_8, var_1_10004("word_got_pt"))

	setText = var_11_4

	var_11_4(arg_11_0.ptCount, arg_11_0.ptData.count)

	return
end

function var_0_1.OnHideFlush(arg_12_0)
	onDelayTick = var_1_10001

	var_1_10001(function()
		for iter_13_0 = 0, arg_12_0.content.transform.childCount - 1 do
			local var_13_0 = arg_12_0.content
			local var_13_1 = var_4.GetChild(var_13_0, iter_13_0)
			local var_13_2 = var_4.GetComponent

			typeof = var_6
			Animation = var_2_10007

			local var_13_3 = var_13_2(var_13_1, var_6(var_2_10007))

			var_4.Stop(var_13_3)

			setCanvasGroupAlpha = var_4

			local var_13_4 = arg_12_0.content

			var_4(var_5.GetChild(var_13_4, iter_13_0), 0)
		end

		return
	end, 0.08)

	onDelayTick = var_1_10001

	var_1_10001(function()
		setCanvasGroupAlpha = var_2_10000

		var_2_10000(arg_12_0.sptf, 0)

		return
	end, 0.08)

	return
end

return var_0_1
