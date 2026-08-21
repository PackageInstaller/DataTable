require("base_service")
require("battle_ui_active_skill_cannot_cast_reason")
ActiveSkillCannotCastReasonText = {
  [BattleUIActiveSkillCannotCastReason.NotReady] = "str_match_cannot_cast_skill_reason",
  [BattleUIActiveSkillCannotCastReason.SanValue] = "str_battle_skill_not_useable_4",
  [BattleUIActiveSkillCannotCastReason.SanByScopeGridCounts] = "str_battle_skill_not_useable_5",
  [BattleUIActiveSkillCannotCastReason.DecreaseHPPercentAsSan] = "str_battle_skill_not_useable_6",
  [BattleUIActiveSkillCannotCastReason.HPValPercent] = "str_battle_skill_not_useable_7",
  [BattleUIActiveSkillCannotCastReason.SanNotFull] = "str_battle_skill_not_useable_8",
  [BattleUIActiveSkillCannotCastReason.CardNotFull] = "str_battle_skill_not_useable_9",
  [BattleUIActiveSkillCannotCastReason.CardNotEnough] = "str_battle_skill_not_useable_10",
  [BattleUIActiveSkillCannotCastReason.CardTarPetHasBuff] = "str_battle_skill_not_useable_11",
  [BattleUIActiveSkillCannotCastReason.NotUnlockByBuffLayer] = "str_battle_skill_not_useable_12",
  [BattleUIActiveSkillCannotCastReason.NotUnlockByAurora] = "str_battle_skill_not_useable_13",
  [BattleUIActiveSkillCannotCastReason.NotEnoughFeatureStepPoint] = "str_match_cannot_cast_skill_reason",
  [BattleUIActiveSkillCannotCastReason.NotEnoughRound] = "str_battle_skill_not_enough_round",
  [BattleUIActiveSkillCannotCastReason.SanMaxLimit] = "str_battle_skill_not_useable_14",
  [BattleUIActiveSkillCannotCastReason.SanMinLimit] = "str_battle_skill_not_useable_4"
}
_enum("ActiveSkillCannotCastReasonText", ActiveSkillCannotCastReasonText)
_class("RenderBattleService", BaseService)
RenderBattleService = RenderBattleService

function RenderBattleService:Constructor(world)
  self._comboNum = 0
  self._sendGameOver = false
  self._firstSkinedMeshRenders = {}
  self._childMeshRenderers = {}
end

function RenderBattleService:HideUIPetInfo(TT)
  self:DisableTeamOrderChangeView()
  YIELD(TT, BattleConst.RefreshPetInfoTick)
  local delay = 0
  while delay <= 10 do
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowPetInfo, -0.1)
    delay = delay + 1
    YIELD(TT)
  end
  Log.debug("[refresh] HidePetInfo end ")
end

function RenderBattleService:ShowUIPetInfo(TT)
  YIELD(TT, BattleConst.RefreshPetInfoTick)
  local delay = 0
  while delay <= 10 do
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowPetInfo, 0.1)
    delay = delay + 1
    YIELD(TT)
  end
  self:EnableTeamOrderChangeView()
end

function RenderBattleService:PlayAnimation(entity, animList)
  if entity and entity:View() then
    local gridGameObj = entity:View().ViewWrapper.GameObject
    local u3dAnimCmpt = gridGameObj:GetComponentInChildren(typeof(UnityEngine.Animation))
    if not u3dAnimCmpt then
      Log.fatal("Can not find animation component", "Trace:", Log.traceback())
      return
    end
    local clipCount = u3dAnimCmpt:GetClipCount()
    if clipCount <= 0 then
      return
    end
    if animList == nil then
      return
    end
    if #animList <= 0 then
      return
    end
    if 1 < #animList then
      for _, v in ipairs(animList) do
        u3dAnimCmpt:PlayQueued(v, UnityEngine.QueueMode.CompleteOthers)
      end
    else
      local curAnim = animList[1]
      u3dAnimCmpt:Play(curAnim)
    end
  end
end

function RenderBattleService:StopAnimation(entity)
  if entity and entity:View() then
    local gridGameObj = entity:View().ViewWrapper.GameObject
    local u3dAnimCmpt = gridGameObj:GetComponentInChildren(typeof(UnityEngine.Animation))
    if not u3dAnimCmpt then
      Log.fatal("Can not find animation component", "Trace:", Log.traceback())
      return
    end
    local clipCount = u3dAnimCmpt:GetClipCount()
    if clipCount <= 0 then
      return
    end
    u3dAnimCmpt:Stop()
  end
end

function RenderBattleService:ClearChainSkillPreviewRenderData()
  local reBoard = self._world:GetRenderBoardEntity()
  local previewChainSkillRangeCmpt = reBoard:PreviewChainSkillRange()
  local chainSkillRangeDic = previewChainSkillRangeCmpt:GetChainSkillRangeOutlineDic()
  local chainSkillOutLineEntityDic = chainSkillRangeDic:GetChainSkillOutlineEntityDic()
  if not chainSkillOutLineEntityDic then
    return
  end
  local entityPoolService = self._world:GetService("EntityPool")
  for _, lineEntityList in pairs(chainSkillOutLineEntityDic) do
    if lineEntityList then
      for _, entityId in pairs(lineEntityList) do
        local entity = self._world:GetEntityByID(entityId)
        entityPoolService:DestroyCacheEntity(entity, EntityConfigIDRender.SkillRangeOutline)
      end
    end
  end
  local previewChainSkillGroup = self._world:GetGroup(self._world.BW_WEMatchers.PreviewChainSkillRange)
  for _, entity in ipairs(previewChainSkillGroup:GetEntities()) do
    local previewChainSkillRangeCmpt = entity:PreviewChainSkillRange()
    local chainSkillRangeDic = previewChainSkillRangeCmpt:GetChainSkillRangeOutlineDic()
    chainSkillRangeDic:ClearChainSkillOutlineEntityDic()
  end
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local teamLeaderEntity = teamEntity:GetTeamLeaderPetEntity()
  teamLeaderEntity:StopCurePreAnim()
  local effectList = previewChainSkillRangeCmpt:GetSnipeEffectList()
  for k, effectEntity in pairs(effectList) do
    self._world:DestroyEntity(effectEntity)
  end
  previewChainSkillRangeCmpt:ClearPreviewChainSkill()
end

function RenderBattleService:SetComboNum(comboNum)
  self._comboNum = comboNum
end

function RenderBattleService:GetComboNum()
  return self._comboNum
end

function RenderBattleService:ChangeTeamLeaderRender(TT, teamEntity)
end

function RenderBattleService:GridPos2HudWorldPos(gridPos)
  local boardRenderSvc = self._world:GetService("BoardRender")
  local gridRenderPos = boardRenderSvc:GridPos2RenderPos(gridPos)
  return self:GridRenderPos2HudWorldPos(gridRenderPos)
end

function RenderBattleService:GridRenderPos2HudWorldPos(gridRenderPos)
  local camera = self._world:MainCamera():Camera()
  local screenPos = camera:WorldToScreenPoint(gridRenderPos)
  local hudCamera = self._world:MainCamera():HUDCamera()
  local hudWorldPos = hudCamera:ScreenToWorldPoint(screenPos)
  return hudWorldPos
end

function RenderBattleService:RenderChangeTeamLeader(newPetPstID, oldPetPstID)
  local petEntity = self._world:Player():GetPetEntityByPetPstID(newPetPstID)
  local teamLeaderEntity = self._world:Player():GetPetEntityByPetPstID(oldPetPstID)
  petEntity:SetViewVisible(true)
  teamLeaderEntity:SetViewVisible(false)
  local renderEntityService = self._world:GetService("RenderEntity")
  renderEntityService:SetTeamLeaderRender(petEntity, true)
end

function RenderBattleService:NotifyUIBattleGameOver(battleResult)
  if self._sendGameOver then
    return
  end
  self._sendGameOver = true
  self._world:EventDispatcher():Dispatch(GameEventType.OnGameOver, battleResult)
end

function RenderBattleService:PlaySnipeEffectAnimation(entity, element)
  if not self._snipeEffectList then
    self._snipeEffectList = {}
    self._snipeEffectList[PieceType.Blue] = "eff_ingame_locking_1"
    self._snipeEffectList[PieceType.Red] = "eff_ingame_locking_2"
    self._snipeEffectList[PieceType.Green] = "eff_ingame_locking_3"
    self._snipeEffectList[PieceType.Yellow] = "eff_ingame_locking_4"
  end
  self:PlayAnimation(entity, {
    self._snipeEffectList[element]
  })
end

function RenderBattleService:PlayAnimationByGameObject(go, animList)
  local u3dAnimCmpt = go:GetComponentInChildren(typeof(UnityEngine.Animation))
  if not u3dAnimCmpt then
    Log.fatal("Can not find animation component", "Trace:", Log.traceback())
    return
  end
  local clipCount = u3dAnimCmpt:GetClipCount()
  if clipCount <= 0 then
    return
  end
  if animList == nil then
    return
  end
  if #animList <= 0 then
    return
  end
  if 1 < #animList then
    for _, v in ipairs(animList) do
      u3dAnimCmpt:PlayQueued(v, UnityEngine.QueueMode.CompleteOthers)
    end
  else
    local curAnim = animList[1]
    u3dAnimCmpt:Play(curAnim)
  end
end

function RenderBattleService:DisableTeamOrderChangeView()
  self._world:RenderBattleStat():SetChangeTeamOrderViewDisabled(true)
end

function RenderBattleService:EnableTeamOrderChangeView()
  Log.info("[RenderBattleService] enabling change team order view")
  local renderStat = self._world:RenderBattleStat()
  renderStat:SetChangeTeamOrderViewDisabled(false)
  local viewQueue = renderStat:GetChangeTeamOrderViewQueue()
  if #viewQueue == 0 then
    Log.info("[RenderBattleService] change team order view queue is empty. ")
    return
  end
  local currentRequest = renderStat:GetCurrentTeamOrderRequest()
  if currentRequest then
    return
  end
  local firstRequest = viewQueue[1]
  if not firstRequest then
    return
  end
  local currentTeamOrder = BattleStatHelper.GetLogicCurrentLocalTeamOrder()
  local mergedReq = BattleTeamOrderViewRequest:New(firstRequest:GetOldTeamOrder(), currentTeamOrder, BattleTeamOrderViewType.ShuffleTeamOrder)
  for _, req in ipairs(viewQueue) do
    Log.info("[RenderBattleService] change team order view merged, dropping request seq ", req:GetRequestSequenceNo())
  end
  renderStat:ClearChangeTeamOrderViewQueue()
  renderStat:AddChangeTeamOrderViewRequest(mergedReq)
  self:TryPopNextChangeTeamOrderView()
end

function RenderBattleService:TryPopNextChangeTeamOrderView()
  local renderStat = self._world:RenderBattleStat()
  if renderStat:IsChangeTeamOrderViewDisabled() then
    Log.info("[InnerGameHelperRender] change team order view disabled, skip popping next request. ")
    return
  end
  if renderStat:GetCurrentTeamOrderRequest() then
    Log.info("[InnerGameHelperRender] there is already a presenting request. ")
    return
  end
  local current = renderStat:PopFirstTeamOrderRequestAsCurrent()
  if current then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.CallUIChangeTeamOrderView, current)
  end
end

function RenderBattleService:GetCurrentChangeTeamOrderViewRequest()
  local renderStat = self._world:RenderBattleStat()
  return renderStat:GetCurrentTeamOrderRequest()
end

function RenderBattleService:RequestUIChangeTeamOrderView(request)
  local renderStat = self._world:RenderBattleStat()
  renderStat:AddChangeTeamOrderViewRequest(request)
  if renderStat:GetCurrentTeamOrderRequest() then
    return
  end
  self:TryPopNextChangeTeamOrderView()
end

function RenderBattleService:CalcHPBarPos(viewWrapper, hp_offset)
  local hpPosTransform = viewWrapper:FindChild("HPPos")
  if hpPosTransform then
    local hpPosObj = hpPosTransform.gameObject
    local owner_entity_render_pos = hpPosObj.transform.position
    local hpPosition = owner_entity_render_pos + hp_offset
    owner_entity_render_pos = self:CalcGridHUDWorldPos(hpPosition)
    return owner_entity_render_pos
  else
    return self:CalcSkinnedMeshPos(viewWrapper, hp_offset)
  end
end

function RenderBattleService:CalcSkinnedMeshPos(viewWrapper, hp_offset)
  local ownerObj = viewWrapper.GameObject
  local rootObj
  local rootTransform = viewWrapper:FindChild("Root")
  if rootTransform then
    rootObj = rootTransform.gameObject
  else
    rootObj = viewWrapper.GameObject
  end
  local owner_entity_render_pos = rootObj.transform.position
  local skinnedMeshRender, meshExtents = self:FindFirstSkinedMeshRender(rootObj)
  if skinnedMeshRender ~= nil then
    local skinnedMeshPosition = skinnedMeshRender.transform.position + hp_offset
    local convertExtents = Vector3(0, meshExtents.x * 2, 0)
    local targetPos = skinnedMeshPosition + convertExtents
    owner_entity_render_pos = self:CalcGridHUDWorldPos(targetPos)
  else
    local meshRenderer = self:GetMeshRendererInChildren(ownerObj)
    if meshRenderer then
      local meshPosition = owner_entity_render_pos + hp_offset
      owner_entity_render_pos = self:CalcGridHUDWorldPos(meshPosition)
    else
      Log.fatal("ownerObj", ownerObj.name, "has no skinned mesh and mesh")
    end
  end
  return owner_entity_render_pos
end

function RenderBattleService:FindFirstSkinedMeshRender(go)
  if not self._firstSkinedMeshRenders[go] then
    local skinnedMeshRender = GameObjectHelper.FindFirstSkinedMeshRender(go)
    local meshExtents = GameObjectHelper.FindFirstSkinedMeshRenderBoundsExtent(go)
    self._firstSkinedMeshRenders[go] = {skinnedMeshRender, meshExtents}
  end
  local v = self._firstSkinedMeshRenders[go]
  return v[1], v[2]
end

function RenderBattleService:CalcGridHUDWorldPos(gridRenderPos)
  local camera = self._world:MainCamera():Camera()
  local hudCamera = self._world:MainCamera():HUDCamera()
  local hudWorldPos = GameObjectHelper.CalcGridHUDWorldPos(camera, hudCamera, gridRenderPos, BattleConst.HUDEdgeLeft, BattleConst.HUDEdgeRight, BattleConst.HUDEdgeDown, BattleConst.HUDEdgeUpper)
  return hudWorldPos
end

function RenderBattleService:GetMeshRendererInChildren(go)
  if not self._childMeshRenderers[go] then
    self._childMeshRenderers[go] = go:GetComponentInChildren(typeof(UnityEngine.MeshRenderer))
  end
  local v = self._childMeshRenderers[go]
  return v
end

function RenderBattleService:GetH3dRenderSetting()
  local goRenderSetting = UnityEngine.GameObject.Find("[H3DRenderSetting]")
  local csRenderSetting = goRenderSetting:GetComponent("H3DRenderSetting")
  return csRenderSetting
end

function RenderBattleService:DefaultEnvColor()
  UnityEngine.Shader.SetGlobalColor("_H3D_EnvColor", Color(1, 1, 1, 1))
end

function RenderBattleService:SetGlobalOutLine(state)
  local value = state and 1 or 0
  UnityEngine.Shader.SetGlobalFloat("_fightCameraOutline", value)
end

function RenderBattleService:SetAllViewOutLine()
  local viewEntities = self._world:GetGroupEntities(self._world.BW_WEMatchers.View)
  for i, entity in ipairs(viewEntities) do
    if entity:HasView() then
      self:SetActorOutLine(entity:View():GetGameObject())
    end
  end
end

function RenderBattleService:SetActorOutLine(go)
  if not self._world:RenderBattleStat():IsActorOutLine() then
    return
  end
  local skinnedmeshRenderers = go:GetComponentsInChildren(typeof(UnityEngine.SkinnedMeshRenderer))
  if skinnedmeshRenderers.Length > 0 then
    for i = 0, skinnedmeshRenderers.Length - 1 do
      local mesh = skinnedmeshRenderers[i]
      for j = 0, mesh.materials.Length - 1 do
        local material = mesh.materials[j]
        if material.shader.name == "H3D/Actor/Common" then
          local value = material:GetFloat("_OutlineStencilTemp")
          if value == 0 then
            material:SetFloat("_StencilID", 3)
            material:SetFloat("_StencilComp", 5)
          end
        end
      end
    end
  end
end
