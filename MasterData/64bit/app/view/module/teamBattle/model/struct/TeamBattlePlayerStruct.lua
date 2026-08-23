local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local TeamBattlePlayerStruct = class("TeamBattlePlayerStruct")

function TeamBattlePlayerStruct:ctor()
	self._id = -1
	self._roomId = -1
	self._pos = cc.p(-1, -1)

	local var_1_0 = g.core.config.team_battle_parameter_info.get(TeamBattleConst.PARAMETER_ID.VISIBLE_LENGTH).parameter

	self._visibleSize = cc.size(var_1_0, var_1_0)
	self._work = TeamBattleConst.WORK_DIFF.NONE or TeamBattleConst.WORK_DIFF.EASY
	self._teamPos = 0
	self._onLineState = 0
	self._buffList = {}
	self._guildBuffList = {}
	self._routeMoveInfo = {}
	self._formationList = {}
	self._debuffId = 0
	self._leftHelpCnt = 0
end

function TeamBattlePlayerStruct:getPlayerId()
	return self._id
end

function TeamBattlePlayerStruct:getSnapShot(arg_3_1)
	return g.core.model.User.snapShotCacheData:getSnapShot(arg_3_1, self._id)
end

function TeamBattlePlayerStruct:getRect()
	return {
		x = self._pos.x,
		y = self._pos.y,
		width = self._visibleSize.width,
		height = self._visibleSize.height
	}
end

function TeamBattlePlayerStruct:getPos()
	return self._pos
end

function TeamBattlePlayerStruct:getRoomId()
	return self._roomId
end

function TeamBattlePlayerStruct:getVisibleSize()
	return self._visibleSize
end

function TeamBattlePlayerStruct:setMoveRouteInfo(arg_8_1)
	self._routeMoveInfo = arg_8_1 or {}
end

function TeamBattlePlayerStruct:getMoveRouteInfo()
	return self._routeMoveInfo
end

function TeamBattlePlayerStruct:clearRouteList()
	self._routeMoveInfo = {}
end

function TeamBattlePlayerStruct:updateBaseInfo(arg_11_1)
	self._id = arg_11_1.user_id
	self._roomId = arg_11_1.room_id
	self._pos = cc.p(arg_11_1.x, arg_11_1.y)
	self._onLineState = arg_11_1.status
	self._work = arg_11_1.work or TeamBattleConst.WORK_DIFF.EASY
	self._debuffId = arg_11_1.deBuff_id or 0

	self:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER)

	self._fightPower = arg_11_1.fight_value

	if self._teamPos == 0 then
		self._teamPos = g.core.model.User.teamBattleData:getTeamUpData():getTeamPos(self._id)
	end

	if arg_11_1.buff_ids then
		self:updateBuffList(TeamBattleConst.BUFF_TYPE.PERSONAL, arg_11_1.buff_ids)
	end

	self._leftHelpCnt = arg_11_1.deBuff_use_count
end

function TeamBattlePlayerStruct:updateValueByHasInfo(arg_12_1)
	if arg_12_1.user_id then
		self._id = arg_12_1.user_id
	end

	if arg_12_1.room_id then
		self._roomId = arg_12_1.room_id
	end

	if arg_12_1.x then
		self._pos.x = arg_12_1.x
	end

	if arg_12_1.y then
		self._pos.y = arg_12_1.y
	end

	if arg_12_1.status then
		self._onLineState = arg_12_1.status
	end

	if arg_12_1.work then
		self._work = arg_12_1.work
	end

	if arg_12_1.deBuff_id then
		self._debuffId = arg_12_1.deBuff_id
	end

	if arg_12_1.fight_value then
		self._fightPower = arg_12_1.fight_value
	end

	if arg_12_1.buff_ids then
		self:updateBuffList(TeamBattleConst.BUFF_TYPE.PERSONAL, arg_12_1.buff_ids)
	end

	self:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER)
end

function TeamBattlePlayerStruct:getBuffList(arg_13_1)
	if not arg_13_1 then
		return self._buffList, self._guildBuffList
	elseif TeamBattleConst.BUFF_TYPE.PERSONAL == arg_13_1 then
		return self._buffList
	elseif TeamBattleConst.BUFF_TYPE.GUILD == arg_13_1 then
		return self._guildBuffList
	end
end

function TeamBattlePlayerStruct:updateBuffList(arg_14_1, arg_14_2)
	if TeamBattleConst.BUFF_TYPE.PERSONAL == arg_14_1 then
		self:_updatePersonalBuffList(arg_14_2)
	elseif TeamBattleConst.BUFF_TYPE.GUILD == arg_14_1 then
		self:_updateGuildBuffList(arg_14_2)
	end
end

function TeamBattlePlayerStruct:_updatePersonalBuffList(arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		self._buffList[iter_15_1] = iter_15_1
	end
end

function TeamBattlePlayerStruct:_updateGuildBuffList(arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		self._guildBuffList[iter_16_1] = iter_16_1
	end
end

function TeamBattlePlayerStruct:getWork()
	return self._work
end

function TeamBattlePlayerStruct:getTeamPos()
	return self._teamPos
end

function TeamBattlePlayerStruct:getFightValue()
	return self._fightPower
end

function TeamBattlePlayerStruct:getOnLineState()
	return self._onLineState
end

function TeamBattlePlayerStruct:getDeBuffId()
	return self._debuffId
end

function TeamBattlePlayerStruct:isSelf()
	return self._id == g.core.model.User:getId()
end

function TeamBattlePlayerStruct:canHelp()
	return self._leftHelpCnt > 0
end

function TeamBattlePlayerStruct:setActionPointAwards(arg_24_1)
	self._actionAwards = arg_24_1
end

function TeamBattlePlayerStruct:getActionPointAwards()
	return self._actionAwards
end

function TeamBattlePlayerStruct:updateExtData(arg_26_1)
	self._extData = arg_26_1
end

function TeamBattlePlayerStruct:getExtData()
	return self._extData
end

function TeamBattlePlayerStruct:safeUpdateExtData(arg_28_1)
	for iter_28_0, iter_28_1 in pairs(arg_28_1) do
		self._extData[iter_28_0] = iter_28_1
	end
end

function TeamBattlePlayerStruct:removeKeyValue(arg_29_1)
	for iter_29_0, iter_29_1 in pairs(arg_29_1) do
		self._extData[iter_29_0] = nil
	end
end

return TeamBattlePlayerStruct
