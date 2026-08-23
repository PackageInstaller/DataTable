local var_0_0 = g.core.lang
local TreasureConst = require("app.view.module.equipAndTreasure.const.TreasureConst")
local TreasureInfoAttrComp = class("TreasureInfoAttrComp", require("app.fairyGUI.infoPop.UI_TreasureInfoAttrComp"))

function TreasureInfoAttrComp:ctor()
	self._treasureData = nil
	self._treasureInfo = nil
	self._treasureId = 0
	self._id = 0
end

function TreasureInfoAttrComp:updateShow(arg_2_1)
	self._treasureData = arg_2_1.treasureData
	self._treasureInfo = arg_2_1.treasureInfo

	local var_2_0 = self._treasureInfo.type

	if self._treasureInfo.type == 1 or var_2_0 == 2 then
		self:_updateBasicAttrs()
		self:_updateStrengthAttrs()
		self:_updateSpecialAttrs()
		self:_updateRefineAttrs()
		self:_updateGlyphAttrInfo()
		self.m_styleController:setSelectedIndex(0)
	end

	self.m_equipDescTxt:setText(self._treasureInfo.description, true)

	if var_2_0 == 3 then
		self.m_styleController:setSelectedIndex(1)
		self.m_expDescTxt:setText(g.core.lang:get(202052, {
			exp = self._treasureInfo.treasure_exp
		}))
	elseif var_2_0 == 4 then
		self.m_styleController:setSelectedIndex(2)
	end
end

function TreasureInfoAttrComp:_updateBasicAttrs()
	if self._treasureData then
		self.m_basicAttrComp:setVisible(false)

		return
	end

	local var_3_0 = {}

	for iter_3_0 = 1, 2 do
		if self._treasureInfo["basic_type_" .. iter_3_0] > 0 then
			table.insert(var_3_0, {
				type = self._treasureInfo["basic_type_" .. iter_3_0],
				value = self._treasureInfo["basic_value_" .. iter_3_0]
			})
		end
	end

	self.m_basicAttrComp:updateAttrs({
		isGlyph = false,
		attrs = var_3_0
	})
end

function TreasureInfoAttrComp:_updateStrengthAttrs()
	if self._treasureData then
		self.m_strengthComp:setY(12)
	end

	local var_4_0 = {}
	local var_4_1 = ""
	local var_4_2 = g.core.model.User:getLevel()
	local var_4_3 = self._treasureInfo.strength_limit
	local var_4_4, var_4_5

	if self._treasureData then
		var_4_4 = self._treasureData.level or var_4_3

		if var_4_3 <= var_4_4 then
			var_4_1 = var_0_0:get(201561)
		else
			var_4_5 = {
				num1 = var_4_4
			}
		end
	end

	var_4_5.num2 = math.min(var_4_2, var_4_3)
	var_4_1 = var_0_0:get(201559, var_4_5)

	for iter_4_0 = 1, 2 do
		if self._treasureInfo["basic_type_" .. iter_4_0] > 0 then
			table.insert(var_4_0, {
				type = self._treasureInfo["basic_type_" .. iter_4_0],
				value = (var_4_4 - 1) * self._treasureInfo["basic_growth_" .. iter_4_0] + self._treasureInfo["basic_value_" .. iter_4_0]
			})
		end
	end

	self.m_strengthComp:updateAttrs({
		isGlyph = false,
		attrs = var_4_0,
		levelDesc = var_4_1
	})
end

function TreasureInfoAttrComp:_updateRefineAttrs()
	if TreasureConst.IS_FORBID_REFINE_ATTR or not self.m_refineComp then
		return
	end

	local var_5_0 = {}
	local var_5_1 = ""
	local var_5_2 = self._treasureInfo.refine_limit
	local var_5_3

	if self._treasureData then
		var_5_3 = self._treasureData.refining_level or var_5_2
	end

	var_5_1 = var_5_3 == var_5_2 and var_0_0:get(201562) or var_0_0:get(201560, {
		num1 = var_5_3,
		num2 = var_5_2
	})

	for iter_5_0 = 1, 2 do
		if self._treasureInfo["refine_type_" .. iter_5_0] > 0 then
			table.insert(var_5_0, {
				type = self._treasureInfo["refine_type_" .. iter_5_0],
				value = var_5_3 * self._treasureInfo["refine_growth_" .. iter_5_0]
			})
		end
	end

	self.m_refineComp:updateAttrs({
		isGlyph = false,
		attrs = var_5_0,
		levelDesc = var_5_1
	})
end

function TreasureInfoAttrComp:_updateGlyphAttrInfo()
	if not self.m_glyphComp then
		return
	end

	if not TreasureConst.IS_FORBID_GLYPH then
		self.m_glyphComp:setVisible(false)

		return
	else
		local var_6_0 = {}
		local var_6_1
		local var_6_2

		if self._treasureData and self._treasureData.glyph_level > 0 then
			var_6_2 = g.core.config.glyph_info.get(self._treasureInfo.treasure_glyph, self._treasureData.glyph_level)
		else
			var_6_1 = var_0_0:get(201563)

			for iter_6_0 = 1, g.core.config.glyph_info:getLength() do
				local var_6_3 = g.core.config.glyph_info.indexOf(iter_6_0)
				local var_6_4

				if var_6_3.type == 2 and var_6_3.id == self._treasureInfo.treasure_glyph and 0 < var_6_3.level then
					var_6_4 = var_6_3.level
					var_6_2 = var_6_3
				end
			end
		end

		if var_6_2 then
			for iter_6_1 = 1, 2 do
				if var_6_2["affect_value" .. iter_6_1] ~= 0 then
					table.insert(var_6_0, {
						type = var_6_2["affect_type" .. iter_6_1],
						value = var_6_2["affect_value" .. iter_6_1]
					})
				end
			end
		end

		self.m_glyphComp:updateAttrs({
			isGlyph = true,
			attrs = var_6_0,
			levelDesc = var_6_1,
			glyphInfo = var_6_2
		})
	end
end

function TreasureInfoAttrComp:_updateSpecialAttrs()
	self.m_specialAttrComp:setVisible(true)

	if self._treasureInfo.quality < 2 then
		self.m_specialAttrComp:setVisible(false)
	elseif self._treasureData then
		local var_7_0 = g.core.model.User.treasureData:getTreasureSpecialAttrsList(self._treasureData.id)

		if #var_7_0 > 0 then
			local var_7_1 = self._treasureInfo.refine_limit
			local var_7_2, var_7_3

			if self._treasureData then
				var_7_2 = self._treasureData.refining_level

				if not self._treasureData.refining_level then
					var_7_2 = var_7_1
					var_7_3 = ""
				end
			end

			var_7_3 = var_7_2 == var_7_1 and var_0_0:get(201562) or var_0_0:get(201560, {
				num1 = var_7_2,
				num2 = var_7_1
			})

			self.m_specialAttrComp:updateAttrs({
				attrs = var_7_0,
				levelDesc = var_7_3
			})
		else
			self.m_specialAttrComp:setVisible(false)
		end
	else
		self.m_specialAttrComp:updateAttrs({
			baseId = self._treasureInfo.id
		})
	end

	self:_adaptAttrPos()
end

function TreasureInfoAttrComp:_adaptAttrPos()
	if self.m_styleController:getSelectedIndex() == 0 then
		if self.m_specialAttrComp:isVisible() then
			self.m_descGroup:setY(self.m_specialAttrComp:getY() + self.m_specialAttrComp:getSize().height + 10)
		else
			self.m_descGroup:setY(self.m_strengthComp:getY() + self.m_strengthComp:getSize().height + 10)
		end
	end
end

return TreasureInfoAttrComp
