local UINTaskPeroidNodeItem = class("UINTaskPeroidNodeItem", UIBaseNode)
local base = UIBaseNode
local TaskEnum = require("Game.Task.TaskEnum")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType

function UINTaskPeroidNodeItem:OnInit()
  self.ctrl = ControllerManager:GetController(ControllerTypeId.Task)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.closeViewState = BindCallback(self, self.SetViewState, false)
  UIUtil.AddButtonListener(self.ui.btn_Item, self, self.OnClick)
end

function UINTaskPeroidNodeItem:InitPeroidItem(index, eTaskState, point, itemCfg, num, viewReward, data)
  self.data = data
  self.index = index
  self.eTaskState = eTaskState
  self.ui.tex_Point.text = tostring(point)
  self.viewReward = viewReward
  self.isPicked = eTaskState == TaskEnum.eTaskState.Picked
  local canPick = eTaskState == TaskEnum.eTaskState.Completed
  self.ui.obj_isPicked:SetActive(false)
  self.ui.obj_fx:SetActive(false)
  self:SetRedDotActive(false)
  self:SetViewState(false)
  self.ui.img_RewardState:SetIndex(eTaskState == TaskEnum.eTaskState.Picked and 1 or 0)
  self.ui.tex_Point.color = self.ui.stateColors[eTaskState]
  if eTaskState == TaskEnum.eTaskState.Completed then
    self:SetRedDotActive(true)
  elseif eTaskState == TaskEnum.eTaskState.Picked then
    self.ui.obj_isPicked:SetActive(true)
    self:SetRedDotActive(false)
  end
  if self.ui.obj_fx.activeInHierarchy ~= canPick then
    self.ui.obj_fx:SetActive(canPick)
  end
end

function UINTaskPeroidNodeItem:OnClick()
  if self.eTaskState == TaskEnum.eTaskState.Completed then
    self.ctrl:SendCommitTaskPeriod(self.index, self.ctrl.showingActiveType)
  else
    self.viewReward:Show()
    self.viewReward:FloatTo(self.transform, HAType.autoCenter, VAType.up)
    self.viewReward:RefreshItems(self.data.stcData.rewardIds, self.data.stcData.rewardNums, self.closeViewState)
    self:SetViewState(true)
    AudioManager:PlayAudioById(1055)
  end
end

function UINTaskPeroidNodeItem:SetViewState(bool)
  self.ui.obj_viewState:SetActive(bool)
  if self.isPicked then
    self.ui.obj_isPicked:SetActive(not bool)
  end
end

function UINTaskPeroidNodeItem:SetRedDotActive(bool)
  self.ui.obj_redDot:SetActive(bool)
end

function UINTaskPeroidNodeItem:OnDelete()
  base.OnDelete(self)
end

return UINTaskPeroidNodeItem
