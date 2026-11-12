local NotePreviewNodeCtrl = class("NotePreviewNodeCtrl", BaseCtrl)
NotePreviewNodeCtrl._mapNodeConfig = {
  advanceNodeAnim = {sNodeName = "adNode", sComponentName = "Animator"},
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
NotePreviewNodeCtrl._mapEventConfig = {}

function NotePreviewNodeCtrl:RefreshNode(nAdvance, nCurAdvance, bSelect)
  self.bSelect = false
  self.nAdvance = nAdvance
  self.nCurAdvance = nCurAdvance
  self._mapNode.Select.gameObject:SetActive(false)
  self._mapNode.advanceNode_gray.gameObject:SetActive(nCurAdvance < nAdvance)
  for _, v in ipairs(self._mapNode.txtAD) do
    NovaAPI.SetTMPText(v, nAdvance)
  end
  if bSelect ~= nil and bSelect == true then
    self.bSelect = true
    self._mapNode.Select.gameObject:SetActive(true)
    self:PlayAnim("Node_idle")
    self.animState = "Node_idle"
  end
end

function NotePreviewNodeCtrl:PlayAnim(sAnimName)
  self._mapNode.advanceNodeAnim:Play(sAnimName)
end

function NotePreviewNodeCtrl:SetSelect(bSelect)
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

function NotePreviewNodeCtrl:OnDisable()
end

return NotePreviewNodeCtrl
