local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.common.Path
local GMSignLookBtn = class("GMSignLookBtn", require("app.fairyGUI.signActivity.UI_GMSignLookBtn"))

function GMSignLookBtn:ctor()
	self._goods = nil

	self:addClickListener(handler(self, self._onClick))
	self.m_knightInfoGroup:setVisible(false)
end

function GMSignLookBtn:initButton(arg_2_1)
	self._goods = var_0_0:convert({
		type = arg_2_1.type,
		value = arg_2_1.value
	})

	if self._goods then
		self.m_qualityBg:setURL(var_0_1:getUserIconQualityStarBg(self._goods.quality))
		self.m_itemNameTxt:setText(self._goods.name)

		if arg_2_1.showInfo then
			self.m_rewardTypeTxt:setText(self._goods.type)
			self.m_qualityImg:setURL(var_0_1:getQualityArtTxtURL(self._goods.quality))
			self.m_knightInfoGroup:setVisible(true)
		end
	end
end

function GMSignLookBtn:_onClick()
	if self._goods then
		g.core.common.GlobalFunc.pushInfoPop(self._goods)
	end
end

return GMSignLookBtn
