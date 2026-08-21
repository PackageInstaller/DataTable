_class("UICollectCardInfoItem", UICustomWidget)
UICollectCardInfoItem = UICollectCardInfoItem

function UICollectCardInfoItem:OnShow(uiParam)
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._gray = self:GetGameObject("Gray")
  self._nameTex = self:GetUIComponent("UILocalizationText", "NameTex")
  self._number = self:GetUIComponent("UILocalizationText", "Number")
  self._specialBg = self:GetGameObject("SpecialBg")
  self._normalBg = self:GetGameObject("NormalBg")
  self._selectGo = self:GetGameObject("SelectGo")
end

function UICollectCardInfoItem:SetData(cardid, callback, count)
  self._cardid = cardid
  self._callback = callback
  self._cfg = Cfg.cfg_component_collect_card[self._cardid]
  local icon = self._cfg.Icon
  self._icon:LoadImage(icon)
  self._gray:SetActive(count == 0)
  self._number:SetText(count)
  local cfgName = self._cfg.Name
  self._nameTex:SetText(StringTable.Get(cfgName))
  self._specialBg:SetActive(self._cfg.Type == 2)
  self._normalBg:SetActive(self._cfg.Type == 1)
end

function UICollectCardInfoItem:Select(selectid)
  self._selectGo:SetActive(selectid == self._cardid)
end

function UICollectCardInfoItem:IconOnClick(go)
  if self._callback then
    self._callback(self._cardid)
  end
end
