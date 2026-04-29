require("ui_main_lobby_main_campaign_base")
_class("UIN43MainEntry", UIMainLobbyMainCampaignBase)
UIN43MainEntry = UIN43MainEntry

function UIN43MainEntry:SetData(sampleInfo, controller)
  self.sampleInfo = sampleInfo
  self._controller = controller
  self._campaignType = UIN43Helper.GetCampaignType()
  self:_RequestCampaign()
end

function UIN43MainEntry:_RequestCampaign()
  self:StartTask(function(TT)
    local lockName = "UIN43MainEntry:_RequestCampaign"
    self:Lock(lockName)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self._campaign = UIActivityHelper.LoadCampaign(TT, res, self._campaignType)
    self:_Refresh()
    self:UnLock(lockName)
  end, self)
end

function UIN43MainEntry:_Refresh()
  self:_CheckPoint()
end

function UIN43MainEntry:_CheckPoint()
  if self._campaign then
    local new = UIN43Helper.CalcNew(self._campaign)
    local red = UIN43Helper.CalcRed(self._campaign)
    UIWidgetHelper.SetNewAndReds(self, new, red, "new", "red")
  end
end

function UIN43MainEntry:BtnOnClick()
  UIN43MainEntry.super.BtnOnClick(self)
  local main = self._controller
  UIActivityHelper.Snap(main._screenShot, main:GetUIComponent("RectTransform", "SafeArea").rect.size, GameGlobal.UIStateManager():GetControllerCamera(main:GetName()), function(cache_rt)
    self:ShowDialog("UIN43MainController", cache_rt)
  end)
end
