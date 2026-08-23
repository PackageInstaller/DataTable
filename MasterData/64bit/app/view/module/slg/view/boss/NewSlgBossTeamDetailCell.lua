local NewSlgBossTeamDetailCell = class("NewSlgBossTeamDetailCell")

function NewSlgBossTeamDetailCell:ctor()
	self._compArmyIcon = self:getChild("Comp_armyIcon")
	self._compName = self:getChild("Comp_name")
	self._compDesc = self:getChild("Comp_desc")
	self._compUserIcon = self:getChild("Comp_userIcon")
	self._btn1 = self:getChild("Btn_1")

	self._btn1:addClickListener(handler(self, self._onClickBtn1))
	self._btn1:getChild("title"):enableOutline(0, g.core.common.Color.newOutline)

	self._btn2 = self:getChild("Btn_2")

	self._btn2:addClickListener(handler(self, self._onClickBtn2))
	self._btn2:getChild("title"):enableOutline(0, g.core.common.Color.newOutline)

	self._btn3 = self:getChild("Btn_3")

	self._btn3:addClickListener(handler(self, self._onClickBtn3))
	self._btn3:getChild("title"):enableOutline(0, g.core.common.Color.newOutline)

	self._txtArmyLv = self:getChild("Txt_armyLv")
	self._txtMoveTime = self:getChild("Txt_moveTime")
	self._isSelfCtrl = self:getController("is_self")
	self._isLeaderCtrl = self:getController("is_leader")
	self._moveTimeCtrl = self:getController("move_time")
	self._isEmptyCtrl = self:getController("is_empty")
	self._endTime = 0
end

function NewSlgBossTeamDetailCell:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_SCHEDULE_NOTIFY_NEW, handler(self, self._onSchedule), self)
end

function NewSlgBossTeamDetailCell:_onSchedule(arg_3_1, arg_3_2, arg_3_3)
	if self._teamUser and arg_3_3.key == "NewSlgBossTeamDetailCell_updateMoveTime" .. self._teamUser.user_id then
		self:_updateMoveTime()
	end
end

function NewSlgBossTeamDetailCell:updateCell(arg_4_1, arg_4_2)
	self._teamUser = arg_4_1
	self._selfIsLeader = arg_4_2

	self:_updateBtn()
	self._isEmptyCtrl:setSelectedIndex(arg_4_1 and 0 or 1)

	if not arg_4_1 then
		return
	end

	self:_updateBase()

	self._moveLeftTime = g.core.model.User.newSlgData:calMoveLeftTime(self._teamUser)
	self._endTime = g.core.common.ServerTime:getTime() + self._moveLeftTime

	if self._moveLeftTime > 0 then
		g.core.utils.Tools.newSlgFunc.addSchedule({
			key = "NewSlgBossTeamDetailCell_updateMoveTime" .. self._teamUser.user_id,
			startTime = g.core.common.ServerTime:getTime(),
			endTime = g.core.common.ServerTime:getTime() + self._moveLeftTime
		})
	end

	self:_updateMoveTime()
end

function NewSlgBossTeamDetailCell:_updateMoveTime()
	local var_5_0 = self._endTime - g.core.common.ServerTime:getTime()

	self._moveTimeCtrl:setSelectedIndex(var_5_0 > 0 and 1 or 0)

	if var_5_0 > 0 then
		self._txtMoveTime:setText((g.core.common.ServerTime:secondToMSString(var_5_0)))
	end
end

function NewSlgBossTeamDetailCell:_updateBase()
	self._isLeaderCtrl:setSelectedIndex(self._teamUser.is_leader and 1 or 0)
	self._isSelfCtrl:setSelectedIndex(self._teamUser.user_id == g.core.model.User:getId() and 1 or 0)
	self._compArmyIcon:updateView({
		armyType = self._teamUser.team.troop_type
	})
	self._txtArmyLv:setText(g.core.lang:get(429006, {
		level = self._teamUser.team.troop_level
	}))

	if self._teamUser.user_id ~= 0 then
		local var_6_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, self._teamUser.user_id)

		if not var_6_0 then
			return
		end

		self._compUserIcon:updateAsUser(var_6_0)
		self._compUserIcon:setTouchCallFunc(handler(self, function(arg_7_0)
			g.core.utils.Tools.newSlgFunc.openTeamPlayerInfo(var_6_0)
		end))
		self._compName:setText(var_6_0.name)
		self._compDesc:setText(self._teamUser.team.authority)
	elseif self._teamUser.robot_info_id > 0 then
		local var_6_1 = g.core.model.User.snapShotCacheData:getDataSnapShotTemplate(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, self._teamUser.robot_info_id)

		self._compUserIcon:setTouchCallFunc(handler(self, function(arg_8_0)
			g.core.utils.Tools.newSlgFunc.openTeamPlayerInfo(var_6_1)
		end))
		self._compUserIcon:updateAsUser(var_6_1)
		self._compName:setText(var_6_1.name)
		self._compDesc:setText(self._teamUser.team.authority)
	end
end

function NewSlgBossTeamDetailCell:_updateBtn()
	self:_resetBtn()

	if not self._teamUser then
		self:_onClickInvite(1)
	elseif self._selfIsLeader then
		if self._teamUser.user_id == g.core.model.User:getId() then
			self:_onClickDetail(1)
			self:_onClickQuit(2)
			self:_onClickDismiss(3)
		else
			self:_onClickDetail(1)
			self:_onClickKickOut(2)
			self:_onClickTransfer(3)
		end
	elseif self._teamUser.user_id == g.core.model.User:getId() then
		self:_onClickDetail(1)
		self:_onClickQuit(2)
	else
		self:_onClickDetail(1)
	end
end

function NewSlgBossTeamDetailCell:_resetBtn()
	self._btn1:setVisible(false)
	self._btn2:setVisible(false)
	self._btn3:setVisible(false)

	self._func1 = nil
	self._func2 = nil
	self._func3 = nil
end

function NewSlgBossTeamDetailCell:_onClickDetail(arg_11_1)
	self["_btn" .. arg_11_1]:setVisible(true)
	self["_btn" .. arg_11_1]:setTitle(g.core.lang:get(428994))
	self["_btn" .. arg_11_1]:setIcon("ui://base_new/icon_yht_xinxi_1")
	self["_btn" .. arg_11_1]:setCtrlState("scale", {
		index = 2
	})

	self["_func" .. arg_11_1] = handler(self, function(arg_12_0, arg_12_1)
		arg_12_0:dispatchCompEvent("NewSlgBossTeamDetailCell_onClickDetail", {
			comp = arg_12_0,
			teamUser = arg_12_0._teamUser
		})
	end)
end

function NewSlgBossTeamDetailCell:_onClickQuit(arg_13_1)
	self["_btn" .. arg_13_1]:setVisible(true)
	self["_btn" .. arg_13_1]:setTitle(g.core.lang:get(428996))
	self["_btn" .. arg_13_1]:setIcon("ui://base_new/icon_tuichu")
	self["_btn" .. arg_13_1]:setCtrlState("scale", {
		index = 2
	})

	self["_func" .. arg_13_1] = handler(self, function(arg_14_0)
		arg_14_0:dispatchCompEvent("NewSlgBossTeamDetailCell_onClickQuit", {
			teamUser = arg_14_0._teamUser
		})
	end)
end

function NewSlgBossTeamDetailCell:_onClickDismiss(arg_15_1)
	self["_btn" .. arg_15_1]:setVisible(true)
	self["_btn" .. arg_15_1]:setTitle(g.core.lang:get(428991))
	self["_btn" .. arg_15_1]:setIcon("ui://newSlg/icon_hzts_jiesan")
	self["_btn" .. arg_15_1]:setCtrlState("scale", {
		index = 1
	})

	self["_func" .. arg_15_1] = handler(self, function(arg_16_0)
		arg_16_0:dispatchCompEvent("NewSlgBossTeamDetailCell_onClickDismiss", {
			teamUser = arg_16_0._teamUser
		})
	end)
end

function NewSlgBossTeamDetailCell:_onClickKickOut(arg_17_1)
	self["_btn" .. arg_17_1]:setVisible(true)
	self["_btn" .. arg_17_1]:setTitle(g.core.lang:get(428992))
	self["_btn" .. arg_17_1]:setIcon("ui://base_new/icon_qingli")
	self["_btn" .. arg_17_1]:setCtrlState("scale", {
		index = 2
	})

	self["_func" .. arg_17_1] = handler(self, function(arg_18_0)
		arg_18_0:dispatchCompEvent("NewSlgBossTeamDetailCell_onClickKickOut", {
			teamUser = arg_18_0._teamUser
		})
	end)
end

function NewSlgBossTeamDetailCell:_onClickTransfer(arg_19_1)
	self["_btn" .. arg_19_1]:setVisible(true)
	self["_btn" .. arg_19_1]:setTitle(g.core.lang:get(428993))
	self["_btn" .. arg_19_1]:setIcon("ui://newSlg/icon_hzts_zhuanrang")
	self["_btn" .. arg_19_1]:setCtrlState("scale", {
		index = 1
	})

	self["_func" .. arg_19_1] = handler(self, function(arg_20_0)
		arg_20_0:dispatchCompEvent("NewSlgBossTeamDetailCell_onClickTransfer", {
			teamUser = arg_20_0._teamUser
		})
	end)
end

function NewSlgBossTeamDetailCell:_onClickInvite(arg_21_1)
	self["_btn" .. arg_21_1]:setVisible(true)
	self["_btn" .. arg_21_1]:setTitle(g.core.lang:get(428997))
	self["_btn" .. arg_21_1]:setIcon("ui://newSlg/btn_djs_yaoqing")
	self["_btn" .. arg_21_1]:setCtrlState("scale", {
		index = 2
	})

	self["_func" .. arg_21_1] = handler(self, function(arg_22_0)
		arg_22_0:dispatchCompEvent("NewSlgBossTeamDetailCell_onClickInvite")
	end)
end

function NewSlgBossTeamDetailCell:_onClickBtn1()
	if self._func1 then
		self._func1()
	end
end

function NewSlgBossTeamDetailCell:_onClickBtn2()
	if self._func2 then
		self._func2()
	end
end

function NewSlgBossTeamDetailCell:_onClickBtn3()
	if self._func3 then
		self._func3()
	end
end

return NewSlgBossTeamDetailCell
