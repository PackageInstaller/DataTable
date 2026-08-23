local MineFailPop = class("MineFailPop", require("app.fairyGUI.mine.UI_MineFailPop"), function()
	return fgui.GComponent:create({
		resName = "MineFailPop",
		pkgPath = "ui/mine/mine",
		pkgName = "mine"
	})
end)

function MineFailPop:ctor()
	self:showAtCenter()
	self:getView():setSize(display.width, display.height)
	self:addClickListener(handler(self, self._onCloseClick))
	self.m_enterTransition:play()
end

function MineFailPop:_onCloseClick()
	if self._closing then
		return
	end

	self._closing = true

	self.m_backTransition:play(handler(self, self.onCloseFinish))
end

function MineFailPop:onCloseFinish()
	self:removeSelf()
end

return MineFailPop
