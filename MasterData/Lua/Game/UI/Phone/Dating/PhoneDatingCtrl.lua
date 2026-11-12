local PhoneDatingCtrl = class("PhoneDatingCtrl", BaseCtrl)
local LocalData = require("GameCore.Data.LocalData")
local newDayTime = UTILS.GetDayRefreshTimeOffset()
PhoneDatingCtrl._mapNodeConfig = {
  txtDatingTime = {sComponentName = "TMP_Text"},
  imgHeadIcon = {sComponentName = "Image"},
  txtCharName = {sComponentName = "TMP_Text"},
  imgForce = {sComponentName = "Image"},
  goAffinityProgress = {},
  rectProgress = {
    sNodeName = "imgProgress",
    sComponentName = "RectTransform"
  },
  txtProgress = {sComponentName = "TMP_Text"},
  imgAffinity = {sComponentName = "Image"},
  txtLevel = {sComponentName = "TMP_Text"},
  txtAffinity = {sComponentName = "TMP_Text"},
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Phone_Dating_Special_Event_Title"
  },
  datingEventLSV = {
    sComponentName = "LoopScrollView"
  },
  btnCharDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CharDetail"
  },
  txtBtnCharDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "Phone_Dating_Char_Detail_Btn"
  },
  btnStartDating = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_StartDating"
  },
  txtBtnStartDating = {
    sComponentName = "TMP_Text",
    sLanguageId = "Phone_Dating_Start_Dating_Btn"
  },
  btnDatingGray = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_DatingGray"
  },
  txtBtnDatingGray = {
    sComponentName = "TMP_Text",
    sLanguageId = "Phone_Char_Dating_Count_Max"
  },
  goEventDetail = {},
  goBlur = {},
  goWindow = {},
  aniWindow = {sNodeName = "goWindow", sComponentName = "Animator"},
  btnBg = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Phone_Dating_Event_Window_Title"
  },
  imgChar = {sComponentName = "Image"},
  imgSpCg = {sComponentName = "Image"},
  txtLandmark = {sComponentName = "TMP_Text"},
  txtEventName = {sComponentName = "TMP_Text"},
  txtDesc = {sComponentName = "TMP_Text"},
  btnReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reward"
  },
  btnLeft = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Left"
  },
  btnRight = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Right"
  },
  goPageDot = {},
  goPage = {nCount = 8},
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  }
}
PhoneDatingCtrl._mapEventConfig = {}
PhoneDatingCtrl._mapRedDotConfig = {}

function PhoneDatingCtrl:Refresh(nCharId)
  self.nCharId = nCharId
  local mapCharacter = ConfigTable.GetData_Character(nCharId)
  if mapCharacter ~= nil then
    local nSkinId = mapCharacter.DefaultSkinId
    local mapSkin = ConfigTable.GetData_CharacterSkin(nSkinId)
    if mapSkin ~= nil then
      self:SetPngSprite(self._mapNode.imgHeadIcon, mapSkin.Icon, AllEnum.CharHeadIconSurfix.S)
    end
    NovaAPI.SetTMPText(self._mapNode.txtCharName, mapCharacter.Name)
    local mapCharDes = ConfigTable.GetData("CharacterDes", nCharId)
    if mapCharDes then
      local mapForceCfg = ConfigTable.GetData("Force", mapCharDes.Force)
      if mapForceCfg ~= nil then
      end
    end
  end
  self._mapNode.goEventDetail.gameObject:SetActive(false)
  local nCount, nAllCount = PlayerData.Dating:GetDatingCount()
  NovaAPI.SetTMPText(self._mapNode.txtDatingTime, orderedFormat(ConfigTable.GetUIText("Dating_Day_Count"), nCount, nAllCount))
  local bDating = PlayerData.Dating:CheckDating(self.nCharId)
  self._mapNode.btnStartDating.gameObject:SetActive(not bDating)
  self._mapNode.btnDatingGray.gameObject:SetActive(bDating)
  self.mapEvent = PlayerData.Dating:GetLimitedEventList(self.nCharId)
  self.mapUnlockEvent = {}
  for k, v in ipairs(self.mapEvent) do
    if v.Status ~= AllEnum.DatingEventStatus.Lock then
      table.insert(self.mapUnlockEvent, v)
    end
  end
  self._mapNode.datingEventLSV.gameObject:SetActive(#self.mapEvent > 0)
  self._mapNode.datingEventLSV:SetAnim(0.1)
  self._mapNode.datingEventLSV:Init(#self.mapEvent, self, self.OnGridRefresh, self.OnGridClick)
  self:RefreshAffinity()
end

function PhoneDatingCtrl:RefreshAffinity()
  local affinityData = PlayerData.Char:GetCharAffinityData(self.nCharId)
  if affinityData == nil then
    return
  end
  self.curFavourLevel = affinityData.Level
  self.curFavourExp = affinityData.Exp
  NovaAPI.SetTMPText(self._mapNode.txtLevel, self.curFavourLevel)
  if self.curFavourLevel < ConfigTable.GetConfigNumber("PhoneDatingAffinityLimit") then
    self._mapNode.btnStartDating.gameObject:SetActive(false)
    self._mapNode.btnDatingGray.gameObject:SetActive(true)
    local sTip = orderedFormat(ConfigTable.GetUIText("Phone_Dating_Affinity_Limit"), ConfigTable.GetConfigNumber("PhoneDatingAffinityLimit"))
    NovaAPI.SetTMPText(self._mapNode.txtBtnDatingGray, sTip)
  else
    NovaAPI.SetTMPText(self._mapNode.txtBtnDatingGray, ConfigTable.GetUIText("Phone_Char_Dating_Count_Max"))
  end
  local mapCharAffinity = ConfigTable.GetData("CharAffinityTemplate", self.nCharId)
  if mapCharAffinity == nil then
    return
  end
  local templateId = mapCharAffinity.TemplateId
  self.MaxAffinityLevel = PlayerData.Char:GetMaxAffinityLevel(templateId)
  local percent = 0
  local level = self.curFavourLevel >= self.MaxAffinityLevel and self.MaxAffinityLevel or self.curFavourLevel + 1
  local data = CacheTable.GetData("_AffinityLevel", templateId)[level]
  local curData = CacheTable.GetData("_AffinityLevel", templateId)[self.curFavourLevel]
  if self.curFavourLevel >= self.MaxAffinityLevel then
    percent = 1
  else
    percent = self.curFavourExp / data.NeedExp
  end
  local sizeDelta = self._mapNode.rectProgress.sizeDelta
  sizeDelta.x = self.progressBarWidth * percent < self.progressBarMinWidth and self.progressBarMinWidth or self.progressBarWidth * percent
  self._mapNode.rectProgress.sizeDelta = sizeDelta
  self._mapNode.rectProgress.gameObject:SetActive(self.curFavourExp > 0 or self.curFavourLevel >= self.MaxAffinityLevel)
  if self.curFavourLevel >= self.MaxAffinityLevel then
    NovaAPI.SetTMPText(self._mapNode.txtProgress, ConfigTable.GetUIText("Phone_Gift_Affinity_Max_Level"))
  else
    NovaAPI.SetTMPText(self._mapNode.txtProgress, string.format("%d/%d", self.curFavourExp, data.NeedExp))
  end
  NovaAPI.SetTMPText(self._mapNode.txtAffinity, curData.AffinityLevelName)
  self:SetPngSprite(self._mapNode.imgAffinity, curData.AffinityLevelIcon .. "_s")
end

function PhoneDatingCtrl:OnGridRefresh(goGrid, goIndex)
  local nIndex = goIndex + 1
  local eventData = self.mapEvent[nIndex]
  if eventData ~= nil then
    local mapCfg = ConfigTable.GetData("DatingCharacterEvent", eventData.Id)
    if mapCfg ~= nil then
      local imgLock = goGrid.transform:Find("btnGrid/AnimRoot/imgLock")
      local goUnlock = goGrid.transform:Find("btnGrid/AnimRoot/goUnlock")
      local imgSpCg = goUnlock.transform:Find("mask/imgSpCg"):GetComponent("Image")
      local txtDesc = goGrid.transform:Find("btnGrid/AnimRoot/txtDesc"):GetComponent("TMP_Text")
      local imgTitleBg = goGrid.transform:Find("btnGrid/AnimRoot/imgTitleBg")
      local txtLandmark = goGrid.transform:Find("btnGrid/AnimRoot/imgTitleBg/txtLandmark"):GetComponent("TMP_Text")
      local redDot = goGrid.transform:Find("btnGrid/AnimRoot/goUnlock/redDotDatingReward")
      RedDotManager.RegisterNode(RedDotDefine.Phone_Dating_Reward, {
        self.nCharId,
        eventData.Id
      }, redDot, nil, nil, true)
      local bLock = eventData.Status == AllEnum.DatingEventStatus.Lock
      imgTitleBg.gameObject:SetActive(not bLock)
      imgLock.gameObject:SetActive(bLock)
      goUnlock.gameObject:SetActive(not bLock)
      if bLock then
        NovaAPI.SetTMPText(txtDesc, mapCfg.Clue)
      else
        NovaAPI.SetTMPText(txtDesc, mapCfg.Name)
        local mapLandmark = ConfigTable.GetData("DatingLandmark", eventData.LandMark)
        if mapLandmark ~= nil then
          NovaAPI.SetTMPText(txtLandmark, mapLandmark.Name)
        end
        if mapCfg.CG ~= nil then
          local sCGPath = "Icon/DatingEventCG/" .. mapCfg.CG
          self:SetPngSprite(imgSpCg, sCGPath)
        end
      end
    end
  end
end

function PhoneDatingCtrl:OnGridClick(goGrid, goIndex)
  local nSelectIndex = goIndex + 1
  local eventData = self.mapEvent[nSelectIndex]
  if eventData.Status == AllEnum.DatingEventStatus.Lock then
    return
  end
  for k, v in ipairs(self.mapUnlockEvent) do
    if v.Id == eventData.Id then
      self.nSelectIndex = k
    end
  end
  self:OpenWindow()
end

function PhoneDatingCtrl:OpenWindow()
  self._mapNode.goEventDetail.gameObject:SetActive(true)
  self._mapNode.goWindow.gameObject:SetActive(false)
  self._mapNode.goBlur.gameObject:SetActive(true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goWindow.gameObject:SetActive(true)
    self._mapNode.aniWindow:Play("t_window_04_t_in")
    EventManager.Hit("OpenEventDetailWindow", true)
    self:RefreshEventContent()
  end
  
  cs_coroutine.start(wait)
end

function PhoneDatingCtrl:CloseWindow()
  EventManager.Hit("OpenEventDetailWindow", false)
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  self._mapNode.goBlur.gameObject:SetActive(false)
  local nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.aniWindow, {
    "t_window_04_t_out"
  })
  self:AddTimer(1, nAnimLen, function()
    self._mapNode.goEventDetail.gameObject:SetActive(false)
  end, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimLen)
end

function PhoneDatingCtrl:RefreshEventContent()
  self.curEventData = self.mapUnlockEvent[self.nSelectIndex]
  local mapCfg = ConfigTable.GetData("DatingCharacterEvent", self.curEventData.Id)
  if mapCfg ~= nil then
    local nCharId = tonumber(mapCfg.DatingEventParams[1])
    local nLandmarkId = tonumber(mapCfg.DatingEventParams[2])
    local mapLandmark = ConfigTable.GetData("DatingLandmark", nLandmarkId)
    if mapLandmark ~= nil then
      local sLandmark = mapLandmark.Name
      NovaAPI.SetTMPText(self._mapNode.txtLandmark, sLandmark)
    end
    local nSkinId = PlayerData.Char:GetCharSkinId(nCharId)
    local mapSkin = ConfigTable.GetData_CharacterSkin(nSkinId)
    if mapSkin ~= nil then
      self:SetPngSprite(self._mapNode.imgChar, mapSkin.Icon, AllEnum.CharHeadIconSurfix.XXL)
    end
    NovaAPI.SetTMPText(self._mapNode.txtEventName, mapCfg.Name)
    if self.curEventData.Status == AllEnum.DatingEventStatus.Lock then
      NovaAPI.SetTMPText(self._mapNode.txtDesc, mapCfg.Clue)
    else
      NovaAPI.SetTMPText(self._mapNode.txtDesc, mapCfg.Memory)
    end
    self._mapNode.btnReward.gameObject:SetActive(self.curEventData.Status == AllEnum.DatingEventStatus.Unlock)
    if mapCfg.CG ~= nil then
      local sCGPath = "Icon/DatingEventCG/" .. mapCfg.CG
      self:SetPngSprite(self._mapNode.imgSpCg, sCGPath)
    end
  end
  for k, v in ipairs(self._mapNode.goPage) do
    v.gameObject:SetActive(k <= #self.mapUnlockEvent)
    if k <= #self.mapUnlockEvent then
      local goCur = v.gameObject.transform:Find("imgPage")
      goCur.gameObject:SetActive(k == self.nSelectIndex)
    end
  end
  self._mapNode.btnLeft.gameObject:SetActive(self.nSelectIndex > 1)
  self._mapNode.btnRight.gameObject:SetActive(self.nSelectIndex < #self.mapUnlockEvent)
end

function PhoneDatingCtrl:Awake()
  self.progressBarWidth = 253
  self.progressBarMinWidth = 0
end

function PhoneDatingCtrl:FadeIn()
end

function PhoneDatingCtrl:FadeOut()
end

function PhoneDatingCtrl:OnEnable()
  local ModuleManager = require("GameCore.Module.ModuleManager")
  local sCurModule = ModuleManager.GetCurModuleName()
  self._mapNode.btnCharDetail.gameObject:SetActive(sCurModule ~= "DormModuleScene")
end

function PhoneDatingCtrl:OnDisable()
end

function PhoneDatingCtrl:OnDestroy()
end

function PhoneDatingCtrl:OnRelease()
end

function PhoneDatingCtrl:OnBtnClick_CharDetail()
  if nil ~= self.nCharId then
    if PanelManager.CheckPanelOpen(PanelId.CharBgPanel) then
      EventManager.Hit(EventId.ClosePanel, PanelId.Phone)
      EventManager.Hit(EventId.CharBgRefresh, PanelId.CharacterRelation, self.nCharId)
    else
      EventManager.Hit(EventId.OpenPanel, PanelId.CharBgPanel, PanelId.CharacterRelation, self.nCharId)
    end
  end
end

function PhoneDatingCtrl:OnBtnClick_StartDating()
  local nCount, nAllCount = PlayerData.Dating:GetDatingCount()
  if not PlayerData.Dating:IsFreeDating() and nAllCount <= nCount then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Dating_Day_Count_Max"))
    return
  end
  local bDating = PlayerData.Dating:CheckDating(self.nCharId)
  if bDating then
    return
  end
  local mapCharCfg = ConfigTable.GetData_Character(self.nCharId)
  if mapCharCfg ~= nil then
    local TipsTime = LocalData.GetPlayerLocalData("PhoneDating_Tips_Time")
    local _tipDay = 0
    if TipsTime ~= nil then
      _tipDay = tonumber(TipsTime)
    end
    local curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
    local fixedTimeStamp = curTimeStamp + newDayTime * 3600
    local nYear = tonumber(os.date("!%Y", fixedTimeStamp))
    local nMonth = tonumber(os.date("!%m", fixedTimeStamp))
    local nDay = tonumber(os.date("!%d", fixedTimeStamp))
    local nowD = nYear * 366 + nMonth * 31 + nDay
    if nowD == _tipDay then
      EventManager.Hit(EventId.OpenPanel, PanelId.DatingLandmark, self.nCharId)
    else
      local sTip = orderedFormat(ConfigTable.GetUIText("Phone_Dating_Start_Tip_Text"), mapCharCfg.Name)
      local isSelectAgain = false
      
      local function confirmCallback()
        if isSelectAgain then
          local _curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
          local _fixedTimeStamp = _curTimeStamp + newDayTime * 3600
          local _nYear = tonumber(os.date("!%Y", _fixedTimeStamp))
          local _nMonth = tonumber(os.date("!%m", _fixedTimeStamp))
          local _nDay = tonumber(os.date("!%d", _fixedTimeStamp))
          local _nowD = _nYear * 366 + _nMonth * 31 + _nDay
          LocalData.SetPlayerLocalData("PhoneDating_Tips_Time", tostring(_nowD))
        end
        EventManager.Hit(EventId.OpenPanel, PanelId.DatingLandmark, self.nCharId)
      end
      
      local function againCallback(isSelect)
        isSelectAgain = isSelect
      end
      
      local msg = {
        nType = AllEnum.MessageBox.Confirm,
        sTitle = ConfigTable.GetUIText("Phone_Dating_Start_Tip_Title"),
        sContent = sTip,
        callbackConfirm = confirmCallback,
        callbackAgain = againCallback
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
    end
  end
end

function PhoneDatingCtrl:OnBtnClick_DatingGray()
  local sTip
  if self.curFavourLevel < ConfigTable.GetConfigNumber("PhoneDatingAffinityLimit") then
    sTip = orderedFormat(ConfigTable.GetUIText("Phone_Dating_Affinity_Limit"), ConfigTable.GetConfigNumber("PhoneDatingAffinityLimit"))
  else
    sTip = ConfigTable.GetUIText("Phone_Dating_Day_Max_Count")
  end
  EventManager.Hit(EventId.OpenMessageBox, sTip)
end

function PhoneDatingCtrl:OnBtnClick_Reward()
  local function callback()
    self.mapEvent = PlayerData.Dating:GetLimitedEventList(self.nCharId)
    
    self.mapUnlockEvent = {}
    for k, v in ipairs(self.mapEvent) do
      if v.Status ~= AllEnum.DatingEventStatus.Lock then
        table.insert(self.mapUnlockEvent, v)
      end
    end
    self._mapNode.datingEventLSV:Init(#self.mapEvent, self, self.OnGridRefresh, self.OnGridClick)
    self:RefreshEventContent()
  end
  
  PlayerData.Dating:SendReceiveDatingEventRewardMsg(self.nCharId, self.curEventData.Id, callback)
end

function PhoneDatingCtrl:OnBtnClick_Left()
  self.nSelectIndex = self.nSelectIndex - 1
  self:RefreshEventContent()
end

function PhoneDatingCtrl:OnBtnClick_Right()
  self.nSelectIndex = self.nSelectIndex + 1
  self:RefreshEventContent()
end

function PhoneDatingCtrl:OnBtnClick_Close()
  self:CloseWindow()
end

return PhoneDatingCtrl
