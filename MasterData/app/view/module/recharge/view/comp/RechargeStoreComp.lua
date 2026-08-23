local RechargeStoreComp = class("RechargeStoreComp", require("app.fairyGUI.recharge.UI_RechargeStoreComp"))
local var_0_1 = g.core.model.User.shopData
local MultilingualMgr = require("app.core.lang.MultilingualMgr")

function RechargeStoreComp:ctor()
	self._shopInfoList = nil

	self.m_itemList:setVirtual()
	self.m_itemList:setItemRenderer(handler(self, self._onItemListRender))
	self.m_subheadTxt:setVisible(MultilingualMgr:getUseLang() ~= "en")
end

function RechargeStoreComp:_onItemListRender(arg_2_1, arg_2_2)
	if self._shopInfoList and self._shopInfoList[arg_2_1 + 1] then
		arg_2_2:setIconSize(cc.size(36, 36))
		arg_2_2:updateCell(self._shopInfoList[arg_2_1 + 1], arg_2_1)
	end
end

function RechargeStoreComp:updateComp(arg_3_1)
	if arg_3_1 then
		self._params = arg_3_1
	else
		arg_3_1 = self._params
	end

	self._info = arg_3_1.info

	self.m_shopName:setText(self._info.type_name)
	g.core.common.ActivitySort:setSortTp(g.core.common.ActivitySort.SHOP_SHOW)

	self._shopInfoList = var_0_1:getInfo(self._info.shop_type, self._info.shop_first, true)

	if not self._hasUpdate then
		self:newScheduleOnce(handler(self, self._updateItemList), 0.1)

		self._hasUpdate = true
	else
		self:_updateItemList()
	end
end

function RechargeStoreComp:_updateItemList()
	self.m_itemList:setNumItems(0)
	self.m_itemList:setNumItems(#self._shopInfoList)
	self.m_itemList:transitionShowCells("listCardAUiLeftIn", 0.03, 1)
end

function RechargeStoreComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING, handler(self, self._onShop), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ITEM_USE, handler(self, self._onRcvItemUse), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GOLD_EXCHANGE, handler(self, self._updateItemList), self)
end

function RechargeStoreComp:_onShop(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = g.core.config.shop_score_info.get(arg_6_4.info.id)

	self._shopInfoList = var_0_1:getInfo(self._info.shop_type, self._info.shop_first, true)

	self.m_itemList:setNumItems(0)
	self.m_itemList:setNumItems(#self._shopInfoList)

	if var_6_0.type == g.core.common.Goods.TYPE_ITEM and g.core.config.item_info.get(var_6_0.value).if_open == 1 then
		g.core.network.GameNetProxy:send_C2S_Item_Use({
			id = var_6_0.value,
			num = var_6_0.size * arg_6_4.info.num
		})

		return
	end

	local var_6_1 = {
		{
			type = var_6_0.type,
			value = var_6_0.value,
			size = var_6_0.size * arg_6_4.info.num
		}
	}

	if var_6_0.type ~= g.core.common.Goods.TYPE_RESOURCE then
		if arg_6_4.awards then
			var_6_1 = arg_6_4.awards
		end

		g.core.module.ModuleManager:awardSummary(var_6_1)
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
			baseShowReward = var_6_1
		})
	end
end

function RechargeStoreComp:_onRcvItemUse(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	g.core.module.ModuleManager:awardSummary(arg_7_4.awards)
end

function RechargeStoreComp:onUnload()
	return
end

return RechargeStoreComp
