local ColorType = CommonDefine.ColorType
local WeekBossToggleItem, Super = NewViewComponent("WeekBossToggleItem")

function WeekBossToggleItem:ctor(uiNode, view, viewData)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dungeons_Item_Common_ElementResource(uiNode)
  self.viewData = viewData
  self.index = viewData.index
  self.stageGroupId = viewData.stageGroupId
  self.stageGroupCfg = DT.StageGroup[self.stageGroupId] or {}
  self.isSelected = nil
end

function WeekBossToggleItem:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnWeekBossStageGroupId, self.OnWeekBossStageGroupId, self)
end

function WeekBossToggleItem:RegisterEvents()
end

function WeekBossToggleItem:OnEnterComponent()
  self:AddButtonClickListener(self.ui.Btn_Click, function()
    WeekBossExtModel.Instance:SetSelectedStageGroupId(self.stageGroupId)
    WeekBossController.Instance:RemoveRed(self.stageGroupId)
  end)
  self:SetTitle()
  self:SetUnlocked()
  self:SetIcon()
  self:SetDoubleAct()
  self:SetIsSelected(WeekBossExtModel.Instance:IsSelected(self.stageGroupId))
  self:SetRedPoint()
end

function WeekBossToggleItem:OnExitComponent()
  Super.OnExitComponent(self)
end

function WeekBossToggleItem:OnWeekBossStageGroupId(stageGroupId)
  local isSelected = stageGroupId == self.stageGroupId
  self:SetIsSelected(isSelected)
end

function WeekBossToggleItem:SetRedPoint()
  self:AddViewComponentOnce(self.ui.Com_RedDot, UICompRedDot, CommonDefine.RedDotType.TextNew, nil, function()
    do return WeekBossExtModel.Instance.IsShowRed, WeekBossExtModel.Instance end
    return WeekBossExtModel.Instance.IsShowRed, WeekBossExtModel.Instance, self.stageGroupId
  end)
end

function WeekBossToggleItem:SetIsSelected(isSelected)
  if self.isSelected == isSelected then
    return
  end
  self.isSelected = isSelected
  self.ui.Group_Select:SetActive(isSelected)
end

function WeekBossToggleItem:SetTitle()
  local title = self.stageGroupCfg.Name
  self:SetText(self.ui.Text_Title, title)
end

function WeekBossToggleItem:SetUnlocked()
  local unlocked = WeekBossExtModel.Instance:IsUnlocked(self.stageGroupId)
  self.ui.Group_Mask:SetActive(not unlocked)
  self.ui.Group_Nor:SetActive(unlocked)
  self.ui.Image_D_Bg:SetActive(unlocked)
  self.ui.Image_D_Icon:SetActive(unlocked)
  if unlocked then
    self:SetText(self.ui.Text_Tip, self.stageGroupCfg.StageGroupRewardDescription)
  else
    local unlockTips = WeekBossExtModel.Instance:GetUnlockTips(self.stageGroupId)
    self:SetText(self.ui.Text_Tip, unlockTips)
  end
  local textColor = unlocked and ColorType.Light or ColorType.Dark
  self:SetTextColorType(self.ui.Text_Tip, textColor)
  self:SetTextColorType(self.ui.Text_Title, textColor)
end

function WeekBossToggleItem:SetIcon()
  local icon = self.stageGroupCfg.DailyIcon and self.stageGroupCfg.DailyIcon[1]
  local searchString = "Untie"
  local replaceWith = "Not"
  local imageGrey = string.gsub(icon, searchString, replaceWith)
  if icon then
    self:SetImage(self.ui.Image_Mask_Icon, imageGrey)
    self:SetImage(self.ui.Image_D_Icon, icon)
  end
end

function WeekBossToggleItem:SetDoubleAct()
  local isInDoubleAct = WeekBossExtModel.Instance:IsInDoubleAct(self.stageGroupId)
  self.ui.Image_Award:SetActive(isInDoubleAct)
end

return WeekBossToggleItem
