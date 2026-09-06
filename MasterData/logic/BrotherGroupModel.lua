-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/brothergroup/model/BrotherGroupModel.lua

module("logic.extensions.brothergroup.model.BrotherGroupModel", package.seeall)

local BrotherGroupModel = class("BrotherGroupModel", BaseModel)

function BrotherGroupModel:onInit()
	self:onReset()
end

function BrotherGroupModel:onReset()
	self._curActId = 0
	self._lastOpenId = 0
	self._hasGainPrizeList = {}
	self._taskInfoHash = {}
	self._teammateInfoList = {}
	self._teamleaderId = 0
	self._curScore = 0
	self._inviteInfoHash = {}
	self._lastPrizeIdAbleToGet = 0
end

function BrotherGroupModel:onGetInfo(msg)
	self._hasGainPrizeList = {}

	for k, v in ipairs(msg.personalPrize) do
		table.insert(self._hasGainPrizeList, checkint(v))
	end

	self:onTeammateUpdate(msg)

	self._curScore = checkint(msg.personScore)
end

function BrotherGroupModel:onGetRequestList(msg)
	return
end

function BrotherGroupModel:onHandleRequest(msg)
	local userId = checkint(msg.userId)

	if msg.action == 2 then
		if msg.result == 0 then
			self:removeAllInviteInfo()
		end
	elseif msg.action == 1 then
		self:removeInviteInfo(userId)
	end
end

function BrotherGroupModel:onGainPersonPrize(msg)
	self._hasGainPrizeList = self._hasGainPrizeList or {}

	if checkint(msg.prizeId) == -1 then
		self._hasGainPrizeList = {}

		for i = 1, self._lastPrizeIdAbleToGet do
			table.insert(self._hasGainPrizeList, i)
		end
	else
		table.insert(self._hasGainPrizeList, checkint(msg.prizeId))
	end
end

function BrotherGroupModel:onGetTaskInfo(msg)
	self._taskInfoHash = {}

	for k, v in ipairs(msg.taskList) do
		local taskInfo = {}

		taskInfo.id = checkint(v.taskId)
		taskInfo.curProgress = checkint(v.curProgress)
		taskInfo.hasGain = v.hasGainPrize
		self._taskInfoHash[checkint(v.taskId)] = taskInfo
	end
end

function BrotherGroupModel:onFinishTask(msg)
	local taskId = checkint(msg.taskId)
	local info = self._taskInfoHash[taskId]

	info.hasGain = true
end

function BrotherGroupModel:onGetReceived(msg)
	self._inviteInfoHash = self._inviteInfoHash or {}

	local data = msg.request
	local inviterUserId = checkint(data.headInfo.userId)
	local info = self._inviteInfoHash[inviterUserId]

	if not info then
		info = {
			headInfo = data.headInfo,
			memberNum = data.memberNum
		}
		info.inviteEndTime = -1
		self._inviteInfoHash[inviterUserId] = info
	end
end

function BrotherGroupModel:onTeammateUpdate(msg)
	self._teammateInfoList = {}
	self._teamleaderId = checkint(msg.teamInfo.captainUserId)

	for k, v in ipairs(msg.teamInfo.member) do
		local info = {}

		info.posId = checkint(v.posId)
		info.headInfo = v.headInfo
		info.score = checkint(v.personScore)
		info.areaName = v.areaName

		table.insert(self._teammateInfoList, info)
	end
end

function BrotherGroupModel:getCurActId()
	return self._curActId
end

function BrotherGroupModel:setCurActId(actId)
	self._curActId = checkint(actId)
end

function BrotherGroupModel:getLastOpenId()
	return self._lastOpenId
end

function BrotherGroupModel:setLastOpenId(lastId)
	self._lastOpenId = checkint(lastId)
end

function BrotherGroupModel:getIsHasGainPrize(prizeId)
	if self._hasGainPrizeList then
		return table.keyof(self._hasGainPrizeList, prizeId)
	end

	return false
end

function BrotherGroupModel:getTaskInfo(taskId)
	return self._taskInfoHash and self._taskInfoHash[taskId]
end

function BrotherGroupModel:checkAbleToGainPassport()
	return table.nums(self._teammateInfoList) >= BrotherGroupConfig.instance:getCommomValue("MIN_GAIN_PRIZE_NUM")
end

function BrotherGroupModel:getCurTeamLeaderId()
	if self._teamleaderId > 0 then
		return self._teamleaderId
	else
		return checkint(RoleModel.instance:getUserId())
	end
end

function BrotherGroupModel:getTeammateInfoList()
	return self._teammateInfoList
end

function BrotherGroupModel:isExitTeam()
	return self._teamleaderId > 0
end

function BrotherGroupModel:getCurPersonScore()
	return self._curScore
end

function BrotherGroupModel:isShowInviteRed()
	if self:isExitTeam() then
		return false
	end

	return table.nums(self._inviteInfoHash) > 0
end

function BrotherGroupModel:getInviteInfoList()
	return self._inviteInfoHash
end

function BrotherGroupModel:removeAllInviteInfo()
	self._inviteInfoHash = {}
end

function BrotherGroupModel:removeInviteInfo(userId)
	self._inviteInfoHash[userId] = nil
end

function BrotherGroupModel:setLastPrizeId(Id)
	self._lastPrizeIdAbleToGet = checkint(Id)
end

BrotherGroupModel.instance = BrotherGroupModel.New()

return BrotherGroupModel
