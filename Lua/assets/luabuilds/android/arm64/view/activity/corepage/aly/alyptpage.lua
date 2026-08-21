local var_0_0 = class("ALYPtPage", import("..CorePageNewPtTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.anim = arg_1_0._tf:Find("bg/Image_back"):GetComponent(typeof(Animation))

	arg_1_0.anim:Play("anim_AlyptPage_BackImage")

	arg_1_0.animEvent = arg_1_0.anim:GetComponent(typeof(DftAniEvent))

	arg_1_0.animEvent:SetStartEvent(function()
		arg_1_0._tf:GetComponent(typeof(Animation)):Play("anim_AlyptPage_In")

		return
	end)

	arg_1_0._tfanim = arg_1_0._tf:GetComponent(typeof(Animation))
	arg_1_0._tfanimEvent = arg_1_0._tfanim:GetComponent(typeof(DftAniEvent))

	arg_1_0._tfanimEvent:SetEndEvent(function()
		setActive(arg_1_0._tf:Find("bg/Image_back_Loop"), true)
		setActive(arg_1_0._tf:Find("bg/VX"), true)

		return
	end)

	arg_1_0.itemAlpha = 0

	setCanvasGroupAlpha(arg_1_0.awardTpl, arg_1_0.itemAlpha)

	arg_1_0.awardanimEvent = arg_1_0._tf:GetComponent(typeof(DftAniEvent))

	arg_1_0.awardanimEvent:SetTriggerEvent(function(arg_4_0)
		arg_1_0.itemAlpha = 1

		setCanvasGroupAlpha(arg_1_0.awardTpl, arg_1_0.itemAlpha)

		for iter_4_0 = 0, arg_1_0.content.transform.childCount - 1 do
			local var_4_0 = arg_1_0.content:GetChild(iter_4_0)

			onDelayTick(function()
				if arg_1_0._state == var_0_0.STATES.DESTROY then
					return
				end

				setCanvasGroupAlpha(var_4_0, arg_1_0.itemAlpha)
				quickPlayAnimation(var_4_0, "anim_AlyptPage_awardtpl_In")

				return
			end, 0.08)
		end

		onDelayTick(function()
			if arg_1_0._state == var_0_0.STATES.DESTROY then
				return
			end

			quickPlayAnimation(arg_1_0.sptf, "anim_AlyptPage_sp_award_In")

			return
		end, 0.08)

		return
	end)

	return
end

function var_0_0.UpdateAward(arg_7_0, arg_7_1, arg_7_2)
	updateDrop(arg_7_2:Find("icon"), arg_7_0.awardList[arg_7_1 + 1].drop)
	setText(arg_7_2:Find("pt"), arg_7_0.awardList[arg_7_1 + 1].target)

	local var_7_0 = arg_7_1 + 1 <= arg_7_0.ptData:GetLevel()
	local var_7_1 = not var_7_0 and arg_7_1 + 1 <= arg_7_0.ptData:GetMaxAvailableTargetIndex()
	local var_7_2 = not var_7_0 and not var_7_1

	setText(arg_7_2:Find("got/got_text"), i18n("yumia_pt_4"))
	setActive(arg_7_2:Find("got"), var_7_0)
	setActive(arg_7_2:Find("get"), var_7_1)
	setActive(arg_7_2:Find("lock"), var_7_2)
	onButton(arg_7_0, arg_7_2, function()
		arg_7_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnFirstFlush(arg_9_0)
	var_0_0.super.OnFirstFlush(arg_9_0)
	setText(arg_9_0._tf:Find("Text (Legacy)", arg_9_0.shopBtn), i18n("yumia_pt_3"))
	setText(arg_9_0._tf:Find("Text (Legacy)", arg_9_0.getBtn), i18n("yumia_pt_2"))
	setText(arg_9_0.bg:Find("rule_bg/rule_text"), i18n("yumia_pt_1"))
	setText(arg_9_0._tf:Find("pt_bg/Text (Legacy)", arg_9_0.bg), i18n("yumia_pt_tip"))

	return
end

function var_0_0.UpdateNextAward(arg_10_0, arg_10_1)
	arg_10_1 = math.min(arg_10_1, 1)

	for iter_10_0, iter_10_1 in pairs(arg_10_0.importantPos) do
		if arg_10_1 + var_0_0.AWARD_OFFSET < iter_10_1.pos then
			arg_10_0:UpdateAward(iter_10_1.index - 1, arg_10_0.spAward)

			break
		elseif iter_10_0 == #arg_10_0.importantPos then
			arg_10_0:UpdateAward(iter_10_1.index - 1, arg_10_0.spAward)
		end
	end

	return
end

function var_0_0.OnUpdateFlush(arg_11_0)
	if isActive(arg_11_0._tf) then
		arg_11_0.scrollCom:ScrollTo(math.clamp(arg_11_0.scrollCom:HeadIndexToValue(arg_11_0.ptData:GetLevel()) / arg_11_0.impTotalPos + var_0_0.OFFSET * arg_11_0.ptData:GetLevel(), 0, 1), true)
	end

	setText(arg_11_0.get, i18n("word_got_pt"))
	setText(arg_11_0.ptCount, arg_11_0.ptData.count)

	return
end

function var_0_0.OnHideFlush(arg_12_0)
	onDelayTick(function()
		for iter_13_0 = 0, arg_12_0.content.transform.childCount - 1 do
			arg_12_0.content:GetChild(iter_13_0):GetComponent(typeof(Animation)):Stop()
			setCanvasGroupAlpha(arg_12_0.content:GetChild(iter_13_0), 0)
		end

		return
	end, 0.08)
	onDelayTick(function()
		setCanvasGroupAlpha(arg_12_0.sptf, 0)

		return
	end, 0.08)

	return
end

return var_0_0
