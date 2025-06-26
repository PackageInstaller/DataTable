--[[ 
-----------------------------------------------------
@filename       : ManualStoryDialogueVo
@Description    : 图鉴怪物配置数据vo
@date           : 2023-3-7 10:00:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualStoryDialogueVo", Class.impl())

function parseData(self, key, cusData)
    self.stageId = key
    self.name = cusData.name
    self.unlockType = cusData.unlock_type
    self.unLockList = cusData.unlock_list
    self.icon = cusData.icon
    self.storyId = cusData.story_id
end

--获取名字
function getName(self)
    return self.name
end

--获取是否已解锁
function getIsUnlock(self)
    return manual.ManualStoryManager:getIsUnlockById(self.stageId) ~= false
end

--获取图片Url
function getImgUrl(self)
    return UrlManager:getBgPath("story/" .. self.icon)
end

function getIsNew(self)
    return read.ReadManager:isModuleRead(ReadConst.MANUAL_MAINSTROY, self.stageId)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]