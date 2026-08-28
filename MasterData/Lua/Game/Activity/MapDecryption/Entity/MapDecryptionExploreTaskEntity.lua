---@class MapDecryptionExploreTaskEntity
local MapDecryptionExploreTaskEntity = Class('MapDecryptionExploreTaskEntity')


function MapDecryptionExploreTaskEntity:__init()
    self.taskId          = 0   --- 探索任务id
    self.taskProgress    = 0   --- 探索任务进度
    self.status          = 0   ---任务领取状态 [01,2] 0:代表进行中 1:可领取 2:已领取
    self.progress        = 0   ---任务进度
    self.desc            = nil  ---任务描述
    self.rewards         = nil  ---奖励信息
    self.taskType        = 0   ---任务类型
    self.targetId        = 0   ---任务参数id
    self.targetNum       = 0   ---任务数量
end


function MapDecryptionExploreTaskEntity:__delete()

end


---Fill
---填充数据
---@param serverData table
function MapDecryptionExploreTaskEntity:Fill(serverData)
    ---填充服务端数据
    self.taskId          = serverData.id
    self.taskProgress    = checkNumber(serverData.progress)
    self.targetNum       = checkNumber(serverData.targetNum)
    self.desc            = serverData.desc
    self.rewards         = serverData.rewards
    self.taskType        = serverData.taskType
    self.targetId        = serverData.targetId
    
    self.status      = checkNumber(serverData.status)

    return self
end


return MapDecryptionExploreTaskEntity
