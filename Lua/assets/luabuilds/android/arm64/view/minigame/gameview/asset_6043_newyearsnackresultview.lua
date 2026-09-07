local NewYearSnackResultView = class("NewYearSnackResultView", import(".SnackResultView"))

function NewYearSnackResultView:getUIName()
	return "NewYearSnackResult"
end

function NewYearSnackResultView:updateView()
	local var_2_0 = self:calculateEXValue()

	if self.contextData.countTime > 0 then
		setText(self.timeText, self.contextData.countTime .. "s   + " .. setColorStr(var_2_0 .. "s", "#3068E6FF"))
	else
		setText(self.timeText, self.contextData.countTime .. "s")
	end

	setText(self.scoreText, self.contextData.score .. "   + " .. setColorStr(var_2_0, "#3068E6FF"))
	self.orderList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			setImageSprite(arg_3_2:Find("SnackImg"), GetSpriteFromAtlas("ui/minigameui/newyearsnackui_atlas", "snack_" .. self.contextData.orderIDList[arg_3_1 + 1]))
		end

		return
	end)
	self.orderList:align(#self.contextData.orderIDList)
	self.selectedList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			local var_4_0 = self.contextData.selectedIDList[arg_4_1 + 1]

			setImageSprite(arg_4_2:Find("SnackImg"), GetSpriteFromAtlas("ui/minigameui/newyearsnackui_atlas", "snack_" .. self.contextData.selectedIDList[arg_4_1 + 1]))

			local var_4_1 = self.contextData.orderIDList[arg_4_1 + 1]
			local var_4_2 = arg_4_2:Find("ErrorImg")

			setActive(arg_4_2:Find("CorrectImg"), var_4_0 == self.contextData.orderIDList[arg_4_1 + 1])
			setActive(var_4_2, var_4_0 ~= var_4_1)
		end

		return
	end)
	self.selectedList:align(#self.contextData.selectedIDList)

	if self.contextData.countTime == 0 then
		setActive(self.continueBtn, false)
	end

	self.contextData.countTime = self.contextData.countTime + var_2_0
	self.contextData.score = self.contextData.score + var_2_0

	return
end

return NewYearSnackResultView
