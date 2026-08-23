local ETPopGlyphComp = class("ETPopGlyphComp", require("app.fairyGUI.equipAndTreasure.UI_ETPopGlyphComp"))

function ETPopGlyphComp:update(arg_1_1)
	local var_1_0 = {}
	local var_1_1 = {}
	local var_1_2 = self.m_iconComp1:getChild("glyphQualityLoader")
	local var_1_3 = self.m_iconComp2:getChild("glyphQualityLoader")

	if arg_1_1.data.glyphType == 1 then
		var_1_0 = arg_1_1.data.data:getGlyphInfo()
		var_1_1 = arg_1_1.data.data:getPreGlyphInfo()

		var_1_2:setURL((g.core.common.Path:getGlyphIcon(var_1_1.icon)))
		var_1_3:setURL((g.core.common.Path:getGlyphIcon(var_1_0.icon)))
	else
		var_1_0 = g.core.model.User.treasureData:getTreasureGlyphInfo(arg_1_1.data.data.id)
		var_1_1 = g.core.model.User.treasureData:getPreTreasureGlyphInfo(arg_1_1.data.data.id)

		var_1_2:setURL((g.core.common.Path:getGlyphIcon(var_1_1.icon)))
		var_1_3:setURL((g.core.common.Path:getGlyphIcon(var_1_0.icon)))
	end

	if var_1_1.level then
		if var_1_1.level < 1 then
			var_1_2:setURL(g.core.common.Path:getGlyphIcon(11) or "")
			var_1_2:setGrayed(true)
		end
	end

	local var_1_4 = self:getChild("attr1")
	local var_1_5 = self:getChild("attr2")

	var_1_4:setVisible(var_1_0.affect_type1 > 0)
	var_1_5:setVisible(var_1_0.affect_type2 > 0)

	if var_1_0.affect_type1 > 0 then
		local var_1_6, var_1_7 = g.core.lang:getAttr(var_1_0.affect_type1, var_1_0.affect_value1)
		local var_1_8, var_1_9 = g.core.lang:getAttr(var_1_1.affect_type1, var_1_1.affect_value1)

		var_1_4:updateAttr({
			name = var_1_6,
			value = var_1_9,
			value2 = var_1_7
		})
	end

	if var_1_0.affect_type2 > 0 then
		local var_1_10, var_1_11 = g.core.lang:getAttr(var_1_0.affect_type2, var_1_0.affect_value2)
		local var_1_12, var_1_13 = g.core.lang:getAttr(var_1_1.affect_type2, var_1_1.affect_value2)

		var_1_5:updateAttr({
			name = var_1_10,
			value = var_1_13,
			value2 = var_1_11
		})
	end
end

return ETPopGlyphComp
