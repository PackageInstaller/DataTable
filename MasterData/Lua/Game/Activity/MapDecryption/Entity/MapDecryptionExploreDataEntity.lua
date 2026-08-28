
local MapDecryptionExploreTaskEntity = import("Game.Activity.MapDecryption.Entity.MapDecryptionExploreTaskEntity")

---@class MapDecryptionExploreDataEntity
local MapDecryptionExploreDataEntity = Class('MapDecryptionExploreDataEntity')


function MapDecryptionExploreDataEntity:__init()
    self.exploreId        = 0        --- 探索id
    self.mapConfData      = nil      --- 探索地图数据
    self.exploreProgress  = 0        --- 探索进度
    self.exploreTargetNum = 0        --- 探索目标进度
    self.status           = 0        --- 0代表进行中1可经取2已领取
    self.isUnlock         = 0        --- 0代表未解锁1已解锁
    self.taskEntityList   = nil      --- 探索任务列表
end


function MapDecryptionExploreDataEntity:__delete()

end

---Fill
---填充数据
---@param decryptedMapsVo     MapDecryptionDecryptedMapsVo
---@param serverData table { 
--- [id] = {
---     id = 0,              ---解密地图表id 
---     unlockDay = 0,       ---解密地图表解锁时间
---     rewards = {},        ---奖励
---     isUnlock = 0,        ---地图是否解锁
---     isDraw = 0,          ---是否领取总奖励
---     tasks  = {
---          id = 0,         ---任务id
---          status = 0,     ---任务领取状态 [0,1,2] 0:代表进行中 1:可领取 2:已领取
---          progress = 0,   ---任务进度
---          desc = "",       ---任务描述
---          rewards = {},   ---奖励信息
---          taskType = 0,   ---任务类型
---          targetId = 0,   ---任务参数id
---          targetNum = 0,  ---任务数量
---     }
--- },
---}
function MapDecryptionExploreDataEntity:Fill(decryptedMapsVo, serverData)
    self.unlockDay  = serverData.unlockDay
    self.unlockTimeLeft = serverData.unlockTimeLeft
    self.rewards    = serverData.rewards
    self.isUnlock   = checkNumber(serverData.isUnlock)
    self.exploreId  = serverData.id
    
    self.mapConfData = decryptedMapsVo
    
    --- 地图总奖励领取状态 [0,1,2] 0:代表进行中 1:可领取 2:已领取
    local isDraw          = checkNumber(serverData.isDraw) == 2
    self.status           = isDraw and 2 or 0
    local tInsert         = table.insert
    local tasks           = serverData.tasks
    local taskEntityList  = {}
    local exploreProgress = 0
    for i, task in ipairs(tasks) do
        if checkNumber(task.status) >= 1 then
            exploreProgress = exploreProgress + 1
        end
        ---@type MapDecryptionExploreTaskEntity
        local entity = MapDecryptionExploreTaskEntity.New()
        tInsert(taskEntityList, entity:Fill(task))
    end
    self.exploreProgress = exploreProgress
    self.exploreTargetNum = #taskEntityList
    if self.status == 0 and exploreProgress == self.exploreTargetNum then
        self.status = 1
    end
    self.taskEntityList  = taskEntityList

    return self
end




return MapDecryptionExploreDataEntity
