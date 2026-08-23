local HomeCultivationLayer = class("HomeCultivationLayer", require("app.fairyGUI.home.UI_HomeCultivationLayer"), function()
	return fgui.GComponent:create({
		resName = "HomeCultivationLayer",
		pkgPath = "ui/home/home",
		isFullScreen = true,
		pkgName = "home"
	}, ...)
end)
local var_0_1 = g.core.model.User.homeData

function HomeCultivationLayer:ctor(arg_2_1)
	self.m_topBarComp:setResInfoById(255)
	self.m_funcList:setVirtual(self)
	self.m_funcList:setItemRenderer(handler(self, self._onFuncListItemRender))
	self:addBg("bg/homeCultivation/bg_yangcheng.jpg")

	self._cultivationData = {}

	self:updateView()
end

function HomeCultivationLayer:onLoad()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_ENERGYENTER)
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_MAIN_MENU)

	for iter_3_0, iter_3_1 in ipairs(self.m_funcList:getChildren()) do
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = iter_3_1,
			customData = {
				type = iter_3_0
			}
		})
	end
end

function HomeCultivationLayer:updateView()
	self._cultivationData = var_0_1:getExpandDataByType(2)

	self.m_funcList:setNumItems(#self._cultivationData + 1)
	self.m_enterTransition:play()
	self.m_funcList:transitionShowCells("enter", 0.03)
end

function HomeCultivationLayer:_onFuncListItemRender(arg_5_1, arg_5_2)
	if arg_5_1 < #self._cultivationData then
		arg_5_2:updateFuncStatus(self._cultivationData[arg_5_1 + 1])
	else
		arg_5_2:updateFuncStatus({
			function_id = 0
		})
	end
end

return HomeCultivationLayer
