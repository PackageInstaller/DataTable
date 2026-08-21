_class("UIN27MiniGameRewardItem", UICustomWidget)
UIN27MiniGameRewardItem = UIN27MiniGameRewardItem

function UIN27MiniGameRewardItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIN27MiniGameRewardItem:_GetComponents()
  self._uiItem = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self._lock = self:GetGameObject("Lock")
  self._lock:SetActive(false)
end

function UIN27MiniGameRewardItem:SetData(data, missioninfo)
  self._item = self._uiItem:SpawnObject("UIItemHomeland")
  self._itemid = data[1]
  self._itemCount = data[2]
  self._missionInfo = missioninfo
  self:_OnValue()
end

function UIN27MiniGameRewardItem:_OnValue()
  local cfg = Cfg.cfg_item[self._itemid]
  if cfg == nil then
    Log.fatal("cfg_item is nil." .. self._itemid)
  end
  local rew = {}
  rew.assetid = self._itemid
  rew.count = self._itemCount
  self._item:Flush(rew)
  self._item.first:SetActive(false)
  self:RefreshUIInfo(self._missionInfo)
end

function UIN27MiniGameRewardItem:RefreshUIInfo(missioninfo)
  self._missionInfo = missioninfo
end

function UIN27MiniGameRewardItem:ShowTips(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN27MinigameRewardItemClicked, self._itemid, go.transform.position)
end
