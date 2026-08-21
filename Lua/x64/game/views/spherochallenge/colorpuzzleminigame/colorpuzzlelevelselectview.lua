local var_0_0 = class("ColorPuzzleLevelSelectView", ReduxView)
local var_0_1 = 53100
local var_0_2 = 54057

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SPHeroChallenge/ColorPuzzle/ColorPuzzleLevelSelectView"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()

	local var_4_0 = arg_4_0.levelRoot_.childCount

	arg_4_0.levelBtns = {}

	arg_4_0:InitLevelBtns(var_4_0)

	arg_4_0.levelInfoPanel = {}

	arg_4_0:InitLevelDetailPanel()
	arg_4_0:AddBtnListener(arg_4_0.bgBtn_, nil, handler(arg_4_0, arg_4_0.UpdateLevelSelect))
	arg_4_0:AddBtnListener(arg_4_0.levelInfoPanel.descBtn, nil, function()
		if arg_4_0.levelInfoPanel.tipsController:GetSelectedState() == "show" then
			arg_4_0.levelInfoPanel.tipsController:SetSelectedState("close")
		else
			arg_4_0.levelInfoPanel.tipsController:SetSelectedState("show")
		end
	end)

	arg_4_0.scrollMoveView_ = ScrollMoveView.New(arg_4_0, arg_4_0.scrollViewGo_)
	arg_4_0.scrollCom = arg_4_0.scrollViewGo_:GetComponent(typeof(ScrollRect))
end

function var_0_0.OnEnter(arg_6_0)
	local var_6_0 = 0
	local var_6_1 = 0

	for iter_6_0, iter_6_1 in pairs(arg_6_0.levelBtns) do
		local var_6_2 = iter_6_1.level
		local var_6_3 = iter_6_1.stateController

		var_6_0 = var_6_0 + 1

		if ColorPuzzleData:IsLevelUnlocked(var_6_2) then
			if ColorPuzzleData:IsLevelCleared(var_6_2) then
				var_6_1 = var_6_1 + 1

				iter_6_1.clearController:SetSelectedState("yes")
			else
				iter_6_1.clearController:SetSelectedState("no")
			end

			var_6_3:SetSelectedState("open")
		else
			var_6_3:SetSelectedState("lock")
		end

		arg_6_0:UpdateLevelSelect(nil)
	end

	arg_6_0.progress_.text = string.format("%d / %d", var_6_1, var_6_0)

	arg_6_0.levelInfoPanel.tipsController:SetSelectedState("close")

	if arg_6_0.params_.isDetailJump then
		local var_6_4 = SPHeroChallengeTools:GetNextCanBattleStageID(SpHeroChallengeConst.ScheduleSubType.decode)
		local var_6_5 = table.indexof(ActivityHeroChallengeColor.all, var_6_4)

		if var_6_5 then
			arg_6_0:UpdateLevelSelect(var_6_5)
		end
	end
end

function var_0_0.IsOpenSectionInfo(arg_7_0)
	return arg_7_0.showDetailController:GetSelectedState() == "show"
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		var_0_1,
		var_0_2
	})
	manager.windowBar:SetBarCanClick(var_0_2, true)
end

function var_0_0.OnBehind(arg_9_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_10_0)
	manager.windowBar:HideBar()
	arg_10_0.scrollMoveView_:OnExit()
end

function var_0_0.InitLevelBtns(arg_11_0, arg_11_1)
	for iter_11_0 = 1, arg_11_1 do
		local var_11_0 = arg_11_0:GetLevelCfg(iter_11_0)
		local var_11_1 = arg_11_0.levelRoot_:GetChild(iter_11_0 - 1).gameObject
		local var_11_2 = {
			level = var_11_0.level_id,
			go = var_11_1,
			rectTransform = var_11_1:GetComponent(typeof(RectTransform))
		}

		arg_11_0:BindCfgUI(var_11_1, var_11_2)
		arg_11_0:AddBtnListener(var_11_2.btn_, nil, function()
			arg_11_0:UpdateLevelSelect(iter_11_0)
		end)

		arg_11_0.levelBtns[iter_11_0] = var_11_2
		var_11_2.name_.text = var_11_0.name
		var_11_2.stateController = var_11_2.controllers_:GetController("state")
		var_11_2.clearController = var_11_2.controllers_:GetController("clear")
	end
end

function var_0_0.InitLevelDetailPanel(arg_13_0)
	local var_13_0 = arg_13_0.levelInfoPanel

	arg_13_0:BindCfgUI(arg_13_0.levelDetailPanel_, var_13_0)

	arg_13_0.showDetailController = arg_13_0.controllers_:GetController("levelDetail")
	var_13_0.stateController = var_13_0.controllers_:GetController("state")
	var_13_0.tipsController = var_13_0.controllers_:GetController("showTips")
	var_13_0.showController = var_13_0.controllers_:GetController("showTime")
	var_13_0.rewardList = LuaList.New(handler(arg_13_0, arg_13_0.IndexRewardItem), var_13_0.rewardList_, CommonItemView)

	arg_13_0:AddBtnListener(var_13_0.startBtn_, nil, function()
		if not SPHeroChallengeTools:CheckActivityCloseWithTips() then
			JumpTools.OpenPageByJump("/colorPuzzleLevel", {
				level = var_13_0.level
			})
		end
	end)
end

function var_0_0.IndexRewardItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.levelInfoPanel.rewards[arg_15_1]
	local var_15_1 = rewardToItemTemplate(formatReward(var_15_0))

	function var_15_1.clickFun(arg_16_0)
		ShowPopItem(POP_ITEM, {
			arg_16_0.id,
			arg_16_0.number
		})
	end

	arg_15_2:SetData(var_15_1)
end

function var_0_0.GetLevelCfg(arg_17_0, arg_17_1)
	local var_17_0 = nullable(ActivityHeroChallengeColor, "all", arg_17_1)

	return nullable(ActivityHeroChallengeColor, var_17_0)
end

function var_0_0.UpdateLevelSelect(arg_18_0, arg_18_1)
	if arg_18_1 then
		arg_18_0.levelInfoPanel.tipsController:SetSelectedState("close")

		local var_18_0 = arg_18_0:GetLevelCfg(arg_18_1)
		local var_18_1 = var_18_0.level_id
		local var_18_2 = arg_18_0.levelInfoPanel

		var_18_2.level = var_18_1
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

		arg_18_0.showDetailController:SetSelectedState("show")
		arg_18_0:ScrollList(arg_18_1)
	else
		arg_18_0.scrollCom.enabled = true

		arg_18_0.showDetailController:SetSelectedState("hide")
	end

	for iter_18_0, iter_18_1 in pairs(arg_18_0.levelBtns) do
		iter_18_1.stateController:SetSelectedState(arg_18_1 == iter_18_0 and "select" or "open")
	end
end

function var_0_0.ScrollList(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:GetScrollPos(arg_19_1)
	local var_19_1 = arg_19_0:GetScrollWidth()

	arg_19_0.scrollMoveView_.needInitScroll_ = false

	arg_19_0.scrollMoveView_:RefreshUI(var_19_0, var_19_1)
end

function var_0_0.GetScrollPos(arg_20_0, arg_20_1)
	return arg_20_0.levelBtns[arg_20_1].rectTransform.anchoredPosition.x
end

function var_0_0.GetScrollWidth(arg_21_0)
	local var_21_0 = 0

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.levelBtns) do
		var_21_0 = math.max(arg_21_0.levelBtns[iter_21_0].rectTransform.anchoredPosition.x, var_21_0)
	end

	return var_21_0
end

function var_0_0.Dispose(arg_22_0)
	arg_22_0.levelInfoPanel.rewardList:Dispose()
	var_0_0.super.Dispose(arg_22_0)
	arg_22_0.scrollMoveView_:Dispose()

	arg_22_0.scrollMoveView_ = nil
end

return var_0_0
