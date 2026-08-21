_class("BuffLogicDamageByBodyAreaPieceCount", BuffLogicBase)
BuffLogicDamageByBodyAreaPieceCount = BuffLogicDamageByBodyAreaPieceCount

function BuffLogicDamageByBodyAreaPieceCount:Constructor(buffInstance, logicParam)
  self._damageParam = logicParam
  self._basePercent = logicParam.percent
  self._pieceType = logicParam.pieceType or {}
  self._excludeTrap = logicParam.excludeTrap or {}
end

function BuffLogicDamageByBodyAreaPieceCount:DoLogic(notify)
  local context = self._buffInstance:Context()
  if not context then
    return
  end
  local petEntity = context.casterEntity
  if not petEntity then
    return
  end
  local defender = self._entity
  local playerElementCmpt = petEntity:Element()
  if playerElementCmpt then
    playerElementCmpt:SetUseSecondaryType(false)
  end
  local pieceCount = 1
  local bodyAreaPosList = {}
  local bodyAreaList = defender:BodyArea():GetArea()
  local gridPos = defender:GridLocation():GetGridPos()
  for _, bodyArea in ipairs(bodyAreaList) do
    local workPos = gridPos + bodyArea
    table.insert(bodyAreaPosList, workPos)
  end
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local posList = boardServiceLogic:FindPieceElementByTypeCountAndCenterFromParam(gridPos, self._pieceType, #bodyAreaPosList, bodyAreaPosList)
  local pieceCount = table.count(posList)
  local newPercent = 0
  newPercent = self._basePercent * pieceCount
  if newPercent == 0 then
    return
  end
  self._damageParam.percent = newPercent
  self._world:GetMatchLogger():BeginBuff(defender:GetID(), self._buffInstance:BuffID())
  local blsvc = self._world:GetService("BuffLogic")
  local damageInfo = blsvc:DoBuffDamage(self._buffInstance:BuffID(), petEntity, defender, self._damageParam)
  self._world:GetMatchLogger():EndBuff(defender:GetID())
  local buffResult = BuffResultDamage:New(damageInfo)
  return buffResult
end
