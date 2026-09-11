local TetrisGameChooseStageView = class("TetrisGameChooseStageView", ReduxView)

function TetrisGameChooseStageView:UIName()
	return "Widget/Version/Alone_TetrisGameUI/TetrisGameORDChapterUI"
end

function TetrisGameChooseStageView:UIParent()
	return manager.ui.uiMain.transform
end

function TetrisGameChooseStageView:OnCtor()
	return
end

function TetrisGameChooseStageView:Init()
	self:InitUI()
	self:AddUIListener()
end

function TetrisGameChooseStageView:InitUI()
	self:BindCfgUI()

	self.scrollMoveView_ = ScrollMoveView.New(self, self.scrollViewGo_)
	self.skillController = self.controller:GetController("skill")
	self.lockController = self.btnController_:GetController("lock")
	self.stageItemList = {}
end

function TetrisGameChooseStageView:OnEnter()
	if self.params_.isORD then
		self.isORD = self.params_.isORD
		self.params_.isORD = nil
	end

	self.scrollMoveView_.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(self, self.BeginDragFun)))
	self.scrollMoveView_.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(self, self.EndDragFun)))

	self.activityID = TetrisGameData:GetCurActivityID()
	self.chapterID = self.params_.chapterID or self.chapterID
	self.chapterIndex = table.keyof(ActivityTetrisGameChapterCfg.get_id_list_by_type[TetrisGameConst.stageType.normal], self.chapterID)
	self.stageIDList = ActivityTetrisGameChapterCfg[self.chapterID].tetris_stage_list

	if ActivityTetrisGameChapterCfg[ActivityTetrisGameChapterCfg.get_id_list_by_activityID[self.activityID][1]].chapterID + 1 == self.chapterID then
		SetActive(self.goBtn_.gameObject, false)
	else
		SetActive(self.goBtn_.gameObject, true)
	end

	self:InitStageInfo()

	self.params_.stageID = nil

	self:ChooseStage(self.params_.stageID or self:GetTargetSelectStageID())

	local var_6_0, var_6_1 = TetrisGameTools:CheckChapterIsOpen((TetrisGameTools:GetEndLessStageIDByActivityID(self.activityID)))

	if not var_6_0 then
		self.lockController:SetSelectedIndex(1)
	else
		self.lockController:SetSelectedIndex(0)
	end

	self:BindRedPoint()
end

function TetrisGameChooseStageView:BindRedPoint()
	for iter_7_0, iter_7_1 in ipairs(ActivityTetrisGameChapterCfg.all) do
		if ActivityTetrisGameChapterCfg[iter_7_1].type == TetrisGameConst.stageType.endLess then
			manager.redPoint:bindUIandKey(self.goBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_CHAPTER, iter_7_1))
		end
	end
end

function TetrisGameChooseStageView:UnbindRedPoint()
	for iter_8_0, iter_8_1 in ipairs(ActivityTetrisGameChapterCfg.all) do
		if ActivityTetrisGameChapterCfg[iter_8_1].type == TetrisGameConst.stageType.endLess then
			manager.redPoint:unbindUIandKey(self.goBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_CHAPTER, iter_8_1))
		end
	end
end

function TetrisGameChooseStageView:GetTargetSelectStageID()
	local var_9_0 = 0

	for iter_9_0 = 1, #self.stageIDList do
		local var_9_1 = TetrisGameData:GetStageInfoByStageID(self.stageIDList[iter_9_0])

		if var_9_1 and var_9_1.isClear then
			var_9_0 = iter_9_0
		end
	end

	if var_9_0 + 1 <= #self.stageIDList then
		var_9_0 = var_9_0 + 1
	end

	return self.stageIDList[var_9_0]
end

function TetrisGameChooseStageView:OnTop()
	self:RefreshStageState()
	self:RefreshStageInfo()
	self:RefreshBar()
end

function TetrisGameChooseStageView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})

	if GameSetting.tetris_game_describe1 then
		local var_11_0 = GameSetting.tetris_game_describe1.value or {}
	end

	manager.windowBar:RegistInfoCallBack(function()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_11_0
		})
	end)
	manager.windowBar:RegistBackCallBack(function()
		if self.isORD then
			JumpTools.OpenPageByJump("/tetrisGameMainView")
		else
			self:Back()
		end
	end)
end

function TetrisGameChooseStageView:OnExit()
	manager.windowBar:HideBar()
	self.scrollMoveView_.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	self.scrollMoveView_.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	self:RemoveAllEventListener()
	self.scrollMoveView_:OnExit()
	self:DisposeStageInfo()

	self.selStageID = nil
	self.stageID = nil

	self:UnbindRedPoint()
end

function TetrisGameChooseStageView:AddUIListener()
	self:AddBtnListener(self.skillBtn, nil, function()
		if #self.skillList > 0 then
			JumpTools.OpenPageByJump("tetrisGameGetSkillView", {
				stageID = self.stageID
			})
		end
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		local var_17_0, var_17_1 = TetrisGameTools:CheckChapterIsOpen((TetrisGameTools:GetEndLessStageIDByActivityID(self.activityID)))

		if not var_17_0 then
			ShowTips(GetI18NText(var_17_1))

			return
		end

		JumpTools.OpenPageByJump("/tetrisGameSkillView", {
			isORD = true
		})
	end)
end

function TetrisGameChooseStageView:BeginDragFun(arg_18_1, arg_18_2)
	self.beginMousePos = Input.mousePosition
end

function TetrisGameChooseStageView:EndDragFun(arg_19_1, arg_19_2)
	local var_19_0 = 0

	if self.beginMousePos.x - Input.mousePosition.x > 0 then
		var_19_0 = 1
	elseif self.beginMousePos.x - Input.mousePosition.x < 0 then
		var_19_0 = -1
	end

	local var_19_1

	for iter_19_0, iter_19_1 in pairs(self.stageIDList) do
		if iter_19_1 == self.selStageID then
			var_19_1 = iter_19_0 + var_19_0
		end
	end

	if self.stageIDList[var_19_1] then
		self:ChooseStage(self.stageIDList[var_19_1])
	end
end

function TetrisGameChooseStageView:Dispose()
	TetrisGameChooseStageView.super.Dispose(self)
	self.scrollMoveView_:Dispose()

	self.scrollMoveView_ = nil

	self:DisposeStageInfo()
end

function TetrisGameChooseStageView:RefreshStageState()
	self.chapterName.text = ActivityTetrisGameChapterCfg[self.chapterID].name
end

function TetrisGameChooseStageView:ChooseStage(arg_22_1)
	local var_22_0 = TetrisGameTools:GetChapterState(arg_22_1)

	self.stageID = arg_22_1

	if arg_22_1 == self.selStageID then
		TetrisGameTools:EnterStage(arg_22_1)

		return
	end

	local var_22_1 = self.selStageID

	self.selStageID = arg_22_1

	if var_22_1 then
		self.stageItemList[var_22_1]:PlayAni(false)
	end

	local var_22_2 = self.stageItemList[arg_22_1]

	self.stageItemList[arg_22_1]:PlayAni(true)
	var_22_2:UpdataRedPoint()
	self:ScrollList(self.selStageID)

	self.skillList = ActivityTetrisGameStageCfg[arg_22_1].skill_list

	self.skillController:SetSelectedState("false")

	if self.chapterIndex == 1 then
		manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_block_ui_a", "")
	else
		manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_block_ui_b", "")
	end

	self:RefreshStageInfo()
end

function TetrisGameChooseStageView:InitStageInfo()
	self.stageItemList = self.stageItemList or {}

	for iter_23_0, iter_23_1 in ipairs(self.stageIDList) do
		local var_23_0 = TetrisGameChooseStageItem.New((Object.Instantiate(self.stageGo, self.scrollMoveView_.content_.transform)))

		var_23_0:RegisterClick(handler(self, self.ChooseStage))

		self.stageItemList[iter_23_1] = var_23_0
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.scrollMoveView_.content_.transform)
end

function TetrisGameChooseStageView:RefreshStageInfo()
	if self.stageItemList then
		for iter_24_0, iter_24_1 in pairs(self.stageItemList) do
			iter_24_1:RefreshUI(iter_24_0, self.selStageID, self.chapterIndex)
		end
	end
end

function TetrisGameChooseStageView:DisposeStageInfo()
	if self.stageItemList then
		for iter_25_0, iter_25_1 in pairs(self.stageItemList) do
			iter_25_1:Dispose()
		end

		self.stageItemList = nil
	end
end

function TetrisGameChooseStageView:ScrollList(arg_26_1)
	self.scrollMoveView_.needInitScroll_ = false

	self.scrollMoveView_:ScrollPosition(self:GetScrollPos(arg_26_1), false, -200)
end

function TetrisGameChooseStageView:GetScrollPos(arg_27_1)
	return self.stageItemList[arg_27_1].rectTransform.anchoredPosition.x
end

function TetrisGameChooseStageView:IsOpenSectionInfo()
	return true
end

return TetrisGameChooseStageView
