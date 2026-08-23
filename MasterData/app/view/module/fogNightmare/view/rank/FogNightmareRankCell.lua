local FogNightmareRankCell = class("FogNightmareRankCell", require("app.fairyGUI.fogNightmare.UI_FogNightmareRankCell"))

function FogNightmareRankCell:ctor()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
	self.m_searchBtn:addClickListener(handler(self, self._onSearchBtnClick))
end

function FogNightmareRankCell:updateCell(arg_2_1)
	if arg_2_1.rank <= 3 then
		self.m_indexRank:setCtrlState("rank", {
			index = arg_2_1.rank
		})
	else
		self.m_indexRank:setCtrlState("rank", {
			index = 0
		})
		self.m_indexRank:setTitle(tostring(arg_2_1.rank))
	end

	self.m_stageText:setText(arg_2_1.score or 0)

	local var_2_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_2_1.id)

	self._userId = nil

	if var_2_0 then
		self.m_iconComp:updateAsUser(var_2_0)
		self.m_userNameText:setText(var_2_0.name or "")
		self.m_serverNameText:setText(var_2_0.server_name or "")
		self.m_levelText:setText(g.core.lang:get(120) .. (var_2_0.level or 0))

		self._userId = var_2_0.id

		local var_2_1 = var_2_0.guild_name or ""

		if string.len(var_2_1) == 0 then
			var_2_1 = g.core.lang:get(1012)
		end

		self.m_guildNameText:setText(var_2_1)
		self.m_iconComp:setVisible(true)
	else
		self.m_userNameText:setText("")
		self.m_serverNameText:setText("")
		self.m_levelText:setText("")
		self.m_guildNameText:setText("")
		self.m_iconComp:setVisible(false)
	end
end

function FogNightmareRankCell:_onSearchBtnClick()
	if not self._userId then
		return
	end

	if math.uint64_equal(self._userId, g.core.model.User:getId()) then
		g.core.module.ModuleManager:tip(g.core.lang:get(1162))

		return
	end

	g.core.network.GameNetProxy:send_C2S_Formation_GetOther({
		tp = 2,
		target_id = self._userId
	})
end

return FogNightmareRankCell
