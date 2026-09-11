local ColorPuzzleLevelSelectView = class("ColorPuzzleLevelSelectView", ReduxView)
local var_0_1 = 53100
local var_0_2 = 54057

function ColorPuzzleLevelSelectView:UIName()
	return "Widget/System/SPHeroChallenge/ColorPuzzle/ColorPuzzleLevelSelectView"
end

function ColorPuzzleLevelSelectView:UIParent()
	return manager.ui.uiMain.transform
end

function ColorPuzzleLevelSelectView:OnCtor()
	return
end

function ColorPuzzleLevelSelectView:Init()
	self:BindCfgUI()

	self.levelBtns = {}

	self:InitLevelBtns(self.levelRoot_.childCount)

	self.levelInfoPanel = {}

	self:InitLevelDetailPanel()
	self:AddBtnListener(self.bgBtn_, nil, handler(self, self.UpdateLevelSelect))
	self:AddBtnListener(self.levelInfoPanel.descBtn, nil, function()
		if self.levelInfoPanel.tipsController:GetSelectedState() == "show" then
			self.levelInfoPanel.tipsController:SetSelectedState("close")
		else
			self.levelInfoPanel.tipsController:SetSelectedState("show")
		end
	end)

	self.scrollMoveView_ = ScrollMoveView.New(self, self.scrollViewGo_)
	self.scrollCom = self.scrollViewGo_:GetComponent(typeof(ScrollRect))
end

function ColorPuzzleLevelSelectView:OnEnter()
	local var_6_0 = 0
	local var_6_1 = 0

	for iter_6_0, iter_6_1 in pairs(self.levelBtns) do
		local var_6_2 = iter_6_1.stateController

		var_6_0 = var_6_0 + 1

		if ColorPuzzleData:IsLevelUnlocked(iter_6_1.level) then
			if ColorPuzzleData:IsLevelCleared(iter_6_1.level) then
				var_6_1 = var_6_1 + 1

				iter_6_1.clearController:SetSelectedState("yes")
			else
				iter_6_1.clearController:SetSelectedState("no")
			end

			var_6_2:SetSelectedState("open")
		else
			var_6_2:SetSelectedState("lock")
		end

		self:UpdateLevelSelect(nil)
	end

	self.progress_.text = string.format("%d / %d", var_6_1, var_6_0)

	self.levelInfoPanel.tipsController:SetSelectedState("close")

	if self.params_.isDetailJump then
		local var_6_3 = table.indexof(ActivityHeroChallengeColor.all, (SPHeroChallengeTools:GetNextCanBattleStageID(SpHeroChallengeConst.ScheduleSubType.decode)))

		if var_6_3 then
			self:UpdateLevelSelect(var_6_3)
		end
	end
end

function ColorPuzzleLevelSelectView:IsOpenSectionInfo()
	return self.showDetailController:GetSelectedState() == "show"
end

function ColorPuzzleLevelSelectView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		var_0_1,
		var_0_2
	})
	manager.windowBar:SetBarCanClick(var_0_2, true)
end

function ColorPuzzleLevelSelectView:OnBehind()
	manager.windowBar:HideBar()
end

function ColorPuzzleLevelSelectView:OnExit()
	manager.windowBar:HideBar()
	self.scrollMoveView_:OnExit()
end

function ColorPuzzleLevelSelectView:InitLevelBtns(arg_11_1)
	for iter_11_0 = 1, arg_11_1 do
		local var_11_0 = self:GetLevelCfg(iter_11_0)
		local var_11_1 = self.levelRoot_:GetChild(iter_11_0 - 1).gameObject
		local var_11_2 = {
			level = var_11_0.level_id,
			go = var_11_1,
			rectTransform = var_11_1:GetComponent(typeof(RectTransform))
		}

		self:BindCfgUI(var_11_1, var_11_2)
		self:AddBtnListener(var_11_2.btn_, nil, function()
			self:UpdateLevelSelect(iter_11_0)
		end)

		self.levelBtns[iter_11_0] = var_11_2
		var_11_2.name_.text = var_11_0.name
		var_11_2.stateController = var_11_2.controllers_:GetController("state")
		var_11_2.clearController = var_11_2.controllers_:GetController("clear")
	end
end

function ColorPuzzleLevelSelectView:InitLevelDetailPanel()
	local var_13_0 = self.levelInfoPanel

	self:BindCfgUI(self.levelDetailPanel_, self.levelInfoPanel)

	self.showDetailController = self.controllers_:GetController("levelDetail")
	self.levelInfoPanel.stateController = self.levelInfoPanel.controllers_:GetController("state")
	self.levelInfoPanel.tipsController = self.levelInfoPanel.controllers_:GetController("showTips")
	self.levelInfoPanel.showController = self.levelInfoPanel.controllers_:GetController("showTime")
	self.levelInfoPanel.rewardList = LuaList.New(handler(self, self.IndexRewardItem), self.levelInfoPanel.rewardList_, CommonItemView)

	self:AddBtnListener(self.levelInfoPanel.startBtn_, nil, function()
		if not SPHeroChallengeTools:CheckActivityCloseWithTips() then
			JumpTools.OpenPageByJump("/colorPuzzleLevel", {
				level = var_13_0.level
			})
		end
	end)
end

function ColorPuzzleLevelSelectView:IndexRewardItem(arg_15_1, arg_15_2)
	local var_15_0 = rewardToItemTemplate(formatReward(self.levelInfoPanel.rewards[arg_15_1]))

	function var_15_0:clickFun()
		ShowPopItem(POP_ITEM, {
			self.id,
			self.number
		})
	end

	arg_15_2:SetData(var_15_0)
end

function ColorPuzzleLevelSelectView:GetLevelCfg(arg_17_1)
	return nullable(ActivityHeroChallengeColor, (nullable(ActivityHeroChallengeColor, "all", arg_17_1)))
end

function ColorPuzzleLevelSelectView:UpdateLevelSelect(arg_18_1)
	if arg_18_1 then
		self.levelInfoPanel.tipsController:SetSelectedState("close")

		local var_18_0 = self:GetLevelCfg(arg_18_1)
		local var_18_1 = var_18_0.level_id
		local var_18_2 = self.levelInfoPanel

		var_18_2.level = var_18_0.level_id
		var_18_2.rewards = var_18_0.reward
		var_18_2.name_.text = var_18_0.name
		var_18_2.textText_.text = GetTips("ACTIVITY_HERO_CHALLENGE_BATTLE_TIME_DESC")

		local var_18_3, var_18_4 = SPHeroChallengeData:GetCurActivityInfo():GetStartBattelScheduleByType(SpHeroChallengeConst.ScheduleSubType.decode)
		local var_18_5, var_18_6 = ColorPuzzleData:IsLevelUnlocked(var_18_1)

		if var_18_5 then
			if ColorPuzzleData:IsLevelCleared(var_18_1) then
				var_18_2.stateController:SetSelectedState("clear")
				var_18_2.showController:SetSelectedState("close")
				var_18_2.rewardList:StartScroll(0)
			else
				var_18_2.showController:SetSelectedState("close")
				var_18_2.stateController:SetSelectedState("open")
				var_18_2.rewardList:StartScroll(#var_18_2.rewards)
			end
		else
			var_18_2.stateController:SetSelectedState("lock")

			var_18_2.lockText_.text = GetTips(var_18_6)
		end

		local var_18_7 = ColorPuzzleData:GetLevelClearTime(var_18_1)

		var_18_2.time_.text = var_18_7 and manager.time:DescCDTime(var_18_7) or "--:--:--"

		self.showDetailController:SetSelectedState("show")
		self:ScrollList(arg_18_1)
	else
		self.scrollCom.enabled = true

		self.showDetailController:SetSelectedState("hide")
	end

	for iter_18_0, iter_18_1 in pairs(self.levelBtns) do
		iter_18_1.stateController:SetSelectedState(arg_18_1 == iter_18_0 and "select" or "open")
	end
end

function ColorPuzzleLevelSelectView:ScrollList(arg_19_1)
	self.scrollMoveView_.needInitScroll_ = false

	self.scrollMoveView_:RefreshUI(self:GetScrollPos(arg_19_1), (self:GetScrollWidth()))
end

function ColorPuzzleLevelSelectView:GetScrollPos(arg_20_1)
	return self.levelBtns[arg_20_1].rectTransform.anchoredPosition.x
end

function ColorPuzzleLevelSelectView:GetScrollWidth()
	local var_21_0 = 0

	for iter_21_0, iter_21_1 in ipairs(self.levelBtns) do
		var_21_0 = math.max(self.levelBtns[iter_21_0].rectTransform.anchoredPosition.x, var_21_0)
	end

	return var_21_0
end

function ColorPuzzleLevelSelectView:Dispose()
	self.levelInfoPanel.rewardList:Dispose()
	ColorPuzzleLevelSelectView.super.Dispose(self)
	self.scrollMoveView_:Dispose()

	self.scrollMoveView_ = nil
end

return ColorPuzzleLevelSelectView
