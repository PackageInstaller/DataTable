-- @FileName:   ShootBrickDupConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.shootBrick.manager.vo.ShootBrickDupConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.id = key
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

    self.brick_list = {}
    for i = 1, #cusData.map_list do
        local row = cusData.map_list[i].pos[1]
        local col = cusData.map_list[i].pos[2]

        if not self.brick_list[row] then
            self.brick_list[row] = {}
        end

        self.brick_list[row][col] = {id = i, row = row, col = col, brick_id = cusData.map_list[i].brick_id, drop_id = cusData.map_list[i].item_id}
    end

    self.pre_id = cusData.pre_id
    self.drop_data = cusData.item

    self.shoot_angle = cusData.ball_set[1] --初次发射的角度
    self.add_speed = cusData.ball_set[2] --每次碰到板子增加的速度
    self.ball_id = cusData.ball_set[3] --子弹id
    self.max_speed = cusData.ball_set[4] --子弹最大速度

    self.star_list = cusData.star_list
    self.img_type = cusData.img_type
end

function getBall(self)
    if not self.ball_id then
        logError("该关卡，子弹id 为空")
        return
    end
    return shootBrick.ShootBrickManager:getBallConfigVo(self.ball_id)
end

function getBrickList(self)
    return self.brick_list
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

function getAward(self)
    return AwardPackManager:getAwardListById(self.first_award)
end

function getIconPath(self)
    return string.format("arts/ui/bg/shootBrick/shootBrick_pnl_%02d.png", self.img_type)
end

function getSceneBgPath(self)
     return string.format("arts/ui/bg/shootBrick/shootBrick_bg%02d.png", self.img_type)
end

return _M
