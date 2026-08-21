
module('mole.MoleGameDataVo', Class.impl())

function parseData(self, id, cusData)
    self.id = id
    self.name = cusData.name
    self.firstAward = cusData.first_award

    --self.mapList = cusData.map_list

    self.pre_id = cusData.pre_id
    self.starList = cusData.star_list
    self.roundTime = cusData.round_time 

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

    self:parseMapList(cusData.map_list)
end


function isOpen(self)
    if not self.begin_time then
        return true
    end

    local configDt = os.time(self.begin_time)
    local clientDt = GameManager:getClientTime()
    return clientDt >= configDt
end

function parseMapList(self,eventList)
    self.eventList = {}
    for k,v in pairs(eventList) do  
        local eventVo = LuaPoolMgr:poolGet(mole.MoleEventListVo)
        eventVo:parseData(k,v)
        table.insert(self.eventList,eventVo)
    end
    table.sort(self.eventList,function(a,b) return a.id < b.id end)
end

function getName(self)
    return self.name
end


return _M