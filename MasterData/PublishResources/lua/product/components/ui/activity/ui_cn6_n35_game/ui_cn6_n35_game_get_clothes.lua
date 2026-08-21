_class("UI_CN6_N35_GameGetClothes", UIController)
UI_CN6_N35_GameGetClothes = UI_CN6_N35_GameGetClothes

function UI_CN6_N35_GameGetClothes:OnShow(uiParams)
  self:GetComponents()
  self._rewards = uiParams[1]
  self._len = #self._rewards
  Log.debug("###[UI_CN6_N35_GameGetClothes] rewards len : ", self._len)
  self._showIdx = 1
  self:ShowAward()
end

function UI_CN6_N35_GameGetClothes:GetComponents()
  self._nameTex = self:GetUIComponent("UILocalizationText", "nameTex")
  self._descTex = self:GetUIComponent("UILocalizationText", "descTex")
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
end

function UI_CN6_N35_GameGetClothes:ShowAward()
  local award = self._rewards[self._showIdx]
  local itemid = award.assetid
  local cfg = Cfg.cfg_item[itemid]
  local icon = cfg.Icon
  self._icon:LoadImage(icon)
  local name = cfg.Name
  local desc = cfg.Intro
  self._nameTex:SetText(StringTable.Get(name))
  self._descTex:SetText(StringTable.Get(desc))
  self:PlayAnim(true)
end

function UI_CN6_N35_GameGetClothes:PlayAnim(show)
end

function UI_CN6_N35_GameGetClothes:BgOnClick(go)
  if self._showIdx == self._len then
    self:CloseDialog()
  else
    self._showIdx = self._showIdx + 1
    self:PlayAnim(false)
    self:ShowAward()
  end
end

function UI_CN6_N35_GameGetClothes:CloseBtnOnClick(go)
  self:BgOnClick(go)
end
