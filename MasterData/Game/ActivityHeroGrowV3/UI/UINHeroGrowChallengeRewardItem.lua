local UINHeroGrowChallengeRewardItem = class("UINHeroGrowChallengeRewardItem", UIBaseNode)
local base = UIBaseNode
local TaskEnum = require("Game.Task.TaskEnum")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType

function UINHeroGrowChallengeRewardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Item, self, self.OnClick)
end

function UINHeroGrowChallengeRewardItem:InitPeroidItem(data, eTaskState, clickFunc)
  self.data = data
  self._clickFunc = clickFunc
  local point = data.achiveCfg.need_socre
  self.eTaskState = eTaskState
  self.ui.tex_Point.text = tostring(point)
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
  local rewardIds = {}
  local rewardNums = {}
  for id, num in pairs(self.data.achiveCfg.level_reward) do
    table.insert(rewardIds, id)
    table.insert(rewardNums, num)
  end
  self.data.rewardIds = rewardIds
  self.data.rewardNums = rewardNums
  self.level = self.data.achiveCfg.level
end

function UINHeroGrowChallengeRewardItem:OnClick()
  if self._clickFunc ~= nil then
    self._clickFunc(self)
  end
end

function UINHeroGrowChallengeRewardItem:SetViewState(bool)
  if self.active == false then
    return
  end
  self.ui.obj_viewState:SetActive(bool)
  if self.isPicked then
    self.ui.obj_isPicked:SetActive(not bool)
  end
end

function UINHeroGrowChallengeRewardItem:SetRedDotActive(bool)
  self.ui.obj_redDot:SetActive(bool)
end

function UINHeroGrowChallengeRewardItem:OnDelete()
  base.OnDelete(self)
end

return UINHeroGrowChallengeRewardItem
