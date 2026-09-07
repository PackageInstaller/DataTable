local AuctionGameTaskItem = class("AuctionGameTaskItem", import("view.base.BasePanel"))

function AuctionGameTaskItem:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	AuctionGameTaskItem.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function AuctionGameTaskItem:Init()
	onButton(self, self.uiGoBtn, function()
		local var_3_0 = self.taskVO:getConfig("scene")

		if var_3_0 and #var_3_0 > 0 and var_3_0[2] and var_3_0[2].unlockActivityID and var_3_0[1] == "AUCTION_GAME_ENTRANCE" then
			if getProxy(ContextProxy):getContextByMediator(AuctionGameEntranceMediator) then
				self:emit(BaseUI.ON_CLOSE)

				return
			end
		end

		self:emit(AuctionGameTaskMediator.ON_TASK_GO, self.taskVO)

		return
	end, SFX_PANEL)
	onButton(self, self.uiGetBtn, function()
		self:emit(AuctionGameTaskMediator.ON_TASK_SUBMIT, self.taskVO)

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

function AuctionGameTaskItem:didEnter()
	return
end

function AuctionGameTaskItem:willExit()
	self:detach()

	return
end

function AuctionGameTaskItem:SetData(arg_9_1)
	self.taskVO = arg_9_1

	setText(self.uiDescText, arg_9_1:getConfig("desc"))

	local var_9_0 = arg_9_1:getConfig("target_num")
	local var_9_1 = arg_9_1:getProgress()

	if arg_9_1:getConfig("sub_type") == TASK_SUB_TYPE_REPEATABLE then
		var_9_0 = 1
	end

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
	setActive(self.uiRepeatableGo, arg_9_1:getConfig("type") == Task.TYPE_REPEATABLE)

	return
end

return AuctionGameTaskItem
