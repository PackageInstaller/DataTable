local AuctionGameTaskScene = class("AuctionGameTaskScene", import("view.base.BaseUI"))

AuctionGameTaskScene.TASK_TYPE = {
	DAILY = 1,
	CHALLENGE = 2
}

function AuctionGameTaskScene:getUIName()
	return "AuctionGameTaskUI"
end

function AuctionGameTaskScene:init()
	onButton(self, self.uiCloseBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	setText(self.uiGetAllText, i18n("auction_signin_collect"))
	onButton(self, self.uiGetAllBtn, function()
		local var_4_0 = {}

		if pg.NewGuideMgr.GetInstance():IsBusy() then
			for iter_4_0, iter_4_1 in ipairs(self.dailyTaskList) do
				if iter_4_1:getTaskStatus() == 1 then
					table.insert(var_4_0, iter_4_1.id)
				end
			end

			for iter_4_2, iter_4_3 in ipairs(self.challengeTaskList) do
				if iter_4_3:getTaskStatus() == 1 then
					table.insert(var_4_0, iter_4_3.id)
				end
			end
		else
			for iter_4_4, iter_4_5 in ipairs(self.taskList) do
				if iter_4_5:getTaskStatus() == 1 then
					table.insert(var_4_0, iter_4_5.id)
				end
			end
		end

		if #var_4_0 <= 0 then
			return
		end

		self:emit(AuctionGameTaskMediator.ON_ACTIVITY_TASK_SUBMIT_ONESTEP, self.taskActivityID, var_4_0)

		return
	end, SFX_PANEL)
	onButton(self, self.uiDailyBtn, function()
		self:OnSwitchBtn(AuctionGameTaskScene.TASK_TYPE.DAILY)

		return
	end, SFX_PANEL)
	onButton(self, self.uiChallengeBtn, function()
		self:OnSwitchBtn(AuctionGameTaskScene.TASK_TYPE.CHALLENGE)

		return
	end, SFX_PANEL)
	setText(self.uiDailyText, i18n("auction_task_daily"))
	setText(self.uiChallengeText, i18n("auction_task_challenge"))

	self.itemList = {}
	self.uiLScroll = GetComponent(self.uiScroll, "LScrollRect")
	self.onInitItemHandler = handler(self, self.OnInitItem)
	self.onUpdateItemHandler = handler(self, self.OnUpdateItem)
	self.uiLScroll.onInitItem = self.onInitItemHandler
	self.uiLScroll.onUpdateItem = self.onUpdateItemHandler

	return
end

function AuctionGameTaskScene:didEnter()
	self:OverlayPanel(self._tf, {})
	setPaintingPrefabAsync(self.uiPaintingTf, pg.ship_skin_template[900284].painting, "chuanwu", nil, {
		skinID = 900284
	})
	self:OnSwitchBtn(AuctionGameTaskScene.TASK_TYPE.DAILY)

	return
end

function AuctionGameTaskScene:willExit()
	self:UnOverlayPanel(self._tf)
	retPaintingPrefab(self.uiPaintingTf, pg.ship_skin_template[900284].painting)

	self.uiLScroll.onInitItem = nil
	self.uiLScroll.onUpdateItem = nil
	self.onInitItemHandler = nil
	self.onUpdateItemHandler = nil

	return
end

function AuctionGameTaskScene:OnSwitchBtn(arg_9_1)
	if arg_9_1 == AuctionGameTaskScene.TASK_TYPE.DAILY then
		setTextColor(self.uiDailyText, Color.NewHex("#FFFFFF"))
		setTextColor(self.uiChallengeText, Color.NewHex("#393A3C"))
		setActive(self.uiDailySelectedGo, true)
		setActive(self.uiChallengeSelectedGo, false)
	else
		setTextColor(self.uiDailyText, Color.NewHex("#393A3C"))
		setTextColor(self.uiChallengeText, Color.NewHex("#FFFFFF"))
		setActive(self.uiDailySelectedGo, false)
		setActive(self.uiChallengeSelectedGo, true)
	end

	self.selectedType = arg_9_1

	self:RefreshUI()

	return
end

function AuctionGameTaskScene:GetTaskList()
	local var_10_0 = {}
	local var_10_1 = {}
	local var_10_2 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AUCTION_GAME):getConfig("config_client").taskActID

	self.taskActivityID = var_10_2

	local var_10_3 = getProxy(TaskProxy)

	for iter_10_0, iter_10_1 in ipairs(pg.activity_template[var_10_2].config_data) do
		local var_10_4 = var_10_3:getTaskVO(iter_10_1) or Task.New({
			id = iter_10_1
		})

		if var_10_4:IsActRoutineType() then
			table.insert(var_10_0, var_10_4)
		else
			table.insert(var_10_1, var_10_4)
		end
	end

	return var_10_0, var_10_1
end

function AuctionGameTaskScene:RefreshUI()
	self.dailyTaskList, self.challengeTaskList = self:GetTaskList()

	if self.selectedType == AuctionGameTaskScene.TASK_TYPE.DAILY then
		self.taskList = self.dailyTaskList

		setGray(self.uiGetAllBtn, not self:IsDailyTip())
	else
		self.taskList = self.challengeTaskList

		setGray(self.uiGetAllBtn, not self:IsChallengeTip())
	end

	self:Sort(self.taskList)
	self.uiLScroll:SetTotalCount(#self.taskList)
	setActive(self.uiDailyTipGo, self:IsDailyTip())
	setActive(self.uiChallengeTipGo, self:IsChallengeTip())

	return
end

function AuctionGameTaskScene:OnInitItem(arg_12_1)
	self.itemList[arg_12_1] = AuctionGameTaskItem.New(tf(arg_12_1), self)

	return
end

function AuctionGameTaskScene:OnUpdateItem(arg_13_1, arg_13_2)
	if self.itemList[arg_13_2] == nil then
		self:OnInitItem(arg_13_2)
	end

	self.itemList[arg_13_2]:SetData(self.taskList[arg_13_1 + 1])

	return
end

function AuctionGameTaskScene:Sort()
	local function var_14_0(arg_15_0, arg_15_1, arg_15_2)
		local function var_15_0(arg_16_0)
			for iter_16_0, iter_16_1 in ipairs(arg_15_2) do
				if arg_16_0 == iter_16_1 then
					return iter_16_0
				end
			end

			return
		end

		return var_15_0(arg_15_0) < var_15_0(arg_15_1)
	end

	table.sort(self.taskList, function(arg_17_0, arg_17_1)
		local var_17_0 = arg_17_0:getTaskStatus()
		local var_17_1 = arg_17_1:getTaskStatus()

		if var_17_0 == var_17_1 then
			return arg_17_0.id < arg_17_1.id
		end

		return var_14_0(var_17_0, var_17_1, {
			1,
			0,
			2,
			-1
		})
	end)

	return
end

function AuctionGameTaskScene:IsDailyTip()
	for iter_18_0, iter_18_1 in ipairs(self.dailyTaskList) do
		if iter_18_1:getTaskStatus() == 1 then
			return true
		end
	end

	return false
end

function AuctionGameTaskScene:IsChallengeTip()
	for iter_19_0, iter_19_1 in ipairs(self.challengeTaskList) do
		if iter_19_1:getTaskStatus() == 1 then
			return true
		end
	end

	return false
end

return AuctionGameTaskScene
