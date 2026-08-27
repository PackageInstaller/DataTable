local UINDiffLevelMulLineCanvas = require("Game.Sector.SectorLevel.UINDiffLevelMulLineCanvas")
local UINDiffLevelMulLineActSum21Canvas = class("UINDiffLevelMulLineActSum21Canvas", UINDiffLevelMulLineCanvas)
local base = UINDiffLevelMulLineCanvas
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local cs_Material = CS.UnityEngine.Material
local UINActChapterItem = require("Game.ActivitySummer.UI.Sector.UINActChapterItem")

function UINDiffLevelMulLineActSum21Canvas:OnInit()
  base.OnInit(self)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.switchTween.onComplete:AddListener(BindCallback(self, self.OnSwitchTweenComplete))
  self.ui.switchTween.onRewind:AddListener(BindCallback(self, self.OnSwitchTweenRewind))
  self.chapterItemPool = UIItemPool.New(UINActChapterItem, self.ui.obj_chapterItem)
  self.ui.obj_chapterItem:SetActive(false)
  self.ui.obj_clock:SetActive(false)
  self.__OnRefreshTimeDayPass = BindCallback(self, self.RefreshSectorActivityCount)
  MsgCenter:AddListener(eMsgEventId.SectorActivityTimePass, self.__OnRefreshTimeDayPass)
end

function UINDiffLevelMulLineActSum21Canvas:InitDiffLevelCanvas(sectorId, autoStateCfg, isUnCompleteEp, difficulty, levelItemClickEvent, levelAvgMainClickEvent, lAvgSubClickEvent, tweenCompleteEvent, resLoader, sectorLevelTipsGuides, clickBackFunc)
  base.InitDiffLevelCanvas(self, sectorId, autoStateCfg, isUnCompleteEp, difficulty, levelItemClickEvent, levelAvgMainClickEvent, lAvgSubClickEvent, tweenCompleteEvent, resLoader, sectorLevelTipsGuides, clickBackFunc)
  self:RefreshSectorActivityCount()
  self:RefreshHardModeFx(difficulty)
end

function UINDiffLevelMulLineActSum21Canvas:SetDungeonListInSector(dungeonDataDic, clickDungeonItemEvent, blueReddotFunc)
end

function UINDiffLevelMulLineActSum21Canvas:RefreshSectorActivityCount()
  if self.sectorId == nil then
    return
  end
  local actId, sectorIData, inTime = PlayerDataCenter.allActivitySectorIData:GetDataBySectorId(self.sectorId)
  self:CheckExtraMount(actId, sectorIData, inTime)
  self:SetChapterAndLockLayout(actId, sectorIData, inTime)
end

function UINDiffLevelMulLineActSum21Canvas:RefillScrollRect(isOpenInfo)
  self.chapterItemPool:HideAll()
  self.extraCharpterTisItemDic = {}
  base.RefillScrollRect(self, isOpenInfo)
end

function UINDiffLevelMulLineActSum21Canvas:PlayDiffLevelCanvasSwitchTween(isUpTween)
  self.gameObject.transform:SetAsLastSibling()
  if isUpTween then
    self.ui.switchTween:DORestart()
  else
    self.__isBackwardsTween = true
    self.ui.switchTween:DOComplete()
    self.ui.switchTween:DOPlayBackwards()
  end
  AudioManager:PlayAudioById(1073)
  local continueWindow = UIManager:ShowWindow(UIWindowTypeID.ClickContinue)
  continueWindow:InitContinue(nil, nil, nil, Color.clear, false)
end

function UINDiffLevelMulLineActSum21Canvas:OnSwitchTweenComplete()
  if self.__isBackwardsTween then
    return
  end
  self:OnSwitchTweenEndEvent()
end

function UINDiffLevelMulLineActSum21Canvas:OnSwitchTweenRewind()
  if not self.__isBackwardsTween then
    return
  end
  self.__isBackwardsTween = false
  self:OnSwitchTweenEndEvent()
end

function UINDiffLevelMulLineActSum21Canvas:OnSwitchTweenEndEvent()
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  self.ui.switchTween:DORewind()
  if self.tweenCompleteEvent ~= nil then
    self.tweenCompleteEvent()
  end
end

function UINDiffLevelMulLineActSum21Canvas:CheckExtraMount(actId, sectorIData, inTime)
  self.ui.extraMount:SetActive(false)
  self.ui.tex_Time.gameObject:SetActive(false)
  if self._mulLineCountdownTimer ~= nil then
    TimerManager:StopTimer(self._mulLineCountdownTimer)
    self._mulLineCountdownTimer = nil
    self._countDownTime = nil
  end
  self.extraCharpterTisInfoDic = nil
  self.extraCharpterTisItemDic = nil
  self.chapterItemPool:HideAll()
  if not inTime then
    return
  end
  if sectorIData:GetSectorICfg().rechallenge_stage ~= self.sectorId then
    self:CalculateExtraCharterInfo(sectorIData)
    return
  end
  local _, battleCount, allCount = sectorIData:GetSectorIBattleCount()
  local remainCount = allCount - battleCount
  self.ui.extraMount:SetActive(true)
  local sectorCfg = ConfigData.sector[self.sectorId]
  self.ui.sectorName.text = LanguageUtil.GetLocaleText(sectorCfg.name)
  self.ui.remainTimes:SetIndex(0, tostring(remainCount))
  local nextShowTime = sectorIData:GetNextExpireTimeInShow()
  if nextShowTime <= sectorIData:GetActivityEndTime() then
    self._countDownTime = sectorIData:GetNextExpireTimeInShow()
    self.ui.tex_Time.gameObject:SetActive(true)
    self._mulLineCountdownTimer = TimerManager:StartTimer(1, self.MulLineCountdown, self)
    self:MulLineCountdown()
  end
end

function UINDiffLevelMulLineActSum21Canvas:MulLineCountdown()
  if self._countDownTime == nil then
    self.ui.tex_Time.gameObject:SetActive(false)
    TimerManager:StopTimer(self._mulLineCountdownTimer)
    self._mulLineCountdownTimer = nil
    return
  end
  local coutdown = self._countDownTime - PlayerDataCenter.timestamp
  if 0 <= coutdown then
    local str = TimeUtil:TimestampToTime(coutdown)
    self.ui.tex_Time:SetIndex(0, str)
    return
  end
  local actId, sectorIData, inTime = PlayerDataCenter.allActivitySectorIData:GetDataBySectorId(self.sectorId)
  if inTime then
    local nextShowTime = sectorIData:GetNextExpireTimeInShow()
    if nextShowTime <= sectorIData:GetActivityEndTime() then
      self._countDownTime = sectorIData:GetNextExpireTimeInShow()
      return
    end
  end
  self._countDownTime = nil
  self.ui.tex_Time.gameObject:SetActive(false)
  TimerManager:StopTimer(self._mulLineCountdownTimer)
  self._mulLineCountdownTimer = nil
end

function UINDiffLevelMulLineActSum21Canvas:_CalculateScrollRectWidth()
  local width = 0
  for go, item in pairs(self.scrollItemGoDic) do
    local sizeDelta, _ = item:GetGroupSizeDelta()
    width = sizeDelta.x + width
  end
  local vec = Vector2.New(width, 0)
  self.ui.rect_Chapter.sizeDelta = vec
  self.ui.rect_Lock.sizeDelta = vec
end

function UINDiffLevelMulLineActSum21Canvas:CalculateExtraCharterInfo(sectorIData)
  local chapterPosList = sectorIData:GetChapterPosList()
  if chapterPosList == nil then
    return
  end
  self.extraCharpterTisInfoDic = {}
  for idx, pos in ipairs(chapterPosList) do
    if self.isVertical then
      local diff = pos[2]
      for i, lastLocalInfo in ipairs(self.lastLocalsDataList) do
        if diff > lastLocalInfo.maxDistance or i == #self.lastLocalsDataList then
          self.extraCharpterTisInfoDic[i] = self.extraCharpterTisInfoDic[i] or {}
          self.extraCharpterTisInfoDic[i][idx] = {
            pos[1],
            diff
          }
          break
        end
        diff = diff - lastLocalInfo.maxDistance
      end
    else
      local diff = pos[1]
      for i, lastLocalInfo in ipairs(self.lastLocalsDataList) do
        if diff < lastLocalInfo.maxDistance or i == #self.lastLocalsDataList then
          self.extraCharpterTisInfoDic[i] = self.extraCharpterTisInfoDic[i] or {}
          self.extraCharpterTisInfoDic[i][idx] = {
            diff,
            pos[2]
          }
          break
        end
        diff = diff - lastLocalInfo.maxDistance
      end
    end
  end
end

function UINDiffLevelMulLineActSum21Canvas:ShowOrHideExtraCharterInfo(showPage, go, lastPage)
  local actId, sectorIData, inTime = PlayerDataCenter.allActivitySectorIData:GetDataBySectorId(self.sectorId)
  if lastPage ~= nil and self.extraCharpterTisItemDic ~= nil then
    local lastOne
    local extraCharpItemtDic = self.extraCharpterTisItemDic[lastPage]
    if extraCharpItemtDic ~= nil then
      for idx, item in pairs(extraCharpItemtDic) do
        self.chapterItemPool:HideOne(item)
        if idx == 2 then
          self.ui.obj_clock:SetActive(false)
        end
      end
    end
  end
  if showPage == nil or self.extraCharpterTisInfoDic == nil then
    return
  end
  local extraCharpInfoDic = self.extraCharpterTisInfoDic[showPage]
  if extraCharpInfoDic == nil then
    return
  end
  self.extraCharpterTisItemDic = {}
  local lastOne
  for idx, pos in pairs(extraCharpInfoDic) do
    local item = self.chapterItemPool:GetOne()
    item.transform:SetParent(go.transform)
    item.transform:SetAsFirstSibling()
    item:InitActChapterItem(idx, pos)
    self.extraCharpterTisItemDic[showPage] = self.extraCharpterTisItemDic[showPage] or {}
    self.extraCharpterTisItemDic[showPage][idx] = item
    if idx == 2 then
      lastOne = item
    end
  end
  if lastOne == nil then
    return
  end
  local unlock, timestamp = sectorIData:GetChapterHasUnlock()
  self.ui.obj_clock:SetActive(not unlock)
  if unlock then
    return
  end
  lastOne.transform:SetParent(self.ui.rect_cItemHolder)
  lastOne.transform.anchoredPosition = Vector2.zero
  local date = TimeUtil:TimestampToDate(timestamp, false, true)
  self.ui.tex_cUnlockTime:SetIndex(0, tostring(date.month), tostring(date.day))
end

function UINDiffLevelMulLineActSum21Canvas:SetChapterAndLockLayout(actId, sectorIData, inTimesectorIData)
  if actId == nil or not inTimesectorIData then
    self.chapterItemPool:HideAll()
    self.extraCharpterTisInfoDic = nil
    self.extraCharpterTisItemDic = nil
  end
end

function UINDiffLevelMulLineActSum21Canvas:RefreshHardModeFx(difficulty)
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

function UINDiffLevelMulLineActSum21Canvas:GetSectorDungeonItem(dungeonId)
  return nil
end

function UINDiffLevelMulLineActSum21Canvas:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.SectorActivityTimePass, self.__OnRefreshTimeDayPass)
  if self._mulLineCountdownTimer ~= nil then
    TimerManager:StopTimer(self._mulLineCountdownTimer)
    self._mulLineCountdownTimer = nil
  end
  if self.__NMBackgroundMat ~= nil then
    DestroyUnityObject(self.__NMBackgroundMat)
  end
  if self.__NMBackgrounFx ~= nil then
    DestroyUnityObject(self.__NMBackgrounFx)
  end
  self.resLoader = nil
  self.chapterItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINDiffLevelMulLineActSum21Canvas
