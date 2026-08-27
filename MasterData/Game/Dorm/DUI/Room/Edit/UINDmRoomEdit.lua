local UINDmRoomEdit = class("UINDmRoomEdit", UIBaseNode)
local base = UIBaseNode
local UINDmFntCategoryTog = require("Game.Dorm.DUI.Room.Edit.UINDmFntCategoryTog")
local UINDmRoomFntList = require("Game.Dorm.DUI.Room.Edit.UINDmRoomFntList")
local UINDmRoomFntOperate = require("Game.Dorm.DUI.Room.Edit.UINDmRoomFntOperate")
local UINDmFntThemeList = require("Game.Dorm.DUI.Room.Edit.Theme.UINDmFntThemeList")
local DormEnum = require("Game.Dorm.DormEnum")
local DormUtil = require("Game.Dorm.DormUtil")
local CS_MessageCommon = CS.MessageCommon

function UINDmRoomEdit:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self._OnConfirmClicked)
  UIUtil.AddButtonListener(self.ui.btn_PackUp, self, self._OnClearClicked)
  UIUtil.AddButtonListener(self.ui.btn_ReSet, self, self._OnRestoreClicked)
  UIUtil.AddButtonListener(self.ui.btn_Sort, self, self._OnSortClicked)
  UIUtil.AddButtonListener(self.ui.btn_BackTheme, self, self._OnBackThemeClicked)
  UIUtil.AddButtonListener(self.ui.btn_QuickSet, self, self._OnQuickSetThemeClicked)
  self.dmRoomFntList = UINDmRoomFntList.New()
  self.dmRoomFntList:Init(self.ui.fntList)
  self.dmRoomFntOp = UINDmRoomFntOperate.New()
  self.dmRoomFntOp:Init(self.ui.fntOperate)
  self._onClickFntItemFunc = BindCallback(self, self._OnClickFntItem)
  self._OnSelectFntCategoryFunc = BindCallback(self, self._OnSelectFntCategory)
  self._onDormRoomEditDataChange = BindCallback(self, self._DormRoomEditDataChange)
  self._resLoader = CS.ResLoader.Create()
  local iconPath = PathConsts:GetSpriteAtlasPath("UI_DormRoom")
  self._togIconAtlas = self._resLoader:LoadABAsset(iconPath)
  self.ui.fntCatgTog:SetActive(false)
  self.fntCategoryTogList = UIItemPool.New(UINDmFntCategoryTog, self.ui.fntCatgTog)
  self.catTogItemDic = {}
  for k, catgId in ipairs(ConfigData.dorm_fnt_category.dmFntCategoryIdList) do
    local cfg = ConfigData.dorm_fnt_category[catgId]
    local togItem = self.fntCategoryTogList:GetOne()
    local sprite = AtlasUtil.GetResldSprite(self._togIconAtlas, cfg.icon)
    togItem:InitDmFntCategoryTog(cfg, sprite, self._OnSelectFntCategoryFunc)
    self.catTogItemDic[catgId] = togItem
    if DormEnum.ThemeCatId == catgId then
      togItem:Hide()
    end
  end
  self._dmRoomFntOpShow_InWall = true
  self.ui.fntThemeBack:SetActive(false)
end

function UINDmRoomEdit:InitDmRoomtEdit(dmRoomCtrl)
  self.dmRoomCtrl = dmRoomCtrl
  UIUtil.SetTopStatus(self, self._OnCancelClicked, nil, DormEnum.ShowRoomInfoFunc)
  self.fntWarehouseCatgList = self.dmRoomCtrl.editRoomData:GetFntWarehouseCatgList()
  local themeCatItem = self.catTogItemDic[DormEnum.ThemeCatId]
  if themeCatItem ~= nil and self.dmRoomCtrl.editRoomData:IsHasAnyDmtThemeFnt() then
    themeCatItem:Show()
  end
  self._selCatgId = nil
  self:DmRoomEditSelectFntMode(false)
  local setFirst = false
  for k, togItem in ipairs(self.fntCategoryTogList.listItem) do
    if not setFirst and togItem.gameObject.activeInHierarchy then
      togItem:SetDmFntCategoryTogOn(true)
      setFirst = true
    else
      togItem:SetDmFntCategoryTogOn(false)
    end
  end
  self.ui.typeList.verticalNormalizedPosition = 1
end

function UINDmRoomEdit:ReinitDmRoomtEditData()
  self.fntWarehouseCatgList = self.dmRoomCtrl.editRoomData:GetFntWarehouseCatgList()
  local themeCfg = self._curThemeCfg
  self:_OnSelectFntCategory(self._selCatgId, true)
  if themeCfg ~= nil then
    self:ShowDmRoomEditThemeFntList(themeCfg)
  end
end

function UINDmRoomEdit:DmRoomEditSelectFntMode(isEnter)
  if isEnter then
    self:DmRoomEditOperateShow(true)
    self.ui.listRoot:SetActive(false)
  else
    self:DmRoomEditOperateShow(false)
    self.ui.listRoot:SetActive(true)
    self:TryRefreshDmRoomEditList()
  end
end

function UINDmRoomEdit:DmRoomEditOperateShow(isShow, inWallVisible)
  if inWallVisible then
    self._dmRoomFntOpShow_InWall = isShow
  else
    self._dmRoomFntOpShow = isShow
  end
  if self._dmRoomFntOpShow_InWall and self._dmRoomFntOpShow then
    self.dmRoomFntOp:Show()
  else
    self.dmRoomFntOp:Hide()
  end
end

function UINDmRoomEdit:TryRefreshDmRoomEditList()
  if self.ui.listRoot.activeInHierarchy and self.waitDmRoomFntListRefresh then
    self:_RefreshDmRoomEditFntList()
    self.waitDmRoomFntListRefresh = false
  end
  if self._themeListNode ~= nil and self._themeListNode.gameObject.activeInHierarchy and self._waitDmRoomThemeListRefresh then
    self._themeListNode:RefillDmRoomThemeList()
    self._waitDmRoomThemeListRefresh = false
  end
end

function UINDmRoomEdit:_RefreshDmRoomEditFntList()
  local fntWarehouseList = self._themefntWarehouseList or self.fntWarehouseCatgList[self._selCatgId] or table.emptytable
  self:__RefreshFntListUI(fntWarehouseList, false)
end

function UINDmRoomEdit:_UpdCategoryLimitNum()
  local fntCatgCfg = ConfigData.dorm_fnt_category[self._selCatgId]
  local roomType = self.dmRoomCtrl.roomEntity.roomData:GetDmRoomType()
  local limitNum = DormUtil.GetDmFntNumLimit(roomType, fntCatgCfg)
  if limitNum == 0 then
    self.ui.obj_currFntCatg:SetActive(false)
  else
    self.ui.obj_currFntCatg:SetActive(true)
    local sprite = AtlasUtil.GetResldSprite(self._togIconAtlas, fntCatgCfg.icon)
    self.ui.img_CatgIcon.sprite = sprite
    self.ui.tex_typeName.text = LanguageUtil.GetLocaleText(fntCatgCfg.name)
    local curNum = self.dmRoomCtrl.roomEntity.roomData:GetDmRoomFntCategoryNum(self._selCatgId)
    local maxNum = limitNum
    self.ui.tex_typeCount:SetIndex(0, tostring(curNum), tostring(maxNum))
    local isMax = curNum >= maxNum
    self.ui.img_CurrFntCatg.color = isMax and self.ui.catgBgColor[2] or self.ui.catgBgColor[1]
    self.ui.img_CatgIcon.color = isMax and Color.white or Color.black
    self.ui.tex_typeName.color = isMax and Color.white or Color.black
    self.ui.tex_typeCount.text.color = isMax and Color.white or Color.black
  end
end

function UINDmRoomEdit:ShowDmRoomEditThemeFntList(themeCfg)
  self._curThemeCfg = themeCfg
  local fntWarehouseList = {}
  for fntId, num in pairs(themeCfg.theme_furniture_id) do
    local fntWarehousedata = self.dmRoomCtrl.editRoomData:GetDmStorageFntData(fntId)
    if fntWarehousedata == nil then
      fntWarehousedata = self.dmRoomCtrl.editRoomData:NewDmStorateFnt(fntId, 0)
    end
    table.insert(fntWarehouseList, fntWarehousedata)
  end
  self.dmRoomFntList:SetDmRoomFntListInTheme(themeCfg.theme_furniture_id)
  self.ui.fntThemeBack:SetActive(true)
  self.ui.tex_ThemeName.text = LanguageUtil.GetLocaleText(themeCfg.theme_name)
  self.ui.btn_QuickSet.gameObject:SetActive(true)
  self.ui.btn_QuickSet.targetGraphic.color = self:_IsCanQuickSetTheme() and Color.white or Color.gray
  self:__RefreshFntListUI(fntWarehouseList, true)
  self._themefntWarehouseList = fntWarehouseList
end

function UINDmRoomEdit:_OnBackThemeClicked()
  self:_ResetThemeFntList()
  self.dmRoomFntList:Hide()
  self._themeListNode:Show()
  self:TryRefreshDmRoomEditList()
end

function UINDmRoomEdit:_IsCanQuickSetTheme()
  if not self.dmRoomCtrl.roomEntity.roomData:IsBigRoomType() and self._curThemeCfg and self._curThemeCfg.only_big then
    return false
  end
  return true
end

function UINDmRoomEdit:_OnQuickSetThemeClicked()
  if self._curThemeCfg == nil then
    return
  end
  if not self:_IsCanQuickSetTheme() then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(2040))
    return
  end
  local noneFnt = true
  local hasAllTheme = true
  for fntId, num in pairs(self._curThemeCfg.theme_furniture_id) do
    local storageFntData = self.dmRoomCtrl.editRoomData:GetDmStorageFntData(fntId)
    if storageFntData ~= nil and storageFntData.count > 0 then
      noneFnt = false
    end
    if storageFntData == nil or num > storageFntData.count then
      hasAllTheme = false
    end
    if noneFnt == false and hasAllTheme == false then
      break
    end
  end
  if noneFnt then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(2039))
    return
  end
  if string.IsNullOrEmpty(self._curThemeCfg.theme_coord) then
    error(string.format("dormThemeCfg.theme_coord is Null Or Empty, theme id:%s", self._curThemeCfg.id))
    return
  end
  local themeData = table.String2Table(self._curThemeCfg.theme_coord)
  self.dmRoomCtrl:LoadDmRoomTheme(themeData)
  if not hasAllTheme then
    CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(2041))
  end
end

function UINDmRoomEdit:_ShowThemeList()
  if self._themeListNode == nil then
    self._themeListNode = UINDmFntThemeList.New()
    self._themeListNode:Init(self.ui.fntThemeList)
  end
  self.dmRoomFntList:Hide()
  local inBigRoom = self.dmRoomCtrl.roomEntity.roomData:IsBigRoomType()
  self._themeListNode:InitDmFntThemeList(inBigRoom, self.dmRoomCtrl.editRoomData, self._resLoader, self)
  self.ui.fntEmpty:SetActive(false)
end

function UINDmRoomEdit:_ResetThemeFntList()
  self.ui.fntThemeBack:SetActive(false)
  self.ui.btn_QuickSet.gameObject:SetActive(false)
  self._curThemeCfg = nil
  self._themefntWarehouseList = nil
  self.dmRoomFntList:SetDmRoomFntListInTheme(nil)
end

function UINDmRoomEdit:_OnSelectFntCategory(catgId, isForce)
  if self._selCatgId == catgId and not isForce then
    return
  end
  self._selCatgId = catgId
  self:_UpdCategoryLimitNum()
  self:_ResetThemeFntList()
  if catgId == DormEnum.ThemeCatId then
    self:_ShowThemeList()
    return
  end
  local fntWarehouseList = self.fntWarehouseCatgList[catgId] or table.emptytable
  self:__RefreshFntListUI(fntWarehouseList, true)
end

function UINDmRoomEdit:_OnClickFntItem(fntWarehouseData, fntItem)
  if not self.dmRoomCtrl.roomEntity.roomData:IsBigRoomType() and fntWarehouseData.fntCfg.only_big then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(2037))
    return
  end
  if fntWarehouseData.count == 0 then
    return
  end
  if not fntWarehouseData.isDefaultDmFnt then
    local catgId = fntWarehouseData.fntCfg.category
    local fntCatgCfg = ConfigData.dorm_fnt_category[catgId]
    local roomType = self.dmRoomCtrl.roomEntity.roomData:GetDmRoomType()
    local limitNum = DormUtil.GetDmFntNumLimit(roomType, fntCatgCfg)
    if 0 < limitNum then
      local curNum = self.dmRoomCtrl.roomEntity.roomData:GetDmRoomFntCategoryNum(catgId)
      local maxNum = limitNum
      if curNum >= maxNum then
        local msg = string.format(ConfigData:GetTipContent(2027), LanguageUtil.GetLocaleText(fntCatgCfg.name))
        CS_MessageCommon.ShowMessageTipsWithErrorSound(msg)
        return
      end
    end
  end
  self.dmRoomCtrl:InstallFnt(fntWarehouseData)
end

function UINDmRoomEdit:_DormRoomEditDataChange(fntWarehouseDataDic)
  local newWarehouseDataDic = self._themefntWarehouseList ~= nil and {}
  for fntWarehouseData, isNew in pairs(fntWarehouseDataDic) do
    local catgId = fntWarehouseData.fntCfg.category
    if isNew then
      self.fntWarehouseCatgList[catgId] = self.fntWarehouseCatgList[catgId] or {}
      local catgList = self.fntWarehouseCatgList[catgId]
      table.insert(catgList, fntWarehouseData)
      if newWarehouseDataDic then
        newWarehouseDataDic[fntWarehouseData.id] = fntWarehouseData
      end
    end
  end
  local refreshFntList = false
  if self._themefntWarehouseList ~= nil then
    for k, v in ipairs(self._themefntWarehouseList) do
      if newWarehouseDataDic[v.id] ~= nil then
        self._themefntWarehouseList[k] = newWarehouseDataDic[v.id]
      end
    end
    refreshFntList = true
  end
  if self._selCatgId == DormEnum.ThemeCatId and self._themeListNode ~= nil then
    self._waitDmRoomThemeListRefresh = false
    if self._themeListNode.gameObject.activeInHierarchy then
      self._themeListNode:RefillDmRoomThemeList(false)
    else
      self._waitDmRoomThemeListRefresh = true
    end
  else
    refreshFntList = true
  end
  if refreshFntList then
    self.dmRoomFntList:RefreshDmRoomFntList()
    self.waitDmRoomFntListRefresh = false
    if self.ui.listRoot.activeInHierarchy then
      self:_RefreshDmRoomEditFntList()
    else
      self.waitDmRoomFntListRefresh = true
    end
  end
  self:_UpdCategoryLimitNum()
end

function UINDmRoomEdit:_OnConfirmClicked()
  self.dmRoomCtrl:ConfirmDormRoomEdit()
end

function UINDmRoomEdit:_OnCancelClicked()
  if self.dmRoomCtrl:HasDmRoomEdited() then
    CS_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(2011), function()
      self:_ExitEdit(false)
    end, nil)
    return false
  else
    self:_ExitEdit(true)
  end
end

function UINDmRoomEdit:_ExitEdit(popStack)
  self.dmRoomCtrl:ExitDormRoomEdit(false, popStack)
end

function UINDmRoomEdit:_OnRestoreClicked()
  CS_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(2010), function()
    self.dmRoomCtrl:RestoreDormRoomEdit()
  end, nil)
end

function UINDmRoomEdit:_OnSortClicked()
end

function UINDmRoomEdit:_OnClearClicked()
  CS_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(2008), function()
    self.dmRoomCtrl:ClearAllFnt()
  end, nil)
end

function UINDmRoomEdit:OnShow()
  MsgCenter:AddListener(eMsgEventId.DormRoomEditDataChange, self._onDormRoomEditDataChange)
end

function UINDmRoomEdit:OnHide()
  MsgCenter:RemoveListener(eMsgEventId.DormRoomEditDataChange, self._onDormRoomEditDataChange)
end

function UINDmRoomEdit:__RefreshFntListUI(fntWarehouseList, refill)
  local hasData = 0 < #fntWarehouseList
  self.ui.fntEmpty:SetActive(not hasData)
  if self._themeListNode then
    self._themeListNode:Hide()
  end
  if hasData then
    self.dmRoomFntList:Show()
    self.dmRoomFntList:InitDmRoomFntList(fntWarehouseList, self._onClickFntItemFunc, self.dmRoomCtrl.roomEntity.roomData:IsBigRoomType())
    self.dmRoomFntList:RefreshDmRoomFntList()
    self.dmRoomFntList:RefillDmRoomFntList(refill)
  else
    self.dmRoomFntList:Hide()
  end
end

function UINDmRoomEdit:OnDelete()
  self.fntCategoryTogList:DeleteAll()
  self.dmRoomFntList:Delete()
  self.dmRoomFntOp:Delete()
  if self._themeListNode ~= nil then
    self._themeListNode:Delete()
    self._themeListNode = nil
  end
  if self._resLoader ~= nil then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
  base.OnDelete(self)
end

return UINDmRoomEdit
