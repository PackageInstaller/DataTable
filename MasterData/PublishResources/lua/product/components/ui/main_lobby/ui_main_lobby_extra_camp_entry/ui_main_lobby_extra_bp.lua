require("ui_main_lobby_extra_base")
_class("UIMainLobbyExtraBP", UIMainLobbyExtraBase)
UIMainLobbyExtraBP = UIMainLobbyExtraBP

function UIMainLobbyExtraBP:OnShow()
  self._campModule = GameGlobal.GetModule(CampaignModule)
  self:AttachEvent(GameEventType.BattlePassRedPoint, self.SetRed)
end

function UIMainLobbyExtraBP:OnHide()
  self:DetachEvent(GameEventType.BattlePassRedPoint, self.SetRed)
end

function UIMainLobbyExtraBP:RefreshView()
  self:SetRed()
end

function UIMainLobbyExtraBP:BtnOnClick(go)
  if self:CheckCampaignOpen() then
    GameGlobal.GetModule(RoleModule):OnHomePageEnter(CLICKENTRANCE.CE_BATTLE_PASS)
    UIActivityBattlePassHelper.OpenMainController()
  end
end

function UIMainLobbyExtraBP:SetRed()
  local redGo = self:GetGameObject("redGo")
  local red = false
  local campType = self._sample_info.camp_type
  local campID = self._sample_info.id
  local localPro = self._campModule:GetCampaignLocalProcessByCampaignId_Local(campType, campID)
  if not localPro then
    Log.error("###[UIMainLobbyExtraBP] localPro is nil !")
    return
  end
  local component = localPro:GetComponent(ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD)
  if not component then
    Log.error("###[UIMainLobbyExtraBP] component is nil !")
    return
  end
  local isMax = component:CheckIsLevelMax()
  if isMax then
  else
    local checkComs = {
      ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD,
      ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_1,
      ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_2,
      ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_3
    }
    red = self._campModule:CheckComponentRed(localPro, table.unpack(checkComs))
  end
  redGo:SetActive(red)
end
