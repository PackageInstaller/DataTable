-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/answerfunc/model/AnswerFuncModel.lua

module("logic.extensions.answerfunc.model.AnswerFuncModel", package.seeall)

local AnswerFuncModel = class("AnswerFuncModel", BaseModel)

function AnswerFuncModel:ctor()
	self.curChoiseParam = nil
	self._answerFuncInfo = nil
	self._curClientKey = nil
	self._curServerKey = nil
end

function AnswerFuncModel:onInit()
	AnswerFuncModel.super.onInit(self)
	self:onReset()
end

function AnswerFuncModel:onReset()
	AnswerFuncModel.super.onReset(self)

	self.curChoiseParam = nil
	self._answerFuncInfo = nil
	self._curClientKey = nil
	self._curServerKey = nil
end

function AnswerFuncModel:getAnswerFuncInfo()
	if self._answerFuncInfo == nil then
		self._answerFuncInfo = {
			useNum = 0,
			score = 0,
			poltHasLook = {}
		}
		self._answerFuncInfo.activityId = 0
		self._answerFuncInfo.typeId = 0
	end

	return self._answerFuncInfo
end

function AnswerFuncModel:getTypeId()
	return (self._answerFuncInfo or nil) and (self._answerFuncInfo.typeId or 0)
end

function AnswerFuncModel:getPlotPlanId()
	local info = self:getAnswerFuncInfo()
	local typeData = AnswerFuncConfig.instance:getTypeData(info.activityId, info.typeId)

	return (typeData or nil) and typeData.plotPlanId
end

function AnswerFuncModel:getAnswerAllChapterByPlanId(planId)
	local allCfgs = AnswerFuncConfig.instance:getAnswerStageCfgs(planId)

	if allCfgs then
		if not #allCfgs then
			return 0
		end
	end
end

function AnswerFuncModel:getAnswerAllScoreByPlanId(planId)
	local allScore = 0
	local cfgs = AnswerFuncConfig.instance:getAnswerStageCfgs(planId)

	if cfgs then
		for _, cfg in pairs(cfgs) do
			for _, data in pairs(cfg) do
				allScore = allScore + data.scoreLimit
			end
		end
	end

	return allScore
end

function AnswerFuncModel:getAnswerChapterStageList(planId, chapterId)
	local allCfgs = AnswerFuncConfig.instance:getAnswerStageCfgs(planId)

	if allCfgs then
		if not #allCfgs then
			local allCount = 0

			if allCount == 0 then
				return nil
			end

			if chapterId and allCfgs[chapterId] then
				return allCfgs[chapterId]
			end

			local afInfo = self:getAnswerFuncInfo()
			local temp

			for i = 1, allCount do
				if allCfgs[i] and #allCfgs[i] > 0 then
					temp = allCfgs[i]

					if afInfo == nil or afInfo.poltHasLook == nil then
						return temp
					end

					for _, cfg in pairs(allCfgs[i]) do
						if cfg and cfg.scoreLimit > afInfo.score or not table.indexof(afInfo.poltHasLook, cfg.onlyId) then
							return temp
						end
					end
				end
			end

			return temp
		end
	end
end

function AnswerFuncModel:isAnswerChapterUnlock(planId, chapterId)
	local allCfgs = AnswerFuncConfig.instance:getAnswerStageCfgs(planId, chapterId)

	if allCfgs == nil or #allCfgs == 0 then
		return "未解锁"
	end

	local afInfo = self:getAnswerFuncInfo()

	if allCfgs[1] and allCfgs[1].scoreLimit > afInfo.score then
		return string.format("累计获得%s积分后解锁！", allCfgs[1].scoreLimit)
	end

	return ""
end

function AnswerFuncModel:scSendAnswerProblemUnlockPlotInfo(msg)
	self._answerFuncInfo = {}
	self._answerFuncInfo.activityId = msg.activityId
	self._answerFuncInfo.typeId = msg.typeId
	self._answerFuncInfo.score = checknumber(msg.score)
	self._answerFuncInfo.useNum = checknumber(msg.hasAnswerTime)
	self._answerFuncInfo.poltHasLook = {}

	for _, v in pairs(msg.poltHasLook or {}) do
		if v and checknumber(v) > 0 then
			table.insert(self._answerFuncInfo.poltHasLook, checknumber(v))
		end
	end
end

function AnswerFuncModel:scSendAnswerProblemUnlockPlotGainPrize(msg)
	self._answerFuncInfo = self._answerFuncInfo or {}
	self._answerFuncInfo.activityId = msg.activityId
	self._answerFuncInfo.poltHasLook = self._answerFuncInfo.poltHasLook or {}

	table.insert(self._answerFuncInfo.poltHasLook, checknumber(msg.onlyId))
end

function AnswerFuncModel:scSendAnswerProblemUnlockPlotResult(msg)
	self._answerFuncInfo = self._answerFuncInfo or {}
	self._answerFuncInfo.resultInfo = {}
	self._answerFuncInfo.resultInfo.num = checknumber(msg.num)
	self._answerFuncInfo.resultInfo.addScore = checknumber(msg.addScore)
	self._answerFuncInfo.useNum = checknumber(msg.hasAnswerTime)
	self._answerFuncInfo.score = checknumber(msg.curScore)
end

function AnswerFuncModel:resetClientServerKey()
	self._curClientKey = nil
	self._curServerKey = nil
end

function AnswerFuncModel:setClientKey(key)
	self._curClientKey = key
end

function AnswerFuncModel:setServerKey(key)
	self._curServerKey = key
end

function AnswerFuncModel:getEncryptedKey(...)
	local clientKey = self._curClientKey
	local serverKey = self._curServerKey
	local nums = {
		...
	}

	return GameUtil.getClientEncryptedKey(clientKey, serverKey, nums)
end

function AnswerFuncModel:getAnswerFuncChapterRed(planId, chapterId)
	local allCfgs = AnswerFuncConfig.instance:getAnswerStageCfgs(planId, chapterId)

	if allCfgs == nil or #allCfgs == 0 then
		return false
	end

	local afInfo = self:getAnswerFuncInfo()

	if afInfo == nil or afInfo.score <= 0 then
		return false
	end

	for i = 1, #allCfgs do
		if allCfgs[i] and allCfgs[i].scoreLimit <= afInfo.score and not table.indexof(afInfo.poltHasLook, allCfgs[i].onlyId) then
			return true
		end
	end

	return false
end

AnswerFuncModel.instance = AnswerFuncModel.New()

return AnswerFuncModel
