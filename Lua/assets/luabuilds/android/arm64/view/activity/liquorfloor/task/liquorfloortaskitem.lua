local var_0_0 = class("LiquorFloorTaskItem", import("view.base.BasePanel"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_0.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	setText(arg_2_0.uiGoText, i18n("LiquorFloorTaskUI_go"))
	setText(arg_2_0.uiGetText, i18n("LiquorFloorTaskUI_get"))
	setText(arg_2_0.uiGotText, i18n("LiquorFloorTaskUI_got"))
	onButton(arg_2_0, arg_2_0.uiGoBtn, function()
		arg_2_0:emit(LiquorFloorTaskMediator.ON_TASK_GO, arg_2_0.taskVO)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiGetBtn, function()
		arg_2_0:emit(LiquorFloorTaskMediator.ON_TASK_SUBMIT, arg_2_0.taskVO)

		return
	end, SFX_PANEL)

	arg_2_0.rewardList = UIItemList.New(arg_2_0.uiRewardList, arg_2_0.uiRewardItem)

	arg_2_0.rewardList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			updateDrop(arg_5_2, (Drop.Create(arg_2_0.taskVO:getConfig("award_display")[arg_5_1 + 1])))
			onButton(arg_2_0, arg_5_2, function()
				arg_2_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function var_0_0.didEnter(arg_7_0)
	return
end

function var_0_0.willExit(arg_8_0)
	arg_8_0:detach()

	return
end

function var_0_0.SetData(arg_9_0, arg_9_1)
	arg_9_0.taskVO = arg_9_1

	setText(arg_9_0.uiDescText, arg_9_1:getConfig("desc"))

	local var_9_0 = arg_9_1:getConfig("target_num")
	local var_9_1 = arg_9_1:getProgress()

	if var_9_0 < var_9_1 then
		var_9_1 = var_9_0
	end

	setText(arg_9_0.uiProgressText, string.format("%s/%s", var_9_1, var_9_0))

	arg_9_0.uiSlider.value = var_9_1 / var_9_0

	if arg_9_1:isReceive() then
		setActive(arg_9_0.uiGoBtn, false)
		setActive(arg_9_0.uiGetBtn, false)
		setActive(arg_9_0.uiGotBtn, true)
	else
		setActive(arg_9_0.uiGotBtn, false)

		if arg_9_1:isFinish() then
			setActive(arg_9_0.uiGoBtn, false)
			setActive(arg_9_0.uiGetBtn, true)
		else
			setActive(arg_9_0.uiGoBtn, true)
			setActive(arg_9_0.uiGetBtn, false)
		end
	end

	arg_9_0.rewardList:align(#arg_9_1:getConfig("award_display"))

	return
end

return var_0_0
