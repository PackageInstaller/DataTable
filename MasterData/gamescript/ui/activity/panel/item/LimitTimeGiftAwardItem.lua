local LimitTimeGiftAwardItem, Super = System.NewComponent("LimitTimeGiftAwardItem")

function LimitTimeGiftAwardItem:ctor(gameObj, itemId, itemCount, taskId, preTaskId)
  Super.ctor(self)
  self.ui = UI_Events_Item_GiftBagAwardResource(gameObj)
  self.itemId = itemId
  self.itemCount = itemCount
  self.taskId = taskId
  self.preTaskId = preTaskId
end

function LimitTimeGiftAwardItem:OnBind(binder)
  self.binder = binder
  local itemData = {
    itemTid = self.itemId,
    itemCount = self.itemCount,
    clickFunc = function()
      ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.uiNode.transform.parent.gameObject, nil, self.itemId)
    end,
    lockFunc = function()
      if not self:IsPreTaskRewardGot() then
        return true
      end
      return not TaskDataUtils.IsTaskDoneByTaskId(self.taskId)
    end,
    isGotFunc = function()
      do return TaskDataUtils.TaskFinshAndGetedAward end
      return TaskDataUtils.TaskFinshAndGetedAward, self.taskId
    end,
    redFunc = function()
      do return self.IsCanGet end
      return self.IsCanGet, self
    end
  }
  self.binder:BindComponent(CommonIconItemType2(self.ui.UI_Common_Item_WuPin_Type2, itemData))
  self.binder:BindToRaw(function(_, isshowDarkEffect)
    self.ui.Dark_Effect:SetActive(isshowDarkEffect)
  end, function()
    local isCanGet = self:IsCanGet()
    local isBright = TaskDataUtils.GetTaskPrice(self.taskId) == nil
    return isCanGet and isBright
  end)
  self.binder:BindToRaw(function(_, isShowBrightEffect)
    self.ui.Bright_Effect:SetActive(isShowBrightEffect)
  end, function()
    local isGot = TaskDataUtils.TaskFinshAndGetedAward(self.taskId)
    local isPreTaskRewardGot = self:IsPreTaskRewardGot()
    return not isGot and isPreTaskRewardGot
  end)
end

function LimitTimeGiftAwardItem:IsPreTaskRewardGot()
  if not self.preTaskId then
    return true
  end
  do return TaskDataUtils.TaskFinshAndGetedAward end
  return TaskDataUtils.TaskFinshAndGetedAward, self.preTaskId
end

function LimitTimeGiftAwardItem:IsCanGet()
  if not self:IsPreTaskRewardGot() then
    return false
  end
  do return TaskDataUtils.IsTaskCanReward end
  return TaskDataUtils.IsTaskCanReward, self.taskId
end

return LimitTimeGiftAwardItem
