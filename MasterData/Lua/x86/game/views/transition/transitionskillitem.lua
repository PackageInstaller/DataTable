local TransitionSkillItem = class("TransitionSkillItem", ReduxView)

function TransitionSkillItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function TransitionSkillItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function TransitionSkillItem:InitUI()
	self:BindCfgUI()

	local var_3_0 = self.gameObject_:GetComponent("ControllerExCollection")

	self.selectController = var_3_0:GetController("sel")
	self.useController = var_3_0:GetController("use")
	self.lvController = var_3_0:GetController("lv")
	self.recommandContorller = var_3_0:GetController("good")
end

function TransitionSkillItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickFunc_ then
			self.clickFunc_(self.skillID_)
		end
	end)
end

function TransitionSkillItem:OnEnter()
	return
end

function TransitionSkillItem:RefreshUI(arg_7_1, arg_7_2)
	self:SetLevel(arg_7_2)

	self.level_ = arg_7_2
	self.skillID_ = arg_7_1
	self.cfg_ = EquipSkillCfg[self.skillID_]
	self.icon_.sprite = getEquipSkillSprite(self.skillID_)
	self.levelTxt_.text = GetTips("LEVEL") .. self.level_
	self.name_.text = GetI18NText(self.cfg_.name)
end

function TransitionSkillItem:SetUsed(arg_8_1)
	self.useController:SetSelectedState(arg_8_1 and "state1" or "state0")
end

function TransitionSkillItem:SetSelect(arg_9_1)
	self.selectController:SetSelectedState(arg_9_1 and "state1" or "state0")
end

function TransitionSkillItem:SetLevel(arg_10_1)
	self.selectController:SetSelectedState(arg_10_1 == 0 and "state1" or "state0")
end

function TransitionSkillItem:SetRecommand(arg_11_1)
	if arg_11_1 then
		self.recommandContorller:SetSelectedState("state1")
	else
		self.recommandContorller:SetSelectedState("state0")
	end
end

function TransitionSkillItem:RegistCallBack(arg_12_1)
	self.clickFunc_ = arg_12_1
end

function TransitionSkillItem:OnExit()
	return
end

function TransitionSkillItem:Dispose()
	self:RemoveAllListeners()
	TransitionSkillItem.super.Dispose(self)
end

return TransitionSkillItem
