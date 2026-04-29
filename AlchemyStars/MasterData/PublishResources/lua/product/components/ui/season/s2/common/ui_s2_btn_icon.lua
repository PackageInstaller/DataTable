_class("UIS2BtnIcon", UICustomWidget)
UIS2BtnIcon = UIS2BtnIcon

function UIS2BtnIcon:SetData(uiName)
  self:_SetImage(uiName)
end

function UIS2BtnIcon:_SetImage(uiName)
  local tb = {
    UIS2MedalBtn = "exp_s2_zjm_di01_icon",
    UIS2QuestBtn = "exp_s2_zjm_di02_icon",
    UIS2ExchangeBtn = "exp_s2_zjm_di03_icon",
    UIS2CollageBtn = "exp_s2_zjm_di04_icon",
    UIS2GoBtn = "exp_s2_zjm_di05_icon"
  }
  local atlasName = "UIS2Main.spriteatlas"
  local spriteName = tb[uiName]
  UIWidgetHelper.SetImageSprite(self, "Icon3", atlasName, spriteName)
end
