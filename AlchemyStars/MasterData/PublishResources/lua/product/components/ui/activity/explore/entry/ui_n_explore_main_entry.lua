require("ui_main_lobby_main_campaign_base")
_class("UINExploreMainEntry", UIMainLobbyMainCampaignBase)
UINExploreMainEntry = UINExploreMainEntry

function UINExploreMainEntry:SetData(sampleInfo, controller)
  self.sampleInfo = sampleInfo
  self._controller = controller
  self._campaignType = UINExploreHelper.GetCampaignType()
  self:_RequestCampaign()
end

function UINExploreMainEntry:_RequestCampaign()
  self:StartTask(function(TT)
    local lockName = "UINExploreMainEntry:_RequestCampaign"
    self:Lock(lockName)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self._campaign = UIActivityHelper.LoadCampaign(TT, res, self._campaignType)
    self:_Refresh()
    self:UnLock(lockName)
  end, self)
end

function UINExploreMainEntry:_Refresh()
  self:_CheckPoint()
end

function UINExploreMainEntry:_CheckPoint()
  if self._campaign then
    local new = UINExploreHelper.CalcNew(self._campaign)
    local red = UINExploreHelper.CalcRed(self._campaign)
    UIWidgetHelper.SetNewAndReds(self, new, red, "new", "red")
  end
end

function UINExploreMainEntry:BtnOnClick()
  UINExploreMainEntry.super.BtnOnClick(self)
  local main = self._controller
  UIActivityHelper.Snap(main._screenShot, main:GetUIComponent("RectTransform", "SafeArea").rect.size, GameGlobal.UIStateManager():GetControllerCamera(main:GetName()), function(cache_rt)
    self:ShowDialog("UINExploreMainController", cache_rt)
  end)
end
