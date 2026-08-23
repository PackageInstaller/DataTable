local BaseGlyphQualityComp = class("BaseGlyphQualityComp", require("app.fairyGUI.base_new.UI_BaseGlyphQualityComp"))
local var_0_1 = g.core.common.Goods

function BaseGlyphQualityComp:ctor()
	self._equipGlyGroupId = nil
end

function BaseGlyphQualityComp:updateView(arg_2_1)
	if not arg_2_1 then
		return
	end

	if arg_2_1.sid then
		self:_updateViewBySid(arg_2_1.sid, arg_2_1.isNext)

		return
	end

	local var_2_0 = arg_2_1.type
	local var_2_1 = arg_2_1.glyphLevel

	self._params = arg_2_1

	local var_2_2

	if var_2_0 == var_0_1.TYPE_EQUIP then
		var_2_2 = g.core.config.equipment_info.get(arg_2_1.value).equipment_glyph
	elseif var_2_0 == var_0_1.TYPE_TREASURE then
		var_2_2 = g.core.config.treasure_info.get(arg_2_1.value).treasure_glyph
	end

	self._equipGlyGroupId = var_2_2

	self.m_glyphQualityLoader:setURL((g.core.common.Path:getGlyphIcon((g.core.config.glyph_info.get(var_2_2, var_2_1) or {}).icon)))
end

function BaseGlyphQualityComp:_getIconUrlBySid(arg_3_1, arg_3_2)
	local var_3_0 = g.core.model.User.treasureData:getTreasureDataByOnlyId(arg_3_1)

	if var_3_0 then
		local var_3_2 = g.core.config.treasure_info.get(var_3_0.base_id).treasure_glyph
		local var_3_3 = var_3_0.glyph_level

		if arg_3_2 then
			var_3_3 = var_3_3 + 1
		end

		self._equipGlyGroupId = var_3_2

		return g.core.common.Path:getGlyphIcon(g.core.config.glyph_info.get(var_3_2, var_3_3).icon)
	end

	local var_3_4 = g.core.model.User.equipmentData:getEquipBySid(arg_3_1)
	local var_3_5 = var_3_4:getGlyphInfo()
	local var_3_6 = var_3_4:getCfg().equipment_glyph

	self._equipGlyGroupId = var_3_6

	return g.core.common.Path:getGlyphIcon(((arg_3_2 or nil) and g.core.config.glyph_info.get(var_3_6, var_3_4:getServerData().glyph_level + 1)).icon)
end

function BaseGlyphQualityComp:_updateViewBySid(arg_4_1, arg_4_2)
	self.m_glyphQualityLoader:setURL((self:_getIconUrlBySid(arg_4_1, arg_4_2)))
end

function BaseGlyphQualityComp:setGlyphIconByLevel(arg_5_1)
	if not self._equipGlyGroupId then
		return
	end

	local var_5_0 = g.core.common.Path:getGlyphIcon("10")

	self.m_glyphQualityLoader:setURL((arg_5_1 > 0 or nil) and g.core.common.Path:getGlyphIcon((g.core.config.glyph_info.get(self._equipGlyGroupId, arg_5_1) or {}).icon))
end

return BaseGlyphQualityComp
