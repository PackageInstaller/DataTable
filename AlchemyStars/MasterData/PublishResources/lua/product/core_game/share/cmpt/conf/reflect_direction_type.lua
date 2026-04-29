ReflectDirectionType = {
  Heng = 1,
  Shu = 2,
  Pie = 3,
  Na = 4
}

function CalcReflectPos(srcPos, centerPos, reflectType)
  local tarPos = Vector2(srcPos.x, srcPos.y)
  if srcPos == centerPos then
    return tarPos
  end
  if reflectType == ReflectDirectionType.Heng then
    local dir = centerPos - srcPos
    tarPos.x = centerPos.x + dir.x
    return tarPos
  elseif reflectType == ReflectDirectionType.Shu then
    local dir = centerPos - srcPos
    tarPos.y = centerPos.y + dir.y
    return tarPos
  elseif reflectType == ReflectDirectionType.Na then
    local orignal = srcPos - centerPos
    orignal.x, orignal.y = orignal.y, orignal.x
    tarPos = orignal + centerPos
    return tarPos
  elseif reflectType == ReflectDirectionType.Pie then
    local orignal = srcPos - centerPos
    orignal.x, orignal.y = -orignal.y, -orignal.x
    tarPos = orignal + centerPos
    return tarPos
  end
end
