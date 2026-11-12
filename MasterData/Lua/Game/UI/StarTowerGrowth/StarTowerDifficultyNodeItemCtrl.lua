local StarTowerDifficultyNodeItemCtrl = class("StarTowerDifficultyNodeItemCtrl", BaseCtrl)
StarTowerDifficultyNodeItemCtrl._mapNodeConfig = {
  advanceNodeAnim = {sNodeName = "adNode", sComponentName = "Animator"},
  btnNode = {
    sComponentName = "UIButton",
    callback = "OnBtn_SelectNode"
  },
  diffNode_gray = {},
  txtAD = {nCount = 2, sComponentName = "TMP_Text"},
  txtDiffNode = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Difficulty"
  },
  txtDiffNodeGray = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Difficulty"
  },
  Select = {},
  redDotNode = {}
}
StarTowerDifficultyNodeItemCtrl._mapEventConfig = {
  SelectDiffNode = "OnSelectDiffNode"
}

function StarTowerDifficultyNodeItemCtrl:RefreshNode(nNodeIndex, nCurDifficulty, bSelect, nMaxDifficulty)
  self.bSelect = false
  self.nNodeIndex = nNodeIndex
  self.nMaxDifficulty = nMaxDifficulty or 1
  self._mapNode.Select.gameObject:SetActive(false)
  self._mapNode.diffNode_gray.gameObject:SetActive(nMaxDifficulty < nNodeIndex)
  for _, v in ipairs(self._mapNode.txtAD) do
    NovaAPI.SetTMPText(v, nNodeIndex)
  end
  if bSelect ~= nil and bSelect == true then
    self.bSelect = true
    self._mapNode.Select.gameObject:SetActive(true)
    self:PlayAnim("Node_idle")
    self.animState = "Node_idle"
  end
end

function StarTowerDifficultyNodeItemCtrl:PlayAnim(sAnimName)
  self._mapNode.advanceNodeAnim:Play(sAnimName)
end

function StarTowerDifficultyNodeItemCtrl:SetSelect(bSelect)
  if self.bSelect and not bSelect then
    self:PlayAnim("Node_out")
    self.animState = "Node_out"
  end
  self.bSelect = bSelect
  self._mapNode.Select.gameObject:SetActive(bSelect)
  if bSelect and self.animState ~= "Node_idle" then
    self:PlayAnim("Node_in")
    self.animState = "Node_idle"
    if self.nNodeIndex <= self.nCurSelectDiff then
      CS.WwiseAudioManager.Instance:PlaySound("ui_charinfo_levelup_select_button")
    end
  end
end

function StarTowerDifficultyNodeItemCtrl:OnSelectDiffNode(nDifficulty)
  self.nCurSelectDiff = nDifficulty
  self:SetSelect(nDifficulty == self.nNodeIndex)
end

function StarTowerDifficultyNodeItemCtrl:OnBtn_SelectNode()
  if self.bSelect then
    return
  end
  if self.nMaxDifficulty < self.nNodeIndex then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("RegusBoss_Unlock"))
    return
  end
  EventManager.Hit("SelectDiffNode", self.nNodeIndex)
end

function StarTowerDifficultyNodeItemCtrl:OnDisable()
end

return StarTowerDifficultyNodeItemCtrl
