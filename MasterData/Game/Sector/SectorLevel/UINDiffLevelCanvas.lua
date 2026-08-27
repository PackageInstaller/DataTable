local UINDiffLevelCanvas = class("UINDiffLevelCanvas", UIBaseNode)
local base = UIBaseNode
local cs_Material = CS.UnityEngine.Material
local UINLevelGroup = require("Game.Sector.SectorLevel.UINLevelGroup")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local LoopVerticalScrollRect = CS.UnityEngine.UI.LoopVerticalScrollRect
local LoopHorizontalScrollRect = CS.UnityEngine.UI.LoopHorizontalScrollRect
local CS_Ease = CS.DG.Tweening.Ease
local CheckerTypeId = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))

function UINDiffLevelCanvas:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__levelGroupUI = {}
  UIUtil.LuaUIBindingTable(self.ui.levelGroup.transform, self.__levelGroupUI)
  UIUtil.AddButtonListener(self.ui.contentVertical, self, self.__OnClickBg)
  UIUtil.AddButtonListener(self.ui.contentHorizontal, self, self.__OnClickBg)
  self.__inited = false
  self.ui.switchTween.onComplete:AddListener(BindCallback(self, self.OnSwitchTweenComplete))
  self.ui.switchTween.onRewind:AddListener(BindCallback(self, self.OnSwitchTweenRewind))
  self.scrollItemGoDic = {}
end

function UINDiffLevelCanvas:InitDiffLevelCanvas(sectorId, autoStateCfg, isUnCompleteEp, difficulty, levelItemClickEvent, levelAvgMainClickEvent, lAvgSubClickEvent, tweenCompleteEvent, resLoader, sectorLevelTipsGuides, clickBackFunc)
  self.sectorId = sectorId
  if isUnCompleteEp then
    self.lastEpStateCfg = autoStateCfg
  else
    self.lastEpStateCfg = nil
  end
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
  local sectorCfg = ConfigData.sector[sectorId]
  local levelArrangeType = sectorCfg.level_arrange[difficulty]
  local arrangeCfg = ConfigData.level_arrange[levelArrangeType]
  if arrangeCfg == nil then
    error(string.format("Can't find level arrange Cfg,arrangeId:%s, difficulty:%s, sectorId:%s", levelArrangeType, difficulty, sectorId))
    return
  end
  self.arrangeCfg = arrangeCfg
  self:InitLevelGroupData(locateStageId)
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
  self.ui.scrollRect.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.scrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.ui.scrollRect.onReturnItem = BindCallback(self, self.__OnReturnItem)
  self.__inited = true
  self:RefillScrollRect(isWin == false)
  self:RefreshHardModeFx(difficulty)
end

function UINDiffLevelCanvas:SetBackground(texture)
  self.ui.Img_background.texture = texture
end

function UINDiffLevelCanvas:SetDungeonListInSector(dungeonDataDic, clickDungeonItemEvent, blueReddotFunc)
  self._clickDungeonItemEvent = clickDungeonItemEvent
  self._dungeonDataDic = dungeonDataDic
  self._pageDungonDic = {}
  self._dungeonBlueReddotFunc = blueReddotFunc
  local sectorPageDic = {}
  for pageId, pageList in ipairs(self.levelGroupDataList) do
    for i, v in ipairs(pageList) do
      if v.stageCfg ~= nil then
        sectorPageDic[v.stageCfg.id] = pageId
      end
    end
  end
  local lastPageId = 1
  for _, dungeonData in pairs(dungeonDataDic) do
    local dungeonId = dungeonData:GetDungeonLevelStageId()
    local dungeonCfg = ConfigData.battle_dungeon[dungeonId]
    local index = table.indexof(dungeonCfg.pre_condition, CheckerTypeId.CompleteStage)
    if index then
      local stageId = dungeonCfg.pre_para1[index]
      local pageId = sectorPageDic[stageId]
      if pageId ~= nil then
        lastPageId = lastPageId < pageId and pageId or lastPageId
        local pagetable = self._pageDungonDic[pageId]
        if pagetable == nil then
          pagetable = {
            dungeon = {}
          }
          self._pageDungonDic[pageId] = pagetable
        end
        local dungeonStageMapping = pagetable.dungeon
        dungeonStageMapping[dungeonId] = stageId
      end
    end
  end
  local dungeonIndex = 1
  for i = 1, lastPageId do
    if self._pageDungonDic[i] ~= nil then
      self._pageDungonDic[i].startIndex = dungeonIndex
      dungeonIndex = dungeonIndex + table.count(self._pageDungonDic[i].dungeon)
    end
  end
  for pageId, _ in ipairs(self.levelGroupDataList) do
    local dungeonStageMapping = self._pageDungonDic[pageId]
    if dungeonStageMapping ~= nil then
      local groupItem = self:GetLevelGroupItemByIndex(pageId)
      if groupItem ~= nil then
        groupItem:InsetDungeonInSectorGroup(dungeonStageMapping, self._dungeonDataDic, self.ui.lineHolder, self._clickDungeonItemEvent, self._dungeonBlueReddotFunc)
      end
    end
  end
end

function UINDiffLevelCanvas:InitLevelGroupData(locateStageId)
  local levelGroupDataList = {}
  local groupCount = #self.arrangeCfg
  self.lastCompletedStage = {groupIndex = nil, index = nil}
  local index = 0
  local groupIndex = 0
  local tempList = {}
  local stageCount = 0
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  
  local function AddTempListFunc(cfg, isState)
    stageCount = stageCount + 1
    if index + 1 > groupCount then
      index = 0
      tempList = {}
    end
    if index == 0 then
      groupIndex = groupIndex + 1
      table.insert(levelGroupDataList, tempList)
      tempList.startIndex = stageCount
    end
    index = index + 1
    local tab = {}
    if isState then
      tab.stageCfg = cfg
    else
      tab.avgCfg = cfg
    end
    table.insert(tempList, tab)
    if self.lastEpStateCfg ~= nil then
      if isState and cfg.id == self.lastEpStateCfg.id then
        self.lastCompletedStage.groupIndex = groupIndex
        self.lastCompletedStage.index = index
      end
    elseif locateStageId ~= nil and isState and cfg.id == locateStageId then
      self.lastCompletedStage.groupIndex = groupIndex
      self.lastCompletedStage.index = index
    elseif locateStageId == nil and (isState and PlayerDataCenter.sectorStage:IsStageComplete(cfg.id) or not isState and avgPlayCtrl:IsAvgPlayed(cfg.id)) then
      self.lastCompletedStage.groupIndex = groupIndex
      self.lastCompletedStage.index = index
    end
  end
  
  local sectorCfg = ConfigData.sector_stage.sectorDiffDic[self.sectorId]
  local sectorStageCfg = sectorCfg ~= nil and sectorCfg[self.difficulty] or nil
  if sectorStageCfg ~= nil then
    for k, stageId in ipairs(sectorStageCfg) do
      local para2num = avgPlayCtrl:GetMainAvgPara2Num(stageId, 1)
      for i = 0, para2num - 1 do
        local avgCfg = avgPlayCtrl:TryGetAvgCfg(eAvgTriggerType.MainAvg, stageId, 1, i)
        if avgCfg ~= nil then
          AddTempListFunc(avgCfg, false)
        end
      end
      local stage = ConfigData.sector_stage[stageId]
      if not CS.ClientConsts.IsAudit or self.sectorId == 1 or self.sectorId == 100 or stage.fixed_hero_team == 0 then
        AddTempListFunc(stage, true)
      end
      local para2num = avgPlayCtrl:GetMainAvgPara2Num(stageId, 2)
      for i = 0, para2num - 1 do
        local avgCfg = avgPlayCtrl:TryGetAvgCfg(eAvgTriggerType.MainAvg, stageId, 2, i)
        if avgCfg ~= nil then
          AddTempListFunc(avgCfg, false)
        end
      end
    end
  end
  local avgIds = ConfigData.story_avg.sectorAvgDic[self.sectorId]
  if avgIds ~= nil then
    for i, avgId in ipairs(avgIds) do
      AddTempListFunc(ConfigData.story_avg[avgId], false)
    end
  end
  self.stageCount = stageCount
  self.levelGroupDataList = levelGroupDataList
end

function UINDiffLevelCanvas:AddScrollRect(prefabSource)
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
end

function UINDiffLevelCanvas:LocationSectorStageItem(id, isAvg)
  isAvg = isAvg or false
  for groupIndex, group in pairs(self.levelGroupDataList) do
    for index, data in ipairs(group) do
      if isAvg then
        if data.avgCfg ~= nil and data.avgCfg.id == id then
          self.lastCompletedStage.groupIndex = groupIndex
          self.lastCompletedStage.index = index
          self:RefillScrollRect()
          local groupItem = self:GetLevelGroupItemByIndex(groupIndex)
          if groupItem ~= nil then
            return groupItem:GetLevelItemByIndex(index), groupItem
          end
          return nil, nil
        end
      elseif data.stageCfg ~= nil and data.stageCfg.id == id then
        self.lastCompletedStage.groupIndex = groupIndex
        self.lastCompletedStage.index = index
        self:RefillScrollRect()
        local groupItem = self:GetLevelGroupItemByIndex(groupIndex)
        if groupItem ~= nil then
          return groupItem:GetLevelItemByIndex(index), groupItem
        end
        return nil, nil
      end
    end
  end
end

function UINDiffLevelCanvas:SetSpecialLevelList(specialLevelList)
  self.specialLevelList = specialLevelList
end

function UINDiffLevelCanvas:GetSectorStageItem(stageId)
  for groupIndex, group in pairs(self.levelGroupDataList) do
    for index, data in ipairs(group) do
      if data.stageCfg ~= nil and data.stageCfg.id == stageId then
        local groupItem = self:GetLevelGroupItemByIndex(groupIndex)
        if groupItem ~= nil then
          local levelItem = groupItem:GetLevelItemByIndex(index)
          return levelItem
        end
        return
      end
    end
  end
end

function UINDiffLevelCanvas:SetSectorStageItemBlueDot(stageId, show)
  local levelItem = self:GetSectorStageItem(stageId)
  if levelItem ~= nil then
    levelItem:ShowBlueDotLevelItem(show)
  end
end

function UINDiffLevelCanvas:GetSectorLAvgMainItem(avgId)
  for groupIndex, group in pairs(self.levelGroupDataList) do
    for index, data in ipairs(group) do
      if data.avgCfg ~= nil and data.avgCfg.id == avgId then
        local groupItem = self:GetLevelGroupItemByIndex(groupIndex)
        if groupItem ~= nil then
          local lAvgMainItem = groupItem:GetLevelItemByIndex(index)
          return lAvgMainItem
        end
        return
      end
    end
  end
end

function UINDiffLevelCanvas:GetSectorDungeonItem(dungeonId)
  if self._pageDungonDic == nil then
    return
  end
  for groupIndex, dungeonDic in pairs(self._pageDungonDic) do
    if dungeonDic[dungeonId] ~= nil then
      local groupItem = self:GetLevelGroupItemByIndex(groupIndex)
      if groupItem ~= nil then
        local dungeonItem = groupItem:GetLevelDungeonItem(dungeonId)
        return dungeonItem
      end
      return
    end
  end
end

function UINDiffLevelCanvas:SetSectorLAvgMainItemBlueDot(avgId, show)
  local lAvgMainItem = self:GetSectorLAvgMainItem(avgId)
  if lAvgMainItem ~= nil then
    lAvgMainItem:ShowBlueDotLAvgMain(show)
  end
end

function UINDiffLevelCanvas:RefillScrollRect(isOpenInfo)
  local index = self.lastCompletedStage.index or 1
  local groupIndex = self.lastCompletedStage.groupIndex or 1
  self.ui.scrollRect.totalCount = #self.levelGroupDataList
  local indexOffset = groupIndex - 1
  local posOffset = 0
  if 1 < index then
    local pos = self.arrangeCfg[index].pos
    if self.isVertical then
      posOffset = -pos[2] - (self.__levelGroupUI.padding + self.__levelGroupUI.lastPadding)
    else
      posOffset = pos[1] - (self.__levelGroupUI.padding + self.__levelGroupUI.lastPadding)
    end
  end
  local remainLength = 0
  for i = groupIndex, #self.levelGroupDataList do
    local grouDatas = self.levelGroupDataList[i]
    local lastArrage = self.arrangeCfg[#grouDatas]
    local endPos = self.isVertical and lastArrage.pos[2] or lastArrage.pos[1]
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
      local item = groupItem:GetLevelItemByIndex(index)
      if item ~= nil and item.stageCfg ~= nil then
        item:OnClickLevelItem()
      else
        error("want to open a not levelItem's info, groupIndex:" .. tostring(groupIndex) .. ", index:" .. tostring(index))
      end
    end
  end
end

function UINDiffLevelCanvas:__OnNewItem(go)
  local item = UINLevelGroup.New()
  item:Init(go)
  self.scrollItemGoDic[go] = item
end

function UINDiffLevelCanvas:__OnReturnItem(go)
  local item = self.scrollItemGoDic[go]
  if item == nil then
    error("OnReturnItem : Can't find item by gameObject")
    return
  end
  item:OnReturnLevelGroup()
end

function UINDiffLevelCanvas:__OnChangeItem(go, index)
  self.scrollRectIndex = index
  local item = self.scrollItemGoDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  local levelGroupData = self.levelGroupDataList[index + 1]
  if levelGroupData == nil then
    error("Can't find levelGroupData by index, index = " .. tonumber(index))
    return
  end
  local isLastGroup = index + 1 == #self.levelGroupDataList
  item:InitLevelGroup(levelGroupData, self.lastEpStateCfg, self.arrangeCfg, self.ui.lineHolder, self.ui.bgHolder, self.stageCount, self.levelItemClickEvent, self.levelAvgMainClickEvent, self.lAvgSubClickEvent, self.resLoader, self.sectorLevelTipsGuides, isLastGroup)
  if self._pageDungonDic ~= nil then
    local dungeonStageMapping = self._pageDungonDic[index + 1]
    if dungeonStageMapping ~= nil then
      item:InsetDungeonInSectorGroup(dungeonStageMapping, self._dungeonDataDic, self.ui.lineHolder, self._clickDungeonItemEvent, self._dungeonBlueReddotFunc)
    end
  end
  for k, v in ipairs(levelGroupData) do
    if v.stageCfg ~= nil then
      local levelItem = item:GetLevelItemByIndex(k)
      if levelItem ~= nil then
        local showBlueDot = PlayerDataCenter.sectorStage:IsStageUnlock(v.stageCfg.id) and not PlayerDataCenter.sectorStage:IsStageComplete(v.stageCfg.id)
        levelItem:ShowBlueDotLevelItem(showBlueDot)
      end
    elseif v.avgCfg ~= nil then
      local lAvgMainItem = item:GetLevelItemByIndex(k)
      if lAvgMainItem ~= nil then
        local avgId = v.avgCfg.id
        local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
        local showBlueDot = avgPlayCtrl:IsAvgUnlock(avgId) and not avgPlayCtrl:IsAvgPlayed(avgId)
        lAvgMainItem:ShowBlueDotLAvgMain(showBlueDot)
      end
    end
  end
end

function UINDiffLevelCanvas:GetLevelGroupItemByIndex(index)
  local go = self.ui.scrollRect:GetCellByIndex(index - 1)
  return self.scrollItemGoDic[go]
end

function UINDiffLevelCanvas:RefreshUncompletedEp(lastEpStateCfg)
  self.lastEpStateCfg = lastEpStateCfg
  for k, v in ipairs(self.levelGroupDataList) do
    local groupItem = self:GetLevelGroupItemByIndex(k)
    if groupItem ~= nil then
      groupItem:RefreshUncompletedEp(lastEpStateCfg)
    end
  end
end

function UINDiffLevelCanvas:RefreshLevelState()
  for k, v in ipairs(self.levelGroupDataList) do
    local groupItem = self:GetLevelGroupItemByIndex(k)
    if groupItem ~= nil then
      groupItem:RefreshLevelItemState()
    end
  end
end

function UINDiffLevelCanvas:RefreshHardModeFx(difficulty)
  if difficulty == SectorLevelDetailEnum.eDifficulty.nightmare then
    if self.__NMBackgroundMat == nil then
      self.__NMBackgroundMat = cs_Material(self.ui.mat_uIM_rolo2)
    end
    self.ui.Img_background.material = self.__NMBackgroundMat
    if self.__NMBackgrounFx == nil then
      self.__NMBackgrounFx = self.ui.fXP_UI_SectorLevelMap2:Instantiate()
      self.__NMBackgrounFx.transform:SetParent(self.transform)
      self.__NMBackgrounFx.transform.localScale = Vector3.one
      self.__NMBackgrounFx.transform.localPosition = Vector3.zero
    end
    self.__NMBackgrounFx:SetActive(true)
    self.ui.obj_redMask:SetActive(true)
  else
    self.ui.Img_background.material = nil
    if self.__NMBackgrounFx ~= nil then
      self.__NMBackgrounFx:SetActive(false)
    end
    self.ui.obj_redMask:SetActive(false)
  end
end

function UINDiffLevelCanvas:PlayDiffLevelCanvasSwitchTween(isUpTween)
  self.gameObject.transform:SetAsLastSibling()
  if isUpTween then
    self.ui.switchTween:DORestart()
  else
    self.__isBackwardsTween = true
    self.ui.switchTween:DOComplete()
    self.ui.switchTween:DOPlayBackwards()
  end
  local continueWindow = UIManager:ShowWindow(UIWindowTypeID.ClickContinue)
  continueWindow:InitContinue(nil, nil, nil, Color.clear, false)
end

function UINDiffLevelCanvas:OnSwitchTweenComplete()
  if self.__isBackwardsTween then
    return
  end
  self:OnSwitchTweenEndEvent()
end

function UINDiffLevelCanvas:OnSwitchTweenRewind()
  if not self.__isBackwardsTween then
    return
  end
  self.__isBackwardsTween = false
  self:OnSwitchTweenEndEvent()
end

function UINDiffLevelCanvas:OnSwitchTweenEndEvent()
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  self.ui.switchTween:DORewind()
  if self.tweenCompleteEvent ~= nil then
    self.tweenCompleteEvent()
  end
end

function UINDiffLevelCanvas:PlayDiffLevelContentTween(duration)
  if not self.isVertical then
    return
  end
  if self.contentVerticalTween ~= nil then
    self.contentVerticalTween:Kill()
  end
  self.contentVerticalTween = self.ui.contentVertical.transform:DOAnchorPosX(0, duration):SetEase(CS_Ease.InQuad)
end

function UINDiffLevelCanvas:__OnClickBg()
  if self.clickBackFunc ~= nil then
    self.clickBackFunc()
  end
end

function UINDiffLevelCanvas:OnDelete()
  if self.contentVerticalTween ~= nil then
    self.contentVerticalTween:Kill()
  end
  for k, v in pairs(self.scrollItemGoDic) do
    v:Delete()
  end
  if self.__NMBackgroundMat ~= nil then
    DestroyUnityObject(self.__NMBackgroundMat)
  end
  if self.__NMBackgrounFx ~= nil then
    DestroyUnityObject(self.__NMBackgrounFx)
  end
  self.resLoader = nil
  base.OnDelete(self)
end

return UINDiffLevelCanvas
