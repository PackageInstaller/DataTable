local MatCraftingCtrl = class("MatCraftingCtrl", BaseCtrl)
MatCraftingCtrl._mapNodeConfig = {
  sv = {
    sComponentName = "LoopScrollView"
  },
  trSv = {sNodeName = "sv", sComponentName = "Transform"},
  goCraftingContent = {},
  btnCraftingItem = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CraftingItem"
  },
  imgItemIcon = {sComponentName = "Image"},
  txtItemCount = {sComponentName = "TMP_Text"},
  txtCrafting = {
    sComponentName = "TMP_Text",
    sLanguageId = "Crafting_Count_Text"
  },
  txtCraftingCount = {sComponentName = "TMP_Text"},
  txtMaterial = {
    sComponentName = "TMP_Text",
    sLanguageId = "Crafting_Material_Title"
  },
  goMaterialList = {
    sComponentName = "RectTransform"
  },
  btnMaterial = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_MaterialItem",
    nCount = 4
  },
  goMaterialItem = {
    sCtrlName = "Game.UI.TemplateEx.TemplateMatCtrl",
    nCount = 4
  },
  btnReduceCount = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reduce"
  },
  btnAddCount = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Add"
  },
  btnReduceGray = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ReduceGray"
  },
  btnAddGray = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_AddGray"
  },
  imgCountSlider = {
    sComponentName = "Slider",
    callback = "OnSliderValueChange"
  },
  btnCrafting = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Crafting"
  },
  txtBtnCrafting = {
    sComponentName = "TMP_Text",
    sLanguageId = "Crafting_Btn_Text"
  },
  goEmpty = {},
  txtEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "Crafting_Empty"
  },
  txtHave = {
    sComponentName = "TMP_Text",
    sLanguageId = "Depot_ItemQTY"
  },
  txtBeforeValue = {sComponentName = "TMP_Text"},
  txtAfterValue = {sComponentName = "TMP_Text"}
}
MatCraftingCtrl._mapEventConfig = {
  CraftingSuccess = "OnRefreshCraftingItem"
}

function MatCraftingCtrl:RefreshProductionList(tbList, nSelectPId)
  self.tbProduction = tbList
  for insId, objCtrl in pairs(self.tbProductionCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbProductionCtrl[insId] = nil
  end
  self.nWorldClass = PlayerData.Base:GetWorldClass()
  if nil ~= nSelectPId then
    self.nSelectPId = nSelectPId
  end
  local nSelectIndex
  if nil ~= self.nSelectPId then
    for k, v in ipairs(self.tbProduction) do
      if v.Id == self.nSelectPId then
        nSelectIndex = k
      end
    end
  end
  self._mapNode.sv:Init(#self.tbProduction, self, self.OnRefreshGrid, self.OnGridBtnClick)
  if nil ~= nSelectIndex then
    self._mapNode.sv:SetScrollGridPos(nSelectIndex - 1, 0.1, 1)
  end
  self:OnSelectMtProduction(self.nSelectPId)
  self:RefreshCraftingCount()
  NovaAPI.SetSliderValue(self._mapNode.imgCountSlider, self.nCraftingCount)
end

function MatCraftingCtrl:OnRefreshGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local data = self.tbProduction[nIndex]
  if data == nil then
    goGrid:SetActive(false)
    return
  end
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbProductionCtrl[nInstanceId] then
    self.tbProductionCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.Crafting.MatProductionItemCtrl")
  end
  goGrid.gameObject:SetActive(true)
  data.Unlock = data.UnlockWorldLevel <= self.nWorldClass
  self.tbProductionCtrl[nInstanceId]:SetData(data)
  if self.nSelectPId == 0 and data.Unlock then
    self.nSelectPId = data.Id
  end
  if self.nSelectPId == data.Id then
    self.nSelectIndex = nIndex
    self.tbProductionCtrl[nInstanceId]:SetSelect(true)
  end
end

function MatCraftingCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local data = self.tbProduction[nIndex]
  if not data.Unlock then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Crafting_Lock_Tip"))
    return
  end
  if self.nSelectPId == data.Id then
    return
  end
  local nInstanceId = goGrid:GetInstanceID()
  local goSelect = self._mapNode.trSv:Find("Viewport/Content/" .. self.nSelectIndex - 1)
  if goSelect then
    self.tbProductionCtrl[goSelect.gameObject:GetInstanceID()]:SetSelect(false)
  end
  self.tbProductionCtrl[nInstanceId]:SetSelect(true)
  self.nSelectIndex = nIndex
  self.nSelectPId = data.Id
  self:OnSelectMtProduction(self.nSelectPId)
end

function MatCraftingCtrl:RefreshCraftingCount()
  local bEmpty = self.nSelectPId == nil or self.nSelectPId == 0
  self._mapNode.goEmpty:SetActive(bEmpty)
  self._mapNode.goCraftingContent:SetActive(not bEmpty)
  EventManager.Hit("SetCraftingEmpty", bEmpty)
  if bEmpty then
    return
  end
  local tbCfgData = PlayerData.Crafting:GetProductionById(self.nSelectPId)
  if tbCfgData == nil then
    return
  end
  self._mapNode.goEmpty:SetActive(false)
  self._mapNode.goCraftingContent:SetActive(true)
  for k, v in ipairs(tbCfgData.MaterialList) do
    self._mapNode.btnMaterial[k].interactable = nil ~= self._mapNode.goMaterialItem[k]
    if nil ~= self._mapNode.goMaterialItem[k] then
      self._mapNode.goMaterialItem[k]:SetMat(v.nItemId, self.nCraftingCount * v.nCount)
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txtCraftingCount, self.nCraftingCount)
  self._mapNode.btnAddCount.gameObject:SetActive(self.nCraftingCount < self.nMaxCraftingCount)
  self._mapNode.btnAddGray.gameObject:SetActive(self.nCraftingCount >= self.nMaxCraftingCount)
  self._mapNode.btnReduceCount.gameObject:SetActive(self.nCraftingCount > 1)
  self._mapNode.btnReduceGray.gameObject:SetActive(self.nCraftingCount <= 1)
  if self.nProductionId == nil or self.nProductionId == 0 then
    return
  end
  local nHasCount = PlayerData.Item:GetItemCountByID(self.nProductionId)
  NovaAPI.SetTMPText(self._mapNode.txtBeforeValue, nHasCount)
  local nPerCount = tbCfgData.ShowProductionId == 0 and tbCfgData.ProductionPerBatch or tbCfgData.ShowProductionPerBatch
  local nAfterCount = nHasCount + self.nCraftingCount * nPerCount
  NovaAPI.SetTMPText(self._mapNode.txtAfterValue, nAfterCount)
end

function MatCraftingCtrl:ResetSelectProduction()
  self.nSelectPId = 0
end

function MatCraftingCtrl:Awake()
  self.nSelectPId = 0
  self.nMaxCraftingCount = 0
  self.nMaxCraftingCountCfg = ConfigTable.GetConfigNumber("MaterialCraftingLimit")
  self.nCraftingCount = 1
  self.tbProductionCtrl = {}
end

function MatCraftingCtrl:OnEnable()
end

function MatCraftingCtrl:OnDisable()
  for insId, objCtrl in pairs(self.tbProductionCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbProductionCtrl[insId] = nil
  end
  self.tbProductionCtrl = {}
end

function MatCraftingCtrl:OnDestroy()
end

function MatCraftingCtrl:OnBtnClick_CraftingItem(btn)
  local mapData = {
    nTid = self.nProductionId,
    bShowDepot = true,
    bShowJumpto = true
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.ItemTips, btn.transform, mapData)
end

function MatCraftingCtrl:OnBtnClick_MaterialItem(btn, index)
  local tbCfgData = PlayerData.Crafting:GetProductionById(self.nSelectPId)
  if nil ~= tbCfgData.MaterialList[index] then
    local mapData = {
      nTid = tbCfgData.MaterialList[index].nItemId,
      bShowDepot = true,
      bShowJumpto = true
    }
    EventManager.Hit(EventId.OpenPanel, PanelId.ItemTips, btn.transform, mapData)
  end
end

function MatCraftingCtrl:OnBtnClick_Reduce(btn)
  if self.nCraftingCount <= 1 then
    return
  end
  if btn.Operate_Type == 0 then
    self.nCraftingCount = self.nCraftingCount - 1
  elseif btn.Operate_Type == 3 then
    local nAdd = 2 ^ btn.CurrentGear
    self.nCraftingCount = math.floor(self.nCraftingCount - nAdd)
  end
  if self.nCraftingCount < 1 then
    self.nCraftingCount = 1
  end
  self:RefreshCraftingCount()
  NovaAPI.SetSliderValue(self._mapNode.imgCountSlider, self.nCraftingCount)
end

function MatCraftingCtrl:OnBtnClick_Add(btn)
  if self.nCraftingCount >= self.nMaxCraftingCount then
    return
  end
  if btn.Operate_Type == 0 then
    self.nCraftingCount = self.nCraftingCount + 1
  elseif btn.Operate_Type == 3 then
    local nAdd = 2 ^ btn.CurrentGear
    self.nCraftingCount = math.floor(self.nCraftingCount + nAdd)
  end
  self.nCraftingCount = self.nCraftingCount > self.nMaxCraftingCount and self.nMaxCraftingCount or self.nCraftingCount
  self:RefreshCraftingCount()
  NovaAPI.SetSliderValue(self._mapNode.imgCountSlider, self.nCraftingCount)
end

function MatCraftingCtrl:OnBtnClick_ReduceGray()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Crafting_Count_Min"))
end

function MatCraftingCtrl:OnBtnClick_AddGray()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Crafting_Count_Max"))
end

function MatCraftingCtrl:OnSliderValueChange(_, value)
  self.nCraftingCount = math.ceil(value)
  self:RefreshCraftingCount()
end

function MatCraftingCtrl:OnBtnClick_Crafting()
  if self.nCraftingCount == 0 then
    return
  end
  local bEnough = true
  local tbCfgData = PlayerData.Crafting:GetProductionById(self.nSelectPId)
  for k, v in ipairs(tbCfgData.MaterialList) do
    local hasCount = PlayerData.Item:GetItemCountByID(v.nItemId)
    if hasCount < self.nCraftingCount * v.nCount then
      bEnough = false
      break
    end
  end
  if not bEnough then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Crafting_Material_Not_Enough"))
    return
  end
  
  local function sucFunc()
    EventManager.Hit("CraftingSuccess")
  end
  
  EventManager.Hit("PlayCraftingAnim", function()
    PlayerData.Crafting:SendMaterialCrafting(self.nSelectPId, self.nCraftingCount, sucFunc)
  end)
end

function MatCraftingCtrl:OnSelectMtProduction(nId)
  self.nSelectPId = nId
  self.nMaxCraftingCount = -1
  self.nCraftingCount = 1
  local tbCfgData = PlayerData.Crafting:GetProductionById(self.nSelectPId)
  if nil ~= tbCfgData then
    self.nProductionId = tbCfgData.ShowProductionId == 0 and tbCfgData.ProductionId or tbCfgData.ShowProductionId
    local nCount = tbCfgData.ShowProductionId == 0 and tbCfgData.ProductionPerBatch or tbCfgData.ShowProductionPerBatch
    local itemCfg = ConfigTable.GetData_Item(self.nProductionId)
    self:SetPngSprite(self._mapNode.imgItemIcon, itemCfg.Icon)
    NovaAPI.SetTMPText(self._mapNode.txtItemCount, orderedFormat(ConfigTable.GetUIText("Crafting_Item_Count"), nCount))
    for k, v in ipairs(self._mapNode.btnMaterial) do
      local tbMaterialInfo = tbCfgData.MaterialList[k]
      local itemCtrl = self._mapNode.goMaterialItem[k]
      v.interactable = nil ~= tbMaterialInfo
      if nil ~= tbMaterialInfo then
        v.gameObject:SetActive(true)
        itemCtrl:SetMat(tbMaterialInfo.nItemId, nil)
        local hasCount = PlayerData.Item:GetItemCountByID(tbMaterialInfo.nItemId)
        local nCount = math.floor(hasCount / tbMaterialInfo.nCount)
        if -1 == self.nMaxCraftingCount then
          self.nMaxCraftingCount = nCount
        end
        self.nMaxCraftingCount = nCount < self.nMaxCraftingCount and nCount or self.nMaxCraftingCount
      else
        itemCtrl:SetMat(0)
      end
    end
    self.nMaxCraftingCount = self.nMaxCraftingCount > self.nMaxCraftingCountCfg and self.nMaxCraftingCountCfg or self.nMaxCraftingCount
    NovaAPI.SetSliderMaxValue(self._mapNode.imgCountSlider, self.nMaxCraftingCount <= 0 and 1 or self.nMaxCraftingCount)
    NovaAPI.SetSliderMinValue(self._mapNode.imgCountSlider, 1)
    if self.nMaxCraftingCount <= 1 then
      NovaAPI.SetSliderValue(self._mapNode.imgCountSlider, 1)
      NovaAPI.SetSliderInteractable(self._mapNode.imgCountSlider, false)
    else
      NovaAPI.SetSliderInteractable(self._mapNode.imgCountSlider, true)
    end
  end
  self:RefreshCraftingCount()
  NovaAPI.SetSliderValue(self._mapNode.imgCountSlider, self.nCraftingCount)
end

function MatCraftingCtrl:OnRefreshCraftingItem()
  for _, v in pairs(self.tbProductionCtrl) do
    v:RefreshCraftingItem()
  end
  self:OnSelectMtProduction(self.nSelectPId)
end

return MatCraftingCtrl
