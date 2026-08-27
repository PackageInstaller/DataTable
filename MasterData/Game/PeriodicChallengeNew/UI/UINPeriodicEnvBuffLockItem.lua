local UINPeriodicEnvBuffLockItem = class("UINPeriodicEnvBuffLockItem", UIBaseNode)
local base = UIBaseNode

function UINPeriodicEnvBuffLockItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.debuffSelectItem, self, self.OnClickBuffItem)
  UIUtil.AddButtonListener(self.ui.btn_UnLock, self, self.OnClickTaskUnlock)
end

function UINPeriodicEnvBuffLockItem:InitDebuffItem(buffId, originBuffCfg, selectFunc, isSelected, resloader)
  self.buffId = buffId
  self.originBuffCfg = originBuffCfg
  self.permillage = self.originBuffCfg.inifinite_coe
  self.taskId = self.originBuffCfg.unlock_task
  self.selectFunc = selectFunc
  self.buffCfg = ConfigData.exploration_buff[self.buffId]
  if self.buffCfg == nil then
    error("不存在的 buff, id is " .. tostring(self.buffId))
    return
  end
  self.ui.img_Icon.sprite = CRH:GetSprite(self.buffCfg.icon, CommonAtlasType.ExplorationIcon)
  self.buffType = self.buffCfg.buff_type
  if self.taskId ~= 0 then
    self.taskData = PlayerDataCenter.allTaskData:GetTaskDataById(self.taskId, true)
  end
  self:RefreshItemShow()
  self:ChangeState(isSelected, false)
end

function UINPeriodicEnvBuffLockItem:RefreshItemShow()
  if self.taskData ~= nil and not self.taskData:IsPickedTaskReward() then
    self:RefreshTaskShow()
  else
    self:RefreshNormalShow()
  end
end

function UINPeriodicEnvBuffLockItem:RefreshTaskShow()
  local schedule, aim = self.taskData:GetTaskProcess()
  self.ui.img_Select.gameObject:SetActive(false)
  self.ui.obj_lockBottom:SetActive(true)
  self.ui.tex_Desc.text = string.format("%s(%d/%d)", self.taskData:GetTaskFirstStepIntro(), schedule, aim)
  local isFinish = self.taskData:CheckComplete()
  self.ui.obj_UnLock:SetActive(isFinish)
  self.ui.obj_Lock:SetActive(not isFinish)
end

function UINPeriodicEnvBuffLockItem:RefreshNormalShow()
  self.ui.tex_Desc.text = LanguageUtil.GetLocaleText(self.buffCfg.describe)
  self.ui.img_Select.gameObject:SetActive(true)
  self.ui.obj_lockBottom:SetActive(false)
  self.ui.tex_Permillage.text = tostring(Mathf.Floor(self.permillage)) .. "%"
end

function UINPeriodicEnvBuffLockItem:ChangeState(isSelected, isForbid)
  self.isSelected = isSelected
  if isForbid then
    self.ui.img_Select:SetIndex(4)
  elseif not self.isSelected then
    self.ui.img_Select:SetIndex(0)
  elseif 0 > self.permillage then
    self.ui.img_Select:SetIndex(3)
  elseif 0 < self.permillage then
    self.ui.img_Select:SetIndex(1)
  else
    self.ui.img_Select:SetIndex(2)
  end
end

function UINPeriodicEnvBuffLockItem:UnlockBuffItem()
  if self.taskId ~= 0 then
    self.taskData = PlayerDataCenter.allTaskData:GetTaskDataById(self.taskId, true)
  end
  self:RefreshNormalShow()
end

function UINPeriodicEnvBuffLockItem:OnClickTaskUnlock()
  if self.taskData == nil then
    return
  end
  local taskCtrl = ControllerManager:GetController(ControllerTypeId.Task)
  taskCtrl:SendCommitQuestReward(self.taskData, false, BindCallback(self, self.UnlockBuffItem))
end

function UINPeriodicEnvBuffLockItem:OnClickBuffItem()
  if self.taskData ~= nil and not self.taskData:IsPickedTaskReward() then
    return
  end
  if self.selectFunc ~= nil then
    self.selectFunc(self.buffId, not self.isSelected)
  end
end

return UINPeriodicEnvBuffLockItem
