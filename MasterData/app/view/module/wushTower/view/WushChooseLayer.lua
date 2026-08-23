local var_0_0 = g.core.const.ConstMgr.WushTowerConst
local WushChooseLayer = class("WushChooseLayer", require("app.fairyGUI.wushTower.UI_WushChooseLayer"), function()
	return fgui.GComponent:create({
		resName = "WushChooseLayer",
		pkgPath = "ui/wushTower/wushTower",
		isFullScreen = true,
		pkgName = "wushTower"
	}, ...)
end)

function WushChooseLayer:ctor()
	self:_initChooseLayerUI()
	self:_initRegisterListen()
end

function WushChooseLayer:_initChooseLayerUI()
	self:addBg("bg/wushTower/bg_srhy_select.jpg", nil, nil, 1)
	self.m_topBarComp:setResInfoById(var_0_0.CHOOSE_LAYER_TOPBAR)
end

function WushChooseLayer:_initRegisterListen()
	self.m_hardWushComp:addClickListener(handler(self, self._onClickHardWush))
	self.m_normalWushComp:addClickListener(handler(self, self._onClickNormalWush))
end

function WushChooseLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DEAD_TOWER_ENTERINFO, self._S2CDeadTowerEnterInfo, self)
	g.core.network.GameNetProxy:send_C2S_DeadTower_EnterInfo({})
	self.m_enterTransition:play()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_SY_ENTRANCE)
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_ABYSS)
end

function WushChooseLayer:onUnload()
	g.core.event.EventManager:removeListenerWithTarget(self)
end

function WushChooseLayer:_S2CDeadTowerEnterInfo()
	self.m_hardWushComp:updateEntranceInfo()
	self.m_normalWushComp:updateEntranceInfo()
end

function WushChooseLayer:_onClickNormalWush()
	g.core.module.ModuleManager:pushModule(g.view.entrance.WUSH)
end

function WushChooseLayer:_onClickHardWush()
	g.core.module.ModuleManager:pushModule(g.view.entrance.WUSH_TOWER)
end

return WushChooseLayer
