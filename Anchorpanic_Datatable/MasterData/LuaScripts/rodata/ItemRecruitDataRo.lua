
module("ItemRecruitDataRo", Class.impl())

function parseData(self, id, refData)
    self.id = id

    self.type = refData.type
    self.m_costOneNum = refData.cost_one_num
    self.m_minimumDes = refData.minimum_des
    self.m_costTenId = refData.cost_ten_id
    self.m_costTenNum = refData.cost_ten_num
    self.m_minimumNum = refData.minimum_num
    self.m_costOneId = refData.cost_one_id
    self.m_minimumTimes = refData.minimum_times
    self.m_minimumReward = refData.minimum_reward
    self.m_try_hero = refData.try_hero
    self.trailHero_id = refData.hero_id
    self.rebate_item = refData.rebate_item
    self.show_item = refData.show_item

    self.free_times = refData.free_times

    self.hero_list = refData.hero_list
end

function geID(self)
    return self.id
end

function getCostOneNum(self)
    return self.m_costOneNum
end

function getMinimumDes(self)
    return self.m_minimumDes
end

function getCostTenId(self)
    return self.m_costTenId
end

function getCostTenNum(self)
    return self.m_costTenNum
end

function getMinimumNum(self)
    return self.m_minimumNum
end

function getCostOneId(self)
    return self.m_costOneId
end

function getMinimumTimes(self)
    return self.m_minimumTimes
end

function getTrailHero_id(self)
    return self.trailHero_id
end

function getMinimumReward(self)
    return self.m_minimumReward
end

function getTry_hero(self)
    return self.m_try_hero
end

return _M
