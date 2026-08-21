_class("BuffViewAccumulateSoulAddDamage", BuffViewBase)
BuffViewAccumulateSoulAddDamage = BuffViewAccumulateSoulAddDamage

function BuffViewAccumulateSoulAddDamage:PlayView(TT, notify)
  local result = self:GetBuffResult()
  local curAccumulateNum = result:GetLayer()
  self._entity:BuffView():SetBuffValue("SoulCount", curAccumulateNum)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SetAccumulateNum, self._entity:PetPstID():GetPstID(), curAccumulateNum)
  if notify:GetNotifyEntity() == self._entity then
    return
  end
  self:_PlayCollectSoul(TT, notify:GetTargetEntityList(), notify:GetNotifyEntity())
  local cfgData = self._viewInstance:BuffConfigData()
  local cfg = cfgData:GetViewParams()
  if not cfg then
    return
  end
  local waitTime = cfg.waitBuffViewTime
  if waitTime then
    YIELD(TT, waitTime)
  end
end

function BuffViewAccumulateSoulAddDamage:_PlayCollectSoul(TT, targetEntityList, casterEntity)
  local cfgData = self._viewInstance:BuffConfigData()
  local cfg = cfgData:GetViewParams()
  if not cfg then
    return
  end
  if targetEntityList == nil or table.count(targetEntityList) <= 0 then
    return
  end
  local targetGridPosList = {}
  for k, v in pairs(targetEntityList) do
    if v and v:Location() then
      targetGridPosList[#targetGridPosList + 1] = v:Location():GetPosition()
    end
  end
  if not self._skillService then
    self._skillService = self._world:GetService("PlaySkill")
  end
  local effectService = self._world:GetService("Effect")
  local castAudioId = cfg.castAudioId
  local castAnimName = cfg.castAnimName
  local castEffect = cfg.castEffect
  local gridEffectId = cfg.gridEffectID
  local bornEffectId = cfg.bornEffectID
  local bornEffectTime = cfg.bornEffectTime
  local startHigh = cfg.startHigh
  local flyTime = cfg.flyTime
  local endHigh = cfg.endHigh
  local castEndEffectId = cfg.castEndEffectId
  local castEndEffectTime = cfg.castEndEffectTime
  if castAudioId then
    self._skillService:PlayCastAudio(TT, castAudioId, 0)
  end
  local effectList = self:_PlayAnimationEffect(TT, casterEntity, castAnimName, castEffect, 0)
  if bornEffectId and 0 < bornEffectId then
    for k, v in pairs(targetGridPosList) do
      local renderPos = v
      local effectEntity = effectService:CreatePositionEffect(bornEffectId, renderPos)
    end
  end
  YIELD(TT, bornEffectTime)
  local effectEntityList = {}
  for k, v in pairs(targetGridPosList) do
    local renderPos = v
    renderPos.y = renderPos.y + startHigh
    local effect = effectService:CreatePositionEffect(gridEffectId, renderPos)
    table.insert(effectEntityList, {entity = effect, position = renderPos})
  end
  local taskIDs = {}
  for k, v in pairs(effectEntityList) do
    local view = v.entity:View()
    local go = view:GetGameObject()
    local curTaskID = GameGlobal.TaskManager():CoreGameStartTask(self._DoFlyLine, self, v.entity, casterEntity, v.position, flyTime, endHigh)
    if 0 < curTaskID then
      taskIDs[#taskIDs + 1] = curTaskID
    end
    YIELD(TT)
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDs) do
    YIELD(TT)
  end
  for i = 1, #effectList do
    self._world:DestroyEntity(effectList[i])
  end
  self:_PlayAnimationEffect(TT, casterEntity, nil, castEndEffectId, castEndEffectTime)
end

function BuffViewAccumulateSoulAddDamage:_PlayAnimationEffect(TT, casterEntity, stAnimationName, nEffectID, nEffectTime)
  if stAnimationName and "" ~= stAnimationName then
    casterEntity:SetAnimatorControllerTriggers({stAnimationName})
  end
  local effectList = {}
  if nEffectID then
    local effectService = self._world:GetService("Effect")
    local listEffectID = {}
    if type(nEffectID) == "number" then
      if 0 < nEffectID then
        listEffectID[#listEffectID + 1] = nEffectID
      end
    elseif type(nEffectID) == "table" then
      listEffectID = nEffectID
    end
    for i = 1, #listEffectID do
      effectList[#effectList + 1] = effectService:CreateEffect(listEffectID[i], casterEntity)
    end
  end
  YIELD(TT, nEffectTime)
  return effectList
end

function BuffViewAccumulateSoulAddDamage:_DoFlyLine(TT, entityEffect, entityCaster, effectRenderPos, flyTime, endHigh)
  local boardServiceRender = self._world:GetService("BoardRender")
  local posCaster = entityCaster:GetGridPosition()
  local gridWorldpos = boardServiceRender:GridPos2RenderPos(posCaster)
  local effectViewCmpt = entityEffect:View()
  local effectObject = effectViewCmpt:GetGameObject()
  gridWorldpos.y = gridWorldpos.y + endHigh
  local endtime = GameGlobal:GetInstance():GetCurrentTime() + flyTime
  local transWork = effectObject.transform
  local nFlyTime = flyTime / 1000.0
  local easeWork = transWork:DOMove(gridWorldpos, nFlyTime, false):SetEase(DG.Tweening.Ease.InOutSine)
  while endtime > GameGlobal:GetInstance():GetCurrentTime() do
    YIELD(TT)
  end
  effectObject:SetActive(false)
  self._world:DestroyEntity(entityEffect)
end
