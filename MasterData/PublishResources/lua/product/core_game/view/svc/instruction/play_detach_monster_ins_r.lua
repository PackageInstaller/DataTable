require("base_ins_r")
_class("PlayDetachMonsterInstruction", BaseInstruction)
PlayDetachMonsterInstruction = PlayDetachMonsterInstruction

function PlayDetachMonsterInstruction:Constructor(paramList)
  local str = paramList.delEffIDList
  local tmpStrIDList = string.split(str, "|")
  self._deleteEffectIDList = {}
  for i, strID in ipairs(tmpStrIDList) do
    table.insert(self._deleteEffectIDList, tonumber(strID))
  end
end

function PlayDetachMonsterInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local result = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.DetachMonster)
  if not result then
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local targetEntity = world:GetEntityByID(result:GetTargetID())
  if targetEntity == nil then
    return
  end
  if targetEntity:HasDeadMark() then
    return
  end
  if targetEntity:HasEffectHolder() then
    local effectHolderCmpt = targetEntity:EffectHolder()
    local effectDictList1 = effectHolderCmpt:GetDictEffectId()
    local effectDictList2 = effectHolderCmpt:GetEffectIDEntityDic()
    self:_DeleteEffect(world, effectDictList1)
    self:_DeleteEffect(world, effectDictList2)
  end
  local bodyAreaCmpt = targetEntity:BodyArea()
  local bodyAreaCount = bodyAreaCmpt:GetAreaCount()
  local oriEliteEffID = BattleConst.EliteMonsterPermanentEffectBodyArea1
  if bodyAreaCount ~= 1 then
    oriEliteEffID = BattleConst.EliteMonsterPermanentEffectBodyArea4
  end
  local monsterIDCmpt = targetEntity:MonsterID()
  local eliteIDArray = monsterIDCmpt:GetEliteIDArray()
  if #eliteIDArray == 0 then
    oriEliteEffID = nil
  end
  local monsterShowSvc = world:GetService("MonsterShowRender")
  local effectIDList = 0 < #eliteIDArray and monsterShowSvc:GetEliteEffectIDList(targetEntity, eliteIDArray) or {}
  local playTrailEffectEx = false
  if #effectIDList == 0 and 0 < #eliteIDArray then
    playTrailEffectEx = true
  elseif #effectIDList == 1 and effectIDList[1] == oriEliteEffID then
    playTrailEffectEx = true
  end
  self:_PlayTrailEffect(targetEntity, playTrailEffectEx)
  self:_PlayEliteEffect(targetEntity, effectIDList, oriEliteEffID)
  local playBuffService = world:GetService("PlayBuff")
  local buffArray = result:GetRemoveBuffSeqArray()
  for _, seq in pairs(buffArray) do
    local buffViewInst = targetEntity:BuffView():GetBuffViewInstance(seq)
    if buffViewInst then
      playBuffService:PlayRemoveBuff(TT, buffViewInst, NTBuffUnload:New())
    end
  end
end

function PlayDetachMonsterInstruction:_PlayTrailEffect(targetEntity, isPlay)
  if targetEntity and targetEntity:HasView() then
    local go = targetEntity:View():GetGameObject()
    local rootTF = go.transform:Find("Root")
    local trailEffectExCmpt = rootTF.gameObject:GetComponent(typeof(TrailsFX.TrailEffectEx))
    if isPlay == false then
      if trailEffectExCmpt then
        UnityEngine.Object.Destroy(trailEffectExCmpt)
      end
      targetEntity:RemoveTrailEffectEx()
      return
    end
    if trailEffectExCmpt and targetEntity:TrailEffectEx() then
      return
    end
    local trailEffect = BattleConst.EliteMonsterTrialEffect
    if targetEntity:HasMonsterID() then
      local monsterClassID = targetEntity:MonsterID():GetMonsterClassID()
      local cfg_monster_class = Cfg.cfg_monster_class[monsterClassID]
      if cfg_monster_class.TrailEffect then
        trailEffect = cfg_monster_class.TrailEffect
      end
    end
    trailEffectExCmpt = rootTF.gameObject:AddComponent(typeof(TrailsFX.TrailEffectEx))
    local world = targetEntity:GetOwnerWorld()
    local resServ = world.BW_Services.ResourcesPool
    local containerTrailEffect = resServ:LoadAsset(trailEffect)
    if not containerTrailEffect then
      resServ:CacheAsset(trailEffect, 1)
      containerTrailEffect = resServ:LoadAsset(trailEffect)
    end
    assert(containerTrailEffect)
    targetEntity:AddTrailEffectEx(containerTrailEffect, trailEffectExCmpt)
  end
end

function PlayDetachMonsterInstruction:_PlayEliteEffect(targetEntity, effectIDList, oriEliteEffID)
  local effectHolderCmpt = targetEntity:EffectHolder()
  local effectSvc = targetEntity:GetOwnerWorld():GetService("Effect")
  local oriEffEntityID
  if oriEliteEffID then
    oriEffEntityID = effectHolderCmpt:GetEliteEffEntityID(oriEliteEffID)
  end
  if #effectIDList == 1 and effectIDList[1] == oriEliteEffID and oriEffEntityID then
    effectSvc:ShowEffect({oriEffEntityID}, true)
  end
  local needDelEffIDList = {}
  local eliteDic = effectHolderCmpt:GetEliteEffIDDic()
  for effID, entityID in pairs(eliteDic) do
    if not table.icontains(effectIDList, effID) then
      effectSvc:DestroyEffectByID(entityID)
      table.insert(needDelEffIDList, effID)
    end
  end
  effectHolderCmpt:DeleteEliteEffIDDic(needDelEffIDList)
end

function PlayDetachMonsterInstruction:_DeleteEffect(world, effectList)
  for effectID, entityIDList in pairs(effectList) do
    if table.icontains(self._deleteEffectIDList, effectID) then
      for _, entityID in ipairs(entityIDList) do
        local entity = world:GetEntityByID(entityID)
        if entity then
          world:DestroyEntity(entity)
        end
      end
    end
  end
  for effectID, entityIDList in pairs(effectList) do
    if table.icontains(self._deleteEffectIDList, effectID) then
      entityIDList = {}
    end
  end
end
