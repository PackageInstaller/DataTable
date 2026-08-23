local SpireAutoFinishPop = class("SpireAutoFinishPop", require("app.fairyGUI.spire.UI_SpireAutoFinishPop"))

function SpireAutoFinishPop:ctor()
	self.m_closePanel:addClickListener(handler(self, self._onCloseClick))
end

function SpireAutoFinishPop:updateAutoReason(arg_2_1)
	self.m_levelTxt:setText(arg_2_1.levelTxt)
	self.m_resDescTxt:setText(arg_2_1.desc)
end

function SpireAutoFinishPop:_onCloseClick()
	self:removeFromParent()
end

return SpireAutoFinishPop
