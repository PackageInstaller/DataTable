_class("BuffViewAddElite", BuffViewBase)
BuffViewAddElite = BuffViewAddElite

function BuffViewAddElite:PlayView(TT)
  local buffRes = self._buffResult
  local eliteIDArray = buffRes:GetEliteIDArray()
  if #eliteIDArray == 0 then
    return
  end
  local bodyAreaCmpt = self._entity:BodyArea()
  local bodyAreaCount = bodyAreaCmpt:GetAreaCount()
  local oriEliteEffID = BattleConst.EliteMonsterPermanentEffectBodyArea1
  if bodyAreaCount ~= 1 then
    oriEliteEffID = BattleConst.EliteMonsterPermanentEffectBodyArea4
  end
  local monsterShowSvc = self._world:GetService("MonsterShowRender")
  local effectIDList = monsterShowSvc:GetEliteEffectIDList(self._entity, eliteIDArray)
  local playTrailEffectEx = false
  if #effectIDList == 0 then
    playTrailEffectEx = true
  elseif #effectIDList == 1 and effectIDList[1] == oriEliteEffID then
    playTrailEffectEx = true
  end
  self:_PlayTrailEffect(self._entity, playTrailEffectEx)
  self:_PlayEliteEffect(self._entity, effectIDList, oriEliteEffID)
  local playBuffService = self._world:GetService("PlayBuff")
  local buffArray = buffRes:GetAddBuffSeqArray()
  for _, seq in pairs(buffArray) do
    local buffViewInst = self._entity:BuffView():GetBuffViewInstance(seq)
    if buffViewInst then
      playBuffService:PlayAddBuff(TT, buffViewInst, self._entity:GetID())
    end
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local hpBarType = utilDataSvc:GetHPBarTypeByEntity(self._entity)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateBossNameAndElement, self._entity:MonsterID():GetMonsterID(), hpBarType, self._entity:GetID())
end

function BuffViewAddElite:_PlayTrailEffect(targetEntity, isPlay)
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

function BuffViewAddElite:_PlayEliteEffect(targetEntity, effectIDList, oriEliteEffID)
  local effectHolderCmpt = targetEntity:EffectHolder()
  local oriEffEntityID = effectHolderCmpt:GetEliteEffEntityID(oriEliteEffID)
  local needCreateEffIDList = {}
  if #effectIDList == 1 and effectIDList[1] == oriEliteEffID then
    if oriEffEntityID then
      return
    else
      needCreateEffIDList[#needCreateEffIDList + 1] = oriEliteEffID
    end
  else
    for _, effID in ipairs(effectIDList) do
      if not effectHolderCmpt:GetEliteEffEntityID(effID) then
        needCreateEffIDList[#needCreateEffIDList + 1] = effID
      end
    end
  end
  local effectSvc = targetEntity:GetOwnerWorld():GetService("Effect")
  if oriEffEntityID then
    effectSvc:ShowEffect({oriEffEntityID}, false)
  end
  for _, effID in ipairs(needCreateEffIDList) do
    local effectEntity = effectSvc:CreateEffect(effID, targetEntity)
    effectHolderCmpt:AttachPermanentEffect(effectEntity:GetID())
    effectHolderCmpt:AddEliteEffID(effID, effectEntity:GetID())
  end
end
