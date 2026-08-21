require("ui_main_lobby_main_campaign_base")
_class("UICN12N41MainLobbyEntry", UIMainLobbyMainCampaignBase)
UICN12N41MainLobbyEntry = UICN12N41MainLobbyEntry

function UICN12N41MainLobbyEntry:OnHide()
  self._time = UIActivityHelper.CancelTimerEvent(self._time)
end

function UICN12N41MainLobbyEntry:SetData(sampleInfo, controller)
  self.sampleInfo = sampleInfo
  self._uiMainLobbyController = controller
  self._campaignType = UICN12N41Helper.GetCampaignType()
  self:_RequestCampaign()
  self._time = UIActivityHelper.StartTimerEvent(self._time, function()
    self:_CheckState()
  end)
end

function UICN12N41MainLobbyEntry:_RequestCampaign()
  self:StartTask(function(TT)
    local lockName = "UICN12N41MainLobbyEntry:_RequestCampaign"
    self:Lock(lockName)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self._campaign = UIActivityHelper.LoadCampaign(TT, res, self._campaignType)
    self:_Refresh()
    self:_CheckState()
    self:UnLock(lockName)
  end, self)
end

function UICN12N41MainLobbyEntry:_Refresh()
  self:_CheckPoint()
end

function UICN12N41MainLobbyEntry:_SetText(state)
  if state == 1 then
    local hard1Tips = StringTable.Get("str_cn12_n41_main_entry_tips1")
    UIWidgetHelper.SetLocalizationText(self, "Hard1_Tips", hard1Tips)
    UIWidgetHelper.SetRollingText(self, "Hard1_Tips")
  elseif state == 2 then
    local hard2Tips = StringTable.Get("str_cn12_n41_main_entry_tips2")
    UIWidgetHelper.SetLocalizationText(self, "Hard2_Tips", hard2Tips)
    UIWidgetHelper.SetRollingText(self, "Hard2_Tips")
  elseif state == 3 then
    local hard3Tips = StringTable.Get("str_cn12_n41_main_entry_tips3")
    UIWidgetHelper.SetLocalizationText(self, "Subject_Tips", hard3Tips)
    UIWidgetHelper.SetRollingText(self, "Subject_Tips")
  end
end

function UICN12N41MainLobbyEntry:_CheckState()
  if not self.view then
    return
  end
  if not self._campaign then
    return
  end
  local state = UICN12N41Helper.CheckCampaignTimeState(self._campaign)
  if state == self._state then
    return
  end
  self._state = state
  self:_SetState(state)
  self:_SetText(state)
end

function UICN12N41MainLobbyEntry:_SetState(state)
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    [1] = {
      "Hard1_TipsPanel"
    },
    [2] = {
      "Hard2_TipsPanel"
    },
    [3] = {
      "Subject_TipsPanel"
    }
  }, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
end

function UICN12N41MainLobbyEntry:_CheckPoint()
  if not self._campaign then
    return
  end
  local new = UICN12N41Helper.CalcNew(self._campaign)
  local red = UICN12N41Helper.CalcRed(self._campaign)
  UIWidgetHelper.SetNewAndReds(self, new, red, "new", "red")
end

function UICN12N41MainLobbyEntry:BtnOnClick()
  UICN12N41MainLobbyEntry.super.BtnOnClick(self)
  GameGlobal.UIStateManager():ShowDialog("UICN12N41MainController")
end

function UICN12N41MainLobbyEntry:Entry(stateType)
  if self._uiMainLobbyController then
    self._uiMainLobbyController._screenShot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self._uiMainLobbyController:GetName())
    local rt = self._uiMainLobbyController._screenShot:RefreshBlurTexture()
    local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
    self:StartTask(function(TT)
      YIELD(TT)
      UnityEngine.Graphics.Blit(rt, cache_rt)
      self:SwitchState(stateType, cache_rt)
    end)
  else
    self:SwitchState(stateType)
  end
end
