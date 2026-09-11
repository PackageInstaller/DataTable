local ActivityRaceAffixResultItem = class("ActivityRaceAffixResultItem", ReduxView)

function ActivityRaceAffixResultItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	SetActive(self.gameObject_, true)
	self:Init()
end

function ActivityRaceAffixResultItem:Init()
	self:InitUI()
end

function ActivityRaceAffixResultItem:InitUI()
	self:BindCfgUI()
end

function ActivityRaceAffixResultItem:SetData(arg_4_1)
	self.affixID_ = arg_4_1

	if self.affixID_ then
		if PublicBuffCfg[AffixTypeCfg[self.affixID_].affix_buff_id].icon == "" then
			-- block empty
		end

		self.icon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.AffixIcon.path .. PublicBuffCfg[AffixTypeCfg[self.affixID_].affix_buff_id].icon)
		self.name_.text = GetI18NText(AffixTypeCfg[self.affixID_].name)
	end
end

return ActivityRaceAffixResultItem
