-- @FileName:   FieldExplorationMapConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.manager.configVo.FieldExplorationMapConfigVo', Class.impl())

function parseCogfigData(self, activity_id, key, cusData)
    self.activity_id = activity_id
    self.map_id = key
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

return _M
