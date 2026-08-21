_class("UISeasonTalentTreeInfoLv", UICustomWidget)
UISeasonTalentTreeInfoLv = UISeasonTalentTreeInfoLv

function UISeasonTalentTreeInfoLv:OnShow()
  self._select = self:GetGameObject("Select")
  self._lv = self:GetGameObject("Lv")
  self._lvTex = self:GetUIComponent("UILocalizationText", "LvTex")
  self._descTex = self:GetUIComponent("UILocalizationText", "Desc")
  self._descTex2 = self:GetUIComponent("UILocalizationText", "Desc2")
  self._down = self:GetGameObject("down")
end

function UISeasonTalentTreeInfoLv:SetData(lv, currentLv, desc)
  self._lv:SetActive(lv ~= nil)
  if lv then
    self._lvTex:SetText(StringTable.Get("str_season_talent_tree_skil_info_lv", lv))
    self._select:SetActive(lv <= currentLv)
    self._descTex:SetText(desc)
  else
    self._descTex2:SetText(desc)
  end
  self._descTex2.gameObject:SetActive(lv == nil)
  self._descTex.gameObject:SetActive(lv ~= nil)
  self._down:SetActive(lv ~= nil)
end
