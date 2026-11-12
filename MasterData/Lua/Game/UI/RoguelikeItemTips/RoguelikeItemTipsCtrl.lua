local RoguelikeItemTipsCtrl = class("RoguelikeItemTipsCtrl", BaseCtrl)
RoguelikeItemTipsCtrl._mapNodeConfig = {
  tr_TipContent = {sComponentName = "Transform"},
  TipPool = {sComponentName = "Transform"},
  TemplateTip = {sComponentName = "GameObject"}
}
RoguelikeItemTipsCtrl._mapEventConfig = {
  [EventId.ShowRoguelikeDrop] = "OnEvent_ShowTips",
  AvgBubbleStart = "OnAvgBubbleStart",
  [EventId.AvgBubbleExit] = "OnAvgBubbleEnd",
  TipsShowEnd = "OnEvent_TipsShowEnd"
}

function RoguelikeItemTipsCtrl:GetItem()
  local TipItem
  if #self._tbTipPool > 0 then
    local idx = #self._tbTipPool
    TipItem = self._tbTipPool[idx]
    table.remove(self._tbTipPool, idx)
    TipItem.gameObject.transform:SetParent(self._mapNode.tr_TipContent)
    return TipItem
  else
    local itemObj = instantiate(self._mapNode.TemplateTip, self._mapNode.tr_TipContent)
    itemObj:SetActive(true)
    TipItem = self:BindCtrlByNode(itemObj, "Game.UI.RoguelikeItemTips.RoguelikeItemTipsItemCtrl")
    return TipItem
  end
end

function RoguelikeItemTipsCtrl:RecycleItem(itemCtrl)
  itemCtrl.gameObject.transform:SetParent(self._mapNode.TipPool)
  table.insert(self._tbTipPool, itemCtrl)
end

function RoguelikeItemTipsCtrl:ShowTips()
  if not self.bPause then
    while #self._tbTipShow < self.nMaxTipsCount and #self._tbTipsQueue > 0 do
      local itemInfo = table.remove(self._tbTipsQueue, 1)
      local tipItem = self:GetItem()
      tipItem.gameObject:SetActive(true)
      table.insert(self._tbTipShow, tipItem)
      tipItem:Show(itemInfo.nTid, itemInfo.nCount)
    end
  else
    print("剧情中无法显示物品提示")
  end
end

function RoguelikeItemTipsCtrl:Awake()
  self.nMaxTipsCount = 4
  self.bPause = false
end

function RoguelikeItemTipsCtrl:OnEnable()
  self.bPause = false
  self.nMaxTipsCount = 4
  self._tbTipPool = {}
  self._tbTipShow = {}
  self._tbTipsQueue = {}
  delChildren(self._mapNode.tr_TipContent)
end

function RoguelikeItemTipsCtrl:OnDisable()
end

function RoguelikeItemTipsCtrl:OnDestroy()
end

function RoguelikeItemTipsCtrl:OnEvent_ShowTips(nTid, nCount)
  table.insert(self._tbTipsQueue, {nTid = nTid, nCount = nCount})
  self:ShowTips()
end

function RoguelikeItemTipsCtrl:OnEvent_TipsShowEnd(itemCtrl)
  local idx = table.indexof(self._tbTipShow, itemCtrl)
  table.remove(self._tbTipShow, idx)
  self:RecycleItem(itemCtrl)
  self:ShowTips()
end

function RoguelikeItemTipsCtrl:OnAvgBubbleStart(sAvgId, nGroupId)
  self.bPause = true
  if #self._tbTipShow > 0 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(1))
      
      for _, item in pairs(self._tbTipShow) do
        item:FadeOut()
      end
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.5))
      for _, item in pairs(self._tbTipShow) do
        self:RecycleItem(item)
      end
      EventManager.Hit(EventId.AvgBubbleShow, sAvgId, nGroupId)
    end
    
    cs_coroutine.start(wait)
  else
    EventManager.Hit(EventId.AvgBubbleShow, sAvgId, nGroupId)
  end
end

function RoguelikeItemTipsCtrl:OnAvgBubbleEnd()
  self.bPause = false
  self:ShowTips()
end

return RoguelikeItemTipsCtrl
