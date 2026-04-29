require("base_service")
_class("TalentService", BaseService)
TalentService = TalentService

function TalentService:Constructor(world)
  self._world = world
  self._parseTalentParam = {}
  self._parseTalentParam[TalentType.Buff] = TalentAddBuffParam
  self._parseTalentParam[TalentType.MasterSkill] = TalentMasterSkillParam
  self._parseTalentParam[TalentType.AddRoundCount] = TalentAddRoundCountParam
  self._parseTalentParam[TalentType.AddChangeTeamLeaderCount] = TalentAddChangeTeamLeaderCountParam
  self._parseTalentParam[TalentType.ChooseRelic] = TalentChooseRelicParam
end

function TalentService:GetTalentComponent()
  local talentCmpt = self._world:GetBoardEntity():Talent()
  return talentCmpt
end

function TalentService:HasTalentData(talentType)
  if self._world:GetRunningPosition() == WorldRunPostion.Performance then
    return false
  end
  local talentCmpt = self:GetTalentComponent()
  return talentCmpt:HasTalentData(talentType)
end

function TalentService:GetTalentData(talentType)
  local talentCmpt = self:GetTalentComponent()
  return talentCmpt:GetTalentDataList(talentType)
end

function TalentService:ParseTalentData_MiniMaze(talentTreeSkills, unlockRelicIDs)
  local talentCmpt = self:GetTalentComponent()
  talentCmpt:SetUnlockRelicIDList(unlockRelicIDs)
  if table.count(talentTreeSkills) < 1 then
    return
  end
  for _, talent in ipairs(talentTreeSkills) do
    local talentCfg = Cfg.cfg_mini_maze_talent[talent.skill_id]
    if not talentCfg or not talentCfg.Param then
      Log.exception("ParseTalentData cant find talent :", talent.skill_id)
      return
    end
    local paramClassType = self._parseTalentParam[talentCfg.Type]
    if paramClassType == nil then
      Log.exception("ParseTalentData cant find talentType :", talentCfg.Type)
      return
    end
    if talentCfg.Type ~= TalentType.MasterSkill or talent.select ~= 0 then
      local talentParam = paramClassType:New(talentCfg.Param, talentCfg.Type, talent.level)
      talentCmpt:AddTalentData(talentCfg.Type, talentParam)
    end
  end
end

function TalentService:ParseTalentData_Campaign(talentTreeSkills)
  if not talentTreeSkills then
    return
  end
  local talentCmpt = self:GetTalentComponent()
  if table.count(talentTreeSkills) < 1 then
    return
  end
  for _, talentID in ipairs(talentTreeSkills) do
    local talentCfg = Cfg.cfg_battle_talent[talentID]
    if not talentCfg then
      Log.exception("ParseTalentData_Campaign cant find talent :", talentID)
      return
    end
    if talentCfg.Param then
      local paramClassType = self._parseTalentParam[talentCfg.Type]
      if paramClassType == nil then
        Log.exception("ParseTalentData_Campaign cant find talentType :", talentCfg.Type)
        return
      end
      local talentLevel = 1
      local talentParam = paramClassType:New(talentCfg.Param, talentCfg.Type, talentLevel)
      talentCmpt:AddTalentData(talentCfg.Type, talentParam)
    end
  end
end

function TalentService:GetUnlockRelicIDList()
  local talentCmpt = self:GetTalentComponent()
  return talentCmpt:GetUnlockRelicIDList()
end

function TalentService:NeedChooseOpeningRelic()
  local talentCmpt = self:GetTalentComponent()
  if talentCmpt:IsChosenOpeningRelic() then
    return false
  end
  local groupID, count = self:GetChooseRelicParam()
  if groupID == 0 and count == 0 then
    return false
  end
  return true
end

function TalentService:InitTalentBuff(GameStartBuffs)
  if not self:HasTalentData(TalentType.Buff) then
    return
  end
  local buffLogic = self._world:GetService("BuffLogic")
  local paramList = self:GetTalentData(TalentType.Buff)
  for _, param in ipairs(paramList) do
    local ret = buffLogic:AddBuffByTargetType(param:GetBuffID(), param:GetBuffTargetType(), param:GetBuffTargetParam())
    for _, inst in ipairs(ret) do
      GameStartBuffs[#GameStartBuffs + 1] = {
        inst:Entity(),
        inst:BuffSeq()
      }
    end
  end
end

function TalentService:ChangeFeature(featureList)
  if not self:HasTalentData(TalentType.MasterSkill) then
    return
  end
  local paramList = self:GetTalentData(TalentType.MasterSkill)
  for _, param in ipairs(paramList) do
    local cfgFeatureList = param:GetFeatureList()
    if cfgFeatureList then
      local featureCfg = cfgFeatureList.feature
      if featureCfg then
        for type, data in pairs(featureCfg) do
          featureList[type] = data
        end
      end
    end
  end
end

function TalentService:GetAddRoundCount(levelID)
  local count = 0
  if self:HasTalentData(TalentType.AddRoundCount) then
    local paramList = self:GetTalentData(TalentType.AddRoundCount)
    for _, param in ipairs(paramList) do
      count = count + param:GetAddCountByLevelID(levelID)
    end
  end
  return count
end

function TalentService:GetAddChangeTeamLeaderCount()
  local count = 0
  if self:HasTalentData(TalentType.AddChangeTeamLeaderCount) then
    local paramList = self:GetTalentData(TalentType.AddChangeTeamLeaderCount)
    for _, param in ipairs(paramList) do
      count = count + param:GetAddCount()
    end
  end
  return count
end

function TalentService:GetChooseRelicParam()
  local groupID = 0
  local randomCount = 0
  if self:HasTalentData(TalentType.ChooseRelic) then
    local paramList = self:GetTalentData(TalentType.ChooseRelic)
    for _, param in ipairs(paramList) do
      local tempGroupID = param:GetGroupID()
      local tempRandomCount = param:GetRandomCount()
      if groupID < tempGroupID then
        groupID = tempGroupID
        randomCount = tempRandomCount
      elseif tempGroupID == groupID and tempRandomCount > randomCount then
        randomCount = tempRandomCount
      end
    end
  end
  return groupID, randomCount
end
