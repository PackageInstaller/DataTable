local HomeSmallEmbryoPop1 = class("HomeSmallEmbryoPop1", require("app.fairyGUI.home.UI_HomeSmallEmbryoPop1"), function()
	return fgui.GComponent:create({
		resName = "HomeSmallEmbryoPop1",
		pkgPath = "ui/home/home",
		pkgName = "home"
	}, ...)
end)
local var_0_1 = 4
local var_0_2 = g.core.model.User.homeData

function HomeSmallEmbryoPop1:ctor(arg_2_1)
	self._count = 0
	self._expandType = arg_2_1.expandType or 1
	self._dir = arg_2_1.dir or cc.p(0, 0)
	self._embryoData = {}
	self._pos = g.core.model.User.homeData:getPopPos()

	self:updateView()
	self:addClickListener(handler(self, self._clickListClose))
end

function HomeSmallEmbryoPop1:onLoad()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.common.Scheduler:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end, 0.2)
end

function HomeSmallEmbryoPop1:updateView()
	self._embryoData = var_0_2:getExpandDataByType(self._expandType)

	self.m_enterTransition:play()

	for iter_5_0 = 1, var_0_1 do
		local var_5_0 = self:getChild("cell" .. iter_5_0)

		if self._embryoData[iter_5_0] then
			var_5_0:updateFuncStatus(self._embryoData[iter_5_0])
			var_5_0:setVisible(true)
		else
			var_5_0:setVisible(false)
		end
	end

	self:getView():setPosition(cc.p(self._pos.x - self:getView():getWidth() / 2 + self._dir.x, display.height - self._pos.y - self:getView():getHeight() + self._dir.y))
end

function HomeSmallEmbryoPop1:_clickListClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return HomeSmallEmbryoPop1
