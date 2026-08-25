local AwakerPage = CommonDefine.AwakerPage
local AwakerTrinketListComp, Super = System.NewClass("AwakerTrinketListComp")

function AwakerTrinketListComp:ctor(ui, model, trinketModel)
  Super.ctor(self)
  self.ui = ui
  self.model = model
  self.trinketModel = trinketModel
end

local StateTable = {"Normal", "Select"}

function AwakerTrinketListComp:OnBind(binder)
  self.boundLightComps = {}
  binder:BindToRaw(function(_, n, o)
    if o == AwakerPage.TrinketChange and n ~= AwakerPage.TrinketChange then
      self.trinketModel:SetSortOrder(CommonDefine.SortOrder.Descend)
      self.trinketModel:SetSortType(CommonDefine.AwakerTrinketSortType.CompletionRate)
      self.trinketModel:ResetFilters()
    end
  end, function()
    return self.model.page
  end)
  self:BindTipMask(binder)
  self:BindSortType(binder)
  self:BindFilterComp(binder)
  self:BindStateTable(binder)
  self:BindTrinketParts(binder)
  self:BindTrinketList(binder)
  self:BindTrinketSuitGatherAll(binder)
  self:BindTrinketSuitComponents(binder)
end

function AwakerTrinketListComp:BindSortType(binder)
  binder:BindToZ1Toggle(self.ui.Btn_Sort, nil, function(isOn)
    if isOn then
      self.trinketModel:SetSortOrder(CommonDefine.SortOrder.Descend)
    else
      self.trinketModel:SetSortOrder(CommonDefine.SortOrder.Ascend)
    end
  end, function()
    return self.trinketModel.sortOrder == CommonDefine.SortOrder.Descend
  end)
  binder:BindToZ1Toggle(self.ui.Btn_Level, nil, function(isOn)
    self.trinketModel:SetSortTypeShow(isOn)
    if isOn then
      binder:SetActive(self.ui.Group_Sort_List, true)
    end
  end, function()
    return self.trinketModel.sortTypeShow
  end)
  binder:BindToAnimator(self.ui.Group_Sort_List, function(_, animator, show)
    AnimatorUtils.SetStateEndInBehavior(animator, "Close", function()
      binder:SetActive(self.ui.Group_Sort_List, false)
    end)
    local name = show and "Open" or "Close"
    if "Open" == name then
      return
    end
    local state = string.format("Base Layer.%s", name)
    AnimatorUtils.PlayState(animator, state)
  end, nil, function()
    return self.trinketModel.sortTypeShow
  end)
  binder:BindToCircularListView(self.ui.ScrollView_Sort_List, function()
    return self.trinketModel.sortTypeList
  end, function(childBinder, obj, index)
    local sortTypeInfo = self.trinketModel.sortTypeList[index]
    local sortTypeName = sortTypeInfo.name
    
    local function IsSelected()
      return self.trinketModel.sortType == index
    end
    
    local function OnClick(sortType)
      if not sortType then
        return
      end
      self.trinketModel:SetSortType(sortType)
      self.trinketModel:SetSortTypeShow(false)
    end
    
    local itemData = {
      tid = index,
      name = sortTypeName,
      selectedFunc = IsSelected,
      callback = OnClick
    }
    childBinder:BindComponent(CommonFilterListItem(obj, itemData))
  end)
end

function AwakerTrinketListComp:BindFilterComp(binder)
  binder:BindZ1Button(self.ui.Btn_Suit, function()
    self.trinketModel:SetFilterShow(true)
    AwakerTrinketDataUtils.ToggleTrinkFilterPanel(true, self.trinketModel, self.ui.TrinketFilterPos.transform.position, function(isChanged)
      if isChanged then
        self.trinketModel:SetLastEquipUid(0)
        self.trinketModel:SetDefaultChosenTrinket()
      end
    end)
  end, function()
    if self.trinketModel.trinketFilterHaved then
      return CommonDefine.BtnType.High
    end
    return CommonDefine.BtnType.Normal
  end)
end

function AwakerTrinketListComp:BindTipMask(binder)
  binder:BindToVisible(self.ui.Btn_Mask_Tip, function()
    return self.trinketModel.sortTypeShow
  end)
  binder:BindButtonClick(self.ui.Btn_Mask_Tip, function()
    if self.trinketModel.filterShow then
      self.trinketModel:SetFilterShow(false)
      AwakerTrinketDataUtils.ToggleTrinkFilterPanel(false, nil, nil, function(isChanged)
        if isChanged then
          self.trinketModel:SetLastEquipUid(0)
          self.trinketModel:SetDefaultChosenTrinket()
        end
      end)
    end
    if self.trinketModel.sortTypeShow then
      self.trinketModel:SetSortTypeShow(false)
    end
  end)
  binder:BindToVisible(self.ui.TrinketFilterMask, function()
    return self.trinketModel.filterShow
  end)
  binder:BindButtonClick(self.ui.TrinketFilterMask, function()
    if self.trinketModel.filterShow then
      self.trinketModel:SetFilterShow(false)
      AwakerTrinketDataUtils.ToggleTrinkFilterPanel(false, nil, nil, function(isChanged)
        if isChanged then
          self.trinketModel:SetLastEquipUid(0)
          self.trinketModel:SetDefaultChosenTrinket()
        end
      end)
    end
  end)
end

function AwakerTrinketListComp:BindStateTable(binder)
  for _, stateName in pairs(StateTable) do
    local TextSuitObj = self.ui["Text_Suit_" .. stateName]
    if TextSuitObj then
      binder:BindToText(TextSuitObj, function()
        local filterSuitId = self.trinketModel.filter
        local suitName = self.trinketModel:GetSuitName(filterSuitId)
        return suitName
      end)
    end
    local TextSortObj = self.ui["Text_Level_" .. stateName]
    if TextSortObj then
      binder:BindToText(TextSortObj, function()
        local sortType = self.trinketModel.sortType
        local sortTypeName = self.trinketModel:GetSortTypeName(sortType)
        return sortTypeName
      end)
    end
  end
end

function AwakerTrinketListComp:BindTrinketParts(binder)
  for i = 1, CommonDefine.MaxEquipTrinketsNum do
    local obj = self.ui["Btn_" .. i]
    if obj then
      binder:BindToZ1Toggle(obj, nil, function(isOn)
        if isOn then
          self.trinketModel:SetSelectPos(i)
          self.trinketModel:SetDefaultChosenTrinket()
        end
      end, function()
        return self.trinketModel.selectPos == i
      end)
    end
    local txtNormal = self.ui["Text_C_Normal_" .. i]
    local txtSelect = self.ui["Text_C_Select_" .. i]
    if txtNormal then
      binder:SetText(txtNormal, StrUtils.RomeNumer[i])
    end
    if txtSelect then
      binder:SetText(txtSelect, StrUtils.RomeNumer[i])
    end
  end
end

function AwakerTrinketListComp:BindTrinketList(binder)
  binder:BindToVisible(self.ui.Text_C_None, function()
    return #self.trinketModel.trinketShowList <= 0
  end)
  local commonIconItemModel = binder:createModel(CommonIconItemModel)
  binder:BindToCircularListView(self.ui.ScrollView_Trinket_List, function()
    local list = self.trinketModel.trinketShowList
    if not list or 0 == #list then
      return {}
    end
    return list
  end, function(childBinder, obj, index)
    local trinketUid = self.trinketModel.trinketShowList[index]
    local data = self.trinketModel:GetTrinketDataByUid(trinketUid)
    
    local function OnClick(tid, uid)
      if not tid or not uid then
        return
      end
      self.trinketModel:SetSelectTrinketUid(uid)
      self.trinketModel:ReqRemoveNew(uid)
    end
    
    local function IsSelected()
      return trinketUid == self.trinketModel.selectTrinketUid
    end
    
    local function mockOwnerCheck()
      local awaker = commonIconItemModel:GetItemOwner(data.uid)
      if awaker and 0 ~= awaker then
        local changeFormAwaker = AwakerDataUtils.GetChangerForm(awaker)
        if awaker == self.model.selectAwakerId or changeFormAwaker == self.model.selectAwakerId then
          return self.model.selectAwakerId
        end
      end
      return nil
    end
    
    local itemData = {
      tid = data.tid,
      uid = data.uid,
      model = commonIconItemModel,
      callback = OnClick,
      clickFrameShowFunc = IsSelected,
      mockOwner = mockOwnerCheck
    }
    childBinder:BindComponent(CommonIconItem(obj, itemData))
  end)
end

function AwakerTrinketListComp:BindTrinketSuitComponents(binder)
  for i = 1, CommonDefine.MaxEquipTrinketsNum do
    local btnObj = self.ui["Btn_Parts_" .. i]
    if btnObj then
      binder:BindButtonClick(btnObj, function()
        local page = self.model.page
        if page ~= AwakerPage.TrinketChange then
          return
        end
        self.trinketModel:SetSelectPos(i)
        self.trinketModel:SetDefaultChosenTrinket()
        AudioManager.Instance:PostSoundEvent("UI_AWAKER_COVENANT_ITEM_CLICK")
      end)
    end
  end
  for i = 1, CommonDefine.MaxEquipTrinketsNum do
    local imageObj = self.ui["Image_Parts_" .. i]
    if imageObj then
      binder:BindToImage(imageObj, function()
        local trinkets = self.trinketModel.trinkets
        local trinket = trinkets[i]
        if not trinket then
          return
        end
        local iconPath = self.trinketModel:GetTrinketIcon(trinket.tid)
        return iconPath
      end)
      binder:BindToVisible(imageObj, function()
        local trinkets = self.trinketModel.trinkets
        local trinket = trinkets[i]
        if not trinket then
          return false
        end
        return trinket.tid and trinket.tid > 0
      end)
      local lightComp = UICompTrinketIconMat(imageObj, {binder = binder})
      binder:BindToRaw(function(_, hasBound, _)
        lightComp:EnableLight(true == hasBound, i)
      end, function()
        local trinket = self.trinketModel.trinkets[i]
        return trinket and AwakerTrinketDataUtils.IsTrinketBoundForLight(trinket.uid) or false
      end)
      table.insert(self.boundLightComps, lightComp)
    end
    local ImageSelectObj = self.ui["Image_Select_Patrs_" .. i]
    if ImageSelectObj then
      binder:BindToVisible(ImageSelectObj, function()
        local pos = self.trinketModel.selectPos
        return pos == i
      end)
    end
  end
end

function AwakerTrinketListComp:BindTrinketSuitGatherAll(binder)
  binder:BindToVisible(self.ui.Image_Finish, function()
    do return self.trinketModel.IsSuitGatherAll end
    return self.trinketModel.IsSuitGatherAll, self.trinketModel
  end)
  binder:BindToImage(self.ui.Image_Finish, function()
    local isGatherAll = self.trinketModel:IsSuitGatherAll()
    if not isGatherAll then
      return
    end
    local trinkets = self.trinketModel.trinkets
    local suitId = trinkets[1].suitId
    local iconPath = self.trinketModel:GetSuitIcon(suitId)
    return iconPath
  end)
end

function AwakerTrinketListComp:OnUnbind()
  for _, lightComp in ipairs(self.boundLightComps or {}) do
    lightComp:OnExitComponent()
  end
  self.boundLightComps = nil
end

return AwakerTrinketListComp
