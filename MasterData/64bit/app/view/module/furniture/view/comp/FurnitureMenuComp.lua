local var_0_0 = g.core.const.ConstMgr.FUNCTION_TYPE
local FurnitureMenuComp = class("FurnitureMenuComp", require("app.fairyGUI.furniture.UI_FurnitureMenuComp"))

function FurnitureMenuComp:ctor()
	self.m_visitBtn:addClickListener(handler(self, self._onClickVisitBtn))
	self.m_shopBtn:addClickListener(handler(self, self._onClickshopBtn))
	self.m_charmRankBtn:addClickListener(handler(self, self._onClickCharmRankBtn))
	self.m_menuBtn:addClickListener(handler(self, self._onClickMenu))
end

function FurnitureMenuComp:onLoad()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_menuBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_visitBtn
	})
end

function FurnitureMenuComp:_onClickMenu()
	if self.m_isSelectController:getSelectedIndex() == 1 then
		self.m_backTransition:play(function()
			self.m_isSelectController:setSelectedIndex(0)
		end)
	else
		self.m_isSelectController:setSelectedIndex(1)
		self.m_enterTransition:play()
	end
end

function FurnitureMenuComp:_onClickVisitBtn()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_0.FRIEND) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.FRIEND)
	end
end

function FurnitureMenuComp:_onClickshopBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.FLUSH_TAB_TYPE,
		shopType = g.core.const.ConstMgr.ShopConst.SHOP_FLUSH_TYPE.FURNITURE
	})
end

function FurnitureMenuComp:_onClickCharmRankBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FURNITURE_CHARM_RANK)
end

return FurnitureMenuComp
