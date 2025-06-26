module("ExploreDataVo",Class.impl())

function parseConfigData(self,cusData)
    --区域名称
    self.areaName = cusData.area_name
    --区域序号
    self.areaNum = cusData.area_number

    --解锁需要声望等级
    self.needPrestige = cusData.need_prestige
    --事件
    --self.eventData = cusData.event_Data
    local oldData = cusData.event_data
    self.level = cusData.level

    self.eventDic = {}
    for id,data in pairs(oldData) do
        local vo = explore.ExploreEventDataVo.new()
        vo:parseEventData(data)
        self.eventDic[data.id] = vo
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
