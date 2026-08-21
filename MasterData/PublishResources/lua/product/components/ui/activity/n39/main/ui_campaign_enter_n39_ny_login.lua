_class("UICampaignEnterN39NYLogin", UIActivityCommonCampaignEnter)
UICampaignEnterN39NYLogin = UICampaignEnterN39NYLogin

function UICampaignEnterN39NYLogin:_CheckPoint()
  local newObj = self:GetGameObject("new")
  local redObj = self:GetGameObject("red")
  local new = UIN39Helper.CheckNew("ny_login")
  local red = UIActivityHelper.CheckCampaignSampleRedPoint(self._campaign)
  UIActivityHelper.SetWidgetNewAndRed(newObj, new, redObj, red)
end
