_class("UILuckLandSingleSelectCardItem", UICustomWidget)
UILuckLandSingleSelectCardItem = UILuckLandSingleSelectCardItem

function UILuckLandSingleSelectCardItem:OnShow(uiParams)
  self:InitWidget()
end

function UILuckLandSingleSelectCardItem:InitWidget()
  self.singleCard = self:GetUIComponent("UISelectObjectPath", "SingleCard")
  self.skillTipsText = self:GetUIComponent("UILocalizationText", "SkillTipsText")
  self.characterNameText = self:GetUIComponent("UILocalizationText", "CharacterNameText")
  self.star = self:GetUIComponent("UISelectObjectPath", "Star")
  self.selectTag = self:GetUIComponent("Image", "SelectTag")
  self.toggleArea = self:GetUIComponent("Image", "ToggleArea")
  self.selectTagBG = self:GetUIComponent("Image", "SelectTagBG")
  self.SelectTagBGObj = self:GetGameObject("SelectTagBG")
  self.selectTagObj = self:GetGameObject("SelectTag")
  self._anim = self:GetUIComponent("Animation", "UILuckLandSingleSelectCardItem")
  self.toggle = self:GetUIComponent("Toggle", "UILuckLandSingleSelectCardItem")
  
  function self.OntoggleValueChanged(isOn)
    if isOn then
      self.toggleCallBack(self.index)
      self.selectTagObj:SetActive(true)
      self._anim:Play("uieff_UILuckLandSingleSelectCardItem_click")
    else
      self._anim:Stop()
      self.SelectTagBGObj:SetActive(true)
      self.selectTagBG.color = Color(1, 1, 1, 1)
    end
  end
  
  self.toggle.onValueChanged:AddListener(self.OntoggleValueChanged)
end

function UILuckLandSingleSelectCardItem:SetData(cardData, index, toggleGroup, toggleCallBack)
  self.cardData = cardData
  self.index = index
  self.toggleCallBack = toggleCallBack
  self.toggle.group = toggleGroup
  if self.index == 1 then
  end
  self.toggle.isOn = false
  self:InitUI()
  self.selectTagObj:SetActive(false)
  self.selectTagBG.color = Color(1, 1, 1, 1)
end

function UILuckLandSingleSelectCardItem:InitUI()
  local getCardCount = 1
  self.characterNameText:SetText(StringTable.Get(self.cardData:Cfg().CardName))
  self.skillTipsText:SetText(StringTable.Get(self.cardData:Cfg().CardTips))
  local cardStarCount = self.cardData:Cfg().CardStar
  self.CardAreaList = UIWidgetHelper.SpawnObjects(self, "Star", "UILuckLandStarItem", cardStarCount)
  for i = 1, #self.CardAreaList do
  end
  self.CardAreaList = UIWidgetHelper.SpawnObjects(self, "SingleCard", "UILuckLandSingleCard", 1)
  for i = 1, #self.CardAreaList do
    local item = self.CardAreaList[i]
    item:SetData(self.cardData)
  end
end

function UILuckLandSingleSelectCardItem:CardData()
  return self.cardData
end
