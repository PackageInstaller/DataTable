-- 战员信息
module("rogueLike.RogueLikeTaskVo", Class.impl())

function parseData(self, id, cusData)
    self.id = id
    -- 任务类型
    self.taskType = cusData.task_type
    -- 完成次数
    self.times = cusData.times
    -- 任务描述
    self.des = cusData.describe
    -- 任务标签
    self.title = cusData.title
    -- 获得分数
    self.score = cusData.score
    -- 任务页签
    self.page = cusData.task_page

    --奖励
    self.reward = cusData.reward
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
