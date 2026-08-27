local UINCharDunLevelCanvas = class("UINCharDunLevelCanvas", UIBaseNode)
local base = UIBaseNode
local UINLevelCharDunItem = require("Game.Sector.SectorLevel.UINLevelCharDunItem")

function UINCharDunLevelCanvas:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.OnClickBackground)
  self.stagePool = UIItemPool.New(UINLevelCharDunItem, self.ui.uINCharDunStory)
  self.ui.uINCharDunStory:SetActive(false)
  self.ui.switchTween.onComplete:AddListener(BindCallback(self, self.OnSwitchTweenComplete))
  self.ui.switchTween.onRewind:AddListener(BindCallback(self, self.OnSwitchTweenRewind))
  self.__OnClickLevelItemCallback = BindCallback(self, self.OnClickLevelItem)
  self.__OnLevelItemSelectStateCallback = BindCallback(self, self.OnLevelItemSelectState)
end

function UINCharDunLevelCanvas:InitDiffLevelCanvas(sectorId, autoStateCfg, isUnCompleteEp, difficulty, levelItemClickEvent, levelAvgMainClickEvent, lAvgSubClickEvent, tweenCompleteEvent, resLoader, sectorLevelTipsGuides, clickBackFunc)
  self.ui.obj_Select:SetActive(false)
  self._sectorId = sectorId
  self._difficulty = difficulty
  self._levelItemClickEvent = levelItemClickEvent
  self._tweenCompleteEvent = tweenCompleteEvent
  self._resLoader = resLoader
  self._clickBackFunc = clickBackFunc
  self:__UpdateSectorStageInfo()
  if isUnCompleteEp then
    self:RefreshUncompletedEp(autoStateCfg)
  end
  if autoStateCfg ~= nil then
    self:LocationSectorStageItem(autoStateCfg.id, false)
  end
end

function UINCharDunLevelCanvas:SetDungeonListInSector(dungeonDataDic, clickDungeonItemEvent, blueReddotFunc)
end

function UINCharDunLevelCanvas:__UpdateSectorStageInfo()
  self.stagePool:HideAll()
  self.stageItemDic = {}
  local sectorStageCfg = ConfigData.sector_stage.sectorDiffDic[self._sectorId][self._difficulty]
  for i, stageCfgId in ipairs(sectorStageCfg) do
    local item = self.stagePool:GetOne()
    local showBlueDot = PlayerDataCenter.sectorStage:IsStageUnlock(stageCfgId) and not PlayerDataCenter.sectorStage:IsStageComplete(stageCfgId)
    item:SetBluedot(showBlueDot)
    item:InitCharDunSectorStage(stageCfgId, self.__OnClickLevelItemCallback, self.__OnLevelItemSelectStateCallback, self._resLoader)
    self.stageItemDic[stageCfgId] = item
  end
end

function UINCharDunLevelCanvas:OnClickBackground()
  if self._clickBackFunc == nil then
    return
  end
  self.ui.obj_Select:SetActive(false)
  self._clickBackFunc()
end

function UINCharDunLevelCanvas:SetBackground(texture)
  self.ui.background.texture = texture
end

function UINCharDunLevelCanvas:OnSwitchTweenComplete()
  if self.__isBackwardsTween then
    return
  end
  self:OnSwitchTweenEndEvent()
end

function UINCharDunLevelCanvas:OnSwitchTweenRewind()
  if not self.__isBackwardsTween then
    return
  end
  self.__isBackwardsTween = false
  self:OnSwitchTweenEndEvent()
end

function UINCharDunLevelCanvas:OnSwitchTweenEndEvent()
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  self.ui.switchTween:DORewind()
  if self._tweenCompleteEvent ~= nil then
    self._tweenCompleteEvent()
  end
end

function UINCharDunLevelCanvas:PlayDiffLevelCanvasSwitchTween(isUpTween)
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

function UINCharDunLevelCanvas:SetSectorStageItemBlueDot(stageId, show)
  local item = self.stageItemDic[stageId]
  if item ~= nil then
    item:SetBluedot(show)
  end
end

function UINCharDunLevelCanvas:SetSectorLAvgMainItemBlueDot(avgId, show)
end

function UINCharDunLevelCanvas:PlayDiffLevelContentTween(duration)
end

function UINCharDunLevelCanvas:SetSpecialLevelList(specialLevelList)
  self.specialLevelList = specialLevelList
end

function UINCharDunLevelCanvas:GetSectorDungeonItem(dungeonId)
  return nil
end

function UINCharDunLevelCanvas:RefreshUncompletedEp(lastEpStateCfg)
  if lastEpStateCfg == nil then
    return
  end
  local item = self.stageItemDic[lastEpStateCfg]
  if item == nil then
    return
  end
  item:RefreshUncompletedEp(true, false)
end

function UINCharDunLevelCanvas:RefreshLevelState()
  for i, item in ipairs(self.stagePool.listItem) do
    item:RefreshStageUI()
  end
end

function UINCharDunLevelCanvas:LocationSectorStageItem(id, isAvg)
  local item = self.stageItemDic[id]
  if item == nil then
    return
  end
  item:SeletedLevelItem(true, false)
  item:OnClickStage()
end

function UINCharDunLevelCanvas:GetSectorStageItem(stageId)
  return self.stageItemDic[stageId]
end

function UINCharDunLevelCanvas:GetSectorLAvgMainItem(avgId)
  return nil
end

function UINCharDunLevelCanvas:OnClickLevelItem(item)
  if self._levelItemClickEvent ~= nil then
    self._levelItemClickEvent(item)
  end
end

function UINCharDunLevelCanvas:OnLevelItemSelectState(item, flag)
  if flag then
    self.ui.obj_Select:SetActive(true)
    self.ui.obj_Select.transform:SetParent(item.transform)
    self.ui.obj_Select.transform.localPosition = Vector3.zero
  elseif self.ui.obj_Select.transform.parent == item.transform then
    self.ui.obj_Select:SetActive(false)
  end
end

function UINCharDunLevelCanvas:OnDelete()
  self.stagePool:DeleteAll()
  base.OnDelete(self)
end

return UINCharDunLevelCanvas
