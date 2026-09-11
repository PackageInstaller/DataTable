local ActivityReforgeInitiativeSkillItem = class("ActivityReforgeInitiativeSkillItem", ReduxView)

function ActivityReforgeInitiativeSkillItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ActivityReforgeInitiativeSkillItem:Init()
	self:InitUI()
end

function ActivityReforgeInitiativeSkillItem:InitUI()
	self:BindCfgUI()

	self.skillItemList_ = {}
end

function ActivityReforgeInitiativeSkillItem:SetData(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6, arg_4_7)
	self.viewType_ = arg_4_1
	self.skillList_ = arg_4_2
	self.itemSelectHandler_ = arg_4_3
	self.activityID_ = arg_4_4
	self.levelID_ = arg_4_5
	self.curSkillID_ = arg_4_7
	self.slotText_.text = string.format(GetTips("ACTIVITY_REFORGE_SLOT"), arg_4_6)
	self.slotNumText_.text = string.format(GetTips("ACTIVITY_REFORGE_USE_MAX"), ActivityReforgeData:GetInitiativeSkillUseNum(arg_4_6) .. "/1")

	for iter_4_0, iter_4_1 in pairs(self.skillList_) do
		if self.skillItemList_[iter_4_0] == nil then
			self.skillItemList_[iter_4_0] = ActivityReforgeSkillItem.New((Object.Instantiate(self.itemGo_, self.contentTrans_)))
		end

		self.skillItemList_[iter_4_0]:SetIsActive(true)
		self.skillItemList_[iter_4_0]:SetData(self.viewType_, self.skillList_[iter_4_0], self.itemSelectHandler_, self.activityID_, self.levelID_, self.curSkillID_)
	end

	for iter_4_2 = #self.skillList_ + 1, #self.skillItemList_ do
		self.skillItemList_[iter_4_2]:SetIsActive(false)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrans_)
end

function ActivityReforgeInitiativeSkillItem:OnExit()
	for iter_5_0, iter_5_1 in pairs(self.skillItemList_) do
		iter_5_1:OnExit()
	end
end

function ActivityReforgeInitiativeSkillItem:Dispose()
	for iter_6_0, iter_6_1 in pairs(self.skillItemList_) do
		self.skillItemList_[iter_6_0]:Dispose()

		self.skillItemList_[iter_6_0] = nil
	end

	self.clickHandle_ = nil

	ActivityReforgeInitiativeSkillItem.super.Dispose(self)
end

return ActivityReforgeInitiativeSkillItem
