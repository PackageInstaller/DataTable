local NewSlgFirstKillUserIcon = class("NewSlgFirstKillUserIcon")

function NewSlgFirstKillUserIcon:ctor()
	self._compName = self:getChild("Comp_name")
	self._compFlag = self:getChild("Comp_flag")
	self._compUser = self:getChild("Comp_user")
	self._isSelfCtrl = self:getController("isself")
end

function NewSlgFirstKillUserIcon:updateCell(arg_2_1)
	if not arg_2_1 then
		return
	end

	local var_2_0

	if arg_2_1.robot_id > 0 then
		var_2_0 = g.core.model.User.snapShotCacheData:getDataSnapShotTemplate(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_2_1.robot_id, 2)
	elseif arg_2_1.user_id then
		var_2_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_2_1.user_id)
	end

	if not var_2_0 then
		return
	end

	self._compUser:updateAsUser(var_2_0)
	self._compName:setText(var_2_0.name)
	self._compUser:setTouchCallFunc(handler(self, function(arg_3_0)
		g.core.utils.Tools.newSlgFunc.openTeamPlayerInfo(var_2_0)
	end))
	self._isSelfCtrl:setSelectedIndex(not var_2_0.is_robot and var_2_0.id == g.core.model.User:getId() and 1 or 0)
end

return NewSlgFirstKillUserIcon
