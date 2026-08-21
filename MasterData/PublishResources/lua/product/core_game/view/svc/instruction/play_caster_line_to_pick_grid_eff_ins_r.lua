require("base_ins_r")
_class("PlayCasterLineToPickGridEffInstruction", BaseInstruction)
PlayCasterLineToPickGridEffInstruction = PlayCasterLineToPickGridEffInstruction

function PlayCasterLineToPickGridEffInstruction:Constructor(paramList)
  self._lineOnCaster = paramList.lineOnCaster
  self._lineOnEffect = paramList.lineOnEffect
  self._lineEffectID = tonumber(paramList.lineEffectID)
  self._lineEffectDelay = tonumber(paramList.lineEffectDelay)
  self._lineEffectDuration = tonumber(paramList.lineEffectDuration)
  self._gridEffectID = tonumber(paramList.gridEffectID)
  self._pickUpIndex = tonumber(paramList.pickUpIndex)
  self._pickEffDirX = 0
  self._pickEffDirY = 1
  if paramList.pickEffDirX then
    self._pickEffDirX = tonumber(paramList.pickEffDirX)
  end
  if paramList.pickEffDirY then
    self._pickEffDirY = tonumber(paramList.pickEffDirY)
  end
  self._dirOnPickup = tonumber(paramList.dirOnPickup) or 0
end

function PlayCasterLineToPickGridEffInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local effectService = world:GetService("Effect")
  local gridEff = self:_PlayGridEffect(casterEntity)
  if not gridEff then
    return
  end
  local targetRoot = GameObjectHelper.FindChild(casterEntity:View().ViewWrapper.GameObject.transform, self._lineOnCaster)
  if not targetRoot then
    return
  end
  do
    local entity = gridEff
    local effectLineRenderer = entity:EffectLineRenderer()
    entity:SetViewVisible(true)
    local entityViewRoot = entity:View().ViewWrapper.GameObject.transform
    local curRoot = GameObjectHelper.FindChild(entityViewRoot, self._lineOnEffect)
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
      local effectEntityIdList = effectHolderCmpt:GetEffectIDEntityDic()[self._lineEffectID]
      local effect
      if effectEntityIdList then
        effect = world:GetEntityByID(effectEntityIdList[1])
      end
      if not effect then
        effect = effectService:CreateEffect(self._lineEffectID, entity)
        effectHolderCmpt:AttachPermanentEffect(effect:GetID())
      end
      local go = effect:View():GetGameObject()
      local renderers
      renderers = go:GetComponentsInChildren(typeof(UnityEngine.LineRenderer), true)
      for i = 0, renderers.Length - 1 do
        local line = renderers[i]
        if line then
          line.gameObject:SetActive(true)
        end
      end
      effectLineRenderer:InitEffectLineRenderer(casterEntity:GetID(), curRoot, targetRoot, entityViewRoot, renderers, effect:GetID())
      effectLineRenderer:SetIgnoreEntityViewRootPos(true)
      YIELD(TT, self._lineEffectDelay)
      effectLineRenderer:SetEffectLineRendererShow(casterEntity:GetID(), true)
      YIELD(TT, self._lineEffectDuration)
      effectLineRenderer:SetEffectLineRendererShow(casterEntity:GetID(), false)
      local lineEffectID = effectLineRenderer:GetEffectLineRendererEffectID(casterEntity:GetID())
      if effectHolderCmpt then
        local effectList = effectHolderCmpt:GetPermanentEffect()
        for i, eff in ipairs(effectList) do
          if lineEffectID and lineEffectID == eff then
            local e = world:GetEntityByID(eff)
            if e and e:HasView() then
              local go = e:View():GetGameObject()
              local renderers = go:GetComponentsInChildren(typeof(UnityEngine.LineRenderer), true)
              for i = 0, renderers.Length - 1 do
                local line = renderers[i]
                if line then
                  line.gameObject:SetActive(false)
                end
              end
            end
          end
        end
      end
    end
  end
end

function PlayCasterLineToPickGridEffInstruction:_PlayGridEffect(casterEntity)
  local world = casterEntity:GetOwnerWorld()
  local sEffect = world:GetService("Effect")
  local dir = Vector2(self._pickEffDirX, self._pickEffDirY)
  local renderPickUpComponent = casterEntity:RenderPickUpComponent()
  if not renderPickUpComponent then
    return
  end
  local pickUpGridArray = renderPickUpComponent:GetAllValidPickUpGridPos()
  local v2PickupPos = pickUpGridArray[self._pickUpIndex]
  if self._dirOnPickup ~= 0 then
    dir = v2PickupPos - casterEntity:GetGridPosition()
  end
  local effectEntity = sEffect:CreateWorldPositionDirectionEffect(self._gridEffectID, v2PickupPos, dir)
  return effectEntity
end
