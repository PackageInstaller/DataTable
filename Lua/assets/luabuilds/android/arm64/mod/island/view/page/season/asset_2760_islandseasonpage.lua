local IslandSeasonPage = class("IslandSeasonPage", import("...base.IslandBasePage"))

IslandSeasonPage.CLOSE = "IslandSeasonPage:CLOSE"
IslandSeasonPage.UPDATE_REDDOT = "IslandSeasonPage:UPDATE_REDDOT"
IslandSeasonPage.PAGE_ACTIVITY = "activity"
IslandSeasonPage.PAGE_PT = "pt"
IslandSeasonPage.PAGE_TASK = "task"
IslandSeasonPage.PAGE_SHOP = "shop"
IslandSeasonPage.PAGE_RANK = "rank"
IslandSeasonPage.PAGE_REVIEW = "review"

function IslandSeasonPage:getUIName()
	return "IslandSeasonUI"
end

function IslandSeasonPage:Preload(arg_2_1)
	pg.PoolMgr.GetInstance():PreloadUI("IslandSeasonActivityPanel", arg_2_1)

	return
end

function IslandSeasonPage:OnLoaded()
	self.blurTF = self._tf:Find("blur")

	setText(self.blurTF:Find("top/title/Text"), i18n("island_season_title"))

	self.ptTitleTF = self.blurTF:Find("pt_title")
	self.otherTitleTF = self.blurTF:Find("other_title")

	local var_3_0 = self.blurTF:Find("pages")

	self.pages = {
		[IslandSeasonPage.PAGE_ACTIVITY] = IslandSeasonActivityPanel.New(var_3_0, self.event, self.contextData),
		[IslandSeasonPage.PAGE_PT] = IslandSeasonPtPanel.New(var_3_0, self.event, setmetatable({
			ShowMsgBox = function(arg_4_0, arg_4_1)
				self:ShowMsgBox(arg_4_1)

				return
			end
		}, {
			__index = self.contextData
		})),
		[IslandSeasonPage.PAGE_TASK] = IslandSeasonTaskPanel.New(var_3_0, self.event, setmetatable({
			ShowMsgBox = function(arg_5_0, arg_5_1)
				self:ShowMsgBox(arg_5_1)

				return
			end
		}, {
			__index = self.contextData
		})),
		[IslandSeasonPage.PAGE_SHOP] = IslandSeasonShopPanel.New(var_3_0, self.event, setmetatable({
			openBuyLayer = function(arg_6_0, arg_6_1)
				self:OpenPage(IslandShopItemLayer, arg_6_0, arg_6_1)

				return
			end
		}, {
			__index = self.contextData
		})),
		[IslandSeasonPage.PAGE_RANK] = IslandSeasonRankPanel.New(var_3_0, self.event, setmetatable({
			ShowMsgBox = function(arg_7_0, arg_7_1)
				self:ShowMsgBox(arg_7_1)

				return
			end
		}, {
			__index = self.contextData
		}))
	}

	for iter_3_0, iter_3_1 in pairs(self.pages) do
		iter_3_1:RegisterView(self.viewComponent)
	end

	local var_3_1 = IslandSeasonAgency.GetCurrentSeason() == 1

	if not var_3_1 then
		self.pages[IslandSeasonPage.PAGE_REVIEW] = IslandSeasonReviewPanel.New(var_3_0, self.event, self.contextData)
	end

	self.togglesTF = self.blurTF:Find("toggles/content")

	setActive(self.togglesTF:Find(IslandSeasonPage.PAGE_REVIEW), not var_3_1)

	local function var_3_2(arg_8_0, arg_8_1)
		setText(arg_8_0:Find("sel/Text"), arg_8_1)
		setText(arg_8_0:Find("sel/Text/shandw"), arg_8_1)
		setText(arg_8_0:Find("unsel/Text"), arg_8_1)
		setText(arg_8_0:Find("unsel/Text/shandw"), arg_8_1)

		return
	end

	var_3_2(self.togglesTF:Find("activity"), i18n("island_season_activity"))
	var_3_2(self.togglesTF:Find("pt"), i18n("island_season_pt"))
	var_3_2(self.togglesTF:Find("task"), i18n("island_season_task"))
	var_3_2(self.togglesTF:Find("shop"), i18n("island_season_shop"))
	var_3_2(self.togglesTF:Find("rank"), i18n("island_season_charts"))
	var_3_2(self.togglesTF:Find("review"), i18n("island_season_review"))

	self.playRoomPop = PlayRoomPop.New(self.blurTF:Find("playRoomPop"), self)

	self.playRoomPop:didEnter()

	return
end

function IslandSeasonPage:Close(arg_9_1)
	self:emit(IslandMediator.PLAY_ROOM_MATCH_STOP)
	self:Hide(arg_9_1)

	return
end

function IslandSeasonPage:OnInit()
	onButton(self, self.blurTF:Find("top/back"), function()
		self:Close(true)

		return
	end, SFX_PANEL)
	onButton(self, self.blurTF:Find("top/help"), function()
		self:ShowMsgBox({
			type = IslandMsgBox.TYPE_WHITOUT_BTN,
			content = i18n("island_season_help")
		})

		return
	end, SFX_PANEL)
	eachChild(self.togglesTF, function(arg_13_0)
		onToggle(self, arg_13_0, function(arg_14_0)
			if arg_14_0 then
				self.curPage = arg_13_0.name

				self:SwitchPage()
			end

			return
		end, SFX_PANEL)

		return
	end)
	self:bind(IslandSeasonPage.CLOSE, function()
		self:Close(false)

		return
	end)
	self:bind(IslandSeasonPage.UPDATE_REDDOT, function(arg_16_0, arg_16_1)
		self:UpdateRedDot(arg_16_1)

		return
	end)
	self:UpdateRedDot()

	return
end

function IslandSeasonPage:UpdateRedDot(arg_17_1)
	eachChild(self.togglesTF, function(arg_18_0)
		if not arg_17_1 or arg_18_0.name == arg_17_1 then
			setActive(arg_18_0:Find("red"), IslandSeasonRedDotHelper.TipTag(arg_18_0.name))
		end

		return
	end)

	return
end

function IslandSeasonPage:AddListeners()
	self:AddListener(ActivityProxy.ACTIVITY_UPDATED, self.FlushActivityPage)
	self:AddListener(IslandSeasonAgency.ADD_PT, self.FlushPtPage)
	self:AddListener(GAME.ISLAND_GET_SEASON_PT_AWARD_DONE, self.FlushPtPage)
	self:AddListener(GAME.ISLAND_SUBMIT_TASK_DONE, self.OnSubmitTaskDone)
	self:AddListener(GAME.ISLAND_SUBMIT_TASK_ONE_STEP_DONE, self.OnSubmitTaskDone)
	self:AddListener(GAME.ISLAND_SHOP_OP_DONE, self.FlushShopPage)
	self:AddListener(GAME.ISLAND_GET_SEASON_RANK_DONE, self.OnGetRankData)
	self:AddListener(IslandTaskAgency.TASK_ADDED, self.OnTaskAdded)
	self:AddListener(IslandTaskAgency.TASK_UPDATED, self.OnTaskUpdate)
	self:AddListener(IslandTaskAgency.TASK_REMOVED, self.OnTaskRemove)
	self:AddListener(IslandTaskAgency.TASK_FINISH, self.OnTaskFinish)

	return
end

function IslandSeasonPage:RemoveListeners()
	self:RemoveListener(ActivityProxy.ACTIVITY_UPDATED, self.FlushActivityPage)
	self:RemoveListener(IslandSeasonAgency.ADD_PT, self.FlushPtPage)
	self:RemoveListener(GAME.ISLAND_GET_SEASON_PT_AWARD_DONE, self.FlushPtPage)
	self:RemoveListener(GAME.ISLAND_SUBMIT_TASK_DONE, self.OnSubmitTaskDone)
	self:RemoveListener(GAME.ISLAND_SUBMIT_TASK_ONE_STEP_DONE, self.OnSubmitTaskDone)
	self:RemoveListener(GAME.ISLAND_SHOP_OP_DONE, self.FlushShopPage)
	self:RemoveListener(GAME.ISLAND_GET_SEASON_RANK_DONE, self.OnGetRankData)
	self:RemoveListener(IslandTaskAgency.TASK_ADDED, self.OnTaskAdded)
	self:RemoveListener(IslandTaskAgency.TASK_UPDATED, self.OnTaskUpdate)
	self:RemoveListener(IslandTaskAgency.TASK_REMOVED, self.OnTaskRemove)
	self:RemoveListener(IslandTaskAgency.TASK_FINISH, self.OnTaskFinish)

	return
end

function IslandSeasonPage:OnShow(arg_21_1)
	self.contextData.season = getProxy(IslandProxy):GetIsland():GetSeasonAgency():GetSeason()

	if arg_21_1 and arg_21_1.target_act_id then
		triggerToggle(self.togglesTF:Find(IslandSeasonPage.PAGE_ACTIVITY), true)
		self.pages[IslandSeasonPage.PAGE_ACTIVITY]:ExecuteAction("verifyTabs", arg_21_1.target_act_id)
	else
		triggerToggle(self.togglesTF:Find(IslandSeasonPage.PAGE_ACTIVITY), true)
	end

	self.playRoomPop:Show(true)

	return
end

local var_0_1 = {
	[IslandSeasonPage.PAGE_ACTIVITY] = 1,
	[IslandSeasonPage.PAGE_PT] = 2,
	[IslandSeasonPage.PAGE_TASK] = 3,
	[IslandSeasonPage.PAGE_SHOP] = 3,
	[IslandSeasonPage.PAGE_RANK] = 3,
	[IslandSeasonPage.PAGE_REVIEW] = 4
}

function IslandSeasonPage:SwitchPage()
	for iter_22_0, iter_22_1 in pairs(self.pages) do
		if iter_22_0 == self.curPage then
			iter_22_1:ExecuteAction("Show")
		else
			iter_22_1:ExecuteAction("Hide")
		end

		local var_22_0 = var_0_1[self.curPage]

		SetCompomentEnabled(self.blurTF, "Image", var_0_1[self.curPage] == 1 or var_22_0 == 3 or var_22_0 == 4)
		setActive(self.ptTitleTF, var_22_0 == 2)
		setActive(self.otherTitleTF, var_22_0 == 3)

		if var_22_0 == 1 or var_22_0 == 3 or var_22_0 == 4 then
			self:OverlayPanel(self.blurTF, {
				pbList = {
					self.blurTF
				}
			})
		else
			self:UnOverlayPanel(self.blurTF, self._tf)
		end
	end

	return
end

function IslandSeasonPage:UpdateTaskAct(arg_23_1)
	self.pages[IslandSeasonPage.PAGE_ACTIVITY]:ExecuteAction("OnTaskUpdate", arg_23_1)

	return
end

function IslandSeasonPage:OnTaskAdded(arg_24_1)
	if not arg_24_1 then
		return
	end

	self:UpdateTaskAct(arg_24_1.id)

	return
end

function IslandSeasonPage:OnTaskUpdate(arg_25_1)
	if not arg_25_1 then
		return
	end

	self:UpdateTaskAct(arg_25_1.id)

	return
end

function IslandSeasonPage:OnTaskRemove(arg_26_1)
	if not arg_26_1 then
		return
	end

	self:UpdateTaskAct(arg_26_1.id)

	return
end

function IslandSeasonPage:OnTaskFinish(arg_27_1)
	if not arg_27_1 then
		return
	end

	self:UpdateTaskAct(arg_27_1)

	return
end

function IslandSeasonPage:FlushActivityPage(arg_28_1)
	self.pages[IslandSeasonPage.PAGE_ACTIVITY]:ExecuteAction("updateActivity", arg_28_1)

	return
end

function IslandSeasonPage:FlushPtPage()
	self.contextData.season = getProxy(IslandProxy):GetIsland():GetSeasonAgency():GetSeason()

	self.pages[IslandSeasonPage.PAGE_PT]:ExecuteAction("Flush")
	self:UpdateRedDot(IslandSeasonPage.PAGE_PT)

	return
end

function IslandSeasonPage:OnSubmitTaskDone()
	self:FlushTaskPage()
	self.pages[IslandSeasonPage.PAGE_ACTIVITY]:ExecuteAction("flushTabs")
	self:UpdateRedDot(IslandSeasonPage.PAGE_TASK)

	return
end

function IslandSeasonPage:FlushTaskPage()
	self.pages[IslandSeasonPage.PAGE_TASK]:ExecuteAction("Flush")

	return
end

function IslandSeasonPage:FlushShopPage(arg_32_1)
	self.pages[IslandSeasonPage.PAGE_SHOP]:ExecuteAction("Flush")

	if arg_32_1.operation == IslandConst.SHOP_BUY_COMMODITY then
		self:OpenPage(IslandShopBuySuccessLayer, arg_32_1.awards)
	end

	return
end

function IslandSeasonPage:OnGetRankData(arg_33_1)
	self.pages[IslandSeasonPage.PAGE_RANK]:ExecuteAction("UpdateRankVOs", arg_33_1.seasonId, arg_33_1.list, arg_33_1.playerInfo)
	self.pages[IslandSeasonPage.PAGE_RANK]:ExecuteAction("UpdataRankView")

	if self.pages[IslandSeasonPage.PAGE_REVIEW] then
		self.pages[IslandSeasonPage.PAGE_REVIEW]:ExecuteAction("UpdateRankVOs", arg_33_1.seasonId, arg_33_1.list, arg_33_1.playerInfo)
		self.pages[IslandSeasonPage.PAGE_REVIEW]:ExecuteAction("UpdataIcon")
	end

	return
end

function IslandSeasonPage:OnHide()
	self.playRoomPop:Show(false)
	self:UnOverlayPanel(self.blurTF, self._tf)
	self.pages[IslandSeasonPage.PAGE_PT]:OnHide()
	self.pages[IslandSeasonPage.PAGE_ACTIVITY]:OnHide()

	if self.pages[IslandSeasonPage.PAGE_REVIEW] then
		self.pages[IslandSeasonPage.PAGE_REVIEW]:Hide()
	end

	return
end

function IslandSeasonPage:OnDisable()
	self:OnHide()

	return
end

function IslandSeasonPage:OnDestroy()
	self:OnHide()
	self.playRoomPop:willExit()

	self.playRoomPop = nil

	for iter_36_0, iter_36_1 in pairs(self.pages) do
		if iter_36_1 then
			iter_36_1:Destroy()

			iter_36_1 = nil
		end
	end

	return
end

function IslandSeasonPage:OnEnable()
	self:OnShow()

	return
end

return IslandSeasonPage
