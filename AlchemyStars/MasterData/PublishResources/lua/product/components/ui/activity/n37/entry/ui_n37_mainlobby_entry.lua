require("ui_main_lobby_main_campaign_base")
_class("UIN37MainLobbyEntry", UIMainLobbyMainCampaignBase)
UIN37MainLobbyEntry = UIN37MainLobbyEntry

function UIN37MainLobbyEntry:SetData(sampleInfo, controller)
  self.sampleInfo = sampleInfo
  self._campaignType = UIN37Helper.GetCampaignType()
  self:_RequestCampaign()
end

function UIN37MainLobbyEntry:_RequestCampaign()
  self:StartTask(function(TT)
    local lockName = "UIN37MainLobbyEntry:_RequestCampaign"
    self:Lock(lockName)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self._campaign = UIActivityHelper.LoadCampaign(TT, res, self._campaignType)
    self:_Refresh()
    self:UnLock(lockName)
  end, self)
end

function UIN37MainLobbyEntry:_Refresh()
  self:_CheckPoint()
  self:_SetTips()
end

function UIN37MainLobbyEntry:_CheckPoint()
  if self._campaign then
    local new = UIActivityHelper.CheckCampaignSampleNewPoint(self._campaign)
    local red = UIActivityHelper.CheckCampaignSampleRedPoint(self._campaign)
    UIWidgetHelper.SetNewAndReds(self, new, red, "new", "red")
  end
end

function UIN37MainLobbyEntry:_SetTips()
  local cmptId, component, componentInfo = UIN37Helper.GetComponent(self._campaign, "hard")
  local isShow = component:ComponentIsOpen()
  self:GetGameObject("tipsBg"):SetActive(isShow)
end

function UIN37MainLobbyEntry:BtnOnClick()
  UIN37MainLobbyEntry.super.BtnOnClick(self)
  GameGlobal.UIStateManager():ShowDialog("UIN37MainController")
end
