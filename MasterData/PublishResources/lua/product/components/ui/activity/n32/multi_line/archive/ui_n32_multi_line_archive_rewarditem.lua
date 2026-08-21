_class("UIN32MultiLineArchiveRewardItem", UICustomWidget)
UIN32MultiLineArchiveRewardItem = UIN32MultiLineArchiveRewardItem

function UIN32MultiLineArchiveRewardItem:OnShow(uiParams)
  self:InitComponent()
  self:InitUI()
end

function UIN32MultiLineArchiveRewardItem:InitComponent()
  self._item = self:GetUIComponent("UISelectObjectPath", "item")
  self._done = self:GetGameObject("done")
end

function UIN32MultiLineArchiveRewardItem:InitUI()
  self._done:SetActive(false)
  self._itemWidget = self._item:SpawnObject("UIN32MultiLineUIItem")
end

function UIN32MultiLineArchiveRewardItem:Refresh()
end

function UIN32MultiLineArchiveRewardItem:SetData(index, item, received, callBack)
  self._index = index
  self._callBack = callBack
  local rew = {}
  rew.assetid = item[1]
  rew.count = item[2]
  self._received = received
  self._done:SetActive(self._received)
  self._itemWidget:Flush(rew, function()
    self._callBack(rew, self.view.gameObject)
  end)
end
