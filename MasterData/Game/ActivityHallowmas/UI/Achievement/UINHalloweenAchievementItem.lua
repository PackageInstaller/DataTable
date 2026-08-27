local UINHalloweenAchievementItem = class("UINHalloweenAchievementItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINHalloweenAchievementItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.obj_Get, self, self.OnClickComplete)
  self._starList = {
    self.ui.starItem
  }
  self._itemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithReceived)
  self.ui.uINBaseItemWithReceived:SetActive(false)
end

function UINHalloweenAchievementItem:InitAchieventItem(taskData, star, callback)
  self._task = taskData
  self._callback = callback
  self:__RefreshFixed(star)
  self:RefreshTaskUI()
end

function UINHalloweenAchievementItem:__RefreshFixed(star)
  local count = #self._starList
  for i = 1, count do
    local starItem = self._starList[i]
    starItem:SetActive(i <= star)
  end
  for i = count + 1, star do
    local starItem = self.ui.starItem:Instantiate()
    table.insert(self._starList, starItem)
    starItem:SetActive(true)
  end
  self.ui.tex_TitleName.text = self._task:GetTaskName()
  self.ui.tex_Des.text = self._task:GetTaskFirstStepIntro()
  self._itemPool:HideAll()
  local ids, nums = self._task:GetTaskCfgRewards()
  for i, id in ipairs(ids) do
    local num = nums[i]
    local itemCfg = ConfigData.item[id]
    local item = self._itemPool:GetOne()
    item:InitItemWithCount(itemCfg, num, nil, self._task.isPicked)
  end
end

function UINHalloweenAchievementItem:RefreshTaskUI()
  if self._task.isPicked then
    self.ui.obj_Progress:SetActive(false)
    self.ui.obj_Get.gameObject:SetActive(false)
    self.ui.obj_Completed:SetActive(true)
  elseif self._task:CheckComplete() then
    self.ui.obj_Progress:SetActive(false)
    self.ui.obj_Completed:SetActive(false)
    self.ui.obj_Get.gameObject:SetActive(true)
  else
    self.ui.obj_Completed:SetActive(false)
    self.ui.obj_Get.gameObject:SetActive(false)
    self.ui.obj_Progress:SetActive(true)
    local aim, schedule = self._task:GetTaskProcess()
    self.ui.tex_Progress:SetIndex(0, tostring(aim), tostring(schedule))
    self.ui.slider.value = aim / schedule
  end
end

function UINHalloweenAchievementItem:GetHallowAchieveTask()
  return self._task
end

function UINHalloweenAchievementItem:OnClickComplete()
  if self._callback ~= nil then
    self._callback(self._task)
  end
end

return UINHalloweenAchievementItem
