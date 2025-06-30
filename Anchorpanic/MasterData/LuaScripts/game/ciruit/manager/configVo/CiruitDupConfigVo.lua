-- @FileName:   CiruitDupConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.ciruit.manager.configVo.CiruitDupConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.tid = key
    self.name = cusData.name
    self.desc = cusData.desc
    self.help = cusData.help
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

    self.grid_list = cusData.grid_list

    self.max_row = cusData.max_row
    self.max_col = cusData.max_col
    self.pre_id = cusData.pre_id --前置副本ID
    self.put_grid = cusData.put_grid -- 摆放的格子列表
end

function getName(self)
    return self.name
end

function getDesc(self)
    return _TT(self.desc)
end

function isOpen(self)
    if not self.begin_time then
        return true
    end
    
    local configDt = os.time(self.begin_time)
    local clientDt = GameManager:getClientTime()
    return clientDt >= configDt
end

function getHelpTips(self)
    return _TT(self.help)
end

return _M
