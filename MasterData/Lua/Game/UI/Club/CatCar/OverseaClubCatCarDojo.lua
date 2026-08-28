---@class OverseaClubCatCarDojo.CatCarInfo
---@field clubCatCarPoint number 社团猫车赛道分数
---@field rankInfo OverseaClubCatCarDojo.RankInfo[] 社团猫车排行信息  --分数从小到大
---@field drawBoxIds number[] 领取的进度宝箱id
---@field catCarArriveNum number[] 到达的数量
---@field playerDiceTimesLeft number 玩家剩余重置塞子总次数
---@field playerDiceNumber number[] 玩家塞子点数
---@field submitDiceTimes number 提交塞子的次数
---@field freeResetDiceTimes number 剩余免费重置塞子次数
---@field freeDiceTimes number 免费塞子总次数
---@field drawCarTrackIds number[] 领取的赛道猫车id
---@field otherRankInfo OverseaClubCatCarDojo.RankInfo[] 其他社团猫车排行信息  --分数从小到大
---@field selfRankInfo OverseaClubCatCarDojo.RankInfo 我的社团猫车排行信息

---@class OverseaClubCatCarDojo.CatCarBoss
---@field isFirstJoin number 是否第一次进入 1 第一次进入
---@field remainingHp number boss剩余血量
---@field totalHp number 总血量
---@field atTimes number 挑战次数
---@field playerInfo OverseaClubCatCarDojo.PlayerInfo[] 前三位 社团玩家信息
---@field bossText string 最新造成boss文本
---@field ranking number 社团排名

---@class OverseaClubCatCarDojo.CatCarCallInfo
---@field playerCallNum number 抽奖道具数量
---@field callConf OverseaClubCatCarDojo.CallConf[] 抽奖卡池信息
---@field callLog OverseaClubCatCarDojo.CallLog[] 抽奖记录(最新的)
---@field calledId number 当前抽到的奖励id   (由抽奖接口塞入数据)
---@field log OverseaClubCatCarDojo.CallLog 抽奖记录 (由获取记录接口塞入)

---@class OverseaClubCatCarDojo.RankInfo
---@field clubName string 社团名称
---@field ranking number 社团排名
---@field score number 社团分数
---@field playerInfo OverseaClubCatCarDojo.PlayerInfo[] 社团玩家信息
---@field isMyClub boolean 是否是我的社团

---@class OverseaClubCatCarDojo.PlayerInfo
---@field avatar number 玩家头像
---@field avatarFrame number 玩家头像框
---@field playerId number 玩家id
---@field level number 玩家等级
---@field name string 玩家名称
---@field score number 玩家分数

---@class OverseaClubCatCarDojo.CallConf
---@field id number 奖品编号
---@field rewards Reward[] 奖励
---@field avatar number 抽到的玩家头像
---@field avatarFrame number 抽到的玩家头像框 
---@field type number 几等奖 1  2 3

---@class OverseaClubCatCarDojo.CallLog
---@field avavar number 玩家头像
---@field avatarFrame number 玩家头像框
---@field logText string 日志信息
---@field id number 抽到的奖励编号

---@class OverseaClubCatCarDojo.CarRankInfo
---@field score number 分数
---@field clubId number 社团id
---@field clubName string 社团名称
---@field clubLevel number 社团等级
---@field clubChairmanName string 团长名称
---@field percentageRank number 社团百分比排名

---@class OverseaClubCatCarDojo.MyRank
---@field ranking number 排名
---@field score number 分数

---@class OverseaClubCatCarDojo.BossRankInfo
---@field score number 伤害
---@field playerId number 玩家id
---@field name string 玩家名字
---@field level number 玩家等级
---@field avatar number 玩家头像
---@field avatarFrame number 玩家头像框
---@field ranking number 排名

---@class OverseaClubCatCarDojo : ClassFromJson
---@field scheduleId number 当前排期id
---@field scheduleType number 排期type  1 赛道猫车 2 猫车Boss 3 猫车抽奖
---@field catCarInfo OverseaClubCatCarDojo.CatCarInfo 猫车活动
---@field rankRewards Reward[] 社团猫车排行榜奖励
---@field clubCatCarLevel number 社团猫车奖励等级
---@field clubScore number 社团分数
---@field playerScore number 我的分数
---@field convertCallNum number 转换的抽奖次数
---@field catCarBoss OverseaClubCatCarDojo.CatCarBoss 猫车boss
---@field catCarCallInfo OverseaClubCatCarDojo.CatCarCallInfo 猫车抽奖信息
---@field carRankInfo table<number, OverseaClubCatCarDojo.CarRankInfo> 社团猫车排行榜  排名->信息
---@field myRank OverseaClubCatCarDojo.MyRank 我的排名
---@field bossRankInfo table<number, OverseaClubCatCarDojo.BossRankInfo> 猫车boss排行榜  排名->信息
---@field totalSubmitDiceTimes number 总提交塞子次数
---@field diceRecords table<number, number> 塞子记录  日期->塞子点数
local OverseaClubCatCarDojo = Class("OverseaClubCatCarDojo", import("Game.Dojo.ClassFromJson"))

function OverseaClubCatCarDojo:__init()
    self.scheduleId = 0
    self.scheduleType = 1
    self.catCarInfo = {}
    self.catCarInfo.rankInfo = {}
    self.catCarInfo.drawBoxIds = {}
    self.catCarInfo.catCarArriveNum = {}
    self.rankRewards = {}
    self.clubCatCarLevel = 0
    self.clubScore = 0
    self.playerScore = 0
    self.convertCallNum = 0
    self.catCarBoss = {}
    self.catCarBoss.playerInfo = {}
    self.catCarCallInfo = {}
    self.catCarCallInfo.callConf = {}
    self.catCarCallInfo.callLog = {}

    self.carRankInfo = {}
    self.rankRewards = {}
    self.myRank = {}
    self.bossRankInfo = {}
    self.totalSubmitDiceTimes = 0
    self.diceRecords = {}
    self.totalDiceTimes = 0
end

function OverseaClubCatCarDojo:CheckData()
    self:CheckCarRankInfo()

    if self.clubCatCarLevel == 0 then
        self.clubCatCarLevel = 1
    end
    if checkNumber(self.catCarBoss.totalHp) == 0 then
        self.catCarBoss.totalHp = 1
    end
    self.catCarBoss.remainingHp = checkNumber(self.catCarBoss.remainingHp)

    if self.diceRecords == nil then
        self.diceRecords = {}
    end
end

function OverseaClubCatCarDojo:CheckCarRankInfo()
    self.catCarInfo.otherRankInfo = {}
    for i, v in pairs(self.catCarInfo.rankInfo) do
        if checkNumber(v.isMyClub) == 1 then
            self.catCarInfo.selfRankInfo = v
        else
            table.insert(self.catCarInfo.otherRankInfo, v)
        end
    end
    table.sort(self.catCarInfo.otherRankInfo, function(a, b)
        return a.score < b.score
    end)
end

function OverseaClubCatCarDojo:__delete()
    self.scheduleId = nil
    self.scheduleType = nil
    self.catCarInfo = nil
    self.rankRewards = nil
    self.clubCatCarLevel = nil
    self.clubScore = nil
    self.playerScore = nil
    self.convertCallNum = nil
    self.catCarBoss = nil
    self.catCarCallInfo = nil
    self.totalDiceTimes = nil
end

return OverseaClubCatCarDojo