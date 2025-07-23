module("maze.MazeVo", Class.impl())

function setData(self, cusData)
    -- 迷宫id
    self.mazeId = cusData.maze_id
    -- 通过时间
    self.passTime = cusData.pass_time
    -- 剩余华丽箱子数量
    self.remainGorgeousBoxNum = cusData.left_gorgeous_box
    -- 剩余普通箱子数量
    self.remainNormalBoxNum = cusData.left_normal_box
    -- 剩余boss数量
    self.remainBossNum = cusData.left_boss
    -- 箱子总数量（包括通关箱子）
    self.totalBoxNum = cusData.box_total_num

    -- 本轮开启后是否进入过的标识，0-未进入1-进入过
    self.hasEnter = cusData.enter_flag == 1
end

-- 剩余通关箱子数量
function getReaminPassBoxNum(self)
    -- return self.passTime <= 0 and 1 or 0
    -- 策划说去掉了通关宝箱
    return 0
end

-- 获取当前箱子进度
function getBoxPro(self)
    return (self.totalBoxNum - self.remainGorgeousBoxNum - self.remainNormalBoxNum - self:getReaminPassBoxNum()) / self.totalBoxNum
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
