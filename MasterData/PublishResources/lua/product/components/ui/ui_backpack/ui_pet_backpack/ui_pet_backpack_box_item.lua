_class("UIPetBackPackBoxItem", UICustomWidget)
UIPetBackPackBoxItem = UIPetBackPackBoxItem

function UIPetBackPackBoxItem:OnShow(uiParams)
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._selctedGo = self:GetGameObject("Selected")
  self._selctedGo:SetActive(false)
  self._btnGo = self:GetGameObject("Btn")
  self._isInit = false
  self._draging = false
  self._starLoader = self:GetUIComponent("UISelectObjectPath", "stars")
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._uiHeartItemAtlas = self:GetAsset("UIHeartItem.spriteatlas", LoadType.SpriteAtlas)
  self._starSprite = self._uiHeartItemAtlas:GetSprite("items_Prop-interface_xing1")
  self._logoLoader = self:GetUIComponent("RawImageLoader", "logo")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "diLayer")
  self._qualityIcon = self:GetUIComponent("Image", "qualityIcon")
  self._firstGo = self:GetGameObject("first")
  self._secondGo = self:GetGameObject("second")
  self._firstAttIcon = self:GetUIComponent("Image", "firstAttribute")
  self._secondAttribute = self:GetUIComponent("Image", "secondAttribute")
  self._hasGetGo = self:GetGameObject("HasGet")
end

function UIPetBackPackBoxItem:OnHide()
  self._uiHeartItemAtlas = nil
  self.atlasProperty = nil
end

function UIPetBackPackBoxItem:RegisterEvent()
  local etlAddDrag = UICustomUIEventListener.Get(self._btnGo)
  local etlAdd = UILongPressTriggerListener.Get(self._btnGo)
  self:AddUICustomEventListener(etlAdd, UIEvent.LongPress, function(go)
    if not self._draging then
      self:ShowDialog("UIShopPetDetailController", self._itemId)
    end
  end)
  self:AddUICustomEventListener(etlAddDrag, UIEvent.BeginDrag, function(eventData)
    self._draging = true
    if self._scrollRect then
      self._scrollRect:OnBeginDrag(eventData)
    end
  end)
  self:AddUICustomEventListener(etlAddDrag, UIEvent.Drag, function(eventData)
    if self._scrollRect then
      self._scrollRect:OnDrag(eventData)
    end
  end)
  self:AddUICustomEventListener(etlAddDrag, UIEvent.EndDrag, function(eventData)
    self._draging = false
    if self._scrollRect then
      self._scrollRect:OnEndDrag(eventData)
    end
  end)
end

function UIPetBackPackBoxItem:Refresh(petBackPackBox, itemId, scrollRect, previewMode)
  self._draging = false
  self._scrollRect = scrollRect
  self._previewMode = previewMode
  self._petBackPackBox = petBackPackBox
  self._itemId = itemId
  if self._isInit == false then
    self._scrollRect = scrollRect
    self:RegisterEvent()
    self._isInit = true
  end
  self._selctedGo:SetActive(false)
  self:_SetPet()
end

function UIPetBackPackBoxItem:_SetPet()
  local petCfg = Cfg.cfg_pet[self._itemId]
  if not petCfg then
    return
  end
  local petStar = petCfg.Star
  local petBody = HelperProxy:GetInstance():GetPetBody(petCfg.ID, 0, 0, PetSkinEffectPath.CARD_PET_LIST)
  if petBody then
    self._iconLoader:LoadImage(petBody)
  end
  self._logoLoader:LoadImage(petCfg.Logo)
  self._qualityIcon.sprite = self._uiHeartItemAtlas:GetSprite("map_biandui_pin" .. petStar)
  local petModule = GameGlobal.GetModule(PetModule)
  local petData = petModule:GetPetByTemplateId(self._itemId)
  local awakenStep = 0
  if petData then
    awakenStep = petData:GetPetAwakening()
  end
  self._starSp1 = self._uiHeartItemAtlas:GetSprite("spirit_xing3_frame")
  self._starSp2 = self._uiHeartItemAtlas:GetSprite("spirit_xing2_frame")
  local allStar = 6
  self._starLoader:SpawnObjects("UIPetBackpackStarItem", petStar)
  local stars = self._starLoader:GetAllSpawnList()
  local awakenStartIndex = petStar - awakenStep
  for i = 1, petStar do
    if i > awakenStartIndex then
      stars[i]:SetData(true)
    else
      stars[i]:SetData(false)
    end
  end
  local cfg_pet_element = Cfg.cfg_pet_element({})
  local firstElementIcon = UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[petCfg.FirstElement].Icon)
  self._firstAttIcon.sprite = self.atlasProperty:GetSprite(firstElementIcon)
  local secondElement
  if 0 >= petCfg.Element2NeedGrade then
    secondElement = petCfg.SecondElement
  end
  if secondElement and 0 < secondElement then
    self._secondGo:SetActive(true)
    local secondElementIcon = UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[petCfg.SecondElement].Icon)
    self._secondAttribute.sprite = self.atlasProperty:GetSprite(secondElementIcon)
  else
    self._secondGo:SetActive(false)
  end
  local petName = ""
  if petCfg then
    petName = StringTable.Get(petCfg.Name)
  end
  self._nameLabel:SetText(petName)
  local petModule = GameGlobal.GameLogic():GetModule(PetModule)
  self._hasGetGo:SetActive(petModule:HasPet(petCfg.ID))
end

function UIPetBackPackBoxItem:RefreshSelectStatus(status)
  self._selctedGo:SetActive(status)
end

function UIPetBackPackBoxItem:GetItemId()
  return self._itemId
end

function UIPetBackPackBoxItem:BtnOnClick()
  if self._previewMode then
    self:ShowDialog("UIShopPetDetailController", self._itemId)
  else
    self._petBackPackBox:SelectPetItem(self)
  end
end
