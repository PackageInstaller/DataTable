local DungeonFindHostPop = class("DungeonFindHostPop", require("app.fairyGUI.infoPop.UI_DungeonFindHostPop"), function()
	return fgui.GComponent:create({
		pkgName = "infoPop",
		resName = "DungeonFindHostPop",
		pkgPath = "ui/infoPop/infoPop"
	})
end)

function DungeonFindHostPop:ctor(arg_2_1)
	self._args = arg_2_1

	self:showAtCenter()
	self:getView():setWidth(display.width)
	self:getView():getTransition("enter"):play(handler(self, self._onPlayFinish))
end

function DungeonFindHostPop:_onPlayFinish()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.function.DungeonHostInfoPop").new(self._args), {
		touchDisappear = true
	})
	self:removeSelf()
end

return DungeonFindHostPop
