local PlayerVitaeDockyardScene = class("PlayerVitaeDockyardScene", import("view.ship.DockyardScene"))

function PlayerVitaeDockyardScene:SortShips(arg_1_1)
	local var_1_0 = getProxy(PlayerProxy):getRawData().characters
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		var_1_1[iter_1_1] = #var_1_0 + 1 - iter_1_0
	end

	table.insert(arg_1_1, function(arg_2_0)
		return -(var_1_1[arg_2_0.id] or 0)
	end)
	table.sort(self.shipVOs, CompareFuncs(arg_1_1))

	return
end

function PlayerVitaeDockyardScene:init()
	PlayerVitaeDockyardScene.super.init(self)

	self.selectedMarks = {}

	for iter_3_0, iter_3_1 in ipairs(self.contextData.selectedMarks or {}) do
		local var_3_0, var_3_1 = ShipPhantom.UnpackMark(iter_3_1)

		if var_3_1 == 0 then
			table.insert(self.selectedIds, var_3_0)
		else
			table.insert(self.selectedMarks, iter_3_1)
		end
	end

	self.contextData.selectedMarks = nil

	setActive(self.togglePhantom, true)

	return
end

function PlayerVitaeDockyardScene:OnClickPhantom(arg_4_1)
	if arg_4_1.phantomId == 0 then
		self:selectShip(arg_4_1)
	else
		self:selectPhantom(arg_4_1)
	end

	return
end

function PlayerVitaeDockyardScene:selectPhantom(arg_5_1)
	local var_5_0 = arg_5_1:GetShipPhantomMark()
	local var_5_1 = false
	local var_5_2

	for iter_5_0, iter_5_1 in ipairs(self.selectedMarks) do
		if iter_5_1 == var_5_0 then
			var_5_1 = true
			var_5_2 = iter_5_0

			break
		end
	end

	if var_5_1 or self.selectedMax == 1 and self:GetSelectCount() > 0 then
		local var_5_3 = defaultValue(var_5_2, 1)
		local var_5_4, var_5_5 = self.onCancelShip(getProxy(BayProxy):GetShipPhantom(self.selectedMarks[var_5_3]), function()
			if not self.exited then
				return
			end

			self:selectPhantom(arg_5_1)

			return
		end, self.selectedMarks)

		if not var_5_4 then
			if var_5_5 then
				pg.TipsMgr.GetInstance():ShowTips(var_5_5)
			end

			return
		end

		table.remove(self.selectedMarks, var_5_3)
	end

	if not var_5_1 then
		local var_5_6, var_5_7 = self.checkShip(arg_5_1, function()
			if self.exited then
				return
			end

			self:selectPhantom(arg_5_1)

			return
		end, self.selectedMarks)

		if not var_5_6 then
			if var_5_7 then
				pg.TipsMgr.GetInstance():ShowTips(var_5_7)
			end

			return
		end

		if self.selectedMax == 0 or self:GetSelectCount() < self.selectedMax then
			table.insert(self.selectedMarks, var_5_0)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("ship_dockyardScene_error_choiseRoleLess", self.selectedMax))

			return
		end
	end

	self:updateSelected()

	if self.contextData.mode == PlayerVitaeDockyardScene.MODE_DESTROY then
		self:updateDestroyRes()
	elseif self.contextData.mode == PlayerVitaeDockyardScene.MODE_MOD then
		self:updateModAttr()
	end

	self:UpdateGuildViewEquipmentsBtn()

	return
end

function PlayerVitaeDockyardScene:GetSelectCount()
	return #self.selectedIds + #self.selectedMarks
end

function PlayerVitaeDockyardScene:GetConfirmSelect()
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(self.selectedIds) do
		table.insert(var_9_0, ShipPhantom.PackMark(iter_9_1, 0))
	end

	table.insertto(var_9_0, self.selectedMarks)

	return var_9_0
end

return PlayerVitaeDockyardScene
