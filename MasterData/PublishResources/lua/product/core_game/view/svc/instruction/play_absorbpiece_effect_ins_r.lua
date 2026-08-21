require("base_ins_r")
_class("PlayAbsorbPieceEffectInstruction", BaseInstruction)
PlayAbsorbPieceEffectInstruction = PlayAbsorbPieceEffectInstruction

function PlayAbsorbPieceEffectInstruction:Constructor(paramList)
  self._gridEffectID = 0
  if paramList.gridEffectID then
    self._gridEffectID = tonumber(paramList.gridEffectID)
  end
  self._flyEffectID = 0
  if paramList.flyEffectID then
    self._flyEffectID = tonumber(paramList.flyEffectID)
  end
  self._flySpeed = 0
  if paramList.flySpeed then
    self._flySpeed = tonumber(paramList.flySpeed)
  end
  self._delayTime = 0
  if paramList.delayTime then
    self._delayTime = tonumber(paramList.delayTime)
  end
  self._offsetX = 0
  if paramList.offsetX then
    self._offsetX = tonumber(paramList.offsetX)
  end
  self._offsetY = 0
  if paramList.offsetY then
    self._offsetY = tonumber(paramList.offsetY)
  end
  self._offsetZ = 0
  if paramList.offsetZ then
    self._offsetZ = tonumber(paramList.offsetZ)
  end
  self._targetPos = ""
  if paramList.targetPos then
    self._targetPos = paramList.targetPos
  end
  self._waitFlyEffectTime = 0
  if paramList.waitFlyEffectTime then
    self._waitFlyEffectTime = tonumber(paramList.waitFlyEffectTime)
  end
end

function PlayAbsorbPieceEffectInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local absorbResult = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.AbsorbPiece)
  if not absorbResult then
    return
  end
  local absorbPieceList = {}
  local newPieceList = {}
  for _, v in pairs(absorbResult) do
    local list = v:GetAbsorbPieceList()
    local newList = v:GetNewPieceList()
    if list then
      for _, p in pairs(list) do
        absorbPieceList[#absorbPieceList + 1] = p
      end
    end
    if newList then
      for _, p in pairs(newList) do
        newPieceList[#newPieceList + 1] = p
      end
    end
  end
  if not absorbPieceList or #absorbPieceList == 0 then
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local effectService = world:GetService("Effect")
  local boardServiceRender = world:GetService("BoardRender")
  if self._gridEffectID ~= 0 then
    for _, pos in pairs(absorbPieceList) do
      local renderPos = boardServiceRender:GridPos2RenderPos(pos)
      local effectEntity = effectService:CreatePositionEffect(self._gridEffectID, renderPos)
    end
  end
  YIELD(TT, self._delayTime)
  if self._flyEffectID ~= 0 then
    local waitTime = 0
    local targetPos = casterEntity:Location().Position
    if self._targetPos and self._targetPos ~= "" then
      local tran = casterEntity:View():GetGameObject().transform
      local targetTrans = GameObjectHelper.FindChild(tran, self._targetPos)
      targetPos = targetTrans.position
    end
    local effectList = {}
    for _, pos in pairs(absorbPieceList) do
      local renderPos = boardServiceRender:GridPos2RenderPos(pos)
      renderPos = renderPos + Vector3(self._offsetX, self._offsetY, self._offsetZ)
      local dir = targetPos - renderPos
      local effectEntity = world:GetService("Effect"):CreatePositionEffect(self._flyEffectID, renderPos)
      effectEntity:SetDirection(dir)
      local distance = Vector3.Distance(renderPos, targetPos)
      local flyTime = 0
      if self._flySpeed then
        flyTime = distance * self._flySpeed / 1000
      end
      local effect = {}
      effect.entity = effectEntity
      effect.flyTime = flyTime
      effectList[#effectList + 1] = effect
      if waitTime < flyTime then
        waitTime = flyTime
      end
    end
    YIELD(TT)
    YIELD(TT, self._waitFlyEffectTime)
    for _, effect in pairs(effectList) do
      local go = effect.entity:View():GetGameObject()
      local dotween = go.transform:DOMove(targetPos, effect.flyTime, false)
      if dotween then
        dotween:SetEase(DG.Tweening.Ease.InExpo):OnComplete(function()
          go:SetActive(false)
          world:DestroyEntity(effect.entity)
        end)
      else
        world:DestroyEntity(effect.entity)
      end
    end
    YIELD(TT, waitTime)
  end
  local boardServiceR = world:GetService("BoardRender")
  for _, pos in pairs(absorbPieceList) do
    local newPieceType = self:_GetPieceType(newPieceList, pos)
    boardServiceR:ReCreateGridEntity(newPieceType, pos, false, true)
  end
end

function PlayAbsorbPieceEffectInstruction:_GetPieceType(newPieceList, gridPos)
  for _, grid in pairs(newPieceList) do
    if grid.x == gridPos.x and grid.y == gridPos.y then
      return grid.color
    end
  end
  return nil
end

function PlayAbsorbPieceEffectInstruction:GetCacheResource()
  local t = {}
  if self._gridEffectID and self._gridEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._gridEffectID].ResPath,
      8
    })
  end
  if self._flyEffectID and 0 < self._flyEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._flyEffectID].ResPath,
      8
    })
  end
  return t
end
