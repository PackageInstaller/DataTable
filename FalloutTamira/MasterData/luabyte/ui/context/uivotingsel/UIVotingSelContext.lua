local UIVotingSelContext = BaseClass("UIVotingSelContext", BaseContext)
local M = UIVotingSelContext
-- 海选界面
function M:Init()
end

function M:Open()
    if not self.nextRefTimer or TimeUtil.GetNowTimeStamp() > self.nextRefTimer then
        self:HeroRankReq()
    else
        self:_Show()
    end
end

local function SortTicket(heroData1, heroData2)
    if heroData1.Ticket ~= heroData2.Ticket then
        return heroData1.Ticket > heroData2.Ticket
    end
    if heroData1.rare ~= heroData2.rare then
        return heroData1.rare > heroData2.rare
    end
    return heroData1.heroId < heroData2.heroId
end

-- 海选数据
function M:AllSelectHeroDatas(Datas)
    if self.allHero == nil then
        self.allHero = ConfigHelper.GetCfgPropByLua("activityGirl", VotingDataMgr:GetInstance():GetActivityGirlId(), "hero")
        self.allHero = self.allHero or {}
    end

    -- 海选数据
    self.selectAllHeroData = {}
    local index = 1

    for i = 1, #self.allHero do
        local heroId = self.allHero[i]
        local have = false
        local data = {}
        self.selectAllHeroData[index] = data
        index = index + 1
        data.heroId = heroId
        data.rare = ConfigHelper.GetCfgPropByLua("hero", heroId, "rare")
        for j = 1, #Datas do
            if Datas[j].HeroId == heroId then
                have = true
                data.Ticket = Datas[j].Ticket
                break
            end
        end

        if not have then
            data.Ticket = 0
        end
    end

    table.sort(self.selectAllHeroData, SortTicket)

    for i = 1, #self.selectAllHeroData do
        self.selectAllHeroData[i].index = i
    end
end

-- 获取海选数据
function M:GetAllSelectGetHeroData()
    return self.selectAllHeroData or {}
end

function M:GetNextRefTimer()
    return self.nextRefTimer or 0
end

------------------------------------Start-------------------------------------------
-- 请求英雄排行
function M:HeroRankReq()
    Logger.Log("请求英雄排行Req")

    self._ResponseHeroRankCallback = NetPack:RegistResponse(Proto.MessageId.ResponseHeroRank, Bind(self, self.ResponseHeroRankCallback))
    local request = {}
    request.ActivityId = VotingDataMgr:GetInstance():GetActivityId()
    NetPack:SendMessage(Proto.MessageId.RequestHeroRank, request)
end

function M:ResponseHeroRankCallback(messagId, result, msg)
    Logger.Log("请求英雄排行Ack")
    NetPack:UnRegistResponse(Proto.MessageId.ResponseHeroRank, self._ResponseHeroRankCallback)
    self._ResponseHeroRankCallback = nil

    if result ~= 0 then
        Logger.LogError("错误码：" .. result)
        return
    end
    self.nextRefTimer = TimeUtil.GetNowTimeStamp() + msg.Countdown
    self:AllSelectHeroDatas(msg.Data)

    if UIManager:IsShow(self.uiName) then
        self:GetCtrl():OnRefHeroData()
    else
        self:_Show()
    end
end

------------------------------------End-------------------------------------------

function M:OnClose()
    M.super.OnClose(self)
end

return UIVotingSelContext
