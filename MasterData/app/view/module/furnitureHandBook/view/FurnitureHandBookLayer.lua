local var_0_0 = g.core.model.User.furnitureHandBookData
local var_0_2 = g.core.config.furniture_book_info
local var_0_3 = g.core.module.ModuleManager
local var_0_5 = g.core.const.ConstMgr.ShopConst
local FurnitureHandBookLayer = class("FurnitureHandBookLayer", require("app.fairyGUI.furnitureHandBook.UI_FurnitureHandBookLayer"), function()
	return fgui.GComponent:create({
		resName = "FurnitureHandBookLayer",
		pkgPath = "ui/furnitureHandBook/furnitureHandBook",
		isFullScreen = true,
		pkgName = "furnitureHandBook"
	}, ...)
end)

function FurnitureHandBookLayer:ctor()
	self._kitListData = {}
	self._isUpSort = true
	self._isQuality = true

	self.m_upDownBtn:setSelected(true)

	self._curSelect = nil

	self:addBg("bg/furniture/bg_cls_jiajushoucang.jpg")
	self:_initUIListener()
	self.m_enterTransition:play()
end

function FurnitureHandBookLayer:_initUIListener()
	self.m_kitList:setIniter()
	self.m_kitList:doFairyBatching(false)
	self.m_kitList:setItemRendererAsync1(handler(self, self._onKitListItemRender), 0.02, false)
	self.m_kitList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickItem))
	self.m_sortBtn:addClickListener(handler(self, self._onClickSortBtn))
	self.m_shopBtn:addClickListener(handler(self, self._onClickFurnitureShopBtn))
	self.m_upDownBtn:addClickListener(handler(self, self._onClickUpDownBtnSortBtn))
end

function FurnitureHandBookLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FURNITURE_ROOM_FURNISHINGNUMRANK, self._onRecRoomFurnishingnumRank, self)
	g.core.network.GameNetProxy:send_C2S_FurnitureRoom_FurnishingNumRank({})
	self:_updateMainView()
	self:_updateHandBookList(self._isUpSort)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_shopBtn
	})
end

function FurnitureHandBookLayer:_updateMainView()
	self.m_collectTxt:setText(g.core.lang:get(113501, {
		curNum = var_0_0:getOwnFurnituresCount(),
		maxNum = #g.core.config.furniture_info.match(function(arg_6_0)
			return arg_6_0.put == 1
		end)
	}))
end

function FurnitureHandBookLayer:_updateHandBookList(arg_7_1)
	if self._isQuality then
		self._kitListData = var_0_0:getSortDataByQuality(arg_7_1)

		self.m_kitList:setNumItems(#self._kitListData)
	else
		self._kitListData = var_0_0:getSortDataByCollect(arg_7_1)

		self.m_kitList:setNumItems(#self._kitListData)
	end
end

function FurnitureHandBookLayer:receiveCompEvent(arg_8_1, arg_8_2)
	if arg_8_1 == "LIST_SORT_BY_COLLECT" then
		self.m_sortBtn:setTitle(g.core.lang:get(113505))
		self.m_chooseComp:setVisible(false)

		self._isQuality = false

		self:_updateHandBookList(self._isUpSort)
	elseif arg_8_1 == "LIST_SORT_BY_QUALITY" then
		self.m_sortBtn:setTitle(g.core.lang:get(113504))
		self.m_chooseComp:setVisible(false)

		self._isQuality = true

		self:_updateHandBookList(self._isUpSort)
	end
end

function FurnitureHandBookLayer:_onKitListItemRender(arg_9_1, arg_9_2)
	local var_9_0 = var_0_2.get(self._kitListData[arg_9_1 + 1])

	if var_9_0 then
		arg_9_2:updateCell(var_9_0)
	end
end

function FurnitureHandBookLayer:_onClickItem(arg_10_1)
	local var_10_0 = arg_10_1:getDataValue()
	local var_10_1 = self.m_kitList:getChildAt(var_10_0)

	if self._curSelect then
		if var_10_0 == self._curSelect then
			if var_10_1 and var_10_1.m_openTransition then
				var_10_1.m_closeTransition:play()
			end

			self._curSelect = nil
		else
			local var_10_2 = self.m_kitList:getChildAt(self._curSelect)

			if var_10_2 and var_10_2.m_openTransition then
				var_10_2.m_closeTransition:play()
			end

			if var_10_1 and var_10_1.m_openTransition and var_10_1.updateIconList then
				var_10_1:updateIconList()
				var_10_1.m_openTransition:play(handler(self, self.scrollToCurSel))
			end

			self._curSelect = var_10_0
		end
	else
		if var_10_1 and var_10_1.m_openTransition and var_10_1.updateIconList then
			var_10_1:updateIconList()
			var_10_1.m_openTransition:play(handler(self, self.scrollToCurSel))
		end

		self._curSelect = var_10_0
	end
end

function FurnitureHandBookLayer:scrollToCurSel()
	if self._curSelect then
		self.m_kitList:scrollToView(self._curSelect, true)
	end
end

function FurnitureHandBookLayer:_onRecRoomFurnishingnumRank()
	local var_12_0 = var_0_0:getExceedPlayerRatio()

	self.m_isExceedController:setSelectedIndex(checknumber(var_12_0) > 50 and 1 or 0)
	self.m_exceedPlayerDesc:setText(g.core.lang:get(113502, {
		num = var_12_0
	}))
end

function FurnitureHandBookLayer:_onClickFurnitureShopBtn(arg_13_1)
	var_0_3:pushModule(g.view.entrance.SHOP, {
		tabType = var_0_5.SHOP_INFO_TAB_TYPE.FLUSH_TAB_TYPE,
		shopType = var_0_5.SHOP_FLUSH_TYPE.FURNITURE
	})
end

function FurnitureHandBookLayer:_onClickSortBtn()
	self.m_chooseComp:setVisible(not self.m_chooseComp:isVisible())
end

function FurnitureHandBookLayer:_onClickUpDownBtnSortBtn()
	self._isUpSort = self.m_upDownBtn:isSelected()

	self:_updateHandBookList(self._isUpSort)
end

return FurnitureHandBookLayer
