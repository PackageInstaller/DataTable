local EquipSeizureAffixItem = class("EquipSeizureAffixItem", ReduxView)

function EquipSeizureAffixItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	SetActive(self.gameObject_, true)
end

function EquipSeizureAffixItem:SetData(arg_2_1)
	self.affixID_ = arg_2_1

	self:RefreshUI()
end

function EquipSeizureAffixItem:Dispose()
	EquipSeizureAffixItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function EquipSeizureAffixItem:RefreshUI()
	self.nameText_.text = ActivityAffixPoolCfg[self.affixID_].name
	self.descText_.text = getAffixDesc(ActivityAffixPoolCfg[self.affixID_].affix)
	self.iconImage_.sprite = getAffixSprite(ActivityAffixPoolCfg[self.affixID_].affix)
end

return EquipSeizureAffixItem
