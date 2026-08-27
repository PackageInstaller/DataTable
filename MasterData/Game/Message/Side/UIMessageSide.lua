local UIMessageSide = class("UIMessageSide", UIBaseWindow)
local base = UIBaseWindow
local UITipsCacheItem = require("Game.Message.Side.UITipsCacheItem")
local eCacheState = require("Game.Message.Side.eCacheState")

function UIMessageSide:OnInit()
  self._cacheItemPool = UIItemPool.New(UITipsCacheItem, self.ui.obj_TipsItem)
  self.ui.obj_TipsItem:SetActive(false)
  self.msgDataList = {}
  self.curShowItemList = {}
  self.__update__handle = BindCallback(self, self.__OnCoroutinePlay)
  UpdateManager:AddFixedUpdate(self.__update__handle)
end

function UIMessageSide:ShowTips(content, waitSecond, tipsType, cachePlay)
  local msgData = {
    tipsType = tipsType,
    content = content,
    waitTime = waitSecond or 1.5
  }
  if cachePlay then
    table.insert(self.msgDataList, msgData)
  else
    self:_ShowCacheItem(msgData)
  end
end

function UIMessageSide:_ShowCacheItem(msgData)
  local cacheItem
  local isLayout = UITipsCacheItem.IsLayout(msgData)
  if isLayout or #self.curShowItemList <= 2 then
    cacheItem = self._cacheItemPool:GetOne()
  else
    cacheItem = table.remove(self.curShowItemList, 1)
  end
  if isLayout then
    cacheItem.transform:SetParent(self.ui.LayoutParent)
  else
    cacheItem.transform:SetParent(self.ui.NormalParent)
  end
  cacheItem:InitTipsCacheItem(msgData, self)
  table.insert(self.curShowItemList, cacheItem)
  self._lastItem = cacheItem
end

function UIMessageSide:__OnCoroutinePlay()
  while #self.msgDataList > 0 and self:IsCanStart() do
    local msgData = table.remove(self.msgDataList, 1)
    self:_ShowCacheItem(msgData)
  end
  if self:IsCanStart() and 0 < #self.curShowItemList then
    local cacheItem = table.remove(self.curShowItemList, 1)
    self._cacheItemPool:HideOne(cacheItem)
  end
  if 0 >= #self.curShowItemList then
    self:Delete()
  end
end

function UIMessageSide:IsCanStart()
  return self._lastItem == nil or self._lastItem.curState == eCacheState.Useless
end

function UIMessageSide:OnDelete()
  UpdateManager:RemoveFixedUpdate(self.__update__handle)
  self._cacheItemPool:DeleteAll()
  base.OnDelete(self)
end

return UIMessageSide
