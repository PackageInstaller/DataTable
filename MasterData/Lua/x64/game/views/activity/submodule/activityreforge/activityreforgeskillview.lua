local ActivityReforgeSkillView = class("ActivityReforgeSkillView", ReduxView)
local var_0_1 = "D46068"
local var_0_2 = {
	USE = 2,
	ILLUSTRATED = 1
}
local var_0_3 = {
	PASSIVE = 2,
	INITIATIVE = 1
}

function ActivityReforgeSkillView:UIName()
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeSkillUI"
end

function ActivityReforgeSkillView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityReforgeSkillView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityReforgeSkillView:InitUI()
	self:BindCfgUI()

	self.initiativeSkillList_ = {
		{},
		{},
		{},
		{}
	}
	self.passiveSkillList_ = {}

	for iter_4_0, iter_4_1 in pairs(ActivityReforgeSkillCfg.all) do
		if ActivityReforgeSkillCfg[iter_4_1].type == 1 then
			table.insert(self.initiativeSkillList_[ActivityReforgeSkillCfg[iter_4_1].slot], iter_4_1)
		else
			table.insert(self.passiveSkillList_, iter_4_1)
		end
	end

	self.viewStatusController_ = self.controllerEx_:GetController("viewStatus")
	self.curSkillStatusController_ = self.controllerEx_:GetController("curSkillStatus")
	self.skillStatusController_ = self.controllerEx_:GetController("skillStatus")
	self.initiativeList_ = {}

	for iter_4_2 = 1, 4 do
		self.initiativeList_[iter_4_2] = ActivityReforgeInitiativeSkillItem.New(self["initiativeSkillListGo" .. iter_4_2 .. "_"])
	end

	self.passiveList_ = {}

	for iter_4_3 = 1, 1 do
		self.passiveList_[iter_4_3] = ActivityReforgePassiveSkillItem.New(self["passiveSkillListGo" .. iter_4_3 .. "_"])
	end

	self.itemSelectHandler_ = handler(self, self.OnItemSelect)
end

function ActivityReforgeSkillView:OnItemSelect(arg_5_1)
	self.skillID_ = arg_5_1
	self.curViewStatus_ = ActivityReforgeSkillCfg[self.skillID_].type == 1 and var_0_3.INITIATIVE or var_0_3.PASSIVE

	self:RefreshUI()
end

function ActivityReforgeSkillView:AddUIListeners()
	self:AddBtnListener(self.toggleBtn_, nil, function()
		if self.curViewStatus_ == var_0_3.INITIATIVE then
			self.curViewStatus_ = var_0_3.PASSIVE
			self.skillID_ = self.passiveSkillList_[1]
		elseif self.curViewStatus_ == var_0_3.PASSIVE then
			self.curViewStatus_ = var_0_3.INITIATIVE
			self.skillID_ = self.initiativeSkillList_[1][1]
		end

		self:RefreshUI()
	end)
	self:AddBtnListener(self.buyBtn_, nil, function()
		ActivityReforgeAction.BuySkill(self.chapterActivityID_, self.levelID_, self.skillID_, function()
			ActivityReforgeAction.SelectSkill(self.chapterActivityID_, self.levelID_, self.skillID_, function()
				ShowTips("ACTIVITY_REFORGE_BUY_SKILL")
			end)
		end)
	end)
	self:AddBtnListener(self.useBtn_, nil, function()
		ActivityReforgeAction.SelectSkill(self.chapterActivityID_, self.levelID_, self.skillID_, function()
			ShowTips("ACTIVITY_REFORGE_USE_SKILL")
		end)
	end)
	self:AddBtnListener(self.unUsebtn_, nil, function()
		ActivityReforgeAction.UnSelectSkill(self.chapterActivityID_, self.levelID_, self.skillID_)
	end)
	self:AddBtnListener(self.panelUseBtn_, nil, function()
		ActivityReforgeAction.SelectSkill(self.chapterActivityID_, self.levelID_, self.skillID_)
	end)
	self:AddBtnListener(self.panelUnUseBtn_, nil, function()
		ActivityReforgeAction.UnSelectSkill(self.chapterActivityID_, self.levelID_, self.skillID_)
	end)
	self:AddBtnListener(self.panelSellBtn_, nil, function()
		ActivityReforgeAction.SellSkill(self.chapterActivityID_, self.levelID_, self.skillID_)
	end)
end

function ActivityReforgeSkillView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.chapterActivityID_ = self.params_.chapterActivityID
	self.levelID_ = self.params_.levelID
	self.viewType_ = self.params_.viewType

	if self.viewType_ == var_0_2.ILLUSTRATED then
		self.curViewStatus_ = var_0_3.INITIATIVE
		self.skillID_ = self.initiativeSkillList_[1][1]
	else
		self:InitEnterSelectSkill()
	end

	self:RefreshUI()
end

function ActivityReforgeSkillView:OnTop()
	if self.viewType_ == var_0_2.USE then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_ACTIVITY_REFORGE
		})
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function ActivityReforgeSkillView:OnExit()
	for iter_19_0 = 1, 4 do
		self.initiativeList_[iter_19_0]:OnExit()
	end

	for iter_19_1 = 1, 1 do
		self.passiveList_[iter_19_1]:OnExit()
	end

	manager.windowBar:HideBar()
end

function ActivityReforgeSkillView:InitEnterSelectSkill()
	if self.params_.skillID ~= nil and self.params_.skillID ~= 0 then
		self.skillID_ = self.params_.skillID
		self.curViewStatus_ = ActivityReforgeSkillCfg[self.skillID_].type == 1 and var_0_3.INITIATIVE or var_0_3.PASSIVE
	elseif self.params_.slot_ and self.params_.viewStatus then
		if self.params_.viewStatus == var_0_3.INITIATIVE then
			if self.params_.slot_ < 1 or self.params_.slot_ > 4 then
				self.params_.slot_ = 1
			end

			self.skillID_ = self.initiativeSkillList_[self.params_.slot_][1]
		else
			self.skillID_ = self.passiveSkillList_[1]
		end
	elseif self.params_.viewStatus then
		self.curViewStatus_ = self.params_.viewStatus
		self.skillID_ = self.params_.viewStatus == var_0_3.INITIATIVE and self.initiativeSkillList_[1][1] or self.passiveSkillList_[1]
	end
end

function ActivityReforgeSkillView:RefreshUI()
	if self.curViewStatus_ == var_0_3.INITIATIVE then
		self.viewStatusController_:SetSelectedState("initiative")

		for iter_21_0 = 1, 4 do
			self.initiativeList_[iter_21_0]:SetData(self.viewType_, self.initiativeSkillList_[iter_21_0], self.itemSelectHandler_, self.activityID_, self.levelID_, iter_21_0, self.skillID_)
		end

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.initiativeSkillContentTrans_)
	else
		self.viewStatusController_:SetSelectedState("passive")

		for iter_21_1 = 1, 1 do
			self.passiveList_[iter_21_1]:SetData(self.viewType_, self.passiveSkillList_, self.itemSelectHandler_, self.activityID_, self.levelID_, self.skillID_)
		end

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.passiveSkillContentTrans_)
	end

	local var_21_0 = ActivityReforgeSkillCfg[self.skillID_]

	if self.viewType_ == var_0_2.ILLUSTRATED then
		if ActivityReforgeData:GetSkillIsLock(self.activityID_, self.skillID_) then
			self.curSkillStatusController_:SetSelectedState("lock")

			self.lockDesText_.text = var_21_0.lock_des
		else
			self.skillImage_.sprite = getSprite("Atlas/ValhallaSkillAtlas", var_21_0.icon)
			self.skillBgImage_.sprite = getSprite("Atlas/ValhallaSkillAtlas", var_21_0.bg_name)
			self.skillName_.text = var_21_0.name
			self.buffText_.text = var_21_0.desc_effect
			self.debuffText_.text = var_21_0.desc_negative
			self.skillDesText_.text = var_21_0.desc_background
			self.costText_.text = var_21_0.cost

			if var_21_0.count == -1 then
				self.curSkillStatusController_:SetSelectedState("illustratedFreeNormal")
			else
				self.curSkillStatusController_:SetSelectedState("illustratedNormal")
				self.skillStatusController_:SetSelectedState("useNum" .. var_21_0.count)

				for iter_21_2 = 1, 3 do
					SetActive(self["useNumGo" .. iter_21_2 .. "_"], true)
				end
			end
		end
	else
		self.skillStatus_, self.skillCanUseNum_ = ActivityReforgeData:GetSkillStatus(self.activityID_, self.levelID_, self.skillID_)

		self.curSkillStatusController_:SetSelectedState(self.skillStatus_)

		if self.skillStatus_ == "lock" then
			self.lockDesText_.text = var_21_0.lock_des
		end

		if self.skillStatus_ == "freeUsing" or self.skillStatus_ == "freeNormal" or self.skillStatus_ == "haveNot" or self.skillStatus_ == "using" or self.skillStatus_ == "haveNotFree" or self.skillStatus_ == "infiniteUsing" or self.skillStatus_ == "infiniteNormal" or self.skillStatus_ == "normal" then
			self.skillImage_.sprite = getSprite("Atlas/ValhallaSkillAtlas", var_21_0.icon)
			self.skillBgImage_.sprite = getSprite("Atlas/ValhallaSkillAtlas", var_21_0.bg_name)
			self.skillName_.text = var_21_0.name
			self.buffText_.text = var_21_0.desc_effect
			self.debuffText_.text = var_21_0.desc_negative
			self.skillDesText_.text = var_21_0.desc_background
			self.costText_.text = ActivityReforgeAction.CheckGold(var_21_0.cost, false) and var_21_0.cost or "<color=#" .. var_0_1 .. ">" .. var_21_0.cost .. "</color>"
		end

		if self.skillStatus_ == "haveNot" or self.skillStatus_ == "using" or self.skillStatus_ == "normal" then
			self.skillStatusController_:SetSelectedState("useNum" .. var_21_0.count)

			for iter_21_3 = 1, 3 do
				if iter_21_3 <= self.skillCanUseNum_ then
					SetActive(self["useNumGo" .. iter_21_3 .. "_"], true)
				else
					SetActive(self["useNumGo" .. iter_21_3 .. "_"], false)
				end
			end
		end
	end
end

function ActivityReforgeSkillView:OnActivityReforgeCurLevelUpdate()
	self:RefreshUI()

	if self.viewType_ == var_0_2.USE then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_ACTIVITY_REFORGE
		})
	end
end

function ActivityReforgeSkillView:Dispose()
	for iter_23_0, iter_23_1 in pairs(self.initiativeList_) do
		self.initiativeList_[iter_23_0]:Dispose()

		self.initiativeList_[iter_23_0] = nil
	end

	self.initiativeList_ = nil

	for iter_23_2, iter_23_3 in pairs(self.passiveList_) do
		self.passiveList_[iter_23_2]:Dispose()

		self.passiveList_[iter_23_2] = nil
	end

	self.passiveList_ = nil
	self.itemSelectHandler_ = nil

	self.super.Dispose(self)
end

return ActivityReforgeSkillView
