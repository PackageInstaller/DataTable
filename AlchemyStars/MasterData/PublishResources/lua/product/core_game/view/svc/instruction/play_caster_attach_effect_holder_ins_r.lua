require("base_ins_r")
_class("PlayCasterAttachEffectHolderInstruction", BaseInstruction)
PlayCasterAttachEffectHolderInstruction = PlayCasterAttachEffectHolderInstruction

function PlayCasterAttachEffectHolderInstruction:Constructor(paramList)
  self._effHolderType = paramList.effHolderType
  self._effId = tonumber(paramList.effId)
  local strT = paramList.T
  if strT then
    local arr = string.split(strT, "|")
    self._t = Vector3(tonumber(arr[1]), tonumber(arr[2]), tonumber(arr[3]))
  end
  local strS = paramList.S
  if strS then
    local arr = string.split(strS, "|")
    self._s = Vector3(tonumber(arr[1]), tonumber(arr[2]), tonumber(arr[3]))
  end
  self._useCasterPos = paramList.useCasterPos
  self._isShow = paramList.isShow or true
end

function PlayCasterAttachEffectHolderInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local effectService = world:GetService("Effect")
  local cEffectHolder = casterEntity:EffectHolder()
  if not cEffectHolder then
    casterEntity:AddEffectHolder()
  end
  cEffectHolder = casterEntity:EffectHolder()
  local effEntity
  if not self._useCasterPos then
    effEntity = effectService:CreateEffect(self._effId, casterEntity)
  else
    effEntity = effectService:CreateWorldPositionEffect(self._effId, casterEntity:GetGridPosition(), self._isShow)
  end
  local effEntityId = effEntity:GetID()
  if self._effHolderType == "Idle" then
    cEffectHolder:AttachIdleEffect(effEntityId)
  elseif self._effHolderType == "Permanent" then
    cEffectHolder:AttachPermanentEffect(effEntityId)
  else
    cEffectHolder:AttachEffect(self._effHolderType, effEntityId)
  end
  YIELD(TT)
  local cView = effEntity:View()
  local tran = cView:GetGameObject().transform
  if self._t then
    tran.localPosition = self._t
  end
  if self._s then
    tran.localScale = self._s
  end
end

function PlayCasterAttachEffectHolderInstruction:GetCacheResource()
  local t = {}
  if self._effId and self._effId > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effId].ResPath,
      1
    })
  end
  return t
end
