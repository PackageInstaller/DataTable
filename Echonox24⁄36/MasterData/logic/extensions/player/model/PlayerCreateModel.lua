-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/player/model/PlayerCreateModel.lua

module("logic.extensions.player.model.PlayerCreateModel", package.seeall)

local json = require("cjson")
local M = class("PlayerCreateModel", BaseModel)

function M:ctor()
	self._six = 0
	self._portrait = 0
	self._portraitSex = 0
	self._nameState = 0
	self._name = false
	self._timeEnterPlayerCreate = 0
	self._timeFirstEnterPortrait = 0
	self._timeFirstEnterAttr = 0
	self._timeLastConfirmAttr = 0
	self._timeAnswerOne = 0
	self._timeAnswerTwo = 0
	self._timeSelectAttr = 0
	self._timeSetName = 0
	self._roleTmpId = 0
end

function M:onReset()
	self._six = 0
	self._portrait = 0
	self._portraitSex = 0
	self._nameState = 0
	self._name = false
	self._timeEnterPlayerCreate = 0
	self._timeFirstEnterPortrait = 0
	self._timeFirstEnterAttr = 0
	self._timeLastConfirmAttr = 0
	self._timeConfirmAll = 0
	self._timeAnswerOne = 0
	self._timeAnswerTwo = 0
	self._timeSelectAttr = 0
	self._timeSetName = 0
	self._roleTmpId = 0
end

function M:recordEnterTime()
	self._timeEnterPlayerCreate = ServerTime.now()
end

function M:recordFirstEnterPortrait()
	self._timeFirstEnterPortrait = ServerTime.now()
end

function M:recordFirstEnterAttr()
	self._timeFirstEnterAttr = ServerTime.now()
end

function M:recordLastConfirmAttr()
	self._timeLastConfirmAttr = ServerTime.now()
end

function M:recordAnswer(index)
	if index == 1 then
		self:recordAnswerOne()
	else
		self:recordAnswerTwo()
	end
end

function M:recordAnswerOne()
	self._timeAnswerOne = ServerTime.now()
end

function M:recordAnswerTwo()
	self._timeAnswerTwo = ServerTime.now()
end

function M:recordSelectAttr()
	self._timeSelectAttr = ServerTime.now()
end

function M:recordSetName()
	self._timeSetName = ServerTime.now()
end

function M:recordTmpId(tmpId)
	self._roleTmpId = tmpId
end

function M:sendCreateRoleInfo()
	if self._timeEnterPlayerCreate == 0 then
		return
	end

	local answerOneTime = self._timeAnswerOne - self._timeEnterPlayerCreate
	local answerTwoTime = self._timeAnswerTwo - self._timeAnswerOne
	local selectAttrTime = self._timeSelectAttr - self._timeAnswerTwo
	local setNameTime = self._timeSetName - self._timeSelectAttr
	local roleTmpId = self._roleTmpId
	local allTime = ServerTime.now() - self._timeEnterPlayerCreate
	local keys = CommEnum.BuryPointPlayerCreateKey
	local info = {
		[keys.AnswerOne] = answerOneTime,
		[keys.AnswerTwo] = answerTwoTime,
		[keys.PlayerAttribute] = selectAttrTime,
		[keys.SetName] = setNameTime,
		[keys.PlayerNickname] = self._name or PlayerCreateModel.instance:getDefaultName(),
		[keys.RoleTmpId] = roleTmpId,
		[keys.CommitTotalTime] = allTime
	}
	local jsStr = json.encode(info)

	UserAgent.instance:sendUploadStatsRequest(CommEnum.BuryPointType.PlayerCreate, jsStr)

	self._timeEnterPlayerCreate = 0
end

function M:sendBuryPointInfo()
	local openPortraitTime = self._timeFirstEnterPortrait - self._timeEnterPlayerCreate
	local openSixTime = self._timeFirstEnterAttr - self._timeEnterPlayerCreate
	local totalSixTime = self._timeLastConfirmAttr - self._timeFirstEnterAttr
	local allTime = ServerTime.now() - self._timeEnterPlayerCreate
	local keys = CommEnum.BuryPointPlayerCreateKey
	local info = {
		[keys.PlayerImage] = self._portrait,
		[keys.PlayerNickname] = self._name,
		[keys.PlayerAttribute] = self._six,
		[keys.OpenImageTime] = openPortraitTime,
		[keys.OpenAttributeTime] = openSixTime,
		[keys.CommitAttributeTime] = totalSixTime,
		[keys.CommitTotalTime] = allTime
	}
	local jsStr = json.encode(info)

	UserAgent.instance:sendUploadStatsRequest(CommEnum.BuryPointType.PlayerCreate, jsStr)
end

function M:getNameEditState()
	return self._nameState
end

function M:getDefaultName()
	if not self._defaultName then
		self._defaultName = ConstConfig.instance:getStrValueByKey("DefaultNickname")
	end

	return self._defaultName
end

function M:setNameEditState(state)
	self._nameState = state
end

function M:getPortrait()
	return self._portrait
end

function M:getSex()
	return self._portraitSex
end

function M:setPortrait(portrait, sex)
	self._portrait = portrait
	self._portraitSex = sex

	GlobalDispatcher:dispatchEvent(EventType.PLAYER_CREATE_MODEL_CHOSE, sex)
end

function M:getNickName()
	return self._name or nil
end

function M:setNickName(name)
	self._name = name

	GlobalDispatcher:dispatchEvent(EventType.PLAYER_CREATE_Name_CHOSE)
end

function M:getSixInfo()
	local config = PlayerConfig.instance:getAttrTemplateById(self._six)

	return config, self._six == 0
end

function M:setSixInfo(six)
	self._six = six
	self._timeLastConfirmAttr = ServerTime.now()

	GlobalDispatcher:dispatchEvent(EventType.PLAYER_CREATE_SIX_CHOSE)
end

function M:isAllComplete()
	return self._six ~= 0 and self._portrait ~= 0
end

function M:isAllCompleteTrue()
	return self._six ~= 0 and self._portrait ~= 0 and (self._nameState == CommEnum.PlayerNameCreateState.Default or self._nameState == CommEnum.PlayerNameCreateState.Normal)
end

function M:requestToCreatePlayer()
	PlayerAgent.instance:sendFinishCreatePlayerRequest(self._name, self._portraitSex, self._six)
end

M.instance = M.New()

return M
