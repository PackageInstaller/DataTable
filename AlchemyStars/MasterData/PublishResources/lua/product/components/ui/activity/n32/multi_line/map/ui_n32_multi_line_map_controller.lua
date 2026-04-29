_class("UIN32MultiLineMapController", UIController)
UIN32MultiLineMapController = UIN32MultiLineMapController

function UIN32MultiLineMapController:Constructor()
  self.mCampaignModule = self:GetModule(CampaignModule)
end

function UIN32MultiLineMapController:LoadDataOnEnter(TT, res)
  local comType = ECampaignType.CAMPAIGN_TYPE_N32
  local comId = ECampaignN32ComponentID.ECAMPAIGN_N32_MULTILINE_MISSION
  self.multiLineData = UIMultiLineData:New()
  if not self.multiLineData:LoadData(TT, res, comType, comId) then
    self.mCampaignModule:CheckErrorCode(res.m_result, self.mCampaignModule._id, nil, nil)
    return
  end
  res:SetSucc(true)
end

function UIN32MultiLineMapController:OnShow(uiParams)
  self._multilineFolerIndex = uiParams[1]
  self._isMatch = uiParams[2]
  self._isWin = uiParams[3]
  self._shotScreenTexture = uiParams[4]
  self._cfg = self.multiLineData:GetMultiLineFolderCfgByIndex(self._multilineFolerIndex)
  self._multilineComponent, self._multilineComInfo = self.multiLineData:GetComponent()
  self._timerHolder = UITimerHolder:New()
  self:InitWidget()
  self:OnValue()
end

function UIN32MultiLineMapController:OnHide()
  self._timerHolder:Dispose()
  if self._shot then
    self._shot:CleanRenderTexture()
  end
end

function UIN32MultiLineMapController:RefreshAfterPlot()
  self._isMatch = true
  self._isWin = true
  self:RefreshDocRed()
  self._contentMap:SetData(self._multilineFolerIndex, self._cfg, self.multiLineData, self._isMatch, self._isWin)
  self:StartTask(function(TT)
    local lockName = "UIN32MultiLineMapController_check_unlockAni"
    self:Lock(lockName)
    self._contentMap:CheckAndPlayUnlockAni(TT)
    self:UnLock(lockName)
  end)
end

function UIN32MultiLineMapController:RefreshAfterDialog()
  self:RefreshDocRed()
  self._contentMap:SetData(self._multilineFolerIndex, self._cfg, self.multiLineData)
  self:_CheckGuide()
end

function UIN32MultiLineMapController:InitWidget()
  self.mapContent = self:GetGameObject("mapContent")
  self.map1 = self:GetUIComponent("UISelectObjectPath", "map1")
  self.map2 = self:GetUIComponent("UISelectObjectPath", "map2")
  self.map3 = self:GetUIComponent("UISelectObjectPath", "map3")
  self.topBtn = self:GetUIComponent("UISelectObjectPath", "topBtn")
  self.countDownTxt = self:GetUIComponent("UILocalizationText", "countDownTxt")
  self.mapBg = self:GetUIComponent("RawImageLoader", "mapBg")
  self.docRedPoint = self:GetGameObject("docRedPoint")
  self.animation = self:GetUIComponent("Animation", "animation")
  self.screeShotImage = self:GetUIComponent("RawImage", "screenshot")
  self._shot = self:GetUIComponent("H3DUIBlurHelper", "screenshot")
  local backBtns = self:GetUIComponent("UISelectObjectPath", "topBtn")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    if self:CheckComponentTime() then
      self:StartTask(function(TT)
        self:GetRenderTexture(function(textrue)
          self.mCampaignModule:CampaignSwitchState(true, UIStateType.UIN32MultiLineMain, UIStateType.UIMain, {true, textrue}, self.multiLineData:GetCampaignId())
        end)
      end)
    end
  end, function()
    if self:CheckComponentTime() then
      self:ShowDialog("UIIntroLoader", "UIN32MultilineMapIntro")
    end
  end, nil, true)
  self._petEnhanceAreaGo = self:GetGameObject("PetEnhanceAreaGen")
end

function UIN32MultiLineMapController:BtnDocOnClick(go)
  if self:CheckComponentTime() then
    self:ShowDialog("UIN32MultiLineArchive", self)
  end
end

function UIN32MultiLineMapController:OnValue()
  local mapPool
  if self._multilineFolerIndex == 1 then
    mapPool = self.map1
  elseif self._multilineFolerIndex == 2 then
    mapPool = self.map2
  elseif self._multilineFolerIndex == 3 then
    mapPool = self.map3
  else
    mapPool = self.map3
    Log.fatal("err: UIN32MultiLineMapController self._multilineFolerIndex max is 3, cur is " .. self._multilineFolerIndex)
  end
  local cfg = Cfg.cfg_component_multiline_mission_main[self._multilineFolerIndex]
  self.mapBg:LoadImage(cfg.MapBg)
  self._contentMap = mapPool:SpawnObject("UIN32MultiLineMapContent")
  self._contentMap:SetData(self._multilineFolerIndex, self._cfg, self.multiLineData, self._isMatch, self._isWin)
  self:RefreshCountdown()
  self:RefreshDocRed()
  local enterAni, aniLen, wayEnterLen
  if self._shotScreenTexture then
    self.screeShotImage.texture = self._shotScreenTexture
    enterAni = "uieff_UIN32MultiLineMapController_clickin"
    aniLen = 1533
    wayEnterLen = 800
  else
    enterAni = "uieff_UIN32MultiLineMapController_in"
    aniLen = 700
    wayEnterLen = 100
  end
  local componentCfgId = self._multilineComponent:GetComponentCfgId()
  UIActivityHelper.SpawnPetEnhanceArea(self, "PetEnhanceAreaGen", componentCfgId, UIActivityPetEnhanceAreaUIStyle.N32_MULTI_LINE)
  self:StartTask(function(TT)
    local lockName = "UIN32MultiLineMapController_enterAni"
    self:Lock(lockName)
    self.animation:Play(enterAni)
    YIELD(TT, wayEnterLen)
    self._contentMap:PlayEnterAni()
    YIELD(TT, aniLen - wayEnterLen)
    self._contentMap:CheckAndPlayUnlockAni(TT)
    self:UnLock(lockName)
    self:_CheckGuide()
  end)
end

function UIN32MultiLineMapController:RefreshCountdown()
  local closeTime = self._multilineComInfo.m_close_time
  self._isValid = true
  local timerName = "CountDown"
  
  local function countDown()
    local now = self:GetModule(SvrTimeModule):GetServerTime() / 1000
    local time = math.ceil(closeTime - now)
    local timeStr = self:GetFormatTimerStr(time)
    if self._timeString ~= timeStr then
      self.countDownTxt:SetText(timeStr)
      self._timeString = timeStr
    end
    if time < 0 then
      self._isValid = false
      self._timerHolder:StopTimer(timerName)
    end
  end
  
  countDown()
  self._timerHolder:StartTimerInfinite(timerName, 1000, countDown)
end

function UIN32MultiLineMapController:GetFormatTimerStr(time, id)
  local timeStr = StringTable.Get("str_activity_error_107")
  if time < 0 then
    return timeStr
  end
  local dayStr, hourStr, minusStr, lessOneMinusStr = self:GetCustomTimeStr()
  timeStr = UIActivityCustomHelper.GetTimeString(time, dayStr, hourStr, minusStr, lessOneMinusStr)
  return StringTable.Get(self:GetCustomTimeTipsStr(), timeStr)
end

function UIN32MultiLineMapController:GetCustomTimeStr()
  return "str_n32_multiline_day", "str_n32_multiline_hour", "str_n32_multiline_minus", "str_n32_multiline_less_one_minus"
end

function UIN32MultiLineMapController:GetCustomTimeTipsStr()
  return "str_n32_multiline_activity_remain_time"
end

function UIN32MultiLineMapController:RefreshDocRed()
  self.docRedPoint:SetActive(self.multiLineData:CheckDocRedPoint())
end

function UIN32MultiLineMapController:CheckComponentTime()
  if self.multiLineData:IsComponentTimeEnd() then
    self.mCampaignModule:CampaignSwitchState(true, UIStateType.UIActivityN32MainController, UIStateType.UIMain, nil, self.multiLineData:GetCampaignId())
    ToastManager.ShowToast(StringTable.Get("str_activity_error_107"))
    return false
  end
  return true
end

function UIN32MultiLineMapController:GetRenderTexture(callback)
  self._shot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  local rt = self._shot:RefreshBlurTexture()
  local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
  cache_rt.format = UnityEngine.RenderTextureFormat.RGB111110Float
  self:StartTask(function(TT)
    YIELD(TT)
    UnityEngine.Graphics.Blit(rt, cache_rt)
    if callback then
      callback(cache_rt)
    end
  end)
end

function UIN32MultiLineMapController:GetName()
  return "UIN32MultiLineMapController"
end

function UIN32MultiLineMapController:GetFirstDialogBtn()
  return self._contentMap:GetFirstDialogBtn()
end

function UIN32MultiLineMapController:_CheckGuide()
  local petFiles = self.multiLineData:GetPetFiles()
  if petFiles and 0 < #petFiles then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN32MultiLineMapController_Doc)
  end
end
