-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bountypkcompete/model/BountyPkCompetePhaseHandler.lua

module("logic.extensions.bountypkcompete.model.BountyPkCompetePhaseHandler", package.seeall)

local BountyPkCompetePhaseHandler = class("BountyPkCompetePhaseHandler")

BountyPkCompetePhaseHandler.PhaseSettingForm = 1
BountyPkCompetePhaseHandler.PhaseAfterSetForm = 2
BountyPkCompetePhaseHandler.PhaseBetting = 3
BountyPkCompetePhaseHandler.PhaseAfterBet = 4

function BountyPkCompetePhaseHandler:ctor()
	return
end

function BountyPkCompetePhaseHandler:_initBuff()
	local configInstance = BountyPKCompeteConfig.instance
	local seasonConfig = configInstance:getSeasonConfig(BountyPKCompeteModel.instance:getActivityId())
	local buffs = configInstance:getBuffConfigs(seasonConfig.buffPlan)
	local validator = buffs[1].validator
	local temp = string.split(validator, "#")
	local validatorType = temp[1]

	if validatorType == "mainAttr" then
		self._validateFunc = self._validateMainAttr
	elseif validatorType == "sex" then
		self._validateFunc = self._validateSex
	end

	self._buffMap = {}

	for _, config in ipairs(buffs) do
		temp = string.split(config.validator, "#")
		self._buffMap[checknumber(temp[2])] = config
	end
end

function BountyPkCompetePhaseHandler:reset()
	self.roundId = 0
	self.opHeadInfo = {}
	self.myScore = 0
	self.myBetScore = 0
	self.opScore = 0
	self.myForm = {}
	self.opForm = {}
	self.myPetIds = {}
	self.gameTimeMills = 0
	self.scorePool = 0
	self.phase = 0
	self.isEndAll = false
	self.isHasSetFormation = {}
	self.state = nil
	self.myTeamId = nil
	self.battleResult = nil
	self.result = nil
	self.changeSetId = nil
	self.oldScore = nil
	self.endTimeStamp = 0
	self.fmtMo = BountyPkCompeteFmtMo.New()
end

function BountyPkCompetePhaseHandler:initByParams(params)
	self:reset()
	self:_initBuff()

	self.matchType = params.matchType
	self.roundId = params.roundId
	self.opHeadInfo = params.opHeadInfo
	self.opScore = params.opScore
	self.scorePool = params.scorePool
	self.myScore = params.myScore
	self.myPetIds = params.myFormInfo.myPetIds
	self.myForm = params.myFormInfo.form
	self.gameTimeMills = params.gameTimeMills

	self:enterOperatePet(params)
end

function BountyPkCompetePhaseHandler:setPhaseData()
	local seasonConfig = BountyPKCompeteConfig.instance:getSeasonConfig(BountyPKCompeteModel.instance:getActivityId())
	local gateConfigs = BountyPKCompeteConfig.instance:getGateConfigs(seasonConfig.seasonId)

	self.gateConfig = gateConfigs[self.matchType]

	local roundConfigs = BountyPKCompeteConfig.instance:getRoundConfigs()

	self.roundConfig = roundConfigs[self.roundId]
	self.myBetScore = self.scorePool * 0.5
	self.cost = self.gateConfig.roundCost[self.roundId]

	self:_calCountDown()
	self:getMyFormation():SetData(self.myForm)
	self:_setPetFixPosState()
end

function BountyPkCompetePhaseHandler:_calCountDown()
	local delta = 0
	local sec = 0

	if self.isEndAll then
		sec = BountyPKCompeteConfig.instance:getCommonValue("READY_TIME", true)
	else
		delta = ServerTime.now() - math.floor(self.gameTimeMills / 1000)
		sec = (self.phase == BountyPkCompetePhaseHandler.PhaseSettingForm or self.phase == BountyPkCompetePhaseHandler.PhaseAfterSetForm) and self.roundConfig.adjustTime or self.roundConfig.betTime
	end

	self.endTimeStamp = UnityEngine.Time.realtimeSinceStartup + sec - delta
end

function BountyPkCompetePhaseHandler:_setPetFixPosState()
	self.cachePositions = {}

	for i, v in ipairs(self.myForm.pos) do
		if v > 0 then
			self.cachePositions[i] = v
		end
	end
end

function BountyPkCompetePhaseHandler:validateFormationView()
	self.fmtMo:updateAll()
	GlobalDispatcher:dispatch(GlobalNotify.ForceChangeCurFormTab)
end

function BountyPkCompetePhaseHandler:getMyFormCachePosIds()
	return table.keys(self.cachePositions)
end

function BountyPkCompetePhaseHandler:enterOperatePet(params)
	self.roundId = params.roundId
	self.scorePool = params.scorePool
	self.myPetIds = params.myFormInfo.myPetIds
	self.myForm = params.myFormInfo.form
	self.gameTimeMills = params.gameTimeMills

	self:setPhaseData()

	if self:isPhaseOverTime() then
		self:endOperatePet()
	else
		self.phase = BountyPkCompetePhaseHandler.PhaseSettingForm
	end

	self:validateFormationView()
	self:clearAllTipsWindow()
end

function BountyPkCompetePhaseHandler:endOperatePet()
	if self.phase == BountyPkCompetePhaseHandler.PhaseAfterBet or self.phase == BountyPkCompetePhaseHandler.PhaseBetting then
		return
	end

	self.phase = BountyPkCompetePhaseHandler.PhaseAfterSetForm

	self:validateFormationView()
	self:clearAllTipsWindow()
end

function BountyPkCompetePhaseHandler:enterBet(params)
	self.roundId = params.roundId
	self.myForm = params.myForm
	self.opForm = params.opForm
	self.gameTimeMills = params.gameTimeMills

	self:setPhaseData()

	if self:isPhaseOverTime() then
		self:endBet()
	else
		self.phase = BountyPkCompetePhaseHandler.PhaseBetting
	end

	self:validateFormationView()
	self:clearAllTipsWindow()
end

function BountyPkCompetePhaseHandler:endBet()
	self.phase = BountyPkCompetePhaseHandler.PhaseAfterBet

	self:clearAllTipsWindow()
end

function BountyPkCompetePhaseHandler:clearAllTipsWindow()
	UIStateManager.instance:popByName(ViewName.BountyPKCompetePopView)

	if self._popupView and self._popupView:isOpen() then
		self._popupView:close()

		self._popupView = nil
	end
end

function BountyPkCompetePhaseHandler:parseGameEnd(params)
	self.isEndAll = true
	self.state = params.state
	self.myTeamId = params.myTeamId
	self.battleResult = params.battleResult
	self.result = params.result
	self.changeSetId = params.changeSetId
	self.oldScore = params.oldScore
	self.newScore = params.newScore

	MaterialController.instance:saveChangeSetToTemp(self.changeSetId)
	UIStateManager.instance:popByName(ViewName.BountyPKCompetePopView)

	if self._popupView and self._popupView:isOpen() then
		self._popupView:close()

		self._popupView = nil
	end

	self:setPhaseData()
end

function BountyPkCompetePhaseHandler:isPhaseOverTime()
	return UnityEngine.Time.realtimeSinceStartup > self.endTimeStamp
end

function BountyPkCompetePhaseHandler:reqAbandon()
	local strContent = langPara("bountypk__1", self.myBetScore)

	self._popupView = TipsFacade.instance:openPopupWindow(lang("tip"), strContent, function()
		self._popupView = nil

		BountyPKCompeteAgent.instance:sendPM_BountyPKRetreatReq()
	end, function()
		self._popupView = nil
	end)
end

function BountyPkCompetePhaseHandler:reqFollow()
	local seasonConfig = BountyPKCompeteConfig.instance:getSeasonConfig(BountyPKCompeteModel.instance:getActivityId())
	local gateConfigs = BountyPKCompeteConfig.instance:getGateConfigs(seasonConfig.seasonId)
	local gateConfig = gateConfigs[self.matchType]
	local roundCost = gateConfig.roundCost[self.roundId]

	UIStateManager.instance:push(ViewName.BountyPKCompetePopView, {
		cost = roundCost,
		total = self.scorePool,
		callback = function()
			BountyPKCompeteAgent.instance:sendPM_BountyPKSetBetReq(true)
		end
	})
end

function BountyPkCompetePhaseHandler:reqSetFormation()
	if not self.isHasSetFormation[self.roundId] then
		self._popupView = TipsFacade.instance:openPopupWindow(lang("tip"), lang("bountypk__19"), function()
			self._popupView = nil

			self:_doSetFormation()
		end, function()
			self._popupView = nil
		end)
	end
end

function BountyPkCompetePhaseHandler:_doSetFormation()
	self.isHasSetFormation[self.roundId] = true

	local form = self.fmtMo:getCurSimpleForm()

	BountyPKCompeteAgent.instance:sendPM_BountyPKSetFormReq(form)
end

function BountyPkCompetePhaseHandler:checkOpBuff()
	if self.opForm and self.opForm.pos then
		local configInstance = BountyPKCompeteConfig.instance
		local result = {}

		for _, petId in ipairs(self.opForm.pos) do
			if petId > 0 then
				local data = configInstance:getSystemPetConfig(petId)

				trycall(self._validateFunc, self, data.raceId, result)
			end
		end

		local maxCount = 0

		for _, v in pairs(result) do
			maxCount = math.max(maxCount, v)
		end

		return maxCount, self._buffMap[maxCount]
	end

	return 0
end

function BountyPkCompetePhaseHandler:checkMyBuff()
	local configInstance = BountyPKCompeteConfig.instance
	local formation = self.fmtMo:getCurFormation()
	local position = formation:GetPositions()
	local result = {}

	for _, petId in ipairs(position) do
		if petId > 0 then
			local data = configInstance:getSystemPetConfig(petId)

			trycall(self._validateFunc, self, data.raceId, result)
		end
	end

	local maxCount = 0

	for i, v in pairs(result) do
		maxCount = math.max(maxCount, v)
	end

	return maxCount, self._buffMap[maxCount]
end

function BountyPkCompetePhaseHandler:_validateSex(raceId, result)
	local basicInfo = HandbookController.instance:getPetBasicInfo(raceId)

	if basicInfo then
		result[basicInfo.sex] = result[basicInfo.sex] or 0
		result[basicInfo.sex] = result[basicInfo.sex] + 1
	end
end

function BountyPkCompetePhaseHandler:_validateMainAttr(raceId, result)
	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(raceId)

	race = math.fmod(race, 10)

	local targetValue = race - 1

	result[targetValue] = result[targetValue] or 0
	result[targetValue] = result[targetValue] + 1
end

function BountyPkCompetePhaseHandler:tryModifyByAdjust(petId, pos)
	if self.roundConfig.formNum <= 0 and self.roundConfig.changeNum > 0 and (self.phase == BountyPkCompetePhaseHandler.PhaseSettingForm or self.phase == BountyPkCompetePhaseHandler.PhaseAfterSetForm) then
		local nowPositions = self:getMyFormation():GetPositions()
		local newPositions = {}

		for i, v in pairs(nowPositions) do
			if v > 0 then
				newPositions[i] = v
			end
		end

		local oldId = newPositions[pos]

		if oldId > 0 then
			local petMo = self:getMyFormation():_getPet(oldId)

			if petMo and petMo:isSummonedPet() then
				FloatWordMgr.instance:show(lang("不能操作"))

				return
			end
		end

		newPositions[pos] = petId

		local count = self:_comparePositionChangeCount(newPositions, self.cachePositions)

		if count > self.roundConfig.changeNum then
			FloatWordMgr.instance:show(lang("超过了替换精灵的上限"))
		else
			self:getMyFormation():SetPosition(pos, petId, false)
		end
	end
end

function BountyPkCompetePhaseHandler:isInFormation(petId)
	return self:getMyFormation():HasPet(petId)
end

function BountyPkCompetePhaseHandler:getMyFormation()
	return self.fmtMo:getCurFormation()
end

function BountyPkCompetePhaseHandler:isMyFormationFull()
	local nowCount = 0
	local nowPositions = self:getMyFormation():GetPositions()

	for _, petId in ipairs(nowPositions) do
		if petId > 0 then
			nowCount = nowCount + 1
		end
	end

	return nowCount == self.fmtMo.needUpPetCount
end

function BountyPkCompetePhaseHandler:tryAutoSetFormation()
	if not self.isHasSetFormation[self.roundId] and self:isMyFormationFull() then
		self:reqSetFormation()
	end
end

function BountyPkCompetePhaseHandler:_comparePositionChangeCount(newPositions, oldPositions)
	local hasCompareMap = {}
	local count = 0

	for i, v in pairs(newPositions) do
		if not hasCompareMap[i] and oldPositions[i] ~= v then
			count = count + 1
			hasCompareMap[i] = true
		end
	end

	for i, v in pairs(oldPositions) do
		if not hasCompareMap[i] and newPositions[i] ~= v then
			count = count + 1
			hasCompareMap[i] = true
		end
	end

	return count
end

function BountyPkCompetePhaseHandler:getChangeScore()
	return self.newScore - self.oldScore
end

function BountyPkCompetePhaseHandler:getChangeScoreStr()
	local scoreChange = self:getChangeScore()

	return scoreChange > 0 and string.format("+%s", scoreChange) or string.format("%s", scoreChange)
end

return BountyPkCompetePhaseHandler
