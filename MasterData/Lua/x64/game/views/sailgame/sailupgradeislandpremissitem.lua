local SailUpgradeIslandPremissItem = class("SailUpgradeIslandPremissItem", ReduxView)

function SailUpgradeIslandPremissItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SailUpgradeIslandPremissItem:Init()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
end

function SailUpgradeIslandPremissItem:Dispose()
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil

	SailUpgradeIslandPremissItem.super.Dispose(self)
end

function SailUpgradeIslandPremissItem:SetActive(arg_4_1)
	SetActive(self.gameObject_, arg_4_1)
end

function SailUpgradeIslandPremissItem:SetData(arg_5_1, arg_5_2)
	self.ID_ = arg_5_1
	self.activityID_ = arg_5_2

	local var_5_0 = ConditionCfg[self.ID_]

	if ConditionCfg[self.ID_].type == 2508 then
		self.needNum_ = 1
		self.curNum_ = SailGameData:GetUnLockBuilding(self.activityID_)[var_5_0.params[1]] == true and 1 or 0
		self.descText_.text = string.format(ConditionCfg[self.ID_].desc, SailGameBuildingCfg[var_5_0.params[1]].name)
	elseif var_5_0.type == 2509 then
		self.needNum_ = var_5_0.params[1]
		self.curNum_ = SailGameData:GetCompleteSailTimes(self.activityID_)
		self.descText_.text = string.format(ConditionCfg[self.ID_].desc, var_5_0.params[1])
	end

	self.progressText_.text = string.format("%d/%d", self.curNum_, self.needNum_)

	self.statusController_:SetSelectedState(self.curNum_ >= self.needNum_ and "on" or "off")
	self:SetActive(true)
end

function SailUpgradeIslandPremissItem:IsComplete()
	return self.curNum_ >= self.needNum_
end

return SailUpgradeIslandPremissItem
