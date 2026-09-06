-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breakformation/controller/BreakFormationController.lua

module("logic.extensions.breakformation.controller.BreakFormationController", package.seeall)

local BreakFormationController = class("BreakFormationController", BaseController)
local difficultyTips = {
	"普通难度",
	"困难难度",
	"噩梦难度"
}

function BreakFormationController:ctor()
	return
end

function BreakFormationController:onInit()
	BreachFormationAgent.instance:setShowChangeSetFunc(GameUtil.handler(self.showChangeSet, self))
	BreachFormationAgent.instance:addHandler(BreachFormationAgent.PM_BreachFormationNotifyScoreRes, self.handleNotifyAfterFight, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._reloadData, self)
	self:onReset()
end

function BreakFormationController:_reloadData()
	BreakFormationModel.instance:clearQuickOpenTime()
end

function BreakFormationController:onReset()
	self.registerNotify(self, GlobalNotify.BattleEnter, self._onBattleEnter, self)
	self.registerNotify(self, GlobalNotify.BattleEnd, self._onBattleEnd, self)

	self.cacheDifficulty = nil
	self.cacheFightId = nil
	self.cacheFightPower = nil
	self.needShowRankChange = false
	self.progTeamId = nil
	self.progIndex = nil
	self.tempMaxPetPool = {}
end

function BreakFormationController:getTempMaxPet(id)
	local list = BreakFormationModel.instance:getAllPetList()

	for i, v in ipairs(list) do
		if v.petId == id then
			local mo = BagPetsController.instance:getPet(id)

			if mo then
				v.summonMasterId = mo.summonMasterId
				v.summonedPetId = mo.summonedPetId
				v.carriedMasterId = mo.carriedMasterId
				v.carriedPetId = mo.carriedPetId
				v.heavenAwakenMasterId = mo.heavenAwakenMasterId
				v.heavenAwakenSummonPetId = mo.heavenAwakenSummonPetId
				v.oracleMasterId = mo.oracleMasterId
				v.oraclePetId = mo.oraclePetId
				v.oraclePetRaceId = mo.oraclePetRaceId
				v.bookSpiritPetId = mo.bookSpiritPetId
				v.bookSpiritRaceId = mo.bookSpiritRaceId
				v.curFaceId = mo.curFaceId
			end

			return v
		end
	end
end

function BreakFormationController:checkAndOpenView()
	BreachFormationAgent.instance:sendPM_BreachFormationGetUserInfoReq(function(msg)
		if msg.periodId == nil or msg.periodId < 0 then
			FloatWordMgr.instance:show(lang("本赛段破阵天下没有开放，请耐心等待下一赛段开启"))
		else
			BreakFormationModel.instance:handlePM_BreachFormationGetUserInfoRes(msg)
			UIStateManager.instance:push(ViewName.BreakFormation, true)
		end
	end)
end

function BreakFormationController:openBreakFormationView()
	if BreakFormationModel.instance.isDataInit then
		UIStateManager.instance:push(ViewName.BreakFormation)
	end
end

function BreakFormationController:startBattle(teamId, monsterId, fightPower)
	self.cacheDifficulty = monsterId
	self.cacheFightId = teamId
	self.cacheFightPower = fightPower

	local periodId = BreakFormationModel.instance.periodId
	local mode = BreakFormationModel.instance:getCurMode()
	local isNoraml = mode ~= BreakFormationModel.MODE_HELL

	BreachFormationAgent.instance:sendPM_BreachFormationFightReq(periodId, monsterId, isNoraml)
end

function BreakFormationController:onQuickPassRes(msg)
	local modelIns = BreakFormationModel.instance
	local hasFirstPassTimes = checknumber(msg.hasFirstPassTimes)

	if hasFirstPassTimes and checknumber(msg.hasFirstPassTimes) >= 0 then
		modelIns.hasFirstPassTimes = hasFirstPassTimes
	end

	modelIns:SetPozhanScorelist(checknumber(msg.monsterId), checknumber(msg.newScore))
	self:OpenPozhenTipsView()
end

function BreakFormationController:handleNotifyAfterFight(msg)
	self.needShowRankChange = true
	BreakFormationModel.instance.isPopupTipsParam = -1

	local newChange = checknumber(msg.newScore)

	self.cacheRankChange = newChange

	if checknumber(msg.hasFirstPassTimes) > 0 then
		BreakFormationModel.instance.hasFirstPassTimes = checknumber(msg.hasFirstPassTimes)
	end

	local normalMode = msg.normalMode

	if normalMode then
		local nowChange = BreakFormationModel.instance:GetPozhanScorelist(self.cacheDifficulty or 1)
		local sord = 0
		local cfg = BreakFormationConfig.instance:GetPozhenTeamCfg()

		if cfg then
			sord = cfg.sortOrder
		end

		if sord == 0 then
			if nowChange == nil or nowChange < 0 or newChange < nowChange then
				BreakFormationModel.instance.isPopupTipsParam = newChange
			end
		elseif sord == 1 and (nowChange == nil or nowChange < 0 or nowChange < newChange) then
			BreakFormationModel.instance.isPopupTipsParam = newChange
		end

		BreakFormationModel.instance:SetPozhanScorelist(self.cacheDifficulty or 1, newChange)
	else
		local nowChange = BreakFormationModel.instance:GetHellPozhanScorelist(self.cacheDifficulty or 1)

		BreakFormationModel.instance:SetHellPozhanScorelist(self.cacheDifficulty or 1, newChange)
	end
end

function BreakFormationController:getCoinId()
	return 26
end

function BreakFormationController:getDifficultyTip(difficulty)
	return difficultyTips[difficulty]
end

function BreakFormationController:_onBattleEnter()
	return
end

function BreakFormationController:_onBattleEnd()
	local result = BattleFacade.instance:getLastBattleResult()

	if result == GameEnum.BattleResult.Success or result == GameEnum.BattleResult.ExpSuccess then
		BreakFormationModel.instance:onResultBattle(self.cacheFightId, self.cacheDifficulty, self.cacheFightPower)
	end
end

function BreakFormationController:ReceiveProgressReward(index)
	local teamId = BreakFormationModel.instance:getFightId()

	self.progIndex = index

	local periodId = BreakFormationModel.instance.periodId

	BreachFormationAgent.instance:sendPM_BreachFormationGainProgressPrizeReq(periodId, self.progIndex, function(msg)
		BreakFormationModel.instance:SetPozhenSingleProgReceive(index + 1)
		BreakFormationController.instance:localNotify("onDataLoaded")
	end)
end

function BreakFormationController:OnReceiveChange(msg, status)
	if status == 0 then
		BreakFormationModel.instance:SetPozhenSingleProgReceive(self.progIndex + 1)
		BreakFormationController.instance:localNotify("onProgReceiveChange")
	end
end

function BreakFormationController:OpenPozhenTipsView(callback)
	local curIdx = BreakFormationModel.instance:getNewScoreIdx()

	if curIdx ~= nil then
		local mode = BreakFormationModel.instance:getCurMode()
		local isNoraml = mode ~= BreakFormationModel.MODE_HELL
		local score = BreakFormationModel.instance:GetPozhanScorelistByType(isNoraml, curIdx)
		local periodId = BreakFormationModel.instance.periodId
		local cfg = BreakFormationConfig.instance:getTeamCfg(periodId)
		local key = BreakFormationConfig.instance:getScoreName(cfg.scoreProcessor, score)

		TipsFacade.instance:openTipWindowValidX(lang("tip"), langPara("最佳记录更新！\n获得评价：%s\n获得分数：%s", string.upper(key), score), callback, nil, UnityEngine.TextAnchor.MiddleCenter)
	end
end

function BreakFormationController:showChangeSet(changeSetId, msgName)
	if msgName == "handlePM_BreachFormationNotifyScoreRes" then
		BattleSettlementModel.instance:setChangeSetId(changeSetId)
	else
		MaterialFacade.instance:popAndShowChangeSetItems(changeSetId)
	end
end

function BreakFormationController:onAddCount(callback)
	local total = BreakFormationConfig.instance:getBuyCfgLength()
	local buyTime = BreakFormationModel.instance:getHasBuyFirstPassTimes()

	if total <= buyTime then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), langPara("今天的购买次数上限%s次，请下次再来", total))
	else
		local cfg = BreakFormationConfig.instance:getBuyCfgByTimes(buyTime + 1)

		if cfg and not string.nilorempty(cfg.consume) then
			local type, id, count = MaterialMgr.getMatParams(cfg.consume)
			local content = langPara("确定要花费<color=#ebad32>%s%s</color>购买破阵次数吗？", count, MaterialMgr.getMaterialsName(type, id))

			TipsFacade.instance:openPopupCostMatViewNew(type, id, count, content, function()
				BreachFormationAgent.instance:sendPM_BreachFormationBuyFirstPassTimesReq(buyTime, function(msg)
					BreakFormationModel.instance:addHasBuyFirstPassTimes()
					BreakFormationController.instance:localNotify("onDataLoaded")
					GameUtil.callBack(callback)
				end)
			end)
		end
	end
end

function BreakFormationController:checkCanFight(index, callback)
	local mode = BreakFormationModel.instance:getCurMode()
	local isNoraml = mode ~= BreakFormationModel.MODE_HELL
	local score = BreakFormationModel.instance:GetPozhanScorelistByType(isNoraml, index)

	if score > 0 then
		GameUtil.callBack(callback)
	else
		local count = VipModel.instance:getFreeGetTimesOfBreakFormation()
		local totalCount = count + BreakFormationModel.instance:getHasBuyFirstPassTimes()
		local num = math.max(0, totalCount - BreakFormationModel.instance:getHasFirstPassTimes())

		if num > 0 then
			GameUtil.callBack(callback)
		else
			local total = BreakFormationConfig.instance:getBuyCfgLength()
			local buyTime = BreakFormationModel.instance:getHasBuyFirstPassTimes()

			if total <= buyTime then
				TipsFacade.instance:openTipWindowNoX(lang("tip"), langPara("今天的购买次数上限%s次，所有的挑战次数已经用完，请下次再来", total))
			else
				local cfg = BreakFormationConfig.instance:getBuyCfgByTimes(buyTime + 1)

				if cfg and not string.nilorempty(cfg.consume) then
					local type, id, matNum = MaterialMgr.getMatParams(cfg.consume)
					local content = langPara("今天所有的挑战次数已经用完，可以购买更多次数继续破阵。确定要花费<color=#ebad32>%s%s</color>购买破阵次数吗？\n每天可以购买%s次，当前剩余购买次数：%s", matNum, MaterialMgr.getMaterialsName(type, id), total, total - buyTime)

					TipsFacade.instance:openPopupCostMatViewNew(type, id, matNum, content, function()
						BreachFormationAgent.instance:sendPM_BreachFormationBuyFirstPassTimesReq(buyTime, function(msg)
							BreakFormationModel.instance:addHasBuyFirstPassTimes()
							BreakFormationController.instance:localNotify("onDataLoaded")
							GameUtil.callBack(callback)
						end)
					end)
				end
			end
		end
	end
end

function BreakFormationController:onQuickPassXiaoNuoRes(msg)
	local modelIns = BreakFormationModel.instance
	local hasFirstPassTimes = checknumber(msg.hasFirstPassTimes)

	if hasFirstPassTimes and checknumber(msg.hasFirstPassTimes) >= 0 then
		modelIns.hasFirstPassTimes = hasFirstPassTimes
	end

	modelIns:SetPozhanScorelist(checknumber(msg.monsterId), checknumber(msg.newScore))
	modelIns:resetNewScoreIdx()
end

BreakFormationController.instance = BreakFormationController.New()

return BreakFormationController
