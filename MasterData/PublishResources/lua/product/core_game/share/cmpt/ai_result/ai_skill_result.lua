require("skill_effect_result_container")
_class("AISkillResult", Object)
AISkillResult = AISkillResult

function AISkillResult:Constructor()
  self._castSkillDir = nil
  self._resultContainer = nil
  self._deadChessPetEntityIDList = {}
  self._antiChessResultList = {}
  self._hadPlay = false
  self._parallelID = nil
  self._casterEntityID = nil
end

function AISkillResult:SetCasterEntityID(casterEntityID)
  self._casterEntityID = casterEntityID
end

function AISkillResult:GetCasterEntityID()
  return self._casterEntityID
end

function AISkillResult:SetParallelID(parallelID)
  self._parallelID = parallelID
end

function AISkillResult:GetParallelID()
  return self._parallelID
end

function AISkillResult:IsHadPlay()
  return self._hadPlay
end

function AISkillResult:HadPlay()
  self._hadPlay = true
end

function AISkillResult:SetCastSkillDir(dir)
  self._castSkillDir = dir
end

function AISkillResult:GetCastSkillDir()
  return self._castSkillDir
end

function AISkillResult:GetResultContainer()
  return self._resultContainer
end

function AISkillResult:SetResultContainer(rc)
  self._resultContainer = rc
end

function AISkillResult:SetAISkillResult_DeadChessList(idList)
  self._deadChessPetEntityIDList = idList
end

function AISkillResult:GetAISkillResult_DeadChessList()
  return self._deadChessPetEntityIDList
end

function AISkillResult:SetAISkillResult_AntiChessResultList(resultList)
  self._antiChessResultList = resultList
end

function AISkillResult:GetAISkillResult_AntiChessResultList()
  return self._antiChessResultList
end
