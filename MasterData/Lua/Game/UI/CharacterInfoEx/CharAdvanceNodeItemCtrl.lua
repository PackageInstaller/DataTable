local CharAdvanceNodeItemCtrl = class("CharAdvanceNodeItemCtrl", BaseCtrl)
CharAdvanceNodeItemCtrl._mapNodeConfig = {
  advanceNodeAnim = {sNodeName = "adNode", sComponentName = "Animator"},
  btnNode = {
    sComponentName = "UIButton",
    callback = "OnBtn_SelectNode"
  },
  advanceNode_gray = {},
  txtAD = {nCount = 2, sComponentName = "TMP_Text"},
  txtAdNode = {
    sComponentName = "TMP_Text",
    sLanguageId = "Advance_Name"
  },
  txtAdNodeGray = {
    sComponentName = "TMP_Text",
    sLanguageId = "Advance_Name"
  },
  Select = {},
  redDotNode = {}
}
CharAdvanceNodeItemCtrl._mapEventConfig = {
  SelectAdvanceNode = "OnSelectAdvanceNode"
}

function CharAdvanceNodeItemCtrl:RegisterRedDot()
  RedDotManager.RegisterNode(RedDotDefine.Role_AdvanceReward, {
    self.nCharId,
    self.nAdvance
  }, self._mapNode.redDotNode)
end

function CharAdvanceNodeItemCtrl:UnRegisterRedDot()
end

function CharAdvanceNodeItemCtrl:RefreshNode(nCharId, nAdvance, nCurAdvance, bZero, bSelect)
  self.bSelect = false
  self.nCharId = nCharId
  self.nAdvance = nAdvance
  self.nCurAdvance = nCurAdvance
  self._mapNode.Select.gameObject:SetActive(false)
  self._mapNode.advanceNode_gray.gameObject:SetActive(nCurAdvance < nAdvance or bZero)
  for _, v in ipairs(self._mapNode.txtAD) do
    NovaAPI.SetTMPText(v, nAdvance)
  end
  if bSelect ~= nil and bSelect == true then
    self.bSelect = true
    self._mapNode.Select.gameObject:SetActive(true)
    self:PlayAnim("Node_idle")
    self.animState = "Node_idle"
  end
  self:RegisterRedDot()
end

function CharAdvanceNodeItemCtrl:PlayAnim(sAnimName)
  self._mapNode.advanceNodeAnim:Play(sAnimName)
end

function CharAdvanceNodeItemCtrl:SetSelect(bSelect)
  if self.bSelect and not bSelect then
    self:PlayAnim("Node_out")
    self.animState = "Node_out"
  end
  self.bSelect = bSelect
  self._mapNode.Select.gameObject:SetActive(bSelect)
  if bSelect and self.animState ~= "Node_idle" then
    self:PlayAnim("Node_in")
    self.animState = "Node_idle"
    if self.nAdvance <= self.nCurAdvance then
      CS.WwiseAudioManager.Instance:PlaySound("ui_charinfo_levelup_select_button")
    end
  end
end

function CharAdvanceNodeItemCtrl:OnSelectAdvanceNode(nSelectAdvance)
  self:SetSelect(nSelectAdvance == self.nAdvance)
end

function CharAdvanceNodeItemCtrl:OnBtn_SelectNode()
  if self.bSelect then
    return
  end
  EventManager.Hit("SelectAdvanceNode", self.nAdvance)
end

function CharAdvanceNodeItemCtrl:OnDisable()
end

return CharAdvanceNodeItemCtrl
