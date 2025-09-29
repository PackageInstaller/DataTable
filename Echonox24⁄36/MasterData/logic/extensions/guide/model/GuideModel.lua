-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/model/GuideModel.lua

module("logic.extensions.guide.model.GuideModel", package.seeall)

local TriggerType = GuideEnum.TriggerType
local GuideModel = class("GuideModel", BaseModel)
local recordMaxCount = 20

function GuideModel:ctor()
	GuideModel.super.ctor(self)

	self._stepExecList = {}
	self._gmStartGuideId = nil
	self._answers = {}
	self._allGuideDict = {}
	self._battleUnFinishList = {}
end

function GuideModel:onInit()
	GuideModel.super.onInit(self)
end

function GuideModel:onReset()
	GuideModel.super.onReset(self)

	self._stepExecList = {}
	self._gmStartGuideId = nil
	self._allGuideDict = {}
end

function GuideModel:execStep(guideId, stepId)
	self:addStepLog(string.format("%d_%d", guideId, stepId))
end

function GuideModel:addStepLog(logStr)
	if #self._stepExecList >= recordMaxCount then
		table.remove(self._stepExecList, 1)
	end

	table.insert(self._stepExecList, logStr)
end

function GuideModel:getStepExecStr()
	return table.concat(self._stepExecList, ",")
end

function GuideModel:initGuide(finished)
	local list = GuideConfig.instance:getGuideCOList()

	for i = 1, #list do
		local guideInfo = list[i]
		local guideId = guideInfo.id
		local guideMO = GuideMO.New()

		guideMO:setGuideState(false)
		guideMO:initGuideInfo(guideInfo)

		for j = 1, #finished do
			if finished[j] == guideId then
				guideMO:setGuideState(true)

				break
			end
		end

		self._allGuideDict[guideId] = guideMO
	end
end

function GuideModel:finishStep(guideId, stepId)
	local guideMO = self:getGuideMO(guideId)

	guideMO:setFinishClientStep(stepId)
end

function GuideModel:getGuideMO(guideId)
	return self._allGuideDict[guideId]
end

function GuideModel:getAllGuides()
	return self._allGuideDict
end

function GuideModel:getBattleUnFinishGuides(triggerType)
	local battleUnFinishList = false
	local isFind = false
	local list = self:getAllGuides()

	for _, v in pairs(list) do
		if not v:getGuideFinish() and v:isOnLine() then
			isFind = false

			if triggerType then
				if triggerType == v:getGuideCO().triggerType then
					isFind = true
				end
			elseif v:getIsBattleGuide() then
				isFind = true
			end

			if isFind then
				battleUnFinishList = battleUnFinishList or {}

				table.insert(battleUnFinishList, v)
			end
		end
	end

	return battleUnFinishList
end

function GuideModel:getBattleUnFinishGuideByDungeonCode(dungeonCode, triggerType, isFindBreak)
	local battleUnFinishList = self:getBattleUnFinishGuides(triggerType)
	local findList = false

	if battleUnFinishList then
		local triggerParam = false

		for _, v in pairs(battleUnFinishList) do
			triggerParam = v:getTriggerParamParse()

			if triggerParam and tonumber(triggerParam[1]) == dungeonCode then
				findList = findList or {}

				table.insert(findList, v)

				if isFindBreak then
					break
				end
			end
		end
	end

	return findList
end

function GuideModel:getBattleTriggerGuideInRound(dungeonCode, round)
	local list = self:getDoingGuideIdList()

	if not list then
		return false
	end

	for i = 1, #list do
		local guideMO = self:getGuideMO(list[i])

		if guideMO:getIsBattleGuide() then
			local triggerParam = guideMO:getTriggerParamParse()

			if triggerParam then
				local targetDungeonCode = tonumber(triggerParam[1])
				local targetRound = tonumber(triggerParam[2])

				if targetDungeonCode == dungeonCode and targetRound == round then
					return true
				end
			end
		end
	end

	return false
end

function GuideModel:getDoingGuideIdList()
	local list

	for _, v in pairs(self._allGuideDict) do
		local guideMO = v

		if not guideMO.isFinish then
			list = list or {}

			table.insert(list, guideMO.id)
		end
	end

	return list
end

function GuideModel:isGuideFinish(guideId)
	local guideMO = self:getGuideMO(guideId)

	if not guideMO or guideMO.isFinish then
		return true
	end

	return false
end

function GuideModel:setFinishGuide(guideId)
	local guideMO = self:getGuideMO(guideId)

	if guideMO then
		guideMO:setGuideState(true)
	end
end

function GuideModel:setOpenSytemState(guideId, isOpen)
	local guideMO = self:getGuideMO(guideId)

	if guideMO then
		guideMO:trySetOpenSytemState(isOpen)
	end
end

function GuideModel:gmStartGuide(guideId)
	self._gmStartGuideId = guideId
end

function GuideModel:isGMStartGuide(guideId)
	return guideId == self._gmStartGuideId
end

function GuideModel:isFinishedAllForceGuide()
	local list = self:getDoingGuideIdList()

	if list and #list > 0 then
		return false
	end

	return true
end

function GuideModel:addPlotAnswers(question, answers)
	if not self._answers[question] then
		self._answers[question] = {}
	end

	for i, v in ipairs(answers) do
		self._answers[question][v] = true
	end
end

function GuideModel:initPlotAnswers(answers)
	self._answers = {}

	for i, answer in ipairs(answers) do
		self._answers[answer.question] = {}

		for j, v in ipairs(answer.answer) do
			self._answers[answer.question][v] = true
		end
	end
end

function GuideModel:hasPlotAnswer(question, answer)
	if not self._answers[question] then
		return false
	end

	if self._answers[question][answer] then
		return true
	end

	return false
end

GuideModel.instance = GuideModel.New()

return GuideModel
