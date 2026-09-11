local MonsterCosplayStageItem = class("MonsterCosplayStageItem", ReduxView)

function MonsterCosplayStageItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.stateController = self.controller_:GetController("state")
	self.typeController = self.controller_:GetController("type")
	self.selController = self.controller_:GetController("sel")
end

function MonsterCosplayStageItem:SetData(arg_2_1, arg_2_2, arg_2_3)
	self.stageID = arg_2_1
	self.monsterID = arg_2_2
	self.monsterData = MonsterCosplayData:GetDataByPara("monsterData")[self.monsterID]
	self.stageData = self.monsterData.finishedStage
	self.openStage = MonsterCosplayData:GetDataByPara("openStage")[arg_2_2]
	self.finishedPointStageData = self.monsterData.finishedPointStage
	self.parent = arg_2_3

	self:RefreshUI()
end

function MonsterCosplayStageItem:Dispose()
	MonsterCosplayStageItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function MonsterCosplayStageItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if IsConditionAchieved(tonumber(BattleActivityMonsterCosplayCfg[self.stageID].unlock_condition)) == false then
			ShowTips(ConditionCfg[tonumber(BattleActivityMonsterCosplayCfg[self.stageID].unlock_condition)].desc)

			return
		end

		self.parent.leftAnimator_.enabled = false
		self.parent.selectStageID = self.stageID

		JumpTools.OpenPageByJump("MonsterCosplaySectionInfo", {
			section = self.stageID,
			monsterID = self.monsterID,
			parent = self.parent
		})
		self:SelectorItem(self.stageID)
		self.parent:SelectedItem(self.stageID)
		self.parent.infoController:SetSelectedState("state1")
		self.parent:RefreshUI()
	end)
end

function MonsterCosplayStageItem:IsOpenSectionInfo()
	return self:IsOpenRoute("subPlotSectionInfo")
end

function MonsterCosplayStageItem:RefreshUI()
	self:Show(true)
	self:RefreshCustomUI()
end

function MonsterCosplayStageItem:RefreshCustomUI()
	self.selController:SetSelectedState("false")

	local var_8_0 = BattleActivityMonsterCosplayCfg[self.stageID]

	self.textIndex_.text = BattleActivityMonsterCosplayCfg[self.stageID].name
	self.scoreLevelTxt_.text = var_8_0.name

	if self.stageData[self.stageID] then
		self.stateController:SetSelectedState("2")

		if var_8_0.sub_type == 2 and self.finishedPointStageData[self.stageID] then
			self.scoreTxt_.text = self.finishedPointStageData[self.stageID].maxScore
		end
	elseif self.stageID == self.openStage and IsConditionAchieved(tonumber(var_8_0.unlock_condition[1])) then
		self.stateController:SetSelectedState("1")
	else
		self.stateController:SetSelectedState("3")
	end

	if var_8_0.sub_type == 1 then
		self.typeController:SetSelectedState("2")
	elseif var_8_0.sub_type == 2 then
		self.typeController:SetSelectedState("3")
	end
end

function MonsterCosplayStageItem:BindRedPoint()
	manager.redPoint:bindUIandKey(self.transform_, RedPointConst.MONSTER_COSPLAY_STAGE .. self.stageID)
end

function MonsterCosplayStageItem:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.transform_, RedPointConst.MONSTER_COSPLAY_STAGE .. self.stageID)
end

function MonsterCosplayStageItem:SelectorItem(arg_11_1)
	if self.stageID == arg_11_1 then
		self.selController:SetSelectedState("state1")
	else
		self.selController:SetSelectedState("state0")
	end
end

function MonsterCosplayStageItem:GetLocalPosition()
	return self.transform_.localPosition
end

function MonsterCosplayStageItem:Show(arg_13_1)
	SetActive(self.gameObject_, arg_13_1)
end

return MonsterCosplayStageItem
