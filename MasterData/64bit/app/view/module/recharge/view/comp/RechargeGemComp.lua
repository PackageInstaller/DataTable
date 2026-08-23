local var_0_0 = g.core.const.ConstMgr.RechargeConst
local RechargeGemComp = class("RechargeGemComp", require("app.fairyGUI.recharge.UI_RechargeGemComp"))

function RechargeGemComp:ctor()
	self._productList = nil

	self.m_goodsList:setVirtual()
	self.m_goodsList:setItemRendererAsync1(handler(self, self._onGoodsListRender))
	self.m_compBg:setURL("bg/shop/bg_hongse_1.jpg")
end

function RechargeGemComp:_onGoodsListRender(arg_2_1, arg_2_2)
	if self._productList and self._productList[arg_2_1 + 1] then
		arg_2_2:updateCell(self._productList[arg_2_1 + 1], true)
	end
end

function RechargeGemComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE, handler(self, self._recvChargeInfo), self)
end

function RechargeGemComp:_recvChargeInfo()
	self:updateComp()
end

function RechargeGemComp:updateComp()
	self._productList = self:_getList()

	self.m_goodsList:setNumItems1(#self._productList)
end

function RechargeGemComp:_getList()
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

	return var_6_1
end

function RechargeGemComp:onUnload()
	return
end

return RechargeGemComp
