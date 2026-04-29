_class("UIAircraftEvilShowItem", UICustomWidget)
UIAircraftEvilShowItem = UIAircraftEvilShowItem

function UIAircraftEvilShowItem:OnShow(uiParams)
  self:InitWidget()
end

function UIAircraftEvilShowItem:InitWidget()
  self.textEvilName = self:GetUIComponent("UILocalizationText", "TextEvilName")
  self.textStar = self:GetUIComponent("UILocalizationText", "TextStar")
  self.textProperty = self:GetUIComponent("UILocalizationText", "TextProperty")
  self.indexItem = self:GetGameObject("IndexItem")
  self.outputMatsGo = self:GetGameObject("OutputMatsGo")
  self.indexLayoutTr = self:GetUIComponent("Transform", "IndexLayoutTr")
  self.textEvilAmount = self:GetUIComponent("UILocalizationText", "TextEvilAmount")
  self.buttonLast = self:GetGameObject("ButtonLast")
  self.buttonNext = self:GetGameObject("ButtonNext")
end

function UIAircraftEvilShowItem:SetData(_evils)
  self.currentIdx = 1
  self.evilCount = #_evils
  self.indexImages = {}
  for i = 1, self.evilCount do
    local idx = UnityEngine.GameObject.Instantiate(self.indexItem, self.indexLayoutTr)
    table.insert(self.indexImages, idx:GetComponent("Image"))
  end
  self.indexItem:SetActive(false)
  self:OnSelectChanged(1)
end

function UIAircraftEvilShowItem:OnSelectChanged(_idx)
  self.indexImages[self.currentIdx]:CrossFadeColor(Color(1, 1, 1), 0, true, false)
  self.indexImages[_idx]:CrossFadeColor(Color(0.6, 0.6, 0.6), 0, true, false)
  self.currentIdx = _idx
  self.buttonLast:SetActive(self.currentIdx > 1)
  self.buttonNext:SetActive(self.currentIdx < self.evilCount)
  self.textEvilAmount.text = self.currentIdx .. "/" .. self.evilCount
end

function UIAircraftEvilShowItem:ButtonLastOnClick(go)
  if self.currentIdx <= 1 then
    self.currentIdx = 1
    return
  end
  self:OnSelectChanged(self.currentIdx - 1)
end

function UIAircraftEvilShowItem:ButtonNextOnClick(go)
  if self.currentIdx >= self.evilCount then
    self.currentIdx = self.evilCount
    return
  end
  self:OnSelectChanged(self.currentIdx + 1)
end
