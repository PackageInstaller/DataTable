--派遣坞任务Msg Vo
module("buildBase.DispatchExploreMsgVo", Class.impl())

function parseMsgInfo(self, data)
    --探索区域Id
    self.exploreId = data.explore_id
    --任务Id
    self.taskId =data.task_id or 0
    --状态 " 1：待派遣 2：派遣中 3：已完成 4：等待刷新"
    self.state = data.state or 0
    --时间戳
    self.endTIme = data.end_time or 0
    --派遣战员列表
    self.heroList = data.hero_list or {}
 
end

return _M
