-- baoruichang
-- 2021/12/15 11:17:39
local UIVotingFir2Context = BaseClass("UIVotingFir2Context", BaseContext)
local M = UIVotingFir2Context
local MessageId = Proto.MessageId
local tSort = table.sort

function M:Init()
end

function M:Open()
    self:HeroRankReq()
end

function M.SortData(data1, data2)
    if data1.Ticket ~= data2.Ticket then
        return data1.Ticket > data2.Ticket
    end
    if data1.rare ~= data2.rare then
        return data1.rare > data2.rare
    end
    return data1.heroId < data2.heroId
end

function M:UpdateHeroData(heroDatas)
    self.heroDatas = heroDatas

    for i = 1, #self.heroDatas do
        self.heroDatas[i].heroId = self.heroDatas[i].HeroId
        self.heroDatas[i].rare = ConfigHelper.GetCfgPropByLua("hero", self.heroDatas[i].HeroId, "rare")
    end

    tSort(self.heroDatas, self.SortData)
end

function M:GetHeroDatas()
    return self.heroDatas or {}
end

function M:GetNextRefTimer()
    return self.nextRefTimer or 0
end

------------------------------------Start-------------------------------------------
-- 请求英雄排行
function M:HeroRankReq()
    Logger.Log("请求英雄排行Req")

    self._ResponseHeroRankCallback = NetPack:RegistResponse(MessageId.ResponseHeroRank, Bind(self, self.ResponseHeroRankCallback))
    local request = {}
    request.ActivityId = VotingDataMgr:GetInstance():GetActivityId()
    NetPack:SendMessage(MessageId.RequestHeroRank, request)
end

function M:ResponseHeroRankCallback(messagId, result, msg)
    Logger.Log("请求英雄排行Ack")
    NetPack:UnRegistResponse(MessageId.ResponseHeroRank, self._ResponseHeroRankCallback)
    self._ResponseHeroRankCallback = nil

    if result ~= 0 then
        Logger.LogError("错误码：" .. result)
        return
    end
    self.nextRefTimer = TimeUtil.GetNowTimeStamp() + msg.Countdown
    self:UpdateHeroData(msg.Data)
    self:_Show(self:GetHeroDatas())
end

------------------------------------End-------------------------------------------
function M:OnClose()
    M.super.OnClose(self)
end

return UIVotingFir2Context
