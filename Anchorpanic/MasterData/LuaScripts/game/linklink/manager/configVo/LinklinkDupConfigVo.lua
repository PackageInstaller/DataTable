-- @FileName:   LinklinkDupConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.linklink.manager.configVo.LinklinkDupConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.tid = key
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

    self.time_limit = cusData.time_limit
    self.create_list = cusData.create_list--生成规则{{生成层级,{{卡牌类型，生成数量},{卡牌类型，生成数量}}}}
    self.pre_id = cusData.pre_id

    self.thing_list = cusData.thing_list
    -- for _, config in pairs(cusData.thing_list) do
    --     if not self.thing_list[config.grid_id] then
    --         self.thing_list[config.grid_id] = {row = config.pos[2], col = config.pos[1]}
    --     end
    -- end
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

return _M
