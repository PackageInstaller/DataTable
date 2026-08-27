local HeroListStateEnum = {}
HeroListStateEnum.eHeroListFlag = {
  none = 0,
  showLocked = 1,
  showFavor = 2,
  editorFavor = 4
}

function HeroListStateEnum.isHaveFlag(flag, enum)
  if flag == nil or enum == nil then
    return false
  end
  return 0 < flag & enum
end

return HeroListStateEnum
