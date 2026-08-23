local RechargeHotTipKnightBtn = class("RechargeHotTipKnightBtn", require("app.fairyGUI.recharge.UI_RechargeHotTipKnightBtn"))

function RechargeHotTipKnightBtn:ctor()
	self._info = nil

	self:addClickListener(handler(self, self._onClickSearchBtn))
end

function RechargeHotTipKnightBtn:setKnight(arg_2_1)
	self._info = g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_KNIGHT,
		value = arg_2_1
	})

	if self._info then
		self.m_nameText:setText(self._info.name)
		self.m_qualityTextLoader:setURL("ui://text_new/pic_pinzhi_" .. self._info.quality + 1)
		self.m_bgLoader:setURL("ui://base_new/bg_zm_pinzhi_" .. self._info.quality + 1)
	end
end

function RechargeHotTipKnightBtn:_onClickSearchBtn()
	if self._info then
		g.core.common.GlobalFunc.pushInfoPop(self._info)
	end
end

return RechargeHotTipKnightBtn
