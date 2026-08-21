_class("UIAircraftDecorateItem", UICustomWidget)
UIAircraftDecorateItem = UIAircraftDecorateItem

function UIAircraftDecorateItem:OnShow(uiParams)
  self._aircraftModule = GameGlobal.GameLogic():GetModule(AircraftModule)
  self._atlas = self:GetAsset("UIAircraftDecorate.spriteatlas", LoadType.SpriteAtlas)
  self:AttachEvent(GameEventType.UIAircraftDecorateSelectItem, self._OnUIAircraftDecorateSelectItem)
  self:AttachEvent(GameEventType.UIAircraftDecoratePutFurniture, self._OnUIAircraftDecoratePutFurniture)
end

function UIAircraftDecorateItem:SetData(index, item, getCallback)
  self:_GetComponents()
  self._item = item
  self._itemID = self._item:GetTemplateID()
  self._cfg_item = Cfg.cfg_item[self._itemID]
  self._cfg_item_furniture = Cfg.cfg_item_furniture[self._itemID]
  self._index = index
  self._getCallback = getCallback
  self:_OnRefresh()
end

function UIAircraftDecorateItem:_GetComponents()
  self._rectTransform = self:GetUIComponent("RectTransform", "Root")
  self._selectObj = self:GetGameObject("Select")
  self._alreadyObj = self:GetGameObject("Already")
  self._newObj = self:GetGameObject("New")
  self._rawImageLoader = self:GetUIComponent("RawImageLoader", "RawImage")
  self._rawImage = self:GetUIComponent("RawImage", "RawImage")
  self._rawImageObj = self:GetGameObject("RawImage")
  self._txtCount = self:GetUIComponent("UILocalizationText", "TextCount")
  self._textAtmosphere = self:GetUIComponent("UILocalizationText", "TextAtmosphere")
  self._txtName = self:GetUIComponent("RollingText", "TextName")
  self._bg = self:GetUIComponent("Image", "BG")
  self._bgAtmosphere = self:GetUIComponent("Image", "BGAtmosphere")
  self._bgAlready = self:GetUIComponent("Image", "BGAlready")
end

function UIAircraftDecorateItem:_OnRefresh()
  self._rawImageLoader:LoadImage(self._cfg_item.Icon)
  self._txtName:RefreshText(StringTable.Get(self._cfg_item.Name))
  local atmosphere = self._cfg_item_furniture.Atmosphere
  local lfAv, lfMv = self._aircraftModule:CalCentralPetWorkSkill()
  local newAtmosphere = atmosphere + math.floor(atmosphere * lfMv) + math.floor(lfAv)
  self._textAtmosphere:SetText(newAtmosphere)
  local useNum = self._aircraftModule:GetUseFurnitureItemNumByItemID(self._itemID)
  local remainsNum = self._aircraftModule:GetRemainsFurnitureItemNumByItemID(self._itemID)
  self._txtCount:SetText(remainsNum)
  self._newObj:SetActive(self._item:IsNewFurniture())
  self._alreadyObj:SetActive(false)
  local useGray = false
  if useNum == 0 then
    self._bg.sprite = self._atlas:GetSprite("home_jiaju_kuang11")
  elseif remainsNum == 0 then
    self._bg.sprite = self._atlas:GetSprite("home_jiaju_kuang13")
    if not self._EMIMatResRequest then
      self._EMIMatResRequest = ResourceManager:GetInstance():SyncLoadAsset("ui_image_gray.mat", LoadType.Mat)
      self._EMIMat = self._EMIMatResRequest.Obj
    end
    useGray = true
  else
    self._bg.sprite = self._atlas:GetSprite("home_jiaju_kuang12")
  end
  if useGray then
    self._bgAlready.material = self._EMIMat
    self._bgAtmosphere.material = self._EMIMat
    self._rawImage.material:SetFloat("_LuminosityAmount", 1)
  else
    self._bgAlready.material = nil
    self._bgAtmosphere.material = nil
    self._rawImage.material:SetFloat("_LuminosityAmount", 0)
  end
  self._rawImageObj:SetActive(false)
  self._rawImageObj:SetActive(true)
  self._selectObj:SetActive(false)
end

function UIAircraftDecorateItem:_OnUIAircraftDecorateSelectItem(item)
  self._selectObj:SetActive(self._itemID == item:GetTemplateID())
end

function UIAircraftDecorateItem:_OnUIAircraftDecoratePutFurniture(itemID)
end

function UIAircraftDecorateItem:BGOnClick()
  self._newObj:SetActive(false)
  if self._getCallback then
    self._getCallback(self._item)
  end
end

function UIAircraftDecorateItem:GetBG()
  return self:GetGameObject("BG")
end
