-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/agent/DungeonAgent.lua

module("logic.extensions.dungeon.agent.DungeonAgent", package.seeall)

local DungeonAgent = class("DungeonAgent", BaseAgent)

function DungeonAgent:ctor()
	DungeonAgent.super.ctor(self)
end

function DungeonAgent:_onReset()
	self._starRewardWaitReplyRecord = {}
	self._teachingRewardWaitReplyRecord = {}
	self._lastDungeonRestart = false
end

function DungeonAgent:sendGetDungeonInfoRequest()
	local req = DungeonExtension_pb.GetDungeonInfoRequest()

	self:sendMsg(req)
end

function DungeonAgent:handleGetDungeonInfoReply(status, msg)
	if status == 0 then
		DungeonModel.instance:initDungeonPassData(msg.dungeons)
		DungeonMainLineChapterModel.instance:initStarBoxTakenData(msg.starTakenMainlines)
		DungeonTeachingChapterModel.instance:initRewardTaken(msg.takenTrainings or {})
		DungeonTeachingChapterModel.instance:initUnlockDungeon(msg.unlockedTrainings or {})
		DungeonModel.instance:setLastBattleTeam(msg.lastBattleTeam)
		DungeonModel.instance:setRecordLastTeam(msg.dungeons)
		ClimbingTowerDarkModel.instance:updateDarkRoundFromServer(msg.darkRound)
		GlobalDispatcher:dispatchEvent(EventType.LOAD_DUNGEON_DATA_FINISH)
	end
end

function DungeonAgent:handleChangeLastBattleTeamPush(status, msg)
	DungeonModel.instance:updateLastBattleTeam(msg)
end

function DungeonAgent:sendStartDungeonRequest(code, multiplied, isRestart, gameplay)
	DungeonModel.instance:localStorageHasEnterDungeonId(code)

	local req = DungeonExtension_pb.StartDungeonRequest()

	req.code = code
	req.multiplied = multiplied
	req.restart = isRestart
	req.gameplay = gameplay

	self:sendMsg(req)

	self._lastDungeonRestart = isRestart
end

function DungeonAgent:handleStartDungeonReply(status, msg)
	BattleDispatcher:dispatchEvent(BattleEventType.OnDungeonBattleStart, status)

	if status == 0 then
		if self._lastDungeonRestart then
			DungeonAgent.instance:SendFinishPostwarPlotRequest()
		end

		local battleFlowClass = false
		local isFinishPreface = PlayerModel.instance:getPrologueFinished()

		if isFinishPreface then
			local dungeonCode = msg.info.passId

			battleFlowClass = DungeonController.instance:getBattleFlowClassByCode(dungeonCode)
		else
			battleFlowClass = PrefaceBattleFlow
		end

		BattleMgr.instance:enter(msg.info, battleFlowClass)

		if enableWarnLog then
			printWarn("DungeonAgent:handleStartDungeonReply success")
		end
	elseif enableWarnLog then
		printWarn("DungeonAgent:handleStartDungeonReply(status, msg)", status)
	end
end

function DungeonAgent:handleEndDungeonWithStarsPush(status, msg)
	if status == 0 then
		if msg.result == 1 then
			DungeonModel.instance:cacheEndStars(msg.currentStars, msg.mergedStars)
		end

		DungeonModel.instance:setFirstPass(msg.first)
		BattleCalculateModel.instance:setCalculateItemProto(msg.rewards)
		BattleCalculateModel.instance:setCalculateHeroBattleData(msg.statHeroes)
		BattleCalculateModel.instance:setCalculateHeroCount(msg.heroCount)

		if enableWarnLog then
			printWarn("DungeonAgent:handleEndDungeonWithStarsPush success")
		end
	elseif enableErrorLog then
		printError("DungeonAgent:handleEndDungeonWithStarsPush(status, msg)", status)
	end

	BattleDispatcher:dispatchEvent(BattleEventType.BattleCalculateReady)
end

function DungeonAgent:SendTakeMainlineStarRewardRequest(chapter, difficulty, index)
	local req = DungeonExtension_pb.TakeMainlineStarRewardRequest()

	req.chapter = chapter
	req.difficulty = difficulty
	req.index = index

	self:sendMsg(req)
	table.insert(self._starRewardWaitReplyRecord, {
		chapter = chapter,
		difficulty = difficulty,
		index = index + 1
	})
end

function DungeonAgent:handleTakeMainlineStarRewardReply(status, msg)
	if status == 0 then
		local record = self._starRewardWaitReplyRecord[1]

		if record then
			DungeonMainLineChapterModel.instance:takeOneStarBox(record.chapter, record.difficulty, record.index)
		end
	end

	table.remove(self._starRewardWaitReplyRecord, 1)
	GlobalDispatcher:dispatchEvent(EventType.DUNGEON_STAR_REWARD_UPDATE)
end

function DungeonAgent:SendTakeTrainingRewardRequest(chapter, index)
	local req = DungeonExtension_pb.TakeTrainingRewardRequest()

	req.chapter = chapter
	req.index = index

	self:sendMsg(req)
	table.insert(self._teachingRewardWaitReplyRecord, {
		chapter = chapter,
		index = index + 1
	})
end

function DungeonAgent:handleTakeTrainingRewardReply(status, msg)
	if status == 0 then
		local record = self._teachingRewardWaitReplyRecord[1]

		if record then
			DungeonTeachingChapterModel.instance:takeOneReward(record.chapter, record.index)
		end
	end

	table.remove(self._teachingRewardWaitReplyRecord, 1)
	GlobalDispatcher:dispatchEvent(EventType.DUNGEON_STAR_REWARD_UPDATE)
end

function DungeonAgent:SendPassPlotDungeonRequest(code)
	local req = DungeonExtension_pb.PassPlotDungeonRequest()

	req.code = code

	self:sendMsg(req)
end

function DungeonAgent:handlePassPlotDungeonReply(status, msg)
	if status == 0 then
		DungeonModel.instance:updateDungeonPassData(0)
	end

	DungeonDispatcher:dispatchEvent(DungeonEventType.OnPassPlotDungeonReply)
end

function DungeonAgent:SendFinishPostwarPlotRequest()
	local req = DungeonExtension_pb.FinishPostwarPlotRequest()

	self:sendMsg(req)
end

function DungeonAgent:handleFinishPostwarPlotReply(status, msg)
	return
end

function DungeonAgent:SendSaveLastRecordRequest()
	local req = DungeonExtension_pb.SaveLastRecordRequest()

	self:sendMsg(req)
end

function DungeonAgent:handleSaveLastRecordReply(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show(lang("tip_save_success"))
	end
end

function DungeonAgent:sendViewVideoRequest(videoId, skipped, time)
	local msg = DungeonExtension_pb.ViewVideoRequest()

	msg.videoId = videoId
	msg.skipped = skipped
	msg.time = time

	self:sendMsg(msg)
end

function DungeonAgent:handleViewVideoReply(status, msg)
	return
end

function DungeonAgent:sendGetConsecutiveInfoRequest()
	local msg = DungeonExtension_pb.GetConsecutiveInfoRequest()

	self:sendMsg(msg)
end

function DungeonAgent:handleGetConsecutiveInfoReply(status, msg)
	if status == 0 then
		local battleModel = BattleMgr.instance:getModel()

		if battleModel then
			battleModel:setConsecutiveRound(msg.times)
			battleModel:setConsecutiveRewards(msg.rewards)
		else
			printError("无法找到activeBattleFlow的BattleModel")
		end
	end
end

function DungeonAgent:handleRecordSavedPush(status, msg)
	DungeonModel.instance:updateRecordLastTeam(msg)
end

DungeonAgent.instance = DungeonAgent.New()

return DungeonAgent
