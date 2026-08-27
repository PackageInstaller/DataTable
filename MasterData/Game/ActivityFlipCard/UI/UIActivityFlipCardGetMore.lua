local UIActivityFlipCardGetMore = class("UIActivityFlipCardGetMore", UIBaseWindow)
local base = UIBaseWindow
local UIActivityFlipCardGiftItem = require("Game.ActivityFlipCard.UI.UINActivityFlipCardGiftItem")

function UIActivityFlipCardGetMore:OnInit()
  UIUtil.SetTopStatus(self, self.OnCloseFlipCardGetMore, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_close, self, self.OnCloseFlipCardGetMore)
  self.__OnClickGoCallback = BindCallback(self, self.OnClickGoCallback)
  self.__CommitTaskCallback = BindCallback(self, self.RefreshTaskItem)
  self._itemPool = UIItemPool.New(UIActivityFlipCardGiftItem, self.ui.obj_giftNode)
  self.ui.obj_giftNode:SetActive(false)
  self.resloader = CS.ResLoader.Create()
end

function UIActivityFlipCardGetMore:InitFlipCardGetMore(actID, actFrameID)
  UIUtil.SetCurButtonGroupActive(false)
  UIUtil.RefreshTopResId({
    ConstGlobalItem.PaidQZ
  })
  self.actID = actID
  local cfg = ConfigData.activity_flipcards_main[actID]
  if cfg == nil then
    return
  end
  local gitIds = cfg.gift_type
  self.actFrameID = actFrameID
  self._itemPool:HideAll()
  self.taskItem = self._itemPool:GetOne()
  self:RefreshTaskItem()
  local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift)
  if payGiftCtrl ~= nil then
    for k, v in pairs(gitIds) do
      local giftId = v
      local giftInfo = payGiftCtrl:GetPayGiftDataById(giftId)
      if giftInfo ~= nil and giftInfo:IsUnlock() then
        local giftItem = self._itemPool:GetOne()
        giftItem:InitFlipCardGiftItemWithGiftData(giftInfo, self.__OnClickGoCallback, self.resloader)
        giftItem:PlayFlipCardGetMoreCardInitTween(k)
      end
    end
    self.taskItem:PlayFlipCardGetMoreCardInitTween(0)
  end
end

function UIActivityFlipCardGetMore:OnClickGoCallback(isTask, giftData)
  if isTask then
    UIManager:ShowWindowAsync(UIWindowTypeID.ActivityFlipCardTask, function(window)
      if window == nil then
        return
      end
      local taskIds = ConfigData.activity_general[self.actFrameID].once_quest
      window:InitFlipCardTask(taskIds, nil, self.__CommitTaskCallback)
      window:SetChristmasEnvTaskTitle(ConfigData:GetTipContent(9711))
    end)
  else
    local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift)
    payGiftCtrl:SendBuyGifitInfo(giftData, nil, function()
      self:RefreshGiftItem(giftData)
    end, true)
  end
end

function UIActivityFlipCardGetMore:RefreshTaskItem()
  if self.taskItem == nil then
    return
  end
  local taskIds = ConfigData.activity_general[self.actFrameID].once_quest
  local totalCount = 0
  local finishCount = 0
  for _, taskId in pairs(taskIds) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
    totalCount = totalCount + 1
    if taskData.isPicked then
      finishCount = finishCount + 1
    end
  end
  self.taskItem:InitFlipCardGiftItemWithTask(finishCount, totalCount, self.__OnClickGoCallback, self.resloader)
end

function UIActivityFlipCardGetMore:RefreshGiftItem(giftData)
  local items = self._itemPool.listItem
  for k, v in pairs(items) do
    if v.giftData == giftData then
      v:InitFlipCardGiftItemWithGiftData(giftData, self.__OnClickGoCallback, self.resloader)
      break
    end
  end
end

function UIActivityFlipCardGetMore:OnCloseFlipCardGetMore()
  self:Delete()
end

function UIActivityFlipCardGetMore:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self._itemPool:DeleteAll()
  self.taskItem = nil
  base.OnDelete(self)
end

return UIActivityFlipCardGetMore
