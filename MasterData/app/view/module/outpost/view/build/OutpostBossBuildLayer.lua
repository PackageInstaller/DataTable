local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostBossBuildLayer = class("OutpostBossBuildLayer", require("app.fairyGUI.outpost.UI_OutpostBossBuildLayer"), function()
	return fgui.GComponent:create({
		resName = "OutpostBossBuildLayer",
		pkgPath = "ui/outpost/outpost",
		isFullScreen = true,
		pkgName = "outpost"
	}, ...)
end)

function OutpostBossBuildLayer:ctor()
	self:addBg("bg/outpost/pic_hxsz_jiaoyisuobg.jpg")

	self._buildData = g.core.model.User.outpostData:getBuildData():getBuild({
		type = var_0_0.BuildType.Boss
	})

	self.m_topBarComp:setResInfoById(384)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.common.Scheduler:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end, 0.5)
	self.m_bossInfoComp:setBossCurIdx(self._buildData:getLevel())
end

function OutpostBossBuildLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BUILD_CALLBOSS, handler(self, self._onBossCall), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BUILD_LEVELUP, handler(self, self._onBuildLevelUp), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BOSS_SWEEP, handler(self, self._onSweepBoss), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_DELBOSS, handler(self, self._onBossCancel), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BATTLEFINISH, handler(self, self._onS2CBattleFinish), self)
	self:updateBuildLayer()
end

function OutpostBossBuildLayer:updateBuildLayer()
	self.m_buiodComp:updateBuildInfoComp(self._buildData)
	self.m_bossInfoComp:updateBossComp(self._buildData:getAllBossInfo())
end

function OutpostBossBuildLayer:_onS2CBattleFinish()
	self:updateBuildLayer()
end

function OutpostBossBuildLayer:receiveCompEvent(arg_7_1)
	local var_7_0 = ...

	if arg_7_1 == "callBoss" then
		self:_onSummon(var_7_0)

		return true
	elseif arg_7_1 == "sweepBoss" then
		self:_onSweep(var_7_0)

		return true
	elseif arg_7_1 == "cancelBoss" then
		self:_onCancel(var_7_0)

		return true
	end
end

function OutpostBossBuildLayer:_onSweep(arg_8_1)
	self._buildData:onEffect(arg_8_1)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Boss)
end

function OutpostBossBuildLayer:_onSummon(arg_9_1)
	self._bossCfg = arg_9_1.bossCfg

	self._buildData:onEffect(arg_9_1)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Boss)
end

function OutpostBossBuildLayer:_onCancel(arg_10_1)
	self._bossCfg = arg_10_1.bossCfg

	self._buildData:onEffect(arg_10_1)
end

function OutpostBossBuildLayer:_onBossCall()
	local var_11_0 = g.core.config.outpost_map_info.get(self._bossCfg.map)

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_OUTPOST_JUMP_TO_POS, false, nil, {
		pos = cc.p(var_11_0.boss_x, var_11_0.boss_y)
	})
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function OutpostBossBuildLayer:_onSweepBoss(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	g.core.module.ModuleManager:awardSummary(arg_12_4.awards)
	self:updateBuildLayer()
	g.core.module.ModuleManager:tip(g.core.lang:get(432678))
end

function OutpostBossBuildLayer:_onBossCancel()
	g.core.module.ModuleManager:tip(g.core.lang:get(432677))
	self:updateBuildLayer()
end

function OutpostBossBuildLayer:_onBuildLevelUp()
	self.m_bossInfoComp:setBossCurIdx(self._buildData:getLevel())
	self:updateBuildLayer()
end

return OutpostBossBuildLayer
