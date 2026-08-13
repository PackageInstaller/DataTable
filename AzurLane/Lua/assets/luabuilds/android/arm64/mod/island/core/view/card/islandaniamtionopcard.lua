class = var_0_10000

local var_0_0 = var_0_10000("IslandAniamtionOpCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf

	arg_1_0.tipTr = var_2.Find(var_1_0, "tip")

	local var_1_1 = arg_1_0._tf

	arg_1_0.cutoffTr = var_2.Find(var_1_1, "cut_off ")

	local var_1_2 = arg_1_0._tf

	arg_1_0.item1 = var_2.Find(var_1_2, "1/main")

	local var_1_3 = arg_1_0._tf

	arg_1_0.item2 = var_2.Find(var_1_3, "2/main")

	local var_1_4 = arg_1_0.item1

	arg_1_0.item1TimeTr = var_2.Find(var_1_4, "time")

	local var_1_5 = arg_1_0.item2

	arg_1_0.item2TimeTr = var_2.Find(var_1_5, "time")

	local var_1_6 = arg_1_0.item1

	arg_1_0.item1MarkTr = var_2.Find(var_1_6, "mark")

	local var_1_7 = arg_1_0.item2

	arg_1_0.item2MarkTr = var_2.Find(var_1_7, "mark")
	setActive = var_2

	var_2(arg_1_0.item1TimeTr, false)

	setActive = var_2

	var_2(arg_1_0.item2TimeTr, false)

	local var_1_8 = arg_1_0._tf
	local var_1_9 = var_2.GetComponent

	typeof = var_5
	LayoutElement = var_1_10007
	arg_1_0.layoutElement = var_1_9(var_1_8, var_5(var_1_10007))
	arg_1_0.baseHeight = arg_1_0.layoutElement.preferredHeight

	local var_1_10 = arg_1_0.cutoffTr
	local var_1_11 = var_2.GetComponent

	typeof = var_5
	LayoutElement = var_1_10007
	arg_1_0.cutOffHeight = var_1_11(var_1_10, var_5(var_1_10007)).preferredHeight

	local var_1_12 = arg_1_0._tf
	local var_1_13 = var_2.Find(var_1_12, "1")
	local var_1_14 = var_2.GetComponent

	typeof = var_5
	Animation = var_1_10007
	arg_1_0.animationItem1 = var_1_14(var_1_13, var_5(var_1_10007))

	local var_1_15 = arg_1_0._tf
	local var_1_16 = var_2.Find(var_1_15, "2")
	local var_1_17 = var_2.GetComponent

	typeof = var_5
	Animation = var_1_10007
	arg_1_0.animationItem2 = var_1_17(var_1_16, var_5(var_1_10007))

	return
end

function var_0_0.Contains(arg_2_0, arg_2_1)
	return arg_2_0.firstId == arg_2_1 or arg_2_0.secondId == arg_2_1
end

function var_0_0.Update(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = arg_3_1[1]
	local var_3_1 = arg_3_1[2]

	arg_3_0.firstId = var_3_0
	arg_3_0.secondId = var_3_1

	arg_3_0:UpdateItem(arg_3_0.item1, var_3_0)
	arg_3_0:UpdateItem(arg_3_0.item2, var_3_1)
	arg_3_0:UpdateSelected(arg_3_2)
	arg_3_0:LoadingEffect(arg_3_3)
	arg_3_0:UpdateMards(arg_3_4)

	setActive = var_7

	var_7(arg_3_0.tipTr, false)

	return
end

function var_0_0.UpdateMards(arg_4_0, arg_4_1)
	setActive = var_1_10002

	var_1_10002(arg_4_0.item1MarkTr, arg_4_1 == arg_4_0.firstId)

	setActive = var_1_10002

	var_1_10002(arg_4_0.item2MarkTr, arg_4_1 == arg_4_0.secondId)

	return
end

function var_0_0.UpdateItem(arg_5_0, arg_5_1, arg_5_2)
	setActive = var_1_10003

	var_1_10003(arg_5_1, arg_5_2)

	if not arg_5_2 then
		return
	end

	pg = var_1_10003

	local var_5_0 = var_1_10003.island_action[arg_5_2]

	setText = var_1_10004

	var_1_10004(arg_5_1:Find("Text"), var_5_0.name)

	setActive = var_1_10004

	local var_5_1 = arg_5_1
	local var_5_2 = arg_5_1.Find(var_5_1, "double")
	local var_5_3 = var_5_0.type

	IslandConst = var_5_1

	var_1_10004(var_5_2, var_5_3 == var_5_1.ANIMATION_OP_DOUBLE)

	LoadImageSpriteAsync = var_1_10004

	var_1_10004("island/IslandActionIcon/" .. var_5_0.resource, arg_5_1:Find("icon"), true)

	return
end

function var_0_0.UpdateSelected(arg_6_0, arg_6_1)
	local var_6_0

	if arg_6_0.firstId then
		var_6_0 = arg_6_1 == arg_6_0.firstId
	end

	local var_6_1

	if arg_6_0.secondId then
		var_6_1 = arg_6_1 == arg_6_0.secondId
	end

	arg_6_0:PlayAnimtion(var_6_0, var_6_1)

	return
end

function var_0_0.PlayAnimtion(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 then
		local var_7_0 = arg_7_0.animationItem1

		var_3.Play(var_7_0, "Anim_IslandActionOpUI_Selected")
	else
		local var_7_1 = arg_7_0.animationItem1

		var_3.Play(var_7_1, "Anim_IslandActionOpUI_UnSelected")
	end

	if arg_7_2 then
		local var_7_2 = arg_7_0.animationItem2

		var_3.Play(var_7_2, "Anim_IslandActionOpUI_Selected")
	else
		local var_7_3 = arg_7_0.animationItem2

		var_3.Play(var_7_3, "Anim_IslandActionOpUI_UnSelected")
	end

	return
end

function var_0_0.Clear(arg_8_0, ...)
	local var_8_0 = arg_8_0.animationItem1

	var_1.Play(var_8_0, "Anim_IslandActionOpUI_UnSelected")

	local var_8_1 = arg_8_0.animationItem2

	var_1.Play(var_8_1, "Anim_IslandActionOpUI_UnSelected")

	LeanTween = var_1

	local var_8_2 = var_1.cancel

	go = var_8_1

	var_8_2(var_8_1(arg_8_0.item1TimeTr))

	LeanTween = var_8_2

	local var_8_3 = var_8_2.cancel

	go = var_3

	var_8_3(var_3(arg_8_0.item2TimeTr))

	return
end

function var_0_0.LoadingEffect(arg_9_0, arg_9_1)
	arg_9_0:ClearLoadingEffect()

	if not arg_9_1 then
		return
	end

	local var_9_0

	if arg_9_0.firstId then
		var_9_0 = arg_9_1.id == arg_9_0.firstId
	end

	local var_9_1

	if arg_9_0.secondId then
		var_9_1 = arg_9_1.id == arg_9_0.secondId
	end

	local var_9_2

	if var_9_0 then
		var_9_2 = arg_9_0.item1TimeTr
	elseif var_9_1 then
		var_9_2 = arg_9_0.item2TimeTr
	end

	if not var_9_2 then
		return
	end

	local var_9_3 = arg_9_1.startTime
	local var_9_4 = arg_9_1.endTime - var_9_3

	pg = var_1_10008

	local var_9_5 = var_1_10008.TimeMgr.GetInstance()
	local var_9_6 = (var_8.GetServerTime(var_9_5) - var_9_3) / var_9_4
	local var_9_7 = var_6 - var_8

	setActive = var_1_10011

	var_1_10011(var_9_2, true)

	LeanTween = var_1_10011

	local var_9_8 = var_1_10011.value

	go = var_13

	local var_9_9 = var_9_8(var_13(var_9_2), var_9_6, 1, var_9_7)
	local var_9_10 = var_11.setOnUpdate

	System = var_14

	local var_9_11 = var_9_10(var_9_9, var_14.Action_float(function(arg_10_0)
		setFillAmount = var_2_10001

		var_2_10001(var_9_2, arg_10_0)

		return
	end))
	local var_9_12 = var_11.setOnComplete

	System = var_14

	var_9_12(var_9_11, var_14.Action(function()
		setActive = var_2_10000

		var_2_10000(var_9_2, false)

		return
	end))

	return
end

function var_0_0.ClearLoadingEffect(arg_12_0)
	setActive = var_1_10001

	var_1_10001(arg_12_0.item1TimeTr, false)

	setActive = var_1_10001

	var_1_10001(arg_12_0.item2TimeTr, false)

	LeanTween = var_1_10001

	local var_12_0 = var_1_10001.cancel

	go = var_3

	var_12_0(var_3(arg_12_0.item1TimeTr))

	LeanTween = var_12_0

	local var_12_1 = var_12_0.cancel

	go = var_3

	var_12_1(var_3(arg_12_0.item2TimeTr))

	return
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0:Clear()

	return
end

return var_0_0
