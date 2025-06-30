--[[ 
-----------------------------------------------------
@filename       : WelfareOptNoviceVo
@Description    : 新手训练营
@Author         : lyx
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("WelfareOptNoviceVo",Class.impl())

function parseNoviceData(self, id, cusData)
    self.mId = id
    --任务类型
    self.mTaskType = cusData.task_type
    --完成次数
    self.mTime = cusData.time
    --任务描述
    self.mDescribe = cusData.describe
    -- 任务标题
    self.mTitle = cusData.title
    -- {奖励道具id，奖励道具数量}
    self.mReward = cusData.reward
    -- 界面跳转
    self.mUiCode = cusData.ui_code
    -- 阶段
    self.mStep = cusData.step
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
