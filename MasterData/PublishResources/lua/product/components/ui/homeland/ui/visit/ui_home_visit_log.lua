_class("UIHomeVisitLog", Object)
UIHomeVisitLog = UIHomeVisitLog

function UIHomeVisitLog:Constructor(log_info)
  self._palyerName = log_info.nick
  self._speedup = log_info.masks & HomelandVisitMask.HVM_Forge > 0
  self._water = 0 < log_info.masks & HomelandVisitMask.HVM_Cultivation
  self._takeGift = 0 < log_info.masks & HomelandVisitMask.HVM_Item
  if self._takeGift then
    self._giftID = log_info.item.assetid
    self._giftCount = log_info.item.count
  end
  self._time = log_info.visit_time
  local actionCount = 1
  local params = {}
  if self._speedup then
    actionCount = actionCount + 1
    table.insert(params, StringTable.Get("str_homeland_visit_log_action2"))
  end
  if self._water then
    actionCount = actionCount + 1
    table.insert(params, StringTable.Get("str_homeland_visit_log_action3"))
  end
  if self._takeGift then
    actionCount = actionCount + 1
    local cfg = Cfg.cfg_item[self._giftID]
    if cfg == nil then
      Log.exception("cfg_item中找不到领取的物品:", self._giftID)
    end
    local name = StringTable.Get(cfg.Name)
    table.insert(params, StringTable.Get("str_homeland_visit_log_action4", name, self._giftCount))
  end
  local logKey = "str_homeland_visit_log_type" .. actionCount
  self._log = StringTable.Get(logKey, self._palyerName, table.unpack(params, 1, actionCount))
end

function UIHomeVisitLog:Content()
  return self._log
end

function UIHomeVisitLog:Time()
  return self._time
end
