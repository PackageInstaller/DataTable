local var_0_0 = g.core.common.Goods
local PhoenixGiftLookBtn = class("PhoenixGiftLookBtn", require("app.fairyGUI.phoenixGift.UI_PhoenixGiftLookBtn"))

function PhoenixGiftLookBtn:ctor()
	self._goods = var_0_0:convert((g.core.model.User.firstRechargeData:getLookBtnAward()))

	self:addClickListener(handler(self, self._onClickSelf))
end

function PhoenixGiftLookBtn:updateBtnName()
	if self._goods then
		self.m_bgLoader:setURL("ui://base_new/bg_zm_pinzhi_" .. self._goods.quality + 1)
		self.m_qualityTextLoader:setURL("ui://text_new/pic_pinzhi_" .. self._goods.quality + 1)
		self:setTitle(self._goods.name)
	end
end

function PhoenixGiftLookBtn:_onClickSelf()
	if self._goods then
		g.core.common.GlobalFunc.pushInfoPop(self._goods)
	end
end

return PhoenixGiftLookBtn
