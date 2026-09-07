local PlayerSummaryInfoScene = class("PlayerSummaryInfoScene", import("...base.BaseUI"))

function PlayerSummaryInfoScene:getUIName()
	return "PlayerSummaryUI"
end

function PlayerSummaryInfoScene:setActivity(arg_2_1)
	self.activityVO = arg_2_1

	return
end

function PlayerSummaryInfoScene:setPlayer(arg_3_1)
	self.palyerVO = arg_3_1

	return
end

function PlayerSummaryInfoScene:setSummaryInfo(arg_4_1)
	self.summaryInfoVO = arg_4_1

	return
end

function PlayerSummaryInfoScene:init()
	self.backBtn = self._tf:Find("bg/back_btn")
	self.pageContainer = self._tf:Find("bg/main/pages")
	self.pageFootContainer = self._tf:Find("bg/main/page_foot")

	return
end

function PlayerSummaryInfoScene:didEnter()
	if self.summaryInfoVO then
		self:initSummaryInfo()
	else
		self:emit(PlayerSummaryInfoMediator.GET_PLAYER_SUMMARY_INFO)
	end

	onButton(self, self.backBtn, function()
		if self:inAnim() then
			return
		end

		self:emit(PlayerSummaryInfoScene.ON_BACK)

		return
	end, SFX_CANCEL)

	return
end

function PlayerSummaryInfoScene:inAnim()
	if _.any(self.pages or {}, function(arg_9_0)
		return arg_9_0:inAnim()
	end) then
		return true
	end

	return false
end

function PlayerSummaryInfoScene:initSummaryInfo()
	self.loadingPage = SummaryPageLoading.New(self.pageContainer:Find("loading"))
	self.pages = {
		SummaryPage1.New(self.pageContainer:Find("page1")),
		SummaryPage2.New(self.pageContainer:Find("page2")),
		SummaryPage3.New(self.pageContainer:Find("page3")),
		SummaryPage4.New(self.pageContainer:Find("page4")),
		SummaryPage4.New(self.pageContainer:Find("page4_1")),
		SummaryPage4.New(self.pageContainer:Find("page4_2")),
		SummaryPage5.New(self.pageContainer:Find("page5"))
	}

	table.remove(self.pages, self.summaryInfoVO.isProPose and 3 or 2):Hide()
	setActive(self.pageFootContainer, false)
	seriesAsync({
		function(arg_11_0)
			self.loadingPage:Init(self.summaryInfoVO)
			arg_11_0()

			return
		end,
		function(arg_12_0)
			self.loadingPage:Show(arg_12_0)

			return
		end,
		function(arg_13_0)
			self.loadingPage:Hide(arg_13_0)

			return
		end,
		function(arg_14_0)
			for iter_14_0, iter_14_1 in ipairs(self.pages) do
				iter_14_1:Init(self.summaryInfoVO)
			end

			arg_14_0()

			return
		end,
		function(arg_15_0)
			self:registerFootEvent()
			arg_15_0()

			return
		end,
		function(arg_16_0)
			self:updatePageFoot(1)
			arg_16_0()

			return
		end,
		function(arg_17_0)
			self:registerDrag()
			arg_17_0()

			return
		end
	}, function()
		setActive(self.pageFootContainer, true)

		return
	end)

	return
end

function PlayerSummaryInfoScene:registerFootEvent()
	self.footTFs = {}

	for iter_19_0 = 1, #self.pages do
		local var_19_0 = self.pageFootContainer:Find("dot_" .. iter_19_0)

		table.insert(self.footTFs, var_19_0)
		onToggle(self, var_19_0, function(arg_20_0)
			if arg_20_0 then
				self.pages[iter_19_0]:Show()

				self.currPage = iter_19_0
			else
				self.pages[self.currPage]:Hide()
			end

			return
		end)
	end

	return
end

function PlayerSummaryInfoScene:registerDrag()
	self:addVerticalDrag(self._tf:Find("bg"), function()
		self:updatePageFoot(self.currPage + 1)

		return
	end, function()
		self:updatePageFoot(self.currPage - 1)

		return
	end)

	return
end

function PlayerSummaryInfoScene:updatePageFoot(arg_24_1)
	if self:inAnim() then
		return
	end

	if not self.footTFs[arg_24_1] then
		return
	end

	triggerToggle(self.footTFs[arg_24_1], true)

	return
end

function PlayerSummaryInfoScene:addVerticalDrag(arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = GetOrAddComponent(arg_25_1, "EventTriggerListener")
	local var_25_1
	local var_25_2 = 0
	local var_25_3 = 50

	var_25_0:AddBeginDragFunc(function()
		var_25_2 = 0
		var_25_1 = nil

		return
	end)
	var_25_0:AddDragFunc(function(arg_27_0, arg_27_1)
		var_25_1 = var_25_1 or arg_27_1.position
		var_25_2 = arg_27_1.position.y - var_25_1.y

		return
	end)
	var_25_0:AddDragEndFunc(function(arg_28_0, arg_28_1)
		if var_25_2 < -var_25_3 then
			if arg_25_3 then
				arg_25_3()
			end
		elseif var_25_2 > var_25_3 and arg_25_2 then
			arg_25_2()
		end

		return
	end)

	return
end

function PlayerSummaryInfoScene:willExit()
	for iter_29_0, iter_29_1 in pairs(self.pages) do
		iter_29_1:Dispose()
	end

	self.pages = nil

	self.loadingPage:Dispose()

	self.loadingPage = nil

	return
end

return PlayerSummaryInfoScene
