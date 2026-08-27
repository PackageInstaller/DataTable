local UINAthAreaItem = class("UINAthAreaItem", UIBaseNode)
local base = UIBaseNode
local AthAreaGridData = require("Game.Arithmetic.Data.AthAreaGridData")
local UINAthTableGridState = require("Game.Arithmetic.AthMain.Table.UINAthTableGridState")
local eAthGridState = require("Game.Arithmetic.Enum.eAthGridState")
local UINAthItem = require("Game.Arithmetic.AthList.Area.UINAthItem")
local AthUtil = require("Game.Arithmetic.AthUtil")
local itemPivot = Vector2.New(0.5, 0.5)
local itemAnchor = Vector2.New(0, 1)
local cs_MessageCommon = CS.MessageCommon

function UINAthAreaItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_Root, self, self._OnClickRootToggle)
  self.ui.img_State:SetActive(false)
  self.gridStatePool = UIItemPool.New(UINAthTableGridState, self.ui.img_State)
  self.gridSizeX = self.ui.gridHolder.rect.size.x / self.ui.gridSize.x
  self.gridSizeY = self.ui.gridHolder.rect.size.y / self.ui.gridSize.y
  self.__OnClickAthItem = BindCallback(self, self.OnClickAthItem)
  self.__OnClickAthGrid = BindCallback(self, self.OnClickGride)
  self.athItemPoolDic = {}
end

function UINAthAreaItem:InitAthAreaItem(areaId, athMain, dragStartFunc)
  self.areaId = areaId
  self.athMain = athMain
  self.dragStartFunc = dragStartFunc
  self.ui.img_Icon:SetIndex(areaId - 1)
  local areaCfg = ConfigData.ath_area[areaId]
  if areaCfg == nil then
    error("Can't find ath areaCfg, areaId = " .. tostring(areaId))
    return
  end
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(areaCfg.name2)
end

function UINAthAreaItem:RefreshAthAreaItem(heroData, resLoader, space, maxSpace)
  self:__HideAllAthItem()
  self:__ClearItemPosTween()
  self.heroData = heroData
  self.resLoader = resLoader
  self.space = space
  self.maxSpace = maxSpace
  local gridUnlockList = ConfigData.game_config.athGridUnlockList
  if space > #gridUnlockList then
    error(string.format("Ath grid count(%s) error, space = (%s)", #gridUnlockList, space))
    return
  end
  self.areaGridData = AthAreaGridData.New(self.areaId)
  self.areaGridData:InitAthAreaGridData(heroData, space, maxSpace)
  self.gridStatePool:HideAll()
  for k, gridId in ipairs(AthUtil.AthUseGridList) do
    local stateItem = self.gridStatePool:GetOne()
    local x, y, position = self:GetAthGridPos(gridId, true)
    stateItem.transform:SetParent(self.ui.stateHolder)
    stateItem:BindAthGridClickCallback(self.__OnClickAthGrid)
    local state = self.areaGridData.gridStateList[gridId]
    if state == eAthGridState.Lock then
      stateItem:InitAthGridState(position, 1, state)
    elseif state == eAthGridState.Disable then
      stateItem:InitAthGridState(position, 0, state)
    else
      stateItem:InitAthGridState(position, 2, state)
    end
  end
  self.athItemDic = {}
  for uid, athData in pairs(self.areaGridData.athInstalledDic) do
    self:InstallAthItem(athData)
  end
  self:SetAthItemPosTween()
end

function UINAthAreaItem:SetAthAreaItemToggleOn(isOn)
  self.ui.tog_Root.isOn = isOn
end

function UINAthAreaItem:_OnClickRootToggle(isOn)
  if isOn then
    self.athMain:OnSelectAthAreaItem(self.areaId)
  end
  self:SetAthAreaItemToggleOnUI(isOn)
end

function UINAthAreaItem:ShowAthAreaItemMask(show)
  self.ui.img_Mask:SetActive(show)
end

function UINAthAreaItem:SetAthAreaItemToggleOnUI(isOn)
  if isOn then
    self.ui.img_Root.color = Color.white
    self.ui.tex_Name.color = Color.black
    self.ui.img_Icon.image.color = Color.black
  else
    self.ui.img_Root.color = self.ui.color_NormalBg
    self.ui.tex_Name.color = self.ui.color_NormalName
    self.ui.img_Icon.image.color = self.ui.color_NormalName
  end
end

function UINAthAreaItem:OnClickAthItem(athItem)
  self.athMain:OnClickAthItem(athItem, true)
end

function UINAthAreaItem:GetAthGridPos(gridId, withUnityPos)
  local y = math.ceil(gridId / AthUtil.AthGridSize.x)
  local x = gridId % AthUtil.AthGridSize.x
  if x == 0 then
    x = AthUtil.AthGridSize.x
  end
  if y > AthUtil.AthGridSize.y then
    error("AthGridPos out of range, gridId == " .. tostring(gridId))
  end
  local unityPos
  if withUnityPos then
    local uX = self.gridSizeX * (x - 1)
    local uY = self.gridSizeY * (y - 1) * -1
    unityPos = Vector2.New(uX, uY)
  end
  return x, y, unityPos
end

function UINAthAreaItem:GetAthTableItemPos(athData, gridId)
  local space = athData:GetAthSize()
  local x, y = self:GetAthGridPos(gridId)
  local uX = 0
  local uY = 0
  if space == 1 then
    uX = x - 0.5
    uY = y - 0.5
  elseif space == 2 then
    uX = x - 0.5
    uY = y
  elseif space == 4 then
    uX = x
    uY = y
  elseif space == 8 then
    uX = x
    uY = y + 1
  end
  return Vector2.New(uX * self.gridSizeX, -uY * self.gridSizeY)
end

function UINAthAreaItem:GetAthGridIdByScreenPos(worldPos, athData)
  local centerAnchordPos = UIManager:World2UIPosition(worldPos, self.ui.gridHolder, nil, UIManager.UICamera)
  centerAnchordPos.y = -centerAnchordPos.y
  local athSpace = athData:GetAthSize()
  local ltAnchordPos
  if athSpace == 1 then
    ltAnchordPos = centerAnchordPos
  else
    ltAnchordPos = {}
    if athSpace == 2 then
      ltAnchordPos.x = centerAnchordPos.x
      ltAnchordPos.y = centerAnchordPos.y - self.gridSizeY / 2
    elseif athSpace == 4 then
      ltAnchordPos.x = centerAnchordPos.x - self.gridSizeX / 2
      ltAnchordPos.y = centerAnchordPos.y - self.gridSizeY / 2
    elseif athSpace == 8 then
      ltAnchordPos.x = centerAnchordPos.x - self.gridSizeX / 2
      ltAnchordPos.y = centerAnchordPos.y - self.gridSizeY * 1.5
    end
  end
  local aPosX = ltAnchordPos.x
  local aPosY = ltAnchordPos.y
  local gridHolderSize = self.ui.gridHolder.rect.size
  if aPosX > gridHolderSize.x or aPosX < 0 or aPosY > gridHolderSize.y or aPosY < 0 then
    return
  end
  local gridX = math.ceil(aPosX / self.gridSizeX)
  local gridY = math.ceil(aPosY / self.gridSizeY)
  local gridId = (gridY - 1) * AthUtil.AthGridSize.x + gridX
  return gridId
end

function UINAthAreaItem:OnInstallAthItem(athData)
  self.areaGridData:InstallAthGridData(athData)
  self:InstallAthItem(athData)
end

function UINAthAreaItem:InstallAthItem(athData)
  local gridPos = athData.bindInfo.grid
  local space = athData:GetAthSize()
  local athItem = self:__GetAthItem(athData)
  local unityPos = self:GetAthTableItemPos(athData, gridPos)
  athItem.transform.anchoredPosition = unityPos
  self.athItemDic[athData.uid] = athItem
end

function UINAthAreaItem:OnUnInstallAthItem(uid, gridPos)
  local athItem = self.athItemDic[uid]
  if athItem == nil then
    return
  end
  local athData = athItem:GetAthItemData()
  self.areaGridData:UninstallAthGridData(athData, gridPos)
  self:__HideOneAthItem(athItem)
  self.athItemDic[uid] = nil
  if self.itemPosTweenDic ~= nil then
    local tween = self.itemPosTweenDic[uid]
    if tween ~= nil then
      tween:Kill()
      self.itemPosTweenDic[uid] = nil
    end
  end
end

function UINAthAreaItem:OnReinstallAllAthTable(athInstallDic, athInstalledDic)
  for uid, gridPos in pairs(athInstalledDic) do
    self:OnUnInstallAthItem(uid, gridPos)
  end
  for uid, gridPos in pairs(athInstallDic) do
    local athData = PlayerDataCenter.allAthData.athDic[uid]
    self:OnInstallAthItem(athData)
  end
end

function UINAthAreaItem:__GetItemSizeDelta(space)
  local x = 0
  local y = 0
  if space == 1 then
    x = self.gridSizeX
    y = self.gridSizeY
  elseif space == 2 then
    x = self.gridSizeX
    y = self.gridSizeY * 2
  elseif space == 4 then
    x = self.gridSizeX * 2
    y = self.gridSizeY * 2
  elseif space == 8 then
    x = self.gridSizeX * 2
    y = self.gridSizeY * 4
  end
  x = x - 10
  y = y - 10
  return Vector2.New(x, y)
end

function UINAthAreaItem:__GetAthItem(athData)
  local space = athData:GetAthSize()
  local pool = self.athItemPoolDic[space]
  if pool == nil then
    local go = self.athMain:GetAthItemGameObject(space)
    pool = UIItemPool.New(UINAthItem, go)
    self.athItemPoolDic[space] = pool
  end
  local item = pool:GetOne()
  item:SetAthItemDragFunc(self.dragStartFunc, true)
  item:InitAthItem(athData, self.__OnClickAthItem, self.resLoader, true)
  item.transform:SetParent(self.ui.gridHolder)
  item.transform.anchorMin = itemAnchor
  item.transform.anchorMax = itemAnchor
  item.transform.pivot = itemPivot
  item.transform.sizeDelta = self:__GetItemSizeDelta(space)
  return item
end

function UINAthAreaItem:__HideOneAthItem(athItem)
  local athData = athItem:GetAthItemData()
  local space = athData:GetAthSize()
  local pool = self.athItemPoolDic[space]
  pool:HideOne(athItem)
end

function UINAthAreaItem:__HideAllAthItem()
  for k, pool in pairs(self.athItemPoolDic) do
    pool:HideAll()
  end
end

function UINAthAreaItem:__DeleteAllAthItem()
  for k, pool in pairs(self.athItemPoolDic) do
    pool:DeleteAll()
  end
end

function UINAthAreaItem:SetAthItemPosTween()
  local duration = 0.3
  local transPos = Vector2.New(-20, 20)
  self.itemPosTweenDic = {}
  for uid, Item in pairs(self.athItemDic) do
    local toAnchoredPos = Item.transform.anchoredPosition
    Item.transform.anchoredPosition = Item.transform.anchoredPosition + transPos
    self.itemPosTweenDic[uid] = Item.transform:DOAnchorPos(toAnchoredPos, duration)
    duration = duration + 0.1
  end
end

function UINAthAreaItem:__ClearItemPosTween()
  if self.itemPosTweenDic == nil then
    return
  end
  for k, tween in pairs(self.itemPosTweenDic) do
    tween:Kill()
  end
  self.itemPosTweenDic = nil
end

function UINAthAreaItem:GetAthTableItemByUid(uid)
  return self.athItemDic[uid]
end

function UINAthAreaItem:RefreshAthAreaItemBlueDot()
  local canLoaded = PlayerDataCenter.allAthData:GetHeroCanLoadedSlot(self.heroData, self.areaId)
  self.ui.blueDot:SetActive(canLoaded)
end

function UINAthAreaItem:RefreshAthAreaItemData(updateAth)
  for uid, v in pairs(updateAth) do
    local athItem = self.athItemDic[uid]
    if athItem ~= nil then
      athItem:RereshAthItem()
    end
  end
end

function UINAthAreaItem:RefreshAthAreaItemDataAll()
  for uid, athItem in pairs(self.athItemDic) do
    athItem:RereshAthItem()
  end
end

function UINAthAreaItem:OnClickGride(state)
  if state == eAthGridState.Unlock then
    return
  elseif state == eAthGridState.Disable then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(4005))
    return
  end
  if self.heroData == nil or self.heroData:GetHeroDataTalent() == nil then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(4004))
    return
  end
  local algAreaTalent = self.heroData:GetHeroDataTalent():GetAlgorithmSpace()
  local algAreaTalentMax = ConfigData.hero_talent.maxAlgSpaceDic[self.heroData.dataId]
  if algAreaTalentMax == nil or algAreaTalentMax[self.areaId] == 0 or algAreaTalentMax[self.areaId] == algAreaTalent[self.areaId] then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(4004))
  else
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(4007))
  end
end

function UINAthAreaItem:OnDelete()
  self:__DeleteAllAthItem()
  self:__ClearItemPosTween()
  base.OnDelete(self)
end

return UINAthAreaItem
