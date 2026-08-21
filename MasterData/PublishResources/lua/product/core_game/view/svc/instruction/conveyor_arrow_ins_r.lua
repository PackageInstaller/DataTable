require("base_ins_r")
_class("ConveyorArrowInstruction", BaseInstruction)
ConveyorArrowInstruction = ConveyorArrowInstruction

function ConveyorArrowInstruction:Constructor(paramList)
  self._effId = tonumber(paramList.effId)
  self._endEffID = tonumber(paramList.endEffID)
end

function ConveyorArrowInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  if not casterEntity:HasTrapID() then
    return
  end
  local trapRenderCmpt = casterEntity:TrapRender()
  if trapRenderCmpt:GetTrapType() ~= TrapType.Conveyor then
    return
  end
  local cEffectHolder = casterEntity:EffectHolder()
  if not cEffectHolder then
    casterEntity:AddEffectHolder()
  end
  cEffectHolder = casterEntity:EffectHolder()
  local sEffect = world:GetService("Effect")
  local bodyArea = casterEntity:BodyArea():GetArea()
  local cGridLocation = casterEntity:GridLocation()
  local pos, dir = cGridLocation.Position, cGridLocation.Direction
  local len = table.count(bodyArea)
  local arrows = {}
  local key = "ConveyorArrow"
  local effID = self._effId
  for i = 1, len do
    local newPos = bodyArea[i] + pos
    local newDir
    if i == len then
      if self._endEffID and self._endEffID > 0 then
        effID = self._endEffID
        newDir = Vector2.up
      else
        newDir = bodyArea[1] - bodyArea[i]
      end
    else
      newDir = bodyArea[i + 1] - bodyArea[i]
    end
    local effEntity = sEffect:CreateWorldPositionDirectionEffect(effID, newPos, newDir)
    local effEntityId = effEntity:GetID()
    cEffectHolder:AttachEffect(key, effEntityId)
    effEntity:SetGridLocation(newPos, newDir)
    effEntity:SetLocation(newPos, newDir)
    table.insert(arrows, effEntity)
  end
  self:_ConveyorClockwise(TT, arrows)
end

function ConveyorArrowInstruction:_ConveyorClockwise(TT, arrows)
  if not arrows then
    return
  end
  local isClockwise = true
  local dir = arrows[1]:GridLocation().Direction
  for i = 2, table.count(arrows) do
    local dirTmp = arrows[i]:GridLocation().Direction
    if dir ~= dirTmp then
      if dir == Vector2(dirTmp.y, -dirTmp.x) then
        isClockwise = false
        break
      end
      if dir == Vector2(-dirTmp.y, dirTmp.x) then
        isClockwise = true
      end
      break
    end
  end
  for _, e in ipairs(arrows) do
    local go = e:View():GetGameObject()
    if isClockwise then
      go.transform.localScale = Vector3(-1, 1, 1)
    else
      go.transform.localScale = Vector3.one
    end
  end
end

function ConveyorArrowInstruction:GetCacheResource()
  local t = {}
  if self._effId and self._effId > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effId].ResPath,
      4
    })
  end
  if self._endEffID and 0 < self._endEffID then
    table.insert(t, {
      Cfg.cfg_effect[self._endEffID].ResPath,
      1
    })
  end
  return t
end
