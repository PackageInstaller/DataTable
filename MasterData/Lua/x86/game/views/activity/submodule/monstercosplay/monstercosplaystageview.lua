SubPlotBaseView = import("game.views.sectionSelect.subPlot.base.SubPlotBaseView")

local SummerChessMonsterCosplayUIData = import("game.data.summerChessBoard.gameUIData.SummerChessMonsterCosplayUIData")
local MonsterCosplayStageView = class("MonsterCosplayStageView", SubPlotBaseView)

function MonsterCosplayStageView:UIName()
	return "Widget/System/Summer2024/Summer2024_MonsterPlayUI/Summer2024_MonsterPlayStageUI"
end

function MonsterCosplayStageView:UIParent()
	return manager.ui.uiMain.transform
end

function MonsterCosplayStageView:GetItemClass()
	return MonsterCosplayStageItem
end

function MonsterCosplayStageView:GetCfgName()
	return BattleActivityMonsterCosplayCfg
end

function MonsterCosplayStageView:Init()
	self:BindCfgUI()

	self.itemWidth_ = self.sectionItem1_.transform:GetComponent("RectTransform").rect.width
	self.infoController = self.controller_:GetController("info")
	self.typeController = self.controller_:GetController("type")
	self.stageList = {}

	for iter_5_0 = 1, #ActivityMonsterCosplayCfg.all do
		self.stageList[ActivityMonsterCosplayCfg.all[iter_5_0]] = {}

		for iter_5_1 = 1, #ActivityMonsterCosplayCfg[ActivityMonsterCosplayCfg.all[iter_5_0]].stage_list do
			table.insert(self.stageList[ActivityMonsterCosplayCfg.all[iter_5_0]], self["stage" .. iter_5_0 .. iter_5_1 .. "Go_"])
		end
	end

	self.stageItemList_ = {}
	self.scrollMoveView1 = ScrollMoveView.New(self, self.scrollViewGo1_)
	self.scrollMoveView2 = ScrollMoveView.New(self, self.scrollViewGo2_)

	self:AddUIListener()
end

function MonsterCosplayStageView:AddUIListener()
	self:AddBtnListener(self.swap1Btn_, nil, function()
		if self.infoController:GetSelectedState() == "state1" then
			return
		end

		if self.typeController:GetSelectedState() == "3" then
			self.selectID = ActivityMonsterCosplayCfg.all[1]
			self.lastSelectStageID = nil

			self.typeController:SetSelectedState("2")
			self:RefreshData()
			self:RefreshUI()
			self:SetItemData()
			MonsterCosplayAction.ViewMonsterSkill(self.selectID, 0)
		end
	end)
	self:AddBtnListener(self.swap2Btn_, nil, function()
		if self.infoController:GetSelectedState() == "state1" then
			return
		end

		if self.typeController:GetSelectedState() == "2" then
			self.selectID = ActivityMonsterCosplayCfg.all[2]

			self.typeController:SetSelectedState("3")

			self.lastSelectStageID = nil

			self:RefreshData()
			self:RefreshUI()
			self:SetItemData()
			MonsterCosplayAction.ViewMonsterSkill(self.selectID, 0)
		end
	end)
	self:AddBtnListener(self.taskBtn_, nil, function()
		if self.infoController:GetSelectedState() == "state1" then
			self:Back()
		end

		local var_9_0 = ActivityConst.SUMMER_CHESS_BOARD_MONSTER_COSPLAY_LIMIT_TASK

		for iter_9_0, iter_9_1 in pairs((SummerChessMonsterCosplayUIData:GetTaskIDList(ActivityConst.SUMMER_CHESS_BOARD_MONSTER_COSPLAY_NORMAL_TASK))) do
			if TaskData2:GetTask(iter_9_1).complete_flag <= 0 then
				var_9_0 = ActivityConst.SUMMER_CHESS_BOARD_MONSTER_COSPLAY_NORMAL_TASK

				break
			end
		end

		JumpTools.OpenPageByJump("/summerChessBoardTask", {
			taskActivityID = var_9_0
		})
	end)
	self:AddBtnListener(self.bgBtn1_, nil, function()
		if self.selectStageID then
			self.lastSelectStageID = self.selectStageID
			self.selectStageID = nil

			self:RefreshUI()
			self:Back()
		end
	end)
	self:AddBtnListener(self.bgBtn2_, nil, function()
		if self.selectStageID then
			self.lastSelectStageID = self.selectStageID
			self.selectStageID = nil

			self:RefreshUI()
			self:Back()
		end
	end)
	self:AddBtnListener(self.modelViewBtn_, nil, function()
		JumpTools.OpenPageByJump("/MonsterCosplayMonster", {
			modelID = self.selectID
		})
	end)
end

function MonsterCosplayStageView:RefreshLineItemList()
	return
end

function MonsterCosplayStageView:RefreshData()
	self.stageData_ = BattleStageData:GetStageData()
	self.stageList_ = ActivityMonsterCosplayCfg[self.selectID].stage_list
end

function MonsterCosplayStageView:OnMonsterAllUpdate()
	self:RefreshData()
	self:RefreshUI()
	self:SetItemData()
end

function MonsterCosplayStageView:OnEnter()
	self.selectID = self.selectID or ActivityMonsterCosplayCfg[ActivityMonsterCosplayCfg.all[1]].id

	local var_16_0 = tonumber(getData("monsterCosplay", "selectID") or "0")

	if var_16_0 ~= 0 then
		self.selectID = var_16_0

		saveData("monsterCosplay", "selectID", "0")
	end

	if self.params_.selectID then
		self.selectID = self.params_.selectID
		self.params_.selectID = nil
	end

	self.canSwap = IsConditionAchieved(ActivityMonsterCosplayCfg[ActivityMonsterCosplayCfg.all[2]].unlock_condition[1])

	if (getData("monsterCosplay", "isFirstLock") or "1") == "1" and self.canSwap then
		self.selectID = ActivityMonsterCosplayCfg[ActivityMonsterCosplayCfg.all[2]].id

		saveData("monsterCosplay", "isFirstLock", "true")
	end

	manager.ui:SetMainCamera("null")

	self.leftAnimator_.enabled = true

	self:RefreshData()
	self:RefreshUI()
	self:SetItemData()
	self.infoController:SetSelectedState("state0")
	MonsterCosplayAction.ViewMonsterSkill(self.selectID, 0)
end

function MonsterCosplayStageView:RefreshUI()
	local var_17_0 = self:GetScrollPos()
	local var_17_1 = self:GetScrollWidth()

	if self.selectID == ActivityMonsterCosplayCfg[ActivityMonsterCosplayCfg.all[1]].id then
		self.scrollMoveView_ = self.scrollMoveView1 or self.scrollMoveView2
	end

	if self.selectID == ActivityMonsterCosplayCfg[ActivityMonsterCosplayCfg.all[1]].id then
		self.titleTxt_ = self.titleTxt1_ or self.titleTxt2_
	end

	self.titleTxt1_.text = GetI18NText(ActivityMonsterCosplayCfg[ActivityMonsterCosplayCfg.all[1]].chapter_name)

	local var_17_2 = self.selectID == ActivityMonsterCosplayCfg.all[1] and 1 or 2

	self.scrollMoveView_:RefreshUI(var_17_0, var_17_1, self["stop" .. (self.selectID == ActivityMonsterCosplayCfg.all[1] and 1 or 2)])

	self["stop" .. var_17_2] = false

	self:RefreshSelectItem()
end

function MonsterCosplayStageView:SetItemData()
	self:UnbindRedPoint()

	self.curStageGo = self.stageList[self.selectID]

	for iter_18_0 = 1, #self.stageList_ do
		self.stageItemList_[iter_18_0] = self:GetItemClass().New(self.curStageGo[iter_18_0], self.content_)

		self.stageItemList_[iter_18_0]:SetData(self.stageList_[iter_18_0], self.selectID, self)
	end

	SetActive(self.effGo_, self.canSwap and MonsterCosplayData:GetDataByPara("firstView"))

	if self.canSwap then
		self.typeController:SetSelectedState(self.selectID == ActivityMonsterCosplayCfg.all[1] and "2" or "3")
		self.animator_:Play(self.selectID == ActivityMonsterCosplayCfg.all[1] and "change02" or "change01")
		MonsterCosplayData.SetFirstView()
	else
		self.typeController:SetSelectedState("1")
	end

	self:BindRedPoint()
end

function MonsterCosplayStageView:SelectedItem(arg_19_1)
	if IsConditionAchieved((tonumber(BattleActivityMonsterCosplayCfg[arg_19_1].unlock_condition[1]))) then
		MonsterCosplayData:ClickStage(arg_19_1)
		manager.redPoint:setTip(RedPointConst.MONSTER_COSPLAY_STAGE .. arg_19_1, 0)
	end
end

function MonsterCosplayStageView:RefreshSelectItem()
	for iter_20_0, iter_20_1 in pairs(self.stageItemList_) do
		iter_20_1:SelectorItem(self.selectStageID)
	end
end

function MonsterCosplayStageView:CheckHaveCoreSkill()
	for iter_21_0, iter_21_1 in pairs(MonsterCosplayData:GetDataByPara("viewCoreSkillTable")[self.selectID]) do
		if iter_21_1 == false and IsConditionAchieved(TalentTreeCfg[iter_21_0].unlock_condition[1]) then
			return self.selectID, iter_21_0
		end
	end

	return nil, nil
end

function MonsterCosplayStageView:OnMonsterCoreSkill()
	local var_22_0, var_22_1 = MonsterCosplayData:CheckCanSkillEnhance()
	local var_22_2, var_22_3 = self:CheckHaveCoreSkill()

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

function MonsterCosplayStageView:OnMonsterSkillUp()
	self:OnMonsterCoreSkill()
end

function MonsterCosplayStageView:GetScrollPos()
	self.openStage = MonsterCosplayData:GetDataByPara("openStage")[self.selectID]

	if self.lastSelectStageID then
		self.lastSelectStageID = nil

		local var_26_0

		if self.lastSelectStageID == self.stageList_[#self.stageList_] then
			do return math.ceil(self["contentRect" .. (self.selectID == ActivityMonsterCosplayCfg.all[1] and 1 or 2) .. "_"].rect.width) + math.ceil(self["viewportRect" .. (self.selectID == ActivityMonsterCosplayCfg.all[1] and 1 or 2) .. "_"].rect.width) * 0.75 end

			var_26_0 = table.indexof(self.stageList_, self.lastSelectStageID) or 1
		end

		return self.itemRect_.rect.width / 2 + 650 + (var_26_0 - 1) * 350 - 250
	end

	local var_26_2

	if self.selectStageID then
		local var_26_1

		if self.selectStageID == self.stageList_[#self.stageList_] then
			do return math.ceil(self["contentRect" .. (self.selectID == ActivityMonsterCosplayCfg.all[1] and 1 or 2) .. "_"].rect.width) + math.ceil(self["viewportRect" .. (self.selectID == ActivityMonsterCosplayCfg.all[1] and 1 or 2) .. "_"].rect.width) * 0.75 end

			var_26_1 = table.indexof(self.stageList_, self.selectStageID) or 1
		end

		do return self.itemRect_.rect.width / 2 + 650 + (var_26_1 - 1) * 350 - 250 end

		var_26_2 = table.indexof(self.stageList_, self.openStage) or 1
	end

	return self.itemRect_.rect.width / 2 + 650 + (var_26_2 - 1) * 350 - 250
end

function MonsterCosplayStageView:IsOpenSectionInfo()
	return self:IsOpenRoute("subPlotSectionInfo")
end

function MonsterCosplayStageView:GetScrollWidth()
	return math.ceil(self["contentRect" .. (self.selectID == ActivityMonsterCosplayCfg.all[1] and 1 or 2) .. "_"].rect.width) + math.ceil(self["viewportRect" .. (self.selectID == ActivityMonsterCosplayCfg.all[1] and 1 or 2) .. "_"].rect.width) * 0.75
end

function MonsterCosplayStageView:OnExit()
	self.selectStageID = nil
	self.lastSelectStageID = nil

	SetActive(self.effGo_, false)
	manager.windowBar:HideBar()
	self.scrollMoveView1:OnExit()
	self.scrollMoveView2:OnExit()
	self:UnbindRedPoint()
	MonsterCosplayStageView.super.OnExit(self)
end

function MonsterCosplayStageView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.modelViewBtn_.transform, "MonsterCosPlayMonsterID" .. self.selectID)
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, RedPointConst.MONSTER_COSPLAY_TASK)

	for iter_30_0, iter_30_1 in pairs(self.stageItemList_) do
		iter_30_1:UnbindRedPoint()
	end
end

function MonsterCosplayStageView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.modelViewBtn_.transform, "MonsterCosPlayMonsterID" .. self.selectID, {
		x = 0,
		y = 130
	})
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, RedPointConst.MONSTER_COSPLAY_TASK)

	for iter_31_0, iter_31_1 in pairs(self.stageItemList_) do
		iter_31_1:BindRedPoint()
	end
end

function MonsterCosplayStageView:OnTop()
	self.stopMove_ = false

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		NAVI_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_MONSTER_COSPLAY_DESCRIBE")
end

function MonsterCosplayStageView:Dispose()
	for iter_33_0, iter_33_1 in pairs(self.stageItemList_) do
		iter_33_1:Dispose()
	end

	self.stageList = nil

	self.scrollMoveView1:Dispose()

	self.scrollMoveView1 = nil

	self.scrollMoveView2:Dispose()

	self.scrollMoveView2 = nil

	MonsterCosplayStageView.super.Dispose(self)
end

function MonsterCosplayStageView:OnUpdate()
	return
end

return MonsterCosplayStageView
