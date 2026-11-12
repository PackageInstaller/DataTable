local TipsPanelCtrl = class("MessageBoxTipsCtrl", BaseCtrl)
TipsPanelCtrl._mapNodeConfig = {
  trContent = {sComponentName = "Transform"},
  goPool = {sComponentName = "Transform"},
  goTips = {sComponentName = "GameObject"}
}
TipsPanelCtrl._mapEventConfig = {}
local HEIGHT = 90
local MOVE_TIME = 0.2
local WAIT_TIME = 0.5
local RECYCLE_TIME = 1.3

function TipsPanelCtrl:GetItem()
  local goItem
  if #self.tbPool > 0 then
    local nlast = #self.tbPool
    goItem = self.tbPool[nlast]
    table.remove(self.tbPool, nlast)
    goItem.gameObject.transform:SetParent(self._mapNode.trContent)
    goItem.gameObject.transform.localPosition = Vector3(0, 0, 0)
    return goItem
  else
    goItem = instantiate(self._mapNode.goTips, self._mapNode.trContent)
    goItem.gameObject.transform.localPosition = Vector3(0, 0, 0)
    goItem:SetActive(true)
    return goItem
  end
end

function TipsPanelCtrl:RecycleItem()
  local goItem = self.tbShowItem[1]
  table.remove(self.tbTipsQueue, 1)
  table.remove(self.tbShowItem, 1)
  if self.tbTweener[1] then
    self.tbTweener[1]:Kill()
    table.remove(self.tbTweener, 1)
  end
end

function TipsPanelCtrl:PopupTips()
  for nIndex, goOther in pairs(self.tbShowItem) do
    local rtOther = goOther.gameObject:GetComponent("RectTransform")
    local nCount = #self.tbShowItem + 1 - nIndex
    local v3Target = Vector3(0, nCount * HEIGHT, 0)
    self.tbTweener[nIndex] = rtOther:DOLocalMove(v3Target, MOVE_TIME):SetUpdate(true):SetEase(Ease.OutCubic)
  end
  local goItem = self:GetItem()
  table.insert(self.tbShowItem, goItem)
  NovaAPI.SetTMPText(goItem.gameObject.transform:Find("imgBg/txtTips"):GetComponent("TMP_Text"), self.tbTipsQueue[#self.tbTipsQueue])
  self:AddTimer(1, RECYCLE_TIME, "RecycleItem", true, true, true)
end

function TipsPanelCtrl:EnableReceive()
  self.bReceive = true
end

function TipsPanelCtrl:OpenUI(sTip)
  if self.bReceive then
    self.bReceive = false
    self:AddTimer(1, WAIT_TIME, "EnableReceive", true, true, true)
    table.insert(self.tbTipsQueue, sTip)
    self:PopupTips()
  end
end

function TipsPanelCtrl:Awake()
  self.tbTipsQueue = {}
  self.tbShowItem = {}
  self.tbPool = {}
  self.tbTweener = {}
  self.bReceive = true
  self._mapNode.goTips:SetActive(false)
end

function TipsPanelCtrl:OnDisable()
  self.tbTipsQueue = nil
  self.tbShowItem = nil
  self.tbPool = nil
  self.tbTweener = nil
end

function TipsPanelCtrl:OnDestroy()
end

return TipsPanelCtrl
