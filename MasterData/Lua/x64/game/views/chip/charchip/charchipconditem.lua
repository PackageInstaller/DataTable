local CharChipCondItem = class("CharChipCondItem", ReduxView)

function CharChipCondItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.clearController_ = self.conEx_:GetController("clear")
end

function CharChipCondItem:AddListeners()
	return
end

function CharChipCondItem:SetData(arg_3_1)
	self.conditionID_ = arg_3_1

	self:RefreshUI()
end

function CharChipCondItem:RefreshUI()
	self.gameObject_.name = self.conditionID_

	if not ConditionCfg[self.conditionID_] then
		Debug.LogError("没有找到条件: id=" .. self.conditionID_)
	end

	self.desc_.text = ConditionCfg[self.conditionID_].desc

	local var_4_0, var_4_1, var_4_2 = IsConditionAchieved(self.conditionID_)

	self.prog_.text = GetConditionProgressText(self.conditionID_, var_4_1, var_4_2)

	self.clearController_:SetSelectedState(var_4_0 and "clear" or "notclear")
end

function CharChipCondItem:Dispose()
	CharChipCondItem.super.Dispose(self)
end

return CharChipCondItem
