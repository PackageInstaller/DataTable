
module('doundless.DoundlessCityVo', Class.impl())

function parseData(self,id,cusData)
    self.id = id 

    self.leftLevel = cusData.left_level
    self.rightLevel = cusData.right_level

    self.cityData  = {}--cusData.city_data

    for id, data in pairs(cusData.city_data) do
        local vo = LuaPoolMgr:poolGet(doundless.DoundlessSingleCityVo)
        vo:parseData(id,data)
        self.cityData[id] = vo
    end

    self.downtownRewardsData = cusData.downtown_rewards_data
    self.midtownRewardsData = cusData.midtown_rewards_data
    self.uptownRewardsData = cusData.uptown_rewards_data

    self.downtownDisturbanceData={}
    self:paserDisturbanceData(self.downtownDisturbanceData,cusData.downtown_disturbance_data)

    self.midtownDisturbanceData = {}
    self:paserDisturbanceData(self.midtownDisturbanceData,cusData.midtown_disturbance_data)

    self.uptownDisturbanceData = {}
    self:paserDisturbanceData(self.uptownDisturbanceData,cusData.uptown_disturbance_data)
end

function getDistributeData(self,city,id)
    local data = {}
    if city == doundless.WarType.Low then
        data = self.downtownDisturbanceData
    elseif city == doundless.WarType.Middle then
        data = self.midtownDisturbanceData
    elseif city == doundless.WarType.Hight then
        data = self.uptownDisturbanceData
    end
    return data[id]
end

function paserDisturbanceData(self,dic,data)
    for id, data in pairs(data) do
        local vo = LuaPoolMgr:poolGet(doundless.DoundlessDisturbanceVo)
        vo:parseData(id, data)
        dic[id] = vo
    end
end

function getSingleCityData(self,lv)
    return self.cityData[lv]
end

function getCityRewardsData(self,city)
    local data = {}
    if city == doundless.WarType.Low then
        data = self.downtownRewardsData
    elseif city == doundless.WarType.Middle then
        data = self.midtownRewardsData
    elseif city == doundless.WarType.Hight then
        data = self.uptownRewardsData
    end
    return data 
end

return _M