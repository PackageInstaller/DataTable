require("ui_main_lobby_main_campaign_base")
_class("UIMainLobbyMainCampaignN4", UIMainLobbyMainCampaignBase)
UIMainLobbyMainCampaignN4 = UIMainLobbyMainCampaignN4

function UIMainLobbyMainCampaignN4:GetComponent()
  self._redGo = self:GetGameObject("RedPoint")
  self._newGo = self:GetGameObject("NewFlag")
end

function UIMainLobbyMainCampaignN4:RefreshView()
  self:RedAndNew()
end

function UIMainLobbyMainCampaignN4:BtnOnClick()
  UIMainLobbyMainCampaignN4.super.BtnOnClick(self)
  GameGlobal.UIStateManager():SwitchState(UIStateType.UISummer2)
end

function UIMainLobbyMainCampaignN4:RedAndNew()
  local new = self.sampleInfo:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
  local red = self.sampleInfo:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_REWARD)
  local open_id = GameGlobal.GameLogic():GetOpenId()
  local save_key = open_id .. "UISummerActivityTwoMainController_LineRed"
  new = new or not LocalDB.HasKey(save_key)
  self._newGo:SetActive(new)
  self._redGo:SetActive(red and not new)
end
