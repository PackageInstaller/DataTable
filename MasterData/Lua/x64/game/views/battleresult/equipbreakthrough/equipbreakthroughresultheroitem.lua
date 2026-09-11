local EquipBrealThroughResultHeroItem = class("EquipBrealThroughResultHeroItem", ReduxView)

function EquipBrealThroughResultHeroItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index_ = arg_1_2

	self:BindCfgUI()
end

function EquipBrealThroughResultHeroItem:SetData(arg_2_1)
	self.stageData_ = arg_2_1

	self:RefreshUI()
end

function EquipBrealThroughResultHeroItem:OnExit()
	return
end

function EquipBrealThroughResultHeroItem:Dispose()
	EquipBrealThroughResultHeroItem.super.Dispose(self)
end

function EquipBrealThroughResultHeroItem:RefreshUI()
	local var_5_0 = self.stageData_:GetHeroTeam()
	local var_5_1 = self.stageData_:GetSystemHeroTeam()

	if var_5_0[self.index_] == nil or var_5_0[self.index_] == 0 then
		SetActive(self.gameObject_, false)

		return
	end

	SetActive(self.gameObject_, true)

	self.icon_.sprite = getSpriteViaConfig("HeroIcon", HeroTools.HeroUsingSkinInfo(var_5_0[self.index_]).picture_id)
	self.lvText_.text = HeroData:GetHeroData(var_5_0[self.index_]).level

	local var_5_2 = EquipBreakThroughMaterialData:GetHeroState()[self.index_] and EquipBreakThroughMaterialData:GetHeroState()[self.index_].rate or 10000

	self.slider_.value = var_5_2 / 10000

	local var_5_3 = math.ceil(var_5_2 / 100)

	if var_5_2 > 0 and var_5_3 < 1 then
		var_5_3 = 1
	end

	self.rateText_.text = string.format("%s%%", var_5_3)
end

return EquipBrealThroughResultHeroItem
