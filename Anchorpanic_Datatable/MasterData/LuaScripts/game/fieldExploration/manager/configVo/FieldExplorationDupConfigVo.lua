-- @FileName:   FieldExplorationDupConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.manager.configVo.FieldExplorationDupConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.dup_id = key
    self.scene_id = cusData.map_id
    self.name = cusData.name
    self.star_list = cusData.star_list
    self.first_award = cusData.first_award
    self.leader_id = cusData.leader_id
    self.time = cusData.time
    self.settlement_type = cusData.settlement_type
    self.settlement_param = cusData.settlement_param

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
