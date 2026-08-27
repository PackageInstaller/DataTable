local UIHeroUtil = {}

function UIHeroUtil.UpdHeroStar(img_Star, obj_StarHalf, rank)
  local half = rank % 2
  local rankImgIndex = (rank - half) / 2 - 1
  if 0 <= rankImgIndex then
    img_Star.gameObject:SetActive(true)
    img_Star:SetIndex(rankImgIndex)
    img_Star.image:SetNativeSize()
  else
    img_Star.gameObject:SetActive(false)
  end
  obj_StarHalf:SetActive(half == 1)
end

local HeroLevel60Color = Color.New(1, 0.5450980392156862, 0.12941176470588237)
local HeroLevel60ColorHexPre = "<Color=#FF8B21>"

function UIHeroUtil.GetHeroLevelColor(level)
  return level >= ConfigData.buildinConfig.HeroLongTailLevel and HeroLevel60Color or Color.white
end

function UIHeroUtil.GetHeroLevelColorHexStr(level)
  if level >= ConfigData.buildinConfig.HeroLongTailLevel then
    return HeroLevel60ColorHexPre .. tostring(level) .. "</Color>"
  end
  return tostring(level)
end

return UIHeroUtil
