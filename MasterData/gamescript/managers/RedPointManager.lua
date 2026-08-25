local RedPointManager, Super = System.NewClass("RedPointManager", Manager)

function RedPointManager:Awake(binder)
  self.binder = binder
  binder:BindEvent(EventMgr.Instance.UpdateBagEvent, function(datas)
    self:UpdateByBagUpate(datas)
  end)
end

local function CheckItemUpdateAwakerRed(tid)
  local cfg = ItemDataUtils.GetItemConfig(tid)
  if cfg and cfg.Type == CommonDefine.ItemType.Material or cfg and cfg.Type == CommonDefine.ItemType.TopBarItem and cfg.SubType == CommonDefine.ItemSubType.AwakerChip or tid == CommonDefine.CurrencyType.JuniorMoney or tid == CommonDefine.CurrencyType.AwakerUpgradeExp or cfg.Type == CommonDefine.ItemType.Trinket then
    return true
  end
end

function RedPointManager:UpdateByBagUpate(datas)
  if not datas then
    return
  end
  local needUpdateAwakerRed = false
  local needUpdateAvatarRed = false
  local needUpdateEmojiRed = false
  for _, data in pairs(datas) do
    if type(data) ~= "table" then
    else
      if not needUpdateAwakerRed and CheckItemUpdateAwakerRed(data.tid) then
        needUpdateAwakerRed = true
      end
      if ItemDataUtils.IsSpecificOnceRedItem(data.tid) then
        local showRed = data.changedNum and data.changedNum > 0
        RedPointDataUtils.UpdateSpecificItemOnceRed(data.tid, showRed)
      end
      if not needUpdateAvatarRed and ItemDataUtils.IsAvatarItem(data.tid) then
        needUpdateAvatarRed = true
      end
      if not needUpdateEmojiRed and ItemDataUtils.IsEmojiItem(data.tid) then
        needUpdateEmojiRed = true
      end
    end
  end
  if needUpdateAwakerRed then
    RedPointDataUtils.UpdateAwakerRed()
  end
  if needUpdateAvatarRed then
    SocialRedUtils.UpdateAvatarRed()
  end
  if needUpdateEmojiRed then
    RedPointDataUtils.UpdateEmojiNew()
  end
end

function RedPointManager:UpdateByItemAdd(item)
  if not item then
    return
  end
  if CheckItemUpdateAwakerRed(item.tid) then
    RedPointDataUtils.UpdateAwakerRed()
  end
end

function RedPointManager:UpdateByItemRemove(item)
  if not item then
    return
  end
  if CheckItemUpdateAwakerRed(item.tid) then
    RedPointDataUtils.UpdateAwakerRed()
  end
end

function RedPointManager:OnDestroy()
  Super.OnDestroy(self)
end

return RedPointManager
