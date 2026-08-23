local EquipSuitDetailPop = class("EquipSuitDetailPop", require("app.fairyGUI.equipAndTreasure.UI_EquipSuitDetailPop"), function()
	return fgui.GComponent:create({
		resName = "EquipSuitDetailPop",
		pkgPath = "ui/equipAndTreasure/equipAndTreasure",
		pkgName = "equipAndTreasure"
	}, ...)
end)

function EquipSuitDetailPop:ctor(arg_2_1)
	self:getView():center(true)

	self._params = arg_2_1
	self._suitId = arg_2_1.suitId
	self._data = arg_2_1.data
	self._knightPos = arg_2_1.knightPos
	self._isOther = arg_2_1.isOther
	self._suitInfo = g.core.config.equipment_suit_info.get(self._suitId)

	self:updataView()
end

function EquipSuitDetailPop:updataView()
	for iter_3_0 = 1, 4 do
		local var_3_0 = self["m_suit" .. iter_3_0]

		if self["m_suit" .. iter_3_0].updateIcon then
			var_3_0:updateIcon({
				isGetShow = true,
				type = g.core.common.Goods.TYPE_EQUIP,
				value = self._suitInfo["equipment_id_" .. iter_3_0]
			})
		end

		if self._data and self._data.position > 0 and self._knightPos and self._knightPos > 0 then
			if not self._isOther and g.core.model.User.equipmentData:isEquipWearedSuitByBaseId(self._suitInfo["equipment_id_" .. iter_3_0], self._knightPos) or g.core.model.User.playerInfoData:isEquipWearedSuitByBaseId(self._suitInfo["equipment_id_" .. iter_3_0], self._knightPos) then
				var_3_0:setGrayed(false)
			else
				var_3_0:setGrayed(true)
			end
		end
	end

	self.m_suitDetailPanel:updatePanel(self._params)
end

return EquipSuitDetailPop
