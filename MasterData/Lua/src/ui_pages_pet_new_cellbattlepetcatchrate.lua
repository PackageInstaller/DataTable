local module = class("cellBattlePetCatchRate", G_UIModuleBase)
local petDna = L_GameTpl:getDnaTpl()

function module:ctor(...)
  module.super.ctor(self, ...)
  self.catchIndex = {
    hp = 2,
    graph = 3,
    food = 4,
    nestCoop = 5,
    Link = 6,
    guarantee = 7
  }
  self.data = {
    icons = {
      [self.catchIndex.hp] = "UI/Icon/PetCatch/tex_starlink_lens_icon_3xl.png",
      [self.catchIndex.Link] = "UI/Icon/PetCatch/tex_starlink_lens_icon_3lv.png",
      [self.catchIndex.graph] = "UI/Icon/PetCatch/tex_starlink_lens_icon_3tj.png",
      [self.catchIndex.food] = "UI/Icon/PetCatch/tex_starlink_lens_icon_3ll.png",
      [self.catchIndex.guarantee] = "UI/Icon/PetCatch/tex_starlink_lens_icon_3bd.png",
      [self.catchIndex.nestCoop] = "UI/Icon/PetCatch/tex_starlink_lens_icon_3bs.png"
    },
    color = {
      [self.catchIndex.hp] = "#ffffff",
      [self.catchIndex.Link] = "#ffffff",
      [self.catchIndex.graph] = "#ffffff",
      [self.catchIndex.food] = "#ffffff",
      [self.catchIndex.guarantee] = "#a2c9ff",
      [self.catchIndex.nestCoop] = "#ffffff"
    },
    alpha = {
      [self.catchIndex.hp] = 0.8,
      [self.catchIndex.Link] = 0.8,
      [self.catchIndex.graph] = 0.8,
      [self.catchIndex.food] = 0.8,
      [self.catchIndex.guarantee] = 1,
      [self.catchIndex.nestCoop] = 0.8
    },
    txtKey = {
      [self.catchIndex.hp] = "ui_starlink_hp_factor",
      [self.catchIndex.Link] = "ui_starlink_player_level_factor",
      [self.catchIndex.graph] = "ui_starlink_iconography_factor",
      [self.catchIndex.food] = "ui_starlink_dishes_factor",
      [self.catchIndex.guarantee] = "ui_starlink_guarantee_factor",
      [self.catchIndex.nestCoop] = "ui_starlink_nestcoop_factor"
    }
  }
end

function module.bind()
  return {
    txt_bonusName = "",
    txt_bonusNum = "",
    img_bonusIcon = "",
    color_icon = C_Color.white,
    color_bonusName = C_Color.white,
    color_bonusNum = C_Color.white,
    rectSize_line = C_Vector2(100, 1.0112),
    active_recommand = false
  }
end

function module.methods()
  return {}
end

function module:refresh()
  self:refreshInfo()
end

local function hasTwoDecimalPlaces(value)
  local EPSILON = 1.0E-9
  local roundedToTwo = math.floor(value * 100 + 0.5) / 100
  local roundedToOne = math.floor(value * 10 + 0.5) / 10
  return EPSILON < math.abs(roundedToTwo - roundedToOne)
end

function module:refreshInfo(data)
  local rateInfo = data or self.bind
  local petCatchRateIndex = rateInfo.petCatchRateIndex
  if not petCatchRateIndex then
    self.hideByEmpty = true
    self:onRefreshEmpty()
    return
  elseif self.hideByEmpty then
    self.hideByEmpty = false
    self:onEmptyToShow()
  end
  local iconName = self.data.icons[petCatchRateIndex]
  local colorStr = self.data.color[petCatchRateIndex]
  local alpha = self.data.alpha[petCatchRateIndex]
  local value = rateInfo.petCatchRateValue
  local numTxtColor = "#ffffff"
  if value < 0 then
    numTxtColor = "#FF6D6D"
  end
  local numTxtValue
  local hasTwoDecimals = hasTwoDecimalPlaces(value)
  if math.abs(value) >= 1 and not hasTwoDecimals then
    numTxtValue = ("%.1f%%"):format(value)
  else
    numTxtValue = ("%.2f%%"):format(value)
  end
  self.bind.txt_bonusNum = L_GameUtil.fillColor(numTxtValue, numTxtColor)
  self.bind.color_bonusNum = C_Color(1, 1, 1, alpha)
  self.bind.img_bonusIcon = iconName
  local _, iconColor = C_ColorUtility.TryParseHtmlString(colorStr)
  iconColor.a = 0.8
  self.bind.color_icon = iconColor
  self:onUpdateTextInfo(rateInfo)
  self:onRefreshConent(rateInfo)
end

function module:onUpdateTextInfo(data)
end

function module:onRefreshConent(data)
end

function module:onRefreshEmpty()
end

function module:onEmptyToShow()
end

return module
