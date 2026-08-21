-- @FileName:   PickGoldDupConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.pickGold.manager.vo.PickGoldDupConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.id = key
    self.name = cusData.name
    self.first_award = cusData.first_award

    if not table.empty(cusData.begin_time) then
        self.begin_time =
        {
            year = cusData.begin_time[1][1],
            month = cusData.begin_time[1][2],
            day = cusData.begin_time[1][3],
            hour = cusData.begin_time[2][1],
            min = cusData.begin_time[2][2],
            sec = cusData.begin_time[2][3],
        }
    end

    self.pre_id = cusData.pre_id

    self.weight = {}
    self.maxWeight = 0

    for i = 1, #cusData.weight do
        self.maxWeight = self.maxWeight + cusData.weight[i][2]
        self.weight[i] =
        {
            type = cusData.weight[i][1],
            weight = self.maxWeight,
        }
    end

    self.interval = cusData.interval * 0.001
    self.speed = cusData.speed
    self.target_score = cusData.target_score
end

function getName(self)
    return self.name
end

function isOpen(self)
    if not self.begin_time then
        return true
    end

    local configDt = os.time(self.begin_time)
    local clientDt = GameManager:getClientTime()
    return clientDt >= configDt
end

function getAward(self)
    return AwardPackManager:getAwardListById(self.first_award)
end

function getGoldWeight(self)
    local weight = math.random(1, self.maxWeight)
    for i = 1, # self.weight do
        if weight <= self.weight[i].weight then
            return self.weight[i]
        end
    end
end

return _M
