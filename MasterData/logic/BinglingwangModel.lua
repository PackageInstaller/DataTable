-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/model/BinglingwangModel.lua

module("logic.extensions.timelimitedchallenge.model.BinglingwangModel", package.seeall)

local BinglingwangModel = class("BinglingwangModel", BaseModel)

function BinglingwangModel:ctor()
	BinglingwangModel.super.ctor(self)
end

function BinglingwangModel:onInit()
	self:onReset()
end

function BinglingwangModel:onReset()
	self.currMonsterCfg = nil
	self.modelMap = {}
	self.challengeInfoMap = {}
	self.isWin = false
end

function BinglingwangModel:getChallangeInfoById(challengeId)
	return self.challengeInfoMap[challengeId]
end

function BinglingwangModel:getMoByChallengeId(challengeId)
	return self.modelMap[challengeId]
end

function BinglingwangModel:setCurrMonsterCfg(cfg)
	self.currMonsterCfg = cfg
end

function BinglingwangModel:getCurrMonsterCfg()
	return self.currMonsterCfg
end

function BinglingwangModel:sendGetInfo(challengeId)
	IceKingChallengeAgent.instance:sendPM_IKCGetInfoReq(challengeId)
end

function BinglingwangModel:onGetInfo(msg)
	local mo = {}

	mo.rankSize = msg.rankSize
	mo.hasGainDailyPrize = msg.hasGainDailyPrize
	mo.itemCount = msg.itemCount
	mo.gainedPrizeIds = msg.gainedPrizeIds
	mo.challengeId = msg.challengeId
	self.modelMap[msg.challengeId] = mo

	GlobalDispatcher:dispatch(GlobalNotify.PM_IKCGetInfoRes, msg.challengeId)
end

function BinglingwangModel:sendGetDailyPrize(challengeId)
	IceKingChallengeAgent.instance:sendPM_IKCGainDailyPrizeReq(challengeId)
end

function BinglingwangModel:onGetDailyPrize(msg)
	local mo = self:getMoByChallengeId(msg.challengeId) or {}

	mo.itemCount = msg.itemCount
	mo.hasGainDailyPrize = true
	self.modelMap[msg.challengeId] = mo

	local baseCfg = BinglingwangConfig.instance:getBaseConfig(msg.challengeId) or {}
	local count = checknumber(baseCfg.dailyItemCount)
	local str = langPara("恭喜你获得了\n冰晶雪花x%s", count)

	TipsFacade.instance:openTipWindowNoX(lang("tip"), str, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
	GlobalDispatcher:dispatch(GlobalNotify.PM_IKCGetInfoRes, msg.challengeId)
end

function BinglingwangModel:sendGetProgressPrize(challengeId, prizeId)
	IceKingChallengeAgent.instance:sendPM_IKCGainProgressPrizeReq(challengeId, prizeId)
end

function BinglingwangModel:onGetProgressPrize(msg)
	local mo = self:getMoByChallengeId(msg.challengeId) or {}

	mo.gainedPrizeIds = mo.gainedPrizeIds or {}

	table.insert(mo.gainedPrizeIds, msg.prizeId)

	self.modelMap[msg.challengeId] = mo

	GlobalDispatcher:dispatch(GlobalNotify.PM_IKCGetInfoRes, msg.challengeId)
end

function BinglingwangModel:sendGetChanllengeInfo(challengeId)
	IceKingChallengeAgent.instance:sendPM_IKCGetChallengeInfoReq(challengeId)
end

function BinglingwangModel:onGetChanllengeInfo(msg)
	local info = {}

	info.everPassAllStage = msg.everPassAllStage
	info.participateDays = msg.participateDays
	info.worldZdl = msg.worldZdl
	info.todayAlivePetCount = msg.todayAlivePetCount
	info.todayPassStage = msg.todayPassStage
	info.everAlivePets = GameUtil.pbToTable(msg.everAlivePets)
	info.challengeId = msg.challengeId
	self.challengeInfoMap[msg.challengeId] = info

	GlobalDispatcher:dispatch(GlobalNotify.PM_IKCGetInfoRes, msg.challengeId)
end

function BinglingwangModel:sendSweep(challengeId, stage)
	IceKingChallengeAgent.instance:sendPM_IKCSweepStageReq(challengeId, stage)
end

function BinglingwangModel:onGetSweepStage(msg)
	local mo = self:getMoByChallengeId(msg.challengeId) or {}

	mo.itemCount = msg.itemCount
	self.modelMap[msg.challengeId] = mo

	local info = self:getChallangeInfoById(msg.challengeId)

	info.todayPassStage = checknumber(info.todayPassStage) + 1

	if checknumber(msg.todayAlivePetCount) > 0 then
		info.todayAlivePetCount = msg.todayAlivePetCount
	end

	self.challengeInfoMap[msg.challengeId] = info

	TipsFacade.instance:openCommonTips(lang("扫荡成功！"))
	GlobalDispatcher:dispatch(GlobalNotify.PM_IKCGetInfoRes, msg.challengeId)
end

function BinglingwangModel:sendFight(challengeId, stage)
	IceKingChallengeAgent.instance:sendPM_IKCChallengeStageReq(challengeId, stage)
end

function BinglingwangModel:onChallengeEndRes(msg)
	local mo = self:getMoByChallengeId(msg.challengeId) or {}

	if checknumber(msg.itemCount) > 0 then
		mo.itemCount = msg.itemCount
	end

	self.isWin = msg.isWin

	if checknumber(msg.alivePetCount) > 0 then
		local info = self:getChallangeInfoById(msg.challengeId)

		info.todayAlivePetCount = checknumber(info.todayAlivePetCount) + msg.alivePetCount
		info.todayPassStage = checknumber(info.todayPassStage) + 1
		info.everAlivePets = info.everAlivePets or {}
		info.everAlivePets[msg.stage] = math.max(checknumber(info.everAlivePets[msg.stage]), msg.alivePetCount)
		self.challengeInfoMap[msg.challengeId] = info
	end

	self.modelMap[msg.challengeId] = mo

	GlobalDispatcher:dispatch(GlobalNotify.PM_IKCGetInfoRes, msg.challengeId)
end

BinglingwangModel.instance = BinglingwangModel.New()

return BinglingwangModel
