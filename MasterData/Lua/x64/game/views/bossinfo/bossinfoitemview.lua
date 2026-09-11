local BossInfoItemView = class("BossInfoItemView", (import("game.views.IllustratedHandleBook.IlluEnemyFiles.IlluEnemyFileDetailItem")))

function BossInfoItemView:InitUI()
	self:BindCfgUI()
end

function BossInfoItemView:RefreshUI(arg_2_1)
	SetActive(self.gameObject_, true)

	self.titleText_.text = GetI18NText(arg_2_1.name)
	self.descText_.text = GetI18NText(arg_2_1.info)

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
end

return BossInfoItemView
