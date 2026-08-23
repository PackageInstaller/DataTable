local var_0_0 = g.core.model.User.knightSoulData
local KnightSoulBagLayer = class("KnightSoulBagLayer", require("app.fairyGUI.knightSoul.UI_KnightSoulBagLayer"), function()
	return fgui.GComponent:create({
		resName = "KnightSoulBagLayer",
		pkgPath = "ui/knightSoul/knightSoul",
		isFullScreen = true,
		pkgName = "knightSoul"
	}, ...)
end)

function KnightSoulBagLayer:ctor()
	self._itemDataList = {}
	self._selectQuality = 0

	self.m_topBarComp:setResInfoById(315)
	self:addBg("bg/common/pic_bb_beijing.jpg")
	self:_initRegisterUI()
	self.m_enterTransition:play()
end

function KnightSoulBagLayer:_initRegisterUI()
	self.m_soulList:setVirtual()
	self.m_soulList:setItemRenderer(handler(self, self._onSoulListItemRender))
	self.m_soulList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickSoulItem))
	self.m_sellBtn:addClickListener(handler(self, self._onClickKnightSoulSellBtn))
	self.m_shopBtn:addClickListener(handler(self, self._onClickShopBtn))
	self.m_groupController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onGroupChanged))
end

function KnightSoulBagLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SELL, handler(self, self._onRcvSell), self)
	self:_updateListView()
end

function KnightSoulBagLayer:onUnload()
	g.core.event.EventManager:removeListenerWithTarget(self)
end

function KnightSoulBagLayer:_onSoulListItemRender(arg_6_1, arg_6_2)
	arg_6_2:updateBagCell(self._itemDataList[arg_6_1 + 1])
end

function KnightSoulBagLayer:_onGroupChanged()
	self._selectQuality = self.m_groupController:getSelectedIndex()

	self:_updateListView()
end

function KnightSoulBagLayer:_updateListView()
	self._itemDataList = var_0_0:getKnightSouls(self._selectQuality)

	self.m_soulList:setNumItems(#self._itemDataList)
	self.m_soulList:transitionShowCells("listIconUiScaleIn", 0.03, 1)

	if #self._itemDataList > 0 then
		self.m_soulList:setSelectedIndex(0)
		self.m_infoComp:updateInfoComp(self._itemDataList[1])
		self.m_isEmptyController:setSelectedIndex(0)
	else
		self.m_isEmptyController:setSelectedIndex(1)
	end
end

function KnightSoulBagLayer:_onClickSoulItem(arg_9_1)
	self.m_infoComp:updateInfoComp(self._itemDataList[arg_9_1:getDataValue() + 1])
end

function KnightSoulBagLayer:_onClickShopBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.KNIGHT_SOUL
	})
end

function KnightSoulBagLayer:_onClickKnightSoulSellBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.KNIGHT_SOUL_SELL)
end

function KnightSoulBagLayer:_onRcvSell()
	self:_updateListView()
end

return KnightSoulBagLayer
