local UINLevelMulLineGroup = class("UINLevelMulLineGroup", UIBaseNode)
local base = UIBaseNode
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local UINLevelSimpleItem = require("Game.ActivitySummer.UI.Sector.UINActLevelSimpleItem")
local UINLevelWin23Item = require("Game.ActivityWinter23.UI.Sector.UINActLevelWin23Item")
local UINLevelAvgMain = require("Game.ActivitySummer.UI.Sector.UINActLevelAvgMain")
local UINLevelAvgWin23Main = require("Game.ActivityWinter23.UI.Sector.UINActLevelAvgWin23Main")
local UINLevelLine = require("Game.Sector.SectorLevel.UINLevelLine")
local eLevelLineType = require("Game.Sector.Enum.eLevelLineType")
local UINLevelItemType = {
  [SectorLevelDetailEnum.eSectorType.ActSum21] = UINLevelSimpleItem,
  [SectorLevelDetailEnum.eSectorType.ActWin23] = UINLevelWin23Item,
  [SectorLevelDetailEnum.eSectorType.ActCar23] = UINLevelWin23Item,
  [SectorLevelDetailEnum.eSectorType.ActSum23] = UINLevelWin23Item,
  [SectorLevelDetailEnum.eSectorType.ActSum24] = UINLevelWin23Item,
  [SectorLevelDetailEnum.eSectorType.ActAnni24] = require("Game.ActivityAnniversary24.UI.Sector.UINActLevelAnni24Item")
}
local UINAvgItemType = {
  [SectorLevelDetailEnum.eSectorType.ActSum21] = UINLevelAvgMain,
  [SectorLevelDetailEnum.eSectorType.ActWin23] = UINLevelAvgWin23Main,
  [SectorLevelDetailEnum.eSectorType.ActCar23] = UINLevelAvgWin23Main,
  [SectorLevelDetailEnum.eSectorType.ActSum23] = UINLevelAvgWin23Main,
  [SectorLevelDetailEnum.eSectorType.ActSum24] = UINLevelAvgWin23Main,
  [SectorLevelDetailEnum.eSectorType.ActAnni24] = require("Game.ActivityAnniversary24.UI.Sector.UINActLevelAvgAnni24Main")
}
local UINSpLevelItemType = {
  [SectorLevelDetailEnum.eSectorType.ActWin23] = require("Game.ActivityWinter23.UI.Sector.UINActLevelWin23RepeatItem"),
  [SectorLevelDetailEnum.eSectorType.ActCar23] = require("Game.ActivityWinter23.UI.Sector.UINActLevelWin23RepeatItem"),
  [SectorLevelDetailEnum.eSectorType.ActSum23] = require("Game.ActivityWinter23.UI.Sector.UINActLevelWin23RepeatItem"),
  [SectorLevelDetailEnum.eSectorType.ActSum24] = require("Game.ActivityWinter23.UI.Sector.UINActLevelWin23RepeatItem"),
  [SectorLevelDetailEnum.eSectorType.ActAnni24] = require("Game.ActivityAnniversary24.UI.Sector.UINActLevelAnni24RepeatItem")
}
local UINLineItemType = {
  [SectorLevelDetailEnum.eSectorType.ActWin23] = require("Game.ActivityWinter23.UI.Sector.UINActLevelWin23LineItem"),
  [SectorLevelDetailEnum.eSectorType.ActCar23] = require("Game.ActivityWinter23.UI.Sector.UINActLevelWin23LineItem"),
  [SectorLevelDetailEnum.eSectorType.ActSum23] = require("Game.ActivityWinter23.UI.Sector.UINActLevelWin23LineItem"),
  [SectorLevelDetailEnum.eSectorType.ActSum24] = require("Game.ActivityWinter23.UI.Sector.UINActLevelWin23LineItem"),
  [SectorLevelDetailEnum.eSectorType.ActAnni24] = require("Game.ActivityWinter23.UI.Sector.UINActLevelWin23LineItem")
}

function UINLevelMulLineGroup:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.levelItem:SetActive(false)
  self.ui.plotItem:SetActive(false)
  self.ui.lineItem:SetActive(false)
end

function UINLevelMulLineGroup:SetSpecialLevelState(state)
  if self.specialLevelStater ~= state then
    if self.levelItemPool then
      self.levelItemPool:DeleteAll()
      self.levelItemPool = nil
    end
    if self.lAvgMainItemPool then
      self.lAvgMainItemPool:DeleteAll()
      self.lAvgMainItemPool = nil
    end
    if self.spItemPool then
      self.spItemPool:DeleteAll()
      self.spItemPool = nil
    end
  end
  self.specialLevelStater = state
end

function UINLevelMulLineGroup:GenGroup(pageContent, lastLocals, isFinalPage, resLoader, lineHolder, levelItemClickEvent, levelAvgMainClickEvent, sectorLevelTipsGuides, lastEpStateCfg, sectorId)
  self.lastEpStateCfg = lastEpStateCfg
  self.sectorLevelTipsGuides = sectorLevelTipsGuides
  self.levelItemClickEvent = levelItemClickEvent
  self.lAvgMainClickEvent = levelAvgMainClickEvent
  self.resLoader = resLoader
  local sectorCfg = ConfigData.sector[sectorId]
  if not self.levelItemPool then
    self.levelItemPool = UIItemPool.New(sectorCfg and UINLevelItemType[sectorCfg.sector_type] or UINLevelSimpleItem, self.ui.levelItem)
  end
  if not self.lAvgMainItemPool then
    self.lAvgMainItemPool = UIItemPool.New(sectorCfg and UINAvgItemType[sectorCfg.sector_type] or UINLevelAvgMain, self.ui.plotItem)
  end
  if not self.levelLineItem then
    self.levelLineItem = UIItemPool.New(sectorCfg and UINLineItemType[sectorCfg.sector_type] or UINLevelLine, self.ui.lineItem)
  end
  if self.spDict and not self.spItemPool then
    self.spItemPool = UIItemPool.New(sectorCfg and UINSpLevelItemType[sectorCfg.sector_type] or UINLevelSimpleItem, self.ui.repeatItem)
  end
  local sizeDelta = self:__GenGroupSetRect(pageContent, isFinalPage)
  self:__GenGroupSetStage(pageContent, lastLocals, isFinalPage)
  self.ui.lineList:SetParent(lineHolder)
end

function UINLevelMulLineGroup:__GenGroupSetRect(pageContent, isFinalPage)
  local extraPadding = self.ui.padding
  if isFinalPage then
    extraPadding = extraPadding + self.ui.lastPadding
  end
  
  local function func_arrange(arrangeCfg, posIndex)
    local size = 0
    for k, v in ipairs(arrangeCfg) do
      local value = math.abs(v.pos[posIndex])
      size = math.max(size, value)
    end
    local res = size + self.ui.storyLineLength + self.ui.padding
    local parentWidth = self.transform.parent.parent.rect.width
    return math.max(res, parentWidth)
  end
  
  local function func_layout(arrangeCfg, index, posIndex, defaultValue)
    local lastCfg = arrangeCfg[index]
    local temp = math.abs(lastCfg.pos[posIndex]) + extraPadding
    return defaultValue < temp and temp or defaultValue
  end
  
  local isVertical
  local width = 0
  local height = 0
  for layoutId, content in pairs(pageContent) do
    local arrangeCfg = ConfigData.level_arrange[layoutId]
    if isVertical == nil then
      isVertical = arrangeCfg[1].vertical
      if isVertical then
        width = func_arrange(arrangeCfg, 1)
      else
        height = func_arrange(arrangeCfg, 2)
      end
    end
    if isVertical then
      height = func_layout(arrangeCfg, #content, 2, height)
      if 1 < #content then
        height = func_layout(arrangeCfg, #content - 1, 2, height)
      end
    else
      width = func_layout(arrangeCfg, #content, 1, width)
      if 1 < #content then
        width = func_layout(arrangeCfg, #content - 1, 1, width)
      end
    end
  end
  self._width = width
  self._height = height
  self.ui.layoutElement.preferredWidth = width
  self.ui.layoutElement.preferredHeight = height
  local sizeDelta = Vector2.New(width, height)
  self.transform.sizeDelta = sizeDelta
  self.ui.lineList.sizeDelta = sizeDelta
  return sizeDelta
end

function UINLevelMulLineGroup:__GenGroupSetStage(pageContent, lastLocals, isFinalPage)
  local function stageLineFunc(lineType, startPos, angle, length, isFirstStage, tempItem, lastTab)
    local lineItem = self.levelLineItem:GetOne()
    
    lineItem:InitLevelLine(lineType, startPos, angle, length)
    local itemConnectedLine = self.itemConnectedLineDic
    if itemConnectedLine == nil then
      itemConnectedLine = {}
      self.itemConnectedLineDic[tempItem] = itemConnectedLine
    end
    if lastTab == nil then
      error("lastTab is Null")
      return
    end
    itemConnectedLine[lastTab] = lineItem
  end
  
  local function calculateStageLineFunc(lastPos, startPos, isVertical, tab, tempItem, lastTab)
    local lineType
    local length = Vector3.Distance(lastPos, startPos)
    local dirVector = lastPos - startPos
    local angle = Vector3.Angle(Vector3.right, dirVector)
    if not isVertical and dirVector.y < 0 then
      angle = angle * -1
    end
    if tab.stageCfg ~= nil and PlayerDataCenter.sectorStage:IsStageComplete(tab.stageCfg.id) then
      lineType = eLevelLineType.BetweenLevelFull
    elseif tab.avgCfg ~= nil and ControllerManager:GetController(ControllerTypeId.AvgPlay):IsAvgPlayed(tab.avgCfg.id) then
      lineType = eLevelLineType.BetweenLevelFull
    else
      lineType = eLevelLineType.BetweenLevel
    end
    stageLineFunc(lineType, startPos, angle, length, false, tempItem, lastTab)
  end
  
  self.levelItemPool:HideAll()
  self.lAvgMainItemPool:HideAll()
  self.levelLineItem:HideAll()
  if self.spItemPool then
    self.spItemPool:HideAll()
  end
  self.itemConnectedLineDic = {}
  self.__itemDic = {}
  local sectorLevelWindow = UIManager:GetWindow(UIWindowTypeID.SectorLevel)
  if sectorLevelWindow == nil then
    return
  end
  local selectedLvId = sectorLevelWindow:GetSelectedStageId()
  local selectedLAvgMainId = sectorLevelWindow:GetSelectedLAvgMainId()
  local lastPos
  for layoutId, content in pairs(pageContent) do
    local arrangeCfg = ConfigData.level_arrange[layoutId]
    for k, v in ipairs(content) do
      local isVertical = arrangeCfg[1].vertical
      local startPos
      local randomSeed = 0
      local tempItem = {levelItem = nil, lAvgMainItem = nil}
      if v.stageCfg ~= nil then
        local stageCfg = v.stageCfg
        local levelItem
        if self:CheckLevelIsSpecial(stageCfg.id) and self.spItemPool then
          levelItem = self.spItemPool:GetOne()
          levelItem:SetIsSpecialState(self.specialLevelStater)
        else
          levelItem = self.levelItemPool:GetOne()
        end
        tempItem.levelItem = levelItem
        levelItem:InitSectorLevelItem(stageCfg, arrangeCfg[k], self.levelItemClickEvent, self.resLoader)
        if self.lastEpStateCfg ~= nil then
          if self.lastEpStateCfg.id == stageCfg.id then
            levelItem:OnClickLevelItem()
            levelItem:LevelItemShowContinue(true)
          else
            levelItem:DisableSelectLevelItem(true)
          end
        end
        if selectedLvId == stageCfg.id then
          levelItem:SeletedLevelItem(true, false)
        end
        startPos = levelItem.transform.localPosition
        randomSeed = stageCfg.id
        self.__itemDic[stageCfg.id * 10 + 1] = levelItem
        self:SectorLevelTryTipsGuide(levelItem, stageCfg.id, false)
      elseif v.avgCfg ~= nil then
        local avgCfg = v.avgCfg
        local lAvgMainItem = self.lAvgMainItemPool:GetOne()
        tempItem.lAvgMainItem = lAvgMainItem
        lAvgMainItem:InitActLAvgMain(avgCfg, arrangeCfg[k], self.lAvgMainClickEvent, self.resLoader)
        startPos = lAvgMainItem.transform.localPosition
        randomSeed = avgCfg.id
        self.__itemDic[avgCfg.id * 10 + 2] = lAvgMainItem
        if selectedLAvgMainId == avgCfg.id then
          lAvgMainItem:SelectedLAvgMain(true)
        end
        self:SectorLevelTryTipsGuide(lAvgMainItem, avgCfg.id, true)
      else
        error("levelGroupData error")
      end
      if v.stageCfg and v.stageCfg.is_special then
        if lastPos ~= nil then
          local lastTab = content[k - 1]
          local centerPos
          if isVertical then
            centerPos = Vector3.New(lastPos.x, startPos.y, startPos.z)
          else
            centerPos = Vector3.New(startPos.x, lastPos.y, startPos.z)
          end
          calculateStageLineFunc(centerPos, startPos, isVertical, v, tempItem, lastTab)
        end
      else
        local angle = 0
        local length, lineType
        local isFirstStage = k == 1 and (lastLocals == nil or lastLocals.locals == nil or #lastLocals.locals == 0)
        if isFirstStage then
          angle = isVertical and 90 or 180
          length = self.ui.padding
          lineType = eLevelLineType.BetweenLevelFull
          lastPos = Vector3.New(startPos.x, startPos.y, startPos.z)
        elseif k == 1 then
          for _, lastInfo in ipairs(lastLocals.locals) do
            local lastLocal = lastInfo.pos
            local lastTab = lastInfo.tab
            if lastTab.connecId == v.connecId or table.contain(v.preStages, lastTab.connecId) then
              lastPos = Vector3.New(startPos.x, startPos.y, startPos.z)
              if isVertical then
                lastPos.x = lastLocal[1]
                lastPos.y = self.ui.layoutElement.preferredHeight / 2 + self.ui.padding + (lastLocals.maxDistance - lastLocal[2])
              else
                lastPos.x = -self.ui.layoutElement.preferredWidth / 2 - self.ui.padding - (lastLocals.maxDistance - lastLocal[1])
                lastPos.y = lastLocal[2]
              end
              calculateStageLineFunc(lastPos, startPos, isVertical, v, tempItem, lastTab)
            end
          end
        else
          local lastTab = content[k - 1]
          calculateStageLineFunc(lastPos, startPos, isVertical, v, tempItem, lastTab)
        end
        lastPos = startPos
      end
    end
  end
end

function UINLevelMulLineGroup:CheckLevelIsSpecial(stage)
  if self.spDict and self.spDict[stage] then
    return true
  end
  return false
end

function UINLevelMulLineGroup:SetAllSpecialListDic(dic)
  self.spDict = dic
end

function UINLevelMulLineGroup:DesyroyLastTipsGuide()
  if self.lastSectorTipsGuide ~= nil then
    for k, v in pairs(self.lastSectorTipsGuide) do
      DestroyUnityObject(v.gameObject)
    end
    self.lastSectorTipsGuide = nil
  end
end

function UINLevelMulLineGroup:SectorLevelTryTipsGuide(item, id, isAvg)
  if self.sectorLevelTipsGuides[isAvg] ~= nil then
    local tipsGuideDic = self.sectorLevelTipsGuides[isAvg]
    if tipsGuideDic[id] ~= nil then
      local show_dir = tipsGuideDic[id]
      self.resLoader:LoadABAssetAsync(PathConsts:GetUIPrefabPath(GuideUtil.TipsGuidePrefabName), function(guidePrefab)
        local guideItem = GuideUtil.ShowTipsGuide(item.transform, guidePrefab, show_dir)
        self.lastSectorTipsGuide = self.lastSectorTipsGuide or {}
        self.lastSectorTipsGuide[item] = guideItem
      end)
    end
  end
end

function UINLevelMulLineGroup:SectorLevelClearTipsGuide(item)
  if IsNull(item.gameObject) then
    return
  end
  local tipsGuideNodeName = GuideUtil.GetTipsGuideNodeName(item.gameObject.name)
  local tipsGuideNode = item.transform:Find(tipsGuideNodeName)
  if not IsNull(tipsGuideNode) then
    DestroyUnityObject(tipsGuideNode.gameObject)
  end
  if self.lastSectorTipsGuide ~= nil then
    self.lastSectorTipsGuide[item] = nil
  end
end

function UINLevelMulLineGroup:GetLevelItemByIndex(id, isState)
  return self.__itemDic[id * 10 + (isState and 1 or 2)]
end

function UINLevelMulLineGroup:__GetDecorateLineAngle(isVertical, isFirstStage, isLastStage, lineIndex, isLeft)
  local angle
  local offset = isVertical and 0 or 90
  if isFirstStage then
    if lineIndex == 1 then
      angle = math.random(self.ui.range_start1A + offset, self.ui.range_start1B + offset)
    else
      angle = math.random(self.ui.range_start2A + offset, self.ui.range_start2B + offset)
    end
  elseif isLastStage then
    if lineIndex == 1 then
      angle = math.random(self.ui.range_end1A + offset, self.ui.range_end1B + offset)
    else
      angle = math.random(self.ui.range_end2A + offset, self.ui.range_end2B + offset)
    end
  elseif isLeft then
    if lineIndex == 1 then
      angle = math.random(self.ui.range_left1A + offset, self.ui.range_left1B + offset)
    else
      angle = math.random(self.ui.range_left2A + offset, self.ui.range_left2B + offset)
    end
  elseif lineIndex == 1 then
    angle = math.random(self.ui.range_right1A + offset, self.ui.range_right1B + offset)
  else
    angle = math.random(self.ui.range_right2A + offset, self.ui.range_right2B + offset)
  end
  return angle
end

function UINLevelMulLineGroup:RefreshUncompletedEp(lastEpStateCfg)
  self.lastEpStateCfg = lastEpStateCfg
  for k, levelItem in ipairs(self.levelItemPool.listItem) do
    if lastEpStateCfg == nil then
      levelItem:DisableSelectLevelItem(false)
      levelItem:LevelItemShowContinue(false)
    elseif lastEpStateCfg.num == levelItem:GetLevelStageData().num then
      levelItem:OnClickLevelItem()
      levelItem:LevelItemShowContinue(true)
    else
      levelItem:DisableSelectLevelItem(true)
    end
  end
  if not self.spItemPool then
    return
  end
  for k, levelItem in ipairs(self.spItemPool.listItem) do
    if lastEpStateCfg == nil then
      levelItem:DisableSelectLevelItem(false)
      levelItem:LevelItemShowContinue(false)
    elseif lastEpStateCfg.num == levelItem:GetLevelStageData().num then
      levelItem:OnClickLevelItem()
      levelItem:LevelItemShowContinue(true)
    else
      levelItem:DisableSelectLevelItem(true)
    end
  end
end

function UINLevelMulLineGroup:RefreshLevelItemState()
  for k, v in ipairs(self.levelItemPool.listItem) do
    v:RefreshLevelState()
  end
  for k, v in ipairs(self.lAvgMainItemPool.listItem) do
    v:RefreshLAvgMainState()
  end
  if self.spItemPool then
    for k, v in ipairs(self.spItemPool.listItem) do
      v:RefreshLevelState()
    end
  end
  self:RefreshLevelConnectLineState()
end

function UINLevelMulLineGroup:RefreshLevelConnectLineState()
  for k, lineItem in pairs(self.itemConnectedLineDic) do
    local isComplete = false
    if k.levelItem ~= nil then
      local stageCfg = k.levelItem:GetLevelStageData()
      isComplete = PlayerDataCenter.sectorStage:IsStageComplete(stageCfg.id)
    elseif k.lAvgMainItem ~= nil then
      do
        local avgCfg = k.lAvgMainItem:GetLAvgMainCfg()
        local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
        isComplete = avgPlayCtrl:IsAvgPlayed(avgCfg.id)
      end
      goto lbl_36
      goto lbl_76
      ::lbl_36::
      if not isComplete then
        for i, v in pairs(lineItem) do
          v:RefreshLevelLineState(eLevelLineType.BetweenLevel)
        end
      else
        for i, v in pairs(lineItem) do
          local lastComplete = isComplete
          if v.tab.stageCfg ~= nil then
            lastComplete = PlayerDataCenter.sectorStage:IsStageComplete(v.tab.stageCfg.id)
          end
          local lineType = lastComplete and eLevelLineType.BetweenLevelFull or eLevelLineType.BetweenLevel
          v:RefreshLevelLineState(lineType)
        end
      end
    end
    ::lbl_76::
  end
end

function UINLevelMulLineGroup:OnReturnLevelGroup()
  self.ui.lineList:SetParent(self.ui.lineRoot)
  for k, v in ipairs(self.lAvgMainItemPool.listItem) do
    v:OnReturnLAvgMainItem()
  end
end

function UINLevelMulLineGroup:GetGroupSizeDelta()
  return self.transform.sizeDelta
end

function UINLevelMulLineGroup:OnDelete()
  self.levelItemPool:DeleteAll()
  self.lAvgMainItemPool:DeleteAll()
  self.levelLineItem:DeleteAll()
  if self.spItemPool then
    self.spItemPool:DeleteAll()
  end
  base.OnDelete(self)
end

return UINLevelMulLineGroup
