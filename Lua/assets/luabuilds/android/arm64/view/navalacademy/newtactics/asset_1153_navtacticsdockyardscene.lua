local NavTacticsDockyardScene = class("NavTacticsDockyardScene", import("view.ship.DockyardScene"))
local var_0_1 = 7

function NavTacticsDockyardScene:init()
	NavTacticsDockyardScene.super.init(self)

	self.toggleTr = self._tf:Find("blur_panel/adapt/left_length/frame/toggle_nav")
	self.toggleOnTr = self.toggleTr:Find("on")
	self.toggleOffTr = self.toggleTr:Find("off")

	setActive(self.toggleTr, true)

	return
end

function NavTacticsDockyardScene:didEnter()
	NavTacticsDockyardScene.super.didEnter(self)

	local function var_2_0()
		setActive(self.toggleOnTr, self.isShowRecent)
		setActive(self.toggleOffTr, not self.isShowRecent)

		return
	end

	self.isShowRecent = false

	onButton(self, self.toggleTr, function()
		local var_4_0 = self:CollectionRecentShips()

		if #var_4_0 <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("tactics_no_recent_ships"))

			return
		end

		self.isShowRecent = not self.isShowRecent
		NavTacticsDockyardScene.ToggleOn = self.isShowRecent

		var_2_0()
		self:OnRecentShips(var_4_0)

		return
	end, SFX_PANEL)

	if (NavTacticsDockyardScene.ToggleOn and #self:CollectionRecentShips() == 0 or nil) and false then
		triggerButton(self.toggleTr)
	else
		local var_2_2 = self:CollectionRecentShips()

		var_2_0()
		self:OnRecentShips(var_2_2)
	end

	return
end

function NavTacticsDockyardScene:GetCard(arg_5_1)
	return NavTacticsDockyardShipItem.New(arg_5_1, self.contextData.hideTagFlags, self.contextData.blockTagFlags)
end

function NavTacticsDockyardScene:OnClickCard(arg_6_1)
	if arg_6_1.shipVO then
		NavTacticsDockyardScene.super.OnClickCard(self, arg_6_1)
	end

	return
end

function NavTacticsDockyardScene:onUpdateItem(arg_7_1, arg_7_2)
	NavTacticsDockyardScene.super.onUpdateItem(self, arg_7_1, arg_7_2)

	if self.isShowRecent and arg_7_1 + 1 <= var_0_1 then
		setActive(self.scrollItems[arg_7_2].recentTr, self.shipVOs[arg_7_1 + 1])
	end

	return
end

function NavTacticsDockyardScene:OnRecentShips(arg_8_1)
	self.recentShips = arg_8_1

	if #self.recentShips > 0 then
		self:filter()
	end

	return
end

function NavTacticsDockyardScene:updateShipCount(arg_9_1)
	if self.isShowRecent and #self.recentShips > 0 then
		for iter_9_0 = #self.recentShips + 1, var_0_1 do
			table.insert(self.shipVOs, 1, false)
		end

		for iter_9_1 = #self.recentShips, 1, -1 do
			table.insert(self.shipVOs, 1, self.recentShips[iter_9_1])
		end

		NavTacticsDockyardScene.super.updateShipCount(self, arg_9_1)
	else
		NavTacticsDockyardScene.super.updateShipCount(self, arg_9_1)
	end

	return
end

function NavTacticsDockyardScene:CollectionRecentShips()
	local var_10_0 = {}
	local var_10_1 = getProxy(NavalAcademyProxy):GetRecentShips()

	for iter_10_0 = #var_10_1, 1, -1 do
		if #var_10_0 == var_0_1 then
			break
		end

		local var_10_2 = tonumber(var_10_1[iter_10_0])

		if var_10_2 > 0 and self.shipVOsById[var_10_2] then
			table.insert(var_10_0, self.shipVOsById[var_10_2])
		end
	end

	return var_10_0
end

function NavTacticsDockyardScene:willExit()
	NavTacticsDockyardScene.super.willExit(self)
	setActive(self.toggleTr, false)

	return
end

return NavTacticsDockyardScene
