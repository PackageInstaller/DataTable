local item = class("cellActivityRewardItem", G_UIModuleBase)

function item.bind()
  return {
    activityReward = "",
    activityNoActive = "",
    canReward = false,
    isFinish = false,
    noFinish = true,
    isActiveNum = false,
    noActive = true,
    rewardList = {
      moduleName = "pages/ActivityTask/cellStatusRewardItem"
    },
    activeDotLine = 0,
    show_point = false,
    pointAnchorPos = L_Vector3.zero,
    show_rewardPreview = false
  }
end

function item.methods()
  return {
    onClick = function(self)
      if self.bind.activityRewardId ~= nil then
        self:emit("onClick_getReward", self.bind)
      end
    end,
    onClick_previewReward_finish = function(self)
      if self.bind.canReward then
        return
      end
      self:emit("onClick_rewardPreview", not self.bind.show_rewardPreview)
      self.bind.show_rewardPreview = not self.bind.show_rewardPreview
      if self.bind.show_rewardPreview then
        self:OpenRewardPreview()
      end
    end,
    onClick_previewReward_nofinish = function(self)
      if self.bind.canReward then
        return
      end
      self:emit("onClick_rewardPreview", not self.bind.show_rewardPreview)
      self.bind.show_rewardPreview = not self.bind.show_rewardPreview
      if self.bind.show_rewardPreview then
        self:OpenRewardPreview()
      end
    end
  }
end

function item:open(...)
  self:init()
end

function item:close()
  if self.activityTween then
    self.activityTween:Kill()
    local gap = self.bind.requireActivity - self.bind.lastActivity
    local offset = self.bind.curTotalActivity - self.bind.lastActivity
    self.bind.activeDotLine = offset <= 0 and 0 or math.clamp(offset / gap, 0, 1)
    self.activityTween = nil
  end
end

function item:init()
  self.bind.noFinish = self.bind.isFinish ~= true and self.bind.canReward ~= true
  self.bind.isActiveNum = self.bind.isActive == true and true or false
  self.bind.activityNoActive = self.bind.activityReward
  self.startDotLine = 0
  self.bind.noActive = true
  self.bind.show_rewardPreview = false
  if self.bind.curTotalActivity < self.bind.requireActivity then
    local gap = self.bind.requireActivity - self.bind.lastActivity
    local offset = self.bind.curTotalActivity - self.bind.lastActivity
    self.bind.activeDotLine = offset <= 0 and 0 or math.clamp(offset / gap, 0, 1)
    self.startDotLine = self.bind.activeDotLine
    self.bind.show_point = 0 < offset and true or false
    if self.bind.show_point then
      local size = self.bindComponents.dotLineTrans.sizeDelta.x
      self.bind.pointAnchorPos = L_Vector3.new(size * self.bind.activeDotLine, 0, 0)
    end
  else
    self.bind.activeDotLine = 1
    self.startDotLine = self.bind.activeDotLine
    self.bind.show_point = false
  end
end

function item:refresh()
  self:init()
  if self.bind.reward then
    local base_data = {}
    self.bind.rewardList:clear()
    local rewardData = L_DataUtil.parseRewardConfig(self.bind.reward)
    for i, v in ipairs(rewardData) do
      table.insert(base_data, {
        itemId = v.itemId,
        itemType = v.itemType,
        itemNum = v.itemNum,
        isFinish = self.bind.isFinish
      })
    end
    self.bind.rewardList:insert_array(base_data)
  end
end

function item:dotLineTween()
  local gap = self.bind.requireActivity - self.bind.lastActivity
  local offset = self.bind.curTotalActivity - self.bind.lastActivity
  local targetActivity = offset <= 0 and 0 or math.clamp(offset / gap, 0, 1)
  if self.activityTween then
    self.activityTween:Kill()
    self.startDotLine = targetActivity
    self.bind.activeDotLine = targetActivity
  end
  
  local function getter()
    return self.startDotLine
  end
  
  local function setter(v)
    self.bind.activeDotLine = v
    if self.bind.show_point then
      self.bind.pointAnchorPos = L_Vector3.new(v * self.bindComponents.dotLineTrans.sizeDelta.x, 0, 0)
      if 1 <= v then
        self.bind.show_point = false
      end
    end
  end
  
  self.activityTween = DOTween.To(getter, setter, targetActivity, 0.15):SetEase(Tweening.Ease.Linear):OnComplete(function()
    self.startDotLine = targetActivity
  end)
  self.activityTween:SetAutoKill(true)
  self.activityTween:Play()
end

function item:isVisibleTween()
  if self.bindComponents == nil then
    return false
  end
  if self.startDotLine >= 1 or 1 <= self.bind.activeDotLine then
    return false
  end
  local gap = self.bind.requireActivity - self.bind.lastActivity
  local offset = self.bind.curTotalActivity - self.bind.lastActivity
  local targetActivity = offset <= 0 and 0 or math.clamp(offset / gap, 0, 1)
  local offset = targetActivity - self.startDotLine
  if 0 < offset then
    return true
  end
  return false
end

function item:OpenRewardPreview()
  self:emit("onOpen_rewardPreview", self.bindComponents.active_tips)
end

return item
