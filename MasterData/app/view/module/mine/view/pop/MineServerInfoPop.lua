local var_0_0 = g.core.config.mine_desc_info
local MineConst = require("app.view.module.mine.const.MineConst")
local MineServerInfoPop = class("MineServerInfoPop", require("app.fairyGUI.mine.UI_MineServerInfoPop"), function()
	return fgui.GComponent:create({
		resName = "MineServerInfoPop",
		pkgPath = "ui/mine/mine",
		pkgName = "mine"
	})
end)

function MineServerInfoPop:ctor()
	self:showAtCenter()
	self.m_serverList:setVirtual()
	self.m_serverList:setItemRenderer(handler(self, self._onServerListRender))

	self._isCrossServer = (g.core.model.User.mineData:getActivtyType() or MineConst.ACTIVITY_TYPE.CROSS_SERVER) == MineConst.ACTIVITY_TYPE.CROSS_SERVER
end

function MineServerInfoPop:onLoad()
	self:updateStage()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_GETLEAGUESTATUS, handler(self, self._onRcvLeagueStatus), self)

	if self._isCrossServer then
		g.core.network.GameNetProxy:send_C2S_Mine_GetLeagueStatus({})
	end
end

function MineServerInfoPop:_updateCountdown()
	local var_4_0 = g.core.common.ServerTime:getTime()

	g.common.ServerTime:getActivityLeftTime(g.core.model.User.mineData:getSeasonEndTime() - var_4_0)
	g.common.ServerTime:getActivityLeftTime(g.model.User.mineData:getNewLeagueStartTime() - var_4_0)
end

function MineServerInfoPop:_onRcvLeagueStatus(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self._servers = arg_5_4.serverInfo or {}

	table.sort(self._servers, function(arg_6_0, arg_6_1)
		return g.core.lang:getServerNo(arg_6_0.serverName) < g.core.lang:getServerNo(arg_6_1.serverName)
	end)
	self.m_serverList:setNumItems(#self._servers)
end

function MineServerInfoPop:updateStage()
	local var_7_0 = g.core.model.User.mineData:getTimeStage()
	local var_7_2 = var_7_0 == MineConst.TIME_STAGE.NORMAL and var_0_0.get(1) or var_7_0 == MineConst.TIME_STAGE.TOTAL_WAR and var_0_0.get(2) or var_0_0.get(3)
	local var_7_3 = g.core.model.User.mineData:getTimeStage()

	if var_7_3 == MineConst.TIME_STAGE.NOT_AVAILABLE then
		self.m_stateController:setSelectedIndex(0)
	elseif var_7_3 == MineConst.TIME_STAGE.NORMAL then
		self.m_stateController:setSelectedIndex(0)
	elseif var_7_3 == MineConst.TIME_STAGE.TOTAL_WAR then
		self.m_stateController:setSelectedIndex(1)
	elseif var_7_3 == MineConst.TIME_STAGE.RESULT then
		self.m_stateController:setSelectedIndex(2)
	end

	local var_7_8 = {
		g.core.model.User.mineData:getSeasonStartTime(),
		g.core.model.User.mineData:getTotalWarTime(),
		(g.core.model.User.mineData:getSeasonEndTime())
	}

	for iter_7_0 = 1, 3 do
		self["m_desc" .. iter_7_0]:setText(g.core.config.mine_desc_info.indexOf(iter_7_0).stage_desc)

		local var_7_9 = g.core.common.ServerTime:getDateObject(var_7_8[iter_7_0])
		local var_7_10 = g.core.common.ServerTime:getDateYMDHFormat(var_7_8[iter_7_0])

		if var_7_9.min > 0 then
			var_7_10 = var_7_10 .. g.core.lang:get(307538, {
				minute = var_7_9.min
			})
		elseif config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.EN then
			var_7_10 = var_7_10 .. g.core.lang:get(307538, {
				minute = "00"
			})
		end

		self["m_time" .. iter_7_0]:setText(var_7_10)
	end
end

function MineServerInfoPop:_onServerListRender(arg_8_1, arg_8_2)
	if self._servers[arg_8_1 + 1] then
		arg_8_2:setTitle((g.core.lang:getFormatServerName(self._servers[arg_8_1 + 1].serverName)))
	end
end

return MineServerInfoPop
