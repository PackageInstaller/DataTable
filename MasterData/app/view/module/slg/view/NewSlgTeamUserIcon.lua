local NewSlgTeamUserIcon = class("NewSlgTeamUserIcon")

function NewSlgTeamUserIcon:ctor()
	self._compUserIcon = self:getChild("Comp_userIcon")
	self._txtCountDown = self:getChild("Txt_countDown")
	self._isMoveCtrl = self:getController("is_move")
	self._isSelfCtrl = self:getController("is_self")
	self._isLeaderCtrl = self:getController("is_leader")
	self._emptyCtrl = self:getController("empty")
	self._endTime = 0
end

function NewSlgTeamUserIcon:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_SCHEDULE_NOTIFY_NEW, handler(self, self._onSchedule), self)
end

function NewSlgTeamUserIcon:_onSchedule(arg_3_1, arg_3_2, arg_3_3)
	if self._teamUser then
		if arg_3_3.key == "NewSlgTeamUserIcon_updateTime" .. self._teamUser.user_id .. (self._teamUser.join_time or g.core.common.ServerTime:getTime()) then
			self:_updateMoveTime()
		end
	end
end

function NewSlgTeamUserIcon:updateView(arg_4_1)
	if not arg_4_1 then
		self._emptyCtrl:setSelectedIndex(0)

		self._teamUser = nil

		return
	end

	self._emptyCtrl:setSelectedIndex(1)

	self._teamUser = arg_4_1

	if arg_4_1.user_id > 0 then
		local var_4_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_4_1.user_id)

		if not var_4_0 then
			return
		end

		self._compUserIcon:updateAsUser(var_4_0)
		self._compUserIcon:setTouchCallFunc(handler(self, function(arg_5_0)
			g.core.utils.Tools.newSlgFunc.openTeamPlayerInfo(var_4_0)
		end))
		self._isSelfCtrl:setSelectedIndex(var_4_0.id == g.core.model.User:getId() and 1 or 0)
	else
		if arg_4_1.robot_info_id > 0 then
			local var_4_1 = g.core.model.User.snapShotCacheData:getDataSnapShotTemplate(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_4_1.robot_info_id)

			dump(var_4_1, "robotSnapShot")
			self._compUserIcon:updateAsUser(var_4_1)
			self._compUserIcon:setTouchCallFunc(handler(self, function(arg_6_0)
				g.core.utils.Tools.newSlgFunc.openTeamPlayerInfo(var_4_1)
			end))
		end

		self._isSelfCtrl:setSelectedIndex(0)
	end

	self._isLeaderCtrl:setSelectedIndex(arg_4_1.is_leader and 1 or 0)

	self._moveLeftTime = g.core.model.User.newSlgData:calMoveLeftTime(self._teamUser)
	self._endTime = g.core.common.ServerTime:getTime() + self._moveLeftTime

	if self._moveLeftTime > 0 then
		local var_4_2 = self._teamUser.join_time or g.core.common.ServerTime:getTime()

		g.core.utils.Tools.newSlgFunc.addSchedule({
			key = "NewSlgTeamUserIcon_updateTime" .. self._teamUser.user_id .. var_4_2,
			startTime = g.core.common.ServerTime:getTime(),
			endTime = g.core.common.ServerTime:getTime() + self._moveLeftTime
		})
	end

	self:_updateMoveTime()
end

function NewSlgTeamUserIcon:_updateMoveTime()
	local var_7_0 = self._endTime - g.core.common.ServerTime:getTime()

	self._isMoveCtrl:setSelectedIndex(var_7_0 > 0 and 1 or 0)

	if var_7_0 > 0 then
		self._txtCountDown:setText((g.core.common.ServerTime:secondToMSString(var_7_0)))
	end
end

return NewSlgTeamUserIcon
