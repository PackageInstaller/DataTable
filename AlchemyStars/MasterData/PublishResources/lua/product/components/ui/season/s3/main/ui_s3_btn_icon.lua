_class("UIS3BtnIcon", UICustomWidget)
UIS3BtnIcon = UIS3BtnIcon

function UIS3BtnIcon:SetData(uiName)
  self:_SetImage(uiName)
end

function UIS3BtnIcon:_SetImage(uiName)
  local tb = {
    UIS3MedalBtn = "exp_s2_zjm_di01_icon",
    UIS3QuestBtn = "exp_s2_zjm_di02_icon",
    UIS3ExchangeBtn = "exp_s2_zjm_di03_icon",
    UIS3CollageBtn = "exp_s2_zjm_di04_icon",
    UIS3GoBtn = "exp_s2_zjm_di05_icon"
  }
  local atlasName = "UIS2Main.spriteatlas"
  local spriteName = tb[uiName]
  UIWidgetHelper.SetImageSprite(self, "Icon3", atlasName, spriteName)
end
