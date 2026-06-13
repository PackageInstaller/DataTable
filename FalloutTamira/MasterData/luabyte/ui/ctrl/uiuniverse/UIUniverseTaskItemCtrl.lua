-- baoruichang
local CircularScrollViewItem = require("Framework.UI.Component.CircularScrollViewItem")
local UIUniverseTaskItemCtrl = BaseClass("UIUniverseTaskItemCtrl", CircularScrollViewItem)
local M = UIUniverseTaskItemCtrl
local EActivityState = EnumConst.EActivityState
local Destroy = CS.UnityEngine.GameObject.Destroy

function M:Init()
    self._view.btnReward:onClick(Bind(self, self._OnBtnRewardClick))
    self.tabItemPfbViews = {self._view.ItemPfbView}
end

function M:UpdateItem(data)
    self.data = data
    self._view.labName:SetText(data.activityCopyTask.des)
    self:_InitUI()
end

function M:SetOnClick(rewardOnClick)
    self.rewardOnClick = rewardOnClick
end

function M:_OnBtnRewardClick()
    -- Logger.LogError("领奖")
    if self.rewardOnClick then
        self.rewardOnClick(self.data.activityCopyTask.id)
    end
end

function M:_InitUI()
    self:_InitReward()
    local strNum = tostring(self.data.value) .. "/" .. self.data.activityCopyTask.limitValue1
    self._view.labNum:SetText(strNum)
    if not self.data.state or self.data.state == EActivityState.Doing then
        self._view.scrollbar.size = self.data.value / self.data.activityCopyTask.limitValue1
        self._view.state:SetState(1)

    elseif self.data.state == EActivityState.Completed then -- 已完成
        self._view.scrollbar.size = 1
        self._view.state:SetState(3)
    else
        self._view.scrollbar.size = 1 -- 可领取
        self._view.state:SetState(2)
    end
end

function M:_InitReward()
    local itemGroup = ConfigHelper.GetCfgByLua("itemGroup", self.data.activityCopyTask.reward)
    for i, id in pairs(itemGroup.items) do
        local ItemPfbView = self.tabItemPfbViews[i]
        if not ItemPfbView then
            ItemPfbView = self._view.ItemPfbView:Instantiate()
            self.tabItemPfbViews[i] = ItemPfbView
        end
        ItemPfbView.item:SetInfo(id, ItemNumberType.TOTLE, itemGroup.cnts[i])
        ItemPfbView:SetActive(true)
        ItemPfbView.item:EnablePopItem(true)
    end
    for i = #itemGroup.items + 1, #self.tabItemPfbViews do
        self.tabItemPfbViews[i]:SetActive(false)
    end
end

function M:OnDispose()
    for _, value in ipairs(self.tabItemPfbViews) do
        CS.UnityEngine.GameObject.Destroy(value.gameObject)
        value:OnDispose()
    end
    self.goToOnClick = nil
    self.rewardOnClick = nil
    M.super.OnDispose(self)
end

return UIUniverseTaskItemCtrl
