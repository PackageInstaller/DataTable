local SoldierTechNodeListCtrl = class("SoldierTechNodeListCtrl", BaseCtrl)
local _, ReadyColor = ColorUtility.TryParseHtmlString("#f1f4f6")
local _, LockColor = ColorUtility.TryParseHtmlString("#657eae")
SoldierTechNodeListCtrl._mapNodeConfig = {
  goNode = {
    nCount = 3,
    sCtrlName = "Game.UI.Soldier.Technology.SoldierTechNodeCtrl"
  },
  btnNode = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Node"
  },
  lineSingle = {nCount = 3, sComponentName = "Image"},
  line1_2 = {sComponentName = "Image"},
  line1_3 = {sComponentName = "Image"},
  line2_1 = {sComponentName = "Image"},
  line2_3 = {sComponentName = "Image"},
  line3_1 = {sComponentName = "Image"},
  line3_2 = {sComponentName = "Image"}
}
SoldierTechNodeListCtrl._mapEventConfig = {}
SoldierTechNodeListCtrl._mapRedDotConfig = {}

function SoldierTechNodeListCtrl:Refresh(nCloumn, tbNodes, tbId, mapNext)
  self.nCloumn = nCloumn
  self.tbNodes = tbNodes
  self.tbId = tbId
  for i = 1, 3 do
    local nId = tbId and tbId[i]
    if nId then
      self._mapNode.goNode[i].gameObject:SetActive(true)
      self._mapNode.goNode[i]:Refresh(nId, tbNodes[nId])
    else
      self._mapNode.goNode[i].gameObject:SetActive(false)
    end
  end
  self:RefreshLines(tbNodes, tbId, mapNext)
end

function SoldierTechNodeListCtrl:HideAllLines()
  for i = 1, 3 do
    self._mapNode.lineSingle[i].gameObject:SetActive(false)
  end
  for a = 1, 3 do
    for b = 1, 3 do
      if a ~= b then
        self._mapNode["line" .. a .. "_" .. b].gameObject:SetActive(false)
      end
    end
  end
end

function SoldierTechNodeListCtrl:RefreshLines(tbNodes, tbId, mapNext)
  self:HideAllLines()
  if not (tbId and mapNext) or not mapNext.tbId then
    return
  end
  local tbNextId = mapNext.tbId
  local mapA, mapB = {}, {}
  local nA, nB = 0, 0
  local bDiagonal = true
  for j = 1, 3 do
    local nIdB = tbNextId[j]
    local nodeB = nIdB and tbNodes[nIdB]
    local tbPre = nodeB and nodeB.tbPreNodes
    if tbPre then
      for _, nPreId in ipairs(tbPre) do
        for i = 1, 3 do
          if tbId[i] == nPreId then
            if not mapA[i] then
              mapA[i] = true
              nA = nA + 1
            end
            if not mapB[j] then
              mapB[j] = true
              nB = nB + 1
            end
            if i ~= j then
              bDiagonal = false
            end
            break
          end
        end
      end
    end
  end
  if nA == 0 or nB == 0 then
    return
  end
  if nA == nB and bDiagonal then
    for i = 1, 3 do
      if mapA[i] then
        local img = self._mapNode.lineSingle[i]
        img.gameObject:SetActive(true)
      end
    end
  else
    local sLineKey = "line" .. nA .. "_" .. nB
    local img = self._mapNode[sLineKey]
    if not img then
      printError(string.format("[SoldierTechNode] 未找到连线样式 %s, 列 %s, 请检查配置或补充连线节点", sLineKey, tostring(self.nCloumn)))
      return
    end
    img.gameObject:SetActive(true)
    local bAllActive = true
    for i = 1, 3 do
      if mapA[i] and not tbNodes[tbId[i]].bActive then
        bAllActive = false
        break
      end
    end
  end
end

function SoldierTechNodeListCtrl:SetSelect(nId, bSelect)
  if not self.tbId then
    return
  end
  for i = 1, 3 do
    if self.tbId[i] == nId then
      self._mapNode.goNode[i]:SetSelect(bSelect)
      return
    end
  end
end

function SoldierTechNodeListCtrl:Awake()
end

function SoldierTechNodeListCtrl:OnEnable()
end

function SoldierTechNodeListCtrl:OnDisable()
end

function SoldierTechNodeListCtrl:OnDestroy()
end

function SoldierTechNodeListCtrl:OnBtnClick_Node(btn, nIndex)
  local nId = self.tbId and self.tbId[nIndex]
  if not nId then
    return
  end
  EventManager.Hit("SoldierTechNodeSelect", nId, self.nCloumn, self._mapNode.goNode[nIndex].gameObject)
end

return SoldierTechNodeListCtrl
