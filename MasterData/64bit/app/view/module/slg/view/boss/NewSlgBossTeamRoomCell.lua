local NewSlgBossTeamRoomCell = class("NewSlgBossTeamRoomCell")
local var_0_1 = 4

function NewSlgBossTeamRoomCell:ctor()
	self._btnJoin = self:getChild("Btn_join")

	self._btnJoin:addClickListener(handler(self, self._onClickBtnJoin))

	self._userComps = {}

	for iter_1_0 = 1, var_0_1 do
		table.insert(self._userComps, (self:getChild("Comp_teamUserIcon" .. iter_1_0)))
	end

	self._txtName = self:getChild("Txt_name")
	self._txtCountDown = self:getChild("Txt_countDown")
	self._isSelfCtrl = self:getController("is_self")
	self._canJoinCtrl = self:getController("can_join")
	self._gatherTotalTime = g.core.model.User.newSlgData:getBossTeamGatherTotalTime()
end

function NewSlgBossTeamRoomCell:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_SCHEDULE_NOTIFY_NEW, handler(self, self._onSchedule), self)
end

function NewSlgBossTeamRoomCell:_onSchedule(arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3.key == "NewSlgBossTeamRoomCell_updateSch" then
		self:_updateCountDown()
	end
end

function NewSlgBossTeamRoomCell:updateCell(arg_4_1)
	if not arg_4_1 then
		return
	end

	g.core.utils.Tools.newSlgFunc.addSchedule({
		key = "NewSlgBossTeamRoomCell_updateSch"
	})

	self._team = arg_4_1
	self._teamId = arg_4_1.team_id
	self._bossId = self._team.boss_id

	self:_updateSelfTeam()
	self:_updateTeamName()
	self:_updateCountDown()
	self:_updateUserTeam()
	self:_updateCanJoinView()
end

function NewSlgBossTeamRoomCell:_updateCanJoinView()
	if self._isSelfCtrl:getSelectedIndex() == 1 then
		self._canJoinCtrl:setSelectedIndex(1)

		return
	end

	local var_5_0 = g.core.model.User.newSlgData:getPathByTmpl((g.core.model.User.newSlgData:getBossComponentById(self._team.boss_id)))

	if not var_5_0 then
		self._canJoinCtrl:setSelectedIndex(0)

		return
	end

	if self._team.create_time + self._gatherTotalTime < g.core.common.ServerTime:getTime() + g.core.utils.Tools.newSlgFunc.getMarchDurationByPath(var_5_0, 0, g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.BOSS) then
		self._canJoinCtrl:setSelectedIndex(0)
	else
		self._canJoinCtrl:setSelectedIndex(1)
	end
end

function NewSlgBossTeamRoomCell:_updateSelfTeam()
	self._isSelfCtrl:setSelectedIndex(0)
	self._btnJoin:setTitle(g.core.lang:get(429004))

	for iter_6_0, iter_6_1 in ipairs(self._team.users or {}) do
		if iter_6_1.user_id == g.core.model.User:getId() then
			self._isSelfCtrl:setSelectedIndex(1)
			self._btnJoin:setTitle(g.core.lang:get(429005))

			return
		end
	end
end

function NewSlgBossTeamRoomCell:_updateTeamName()
	local var_7_1 = g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER

	for iter_7_0, iter_7_1 in ipairs(self._team.users or {}) do
		if iter_7_1.is_leader then
			if iter_7_1.user_id ~= 0 then
				local var_7_2 = g.core.model.User.snapShotCacheData:getSnapShot(var_7_1, iter_7_1.user_id)

				if var_7_2 then
					self._txtName:setText(g.core.lang:get(428908, {
						name = var_7_2.name
					}))
				end
			elseif self._teamUser.robot_info_id > 0 then
				self._txtName:setText(g.core.lang:get(428908, {
					name = g.core.model.User.snapShotCacheData:getDataSnapShotTemplate(var_7_1, self._teamUser.robot_info_id).name
				}))
			end

			return
		end
	end
end

function NewSlgBossTeamRoomCell:_updateCountDown()
	local var_8_0 = g.core.common.ServerTime:getTime()

	if self._team.create_time + self._gatherTotalTime - var_8_0 < 0 then
		return
	end

	self._txtCountDown:setText((g.core.common.ServerTime:secondToHMSString(self._team.create_time + self._gatherTotalTime - var_8_0)))
end

function NewSlgBossTeamRoomCell:_updateUserTeam()
	local var_9_0 = self._team.users or {}

	for iter_9_0, iter_9_1 in ipairs(self._userComps) do
		iter_9_1:updateView(var_9_0[iter_9_0])
	end
end

function NewSlgBossTeamRoomCell:_onClickBtnJoin()
	if self._isSelfCtrl:getSelectedIndex() == 1 then
		g.core.utils.Tools.newSlgFunc.openBossTeamDetailPop({
			teamId = self._teamId
		})
	else
		self:_sendGatherEvent()
	end
end

function NewSlgBossTeamRoomCell:_sendGatherEvent()
	local var_11_0 = g.core.model.User.newSlgData:getBossComponentById(self._bossId)

	self:dispatchCompEvent("NewSlg_Boss_Gather", {
		buildType = g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.BOSS,
		info = g.core.model.User.newSlgData:getBossInfoById(self._bossId),
		x = var_11_0.anchor_x,
		y = var_11_0.anchor_y,
		bossJoinType = g.core.const.ConstMgr.NewSlgConst.SLGBossJoinType.JOIN,
		teamId = self._teamId,
		bossTeam = self._team
	})
end

return NewSlgBossTeamRoomCell
