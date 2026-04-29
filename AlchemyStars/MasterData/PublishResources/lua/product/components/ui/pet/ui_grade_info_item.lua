_class("UIGradeInfoItem", Object)
UIGradeInfoItem = UIGradeInfoItem

function UIGradeInfoItem:OnShowItem(uiParams)
  self._name2Assets = {}
  self.key2CustomWidgetPools = {}
  self.type2ComponentTable = {}
  self._petModule = GameGlobal.GetModule(PetModule)
  self._roleModule = GameGlobal.GetModule(RoleModule)
  self._uiPetGradeAtlas = self:GetAsset("UIPetGrade.spriteatlas", LoadType.SpriteAtlas)
  self._atlasAwake = self:GetAsset("UIAwake.spriteatlas", LoadType.SpriteAtlas)
  self.zhuangshiInfo = {
    [0] = {
      chineseTip = "str_pet_config_grade1_decorate_tip_cn",
      engTip = "str_pet_config_grade1_decorate_tip_eng"
    },
    [1] = {
      chineseTip = "str_pet_config_grade1_decorate_tip_cn",
      engTip = "str_pet_config_grade1_decorate_tip_eng"
    },
    [2] = {
      chineseTip = "str_pet_config_grade2_decorate_tip_cn",
      engTip = "str_pet_config_grade2_decorate_tip_eng"
    },
    [3] = {
      chineseTip = "str_pet_config_grade3_decorate_tip_cn",
      engTip = "str_pet_config_grade3_decorate_tip_eng"
    }
  }
  self._varyPool = self:GetUIComponent("UISelectObjectPath", "varyRowItem")
  self._materialPool = self:GetUIComponent("UISelectObjectPath", "RowItem")
  self._gradeLeftImg = self:GetUIComponent("Image", "gradeLeft")
  self._gradeRightImg = self:GetUIComponent("Image", "gradeRight")
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._firstLeft = self:GetUIComponent("Image", "elementLeft")
  self._firstRight = self:GetUIComponent("Image", "elementRight")
  self._sceondLeft = self:GetUIComponent("Image", "secondLeft")
  self._secondRight = self:GetUIComponent("Image", "secondRight")
  self._gradeTexLeft = self:GetUIComponent("UILocalizationText", "leftPetText")
  self._gradeTexRight = self:GetUIComponent("UILocalizationText", "rightPetText")
  self._nameTex = self:GetUIComponent("UILocalizationText", "nameTex")
  self._btn = self:GetGameObject("DetailButton")
  self._uieventListener = UICustomUIEventListener:New()
  self._uieventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self._btn.gameObject), UIEvent.Click, function(go)
    self:DetailButtonOnClick(go)
  end)
end

function UIGradeInfoItem:DetailButtonOnClick(go)
  if not self._click then
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UIGradeSkillPanelController", self._petInfo:GetPstID())
end

function UIGradeInfoItem:StopTween()
  if self._consumItem then
    self._consumItem:StopTween()
  end
end

function UIGradeInfoItem:GetNotEnoughMatList()
end

function UIGradeInfoItem:GradeButtonOnClick()
  if not self._click then
    return false
  end
  local isOk, index = self:CheckIndexMaterialItems()
  if isOk == false then
    local rowList = self._materialPool:GetAllSpawnList()
    local item = rowList[index]
    self._consumItem = item
    item:DOShakePosition()
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundUIMaterialNotEnough)
    return false
  end
  return true
end

function UIGradeInfoItem:CheckIndexMaterialItems()
  if self._materialItemInfos == nil then
    return true, 1
  end
  for index, itemInfo in pairs(self._materialItemInfos) do
    if itemInfo.ConditionType == "Level" then
      local petLevel = self._petInfo:GetPetLevel()
      if petLevel < itemInfo.condition then
        return false, index
      end
    elseif itemInfo.ConditionType == "Coin" then
      local bagNum = self._roleModule:GetGold()
      if bagNum < itemInfo.condition then
        return false, -1
      end
    else
      local bagNum = self._roleModule:GetAssetCount(itemInfo.ID)
      if bagNum < itemInfo.condition then
        return false, index
      end
    end
  end
  return true, 1
end

function UIGradeInfoItem:ShowElementAndTex()
  local cfg_pet_element = Cfg.cfg_pet_element({})
  local f = self._petInfo:GetPetFirstElement()
  self._firstLeft.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[f].Icon))
  self._firstRight.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[f].Icon))
  local sNow = self._petInfo:GetPetSecondElement()
  if sNow == nil or sNow == 0 then
    self._sceondLeft.gameObject:SetActive(false)
  else
    self._sceondLeft.gameObject:SetActive(true)
    self._sceondLeft.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[sNow].Icon))
  end
  local gradeNow = self._petInfo:GetPetGrade()
  local gradeMax = self._petInfo:GetMaxGrade()
  local gradeNext = self._petInfo:GetPetGrade() + 1
  if gradeNow < gradeMax then
    local cfg_pet = Cfg.cfg_pet[self._petInfo:GetTemplateID()]
    if cfg_pet == nil then
      Log.fatal("###cfg_pet is nil ! id --> ", self._petInfo:GetTemplateID())
      return
    end
    local gradeSecondNeed = cfg_pet.Element2NeedGrade
    if gradeNext >= gradeSecondNeed then
      local secondTemp = cfg_pet.SecondElement
      if secondTemp ~= nil and secondTemp ~= 0 then
        self._secondRight.gameObject:SetActive(true)
        self._secondRight.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[cfg_pet.SecondElement].Icon))
      else
        self._secondRight.gameObject:SetActive(false)
      end
    else
      self._secondRight.gameObject:SetActive(false)
    end
  end
  local gradeTexNow = ""
  if gradeNow < gradeMax then
    gradeTexNow = StringTable.Get("str_pet_config_common_advance") .. gradeNow
  else
    gradeTexNow = StringTable.Get("str_pet_config_awake_full")
  end
  self._gradeTexLeft:SetText(gradeTexNow)
  local gradeTexNext = ""
  if gradeMax > gradeNext then
    gradeTexNext = StringTable.Get("str_pet_config_common_advance") .. gradeNext
  else
    gradeTexNext = StringTable.Get("str_pet_config_awake_full")
  end
  self._gradeTexRight:SetText(gradeTexNext)
end

function UIGradeInfoItem:SetLeftIcon()
  local petId = self._petInfo:GetTemplateID()
  local petGradeLevel = self._petInfo:GetPetGrade()
  self._gradeLeftImg.sprite = self._atlasAwake:GetSprite(UIPetModule.GetAwakeSpriteName(petId, petGradeLevel))
  local nextGradeLevel = petGradeLevel + 1
  local maxGrade = self._petInfo:GetMaxGrade()
  if nextGradeLevel > maxGrade then
    nextGradeLevel = maxGrade
  end
  self._gradeRightImg.sprite = self._atlasAwake:GetSprite(UIPetModule.GetAwakeSpriteName(petId, nextGradeLevel))
end

function UIGradeInfoItem:ShowVarySkill()
  local uiModule = self._petModule.uiModule
  self._bodyDiff, self._varyInfo = uiModule:GetDiffWithGrade(self._petInfo, true)
  if self._varyInfo == nil then
    return
  end
  self._varyInfo = uiModule:RemoveNotShowSkill(self._petInfo:GetTemplateID(), self._petInfo:GetPetGrade() + 1, self._petInfo:GetPetAwakening(), self._varyInfo)
  local _itemCountPerRow = table.count(self._varyInfo)
  if _itemCountPerRow <= 0 then
    return
  end
  self._varyPool:SpawnObjects("GradeVaryItem", _itemCountPerRow)
  local rowList = self._varyPool:GetAllSpawnList()
  local tempTab = {}
  local hasWork = false
  for i = 1, #self._varyInfo do
    local item = self._varyInfo[i]
    if item.type == "work" then
      if hasWork == false then
        hasWork = true
        table.insert(tempTab, item)
      end
    else
      table.insert(tempTab, item)
    end
  end
  for itemIndex = 1, _itemCountPerRow do
    local varyItem = rowList[itemIndex]
    varyItem:SetData(tempTab[itemIndex])
  end
end

function UIGradeInfoItem:RefreshItemCount()
  local _itemCountPerRow = table.count(self._materialItemInfos)
  local rowList = self._materialPool:GetAllSpawnList()
  for i = 1, _itemCountPerRow do
    local tMaterialItem = rowList[i]
    tMaterialItem:RefreshItemCount()
  end
end

function UIGradeInfoItem:ShowConsumMaterial()
  if not self._petInfo then
    return
  end
  self._materialItemInfos = self:GetConsumMaterialInfo()
  local _itemCountPerRow = table.count(self._materialItemInfos)
  self._materialPool:SpawnObjects("UIConsumaItem", _itemCountPerRow)
  local rowList = self._materialPool:GetAllSpawnList()
  for itemIndex = 1, _itemCountPerRow do
    local tMaterialItem = rowList[itemIndex]
    tMaterialItem:SetData(self._petInfo, self._materialItemInfos[itemIndex], itemIndex, false, function(itemID, condition, pos)
      self:SetItemTip(itemID, condition, pos)
    end)
  end
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self:GetUIComponent("RectTransform", "RowItem"))
  local sizeFilter = self:GetUIComponent("ContentSizeFitter", "RowItem")
  sizeFilter.enabled = false
  local grid = self:GetUIComponent("GridLayoutGroup", "RowItem")
  grid.enabled = false
end

function UIGradeInfoItem:SetItemTip(itemID, condition, pos)
  GameGlobal.UIStateManager():ShowDialog("UIItemGetPathController", itemID, nil, nil, condition)
end

function UIGradeInfoItem:GetNextGradeInfo()
  local gradeLevel = self._petInfo:GetPetGrade()
  local cfg = Cfg.cfg_pet_grade({
    PetID = self._petInfo:GetTemplateID(),
    Grade = gradeLevel + 1
  })
  return cfg
end

function UIGradeInfoItem:GetConsumMaterialInfo()
  local gradeLevel = self._petInfo:GetPetGrade()
  local cfg = self:GetNextGradeInfo()
  local cfg = Cfg.cfg_pet_grade({
    PetID = self._petInfo:GetTemplateID(),
    Grade = gradeLevel + 1
  })
  local itemInfos = {}
  if cfg then
    local gradeNeedItemList = cfg[1].NeedItem
    local levelCondition = {}
    levelCondition.ConditionType = "Level"
    levelCondition.condition = cfg[1].NeedLevel
    table.insert(itemInfos, levelCondition)
    for key, value in pairs(gradeNeedItemList) do
      local data = string.split(value, ",")
      local itemCondition = {}
      itemCondition.ConditionType = "Consum"
      itemCondition.ID = tonumber(data[1])
      itemCondition.condition = tonumber(data[2])
      if itemCondition.ID == RoleAssetID.RoleAssetGold then
      else
        table.insert(itemInfos, itemCondition)
      end
    end
  end
  return itemInfos
end

function UIGradeInfoItem:OnHide()
end

function UIGradeInfoItem:OnHideCallBack()
end

function UIGradeInfoItem:SetData(index, pet)
  self._petInfo = pet
  self:ShowConsumMaterial()
  self:ShowVarySkill()
  self:ShowTopGradeVaryInfo()
  self:ShowElementAndTex()
  self:SetLeftIcon()
  self:ShowName()
end

function UIGradeInfoItem:RefreshData(index, pet)
  self._petInfo = pet
  self:ShowConsumMaterial()
  self:ShowVarySkill()
  self:ShowTopGradeVaryInfo()
  self:ShowElementAndTex()
  self:SetLeftIcon()
  self:ShowName()
end

function UIGradeInfoItem:ShowName()
  self._nameTex:SetText(StringTable.Get(self._petInfo:GetPetName()))
end

function UIGradeInfoItem:GetCurGradeInfo()
  local gradeLevel = self._petInfo:GetPetGrade()
  local cfg = Cfg.cfg_pet_grade({
    PetID = self._petInfo:GetTemplateID(),
    Grade = gradeLevel
  })
  return cfg
end

function UIGradeInfoItem:ShowTopGradeVaryInfo()
  local petGrade = self._petInfo:GetPetGrade()
  local nextCfg = self:GetNextGradeInfo()
  local curCfg
  local curPetGradeStr = ""
  local nextPetGradeStr = ""
  local curTen = math.floor(petGrade / 10)
  local curBit = petGrade % 10
  curPetGradeStr = curPetGradeStr .. curTen .. curBit
  if petGrade <= 0 then
    local templateID = self._petInfo:GetTemplateID()
    curCfg = Cfg.cfg_pet[templateID]
    if curCfg then
      curPetGradeStr = curPetGradeStr .. StringTable.Get(curCfg.Name)
      self._gradeTexLeft.text = curPetGradeStr
    end
  else
    curCfg = self:GetCurGradeInfo()
    if curCfg then
      curPetGradeStr = curPetGradeStr .. StringTable.Get(curCfg[1].Shape)
      self._gradeTexLeft.text = curPetGradeStr
    end
  end
  if nextCfg then
    local nextTen = math.floor((petGrade + 1) / 10)
    local nextBit = (petGrade + 1) % 10
    nextPetGradeStr = nextPetGradeStr .. nextTen .. nextBit
    nextPetGradeStr = nextPetGradeStr .. StringTable.Get(nextCfg[1].Shape)
    self._gradeTexRight.text = nextPetGradeStr
  end
  self._click = true
  local grade = self._petInfo:GetPetGrade()
  local maxGrade = self._petInfo:GetMaxGrade()
  if grade >= maxGrade then
    self._click = false
  end
  local starLevel = self._petInfo:GetPetStar()
  local openAwakenCfg = Cfg.cfg_global.pet_open_grade
  if starLevel <= openAwakenCfg.IntValue then
    self._click = false
  end
end

function UIGradeInfoItem:GetNeedMatList()
  local itemModule = GameGlobal.GetModule(ItemModule)
  local matList = {}
  for i = 1, #self._materialItemInfos do
    local info = self._materialItemInfos[i]
    local type = info.ConditionType
    if type == "Consum" then
      local id = info.ID
      local needCount = info.condition
      local haveCount = itemModule:GetItemCount(id)
      if needCount > haveCount then
        local gapsCount = needCount - haveCount
        local mat = {}
        mat.id = id
        mat.count = gapsCount
        table.insert(matList, mat)
      end
    end
  end
  if table.count(matList) > 0 then
    return matList
  end
  return nil
end

function UIGradeInfoItem:CanGradeClick()
  local levelOk = false
  local gradeLevel = self._petInfo:GetPetGrade()
  local cfg = Cfg.cfg_pet_grade({
    PetID = self._petInfo:GetTemplateID(),
    Grade = gradeLevel + 1
  })
  if cfg then
    local nowLv = self._petInfo:GetPetLevel()
    local levelCondition = cfg[1].NeedLevel
    if nowLv >= levelCondition then
      levelOk = true
    end
  end
  return self._click and levelOk
end

function UIGradeInfoItem:SetView(view)
  self._view = view
end

function UIGradeInfoItem:GetName()
  return "UIGradeInfoItem"
end

function UIGradeInfoItem:GetUIComponent(componentTypeName, name)
  if componentTypeName == "UISelectObjectPath" then
    local uiCustomWidgetPool = self.key2CustomWidgetPools[name]
    if uiCustomWidgetPool then
      return uiCustomWidgetPool
    end
    local view = self._view
    if view then
      local dynamicInfoOfEngine = view:GetUIComponent(componentTypeName, name)
      if dynamicInfoOfEngine then
        uiCustomWidgetPool = UICustomWidgetPool:New(self, dynamicInfoOfEngine)
        self.key2CustomWidgetPools[name] = uiCustomWidgetPool
        return uiCustomWidgetPool
      end
    end
    Log.fatal("UIController", self:GetName(), " GetUIComponent ->", componentTypeName, " ", name, "<- is Null !")
    return nil
  else
    local name2Component = self.type2ComponentTable[componentTypeName]
    if name2Component then
      local component = name2Component[name]
      if component then
        return component
      end
    end
    local view = self._view
    if view then
      local target = view:GetUIComponent(componentTypeName, name)
      if target then
        if name2Component == nil then
          self.type2ComponentTable[componentTypeName] = {}
          name2Component = self.type2ComponentTable[componentTypeName]
        end
        name2Component[name] = target
        return target
      end
    end
    Log.fatal("UIController", self:GetName(), " GetUIComponent ->", componentTypeName, " ", name, "<- is Null !")
    return nil
  end
end

function UIGradeInfoItem:GetGameObject(name)
  return self._view:GetGameObject(name)
end

function UIGradeInfoItem:GetAsset(name, loadType)
  return UIResourceManager.GetAsset(name, loadType, self._name2Assets)
end

function UIGradeInfoItem:DisposeCustomWidgets()
  local key2CustomWidgetPools = table.shallowcopy(self.key2CustomWidgetPools)
  if key2CustomWidgetPools then
    for k, v in pairs(key2CustomWidgetPools) do
      v:Dispose()
    end
  end
  table.clear(self.key2CustomWidgetPools)
  self.key2CustomWidgetPools = nil
end

function UIGradeInfoItem:Dispose()
  self:DisposeCustomWidgets()
  UIResourceManager.DisposeAllAssets(self._name2Assets)
  self._name2Assets = nil
  self._uieventListener:Dispose()
end

function UIGradeInfoItem:GetGuideItem()
  local rowList = self._materialPool:GetAllSpawnList()
  local guideItem = rowList[2]
  if guideItem then
    return guideItem:GetBtn()
  end
end

function UIGradeInfoItem:ClickGuideItem()
  local rowList = self._materialPool:GetAllSpawnList()
  local guideItem = rowList[3]
  if guideItem then
    guideItem:ClickItemForGuide()
  end
end
