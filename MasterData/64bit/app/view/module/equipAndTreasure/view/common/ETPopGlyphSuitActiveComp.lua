local ETPopGlyphSuitActiveComp = class("ETPopGlyphSuitActiveComp", require("app.fairyGUI.equipAndTreasure.UI_ETPopGlyphSuitActiveComp"))

function ETPopGlyphSuitActiveComp:ctor()
	self.m_suitAttrList:setIniter()
	self.m_suitAttrList:setItemRenderer(handler(self, self._onItemRender))
end

function ETPopGlyphSuitActiveComp:update(arg_2_1)
	local var_2_0 = arg_2_1.data.glyphSuit
	local var_2_1 = arg_2_1.data.glyActive
	local var_2_2 = arg_2_1.data.glyActive.glyphType

	self.m_addAttNumController:setSelectedIndex((arg_2_1.data.glyActive.glyphType == 1 and var_2_1.data:getGlyphInfo() or g.core.model.User.treasureData:getTreasureGlyphInfo(var_2_1.data.id)).affect_type2 > 0 and 1 or 0)
	self.m_glyCompInfo:update({
		data = {
			data = var_2_1.data,
			glyphType = var_2_1.glyphType
		}
	})

	local var_2_4 = 0

	if var_2_2 == 1 then
		self._activeData = g.core.model.User.formationData:getActiveEquipGlyphSuit(var_2_0.pos)

		for iter_2_0 = 1, #self._activeData do
			var_2_4 = var_2_4 + self._activeData[iter_2_0].num - 1
		end
	else
		self._activeData = g.core.model.User.formationData:getActiveTreasureGlyphSuit(var_2_0.pos)

		for iter_2_1 = 1, #self._activeData do
			var_2_4 = var_2_4 + self._activeData[iter_2_1].num - 1
		end
	end

	self.m_preText:setText(g.core.lang:get(201551, {
		num = var_2_4 - 1
	}))
	self.m_curText:setText(g.core.lang:get(201551, {
		num = var_2_4
	}))

	local var_2_5 = {}
	local var_2_6 = {}

	for iter_2_2 = 1, #self._activeData do
		for iter_2_3, iter_2_4 in pairs((g.core.model.User.equipmentData:getGlyphSuitInfoByLevel(self._activeData[iter_2_2].level, var_2_2))) do
			if iter_2_3 <= self._activeData[iter_2_2].num then
				table.insert(var_2_5, iter_2_4)
			end
		end
	end

	for iter_2_5 = 1, #var_2_5 do
		for iter_2_6 = 1, 4 do
			if var_2_5[iter_2_5]["affect_type" .. iter_2_6] and var_2_5[iter_2_5]["affect_type" .. iter_2_6] > 0 then
				var_2_6[var_2_5[iter_2_5]["affect_type" .. iter_2_6]] = not var_2_6[var_2_5[iter_2_5]["affect_type" .. iter_2_6]] and var_2_5[iter_2_5]["affect_value" .. iter_2_6] or var_2_6[var_2_5[iter_2_5]["affect_type" .. iter_2_6]] + var_2_5[iter_2_5]["affect_value" .. iter_2_6]
			end
		end
	end

	self._attrArr = {}

	for iter_2_7, iter_2_8 in pairs(var_2_6) do
		table.insert(self._attrArr, {
			type = iter_2_7,
			value = iter_2_8
		})
	end

	table.sort(self._attrArr, function(arg_3_0, arg_3_1)
		if arg_3_0.type ~= arg_3_1.type then
			return arg_3_0.type < arg_3_1.type
		end
	end)
	self.m_suitAttrList:setNumItems(#self._attrArr)
end

function ETPopGlyphSuitActiveComp:_onItemRender(arg_4_1, arg_4_2)
	local var_4_0, var_4_1 = g.core.lang:getAttr(self._attrArr[arg_4_1 + 1].type, self._attrArr[arg_4_1 + 1].value)

	arg_4_2:updateAttr({
		name = var_4_0,
		value = var_4_1
	})
end

function ETPopGlyphSuitActiveComp:play()
	return
end

return ETPopGlyphSuitActiveComp
