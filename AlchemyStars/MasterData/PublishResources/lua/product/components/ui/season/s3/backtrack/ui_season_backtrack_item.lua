_class("UISeasonBackTrackItem", UICustomWidget)
UISeasonBackTrackItem = UISeasonBackTrackItem

function UISeasonBackTrackItem:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonBackTrackItem:InitWidget()
  self._bg = self:GetUIComponent("Image", "Bg")
  self._head = self:GetUIComponent("Image", "Head")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._name1 = self:GetUIComponent("UILocalizationText", "Name1")
  self._signGO = self:GetGameObject("Sign")
  self._cursorGO = self:GetGameObject("Cursor")
  self._animation = self:GetUIComponent("Animation", "Animation")
  self._enterAnimation = self:GetUIComponent("Animation", "enterAnimation")
  self._roogGo = self:GetGameObject("rootGo")
  self._roogGo:SetActive(false)
end

function UISeasonBackTrackItem:SetData(seasonID, atlas, index, cfg, callBack, signFunc)
  self._atlas = atlas
  self._index = index
  self._cfg = cfg
  self._callBack = callBack
  self._head.sprite = self._atlas:GetSprite(self._cfg.Head)
  self._name.text = StringTable.Get(self._cfg.Name)
  self._name1.text = StringTable.Get(self._cfg.Name)
  self._signGO:SetActive(signFunc(self._cfg.ID))
  self._cursorGO:SetActive(seasonID == self._cfg.ID)
end

function UISeasonBackTrackItem:PlayEngerAni()
  self._roogGo:SetActive(true)
  self._enterAnimation:Play("uianim_UISeasonBackTrackItem_in")
end

function UISeasonBackTrackItem:BgOnClick(go)
  self._callBack(self._index)
end

function UISeasonBackTrackItem:OnSelect(selected)
  self._animation:Stop()
  if selected then
    self._animation:Play("uieff_UISeasonBackTrackItem_select")
  else
    self._animation:Play("uieff_UISeasonBackTrackItem_unselect")
  end
end
