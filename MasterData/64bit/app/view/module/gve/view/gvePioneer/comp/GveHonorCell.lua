local var_0_0 = g.core.config.gve_boss_info
local var_0_2 = g.core.model.User.gveDataMgr
local var_0_3 = g.core.const.ConstMgr.GveConst
local GveHonorCell = class("GveHonorCell", require("app.fairyGUI.gve.UI_GveHonorCell"))

function GveHonorCell:ctor()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
	self.m_awardBtn:addClickListener(handler(self, self._onAwardClick))
	self.m_rankBtn:addClickListener(handler(self, self._onRankClick))

	self._deadTxt = self.m_bossTipTxt:getText()
end

function GveHonorCell:_onAwardClick()
	if self._cellData then
		g.core.network.GameNetProxy:send_C2S_GVE_GetBossAward({
			id = self._cellData.id
		})
	end
end

function GveHonorCell:_onRankClick()
	if self._cellData then
		local var_3_0 = var_0_0.get(self._cellData.id)

		g.core.module.ModuleManager:pushPopup(require("app.view.module.gve.view.gveStage.GveBossRankPop").new((var_0_2:getGveData():getBossData(self._cellData.id, var_3_0.x, var_3_0.y))), {
			ignoreTouch = false,
			touchDisappear = false
		})
	end
end

function GveHonorCell:updateCell(arg_4_1, arg_4_2)
	self._cellData = arg_4_2

	self.m_bgController:setSelectedIndex(arg_4_1 % 2 == 0 and 0 or 1)

	local var_4_0 = var_0_0.get(arg_4_2.id)

	self.m_bossNameTxt:setText(var_4_0.name)
	self.m_bossTipTxt:setText(self._deadTxt)
	self.m_bossIconLoader:setURL(g.core.common.Path:getKnightIconById(var_4_0.image))

	if var_0_2:getGveTimeState() == var_0_3.GVE_TIME_STATE.RESULT then
		self.m_rankBtn:setVisible(false)
	else
		self.m_rankBtn:setVisible(true)
	end

	self.m_awardBtn:setVisible(false)

	if arg_4_2.isDead then
		self.m_isDeadController:setSelectedIndex(1)

		local var_4_1 = var_0_2:getPioneerTeamId()

		if var_4_1 and var_4_1 > 0 then
			self.m_awardBtn:setVisible(true)
		end

		if var_0_2:isAwardHonor(arg_4_2.id) then
			self.m_awardBtn:setVisible(false)
		end

		if var_0_2:getGveData():getBossData(var_4_0.id, var_4_0.x, var_4_0.y):hasExpireTime() then
			self.m_bossTipTxt:setText(g.core.lang:get(309202))
		end

		if not arg_4_2.userId then
			self.m_isDeadController:setSelectedIndex(0)

			return 0
		end

		local var_4_2 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_4_2.userId)

		if not var_4_2 then
			return
		end

		self.m_leaderNameTxt:setText(var_4_2.name)
		self.m_serverNameTxt:setText(var_4_2.server_name)
		self.m_leaderIcon:updateAsUser(var_4_2)

		local var_4_3 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.ALLIANCE, var_4_2.alliance_id)

		if var_4_3 then
			self.m_teamNameTxt:setText(var_4_3.name)
			self.m_teamIconLoader:setURL((g.core.common.Path:getAllianceFlag128(var_4_3.flag or 5)))
			self.m_serverNameTxt1:setText("")
			self.m_guildGroup:setVisible(true)
		else
			self.m_guildGroup:setVisible(false)
		end
	else
		self.m_isDeadController:setSelectedIndex(0)
		self.m_awardBtn:setVisible(false)
	end
end

return GveHonorCell
