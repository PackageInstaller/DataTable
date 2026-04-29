_class("UIN16FaultTolerantItem", UICustomWidget)
UIN16FaultTolerantItem = UIN16FaultTolerantItem

function UIN16FaultTolerantItem:OnShow(uiParams)
  self:InitWidget()
end

function UIN16FaultTolerantItem:OnHide()
end

function UIN16FaultTolerantItem:InitWidget()
  self.used = self:GetGameObject("used")
  self.nouse = self:GetGameObject("nouse")
  self.ani = self:GetUIComponent("Animation", "go")
end

function UIN16FaultTolerantItem:Refresh()
  self.used:SetActive(true)
  self.nouse:SetActive(true)
end

function UIN16FaultTolerantItem:SetUsed(used)
  self:StartTask(function(TT)
    YIELD(TT, 1000)
    if not self.nouse or not self.nouse.gameObject then
      return
    end
    self.nouse:SetActive(not used)
    self.used:SetActive(used)
  end, self)
end

function UIN16FaultTolerantItem:SetData(nIndex)
  self._index = nIndex
end

function UIN16FaultTolerantItem:PlayeAni()
  self.ani:Play("uieff_FaultToLearnItem_Fade")
end
