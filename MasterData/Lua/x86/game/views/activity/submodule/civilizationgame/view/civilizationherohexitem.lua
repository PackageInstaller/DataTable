local CivilizationHeroHexItem = class("CivilizationHeroHexItem", ReduxView)

function CivilizationHeroHexItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CivilizationHeroHexItem:Init()
	self:InitUI()
end

function CivilizationHeroHexItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.mainControllerEx_:GetController("state")
	self.selectController_ = self.mainControllerEx_:GetController("select")
end

function CivilizationHeroHexItem:SetData(arg_4_1)
	self.hexID_ = arg_4_1

	self:UpdateView()
end

function CivilizationHeroHexItem:UpdateView()
	self.img_.sprite = getSpriteViaConfig("CivilizationGame", ActivityCivilizationFactorCfg[self.hexID_].icon)
	self.descText_.text = ActivityCivilizationFactorCfg[self.hexID_].description

	if CivilizationGameTools.GetTechUnlock(self.hexID_) then
		self.stateController_:SetSelectedState("on")
	else
		self.stateController_:SetSelectedState("off")
	end

	if CivilizationGameTools.GetTechSelect(self.hexID_) then
		self.selectController_:SetSelectedState("on")
	else
		self.selectController_:SetSelectedState("off")
	end
end

function CivilizationHeroHexItem:Dispose()
	CivilizationHeroHexItem.super.Dispose(self)
end

return CivilizationHeroHexItem
