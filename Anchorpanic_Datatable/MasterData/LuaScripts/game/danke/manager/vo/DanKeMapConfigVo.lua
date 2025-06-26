-- @FileName:   DanKeMapConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.manager.vo.DanKeMapConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.id = key

    self.hero_id = cusData.hero_id

    self.max_enemyCount = cusData.max_num
    -- self.max_enemyCount = 1

    self.mon_list = cusData.mon_data
    self.grid_list = {}

    self.max_row = 0
    self.max_col = 0
    for _, grid in pairs(cusData.danke_grid) do
        if not self.grid_list[grid.row] then
            self.grid_list[grid.row] = {}
        end
        self.grid_list[grid.row][grid.col] =
        {
            grid_res = grid.floor_res,
            is_obstacle = grid.is_obstacle == 1,
        }

        if grid.row > self.max_row then
            self.max_row = grid.row
        end

        if grid.col > self.max_col then
            self.max_col = grid.col
        end
    end
end

--is_count是否参与怪物数量计算
function getMonster_list(self, gameTime, is_count)
    is_count = is_count or 0

    local mon_list = {}
    for _, mon in pairs(self.mon_list) do
        if mon.is_count == is_count then
            if gameTime >= mon.show_time[1] and gameTime < mon.show_time[2] then
                table.insert(mon_list, mon)
            end
        end
    end

    return mon_list
end

return _M
