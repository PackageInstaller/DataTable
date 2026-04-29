_class("TestRobotMissionRunData", TestRobotRunData)
TestRobotMissionRunData = TestRobotMissionRunData

function TestRobotMissionRunData:SetMissionChapterID(id)
  self._chapterID = id
end

function TestRobotMissionRunData:SetMissionNodeIndex(index)
  self._nodeIndex = index
end

function TestRobotMissionRunData:SetStageIndex(index)
  self._stageIndex = index
end

_class("TestRobotExtraMissionRunData", TestRobotRunData)
TestRobotExtraMissionRunData = TestRobotExtraMissionRunData

function TestRobotExtraMissionRunData:SetChapterIndex(index)
  self._chapterIndex = index
end

function TestRobotExtraMissionRunData:SetMissionIndex(index)
  self._missionIndex = index
end

_class("TestRobotMazeRunData", TestRobotRunData)
TestRobotMazeRunData = TestRobotMazeRunData

function TestRobotMazeRunData:SetCurrentTeamPstIDList(petPstIds)
  self._currentTeamPstIDList = petPstIds
end

function TestRobotMazeRunData:GetCurrentTeamPstIDList()
  return self._currentTeamPstIDList
end

_class("TestRobotTowerRunData", TestRobotRunData)
TestRobotTowerRunData = TestRobotTowerRunData

function TestRobotTowerRunData:SetTowerElementType(val)
  self._elementType = val
end

function TestRobotTowerRunData:GetTowerElementType()
  return self._elementType
end

_class("TestRobotResDungeonRunData", TestRobotRunData)
TestRobotResDungeonRunData = TestRobotResDungeonRunData
_class("TestRobotSummerIIEventRunData", TestRobotRunData)
TestRobotSummerIIEventRunData = TestRobotSummerIIEventRunData

function TestRobotSummerIIEventRunData:ParseLevelData(args)
  self._missionID = tonumber(args[1])
  self._componentConfigID = tonumber(args[2])
  self:ParseConfigID()
  if 2 < table.count(args) then
    self._hardID = tonumber(args[3])
  end
  self._affixList = {}
  if table.count(args) > 3 then
    for i = 4, #args do
      table.insert(self._affixList, tonumber(args[i]))
    end
  end
end

function TestRobotSummerIIEventRunData:GetEnterMatchParam()
  local param = {
    self:GetMissionID(),
    ECampaignMissionComponentId.ECampaignMissionComponentId_SummerII,
    {
      [ECampaignMissionParamKey.ECampaignMissionParamKey_ComCfgId] = self:GetComponentConfigID()
    }
  }
  return param
end

function TestRobotSummerIIEventRunData:ParseConfigID()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaignID, self._componentID, self.componentType = campaignModule:ParseCfgComponentID(self._componentConfigID)
end

function TestRobotSummerIIEventRunData:GetCampaignID()
  return self._campaignID
end

function TestRobotSummerIIEventRunData:GetMissionID()
  return self._missionID
end

function TestRobotSummerIIEventRunData:GetComponentID()
  return self._componentID
end

function TestRobotSummerIIEventRunData:GetComponentConfigID()
  return self._componentConfigID
end

function TestRobotSummerIIEventRunData:HaseAffix()
  if not self._hardID then
    return false
  end
  return true
end

function TestRobotSummerIIEventRunData:GetHardID()
  return self._hardID
end

function TestRobotSummerIIEventRunData:GetAffixList()
  return self._affixList
end
