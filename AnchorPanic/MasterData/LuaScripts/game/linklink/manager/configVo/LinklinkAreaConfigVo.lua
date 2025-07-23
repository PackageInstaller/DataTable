-- @FileName:   LinklinkAreaConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.linklink.manager.configVo.LinklinkAreaConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.tid = key
    self.stage_list = cusData.stage_list
    self.name = cusData.name

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
end

function getName(self)
    return _TT(self.name)
end

function isOpen(self)
    if not self.begin_time then 
        return true
    end
    local configDt = os.time(self.begin_time)
    local clientDt = GameManager:getClientTime()
    return clientDt >= configDt
end

return _M
