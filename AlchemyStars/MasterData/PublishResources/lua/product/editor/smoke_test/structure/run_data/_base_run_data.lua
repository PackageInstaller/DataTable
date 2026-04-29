_class("TestRobotRunData", Object)
TestRobotRunData = TestRobotRunData

function TestRobotRunData:Constructor()
  self._petInfo = {}
  self._retryCount = 0
  self._currentTeamBuild = {}
  self._taskIDList = {}
  self._manager = GameGlobal.GetModule(TestRobotModule)
  self._isExceptionDeclared = false
end

function TestRobotRunData:GetMissionID()
  return self._missionID
end

function TestRobotRunData:SetMissionID(id)
  self._missionID = id
end

function TestRobotRunData:AddPet(data, isSanityFixSkipped)
  if not isSanityFixSkipped then
    data:SanityFix()
  end
  self._petInfo[data:GetTemplateID()] = data
  if not table.icontains(self._currentTeamBuild, data) then
    table.insert(self._currentTeamBuild, data)
  end
end

function TestRobotRunData:CheckRepeatBuildData(buildDataList, data)
  local checkPetPstID = data:GetTemplateID()
  for _, v in pairs(buildDataList) do
    if v:GetTemplateID() == checkPetPstID then
      return true
    end
  end
  return false
end

function TestRobotRunData:ResetCurrentTeamBuild()
  self._currentTeamBuild = {}
end

function TestRobotRunData:GetCurrentTeamBuild()
  return self._currentTeamBuild
end

function TestRobotRunData:GetCurrentTeamBuildFormationTemplateID()
  local t = {}
  for _, data in ipairs(self._currentTeamBuild) do
    table.insert(t, data:GetTemplateID())
  end
  return t
end

function TestRobotRunData:GetPetBuildData(templateID)
  return self._petInfo[templateID]
end

function TestRobotRunData:ClearPetInfo()
  self._petInfo = {}
end

function TestRobotRunData:GetRetryCount()
  return self._retryCount
end

function TestRobotRunData:AppendRetryCount()
  self._retryCount = self._retryCount + 1
end

function TestRobotRunData:ResetRetryCount()
  self._retryCount = 0
end

function TestRobotRunData:SetLastBattleResult(bVictory)
  self._result = bVictory
end

function TestRobotRunData:GetLastBattleResult()
  return self._result
end

function TestRobotRunData:IsRandomTeam()
  return true
end

function TestRobotRunData:AddRunTaskID(taskID)
  self._taskIDList[#self._taskIDList + 1] = taskID
end

function TestRobotRunData:GetRunTaskIDList()
  return self._taskIDList
end

function TestRobotRunData:DeclareException()
  self._isExceptionDeclared = true
end

function TestRobotRunData:IsExceptionThrew()
  return self._isExceptionDeclared
end
