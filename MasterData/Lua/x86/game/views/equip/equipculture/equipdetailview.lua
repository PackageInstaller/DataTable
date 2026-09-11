local EquipDetailView = class("EquipDetailView", EquipBaseView)

function EquipDetailView:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform
	self.params_ = arg_1_3

	self:Init()
end

function EquipDetailView:Init()
	self:InitUI()
	EquipDetailView.super.Init(self)

	self.equipInfoView = EquipInfoView.New(self.equipInfoGo_)

	self.equipInfoView:RegisterSkillClick(handler(self, self.SkillClick))
	self.equipInfoView:RegisterChange(handler(self, self.HidePop))
end

function EquipDetailView:InitUI()
	self:BindCfgUI()
	self:AddUIListener()
end

function EquipDetailView:AddUIListener()
	self:AddBtnListener(self.btnSource_, nil, function()
		ShowPopItemSource(self.equip_.prefab_id)
	end)
end

function EquipDetailView:RegistHeroButton(arg_6_1, arg_6_2)
	self.changeFunc_ = arg_6_1
	self.cultureFunc_ = arg_6_2
end

function EquipDetailView:OnEnter()
	self.heroViewProxy_ = self.params_.proxy or HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)

	self.equipInfoView:OnEnter(self.heroViewProxy_)
	self:OnEquipChange(self.params_.equipId)
end

function EquipDetailView:OnEquipChange(arg_8_1)
	SetActive(self.equipInfoGo_, false)

	self.equipId = arg_8_1
	self.equip_ = EquipData:GetEquipData(self.equipId) or EquipStruct.New(0, self.params_.prefabId)

	self.equipInfoView:RefreshData(self, self.equip_, nil, self.params_.heroId, arg_8_1)
	SetActive(self.equipInfoGo_, true)
end

function EquipDetailView:SkillClick(arg_9_1, arg_9_2)
	if self.handler_.RefreshSkillInfo then
		self.handler_:RefreshSkillInfo(arg_9_1, arg_9_2)
	end
end

function EquipDetailView:HidePop()
	if self.handler_.HidePop then
		self.handler_:HidePop()
	end
end

function EquipDetailView:OnExit()
	return
end

function EquipDetailView:Dispose()
	self.equipInfoView:Dispose()
	EquipDetailView.super.Dispose(self)
end

return EquipDetailView
