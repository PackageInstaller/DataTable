local IslandAutoCollectHelper = class("IslandAutoCollectHelper")

IslandAutoCollectHelper.SelectType = {
	Gather = 3,
	HandCollection = 2,
	Both = 4,
	None = 1
}
IslandAutoCollectHelper.CostTipList = {
	i18n("island_chara_gather_power"),
	i18n("island_chara_gather_money")
}

function IslandAutoCollectHelper:GetAttributeReducePercent()
	return pg.island_chara_att[IslandProductTimeHelper.GetAttributeGradeId(self, IslandShipAttr.COLLECT_KEY)].gather_effect
end

return IslandAutoCollectHelper
