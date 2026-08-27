local UINActSum22TaskItem = class("UINActSum22TaskItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local JumpManager = require("Game.Jump.JumpManager")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")

function UINActSum22TaskItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Refresh, self, self.OnClickRefresh)
  UIUtil.AddButtonListener(self.ui.btn_Receive, self, self.OnClickReward)
  UIUtil.AddButtonListener(self.ui.btn_Jump, self, self.OnClickJump)
  self._rewardPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItemWithCount)
  self.ui.uINBaseItemWithCount:SetActive(false)
end

function UINActSum22TaskItem:InitSum22TaskItem(index, sum22Data, rewardCallback, refreshCallback)
  self._index = index
  self._rewardCallback = rewardCallback
  self._refreshCallback = refreshCallback
  self._sum22Data = sum22Data
  self.ui.tex_TaskNo:SetIndex(0, tostring(self._index))
end

function UINActSum22TaskItem:Refresh22TaskItem(taskData)
  self._taskData = taskData
  if self._taskData == nil then
    self:__RefreshUnlock()
  else
    self:__RefreshTask()
  end
end

function UINActSum22TaskItem:__RefreshUnlock()
  self.ui.titleBg.color = self.ui.color_titles[3]
  self.ui.bottom.color = self.ui.color_bottoms[3]
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(ConfigData:GetTipContent(7128))
  self.ui.dot5.color = self.ui.color_titles[3]
  self.ui.tex_TaskNo.text.color = self.ui.color_titles[3]
  self.ui.tex_Des.color = self.ui.color_titles[3]
  if self._color_3_extra == nil then
    local color = self.ui.color_titles[3]
    self._color_3_extra = Color.New(color.r, color.g, color.b, 0.5)
  end
  self.ui.icon1.color = self._color_3_extra
  self.ui.icon2.color = self._color_3_extra
  self.ui.btn_Refresh.gameObject:SetActive(false)
  self.ui.slider.gameObject:SetActive(false)
  self.ui.tex_Progress.gameObject:SetActive(false)
  self._rewardPool:HideAll()
  self.ui.btn_Receive.gameObject:SetActive(false)
  self.ui.btn_Jump.gameObject:SetActive(false)
  self.ui.unLock:SetActive(true)
end

function UINActSum22TaskItem:__RefreshTask()
  self.ui.dot5.color = Color.white
  self.ui.tex_TaskNo.text.color = Color.white
  self.ui.tex_Des.color = Color.white
  self.ui.icon1.color = Color.white
  self.ui.icon2.color = Color.white
  self.ui.unLock:SetActive(false)
  self.ui.tex_Des.text = self._taskData:GetTaskFirstStepIntro()
  self._rewardPool:HideAll()
  local rewardIds, rewardCounts = self._taskData:GetTaskCfgRewards()
  for index, itemId in ipairs(rewardIds) do
    local count = rewardCounts[index]
    local item = self._rewardPool:GetOne()
    item:InitItemWithCount(ConfigData.item[itemId], count)
  end
  local refreshTimes, maxTimes = self._sum22Data:GetSectorIIITaskRefTimes()
  self.ui.slider.gameObject:SetActive(true)
  self.ui.tex_Progress.gameObject:SetActive(true)
  local isComplete = self._taskData:CheckComplete()
  if isComplete then
    local schedule, aim = self._taskData:GetTaskProcess()
    self.ui.slider.value = 1
    self.ui.tex_Progress:SetIndex(0, tostring(aim), tostring(aim))
    self.ui.btn_Jump.gameObject:SetActive(false)
    self.ui.btn_Receive.gameObject:SetActive(true)
    self.ui.titleBg.color = self.ui.color_titles[1]
    self.ui.bottom.color = self.ui.color_bottoms[1]
    self.ui.btn_Refresh.gameObject:SetActive(false)
  else
    local schedule, aim = self._taskData:GetTaskProcess()
    self.ui.slider.value = schedule / aim
    self.ui.tex_Progress:SetIndex(0, tostring(schedule), tostring(aim))
    self.ui.btn_Jump.gameObject:SetActive(0 < self._taskData.stcData.jump_id)
    self.ui.btn_Receive.gameObject:SetActive(false)
    self.ui.titleBg.color = self.ui.color_titles[2]
    self.ui.bottom.color = self.ui.color_bottoms[2]
    self.ui.btn_Refresh.gameObject:SetActive(refreshTimes < maxTimes)
  end
end

function UINActSum22TaskItem:OnClickRefresh()
  if self._refreshCallback ~= nil then
    self._refreshCallback(self._taskData)
  end
end

function UINActSum22TaskItem:OnClickReward()
  if self._rewardCallback ~= nil then
    local rewardIds, rewardCounts = self._taskData:GetTaskCfgRewards()
    local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardCounts)
    local window = UIManager:GetWindow(UIWindowTypeID.CommonReward)
    if window ~= nil then
      window:Hide()
      window:Show()
      window:AddAndTryShowReward(CRData)
    else
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
        if window == nil then
          return
        end
        window:AddAndTryShowReward(CRData)
      end)
    end
    self._rewardCallback(self._taskData)
  end
end

function UINActSum22TaskItem:OnClickJump()
  local stcData = self._taskData.stcData
  if stcData.jump_id > 0 then
    JumpManager:Jump(stcData.jump_id, nil, nil, stcData.jumpArgs)
  end
end

return UINActSum22TaskItem
