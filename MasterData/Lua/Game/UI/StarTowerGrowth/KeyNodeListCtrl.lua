local KeyNodeListCtrl = class("KeyNodeListCtrl", BaseCtrl)
local _, ReadyColor = ColorUtility.TryParseHtmlString("#f1f4f6")
local _, LockColor = ColorUtility.TryParseHtmlString("#657eae")
KeyNodeListCtrl._mapNodeConfig = {
  goLine = {nCount = 5},
  line1_ = {nCount = 2, sComponentName = "Image"},
  line2_ = {nCount = 2, sComponentName = "Image"},
  line3_1 = {sComponentName = "Image"},
  line4_1 = {sComponentName = "Image"},
  line5_1 = {sComponentName = "Image"},
  KeyNode = {
    nCount = 2,
    sCtrlName = "Game.UI.StarTowerGrowth.KeyNodeCtrl"
  },
  goOne = {},
  btnNode = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Node"
  }
}
KeyNodeListCtrl._mapEventConfig = {}

function KeyNodeListCtrl:Refresh(nCloumn, tbNodes, tbId, mapNext)
  self.nCloumn = nCloumn
  self.tbId = tbId
  self.tbNodes = tbNodes
  local nCount = #tbId
  if nCount == 1 then
    self._mapNode.goOne:SetActive(true)
    self._mapNode.KeyNode[2].gameObject:SetActive(false)
  elseif nCount == 2 then
    self._mapNode.goOne:SetActive(false)
    self._mapNode.KeyNode[2].gameObject:SetActive(true)
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
    self._mapNode.KeyNode[i]:Refresh(nId, nState, nCount == 2)
  end
  local nLineType = 0
  if mapNext then
    if #mapNext.tbId == 2 then
      nLineType = nCount + 2
    elseif #mapNext.tbId == 3 then
      nLineType = nCount
    elseif nCount == 1 and #mapNext.tbId == 1 then
      nLineType = 5
    end
  end
  for i = 1, 5 do
    self._mapNode.goLine[i]:SetActive(nLineType == i)
  end
  if nLineType == 1 then
    local color = tbNodes[tbId[1]].bActive and ReadyColor or LockColor
    NovaAPI.SetImageColor(self._mapNode.line1_[1], color)
    NovaAPI.SetImageColor(self._mapNode.line1_[2], color)
  elseif nLineType == 2 then
    NovaAPI.SetImageColor(self._mapNode.line2_[1], tbNodes[tbId[1]].bActive and ReadyColor or LockColor)
    NovaAPI.SetImageColor(self._mapNode.line2_[2], tbNodes[tbId[2]].bActive and ReadyColor or LockColor)
  elseif nLineType == 3 or nLineType == 4 then
    local bActive = true
    for _, nId in ipairs(tbId) do
      if not tbNodes[nId].bActive then
        bActive = false
        break
      end
    end
    local color = bActive and ReadyColor or LockColor
    if nLineType == 3 then
      NovaAPI.SetImageColor(self._mapNode.line3_1, color)
    elseif nLineType == 4 then
      NovaAPI.SetImageColor(self._mapNode.line4_1, color)
    end
  elseif nLineType == 5 then
    local color = tbNodes[tbId[1]].bActive and ReadyColor or LockColor
    NovaAPI.SetImageColor(self._mapNode.line5_1, color)
  end
end

function KeyNodeListCtrl:GetType()
  return GameEnum.towerGrowthNodeType.Core
end

function KeyNodeListCtrl:GetReadyNode()
  local goNode
  for i, nId in ipairs(self.tbId) do
    local mapNode = self.tbNodes[nId]
    if mapNode.bReady and not mapNode.bActive then
      goNode = self._mapNode.btnNode[i].gameObject
    end
  end
  return goNode, GameEnum.towerGrowthNodeType.Core
end

function KeyNodeListCtrl:SetSelect(nId, bSelect)
  for i, v in ipairs(self.tbId) do
    if v == nId then
      self._mapNode.KeyNode[i]:SetSelect(bSelect)
      return
    end
  end
end

function KeyNodeListCtrl:PlayActiveAnim(nId, callback)
  for i, v in ipairs(self.tbId) do
    if v == nId then
      self._mapNode.KeyNode[i]:PlayActiveAnim(callback)
      return
    end
  end
end

function KeyNodeListCtrl:PlayActiveAnimFromActive(tbActiveId)
  for i, v in ipairs(self.tbId) do
    if table.indexof(tbActiveId, v) > 0 then
      self._mapNode.KeyNode[i]:PlayActiveAnim()
    end
  end
end

function KeyNodeListCtrl:ClearSelect()
  for i = 1, 2 do
    self._mapNode.KeyNode[i]:SetSelect(false)
  end
end

function KeyNodeListCtrl:Awake()
end

function KeyNodeListCtrl:OnEnable()
end

function KeyNodeListCtrl:OnDisable()
end

function KeyNodeListCtrl:OnDestroy()
end

function KeyNodeListCtrl:OnBtnClick_Node(btn, nIndex)
  EventManager.Hit("StarTowerGrowthNodeSelect", self.tbId[nIndex], self.nCloumn, btn.gameObject)
end

return KeyNodeListCtrl
