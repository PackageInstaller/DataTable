local var_0_0 = g.core.const.ConstMgr.ShopConst
local KnightSkinBookShowCell = class("KnightSkinBookShowCell", require("app.fairyGUI.knightSkinBook.UI_KnightSkinBookShowCell"))
local var_0_2 = g.core.config.knight_base_info
local var_0_3 = g.core.config.skin_info
local var_0_4 = g.core.common.Path
local var_0_5 = g.core.model.User

function KnightSkinBookShowCell:ctor()
	self._index = nil
end

function KnightSkinBookShowCell:updateCell(arg_2_1, arg_2_2)
	if not arg_2_1 then
		return
	end

	if self._info and arg_2_1.id == self.info.id then
		return
	end

	self.info = var_0_3.get(arg_2_1.id)
	self._index = arg_2_2

	self.m_nameText:setText(self.info.name)
	self.m_picComp:setIcon(var_0_4:getKnightPicRes(var_0_2.get(self.info.res).painted_id))
	self.m_isGrayController:setSelectedIndex(var_0_5.skinData:getSkinState(self.info.id) == 1 and 0 or 1)
	self.m_isLimitController:setSelectedIndex(self.info.limit == 1 and 1 or 0)
	self.m_effHolder:removeAllEffect()

	if self.info.limit == 1 then
		self.m_effHolder:addEffectSpine({
			anim = "play_shop",
			name = "eff_ui_recharge_limitmarkcn",
			isLoop = true
		})
	end

	self.m_theme:setText(g.core.config.skin_theme_info.get(self.info.theme).name)
	self:_updateGmInfo()
end

function KnightSkinBookShowCell:_updateGmInfo()
	self.m_isTimeLimitController:setSelectedIndex(0)
	self.m_isDiscountController:setSelectedIndex(0)

	local var_3_0 = var_0_5.skinData:getActivitySkinById(self.info.id)

	if (var_0_5.skinGoodsData:getShinGoodsBySkinId(self.info.id) or {}).sale_value == var_0_0.SHOP_SKIN_TYPE.GM_SKIN then
		if var_3_0 and var_0_5.skinData:getSkinState(self.info.id) ~= 1 then
			local var_3_1 = tonumber(var_0_5.skinData:getGmSkinEndTime(self.info.id)) or 0

			if var_3_1 > 0 then
				self.m_isTimeLimitController:setSelectedIndex(1)
				self:updateSkinTime(var_3_1)
			end

			if var_0_5.skinData:isActivitySkinInDiscountTime(self.info.id) then
				self.m_isDiscountController:setSelectedIndex(1)
				self.m_discountLable:setText(var_3_0.discountValue .. "%")
			end
		end
	end
end

function KnightSkinBookShowCell:updateSkinTime(arg_4_1)
	self._endTime = arg_4_1
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

function KnightSkinBookShowCell:_onUpdateCountdown()
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

function KnightSkinBookShowCell:_setTimeTxt()
	self.m_timeLimit:setText((g.core.common.ServerTime:getLeftDHMSFormat(self._endTime)))
end

function KnightSkinBookShowCell:_skinTimeEnd()
	self:_updateGmInfo()
	self:dispatchCompEvent("SKIN_TIME_END")
end

return KnightSkinBookShowCell
