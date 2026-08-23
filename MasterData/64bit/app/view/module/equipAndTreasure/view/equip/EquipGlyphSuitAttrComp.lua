local EquipGlyphSuitAttrComp = class("EquipGlyphSuitAttrComp", require("app.fairyGUI.equipAndTreasure.UI_EquipGlyphSuitAttrComp"))

function EquipGlyphSuitAttrComp:updateAttrComp(arg_1_1, arg_1_2)
	if not arg_1_1 then
		return
	end

	self._attrData = arg_1_1
	self._knightPos = arg_1_2

	local var_1_0 = arg_1_1.isShowTitle or false

	self.m_isShowTtileController:setSelectedIndex(var_1_0 and 1 or 0)

	if var_1_0 and arg_1_1.text then
		self.m_title:setText("[" .. arg_1_1.text .. "]")
	end

	for iter_1_0, iter_1_1 in ipairs(arg_1_1 or {}) do
		local var_1_1 = self:getChild("attr" .. iter_1_0)

		if var_1_1 then
			var_1_1:getChild("atrrNumText"):setText("[" .. math.min(iter_1_0 + 1, (self:_getCurActiveCount())) .. "/" .. iter_1_0 + 1 .. "]")
			var_1_1:getController("isActive"):setSelectedIndex(iter_1_1.isActive and 1 or 0)
			var_1_1:getController("fontSize"):setSelectedIndex((arg_1_1.fontSize or 0) == 18 and 1 or 0)

			local var_1_2, var_1_3 = g.core.lang:getAttr(iter_1_1.info.affect_type1, iter_1_1.info.affect_value1)

			var_1_1:getChild("atrr1"):setText(var_1_2 .. var_1_3)

			local var_1_4 = 0 + 1

			if iter_1_1.info.affect_type2 and iter_1_1.info.affect_type2 > 0 then
				local var_1_5, var_1_6 = g.core.lang:getAttr(iter_1_1.info.affect_type2, iter_1_1.info.affect_value2)

				var_1_1:getChild("atrr2"):setText(var_1_5 .. var_1_6)

				var_1_4 = var_1_4 + 1
			end

			if iter_1_1.info.affect_type3 and iter_1_1.info.affect_type3 > 0 then
				local var_1_7, var_1_8 = g.core.lang:getAttr(iter_1_1.info.affect_type3, iter_1_1.info.affect_value3)

				var_1_1:getChild("atrr3"):setText(var_1_7 .. var_1_8)

				var_1_4 = var_1_4 + 1
			end

			var_1_1:getController("attrsNum"):setSelectedIndex(var_1_4 - 1)
		end
	end
end

function EquipGlyphSuitAttrComp:_getCurActiveCount()
	local var_2_0 = 0

	for iter_2_0, iter_2_1 in ipairs(self._attrData or {}) do
		if iter_2_1.isActive then
			var_2_0 = var_2_0 + 1
		end
	end

	if var_2_0 > 0 then
		var_2_0 = var_2_0 + 1
	elseif self._knightPos then
		local var_2_1 = g.core.model.User.equipmentData:getEquipSuitByKnightPos(self._knightPos)

		for iter_2_2 = 1, #var_2_1 do
			if var_2_1[iter_2_2] ~= 0 and var_2_1[iter_2_2]:getGlyphInfo().level > 0 then
				var_2_0 = 1
			end
		end
	end

	return var_2_0
end

return EquipGlyphSuitAttrComp
