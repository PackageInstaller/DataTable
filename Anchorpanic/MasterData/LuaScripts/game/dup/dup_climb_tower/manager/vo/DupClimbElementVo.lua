module('dup.DupClimbElementVo', Class.impl())
--[[ 
    爬塔副本区域数据
]]
function ctor(self)
end

-- 解析数据
function parseData(self, cusId, cusData)
    self.id = cusId
    self.name = cusData.name
    --每日最大通关次数
    self.maxTime = cusData.max_times
    self.stageList = cusData.stage_list
    self.enterDup = cusData.enter_dup
    self.openDate = cusData.open_date
    self.icon = cusData.icon
end

-- 获取区域副本列表
function dups(self)
    return self.stageList
end

function getName(self)
    return _TT(self.name)
end

function getIsOpen(self, nowTime)
    local week = tonumber(os.date("%w", nowTime)) 
    local hour = os.date("*t", nowTime).hour
    if(week == 0) then 
        week = 7
    end
    if(hour < 5 and hour >= 0) then 
        week = week - 1
        if(week == 0) then 
            week = 7
        end
    end

    if(dup.DupClimbTowerManager:maxDupId() >= self.enterDup) then 
        for k,v in pairs(self.openDate) do
            if(week - v == 0) then 
                return true
            end
        end
    end
    return false
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
