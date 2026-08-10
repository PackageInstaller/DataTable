SubPlotBaseView = import("game.views.sectionSelect.subPlot.base.SubPlotBaseView")

local var_0_0 = import("game.data.summerChessBoard.gameUIData.SummerChessMonsterCosplayUIData")
local var_0_1 = class("MonsterCosplayStageView", SubPlotBaseView)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_MonsterPlayUI/Summer2024_MonsterPlayStageUI"
end

function var_0_1.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_1.GetItemClass(arg_3_0)
	return MonsterCosplayStageItem
end

function var_0_1.GetCfgName(arg_4_0)
	return BattleActivityMonsterCosplayCfg
end

function var_0_1.Init(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.itemWidth_ = arg_5_0.sectionItem1_.transform:GetComponent("RectTransform").rect.width
	arg_5_0.infoController = arg_5_0.controller_:GetController("info")
	arg_5_0.typeController = arg_5_0.controller_:GetController("type")
	arg_5_0.stageList = {}

	for iter_5_0 = 1, #ActivityMonsterCosplayCfg.all do
		arg_5_0.stageList[ActivityMonsterCosplayCfg.all[iter_5_0]] = {}

		for iter_5_1 = 1, #ActivityMonsterCosplayCfg[ActivityMonsterCosplayCfg.all[iter_5_0]].stage_list do
			table.insert(arg_5_0.stageList[ActivityMonsterCosplayCfg.all[iter_5_0]], arg_5_0["stage" .. iter_5_0 .. iter_5_1 .. "Go_"])
		end
	end

	arg_5_0.stageItemList_ = {}
	arg_5_0.scrollMoveView1 = ScrollMoveView.New(arg_5_0, arg_5_0.scrollViewGo1_)
	arg_5_0.scrollMoveView2 = ScrollMoveView.New(arg_5_0, arg_5_0.scrollViewGo2_)

	arg_5_0:AddUIListener()
end

function var_0_1.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.swap1Btn_, nil, function()
		if arg_6_0.infoController:GetSelectedState() == "state1" then
			return
		end

		if arg_6_0.typeController:GetSelectedState() == "3" then
			arg_6_0.selectID = ActivityMonsterCosplayCfg.all[1]
			arg_6_0.lastSelectStageID = nil

			arg_6_0.typeController:SetSelectedState("2")
			arg_6_0:RefreshData()
			arg_6_0:RefreshUI()
			arg_6_0:SetItemData()
			MonsterCosplayAction.ViewMonsterSkill(arg_6_0.selectID, 0)
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.swap2Btn_, nil, function()
		if arg_6_0.infoController:GetSelectedState() == "state1" then
			return
		end

		if arg_6_0.typeController:GetSelectedState() == "2" then
			arg_6_0.selectID = ActivityMonsterCosplayCfg.all[2]

			arg_6_0.typeController:SetSelectedState("3")

			arg_6_0.lastSelectStageID = nil

			arg_6_0:RefreshData()
			arg_6_0:RefreshUI()
			arg_6_0:SetItemData()
			MonsterCosplayAction.ViewMonsterSkill(arg_6_0.selectID, 0)
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.taskBtn_, nil, function()
		if arg_6_0.infoController:GetSelectedState() == "state1" then
			arg_6_0:Back()
		end

		local var_9_0 = ActivityConst.SUMMER_CHESS_BOARD_MONSTER_COSPLAY_LIMIT_TASK
		local var_9_1 = var_0_0:GetTaskIDList(ActivityConst.SUMMER_CHESS_BOARD_MONSTER_COSPLAY_NORMAL_TASK)

		for iter_9_0, iter_9_1 in pairs(var_9_1) do
			if TaskData2:GetTask(iter_9_1).complete_flag <= 0 then
				var_9_0 = ActivityConst.SUMMER_CHESS_BOARD_MONSTER_COSPLAY_NORMAL_TASK

				break
			end
		end

		JumpTools.OpenPageByJump("/summerChessBoardTask", {
			taskActivityID = var_9_0
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.bgBtn1_, nil, function()
		if arg_6_0.selectStageID then
			arg_6_0.lastSelectStageID = arg_6_0.selectStageID
			arg_6_0.selectStageID = nil

			arg_6_0:RefreshUI()
			arg_6_0:Back()
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.bgBtn2_, nil, function()
		if arg_6_0.selectStageID then
			arg_6_0.lastSelectStageID = arg_6_0.selectStageID
			arg_6_0.selectStageID = nil

			arg_6_0:RefreshUI()
			arg_6_0:Back()
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.modelViewBtn_, nil, function()
		JumpTools.OpenPageByJump("/MonsterCosplayMonster", {
			modelID = arg_6_0.selectID
		})
	end)
end

function var_0_1.RefreshLineItemList(arg_13_0)
	return
end

function var_0_1.RefreshData(arg_14_0)
	arg_14_0.stageData_ = BattleStageData:GetStageData()
	arg_14_0.stageList_ = ActivityMonsterCosplayCfg[arg_14_0.selectID].stage_list
end

function var_0_1.OnMonsterAllUpdate(arg_15_0)
	arg_15_0:RefreshData()
	arg_15_0:RefreshUI()
	arg_15_0:SetItemData()
end

function var_0_1.OnEnter(arg_16_0)
	arg_16_0.selectID = arg_16_0.selectID or ActivityMonsterCosplayCfg[ActivityMonsterCosplayCfg.all[1]].id

	local var_16_0 = tonumber(getData("monsterCosplay", "selectID") or "0")

	if var_16_0 ~= 0 then
		arg_16_0.selectID = var_16_0

		saveData("monsterCosplay", "selectID", "0")
	end

	if arg_16_0.params_.selectID then
		arg_16_0.selectID = arg_16_0.params_.selectID
		arg_16_0.params_.selectID = nil
	end

	arg_16_0.canSwap = IsConditionAchieved(ActivityMonsterCosplayCfg[ActivityMonsterCosplayCfg.all[2]].unlock_condition[1])

	if (getData("monsterCosplay", "isFirstLock") or "1") == "1" and arg_16_0.canSwap then
		arg_16_0.selectID = ActivityMonsterCosplayCfg[ActivityMonsterCosplayCfg.all[2]].id

		saveData("monsterCosplay", "isFirstLock", "true")
	end

	manager.ui:SetMainCamera("null")

	arg_16_0.leftAnimator_.enabled = true

	arg_16_0:RefreshData()
	arg_16_0:RefreshUI()
	arg_16_0:SetItemData()
	arg_16_0.infoController:SetSelectedState("state0")
	MonsterCosplayAction.ViewMonsterSkill(arg_16_0.selectID, 0)
end

function var_0_1.RefreshUI(arg_17_0)
	local var_17_0 = arg_17_0:GetScrollPos()
	local var_17_1 = arg_17_0:GetScrollWidth()

	arg_17_0.scrollMoveView_ = arg_17_0.selectID == ActivityMonsterCosplayCfg[ActivityMonsterCosplayCfg.all[1]].id and arg_17_0.scrollMoveView1 or arg_17_0.scrollMoveView2
	arg_17_0.titleTxt_ = arg_17_0.selectID == ActivityMonsterCosplayCfg[ActivityMonsterCosplayCfg.all[1]].id and arg_17_0.titleTxt1_ or arg_17_0.titleTxt2_
	arg_17_0.titleTxt1_.text = GetI18NText(ActivityMonsterCosplayCfg[ActivityMonsterCosplayCfg.all[1]].chapter_name)

	local var_17_2 = arg_17_0.selectID == ActivityMonsterCosplayCfg.all[1] and 1 or 2

	arg_17_0.scrollMoveView_:RefreshUI(var_17_0, var_17_1, arg_17_0["stop" .. var_17_2])

	arg_17_0["stop" .. var_17_2] = false

	arg_17_0:RefreshSelectItem()
end

function var_0_1.SetItemData(arg_18_0)
	arg_18_0:UnbindRedPoint()

	arg_18_0.curStageGo = arg_18_0.stageList[arg_18_0.selectID]

	for iter_18_0 = 1, #arg_18_0.stageList_ do
		arg_18_0.stageItemList_[iter_18_0] = arg_18_0:GetItemClass().New(arg_18_0.curStageGo[iter_18_0], arg_18_0.content_)

		arg_18_0.stageItemList_[iter_18_0]:SetData(arg_18_0.stageList_[iter_18_0], arg_18_0.selectID, arg_18_0)
	end

	local var_18_0 = MonsterCosplayData:GetDataByPara("firstView")

	SetActive(arg_18_0.effGo_, arg_18_0.canSwap and var_18_0)

	if arg_18_0.canSwap then
		arg_18_0.typeController:SetSelectedState(arg_18_0.selectID == ActivityMonsterCosplayCfg.all[1] and "2" or "3")
		arg_18_0.animator_:Play(arg_18_0.selectID == ActivityMonsterCosplayCfg.all[1] and "change02" or "change01")
		MonsterCosplayData.SetFirstView()
	else
		arg_18_0.typeController:SetSelectedState("1")
	end

	arg_18_0:BindRedPoint()
end

function var_0_1.SelectedItem(arg_19_0, arg_19_1)
	local var_19_0 = BattleActivityMonsterCosplayCfg[arg_19_1]
	local var_19_1 = tonumber(var_19_0.unlock_condition[1])

	if IsConditionAchieved(var_19_1) then
		local var_19_2 = RedPointConst.MONSTER_COSPLAY_STAGE .. arg_19_1

		MonsterCosplayData:ClickStage(arg_19_1)
		manager.redPoint:setTip(var_19_2, 0)
	end
end

function var_0_1.RefreshSelectItem(arg_20_0)
	for iter_20_0, iter_20_1 in pairs(arg_20_0.stageItemList_) do
		iter_20_1:SelectorItem(arg_20_0.selectStageID)
	end
end

function var_0_1.CheckHaveCoreSkill(arg_21_0)
	local var_21_0 = MonsterCosplayData:GetDataByPara("viewCoreSkillTable")[arg_21_0.selectID]

	for iter_21_0, iter_21_1 in pairs(var_21_0) do
		local var_21_1 = TalentTreeCfg[iter_21_0]

		if iter_21_1 == false and IsConditionAchieved(var_21_1.unlock_condition[1]) then
			return arg_21_0.selectID, iter_21_0
		end
	end

	return nil, nil
end

function var_0_1.OnMonsterCoreSkill(arg_22_0)
	local var_22_0, var_22_1 = MonsterCosplayData:CheckCanSkillEnhance()
	local var_22_2, var_22_3 = arg_22_0:CheckHaveCoreSkill()

	if var_22_2 then
		TimeTools.StartAfterSeconds(0.1, function()
			JumpTools.OpenPageByJump("MonsterCosplaySkillUp", {
				modelID = var_22_2,
				coreAffixID = var_22_3
			})
		end, {})
	elseif var_22_0 then
		TimeTools.StartAfterSeconds(0.1, function()
			JumpTools.OpenPageByJump("MonsterCosplaySkillUp", {
				modelID = var_22_1
			})
		end, {})
	end
end

function var_0_1.OnMonsterSkillUp(arg_25_0)
	arg_25_0:OnMonsterCoreSkill()
end

function var_0_1.GetScrollPos(arg_26_0)
	arg_26_0.openStage = MonsterCosplayData:GetDataByPara("openStage")[arg_26_0.selectID]

	if arg_26_0.lastSelectStageID then
		local var_26_0 = arg_26_0.lastSelectStageID

		arg_26_0.lastSelectStageID = nil

		if var_26_0 == arg_26_0.stageList_[#arg_26_0.stageList_] then
			local var_26_1 = arg_26_0.selectID == ActivityMonsterCosplayCfg.all[1] and 1 or 2

			return math.ceil(arg_26_0["contentRect" .. var_26_1 .. "_"].rect.width) + math.ceil(arg_26_0["viewportRect" .. var_26_1 .. "_"].rect.width) * 0.75
		end

		return arg_26_0.itemRect_.rect.width / 2 + 650 + ((table.indexof(arg_26_0.stageList_, var_26_0) or 1) - 1) * 350 - 250
	end

	if arg_26_0.selectStageID then
		if arg_26_0.selectStageID == arg_26_0.stageList_[#arg_26_0.stageList_] then
			local var_26_2 = arg_26_0.selectID == ActivityMonsterCosplayCfg.all[1] and 1 or 2

			return math.ceil(arg_26_0["contentRect" .. var_26_2 .. "_"].rect.width) + math.ceil(arg_26_0["viewportRect" .. var_26_2 .. "_"].rect.width) * 0.75
		end

		return arg_26_0.itemRect_.rect.width / 2 + 650 + ((table.indexof(arg_26_0.stageList_, arg_26_0.selectStageID) or 1) - 1) * 350 - 250
	end

	return arg_26_0.itemRect_.rect.width / 2 + 650 + ((table.indexof(arg_26_0.stageList_, arg_26_0.openStage) or 1) - 1) * 350 - 250
end

function var_0_1.IsOpenSectionInfo(arg_27_0)
	return arg_27_0:IsOpenRoute("subPlotSectionInfo")
end

function var_0_1.GetScrollWidth(arg_28_0)
	local var_28_0 = arg_28_0.selectID == ActivityMonsterCosplayCfg.all[1] and 1 or 2

	return math.ceil(arg_28_0["contentRect" .. var_28_0 .. "_"].rect.width) + math.ceil(arg_28_0["viewportRect" .. var_28_0 .. "_"].rect.width) * 0.75
end

function var_0_1.OnExit(arg_29_0)
	arg_29_0.selectStageID = nil
	arg_29_0.lastSelectStageID = nil

	SetActive(arg_29_0.effGo_, false)
	manager.windowBar:HideBar()
	arg_29_0.scrollMoveView1:OnExit()
	arg_29_0.scrollMoveView2:OnExit()
	arg_29_0:UnbindRedPoint()
	var_0_1.super.OnExit(arg_29_0)
end

function var_0_1.UnbindRedPoint(arg_30_0)
	manager.redPoint:unbindUIandKey(arg_30_0.modelViewBtn_.transform, "MonsterCosPlayMonsterID" .. arg_30_0.selectID)
	manager.redPoint:unbindUIandKey(arg_30_0.taskBtn_.transform, RedPointConst.MONSTER_COSPLAY_TASK)

	for iter_30_0, iter_30_1 in pairs(arg_30_0.stageItemList_) do
		iter_30_1:UnbindRedPoint()
	end
end

function var_0_1.BindRedPoint(arg_31_0)
	manager.redPoint:bindUIandKey(arg_31_0.modelViewBtn_.transform, "MonsterCosPlayMonsterID" .. arg_31_0.selectID, {
		x = 0,
		y = 130
	})
	manager.redPoint:bindUIandKey(arg_31_0.taskBtn_.transform, RedPointConst.MONSTER_COSPLAY_TASK)

	for iter_31_0, iter_31_1 in pairs(arg_31_0.stageItemList_) do
		iter_31_1:BindRedPoint()
	end
end

function var_0_1.OnTop(arg_32_0)
	arg_32_0.stopMove_ = false

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		NAVI_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_MONSTER_COSPLAY_DESCRIBE")
end

function var_0_1.Dispose(arg_33_0)
	for iter_33_0, iter_33_1 in pairs(arg_33_0.stageItemList_) do
		iter_33_1:Dispose()
	end

	arg_33_0.stageList = nil

	arg_33_0.scrollMoveView1:Dispose()

	arg_33_0.scrollMoveView1 = nil

	arg_33_0.scrollMoveView2:Dispose()

	arg_33_0.scrollMoveView2 = nil

	var_0_1.super.Dispose(arg_33_0)
end

function var_0_1.OnUpdate(arg_34_0)
	return
end

return var_0_1
