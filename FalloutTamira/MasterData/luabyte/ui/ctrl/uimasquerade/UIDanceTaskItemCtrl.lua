-- baoruichang
-- 2022/11/17 14:53:21
-- local CircularScrollViewItem = require("Framework.UI.Component.CircularScrollViewItem")
-- local UIDanceTaskItemCtrl = BaseClass("UIDanceTaskItemCtrl", CircularScrollViewItem)
local UIDanceTaskItemCtrl = BaseClass("UIDanceTaskItemCtrl", UIBaseComponent)
local M = UIDanceTaskItemCtrl
local tInsert = table.insert

function M:__init(_view)
    self._view = _view
    self:Init()
end

function M:Init()
    self._view.btnGoTo:onClick(Bind(self, self._OnBtnGoToClick))
    self._view.btnReward:onClick(Bind(self, self._OnBtnRewardClick))
    self.tabRewardItems = {self._view.UIDanceItemCtrl}
end

function M:UpdateItem(data)
    self.data = data
    self._view.labName:SetText(data.activityCopyTask.des)
    self:_InitUI()
end

function M:SetOnClick(goToOnClick, rewardOnClick)
    self.goToOnClick = goToOnClick
    self.rewardOnClick = rewardOnClick
end

function M:_OnBtnGoToClick()
    if self.goToOnClick then
        self.goToOnClick(self.data.activityCopyTask.linkto)
    end
end

function M:_OnBtnRewardClick()
    if self.rewardOnClick then
        self.rewardOnClick(self.data.activityCopyTask.id)
    end
end

function M:_InitUI()
    self:_InitReward()
    if not self.data.state or self.data.state == 0 then
        self._view.scrollbar.size = self.data.value / self.data.activityCopyTask.limitValue1
        if self.data.activityCopyTask.linkto > 0 then
            self._view.state:SetState(1)
        else
            self._view.state:SetState(2)
        end
    elseif self.data.state == 1 then
        self._view.scrollbar.size = 1
        self._view.state:SetState(3)
    else
        self._view.scrollbar.size = 1
        self._view.state:SetState(4)
    end
end

function M:_InitReward()
    local itemGroup = ConfigHelper.GetCfgByLua("itemGroup", self.data.activityCopyTask.reward)
    for i, id in pairs(itemGroup.items) do
        local UIDanceItemCtrl = self.tabRewardItems[i]
        if not UIDanceItemCtrl then
            UIDanceItemCtrl = self._view.UIDanceItemCtrl:Instantiate()
            tInsert(self.tabRewardItems, UIDanceItemCtrl)
        end
        UIDanceItemCtrl:UpdateData({id=id, num=itemGroup.cnts[i]})
        UIDanceItemCtrl:SetActive(true)
    end
    for i = #itemGroup.items + 1, #self.tabRewardItems do
        self.tabRewardItems[i]:SetActive(false)
    end
end

function M:OnDispose()
    for k, value in ipairs(self.tabRewardItems) do
        CS.UnityEngine.GameObject.Destroy(value.gameObject)
        value:OnDestroy()
    end
    self.goToOnClick = nil
    self.rewardOnClick = nil
    M.super.OnDispose(self)
end

return UIDanceTaskItemCtrl
