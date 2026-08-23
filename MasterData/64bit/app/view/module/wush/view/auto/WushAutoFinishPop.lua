local WushAutoFinishPop = class("WushAutoFinishPop", require("app.fairyGUI.wush.UI_WushAutoFinishPop"))

function WushAutoFinishPop:ctor()
	self.m_closePanel:addClickListener(handler(self, self._onCloseClick))
end

function WushAutoFinishPop:updateAutoReason(arg_2_1)
	self.m_levelTxt:setText(arg_2_1.levelTxt)
	self.m_resDescTxt:setText(arg_2_1.desc)
end

function WushAutoFinishPop:_onCloseClick()
	self:removeFromParent()
end

return WushAutoFinishPop
