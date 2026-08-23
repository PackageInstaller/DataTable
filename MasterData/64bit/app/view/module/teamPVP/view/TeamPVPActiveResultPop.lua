local var_0_0 = g.core.common.Path
local var_0_1 = g.core.model.User.knightsData
local TeamPVPActiveResultPop = class("TeamPVPActiveResultPop", require("app.fairyGUI.teamPVP.UI_TeamPVPActiveResultPop"), function()
	return fgui.GComponent:create({
		resName = "TeamPVPActiveResultPop",
		pkgName = "teamPVP",
		pkgPath = "ui/teamPVP/teamPVP"
	}, ...)
end)

function TeamPVPActiveResultPop:ctor(arg_2_1)
	if arg_2_1 and arg_2_1.endcall then
		self._endCall = arg_2_1.endcall
	end

	self:showAtCenter()

	self._rankList = {}

	self.m_enterTransition:play()
	self.m_touchComp:addClickListener(handler(self, self._onClickPop))
end

function TeamPVPActiveResultPop:_onClickPop()
	g.core.module.ModuleManager:pushModule(g.view.entrance.TEAM_PVP_MAIN_LAYER)
end

function TeamPVPActiveResultPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, handler(self, self._onRefreshRankList), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self.updateView), self)
	g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
		size = 3,
		id = g.core.network.proto.GROUP_BATTLE_HONOR_CROSS
	})
	g.core.model.User.teamPvpData:setTodayNotPop(true)
end

function TeamPVPActiveResultPop:_onRefreshRankList(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self._rankList = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_4.rank_units or {}) do
		self._rankList[iter_5_1.rank] = iter_5_1
	end

	self:updateView()
end

function TeamPVPActiveResultPop:updateView()
	while self["m_showKnight" .. 1] and self._rankList[1] do
		if self._rankList[1] then
			local var_6_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, self._rankList[1].id)

			if var_6_0 then
				self["m_userName" .. 1]:setText(var_6_0.name)

				local var_6_1 = var_6_0.show_knight_id or 0

				if var_6_1 < 1 then
					var_6_1 = var_6_0.base_id
				end

				self["m_showKnight" .. 1]:setIcon(var_0_0:getKnightBookPicRes(var_0_1:getKnightResInfo({
					knightId = var_6_1,
					skinId = var_6_0.show_knight_dress
				}).painted_id))
			end
		end
	end
end

function TeamPVPActiveResultPop:_onClickClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

	if self._endCall then
		self._endCall()
	end
end

return TeamPVPActiveResultPop
