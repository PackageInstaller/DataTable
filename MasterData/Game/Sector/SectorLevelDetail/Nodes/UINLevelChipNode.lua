local UINLevelChipNode = class("UINLevelChipNode", UIBaseNode)
local base = UIBaseNode
local UINLevelChipQualityItem = require("Game.Sector.SectorLevelDetail.Nodes.UINLevelChipQualityItem")
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINBaseChipDetail")
local UINLevelNormalBuffItem = require("Game.Sector.SectorLevelDetail.Nodes.UINLevelNormalBuffItem")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local ChipData = require("Game.PlayerData.Item.ChipData")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local eDetailType = SectorLevelDetailEnum.eDetailType
local SectorEnum = require("Game.Sector.SectorEnum")

function UINLevelChipNode:OnInit()
  self.chipDataQualityDic = nil
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.chipDetailPanel = UINChipDetailPanel.New()
  self.chipDetailPanel:Init(self.ui.uINChipItemDetail)
  self.qualityItemPool = UIItemPool.New(UINLevelChipQualityItem, self.ui.chipQualityItem)
  self.ui.chipQualityItem:SetActive(false)
  self._OnChipClick = BindCallback(self, self.OnChipClick)
  self.buffItemPool = UIItemPool.New(UINLevelNormalBuffItem, self.ui.obj_img_Buff)
  self.ui.obj_img_Buff:SetActive(false)
  self.__ShowBuffDescription = BindCallback(self, self.ShowBuffDescription)
  self.__HideBuffDetail = BindCallback(self, self.HideBuffDetail)
end

function UINLevelChipNode:InitInfoNode(LevelDtail, chipDataQualityDic, resloader)
  self.levelDtail = LevelDtail
  self.__resloader = resloader
  if LevelDtail.detailType ~= eDetailType.Avg and LevelDtail.detailType ~= eDetailType.None then
    self.chipDataQualityDic = chipDataQualityDic
  else
    return
  end
  if LevelDtail.detailType == eDetailType.Stage then
    local stageCfg = LevelDtail.stageCfg
    self:RefreshBuffs(stageCfg.buff_id, stageCfg.sector == SectorEnum.NewbeeSectorId)
    self:GenInitialChipList(stageCfg.function_id, stageCfg.function_level)
    self.ui.obj_originRes:SetActive(false)
  elseif LevelDtail.detailType == eDetailType.Infinity then
    local num = 0
    local bestCompleteLevelData = LevelDtail.levelData.bestCompleteLevelData
    if bestCompleteLevelData ~= nil then
      num = bestCompleteLevelData.cfg.resource_itemNums[1]
    end
    self.ui.tex_OriginRes:SetIndex(0, tostring(num))
    self.ui.obj_originRes:SetActive(true)
    local infinityCfg = LevelDtail.levelData.cfg
    self:RefreshBuffs(infinityCfg.buff_id)
    self:GenInitialChipList(infinityCfg.function_id, infinityCfg.function_level)
  elseif LevelDtail.detailType == eDetailType.PeriodicChallenge then
    local eChallengeType = LevelDtail.eChallengeType
    self:RefreshBuffs(PlayerDataCenter.periodicChallengeData:GetChallengeBuffList(eChallengeType))
    self:GenInitialChipList(nil)
    self.ui.obj_originRes:SetActive(false)
  elseif LevelDtail.detailType == eDetailType.WeeklyChallenge then
    self:RefreshBuffs(PlayerDataCenter.allWeeklyChallengeData.dataDic[LevelDtail.challengeId].buffList)
    self:GenInitialChipList(nil)
    self.ui.obj_originRes:SetActive(false)
  elseif LevelDtail.detailType == eDetailType.Warchess then
    self.ui.obj_originRes:SetActive(false)
  elseif LevelDtail.detailType == eDetailType.Brotato then
    local stageCfg = LevelDtail.stageCfg
    self:RefreshBuffs(stageCfg.buff_id, stageCfg.sector == SectorEnum.NewbeeSectorId)
    self:GenInitialChipList(stageCfg.function_id, stageCfg.function_level)
    self.ui.obj_originRes:SetActive(false)
  else
    error("error level type:" .. tostring(LevelDtail.detailType))
  end
  self:Sort()
  self:RefreshChipQualityItems()
  self.ui.img_ChipSelect:SetActive(false)
  self.chipDetailPanel:Hide()
end

function UINLevelChipNode:GenInitialChipList(chip_ids, function_level)
  if chip_ids == nil or #chip_ids == 0 then
    self.initialChipList = nil
    return
  end
  self.initialChipList = {}
  for index, chipId in pairs(chip_ids) do
    local chipData = ChipData.New(chipId, function_level[index] or 1)
    table.insert(self.initialChipList, chipData)
  end
end

function UINLevelChipNode:Sort()
  for key, list in pairs(self.chipDataQualityDic) do
    table.sort(list, function(chip1, chip2)
      if chip1.isLock == chip2.isLock then
        return chip1.dataId < chip2.dataId
      elseif chip1.isLock then
        return false
      else
        return true
      end
    end)
  end
end

function UINLevelChipNode:RefreshChipQualityItems()
  self.qualityItemPool:HideAll()
  local keys = table.keys(self.chipDataQualityDic)
  table.sort(keys, function(a, b)
    return b < a
  end)
  if self.initialChipList ~= nil then
    local qualityItem = self.qualityItemPool:GetOne()
    qualityItem:InitChipQualityItem(eItemQualityType.Orange, self.initialChipList, self._OnChipClick, true)
  end
  for _, qId in ipairs(keys) do
    local chipDataList = self.chipDataQualityDic[qId]
    local qualityItem = self.qualityItemPool:GetOne()
    qualityItem:InitChipQualityItem(qId, chipDataList, self._OnChipClick)
  end
end

function UINLevelChipNode:OnChipClick(chipData, chipItem)
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

function UINLevelChipNode:RefreshBuffs(buffList, isNewbee)
  local list = {}
  local additionalBuffList = self.levelDtail:GetShowAdditionBuffList()
  if additionalBuffList ~= nil then
    table.insertto(list, additionalBuffList)
  end
  if buffList ~= nil then
    table.insertto(list, buffList)
  end
  self.ui.obj_buffNode:SetActive(list ~= nil and 0 < #list and not isNewbee)
  if list == nil or #list == 0 then
    return
  end
  self:SetBuffNodeTitle(ConfigData:GetTipContent(TipContent.SctLevelBuffNodeTitle))
  self.buffItemPool:HideAll()
  local count = 0
  for _, buffId in ipairs(list) do
    local buffCfg = ConfigData.exploration_buff[buffId]
    if buffCfg ~= nil and buffCfg.is_listshow then
      count = count + 1
      local buffItem = self.buffItemPool:GetOne()
      buffItem:InitBuffByCfg(buffCfg, self.__ShowBuffDescription, self.__HideBuffDetail)
    end
  end
  if count == 0 then
    self.ui.obj_buffNode:SetActive(false)
  end
end

function UINLevelChipNode:SetBuffNodeTitle(des)
  self.ui.tex_buffNodeTitle.text = des
end

function UINLevelChipNode:ShowBuffDescription(item, buffCfg)
  local window = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  window:SetTitleAndContext(LanguageUtil.GetLocaleText(buffCfg.name), LanguageUtil.GetLocaleText(buffCfg.describe))
  window:FloatTo(item.transform, HAType.autoCenter, VAType.up, 0, 0.62)
end

function UINLevelChipNode:HideBuffDetail(skillData)
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
  end
end

function UINLevelChipNode:OnDelete()
  self.chipDetailPanel:Delete()
  if self.buffItemPool ~= nil then
    self.buffItemPool:DeleteAll()
  end
  self:HideBuffDetail()
  base.OnDelete(self)
end

return UINLevelChipNode
