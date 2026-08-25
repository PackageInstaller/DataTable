local RelicGroupTabType = CommonDefine.RelicGroupTabType
local tableCellSize = CS.UnityEngine.Vector2(0, 0)
local CreationsNumPerLine = 7
local TagCreation_Title = 100
local TagCreation_Item = 101
local TableCellType = {CreationTitle = 1, CreationItem = 2}
local CellsGameObject = {
  [TableCellType.CreationTitle] = {
    tag = TagCreation_Title,
    go = "Item_Creation_Title"
  },
  [TableCellType.CreationItem] = {
    tag = TagCreation_Item,
    go = "Item_Creation"
  }
}
local MainCopyRelicGroupPanel, Super = System.NewClass("MainCopyRelicGroupPanel", UIBasePanel)
MainCopyRelicGroupPanel.uiResCls = UI_Chaper_Popup_DetailedResource

function MainCopyRelicGroupPanel:ctor(stageTid, relicGroupList)
  Super.ctor(self)
  self.stageTid = stageTid
  self.relicGroupList = relicGroupList
end

function MainCopyRelicGroupPanel:OnBind(binder)
  self.binder = binder
  self.model = binder:createModel(MainCopyRelicGroupModel, self.stageTid, self.relicGroupList)
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.ClosePanel))
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.ClosePanel))
  binder:BindToVisible(self.ui.Image_Creation, System.fn(self, self._IsShowRelic))
  binder:BindToVisible(self.ui.Image_Enchantment, System.fn(self, self._IsShowEnchant))
  binder:BindToVisible(self.ui.Image_Show_Creation, System.fn(self, self._IsRelicGroupShow))
  binder:BindToVisible(self.ui.Image_Show_Enchantment, System.fn(self, self._IsEnchantGroupShow))
  binder:BindToVisible(self.ui.Image_Creation_Empty, System.fn(self, self._IsRelicGroupEmptyShow))
  binder:BindToVisible(self.ui.Image_Enchantment_Empty, System.fn(self, self._IsEnchantGroupEmptyShow))
  self:BindCreationTap()
  self:BindRelicInformation()
  self:BindEnchantInformation()
  self:BindCreationView()
  self:RefreshEnchantView()
  self:RefreshCreationView()
  self:_SetChooseFirstRelic()
end

function MainCopyRelicGroupPanel:_DequeCellByCellCfg(view, cellCfg)
  local cellGoCfg = CellsGameObject[cellCfg.tableCellType]
  local cell = view:DequeueCellByTag(cellGoCfg.tag)
  if not cell then
    cell = view:AddChild(self.ui[cellGoCfg.go])
    cell.tag = cellGoCfg.tag
  end
  self.childrenBinders = self.childrenBinders or {}
  self.childrenBinders[cell] = self.childrenBinders[cell] or self.binder:createChild()
  self.childrenBinders[cell]:clearChildren()
  return cell, self.childrenBinders[cell]
end

function MainCopyRelicGroupPanel:GenCreationViewData()
  self.creationViewData = {}
  for i = 1, #self.model.relicGroupList do
    local groupTid = self.model.relicGroupList[i]
    local relics = self.model:GetRelicListByGroup(groupTid)
    if #relics > 0 then
      table.insert(self.creationViewData, {
        tableCellType = TableCellType.CreationTitle,
        groupTid = groupTid
      })
      for i = 1, #relics, CreationsNumPerLine do
        local relicTids = {}
        for j = 0, CreationsNumPerLine - 1 do
          local relicTid = relics[i + j]
          if not relicTid then
            break
          end
          table.insert(relicTids, relicTid)
        end
        if #relicTids > 0 then
          table.insert(self.creationViewData, {
            tableCellType = TableCellType.CreationItem,
            relicTids = relicTids
          })
        end
      end
    end
  end
end

function MainCopyRelicGroupPanel:RefreshCreationView()
  self:GenCreationViewData()
  self.creationTableview:ReloadData()
end

function MainCopyRelicGroupPanel:BindCreationView()
  self.creationTableview = self.ui.ScrollView_Creation:GetComponent(typeof(CS.UITableview))
  
  function self.creationTableview.tableCellAtIndex(view, index)
    local cellCfg = self.creationViewData[index + 1]
    local cell, binder = self:_DequeCellByCellCfg(view, cellCfg)
    if cellCfg.tableCellType == TableCellType.CreationTitle then
      self:_FillCreationTitleCell(binder, cell, cellCfg)
    elseif cellCfg.tableCellType == TableCellType.CreationItem then
      self:_FillCreationsCell(binder, cell, cellCfg)
    end
    return cell
  end
  
  function self.creationTableview.numberCellsInTableview()
    return #self.creationViewData
  end
  
  function self.creationTableview.tableCellSizeForIndex(view, index)
    local cellCfg = self.creationViewData[index + 1]
    tableCellSize.x = 980
    if cellCfg.tableCellType == TableCellType.CreationTitle then
      tableCellSize.y = 80
    elseif cellCfg.tableCellType == TableCellType.CreationItem then
      tableCellSize.y = 126
    end
    return tableCellSize
  end
end

function MainCopyRelicGroupPanel:_FillCreationTitleCell(binder, cell, cellCfg)
  local text_Overview = cell.transform:Find("Text_Overview")
  binder:SetText(text_Overview, self.model:GetRelicGroupName(cellCfg.groupTid))
end

function MainCopyRelicGroupPanel:_FillCreationsCell(binder, cell, cellCfg)
  local function _OnClick(relicTid)
    if self.model.currSelectRelicTid == relicTid then
      return
    end
    self.model:SetCurrSelectRelicTid(relicTid)
  end
  
  local function _IsSelect(_, relicTid)
    return self.model.currSelectRelicTid == relicTid
  end
  
  local relicTids = cellCfg.relicTids
  for i = 1, #relicTids do
    local go = cell.transform:GetChild(i - 1).gameObject
    local itemData = {
      tid = relicTids[i],
      onClick = _OnClick,
      clickFrameShowFunc = _IsSelect,
      isRelic = true,
      hideGroupDown = true
    }
    self.binder:SetIcon(MaterialIconType.CommonIcon_Obsolete, go, itemData)
  end
  for i = #relicTids + 1, CreationsNumPerLine do
    local go = cell.transform:GetChild(i - 1).gameObject
    self.binder:ClearIcon(go)
  end
end

function MainCopyRelicGroupPanel:RefreshEnchantView()
  self.binder:BindExpandListView(self.ui.ScrollView_Enchantment, System.fn(self, self._GetEnchantGroupList), function()
    return "UI_Chapter_Item_Overview"
  end, System.fn(self, self._UpdateEnchantGroupItem))
end

function MainCopyRelicGroupPanel:BindRelicInformation()
  self.binder:BindToRaw(function(childBinder, n, _)
    childBinder:SetText(self.ui.Text_Creation, self:_GetRelicTypeName())
    childBinder:SetText(self.ui.Text_Title, self:_GetRelicName())
    childBinder:SetText(self.ui.Text_Introduce_2, self:_GetRelicDesc(), nil, nil, true)
    childBinder:SetText(self.ui.Text_Match, self:_GetRelicStoryDesc())
    childBinder:SetImage(self.ui.Image_Icon_2, self:_GetRelicIcon())
    CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Content_Creation)
  end, function()
    return self.model.currSelectRelicTid
  end)
  self.ui.Group_Keyword_Creation:SetActive(false)
  self.binder:BindUICustomInput(self.ui.Text_Introduce_2, function(hover)
    if not hover then
      self.ui.Group_Keyword_Creation:SetActive(false)
    end
  end)
end

function MainCopyRelicGroupPanel:BindEnchantInformation()
  self.binder:BindToRaw(function(childBinder, n, _)
    childBinder:SetText(self.ui.Text_Qualitytitle, self:_GetEnchantName())
    childBinder:SetText(self.ui.Text_Introduce_1, self:_GetEnchantDesc(), nil, nil, true)
    childBinder:SetText(self.ui.Text_Enchantment, self:_GetEnchantTypeName())
    childBinder:SetImage(self.ui.Image_Icon_1, self:_GetEnchantIcon())
    CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Content_Enchantment)
  end, function()
    return self.model.currSelectEnchantTid
  end)
  self.ui.Group_Keyword_Enchant:SetActive(false)
end

function MainCopyRelicGroupPanel:BindCreationTap()
  self.binder:BindZ1Button(self.ui.Btn_Creation, function()
    self.model:SetShowTab(RelicGroupTabType.RELIC)
    self:_SetChooseFirstRelic()
  end, nil, nil, nil, System.fn(self, self._IsShowRelic))
  self.binder:BindZ1Button(self.ui.Btn_Enchantment, function()
    self.model:SetShowTab(RelicGroupTabType.ENCHANT)
    self:_SetChooseFirstEnchant()
  end, nil, nil, nil, System.fn(self, self._IsShowEnchant))
end

function MainCopyRelicGroupPanel:_SetChooseFirstRelic()
  if #self.model.relicGroupList > 0 then
    local groupId = self.model.relicGroupList[1]
    local list = self.model:GetRelicListByGroup(groupId)
    if #list > 0 then
      self.model:SetCurrSelectRelicTid(list[1])
    end
  end
end

function MainCopyRelicGroupPanel:_SetChooseFirstEnchant()
  if #self.model.enchantGroupList > 0 then
    local groupId = self.model.enchantGroupList[1]
    local list = self.model:GetEnchantListByGroup(groupId)
    if #list > 0 then
      self.model:SetCurrSelectEnchantTid(list[1])
    end
  end
end

function MainCopyRelicGroupPanel:_GetRelicGroupList()
  return self.model.relicGroupList
end

function MainCopyRelicGroupPanel:_GetEnchantGroupList()
  return self.model.enchantGroupList
end

function MainCopyRelicGroupPanel:_GetRelicTypeName()
  do return self.model.GetRelicTypeName, self.model end
  return self.model.GetRelicTypeName, self.model, self.model.currSelectRelicTid
end

function MainCopyRelicGroupPanel:_GetRelicName()
  do return self.model.GetRelicName, self.model end
  return self.model.GetRelicName, self.model, self.model.currSelectRelicTid
end

function MainCopyRelicGroupPanel:_GetRelicDesc()
  do return self.model.GetRelicDesc, self.model end
  return self.model.GetRelicDesc, self.model, self.model.currSelectRelicTid
end

function MainCopyRelicGroupPanel:_GetRelicStoryDesc()
  do return self.model.GetRelicStoryDesc, self.model end
  return self.model.GetRelicStoryDesc, self.model, self.model.currSelectRelicTid
end

function MainCopyRelicGroupPanel:_GetRelicIcon()
  do return self.model.GetRelicIcon, self.model end
  return self.model.GetRelicIcon, self.model, self.model.currSelectRelicTid
end

function MainCopyRelicGroupPanel:_GetEnchantTypeName()
  do return self.model.GetEnchantTypeName, self.model end
  return self.model.GetEnchantTypeName, self.model, self.model.currSelectEnchantTid
end

function MainCopyRelicGroupPanel:_GetEnchantName()
  do return self.model.GetEnchantName, self.model end
  return self.model.GetEnchantName, self.model, self.model.currSelectEnchantTid
end

function MainCopyRelicGroupPanel:_GetEnchantDesc()
  do return self.model.GetEnchantDesc, self.model end
  return self.model.GetEnchantDesc, self.model, self.model.currSelectEnchantTid
end

function MainCopyRelicGroupPanel:_GetEnchantIcon()
  do return self.model.GetEnchantIcon, self.model end
  return self.model.GetEnchantIcon, self.model, self.model.currSelectEnchantTid
end

function MainCopyRelicGroupPanel:_IsShowRelic()
  return self.model.showTab == RelicGroupTabType.RELIC
end

function MainCopyRelicGroupPanel:_IsRelicGroupShow()
  return not self:_IsRelicGroupEmptyShow()
end

function MainCopyRelicGroupPanel:_IsEnchantGroupShow()
  return not self:_IsEnchantGroupEmptyShow()
end

function MainCopyRelicGroupPanel:_IsShowEnchant()
  return self.model.showTab == RelicGroupTabType.ENCHANT
end

function MainCopyRelicGroupPanel:_IsRelicGroupEmptyShow()
  return #self.model.relicGroupList <= 0
end

function MainCopyRelicGroupPanel:_IsEnchantGroupEmptyShow()
  return #self.model.enchantGroupList <= 0
end

function MainCopyRelicGroupPanel:_UpdateEnchantGroupItem(itemBinder, go, index)
  local groupTid = self.model.enchantGroupList[index]
  itemBinder:BindComponent(MainCopyEnchantGroupItem(go, self.model, groupTid))
end

function MainCopyRelicGroupPanel:ClosePanel()
  self:Close()
end

return MainCopyRelicGroupPanel
