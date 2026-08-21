local var_0_0 = class("TetrisGameChooseStageView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/Alone_TetrisGameUI/TetrisGameORDChapterUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.scrollMoveView_ = ScrollMoveView.New(arg_5_0, arg_5_0.scrollViewGo_)
	arg_5_0.skillController = arg_5_0.controller:GetController("skill")
	arg_5_0.lockController = arg_5_0.btnController_:GetController("lock")
	arg_5_0.stageItemList = {}
end

function var_0_0.OnEnter(arg_6_0)
	if arg_6_0.params_.isORD then
		arg_6_0.isORD = arg_6_0.params_.isORD
		arg_6_0.params_.isORD = nil
	end

	arg_6_0.scrollMoveView_.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(arg_6_0, arg_6_0.BeginDragFun)))
	arg_6_0.scrollMoveView_.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(arg_6_0, arg_6_0.EndDragFun)))

	arg_6_0.activityID = TetrisGameData:GetCurActivityID()
	arg_6_0.chapterID = arg_6_0.params_.chapterID or arg_6_0.chapterID
	arg_6_0.chapterIndex = table.keyof(ActivityTetrisGameChapterCfg.get_id_list_by_type[TetrisGameConst.stageType.normal], arg_6_0.chapterID)
	arg_6_0.stageIDList = ActivityTetrisGameChapterCfg[arg_6_0.chapterID].tetris_stage_list

	local var_6_0 = ActivityTetrisGameChapterCfg.get_id_list_by_activityID[arg_6_0.activityID][1]

	if ActivityTetrisGameChapterCfg[var_6_0].chapterID + 1 == arg_6_0.chapterID then
		SetActive(arg_6_0.goBtn_.gameObject, false)
	else
		SetActive(arg_6_0.goBtn_.gameObject, true)
	end

	arg_6_0:InitStageInfo()

	local var_6_1 = arg_6_0.params_.stageID or arg_6_0:GetTargetSelectStageID()

	arg_6_0.params_.stageID = nil

	arg_6_0:ChooseStage(var_6_1)

	local var_6_2 = TetrisGameTools:GetEndLessStageIDByActivityID(arg_6_0.activityID)
	local var_6_3, var_6_4 = TetrisGameTools:CheckChapterIsOpen(var_6_2)

	if not var_6_3 then
		arg_6_0.lockController:SetSelectedIndex(1)
	else
		arg_6_0.lockController:SetSelectedIndex(0)
	end

	arg_6_0:BindRedPoint()
end

function var_0_0.BindRedPoint(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(ActivityTetrisGameChapterCfg.all) do
		if ActivityTetrisGameChapterCfg[iter_7_1].type == TetrisGameConst.stageType.endLess then
			manager.redPoint:bindUIandKey(arg_7_0.goBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_CHAPTER, iter_7_1))
		end
	end
end

function var_0_0.UnbindRedPoint(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(ActivityTetrisGameChapterCfg.all) do
		if ActivityTetrisGameChapterCfg[iter_8_1].type == TetrisGameConst.stageType.endLess then
			manager.redPoint:unbindUIandKey(arg_8_0.goBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_CHAPTER, iter_8_1))
		end
	end
end

function var_0_0.GetTargetSelectStageID(arg_9_0)
	local var_9_0 = 0

	for iter_9_0 = 1, #arg_9_0.stageIDList do
		local var_9_1 = arg_9_0.stageIDList[iter_9_0]
		local var_9_2 = TetrisGameData:GetStageInfoByStageID(var_9_1)

		if var_9_2 and var_9_2.isClear then
			var_9_0 = iter_9_0
		end
	end

	if var_9_0 + 1 <= #arg_9_0.stageIDList then
		var_9_0 = var_9_0 + 1
	end

	return arg_9_0.stageIDList[var_9_0]
end

function var_0_0.OnTop(arg_10_0)
	arg_10_0:RefreshStageState()
	arg_10_0:RefreshStageInfo()
	arg_10_0:RefreshBar()
end

function var_0_0.RefreshBar(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})

	local var_11_0 = GameSetting.tetris_game_describe1 and GameSetting.tetris_game_describe1.value or {}

	manager.windowBar:RegistInfoCallBack(function()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_11_0
		})
	end)
	manager.windowBar:RegistBackCallBack(function()
		if arg_11_0.isORD then
			JumpTools.OpenPageByJump("/tetrisGameMainView")
		else
			arg_11_0:Back()
		end
	end)
end

function var_0_0.OnExit(arg_14_0)
	manager.windowBar:HideBar()
	arg_14_0.scrollMoveView_.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	arg_14_0.scrollMoveView_.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	arg_14_0:RemoveAllEventListener()
	arg_14_0.scrollMoveView_:OnExit()
	arg_14_0:DisposeStageInfo()

	arg_14_0.selStageID = nil
	arg_14_0.stageID = nil

	arg_14_0:UnbindRedPoint()
end

function var_0_0.AddUIListener(arg_15_0)
	arg_15_0:AddBtnListener(arg_15_0.skillBtn, nil, function()
		if #arg_15_0.skillList > 0 then
			JumpTools.OpenPageByJump("tetrisGameGetSkillView", {
				stageID = arg_15_0.stageID
			})
		end
	end)
	arg_15_0:AddBtnListener(arg_15_0.goBtn_, nil, function()
		local var_17_0 = TetrisGameTools:GetEndLessStageIDByActivityID(arg_15_0.activityID)
		local var_17_1, var_17_2 = TetrisGameTools:CheckChapterIsOpen(var_17_0)

		if not var_17_1 then
			ShowTips(GetI18NText(var_17_2))

			return
		end

		JumpTools.OpenPageByJump("/tetrisGameSkillView", {
			isORD = true
		})
	end)
end

function var_0_0.BeginDragFun(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.beginMousePos = Input.mousePosition
end

function var_0_0.EndDragFun(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = Input.mousePosition
	local var_19_1 = 0

	if arg_19_0.beginMousePos.x - var_19_0.x > 0 then
		var_19_1 = 1
	elseif arg_19_0.beginMousePos.x - var_19_0.x < 0 then
		var_19_1 = -1
	end

	local var_19_2

	for iter_19_0, iter_19_1 in pairs(arg_19_0.stageIDList) do
		if iter_19_1 == arg_19_0.selStageID then
			var_19_2 = iter_19_0 + var_19_1
		end
	end

	local var_19_3 = arg_19_0.stageIDList[var_19_2]

	if var_19_3 then
		arg_19_0:ChooseStage(var_19_3)
	end
end

function var_0_0.Dispose(arg_20_0)
	var_0_0.super.Dispose(arg_20_0)
	arg_20_0.scrollMoveView_:Dispose()

	arg_20_0.scrollMoveView_ = nil

	arg_20_0:DisposeStageInfo()
end

function var_0_0.RefreshStageState(arg_21_0)
	arg_21_0.chapterName.text = ActivityTetrisGameChapterCfg[arg_21_0.chapterID].name
end

function var_0_0.ChooseStage(arg_22_0, arg_22_1)
	local var_22_0 = TetrisGameTools:GetChapterState(arg_22_1)

	arg_22_0.stageID = arg_22_1

	if arg_22_1 == arg_22_0.selStageID then
		TetrisGameTools:EnterStage(arg_22_1)

		return
	end

	local var_22_1 = arg_22_0.selStageID

	arg_22_0.selStageID = arg_22_1

	if var_22_1 then
		arg_22_0.stageItemList[var_22_1]:PlayAni(false)
	end

	local var_22_2 = arg_22_0.stageItemList[arg_22_1]

	var_22_2:PlayAni(true)
	var_22_2:UpdataRedPoint()
	arg_22_0:ScrollList(arg_22_0.selStageID)

	arg_22_0.skillList = ActivityTetrisGameStageCfg[arg_22_1].skill_list

	arg_22_0.skillController:SetSelectedState("false")

	if arg_22_0.chapterIndex == 1 then
		manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_block_ui_a", "")
	else
		manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_block_ui_b", "")
	end

	arg_22_0:RefreshStageInfo()
end

function var_0_0.InitStageInfo(arg_23_0)
	if not arg_23_0.stageItemList then
		arg_23_0.stageItemList = {}
	end

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.stageIDList) do
		local var_23_0 = Object.Instantiate(arg_23_0.stageGo, arg_23_0.scrollMoveView_.content_.transform)
		local var_23_1 = TetrisGameChooseStageItem.New(var_23_0)

		var_23_1:RegisterClick(handler(arg_23_0, arg_23_0.ChooseStage))

		arg_23_0.stageItemList[iter_23_1] = var_23_1
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_0.scrollMoveView_.content_.transform)
end

function var_0_0.RefreshStageInfo(arg_24_0)
	if arg_24_0.stageItemList then
		for iter_24_0, iter_24_1 in pairs(arg_24_0.stageItemList) do
			iter_24_1:RefreshUI(iter_24_0, arg_24_0.selStageID, arg_24_0.chapterIndex)
		end
	end
end

function var_0_0.DisposeStageInfo(arg_25_0)
	if arg_25_0.stageItemList then
		for iter_25_0, iter_25_1 in pairs(arg_25_0.stageItemList) do
			iter_25_1:Dispose()
		end

		arg_25_0.stageItemList = nil
	end
end

function var_0_0.ScrollList(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:GetScrollPos(arg_26_1)

	arg_26_0.scrollMoveView_.needInitScroll_ = false

	arg_26_0.scrollMoveView_:ScrollPosition(var_26_0, false, -200)
end

function var_0_0.GetScrollPos(arg_27_0, arg_27_1)
	return arg_27_0.stageItemList[arg_27_1].rectTransform.anchoredPosition.x
end

function var_0_0.IsOpenSectionInfo(arg_28_0)
	return true
end

return var_0_0
