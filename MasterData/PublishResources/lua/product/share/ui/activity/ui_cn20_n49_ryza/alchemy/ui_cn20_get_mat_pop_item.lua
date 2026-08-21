_class("UICN20GetMatPopItem", UICustomWidget)
UICN20GetMatPopItem = UICN20GetMatPopItem

function UICN20GetMatPopItem:OnShow(uiParams)
  self:InitWidget()
end

function UICN20GetMatPopItem:InitWidget()
  self.root = self:GetGameObject("root")
  self.rushText = self:GetUIComponent("UILocalizationText", "RushText")
  self.lockBtnObj = self:GetGameObject("lockBtn")
end

function UICN20GetMatPopItem:SetData(campaign)
  self._campaign = campaign
  if self._campaign then
    local name = "actionPoint"
    self.actionCmpt = UICN20N49Helper.GetComponent(self._campaign, name)
    if self.actionCmpt then
      local rushCount = self.actionCmpt:GetItemCount()
      if 0 < rushCount then
        self.lockBtnObj:SetActive(false)
      else
        self.lockBtnObj:SetActive(true)
      end
      self.rushText:SetText(StringTable.Get("str_cn20_ryza_get_mat_pop3", rushCount))
    end
  else
    self.lockBtnObj:SetActive(true)
    self.rushText:SetText(StringTable.Get("str_cn20_ryza_get_mat_pop3", 0))
  end
  self:SetPopActive(true)
end

function UICN20GetMatPopItem:SetPopActive(active)
  self.root:SetActive(active)
end

function UICN20GetMatPopItem:GOTO1BtnOnClick(go)
  self:SwitchState(UIStateType.UIDiscovery)
end

function UICN20GetMatPopItem:GOTO2BtnOnClick(go)
  if self.lockBtnObj.activeSelf then
    local tips = StringTable.Get("str_cn20_n49_ryza_tips")
    ToastManager.ShowToast(tips)
    return
  end
  self:SwitchState(UIStateType.UICN20N49LineTalentController)
end

function UICN20GetMatPopItem:CloseBtnOnClick(go)
  self:SetPopActive(false)
end

function UICN20GetMatPopItem:ClickbgBtnOnClick(go)
end
