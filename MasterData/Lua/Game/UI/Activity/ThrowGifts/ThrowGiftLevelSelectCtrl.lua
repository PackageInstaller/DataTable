local ThrowGiftLevelSelectCtrl = class("ThrowGiftLevelSelectCtrl", BaseCtrl)
local tbProgress = {
  0,
  0.3,
  0.7,
  1
}
local mapDifficultyBtn = {
  [1] = GameEnum.ThrowGiftDifficulty.Easy,
  [2] = GameEnum.ThrowGiftDifficulty.Normal,
  [3] = GameEnum.ThrowGiftDifficulty.Speed,
  [4] = GameEnum.ThrowGiftDifficulty.Blind
}
ThrowGiftLevelSelectCtrl._mapNodeConfig = {
  TMPBtnTarget = {
    sComponentName = "TMP_Text",
    sLanguageId = "ThrowGift_Target"
  },
  TMPBtnItem = {
    sComponentName = "TMP_Text",
    sLanguageId = "ThrowGift_Item"
  },
  imgLineTop = {sComponentName = "Image"},
  TMPGroupName = {sComponentName = "TMP_Text"},
  rtPenguin = {sComponentName = "Animator"},
  DecoRoot = {sComponentName = "Animator"},
  imgBgAnim = {sComponentName = "Animator"},
  rtLevelInfo = {
    nCount = 2,
    sCtrlName = "Game.UI.Activity.ThrowGifts.ThrowGiftLevelInfoGridCtrl"
  },
  btnItemDic = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ItemDic"
  },
  btnTarget = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Target"
  },
  btnLevelCtrl = {
    sNodeName = "btnLevel",
    nCount = 4,
    sCtrlName = "Game.UI.Activity.ThrowGifts.ThrowGiftLevelSelectBtmBtnCtrl"
  },
  btnLevel = {
    nCount = 4,
    sComponentName = "UIButton",
    callback = "OnBtnClick_GroupBtn"
  },
  rtItemInfo = {
    sCtrlName = "Game.UI.Activity.ThrowGifts.ThrowGiftItemDicCtrl"
  },
  btnPrev = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Prev"
  },
  btnNext = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Next"
  },
  imgGroupLockIcon = {},
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  goRedDotTarget = {},
  rtBottom = {sComponentName = "Transform"}
}
ThrowGiftLevelSelectCtrl._mapEventConfig = {}
ThrowGiftLevelSelectCtrl._mapRedDotConfig = {}

function ThrowGiftLevelSelectCtrl:Awake()
  self._switchAnimTimer = nil
end

function ThrowGiftLevelSelectCtrl:FadeIn()
end

function ThrowGiftLevelSelectCtrl:FadeOut()
end

function ThrowGiftLevelSelectCtrl:OnEnable()
  self.redDotBottom = self._mapNode.rtBottom:Find("imgNew")
  self._mapNode.rtPenguin.speed = 1
  self._mapNode.DecoRoot.speed = 1
  EventManager.Hit(EventId.SetTransition)
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActivityId = param[1]
  end
  self.rootAnim = self.gameObject:GetComponent("Animator")
  self.mapLevelGroup = {}
  self._mapNode.rtItemInfo.gameObject:SetActive(false)
  self.actData = PlayerData.Activity:GetActivityDataById(self.nActivityId)
  self.mapRecordLevelData = {}
  self.mapRecordItemData = {}
  self.nOpenTime = 0
  if self.actData ~= nil then
    local mapCachedData = self.actData:GetActivityData()
    self.mapRecordLevelData = mapCachedData.mapLevels
    self.mapRecordItemData = mapCachedData.mapItems
    self.nOpenTime = self.actData:GetActOpenTime() or 0
  end
  
  local function foreachLevel(mapData)
    if mapData.ActivityId == self.nActivityId then
      if self.mapLevelGroup[mapData.Difficulty] == nil then
        self.mapLevelGroup[mapData.Difficulty] = {}
      end
      table.insert(self.mapLevelGroup[mapData.Difficulty], mapData)
    end
  end
  
  ForEachTableLine(DataTable.ThrowGiftLevel, foreachLevel)
  
  local function sort(a, b)
    return a.Id < b.Id
  end
  
  for _, tbLevel in pairs(self.mapLevelGroup) do
    table.sort(tbLevel, sort)
  end
  self:RefreshLevelInfo()
  self:RefreshLevelInfoGrid()
  local nCurIdx = 1
  for i = 1, 4 do
    local enumDifficulty = mapDifficultyBtn[i]
    local bUnlock = 0 < table.indexof(self.tbUnlockedGroup, enumDifficulty)
    local bClear = 0 < table.indexof(self.tbClearedGroup, enumDifficulty)
    self._mapNode.btnLevelCtrl[i]:SetBtnState(bUnlock, bClear)
    self._mapNode.btnLevelCtrl[i]:SetBtnCurState(enumDifficulty == self.curGroup)
    self._mapNode.btnLevelCtrl[i]:SetBtnSelectState(enumDifficulty <= self.curGroup)
    if enumDifficulty == self.curGroup then
      nCurIdx = i
    end
  end
  self._mapNode.imgBgAnim:Play("ThrowGiftsBgSwitch_in" .. nCurIdx)
  NovaAPI.SetImageFillAmount(self._mapNode.imgLineTop, tbProgress[nCurIdx])
  local mapActivityData = ConfigTable.GetData("Activity", self.nActivityId)
  if mapActivityData ~= nil then
    local nGroupId = mapActivityData.MidGroupId
    local mapGroupData = PlayerData.Activity:GetActivityGroupDataById(nGroupId)
    if mapGroupData ~= nil then
      local actData = mapGroupData:GetActivityDataByIndex(AllEnum.ActivityThemeFuncIndex.Task)
      if actData ~= nil then
        RedDotManager.RegisterNode(RedDotDefine.Activity_Group_Task_Group, {
          nGroupId,
          actData.ActivityId,
          mapActivityData.MiniGameRedDot
        }, self._mapNode.goRedDotTarget)
      else
        self._mapNode.goRedDotTarget:SetActive(false)
      end
    else
      self._mapNode.goRedDotTarget:SetActive(false)
    end
  else
    self._mapNode.goRedDotTarget:SetActive(false)
  end
end

function ThrowGiftLevelSelectCtrl:OnDisable()
  if self._switchAnimTimer ~= nil then
    self._switchAnimTimer:Cancel()
    self._switchAnimTimer = nil
  end
end

function ThrowGiftLevelSelectCtrl:OnDestroy()
end

function ThrowGiftLevelSelectCtrl:OnRelease()
end

function ThrowGiftLevelSelectCtrl:RefreshLevelInfo()
  self.actData = PlayerData.Activity:GetActivityDataById(self.nActivityId)
  self.mapRecordLevelData = {}
  self.mapRecordItemData = {}
  if self.actData ~= nil then
    local mapCachedData = self.actData:GetActivityData()
    self.mapRecordLevelData = mapCachedData.mapLevels
    self.mapRecordItemData = mapCachedData.mapItems
  end
  self.tbUnlockedGroup = {}
  self.tbClearedGroup = {}
  for _, nEnum in pairs(GameEnum.ThrowGiftDifficulty) do
    if self.mapLevelGroup[nEnum] ~= nil then
      for _, mapLevelCfgData in ipairs(self.mapLevelGroup[nEnum]) do
        if self:GetLevelUnlock(mapLevelCfgData.Id) and table.indexof(self.tbUnlockedGroup, nEnum) < 1 then
          table.insert(self.tbUnlockedGroup, nEnum)
        end
      end
    end
  end
  table.sort(self.tbUnlockedGroup)
  table.sort(self.tbClearedGroup)
  self.curGroup = #self.tbUnlockedGroup > 0 and self.tbUnlockedGroup[#self.tbUnlockedGroup] or GameEnum.ThrowGiftDifficulty.Easy
  for nGroup, tbLevelData in pairs(self.mapLevelGroup) do
    local bClear = true
    for _, mapLevelCfgData in ipairs(tbLevelData) do
      if self.mapRecordLevelData[mapLevelCfgData.Id] == nil or not self.mapRecordLevelData[mapLevelCfgData.Id].FirstComplete then
        bClear = false
      end
    end
    if bClear then
      table.insert(self.tbClearedGroup, nGroup)
    end
  end
end

function ThrowGiftLevelSelectCtrl:RefreshLevelInfoGrid()
  local tbCurGroup = self.mapLevelGroup[self.curGroup]
  local bShowBottomNew = false
  local tbNewLevel = {}
  if self.actData ~= nil then
    tbNewLevel = self.actData:GetNewLevels()
  end
  for _, nLevelId in ipairs(tbNewLevel) do
    if tbCurGroup[2] ~= nil and nLevelId > tbCurGroup[2].Id then
      bShowBottomNew = true
      break
    end
  end
  self.redDotBottom.gameObject:SetActive(bShowBottomNew)
  for i = 1, 2 do
    local nLevelId = tbCurGroup[i].Id
    local bUnlock = self:GetLevelUnlock(nLevelId)
    local nMaxScore = self.mapRecordLevelData[nLevelId] == nil and 0 or self.mapRecordLevelData[nLevelId].MaxScore
    local bPass = self.mapRecordLevelData[nLevelId] ~= nil and self.mapRecordLevelData[nLevelId].FirstComplete or false
    local bShowRedDot = false
    if self.actData ~= nil then
      bShowRedDot = self.actData:GetLevelNewState(nLevelId)
      if bShowRedDot then
        self.actData:SetLevelNew(nLevelId)
      end
    end
    self._mapNode.rtLevelInfo[i]:Refresh(nLevelId, bUnlock, nMaxScore, bPass, bShowRedDot, self.nOpenTime)
  end
  local bUnlock = 1 <= table.indexof(self.tbUnlockedGroup, self.curGroup)
  self._mapNode.imgGroupLockIcon:SetActive(not bUnlock)
  if bUnlock then
    NovaAPI.SetTMPText(self._mapNode.TMPGroupName, ConfigTable.GetUIText("ThrowGift_Difficulty" .. self.curGroup) or "")
  else
    local nCond = 0
    local nTime
    for _, mapLevelCfgData in ipairs(tbCurGroup) do
      local bUnlock, nLevelCond, nTimeLevel = self:GetLevelUnlock(mapLevelCfgData.Id)
      if not bUnlock then
        nCond = math.max(nCond, nLevelCond)
      end
      if nTimeLevel ~= nil then
        nTime = nTime == nil and nTimeLevel or math.min(nTimeLevel, nTime)
      end
    end
    if nCond == 2 then
      NovaAPI.SetTMPText(self._mapNode.TMPGroupName, ConfigTable.GetUIText("ThrowGift_GroupLockHint") or "")
    elseif nCond == 1 then
      NovaAPI.SetTMPText(self._mapNode.TMPGroupName, self:GetRemainTimeStr(nTime))
    else
      NovaAPI.SetTMPText(self._mapNode.TMPGroupName, "")
    end
  end
end

function ThrowGiftLevelSelectCtrl:GetRemainTimeStr(nRemainTime)
  if nRemainTime == nil then
    return ""
  end
  local timeStr = ""
  local day = math.floor(nRemainTime / 86400)
  local hour = math.floor(nRemainTime / 3600)
  local min = math.floor((nRemainTime - hour * 3600) / 60)
  local sec = nRemainTime - hour * 3600 - min * 60
  if 0 < day then
    timeStr = orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Day_Color"), day)
  elseif 0 < hour then
    timeStr = orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Hour_Color"), hour)
  elseif 0 < min then
    timeStr = orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Min_Color"), min)
  elseif 0 < sec then
    timeStr = orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Sec_Color"), sec)
  end
  return timeStr, 0 < nRemainTime
end

function ThrowGiftLevelSelectCtrl:GetLevelPass(nLevelId)
  if self.mapRecordLevelData[nLevelId] ~= nil and self.mapRecordLevelData[nLevelId].FirstComplete then
    return true
  end
  return false
end

function ThrowGiftLevelSelectCtrl:GetLevelUnlock(nLevelId)
  if self.actData == nil then
    return true
  end
  local mapLevelCfgData = ConfigTable.GetData("ThrowGiftLevel", nLevelId)
  if mapLevelCfgData == nil then
    return false, 0
  end
  if mapLevelCfgData.DayOpen ~= 0 and mapLevelCfgData.DayOpen ~= nil and self.nOpenTime ~= 0 then
    local curTime = CS.ClientManager.Instance.serverTimeStamp
    local openTime = CS.ClientManager.Instance:GetNextRefreshTime(self.nOpenTime) - 86400
    local remainTime = openTime + mapLevelCfgData.DayOpen * 86400 - curTime
    if 0 < remainTime then
      return false, 1, remainTime
    end
  end
  if mapLevelCfgData.PreLevelId ~= 0 then
    if self.mapRecordLevelData[mapLevelCfgData.PreLevelId] ~= nil and self.mapRecordLevelData[mapLevelCfgData.PreLevelId].FirstComplete then
      return true
    else
      return false, 2
    end
  else
    return true
  end
end

function ThrowGiftLevelSelectCtrl:OnBtnClick_GroupBtn(btn, nIdx)
  local enumDifficulty = mapDifficultyBtn[nIdx]
  if self.curGroup == enumDifficulty then
    return
  end
  self.curGroup = enumDifficulty
  self:RefreshLevelInfoGrid()
  local nCurIdx = 1
  local nMaxIdx = 1
  for i = 1, 4 do
    local enumDifficulty = mapDifficultyBtn[i]
    local bUnlock = 1 <= table.indexof(self.tbUnlockedGroup, enumDifficulty)
    self._mapNode.btnLevelCtrl[i]:SetBtnCurState(enumDifficulty == self.curGroup)
    self._mapNode.btnLevelCtrl[i]:SetBtnSelectState(enumDifficulty <= self.curGroup and bUnlock)
    if enumDifficulty == self.curGroup then
      nCurIdx = i
    end
    if bUnlock then
      nMaxIdx = math.max(nMaxIdx, i)
    end
  end
  NovaAPI.SetImageFillAmount(self._mapNode.imgLineTop, tbProgress[math.min(nCurIdx, nMaxIdx)])
  self._mapNode.imgBgAnim:Play("ThrowGiftsBgSwitch_in" .. nCurIdx)
  self.rootAnim:Play("ThrowGiftsLevelSelectPanel_switch")
  
  local function wait()
    self._mapNode.rtPenguin.speed = 1
    self._mapNode.DecoRoot.speed = 1
    self._switchAnimTimer = nil
  end
  
  self._mapNode.rtPenguin.speed = 3
  self._mapNode.DecoRoot.speed = 20
  if self._switchAnimTimer ~= nil then
    self._switchAnimTimer:Cancel()
    self._switchAnimTimer = nil
  end
  self._switchAnimTimer = self:AddTimer(1, 0.6, wait, true, true, true)
end

function ThrowGiftLevelSelectCtrl:OnBtnClick_Next()
  local nCurIdx = 1
  for nIdx, nEnum in ipairs(mapDifficultyBtn) do
    if self.curGroup == nEnum then
      nCurIdx = nIdx
    end
  end
  if nCurIdx == 4 then
    nCurIdx = 1
  else
    nCurIdx = nCurIdx + 1
  end
  local enumDifficulty = mapDifficultyBtn[nCurIdx]
  self.curGroup = enumDifficulty
  self:RefreshLevelInfoGrid()
  local nCurIdx = 1
  local nMaxIdx = 1
  for i = 1, 4 do
    local enumDifficulty = mapDifficultyBtn[i]
    local bUnlock = 1 <= table.indexof(self.tbUnlockedGroup, enumDifficulty)
    self._mapNode.btnLevelCtrl[i]:SetBtnCurState(enumDifficulty == self.curGroup)
    self._mapNode.btnLevelCtrl[i]:SetBtnSelectState(enumDifficulty <= self.curGroup and bUnlock)
    if enumDifficulty == self.curGroup then
      nCurIdx = i
    end
    if bUnlock then
      nMaxIdx = math.max(nMaxIdx, i)
    end
  end
  NovaAPI.SetImageFillAmount(self._mapNode.imgLineTop, tbProgress[math.min(nCurIdx, nMaxIdx)])
  self._mapNode.imgBgAnim:Play("ThrowGiftsBgSwitch_in" .. nCurIdx)
  self.rootAnim:Play("ThrowGiftsLevelSelectPanel_switch")
  
  local function wait()
    self._mapNode.rtPenguin.speed = 1
    self._mapNode.DecoRoot.speed = 1
    self._switchAnimTimer = nil
  end
  
  self._mapNode.rtPenguin.speed = 3
  self._mapNode.DecoRoot.speed = 20
  if self._switchAnimTimer ~= nil then
    self._switchAnimTimer:Cancel()
    self._switchAnimTimer = nil
  end
  self._switchAnimTimer = self:AddTimer(1, 0.6, wait, true, true, true)
end

function ThrowGiftLevelSelectCtrl:OnBtnClick_Prev()
  local nCurIdx = 1
  for nIdx, nEnum in ipairs(mapDifficultyBtn) do
    if self.curGroup == nEnum then
      nCurIdx = nIdx
    end
  end
  if nCurIdx == 1 then
    nCurIdx = 4
  else
    nCurIdx = nCurIdx - 1
  end
  local enumDifficulty = mapDifficultyBtn[nCurIdx]
  self.curGroup = enumDifficulty
  self:RefreshLevelInfoGrid()
  local nCurIdx = 1
  local nMaxIdx = 1
  for i = 1, 4 do
    local enumDifficulty = mapDifficultyBtn[i]
    local bUnlock = 1 <= table.indexof(self.tbUnlockedGroup, enumDifficulty)
    self._mapNode.btnLevelCtrl[i]:SetBtnCurState(enumDifficulty == self.curGroup)
    self._mapNode.btnLevelCtrl[i]:SetBtnSelectState(enumDifficulty <= self.curGroup and bUnlock)
    if enumDifficulty == self.curGroup then
      nCurIdx = i
    end
    if bUnlock then
      nMaxIdx = math.max(nMaxIdx, i)
    end
  end
  NovaAPI.SetImageFillAmount(self._mapNode.imgLineTop, tbProgress[math.min(nCurIdx, nMaxIdx)])
  self._mapNode.imgBgAnim:Play("ThrowGiftsBgSwitch_in" .. nCurIdx)
  self.rootAnim:Play("ThrowGiftsLevelSelectPanel_switch")
  
  local function wait()
    self._mapNode.rtPenguin.speed = 1
    self._mapNode.DecoRoot.speed = 1
    self._switchAnimTimer = nil
  end
  
  self._mapNode.rtPenguin.speed = 3
  self._mapNode.DecoRoot.speed = 20
  if self._switchAnimTimer ~= nil then
    self._switchAnimTimer:Cancel()
    self._switchAnimTimer = nil
  end
  self._switchAnimTimer = self:AddTimer(1, 0.6, wait, true, true, true)
end

function ThrowGiftLevelSelectCtrl:OnBtnClick_ItemDic()
  self._mapNode.rtItemInfo:OpenPanel()
end

function ThrowGiftLevelSelectCtrl:OnBtnClick_Target()
  local mapActivityData = ConfigTable.GetData("Activity", self.nActivityId)
  if mapActivityData ~= nil then
    local nGroupId = mapActivityData.MidGroupId
    local mapGroupData = PlayerData.Activity:GetActivityGroupDataById(nGroupId)
    if mapGroupData ~= nil then
      local actData = mapGroupData:GetActivityDataByIndex(AllEnum.ActivityThemeFuncIndex.Task)
      if actData ~= nil then
        EventManager.Hit(EventId.OpenPanel, self._panel.nQuestPanelId, actData.ActivityId, 4)
      end
    end
  end
end

return ThrowGiftLevelSelectCtrl
