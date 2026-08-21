local var_0_0 = class("EducateMindLayer", import(".base.EducateBaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "EducateMindUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_0.initData(arg_3_0)
	arg_3_0.taskProxy = getProxy(EducateProxy):GetTaskProxy()
	arg_3_0.taskVOs = arg_3_0.taskProxy:GetTasksBySystem(EducateTask.SYSTEM_TYPE_MIND)

	return
end

function var_0_0.findUI(arg_4_0)
	arg_4_0.anim = arg_4_0._tf:Find("anim_root"):GetComponent(typeof(Animation))
	arg_4_0.animEvent = arg_4_0._tf:Find("anim_root"):GetComponent(typeof(DftAniEvent))

	arg_4_0.animEvent:SetEndEvent(function()
		arg_4_0:emit(var_0_0.ON_CLOSE)

		return
	end)

	arg_4_0.windowTF = arg_4_0._tf:Find("anim_root/window")
	arg_4_0.scrollview = arg_4_0.windowTF:Find("scrollview")
	arg_4_0.emptyTF = arg_4_0.scrollview:Find("empty")

	setText(arg_4_0.emptyTF:Find("Text"), i18n("child_mind_empty_tip"))

	arg_4_0.contentTF = arg_4_0.scrollview:Find("view/content")
	arg_4_0.finishListTF = arg_4_0.contentTF:Find("finish_list")
	arg_4_0.finishUIList = UIItemList.New(arg_4_0.finishListTF:Find("list"), arg_4_0.finishListTF:Find("list/tpl"))

	setText(arg_4_0.finishListTF:Find("title/Text"), i18n("child_mind_finish_title"))
	setText(arg_4_0.finishListTF:Find("list/tpl/get_btn/Text"), i18n("word_take"))

	arg_4_0.unFinishListTF = arg_4_0.contentTF:Find("unfinish_list")
	arg_4_0.unFinishUIList = UIItemList.New(arg_4_0.unFinishListTF:Find("list"), arg_4_0.unFinishListTF:Find("list/tpl"))

	setText(arg_4_0.unFinishListTF:Find("title/Text"), i18n("child_mind_processing_title"))
	setText(arg_4_0.unFinishListTF:Find("list/tpl/time_desc"), i18n("child_mind_time_title"))

	return
end

function var_0_0.addListener(arg_6_0)
	onButton(arg_6_0, arg_6_0._tf:Find("anim_root/bg"), function()
		arg_6_0:_close()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.didEnter(arg_8_0)
	arg_8_0:OverlayPanel(arg_8_0._tf, {
		groupDelta = 1
	})
	arg_8_0.finishUIList:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			GetOrAddComponent(arg_9_2, "CanvasGroup").alpha = 1

			arg_8_0:updateFinishItem(arg_9_1, arg_9_2)
		end

		return
	end)
	arg_8_0.unFinishUIList:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			arg_8_0:updateUnfinishItem(arg_10_1, arg_10_2)
		end

		return
	end)
	arg_8_0:updateItems()
	EducateTipHelper.ClearNewTip(EducateTipHelper.NEW_MIND_TASK)

	return
end

function var_0_0.sumbitTask(arg_11_0, arg_11_1)
	arg_11_0:emit(EducateMindMediator.ON_TASK_SUBMIT, arg_11_1)

	return
end

function var_0_0.updateItems(arg_12_0)
	local var_12_0 = getProxy(EducateProxy):GetCurTime()

	arg_12_0.taskVOs = underscore.select(arg_12_0.taskVOs, function(arg_13_0)
		return arg_13_0:InTime(var_12_0)
	end)
	arg_12_0.finishTaskVOs = {}
	arg_12_0.unFinishTaskVOs = {}

	underscore.each(arg_12_0.taskVOs, function(arg_14_0)
		if arg_14_0:IsFinish() then
			table.insert(arg_12_0.finishTaskVOs, arg_14_0)
		else
			table.insert(arg_12_0.unFinishTaskVOs, arg_14_0)
		end

		return
	end)

	local var_12_1 = CompareFuncs({
		function(arg_15_0)
			return arg_15_0:GetRemainTime(var_12_0)
		end,
		function(arg_16_0)
			return arg_16_0.id
		end
	})

	table.sort(arg_12_0.finishTaskVOs, var_12_1)
	table.sort(arg_12_0.unFinishTaskVOs, var_12_1)
	setActive(arg_12_0.finishListTF, #arg_12_0.finishTaskVOs > 0)
	arg_12_0.finishUIList:align(#arg_12_0.finishTaskVOs)
	setActive(arg_12_0.unFinishListTF, #arg_12_0.unFinishTaskVOs > 0)
	arg_12_0.unFinishUIList:align(#arg_12_0.unFinishTaskVOs)
	setActive(arg_12_0.emptyTF, #arg_12_0.finishTaskVOs <= 0 and #arg_12_0.unFinishTaskVOs <= 0)

	return
end

function var_0_0.updateFinishItem(arg_17_0, arg_17_1, arg_17_2)
	if LeanTween.isTweening(arg_17_2.gameObject) then
		LeanTween.cancel(arg_17_2.gameObject)
	end

	GetOrAddComponent(arg_17_2, "CanvasGroup").alpha = 1

	setActive(arg_17_2, true)
	setText(arg_17_2:Find("desc"), arg_17_0.finishTaskVOs[arg_17_1 + 1]:getConfig("name"))
	onButton(arg_17_0, arg_17_2:Find("get_btn"), function()
		if not arg_17_0.isClick then
			arg_17_0.isClick = true

			arg_17_0:doAnim(arg_17_2, function()
				return
			end)
			onDelayTick(function()
				arg_17_0.isClick = nil

				arg_17_0:sumbitTask(var_0)

				return
			end, 0.165)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updateUnfinishItem(arg_21_0, arg_21_1, arg_21_2)
	setText(arg_21_2:Find("desc"), arg_21_0.unFinishTaskVOs[arg_21_1 + 1]:getConfig("name"))

	local var_21_0 = arg_21_0.unFinishTaskVOs[arg_21_1 + 1]:GetRemainTime()

	setText(arg_21_2:Find("time_desc/time"), (var_21_0 < 7 and 0 or math.floor(var_21_0 / 7)) .. i18n("word_week"))

	return
end

function var_0_0.doAnim(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_1.transform.localPosition

	LeanTween.alphaCanvas(GetOrAddComponent(arg_22_1, "CanvasGroup"), 0, 0.198):setFrom(1)
	LeanTween.value(go(arg_22_1), arg_22_1.transform.localPosition.x, arg_22_1.transform.localPosition.x + 200, 0.264):setOnUpdate(System.Action_float(function(arg_23_0)
		arg_22_1.transform.localPosition = Vector3(arg_23_0, var_22_0.y, var_22_0.z)

		return
	end)):setEase(LeanTweenType.easeInCubic):setOnComplete(System.Action(function()
		arg_22_1.transform.localPosition = var_22_0

		setActive(arg_22_1, false)
		arg_22_2()

		return
	end))

	return
end

function var_0_0.updateView(arg_25_0)
	arg_25_0:initData()
	arg_25_0:updateItems()

	return
end

function var_0_0._close(arg_26_0)
	if arg_26_0.isClick then
		return
	end

	arg_26_0.anim:Play("anim_educate_mind_out")

	return
end

function var_0_0.onBackPressed(arg_27_0)
	arg_27_0:_close()

	return
end

function var_0_0.willExit(arg_28_0)
	arg_28_0.animEvent:SetEndEvent(nil)
	arg_28_0:UnOverlayPanel(arg_28_0._tf)

	if arg_28_0.contextData.onExit then
		arg_28_0.contextData.onExit()
	end

	return
end

return var_0_0
