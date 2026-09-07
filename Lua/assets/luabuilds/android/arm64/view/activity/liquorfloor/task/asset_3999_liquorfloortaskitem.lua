local LiquorFloorTaskItem = class("LiquorFloorTaskItem", import("view.base.BasePanel"))

function LiquorFloorTaskItem:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	LiquorFloorTaskItem.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function LiquorFloorTaskItem:Init()
	setText(self.uiGoText, i18n("LiquorFloorTaskUI_go"))
	setText(self.uiGetText, i18n("LiquorFloorTaskUI_get"))
	setText(self.uiGotText, i18n("LiquorFloorTaskUI_got"))
	onButton(self, self.uiGoBtn, function()
		self:emit(LiquorFloorTaskMediator.ON_TASK_GO, self.taskVO)

		return
	end, SFX_PANEL)
	onButton(self, self.uiGetBtn, function()
		self:emit(LiquorFloorTaskMediator.ON_TASK_SUBMIT, self.taskVO)

		return
	end, SFX_PANEL)

	self.rewardList = UIItemList.New(self.uiRewardList, self.uiRewardItem)

	self.rewardList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			local var_5_0 = Drop.Create(self.taskVO:getConfig("award_display")[arg_5_1 + 1])

			updateDrop(arg_5_2, var_5_0)
			onButton(self, arg_5_2, function()
				self:emit(BaseUI.ON_DROP, var_5_0)

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function LiquorFloorTaskItem:didEnter()
	return
end

function LiquorFloorTaskItem:willExit()
	self:detach()

	return
end

function LiquorFloorTaskItem:SetData(arg_9_1)
	self.taskVO = arg_9_1

	setText(self.uiDescText, arg_9_1:getConfig("desc"))

	local var_9_0 = arg_9_1:getConfig("target_num")
	local var_9_1 = arg_9_1:getProgress()

	if var_9_0 < var_9_1 then
		var_9_1 = var_9_0
	end

	setText(self.uiProgressText, string.format("%s/%s", var_9_1, var_9_0))

	self.uiSlider.value = var_9_1 / var_9_0

	if arg_9_1:isReceive() then
		setActive(self.uiGoBtn, false)
		setActive(self.uiGetBtn, false)
		setActive(self.uiGotBtn, true)
	else
		setActive(self.uiGotBtn, false)

		if arg_9_1:isFinish() then
			setActive(self.uiGoBtn, false)
			setActive(self.uiGetBtn, true)
		else
			setActive(self.uiGoBtn, true)
			setActive(self.uiGetBtn, false)
		end
	end

	self.rewardList:align(#arg_9_1:getConfig("award_display"))

	return
end

return LiquorFloorTaskItem
