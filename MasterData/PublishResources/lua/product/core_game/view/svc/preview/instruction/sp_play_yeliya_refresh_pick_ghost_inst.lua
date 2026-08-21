require("sp_base_inst")
_class("SkillPreviewYeliyaRefreshPickGhostInstruction", SkillPreviewBaseInstruction)
SkillPreviewYeliyaRefreshPickGhostInstruction = SkillPreviewYeliyaRefreshPickGhostInstruction

function SkillPreviewYeliyaRefreshPickGhostInstruction:Constructor(params)
  self._ghostAnim = params.GhostAnim or "AtkUltPreview"
  self._lineEffectID = tonumber(params.LineEffectID)
  self._bindPos = params.BindPos or "Root"
  self._pickPosEffectID = tonumber(params.PickPosEffectID)
end

function SkillPreviewYeliyaRefreshPickGhostInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = casterEntity:GetOwnerWorld()
  local effectService = world:GetService("Effect")
  local renderEntitySvc = world:GetService("RenderEntity")
  renderEntitySvc:DestroyGhost()
  YIELD(TT)
  local entitySvc = world:GetService("RenderEntity")
  local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
  local pickupPosArray = previewPickUpComponent and previewPickUpComponent:GetAllValidPickUpGridPos() or {}
  if 0 < #pickupPosArray then
    local lastPos = casterEntity:GetPosition()
    local lastEntity = casterEntity
    for index, pickPos in ipairs(pickupPosArray) do
      local ghostEntity = entitySvc:CreateGhost(pickPos, casterEntity, self._ghostAnim)
      if ghostEntity then
        ghostEntity:SetDirection(pickPos - lastPos)
        ghostEntity:SetViewVisible(true)
        if self._pickPosEffectID then
          effectService:CreateEffect(self._pickPosEffectID, ghostEntity)
        end
        GameGlobal.TaskManager():CoreGameStartTask(self._CreateIndexNumHeadShow, self, world, ghostEntity, index)
        self:_PlayLineEffect(TT, world, ghostEntity, lastEntity)
        lastEntity = ghostEntity
      end
      lastPos = pickPos
    end
  end
end

function SkillPreviewYeliyaRefreshPickGhostInstruction:_PlayLineEffect(TT, world, fromEntity, toEntity)
  if not self._lineEffectID then
    return
  end
  local effectService = world:GetService("Effect")
  local effectLineRenderer = fromEntity:EffectLineRenderer()
  if not effectLineRenderer then
    fromEntity:AddEffectLineRenderer()
    effectLineRenderer = fromEntity:EffectLineRenderer()
  end
  local effectHolderCmpt = fromEntity:EffectHolder()
  if not effectHolderCmpt then
    fromEntity:AddEffectHolder()
    effectHolderCmpt = fromEntity:EffectHolder()
  end
  local effectEntityIdList = effectHolderCmpt:GetEffectIDEntityDic()[self._lineEffectID]
  local effect
  if effectEntityIdList then
    effect = world:GetEntityByID(effectEntityIdList[1])
  end
  if not effect then
    effect = effectService:CreateEffect(self._lineEffectID, fromEntity)
    effectHolderCmpt:AttachPermanentEffect(effect:GetID())
  end
  local go = effect:View():GetGameObject()
  local renderers
  renderers = go:GetComponentsInChildren(typeof(UnityEngine.LineRenderer), true)
  local fromEntityViewRoot = fromEntity:View().ViewWrapper.GameObject.transform
  local fromEntityRoot = GameObjectHelper.FindChild(fromEntityViewRoot, self._bindPos)
  local toEntityViewRoot = toEntity:View().ViewWrapper.GameObject.transform
  local toEntityRoot = GameObjectHelper.FindChild(toEntityViewRoot, self._bindPos)
  local fromEntityID = fromEntity:GetID()
  local toEntityID = toEntity:GetID()
  effectLineRenderer:InitEffectLineRenderer(fromEntityID, fromEntityRoot, toEntityRoot, fromEntityViewRoot, renderers, effect:GetID())
  effectLineRenderer:SetEffectLineRendererShow(fromEntityID, true)
  effectLineRenderer:SetTargetEntityID(toEntityID)
  effectLineRenderer:SetTargetRootOff(Vector3(0, 0.001, 0))
end

function SkillPreviewYeliyaRefreshPickGhostInstruction:_CreateIndexNumHeadShow(TT, world, entity, index)
  local entityService = world:GetService("RenderEntity")
  local roundInfoEntity = entityService:CreateRenderEntity(EntityConfigIDRender.HeadTrapRoundInfo)
  roundInfoEntity:ReplaceAsset(NativeUnityPrefabAsset:New("hud_yeliya_ghost_index_info.prefab"))
  roundInfoEntity:AddHUD()
  local tmpType = TrapHeadShowType.HeadShowLevel
  local tmpParam = {
    levelTrapNum = 1,
    x = 0,
    y = 0,
    z = 0
  }
  entity:ReplaceTrapRoundInfoRender(roundInfoEntity:GetID(), tmpType, tmpParam)
  YIELD(TT)
  local roundRender = entity:TrapRoundInfoRender()
  if roundRender then
    local round_entity_id = roundRender:GetRoundInfoEntityID()
    local round_entity = world:GetEntityByID(round_entity_id)
    if round_entity then
      local num = index
      local go = round_entity:View().ViewWrapper.GameObject
      local uiview = go:GetComponent("UIView")
      if uiview and num then
        local numText = uiview:GetUIComponent("UILocalizationText", "LevelNumText")
        if numText then
          numText:SetText(num)
        end
      end
      roundRender:SetIsShow(true)
      round_entity:SetViewVisible(true)
      local renderEntityService = world:GetService("RenderEntity")
      renderEntityService:SetHudPosition(entity, round_entity, roundRender:GetOffset())
    end
  end
end
