local LevelFundMgr = BaseClass("LevelFundMgr", Singleton)
local M = LevelFundMgr
local MessageId = Proto.MessageId
local ITEMGROPUID = 365 -- 成长基金购买后立即获得的 systemId(通过这个systemId 找到groupId)

function M:__init()
    self._tempNotifyActiveGrowGoldCallBack = NetPack:RegistResponse(MessageId.NotifyActiveGrowGold, Bind(self, self._NotifyActiveGrowGoldCallBack))
end

function M:LoadData()
    self._isloading = true
    self._dataLoaded = false
    self._errorCode = 0
    self:RequestGrowGoldInfo()
end

function M:GetData()
    return self.PayId, self.AwardMask, self.AwardMaskPaid
end

function M:UpdateData(awardMask, awardMaskPaid)
    self.AwardMask = awardMask
    self.AwardMaskPaid = awardMaskPaid
end

function M:RedPointCheck()
    if not self._dataLoaded then
        return false
    end
    local level = IPlayerData.level
    if not self.growGolds then
        self.growGolds = ConfigHelper.GetCfgs("growGold")
    end
    for _, growGold in pairs(self.growGolds) do
        if level >= growGold.level then
            local id = growGold.id
            if not self:_IsReward(id, self.AwardMask) then
                return true
            end
            if self.PayId and self.PayId > 0 and not self:_IsReward(id, self.AwardMaskPaid) then
                return true
            end
        end
    end
end

function M:_IsReward(id, mask)
    return 1 << id & mask > 0
end

function M:IsReady()
    return self._dataLoaded
end

function M:ErrorCode()
    return self._isloading
end
-----------------------------------Proto Start--------------------------
-- 请求成长基金信息Req
function M:RequestGrowGoldInfo()
    Logger.Log("Req")

    self.tempResponseGrowGoldInfoCallBack = NetPack:RegistResponse(MessageId.ResponseGrowGoldInfo, Bind(self, self.ResponseGrowGoldInfoCallBack))
    local request = {}
    NetPack:SendMessage(MessageId.RequestGrowGoldInfo, request)
end

-- 请求成长基金信息Ack
function M:ResponseGrowGoldInfoCallBack(_, result, msg)
    Logger.Log("Ack")
    NetPack:UnRegistResponse(MessageId.ResponseGrowGoldInfo, self.tempResponseGrowGoldInfoCallBack)
    self.tempResponseGrowGoldInfoCallBack = nil
    self._errorCode = result
    if result ~= 0 then
        Logger.LogError("错误码：" .. result)
        return
    end

    self.PayId = msg.PayId
    self.AwardMask = msg.AwardMask -- 免费奖励领取掩码
    self.AwardMaskPaid = msg.AwardMaskPaid -- 付费奖励掩码

    self._isloading = false
    self._dataLoaded = true
end

function M:_NotifyActiveGrowGoldCallBack(_, result, msg)
    self.PayId = msg.PayId
    -- local groupId = ConfigHelper.GetSystemParam(ITEMGROPUID)
    -- if groupId <= 0 then
    --     Logger.LogError("策划配置错误未找到system id为：" .. ITEMGROPUID)
    --     return
    -- end
    -- local group = ConfigHelper.GetCfg("itemGroup", groupId)
    -- GameHelper.ShowGetItemsById(group.items, group.cnts)
    RedPointMgr:ForceCheck(RedPointConst.LevelFundRedPointChecker)
    EventMgr:Broadcast(UIMessageNames.LEVELFUND_RECHARGE)
end
-----------------------------------Proto End--------------------------

function M:Dispose()
    NetPack:UnRegistResponse(MessageId.NotifyActiveGrowGold, self._tempNotifyActiveGrowGoldCallBack)
    self._tempNotifyActiveGrowGoldCallBack = nil
    M.super.Dispose(self)
end
return LevelFundMgr
