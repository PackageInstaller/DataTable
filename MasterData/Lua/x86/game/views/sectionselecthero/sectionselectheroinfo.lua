local SectionSelectHeroInfo = class("SectionSelectHeroInfo")

function SectionSelectHeroInfo:Ctor()
	self:Init()
end

function SectionSelectHeroInfo:Init()
	self.heroID = 0
	self.trialID = 0
	self.isPosLock = false
	self.isHeroLock = false
	self.heroDataType = HeroConst.HERO_DATA_TYPE.DEFAULT
	self.heroViewProxy = HeroViewDataProxy.New(self.heroDataType)
	self.isAssistant = false
	self.assistantInfo = {}
end

function SectionSelectHeroInfo:SetData(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self.heroID = arg_3_1 or 0
	self.trialID = arg_3_2 or 0

	self:SetPosLock(arg_3_3)
	self:SetHeroLock(arg_3_4)
end

function SectionSelectHeroInfo:SetHeroDataType(arg_4_1, arg_4_2)
	self.heroDataType = arg_4_1 or HeroConst.HERO_DATA_TYPE.DEFAULT
	self.heroViewProxy = arg_4_2 or HeroViewDataProxy.New(self.heroDataType)
end

function SectionSelectHeroInfo:SetAssistantInfo(arg_5_1, arg_5_2)
	self.isAssistant = arg_5_1 == true
	self.assistantInfo = arg_5_2
end

function SectionSelectHeroInfo:SetPosLock(arg_6_1)
	self.isPosLock = arg_6_1 or false
end

function SectionSelectHeroInfo:SetHeroLock(arg_7_1)
	self.isHeroLock = arg_7_1 or false
end

function SectionSelectHeroInfo:GetHeroPower()
	return self.heroViewProxy:GetBattlePower(self.heroID)
end

function SectionSelectHeroInfo:GetSkinCfg()
	return self.heroViewProxy:GetHeroUsingSkinInfo(self.heroID, {
		self.trialID
	})
end

function SectionSelectHeroInfo:IsHeroOath()
	return nullable(self.assistantInfo, "hero_oath_display", "oath") or self.heroViewProxy:IsHeroOath(self.heroID)
end

function SectionSelectHeroInfo:GetHeroHP(arg_11_1, arg_11_2, arg_11_3)
	return 1, 100
end

return SectionSelectHeroInfo
