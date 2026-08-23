local TreasureMaterialSelectCell = class("TreasureMaterialSelectCell", require("app.fairyGUI.equipAndTreasure.UI_TreasureMaterialSelectCell"))

function TreasureMaterialSelectCell:ctor()
	return
end

function TreasureMaterialSelectCell:updateView(arg_2_1)
	self.m_treasureIcon:updateIcon({
		overrideClick = true,
		type = g.core.common.Goods.TYPE_TREASURE,
		value = arg_2_1.data.base_id,
		level = arg_2_1.data.level
	})

	if arg_2_1.data.isSelect then
		self.m_showMaskController:setSelectedIndex(1)
	else
		self.m_showMaskController:setSelectedIndex(0)
	end
end

return TreasureMaterialSelectCell
