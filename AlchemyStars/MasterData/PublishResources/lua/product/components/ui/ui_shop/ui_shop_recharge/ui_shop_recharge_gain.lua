_class("UIShopRechargeGain", UIController)
UIShopRechargeGain = UIShopRechargeGain

function UIShopRechargeGain:Constructor()
  self._showCount = 5
end

function UIShopRechargeGain:OnShow(uiParams)
  self._anim = self:GetUIComponent("Animation", "uiAnim")
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  local mItem = self:GetModule(ItemModule)
  self._tRoleAsset = uiParams[1]
  self.callback = uiParams[2]
  self._tRoleAsset = mItem:SortRoleAsset(self._tRoleAsset)
  local len = table.count(self._tRoleAsset)
  local itemlist = {}
  if len > self._showCount then
    itemlist = table.sub(self._tRoleAsset, 1, self._showCount)
    self._tRoleAsset = table.sub(self._tRoleAsset, self._showCount + 1, len)
  else
    itemlist = self._tRoleAsset
    self._tRoleAsset = nil
  end
  self._itemList = {}
  for i = 1, table.count(itemlist) do
    local ItemTempleate = Cfg.cfg_item[itemlist[i].assetid]
    if ItemTempleate then
      self._itemList[i] = {
        item_id = itemlist[i].assetid,
        item_count = itemlist[i].count,
        item_des = itemlist[i].des,
        icon = ItemTempleate.Icon,
        item_name = StringTable.Get(ItemTempleate.Name),
        simple_desc = ItemTempleate.RpIntro,
        color = ItemTempleate.Color
      }
    end
  end
  self:Flush()
end

function UIShopRechargeGain:OnHide()
end

function UIShopRechargeGain:Flush()
  self._content:SpawnObjects("UIShopRechargeGainItem", table.count(self._itemList))
  local uiItems = self._content:GetAllSpawnList()
  for i, uiItem in ipairs(uiItems) do
    uiItem:ReadyToFlush(self._itemList[i], i * 200)
  end
end

function UIShopRechargeGain:bgOnClick(go)
  self:Lock("UIShopRechargeGain:OnHide")
  self._anim:Play("Uieff_UIShopRechargeGain_Out")
  self:StartTask(function(TT)
    YIELD(TT, 667)
    self:UnLock("UIShopRechargeGain:OnHide")
    self:CloseDialog()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ForceFlushMonthCard)
    if self._tRoleAsset and table.count(self._tRoleAsset) > 0 then
      self:ShowDialog("UIShopRechargeGain", self._tRoleAsset, self.callback)
    elseif self.callback then
      self.callback()
    end
  end, self)
end
