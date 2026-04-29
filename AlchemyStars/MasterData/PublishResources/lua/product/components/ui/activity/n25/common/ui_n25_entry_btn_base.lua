_class("UIN25EntryBtnBase", UICustomWidget)
UIN25EntryBtnBase = UIN25EntryBtnBase

function UIN25EntryBtnBase:OnShow(uiParams)
  self:InitWidget()
end

function UIN25EntryBtnBase:InitWidget()
  self.lockNode = self:GetGameObject("lockNode")
  self.txtLeftTime = self:GetUIComponent("RollingText", "txtLeftTime")
  self.red = self:GetGameObject("red")
  self.new = self:GetGameObject("new")
  self.leftTime = self:GetGameObject("leftTime")
end

function UIN25EntryBtnBase:SetData(clickCall)
  self.clickCallback = clickCall
end

function UIN25EntryBtnBase:GetLeftTimeWiget()
  return self.txtLeftTime
end

function UIN25EntryBtnBase:SetLeftTime(strTime)
  self.txtLeftTime:RefreshText(strTime)
end

function UIN25EntryBtnBase:SetLeftTimeShow(show)
  self.leftTime:SetActive(show)
end

function UIN25EntryBtnBase:SetLock(lock)
  self.lockNode:SetActive(lock)
end

function UIN25EntryBtnBase:SetNewAndRed(new, red)
  self.new:SetActive(new)
  self.red:SetActive(not new and red)
end

function UIN25EntryBtnBase:ItemBtnOnClick(go)
  if self.clickCallback then
    self.clickCallback()
  end
end
