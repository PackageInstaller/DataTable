local OutpostRecoverSellItemTips = class("OutpostRecoverSellItemTips", require("app.fairyGUI.outpost.UI_OutpostRecoverSellItemTips"))

function OutpostRecoverSellItemTips:updateTipComp(arg_1_1, arg_1_2)
	self.m_nameTxt:setText(g.core.config.outpost_item_info.get(arg_1_1.itemInfo.value).name)
	self.m_effNameTxt:setText(arg_1_2.effDes)

	local var_1_0 = g.core.lang:get(432657, {
		time = arg_1_2.baseTime
	})

	self.m_timeTxt:setText((arg_1_2.timeBonus > 0 or nil) and g.core.lang:get(432656, {
		total = arg_1_2.baseTime - arg_1_2.timeBonus,
		base = arg_1_2.baseTime,
		effectDes = table.concat({
			"-",
			g.core.lang:get(432657, {
				time = arg_1_2.timeBonus
			})
		})
	}))
	self.m_priceTxt:setText((arg_1_2.coinBonus > 0 or nil) and g.core.lang:get(432656, {
		total = math.floor(arg_1_1.cfg.gold * (1 + arg_1_2.coinBonus / 10000)),
		base = arg_1_1.cfg.gold,
		effectDes = table.concat({
			"*",
			100 + arg_1_2.coinBonus / 100,
			"%"
		})
	}))
	self:_updateSizeAndTxtPos()
end

function OutpostRecoverSellItemTips:_updateSizeAndTxtPos()
	local var_2_0 = self.m_effNameTxt:getPosition().x + math.max(math.max(self.m_effNameTxt:getSize().width, self.m_priceTitle:getSize().width), self.m_timeTitle:getSize().width) + 5

	self.m_effValueTxt:setX(var_2_0)
	self.m_priceTxt:setX(var_2_0)
	self.m_timeTxt:setX(var_2_0)

	local var_2_1 = self:getSize()

	var_2_1.width = var_2_0 + math.max(math.max(self.m_effValueTxt:getSize().width, self.m_priceTxt:getSize().width), self.m_timeTxt:getSize().width) + 5

	self:setSize(var_2_1)
end

return OutpostRecoverSellItemTips
