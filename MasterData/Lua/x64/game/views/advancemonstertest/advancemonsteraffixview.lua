local AdvanceMonsterAffixView = class("AdvanceMonsterAffixView", ReduxView)

function AdvanceMonsterAffixView:UIName()
	return "Widget/System/BossTestUI/BossTestAffixUI"
end

function AdvanceMonsterAffixView:UIParent()
	return manager.ui.uiMain.transform
end

function AdvanceMonsterAffixView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AdvanceMonsterAffixView:InitUI()
	self:BindCfgUI()

	self.customDesScrollHelper_ = LuaList.New(handler(self, self.CustomDesIndexItem), self.customDesListGo_, CustomDesItem)
	self.emptyController_ = self.scrollviewController_:GetController("empty")
end

function AdvanceMonsterAffixView:CustomDesIndexItem(arg_5_1, arg_5_2)
	if arg_5_1 <= #self.defaultStageList_ then
		arg_5_2:RefreshUI(self.defaultStageList_[arg_5_1], true)
	else
		arg_5_2:RefreshUI(ActivityAffixPoolCfg[self.customSelectList_[arg_5_1 - #self.defaultStageList_]].affix, false)
	end
end

function AdvanceMonsterAffixView:AddUIListener()
	self:AddBtnListener(self.startBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_ADVANCE_MONSTER_TEST) then
			ShowTips("TIME_OVER")

			return
		end

		AdvanceMonsterTestAction:SaveCustomList(self.stageID_, self.customSelectList_)
		AdvanceMonsterTestData:SetCurStageID(self.stageID_)
		self:Go("/sectionSelectHero", {
			section = ActivityAdvanceMonsterTestCfg[self.stageID_].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.ADVANCE_MONSTER_TEST,
			activityID = ActivityConst.ACTIVITY_ADVANCE_MONSTER_TEST
		})
	end)
end

function AdvanceMonsterAffixView:OnEnter()
	self.stageID_ = self.params_.stageID
	self.customSelectList_ = AdvanceMonsterTestData:GetCustomList(self.stageID_)

	local var_8_0 = ActivityAdvanceMonsterTestCfg[self.stageID_]

	self.defaultStageList_ = BattleActivityAdvanceMonsterTestCfg[ActivityAdvanceMonsterTestCfg[self.stageID_].stage_id].affix_type == "" and {} or BattleActivityAdvanceMonsterTestCfg[ActivityAdvanceMonsterTestCfg[self.stageID_].stage_id].affix_type

	self:CreatCustomTable()
	self:CreatCustomSelectTable()
	self:RefreshUI()

	self.pages = {}

	if ActivityAdvanceMonsterTestCfg[self.stageID_].level_describe ~= "" then
		self.pages = ActivityAdvanceMonsterTestCfg[self.stageID_].level_describe
	end

	local var_8_1 = AdvanceMonsterTestData:GetCurStageID()

	if getData("monsterTest", "monsterTestStage_" .. self.stageID_) ~= "1" and #self.pages > 0 and ((var_8_1 > 0 or nil) and ActivityAdvanceMonsterTestCfg[var_8_1].type) == var_8_0.type then
		saveData("monsterTest", "monsterTestStage_" .. self.stageID_, "1")
		TimeTools.StartAfterSeconds(0.1, function()
			JumpTools.OpenPageByJump("gameHelpPro", {
				isPrefab = true,
				pages = self.pages
			})
		end, {})
	end
end

function AdvanceMonsterAffixView:CreatCustomTable()
	self.customTable_ = {
		all = {}
	}

	for iter_10_0, iter_10_1 in ipairs(ActivityAdvanceMonsterTestCfg[self.stageID_].pool) do
		if ActivityAffixPoolCfg[iter_10_1] then
			if not self.customTable_[ActivityAffixPoolCfg[iter_10_1].affix[1]] then
				self.customTable_[ActivityAffixPoolCfg[iter_10_1].affix[1]] = {}

				table.insert(self.customTable_.all, ActivityAffixPoolCfg[iter_10_1].affix[1])
			end

			table.insert(self.customTable_[ActivityAffixPoolCfg[iter_10_1].affix[1]], iter_10_1)
		end
	end
end

function AdvanceMonsterAffixView:CreatCustomSelectTable()
	self.customSelectTable_ = {}

	for iter_11_0, iter_11_1 in ipairs(self.customSelectList_) do
		self.customSelectTable_[ActivityAffixPoolCfg[iter_11_1].affix[1]] = iter_11_1
	end
end

function AdvanceMonsterAffixView:GetSelectCustom(arg_12_1)
	if self.customSelectTable_[arg_12_1] then
		return self.customSelectTable_[arg_12_1]
	end

	return nil
end

function AdvanceMonsterAffixView:SetSelectCustom(arg_13_1, arg_13_2)
	if self.customSelectTable_[arg_13_1] then
		table.remove(self.customSelectList_, table.indexof(self.customSelectList_, self.customSelectTable_[arg_13_1]))
	end

	if arg_13_2 then
		self.customSelectTable_[arg_13_1] = arg_13_2

		table.insert(self.customSelectList_, arg_13_2)
	else
		self.customSelectTable_[arg_13_1] = nil
	end
end

function AdvanceMonsterAffixView:RefreshUI()
	self:CalculatePoint()
	self:RefreshDesList(true)
	self:InitMultipleAffixList()
	self:CustomAffixListUpdate()
end

function AdvanceMonsterAffixView:InitMultipleAffixList()
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in pairs(ActivityAdvanceMonsterTestCfg[self.stageID_].pool) do
		var_15_0[ActivityAffixPoolCfg[iter_15_1].affix[1]] = true
	end

	local var_15_1 = {}
	local var_15_2 = {}

	for iter_15_2, iter_15_3 in pairs(ActivityAdvanceMonsterTestCfg[self.stageID_].multiple_affix) do
		if not var_15_2[ActivityAffixPoolCfg[iter_15_3].affix[1]] then
			var_15_2[ActivityAffixPoolCfg[iter_15_3].affix[1]] = iter_15_3
		elseif ActivityAffixPoolCfg[iter_15_3].affix[2] > ActivityAffixPoolCfg[var_15_2[ActivityAffixPoolCfg[iter_15_3].affix[1]]].affix[2] then
			var_15_2[ActivityAffixPoolCfg[iter_15_3].affix[1]] = iter_15_3
		end
	end

	for iter_15_4, iter_15_5 in ipairs(ActivityAdvanceMonsterTestCfg[self.stageID_].multiple_affix) do
		if var_15_2[ActivityAffixPoolCfg[iter_15_5].affix[1]] == iter_15_5 and not var_15_0[ActivityAffixPoolCfg[iter_15_5].affix[1]] then
			table.insert(var_15_1, iter_15_5)
		end
	end

	self.multipleAffixList = var_15_1
end

function AdvanceMonsterAffixView:CustomMultipleAffixUpdate()
	self.multipleAffixItem = self.multipleAffixItem or self:CreateMultipleAffixCustomItem()

	SetActive(self.multipleAffixItem.gameObject_, false)

	if self.multipleAffixList and #self.multipleAffixList > 0 then
		SetActive(self.multipleAffixItem.gameObject_, true)
		self.multipleAffixItem:RefreshUI(self.multipleAffixList, self.customSelectList_)
	end
end

function AdvanceMonsterAffixView:CustomAffixListUpdate()
	self:CustomMultipleAffixUpdate()

	self.customAffixList = self.customAffixList or {}

	for iter_17_0, iter_17_1 in pairs(self.customAffixList or {}) do
		SetActive(iter_17_1.gameObject_, false)
	end

	for iter_17_2, iter_17_3 in pairs(self.customTable_.all) do
		self.customAffixList[iter_17_2] = self.customAffixList[iter_17_2] or self:CreateAffixCustomItem()

		local var_17_0 = self.customAffixList[iter_17_2]

		SetActive(self.customAffixList[iter_17_2].gameObject_, true)
		var_17_0:RefreshUI(self.customTable_.all[iter_17_2], self.customTable_[self.customTable_.all[iter_17_2]], (self:GetSelectCustom(self.customTable_.all[iter_17_2])))
	end

	if self.multipleAffixList then
		if self.customTable_.all then
			if (#self.multipleAffixList or 0) + (#self.customTable_.all or 0) > 0 then
				self.emptyController_:SetSelectedState("false")

				goto label_17_0
			end
		end
	end

	self.emptyController_:SetSelectedState("true")

	::label_17_0::
end

function AdvanceMonsterAffixView:CreateAffixCustomItem()
	local var_18_0 = CustomBox.New((GameObject.Instantiate(self.affixGroupGo_, self.affixContent_)))

	var_18_0:RegisterClickListener(function(arg_19_0)
		local var_19_0 = ActivityAffixPoolCfg[arg_19_0].affix[1]

		if self:GetSelectCustom(ActivityAffixPoolCfg[arg_19_0].affix[1]) ~= arg_19_0 then
			self:SetSelectCustom(var_19_0, arg_19_0)
		else
			self:SetSelectCustom(var_19_0)
		end

		var_18_0:RefreshUI(var_19_0, self.customTable_[var_19_0], self:GetSelectCustom(var_19_0))
		self:CalculatePoint()
		self:RefreshDesList(false, arg_19_0)
	end)

	return var_18_0
end

function AdvanceMonsterAffixView:CreateMultipleAffixCustomItem()
	local var_20_0 = AdvanceMonsterMultipleAffixItem.New((GameObject.Instantiate(self.affixMultipleGroupGo_, self.affixContent_)))

	var_20_0:RegisterClickListener(function(arg_21_0)
		self:SelectMultipleCustom(arg_21_0)
		var_20_0:RefreshUI(self.multipleAffixList, self.customSelectList_)
		self:CalculatePoint()
		self:RefreshDesList(false, arg_21_0)
	end)

	return var_20_0
end

function AdvanceMonsterAffixView:SelectMultipleCustom(arg_22_1)
	local var_22_0 = table.indexof(self.customSelectList_, arg_22_1)

	if var_22_0 then
		table.remove(self.customSelectList_, var_22_0)
	else
		table.insert(self.customSelectList_, arg_22_1)
	end
end

function AdvanceMonsterAffixView:CalculatePoint()
	local var_23_1 = ActivityAdvanceMonsterTestCfg[self.stageID_].base_point

	for iter_23_0, iter_23_1 in ipairs(self.customSelectList_) do
		var_23_1 = var_23_1 + ActivityAffixPoolCfg[iter_23_1].point
	end

	self.pointText_.text = string.format("<color=#FE972E>%d</color>", var_23_1)
end

function AdvanceMonsterAffixView:RefreshDesList(arg_24_1, arg_24_2)
	if arg_24_1 then
		self.customDesScrollHelper_:StartScroll(#self.defaultStageList_ + #self.customSelectList_)
	else
		local var_24_0 = table.indexof(self.customSelectList_, arg_24_2)

		if var_24_0 then
			self.customDesScrollHelper_:StartScroll(#self.defaultStageList_ + #self.customSelectList_, #self.defaultStageList_ + var_24_0)
		else
			self.customDesScrollHelper_:StartScrollByPosition(#self.defaultStageList_ + #self.customSelectList_, self.customDesScrollHelper_:GetScrolledPosition())
		end
	end
end

function AdvanceMonsterAffixView:OnTop()
	if #self.pages > 0 then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end

	manager.windowBar:RegistHomeCallBack(function()
		AdvanceMonsterTestAction:SaveCustomList(self.stageID_, self.customSelectList_)
		self:Go("/home", nil, nil, true)
	end)
	manager.windowBar:RegistBackCallBack(function()
		AdvanceMonsterTestAction:SaveCustomList(self.stageID_, self.customSelectList_)
		self:Back()
	end)
	manager.windowBar:RegistInfoCallBack(function()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = self.pages
		})
	end)
end

function AdvanceMonsterAffixView:OnExit()
	manager.windowBar:HideBar()
end

function AdvanceMonsterAffixView:Dispose()
	AdvanceMonsterAffixView.super.Dispose(self)

	if self.customDesScrollHelper_ then
		self.customDesScrollHelper_:Dispose()

		self.customDesScrollHelper_ = nil
	end

	for iter_30_0, iter_30_1 in pairs(self.customAffixList) do
		if iter_30_1 then
			iter_30_1:Dispose()

			iter_30_1 = nil
		end
	end

	if self.multipleAffixItem then
		self.multipleAffixItem:Dispose()

		self.multipleAffixItem = nil
	end
end

return AdvanceMonsterAffixView
