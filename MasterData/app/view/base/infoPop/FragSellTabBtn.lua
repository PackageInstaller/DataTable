local FragSellTabBtn = class("FragSellTabBtn", require("app.fairyGUI.infoPop.UI_FragSellTabBtn"))

function FragSellTabBtn:ctor()
	self._data = nil

	self:addClickListener(handler(self, self._onClickCell))
end

function FragSellTabBtn:updateBtn(arg_2_1)
	self._data = arg_2_1

	self.m_icon:setIcon((g.core.common.Path:getQualityArtTxtURL(arg_2_1.quality)))
	self.m_buttonController:setSelectedIndex(arg_2_1.selected or 0)
end

function FragSellTabBtn:_onClickCell()
	if self.m_buttonController:getSelectedIndex() == 1 then
		self.m_buttonController:setSelectedIndex(0)
	else
		self.m_buttonController:setSelectedIndex(1)
	end

	self:dispatchCompEvent("TabItemClicked", {
		quality = self._data.quality,
		selectIdx = self.m_buttonController:getSelectedIndex()
	})
end

return FragSellTabBtn
