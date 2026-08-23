local RechargeCompTipsPop = class("RechargeCompTipsPop", require("app.fairyGUI.recharge.UI_RechargeCompTipsPop"), function()
	return fgui.GComponent:create({
		resName = "RechargeCompTipsPop",
		pkgPath = "ui/recharge/recharge",
		pkgName = "recharge"
	})
end)
local var_0_1 = g.core.const.ConstMgr.RechargeConst
local var_0_2 = g.core.common.Goods

function RechargeCompTipsPop:ctor()
	self:showAtCenter()
	self.m_ruleList:setVirtual()
	self.m_ruleList:setItemRenderer(handler(self, self._onListRender))

	local var_2_0 = g.core.model.User.rechargeData:getIdsByType(var_0_1.RECHARGE_TYPE.GOLD)

	self._list = {}

	if var_2_0 then
		for iter_2_0 = 1, #var_2_0 do
			local var_2_1 = g.core.model.User.rechargeData:getRechargeInfoById(var_2_0[iter_2_0])

			if var_2_1 and var_2_1.seen == 1 and var_2_1.extra_gift_type > 0 then
				table.insert(self._list, var_2_1)
			end
		end
	end

	self.m_ruleList:setNumItems(#self._list)
end

function RechargeCompTipsPop:_onListRender(arg_3_1, arg_3_2)
	if self._list and self._list[arg_3_1 + 1] then
		local var_3_0 = g.core.model.User.rechargeData:getRechargeInfoByTypeAndPrice(g.core.const.ConstMgr.RechargeConst.RECHARGE_TYPE.GOLD, self._list[arg_3_1 + 1].money)

		if self._list[arg_3_1 + 1].extra_gift_type_1 > 0 then
			arg_3_2:getChild("tipText"):setText(g.core.lang:get(409607, {
				name1 = var_3_0.moneyUnit .. var_3_0.realMoney,
				name2 = var_0_2:convert({
					type = self._list[arg_3_1 + 1].extra_gift_type,
					value = self._list[arg_3_1 + 1].extra_gift_value
				}).name,
				num = self._list[arg_3_1 + 1].extra_gift_size,
				name3 = var_0_2:convert({
					type = self._list[arg_3_1 + 1].extra_gift_type_1,
					value = self._list[arg_3_1 + 1].extra_gift_value_1
				}).name,
				num3 = self._list[arg_3_1 + 1].extra_gift_size_1
			}))
		else
			local var_3_1 = {
				name1 = var_3_0.moneyUnit .. var_3_0.realMoney
			}

			var_3_1.name2 = var_0_2:convert({
				type = self._list[arg_3_1 + 1].extra_gift_type,
				value = self._list[arg_3_1 + 1].extra_gift_value
			}).name
			var_3_1.num = self._list[arg_3_1 + 1].extra_gift_size

			arg_3_2:getChild("tipText"):setText(g.core.lang:get(409606, var_3_1))
		end
	end
end

return RechargeCompTipsPop
