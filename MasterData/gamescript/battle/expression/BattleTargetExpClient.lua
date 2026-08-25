local BattleTargetExpClient, Super = System.NewClass("BattleTargetExpClient", BaseExpression)

function BattleTargetExpClient:ctor(cmdParser, targets)
  Super.ctor(self)
  self.targets = targets
  self.cmdParser = cmdParser
  self.memberValues = {}
  self.cmdFuncs = {}
  Super.InitGetter(self)
end

function BattleTargetExpClient:NormalizeTarget(target)
  if not target then
    return nil
  end
  if type(target) == "number" then
    return CopyAwakerDataUtils.GetBattleAwakerData(target) or AwakerDataUtils.GetAwakerData(target)
  end
  return target
end

function BattleTargetExpClient:GetTarget()
  local targets = rawget(self, "targets")
  do return self.NormalizeTarget, self end
  return self.NormalizeTarget, self, targets[1]
end

function BattleTargetExpClient:GetAttr(attrName)
  local target = self:GetTarget()
  if "TargetCmdOwner" == attrName then
    local cmdOwner = self:NormalizeTarget(target and target.awaker)
    if cmdOwner and self.cmdParser and self.cmdParser.GetAwaker then
      cmdOwner = self.cmdParser:GetAwaker(cmdOwner)
    end
    do return BattleTargetExpClient, self.cmdParser end
    return BattleTargetExpClient, self.cmdParser, {cmdOwner}, cmdOwner
  end
  if not target then
    return 0
  end
  if "TargetCount" == attrName then
    return #self.targets
  end
  if "ID" == attrName then
    return target.tid or target.awaker and target.awaker.tid or 0
  end
  if "School" == attrName then
    if not target.GetSchoolConfigId then
      if target.tid then
        local awakerCfg = DT.AwakerConfig[target.tid]
        if awakerCfg then
          return awakerCfg.School
        end
      end
      if SceneMgr.Instance and SceneMgr.Instance:IsInCopies() then
        local playerRole = bg.battleDataCenter:GetPlayerRoleDataModel(bc.BattleCamp.Camp1)
        return playerRole.schoolConfigId
      end
      return 0
    end
    do return target.GetSchoolConfigId end
    return target.GetSchoolConfigId, target, bc.BattleCamp.Camp1, {cmdOwner}, cmdOwner
  end
  if "tentacle_dmg" == attrName and target.GetTentacleDmg then
    do return target.GetTentacleDmg end
    return target.GetTentacleDmg, target, bc.BattleCamp.Camp1, {cmdOwner}, cmdOwner
  end
  local attrValue = 0
  if target.GetProperty then
    return target:GetProperty(attrName) or 0
  end
  if target.attrs then
    return target.attrs[attrName] or 0
  end
  return attrValue
end

function BattleTargetExpClient:GetBreakLevel()
  local target = self:GetTarget()
  if not target then
    return 0
  end
  local breakSkillLevel = BattleSkillUtils.GetBreakSkillLevel(target)
  return breakSkillLevel or 0
end

function BattleTargetExpClient:GetPotencyLevel()
  local target = self:GetTarget()
  if not target then
    return 0
  end
  local _, potencyLevel = BattleSkillUtils.GetBreakAndPotencyLevel(target)
  return potencyLevel or 0
end

function BattleTargetExpClient:__GetExistStateBaseLayer(stateId)
  local env = self.cmdParser and self.cmdParser.parserEnv
  local map = env and env.existStateLayerMap
  if map and nil ~= map[stateId] then
    return map[stateId]
  end
  return nil
end

function BattleTargetExpClient:GetStateLayer(stateId)
  local target = self:GetTarget()
  local layer = 0
  if target and type(target) == "table" then
    if bg.battleScene then
      local stateList = bg.battleDataCenter.stateData:GetStateListByOwner(target.uid or 0)
      for _, state in ipairs(stateList) do
        if state.stateId == stateId then
          layer = state.layer or 0
          break
        end
      end
    elseif WorldStageManager.Instance:IsInStage() then
      layer = StateDataUtils.GetLayer(stateId)
    elseif target.uid then
      layer = StateDataUtils.GetLayerByOwner(stateId, target.uid)
    else
      layer = StateDataUtils.GetLayer(stateId)
    end
  end
  if not layer or layer <= 0 then
    local baseLayer = self:__GetExistStateBaseLayer(stateId)
    if nil ~= baseLayer then
      return baseLayer
    end
  end
  return layer or 0
end

function BattleTargetExpClient:GetStateParam(stateId, index)
  local target = self:GetTarget()
  if not target then
    return 0
  end
  if type(target) ~= "table" then
    return 0
  end
  if bg.battleScene then
    local stateList = bg.battleDataCenter.stateData:GetStateListByOwner(target.uid or 0)
    for _, state in ipairs(stateList) do
      if state.stateId == stateId and state.layer then
        return state.stateParams[index] or 0
      end
    end
    return 0
  end
  if target.uid then
    do return StateDataUtils.GetStateParamByOwner, stateId, index end
    return StateDataUtils.GetStateParamByOwner, stateId, index, target.uid, ipairs(stateList)
  end
  for _, state in ipairs(DataCenter.stateData.stateList) do
    if state.stateId == stateId then
      return state.stateParams and state.stateParams[index] or 0
    end
  end
  return 0
end

function BattleTargetExpClient:GetAwakerSkillMultiplier()
  local target = self:GetTarget()
  if not target then
    return 0
  end
  local DT = bg.DT
  return DT.AwakerUpgrade[target.level].SkillMultiplier or 0
end

return BattleTargetExpClient
