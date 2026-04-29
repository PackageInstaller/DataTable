require("scope_base")
_class("SkillScopeCalculator_DirectLineExpand", SkillScopeCalculator_Base)
SkillScopeCalculator_DirectLineExpand = SkillScopeCalculator_DirectLineExpand

function SkillScopeCalculator_DirectLineExpand:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local casterPos = centerPos
  local bodyAreaArray = bodyArea
  local effectDirType = 1
  local param = scopeParam
  local expandWidth = param[3] or 0
  local expandArea = {}
  for i, v in ipairs(bodyAreaArray) do
    local p = Vector2(v.x, v.y)
    table.insert(expandArea, p)
  end
  local casterDirX = casterDir.x
  local casterDirY = casterDir.y
  if casterDirX ~= 0 then
    casterDirX = casterDirX / math.abs(casterDirX)
  end
  if casterDirY ~= 0 then
    casterDirY = casterDirY / math.abs(casterDirY)
  end
  casterDir = Vector2(casterDirX, casterDirY)
  local vertical1, vertical2 = Vector2(casterDirY, casterDirX), Vector2(-casterDirY, -casterDirX)
  for i, p in ipairs(bodyAreaArray) do
    for i = 1, expandWidth do
      local l = p + vertical1 * i
      local r = p + vertical2 * i
      if not BodyAreaHelper.IsPosInBodyArea(expandArea, l) then
        table.insert(expandArea, l)
      end
      if not BodyAreaHelper.IsPosInBodyArea(expandArea, r) then
        table.insert(expandArea, r)
      end
    end
  end
  local exceptBack = {}
  for i, v in ipairs(expandArea) do
    local p = Vector2(v.x, v.y)
    if not BodyAreaHelper.IsPosInBodyArea(expandArea, p + casterDir) then
      table.insert(exceptBack, p)
    end
  end
  local absArea = {}
  for i, p in ipairs(exceptBack) do
    table.insert(absArea, Vector2(casterPos.x + p.x, casterPos.y + p.y))
  end
  local cross_area = {}
  local wholeArea = {}
  local size = param[2] or 0
  local offset = param[1] or 0
  for i, p in ipairs(absArea) do
    local center_x = p.x
    local center_y = p.y
    for index = 1, size do
      local offsetIdx = index + offset
      local directpos = Vector2(center_x + casterDirX * offsetIdx, center_y + casterDirY * offsetIdx)
      table.insert(wholeArea, directpos)
      if self._gridFilter:IsValidPiecePos(directpos) then
        table.insert(cross_area, directpos)
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.DirectLineExpand, casterPos, cross_area, wholeArea)
  return result
end
