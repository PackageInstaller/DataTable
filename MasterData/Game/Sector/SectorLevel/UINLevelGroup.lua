local UINLevelGroup = class("UINLevelGroup", UIBaseNode)
local base = UIBaseNode
local UINLevelItem = require("Game.Sector.SectorLevel.UINLevelItem")
local UINLevelDungeonItem = require("Game.Sector.SectorLevel.UINLevelDungeonItem")
local UINLevelAvgMain = require("Game.Sector.SectorLevel.UINLevelAvgMain")
local UINLevelAvgSub = require("Game.Sector.SectorLevel.UINLevelAvgSub")
local UINLevelLine = require("Game.Sector.SectorLevel.UINLevelLine")
local eLevelLineType = require("Game.Sector.Enum.eLevelLineType")
local UINLevelDungeonLine = require("Game.Sector.SectorLevel.UINLevelDungeonLine")
local UICanvasBg = require("Game.Sector.SectorLevel.UIDiffLevelCanvasBg")

function UINLevelGroup:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.levelItem:SetActive(false)
  self.levelItemPool = UIItemPool.New(UINLevelItem, self.ui.levelItem)
  self.ui.plotItem:SetActive(false)
  self.lAvgMainItemPool = UIItemPool.New(UINLevelAvgMain, self.ui.plotItem)
  self.ui.subPlotItem:SetActive(false)
  self.lAvgSubItemPool = UIItemPool.New(UINLevelAvgSub, self.ui.subPlotItem)
  self.ui.lineItem:SetActive(false)
  self.levelLineItem = UIItemPool.New(UINLevelLine, self.ui.lineItem)
  self.ui.spLevelItem:SetActive(false)
  self.dungeonItemPool = UIItemPool.New(UINLevelDungeonItem, self.ui.spLevelItem)
  self.ui.spLevellineItem:SetActive(false)
  self.spLevellineItemPool = UIItemPool.New(UINLevelDungeonLine, self.ui.spLevellineItem)
  self.UICanvasBg = UICanvasBg.New()
  self.UICanvasBg:Init(self.ui.rectBg.gameObject)
  self.__RefreshDungeonStateCallback = BindCallback(self, self.__RefreshDungeonState)
  MsgCenter:AddListener(eMsgEventId.HeroGrowActivityRunEnd, self.__RefreshDungeonStateCallback)
end

function UINLevelGroup:InitLevelGroup(levelGroupData, lastEpStateCfg, arrangeCfg, lineHolder, bgHolder, stageCount, levelItemClickEvent, levelAvgMainClickEvent, lAvgSubClickEvent, resLoader, sectorLevelTipsGuides, isLastGroup)
  self.arrangeCfg = arrangeCfg
  self.lastEpStateCfg = lastEpStateCfg
  self.levelItemClickEvent = levelItemClickEvent
  self.lAvgMainClickEvent = levelAvgMainClickEvent
  self.lAvgSubClickEvent = lAvgSubClickEvent
  self.resLoader = resLoader
  self.sectorLevelTipsGuides = sectorLevelTipsGuides
  self.spLevellineItemPool:HideAll()
  self.dungeonItemPool:HideAll()
  self:DesyroyLastTipsGuide()
  local lastCfg = arrangeCfg[#levelGroupData]
  if #lastCfg.pos ~= 2 then
    error(string.format("levelArrange cfg pos error, typeId:%s, id:%s", lastCfg.typeId, lastCfg.id))
    return
  end
  local isFirstGroup = levelGroupData.startIndex == 1
  local startIsLeft = false
  local isVertical = lastCfg.vertical
  self.isVertical = isVertical
  local width = 0
  local height = 0
  if isVertical then
    height = math.abs(lastCfg.pos[2]) + (isLastGroup and self.ui.lastPadding or self.ui.padding)
    local halfWidth = 0
    for k, v in ipairs(arrangeCfg) do
      local value = math.abs(v.pos[1])
      halfWidth = math.max(halfWidth, value)
    end
    width = halfWidth + self.ui.storyLineLength + self.ui.padding
    local parentWidth = self.transform.parent.parent.rect.width
    width = math.max(width, parentWidth)
    startIsLeft = arrangeCfg[2].pos[1] - arrangeCfg[1].pos[1] > 0
  else
    local halfHeight = 0
    for k, v in ipairs(arrangeCfg) do
      local value = math.abs(v.pos[2])
      halfHeight = math.max(halfHeight, value)
    end
    height = halfHeight + self.ui.storyLineLength + self.ui.padding
    local parentHeight = self.transform.parent.parent.rect.height
    height = math.max(height, parentHeight)
    width = math.abs(lastCfg.pos[1]) + (isLastGroup and self.ui.lastPadding or self.ui.padding)
    startIsLeft = arrangeCfg[2].pos[2] - arrangeCfg[1].pos[2] > 0
  end
  self.ui.layoutElement.preferredWidth = width
  self.ui.layoutElement.preferredHeight = height
  local sizeDelta = Vector2.New(width, height)
  self.transform.sizeDelta = sizeDelta
  self.ui.lineList.sizeDelta = sizeDelta
  self.levelItemPool:HideAll()
  self.lAvgMainItemPool:HideAll()
  self.lAvgSubItemPool:HideAll()
  self.levelLineItem:HideAll()
  local lastPos
  self.itemConnectedLineDic = {}
  self.lAvgSubItemDic = {}
  self._stageIdMapping = {}
  self.__itemList = {}
  local sectorLevelWindow = UIManager:GetWindow(UIWindowTypeID.SectorLevel)
  if sectorLevelWindow == nil then
    return
  end
  local selectedLvId = sectorLevelWindow:GetSelectedStageId()
  local selectedLAvgMainId = sectorLevelWindow:GetSelectedLAvgMainId()
  for k, v in ipairs(levelGroupData) do
    local startPos
    local randomSeed = 0
    local tempItem = {levelItem = nil, lAvgMainItem = nil}
    if v.stageCfg ~= nil then
      local stageCfg = v.stageCfg
      local levelItem = self.levelItemPool:GetOne()
      tempItem.levelItem = levelItem
      levelItem:InitSectorLevelItem(stageCfg, arrangeCfg[k], self.levelItemClickEvent, resLoader)
      if self.lastEpStateCfg ~= nil then
        if self.lastEpStateCfg.num == stageCfg.num then
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
      self:__ShowLAvgSubItem(levelItem, isVertical)
      self.__itemList[k] = levelItem
      self._stageIdMapping[stageCfg.id] = levelItem
      self:SectorLevelTryTipsGuide(levelItem, stageCfg.id, false)
    elseif v.avgCfg ~= nil then
      local avgCfg = v.avgCfg
      local lAvgMainItem = self.lAvgMainItemPool:GetOne()
      tempItem.lAvgMainItem = lAvgMainItem
      lAvgMainItem:InitLAvgMain(avgCfg, arrangeCfg[k], self.lAvgMainClickEvent, resLoader)
      startPos = lAvgMainItem.transform.localPosition
      randomSeed = avgCfg.id
      self.__itemList[k] = lAvgMainItem
      if selectedLAvgMainId == avgCfg.id then
        lAvgMainItem:SelectedLAvgMain(true)
      end
      self:SectorLevelTryTipsGuide(lAvgMainItem, avgCfg.id, true)
    else
      error("levelGroupData error")
    end
    local angle = 0
    local length, lineType
    local isFirstStage = isFirstGroup and k == 1
    if isFirstStage then
      angle = isVertical and 90 or 180
      length = self.ui.padding
      lineType = eLevelLineType.BetweenLevelFull
    else
      if k == 1 then
        lastPos = Vector3.New(startPos.x, startPos.y, startPos.z)
        if isVertical then
          lastPos.y = lastPos.y - math.abs(arrangeCfg[1].pos[2]) - self.ui.padding
          lastPos.x = lastPos.x + (arrangeCfg[#arrangeCfg].pos[1] - arrangeCfg[1].pos[1])
        else
          lastPos.x = lastPos.x - math.abs(arrangeCfg[1].pos[1]) - self.ui.padding
          lastPos.y = lastPos.y + (arrangeCfg[#arrangeCfg].pos[2] - arrangeCfg[1].pos[2])
        end
      end
      length = Vector3.Distance(lastPos, startPos)
      local dirVector = lastPos - startPos
      angle = Vector3.Angle(Vector3.right, dirVector)
      if not isVertical and 0 > dirVector.y then
        angle = angle * -1
      end
      if v.stageCfg ~= nil and PlayerDataCenter.sectorStage:IsStageComplete(v.stageCfg.id) then
        lineType = eLevelLineType.BetweenLevelFull
      elseif v.avgCfg ~= nil and ControllerManager:GetController(ControllerTypeId.AvgPlay):IsAvgPlayed(v.avgCfg.id) then
        lineType = eLevelLineType.BetweenLevelFull
      else
        lineType = eLevelLineType.BetweenLevel
      end
    end
    local lineItem = self.levelLineItem:GetOne()
    lineItem:InitLevelLine(lineType, startPos, angle, length)
    if not isFirstStage then
      self.itemConnectedLineDic[tempItem] = lineItem
    end
    lineType = eLevelLineType.Decorate
    math.randomseed(randomSeed)
    local isLeft = self:__IsOuNumber(levelGroupData.startIndex + k)
    if not startIsLeft then
      isLeft = not isLeft
    end
    local isLastStage = stageCount == levelGroupData.startIndex + k - 1
    angle = self:__GetDecorateLineAngle(isVertical, isFirstStage, isLastStage, 1, isLeft)
    local lineItem = self.levelLineItem:GetOne()
    lineItem:InitLevelLine(lineType, startPos, angle)
    angle = self:__GetDecorateLineAngle(isVertical, isFirstStage, isLastStage, 2, isLeft)
    local lineItem = self.levelLineItem:GetOne()
    lineItem:InitLevelLine(lineType, startPos, angle)
    lastPos = startPos
  end
  self.ui.lineList:SetParent(lineHolder)
  self.UICanvasBg:SetCanvasBgParent(bgHolder, sizeDelta)
  self.UICanvasBg:PlayBgAnima()
end

function UINLevelGroup:InsetDungeonInSectorGroup(dungeonStageMapping, dungeonDataDic, lineHolder, clickDungeonItemEvent, blueReddotFunc)
  self.dungeonItemPool:HideAll()
  self.spLevellineItemPool:HideAll()
  self._extraDungeonDic = {}
  local nowIndex = dungeonStageMapping.startIndex
  local dungeonList = {}
  for dungeonId, stageId in pairs(dungeonStageMapping.dungeon) do
    table.insert(dungeonList, dungeonId)
  end
  table.sort(dungeonList, function(a, b)
    return dungeonStageMapping.dungeon[a] < dungeonStageMapping.dungeon[b]
  end)
  for _, dungeonId in ipairs(dungeonList) do
    local stageId = dungeonStageMapping.dungeon[dungeonId]
    local levelItem = self._stageIdMapping[stageId]
    if levelItem ~= nil then
      local levelPos = levelItem.transform.localPosition
      local dunPos = Vector3.Temp(levelPos.x, levelPos.y, levelPos.z)
      local angle = 0
      if self.isVertical then
        dunPos.x = ConfigData.game_config.sectorDungeonVertialX
        angle = 0
      else
        dunPos.y = ConfigData.game_config.sectorDungeonHorizeY
        angle = 90
      end
      local dungeonLevelData = dungeonDataDic[dungeonId]
      local item = self.dungeonItemPool:GetOne()
      item:InitLevelDungeon(dungeonLevelData, nowIndex, clickDungeonItemEvent)
      item:SetLevelDungeonBlueReddotFunc(blueReddotFunc)
      nowIndex = nowIndex + 1
      item.transform.localPosition = dunPos
      if self.isVertical then
        levelPos.x = levelPos.x + levelItem.transform.sizeDelta.x / 2
        dunPos.x = dunPos.x - item.transform.sizeDelta.x / 2
      else
        levelPos.y = levelPos.y - levelItem.transform.sizeDelta.y / 2
        dunPos.y = dunPos.y + item.transform.sizeDelta.y / 2
      end
      local line = self.spLevellineItemPool:GetOne()
      local length = Vector3.Distance(levelPos, dunPos)
      line:InitLevelDungeonLine(levelPos, angle, length)
    end
  end
  self.ui.dottedLineList:SetParent(lineHolder)
end

function UINLevelGroup:DesyroyLastTipsGuide()
  if self.lastSectorTipsGuide ~= nil then
    for k, v in pairs(self.lastSectorTipsGuide) do
      DestroyUnityObject(v.gameObject)
    end
    self.lastSectorTipsGuide = nil
  end
end

function UINLevelGroup:SectorLevelTryTipsGuide(item, id, isAvg)
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

function UINLevelGroup:SectorLevelClearTipsGuide(item)
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

function UINLevelGroup:__ShowLAvgSubItem(levelItem, isVertical)
  local stageCfg = levelItem:GetLevelStageData()
  if not PlayerDataCenter.sectorStage:IsStageComplete(stageCfg.id) then
    return
  end
  if self.lAvgSubItemDic[levelItem] ~= nil then
    return
  end
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  local avgCfg = avgPlayCtrl:TryGetAvgCfg(eAvgTriggerType.SubAvg, stageCfg.id, nil)
  if avgCfg == nil then
    return
  end
  if not avgPlayCtrl:IsAvgUnlock(avgCfg.id) then
    return
  end
  local startPos = levelItem.transform.localPosition
  local offset = isVertical and 0 or -90
  math.randomseed(stageCfg.id)
  local angle = math.random(self.ui.range_subAvg_angleA + offset, self.ui.range_subAvg_angleB + offset)
  local length = math.random(self.ui.range_subAvg_lengthA, self.ui.range_subAvg_lengthB)
  local rad = math.rad(angle)
  local y = math.sin(rad) * length + startPos.y
  local x = math.cos(rad) * length + startPos.x
  local endPos = Vector3.New(x, y, startPos.z)
  local lineItem = self.levelLineItem:GetOne()
  lineItem:InitLevelLine(eLevelLineType.BetweenLevel, startPos, angle, length)
  local lAvgSubItem = self.lAvgSubItemPool:GetOne()
  lAvgSubItem:InitLAvgSub(endPos, avgCfg, self.lAvgSubClickEvent)
  self.lAvgSubItemDic[levelItem] = lAvgSubItem
end

function UINLevelGroup:GetLevelItemByIndex(index)
  return self.__itemList[index]
end

function UINLevelGroup:GetLevelDungeonItem(dungeonId)
  if self._extraDungeonDic == nil then
    return nil
  end
  return self._extraDungeonDic[dungeonId]
end

function UINLevelGroup:__GetDecorateLineAngle(isVertical, isFirstStage, isLastStage, lineIndex, isLeft)
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

function UINLevelGroup:__IsOuNumber(num)
  local num1, num2 = math.modf(num / 2)
  if num2 == 0 then
    return true
  else
    return false
  end
end

function UINLevelGroup:RefreshUncompletedEp(lastEpStateCfg)
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
end

function UINLevelGroup:RefreshLevelItemState()
  for k, v in ipairs(self.levelItemPool.listItem) do
    v:RefreshLevelState()
    self:__ShowLAvgSubItem(v, self.isVertical)
  end
  for k, v in ipairs(self.lAvgMainItemPool.listItem) do
    v:RefreshLAvgMainState()
  end
  self:RefreshLevelConnectLineState()
end

function UINLevelGroup:RefreshLevelConnectLineState()
  for k, lineItem in pairs(self.itemConnectedLineDic) do
    if k.levelItem ~= nil then
      local stageCfg = k.levelItem:GetLevelStageData()
      if PlayerDataCenter.sectorStage:IsStageComplete(stageCfg.id) then
        lineItem:RefreshLevelLineState(eLevelLineType.BetweenLevelFull)
      else
        lineItem:RefreshLevelLineState(eLevelLineType.BetweenLevel)
      end
    elseif k.lAvgMainItem ~= nil then
      local avgCfg = k.lAvgMainItem:GetLAvgMainCfg()
      local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
      if avgPlayCtrl:IsAvgPlayed(avgCfg.id) then
        lineItem:RefreshLevelLineState(eLevelLineType.BetweenLevelFull)
      else
        lineItem:RefreshLevelLineState(eLevelLineType.BetweenLevel)
      end
    end
  end
end

function UINLevelGroup:__RefreshDungeonState()
  for k, v in pairs(self.dungeonItemPool.listItem) do
    v:RefreshLevelDungeonState()
    v:RefreshLevelDungeonReddot()
  end
end

function UINLevelGroup:OnReturnLevelGroup()
  self.ui.lineList:SetParent(self.ui.lineRoot)
  self.UICanvasBg:SetCanvasBgParent(self.ui.BgRoot)
  for k, v in ipairs(self.levelItemPool.listItem) do
    v:OnReturnLevelItem()
  end
  for k, v in ipairs(self.lAvgMainItemPool.listItem) do
    v:OnReturnLAvgMainItem()
  end
end

function UINLevelGroup:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.HeroGrowActivityRunEnd, self.__RefreshDungeonStateCallback)
  self.levelItemPool:DeleteAll()
  self.lAvgMainItemPool:DeleteAll()
  self.lAvgSubItemPool:DeleteAll()
  self.levelLineItem:DeleteAll()
  self.UICanvasBg:Delete()
  base.OnDelete(self)
end

return UINLevelGroup
