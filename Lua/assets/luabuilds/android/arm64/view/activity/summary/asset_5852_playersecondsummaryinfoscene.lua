local PlayerSecondSummaryInfoScene = class("PlayerSecondSummaryInfoScene", import("...base.BaseUI"))

function PlayerSecondSummaryInfoScene:getUIName()
	return "PlayerSecondSummaryUI"
end

function PlayerSecondSummaryInfoScene:setActivity(arg_2_1)
	self.activityVO = arg_2_1

	return
end

function PlayerSecondSummaryInfoScene:setPlayer(arg_3_1)
	self.palyerVO = arg_3_1

	return
end

function PlayerSecondSummaryInfoScene:setSummaryInfo(arg_4_1)
	self.summaryInfoVO = arg_4_1

	return
end

function PlayerSecondSummaryInfoScene:init()
	self.backBtn = self._tf:Find("bg/back_btn")
	self.pageContainer = self._tf:Find("bg/main/pages")
	self.pageFootContainer = self._tf:Find("bg/main/foots")

	GetOrAddComponent(self.pageFootContainer, typeof(CanvasGroup))
	setCanvasGroupAlpha(self.pageFootContainer, 0)

	return
end

function PlayerSecondSummaryInfoScene:didEnter()
	if self.summaryInfoVO then
		self:initSummaryInfo()
	else
		self:emit(PlayerSummaryInfoMediator.GET_PLAYER_SUMMARY_INFO)
	end

	onButton(self, self.backBtn, function()
		if self:inAnim() then
			return
		end

		self:closeView()

		return
	end, SFX_CANCEL)

	return
end

function PlayerSecondSummaryInfoScene:inAnim()
	return self.inAniming or self.currPage and self.pages[self.currPage]:inAnim()
end

function PlayerSecondSummaryInfoScene:initSummaryInfo()
	self.loadingPage = SecondSummaryPage1.New(self.pageContainer:Find("page1"))

	self.loadingPage:Init(self.summaryInfoVO)

	self.pages = {}

	local function var_9_0(arg_10_0, arg_10_1, arg_10_2)
		setActive(arg_10_0, false)

		local var_10_0 = arg_10_1.New(arg_10_0)

		table.insert(self.pages, var_10_0)
		var_10_0:Init(arg_10_2)

		return
	end

	var_9_0(self.pageContainer:Find("page2"), SecondSummaryPage2, self.summaryInfoVO)
	var_9_0(self.pageContainer:Find("page3"), SecondSummaryPage3, self.summaryInfoVO)
	var_9_0(self.pageContainer:Find("page6"), SecondSummaryPage6, self.summaryInfoVO)

	local var_9_1 = self.pageContainer:Find("page4")

	setActive(var_9_1, false)

	for iter_9_0 = 1, (#self.summaryInfoVO.medalList > 0 or nil) and math.floor((#self.summaryInfoVO.medalList - 1) / SecondSummaryPage4.PerPageCount) + 1 do
		var_9_0(cloneTplTo(var_9_1, self.pageContainer, "page4_1_" .. iter_9_0), SecondSummaryPage4, setmetatable({
			pageType = SecondSummaryPage4.PageTypeFurniture,
			samePage = iter_9_0,
			activityVO = self.activityVO
		}, {
			__index = self.summaryInfoVO
		}))
	end

	for iter_9_1 = 1, (#self.summaryInfoVO.iconFrameList > 0 or nil) and math.floor((#self.summaryInfoVO.iconFrameList - 1) / SecondSummaryPage4.PerPageCount) + 1 do
		var_9_0(cloneTplTo(var_9_1, self.pageContainer, "page4_2_" .. iter_9_1), SecondSummaryPage4, setmetatable({
			pageType = SecondSummaryPage4.PageTypeIconFrame,
			samePage = iter_9_1,
			activityVO = self.activityVO
		}, {
			__index = self.summaryInfoVO
		}))
	end

	var_9_0(self.pageContainer:Find("page5"), SecondSummaryPage5, self.summaryInfoVO)
	onButton(self, self.pageContainer:Find("page5/share"), function()
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeSecondSummary)

		return
	end, SFX_CONFIRM)
	seriesAsync({
		function(arg_12_0)
			self.inAniming = true

			self.loadingPage:Show(arg_12_0)

			return
		end,
		function(arg_13_0)
			self.inAniming = false

			self.loadingPage:Hide()
			arg_13_0()

			return
		end
	}, function()
		self:registerDrag()
		self:registerFootEvent(1)

		return
	end)

	return
end

function PlayerSecondSummaryInfoScene:registerFootEvent(arg_15_1)
	local var_15_0 = UIItemList.New(self.pageFootContainer, self.pageFootContainer:Find("dot"))

	var_15_0:make(function(arg_16_0, arg_16_1, arg_16_2)
		local var_16_0 = arg_16_1 + 1

		if arg_16_0 == UIItemList.EventUpdate then
			onToggle(self, arg_16_2, function(arg_17_0)
				if arg_17_0 then
					self.pages[var_16_0]:Show()

					self.currPage = var_16_0
				else
					self.pages[var_16_0]:Hide()
				end

				return
			end)
		end

		return
	end)
	var_15_0:align(#self.pages)
	setCanvasGroupAlpha(self.pageFootContainer, 1)
	triggerToggle(self.pageFootContainer:GetChild(arg_15_1 - 1), true)

	return
end

function PlayerSecondSummaryInfoScene:registerDrag()
	self:addVerticalDrag(self._tf:Find("bg"), function()
		self:updatePageFoot(self.currPage - 1)

		return
	end, function()
		self:updatePageFoot(self.currPage + 1)

		return
	end)

	return
end

function PlayerSecondSummaryInfoScene:updatePageFoot(arg_21_1)
	if self:inAnim() or not self.pages[arg_21_1] then
		return
	end

	triggerToggle(self.pageFootContainer:GetChild(arg_21_1 - 1), true)

	return
end

function PlayerSecondSummaryInfoScene:addVerticalDrag(arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = GetOrAddComponent(arg_22_1, "EventTriggerListener")
	local var_22_1
	local var_22_2 = 0
	local var_22_3 = 50

	var_22_0:AddBeginDragFunc(function(arg_23_0, arg_23_1)
		var_22_2 = 0
		var_22_1 = arg_23_1.position

		return
	end)
	var_22_0:AddDragFunc(function(arg_24_0, arg_24_1)
		var_22_2 = arg_24_1.position.x - var_22_1.x

		return
	end)
	var_22_0:AddDragEndFunc(function(arg_25_0, arg_25_1)
		if var_22_2 < -var_22_3 then
			if arg_22_3 then
				arg_22_3()
			end
		elseif var_22_2 > var_22_3 and arg_22_2 then
			arg_22_2()
		end

		return
	end)

	return
end

function PlayerSecondSummaryInfoScene:willExit()
	for iter_26_0, iter_26_1 in pairs(self.pages) do
		iter_26_1:Dispose()
	end

	self.pages = nil
	self.currPage = nil

	return
end

return PlayerSecondSummaryInfoScene
