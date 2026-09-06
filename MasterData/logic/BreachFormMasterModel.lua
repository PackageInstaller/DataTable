-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breachformmaster/model/BreachFormMasterModel.lua

module("logic.extensions.breachformmaster.model.BreachFormMasterModel", package.seeall)

local BreachFormMasterModel = class("BreachFormMasterModel", BaseModel)

function BreachFormMasterModel:ctor()
	return
end

function BreachFormMasterModel:onInit()
	self:onReset()
end

function BreachFormMasterModel:onReset()
	self._info = {}
	self._stageInfo = {}
	self._rankInfo = {}
	self._useDailyBuff = false
	self._tempOpponentInfo = nil
	self._battleResult = nil
	self._fmtMo = nil
	self._defenseFmtMo = nil
	self._tempIndex = nil
end

function BreachFormMasterModel:getFmtMo()
	self._fmtMo = self._fmtMo or BreachFormMasterFmtMo.New()

	return self._fmtMo
end

function BreachFormMasterModel:getDefenseFmtMo()
	self._defenseFmtMo = self._defenseFmtMo or BreachFormMasterDefenseFmtMo.New()

	return self._defenseFmtMo
end

function BreachFormMasterModel:saveInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._info[data.activityId] = data

	local stageInfo = {}

	for i, v in ipairs(data.stageList or {}) do
		stageInfo[v.stageId] = v
	end

	self._stageInfo[data.activityId] = stageInfo
end

function BreachFormMasterModel:getCurStepId(activityId)
	if self._info[activityId] then
		return self._info[activityId].stepId
	end

	return 1
end

function BreachFormMasterModel:getMyAttackScore(activityId)
	if self._info[activityId] then
		return self._info[activityId].attackScore
	end

	return 0
end

function BreachFormMasterModel:getDefenseScore(activityId)
	if self._info[activityId] then
		return self._info[activityId].defenseScore
	end

	return 0
end

function BreachFormMasterModel:getTodaySetDefenseFormTimes(activityId)
	if self._info[activityId] then
		return self._info[activityId].todaySetDefenseFormTimes
	end

	return 0
end

function BreachFormMasterModel:getStageInfos(activityId)
	return self._stageInfo[activityId]
end

function BreachFormMasterModel:getStageInfo(activityId, stageId)
	if self._stageInfo[activityId] then
		return self._stageInfo[activityId][stageId]
	end
end

function BreachFormMasterModel:saveRankInfo(msg)
	self._rankInfo[msg.activityId] = self._rankInfo[msg.activityId] or {}
	self._rankInfo[msg.activityId][msg.rankType] = self._rankInfo[msg.activityId][msg.rankType] or {}
	self._rankInfo[msg.activityId][msg.rankType][msg.stepId] = GameUtil.pbToTable(msg)
end

function BreachFormMasterModel:getRankInfo(activityId, type, stepId)
	if self._rankInfo[activityId] and self._rankInfo[activityId][type] then
		return self._rankInfo[activityId][type][stepId]
	end
end

function BreachFormMasterModel:getUseDailyBuff()
	return self._useDailyBuff
end

function BreachFormMasterModel:setUseDailyBuff(bool)
	self._useDailyBuff = bool
end

function BreachFormMasterModel:saveOpponentInfo(msg)
	self._tempOpponentInfo = msg
end

function BreachFormMasterModel:getOpponentInfo()
	return self._tempOpponentInfo
end

function BreachFormMasterModel:saveBattleResult(msg)
	self._battleResult = GameUtil.pbToTable(msg)
end

function BreachFormMasterModel:getBattleResult()
	return self._battleResult
end

function BreachFormMasterModel:resetBattleResult()
	self._battleResult = nil
end

function BreachFormMasterModel:setCurActivityId(activityId)
	self._activityId = activityId
end

function BreachFormMasterModel:getCurActivityId()
	return self._activityId
end

function BreachFormMasterModel:saveReportInfo(msg)
	self._reportInfo = GameUtil.pbToTable(msg)
end

function BreachFormMasterModel:getReportInfo()
	return self._reportInfo
end

function BreachFormMasterModel:saveSelectIndex(index)
	self._tempIndex = index
end

function BreachFormMasterModel:getSelectIndex()
	return self._tempIndex
end

BreachFormMasterModel.instance = BreachFormMasterModel.New()

return BreachFormMasterModel
