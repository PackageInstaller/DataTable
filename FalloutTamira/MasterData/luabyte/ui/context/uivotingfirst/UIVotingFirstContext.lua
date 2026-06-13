-- baoruichang
-- 2021/12/14 14:03:27
local UIVotingFirstContext = BaseClass("UIVotingFirstContext", BaseContext)
local M = UIVotingFirstContext
local tSort = table.sort
local MessageId = Proto.MessageId
function M:Init()
end

function M:Open()
    -- self:LastRankReq()
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

------------------------------------Start-------------------------------------------
function M:HeroRankReq()
    Logger.Log("请求英雄排行Req")

    self._ResponseHeroRankCallback = NetPack:RegistResponse(MessageId.ResponseHeroRank, Bind(self, self.ResponseHeroRankCallback))
    local request = {}
    request.ActivityId = VotingDataMgr:GetInstance():GetActivityId()
    NetPack:SendMessage(MessageId.RequestHeroRank, request)
end

-- 上期排名Req
function M:LastRankReq()
    Logger.Log("上期排名Req")
    self._ResponseLastRankCallback = NetPack:RegistResponse(MessageId.ResponseLastRank, Bind(self, self.ResponseLastRankCallback))
    local request = {}
    NetPack:SendMessage(MessageId.RequestLastRank, request)
end

--[[{
    {
        "accountId": 10,
        "nick": "ken",
        "cnt": 17,
        "updateTime": 1638869506
      },
      {
        "accountId": 10,
        "nick": "ken",
        "cnt": 17,
        "updateTime": 1638869506
      }
}--]]
-- 上期排名Ack
function M:ResponseLastRankCallback(messagId, result, msg)
    Logger.Log("上期排名ack")
    NetPack:UnRegistResponse(MessageId.ResponseLastRank, self._ResponseLastRankCallback)

    if result ~= 0 then
        Logger.LogError("错误，错误码：" .. result)
        return
    end

    self:_Show(msg.HeroId, msg.players)
end

function M:ResponseHeroRankCallback(messagId, result, msg)
    Logger.Log("请求英雄排行Ack")
    NetPack:UnRegistResponse(MessageId.ResponseHeroRank, self._ResponseHeroRankCallback)
    self._ResponseHeroRankCallback = nil

    if result ~= 0 then
        Logger.LogError("错误码：" .. result)
        return
    end

    self:UpdateHeroData(msg.Data)
    self:_Show(self:GetHeroDatas())
end

------------------------------------End-------------------------------------------
function M:OnClose()
    M.super.OnClose(self)
end
return UIVotingFirstContext
