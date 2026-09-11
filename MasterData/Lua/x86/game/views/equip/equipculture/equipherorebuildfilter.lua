HeroListFilterView = import("game.views.newHero.HeroListFilterView")

local EquipHeroRebuildFilter = class("EquipHeroRebuildFilter", HeroListFilterView)

function EquipHeroRebuildFilter:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function EquipHeroRebuildFilter:InitUI()
	self:BindCfgUI()

	self.heroSorter_ = HeroSorter.New()
end

function EquipHeroRebuildFilter:AddUIListener()
	return
end

return EquipHeroRebuildFilter
