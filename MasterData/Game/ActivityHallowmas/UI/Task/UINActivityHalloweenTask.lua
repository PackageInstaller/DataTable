local UINActivityHalloweenTask = class("UINActivityHalloweenTask", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local CS_DOTweenAnimation = CS.DG.Tweening.DOTweenAnimation
local cs_Ease = CS.DG.Tweening.Ease

function UINActivityHalloweenTask:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Refresh, self, self.OnClickRefreshTask)
  UIUtil.AddButtonListener(self.ui.btn_Jump, self, self.OnClickConfirm)
  self._rewardPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithReceived)
  self.ui.uINBaseItemWithReceived:SetActive(false)
end

function UINActivityHalloweenTask:InitHalloweenTask(taskId, refreshFunc, rewardFunc, jumpFunc)
  self:ShowHalloweenTween()
  self._taskId = taskId
  self._taskData = PlayerDataCenter.allTaskData:GetTaskDataById(self._taskId, true)
  self._refreshFunc = refreshFunc
  self._rewardFunc = rewardFunc
  self._jumpFunc = jumpFunc
  self:__RefreshFix()
  self:RefreshHalloweenTask()
end

function UINActivityHalloweenTask:__RefreshFix()
  self.ui.tex_Des.text = self._taskData:GetTaskFirstStepIntro()
  self._rewardPool:HideAll()
  local ids, nums = self._taskData:GetTaskCfgRewards()
  for i, rewardId in ipairs(ids) do
    local rewardNum = nums[i]
    local itemCfg = ConfigData.item[rewardId]
    local item = self._rewardPool:GetOne()
    item:InitItemWithCount(itemCfg, rewardNum)
  end
end

function UINActivityHalloweenTask:RefreshHalloweenTaskPicked()
  self._taskData = PlayerDataCenter.allTaskData:GetTaskDataById(self._taskId, true)
  self:RefreshHalloweenTask()
end

function UINActivityHalloweenTask:RefreshHalloweenTask()
  local schedule, aim = self._taskData:GetTaskProcess()
  self.ui.fill.fillAmount = schedule / aim
  self.ui.tex_Num.text = tostring(schedule) .. "/" .. tostring(aim)
  for i, v in ipairs(self._rewardPool.listItem) do
    v:SetPickedUIActive(self._taskData.isPicked)
  end
  if not self._taskData.isPicked then
    local isComplete = self._taskData:CheckComplete()
    self.ui.img_Clear.gameObject:SetActive(isComplete)
    if isComplete then
      self.ui.img_Jump:SetIndex(1)
      self.ui.tex_Jump:SetIndex(1)
      self.ui.btn_Jump.gameObject:SetActive(true)
    elseif 0 < (self._taskData.stcData.jump_id or 0) then
      self.ui.img_Jump:SetIndex(0)
      self.ui.tex_Jump:SetIndex(0)
      self.ui.btn_Jump.gameObject:SetActive(true)
    else
      self.ui.btn_Jump.gameObject:SetActive(false)
    end
  else
    self.ui.btn_Jump.gameObject:SetActive(false)
    self.ui.img_Clear.gameObject:SetActive(true)
  end
end

function UINActivityHalloweenTask:RefreshHalloweenRefBtn(flag)
  flag = flag and not self._taskData.isPicked and not self._taskData:CheckComplete()
  self.ui.btn_Refresh.gameObject:SetActive(flag)
end

function UINActivityHalloweenTask:SetHalloweenGhost(index)
  self._index = index
  self.ui.img_Ghost:SetIndex(index - 1)
end

function UINActivityHalloweenTask:GetHalloweenGhost()
  return self._index
end

function UINActivityHalloweenTask:OnClickRefreshTask()
  if self._refreshFunc ~= nil then
    self._refreshFunc(self._taskData, self)
  end
end

function UINActivityHalloweenTask:ShowHalloweenTween()
  self.ui.item.alpha = 1
  self.ui.img_Clear.transform.localScale = Vector3.one
  local color = self.ui.img_Clear.color
  color.a = 1
  self.ui.img_Clear.color = color
  self.ui.img_Ghost.transform.localRotation = Quaternion.Euler(0, 0, 0)
  color = self.ui.img_Ghost.image.color
  color.a = 1
  self.ui.img_Ghost.image.color = color
  self.transform:DOMoveY(-100, 0.5):From():SetEase(cs_Ease.OutQuart):SetRelative(true)
  self.ui.item:DOFade(0, 0.5):From():SetEase(cs_Ease.OutQuart)
  self.ui.img_Clear.transform:DOScale(Vector3.New(2, 2, 2), 0.5):From():SetEase(cs_Ease.InQuart)
  self.ui.img_Clear:DOFade(0, 0.5):From():SetEase(cs_Ease.OutQuart)
  self.ui.img_Ghost.image:DOFade(0, 0.5):From():SetEase(cs_Ease.OutQuart)
  self.ui.img_Ghost.transform:DORotateQuaternion(Quaternion.Euler(0, 0, 30), 0.5):From():SetEase(cs_Ease.InOutSine)
end

function UINActivityHalloweenTask:HideHalloweenTween(callback)
  self.transform:DOMoveY(20, 0.5)
  self.ui.item:DOFade(0, 0.5):OnComplete(callback)
end

function UINActivityHalloweenTask:OnClickConfirm()
  if self._taskData:CheckComplete() then
    if self._rewardFunc ~= nil then
      self._rewardFunc(self._taskData, self)
    end
  elseif not self._taskData.isPicked and self._jumpFunc ~= nil then
    self._jumpFunc(self._taskData)
  end
end

function UINActivityHalloweenTask:GetHalloweenTaskId()
  return self._taskId
end

return UINActivityHalloweenTask
