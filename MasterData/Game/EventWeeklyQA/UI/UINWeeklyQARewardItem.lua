local UINWeeklyQARewardItem = class("UINWeeklyQARewardItem", UIBaseNode)
local base = UIBaseNode
local EventWeeklyQAQuestionRewardData = require("Game.EventWeeklyQA.Data.EventWeeklyQAQuestionRewardData")

function UINWeeklyQARewardItem:OnInit()
  self.isPicking = false
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.rewardItem, self, self.__OnBtnClick)
end

function UINWeeklyQARewardItem:InitWeeklyQARewardItem(index, state, pointCount, onClickFunc)
  self.index = index
  self.state = state
  self.onClickFunc = onClickFunc
  self.ui.tex_Point:SetIndex(0, tostring(pointCount))
  self.ui.obj_viewState:SetActive(false)
  self.ui.obj_isPicked:SetActive(false)
  self.ui.obj_canRecive:SetActive(false)
  self:__RefreshItemStateUI()
end

function UINWeeklyQARewardItem:__RefreshItemStateUI()
  self.ui.rewardStateImg:SetIndex(self.state == EventWeeklyQAQuestionRewardData.eRewardState.Picked and 1 or 0)
  self.ui.img_ring.color = self.ui.stateColor[self.state + 1]
  local isCompleted = self.state == EventWeeklyQAQuestionRewardData.eRewardState.CompleteNoPicked
  self.isPicked = self.state == EventWeeklyQAQuestionRewardData.eRewardState.Picked
  self.ui.fx_go:SetActive(isCompleted)
  self.ui.obj_canRecive:SetActive(isCompleted)
  self.ui.obj_completed:SetActive(self.isPicked)
  self.ui.obj_isPicked:SetActive(self.isPicked)
end

function UINWeeklyQARewardItem:SetPicking(flag)
  self.isPicking = flag
end

function UINWeeklyQARewardItem:SetViewState(active)
  self.ui.obj_viewState:SetActive(active)
  if self.isPicked then
    self.ui.obj_isPicked:SetActive(not active)
  end
end

function UINWeeklyQARewardItem:__OnBtnClick()
  if self.isPicking then
    return
  end
  if self.onClickFunc then
    self.onClickFunc(self, self.index)
  end
end

function UINWeeklyQARewardItem:OnDelete()
  base.OnDelete(self)
end

return UINWeeklyQARewardItem
