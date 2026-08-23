local HomeSmallEmbryoPop = class("HomeSmallEmbryoPop", require("app.fairyGUI.home.UI_HomeSmallEmbryoPop"), function()
	return fgui.GComponent:create({
		resName = "HomeSmallEmbryoPop",
		pkgPath = "ui/home/home",
		pkgName = "home"
	}, ...)
end)
local var_0_1 = 4
local var_0_2 = g.core.model.User.homeData

function HomeSmallEmbryoPop:ctor(arg_2_1)
	self._count = 0
	self._expandType = arg_2_1.expandType or 1

	self.m_showList:setIniter(self)
	self.m_showList:addClickListener(handler(self, self._clickListClose))
	self.m_showList:setItemRenderer(handler(self, self._onFuncListItemRender))

	self._embryoData = {}
	self._pos = g.core.model.User.homeData:getPopPos()

	self:updateView()
end

function HomeSmallEmbryoPop:onLoad()
	return
end

function HomeSmallEmbryoPop:updateView()
	self._embryoData = var_0_2:getExpandDataByType(self._expandType)

	self.m_enterTransition:play()

	local var_4_0 = math.ceil(#self._embryoData / var_0_1)

	self._count = var_4_0

	self.m_showList:setNumItems(var_4_0)
	self.m_showList:resizeToFit(var_4_0)
	self:getView():setPosition(cc.p(self._pos.x - self:getView():getWidth() / 2, display.height - self._pos.y - self:getView():getHeight()))
end

function HomeSmallEmbryoPop:_onFuncListItemRender(arg_5_1, arg_5_2)
	for iter_5_0 = 1, var_0_1 do
		local var_5_0 = arg_5_2:getChild("cell" .. iter_5_0)

		if self._embryoData[(self._count - arg_5_1 - 1) * var_0_1 + iter_5_0] then
			var_5_0:updateFuncStatus(self._embryoData[(self._count - arg_5_1 - 1) * var_0_1 + iter_5_0])
			var_5_0:setVisible(true)
		else
			var_5_0:setVisible(false)
		end
	end
end

function HomeSmallEmbryoPop:_clickListClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return HomeSmallEmbryoPop
