_class("UIS4ChangeBtn", UICustomWidget)
UIS4ChangeBtn = UIS4ChangeBtn

function UIS4ChangeBtn:OnShow(uiParams)
  self:InitWidget()
end

function UIS4ChangeBtn:InitWidget()
  self.lockObj = self:GetGameObject("Lock")
  self.choseObj = self:GetGameObject("Chose")
  self.txt = self:GetUIComponent("UILocalizationText", "txt")
  self.harborName = self:GetUIComponent("UILocalizationText", "HarborName")
  self.number = self:GetUIComponent("UILocalizationText", "Number")
end

function UIS4ChangeBtn:SetData(id, harborId, unlock, btnClickCB)
  self.id = id
  self.harborId = harborId
  self.unlock = unlock
  self.CallBack = btnClickCB
  self:InitData()
  self.lockObj:SetActive(not unlock)
  self.lockTips = "str_season_s4_trade_harbor_lock_tip_" .. id
  local titleKey = "str_season_s4_trade_harbor_" .. id
  local titleStr = StringTable.Get(titleKey)
  self.txt:SetText(titleStr)
  if id == 1 then
    self.harborName:SetText("A")
    self.number:SetText("01")
  elseif id == 2 then
    self.harborName:SetText("B")
    self.number:SetText("02")
  elseif id == 3 then
    self.harborName:SetText("C")
    self.number:SetText("03")
  end
end

function UIS4ChangeBtn:InitData()
end

function UIS4ChangeBtn:OnChose(State)
  self.choseObj:SetActive(State)
end

function UIS4ChangeBtn:BtnOnClick(go)
  if not self.unlock then
    ToastManager.ShowToast(StringTable.Get(self.lockTips))
    return
  end
  if self.CallBack then
    self.CallBack(self.harborId)
  end
end
