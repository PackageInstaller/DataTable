-- baoruichang
-- 2021/12/8 22:43:33
local UIVotingShopContext = BaseClass("UIVotingShopContext", BaseContext)
local M = UIVotingShopContext
local MessageId = Proto.MessageId
local tSort = table.sort

function M:Init()
end

function M:Open()
    self._ActivityUpdate = EventMgr:AddListener(UIMessageNames.ACTIVITY_UPDATE, Bind(self, self.ActivityUpdate))
    self:OpenUI()
end

function M:OpenUI()
    local ActivityId = VotingDataMgr:GetExchangeId()
    ActivityDataMgr:GetInstance():GetActivityRoleDatasAsyn(ActivityId, function(data)
        self:UpdateShopData(data)
        self:UpdateShopTab()
        self:_Show(self.shopDatas)
    end)

end

function M.SortShopData(data1, data2)
    if data1.sortId ~= data2.sortId then
        return data1.sortId > data2.sortId
    end
    if data1.order ~= data2.order then
        return data1.order < data2.order
    end
    return data1.id < data2.id
end

function M:UpdateShopData(CRoleActivitys)
    if self.tabConf == nil then
        self.tabConf = {}
        local activityExchange = ConfigHelper.GetCfgs("activityExchange")

        for _, v in pairs(activityExchange) do
            if v.activityType == 1 and v.activityId == VotingDataMgr:GetInstance():GetExchangeId() then
                table.insert(self.tabConf, v)
            end
        end
    end

    self.dataBuyNum = {}
    -- 获取已经购买的数量
    for i = 1, #CRoleActivitys do
        local exchangeData = CRoleActivitys[i]

        for j = 1, #self.tabConf do
            if exchangeData.SubActivityId == self.tabConf[j].id then
                local data = {}
                data.id = exchangeData.SubActivityId
                data.buyNum = exchangeData.Value0
                self.dataBuyNum[exchangeData.SubActivityId] = data
                break
            end
        end
    end
end

function M:UpdataShopNum(CRoleActivity)
    if not self.dataBuyNum[CRoleActivity.SubActivityId] then
        local data = {}
        data.id = CRoleActivity.SubActivityId
        data.buyNum = CRoleActivity.Value0
        self.dataBuyNum[CRoleActivity.SubActivityId] = data
    else
        self.dataBuyNum[CRoleActivity.SubActivityId].buyNum = CRoleActivity.Value0
    end
end

-- function M:AddItemInTab(tab, item)
--     if tab[item.Id] then
--         tab[item.Id] = tab[item.Id] + item.Cnt
--         return
--     end

--     tab[item.Id] = item.Cnt
-- end

------------------------------------Start-------------------------------------------
-- 兑换Req
function M:CommonActivityAwardReq(id, num)
    Logger.Log("购买商店Req")
    -- self._CommonActivityAwardCallback = NetPack:RegistResponse(MessageId.ResponseCommonActivityAward, Bind(self, self.ResponseCommonActivityAwardCallback))
    -- local request = {}
    local ActivityId = VotingDataMgr:GetInstance():GetExchangeId()
    local SubActivityId = {id}
    -- request.Num = {num}
    ActivityDataMgr:GetInstance():SendCommonReward(ActivityId, SubActivityId, Bind(self, self._OnRewardCallBack), {num})
    -- NetPack:SendMessage(MessageId.RequestCommonActivityAward, request)
end

function M:_OnRewardCallBack(awardData)
    -- 票选兑换红点变化
    GameHelper.ShowGetItems(awardData)
    RedPointMgr:ForceCheck(RedPointConst.ExchangeRedPointChecker)
end

-- -- 兑换Ack
-- function M:ResponseCommonActivityAwardCallback(messagId, result, msg)
--     Logger.Log("购买商店Ack")
--     NetPack:UnRegistResponse(MessageId.ResponseCommonActivityAward, self._CommonActivityAwardCallback)
--     self._CommonActivityAwardCallback = nil

--     if result ~= 0 then
--         Logger.LogError("错误码：" .. result)
--         return
--     end

--     -- if msg.Awards then
--     local awardData = {}

--     for i = 1, #msg.SubActivityAward do
--         local SubActivityAward = msg.SubActivityAward[i]

--         for j = 1, #SubActivityAward.Items do
--             self:AddItemInTab(awardData, SubActivityAward.Items[j])
--         end
--     end

--     GameHelper.ShowGetItems(awardData)

--     -- 票选兑换红点变化
--     RedPointMgr:ForceCheck(RedPointConst.ExchangeRedPointChecker)
-- end

------------------------------------End-------------------------------------------

function M:UpdateShopTab()
    self.shopDatas = {}

    for i = 1, #self.tabConf do
        local confData = self.tabConf[i]
        local data = {}
        data.id = confData.id
        data.itemId = confData.rewardItem
        data.itemNum = confData.rewardNum
        data.ConstItemId = confData.costItem
        data.ConstItemNum = confData.costNum
        data.canNum = confData.rewardTimes
        data.order = confData.order
        local exchangeData = self.dataBuyNum[data.id]
        data.canNum = exchangeData ~= nil and data.canNum - exchangeData.buyNum or data.canNum

        if data.canNum <= 0 then
            data.sortId = 0
            data.canNum = 0 -- 已经没有可购买次数
            data.buyOver = true
        else
            data.sortId = 1
        end

        self.shopDatas[i] = data
    end

    tSort(self.shopDatas, self.SortShopData)
end

function M:ActivityUpdate(ActivityId)
    if ActivityId ~= VotingDataMgr:GetInstance():GetExchangeId() then
        return
    end
    ActivityDataMgr:GetInstance():GetActivityRoleDatasAsyn(ActivityId, function(data)
        self:UpdateShopData(data)
        self:UpdateShopTab()
        self:GetCtrl():UpdateList(self.shopDatas)
    end)
end

-- function M:OnClose()
--     M.super.OnClose(self)
--     EventMgr:RemoveListener(UIMessageNames.ACTIVITY_UPDATE, self._ActivityUpdate)
-- end

return UIVotingShopContext
