local PopupTipsCtrl = class("PopupTipsCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
PopupTipsCtrl._mapNodeConfig = {
  trContent = {sComponentName = "Transform"},
  goPool = {sComponentName = "Transform"},
  goTips = {sComponentName = "GameObject"}
}
PopupTipsCtrl._mapEventConfig = {
  ContinuePopupTips = "ProcessParam"
}
local HEIGHT = 90
local MOVE_TIME = 0.2
local WAIT_TIME = 0.5
local RECYCLE_TIME = 1.3

function PopupTipsCtrl:GetItem()
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

function PopupTipsCtrl:RecycleItem()
  local goItem = self.tbShowItem[1]
  goItem.gameObject.transform:SetParent(self._mapNode.goPool)
  table.remove(self.tbTipsQueue, 1)
  table.remove(self.tbShowItem, 1)
  table.insert(self.tbPool, goItem)
  if self.tbTweener[1] then
    self.tbTweener[1]:Kill()
    table.remove(self.tbTweener, 1)
  end
  if #self.tbTipsQueue == 0 then
    EventManager.Hit(EventId.ClosePopupTips)
  end
end

function PopupTipsCtrl:PopupTips()
  for nIndex, goOther in pairs(self.tbShowItem) do
    local rtOther = goOther.gameObject:GetComponent("RectTransform")
    local nCount = #self.tbShowItem + 1 - nIndex
    local v3Target = Vector3(0, nCount * HEIGHT, 0)
    self.tbTweener[nIndex] = rtOther:DOLocalMove(v3Target, MOVE_TIME):SetUpdate(true):SetEase(Ease.OutCubic)
  end
  local goItem = self:GetItem()
  table.insert(self.tbShowItem, goItem)
  local mapTip = self.tbTipsQueue[#self.tbTipsQueue]
  NovaAPI.SetTMPText(goItem.gameObject.transform:Find("imgBg/txtTips"):GetComponent("TMP_Text"), mapTip.sContent)
  if mapTip.sSound then
    WwiseAudioMgr:PlaySound(mapTip.sSound)
  elseif mapTip.bPositive then
    WwiseAudioMgr:PlaySound("ui_common_feedback_success")
  else
    WwiseAudioMgr:PlaySound("ui_common_feedback_error")
  end
  self:AddTimer(1, RECYCLE_TIME, "RecycleItem", true, true, true)
end

function PopupTipsCtrl:EnableReceive()
  self.bReceive = true
end

function PopupTipsCtrl:PopupTipsText(mapTip)
  if self.bReceive then
    self.bReceive = false
    self:AddTimer(1, WAIT_TIME, "EnableReceive", true, true, true)
    table.insert(self.tbTipsQueue, mapTip)
    self:PopupTips()
  end
end

function PopupTipsCtrl:ProcessParam(mapMsg)
  self:PopupTipsText(mapMsg)
end

function PopupTipsCtrl:Awake()
  self.tbTipsQueue = {}
  self.tbShowItem = {}
  self.tbPool = {}
  self.tbTweener = {}
  self.bReceive = true
  local mapMsg = self:GetPanelParam()
  self:ProcessParam(mapMsg)
end

function PopupTipsCtrl:OnEnable()
end

function PopupTipsCtrl:OnDisable()
  self.tbTipsQueue = nil
  self.tbShowItem = nil
  self.tbPool = nil
  self.tbTweener = nil
end

function PopupTipsCtrl:OnDestroy()
end

return PopupTipsCtrl
