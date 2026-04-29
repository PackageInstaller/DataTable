_class("TalentBaseParam", Object)
TalentBaseParam = TalentBaseParam

function TalentBaseParam:Constructor(t, type, level)
  self._talentType = type
  self._level = level
end

function TalentBaseParam:GetTalentType()
  return self._talentType
end

function TalentBaseParam:GetTalentLevel()
  return self._level
end

_class("TalentAddBuffParam", TalentBaseParam)
TalentAddBuffParam = TalentAddBuffParam

function TalentAddBuffParam:Constructor(t)
  self._buffIDList = t.BuffIDList
  self._buffTargetType = t.BuffTargetType
  self._buffTargetParam = t.BuffTargetParam
end

function TalentAddBuffParam:GetBuffID()
  if #self._buffIDList < self._level then
    return
  end
  return self._buffIDList[self._level]
end

function TalentAddBuffParam:GetBuffTargetType()
  return self._buffTargetType
end

function TalentAddBuffParam:GetBuffTargetParam()
  return self._buffTargetParam
end

_class("TalentMasterSkillParam", TalentBaseParam)
TalentMasterSkillParam = TalentMasterSkillParam

function TalentMasterSkillParam:Constructor(t)
  self._featureList = t
end

function TalentMasterSkillParam:GetFeatureList()
  return self._featureList
end

_class("TalentAddRoundCountParam", TalentBaseParam)
TalentAddRoundCountParam = TalentAddRoundCountParam

function TalentAddRoundCountParam:Constructor(t)
  self._levelIDList = t.LevelIDList
  self._count = t.AddCount or 0
end

function TalentAddRoundCountParam:GetAddCountByLevelID(levelID)
  if not table.icontains(self._levelIDList, levelID) then
    return 0
  end
  return self._count * self._level
end

_class("TalentAddChangeTeamLeaderCountParam", TalentBaseParam)
TalentAddChangeTeamLeaderCountParam = TalentAddChangeTeamLeaderCountParam

function TalentAddChangeTeamLeaderCountParam:Constructor(t)
  self._count = t.AddCount or 0
end

function TalentAddChangeTeamLeaderCountParam:GetAddCount()
  return self._count * self._level
end

_class("TalentChooseRelicParam", TalentBaseParam)
TalentChooseRelicParam = TalentChooseRelicParam

function TalentChooseRelicParam:Constructor(t)
  self._groupID = t.relicGroupID or 0
  self._randomCount = t.randomCount or 0
end

function TalentChooseRelicParam:GetGroupID()
  return self._groupID
end

function TalentChooseRelicParam:GetRandomCount()
  return self._randomCount
end
