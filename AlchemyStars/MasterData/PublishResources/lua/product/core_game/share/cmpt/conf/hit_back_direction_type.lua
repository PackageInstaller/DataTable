HitBackDirectionType = {
  None = 0,
  Up = 1,
  Right = 2,
  Down = 3,
  Left = 4,
  UpDown = 5,
  LeftRight = 6,
  EightDir = 7,
  RightUp = 8,
  RightDown = 9,
  LeftDown = 10,
  LeftUp = 11,
  Cross = 12,
  SelectCanUseDir = 13,
  FaceFront = 14,
  SelectSquareRingFarest = 15,
  SpecifyXCoordinate = 16,
  SelectCanUse8Dir = 17,
  SelectNearestOutOfRange = 18,
  AntiEightDir = 19,
  SelectCanUseDirAndDis = 20,
  CoffinMusume = 21,
  CasterDir2Edge = 22,
  Front3Dir = 23,
  AttackFront2Edge = 24,
  EightDirAndCasterAround = 25,
  Butterfly = 26,
  BossCarrot = 27,
  Scorpion = 28,
  END = 9999
}
_enum("HitBackDirectionType", HitBackDirectionType)
HitBackDirectionTypeHelper = {}

function HitBackDirectionTypeHelper.ConvertDirTypeToVector(dirType)
  local vectorRes = Vector2(0, 0)
  if dirType == HitBackDirectionType.Up then
    vectorRes = Vector2(0, 1)
  elseif dirType == HitBackDirectionType.Right then
    vectorRes = Vector2(1, 0)
  elseif dirType == HitBackDirectionType.Down then
    vectorRes = Vector2(0, -1)
  elseif dirType == HitBackDirectionType.Left then
    vectorRes = Vector2(-1, 0)
  end
  return vectorRes
end

function HitBackDirectionTypeHelper.ConvertDirTypeToVectorEight(dirType)
  local vectorRes = Vector2(0, 0)
  if dirType == HitBackDirectionType.Up then
    vectorRes = Vector2(0, 1)
  elseif dirType == HitBackDirectionType.Right then
    vectorRes = Vector2(1, 0)
  elseif dirType == HitBackDirectionType.Down then
    vectorRes = Vector2(0, -1)
  elseif dirType == HitBackDirectionType.Left then
    vectorRes = Vector2(-1, 0)
  elseif dirType == HitBackDirectionType.RightUp then
    vectorRes = Vector2(1, 1)
  elseif dirType == HitBackDirectionType.RightDown then
    vectorRes = Vector2(1, -1)
  elseif dirType == HitBackDirectionType.LeftUp then
    vectorRes = Vector2(-1, 1)
  elseif dirType == HitBackDirectionType.LeftDown then
    vectorRes = Vector2(-1, -1)
  end
  return vectorRes
end

function HitBackDirectionTypeHelper.OverlapHitbackDir(firstDirType, secondDirType)
  local firstVector = HitBackDirectionTypeHelper.ConvertDirTypeToVector(firstDirType)
  local secondVector = HitBackDirectionTypeHelper.ConvertDirTypeToVector(secondDirType)
  local vectorResult = firstVector + secondVector
  if vectorResult.x > 0 then
    if 0 < vectorResult.y then
      return HitBackDirectionType.RightUp
    else
      return HitBackDirectionType.RightDown
    end
  elseif vectorResult.x < 0 then
    if 0 < vectorResult.y then
      return HitBackDirectionType.LeftUp
    else
      return HitBackDirectionType.LeftDown
    end
  elseif vectorResult.x == 0 and vectorResult.y == 0 then
    return HitBackDirectionType.None
  end
  Log.fatal("OverlapHitbackDir is nil")
end

function HitBackDirectionTypeHelper.NormalizeDirType(attackDir)
  local tempDir = Vector2(attackDir.x, attackDir.y)
  tempDir = GameHelper.ComputeLogicDir(tempDir)
  if tempDir.x ~= 0 then
    local sign = tempDir.x / math.abs(tempDir.x)
    tempDir.x = math.floor(math.abs(tempDir.x) + 0.5) * sign
  end
  if tempDir.y ~= 0 then
    local sign = tempDir.y / math.abs(tempDir.y)
    tempDir.y = math.floor(math.abs(tempDir.y) + 0.5) * sign
  end
  return tempDir
end
