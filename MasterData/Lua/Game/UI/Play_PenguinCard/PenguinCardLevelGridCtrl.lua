local PenguinCardLevelGridCtrl = class("PenguinCardLevelGridCtrl", BaseCtrl)
PenguinCardLevelGridCtrl._mapNodeConfig = {
  btnLevel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Level"
  },
  trRoot = {sNodeName = "AnimRoot", sComponentName = "Transform"},
  reddotNew = {},
  txtName = {sComponentName = "TMP_Text"},
  goStarOn = {nCount = 3},
  goStarOff = {nCount = 3},
  goOn = {},
  goMask = {},
  txtLock = {sComponentName = "TMP_Text"},
  imgComplete = {}
}
PenguinCardLevelGridCtrl._mapEventConfig = {
  PenguinCardTriggered = "OnEvent_Triggered"
}

function PenguinCardLevelGridCtrl:RefreshHard(actData, nLevelId)
  self.actData = actData
  self.nLevelId = nLevelId
  local mapLevel = self.actData:GetLevelData(nLevelId)
  self:Refresh(nLevelId, mapLevel)
  local txtBest = self._mapNode.trRoot:Find("goOn/imgBestBg/txtBest"):GetComponent("TMP_Text")
  local txtScore = self._mapNode.trRoot:Find("goOn/imgBestBg/txtScore"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txtBest, ConfigTable.GetUIText("PenguinCard_Level_BestScore"))
  NovaAPI.SetTMPText(txtScore, self:ThousandsNumber(clearFloat(mapLevel.nScore)))
end

function PenguinCardLevelGridCtrl:RefreshEndless(actData, nLevelId)
  self.actData = actData
  self.nLevelId = nLevelId
  local mapLevel = self.actData:GetLevelData(nLevelId)
  self:Refresh(nLevelId, mapLevel)
  local txtBest = self._mapNode.trRoot:Find("goOn/imgBestBg/txtBest"):GetComponent("TMP_Text")
  local txtScore = self._mapNode.trRoot:Find("goOn/imgBestBg/txtScore"):GetComponent("TMP_Text")
  local nDifficulty = mapLevel.nDifficulty == 0 and 1 or mapLevel.nDifficulty
  NovaAPI.SetTMPText(txtBest, orderedFormat(ConfigTable.GetUIText("PenguinCard_Endless_LevelGridTittle"), nDifficulty))
  NovaAPI.SetTMPText(txtScore, self:ThousandsNumber(clearFloat(mapLevel.nScore)))
end

function PenguinCardLevelGridCtrl:RefreshNormal(actData, nIndex, nLevelId)
  self.actData = actData
  self.nLevelId = nLevelId
  local mapLevel = self.actData:GetLevelData(nLevelId)
  self:Refresh(nLevelId, mapLevel)
  local goUp = self.gameObject.transform:Find("goUp").gameObject
  local goDown = self.gameObject.transform:Find("goDown").gameObject
  if nIndex % 2 == 0 then
    goUp:SetActive(false)
    goDown:SetActive(true)
  else
    goUp:SetActive(true)
    goDown:SetActive(false)
  end
end

function PenguinCardLevelGridCtrl:Refresh(nLevelId, mapLevel)
  local mapCfg = ConfigTable.GetData("ActivityPenguinCardLevel", nLevelId)
  if not mapCfg then
    return
  end
  RedDotManager.RegisterNode(RedDotDefine.Activity_PenguinCard_Level, {nLevelId}, self._mapNode.reddotNew)
  NovaAPI.SetTMPText(self._mapNode.txtName, mapCfg.Name)
  for i = 1, 3 do
    self._mapNode.goStarOn[i]:SetActive(i <= mapLevel.nStar)
    self._mapNode.goStarOff[i]:SetActive(i > mapLevel.nStar)
  end
  self:RefreshLock(nLevelId)
  if mapCfg.Type == GameEnum.ActivityPenguinCardLevelType.Endless then
    self._mapNode.imgComplete:SetActive(mapLevel.nScore > 0)
  else
    self._mapNode.imgComplete:SetActive(mapLevel.nStar > 0)
  end
end

function PenguinCardLevelGridCtrl:GetLock()
  return self.bLock
end

function PenguinCardLevelGridCtrl:RefreshLock(nLevelId)
  local bLock, nRemain = self.actData:CheckLevelLockByTime(nLevelId)
  if bLock then
    self._mapNode.goMask:SetActive(true)
    self._mapNode.goOn:SetActive(false)
    local sTime = self:GetTimeText(nRemain)
    NovaAPI.SetTMPText(self._mapNode.txtLock, sTime)
    self.bLock = true
    self.sLockTip = sTime
    return
  end
  bLock = self.actData:CheckLevelLockByPrev(nLevelId)
  if bLock then
    self._mapNode.goMask:SetActive(true)
    self._mapNode.goOn:SetActive(false)
    local sTip = ConfigTable.GetUIText("PenguinCard_Level_LockLevel")
    NovaAPI.SetTMPText(self._mapNode.txtLock, sTip)
    self.bLock = true
    self.sLockTip = ConfigTable.GetUIText("PenguinCard_Level_LockLevelTips")
    return
  end
  self._mapNode.goMask:SetActive(false)
  self._mapNode.goOn:SetActive(true)
  self.bLock = false
  self.sLockTip = ""
end

function PenguinCardLevelGridCtrl:GetTimeText(remainTime)
  local sTimeStr = ""
  if remainTime <= 60 then
    local sec = math.floor(remainTime)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Sec_Color_Common") or "", sec)
  elseif 60 < remainTime and remainTime <= 3600 then
    local min = math.floor(remainTime / 60)
    local sec = math.floor(remainTime - min * 60)
    if sec == 0 then
      min = min - 1
      sec = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Min_Color_Common") or "", min, sec)
  elseif 3600 < remainTime and remainTime <= 86400 then
    local hour = math.floor(remainTime / 3600)
    local min = math.floor((remainTime - hour * 3600) / 60)
    if min == 0 then
      hour = hour - 1
      min = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Hour_Color_Common") or "", hour, min)
  elseif 86400 < remainTime then
    local day = math.floor(remainTime / 86400)
    local hour = math.floor((remainTime - day * 86400) / 3600)
    if hour == 0 then
      day = day - 1
      hour = 24
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Day_Color_Common") or "", day, hour)
  end
  return sTimeStr
end

function PenguinCardLevelGridCtrl:EnterLevel()
  local bOpen = self.actData:CheckActivityOpen()
  if not bOpen then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Alert,
      sContent = ConfigTable.GetUIText("Activity_Invalid_Tip_3"),
      callbackConfirm = function()
        PanelManager.Home()
      end,
      callbackCancel = function()
        PanelManager.Home()
      end
    })
    return
  end
  if self.bLock then
    EventManager.Hit(EventId.OpenMessageBox, self.sLockTip)
    return
  end
  
  local function enter()
    local function callback()
      self.actData:EnterLevel(self.nLevelId)
    end
    
    EventManager.Hit("PenguinCard_EnterLevel", callback)
  end
  
  local function checkLevelData()
    local mapLevelData = self.actData:GetLevelData(self.nLevelId)
    if mapLevelData.sData ~= "" then
      local msg = {
        nType = AllEnum.MessageBox.Confirm,
        sContent = ConfigTable.GetUIText("PenguinCard_Endless_LevelHasData"),
        sConfirm = ConfigTable.GetUIText("PenguinCard_Btn_ReconnectConfirm"),
        sCancel = ConfigTable.GetUIText("PenguinCard_Btn_ReconnectCancel"),
        callbackConfirm = enter,
        callbackCancel = function()
          local nStar, nScore, nDifficulty = self.actData:GetLevelDataBySave(mapLevelData.sData)
          
          local function callback()
            self:RefreshEndless(self.actData, self.nLevelId)
          end
          
          self.actData:SendActivityPenguinCardSettleReq(self.nLevelId, nStar, nScore, nDifficulty, callback)
        end,
        bCloseNoHandler = true,
        bRedCancel = true
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
    else
      enter()
    end
  end
  
  local bSkipAble = self.actData:CheckLevelSkipAble(self.nLevelId)
  if bSkipAble then
    local mapCfg = ConfigTable.GetData("ActivityPenguinCardLevel", self.nLevelId)
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = ConfigTable.GetUIText("PenguinCard_SkipTipsDesc"),
      sContentSub = orderedFormat(ConfigTable.GetUIText("PenguinCard_SkipTipsSubDesc"), mapCfg.Name or ""),
      sConfirm = ConfigTable.GetUIText("PenguinCard_Btn_DontSkip"),
      sCancel = ConfigTable.GetUIText("PenguinCard_Btn_SkipLevel"),
      callbackConfirm = checkLevelData,
      callbackCancel = function()
        self.actData:SendSkipLevelReq(self.nLevelId, function()
          EventManager.Hit("ActivityPenguinCardSkipLevel")
        end)
      end,
      bCloseNoHandler = true
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  else
    checkLevelData()
  end
end

function PenguinCardLevelGridCtrl:Awake()
end

function PenguinCardLevelGridCtrl:OnEnable()
end

function PenguinCardLevelGridCtrl:OnDisable()
end

function PenguinCardLevelGridCtrl:OnBtnClick_Level()
  self:EnterLevel()
  EventManager.Hit("PenguinCard_ClickLevel", self.gameObject)
end

return PenguinCardLevelGridCtrl
