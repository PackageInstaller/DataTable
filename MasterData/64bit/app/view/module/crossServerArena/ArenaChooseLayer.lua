local var_0_0 = g.core.module.ModuleManager
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.event.enum
local var_0_3 = g.core.model.User.crossServerArenaData
local var_0_4 = g.core.model.User.arenaData
local var_0_5 = g.core.const.ConstMgr.CrossServerArenaConst
local ArenaChooseLayer = class("ArenaChooseLayer", require("app.fairyGUI.crossServerArena.UI_ArenaChooseLayer"), function()
	return fgui.GComponent:create({
		resName = "ArenaChooseLayer",
		pkgName = "crossServerArena",
		isFullScreen = true,
		pkgPath = "ui/crossServerArena/crossServerArena"
	}, ...)
end)

function ArenaChooseLayer:ctor()
	self:_initChooseLayerUI()
	self:_initRegisterListen()
end

function ArenaChooseLayer:_initChooseLayerUI()
	self:addBg("bg/arena/bg_dfjjc_rukoubg.jpg", nil, nil, 1)
	self.m_topBarComp:setResInfoById(var_0_5.TOP_BAR_CHOOSE_LAYER)
	self:_updateView()
end

function ArenaChooseLayer:_initRegisterListen()
	self.m_arenaBtn:addClickListener(handler(self, self._onClickArenaComp))
	self.m_chiefArenaBtn:addClickListener(handler(self, self._onClickCSArenaComp))
end

function ArenaChooseLayer:_updateChiefArenaBtn()
	self.m_chiefArenaBtn:setCtrlState("seasonStatus", {
		index = var_0_3:getSeasonStatus()
	})
	self.m_chiefArenaBtn:updateCell({
		redId = 5000007,
		rank = var_0_3:getCurRank(),
		duration = var_0_3:getDurationString()
	})
end

function ArenaChooseLayer:_updateArenaBtn()
	self.m_arenaBtn:updateCell({
		redId = 5000006,
		rank = var_0_4:getRank()
	})
end

function ArenaChooseLayer:_onCrossDayUpdate()
	g.core.network.GameNetProxy:send_C2S_Arena_GetMainInfo({})

	local var_7_0 = var_0_3:getSeasonStatus()

	if var_7_0 == var_0_5.CTRL_ON_SEASON or var_7_0 == var_0_5.CTRL_OFF_SEASON then
		g.core.network.GameNetProxy:send_C2S_ChiefArena_GetInfo({})
	else
		self:_updateChiefArenaBtn()
	end
end

function ArenaChooseLayer:_updateView()
	self:_updateChiefArenaBtn()
	self:_updateArenaBtn()
end

function ArenaChooseLayer:onLoad()
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_CHIEF_ARENA_NOTICEACTIVITY, self._updateChiefArenaBtn, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_ARENA_GETMAININFO, self._updateArenaBtn, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_CHIEF_ARENA_GETINFO, self._updateChiefArenaBtn, self)
	var_0_1:addEventListener(var_0_2.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	g.core.network.GameNetProxy:send_C2S_Arena_GetMainInfo({})

	local var_9_0 = var_0_3:getSeasonStatus()

	if var_9_0 == var_0_5.CTRL_ON_SEASON or var_9_0 == var_0_5.CTRL_OFF_SEASON then
		g.core.network.GameNetProxy:send_C2S_ChiefArena_GetInfo({})
	end

	self.m_enterTransition:play()
	self.m_arenaBtn:playAnim("arena")
	self.m_chiefArenaBtn:playAnim("chiefArena")
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_BATTLE_PVP)
end

function ArenaChooseLayer:_onClickArenaComp()
	var_0_0:pushModule(g.view.entrance.ARENA)
end

function ArenaChooseLayer:_onClickCSArenaComp()
	local var_11_0 = var_0_3:getSeasonStatus()

	if var_11_0 == var_0_5.CTRL_PRE_SEASON then
		self:_updateChiefArenaBtn()
		var_0_0:tip(g.core.lang:get(411007))
	elseif var_11_0 == var_0_5.CTRL_NONE_SEASON then
		var_0_0:tip(g.core.lang:get(411014))
	else
		var_0_0:pushModule(g.view.entrance.CROSS_SERVER_ARENA)
	end
end

return ArenaChooseLayer
