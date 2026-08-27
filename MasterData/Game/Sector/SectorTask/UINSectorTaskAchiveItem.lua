local UINSectorTaskAchiveItem = class("UINSectorTaskAchiveItem", UIBaseNode)
local base = UIBaseNode
local TaskEnum = require("Game.Task.TaskEnum")

function UINSectorTaskAchiveItem:OnInit()
  self.isPicking = false
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.rewardItem, self, self.__OnBtnClick)
end

function UINSectorTaskAchiveItem:InitSectorTaskAchiveItem(index, state, iconIndex, pointCount, onClickFunc)
  self.index = index
  self.state = state
  self.onClickFunc = onClickFunc
  self.ui.tex_Point.text = tostring(pointCount)
  self.ui.imgInfo_Icon:SetIndex(iconIndex)
  self.ui.obj_viewState:SetActive(false)
  self.ui.obj_isPicked:SetActive(false)
  self.ui.obj_redDot:SetActive(false)
  self:__RefreshItemStateUI()
end

function UINSectorTaskAchiveItem:__RefreshItemStateUI()
  self.ui.rewardStateImg:SetIndex(self.state == TaskEnum.eTaskState.Picked and 1 or 0)
  self.ui.tex_Point.color = self.ui.stateColor[self.state]
  self.ui.img_Point.color = self.ui.stateColor[self.state]
  local isCompleted = self.state == TaskEnum.eTaskState.Completed
  self.isPicked = self.state == TaskEnum.eTaskState.Picked
  self.ui.fx_go:SetActive(isCompleted)
  self.ui.obj_redDot:SetActive(isCompleted)
  self.ui.obj_isPicked:SetActive(self.isPicked)
end

function UINSectorTaskAchiveItem:SetPicking(flag)
  self.isPicking = flag
end

function UINSectorTaskAchiveItem:SetViewState(active)
  self.ui.obj_viewState:SetActive(active)
  if self.isPicked then
    self.ui.obj_isPicked:SetActive(not active)
  end
end

function UINSectorTaskAchiveItem:__OnBtnClick()
  if self.isPicking then
    return
  end
  if self.onClickFunc then
    self.onClickFunc(self, self.index)
  end
end

function UINSectorTaskAchiveItem:OnDelete()
  base.OnDelete(self)
end

return UINSectorTaskAchiveItem
