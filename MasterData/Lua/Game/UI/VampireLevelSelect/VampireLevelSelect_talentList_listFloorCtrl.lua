local VampireLevelSelect_talentList_listFloorCtrl = class("VampireLevelSelect_talentList_listFloorCtrl", BaseCtrl)
VampireLevelSelect_talentList_listFloorCtrl._mapNodeConfig = {
  talentNode = {
    sCtrlName = "Game.UI.VampireLevelSelect.VampireLevelSelect_talent_iconGridCtrl",
    nCount = 3
  },
  activeLine1_ = {nCount = 3},
  talentNodeBtn = {
    nCount = 3,
    sNodeName = "talentNode",
    sComponentName = "UIButton",
    callback = "OnBtnClick_Node"
  },
  active = {},
  inactive = {}
}
VampireLevelSelect_talentList_listFloorCtrl._mapEventConfig = {
  VampireTalent_ClickNode = "OnEvent_ClickNode"
}
VampireLevelSelect_talentList_listFloorCtrl._mapRedDotConfig = {}

function VampireLevelSelect_talentList_listFloorCtrl:OnEnable()
  self.gameObject:SetActive(true)
end

function VampireLevelSelect_talentList_listFloorCtrl:Refresh(tbNodeId, tbPrevId, nSelctId, nAnimId)
  local bPrevActive = self:CheckPrevActive(tbPrevId)
  self._mapNode.active:SetActive(bPrevActive)
  self._mapNode.inactive:SetActive(true)
  self.tbNodeId = tbNodeId
  local nMinUnlock = 0
  for i = 1, 3 do
    if tbNodeId[i] ~= nil then
      local nState = PlayerData.VampireSurvivor:IsActiveTalent(tbNodeId[i])
      if nState == 2 and (nMinUnlock == 0 or nMinUnlock > tbNodeId[i]) then
        nMinUnlock = tbNodeId[i]
      end
      self._mapNode.talentNode[i].gameObject:SetActive(true)
      self._mapNode.talentNode[i]:SetTalent(tbNodeId[i])
      self._mapNode.talentNode[i]:SetState(nState)
      self._mapNode.talentNode[i]:SetSelect(tbNodeId[i] == nSelctId)
      if tbNodeId[i] == nAnimId then
        self._mapNode.talentNode[i]:PlayActiveAnim()
      end
    else
      self._mapNode.talentNode[i].gameObject:SetActive(false)
    end
  end
  return nMinUnlock
end

function VampireLevelSelect_talentList_listFloorCtrl:CheckPrevActive(tbPrevId)
  local ret = false
  for i, nNodeId in ipairs(tbPrevId) do
    local nState = PlayerData.VampireSurvivor:IsActiveTalent(nNodeId)
    if nState == 1 then
      self._mapNode.activeLine1_[i].gameObject:SetActive(true)
      ret = true
    else
      self._mapNode.activeLine1_[i].gameObject:SetActive(false)
    end
  end
  return ret
end

function VampireLevelSelect_talentList_listFloorCtrl:OnBtnClick_Node(btn, nIdx)
  local nNodeId = self.tbNodeId[nIdx]
  if nNodeId ~= nil then
    EventManager.Hit("VampireTalent_ClickNode", nNodeId)
  end
end

function VampireLevelSelect_talentList_listFloorCtrl:OnEvent_ClickNode(nId)
  for i = 1, 3 do
    if self.tbNodeId[i] ~= nil then
      self._mapNode.talentNode[i]:SetSelect(self.tbNodeId[i] == nId)
    end
  end
end

return VampireLevelSelect_talentList_listFloorCtrl
