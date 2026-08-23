local var_0_0 = g.core.const.ConstMgr.RechargeConst
local var_0_1 = g.core.model.User.shopData
local var_0_2 = g.core.const.ConstMgr.ShopConst
local RechargeSpreeComp = class("RechargeSpreeComp", require("app.fairyGUI.recharge.UI_RechargeSpreeComp"))

function RechargeSpreeComp:ctor()
	self._productList = nil

	self.m_spreeList:setVirtual()
	self.m_spreeList:setItemRendererAsync1(handler(self, self._onGoodsListRender))
end

function RechargeSpreeComp:_onGoodsListRender(arg_2_1, arg_2_2)
	if self._productList and self._productList[arg_2_1 + 1] then
		arg_2_2:updateCell(self._productList[arg_2_1 + 1], true)
	end
end

function RechargeSpreeComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE, handler(self, self._recvChargeInfo), self)
end

function RechargeSpreeComp:_recvChargeInfo()
	self:updateComp()
end

function RechargeSpreeComp:updateComp()
	self._productList = var_0_1:getInfo(var_0_2.SHOP_TYPE.SHOP, 2, true)

	self.m_spreeList:setNumItems1(#self._productList)
end

function RechargeSpreeComp:_getList()
	local var_6_0 = g.core.model.User.rechargeData:getIdsByType(var_0_0.RECHARGE_TYPE.GOD_BOX)
	local var_6_1 = {}

	if var_6_0 then
		for iter_6_0 = 1, #var_6_0 do
			local var_6_2 = g.core.model.User.rechargeData:getRechargeInfoById(var_6_0[iter_6_0])

			if var_6_2 and var_6_2.seen == 1 then
				table.insert(var_6_1, var_6_2)
			end
		end
	end

	for iter_6_1, iter_6_2 in g.core.config.recharge_info.ipairs() do
		if iter_6_2.app_id == "1" and iter_6_2.recharge_type == 7 then
			table.insert(var_6_1, iter_6_2)
		end
	end

	return var_6_1
end

function RechargeSpreeComp:onUnload()
	return
end

return RechargeSpreeComp
