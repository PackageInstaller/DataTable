-- baoruichang
-- 2022/11/16 14:54:25
-- 预制体 Masquerade_Reward
-- 假面舞会大狂欢界面
local UIMasqueradeRewardCtrl = BaseClass("UIMasqueradeRewardCtrl", BaseUICtrl)
local M = UIMasqueradeRewardCtrl
local EActivityState = EnumConst.EActivityState
local sfmt = string.format
local mCeil = math.ceil
local ITEMNUM = 5
local REWARDNUM = 3

function M:Init()
    self._view.btnBack:onClick(Bind(self, self.Close))
    self.INUM = {2, 1, 2}
    for i = 1, REWARDNUM do
        self._view["UIDanceRewardCtrl" .. i]:SetOnClickCallBack(Bind(self, self._RewardClick, i - 1))
    end
end

-- 进入UI，可传参数
function M:OnEnter(gloalTimes, activityId)
    self.activityId = activityId
    local activityCopys = ConfigHelper.GetCfgsByLua("activityCopy", {activityId=self.activityId})
    self.activityCopy = activityCopys[1]
    self:RefGloalTimes(gloalTimes)
end

function M:OnVisible()
    self:_InitItemState()
end

function M:RefGloalTimes(gloalTimes)
    self.gloalTimes = gloalTimes
    self._view.labTips:SetText(sfmt(ConfigHelper.GetLocalString(5794), self.gloalTimes))
    self:_InitItemState()
end

function M:_InitItemState()
    self._rewardNum = self:GetContext():GetRewardNum()
    local allRewardLimits = self.activityCopy.allRewardLimit
    local openStateNum = 0
    for i = 1, REWARDNUM do
        local itemGroup = ConfigHelper.GetCfgByLua("itemGroup", self.activityCopy.allReward[i])
        ---策划说假面舞会全服奖励每个阶段只会有一个道具
        local itemData = {id=itemGroup.items[1], num=itemGroup.cnts[1]}
        local data = {}
        data.itemData = itemData
        data.num = allRewardLimits[i]
        if data.num > self.gloalTimes then
            data.state = EActivityState.Doing
            data.state1 = 1
        else
            openStateNum = i
            if self:_IsReward(i - 1) then
                data.state = EActivityState.Completed
            else
                data.state = EActivityState.Finished
            end
            if data.num == self.gloalTimes then
                data.state1 = 2
            else
                data.state1 = 3
            end
        end
        self._view["UIDanceRewardCtrl" .. i]:UpdateData(data)
    end
    local openNum = 0
    if self.gloalTimes <= 0 then
        openNum = 0
    elseif self.gloalTimes >= allRewardLimits[REWARDNUM] then
        openNum = 6
    else
        if openStateNum > 0 then
            for i = 1, openStateNum do
                openNum = openNum + self.INUM[i]
            end
        end
        local minNum = allRewardLimits[openStateNum] or 0
        local maxNum = allRewardLimits[openStateNum + 1] or allRewardLimits[REWARDNUM]

        local oneNum = (maxNum - minNum) / self.INUM[openStateNum + 1]
        openNum = openNum + mCeil((self.gloalTimes - minNum) / oneNum)
        if maxNum == self.gloalTimes or minNum == self.gloalTimes then
            openNum = openNum + 0.5
        end
    end
    for i = 1, ITEMNUM do
        self._view["itemState" .. i]:SetState(openNum >= i and 3 or 1)
    end
    if self._view["itemState" .. openNum] then
        self._view["itemState" .. openNum]:SetState(2)
        self._view["labNum" .. openNum]:SetText(tostring(self.gloalTimes))
    end
end

function M:_RewardClick(i)
    ActivityDataMgr:GetInstance():SendCommonReward(self.activityId, {i}, Bind(self, self._OnRewardCallBack))
end

function M:_OnRewardCallBack(awardData)
    GameHelper.ShowGetItems(awardData)
    RedPointMgr:ForceCheck(RedPointConst.ActivityCopyRewardRedPointChecker)
end

function M:_IsReward(i)
    return self._rewardNum & 1 << i > 0
end

function M:OnDeviceBack()
    self:Close()
    return true
end

function M:OnDispose()
    M.super.OnDispose(self)
end

return UIMasqueradeRewardCtrl
