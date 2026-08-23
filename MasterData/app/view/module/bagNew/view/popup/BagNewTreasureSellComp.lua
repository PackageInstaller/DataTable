local BagNewTreasureSellComp = class("BagNewTreasureSellComp", require("app.fairyGUI.bagNew.UI_BagNewTreasureSellComp"))

function BagNewTreasureSellComp:ctor()
	self.m_comIcon:addClickListener(handler(self, self._onClickCell))

	self.m_buttonController = self:getController("button")
end

function BagNewTreasureSellComp:update(arg_2_1, arg_2_2, arg_2_3)
	self._data = arg_2_1

	local var_2_0 = g.core.common.Goods.TYPE_TREASURE

	if arg_2_3 then
		var_2_0 = arg_2_3 == 1 and g.core.common.Goods.TYPE_EQUIP or g.core.common.Goods.TYPE_FRAGMENT

		if var_2_0 == g.core.common.Goods.TYPE_FRAGMENT then
			self.m_comIcon:updateIcon({
				overrideClick = true,
				type = g.core.common.Goods.TYPE_FRAGMENT,
				value = arg_2_1.info.id,
				size = arg_2_1.num
			})

			self._costItem = {
				type = arg_2_1.info.price_type,
				value = arg_2_1.info.price_value,
				size = arg_2_1.info.price_size
			}

			local var_2_1 = {
				type = var_2_0,
				value = arg_2_1.info.id
			}

			var_2_1.size = arg_2_1.num or 1
			self._sellParam = var_2_1
		else
			local var_2_2 = g.core.model.User.equipmentData:getEquipBySid(arg_2_1.sid)
			local var_2_3 = var_2_2:getServerData()
			local var_2_4 = {
				changeControllers = true,
				overrideClick = true,
				resonanceState = 1,
				type = g.core.common.Goods.TYPE_EQUIP,
				value = var_2_2:getCfg().id,
				level = var_2_3.level,
				stage = var_2_3.refining_level,
				refineLevel = var_2_3.refining_level,
				glyphLevel = var_2_3.glyph_level
			}

			var_2_4.resonanceLevel = var_2_3.resonance_level or 0

			self.m_comIcon:updateIcon(var_2_4)

			self._costItem = {
				type = arg_2_1.info.price_type,
				value = arg_2_1.info.price_value,
				size = arg_2_1.info.price_size
			}

			local var_2_5 = {
				type = var_2_0
			}

			if arg_2_3 == 1 then
				var_2_5.value = arg_2_1.sid or arg_2_1.info.id
			end

			var_2_5.size = arg_2_1.num or 1
			self._sellParam = var_2_5
		end
	else
		self.m_comIcon:updateIcon({
			changeControllers = true,
			overrideClick = true,
			type = g.core.common.Goods.TYPE_TREASURE,
			value = self._data.base_id,
			level = self._data.level,
			stage = self._data.refining_level,
			refineLevel = self._data.refining_level,
			glyphLevel = self._data.glyph_level
		})

		local var_2_6 = g.core.config.treasure_info.get(arg_2_1.base_id)

		self._costItem = {
			type = var_2_6.price_type,
			value = var_2_6.price_value,
			size = var_2_6.price_size
		}
		self._sellParam = {
			size = 1,
			type = var_2_0,
			value = self._data.id,
			baseId = self._data.base_id
		}
	end

	if arg_2_2[string.format("%d_%d", self._sellParam.type, self._sellParam.value)] then
		self.m_buttonController:setSelectedIndex(1)
	else
		self.m_buttonController:setSelectedIndex(0)
	end
end

function BagNewTreasureSellComp:_onCheckChanged()
	self:dispatchCompEvent("EquipSellCellComp_selected", self.m_buttonController:getSelectedIndex() == 1, 1, self._costItem, self._sellParam)
end

function BagNewTreasureSellComp:_onClickCell()
	local var_4_0 = self._data.num or 1

	if self.m_buttonController:getSelectedIndex() == 1 then
		self.m_buttonController:setSelectedIndex(0)
	else
		self.m_buttonController:setSelectedIndex(1)
	end

	self:dispatchCompEvent("EquipSellCellComp_selected", self.m_buttonController:getSelectedIndex() == 1, var_4_0, self._costItem, self._sellParam)
end

return BagNewTreasureSellComp
