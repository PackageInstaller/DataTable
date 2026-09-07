local SnackResultView = class("SnackResultView", import("...base.BaseSubView"))

SnackResultView.EXTable = {
	[0] = 0,
	1,
	2,
	5
}

function SnackResultView:getUIName()
	return "SnackResult"
end

function SnackResultView:OnInit()
	self:initUI()
	self:updateView()
	self:Show()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function SnackResultView:OnDestroy()
	self.lockBackPress = false

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function SnackResultView:initUI()
	local var_4_0 = self._tf:Find("Content")

	self.timeText = var_4_0:Find("Tip/Time/TimeText")
	self.scoreText = var_4_0:Find("Tip/Score/ScoreText")
	self.snackTpl = var_4_0:Find("SnackTpl")
	self.orderListContainer = var_4_0:Find("Order/OrderList")
	self.orderList = UIItemList.New(self.orderListContainer, self.snackTpl)
	self.selectedListContainer = var_4_0:Find("Select/SelectList")
	self.selectedList = UIItemList.New(self.selectedListContainer, self.snackTpl)
	self.submitBtn = var_4_0:Find("Buttons/SubmitBtn")
	self.continueBtn = var_4_0:Find("Buttons/ContinueBtn")

	onButton(self, self.submitBtn, function()
		self.contextData.onSubmit((self:calculateLevel()))
		self:Destroy()

		return
	end, SFX_PANEL)
	onButton(self, self.continueBtn, function()
		self.contextData.onContinue()
		self:Destroy()

		return
	end)

	return
end

function SnackResultView:updateView()
	local var_7_0 = self:calculateEXValue()

	if self.contextData.countTime > 0 then
		setText(self.timeText, self.contextData.countTime .. "s   + " .. setColorStr(var_7_0 .. "s", "#3068E6FF"))
	else
		setText(self.timeText, self.contextData.countTime .. "s")
	end

	setText(self.scoreText, self.contextData.score .. "   + " .. setColorStr(var_7_0, "#3068E6FF"))
	self.orderList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			setImageSprite(arg_8_2:Find("SnackImg"), GetSpriteFromAtlas("ui/snackui_atlas", "snack_" .. self.contextData.orderIDList[arg_8_1 + 1]))
		end

		return
	end)
	self.orderList:align(#self.contextData.orderIDList)
	self.selectedList:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			local var_9_0 = self.contextData.selectedIDList[arg_9_1 + 1]

			setImageSprite(arg_9_2:Find("SnackImg"), GetSpriteFromAtlas("ui/snackui_atlas", "snack_" .. self.contextData.selectedIDList[arg_9_1 + 1]))

			local var_9_1 = self.contextData.orderIDList[arg_9_1 + 1]
			local var_9_2 = arg_9_2:Find("ErrorImg")

			setActive(arg_9_2:Find("CorrectImg"), var_9_0 == self.contextData.orderIDList[arg_9_1 + 1])
			setActive(var_9_2, var_9_0 ~= var_9_1)
		end

		return
	end)
	self.selectedList:align(#self.contextData.selectedIDList)

	if self.contextData.countTime == 0 then
		setActive(self.continueBtn, false)
	end

	self.contextData.countTime = self.contextData.countTime + var_7_0
	self.contextData.score = self.contextData.score + var_7_0

	return
end

function SnackResultView:calculateEXValue()
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs(self.contextData.selectedIDList) do
		if self.contextData.orderIDList[iter_10_0] == iter_10_1 then
			var_10_0 = var_10_0 + 1
		end
	end

	return self.contextData.correctNumToEXValue[var_10_0]
end

function SnackResultView:calculateLevel()
	if self.contextData.score >= self.contextData.scoreLevel[4] then
		return 1
	elseif self.contextData.score >= self.contextData.scoreLevel[3] then
		return 2
	elseif self.contextData.score >= self.contextData.scoreLevel[2] then
		return 3
	elseif self.contextData.score >= self.contextData.scoreLevel[1] then
		return 4
	end

	return
end

return SnackResultView
