local TreasureConst = require("app.view.module.equipAndTreasure.const.TreasureConst")
local var_0_1 = g.core.const.ConstMgr.EquipConst
local BagNewCommonFullAttrComp = class("BagNewCommonFullAttrComp", require("app.fairyGUI.bagNew.UI_BagNewCommonFullAttrComp"))

function BagNewCommonFullAttrComp:ctor()
	self._infoData = nil

	self.m_resonanceAttrList:setVirtual()
	self.m_resonanceAttrList:setItemRenderer(handler(self, self._onAttrItemRender))
	self.m_magicalAttrList:setVirtual()
	self.m_magicalAttrList:setItemRenderer(handler(self, self._onMagicalAttrItemRender))
end

function BagNewCommonFullAttrComp:updateInfo(arg_2_1, arg_2_2)
	self._infoData = arg_2_1

	self.m_isTreasureController:setSelectedIndex(0)

	if arg_2_2 then
		self.m_isTreasureController:setSelectedIndex(1)
		self:_updateTreasureView()
	else
		self:_updateEquipView()
	end
end

function BagNewCommonFullAttrComp:_updateEquipView()
	local var_3_0 = g.core.model.User.equipmentData
	local var_3_1 = self._infoData.info

	self.m_baseAttr1:updateAttr({
		type = self._infoData.info.strength_type,
		value = self._infoData.info.strength_value
	})
	self.m_baseAttr2:setVisible(false)
	self.m_strengthAttr1:updateAttr({
		type = var_3_1.strength_type,
		value = (g.core.model.User:getMaxLevel() * 2 - 1) * var_3_1.strength_growth
	})
	self.m_strengthAttr2:setVisible(false)

	local var_3_2 = var_3_0:getEquipMaxRefineAttr(self._infoData)

	for iter_3_0 = 1, 2 do
		if var_3_2[iter_3_0] then
			self["m_refineAttr" .. iter_3_0]:setVisible(true)
			self["m_refineAttr" .. iter_3_0]:updateAttr(var_3_2[iter_3_0])
		else
			self["m_refineAttr" .. iter_3_0]:setVisible(false)
		end
	end

	self.m_glyphAttr1:updateAttr(var_3_0:getEquipMaxGlyAttr(self._infoData)[1])
	self.m_glyphAttr2:setVisible(false)

	if var_0_1.EQUIP_GLYPH_OFF and self.m_gly then
		self.m_gly:setVisible(false)
	end

	local var_3_3 = var_3_1.resonance_id > 0

	self.m_resonance:setVisible(var_3_1.resonance_id > 0)

	if var_3_3 then
		local var_3_4 = var_3_0:getAllResonanceAttr(var_3_1.id)

		self.m_resonanceDesc:setText(g.core.lang:get(201605, {
			level = var_3_0:getMaxResonanceInfo(var_3_1.id).name
		}))

		if var_3_4 and next(var_3_4) then
			self._resonanceAttrData = var_3_4

			self.m_resonanceAttrList:setNumItems(#var_3_4)
		end
	end

	local var_3_5 = var_3_1.quality >= g.core.const.ConstMgr.QUALITY_TYPE.UR

	self.m_magical:setVisible(var_3_1.quality >= g.core.const.ConstMgr.QUALITY_TYPE.UR)

	if var_3_5 then
		local var_3_6 = {}

		for iter_3_1, iter_3_2 in pairs((var_3_0:getMagicalAttrMap(var_3_1.advance_id, var_0_1.MAGICAL_MAX_STAGE[var_3_1.quality]))) do
			table.insert(var_3_6, {
				type = iter_3_1,
				value = iter_3_2
			})
		end

		if #var_3_6 > 0 then
			self._magicalAttrData = var_3_6

			self.m_magicalAttrList:setNumItems(#var_3_6)
		end
	end
end

function BagNewCommonFullAttrComp:_updateTreasureView()
	self.m_treasureSpecialAttrController:setSelectedIndex(0)

	local var_4_0 = {}
	local var_4_1 = {}
	local var_4_2 = g.core.config.treasure_info.fetch(self._infoData.base_id)

	if var_4_2 then
		for iter_4_0 = 1, 2 do
			table.insert(var_4_0, {
				type = var_4_2["basic_type_" .. iter_4_0],
				value = var_4_2["basic_value_" .. iter_4_0]
			})
			table.insert(var_4_1, {
				type = var_4_2["basic_type_" .. iter_4_0],
				value = var_4_2["basic_growth_" .. iter_4_0] * (var_4_2.strength_limit - 1)
			})
		end
	end

	local var_4_3 = g.core.model.User.treasureData:getMaxRefineAttr(self._infoData.base_id)
	local var_4_4 = g.core.model.User.treasureData:getMaxGlyphAttr(self._infoData.base_id)
	local var_4_5 = g.core.model.User.treasureData:getMaxSpecialAttr(self._infoData.id, self._infoData.base_id)

	self.m_strengthDesc:setText(g.core.lang:get(200512, {
		max_level = var_4_2.strength_limit
	}))

	if self.m_refineDesc then
		self.m_refineDesc:setText(g.core.lang:get(200512, {
			max_level = var_4_2.refine_limit
		}))
	end

	if var_4_5 and #var_4_5 > 0 then
		self.m_treasureSpecialAttrController:setSelectedIndex(1)
		self.m_lvDesc:setText((g.core.lang:get(200512, {
			max_level = var_4_2.refine_limit
		})))
	end

	for iter_4_1 = 1, 2 do
		if var_4_0[iter_4_1] then
			self["m_baseAttr" .. iter_4_1]:setVisible(true)
			self["m_baseAttr" .. iter_4_1]:updateAttr(var_4_0[iter_4_1])
		else
			self["m_baseAttr" .. iter_4_1]:setVisible(false)
		end

		if var_4_1[iter_4_1] then
			self["m_strengthAttr" .. iter_4_1]:setVisible(true)
			self["m_strengthAttr" .. iter_4_1]:updateAttr(var_4_1[iter_4_1])
		else
			self["m_strengthAttr" .. iter_4_1]:setVisible(false)
		end

		if not TreasureConst.IS_FORBID_REFINE_ATTR and self["m_refineAttr" .. iter_4_1] then
			if var_4_3[iter_4_1] then
				self["m_refineAttr" .. iter_4_1]:setVisible(true)
				self["m_refineAttr" .. iter_4_1]:updateAttr(var_4_3[iter_4_1])
			else
				self["m_refineAttr" .. iter_4_1]:setVisible(false)
			end
		end

		if self.m_gly then
			if not TreasureConst.IS_FORBID_GLYPH then
				self.m_gly:setVisible(false)
			else
				self.m_gly:setVisible(true)

				if var_4_4[iter_4_1] then
					self["m_glyphAttr" .. iter_4_1]:setVisible(true)
					self["m_glyphAttr" .. iter_4_1]:updateAttr(var_4_4[iter_4_1])
				else
					self["m_glyphAttr" .. iter_4_1]:setVisible(false)
				end
			end
		end

		local var_4_6 = self["m_specialAttr" .. iter_4_1]

		if var_4_5[iter_4_1] then
			if var_4_6 then
				var_4_6:setVisible(true)
				var_4_6:updateAttr(var_4_5[iter_4_1])
			end
		elseif var_4_6 then
			var_4_6:setVisible(false)
		end
	end
end

function BagNewCommonFullAttrComp:_onAttrItemRender(arg_5_1, arg_5_2)
	if self._resonanceAttrData[arg_5_1 + 1] then
		arg_5_2:updateAttr(self._resonanceAttrData[arg_5_1 + 1])
	end
end

function BagNewCommonFullAttrComp:_onMagicalAttrItemRender(arg_6_1, arg_6_2)
	if self._magicalAttrData[arg_6_1 + 1] then
		arg_6_2:updateAttr(self._magicalAttrData[arg_6_1 + 1])
	end
end

return BagNewCommonFullAttrComp
