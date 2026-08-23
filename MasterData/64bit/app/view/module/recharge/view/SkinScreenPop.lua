local SkinScreenPop = class("SkinScreenPop", require("app.fairyGUI.recharge.UI_SkinScreenPop"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/recharge/recharge",
		resName = "SkinScreenPop",
		pkgName = "recharge"
	})
end)

function SkinScreenPop:ctor(arg_2_1)
	self._params = arg_2_1

	self.m_confirmBtn:addClickListener(handler(self, self._onConfirm))
	self.m_touchBg:addClickListener(handler(self, self._onClose))
end

function SkinScreenPop:onLoad()
	self.m_selectComp:initComp(self._params)
	self.m_enterTransition:play()
end

function SkinScreenPop:_onConfirm()
	self:dispatchCompEvent("REFRESH_SKIN_INDEX", {
		index = self.m_selectComp:getSelectedIndex()
	})
	self.m_selectComp:onConfirm()
	self:_onClose()
end

function SkinScreenPop:_onClose()
	if not self._hasPop then
		self._hasPop = true

		self.m_backTransition:play(handler(self, function()
			g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		end))
	end
end

return SkinScreenPop
