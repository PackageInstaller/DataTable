local HomeEmbryoPop = class("HomeEmbryoPop", require("app.fairyGUI.home.UI_HomeEmbryoPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/home/home",
		resName = "HomeEmbryoPop",
		pkgName = "home",
		isFullScreen = true
	}, ...)
end)
local var_0_1 = g.core.model.User.homeData

function HomeEmbryoPop:ctor(arg_2_1)
	self.m_funcList:setVirtual(self)
	self.m_funcList:setItemRenderer(handler(self, self._onFuncListItemRender))

	self._embryoData = {}

	self:updateView()
end

function HomeEmbryoPop:onLoad()
	for iter_3_0, iter_3_1 in ipairs(self.m_funcList:getChildren()) do
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = iter_3_1,
			customData = {
				type = iter_3_0
			}
		})
	end
end

function HomeEmbryoPop:updateView()
	self._embryoData = var_0_1:getExpandDataByType(1)

	self.m_funcList:setNumItems(#self._embryoData + 1)
	self.m_enterTransition:play()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_WARMODE)
end

function HomeEmbryoPop:_onFuncListItemRender(arg_5_1, arg_5_2)
	if arg_5_1 < #self._embryoData then
		arg_5_2:updateFuncStatus(self._embryoData[arg_5_1 + 1])
	else
		arg_5_2:updateFuncStatus({
			function_id = 0
		})
	end
end

return HomeEmbryoPop
