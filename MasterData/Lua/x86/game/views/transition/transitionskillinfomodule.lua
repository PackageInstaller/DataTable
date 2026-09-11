local TransitionSkillSlotsModule = class("TransitionSkillSlotsModule", ReduxView)

function TransitionSkillSlotsModule:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function TransitionSkillSlotsModule:Init()
	self:InitUI()
	self:AddUIListeners()
end

function TransitionSkillSlotsModule:InitUI()
	self:BindCfgUI()

	self.lvupBtnTxt_.text = GetTips("TEXT_UPGRADE")

	self:BuildContext()
end

function TransitionSkillSlotsModule:BuildContext()
	self.controller = {
		comps = self.controller_,
		btnState = {
			MaxLevel = "maxLevel",
			name = "btnState",
			Equip = "equip",
			Exchange = "exchange",
			comps = self.controller_:GetController("btnState")
		}
	}
	self.constVar = {}
	self.data = {
		level = 0,
		skillID = 0,
		equipped = false,
		heroID = 0
	}
end

function TransitionSkillSlotsModule:InitContext()
	self.data = {
		level = 0,
		skillID = 0,
		equipped = false,
		heroID = 0
	}
end

function TransitionSkillSlotsModule:AddUIListeners()
	self:AddBtnListener(self.equipBtn_, nil, function()
		self:OnEquipBtnClick()
	end)
	self:AddBtnListener(self.exchangeBtn_, nil, function()
		self:OnExchangeBtnClick()
	end)
	self:AddBtnListener(self.levelUpBtn_, nil, function()
		self:OnLevelUpBtnClick()
	end)
	TerminologyTools.AddTerminologyHandler(self, self.chipEffectTxt_, nil, nil)
end

function TransitionSkillSlotsModule:Dispose()
	self:RemoveAllListeners()
	TransitionSkillSlotsModule.super.Dispose(self)
end

function TransitionSkillSlotsModule:RenderView(arg_11_1)
	self:InitContext()

	self.data.heroID = arg_11_1.heroID
	self.data.level = arg_11_1.level
	self.data.skillID = arg_11_1.skillID
	self.data.equipped = arg_11_1.equipped
	self.data.pos = arg_11_1.pos

	local var_11_0 = EquipSkillCfg[self.data.skillID].lvmax
	local var_11_1 = 1

	self.skillNameTxt_.text = GetI18NText(EquipSkillCfg[self.data.skillID].name)
	self.skillIconImg_.sprite = getEquipSkillSprite(self.data.skillID)

	if self.data.equipped then
		var_11_1 = self.data.level
		self.skillStatusTxt_.text = GetTips("LEVEL") .. self.data.level

		if var_11_1 < var_11_0 then
			self.controller.btnState.comps:SetSelectedState(self.controller.btnState.Exchange)
		else
			self.controller.btnState.comps:SetSelectedState(self.controller.btnState.MaxLevel)
		end
	else
		self.skillStatusTxt_.text = GetTips("JUMP_EQUIP_NONE_STATUS")

		self.controller.btnState.comps:SetSelectedState(self.controller.btnState.Equip)
	end

	self.chipEffectTxt_.text = EquipTools.GetSkillDescWithoutNext(self.data.skillID, var_11_1, self.data.heroID)

	if var_11_1 < var_11_0 then
		SetActive(self.nextEffectObj_, true)

		self.nextEffectTxt_.text = EquipTools.GetSkillDescWithoutNext(self.data.skillID, var_11_1 + 1, self.data.heroID)
	else
		SetActive(self.nextEffectObj_, false)
	end
end

function TransitionSkillSlotsModule:RegisterEquipBtnClickEmitter(arg_12_1)
	self.constVar.onEquipEmitter = arg_12_1
end

function TransitionSkillSlotsModule:RegisterExchangeBtnClickEmitter(arg_13_1)
	self.constVar.onExchangeEmitter = arg_13_1
end

function TransitionSkillSlotsModule:RegisterLevelUpBtnClickEmitter(arg_14_1)
	self.constVar.onLevelUpEmitter = arg_14_1
end

function TransitionSkillSlotsModule:OnEquipBtnClick()
	if self.constVar.onEquipEmitter then
		self.constVar.onEquipEmitter()
	end
end

function TransitionSkillSlotsModule:OnExchangeBtnClick()
	if self.constVar.onExchangeEmitter then
		self.constVar.onExchangeEmitter()
	end
end

function TransitionSkillSlotsModule:OnLevelUpBtnClick()
	if self.constVar.onLevelUpEmitter then
		self.constVar.onLevelUpEmitter()
	end
end

return TransitionSkillSlotsModule
