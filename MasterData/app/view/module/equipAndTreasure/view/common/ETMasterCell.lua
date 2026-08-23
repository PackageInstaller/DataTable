local var_0_0 = g.core.config.treasure_info
local var_0_1 = g.core.config.equipment_info
local ETMasterCell = class("ETMasterCell", require("app.fairyGUI.equipAndTreasure.UI_ETMasterCell"))

function ETMasterCell:ctor()
	self._type = nil
	self._info = nil
	self._index = 0
	self._data = {}
end

function ETMasterCell:updateView(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	self._type = arg_2_1
	self._data = arg_2_3

	if table.nums(arg_2_3) > 0 then
		if arg_2_1 == 5 then
			self.m_isResonanceController:setSelectedIndex(1)

			self._info = var_0_1.get(arg_2_3.base_id)

			self.m_icon:updateIcon({
				type = g.core.common.Goods.TYPE_EQUIP,
				value = arg_2_3.base_id
			})
		elseif arg_2_1 >= 3 then
			self.m_isResonanceController:setSelectedIndex(0)

			self._info = var_0_0.get(arg_2_3.base_id)

			self.m_icon:updateIcon({
				type = g.core.common.Goods.TYPE_TREASURE,
				value = arg_2_3.base_id,
				treasureOnlyId = arg_2_3.id
			})
		else
			self.m_isResonanceController:setSelectedIndex(0)

			self._info = var_0_1.get(arg_2_3.base_id)

			self.m_icon:updateIcon({
				type = g.core.common.Goods.TYPE_EQUIP,
				value = arg_2_3.base_id
			})
		end

		self.m_name:setText(self._info.name)
		self.m_progress:setVisible(true)

		if arg_2_1 == 1 or arg_2_1 == 3 then
			local var_2_0 = {
				cur = arg_2_3.level,
				max = arg_2_4
			}

			self.m_progress:setPercent(var_2_0)
			self:setProgressNumber(var_2_0, arg_2_5)
		elseif arg_2_1 == 2 or arg_2_1 == 4 then
			local var_2_1 = {
				cur = arg_2_3.refining_level,
				max = arg_2_4
			}

			self.m_progress:setPercent(var_2_1)
			self:setProgressNumber(var_2_1, arg_2_5)
		elseif arg_2_1 == 5 then
			self.m_curResonanceLevelComp:setResonanceLevel(arg_2_3.resonance_level)
			self.m_targetResonanceLevelComp:setResonanceLevel(arg_2_4)

			local var_2_2 = g.core.model.User.equipmentData:getEquipBySid(arg_2_3.id)
			local var_2_3, var_2_4 = var_2_2:getNextResonanceInfo()

			if var_2_2:hasResonance() then
				self.m_canResoanceController:setSelectedIndex(0)
				self.m_progress:setVisible(true)

				local var_2_5 = {
					cur = arg_2_3.resonance_exp,
					max = var_2_3.exp
				}

				if arg_2_4 <= arg_2_3.resonance_level then
					self.m_resonanceEnoughController:setSelectedIndex(1)

					var_2_5.cur = var_2_5.max

					self.m_progress:setPercent(var_2_5)
				else
					self.m_resonanceEnoughController:setSelectedIndex(0)
				end

				self.m_progress:setPercent(var_2_5)
			else
				self.m_canResoanceController:setSelectedIndex(1)
				self.m_progress:setVisible(false)
			end
		end
	end
end

function ETMasterCell:setProgressNumber(arg_3_1, arg_3_2)
	self.m_curLevelText:setText(arg_3_1.cur)

	if not arg_3_2 then
		self.m_nextLevelText:setText(g.core.lang:get(202044, {
			level = arg_3_1.max
		}))
	else
		self.m_nextLevelText:setText("")
	end
end

return ETMasterCell
