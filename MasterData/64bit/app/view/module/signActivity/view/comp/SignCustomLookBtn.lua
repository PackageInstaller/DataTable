local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.common.Path
local SignCustomLookBtn = class("SignCustomLookBtn", require("app.fairyGUI.signActivity.UI_SignCustomLookBtn"))

function SignCustomLookBtn:ctor()
	self._goods = nil

	self:addClickListener(handler(self, self._onClick))
end

function SignCustomLookBtn:initButton(arg_2_1)
	self._goods = var_0_0:convert({
		type = arg_2_1.reward_type,
		value = arg_2_1.reward_value
	})

	if self._goods then
		self.m_qualityImg:setURL(var_0_1:getQualityArtTxtURL(self._goods.quality))
		self.m_qualityBg:setURL(var_0_1:getUserIconQualityStarBg(self._goods.quality))
		self.m_itemNameTxt:setText(self._goods.name)
	end
end

function SignCustomLookBtn:_onClick()
	if self._goods then
		g.core.common.GlobalFunc.pushInfoPop(self._goods)
	end
end

return SignCustomLookBtn
