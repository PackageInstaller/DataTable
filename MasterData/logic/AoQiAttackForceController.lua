-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/controller/AoQiAttackForceController.lua

module("logic.extensions.aoqiattackforce.controller.AoQiAttackForceController", package.seeall)

local AoQiAttackForceController = class("AoQiAttackForceController", BaseController)

function AoQiAttackForceController:ctor()
	return
end

function AoQiAttackForceController:onInit()
	self:onReset()
end

function AoQiAttackForceController:onReset()
	return
end

function AoQiAttackForceController:getInfo(activityId)
	AoQiAttackForceAgent.instance:sendPM_AoQiAttackForceInfoReq(activityId)
end

function AoQiAttackForceController:handleGetInfo(msg)
	AoQiAttackForceModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.AQAFGetInfoRes)
end

function AoQiAttackForceController:getRankInfo(activityId)
	AoQiAttackForceAgent.instance:sendPM_AoQiAttackForceRankInfoReq(activityId)
end

function AoQiAttackForceController:handleGetRankInfo(msg)
	AoQiAttackForceModel.instance:onGetRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.AQAFGetRankInfoRes)
end

function AoQiAttackForceController:handleGetHeroRankInfo(msg)
	AoQiAttackForceModel.instance:onGetHeroRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.AQAFGetRankInfoRes)
end

function AoQiAttackForceController:upgradeEquipment(activityId, equipmentId)
	AoQiAttackForceAgent.instance:sendPM_AoQiAttackForceUpgradeEquipmentReq(activityId, equipmentId)
end

function AoQiAttackForceController:handleUpgradeEquipment(msg)
	AoQiAttackForceModel.instance:onUpgradeEquipment(msg)
	GlobalDispatcher:dispatch(GlobalNotify.AQAFEquipmentInfoUpdate)
end

function AoQiAttackForceController:adjustEquipment(activityId, equipmentId, isUse)
	AoQiAttackForceAgent.instance:sendPM_AoQiAttackForceSetEquipmentReq(activityId, equipmentId, isUse)
end

function AoQiAttackForceController:handleAdjustEquipment(msg)
	AoQiAttackForceModel.instance:onAdjustEquipment(msg)
	GlobalDispatcher:dispatch(GlobalNotify.AQAFEquipmentInfoUpdate)
end

function AoQiAttackForceController:sweepClg(activityId, challengeId)
	AoQiAttackForceAgent.instance:sendPM_AoQiAttackForceChallengeSweepReq(activityId, challengeId)
end

function AoQiAttackForceController:handleSweepClg(msg)
	AoQiAttackForceModel.instance:onSweepClg(msg)
	GlobalDispatcher:dispatch(GlobalNotify.AQAFGetInfoRes)
end

function AoQiAttackForceController:startClg(activityId, challengeId)
	local clientKey = ServerTime.nowServerLook()

	AoQiAttackForceModel.instance:saveClientKey(clientKey)
	AoQiAttackForceAgent.instance:sendPM_AoQiAttackForceChallengeStartGameReq(activityId, challengeId, clientKey)
end

function AoQiAttackForceController:handleStartGame(msg)
	local info = msg
	local activityId = info.activityId
	local challengeId = info.challengeId

	AoQiAttackForceModel.instance:saveServeKey(info.serverKey)
	AoQiAttackForceModel.instance:initGameClgData(activityId, challengeId)
	UIStateManager.instance:push(ViewName.AoqiattackbackpackView)
end

function AoQiAttackForceController:endClg(isWin)
	local serverKey = AoQiAttackForceModel.instance:getServeKey()
	local clientKey = AoQiAttackForceModel.instance:getClientKey()

	serverKey = GenEncryptedKeyUtil.dxor(serverKey, clientKey)

	local encryptedKey = 0

	local function encrypt(num)
		encryptedKey = num % 2 == 0 and encryptedKey + (num + serverKey) * 5381 or encryptedKey + (num + clientKey) * 31
	end

	local curWave = AoQiAttackForceModel.instance:getCurWaveId()

	if not isWin then
		curWave = curWave - 1
	end

	local goldNum = AoQiAttackForceModel.instance:getCurCostCoinNum()

	encrypt(curWave)
	encrypt(goldNum)

	local clgCfg = AoQiAttackForceModel.instance:getCurClgCfg()
	local mergeTimes = AoQiAttackForceModel.instance:getCurMergeTimes()

	AoQiAttackForceAgent.instance:sendPM_AoQiAttackForceChallengeEndGameReq(clgCfg.activityId, clgCfg.challengeId, curWave, goldNum, encryptedKey, mergeTimes)
end

function AoQiAttackForceController:handleEndClg()
	local clgCfg = AoQiAttackForceModel.instance:getCurClgCfg()

	AoQiAttackForceController.instance:getInfo(clgCfg.activityId)
	UIStateManager.instance:popByName(ViewName.AoQiAttackForceGameView)
	UIStateManager.instance:popByName(ViewName.AoqiattackbackpackView)
end

function AoQiAttackForceController:startFinalClg(activityId)
	local clientKey = ServerTime.nowServerLook()

	AoQiAttackForceModel.instance:saveClientKey(clientKey)
	AoQiAttackForceAgent.instance:sendPM_AoQiAttackForceEndlessStartGameReq(activityId, clientKey)
end

function AoQiAttackForceController:handleFinalClg(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId

	AoQiAttackForceModel.instance:saveServeKey(info.serverKey)
	AoQiAttackForceModel.instance:initGameFinalClgData(activityId)
	UIStateManager.instance:push(ViewName.AoqiattackbackpackView)
end

function AoQiAttackForceController:endFinalClg()
	local serverKey = AoQiAttackForceModel.instance:getServeKey()
	local clientKey = AoQiAttackForceModel.instance:getClientKey()

	serverKey = GenEncryptedKeyUtil.dxor(serverKey, clientKey)

	local encryptedKey = 0

	local function encrypt(num)
		encryptedKey = num % 2 == 0 and encryptedKey + (num + serverKey) * 5381 or encryptedKey + (num + clientKey) * 31
	end

	local killNum = AoQiAttackForceModel.instance:getCurKillScore()
	local goldNum = AoQiAttackForceModel.instance:getCurCostCoinNum()

	encrypt(killNum)
	encrypt(goldNum)

	local clgCfg = AoQiAttackForceModel.instance:getCurClgCfg()
	local mergeTimes = AoQiAttackForceModel.instance:getCurMergeTimes()

	AoQiAttackForceAgent.instance:sendPM_AoQiAttackForceEndlessEndGameReq(clgCfg.activityId, killNum, goldNum, encryptedKey, mergeTimes)
end

function AoQiAttackForceController:handleEndFinalClg()
	local clgCfg = AoQiAttackForceModel.instance:getCurClgCfg()

	AoQiAttackForceController.instance:getInfo(clgCfg.activityId)
	UIStateManager.instance:popByName(ViewName.AoQiAttackForceGameView)
	UIStateManager.instance:popByName(ViewName.AoqiattackbackpackView)
end

function AoQiAttackForceController:startHeroClg(activityId)
	local clientKey = ServerTime.nowServerLook()

	AoQiAttackForceModel.instance:saveClientKey(clientKey)
	AoQiAttackForceAgent.instance:sendPM_AoQiAttackForceHeroChallengeStartGameReq(activityId, clientKey)
end

function AoQiAttackForceController:handleHeroClg(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId

	AoQiAttackForceModel.instance:saveServeKey(info.serverKey)
	AoQiAttackForceModel.instance:initGameHeroClgData(activityId)
	AoQiAttackForceModel.instance:recordWaveState()
	UIStateManager.instance:push(ViewName.AoqiattackbackpackView)
end

function AoQiAttackForceController:endHeroClg(isWin)
	local serverKey = AoQiAttackForceModel.instance:getServeKey()
	local clientKey = AoQiAttackForceModel.instance:getClientKey()

	serverKey = GenEncryptedKeyUtil.dxor(serverKey, clientKey)

	local encryptedKey = 0

	local function encrypt(num)
		encryptedKey = num % 2 == 0 and encryptedKey + (num + serverKey) * 5381 or encryptedKey + (num + clientKey) * 31
	end

	local curWave = AoQiAttackForceModel.instance:getCurWaveId()

	if not isWin then
		curWave = curWave - 1
	end

	local killNum = AoQiAttackForceModel.instance:getCurKillScore()
	local goldNum = AoQiAttackForceModel.instance:getCurCostCoinNum()

	encrypt(curWave)
	encrypt(killNum)
	encrypt(goldNum)

	local clgCfg = AoQiAttackForceModel.instance:getCurClgCfg()
	local mergeTimes = AoQiAttackForceModel.instance:getCurMergeTimes()

	AoQiAttackForceAgent.instance:sendPM_AoQiAttackForceHeroChallengeEndGameReq(clgCfg.activityId, curWave, goldNum, killNum, encryptedKey, mergeTimes)
end

function AoQiAttackForceController:handleEndHeroClg()
	local clgCfg = AoQiAttackForceModel.instance:getCurClgCfg()

	AoQiAttackForceController.instance:getInfo(clgCfg.activityId)
	UIStateManager.instance:popByName(ViewName.AoQiAttackForceGameView)
	UIStateManager.instance:popByName(ViewName.AoqiattackbackpackView)
end

function AoQiAttackForceController:sweepHeroClg(activityId)
	AoQiAttackForceAgent.instance:sendPM_AoQiAttackForceHeroChallengeSweepReq(activityId)
end

function AoQiAttackForceController:handleHeroSweepClg(msg)
	local activityCfg = AoQiAttackForceConfig.instance:getActivityCfg(msg.activityId)
	local maxPrizeLimit = activityCfg.heroPrizeDailyLimit

	AoQiAttackForceModel.instance:onHeroSweepClg(msg, maxPrizeLimit)
	GlobalDispatcher:dispatch(GlobalNotify.AQAFGetInfoRes)
end

function AoQiAttackForceController:onEndFight(isWin)
	if AoQiAttackForceModel.instance:getIsEndlessState() then
		local tips = langPara("终极挑战已结束！\n本次消灭怪物数量：%s", AoQiAttackForceModel.instance:getCurKillScore())

		TipsFacade.instance:openTipWindowNoX(lang("提示"), tips, function()
			self:endFinalClg()
		end, lang("确定"), UnityEngine.TextAnchor.MiddleCenter)
	elseif isWin then
		if AoQiAttackForceModel.instance:getIsHeroState() then
			if AoQiAttackForceModel.instance:getCurIsLastWave() then
				local tips = lang("当前挑战已全通，后续可进行扫荡")

				TipsFacade.instance:openTipWindowNoX(lang("提示"), tips, function()
					self:endHeroClg(isWin)
				end, lang("确定"), UnityEngine.TextAnchor.MiddleCenter)
			else
				local addIncome = AoQiAttackForceModel.instance:getIncomeByCurEquipment()
				local curWaveCfg = AoQiAttackForceModel.instance:getCurWaveCfg()
				local addTips = addIncome == 0 and "" or langPara(",装备额外奖励%s金币", addIncome)
				local tips = langPara("已通关第%s波,获得基础奖励%s金币%s", AoQiAttackForceModel.instance:getCurWaveId(), curWaveCfg.passReward, addTips)

				TipsFacade.instance:openTipWindowNoX(lang("提示"), tips, function()
					AoQiAttackForceModel.instance:udpateWave()

					local buffList = AoQiAttackForceModel.instance:getRandomBuffList(1)

					if #buffList >= 1 then
						UIStateManager.instance:push(ViewName.AoQiAttackForceLotteryBuffView)
						UIStateManager.instance:popByName(ViewName.AoQiAttackForceGameView)
					else
						UIStateManager.instance:push(ViewName.AoqiattackbackpackView)
						UIStateManager.instance:popByName(ViewName.AoQiAttackForceGameView)
					end
				end, lang("确定"), UnityEngine.TextAnchor.MiddleCenter)
			end
		elseif AoQiAttackForceModel.instance:getCurIsLastWave() then
			local tips = lang("当前挑战已全通，后续可进行扫荡")

			TipsFacade.instance:openTipWindowNoX(lang("提示"), tips, function()
				self:endClg(isWin)
			end, lang("确定"), UnityEngine.TextAnchor.MiddleCenter)
		else
			local addIncome = AoQiAttackForceModel.instance:getIncomeByCurEquipment()
			local curWaveCfg = AoQiAttackForceModel.instance:getCurWaveCfg()
			local addTips = addIncome == 0 and "" or string.format(",装备额外奖励%s金币", addIncome)
			local tips = langPara("已通关第%s波,获得基础奖励%s金币%s", AoQiAttackForceModel.instance:getCurWaveId(), curWaveCfg.passReward, addTips)

			TipsFacade.instance:openTipWindowNoX(lang("提示"), tips, function()
				AoQiAttackForceModel.instance:udpateWave()
				UIStateManager.instance:push(ViewName.AoQiAttackForceSelectBuffView)
				UIStateManager.instance:popByName(ViewName.AoQiAttackForceGameView)
			end, lang("确定"), UnityEngine.TextAnchor.MiddleCenter)
		end
	elseif AoQiAttackForceModel.instance:getIsHeroState() then
		UIStateManager.instance:push(ViewName.AoQiAttackForceHeroFailView)
	else
		local tips = langPara("很遗憾，本次试炼止步于第%s波，再接再厉", AoQiAttackForceModel.instance:getCurWaveId())

		TipsFacade.instance:openTipWindowNoX(lang("提示"), tips, function()
			self:endClg(isWin)
			UIStateManager.instance:popByName(ViewName.AoQiAttackForceGameView)
		end, lang("确定"), UnityEngine.TextAnchor.MiddleCenter)
	end
end

AoQiAttackForceController.instance = AoQiAttackForceController.New()

return AoQiAttackForceController
