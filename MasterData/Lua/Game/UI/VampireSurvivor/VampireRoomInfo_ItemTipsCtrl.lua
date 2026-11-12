local VampireRoomInfo_ItemTipsCtrl = class("VampireRoomInfo_ItemTipsCtrl", BaseCtrl)
VampireRoomInfo_ItemTipsCtrl._mapNodeConfig = {
  tr_TipContent = {sComponentName = "Transform"},
  TipPool = {sComponentName = "Transform"},
  TemplateItemTip = {sComponentName = "GameObject"},
  TemplateTip = {sComponentName = "GameObject"}
}
VampireRoomInfo_ItemTipsCtrl._mapEventConfig = {
  VampireFateCardTips = "OnEvent_ShowTips",
  VampireEventTips = "OnEvent_ShowEventTips",
  StarTowerTipsShowEnd = "OnEvent_TipsShowEnd"
}
VampireRoomInfo_ItemTipsCtrl._mapRedDotConfig = {}

function VampireRoomInfo_ItemTipsCtrl:GetItem(nType)
  if nType == 1 then
    if #self._tbItemTipPool > 0 then
      local idx = #self._tbItemTipPool
      TipItem = self._tbItemTipPool[idx]
      table.remove(self._tbItemTipPool, idx)
      TipItem.gameObject.transform:SetParent(self._mapNode.tr_TipContent)
      return TipItem
    else
      local itemObj = instantiate(self._mapNode.TemplateItemTip, self._mapNode.tr_TipContent)
      itemObj:SetActive(true)
      TipItem = self:BindCtrlByNode(itemObj, "Game.UI.VampireSurvivor.VampireRoomInfo_ItemTipsItemCtrl")
      return TipItem
    end
  elseif 0 < #self._tbEventTipPool then
    local idx = #self._tbEventTipPool
    TipItem = self._tbEventTipPool[idx]
    table.remove(self._tbEventTipPool, idx)
    TipItem.gameObject.transform:SetParent(self._mapNode.tr_TipContent)
    return TipItem
  else
    local itemObj = instantiate(self._mapNode.TemplateTip, self._mapNode.tr_TipContent)
    itemObj:SetActive(true)
    TipItem = self:BindCtrlByNode(itemObj, "Game.UI.VampireSurvivor.VampireRoomInfo_ItemTipsEventItemCtrl")
    return TipItem
  end
end

function VampireRoomInfo_ItemTipsCtrl:RecycleItem(itemCtrl, nType)
  itemCtrl.gameObject.transform:SetParent(self._mapNode.TipPool)
  if nType == 1 then
    table.insert(self._tbItemTipPool, itemCtrl)
  else
    table.insert(self._tbEventItemTipPool, itemCtrl)
  end
end

function VampireRoomInfo_ItemTipsCtrl:ShowTips()
  if not self.bPause then
    local function wait()
      local frameCount = 0
      
      while #self._tbTipShow < self.nMaxTipsCount and 0 < #self._tbTipsQueue do
        if 4 <= frameCount then
          frameCount = 0
          local tipsInfo = table.remove(self._tbTipsQueue, 1)
          local tipItem = self:GetItem(tipsInfo[1])
          tipItem.gameObject:SetActive(true)
          table.insert(self._tbTipShow, tipItem)
          if tipsInfo[1] == 1 then
            tipItem:Show(tipsInfo[2].nTid, tipsInfo[2].nCount)
          else
            tipItem:Show(tipsInfo[2], tipsInfo[3])
          end
        else
          frameCount = frameCount + 1
          coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        end
      end
    end
    
    self.showTipsCor = cs_coroutine.start(wait)
  else
    print("剧情中无法显示物品提示")
  end
end

function VampireRoomInfo_ItemTipsCtrl:Awake()
  self._mapNode.TemplateItemTip.gameObject:SetActive(false)
  self.bPause = false
  self.nMaxTipsCount = 8
  self._tbItemTipPool = {}
  self._tbEventItemTipPool = {}
  self._tbEventTipPool = {}
  self._tbDiscTipPool = {}
  self._tbTipShow = {}
  self._tbTipsQueue = {}
  self.showTipsCor = nil
  delChildren(self._mapNode.tr_TipContent)
end

function VampireRoomInfo_ItemTipsCtrl:OnDisable()
  if nil ~= self.showTipsCor then
    cs_coroutine.stop(self.showTipsCor)
  end
  self.showTipsCor = nil
end

function VampireRoomInfo_ItemTipsCtrl:OnEvent_ShowTips(tbTips)
  for _, v in ipairs(tbTips) do
    table.insert(self._tbTipsQueue, {1, v})
  end
  self:ShowTips()
end

function VampireRoomInfo_ItemTipsCtrl:OnEvent_ShowEventTips(nType, nMonsterId)
  table.insert(self._tbTipsQueue, {
    2,
    nType,
    nMonsterId
  })
  self:ShowTips()
end

function VampireRoomInfo_ItemTipsCtrl:OnEvent_TipsShowEnd(itemCtrl, nType)
  local idx = table.indexof(self._tbTipShow, itemCtrl)
  table.remove(self._tbTipShow, idx)
  self:RecycleItem(itemCtrl, nType)
  self:ShowTips()
end

return VampireRoomInfo_ItemTipsCtrl
