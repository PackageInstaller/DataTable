--[[ 
-----------------------------------------------------
@filename       : ManualWorldUnlockVo
@Description    : 世界观vo
@date           : 2023-3-14 15:19:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualWorldUnlockVo", Class.impl())

function parseData(self, worldId, cusData)
    self.worldId = worldId
    self.titled = cusData.titled
    self.script = cusData.script
    self.unlockStage = cusData.unlock_stage
    self.tag = cusData.tag
end

--获取名字
function getName(self)
    return self.titled
end

--获取章节展示id
function getChapterId(self)
    return self.chapterId
end

--获取描述
function getDes(self)
    return self.script
end

--获取是否已解锁
function getIsUnlock(self)
    return manual.ManualWorldManager:getIsUnlockById(self.worldId)
end

function getIsNew(self)
    return read.ReadManager:isModuleRead(ReadConst.MANUAL_WORLD, self.worldId)
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]