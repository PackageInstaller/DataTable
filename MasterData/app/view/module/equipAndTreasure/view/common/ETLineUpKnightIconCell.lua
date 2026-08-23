local ETLineUpKnightIconCell = class("ETLineUpKnightIconCell", require("app.fairyGUI.equipAndTreasure.UI_ETLineUpKnightIconCell"))
local var_0_1 = g.core.model.User.knightsData

function ETLineUpKnightIconCell:ctor()
	self._callback = nil
	self.m_icon = self:getChild("icon")

	self:addClickListener(handler(self, self._onTouchItem))
end

function ETLineUpKnightIconCell:updateView(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self._callback = arg_2_3
	self._knightId = arg_2_1
	self._selKnightId = arg_2_2

	if not arg_2_1 then
		return
	end

	local var_2_0 = var_0_1:getKnight({
		id = arg_2_1
	})

	if var_2_0 then
		self.m_isLockController:setSelectedIndex(0)
		self.m_icon:updateIcon({
			sid = arg_2_1
		})
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_canLineUpController:setSelectedIndex(0)

		if self._knightId == self._selKnightId then
			self.m_buttonController:setSelectedIndex(1)
		else
			self.m_buttonController:setSelectedIndex(0)
		end

		local var_2_1 = var_2_0:getFormationPos()
		local var_2_2 = true

		if arg_2_4 == "treasure" then
			local var_2_3 = {}

			for iter_2_0 = 1, 2 do
				local var_2_4 = g.core.model.User.treasureData:getTreasureDataByPos((var_2_1 - 1) * 2 + iter_2_0)

				if var_2_4 then
					table.insert(var_2_3, var_2_4)
				end
			end

			var_2_2 = #var_2_3 ~= 0
		elseif arg_2_4 == "equipment" then
			local var_2_5 = g.core.model.User.equipmentData:getEquipSuitByKnightPos(var_2_1)

			if #var_2_5 > 0 then
				local var_2_6 = 0

				for iter_2_1 = 1, #var_2_5 do
					if type(var_2_5[iter_2_1]) == "number" or not var_2_5[iter_2_1].getCfg then
						var_2_6 = var_2_6 + 1
					end
				end

				var_2_2 = var_2_6 ~= 4
			else
				var_2_2 = false
			end
		end

		self.m_isEquipController:setSelectedIndex(var_2_2 and 0 or 1)
	end
end

function ETLineUpKnightIconCell:_onTouchItem()
	if self._callback then
		self._callback(self._knightId)
	end
end

return ETLineUpKnightIconCell
