local var_0_0 = class("IslandAniamtionOpCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.tipTr = arg_1_0._tf:Find("tip")
	arg_1_0.cutoffTr = arg_1_0._tf:Find("cut_off ")
	arg_1_0.item1 = arg_1_0._tf:Find("1/main")
	arg_1_0.item2 = arg_1_0._tf:Find("2/main")
	arg_1_0.item1TimeTr = arg_1_0.item1:Find("time")
	arg_1_0.item2TimeTr = arg_1_0.item2:Find("time")
	arg_1_0.item1MarkTr = arg_1_0.item1:Find("mark")
	arg_1_0.item2MarkTr = arg_1_0.item2:Find("mark")

	setActive(arg_1_0.item1TimeTr, false)
	setActive(arg_1_0.item2TimeTr, false)

	arg_1_0.layoutElement = arg_1_0._tf:GetComponent(typeof(LayoutElement))
	arg_1_0.baseHeight = arg_1_0.layoutElement.preferredHeight
	arg_1_0.cutOffHeight = arg_1_0.cutoffTr:GetComponent(typeof(LayoutElement)).preferredHeight
	arg_1_0.animationItem1 = arg_1_0._tf:Find("1"):GetComponent(typeof(Animation))
	arg_1_0.animationItem2 = arg_1_0._tf:Find("2"):GetComponent(typeof(Animation))

	return
end

function var_0_0.Contains(arg_2_0, arg_2_1)
	return arg_2_0.firstId == arg_2_1 or arg_2_0.secondId == arg_2_1
end

function var_0_0.Update(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.firstId = arg_3_1[1]
	arg_3_0.secondId = arg_3_1[2]

	arg_3_0:UpdateItem(arg_3_0.item1, arg_3_1[1])
	arg_3_0:UpdateItem(arg_3_0.item2, arg_3_1[2])
	arg_3_0:UpdateSelected(arg_3_2)
	arg_3_0:LoadingEffect(arg_3_3)
	arg_3_0:UpdateMards(arg_3_4)
	setActive(arg_3_0.tipTr, false)

	return
end

function var_0_0.UpdateMards(arg_4_0, arg_4_1)
	setActive(arg_4_0.item1MarkTr, arg_4_1 == arg_4_0.firstId)
	setActive(arg_4_0.item2MarkTr, arg_4_1 == arg_4_0.secondId)

	return
end

function var_0_0.UpdateItem(arg_5_0, arg_5_1, arg_5_2)
	setActive(arg_5_1, arg_5_2)

	if not arg_5_2 then
		return
	end

	local var_5_0 = pg.island_action[arg_5_2]

	setText(arg_5_1:Find("Text"), pg.island_action[arg_5_2].name)
	setActive(arg_5_1:Find("double"), var_5_0.type == IslandConst.ANIMATION_OP_DOUBLE)
	LoadImageSpriteAsync("island/IslandActionIcon/" .. var_5_0.resource, arg_5_1:Find("icon"), true)

	return
end

function var_0_0.UpdateSelected(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.firstId and arg_6_1 == arg_6_0.firstId
	local var_6_1 = arg_6_0.secondId and arg_6_1 == arg_6_0.secondId

	arg_6_0:PlayAnimtion(var_6_0, var_6_1)

	return
end

function var_0_0.PlayAnimtion(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 then
		arg_7_0.animationItem1:Play("Anim_IslandActionOpUI_Selected")
	else
		arg_7_0.animationItem1:Play("Anim_IslandActionOpUI_UnSelected")
	end

	if arg_7_2 then
		arg_7_0.animationItem2:Play("Anim_IslandActionOpUI_Selected")
	else
		arg_7_0.animationItem2:Play("Anim_IslandActionOpUI_UnSelected")
	end

	return
end

function var_0_0.Clear(arg_8_0, ...)
	arg_8_0.animationItem1:Play("Anim_IslandActionOpUI_UnSelected")
	arg_8_0.animationItem2:Play("Anim_IslandActionOpUI_UnSelected")
	LeanTween.cancel(go(arg_8_0.item1TimeTr))
	LeanTween.cancel(go(arg_8_0.item2TimeTr))

	return
end

function var_0_0.LoadingEffect(arg_9_0, arg_9_1)
	arg_9_0:ClearLoadingEffect()

	if not arg_9_1 then
		return
	end

	local var_9_0 = arg_9_0.firstId and arg_9_1.id == arg_9_0.firstId
	local var_9_1 = arg_9_0.secondId and arg_9_1.id == arg_9_0.secondId
	local var_9_2

	if var_9_0 then
		var_9_2 = arg_9_0.item1TimeTr
	elseif var_9_1 then
		var_9_2 = arg_9_0.item2TimeTr
	end

	local var_9_3

	if not var_9_2 then
		do return end

		var_9_3 = pg.TimeMgr.GetInstance():GetServerTime()
	end

	setActive(var_9_2, true)
	LeanTween.value(go(var_9_2), var_9_4, 1, arg_9_1.endTime - var_9_3):setOnUpdate(System.Action_float(function(arg_10_0)
		setFillAmount(var_9_2, arg_10_0)

		return
	end)):setOnComplete(System.Action(function()
		setActive(var_9_2, false)

		return
	end))

	return
end

function var_0_0.ClearLoadingEffect(arg_12_0)
	setActive(arg_12_0.item1TimeTr, false)
	setActive(arg_12_0.item2TimeTr, false)
	LeanTween.cancel(go(arg_12_0.item1TimeTr))
	LeanTween.cancel(go(arg_12_0.item2TimeTr))

	return
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0:Clear()

	return
end

return var_0_0
