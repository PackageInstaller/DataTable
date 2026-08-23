local OutpostMainCityLayer = class("OutpostMainCityLayer", require("app.fairyGUI.outpost.UI_OutpostMainCityLayer"), function()
	return fgui.GComponent:create({
		pkgName = "outpost",
		isFullScreen = true,
		pkgPath = "ui/outpost/outpost",
		resName = "OutpostMainCityLayer"
	}, ...)
end)

function OutpostMainCityLayer:ctor()
	self:addBg("bg/outpost/pic_hxsz_jiaoyisuobg.jpg")

	self._buildData = g.core.model.User.outpostData:getBuildData():getMainCity()

	self.m_topBarComp:setResInfoById(380)
	self.m_cityInfoComp:setOtherUpEffectFunc(handler(self, function(arg_3_0)
		arg_3_0.m_infoComp:playUpEffect()
	end))
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.common.Scheduler:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end, 0.5)
end

function OutpostMainCityLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BUILD_LEVELUP, handler(self, self.updateCityLayer), self)
	self:updateCityLayer()
end

function OutpostMainCityLayer:updateCityLayer()
	self.m_cityInfoComp:updateBuildInfoComp(self._buildData)
	self.m_infoComp:updateMainCityComp(self._buildData)
end

return OutpostMainCityLayer
