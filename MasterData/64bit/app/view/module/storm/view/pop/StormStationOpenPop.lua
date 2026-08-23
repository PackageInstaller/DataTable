local StormStationOpenPop = class("StormStationOpenPop", require("app.fairyGUI.storm.UI_StormStationOpenPop"), function()
	return fgui.GComponent:create({
		resName = "StormStationOpenPop",
		pkgName = "storm",
		isFullScreen = true,
		pkgPath = "ui/storm/storm"
	}, ...)
end)

function StormStationOpenPop:ctor(arg_2_1)
	if arg_2_1 and arg_2_1.callFunc then
		self._callFunc = arg_2_1.callFunc
	end
end

function StormStationOpenPop:onLoad()
	self.m_enterTransition:play(handler(self, self._onCloseSelf))
end

function StormStationOpenPop:onUnload()
	if self._callFunc then
		self._callFunc()
	end
end

function StormStationOpenPop:_onCloseSelf()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return StormStationOpenPop
