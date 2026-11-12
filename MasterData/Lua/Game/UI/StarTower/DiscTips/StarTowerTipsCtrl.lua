local StarTowerTipsCtrl = class("StarTowerTipsCtrl", BaseCtrl)
StarTowerTipsCtrl._mapNodeConfig = {
  tr_TipContent = {sComponentName = "Transform"},
  TipPool = {sComponentName = "Transform"},
  TemplateDiscTip = {sComponentName = "GameObject"},
  TemplateItemTip = {sComponentName = "GameObject"},
  TemplateFateCardTip = {sComponentName = "GameObject"},
  TemplateNoteTip = {sComponentName = "GameObject"}
}
StarTowerTipsCtrl._mapEventConfig = {
  StarTowerBattleRewardTips = "OnEvent_ShowTips",
  StarTowerTipsShowEnd = "OnEvent_TipsShowEnd"
}
StarTowerTipsCtrl._mapRedDotConfig = {}

function StarTowerTipsCtrl:GetItem(nTipType)
  local TipItem
  if nTipType == AllEnum.StarTowerTipsType.ItemTip then
    if #self._tbItemTipPool > 0 then
      local idx = #self._tbItemTipPool
      TipItem = self._tbItemTipPool[idx]
      table.remove(self._tbItemTipPool, idx)
      TipItem.gameObject.transform:SetParent(self._mapNode.tr_TipContent)
      return TipItem
    else
      local itemObj = instantiate(self._mapNode.TemplateItemTip, self._mapNode.tr_TipContent)
      itemObj:SetActive(true)
      TipItem = self:BindCtrlByNode(itemObj, "Game.UI.StarTower.DiscTips.StarTowerItemTipsItem")
      return TipItem
    end
  elseif nTipType == AllEnum.StarTowerTipsType.FateCardTip then
    if 0 < #self._tbFateCardTipPool then
      local idx = #self._tbFateCardTipPool
      TipItem = self._tbFateCardTipPool[idx]
      table.remove(self._tbFateCardTipPool, idx)
      TipItem.gameObject.transform:SetParent(self._mapNode.tr_TipContent)
      return TipItem
    else
      local itemObj = instantiate(self._mapNode.TemplateFateCardTip, self._mapNode.tr_TipContent)
      itemObj:SetActive(true)
      TipItem = self:BindCtrlByNode(itemObj, "Game.UI.StarTower.DiscTips.StarTowerFateCardTipsItem")
      return TipItem
    end
  elseif nTipType == AllEnum.StarTowerTipsType.DiscTip then
    if 0 < #self._tbDiscTipPool then
      local idx = #self._tbDiscTipPool
      TipItem = self._tbDiscTipPool[idx]
      table.remove(self._tbDiscTipPool, idx)
      TipItem.gameObject.transform:SetParent(self._mapNode.tr_TipContent)
      return TipItem
    else
      local itemObj = instantiate(self._mapNode.TemplateDiscTip, self._mapNode.tr_TipContent)
      itemObj:SetActive(true)
      TipItem = self:BindCtrlByNode(itemObj, "Game.UI.StarTower.DiscTips.StarTowerDiscTipsItem")
      return TipItem
    end
  elseif nTipType == AllEnum.StarTowerTipsType.NoteTip then
    if 0 < #self._tbNoteTipPool then
      local idx = #self._tbNoteTipPool
      TipItem = self._tbNoteTipPool[idx]
      table.remove(self._tbNoteTipPool, idx)
      TipItem.gameObject.transform:SetParent(self._mapNode.tr_TipContent)
      return TipItem
    else
      local itemObj = instantiate(self._mapNode.TemplateNoteTip, self._mapNode.tr_TipContent)
      itemObj:SetActive(true)
      TipItem = self:BindCtrlByNode(itemObj, "Game.UI.StarTower.DiscTips.StarTowerNoteTipsItem")
      return TipItem
    end
  elseif nTipType == AllEnum.StarTowerTipsType.NPCAffinity then
    if 0 < #self._tbAffinityTipPool then
      local idx = #self._tbAffinityTipPool
      TipItem = self._tbAffinityTipPool[idx]
      table.remove(self._tbAffinityTipPool, idx)
      TipItem.gameObject.transform:SetParent(self._mapNode.tr_TipContent)
      return TipItem
    else
      local itemObj = instantiate(self._mapNode.TemplateItemTip, self._mapNode.tr_TipContent)
      itemObj:SetActive(true)
      TipItem = self:BindCtrlByNode(itemObj, "Game.UI.StarTower.DiscTips.StarTowerAffinityTipsItem")
      return TipItem
    end
  end
end

function StarTowerTipsCtrl:RecycleItem(itemCtrl, nTipType)
  itemCtrl.gameObject.transform:SetParent(self._mapNode.TipPool)
  if nTipType == AllEnum.StarTowerTipsType.DiscTip then
    table.insert(self._tbDiscTipPool, itemCtrl)
  elseif nTipType == AllEnum.StarTowerTipsType.ItemTip then
    table.insert(self._tbItemTipPool, itemCtrl)
  elseif nTipType == AllEnum.StarTowerTipsType.FateCardTip then
    table.insert(self._tbFateCardTipPool, itemCtrl)
  elseif nTipType == AllEnum.StarTowerTipsType.NoteTip then
    table.insert(self._tbNoteTipPool, itemCtrl)
  elseif nTipType == AllEnum.StarTowerTipsType.NPCAffinity then
    table.insert(self._tbAffinityTipPool, itemCtrl)
  end
end

function StarTowerTipsCtrl:ShowTips()
  if not self.bPause then
    local function wait()
      local frameCount = 0
      
      while #self._tbTipShow < self.nMaxTipsCount and 0 < #self._tbTipsQueue do
        if 4 <= frameCount then
          frameCount = 0
          local tipsInfo = table.remove(self._tbTipsQueue, 1)
          local tipItem = self:GetItem(tipsInfo.nTipType)
          tipItem.gameObject:SetActive(true)
          table.insert(self._tbTipShow, tipItem)
          if tipsInfo.nTipType == AllEnum.StarTowerTipsType.DiscTip then
            tipItem:Show(tipsInfo.nSkillId)
          elseif tipsInfo.nTipType == AllEnum.StarTowerTipsType.ItemTip then
            tipItem:Show(tipsInfo.nTid, tipsInfo.nCount)
          elseif tipsInfo.nTipType == AllEnum.StarTowerTipsType.FateCardTip then
            tipItem:Show(tipsInfo.nFateCardId)
          elseif tipsInfo.nTipType == AllEnum.StarTowerTipsType.NoteTip then
            tipItem:Show(tipsInfo.nNoteId, tipsInfo.nCount)
          elseif tipsInfo.nTipType == AllEnum.StarTowerTipsType.NPCAffinity then
            tipItem:Show(tipsInfo.nNPCId, tipsInfo.nAffinity)
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

function StarTowerTipsCtrl:Awake()
  self._mapNode.TemplateDiscTip.gameObject:SetActive(false)
  self._mapNode.TemplateItemTip.gameObject:SetActive(false)
  self._mapNode.TemplateFateCardTip.gameObject:SetActive(false)
  self._mapNode.TemplateNoteTip.gameObject:SetActive(false)
  self.bPause = false
  self.nMaxTipsCount = 8
  self._tbItemTipPool = {}
  self._tbDiscTipPool = {}
  self._tbFateCardTipPool = {}
  self._tbNoteTipPool = {}
  self._tbAffinityTipPool = {}
  self._tbTipShow = {}
  self._tbTipsQueue = {}
  self.showTipsCor = nil
  delChildren(self._mapNode.tr_TipContent)
end

function StarTowerTipsCtrl:OnDisable()
  if nil ~= self.showTipsCor then
    cs_coroutine.stop(self.showTipsCor)
  end
  self.showTipsCor = nil
end

function StarTowerTipsCtrl:StartShowTips(tbTips)
  for _, v in ipairs(tbTips) do
    table.insert(self._tbTipsQueue, v)
  end
  self:ShowTips()
end

function StarTowerTipsCtrl:OnEvent_TipsShowEnd(itemCtrl, nTipType)
  if #self._tbTipShow > 0 then
    local idx = table.indexof(self._tbTipShow, itemCtrl)
    if idx <= #self._tbTipShow and idx ~= 0 then
      table.remove(self._tbTipShow, idx)
      self:RecycleItem(itemCtrl, nTipType)
      self:ShowTips()
    end
  end
end

return StarTowerTipsCtrl
