--[[ 
-----------------------------------------------------
@filename       : ManualStoryVo
@Description    : 图鉴怪物配置数据vo
@date           : 2023-3-6 16:23:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualStoryVo", Class.impl())

function parseData(self, index, cusData)
    self.index = index
    self.name = cusData.name
    self.scriptDes = cusData.script
    self.backgroundName = cusData.background
    self.chapterId = cusData.chapter_id
    self.type = cusData.type
    self.sort = cusData.sort
end

--获取名字
function getName(self)
    return _TT(self.name)
end

--获取章节展示id
function getChapterId(self)
    return self.chapterId
end

--获取当前章节已解锁
function getUnlockNum(self)
    local curNum = #manual.ManualStoryManager:getStoryLitleUnlockListByType(self.chapterId)
    local subNum = #manual.ManualStoryManager:getStoryLitleListByChapterId(self.chapterId)
    return _TT(45013, curNum, subNum)
end

--获取描述
function getDes(self)
    return _TT(self.scriptDes)
end
--获取图片Url
function getImgUrl(self)
    return UrlManager:getBgPath("story/" .. self.backgroundName)
end

--获取是否已解锁
function getIsUnlock(self)
    if self.type == manual.ManualStoryType.ActivityStory then
        return true
    end
    return manual.ManualStoryManager:getIsUnlockMainById(self.index)
end

--获取StoryList
function getStoryList(self)
    return manual.ManualStoryManager:getStoryLitleListByChapterId(self.chapterId) or {}
end

--获取图片
function getImg(self)
    return self.backgroundName
end

--获取排序
function getSort(self)
    return self.sort
end

function getIsNew(self)
    if self.type == manual.ManualStoryType.ActivityStory then
        return false
    end
    return read.ReadManager:isModuleRead(ReadConst.MANUAL_MAINSTROY, self.chapterId)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]