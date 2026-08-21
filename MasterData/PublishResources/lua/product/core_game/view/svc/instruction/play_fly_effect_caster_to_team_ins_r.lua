require("base_ins_r")
_class("PlayFlyEffectCasterToTeamInstruction", BaseInstruction)
PlayFlyEffectCasterToTeamInstruction = PlayFlyEffectCasterToTeamInstruction

function PlayFlyEffectCasterToTeamInstruction:Constructor(paramList)
  self._flyEffectID = tonumber(paramList.flyEffectID)
  self._hitEffectID = tonumber(paramList.hitEffectID)
  self._flySpeed = tonumber(paramList.flySpeed)
  if paramList.flyTime then
    self._flyTime = tonumber(paramList.flyTime)
  end
  self._startWaitTime = tonumber(paramList.startWaitTime)
  self._offsetX = tonumber(paramList.offsetx) or 0
  self._offsetY = tonumber(paramList.offsety) or 0
  self._offsetZ = tonumber(paramList.offsetz) or 0
  self._flyEaseType = paramList.flyEaseType
  self._targetPos = ""
  if paramList.targetPos then
    self._targetPos = paramList.targetPos
  end
  self._originalBoneName = ""
  if paramList.originalBoneName then
    self._originalBoneName = paramList.originalBoneName
  end
  self._isBlock = tonumber(paramList.isBlock) or 1
end

function PlayFlyEffectCasterToTeamInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local teamEntity = world:Player():GetCurrentTeamEntity()
  local targetEntity = teamEntity
  local tran
  if casterEntity:HasSuperEntity() and casterEntity:SuperEntityComponent():IsUseSuperEntityView() then
    tran = casterEntity:GetSuperEntity():View():GetGameObject().transform
  else
    tran = casterEntity:View():GetGameObject().transform
  end
  local castPos = tran:TransformPoint(Vector3(self._offsetX, self._offsetY, self._offsetZ))
  if self._originalBoneName and self._originalBoneName ~= "" then
    local boneTrans = GameObjectHelper.FindChild(tran, self._originalBoneName)
    if boneTrans ~= nil then
      castPos = boneTrans.position
    end
  end
  local targetPos = targetEntity:Location().Position
  if self._targetPos and self._targetPos ~= "" then
    local tran = targetEntity:View():GetGameObject().transform
    local targetTrans = GameObjectHelper.FindChild(tran, self._targetPos)
    if targetTrans ~= nil then
      targetPos = targetTrans.position
    end
  end
  local dir = targetPos - castPos
  local effectService = world:GetService("Effect")
  local effectEntity = effectService:CreatePositionEffect(self._flyEffectID, castPos)
  YIELD(TT)
  effectEntity:SetDirection(dir)
  YIELD(TT, self._startWaitTime)
  local distance = Vector3.Distance(castPos, targetPos)
  local flyTime = 0
  if self._flySpeed then
    flyTime = distance * self._flySpeed
  end
  YIELD(TT)
  local go = effectEntity:View():GetGameObject()
  local dotween
  if flyTime == 0 and self._flyTime then
    flyTime = self._flyTime
  end
  dotween = go.transform:DOMove(targetPos, flyTime / 1000.0, false)
  if self._flyEaseType then
    local easyType = DG.Tweening.Ease[self._flyEaseType]
    dotween:SetEase(easyType)
  end
  if dotween then
    dotween:SetEase(DG.Tweening.Ease.InOutSine):OnComplete(function()
      go:SetActive(false)
      world:DestroyEntity(effectEntity)
    end)
  end
  if self._isBlock == 1 then
    YIELD(TT, flyTime)
    if not dotween then
      world:DestroyEntity(effectEntity)
    end
    local hitEffect = effectService:CreateEffect(self._hitEffectID, targetEntity)
  else
    GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      YIELD(TT, flyTime)
      if not dotween then
        world:DestroyEntity(effectEntity)
      end
    end)
  end
end

function PlayFlyEffectCasterToTeamInstruction:GetCacheResource()
  local t = {}
  if self._flyEffectID and self._flyEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._flyEffectID].ResPath,
      1
    })
  end
  return t
end
