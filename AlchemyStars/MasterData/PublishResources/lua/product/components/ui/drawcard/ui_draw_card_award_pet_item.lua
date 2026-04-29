_class("UIDrawCardAwardPetItem", UICustomWidget)
UIDrawCardAwardPetItem = UIDrawCardAwardPetItem

function UIDrawCardAwardPetItem:OnShow()
  self.petIcon = self:GetUIComponent("RawImageLoader", "peticon")
  self.diLayer = self:GetUIComponent("RectTransform", "diLayer")
  self._atlas = self:GetAsset("UIDrawCard.spriteatlas", LoadType.SpriteAtlas)
  self._logo = self:GetUIComponent("RawImageLoader", "logo")
  self.firstImage = self:GetUIComponent("Image", "first")
  self.first = self:GetGameObject("first")
  self.secondImage = self:GetUIComponent("Image", "second")
  self.second = self:GetGameObject("second")
  self.secondAttribute = self:GetUIComponent("Image", "secondAttribute")
  self.firstAttribute = self:GetUIComponent("Image", "firstAttribute")
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self.name = self:GetUIComponent("UILocalizationText", "name")
  self.rate = self:GetGameObject("rateText")
  self._bg2 = self:GetGameObject("bg2")
  self.rateText = self:GetUIComponent("UILocalizationText", "rateText")
  self._star6 = self:GetGameObject("star6")
  self._star5 = self:GetGameObject("star5")
  self._star4 = self:GetGameObject("star4")
  self._stars2 = self:GetGameObject("stars2")
  self._stars3 = self:GetGameObject("stars3")
  self._qualityIcon = self:GetUIComponent("Image", "qualityIcon")
  self._uiRoot = self:GetUIComponent("RectTransform", "root")
  self._animRoot = self:GetUIComponent("RectTransform", "animRoot")
  self._uiHeartItemAtlas = self:GetAsset("UIHeartItem.spriteatlas", LoadType.SpriteAtlas)
  local lstStars2 = {
    self:GetChildComponent(self._stars2, "RectTransform", "star1"),
    self:GetChildComponent(self._stars2, "RectTransform", "star2"),
    self:GetChildComponent(self._stars2, "RectTransform", "star3"),
    self:GetChildComponent(self._stars2, "RectTransform", "star4"),
    self:GetChildComponent(self._stars2, "RectTransform", "star5"),
    self:GetChildComponent(self._stars2, "RectTransform", "star6")
  }
  self._stars2 = lstStars2
  local lstStars3 = {
    self:GetChildComponent(self._stars3, "RectTransform", "star1"),
    self:GetChildComponent(self._stars3, "RectTransform", "star2"),
    self:GetChildComponent(self._stars3, "RectTransform", "star3"),
    self:GetChildComponent(self._stars3, "RectTransform", "star4"),
    self:GetChildComponent(self._stars3, "RectTransform", "star5"),
    self:GetChildComponent(self._stars3, "RectTransform", "star6")
  }
  self._stars3 = lstStars3
end

function UIDrawCardAwardPetItem:OnHide()
end

function UIDrawCardAwardPetItem:SetData(stars, content, rate)
  if stars == 5 then
    self._star6:SetActive(false)
  elseif stars == 4 then
    self._star6:SetActive(false)
    self._star5:SetActive(false)
  elseif stars == 3 then
    self._star6:SetActive(false)
    self._star5:SetActive(false)
    self._star4:SetActive(false)
  end
  self._qualityIcon.sprite = self._uiHeartItemAtlas:GetSprite("map_biandui_pin" .. stars)
  if content then
    if rate then
      self.rate:SetActive(true)
      self.rateText:SetText(StringTable.Get("str_draw_card_award_pet_rate", rate))
    else
      self.rate:SetActive(false)
      self._bg2:SetActive(false)
    end
    local petid = content
    self.petCfg = Cfg.cfg_pet[petid]
    if not self.petCfg then
      Log.exception("找不到cfg_pet中光灵" .. petid .. "的数据")
    end
    local skinid = self.petCfg.SkinId
    self.petskinCfg = Cfg.cfg_pet_skin[skinid]
    if not self.petskinCfg then
      Log.exception("cfg_pet_skin 中缺少配置:", skinid)
    end
    local skin = self.petskinCfg.Body
    self.petIcon:LoadImage(skin)
    self._logo:LoadImage(self.petCfg.Logo)
    local cfg_element = Cfg.cfg_pet_element[self.petCfg.FirstElement]
    local cfg_second = Cfg.cfg_pet_element[self.petCfg.SecondElement]
    self.firstAttribute.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_element.Icon))
    if cfg_second then
      self.second:SetActive(true)
      self.secondAttribute.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_second.Icon))
    else
      self.second:SetActive(false)
    end
    local name = StringTable.Get(self.petCfg.Name)
    self.name:SetText(name)
  end
  self:ShowPetAwakening(false)
end

function UIDrawCardAwardPetItem:EventCallBack(getScrollView, clickCB, longPressCB)
  self._fnClickCB = clickCB
  self._fnLongPressCB = longPressCB
  if self._fnLongPressCB ~= nil then
    local scrollRect = getScrollView()
    local eventCustom = UICustomUIEventListener.Get(self.diLayer.gameObject)
    local eventLongPress = UILongPressTriggerListener.Get(self.diLayer.gameObject)
    self:AddUICustomEventListener(eventCustom, UIEvent.ApplicationFocus, function(b)
      if not b then
        eventCustom.IsDragging = false
      end
    end)
    self:AddUICustomEventListener(eventLongPress, UIEvent.LongPress, function(go)
      if not self._draging then
        self._fnLongPressCB(go)
      end
    end)
    self:AddUICustomEventListener(eventCustom, UIEvent.BeginDrag, function(eventData)
      self._draging = true
      scrollRect:OnBeginDrag(eventData)
    end)
    self:AddUICustomEventListener(eventCustom, UIEvent.Drag, function(eventData)
      scrollRect:OnDrag(eventData)
    end)
    self:AddUICustomEventListener(eventCustom, UIEvent.EndDrag, function(eventData)
      self._draging = false
      scrollRect:OnEndDrag(eventData)
    end)
  end
end

function UIDrawCardAwardPetItem:ShowPetAwakening(inShow)
  local awakenStep = 0
  local awakenLock = 0
  if inShow then
    local petModule = self:GetModule(PetModule)
    local petData = petModule:GetPetByTemplateId(self.petCfg.ID)
    if petData ~= nil then
      awakenStep = petData:GetPetAwakening()
      awakenLock = petData:GetAwakeMatch()
    end
  else
    awakenStep = 0
  end
  for k, v in pairs(self._stars2) do
    v.gameObject:SetActive(k <= awakenLock)
    if k > awakenLock then
      if k <= awakenStep then
        self._stars3[k].gameObject:SetActive(true)
      else
        self._stars3[k].gameObject:SetActive(false)
      end
    else
      self._stars3[k].gameObject:SetActive(false)
    end
  end
end

function UIDrawCardAwardPetItem:RootLocalScale(localScale)
  self._uiRoot.localScale = localScale
end

function UIDrawCardAwardPetItem:AnimRootPosition(anchoredPosition)
  self._animRoot.anchoredPosition = anchoredPosition
end

function UIDrawCardAwardPetItem:DiLayerOnClick(go)
  if self._fnClickCB ~= nil then
    self._fnClickCB(go)
  end
end
