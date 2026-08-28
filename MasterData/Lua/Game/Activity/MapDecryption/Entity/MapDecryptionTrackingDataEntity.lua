

---@class MapDecryptionTrackingDataEntity
local MapDecryptionTrackingDataEntity = Class('MapDecryptionTrackingDataEntity')


function MapDecryptionTrackingDataEntity:__init()
    self.questId        = 0       --- 追踪id
    self.questVo           = nil
end


function MapDecryptionTrackingDataEntity:__delete()

end

---Fill
---填充数据
---@param questVo     MapDecryptionQuestVo
---@param serverData table { --- 理想数据
---@       id, 追踪关卡表id
---@       star, 追踪关卡通关星级
---@       isUnlock, 是否解锁
---@}
function MapDecryptionTrackingDataEntity:Fill(questVo, serverData, starInfo)
    serverData = checkTable(serverData)
    ---todo 服务端数据未定 先定义下
    self.questId    = questVo.id

    self.star       = starInfo[tostring(questVo.id)]
    self.isUnlock   = checkNumber(serverData.isUnlock)

    self.questVo    = questVo
    return self
end




return MapDecryptionTrackingDataEntity
