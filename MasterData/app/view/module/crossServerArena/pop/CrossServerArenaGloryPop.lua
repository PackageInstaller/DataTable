local var_0_0 = g.core.model.User.crossServerArenaData
local var_0_1 = g.core.const.ConstMgr.CrossServerArenaConst
local var_0_2 = g.core.event.enum
local var_0_3 = g.core.event.EventManager
local CrossServerArenaGloryPop = class("CrossServerArenaGloryPop", require("app.fairyGUI.crossServerArena.UI_CrossServerArenaGloryPop"), function()
	return fgui.GComponent:create({
		resName = "CrossServerArenaGloryPop",
		pkgPath = "ui/crossServerArena/crossServerArena",
		pkgName = "crossServerArena"
	}, ...)
end)

function CrossServerArenaGloryPop:ctor()
	self:showAtCenter()

	self._rankList = {}

	self:_updateView()
end

function CrossServerArenaGloryPop:_updateView()
	self._rankList = var_0_0:getGuildGloryList()

	for iter_3_0 = 1, 3 do
		self["m_gloryComp" .. iter_3_0]:updateGloryComp(self._rankList[iter_3_0])
	end
end

function CrossServerArenaGloryPop:_onRcvReward(arg_4_1, arg_4_2, arg_4_3)
	g.core.module.ModuleManager:awardSummary(arg_4_3.awards or {}, nil, nil, g.core.lang:get(300001))
	self["m_gloryComp" .. arg_4_3.index]:removeAnim()
end

function CrossServerArenaGloryPop:_onCrossDayUpdate()
	local var_5_0 = var_0_0:getSeasonStatus()

	if var_5_0 ~= var_0_1.CTRL_ON_SEASON and var_5_0 ~= var_0_1.CTRL_OFF_SEASON then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

		return
	end

	g.core.network.GameNetProxy:send_C2S_ChiefArena_GuildHonorRank({})
end

function CrossServerArenaGloryPop:onLoad()
	var_0_3:addEventListener(var_0_2.EVENT_NET_S2C_CHIEF_ARENA_GUILDRANKAWARD, self._onRcvReward, self)
	var_0_3:addEventListener(var_0_2.EVENT_NET_S2C_CHIEF_ARENA_GUILDHONORRANK, self._updateView, self)
	var_0_3:addEventListener(var_0_2.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	g.core.network.GameNetProxy:send_C2S_ChiefArena_GuildHonorRank({})
	self.m_enterTransition:play()
end

return CrossServerArenaGloryPop
