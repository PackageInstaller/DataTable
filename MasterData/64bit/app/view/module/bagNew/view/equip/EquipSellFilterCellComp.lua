local EquipSellFilterCellComp = class("EquipSellFilterCellComp", require("app.fairyGUI.bagNew.UI_EquipSellFilterCell"))

function EquipSellFilterCellComp:ctor()
	self._allQuality = {}

	self.m_checkBtn:setChangeStateOnClick(false)
	self:addClickListener(handler(self, self._onCheckClick))
end

function EquipSellFilterCellComp:update(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self._index = arg_2_1
	self._allQuality = arg_2_2
	self._isTreasure = arg_2_4

	self.m_qualityLoader:setURL(g.core.common.Path:getQualityArtTxtURLNew(arg_2_1))
	self.m_checkBtn:setSelected(arg_2_3 and true or false)
end

function EquipSellFilterCellComp:_onCheckClick(arg_3_1)
	local var_3_0 = not self.m_checkBtn:isSelected()

	self.m_checkBtn:setSelected(var_3_0)
	self:dispatchCompEvent("EquipSellFilterCellComp", var_3_0, self._index)

	if not self._allQuality[self._index] then
		g.core.module.ModuleManager:tip(g.core.lang:get((self._isTreasure or nil) and 201564, {
			num = g.core.lang:get(1261 + tonumber(self._index))
		}))
	end
end

return EquipSellFilterCellComp
