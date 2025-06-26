--派遣坞任务配置表 Vo
module("buildBase.DispatchTaskConfigVo", Class.impl())

function parseConfigData(self, task_id, explore_id, data)
    --任务id
    self.taskId = task_id
    --区域Id
    self.exploreId = explore_id
    --事件图标
    self.icon = data.icon
    -- 解锁等级
    self.unlockLevel = data.need_level
    -- 图标
    self.icon = data.icon
    -- 星级
    self.star = data.star
    -- 任务名称
    self.title = data.title
    -- 任务描述
    self.des = data.des
    --任务最大派遣人数
    self.maxNum = data.num
    -- 基础奖励 id
    self.baseReward = data.base_reward
    -- 额外奖励 id
    self.extraReward = data.extra_reward
    -- 推荐战员职业 {1,2}
    self.heroType = data.hero_type
    -- 推荐战员属性 {2,3}
    self.eleType = data.ele_type
    -- 单个奖励基数
    self.baseIncome = data.floors_income
    -- 额外奖励基数
    self.extraIncome = data.entry_income
    -- 时长
    self.needTime = data.need_time

end

return _M