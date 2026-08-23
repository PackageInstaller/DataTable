local var_0_0 = g.core.model.User.AuctionData
local DrawKnight = require("app.view.common.DrawKnight")
local AuctionMainLayer = class("AuctionMainLayer", require("app.fairyGUI.auction.UI_AuctionMainLayer"), function()
	return fgui.GComponent:create({
		pkgName = "auction",
		isFullScreen = true,
		pkgPath = "ui/auction/auction",
		resName = "AuctionMainLayer"
	}, ...)
end)

AuctionMainLayer.DRAWKNIGHT_RESID = 510030

function AuctionMainLayer:ctor()
	self.act_id = -1
	self._tabInfo = nil
	self._goodsInfo = nil

	self:addBg("bg/auction/bg_bianjingxieding.jpg", true)
	self.m_topBarComp:setResInfoById(17)
	self.m_recordBtn:addClickListener(handler(self, self._onClickRecord))
	self:_addDrawKnightComp()

	self._tabListInfo = var_0_0:getTabListInfo()

	if not self._tabListInfo then
		return
	end

	self:initViewList()

	local var_2_0 = var_0_0:getSelTabIndex()

	self._goodsInfo = self._tabListInfo[var_2_0].goods
	self.auction_id = self._tabListInfo[var_2_0].auction_id

	if #self._goodsInfo > 0 then
		self.act_id = self._tabListInfo[var_2_0].act_id
		self._tabInfo = {
			act_id = self.act_id
		}
	end

	self.m_topTabList:setSelectedIndex(0)
	var_0_0:setShowMyAuction(false)
	self.m_descTxt:setText(g.core.lang:get(403516))
	self:updateBonus(self._tabListInfo[var_2_0])
	self:updateTopTabList()
	self:updateTabList()
	self:updateView()
	self.m_enterTransition:play()
end

function AuctionMainLayer:_addDrawKnightComp()
	local var_3_0 = {
		dir_res = AuctionMainLayer.DRAWKNIGHT_RESID
	}

	var_3_0.isShowBg = false

	self.m_knightComp:addChild((DrawKnight.new(var_3_0)))
end

function AuctionMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_AUCTION_GETRECORD, self._onRcvGetReword, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_AUCTION_BIDPRICE, self._onRcvBid, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_AUCTION_GOODSNOTIFY, self._onRcvNotify, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_AUCTION_CLICKTAB, self._onRcvClickTab, self)
end

function AuctionMainLayer:_onClickRecord()
	if self.act_id then
		g.core.network.GameNetProxy:send_C2S_Auction_GetRecord({
			act_id = self.act_id
		})
	end
end

function AuctionMainLayer:_onRcvGetReword(arg_6_1, arg_6_2)
	g.core.module.ModuleManager:pushPopup((require("app.view.module.auction.view.AuctionRecodePop").new(arg_6_2.records)))
end

function AuctionMainLayer:_onRcvBid(arg_7_1, arg_7_2)
	if arg_7_2.goods then
		if arg_7_2.ret == 1 then
			if arg_7_2.is_one_mouth_price then
				g.core.module.ModuleManager:tip(g.core.lang:get(403501))
			else
				g.core.module.ModuleManager:tip(g.core.lang:get(403518))
			end
		end

		self:replaceGoodsInfo(arg_7_2.goods, arg_7_2.is_one_mouth_price)
		self:updateView()
	end
end

function AuctionMainLayer:_onRcvNotify(arg_8_1, arg_8_2)
	if arg_8_2.goods then
		self:replaceGoodsInfo(arg_8_2.goods, arg_8_2.is_one_mouth_price)
		self:updateView()
	end
end

function AuctionMainLayer:replaceGoodsInfo(arg_9_1, arg_9_2)
	if not self._goodsInfo then
		return
	end

	for iter_9_0 = #self._goodsInfo, 1, -1 do
		if self._goodsInfo[iter_9_0].goods_id == arg_9_1.goods_id then
			if arg_9_2 then
				table.remove(self._goodsInfo, iter_9_0)

				break
			end

			self._goodsInfo[iter_9_0] = arg_9_1

			break
		end
	end
end

function AuctionMainLayer:_onRcvClickTab(arg_10_1, arg_10_2)
	if not arg_10_2 or not arg_10_2.auction then
		return
	end

	if self.is_click_Big_Tab then
		var_0_0:updateAuctionInfo(arg_10_2.auction, true)

		self.act_id = arg_10_2.auction.act_id
		self.auction_id = arg_10_2.auction.auction_id

		self:updateBonus(arg_10_2.auction)
	end

	self._tabListInfo = var_0_0:getTabListInfo()
	self._goodsInfo = arg_10_2.auction and arg_10_2.auction.goods and arg_10_2.auction.goods or {}

	self:updateTabList()
	self:updateView()
end

function AuctionMainLayer:updateTopTabList()
	local var_11_0 = var_0_0:getSubTabGoodsListData(self.auction_id, self.act_id)

	if var_11_0 and #var_11_0 > 0 then
		self._topTabData = var_11_0

		self.m_topTabList:setNumItems(#var_11_0)
		self.m_topTabList:setVisible(#var_11_0 > 2)
	end
end

function AuctionMainLayer:initViewList()
	self.m_tabList:setVirtual()
	self:addListen(self.m_tabList)
	self.m_tabList:setItemRenderer(handler(self, self._onTabListItemRenderer))
	self.m_contentList:setVirtual()
	self.m_contentList:setItemRenderer(handler(self, self._onContenItemRender))
	self.m_topTabList:setVirtual()
	self.m_topTabList:setItemRenderer(handler(self, self._topTabItemRenderer))
	self.m_topTabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._topTabClickItem))
end

function AuctionMainLayer:_onTabListItemRenderer(arg_13_1, arg_13_2)
	if self._tabListInfo[arg_13_1 + 1] then
		arg_13_2:updateCell(self._tabListInfo[arg_13_1 + 1])
	end
end

function AuctionMainLayer:_topTabItemRenderer(arg_14_1, arg_14_2)
	if self._topTabData then
		arg_14_2:setTitle(self._topTabData[arg_14_1 + 1].title)
	end
end

function AuctionMainLayer:_topTabClickItem(arg_15_1)
	local var_15_0 = arg_15_1:getDataValue() + 1

	g.core.network.GameNetProxy:send_C2S_Auction_ClickTab(self._topTabData[var_15_0].tabInfo)
	var_0_0:setShowMyAuction(var_15_0 == #self._topTabData)
end

function AuctionMainLayer:_onContenItemRender(arg_16_1, arg_16_2)
	arg_16_2:updateCell({
		data = self.showInfo[arg_16_1 + 1],
		act_id = self.act_id
	})
end

function AuctionMainLayer:updateTabList()
	self.m_tabList:setNumItems(#self._tabListInfo)
end

function AuctionMainLayer:_onClickTab(arg_18_1)
	if not arg_18_1 then
		return
	end

	if arg_18_1.sonTabList then
		self.is_click_Big_Tab = true
		self._tabInfo = {
			act_id = arg_18_1.act_id
		}

		if arg_18_1.act_id >= 0 and arg_18_1.auction_id > 0 then
			g.core.network.GameNetProxy:send_C2S_Auction_ClickTab(self._tabInfo)
		else
			for iter_18_0, iter_18_1 in ipairs(self._tabListInfo) do
				if iter_18_1.auction_id == arg_18_1.auction_id and iter_18_1.act_id == arg_18_1.act_id then
					arg_18_1.isOpen = not arg_18_1.isOpen
					iter_18_1.isSelect = true
				else
					iter_18_1.isSelect = false
					iter_18_1.isOpen = false
				end
			end

			self.act_id = arg_18_1.act_id
			self.auction_id = arg_18_1.auction_id

			self:updateBonus(arg_18_1)
			self:updateTabList()

			self._goodsInfo = arg_18_1.goods

			self:updateView()
		end
	end
end

function AuctionMainLayer:updateView()
	if not self._goodsInfo then
		self.m_isEmptyController:setSelectedIndex(1)

		return
	end

	self:_updateList()

	if self._scheduleHandler then
		self:cancelSchedule(self._scheduleHandler)

		self._scheduleHandler = nil
	end

	if #self.showInfo > 0 then
		self._scheduleHandler = self:newSchedule(handler(self, self._onUpdate), 1)
	end
end

function AuctionMainLayer:_onUpdate()
	if not self._goodsInfo then
		return
	end

	local var_20_0 = false
	local var_20_1 = g.core.common.ServerTime:getTime()

	for iter_20_0 = #self._goodsInfo, 1, -1 do
		if var_20_1 >= self._goodsInfo[iter_20_0].rest_time then
			table.remove(self._goodsInfo, iter_20_0)

			var_20_0 = true
		end
	end

	if var_20_0 then
		self:_updateList()
	end

	if #self._goodsInfo == 0 and self._scheduleHandler then
		self:cancelSchedule(self._scheduleHandler)

		self._scheduleHandler = nil
	end
end

function AuctionMainLayer:_updateList()
	self.showInfo = {}

	if var_0_0:getShowMyAuction() then
		for iter_21_0, iter_21_1 in ipairs(self._goodsInfo) do
			if iter_21_1.status == 2 then
				table.insert(self.showInfo, iter_21_1)
			end
		end
	else
		self.showInfo = self._goodsInfo
	end

	self.m_isEmptyController:setSelectedIndex(#self.showInfo > 0 and 0 or 1)
	table.sort(self.showInfo, function(arg_22_0, arg_22_1)
		local var_22_0 = var_0_0:getItemInfoById(arg_22_0.auction_item_id).order
		local var_22_1 = var_0_0:getItemInfoById(arg_22_1.auction_item_id).order

		if var_22_0 == var_22_1 then
			return arg_22_0.goods_id < arg_22_1.goods_id
		else
			return var_22_0 < var_22_1
		end
	end)
	self.m_contentList:setNumItems(#self.showInfo)
	self.m_contentList:transitionShowCells("enter_left", 0.03, 1)
end

function AuctionMainLayer:updateBonus(arg_23_1)
	self.m_isJoinController:setSelectedIndex(arg_23_1.bonus > 0 and 1 or 0)
	self.m_awardCount:updateByTVS({
		value = 0,
		type = g.core.common.Goods.TYPE_GOLD,
		size = arg_23_1.bonus
	})
end

function AuctionMainLayer:receiveCompEvent(arg_24_1, arg_24_2)
	if arg_24_1 == "Auction_item_click" then
		if arg_24_2.data == nil then
			return
		end

		self:_onClickTab(arg_24_2.data)
		self.m_topTabList:setSelectedIndex(0)
		var_0_0:setShowMyAuction(false)

		if arg_24_2.data.act_id == 0 then
			self.m_descTxt:setText(g.core.lang:get(403514))
		elseif not arg_24_2.data.has_goods then
			self.m_descTxt:setText(g.core.lang:get(403515))
		else
			self.m_descTxt:setText(g.core.lang:get(403516))
		end
	end
end

function AuctionMainLayer:onUnload()
	g.core.network.GameNetProxy:send_C2S_Auction_Quit({})
end

return AuctionMainLayer
