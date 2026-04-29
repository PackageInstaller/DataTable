local PieceType = {
  None = 0,
  Blue = 1,
  Red = 2,
  Green = 3,
  Yellow = 4,
  Any = 5,
  AnyNone = 6
}
_enum("PieceType", PieceType)
local PieceEffectType = {
  Normal = 0,
  Prism = 1,
  CrossPrism = 2,
  Deep = 3,
  MAX = 9
}
_enum("PieceEffectType", PieceEffectType)

function CanMatchPieceType(t1, t2)
  if t1 == PieceType.None or t2 == PieceType.None then
    return false
  end
  if t1 == PieceType.AnyNone and t2 == PieceType.Any or t2 == PieceType.AnyNone and t1 == PieceType.Any then
    return true
  end
  if t1 == PieceType.Any or t2 == PieceType.Any then
    return true
  end
  return t1 == t2
end

function CanMatchPieceTypeList(type, typeList)
  if type == PieceType.None then
    return false
  end
  if type == PieceType.Any then
    return true
  end
  return table.icontains(typeList, type)
end

function PopStarCanMatchPieceType(t1, t2, tOri)
  if t1 == PieceType.None or t2 == PieceType.None then
    return false
  end
  if t2 == PieceType.Any then
    return true
  end
  return t1 == t2
end

ElementRelation = {
  [PieceType.Blue] = {
    lt = PieceType.Yellow,
    bt = PieceType.Red
  },
  [PieceType.Red] = {
    lt = PieceType.Blue,
    bt = PieceType.Green
  },
  [PieceType.Green] = {
    lt = PieceType.Red,
    bt = PieceType.Yellow
  },
  [PieceType.Yellow] = {
    lt = PieceType.Green,
    bt = PieceType.Blue
  },
  [PieceType.AnyNone] = {}
}
local ElementRelationFlag = {
  Counter = 0,
  BeCountered = 1,
  Normal = 2
}
_enum("ElementRelationFlag", ElementRelationFlag)
