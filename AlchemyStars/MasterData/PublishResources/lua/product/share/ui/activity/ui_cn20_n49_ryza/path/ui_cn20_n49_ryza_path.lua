_class("UICN20N49Ryza_Path", UIController)
UICN20N49Ryza_Path = UICN20N49Ryza_Path

function UICN20N49Ryza_Path:LoadDataOnEnter(TT, res, uiParams)
  local campaignType = ECampaignType.CAMPAIGN_TYPE_INLAND_N20
  local componentIds = {
    ECampaignCN20ComponentID.ECN20_ACTION_POINT
  }
  self._campaign = UIActivityHelper.LoadDataOnEnter(TT, res, campaignType, componentIds)
  self._com = self._campaign:GetComponent(ECampaignCN20ComponentID.ECN20_ACTION_POINT)
end

function UICN20N49Ryza_Path:OnShow()
  self._countTex = self:GetUIComponent("UILocalizationText", "countTex")
  self._notBtn = self:GetGameObject("NotBtn")
  self._goBtn = self:GetGameObject("GoBtn")
  local id = self._com:GetItemId()
  local count = GameGlobal.GetModule(ItemModule):GetItemCount(id)
  self._countTex:SetText(count)
  self._notBtn:SetActive(0 < not count)
  self._goBtn:SetActive(0 < count)
end

function UICN20N49Ryza_Path:BgOnClick(go)
  self:CloseDialog()
end

function UICN20N49Ryza_Path:MissionBtnOnClick(go)
  DiscoveryData.EnterStateUIDiscovery(1)
end

function UICN20N49Ryza_Path:NotBtnOnClick(go)
  local tips = StringTable.Get("not ticket")
  ToastManager.ShowToast(tips)
end

function UICN20N49Ryza_Path:GoBtnOnClick(go)
  self:SwitchState(UIStateType.UICN20N49LineTalentController)
end
