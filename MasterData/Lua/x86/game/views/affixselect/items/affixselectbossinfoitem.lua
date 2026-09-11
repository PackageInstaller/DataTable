local AffixSelectBossInfoItem = class("AffixSelectBossInfoItem", (import("game.views.IllustratedHandleBook.IlluEnemyFiles.IlluEnemyFileDetailItem")))

function AffixSelectBossInfoItem:InitUI()
	self:BindCfgUI()
end

function AffixSelectBossInfoItem:RefreshUI(arg_2_1)
	SetActive(self.gameObject_, true)

	self.titleText_.text = GetI18NText(arg_2_1.name)
	self.descText_.text = GetI18NText(arg_2_1.info)

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
end

function AffixSelectBossInfoItem:Dispose()
	AffixSelectBossInfoItem.super.Dispose(self)
end

return AffixSelectBossInfoItem
