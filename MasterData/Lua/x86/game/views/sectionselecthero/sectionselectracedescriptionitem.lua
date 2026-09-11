local SectionSelectRaceDescriptionItem = class("SectionSelectRaceDescriptionItem", ReduxView)

function SectionSelectRaceDescriptionItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SectionSelectRaceDescriptionItem:Init()
	self:InitUI()
end

function SectionSelectRaceDescriptionItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.controllerExCollection_:GetController("stage")
end

function SectionSelectRaceDescriptionItem:SetData(arg_4_1, arg_4_2, arg_4_3)
	self.raceID_ = arg_4_1
	self.isActive_ = arg_4_2
	self.sameCamp_ = arg_4_3
	self.raceIcon_.sprite = HeroTools.GetRaceIcon(self.raceID_)
	self.raceName_.text = RaceEffectCfg[self.raceID_].name
	self.battleDesc_.text = RaceEffectCfg[self.raceID_].battle_desc
	self.desc_.text = RaceEffectCfg[self.raceID_].desc

	if self.isActive_ then
		if self.sameCamp_ then
			self.stateController_:SetSelectedState("max")
		else
			self.stateController_:SetSelectedState("active")
		end
	else
		self.stateController_:SetSelectedState("none")
	end
end

return SectionSelectRaceDescriptionItem
