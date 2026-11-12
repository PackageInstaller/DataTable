local NormalNodeListCtrl = class("NormalNodeListCtrl", BaseCtrl)
local _, ReadyColor = ColorUtility.TryParseHtmlString("#f1f4f6")
local _, LockColor = ColorUtility.TryParseHtmlString("#657eae")
NormalNodeListCtrl._mapNodeConfig = {
  goLine = {nCount = 6},
  line1_ = {nCount = 3, sComponentName = "Image"},
  line2_ = {nCount = 2, sComponentName = "Image"},
  line3_ = {nCount = 2, sComponentName = "Image"},
  line4_ = {nCount = 2, sComponentName = "Image"},
  line5_1 = {sComponentName = "Image"},
  line6_1 = {sComponentName = "Image"},
  NormalNode = {
    nCount = 3,
    sCtrlName = "Game.UI.StarTowerGrowth.NormalNodeCtrl"
  },
  btnNode = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Node"
  }
}
NormalNodeListCtrl._mapEventConfig = {}

function NormalNodeListCtrl:Refresh(nCloumn, tbNodes, tbId, mapNext)
  self.nCloumn = nCloumn
  self.tbId = tbId
  self.tbNodes = tbNodes
  local nNodeCount = #tbId
  for i = 1, 3 do
    self._mapNode.NormalNode[i].gameObject:SetActive(i <= nNodeCount)
  end
  for i, nId in ipairs(tbId) do
    local mapNode = tbNodes[nId]
    local nState = 1
    if mapNode.bActive then
      nState = 3
    elseif not mapNode.bReady then
      nState = 1
    elseif mapNode.bReady then
      nState = 2
    end
    self._mapNode.NormalNode[i]:Refresh(nId, nState)
  end
  local nLineType = 0
  if mapNext then
    if mapNext.nType == GameEnum.towerGrowthNodeType.Core then
      if #mapNext.tbId == 1 then
        nLineType = nNodeCount == 3 and 3 or 5
      elseif #mapNext.tbId == 2 then
        nLineType = nNodeCount == 3 and 2 or 6
      end
    elseif mapNext.nType == GameEnum.towerGrowthNodeType.Normal then
      nLineType = nNodeCount == 3 and 1 or 4
    end
  end
  for i = 1, 6 do
    self._mapNode.goLine[i]:SetActive(nLineType == i)
  end
  if nLineType == 1 then
    for i, nId in ipairs(tbId) do
      NovaAPI.SetImageColor(self._mapNode.line1_[i], tbNodes[nId].bActive and ReadyColor or LockColor)
    end
  elseif nLineType == 2 then
    local b12Active = tbNodes[tbId[1]].bActive and tbNodes[tbId[2]].bActive
    local b23Active = tbNodes[tbId[3]].bActive and tbNodes[tbId[2]].bActive
    NovaAPI.SetImageColor(self._mapNode.line2_[1], b12Active and ReadyColor or LockColor)
    NovaAPI.SetImageColor(self._mapNode.line2_[2], b23Active and ReadyColor or LockColor)
  elseif nLineType == 3 or nLineType == 5 or nLineType == 6 then
    local bActive = true
    for _, nId in ipairs(tbId) do
      if not tbNodes[nId].bActive then
        bActive = false
        break
      end
    end
    local color = bActive and ReadyColor or LockColor
    if nLineType == 3 then
      NovaAPI.SetImageColor(self._mapNode.line3_[1], color)
      NovaAPI.SetImageColor(self._mapNode.line3_[2], color)
    elseif nLineType == 5 then
      NovaAPI.SetImageColor(self._mapNode.line5_1, color)
    elseif nLineType == 6 then
      NovaAPI.SetImageColor(self._mapNode.line6_1, color)
    end
  elseif nLineType == 4 then
    for i, nId in ipairs(tbId) do
      NovaAPI.SetImageColor(self._mapNode.line4_[i], tbNodes[nId].bActive and ReadyColor or LockColor)
    end
  end
end

function NormalNodeListCtrl:GetType()
  return GameEnum.towerGrowthNodeType.Normal
end

function NormalNodeListCtrl:GetReadyNode()
  local goNode
  for i, nId in ipairs(self.tbId) do
    local mapNode = self.tbNodes[nId]
    if mapNode.bReady and not mapNode.bActive then
      goNode = self._mapNode.btnNode[i].gameObject
    end
  end
  return goNode, GameEnum.towerGrowthNodeType.Normal
end

function NormalNodeListCtrl:SetSelect(nId, bSelect)
  for i, v in ipairs(self.tbId) do
    if v == nId then
      self._mapNode.NormalNode[i]:SetSelect(bSelect)
      return
    end
  end
end

function NormalNodeListCtrl:PlayActiveAnim(nId, callback)
  for i, v in ipairs(self.tbId) do
    if v == nId then
      self._mapNode.NormalNode[i]:PlayActiveAnim(callback)
      return
    end
  end
end

function NormalNodeListCtrl:PlayActiveAnimFromActive(tbActiveId)
  for i, v in ipairs(self.tbId) do
    if table.indexof(tbActiveId, v) > 0 then
      self._mapNode.NormalNode[i]:PlayActiveAnim()
    end
  end
end

function NormalNodeListCtrl:ClearSelect()
  for i = 1, 3 do
    self._mapNode.NormalNode[i]:SetSelect(false)
  end
end

function NormalNodeListCtrl:Guide_SelectNode(nIndex)
  local btn = self._mapNode.btnNode[nIndex]
  if self.tbId[nIndex] ~= nil and btn ~= nil then
    EventManager.Hit("StarTowerGrowthNodeSelect", self.tbId[nIndex], self.nCloumn, btn.gameObject)
  end
end

function NormalNodeListCtrl:Awake()
end

function NormalNodeListCtrl:OnEnable()
end

function NormalNodeListCtrl:OnDisable()
end

function NormalNodeListCtrl:OnDestroy()
end

function NormalNodeListCtrl:OnBtnClick_Node(btn, nIndex)
  EventManager.Hit("StarTowerGrowthNodeSelect", self.tbId[nIndex], self.nCloumn, btn.gameObject)
end

return NormalNodeListCtrl
