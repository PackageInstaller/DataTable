--[[ 
-----------------------------------------------------
@filename       : ManualWorldVo
@Description    : 世界观vo
@date           : 2023-3-14 15:19:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualWorldVo", Class.impl())

function parseData(self, index, cusData)
    self.index = index
    self.tapName = cusData.tag_name
    self.type = cusData.type
end

--获取名字
function getName(self)
    return _TT(self.tapName)
end

--获取章节展示id
function getChapterId(self)
    return self.chapterId
end

--获取是否已解锁
function getIsUnlock(self)
    return manual.ManualStoryManager:getIsUnlockMainById(self.index)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]