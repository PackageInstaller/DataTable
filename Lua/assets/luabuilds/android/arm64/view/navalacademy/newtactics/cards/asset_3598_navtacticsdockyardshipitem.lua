local NavTacticsDockyardShipItem = class("NavTacticsDockyardShipItem", import("view.ship.DockyardShipItem"))

function NavTacticsDockyardShipItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	NavTacticsDockyardShipItem.super.Ctor(self, arg_1_1, arg_1_2, arg_1_3)

	self.empty = findTF(self.tr, "empty")
	self.recentTr = findTF(self.tr, "recent")

	setText(self.recentTr:Find("Text"), i18n("tactics_recent_ship_label"))

	return
end

function NavTacticsDockyardShipItem:flush()
	NavTacticsDockyardShipItem.super.flush(self)
	setActive(self.empty, not tobool(self.shipVO))
	setActive(self.quit, false)
	setActive(self.recentTr, false)
	setActive(self.iconStatus, false)

	return
end

function NavTacticsDockyardShipItem:clear()
	NavTacticsDockyardShipItem.super.clear(self)
	setActive(self.recentTr, false)

	return
end

return NavTacticsDockyardShipItem
