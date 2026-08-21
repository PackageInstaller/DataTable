_class("EffectService", Object)
EffectService = EffectService

function EffectService:Constructor(world)
  self._world = world
  self._configService = world:GetService("Config")
end

function EffectService:Initialize()
  self._renderEntityService = self._world:GetService("RenderEntity")
end

function EffectService:DestroyStaticEffect(e)
  local cEffectHolder = e:EffectHolder()
  if not cEffectHolder then
    return
  end
  local permanentEffectList = cEffectHolder:GetPermanentEffect()
  self:_DestroyEffectArray(permanentEffectList)
  local idleEffectList = cEffectHolder:GetIdleEffect()
  self:_DestroyEffectArray(idleEffectList)
  local weakEffectList = cEffectHolder:GetWeakEffect()
  self:_DestroyEffectArray(weakEffectList)
  local effectIDEntityDic = cEffectHolder:GetEffectIDEntityDic()
  for _, entityIDList in pairs(effectIDEntityDic) do
    for _, entityID in pairs(entityIDList) do
      local effectEntity = self._world:GetEntityByID(entityID)
      if effectEntity ~= nil then
        self._world:DestroyEntity(effectEntity)
      end
    end
  end
  local dictEffectId = cEffectHolder:GetDictEffectId()
  if dictEffectId then
    for key, list in pairs(dictEffectId) do
      for index, id in ipairs(list) do
        local eEffect = self._world:GetEntityByID(id)
        if eEffect then
          self._world:DestroyEntity(eEffect)
        end
      end
    end
  end
end

function EffectService:_DestroyEffectArray(effectIDArray)
  for _, effectID in ipairs(effectIDArray) do
    local effectEntity = self._world:GetEntityByID(effectID)
    if effectEntity ~= nil then
      self._world:DestroyEntity(effectEntity)
    end
  end
end

function EffectService:GetEffectHolder(effectID)
  local effectConfigItem = Cfg.cfg_effect[effectID]
  if not effectConfigItem then
    return "caster"
  end
  return effectConfigItem.Holder
end

function EffectService:CreateEffectEntity()
  local e = self._renderEntityService:CreateRenderEntity(EntityConfigIDRender.Effect)
  return e
end

function EffectService:CreateEffect(effectID, holderEntity, state)
  local eInitialHolder = holderEntity
  local eAvatar
  if holderEntity:HasEffectHolder() then
    local cEffectHolder = holderEntity:EffectHolder()
    local teAvatar = cEffectHolder:GetEffectList("BuffViewShowHidePetRoot") or {}
    if teAvatar[1] then
      eAvatar = teAvatar[1]
      holderEntity = eAvatar
    end
  end
  local show = true
  if state ~= nil then
    show = state
  end
  local effectConfigItem = Cfg.cfg_effect[effectID]
  if not effectConfigItem then
    Log.fatal("EffectService CreateEffect failed:", effectID, " ", Log.traceback())
    return nil
  end
  if effectConfigItem.ResPath == nil then
    Log.fatal("cannot find effect res ,effectID is", effectID)
  end
  local effectEntity = self:CreateEffectEntity()
  effectEntity:ReplaceAsset(NativeUnityPrefabAsset:New(effectConfigItem.ResPath, show))
  effectEntity:AddEffectController(holderEntity, effectConfigItem.BindPos, effectConfigItem.Duration, effectConfigItem.Type)
  local effCtrl = effectEntity:EffectController()
  if effectConfigItem.FollowMove ~= nil then
    effCtrl:SetFollowMove(effectConfigItem.FollowMove)
  end
  if effectConfigItem.FollowRotate ~= nil then
    effCtrl:SetFollowRotate(effectConfigItem.FollowRotate)
  end
  if effectConfigItem.BindLayer then
    effCtrl:SetBindLayer(effectConfigItem.BindLayer)
  end
  if effectConfigItem.FollowRotateCaster then
    effCtrl:SetFollowRotateCaster(effectConfigItem.FollowRotateCaster)
  end
  local effectHolder = holderEntity:EffectHolder()
  if not effectHolder then
    holderEntity:AddEffectHolder()
    effectHolder = holderEntity:EffectHolder()
  end
  effectHolder:AttachEffectByEffectID(effectID, effectEntity:GetID())
  if eAvatar then
    if not eInitialHolder:HasEffectHolder() then
      eInitialHolder:AddEffectHolder()
    end
    local cInitialEffectHolder = eInitialHolder:EffectHolder()
    cInitialEffectHolder:AttachEffectByEffectID(effectID, effectEntity:GetID())
    effectHolder:AttachEffect("EffectHolderReplacedByAvatar", effectEntity)
  end
  return effectEntity
end

function EffectService:CreateBeHitEffect(hitEffectID, holderEntity, damageShowType, gridPos)
  if damageShowType and damageShowType == DamageShowType.Grid then
    local monsterConfigData = self._configService:GetMonsterConfigData()
    if holderEntity:MonsterID() and monsterConfigData:GetMonsterOffSetWithBindPos(holderEntity:MonsterID():GetMonsterID()) then
      self:CreateGridEffectWithBindPos(hitEffectID, gridPos, holderEntity)
    else
      return self:CreateEffect(hitEffectID, holderEntity)
    end
  else
    return self:CreateEffect(hitEffectID, holderEntity)
  end
end

function EffectService:CreateWorldPositionEffect(effectID, grid_pos, isShow)
  local effectConfigItem = Cfg.cfg_effect[effectID]
  if not effectConfigItem then
    return nil
  end
  local effectEntity = self:CreateEffectEntity()
  effectEntity:ReplaceAsset(NativeUnityPrefabAsset:New(effectConfigItem.ResPath, isShow))
  effectEntity:SetPosition(grid_pos)
  effectEntity:AddEffect(effectConfigItem.Duration)
  return effectEntity
end

function EffectService:CreateWorldPositionDirectionEffect(effectID, grid_pos, grid_dir)
  local entity = self:CreateWorldPositionEffect(effectID, grid_pos)
  if entity then
    entity:SetDirection(grid_dir)
  end
  return entity
end

function EffectService:CreateTransformEffect(effectID, grid_pos, grid_dir, localScale)
  local entity = self:CreateWorldPositionEffect(effectID, grid_pos)
  if entity then
    entity:SetDirection(grid_dir)
  end
end

function EffectService:CreateGridEffectWithEffectHolder(effectID, girdPos, monsterEntity)
  local effectConfigItem = Cfg.cfg_effect[effectID]
  if not effectConfigItem then
    Log.fatal("EffectService CreateGridEffectWithBindPos failed EffectID:", effectID, " ", Log.traceback())
    return nil
  end
  if effectConfigItem.ResPath == nil then
    Log.fatal("cannot find effect res ,effectID is", effectID)
  end
  local effectEntity = self:CreateEffectEntity()
  effectEntity:ReplaceAsset(NativeUnityPrefabAsset:New(effectConfigItem.ResPath))
  effectEntity:SetPosition(girdPos)
  local effectHolder = monsterEntity:EffectHolder()
  if not effectHolder then
    monsterEntity:AddEffectHolder()
    effectHolder = monsterEntity:EffectHolder()
  end
  effectHolder:AttachEffectByEffectID(effectID, effectEntity:GetID())
  return effectEntity
end

function EffectService:CreateGridEffectWithBindPos(effectID, girdPos, monsterEntity)
  if monsterEntity:HasMonsterID() and monsterEntity:BodyArea() then
    local monsterID = monsterEntity:MonsterID():GetMonsterID()
    local monsterGridPos = monsterEntity:GridLocation().Position
    local monsterConfigData = self._configService:GetMonsterConfigData()
    local ret = monsterConfigData:GetMonsterBindPos(monsterID, monsterGridPos, girdPos, monsterEntity:BodyArea():GetArea())
    if not ret then
      Log.fatal("### get monster bindpos failed. monsterID=", monsterID, ", effectID=", effectID)
      return
    end
    local effectConfigItem = Cfg.cfg_effect[effectID]
    if not effectConfigItem then
      Log.fatal("EffectService CreateGridEffectWithBindPos failed EffectID:", effectID, " ", Log.traceback())
      return nil
    end
    if effectConfigItem.ResPath == nil then
      Log.fatal("cannot find effect res ,effectID is", effectID)
    end
    local effectEntity = self:CreateEffectEntity()
    effectEntity:ReplaceAsset(NativeUnityPrefabAsset:New(effectConfigItem.ResPath))
    if ret.bindPos then
      effectEntity:AddEffectController(monsterEntity, ret.BindPos, effectConfigItem.Duration, effectConfigItem.Type)
    else
      effectEntity:AddEffectController(monsterEntity, effectConfigItem.BindPos, effectConfigItem.Duration, effectConfigItem.Type)
    end
    if ret.useEffectConfig then
      local effectControllerComponent = effectEntity:EffectController()
      local boardServiceRender = self._world:GetService("BoardRender")
      local gridRenderPos = boardServiceRender:GridPos2RenderPos(girdPos)
      effectControllerComponent:SetGirdRenderPos(gridRenderPos)
    end
    local effCtrl = effectEntity:EffectController()
    if effectConfigItem.FollowMove ~= nil then
      effCtrl:SetFollowMove(effectConfigItem.FollowMove)
    end
    if effectConfigItem.FollowRotate ~= nil then
      effCtrl:SetFollowRotate(effectConfigItem.FollowRotate)
    end
    if effectConfigItem.BindLayer then
      effCtrl:SetBindLayer(effectConfigItem.BindLayer)
    end
    if effectConfigItem.FollowRotateCaster then
      effCtrl:SetFollowRotateCaster(effectConfigItem.FollowRotateCaster)
    end
    local effectHolder = monsterEntity:EffectHolder()
    if not effectHolder then
      monsterEntity:AddEffectHolder()
      effectHolder = monsterEntity:EffectHolder()
    end
    effectHolder:AttachEffectByEffectID(effectID, effectEntity:GetID())
  end
end

function EffectService:CreateCommonGridEffect(effectID, gridPos, gridDir)
  local boardServiceRender = self._world:GetService("BoardRender")
  local renderPos = boardServiceRender:GridPos2RenderPos(gridPos)
  renderPos = Vector3(renderPos.x, renderPos.y, renderPos.z)
  local effectConfigItem = Cfg.cfg_effect[effectID]
  if not effectConfigItem then
    return nil
  end
  local effectEntity = self:CreateEffectEntity()
  effectEntity:ReplaceAsset(NativeUnityPrefabAsset:New(effectConfigItem.ResPath))
  effectEntity:SetLocation(renderPos, gridDir)
  effectEntity:AddEffect(effectConfigItem.Duration)
  return effectEntity
end

function EffectService:CreatePositionEffect(effectID, renderPos)
  local effectConfigItem = Cfg.cfg_effect[effectID]
  if not effectConfigItem then
    return nil
  end
  local effectEntity = self:CreateEffectEntity()
  effectEntity:ReplaceAsset(NativeUnityPrefabAsset:New(effectConfigItem.ResPath))
  effectEntity:SetPosition(renderPos)
  effectEntity:AddEffect(effectConfigItem.Duration)
  return effectEntity
end

function EffectService:CreateUIEffect(casterEntity, effectID, girdPos)
  local effectConfigItem = Cfg.cfg_effect[effectID]
  if not effectConfigItem then
    return nil
  end
  local effectEntity = self:CreateEffectEntity()
  effectEntity:ReplaceAsset(NativeUnityPrefabAsset:New(effectConfigItem.ResPath))
  effectEntity:AddEffect(effectConfigItem.Duration)
  effectEntity:EffectController():SetTargetGridPos(girdPos)
  effectEntity:EffectController():SetEffectType(tonumber(effectConfigItem.Type))
  local effectHolder = casterEntity:EffectHolder()
  if not effectHolder then
    casterEntity:AddEffectHolder()
    effectHolder = casterEntity:EffectHolder()
  end
  effectHolder:AttachEffectByEffectID(effectID, effectEntity:GetID())
  return effectEntity
end

function EffectService:ShowEffect(idleEffectArray, isShow)
  if not idleEffectArray then
    return
  end
  for _, effectID in ipairs(idleEffectArray) do
    local effectEntity = self._world:GetEntityByID(effectID)
    if effectEntity then
      local effectViewCmpt = effectEntity:View()
      if effectViewCmpt then
        effectEntity:SetViewVisible(isShow)
      end
    else
      Log.fatal("Show Effect Error,can not find effect entity!")
    end
  end
end

function EffectService:ShowIdleEffect(targetEntity, isShow)
  local cEffectHolder = targetEntity:EffectHolder()
  if cEffectHolder then
    self:ShowEffect(cEffectHolder:GetIdleEffect(), isShow)
  end
end

function EffectService:ShowPermanentEffect(targetEntity, isShow)
  local cEffectHolder = targetEntity:EffectHolder()
  if cEffectHolder then
    self:ShowEffect(cEffectHolder:GetPermanentEffect(), isShow)
  end
end

function EffectService:ShowChainMoveEffect(petEntity, show)
  local petData = petEntity:MatchPet():GetMatchPet()
  local chainMoveEffect = petData:GetChainMoveEffect()
  if not chainMoveEffect or table.count(chainMoveEffect) == 0 then
    return
  end
  local cEffectHolder = petEntity:EffectHolder()
  if not cEffectHolder then
    petEntity:AddEffectHolder()
    cEffectHolder = petEntity:EffectHolder()
  end
  local effectList = cEffectHolder:GetEffectList("ChainMove")
  if not effectList then
    local effEntity = self:CreateEffect(chainMoveEffect.EffectID, petEntity)
    if effEntity then
      local effEntityId = effEntity:GetID()
      cEffectHolder:AttachEffect("ChainMove", effEntityId)
      effectList = cEffectHolder:GetEffectList("ChainMove")
    end
  end
  local delay = 0
  if show then
    delay = chainMoveEffect.ShowDelay or 0
  else
    delay = chainMoveEffect.HideDelay or 0
  end
  if delay == 0 then
    self:ShowEffect(effectList, show)
  else
    GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      YIELD(TT, delay)
      self:ShowEffect(effectList, show)
    end)
  end
end

function EffectService:DestroyWeakEffect(targetEntity)
  local effectHolderCmpt = targetEntity:EffectHolder()
  if effectHolderCmpt == nil then
    return
  end
  local weakEffectArray = effectHolderCmpt:GetWeakEffect()
  for _, effectID in ipairs(weakEffectArray) do
    local effectEntity = self._world:GetEntityByID(effectID)
    if effectEntity ~= nil then
      self._world:DestroyEntity(effectEntity)
    end
  end
end

function EffectService:DestroyEffectIDEntityDicEffect(targetEntity)
  if not targetEntity then
    return
  end
  local effectHolderCmpt = targetEntity:EffectHolder()
  if effectHolderCmpt == nil then
    return
  end
  local effDict = effectHolderCmpt:GetEffectIDEntityDic()
  for k, v in pairs(effDict) do
    self:_DestroyEffectArray(v)
  end
  effectHolderCmpt:ClearEffectIDEntityDic()
end

function EffectService:ClearEntityEffect(targetEntity)
  if not targetEntity then
    Log.error(self._className, " ClearEntityEffect: requires entity param. ")
    return
  end
  local cFxHolder = targetEntity:EffectHolder()
  if cFxHolder == nil then
    Log.warn(self._className, " ClearEntityEffect: no EffectHolderComponent on provided entity. ")
    return
  end
  local tIdleFx = cFxHolder:GetIdleEffect()
  self:_DestroyEffectArray(tIdleFx)
  cFxHolder:ClearIdleEffectList()
  local tWeakFx = cFxHolder:GetWeakEffect()
  self:_DestroyEffectArray(tWeakFx)
  cFxHolder:ClearWeakEffectList()
  local tFxDict = cFxHolder:GetEffectIDEntityDic()
  for k, v in pairs(tFxDict) do
    self:_DestroyEffectArray(v)
  end
  cFxHolder:ClearEffectIDEntityDic()
  local dicFx = cFxHolder:GetDictEffectId()
  for _, t in pairs(dicFx) do
    self:_DestroyEffectArray(t)
  end
  cFxHolder:ClearDictEffectID()
  local tBindFx = cFxHolder:GetBindEffectIDArray()
  self:_DestroyEffectArray(tBindFx)
  cFxHolder:ClearBindEffectID()
  if targetEntity:EffectLineRenderer() then
    Log.info("MonsterDeadRemoveEffectLineRenderer")
    targetEntity:RemoveEffectLineRenderer()
  end
end

function EffectService:DestroyEntityEffectByID(targetEntity, nEffectID)
  if not nEffectID or not targetEntity then
    return
  end
  local effectHolderCmpt = targetEntity:EffectHolder()
  if effectHolderCmpt == nil then
    return
  end
  local effDict = effectHolderCmpt:GetEffectIDEntityDic()
  if nil == effDict then
    return
  end
  local listWorkID = {}
  if type(nEffectID) == "table" then
    listWorkID = nEffectID
  else
    listWorkID[1] = nEffectID
  end
  for _, nID in pairs(nEffectID) do
    local entityList = effDict[nID]
    if entityList then
      self:_DestroyEffectArray(entityList)
    end
  end
end

function EffectService:DestroyEffectByID(nEffectID)
  local listWorkID = {}
  if type(nEffectID) == "table" then
    listWorkID = nEffectID
  else
    listWorkID[1] = nEffectID
  end
  return self:_DestroyEffectArray(listWorkID)
end

function EffectService:GetPetShowEffIdByEntity(elementType)
  return GameResourceConst.PetAppearEff[elementType]
end

function EffectService:GetMonsterShowEffIdByEntity(e, elementType, isBoss)
  if isBoss then
    return
  end
  local count = e:BodyArea():GetAreaCount()
  if 4 < count then
    return
  end
  if 4 <= count then
    return GameResourceConst.MonsterAppearEffMultiBodyArea[elementType]
  end
  return GameResourceConst.MonsterAppearEffSingleBodyArea[elementType]
end

function EffectService:CreateScreenEffPointEffectWithHolder(effectID, holderEntity)
  local effectConfigItem = Cfg.cfg_effect[effectID]
  if not effectConfigItem then
    return nil
  end
  local cEffectHolder = holderEntity:EffectHolder()
  if not cEffectHolder then
    holderEntity:AddEffectHolder()
    cEffectHolder = holderEntity:EffectHolder()
  end
  local effectEntity = self:CreateEffectEntity()
  effectEntity:ReplaceAsset(NativeUnityPrefabAsset:New(effectConfigItem.ResPath))
  effectEntity:AddEffectType(effectConfigItem.Type, effectConfigItem.Duration)
  cEffectHolder:AttachEffectByEffectID(effectID, effectEntity:GetID())
  return effectEntity
end

function EffectService:CreateScreenEffPointEffect(effectID)
  local effectConfigItem = Cfg.cfg_effect[effectID]
  if not effectConfigItem then
    return nil
  end
  local effectEntity = self:CreateEffectEntity()
  effectEntity:ReplaceAsset(NativeUnityPrefabAsset:New(effectConfigItem.ResPath))
  effectEntity:AddEffectType(effectConfigItem.Type, effectConfigItem.Duration)
  return effectEntity
end

function EffectService:GetEffectResPath(effectID)
  local cfgItem = Cfg.cfg_effect[effectID]
  if not cfgItem then
    return nil
  end
  return cfgItem.ResPath
end

function EffectService:CreateMonsterMoveLineEffects(TT, effectID, holderEntity, startEntities, startBone, endEntities, endBone)
  local effectLineRenderCmpt = holderEntity:EffectLineRenderer()
  if not effectLineRenderCmpt then
    holderEntity:AddEffectLineRenderer()
    effectLineRenderCmpt = holderEntity:EffectLineRenderer()
  end
  effectLineRenderCmpt:SetIgnoreEntityViewRootPos(true)
  local effectHolderCmpt = holderEntity:EffectHolder()
  if not effectHolderCmpt then
    holderEntity:AddEffectHolder()
    effectHolderCmpt = holderEntity:EffectHolder()
  end
  for i, entityID in ipairs(startEntities) do
    local entity = self._world:GetEntityByID(entityID)
    local targetEntityID = endEntities[i]
    local targetEntity = self._world:GetEntityByID(targetEntityID)
    local entityViewRoot = entity:View().ViewWrapper.GameObject.transform
    local targetEntityViewRoot = targetEntity:View().ViewWrapper.GameObject.transform
    local curRoot = GameObjectHelper.FindChild(entityViewRoot, startBone)
    local endRoot = GameObjectHelper.FindChild(targetEntityViewRoot, endBone)
    if curRoot then
      local effect = self:CreateEffect(effectID, holderEntity)
      effectHolderCmpt:AttachPermanentEffect(effect:GetID())
      local effView = effect:View()
      if effView then
        local go = effect:View():GetGameObject()
        local renderers
        renderers = go:GetComponentsInChildren(typeof(UnityEngine.LineRenderer), true)
        for i = 0, renderers.Length - 1 do
          local line = renderers[i]
          if line then
            line.gameObject:SetActive(true)
          end
        end
        effectLineRenderCmpt:InitEffectLineRenderer(entityID, curRoot, endRoot, entityViewRoot, renderers, effect:GetID())
        effectLineRenderCmpt:SetEffectLineRendererShow(entityID, true)
      end
    end
  end
end

function EffectService:CreateLineEffects(TT, effectID, holderEntity, holderBone, startEntitys, startBone, holderPosOff, startPosOff)
  local targetRoot = GameObjectHelper.FindChild(holderEntity:View().ViewWrapper.GameObject.transform, holderBone)
  if not targetRoot then
    return
  end
  for i, entity in ipairs(startEntitys) do
    local effectLineRenderer = entity:EffectLineRenderer()
    if entity:IsViewVisible() then
      local entityViewRoot = entity:View().ViewWrapper.GameObject.transform
      local curRoot = GameObjectHelper.FindChild(entityViewRoot, startBone)
      if curRoot then
        if not effectLineRenderer then
          entity:AddEffectLineRenderer()
          effectLineRenderer = entity:EffectLineRenderer()
        end
        local effectHolderCmpt = entity:EffectHolder()
        if not effectHolderCmpt then
          entity:AddEffectHolder()
          effectHolderCmpt = entity:EffectHolder()
        end
        local effectEntityIdList = effectHolderCmpt:GetEffectIDEntityDic()[effectID]
        local effect
        if effectEntityIdList then
          effect = self._world:GetEntityByID(effectEntityIdList[1])
        end
        if not effect then
          effect = self:CreateEffect(effectID, entity)
          effectHolderCmpt:AttachPermanentEffect(effect:GetID())
        end
        local effView = effect:View()
        if effView then
          local go = effect:View():GetGameObject()
          local renderers
          renderers = go:GetComponentsInChildren(typeof(UnityEngine.LineRenderer), true)
          for i = 0, renderers.Length - 1 do
            local line = renderers[i]
            if line then
              line.gameObject:SetActive(true)
            end
          end
          effectLineRenderer:InitEffectLineRenderer(holderEntity:GetID(), curRoot, targetRoot, entityViewRoot, renderers, effect:GetID())
          effectLineRenderer:SetEffectLineRendererShow(holderEntity:GetID(), true)
          if startPosOff then
            effectLineRenderer:SetCurrentRootOff(startPosOff)
          end
          if holderPosOff then
            effectLineRenderer:SetTargetRootOff(holderPosOff)
          end
        end
      end
    end
  end
end
