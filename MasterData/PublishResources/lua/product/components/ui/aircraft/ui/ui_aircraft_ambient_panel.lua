_class("UIAmbientPanel", UIController)
UIAmbientPanel = UIAmbientPanel

function UIAmbientPanel:OnShow()
  self.module_ = GameGlobal.GetModule(AircraftModule)
  self.bg_ = self:GetUIComponent("RectTransform", "canvasGroup")
  self.bg_.localScale = Vector3(1, 1, 1)
  local bgCanvas = self:GetUIComponent("Canvas", "BGCanvas")
  self.blur_ = self:GetUIComponent("H3DUIBlurHelper", "Blur")
  self.blur_.OwnerCamera = bgCanvas.worldCamera
  self.blur_:RefreshBlurTexture()
  self.qualityText_ = self:GetUIComponent("Text", "TitleText")
  self.slider_ = self:GetUIComponent("Slider", "Slider")
  self:SetSliderValue()
  self.valueText_ = self:GetUIComponent("Text", "ValueText")
  self.extraAddValue_ = self:GetUIComponent("Text", "ExtraAddValue")
  self.centralLevel_ = self:GetUIComponent("Text", "CentralLevel")
  self.ambientTopValue_ = self:GetUIComponent("Text", "AmbientTopValue")
  self:SetOtherValue()
  self.scrollView_ = self:GetUIComponent("UIDynamicScrollView", "FurnitureScrollView")
  self:_InitSrollView()
end

function UIAmbientPanel:OnHide()
end

function UIAmbientPanel:NextOnClick(go)
  self:CloseDialog()
end

function UIAmbientPanel:SetOtherValue()
  local _, percent = self.module_:CalCentralPetWorkSkill()
  local text = 100 * percent .. "%"
  self.extraAddValue_:SetText(text)
  local centralRoom = self.module_:GetCentralRoom()
  local centralLimit = centralRoom:GetAmbientLimit()
  self.ambientTopValue_:SetText(tostring(centralLimit))
  local centralLevel = StringTable.Get("str_aircraft_central_level", centralRoom:Level())
  self.centralLevel_:SetText(centralLevel)
  local curTotalAmbient = self.module_:GetValidAmbient() .. "/" .. centralLimit
  self.valueText_:SetText(tostring(curTotalAmbient))
end

function UIAmbientPanel:SetSliderValue()
  self.qualityCfg_ = Cfg.cfg_aircraft_ambient_quality({})
  local curValue = self.module_:GetValidAmbient()
  local maxValue = self.module_:GetCentralTotalAmbientLimit()
  self.tipColor_ = self:GetUIComponent("Image", "TipColor")
  self.atlas_ = self:GetAsset("UIAircraftDecorate.spriteatlas", LoadType.SpriteAtlas)
  local qualityID = self:GetQualityByValue(curValue)
  if qualityID == 0 then
    return
  end
  local spriteName = self.qualityCfg_[qualityID].PictureName
  local tipSprite = self.atlas_:GetSprite(spriteName)
  local nameStrID = self.qualityCfg_[qualityID].Desc
  local nameStr = StringTable.Get(nameStrID)
  self.qualityText_:SetText(nameStr)
  self.tipColor_.sprite = tipSprite
  local rulerValues = self:GetRulerValues()
  self.rulerValue1 = self:GetUIComponent("Text", "RulerValue1")
  self.rulerValue1:SetText(rulerValues[1])
  self.rulerValue2 = self:GetUIComponent("Text", "RulerValue2")
  self.rulerValue2:SetText(rulerValues[2])
  self.rulerValue3 = self:GetUIComponent("Text", "RulerValue3")
  self.rulerValue3:SetText(rulerValues[3])
  self.rulerValue4 = self:GetUIComponent("Text", "RulerValue4")
  self.rulerValue4:SetText(rulerValues[4])
  self.rulerValue5 = self:GetUIComponent("Text", "RulerValue5")
  self.rulerValue5:SetText(rulerValues[5])
  self.rulerValue6 = self:GetUIComponent("Text", "RulerValue6")
  self.rulerValue6:SetText(rulerValues[6])
  self.rulerValue7 = self:GetUIComponent("Text", "RulerValue7")
  self.rulerValue7:SetText(rulerValues[7])
  self.slider_.value = self:_GetSliderValue(curValue, rulerValues[7])
end

function UIAmbientPanel:GetQualityByValue(value)
  for id, vt in pairs(self.qualityCfg_) do
    if value <= vt.MaxAmbient and value >= vt.MinAmbient then
      return id
    end
  end
  Log.exception("current Ambient Value : ", value, "haven't config")
  return 0
end

function UIAmbientPanel:GetRulerValues()
  local ret = {}
  for id, vt in pairs(self.qualityCfg_) do
    table.insert(ret, vt.MaxAmbient)
  end
  table.sort(ret)
  return ret
end

function UIAmbientPanel:_InitSrollView()
  self.furnitures_ = self.module_:CalAllFurnitureAmbientInfo()
  self.scrollView_:InitListView(self:CalculateRowCount(), function(scrollView, index)
    return self:_InitSpritListInfo(scrollView, index)
  end)
  self._firstIn = false
end

function UIAmbientPanel:CalculateRowCount()
  self.furnitureInfos_ = self.module_:CalAllFurnitureAmbientInfo()
  local furnitureCount = table.count(self.furnitureInfos_)
  return furnitureCount / 2 + 1
end

function UIAmbientPanel:_GetScrollViewParam()
  local param = UIDynamicScrollViewInitParam:New()
  param.mItemDefaultWithPaddingSize = 333
  return param
end

function UIAmbientPanel:_InitSpritListInfo(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  rowPool:SpawnObjects("UIAircraftFurnitureItem", 2)
  local furnitureList = rowPool:GetAllSpawnList()
  for i = 1, 2 do
    local petItem = furnitureList[i]
    local itemIndex = index * 2 + i
    if itemIndex > table.count(self.furnitureInfos_) then
      petItem:GetGameObject():SetActive(false)
    else
      petItem:SetData(self.furnitureInfos_[itemIndex])
    end
  end
  return item
end

function UIAmbientPanel:_GetSliderValue(cur, max)
  if cur < 0 or max < cur then
    Log.exception("风船氛围值异常:", cur, max)
    return 0
  end
  local ambientSpliter = 10000
  local maxPixel = 1260
  local spliter = 1000
  local spliterValue = spliter / maxPixel
  if cur <= 10000 then
    return cur / ambientSpliter * spliterValue
  else
    return (cur - ambientSpliter) / (max - ambientSpliter) * (1 - spliterValue) + spliterValue
  end
end
