local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.const.ConstMgr.TeamBattleConst
local TeamBattleTeamUpData = class("TeamBattleTeamUpData")

function TeamBattleTeamUpData:ctor()
	self._teamList = {}
	self._myTeam = nil
	self._searchTeam = {}
	self._serverInfoList = {}
	self._sidMap = {}
	self._searchTeam = {}
	self._inviteTeamList = {}
	self._inviteCd = g.core.config.team_battle_parameter_info.get(17).parameter
	self._inviteTimeDict = {}
end

function TeamBattleTeamUpData:setTeamList(arg_2_1)
	self._teamList = arg_2_1 or {}

	self:updateListSnap()
end

function TeamBattleTeamUpData:updateListSnap()
	if self:_checkTeamListUserSnapShot() then
		self:_sortTeamList()
	end
end

function TeamBattleTeamUpData:getTeamList()
	return self._teamList
end

function TeamBattleTeamUpData:_sortTeamList()
	table.sort(self._teamList, function(arg_6_0, arg_6_1)
		if #arg_6_0.members ~= #arg_6_1.members then
			return #arg_6_0.members < #arg_6_1.members
		end

		local var_6_1 = arg_6_0.members[1]
		local var_6_2 = arg_6_1.members[1]

		if arg_6_0.snapShotDic[arg_6_0.members[1]].fight_value ~= arg_6_1.snapShotDic[arg_6_1.members[1]].fight_value then
			return arg_6_1.snapShotDic[arg_6_1.members[1]].fight_value < arg_6_0.snapShotDic[arg_6_0.members[1]].fight_value
		end

		return var_6_1 < var_6_2
	end)
end

function TeamBattleTeamUpData:setMyTeam(arg_7_1)
	self._myTeam = arg_7_1

	if self._myTeam then
		self:updateTeamSnap(self._myTeam)
	end
end

function TeamBattleTeamUpData:getMyTeam()
	return self._myTeam
end

function TeamBattleTeamUpData:getMyTeamId()
	return (self._myTeam or nil) and (self._myTeam.id or 0)
end

function TeamBattleTeamUpData:hasMyTeam()
	return self._myTeam ~= nil
end

function TeamBattleTeamUpData:updateTeamSnap(arg_11_1)
	self:checkTeamMemberSnapShot(arg_11_1)
end

function TeamBattleTeamUpData:setSearchTeam(arg_12_1)
	self._searchTeam = arg_12_1

	if self._searchTeam then
		self:updateTeamSnap(self._searchTeam)
	end
end

function TeamBattleTeamUpData:getSearchTeam()
	return self._searchTeam
end

function TeamBattleTeamUpData:_checkTeamListUserSnapShot()
	local var_14_0 = true

	for iter_14_0, iter_14_1 in ipairs(self._teamList) do
		if not self:checkTeamMemberSnapShot(iter_14_1) then
			var_14_0 = false
		end
	end

	return var_14_0
end

function TeamBattleTeamUpData:checkTeamMemberSnapShot(arg_15_1)
	local var_15_0 = true

	arg_15_1.snapShotDic = arg_15_1.snapShotDic or {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_1.members) do
		local var_15_1 = iter_15_1 == g.core.model.User:getId() and g.core.model.User:packUser() or g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, iter_15_1)

		if not var_15_1 then
			var_15_0 = false
		else
			arg_15_1.snapShotDic[iter_15_1] = var_15_1
		end
	end

	return var_15_0
end

function TeamBattleTeamUpData:setMyTeamOpen(arg_16_1)
	if self._myTeam then
		self._myTeam.open = arg_16_1
	end
end

function TeamBattleTeamUpData:changeMyTeamMember(arg_17_1, arg_17_2)
	if not self._myTeam then
		return
	end

	if arg_17_2 then
		for iter_17_0, iter_17_1 in ipairs(self._myTeam.members) do
			if iter_17_1 == arg_17_1 then
				table.remove(self._myTeam.members, iter_17_0)

				return
			end
		end
	else
		self._myTeam.members[#self._myTeam.members + 1] = arg_17_1
	end
end

function TeamBattleTeamUpData:isLeader()
	if not self._myTeam then
		return false
	end

	return g.core.model.User:getId() == self._myTeam.members[1]
end

function TeamBattleTeamUpData:setServerInfos(arg_19_1)
	self._serverInfoList = {}
	self._sidMap = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		self._sidMap[iter_19_1.long_sid] = true
		self._serverInfoList[#self._serverInfoList + 1] = g.core.platform.ServerListProxy:getServerBySid(iter_19_1.long_sid)
	end
end

function TeamBattleTeamUpData:getServerInfos()
	return self._serverInfoList
end

function TeamBattleTeamUpData:_getFriendListByMatchInfos(arg_21_1)
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs((g.core.model.User.friendData:getFriendList())) do
		local var_21_1 = iter_21_1:getBasicInfo()

		if not arg_21_1[var_21_1.id] and self._sidMap[var_21_1.sid] then
			var_21_0[#var_21_0 + 1] = var_21_1
		end
	end

	return var_21_0
end

function TeamBattleTeamUpData:getInviteTeamData(arg_22_1)
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs(self._myTeam.members) do
		var_22_0[iter_22_1] = true
	end

	if arg_22_1 == var_0_1.INVITE_TAB.FRIEND then
		return self:_getFriendListByMatchInfos(var_22_0)
	elseif arg_22_1 == var_0_1.INVITE_TAB.GUILD then
		local var_22_1, var_22_2

		if not g.core.model.User.guildData:hasGuild() then
			do return {} end

			var_22_1 = {}
			var_22_2 = g.core.model.User:getId()
		end

		for iter_22_2, iter_22_3 in ipairs((g.core.model.User.guildData:getMemberData())) do
			if not var_22_0[iter_22_3.user.id] then
				var_22_1[#var_22_1 + 1] = iter_22_3.user
			end
		end

		return var_22_1
	end
end

function TeamBattleTeamUpData:setTeamBattleInvite(arg_23_1)
	self._inviteTimeDict[arg_23_1.user_id] = var_0_0:getTime()
end

function TeamBattleTeamUpData:getNextInviteTime(arg_24_1)
	if self._inviteTimeDict[arg_24_1] then
		return self._inviteTimeDict[arg_24_1] + self._inviteCd
	end

	return 0
end

function TeamBattleTeamUpData:getFriendCd(arg_25_1)
	local var_25_0 = self:getNextInviteTime(arg_25_1)

	if var_25_0 > 0 then
		return var_25_0 - var_0_0:getTime()
	else
		return 0
	end
end

function TeamBattleTeamUpData:getTeamPos(arg_26_1)
	if not self._myTeam then
		return 0
	end

	for iter_26_0, iter_26_1 in ipairs(self._myTeam.members) do
		if iter_26_1 == arg_26_1 then
			return iter_26_0
		end
	end

	return 0
end

return TeamBattleTeamUpData
