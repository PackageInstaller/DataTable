local ConsumableCtrl = class("ConsumableCtrl", BaseCtrl)
ConsumableCtrl._mapNodeConfig = {
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  btnBlur = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_Cancel"
  },
  BatchItem = {
    sCtrlName = "Game.UI.Consumable.BatchItemCtrl"
  },
  OutfitSelect = {
    sCtrlName = "Game.UI.Consumable.OutfitSelectCtrl"
  },
  RandomItemSelect = {
    sCtrlName = "Game.UI.Consumable.RandomItemSelect"
  }
}
ConsumableCtrl._mapEventConfig = {
  ConfirmUseItem = "OnEvent_ConfirmUseItem",
  CancelUseItem = "OnEvent_ClickCancel"
}
ConsumableCtrl._mapRedDotConfig = {}

function ConsumableCtrl:Awake()
end

function ConsumableCtrl:FadeIn()
end

function ConsumableCtrl:FadeOut()
end

function ConsumableCtrl:OnEnable()
  self._mapNode.blur:SetActive(true)
  local tbParam = self:GetPanelParam()
  self.tbItems = tbParam[1]
  self.nCurIdx = 1
  if self.tbItems == nil then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      EventManager.Hit(EventId.ClosePanel, PanelId.Consumable)
    end
    
    cs_coroutine.start(wait)
  else
    local nItemId = self.tbItems[self.nCurIdx]
    local mapItemCfgData = ConfigTable.GetData_Item(nItemId)
    if mapItemCfgData ~= nil then
      do
        local function wait()
          coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
          
          if mapItemCfgData.Stype == GameEnum.itemStype.OutfitCYO then
            self._mapNode.OutfitSelect:OpenPanel(nItemId)
          elseif mapItemCfgData.Stype == GameEnum.itemStype.RandomPackage then
            local nItemCount = PlayerData.Item:GetItemCountByID(nItemId)
            self._mapNode.RandomItemSelect:OpenPanel(nItemId, nItemCount)
          elseif mapItemCfgData.Stype == GameEnum.itemStype.ComCYO then
            local nItemCount = PlayerData.Item:GetItemCountByID(nItemId)
            local nSelectItemId = tbParam[2]
            local nNeedCount = tbParam[3]
            self._mapNode.BatchItem:OpenPanel(nItemId, nItemCount, nSelectItemId, nNeedCount)
          end
        end
        
        cs_coroutine.start(wait)
      end
    end
  end
end

function ConsumableCtrl:OnDisable()
end

function ConsumableCtrl:OnDestroy()
end

function ConsumableCtrl:OnRelease()
end

function ConsumableCtrl:OnEvent_ConfirmUseItem(nItemId, nCount, nChooseTid)
  local tbItem = PlayerData.Item:GetItemSortByExpire(nItemId)
  if #tbItem == 0 then
    printError("没有可使用的道具：" .. nItemId)
    return
  end
  local tbUseItem = {}
  local nRemainCount = nCount
  if nChooseTid ~= nil then
    for _, tbItemCount in ipairs(tbItem) do
      if nRemainCount > tbItemCount[2] then
        table.insert(tbUseItem, {
          Id = tbItemCount[1],
          Tid = nItemId,
          SelectTid = nChooseTid,
          Qty = tbItemCount[2] == 1 and 0 or tbItemCount[2]
        })
        nRemainCount = nRemainCount - tbItemCount[2]
      else
        table.insert(tbUseItem, {
          Id = tbItemCount[1],
          Tid = nItemId,
          SelectTid = nChooseTid,
          Qty = nRemainCount == 1 and 0 or nRemainCount
        })
        nRemainCount = 0
        break
      end
    end
  else
    for _, tbItemCount in ipairs(tbItem) do
      if 0 < nRemainCount then
        if nRemainCount > tbItemCount[2] then
          table.insert(tbUseItem, {
            Id = tbItemCount[1],
            Tid = nItemId,
            Qty = tbItemCount[2]
          })
          nRemainCount = nRemainCount - tbItemCount[2]
        else
          table.insert(tbUseItem, {
            Id = tbItemCount[1],
            Tid = nItemId,
            Qty = nRemainCount
          })
          nRemainCount = 0
        end
      end
    end
  end
  
  local function callback()
    EventManager.Hit("ConsumableUsed")
    self._mapNode.BatchItem.gameObject:SetActive(false)
    self._mapNode.OutfitSelect.gameObject:SetActive(false)
    self._mapNode.RandomItemSelect.gameObject:SetActive(false)
    if self.tbItems[self.nCurIdx + 1] ~= nil then
      self.nCurIdx = self.nCurIdx + 1
      local nItemId = self.tbItems[self.nCurIdx]
      local mapItemCfgData = ConfigTable.GetData_Item(nItemId)
      if mapItemCfgData ~= nil then
        if mapItemCfgData.Stype == GameEnum.itemStype.OutfitCYO then
          self._mapNode.OutfitSelect:OpenPanel(nItemId)
        elseif mapItemCfgData.Stype == GameEnum.itemStype.RandomPackage then
          local nItemCount = PlayerData.Item:GetItemCountByID(nItemId)
          self._mapNode.RandomItemSelect:OpenPanel(nItemId, nItemCount)
        elseif mapItemCfgData.Stype == GameEnum.itemStype.ComCYO then
          local nItemCount = PlayerData.Item:GetItemCountByID(nItemId)
          self._mapNode.BatchItem:OpenPanel(nItemId, nItemCount)
        end
      end
    else
      EventManager.Hit(EventId.ClosePanel, PanelId.Consumable)
    end
  end
  
  if nChooseTid ~= nil then
    PlayerData.Item:SendPickItemMsg(tbUseItem, callback, true)
  else
    PlayerData.Item:SendUseItemMsg(tbUseItem, callback, true)
  end
end

function ConsumableCtrl:OnEvent_ClickCancel()
  self._mapNode.aniBlur:SetTrigger("tOut")
  
  local function wait()
    self._mapNode.BatchItem.gameObject:SetActive(false)
    self._mapNode.OutfitSelect.gameObject:SetActive(false)
    self._mapNode.RandomItemSelect.gameObject:SetActive(false)
    if self.tbItems[self.nCurIdx + 1] ~= nil then
      self.nCurIdx = self.nCurIdx + 1
      local nItemId = self.tbItems[self.nCurIdx]
      local mapItemCfgData = ConfigTable.GetData_Item(nItemId)
      if mapItemCfgData ~= nil then
        if mapItemCfgData.Stype == GameEnum.itemStype.OutfitCYO then
          self._mapNode.OutfitSelect:OpenPanel(nItemId)
        elseif mapItemCfgData.Stype == GameEnum.itemStype.RandomPackage then
          local nItemCount = PlayerData.Item:GetItemCountByID(nItemId)
          self._mapNode.RandomItemSelect:OpenPanel(nItemId, nItemCount)
        elseif mapItemCfgData.Stype == GameEnum.itemStype.ComCYO then
          local nItemCount = PlayerData.Item:GetItemCountByID(nItemId)
          self._mapNode.BatchItem:OpenPanel(nItemId, nItemCount)
        end
      end
    else
      EventManager.Hit(EventId.ClosePanel, PanelId.Consumable)
    end
  end
  
  self:AddTimer(1, 0.2, wait, true, true, true)
end

function ConsumableCtrl:OnBtnClick_Cancel()
  self._mapNode.aniBlur:SetTrigger("tOut")
  EventManager.Hit("ConsumableCancel")
end

return ConsumableCtrl
