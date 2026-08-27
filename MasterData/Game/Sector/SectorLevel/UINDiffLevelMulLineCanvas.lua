local UINDiffLevelMulLineCanvas = class("UINDiffLevelMulLineCanvas", UIBaseNode)
local base = UIBaseNode
local UINLevelMulLineGroup = require("Game.Sector.SectorLevel.UINLevelMulLineGroup")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local sectorLevelUtil = require("Game.Sector.SectorLevel.SectorLevelUtil")
local cs_Material = CS.UnityEngine.Material
local LoopVerticalScrollRect = CS.UnityEngine.UI.LoopVerticalScrollRect
local LoopHorizontalScrollRect = CS.UnityEngine.UI.LoopHorizontalScrollRect
local UINActChapterItem = require("Game.ActivitySummer.UI.Sector.UINActChapterItem")
local CS_Ease = CS.DG.Tweening.Ease

function UINDiffLevelMulLineCanvas:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__levelGroupUI = {}
  UIUtil.LuaUIBindingTable(self.ui.levelGroup.transform, self.__levelGroupUI)
  UIUtil.AddButtonListener(self.ui.contentVertical, self, self.__OnClickBg)
  UIUtil.AddButtonListener(self.ui.contentHorizontal, self, self.__OnClickBg)
  self.__inited = false
  self.scrollItemGoDic = {}
  self.scrollItemPageIdDic = {}
  self._sectorStageIdGroupMapping = {}
  self._sectorAvgIdGroupMapping = {}
  self.lastCompletedStage = {
    groupIndex = nil,
    id = nil,
    isState = nil
  }
end

function UINDiffLevelMulLineCanvas:InitDiffLevelCanvas(sectorId, autoStateCfg, isUnCompleteEp, difficulty, levelItemClickEvent, levelAvgMainClickEvent, lAvgSubClickEvent, tweenCompleteEvent, resLoader, sectorLevelTipsGuides, clickBackFunc)
  local isNeedInitData = self.sectorId ~= sectorId or self.difficulty ~= difficulty
  self.sectorId = sectorId
  if isUnCompleteEp then
    self.lastEpStateCfg = autoStateCfg
  else
    self.lastEpStateCfg = nil
  end
  self.spDic = self:GenAllSpecialListDic()
  self.difficulty = difficulty
  self.levelItemClickEvent = levelItemClickEvent
  self.levelAvgMainClickEvent = levelAvgMainClickEvent
  self.lAvgSubClickEvent = lAvgSubClickEvent
  self.tweenCompleteEvent = tweenCompleteEvent
  self.resLoader = resLoader
  self.sectorLevelTipsGuides = sectorLevelTipsGuides
  self.clickBackFunc = clickBackFunc
  local locateStageId, isWin
  if PlayerDataCenter.sectorStage.lastSatgeData ~= nil then
    locateStageId = PlayerDataCenter.sectorStage.lastSatgeData.stageCfg.id
    isWin = PlayerDataCenter.sectorStage.lastSatgeData.isWin
  elseif autoStateCfg ~= nil then
    locateStageId = autoStateCfg.id
    isWin = false
  end
  self.isWin = isWin
  local sectorCfg = ConfigData.sector[sectorId]
  local levelArrangeType = sectorCfg.level_arrange[difficulty]
  local arrangeCfg = ConfigData.level_arrange[levelArrangeType]
  if arrangeCfg == nil then
    error(string.format("Can't find level arrange Cfg,arrangeId:%s, difficulty:%s, sectorId:%s", levelArrangeType, difficulty, sectorId))
    return
  end
  self.arrangeCfg = arrangeCfg
  local isVertical = arrangeCfg[1].vertical
  local verticalChange = self.isVertical ~= nil and self.isVertical ~= isVertical
  self.isVertical = isVertical
  if self.__inited then
    if verticalChange then
      self.ui.scrollRect:ClearCells()
      local prefabSource = self.ui.scrollRect:GetPrefabSource()
      DestroyUnityObject(self.ui.scrollRect, true)
      self:AddScrollRect(prefabSource)
    end
  else
    self:AddScrollRect()
  end
  self.__inited = true
  if isNeedInitData or self.specialLevelList then
    self:InitLevelGroupData()
  end
  if locateStageId ~= nil then
    local pageId = self._sectorStageIdGroupMapping[locateStageId]
    if pageId ~= nil then
      self.lastCompletedStage.groupIndex = pageId
      self.lastCompletedStage.id = locateStageId
      self.lastCompletedStage.isState = true
    end
  end
  self:RefillScrollRect(isWin == false)
end

function UINDiffLevelMulLineCanvas:SetDungeonListInSector(dungeonDataDic, clickDungeonItemEvent, blueReddotFunc)
end

function UINDiffLevelMulLineCanvas:SetSpecialLevelList(specialLevelList)
  self.specialLevelList = specialLevelList
end

function UINDiffLevelMulLineCanvas:SetSpecialLevelState(state)
  self.levelState = state
end

function UINDiffLevelMulLineCanvas:ResetLevelGroupDataBySpecialLevelList(specialLevelList)
  self.specialLevelList = specialLevelList
  self:InitLevelGroupData()
  self:RefillScrollRect(self.isWin)
end

function UINDiffLevelMulLineCanvas:SetBackground(texture)
  if not IsNull(texture) then
    self.ui.Img_background.texture = texture
  end
end

function UINDiffLevelMulLineCanvas:InitLevelGroupData()
  self.finalPage = nil
  self.splitPointPage = nil
  self.layourDic = nil
  self.levelGroupDataList, self.lastLocalsDataList, self.lastCompletedStage, self.finalPage, self._sectorStageIdGroupMapping, self._sectorAvgIdGroupMapping = sectorLevelUtil.GetLevelGroupByNormalMulLine(self.arrangeCfg, self:GetLevelList(), self._sectorStageIdGroupMapping, self._sectorAvgIdGroupMapping)
end

function UINDiffLevelMulLineCanvas:GetLevelList()
  return ConfigData.sector_stage.sectorDiffDic[self.sectorId][self.difficulty]
end

function UINDiffLevelMulLineCanvas:AddScrollRect(prefabSource)
  self.ui.scrollRectGo:SetActive(false)
  if self.isVertical then
    self.ui.scrollRect = self.ui.scrollRectGo:AddComponent(typeof(LoopVerticalScrollRect))
    self.ui.scrollRect.horizontal = false
    self.ui.scrollRect.content = self.ui.contentVertical.transform
  else
    self.ui.scrollRect = self.ui.scrollRectGo:AddComponent(typeof(LoopHorizontalScrollRect))
    self.ui.scrollRect.vertical = false
    self.ui.scrollRect.content = self.ui.contentHorizontal.transform
  end
  if prefabSource == nil then
    self.ui.scrollRect:SetPrefab(self.ui.levelGroup)
  else
    self.ui.scrollRect:SetPrefabSource(prefabSource)
  end
  self.ui.scrollRectGo:SetActive(true)
  self.ui.scrollRect.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.scrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.ui.scrollRect.onReturnItem = BindCallback(self, self.__OnReturnItem)
end

function UINDiffLevelMulLineCanvas:LocationSectorStageItem(id, isAvg)
  isAvg = isAvg or false
  local levelItem, groupItem, pageId
  if isAvg then
    levelItem, groupItem, pageId = self:GetSectorLAvgMainItem(id)
  else
    levelItem, groupItem, pageId = self:GetSectorStageItem(id)
  end
  if levelItem == nil then
    return nil, nil
  end
  self.lastCompletedStage.groupIndex = pageId
  self.lastCompletedStage.id = id
  self.lastCompletedStage.isState = not isAvg
  self:RefillScrollRect()
  return levelItem, groupItem
end

function UINDiffLevelMulLineCanvas:GetSectorStageItem(stageId)
  local pageIndex = self._sectorStageIdGroupMapping[stageId]
  if pageIndex == nil then
    return
  end
  local groupItem = self:GetLevelGroupItemByIndex(pageIndex)
  if groupItem == nil then
    return
  end
  return groupItem:GetLevelItemByIndex(stageId, true), groupItem, pageIndex
end

function UINDiffLevelMulLineCanvas:GetSectorLAvgMainItem(avgId)
  local pageIndex = self._sectorAvgIdGroupMapping[avgId]
  if pageIndex == nil then
    return
  end
  local groupItem = self:GetLevelGroupItemByIndex(pageIndex)
  if groupItem == nil then
    return
  end
  return groupItem:GetLevelItemByIndex(avgId, false), groupItem, pageIndex
end

function UINDiffLevelMulLineCanvas:SetSectorStageItemBlueDot(stageId, show)
  local levelItem = self:GetSectorStageItem(stageId)
  if levelItem ~= nil then
    levelItem:ShowBlueDotLevelItem(show)
  end
end

function UINDiffLevelMulLineCanvas:SetStopTweenCompleteEvent(bool)
end

function UINDiffLevelMulLineCanvas:PlayDiffLevelCanvasSwitchTween(isUpTween)
  self:OnSwitchTweenComplete()
end

function UINDiffLevelMulLineCanvas:OnSwitchTweenComplete()
  self:OnSwitchTweenEndEvent()
end

function UINDiffLevelMulLineCanvas:OnSwitchTweenRewind()
end

function UINDiffLevelMulLineCanvas:OnSwitchTweenEndEvent()
  if self.tweenCompleteEvent ~= nil then
    self.tweenCompleteEvent()
  end
end

function UINDiffLevelMulLineCanvas:SetSectorLAvgMainItemBlueDot(avgId, show)
  local lAvgMainItem = self:GetSectorLAvgMainItem(avgId)
  if lAvgMainItem ~= nil then
    lAvgMainItem:ShowBlueDotLAvgMain(show)
  end
end

function UINDiffLevelMulLineCanvas:RefillScrollRect(isOpenInfo)
  self.scrollItemPageIdDic = {}
  local selectId = self.lastCompletedStage.id or 0
  local isState = self.lastCompletedStage.isState or false
  local groupIndex = self.lastCompletedStage.groupIndex or 1
  self.ui.scrollRect.totalCount = #self.levelGroupDataList
  local indexOffset = groupIndex - 1
  local posOffset = 0
  if 0 < selectId then
    for layoutId, grouDatas in pairs(self.levelGroupDataList[groupIndex]) do
      for index, groupData in ipairs(grouDatas) do
        if isState and groupData.stageCfg ~= nil and groupData.stageCfg.id == selectId or not isState and groupData.avgCfg ~= nil and groupData.avgCfg.id == selectId then
          local arrange = ConfigData.level_arrange[layoutId][index]
          posOffset = self.isVertical and -arrange.pos[2] - self.__levelGroupUI.padding - self.__levelGroupUI.lastPadding or arrange.pos[1] - self.__levelGroupUI.padding - self.__levelGroupUI.lastPadding
        end
      end
    end
    posOffset = posOffset + self.__levelGroupUI.lastPadding
  end
  local remainLength = 0
  for i = groupIndex, #self.levelGroupDataList do
    local pageContent = self.levelGroupDataList[i]
    local endPos
    for layoutId, grouDatas in pairs(pageContent) do
      local arrangeCfg = ConfigData.level_arrange[layoutId]
      local lastArrange = arrangeCfg[#grouDatas]
      local tempEndPos = self.isVertical and lastArrange.pos[2] or lastArrange.pos[1]
      if endPos == nil or self.isVertical and endPos > tempEndPos or endPos < tempEndPos then
        endPos = tempEndPos
      end
    end
    endPos = endPos ~= nil and endPos or 0
    remainLength = remainLength + math.abs(endPos) + self.__levelGroupUI.padding
  end
  remainLength = remainLength - posOffset
  local viewLength = self.isVertical and self.transform.rect.height or self.transform.rect.width
  if remainLength > viewLength then
    self.ui.scrollRect:RefillCells(indexOffset, posOffset)
  else
    self.ui.scrollRect:RefillCellsFromEnd()
  end
  if isOpenInfo then
    local groupItem = self:GetLevelGroupItemByIndex(groupIndex)
    if groupItem ~= nil then
      local item = groupItem:GetLevelItemByIndex(selectId, isState)
      if item ~= nil and item.stageCfg ~= nil then
        item:OnClickLevelItem()
      else
        error("want to open a not levelItem's info, groupIndex:" .. tostring(groupIndex) .. ", id:" .. tostring(selectId))
      end
    end
  end
end

function UINDiffLevelMulLineCanvas:__OnNewItem(go)
  local item = UINLevelMulLineGroup.New()
  item:Init(go)
  self.scrollItemGoDic[go] = item
  self:_CalculateScrollRectWidth()
end

function UINDiffLevelMulLineCanvas:__OnReturnItem(go)
  local item = self.scrollItemGoDic[go]
  if item == nil then
    error("OnReturnItem : Can't find item by gameObject")
    return
  end
  item:OnReturnLevelGroup()
  self:_CalculateScrollRectWidth()
end

function UINDiffLevelMulLineCanvas:__OnChangeItem(go, index)
  local item = self.scrollItemGoDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  local pageId = index + 1
  local lastIndex = self.scrollItemPageIdDic[go]
  self.scrollItemPageIdDic[go] = pageId
  local levelGroupData = self.levelGroupDataList[pageId]
  local lastLocals = self.lastLocalsDataList[pageId - 1]
  item:SetSpecialLevelState(self.levelState)
  item:SetAllSpecialListDic(self.spDic)
  item:GenGroup(levelGroupData, lastLocals, self.finalPage == pageId, self.resLoader, self.ui.lineHolder, self.levelItemClickEvent, self.levelAvgMainClickEvent, self.sectorLevelTipsGuides, self.lastEpStateCfg, self.sectorId)
  for _, content in pairs(levelGroupData) do
    for _, v in ipairs(content) do
      if v.stageCfg ~= nil then
        local levelItem = item:GetLevelItemByIndex(v.stageCfg.id, true)
        if levelItem ~= nil then
          local showBlueDot = PlayerDataCenter.sectorStage:IsStageUnlock(v.stageCfg.id) and not PlayerDataCenter.sectorStage:IsStageComplete(v.stageCfg.id)
          levelItem:ShowBlueDotLevelItem(showBlueDot)
        end
      elseif v.avgCfg ~= nil then
        local lAvgMainItem = item:GetLevelItemByIndex(v.avgCfg.id, false)
        if lAvgMainItem ~= nil then
          local avgId = v.avgCfg.id
          local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
          local showBlueDot = avgPlayCtrl:IsAvgUnlock(avgId) and not avgPlayCtrl:IsAvgPlayed(avgId)
          lAvgMainItem:ShowBlueDotLAvgMain(showBlueDot)
        end
      end
    end
  end
  self:_CalculateScrollRectWidth()
end

function UINDiffLevelMulLineCanvas:GenAllSpecialListDic()
  return nil
end

function UINDiffLevelMulLineCanvas:GetLevelGroupItemByIndex(index)
  local go = self.ui.scrollRect:GetCellByIndex(index - 1)
  return self.scrollItemGoDic[go]
end

function UINDiffLevelMulLineCanvas:RefreshUncompletedEp(lastEpStateCfg)
  self.lastEpStateCfg = lastEpStateCfg
  for k, v in ipairs(self.levelGroupDataList) do
    local groupItem = self:GetLevelGroupItemByIndex(k)
    if groupItem ~= nil then
      groupItem:RefreshUncompletedEp(lastEpStateCfg)
    end
  end
end

function UINDiffLevelMulLineCanvas:RefreshLevelState()
  for k, v in ipairs(self.levelGroupDataList) do
    local groupItem = self:GetLevelGroupItemByIndex(k)
    if groupItem ~= nil then
      groupItem:RefreshLevelItemState()
    end
  end
end

function UINDiffLevelMulLineCanvas:PlayDiffLevelContentTween(duration)
  if not self.isVertical then
    return
  end
  if self.contentVerticalTween ~= nil then
    self.contentVerticalTween:Kill()
  end
  self.contentVerticalTween = self.ui.contentVertical.transform:DOAnchorPosX(0, duration):SetEase(CS_Ease.InQuad)
end

function UINDiffLevelMulLineCanvas:__OnClickBg()
  if self.clickBackFunc ~= nil then
    self.clickBackFunc()
  end
end

function UINDiffLevelMulLineCanvas:_CalculateScrollRectWidth()
  local width = 0
  for go, item in pairs(self.scrollItemGoDic) do
    local sizeDelta, _ = item:GetGroupSizeDelta()
    width = sizeDelta.x + width
  end
  local vec = Vector2.New(width, 0)
  self.ui.rect_Chapter.sizeDelta = vec
  self.ui.rect_Lock.sizeDelta = vec
end

function UINDiffLevelMulLineCanvas:GetSectorDungeonItem(dungeonId)
  return nil
end

function UINDiffLevelMulLineCanvas:OnDelete()
  if self.contentVerticalTween ~= nil then
    self.contentVerticalTween:Kill()
  end
  for k, v in pairs(self.scrollItemGoDic) do
    v:Delete()
  end
  self.resLoader = nil
  base.OnDelete(self)
end

return UINDiffLevelMulLineCanvas
