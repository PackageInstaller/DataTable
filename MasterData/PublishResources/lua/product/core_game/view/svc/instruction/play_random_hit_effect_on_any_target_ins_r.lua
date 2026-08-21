_class("PlayRandomBindEffectOnAnyTargetInstruction", BaseInstruction)
PlayRandomBindEffectOnAnyTargetInstruction = PlayRandomBindEffectOnAnyTargetInstruction

function PlayRandomBindEffectOnAnyTargetInstruction:Constructor(paramList)
  self._tEffectID = {}
  local tStrFx = string.split(paramList.effectIDArray, "|")
  for _, str in ipairs(tStrFx) do
    local id = tonumber(str)
    if id then
      table.insert(self._tEffectID, id)
    end
    if not Cfg.cfg_effect[id] then
      Log.exception(self._className, "cfg_effect中没有该特效：", id)
    end
  end
  assert(#self._tEffectID > 0, "[PlayRandomHitEffectOnAnyTarget] effectIDArray里没有任何有效ID")
end

function PlayRandomBindEffectOnAnyTargetInstruction:GetCacheResource()
  local t = {}
  for _, id in ipairs(self._tEffectID) do
    table.insert(t, {
      Cfg.cfg_effect[id].ResPath,
      4
    })
  end
  return t
end

function PlayRandomBindEffectOnAnyTargetInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local effectService = world:GetService("Effect")
  local targetEntityID = phaseContext:GetCurTargetEntityID()
  local targetEntity = world:GetEntityByID(targetEntityID)
  if not targetEntity then
    return
  end
  local luckyNum = 1
  if 1 < #self._tEffectID then
    luckyNum = math.random(1, #self._tEffectID)
  end
  local luckyEffectID = self._tEffectID[luckyNum]
  local eFx = effectService:CreateBeHitEffect(luckyEffectID, targetEntity)
  if eFx then
    self:_FxLookAtCaster(eFx, casterEntity)
    local effectCtrl = eFx:EffectController()
    if effectCtrl ~= nil and casterEntity ~= nil then
      effectCtrl:SetEffectCasterID(casterEntity:GetID())
    end
  end
end

function PlayRandomBindEffectOnAnyTargetInstruction:_FxLookAtCaster(eFx, eCaster)
  if not eCaster or not eCaster:HasView() then
    return
  end
  local cFxView = eFx:View()
  local go = cFxView:GetGameObject()
  local transform = go.transform
  local cCasterView = eCaster:View()
  local casterTransform = cCasterView:GetGameObject().transform
  transform:LookAt(casterTransform, Vector3.up)
end
