local UINDunLevelChipSuitNode = class("UINDunLevelChipSuitNode", UIBaseNode)
local base = UIBaseNode
local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")
local UINDunLevelChipSuitNodeItem = require("Game.DungeonCenter.LevelUI.UINDunLevelChipSuitNodeItem")
local UINLevelNormalBuffItem = require("Game.Sector.SectorLevelDetail.Nodes.UINLevelNormalBuffItem")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local ChipData = require("Game.PlayerData.Item.ChipData")
local UINLevelChipQualityItem = require("Game.Sector.SectorLevelDetail.Nodes.UINLevelChipQualityItem")
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINBaseChipDetail")

function UINDunLevelChipSuitNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.loopscroll_chipsuit.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.loopscroll_chipsuit.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.__ItemDic = {}
  self.buffItemPool = UIItemPool.New(UINLevelNormalBuffItem, self.ui.obj_img_Buff)
  self.ui.obj_img_Buff:SetActive(false)
  self.__ShowBuffDescription = BindCallback(self, self.ShowBuffDescription)
  self.__HideBuffDetail = BindCallback(self, self.HideBuffDetail)
  self.chipDetailPanel = UINChipDetailPanel.New()
  self.chipDetailPanel:Init(self.ui.uINBaseChipDetail)
  self.qualityItemPool = UIItemPool.New(UINLevelChipQualityItem, self.ui.chipQualityItem)
  self.ui.chipQualityItem:SetActive(false)
  self._OnChipClick = BindCallback(self, self.OnChipClick)
end

function UINDunLevelChipSuitNode:BindDunLevelResloader(resloader)
  self.__resloader = resloader
end

function UINDunLevelChipSuitNode:InitDungeonInfoNode(dLevelDetail)
  self.__dLevelDetail = dLevelDetail
  local dunLevelData = dLevelDetail:GetDungeonLevelData()
  local dunLevelType = dunLevelData:GetDungeonLevelType()
  self.__defaultQuality = 1
  self.__chipPoolQualityDic = nil
  self.__wait2UnlockChipPoolList = nil
  self.__chipPoolList = nil
  self._showSuitIntroDic = {}
  self.__showBuffIdList = {}
  local buffListCfg = dunLevelData:GetDungeonBuffListCfg()
  for _, buffId in pairs(buffListCfg) do
    table.insert(self.__showBuffIdList, buffId)
  end
  if dunLevelType == DungeonLevelEnum.DunLevelType.SectorII or dunLevelType == DungeonLevelEnum.DunLevelType.SectorIIChallenge then
    local sectorIIData = dunLevelData:GetSectorIIActivityData()
    local chipPoolList, chipPoolQualityDic = sectorIIData:GetSectorII_ChipSuitPool()
    self.__chipPoolList = chipPoolList
    self.__chipPoolQualityDic = chipPoolQualityDic
    local wait2UnlockChipPoolList, wait4UnlockChipSuitUnlockInfoList = sectorIIData:GetSectorII_Wait4UnlockChipSuit()
    self.__wait2UnlockChipPoolList = wait2UnlockChipPoolList
    self.__wait4UnlockChipSuitUnlockInfoList = wait4UnlockChipSuitUnlockInfoList
  elseif dunLevelType == DungeonLevelEnum.DunLevelType.Tower then
    local chipList = dunLevelData:GetTowerChipSuitPool()
    self.__chipPoolList = chipList
    self.__defaultQuality = dunLevelData:GetTowerChipQuality()
  elseif dunLevelType == DungeonLevelEnum.DunLevelType.SixHeroTower then
    self.__chipPoolList = dunLevelData:GetTowerChipSuitPool() or {}
    self.__defaultQuality = dunLevelData:GetTowerChipQuality() or 0
  else
    self.__chipPoolList = {}
  end
  local actBuffUnlockDic = dunLevelData:GetDunExtraBuffDic()
  if actBuffUnlockDic ~= nil then
    for buffId, _ in pairs(actBuffUnlockDic) do
      table.insert(self.__showBuffIdList, buffId)
    end
  end
  local actBuffRemoveDic = dunLevelData:GetDunExtraDelectedBuffDic()
  if actBuffRemoveDic ~= nil then
    for i = #self.__showBuffIdList, 1, -1 do
      local buffId = self.__showBuffIdList[i]
      if actBuffRemoveDic[buffId] then
        table.remove(self.__showBuffIdList, i)
      end
    end
  end
  self:__RefreshDunBuff()
  self:__InitDunChipSuit()
  self:__InitDunChipList()
end

function UINDunLevelChipSuitNode:__InitDunChipSuit()
  local totalCount = #self.__chipPoolList
  if self.__wait2UnlockChipPoolList ~= nil then
    totalCount = totalCount + #self.__wait2UnlockChipPoolList
  end
  local isEmpty = totalCount <= 0
  self.__isChipSuitEmpty = isEmpty
  self.ui.obj_ChipSuitList:SetActive(not isEmpty)
  self.ui.obj_Empty:SetActive(isEmpty)
  if isEmpty then
    return
  end
  self.ui.loopscroll_chipsuit.totalCount = totalCount
  TimerManager:AddLateCommand(function()
    self.ui.loopscroll_chipsuit:RefillCells()
  end)
end

function UINDunLevelChipSuitNode:__OnNewItem(go)
  local item = UINDunLevelChipSuitNodeItem.New(self)
  item:Init(go)
  self.__ItemDic[go] = item
end

function UINDunLevelChipSuitNode:__OnChangeItem(go, index)
  local item = self.__ItemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  local chipPoolId
  local isUnlock = true
  local quality = self.__defaultQuality
  local unlockInfo
  local normalLength = #self.__chipPoolList
  if index < normalLength then
    chipPoolId = self.__chipPoolList[index + 1]
    if self.__chipPoolQualityDic ~= nil and self.__chipPoolQualityDic[chipPoolId] ~= nil then
      quality = self.__chipPoolQualityDic[chipPoolId]
    end
  else
    chipPoolId = self.__wait2UnlockChipPoolList[index + 1 - normalLength]
    unlockInfo = self.__wait4UnlockChipSuitUnlockInfoList[index + 1 - normalLength]
    isUnlock = false
  end
  if chipPoolId == nil then
    error("Can't find chipPoolId by index, index = " .. tonumber(index))
    return
  end
  local showIntro = self._showSuitIntroDic[chipPoolId] or false
  item:RefreshIsUnlock(isUnlock, unlockInfo)
  item:RefreshChipSuitItem(chipPoolId, quality, showIntro)
end

function UINDunLevelChipSuitNode:RecordDunChipSuitItemIntroState(chipTagId, showIntro)
  if showIntro == false then
    showIntro = nil
  end
  self._showSuitIntroDic[chipTagId] = showIntro
end

function UINDunLevelChipSuitNode:__RefreshDunBuff()
  if self.__showBuffIdList == nil or #self.__showBuffIdList == 0 then
    self.ui.obj_buff:SetActive(false)
    return
  end
  self.ui.obj_buff:SetActive(true)
  self.buffItemPool:HideAll()
  for _, buffId in pairs(self.__showBuffIdList) do
    local buffCfg = ConfigData.dungeon_buff[buffId]
    if buffCfg ~= nil then
      local buffItem = self.buffItemPool:GetOne()
      buffItem:InitBuffByCfg(buffCfg, self.__ShowBuffDescription, self.__HideBuffDetail)
    end
  end
end

function UINDunLevelChipSuitNode:ShowBuffDescription(item, buffCfg)
  local window = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  window:SetTitleAndContext(LanguageUtil.GetLocaleText(buffCfg.name), LanguageUtil.GetLocaleText(buffCfg.describe))
  window:FloatTo(item.transform, HAType.autoCenter, VAType.up, 0, 0.62)
end

function UINDunLevelChipSuitNode:HideBuffDetail(skillData)
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
  end
end

function UINDunLevelChipSuitNode:__InitDunChipList()
  local dunLevelData = self.__dLevelDetail:GetDungeonLevelData()
  self:__GenDungeonChipList(dunLevelData)
  self.ui.img_ChipSelect:SetActive(false)
  self.chipDetailPanel:Hide()
  self.selectedChipData = nil
  self.qualityItemPool:HideAll()
  if self._chipDataQualityDic == nil then
    self.ui.obj_chipSuitMain:SetActive(true)
    self.ui.obj_chipList:SetActive(false)
    return
  end
  self.ui.obj_chipList:SetActive(true)
  self.ui.obj_chipSuitMain:SetActive(not self.__isChipSuitEmpty)
  local keys = table.keys(self._chipDataQualityDic)
  table.sort(keys, function(a, b)
    return b < a
  end)
  for _, qId in ipairs(keys) do
    local chipDataList = self._chipDataQualityDic[qId]
    local qualityItem = self.qualityItemPool:GetOne()
    qualityItem:InitChipQualityItem(qId, chipDataList, self._OnChipClick)
  end
end

function UINDunLevelChipSuitNode:__GenDungeonChipList(dunLevelData)
  local enter_chip_select = dunLevelData:GetEnterChipSelectCfg()
  if #enter_chip_select == 0 then
    self._chipDataQualityDic = nil
    return
  end
  self._chipDataQualityDic = {}
  local chipSet = {}
  for _, chipGroup in pairs(enter_chip_select) do
    for index, chipId in pairs(chipGroup.chip_ids) do
      if chipSet[chipId] == nil then
        chipSet[chipId] = true
        local chipLevel = chipGroup.chip_lvs[index]
        local chipData = ChipData.New(chipId, chipLevel)
        local qua = chipData:GetQuality()
        if self._chipDataQualityDic[qua] == nil then
          self._chipDataQualityDic[qua] = {}
        end
        table.insert(self._chipDataQualityDic[qua], chipData)
      end
    end
  end
end

function UINDunLevelChipSuitNode:OnChipClick(chipData, chipItem)
  if self.selectedChipData == chipData or not chipData then
    self.ui.img_ChipSelect:SetActive(false)
    self.chipDetailPanel:Hide()
    self.selectedChipData = nil
  else
    self.selectedChipData = chipData
    self.ui.img_ChipSelect:SetActive(true)
    self.ui.img_ChipSelect.transform.position = chipItem.transform.position
    self.ui.img_ChipSelect.transform:SetParent(chipItem.transform)
    self.chipDetailPanel:Show()
    self.chipDetailPanel:InitBaseChipDetail(nil, chipData, nil, self.__resloader, nil, true, false)
  end
end

function UINDunLevelChipSuitNode:OnDelete()
  if self.chipDetailPanel ~= nil then
    self.chipDetailPanel:Delete()
    self.chipDetailPanel = nil
  end
  if self.__ItemDic ~= nil then
    for k, v in pairs(self.__ItemDic) do
      v:Delete()
    end
    self.__ItemDic = nil
  end
  base.OnDelete(self)
end

return UINDunLevelChipSuitNode
