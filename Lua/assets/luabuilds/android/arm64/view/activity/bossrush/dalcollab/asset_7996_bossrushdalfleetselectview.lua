local BossRushDALFleetSelectView = class("BossRushDALFleetSelectView", import("..BossRushFleetSelectView"))

function BossRushDALFleetSelectView:getUIName()
	return "BossRushFleetSelectUIDALCollab"
end

function BossRushDALFleetSelectView:InitUI()
	BossRushDALFleetSelectView.super.InitUI(self)
	setText(self._tf:Find("Panel/Info/Start/text"), i18n("dal_chapter_goto"))

	return
end

return BossRushDALFleetSelectView
