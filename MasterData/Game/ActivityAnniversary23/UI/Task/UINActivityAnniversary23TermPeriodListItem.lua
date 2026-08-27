local UINActivityAnniversary23TermPeriodListItem = class("UINActivityAnniversary23TermPeriodListItem", UIBaseNode)
local base = UIBaseNode
local TaskEnum = require("Game.Task.TaskEnum")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType

function UINActivityAnniversary23TermPeriodListItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.closeViewState = BindCallback(self, self.SetViewState, false)
  UIUtil.AddButtonListener(self.ui.btn_Item, self, self.OnClick)
end

function UINActivityAnniversary23TermPeriodListItem:InitPeroidItem(data, actLongId, viewReward, eTaskState, unlockFunc)
  self.actLongId = actLongId
  self.data = data
  self._unlockFunc = unlockFunc
  local point = data.point
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
  local rewardIds = {}
  local rewardNums = {}
  for id, num in pairs(self.data.reward) do
    table.insert(rewardIds, id)
    table.insert(rewardNums, num)
  end
  self.data.rewardIds = rewardIds
  self.data.rewardNums = rewardNums
end

function UINActivityAnniversary23TermPeriodListItem:OnClick()
  if self.eTaskState == TaskEnum.eTaskState.Completed then
    local network = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
    network:CS_ACTIVITY_General_QuestBP_Reward(self.actLongId, self.data.term, self.data.point, function()
      if self._unlockFunc ~= nil then
        self._unlockFunc()
      end
      MsgCenter:Broadcast(eMsgEventId.ActivityTermTaskExpired, self._frameId)
    end)
  else
    self.viewReward:Show()
    self.viewReward:FloatTo(self.transform, HAType.autoCenter, VAType.up)
    self.viewReward:RefreshItems(self.data.rewardIds, self.data.rewardNums, self.closeViewState)
    self:SetViewState(true)
  end
end

function UINActivityAnniversary23TermPeriodListItem:SetViewState(bool)
  self.ui.obj_viewState:SetActive(bool)
  if self.isPicked then
    self.ui.obj_isPicked:SetActive(not bool)
  end
end

function UINActivityAnniversary23TermPeriodListItem:SetRedDotActive(bool)
  self.ui.obj_redDot:SetActive(bool)
end

function UINActivityAnniversary23TermPeriodListItem:OnDelete()
  base.OnDelete(self)
end

return UINActivityAnniversary23TermPeriodListItem
