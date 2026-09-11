local SoloChallengeBossInfoItem = class("SoloChallengeBossInfoItem", (import("game.views.IllustratedHandleBook.IlluEnemyFiles.IlluEnemyFileDetailItem")))

function SoloChallengeBossInfoItem:InitUI()
	self:BindCfgUI()
end

function SoloChallengeBossInfoItem:RefreshUI(arg_2_1)
	SetActive(self.gameObject_, true)

	self.titleText_.text = GetI18NText(arg_2_1.name)
	self.descText_.text = GetI18NText(arg_2_1.info)

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
end

return SoloChallengeBossInfoItem
