local InfinityAutoCtrl = class("InfinityAutoCtrl", BaseCtrl)
InfinityAutoCtrl._mapNodeConfig = {
  btnAutoLevel = {
    sComponentName = "UIButton",
    callback = "OnClick_AutoLevel"
  },
  texAutoLevel = {
    sComponentName = "TMP_Text",
    sLanguageId = "Auto_Overlayer"
  },
  AutoLevelOpen = {},
  AutoLevelClose = {},
  btnAutoLevelAin = {
    sNodeName = "btnAutoLevel",
    sComponentName = "Animator"
  }
}
InfinityAutoCtrl._mapEventConfig = {
  InputEnable = "OnEvent_InputEnable"
}

function InfinityAutoCtrl:OnEnable()
  self.isAuto = PlayerData.InfinityTower:GetAutoNextLv()
  self._mapNode.AutoLevelOpen:SetActive(self.isAuto)
  self._mapNode.AutoLevelClose:SetActive(not self.isAuto)
end

function InfinityAutoCtrl:OnClick_AutoLevel()
  self.isAuto = not self.isAuto
  self._mapNode.AutoLevelOpen:SetActive(self.isAuto)
  self._mapNode.AutoLevelClose:SetActive(not self.isAuto)
  PlayerData.InfinityTower:SetAutoNextLv(self.isAuto)
end

function InfinityAutoCtrl:SetAutoLevelState(isAuto)
  self.isAuto = isAuto
  self._mapNode.AutoLevelOpen:SetActive(self.isAuto)
  self._mapNode.AutoLevelClose:SetActive(not self.isAuto)
end

function InfinityAutoCtrl:OnEvent_InputEnable(bEnable)
  self.gameObject.transform.localScale = bEnable and Vector3.one or Vector3.zero
end

function InfinityAutoCtrl:PlayAin(isIn)
  if self.isAutoTime then
    self.isAutoTime:Cancel(false)
    self.isAutoTime = nil
  end
  if isIn then
    self._mapNode.btnAutoLevelAin:Play("InfinityAutoPanel_in")
  else
    self._mapNode.btnAutoLevelAin:Play("InfinityAutoPanel_out")
    self.isAutoTime = self:AddTimer(1, 0.4, function()
      self.gameObject:SetActive(false)
      self.isAutoTime = nil
    end, true, true, true)
  end
end

return InfinityAutoCtrl
