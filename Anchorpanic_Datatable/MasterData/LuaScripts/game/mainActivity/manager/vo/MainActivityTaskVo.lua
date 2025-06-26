--[[ 
-----------------------------------------------------
@filename       : MainActivityTaskVo
@Description    : 任务
@date           : 2023-05-22 15:45:15
@Author         : Tonn
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('mainActivity.MainActivityTaskVo', Class.impl())

function parseConfigData(self, id, data)
    --道具tid
    self.id = id
    -- 需要完成的次数
    self.needTimes = data.time
    -- 任务描述
    self.des = data.describe
    -- 任务标题
    self.title = data.title
    --奖励列表
    self.reward = {}

    self:parseAwardData(data)
end

function parseAwardData(self, data)
    if next(data.rewards) then
        for _, Vo in pairs(data.rewards) do
            self.reward[#self.reward + 1] = { tid = Vo[1], num = Vo[2] }
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]