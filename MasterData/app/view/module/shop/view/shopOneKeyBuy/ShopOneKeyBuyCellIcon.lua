local ShopOneKeyBuyCellIcon = class("ShopOneKeyBuyCellIcon", require("app.fairyGUI.shop.UI_ShopOneKeyBuyCellIcon"))

function ShopOneKeyBuyCellIcon:ctor()
	self._data = nil
end

function ShopOneKeyBuyCellIcon:updateCell(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	self._data = arg_2_1
	self._finishcallback = arg_2_4
	self._progresscallback = arg_2_5

	self.m_goodIcon:updateIcon({
		type = arg_2_1.type,
		value = arg_2_1.value,
		size = arg_2_1.size
	})

	if arg_2_1.isSuccess == false then
		self.m_successController:setSelectedIndex(1)
	else
		self.m_successController:setSelectedIndex(2)
	end

	self:setVisible(false)

	if arg_2_1.skipAnim ~= true and arg_2_1.played ~= true then
		if self.m_enterTransition then
			arg_2_1.played = true

			local var_2_0 = arg_2_3 ~= nil and arg_2_2 == arg_2_3 - 1

			if (arg_2_2 or 0) * 0.3 > 0 then
				self:newScheduleOnce(function()
					self:setVisible(true)
					self.m_enterTransition:play()

					if var_2_0 and self._finishcallback then
						self._finishcallback()
					end

					if self._progresscallback then
						self._progresscallback(self._data)
					end
				end, (arg_2_2 or 0) * 0.3)
			else
				self:setVisible(true)
				self.m_enterTransition:play()

				if var_2_0 and self._finishcallback then
					self._finishcallback()
				end

				if self._progresscallback then
					self._progresscallback(self._data)
				end
			end
		end
	else
		self:setVisible(true)
	end
end

function ShopOneKeyBuyCellIcon:skipAnim()
	self:cancelAllSchedule()

	if self._data then
		self._data.played = true
	end

	self:setVisible(true)
end

return ShopOneKeyBuyCellIcon
