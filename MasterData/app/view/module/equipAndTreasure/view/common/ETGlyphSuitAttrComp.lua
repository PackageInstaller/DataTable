local ETGlyphSuitAttrComp = class("ETGlyphSuitAttrComp", require("app.fairyGUI.equipAndTreasure.UI_ETGlyphSuitAttrComp"))

function ETGlyphSuitAttrComp:updateAttrComp(arg_1_1)
	if not arg_1_1 then
		return
	end

	local var_1_0 = arg_1_1.glyphType
	local var_1_1 = arg_1_1.isShowTitle or false

	self.m_isShowTtileController:setSelectedIndex(var_1_1 and 1 or 0)

	if var_1_1 then
		self.m_title:setText(arg_1_1.text or "")
	end

	local var_1_3 = 0

	for iter_1_0, iter_1_1 in ipairs(arg_1_1 or {}) do
		var_1_3 = var_1_3 + 1

		local var_1_4 = self:getChild("attr" .. iter_1_0)

		var_1_4:setVisible(true)

		if var_1_4 then
			local var_1_5 = string.sub((iter_1_1.info or nil) and (iter_1_1.info.suit_name .. "：" or ""), 1, 1)

			if var_1_0 == 1 then
				var_1_4:getChild("atrrNumText"):setText("[" .. var_1_5 .. "/" .. 4 .. "]")
			else
				var_1_4:getChild("atrrNumText"):setText("[" .. var_1_5 .. "/" .. 2 .. "]")
			end

			var_1_4:getController("isActive"):setSelectedIndex(iter_1_1.isActive and 1 or 0)

			local var_1_6

			if iter_1_1.isActive then
				var_1_6 = false

				self.m_title:setColor(cc.c3b(50, 50, 50))
			else
				var_1_6 = true
			end

			local var_1_7, var_1_8 = g.core.lang:getAttr(iter_1_1.info.affect_type1, iter_1_1.info.affect_value1)

			var_1_4:getChild("atrr1"):updateAttr({
				withoutPlus1 = false,
				name = var_1_7,
				value = iter_1_1.info.affect_value1,
				type = iter_1_1.info.affect_type1,
				isGray = var_1_6
			})

			local var_1_9 = 0 + 1

			if iter_1_1.info.affect_type2 and iter_1_1.info.affect_type2 > 0 then
				local var_1_10, var_1_11 = g.core.lang:getAttr(iter_1_1.info.affect_type2, iter_1_1.info.affect_value2)

				var_1_4:getChild("atrr2"):updateAttr({
					withoutPlus1 = false,
					name = var_1_10,
					value = iter_1_1.info.affect_value2,
					type = iter_1_1.info.affect_type2,
					isGray = var_1_6
				})

				var_1_9 = var_1_9 + 1
			end

			var_1_4:getController("attrsNum"):setSelectedIndex(var_1_9 - 1)
		end
	end

	for iter_1_2 = var_1_3 + 1, 3 do
		self:getChild("attr" .. iter_1_2):setVisible(false)
	end
end

return ETGlyphSuitAttrComp
