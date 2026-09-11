local CivilizationSkillChooseItem = class("CivilizationSkillChooseItem", ReduxView)

function CivilizationSkillChooseItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CivilizationSkillChooseItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function CivilizationSkillChooseItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = self.mainControllerEx_:GetController("select")
	self.cardController_ = self.mainControllerEx_:GetController("card")
	self.lockController_ = self.mainControllerEx_:GetController("lock")
end

function CivilizationSkillChooseItem:AddUIListener()
	self:AddBtnListener(self.selfBtn_, nil, function()
		if self.callback_ then
			self.callback_(self.ID_)
		end
	end)
end

function CivilizationSkillChooseItem:SetData(arg_6_1, arg_6_2, arg_6_3)
	self.type_ = arg_6_1
	self.ID_ = arg_6_2
	self.callback_ = arg_6_3

	self:UpdateView()
end

function CivilizationSkillChooseItem:UpdateView()
	if self.type_ == 1 then
		self.cardController_:SetSelectedState("grid")

		self.gridImg_.sprite = getSpriteViaConfig("CivilizationGame", ActivityCivilizationIlluCfg[self.ID_].picture)
	elseif self.type_ == 4 then
		self.cardController_:SetSelectedState("skill")

		self.techImg_.sprite = getSpriteViaConfig("CivilizationGame", ActivityCivilizationIlluCfg[self.ID_].picture)
	else
		self.cardController_:SetSelectedState("hex")

		self.hexImg_.sprite = getSpriteViaConfig("CivilizationGame", ActivityCivilizationIlluCfg[self.ID_].picture)
	end

	if table.indexof(CivilizationGameData:GetDataByPara("illu_list"), self.ID_) then
		self.lockController_:SetSelectedState("off")
	else
		self.lockController_:SetSelectedState("on")
	end
end

function CivilizationSkillChooseItem:GetID()
	return self.ID_
end

function CivilizationSkillChooseItem:SetActive(arg_9_1)
	SetActive(self.gameObject_, arg_9_1)
end

function CivilizationSkillChooseItem:SetSelect(arg_10_1)
	self.selectController_:SetSelectedState(arg_10_1 and "on" or "off")
end

function CivilizationSkillChooseItem:Dispose()
	CivilizationSkillChooseItem.super.Dispose(self)
end

return CivilizationSkillChooseItem
