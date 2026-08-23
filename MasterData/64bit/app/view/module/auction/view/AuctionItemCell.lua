local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.common.Goods
local var_0_2 = g.core.model.User.AuctionData
local AuctionItemCell = class("AuctionItemCell", require("app.fairyGUI.auction.UI_AuctionItemCell"))
local var_0_4 = g.core.common.Path

function AuctionItemCell:ctor()
	self.getSharedTrans(self, "enter_left", "CommonShortCellList", self)

	local var_1_0 = var_0_4:getIconByTypeValue(var_0_1.TYPE_GOLD, 0, true)

	self.m_biddingBtn:setIcon(var_1_0)
	self.m_buyNowBtn:setIcon(var_1_0)
	self.m_biddingBtn:addClickListener(handler(self, self._onClickBidPrice))
	self.m_buyNowBtn:addClickListener(handler(self, self._onClickOnePrice))
	self.m_iconLoader:addClickListener(handler(self, self._onClickItemIcon))
end

function AuctionItemCell:updateCell(arg_2_1)
	if self._scheduleHandler then
		self:cancelSchedule(self._scheduleHandler)

		self._scheduleHandler = nil
	end

	if not arg_2_1 then
		return
	end

	self.dataInfo = arg_2_1.data
	self._actId = arg_2_1.act_id
	self._startTime = self.dataInfo.start_time

	local var_2_0 = var_0_2:getItemInfoById(self.dataInfo.auction_item_id)

	self.m_statusController:setSelectedIndex(self.dataInfo.status)

	local var_2_1 = var_0_0:getTime()

	if var_2_1 < self._startTime then
		self._isStart = false
		self._leftTime = math.max(0, math.floor(self._startTime - var_2_1))

		self.m_timeTxt:setText(var_0_0:_secondToString(self._leftTime))
	else
		self._isStart = true
		self._leftTime = math.max(0, math.floor(self.dataInfo.rest_time - var_2_1))

		self.m_timeTxt:setText(var_0_0:_secondToString(self._leftTime))
	end

	self._scheduleHandler = self:newSchedule(handler(self, self._onUpdate), 1)

	local var_2_2 = {
		type = var_2_0.type,
		value = var_2_0.value,
		size = var_2_0.size
	}
	local var_2_3 = var_0_1:convert(var_2_2)

	if var_2_3 then
		self.m_iconLoader:setURL(var_2_3.icon)
		self.m_nameTxt:setText(var_2_3.name)
		self.m_qualityLoader:setURL(var_0_4:getPreciousSuitCellQualityUrl(var_2_3.quality))
	end

	self.m_countTxt:setText("x" .. var_2_2.size)
	self.m_biddingBtn:setCtrlState("style", {
		index = self.dataInfo.status == 2 and 1 or 0
	})

	local var_2_4 = g.core.model.User:getVipLevel()
	local var_2_5 = var_2_0.fixed_price_vip

	self.needVipLevel = var_2_0.fixed_price_vip

	self.m_buyNowBtn:setCtrlState("style", {
		index = var_2_5 <= var_2_4 and 0 or 1
	})

	self._consumeNum_1 = var_2_0.price_min + self.dataInfo.auction_num * var_2_0.price_add
	self._consumeNum_2 = var_2_0.price_max
	self._consumeNum_1 = math.min(self._consumeNum_1, self._consumeNum_2)

	self.m_biddingBtn:getChild("priceTxt"):setText(self._consumeNum_1)
	self.m_buyNowBtn:getChild("priceTxt"):setText(self._consumeNum_2)

	if self.dataInfo.status == 2 then
		self.m_biddingBtn:setTitle(g.core.lang:get(403502))

		self._consumeNum_1 = var_2_0.price_add
		self._consumeNum_2 = var_2_0.price_max - (var_2_0.price_min + (self.dataInfo.auction_num - 1) * var_2_0.price_add)
	else
		self.m_biddingBtn:setTitle(g.core.lang:get(403503))
	end
end

function AuctionItemCell:_onUpdate()
	local var_3_0 = var_0_0:getTime()

	if self._isStart then
		if self._leftTime > 0 then
			self._leftTime = math.max(0, math.floor(self.dataInfo.rest_time - var_3_0))

			self.m_timeTxt:setText(var_0_0:_secondToString(self._leftTime))
		elseif self._scheduleHandler then
			self:cancelSchedule(self._scheduleHandler)

			self._scheduleHandler = nil
		end
	elseif self._leftTime > 0 then
		self._leftTime = math.max(0, math.floor(self._startTime - var_3_0))

		self.m_timeTxt:setText(var_0_0:_secondToString(self._leftTime))
	else
		self._isStart = true
		self._leftTime = math.max(0, math.floor(self.dataInfo.rest_time - var_3_0))

		self.m_timeTxt:setText(var_0_0:_secondToString(self._leftTime))
	end
end

function AuctionItemCell:_onClickBidPrice()
	if not self._isStart then
		g.core.module.ModuleManager:tip(g.core.lang:get(403504))

		return
	end

	if self.dataInfo.status == 2 then
		g.core.module.ModuleManager:tip(g.core.lang:get(403517))

		return
	end

	local var_4_0 = g.core.model.User.bagData:getOwnNum(var_0_1.TYPE_GOLD, 0)

	if var_4_0 >= self._consumeNum_1 then
		self:addPopup((require("app.view.module.auction.view.AuctionBuyConfirmPop").new({
			is_bid_price = true,
			costType = 1,
			act_id = self._actId,
			goods_id = self.dataInfo.goods_id,
			prepare_cost_amount = self._consumeNum_1,
			auctionItemId = self.dataInfo.auction_item_id,
			isSelf = self.dataInfo.status == 2
		})))
	else
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			value = 0,
			type = var_0_1.TYPE_GOLD,
			size = var_4_0
		})
	end
end

function AuctionItemCell:_onClickOnePrice()
	if not self._isStart then
		g.core.module.ModuleManager:tip(g.core.lang:get(403504))

		return
	end

	if g.core.model.User:getVipLevel() < self.needVipLevel then
		g.core.module.ModuleManager:tip(g.core.lang:get(403505, {
			level = self.needVipLevel
		}))
	else
		local var_5_0 = g.core.model.User.bagData:getOwnNum(var_0_1.TYPE_GOLD, 0)

		if var_5_0 >= self._consumeNum_2 then
			self:addPopup((require("app.view.module.auction.view.AuctionBuyConfirmPop").new({
				is_bid_price = false,
				costType = 0,
				act_id = self._actId,
				goods_id = self.dataInfo.goods_id,
				prepare_cost_amount = self._consumeNum_2,
				auctionItemId = self.dataInfo.auction_item_id,
				isSelf = self.dataInfo.status == 2
			})))
		else
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				value = 0,
				type = var_0_1.TYPE_GOLD,
				size = var_5_0
			})
		end
	end
end

function AuctionItemCell:_onClickItemIcon()
	local var_6_0 = var_0_2:getItemInfoById(self.dataInfo.auction_item_id)
	local var_6_1 = var_0_1:convert({
		type = var_6_0.type,
		value = var_6_0.value,
		size = var_6_0.size
	})

	if var_6_1 then
		g.core.common.GlobalFunc.pushInfoPop(var_6_1)
	end
end

function AuctionItemCell:onUnload()
	if self._scheduleHandler then
		self:cancelSchedule(self._scheduleHandler)

		self._scheduleHandler = nil
	end
end

return AuctionItemCell
