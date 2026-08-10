local var_0_0 = import("game.tools.PinballTools")
local var_0_1 = class("PinballStageView", ReduxView)

function var_0_1.UIName(arg_1_0)
	return "Widget/Version/BaichaoUI_3_9/BaichaoUI_3_9_PinballUI/BaichaoUI_3_9_PinballCheckpointUI"
end

function var_0_1.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

local function var_0_2(arg_3_0)
	return PinballData:GetStageCategoryActivityList()[arg_3_0 or 1]
end

local function var_0_3(arg_4_0, arg_4_1)
	arg_4_0[arg_4_1 .. "Controller"] = arg_4_0.controllers_:GetController(arg_4_1)
end

function var_0_1.Init(arg_5_0)
	arg_5_0:BindCfgUI()
	arg_5_0:InitUI()
	arg_5_0:AddUIListener()
end

function var_0_1.Dispose(arg_6_0)
	var_0_1.super.Dispose(arg_6_0)
	arg_6_0.stageList:Dispose()
	arg_6_0.detailPanel.firstTimeDropRewardList:Dispose()

	if arg_6_0.heroHeadItem then
		arg_6_0.heroHeadItem:Dispose()
	end
end

function var_0_1.OnEnter(arg_7_0)
	arg_7_0:SwitchDisplayStageCat(PinballData:GetLastEnterStageCategory(), true)
	arg_7_0.stageList:StartScroll(#arg_7_0:CurDisplayStageList())
	arg_7_0:BindRedPoints()
end

function var_0_1.OnExit(arg_8_0)
	arg_8_0:HideStageDetail()
	arg_8_0:UnBindRedPoints()
end

function var_0_1.OnTop(arg_9_0)
	local var_9_0 = var_0_0.ActivityCoin()

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		var_9_0
	})
	manager.windowBar:SetBarCanClick(var_9_0, true)
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			isPrefab = true,
			pages = {
				"Widget/Version/BaichaoUI_3_9/BaichaoUI_3_9_PinballUI/BaichaoUI_3_9_PinballDescription_01",
				"Widget/Version/BaichaoUI_3_9/BaichaoUI_3_9_PinballUI/BaichaoUI_3_9_PinballDescription_02",
				"Widget/Version/BaichaoUI_3_9/BaichaoUI_3_9_PinballUI/BaichaoUI_3_9_PinballDescription_03"
			}
		}
	})

	if ActivityTools.IsFirstEnterActivity(PinballData.activityID) then
		ActivityTools.MarkHasEnterActivity(PinballData.activityID)
		manager.windowBar:ShowGameHelp()
	end
end

function var_0_1.OnBehind(arg_10_0)
	manager.windowBar:HideBar()
end

local function var_0_4(arg_11_0)
	local var_11_0 = PinballData:GetStageCategoryActivityList()

	return nullable(ActivityCfg, var_11_0[arg_11_0], "name")
end

function var_0_1.EnsureItemInViewport(arg_12_0, arg_12_1, arg_12_2)
	arg_12_1:ScrollToIndex(arg_12_2, true, true)
end

function var_0_1.InitUI(arg_13_0)
	var_0_3(arg_13_0, "selectCategory")
	var_0_3(arg_13_0, "showSubView")

	arg_13_0.stageList = LuaList.New(handler(arg_13_0, arg_13_0.RenderStageItem), arg_13_0.stageList_, PinballStageItem)

	function arg_13_0.clickItemHandler(arg_14_0)
		local var_14_0 = arg_14_0.stage

		if var_14_0 == arg_13_0.stageSelect then
			arg_13_0:HideStageDetail()
		else
			arg_13_0:DisplayStageDetail(var_14_0)
			arg_13_0:EnsureItemInViewport(arg_13_0.stageList, arg_14_0.index)
		end

		arg_13_0.stageList:Refresh()
	end

	arg_13_0.catName1_.text = var_0_4(1)
	arg_13_0.catName2_.text = var_0_4(2)

	arg_13_0:InitDetailPanel()

	if arg_13_0.curHeroHeadItem_ then
		arg_13_0.heroHeadItem = PinballRoleInfoView.RoleItem.New(arg_13_0.curHeroHeadItem_)

		arg_13_0.heroHeadItem:SetMuteRedPoint(true)
	end
end

function var_0_1.InitDetailPanel(arg_15_0)
	arg_15_0.detailPanel = {}

	arg_15_0:BindCfgUI(arg_15_0.detailPanel_, arg_15_0.detailPanel)

	arg_15_0.detailPanel.stateController = arg_15_0.detailPanel.controllerEx_:GetController("state")

	local var_15_0 = arg_15_0:InitDetailConditionCom(arg_15_0.detailPanel.conditionGo_)

	arg_15_0.detailPanel.conditions = var_15_0
	arg_15_0.detailPanel.firstTimeDropRewardList = LuaList.New(handler(arg_15_0, arg_15_0.RenderFirstDrop), arg_15_0.detailPanel.rewardUIListGo_, CommonItemView)
end

var_0_1.InitDetailConditionCom = var_0_0.InitDetailConditionCom

local function var_0_5(arg_16_0)
	local var_16_0 = PinballPlayerCfg.get_id_list_by_type[1]

	return var_16_0[arg_16_0] or var_16_0[1]
end

local function var_0_6(arg_17_0, arg_17_1)
	local var_17_0, var_17_1 = PinballData:GetStageUnlocked()

	if var_17_0 then
		PinballAction.PlayPinballGame(arg_17_0, arg_17_1)
	else
		ShowTips(var_17_1)
	end
end

function var_0_1.CurDisplayStage(arg_18_0)
	return var_0_2(arg_18_0.stageCategory)
end

function var_0_1.CurDisplayStageList(arg_19_0)
	return PinballStageCfg.get_id_list_by_activity_id[arg_19_0:CurDisplayStage()]
end

function var_0_1.AddUIListener(arg_20_0)
	arg_20_0:AddBtnListenerScale(arg_20_0.enterBtn_, nil, function()
		var_0_6(arg_20_0.stageSelect, var_0_5(arg_20_0.stageCategory))
	end)
	arg_20_0:AddBtnListener(arg_20_0.questBtn_, nil, function()
		local var_22_0 = var_0_0.GetTaskActivityID()

		if var_22_0 then
			JumpTools.OpenPageByJump("pinballTasks", {
				activityId = var_22_0
			})
		end
	end)
	arg_20_0:AddBtnListener(arg_20_0.changeRoleBtn_, nil, function()
		local var_23_0 = var_0_5(arg_20_0.stageCategory)
		local var_23_1 = var_0_0.UpgradeRedPoint(var_23_0)

		manager.redPoint:setTip(var_23_1, 0)
		JumpTools.OpenPageByJump("/pinballRoleInfo", {
			heroID = var_23_0
		})
	end)
	arg_20_0:AddBtnListenerScale(arg_20_0.showCatBtn1_, nil, function()
		arg_20_0:SwitchDisplayStageCat(1)
		arg_20_0:UnBindUpdateRoleRedPoint()
		arg_20_0:BindUpdateRoleRedPoint()
	end)
	arg_20_0:AddBtnListenerScale(arg_20_0.showCatBtn2_, nil, function()
		arg_20_0:SwitchDisplayStageCat(2)
		arg_20_0:UnBindUpdateRoleRedPoint()
		arg_20_0:BindUpdateRoleRedPoint()
	end)
	arg_20_0:AddBtnListenerScale(arg_20_0.detailPanel.bossInfoBtn_, nil, function()
		arg_20_0:GoToBossInfoView(arg_20_0.stageSelect)
	end)
	arg_20_0:AddBtnListener(arg_20_0.hideDetailBtn_, nil, function()
		arg_20_0:HideStageDetail()
		arg_20_0.stageList:Refresh()
	end)
end

local function var_0_7(arg_28_0)
	local var_28_0 = PinballStageCfg.get_id_list_by_activity_id[var_0_2(arg_28_0)]
	local var_28_1 = 0

	for iter_28_0, iter_28_1 in ipairs(var_28_0) do
		if PinballData:GetStageComplete(iter_28_1) then
			var_28_1 = var_28_1 + 1
		end
	end

	return var_28_1, #var_28_0
end

function var_0_1.SwitchDisplayStageCat(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_0.stageCategory ~= arg_29_1 then
		arg_29_0.stageCategory = arg_29_1

		arg_29_0:HideStageDetail()

		if not arg_29_2 then
			arg_29_0.stageList:StartScroll(#arg_29_0:CurDisplayStageList())
		end

		PinballData:SetLastEnterStageCategory(arg_29_1)
		arg_29_0.selectCategoryController:SetSelectedState(tostring(arg_29_1))

		arg_29_0.title_.text = var_0_4(arg_29_1)

		local var_29_0, var_29_1 = var_0_7(arg_29_1)

		arg_29_0.progress_.text = string.format("%d / %d", var_29_0, var_29_1)

		if arg_29_0.heroHeadItem then
			arg_29_0.heroHeadItem:SetData(var_0_5(arg_29_1))
			arg_29_0.heroHeadItem:SetSelected(false)
		end
	end
end

function var_0_1.RenderStageItem(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0:CurDisplayStageList()[arg_30_1]

	arg_30_2:SetData(arg_30_1, var_30_0)
	arg_30_2:SetSelected(arg_30_0.stageSelect == var_30_0)
	arg_30_2:SetOnClick(arg_30_0.clickItemHandler)
end

function var_0_1.RenderFirstDrop(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_0.stageSelect == nil then
		return
	end

	local var_31_0 = PinballData:GetStageComplete(arg_31_0.stageSelect) and "repetition_reward" or "first_reward"
	local var_31_1 = nullable(PinballStageCfg, arg_31_0.stageSelect, var_31_0, arg_31_1)

	if var_31_1 then
		local var_31_2 = cfgToItemTemplate(var_31_1)

		function var_31_2.clickFun(arg_32_0)
			ShowPopItem(POP_ITEM, arg_32_0)
		end

		arg_31_2:SetData(var_31_2)
	end
end

function var_0_1.DisplayStageDetail(arg_33_0, arg_33_1)
	arg_33_0.stageSelect = arg_33_1

	arg_33_0.showSubViewController:SetSelectedState("true")
	arg_33_0.stageList:Refresh()

	local var_33_0 = PinballStageCfg[arg_33_1]

	if var_33_0 then
		arg_33_0.detailPanel.sectionName_.text = var_33_0.name

		local var_33_1, var_33_2 = PinballData:GetStageState(arg_33_1)

		arg_33_0.detailPanel.stateController:SetSelectedState(var_33_1)

		if var_33_1 == "lock" then
			arg_33_0.detailPanel.btnLockText_.text = var_33_2
		end

		for iter_33_0 = 1, var_0_0.CONDITOIN_CNT do
			local var_33_3 = arg_33_0.detailPanel.conditions[iter_33_0]

			var_0_0.RefreshDetailConditionCom(var_33_3, arg_33_1, iter_33_0)
		end

		if PinballData:GetStageComplete(arg_33_1) then
			arg_33_0.detailPanel.firstTimeDropRewardList:StartScroll(#var_33_0.repetition_reward)
		else
			arg_33_0.detailPanel.firstTimeDropRewardList:StartScroll(#var_33_0.first_reward)
		end

		arg_33_0.detailPanel.bossIcon_.spriteSync = var_0_0.GetBossIconPath(var_33_0.monster_list[1])
	end
end

function var_0_1.HideStageDetail(arg_34_0)
	arg_34_0.detailPanel.firstTimeDropRewardList:StartScroll(0)

	arg_34_0.stageSelect = nil

	arg_34_0.showSubViewController:SetSelectedState("false")
end

function var_0_1.GoToBossInfoView(arg_35_0, arg_35_1)
	local var_35_0 = nullable(PinballStageCfg, arg_35_1, "monster_list", 1)

	if var_35_0 then
		JumpTools.OpenPageByJump("pinballBossInfo", {
			id = var_35_0
		})
	end
end

local function var_0_8(arg_36_0, arg_36_1)
	return string.format("%s_%d", arg_36_0, arg_36_1)
end

function var_0_1.BindUpdateRoleRedPoint(arg_37_0)
	local var_37_0 = var_0_5(arg_37_0.stageCategory)
	local var_37_1 = var_0_0.UpgradeRedPoint(var_37_0)

	manager.redPoint:bindUIandKey(arg_37_0.changeRoleBtn_.transform, var_37_1)
end

function var_0_1.UnBindUpdateRoleRedPoint(arg_38_0)
	manager.redPoint:unbindUIandKey(arg_38_0.changeRoleBtn_.transform)
end

function var_0_1.BindRedPoints(arg_39_0)
	local var_39_0 = PinballData.activityID

	arg_39_0:BindUpdateRoleRedPoint()
	manager.redPoint:bindUIandKey(arg_39_0.showCatBtn1_.transform, var_0_0.StageCatRedPoint(var_0_2(1)))
	manager.redPoint:bindUIandKey(arg_39_0.showCatBtn2_.transform, var_0_0.StageCatRedPoint(var_0_2(2)))
	manager.redPoint:bindUIandKey(arg_39_0.questBtn_.transform, var_0_8(RedPointConst.ACTIVITY_PINBALL_TASKS, var_39_0))
end

function var_0_1.UnBindRedPoints(arg_40_0)
	local var_40_0 = PinballData.activityID

	arg_40_0:UnBindUpdateRoleRedPoint()
	manager.redPoint:unbindUIandKey(arg_40_0.showCatBtn1_.transform, var_0_0.StageCatRedPoint(var_0_2(1)))
	manager.redPoint:unbindUIandKey(arg_40_0.showCatBtn2_.transform, var_0_0.StageCatRedPoint(var_0_2(2)))
	manager.redPoint:unbindUIandKey(arg_40_0.questBtn_.transform, var_0_8(RedPointConst.ACTIVITY_PINBALL_TASKS, var_40_0))
end

return var_0_1
