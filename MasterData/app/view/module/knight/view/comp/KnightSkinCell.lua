local KnightSkinCell = class("KnightSkinCell", require("app.fairyGUI.knight.UI_KnightSkinCell"))
local var_0_1 = g.core.config.knight_base_info
local var_0_2 = g.core.common.Path
local var_0_3 = g.core.event.EventManager
local var_0_4 = g.core.event.enum.EVENT_REFRESH_RED_POINT
local var_0_5 = g.core.model.User.skinData
local var_0_6 = g.core.const.ConstMgr.ShopConst
local var_0_7 = g.core.model.User

function KnightSkinCell:ctor()
	self._index = nil
	self._data = nil
end

function KnightSkinCell:updateCell(arg_2_1, arg_2_2)
	if not arg_2_1 then
		return
	end

	if arg_2_1 == self._data then
		return
	end

	self._data = arg_2_1
	self._index = arg_2_2

	self.m_isGrayController:setSelectedIndex(0)

	if arg_2_1.knightInfo then
		self.m_nameText:setText(arg_2_1.name)
		self.m_picComp:setIcon(var_0_2:getKnightPicRes(var_0_1.get(arg_2_1.knightInfo.res_id).painted_id))
	else
		self.m_isGrayController:setSelectedIndex(var_0_5:getSkinState(arg_2_1.skinInfo.id) == 1 and 0 or 1)
		self.m_nameText:setText(arg_2_1.skinInfo.name)
		self.m_picComp:setIcon(var_0_2:getKnightPicRes(var_0_1.get(arg_2_1.skinInfo.res).painted_id))
		var_0_3:dispatchEvent(var_0_4, true, {
			redPointComp = self.m_redPointComp,
			customData = {
				skinId = arg_2_1.skinInfo.id
			}
		})
	end

	self:_updateGmInfo()
end

function KnightSkinCell:setGray(arg_3_1)
	self.m_isGrayController:setSelectedIndex(arg_3_1 and 1 or 0)
end

function KnightSkinCell:getCellData()
	return self._data
end

function KnightSkinCell:_updateGmInfo()
	self.m_isTimeLimitController:setSelectedIndex(0)
	self.m_isDiscountController:setSelectedIndex(0)

	if self._data.skinInfo and self._data.skinInfo.res then
		local var_5_0 = self._data.skinInfo.res
		local var_5_1 = var_0_7.skinData:getActivitySkinById(self._data.skinInfo.res)

		if (var_0_7.skinGoodsData:getShinGoodsBySkinId(self._data.skinInfo.res) or {}).sale_value == var_0_6.SHOP_SKIN_TYPE.GM_SKIN then
			if var_5_1 and var_0_7.skinData:getSkinState(var_5_0) ~= 1 then
				local var_5_2 = tonumber(var_0_7.skinData:getGmSkinEndTime(var_5_0)) or 0

				if var_5_2 > 0 then
					self.m_isTimeLimitController:setSelectedIndex(1)
					self:updateSkinTime(var_5_2)
				end

				if var_0_7.skinData:isActivitySkinInDiscountTime(var_5_0) then
					self.m_isDiscountController:setSelectedIndex(1)
					self.m_discountLable:setText(var_5_1.discountValue .. "%")
				end
			end
		end
	end
end

function KnightSkinCell:updateSkinTime(arg_6_1)
	self._endTime = arg_6_1
	self._leftTime = self._endTime - g.core.common.ServerTime:getTime()

	if self._leftTime < 0 then
		return
	else
		self:_setTimeTxt()
	end

	if self._updateHandler then
		self:cancelSchedule(self._updateHandler)

		self._updateHandler = nil
	end

	self._updateHandler = self._updateHandler or self:newSchedule(handler(self, self._onUpdateCountdown), 1)
end

function KnightSkinCell:_onUpdateCountdown()
	self._leftTime = self._endTime - g.core.common.ServerTime:getTime()

	if self._leftTime >= 0 then
		self:_setTimeTxt()
	else
		if self._updateHandler then
			self:cancelSchedule(self._updateHandler)

			self._updateHandler = nil
		end

		self._leftTime = 0

		self:_skinTimeEnd()
	end
end

function KnightSkinCell:_setTimeTxt()
	self.m_timeLimit:setText((g.core.common.ServerTime:getLeftDHMSFormat(self._endTime)))
end

function KnightSkinCell:_skinTimeEnd()
	self:_updateGmInfo()
	self:dispatchCompEvent("SKIN_TIME_END")
end

return KnightSkinCell
