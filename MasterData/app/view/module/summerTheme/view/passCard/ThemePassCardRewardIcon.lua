local ThemePassCardRewardCell = class("ThemePassCardRewardCell", require("app.fairyGUI.themePasscard.UI_ThemePassCardRewardIcon"))

function ThemePassCardRewardCell:ctor()
	self._isMatch = false

	self:addClickListener(handler(self, self._onClicked))
end

function ThemePassCardRewardCell:initView(arg_2_1)
	if not self._themeValue then
		self._themeValue = arg_2_1

		local var_2_0 = g.core.const.ConstMgr.ThemeConst.THEME_RES_KEY_ALIAS[arg_2_1] or arg_2_1

		self.m_itemBgLoader:setIcon(g.core.common.Path:getThemePassCardImage("pic_zl_jianglidi2", var_2_0))
		self.m_getLoader:setIcon(g.core.common.Path:getThemePassCardImage("pic_yilingqu", var_2_0))
	end
end

function ThemePassCardRewardCell:updateIcon(arg_3_1, arg_3_2, arg_3_3)
	self._isMatch = arg_3_3
	self._data = arg_3_1

	self.m_itemIcon:setURL((g.core.common.Path:getIconByTypeValue(arg_3_1.type, arg_3_1.value)))
	self.m_numTxt:setText(arg_3_1.size)
	self.m_qualityLoader:setURL((g.core.common.Path:getPassCardRewardIconQuality(arg_3_1.quality)))

	if arg_3_2 then
		self.m_getController:setSelectedIndex(1)
	else
		self.m_getController:setSelectedIndex(0)
	end
end

function ThemePassCardRewardCell:_onClicked()
	if self._isMatch then
		self:dispatchCompEvent("get_free_award")
	else
		g.core.common.GlobalFunc.pushInfoPop(self._data)
	end
end

return ThemePassCardRewardCell
