local NewSlgBossTotalTeamCell = class("NewSlgBossTotalTeamCell")
local var_0_1 = 4

function NewSlgBossTotalTeamCell:ctor()
	self._compLeaderName = self:getChild("Comp_leaderName")
	self._userComps = {}

	for iter_1_0 = 1, var_0_1 do
		table.insert(self._userComps, (self:getChild("Comp_userIcon" .. iter_1_0)))
	end

	self._btnJoin = self:getChild("Btn_join")

	self._btnJoin:addClickListener(handler(self, self._onClickBtnJoin))
	self._btnJoin:getChild("title"):enableOutline(0, g.core.common.Color.newOutline)

	self._btnShare = self:getChild("Btn_share")

	self._btnShare:addClickListener(handler(self, self._onClickBtnShare))
	self._btnShare:getChild("title"):enableOutline(0, g.core.common.Color.newOutline)

	self._btnCheck = self:getChild("Btn_check")

	self._btnCheck:addClickListener(handler(self, self._onClickBtnCheck))
	self._btnCheck:getChild("title"):enableOutline(0, g.core.common.Color.newOutline)

	self._txtDesc = self:getChild("Txt_desc")
	self._txtLevel = self:getChild("Txt_level")
	self._txtCountDown = self:getChild("Txt_countDown")
	self._isInCtrl = self:getController("is_in")
	self._compArmy = self:getChild("Comp_army")
end

function NewSlgBossTotalTeamCell:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_SCHEDULE_NOTIFY_NEW, handler(self, self._onSchedule), self)
end

function NewSlgBossTotalTeamCell:_onSchedule(arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3.key == "NewSlgBossTotalTeamCell_updateSch" then
		self:_updateBySch()
	end
end

function NewSlgBossTotalTeamCell:updateCell(arg_4_1, arg_4_2)
	if not arg_4_1 then
		return
	end

	self._tabIndex = arg_4_2
	self._team = arg_4_1
	self._teamId = arg_4_1.team_id
	self._bossId = self._team.boss_id
	self._bossCfg = g.core.model.User.newSlgData:getBossInfoById(self._bossId)

	self._compArmy:updateView({
		armyType = self._bossCfg.boss_army_type
	})

	if arg_4_2 == 1 then
		local var_4_0 = g.core.model.User.newSlgData:getPrivateContentData(arg_4_1.team_id)

		if var_4_0 and var_4_0.receiverId == g.core.model.User:getId() then
			self._txtLevel:setVisible(false)
			self._txtDesc:setText(g.core.lang:get(428928, {
				name1 = var_4_0.name,
				name2 = self._bossCfg.name
			}))
		else
			self._txtLevel:setVisible(true)
			self._txtLevel:setText(g.core.lang:get(429006, {
				level = self._bossCfg.level
			}))
			self._txtDesc:setText(self._bossCfg.name)
		end
	else
		self._txtLevel:setVisible(true)
		self._txtLevel:setText(g.core.lang:get(429006, {
			level = self._bossCfg.level
		}))
		self._txtDesc:setText(self._bossCfg.name)
	end

	self._isInCtrl:setSelectedIndex(0)

	for iter_4_0, iter_4_1 in ipairs(self._team.users or {}) do
		if iter_4_1.is_leader then
			local var_4_1 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, iter_4_1.user_id)

			if var_4_1 then
				self._compLeaderName:setText(var_4_1.name)
			end
		end

		if iter_4_1.user_id == g.core.model.User:getId() then
			self._isInCtrl:setSelectedIndex(1)
		end
	end

	local var_4_2 = self._team.users or {}

	for iter_4_2, iter_4_3 in ipairs(self._userComps) do
		iter_4_3:updateView(var_4_2[iter_4_2])
	end

	self:_updateBySch()
end

function NewSlgBossTotalTeamCell:_updateBySch()
	self._txtCountDown:setText(g.core.common.ServerTime:secondToHMSString((math.max(self._team.create_time + g.core.model.User.newSlgData:getBossTeamGatherTotalTime() - g.core.common.ServerTime:getTime(), 0))))
	g.core.utils.Tools.newSlgFunc.addSchedule({
		key = "NewSlgBossTotalTeamCell_updateSch"
	})
end

function NewSlgBossTotalTeamCell:_onClickBtnJoin()
	local var_6_0 = g.core.model.User.newSlgData:getBossComponentById(self._bossId)

	self:dispatchCompEvent("NewSlg_Boss_Gather", {
		buildType = g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.BOSS,
		info = g.core.model.User.newSlgData:getBossInfoById(self._bossId),
		x = var_6_0.anchor_x,
		y = var_6_0.anchor_y,
		bossJoinType = g.core.const.ConstMgr.NewSlgConst.SLGBossJoinType.JOIN,
		teamId = self._teamId,
		bossTeam = self._team
	})
end

function NewSlgBossTotalTeamCell:_onClickBtnShare()
	if self._team and self._team.state == g.core.const.ConstMgr.NewSlgConst.SLGBossTeamState.STATE_3 then
		g.core.module.ModuleManager:tip(g.core.lang:get(428939))

		return
	end

	if self._team and self._team.state == g.core.const.ConstMgr.NewSlgConst.SLGBossTeamState.STATE_2 then
		g.core.module.ModuleManager:tip(g.core.lang:get(428940))

		return
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_BOSS_TEAM_INVITE_POP, {
		bossTeam = self._team
	})
end

function NewSlgBossTotalTeamCell:_onClickBtnCheck()
	if self._team and self._team.state == g.core.const.ConstMgr.NewSlgConst.SLGBossTeamState.STATE_3 then
		g.core.module.ModuleManager:tip(g.core.lang:get(428939))

		return
	end

	if self._team and self._team.state == g.core.const.ConstMgr.NewSlgConst.SLGBossTeamState.STATE_2 then
		g.core.module.ModuleManager:tip(g.core.lang:get(428940))

		return
	end

	g.core.utils.Tools.newSlgFunc.openBossTeamDetailPop({
		teamId = self._teamId
	})
end

return NewSlgBossTotalTeamCell
