require("ui_side_enter_center_content_base")
_class("UIActivityNewYearLuckBagContent", UISideEnterCenterContentBase)
UIActivityNewYearLuckBagContent = UIActivityNewYearLuckBagContent

function UIActivityNewYearLuckBagContent:DoInit(params)
  self._timerName = "UIActivityNewYearLuckBagContent_TimerHolder"
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_INLAND_RANDOM_DRAW
  self._randomLotteryComponentId = ECampaignPetSkinComponentID.RANDOMLOTTERY
  self._actionPointComponentId = ECCampaignSeasonComponentID.ACTION_POINT
  self._storyComponentId = ECampaignRandomDrawComponentID.STORY
  self._campaignId = params and params.campaign_id
  self._curSelectType = nil
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaign = self._data
end

function UIActivityNewYearLuckBagContent:DoShow()
  self:StartTask(function(TT)
    self._campaign:ClearCampaignNew(TT)
  end)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._randomLotteryComponent = self._campaign:GetComponent(self._randomLotteryComponentId)
  self._actionPointComponent = self._campaign:GetComponent(self._actionPointComponentId)
  self._storyComponent = self._campaign:GetComponent(self._storyComponentId)
  self._randomLotteryComponentInfo = self._campaign:GetComponentInfo(self._randomLotteryComponentId)
  self:GetComponents()
  self:InitWidgets()
  self:RefreshDrawResult()
  self._timerHolder = UITimerHolder:New()
  self:RefreshCountdown()
  if self:CheckActivityOver() then
    return
  end
end

function UIActivityNewYearLuckBagContent:_GetRemainTime(time)
  local day, hour, minute
  day = math.floor(time / 86400)
  hour = math.floor(time / 3600) % 24
  minute = math.floor(time / 60) % 60
  local timestring = ""
  if 0 < day then
    timestring = day .. StringTable.Get("str_activity_common_day") .. hour .. StringTable.Get("str_activity_common_hour")
  elseif 0 < hour then
    timestring = hour .. StringTable.Get("str_activity_common_hour") .. minute .. StringTable.Get("str_activity_common_minute")
  elseif 0 < minute then
    timestring = minute .. StringTable.Get("str_activity_common_minute")
  else
    timestring = StringTable.Get("str_activity_common_less_minute")
  end
  return string.format(StringTable.Get("str_activity_common_over"), timestring)
end

function UIActivityNewYearLuckBagContent:DoHide()
  self._timerHolder:StopTimer(self._timerName)
end

function UIActivityNewYearLuckBagContent:DoDestroy()
end

function UIActivityNewYearLuckBagContent:GetComponents()
  self._DRAWTYPE = {
    Fortune = 1,
    Career = 2,
    Marriage = 3
  }
  self._DRAWResult = {
    Bad = 1,
    Ordinary = 2,
    Extremely = 3
  }
  self.MAXDRAWTIME = 3
  self._drawTypeBtnGroup = {
    [self._DRAWTYPE.Fortune] = self:GetGameObject("DrawTypeButton1"),
    [self._DRAWTYPE.Career] = self:GetGameObject("DrawTypeButton2"),
    [self._DRAWTYPE.Marriage] = self:GetGameObject("DrawTypeButton3")
  }
  self._drawTypeIDGroup = {
    [self._DRAWTYPE.Fortune] = 3,
    [self._DRAWTYPE.Career] = 4,
    [self._DRAWTYPE.Marriage] = 5
  }
  self._nextFlushTimeText = self:GetUIComponent("UILocalizationText", "NextDrawTimeText")
  self._remainDrawTimeText = self:GetUIComponent("UILocalizationText", "RemainDrawTimeText")
  self._activityRemainTimeText = self:GetUIComponent("UILocalizationText", "ActivityRemainTimeText")
  self._spineText = self:GetUIComponent("UILocalizationText", "SpineText")
  self._DrawResult = self:GetUIComponent("UISelectObjectPath", "DrawResult")
  self._selectInfoPool = self:GetUIComponent("UISelectObjectPath", "selectInfoPool")
  self._briefTip = self:GetUIComponent("UILocalizationText", "BriefTip")
  self._firstRoot = self:GetGameObject("FirstRoot")
  self._drawedRoot = self:GetGameObject("DrawedRoot")
  self._startRoot = self:GetGameObject("StartRoot")
  self._drawTypeRoot = self:GetGameObject("DrawTypeRoot")
  self._drawedList = self:GetGameObject("DrawedList")
  self._drawedButtonGroup = self:GetGameObject("DrawedButtonGroup")
  self._reDrawButton = self:GetGameObject("ReDrawButton")
  self._btnGroupObj = self:GetGameObject("btnGroup")
  self._chooseTipObj = self:GetGameObject("chooseTip")
  self._sixFullAnim = self:GetUIComponent("Animation", "SixFull")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._drawResultBtnGroup = {
    [1] = self:GetGameObject("resultButton1"),
    [2] = self:GetGameObject("resultButton2"),
    [3] = self:GetGameObject("resultButton3")
  }
end

function UIActivityNewYearLuckBagContent:InitWidgets()
  self._curSelectType = nil
  for t, v in pairs(self._drawTypeBtnGroup) do
    v.transform:Find("select").gameObject:SetActive(false)
  end
  for type, obj in pairs(self._drawTypeBtnGroup) do
    self:AddUICustomEventListener(UICustomUIEventListener.Get(obj), UIEvent.Click, function(go)
      if self._curSelectType == type then
        return
      end
      AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
      self._btnGroupObj:SetActive(true)
      self._curSelectType = type
      self:SetBriefIntro()
      for t, v in pairs(self._drawTypeBtnGroup) do
        v.transform:Find("select").gameObject:SetActive(self._curSelectType == t)
        v.transform:GetComponent("Animation"):Play("uieff_UIActivityNewYearLuckBagContent_SixFull_LuckBagGroup")
        self:StartTask(function(TT)
          self:Lock("uieff_UIActivityNewYearLuckBagContent_SixFull_LuckBagGroup")
          YIELD(TT, 600)
          self:UnLock("uieff_UIActivityNewYearLuckBagContent_SixFull_LuckBagGroup")
        end)
      end
    end)
  end
  self._btnGroupObj:SetActive(false)
  self._curSelectDrawIndex = 1
  self:SetBriefIntro()
  self._hasGetReward = false
  self._todayRefreshFlag = false
end

function UIActivityNewYearLuckBagContent:RefreshCountdown()
  local refreshTime = self._randomLotteryComponentInfo.draw_refresh_time
  local activityRemainTime = self._randomLotteryComponentInfo.m_close_time
  
  local function countDown()
    local nowTime = self._timeModule:GetServerTime() / 1000
    local remainTime = refreshTime - nowTime
    local activituRemain = activityRemainTime - nowTime
    if tolua.isnull(self._nextFlushTimeText) then
      return
    end
    if 0 < activituRemain then
      if remainTime < 0 then
        if not self._todayRefreshFlag then
          self._todayRefreshFlag = true
          self:StartTask(function(TT)
            local luckBagController = GameGlobal.UIStateManager():GetController("UIActivityNewYearLuckBagController")
            if luckBagController then
              luckBagController:SetExpire(true)
            end
            YIELD(TT, 2000)
            local res = AsyncRequestRes:New()
            self._campaign:ReLoadCampaignInfo_Force(TT, res)
            if res:GetSucc() then
              self:OnCN12LuckBagDrawRefresh()
            else
              Log.fatal("新年抽签强制刷新数据错误：", res:GetResult())
            end
          end)
        end
        return
      end
      self._nextFlushTimeText:SetText(StringTable.Get("str_cn12_n41_game_time1", self:_GetRemainTime(remainTime)))
      self._activityRemainTimeText:SetText(StringTable.Get("str_cn12_n41_game_time2", self:_GetRemainTime(activituRemain)))
    else
      self._nextFlushTimeText:SetText(StringTable.Get("str_activity_common_notice_content"))
      self._activityRemainTimeText:SetText(StringTable.Get("str_activity_common_notice_content"))
    end
  end
  
  countDown()
  self._timerHolder:StartTimerInfinite(self._timerName, 1000, countDown)
end

function UIActivityNewYearLuckBagContent:GetDrawType(cfgID)
  for type, v in pairs(self._drawTypeIDGroup) do
    if v == cfgID then
      return type
    end
  end
  return nil
end

function UIActivityNewYearLuckBagContent:OnCN12LuckBagDrawRefresh()
  if tolua.isnull(self._nextFlushTimeText) then
    return
  end
  ToastManager.ShowToast(StringTable.Get("str_cn12_n41_game_tip6"))
  self._anim:Play("uieff_UIActivityNewYearLuckBagContent_in")
  self:InitWidgets()
  self:RefreshDrawResult()
  self:RefreshCountdown()
end

function UIActivityNewYearLuckBagContent:RefreshDrawResult()
  if self._randomLotteryComponentInfo.m_draw and #self._randomLotteryComponentInfo.m_draw > 0 then
    for _, v in pairs(self._randomLotteryComponentInfo.m_draw) do
      if v.is_get then
        self._hasGetReward = true
      end
    end
    self._drawedRoot:SetActive(true)
    self._firstRoot:SetActive(false)
    local stage = 1
    if self._hasGetReward then
      stage = 2
    end
    local dialogCfg = Cfg.cfg_luckbag_dialog({Stage = stage})[1]
    self._spineText:SetText(StringTable.Get(dialogCfg.Dialog))
    self:FlushDrawedPanel()
  else
    local dialogCfg = Cfg.cfg_luckbag_dialog({Stage = 1})[1]
    self._spineText:SetText(StringTable.Get(dialogCfg.Dialog))
    self._drawedRoot:SetActive(false)
    self._firstRoot:SetActive(true)
    self:FlushFirstDrawPanel()
  end
  local leftTime = self.MAXDRAWTIME - table.count(self._randomLotteryComponentInfo.m_draw)
  leftTime = leftTime == 0 and "<color=#FF0000>" .. leftTime .. "</color>" or leftTime
  local tempRemindTime = "<color=#ffd257>" .. leftTime .. "/" .. self.MAXDRAWTIME .. "</color>"
  local tempTxt = StringTable.Get("str_cn12_n41_game_tip2", tempRemindTime)
  self._remainDrawTimeText:SetText(tempTxt)
end

function UIActivityNewYearLuckBagContent:FlushFirstDrawPanel()
  self._startRoot:SetActive(true)
  self._drawTypeRoot:SetActive(false)
end

function UIActivityNewYearLuckBagContent:FlushDrawedPanel()
  local drawListLength = #self._randomLotteryComponentInfo.m_draw
  self._drawedList:SetActive(not self._hasGetReward)
  self._chooseTipObj:SetActive(not self._hasGetReward)
  self._drawedButtonGroup:SetActive(not self._hasGetReward)
  self._reDrawButton:SetActive(drawListLength ~= self.MAXDRAWTIME)
  local lastSelectObj, lastSelectTxt
  self._drawResultPool = self._DrawResult:SpawnObject("UIActivityNewYearLuckBagResultItem")
  for i = 1, #self._drawResultBtnGroup do
    local obj = self._drawResultBtnGroup[i]
    local drawInfo = self._randomLotteryComponentInfo.m_draw[i]
    obj.transform:Find("bgNormal").gameObject:SetActive(drawInfo ~= nil)
    obj.transform:Find("bgNotDraw").gameObject:SetActive(drawInfo == nil)
    local txt = obj.transform:Find("resultTxt"):GetComponent(typeof(UILocalizationText))
    if drawInfo then
      txt:SetText(StringTable.Get("str_cn12_n41_game_luck" .. drawInfo.random_type))
      txt.color = Color(0.47843137254901963, 0.30980392156862746, 0.19215686274509805)
    else
      txt:SetText(StringTable.Get("str_cn12_n41_game_luck_none"))
      txt.color = Color(0.2901960784313726, 0.1607843137254902, 0.09803921568627451)
    end
    obj.transform:Find("bgSelect").gameObject:SetActive(false)
    
    local function callback()
      if drawInfo then
        self._drawResultPool:FlushData(drawInfo, self, self._hasGetReward, function(id, pos)
          self:OnItemSelect(id, pos)
        end)
        self._curSelectDrawIndex = i
      else
        return
      end
      if lastSelectObj then
        lastSelectObj:SetActive(false)
        lastSelectTxt.color = Color(0.47843137254901963, 0.30980392156862746, 0.19215686274509805)
      end
      lastSelectObj = obj.transform:Find("bgSelect").gameObject
      lastSelectTxt = obj.transform:Find("resultTxt"):GetComponent(typeof(UILocalizationText))
      lastSelectObj:SetActive(true)
      lastSelectTxt.color = Color(0.9647058823529412, 0.9333333333333333, 0.7764705882352941)
    end
    
    self:AddUICustomEventListener(UICustomUIEventListener.Get(obj), UIEvent.Click, function(go)
      callback()
    end)
    if self._hasGetReward then
      if drawInfo and drawInfo.is_get then
        callback()
      end
    elseif i == drawListLength then
      callback()
    end
  end
end

function UIActivityNewYearLuckBagContent:OnItemSelect(id, pos)
  if not self._selectInfo then
    self._selectInfo = self._selectInfoPool:SpawnObject("UISelectInfo")
  end
  self._selectInfo:SetData(id, pos)
end

function UIActivityNewYearLuckBagContent:StartButtonOnClick()
  if self:CheckActivityOver() then
    return
  end
  self._startRoot:SetActive(false)
  self._drawTypeRoot:SetActive(true)
  self:StartTask(function(TT)
    self:Lock("uieff_UIActivityNewYearLuckBagContent_SixFull")
    self._sixFullAnim:Play("uieff_UIActivityNewYearLuckBagContent_SixFull")
    YIELD(TT, 667)
    self:UnLock("uieff_UIActivityNewYearLuckBagContent_SixFull")
  end)
end

function UIActivityNewYearLuckBagContent:DrawButtonOnClick()
  if self:CheckActivityOver() then
    return
  end
  if not self._curSelectType and not self._randomLotteryComponentInfo.m_draw then
    return
  end
  self:DrawAction(function()
    self:ShowDialog("UIActivityNewYearLuckBagAnimController", self._randomLotteryComponentInfo, self, self._storyComponent)
  end)
end

function UIActivityNewYearLuckBagContent:CancelDrawButtonOnClick()
  if self:CheckActivityOver() then
    return
  end
  self._curSelectType = nil
  for t, v in pairs(self._drawTypeBtnGroup) do
    v.transform:Find("select").gameObject:SetActive(false)
  end
  self._btnGroupObj:SetActive(false)
  self:SetBriefIntro()
end

function UIActivityNewYearLuckBagContent:ReDrawButtonOnClick()
  if self:CheckActivityOver() then
    return
  end
  self:DrawAction(function()
    self:ShowDialog("UIActivityNewYearLuckBagAnimController", self._randomLotteryComponentInfo, self, self._storyComponent)
  end)
end

function UIActivityNewYearLuckBagContent:ConfirmButtonOnClick()
  self:GetReward(self._curSelectDrawIndex, function()
    self._hasGetReward = true
    if self._drawResultPool then
      self._drawResultPool:SetFinishDrawState(self._hasGetReward)
    end
  end)
end

function UIActivityNewYearLuckBagContent:GetReward(index, callback)
  self:StartTask(function(TT)
    local asyncRes = AsyncRequestRes:New()
    local respone = self._randomLotteryComponent:HandleRandomLotteryComponentDrawReward(TT, asyncRes, index)
    local replyResult = asyncRes:GetResult()
    if asyncRes:GetSucc() then
      local rewards = respone.m_draw.m_rewards
      self:ShowDialog("UIGetItemController", rewards, function()
        if callback then
          callback()
        end
        self:StartTask(function(TT)
          self._anim:Play("uieff_UIActivityNewYearLuckBagContent_out")
          YIELD(TT, 534)
          self:InitWidgets()
          self:RefreshDrawResult()
        end)
      end)
    else
      local campaignModule = GameGlobal.GetModule(CampaignModule)
      campaignModule:CheckErrorCode(asyncRes:GetResult(), self._campaign._id, function()
        local luckBagController = GameGlobal.UIStateManager():GetController("UIActivityNewYearLuckBagController")
        if luckBagController then
          GameGlobal.UIStateManager():CloseDialog("UIActivityNewYearLuckBagController")
        end
      end, function()
        self:CloseDialog()
      end)
    end
  end)
end

function UIActivityNewYearLuckBagContent:SetBriefIntro()
  if not self._curSelectType then
    self._briefTip:SetText(StringTable.Get("str_cn12_n41_game_tip3"))
    return
  end
  local commonTxt = "str_cn12_n41_game_luck_txt"
  local typeTxt = StringTable.Get(commonTxt .. self._curSelectType)
  local tipTxt = StringTable.Get("str_cn12_n41_game_tip4", typeTxt)
  self._briefTip:SetText(tipTxt)
end

function UIActivityNewYearLuckBagContent:DrawAction(callback)
  if self:CheckActivityOver() then
    local luckBagController = GameGlobal.UIStateManager():GetController("UIActivityNewYearLuckBagController")
    if luckBagController then
      GameGlobal.UIStateManager():CloseDialog("UIActivityNewYearLuckBagController")
    end
    return
  end
  local cur, need, cfgID = self:GetActionPointAndNeed(self._curSelectType)
  if not cur or cur < need then
  else
    self:StartTask(function(TT)
      self:Lock("HandleRandomLotteryComponentDraw")
      local asyncRes = AsyncRequestRes:New()
      self._randomLotteryComponent:HandleRandomLotteryComponentDraw(TT, asyncRes, cfgID)
      local replyResult = asyncRes:GetResult()
      if asyncRes:GetSucc() then
        if callback then
          callback()
        end
        YIELD(TT, 1000)
        self:UnLock("HandleRandomLotteryComponentDraw")
        self:InitWidgets()
        self:RefreshDrawResult()
      else
        local campaignModule = GameGlobal.GetModule(CampaignModule)
        campaignModule:CheckErrorCode(asyncRes:GetResult(), self._campaign._id, function()
          local luckBagController = GameGlobal.UIStateManager():GetController("UIActivityNewYearLuckBagController")
          if luckBagController then
            GameGlobal.UIStateManager():CloseDialog("UIActivityNewYearLuckBagController")
          end
        end, function()
          self:CloseDialog()
        end)
      end
    end)
  end
end

function UIActivityNewYearLuckBagContent:GetActionPointAndNeed(type)
  if not type then
    if table.count(self._randomLotteryComponentInfo.m_draw) == 0 then
      return
    end
    type = self._randomLotteryComponentInfo.m_draw[1].draw_cfg_id
  else
    type = self._drawTypeIDGroup[type]
  end
  local lotteryCfg = Cfg.cfg_component_random_lottery[type]
  if lotteryCfg then
    local cur, ceil = self.MAXDRAWTIME
    return cur, lotteryCfg.OneCostCount, lotteryCfg.ID
  end
  return nil
end

function UIActivityNewYearLuckBagContent:IntroBtnOnClick()
  self:ShowDialog("UIIntroLoader", "UIActivityNewYearLuckBagIntr")
end

function UIActivityNewYearLuckBagContent:CheckActivityOver()
  local closeTime = self._randomLotteryComponentInfo.m_close_time
  local nowTime = self._timeModule:GetServerTime() / 1000
  local activituRemain = closeTime - nowTime
  if activituRemain < 0 then
    ToastManager.ShowToast(StringTable.Get("str_activity_common_notice_content"))
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, self._campaignId)
    return true
  end
  return false
end
