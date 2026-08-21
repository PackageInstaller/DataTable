_class("BuffViewPlayEffectWithChainMove", BuffViewBase)
BuffViewPlayEffectWithChainMove = BuffViewPlayEffectWithChainMove

function BuffViewPlayEffectWithChainMove:PlayView(TT, notify)
  local buffResult = self._buffResult
  local notifyType = buffResult:GetNotifyType()
  local notifyPos = buffResult:GetNotifyPos()
  local isStart = buffResult:GetIsStart()
  local isEnd = buffResult:GetIsEnd()
  local permanentEffectID = buffResult:GetPermanentEffectID()
  local moveEffectID = buffResult:GetMoveEffectID()
  local useType = buffResult:GetUseType()
  local effectService = self._world:GetService("Effect")
  local e = self._entity
  local effectHolderCmpt = e:EffectHolder()
  if not effectHolderCmpt then
    e:AddEffectHolder()
  end
  effectHolderCmpt = e:EffectHolder()
  if notifyType == NotifyType.PlayerEachMoveStart then
    self:_HandleEachMoveStartByType(e, buffResult, effectHolderCmpt, effectService)
  elseif notifyType == NotifyType.PlayerEachMoveEnd then
    if moveEffectID then
      effectService:CreateWorldPositionEffect(moveEffectID, notifyPos)
    end
    if isEnd then
      self:_HandleChainMoveEndByType(e, buffResult, effectHolderCmpt, effectService)
    end
  elseif notifyType == NotifyType.PetChainMoveBegin then
    if isStart then
      self:_HandleChainMoveBeginByType(e, buffResult, effectHolderCmpt, effectService)
    end
  elseif notifyType == NotifyType.PlayerMoveStart then
    self:_HandlePlayerMoveStartByType(TT, e, buffResult, effectHolderCmpt, effectService)
  end
end

function BuffViewPlayEffectWithChainMove:IsNotifyMatch(notify)
  local buffResult = self._buffResult
  local notifyType = buffResult:GetNotifyType()
  local notifyPos = buffResult:GetNotifyPos()
  if not notify then
    return false
  end
  if notifyType == NotifyType.PlayerMoveStart then
    local useType = buffResult:GetUseType()
    if useType == PlayEffectWithChainMoveType.Zhongxu then
      return true
    end
  end
  if notifyType ~= NotifyType.PlayerEachMoveStart and notifyType ~= NotifyType.PlayerEachMoveEnd and notifyType ~= NotifyType.PetChainMoveBegin then
    return false
  end
  if notifyType == NotifyType.PetChainMoveBegin then
    local useType = buffResult:GetUseType()
    if useType == PlayEffectWithChainMoveType.Zhongxu then
    elseif notify:GetEntityID() ~= self._entity:GetID() then
      return false
    end
  elseif notify:GetEntityID() ~= self._entity:GetID() then
    return false
  end
  if notify:GetNotifyType() ~= notifyType then
    return false
  end
  if notify:GetPos() ~= notifyPos then
    return false
  end
  return true
end

function BuffViewPlayEffectWithChainMove:_HandleEachMoveStartByType(e, buffResult, effectHolderCmpt, effectService)
  local useType = buffResult:GetUseType()
  local typeParam = buffResult:GetTypeParam()
  useType = useType or PlayEffectWithChainMoveType.Normal
  if useType == PlayEffectWithChainMoveType.Normal then
  elseif useType == PlayEffectWithChainMoveType.Zhongxu then
    local bvcmpt = self._entity:BuffView()
    local played = bvcmpt:GetBuffValue("ZhongxuTrasnToCatPlayed")
    if played and played == 1 then
    else
      Log.error("PlayEffectWithChainMove,EachMoveStart,trans to cat not played")
      local permanentEffectID = buffResult:GetPermanentEffectID()
      if permanentEffectID then
        local effect = effectService:CreateEffect(permanentEffectID, e)
        self:_ZhongxuCatEffectAddMaterialAnimation(effect)
        effectHolderCmpt:AttachPermanentEffect(effect:GetID())
        effectHolderCmpt:AttachChainMovePermanentEffect(effect:GetID())
        self:_ZhongxuShowHideModel(false)
        bvcmpt:SetBuffValue("ZhongxuTrasnToCatPlayed", 1)
        bvcmpt:SetBuffValue("ZhongxuCatEffectEntityID", effect:GetID())
      end
    end
  end
end

function BuffViewPlayEffectWithChainMove:_HandleChainMoveBeginByType(e, buffResult, effectHolderCmpt, effectService)
  local useType = buffResult:GetUseType()
  local typeParam = buffResult:GetTypeParam()
  useType = useType or PlayEffectWithChainMoveType.Normal
  local notifyPos = buffResult:GetNotifyPos()
  local permanentEffectID = buffResult:GetPermanentEffectID()
  local moveEffectID = buffResult:GetMoveEffectID()
  if useType == PlayEffectWithChainMoveType.Normal then
    if moveEffectID then
      effectService:CreateWorldPositionEffect(moveEffectID, notifyPos)
    end
    if permanentEffectID then
      local effect = effectService:CreateEffect(permanentEffectID, e)
      effectHolderCmpt:AttachPermanentEffect(effect:GetID())
      effectHolderCmpt:AttachChainMovePermanentEffect(effect:GetID())
    end
  elseif useType == PlayEffectWithChainMoveType.Zhongxu then
    if moveEffectID then
      effectService:CreateWorldPositionEffect(moveEffectID, notifyPos)
    end
    local bvcmpt = self._entity:BuffView()
    bvcmpt:SetBuffValue("ZhongxuCatTrasnToPetPlayed", 0)
    local transTaskID = bvcmpt:GetBuffValue("ZhongxuTrasnToCatTaskID")
    if transTaskID and 0 < transTaskID then
      return
    end
    if typeParam and typeParam.isTeamLeader then
    elseif permanentEffectID then
      local effect = effectService:CreateEffect(permanentEffectID, e)
      self:_ZhongxuCatEffectAddMaterialAnimation(effect)
      effectHolderCmpt:AttachPermanentEffect(effect:GetID())
      effectHolderCmpt:AttachChainMovePermanentEffect(effect:GetID())
      self:_ZhongxuShowHideModel(false)
      bvcmpt:SetBuffValue("ZhongxuTrasnToCatPlayed", 1)
      bvcmpt:SetBuffValue("ZhongxuCatEffectEntityID", effect:GetID())
    end
  end
end

function BuffViewPlayEffectWithChainMove:_HandleChainMoveEndByType(e, buffResult, effectHolderCmpt, effectService)
  local useType = buffResult:GetUseType()
  local typeParam = buffResult:GetTypeParam()
  useType = useType or PlayEffectWithChainMoveType.Normal
  if useType == PlayEffectWithChainMoveType.Normal then
    local permanentEffectList = effectHolderCmpt:GetChainMovePermanentEffect()
    effectService:_DestroyEffectArray(permanentEffectList)
    effectHolderCmpt:ClearChainMovePermanentEffectIDListAfterDestroy()
  elseif useType == PlayEffectWithChainMoveType.Zhongxu then
    local bvcmpt = self._entity:BuffView()
    local played = bvcmpt:GetBuffValue("ZhongxuCatTrasnToPetPlayed")
    if played and played == 1 then
      if typeParam and typeParam.isTeamLeader then
      else
        local permanentEffectList = effectHolderCmpt:GetChainMovePermanentEffect()
        effectService:_DestroyEffectArray(permanentEffectList)
        effectHolderCmpt:ClearChainMovePermanentEffectIDListAfterDestroy()
        self:_ZhongxuShowHideModel(true)
        bvcmpt:SetBuffValue("ZhongxuCatTrasnToPetPlayed", 1)
        bvcmpt:SetBuffValue("ZhongxuTrasnToCatPlayed", 0)
      end
      return
    end
    if typeParam and typeParam.isTeamLeader then
      bvcmpt:SetBuffValue("ZhongxuCatTrasnToPetPlayed", 1)
      bvcmpt:SetBuffValue("ZhongxuTrasnToCatPlayed", 0)
      local transRevertTaskID = GameGlobal.TaskManager():CoreGameStartTask(self._ZhongxuCatTransToPet, self, e, effectHolderCmpt, effectService)
      local bvcmpt = self._entity:BuffView()
      bvcmpt:SetBuffValue("ZhongxuTrasnRevertTaskID", transRevertTaskID)
    else
      local permanentEffectList = effectHolderCmpt:GetChainMovePermanentEffect()
      effectService:_DestroyEffectArray(permanentEffectList)
      effectHolderCmpt:ClearChainMovePermanentEffectIDListAfterDestroy()
      self:_ZhongxuShowHideModel(true)
      bvcmpt:SetBuffValue("ZhongxuCatTrasnToPetPlayed", 1)
      bvcmpt:SetBuffValue("ZhongxuTrasnToCatPlayed", 0)
    end
  end
end

function BuffViewPlayEffectWithChainMove:_ZhongxuPetTransToCat(TT, e, effectHolderCmpt, effectService, permanentEffectID)
  Log.debug("PlayEffectWithChainMove,play ZhongxuCatTransToPet task")
  local buffResult = self._buffResult
  local typeParam = buffResult:GetTypeParam()
  local specialParam = typeParam.specialParam
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local chain_path = renderBoardEntity:RenderChainPath():GetRenderChainPath()
  if not chain_path or 1 < #chain_path then
  end
  local audioID = specialParam._transAudioID or 2585
  AudioHelperController.PlayInnerGameSfx(audioID)
  local actEffID = specialParam._transEffectID or 160181102
  local matAnim = specialParam._transMatAnim or "effanim_1601811_atk_revolve1"
  local animName = specialParam._transAnim or "AttackMove1"
  e:SetAnimatorControllerTriggers({animName})
  effectService:CreateEffect(actEffID, e)
  e:PlayMaterialAnim(matAnim)
  YIELD(TT, 400)
  local catEffEntity
  if permanentEffectID then
    local effect = effectService:CreateEffect(permanentEffectID, e)
    self:_ZhongxuCatEffectAddMaterialAnimation(effect)
    effectHolderCmpt:AttachPermanentEffect(effect:GetID())
    effectHolderCmpt:AttachChainMovePermanentEffect(effect:GetID())
    catEffEntity = effect
    local bvcmpt = self._entity:BuffView()
    bvcmpt:SetBuffValue("ZhongxuCatEffectEntityID", effect:GetID())
  end
  local catEffID = specialParam._catShowEffectID or 160181106
  effectService:CreateEffect(catEffID, e)
  local catMatAnim = specialParam._catShowMatAnim or "effanim_1601811_atk_weapon02_in"
  if catEffEntity then
    catEffEntity:PlayMaterialAnim(catMatAnim)
  end
  self:_ZhongxuShowHideModel(false)
  local bvcmpt = self._entity:BuffView()
  bvcmpt:SetBuffValue("ZhongxuTrasnToCatTaskID", 0)
end

function BuffViewPlayEffectWithChainMove:_ZhongxuCatEffectAddMaterialAnimation(effect)
  if not effect then
    return
  end
  local effView = effect:View()
  if not effView then
    return
  end
  local viewWrapper = effView.ViewWrapper
  if not viewWrapper then
    return
  end
  local matAnimMonoCmpt = viewWrapper.GameObject:GetComponent(typeof(MaterialAnimation))
  if matAnimMonoCmpt then
    UnityEngine.Object.Destroy(matAnimMonoCmpt)
  end
  matAnimMonoCmpt = viewWrapper.GameObject:AddComponent(typeof(MaterialAnimation))
  local resServ = self._world.BW_Services.ResourcesPool
  local container = resServ:LoadAsset("globalShaderEffects.asset")
  effect:AddMaterialAnimationComponent(container, matAnimMonoCmpt)
  local shaderEffect = "1601811_shader_effects.asset"
  if shaderEffect then
    local containerShaderEffect = resServ:LoadAsset(shaderEffect)
    if containerShaderEffect then
      effect:MaterialAnimationComponent():LoadContainer(containerShaderEffect)
    end
  end
end

function BuffViewPlayEffectWithChainMove:_ZhongxuCatTransToPet(TT, e, effectHolderCmpt, effectService)
  Log.debug("PlayEffectWithChainMove,play ZhongxuCatTransToPet task , enter")
  local bvcmpt = self._entity:BuffView()
  local transToCatTaskID = bvcmpt:GetBuffValue("ZhongxuTrasnToCatTaskID")
  if transToCatTaskID and 0 < transToCatTaskID then
    local taskIDs = {transToCatTaskID}
    while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDs) do
      YIELD(TT)
    end
  end
  Log.debug("PlayEffectWithChainMove,play ZhongxuCatTransToPet task")
  local buffResult = self._buffResult
  local typeParam = buffResult:GetTypeParam()
  local specialParam = typeParam.specialParam
  local audioID = specialParam._transAudioID or 2585
  AudioHelperController.PlayInnerGameSfx(audioID)
  local catEffID = specialParam._catHideEffectID or 160181108
  local catMatAnim = specialParam._catHideMatAnim or "effanim_1601811_atk_weapon02_out"
  local catEffEntity
  local catEffectID = bvcmpt:GetBuffValue("ZhongxuCatEffectEntityID")
  if catEffectID and 0 < catEffectID then
    catEffEntity = self._world:GetEntityByID(catEffectID)
  end
  effectService:CreateEffect(catEffID, e)
  if catEffEntity then
    catEffEntity:PlayMaterialAnim(catMatAnim)
  end
  local actEffID = specialParam._revertEffectID or 160181104
  effectService:CreateEffect(actEffID, e)
  YIELD(TT, 500)
  local matAnim = specialParam._revertMatAnim or "effanim_1601811_atk_revolve2"
  local animName = specialParam._revertAnim or "AttackMove2"
  self:_ZhongxuShowHideModel(true)
  e:SetAnimatorControllerTriggers({animName})
  e:PlayMaterialAnim(matAnim)
  YIELD(TT, 500)
  local permanentEffectList = effectHolderCmpt:GetChainMovePermanentEffect()
  effectService:_DestroyEffectArray(permanentEffectList)
  effectHolderCmpt:ClearChainMovePermanentEffectIDListAfterDestroy()
  YIELD(TT, 400)
  bvcmpt:SetBuffValue("ZhongxuTrasnRevertTaskID", 0)
end

function BuffViewPlayEffectWithChainMove:_ZhongxuShowHideModel(bShow)
  Log.debug("PlayEffectWithChainMove,ZhongxuShowHideModel,", bShow)
  local cView = self._entity:View()
  local CSGameObject = cView:GetGameObject()
  local CSGameObjectRoot = CSGameObject.transform:Find("Root")
  local tSkinnedMeshRender = CSGameObjectRoot.transform:GetComponentsInChildren(typeof(UnityEngine.SkinnedMeshRenderer))
  for i = 0, tSkinnedMeshRender.Length - 1 do
    tSkinnedMeshRender[i].enabled = bShow
  end
end

function BuffViewPlayEffectWithChainMove:_HandlePlayerMoveStartByType(TT, e, buffResult, effectHolderCmpt, effectService)
  local useType = buffResult:GetUseType()
  local typeParam = buffResult:GetTypeParam()
  useType = useType or PlayEffectWithChainMoveType.Normal
  local notifyPos = buffResult:GetNotifyPos()
  local permanentEffectID = buffResult:GetPermanentEffectID()
  local moveEffectID = buffResult:GetMoveEffectID()
  if useType == PlayEffectWithChainMoveType.Normal then
  elseif useType == PlayEffectWithChainMoveType.Zhongxu then
    if moveEffectID then
      effectService:CreateWorldPositionEffect(moveEffectID, notifyPos)
    end
    local bvcmpt = self._entity:BuffView()
    bvcmpt:SetBuffValue("ZhongxuCatTrasnToPetPlayed", 0)
    local transTaskID = bvcmpt:GetBuffValue("ZhongxuTrasnToCatTaskID")
    if transTaskID and 0 < transTaskID then
      return
    end
    local eTeam = self._entity:Pet():GetOwnerTeamEntity()
    local curIsTeamLeader = self._entity:GetID() == eTeam:Team():GetTeamLeaderEntityID()
    if typeParam and typeParam.isTeamLeader and curIsTeamLeader then
      local transToCatTaskID = 0
      self:_ZhongxuPetTransToCat(TT, e, effectHolderCmpt, effectService, permanentEffectID)
      local bvcmpt = self._entity:BuffView()
      bvcmpt:SetBuffValue("ZhongxuTrasnToCatTaskID", transToCatTaskID)
      bvcmpt:SetBuffValue("ZhongxuTrasnToCatPlayed", 1)
    else
    end
  end
end
