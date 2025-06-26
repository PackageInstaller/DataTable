module("branchStory.BranchEquipChapterVo", Class.impl())
--[[ 
    关卡章节数据
]]
function ctor(self)
end

-- 解析数据
function parseData(self, cusId, cusData)
    self.chapterId = cusId

    self.mName = cusData.name
    self.mChapterName = cusData.chapter_name
    self.mChapterInside = cusData.chapter_inside
    self.dropId = cusData.drop
    self.needMainStageId = cusData.unlock_stage
    self.mUnLockText = cusData.unlock_text
    self.mIconPath = cusData.icon_image
    self.stageIdList = {}

    local len = #cusData.stage
    for i = 1, len do
        table.insert(self.stageIdList, cusData.stage[i])
    end
    table.sort(self.stageIdList, self.__sortStageIdList)
end

function getInsideName(self)
    return _TT(self.mChapterInside)
end

function getName(self)
    return _TT(self.mName)
end

function getChapterName(self)
    return _TT(self.mChapterName)
end

function getUnLockText(self)
    return _TT(self.mUnLockText)
end

-- 关卡列表按照关卡id排序
function __sortStageIdList(stageId_1, stageId_2)
    -- 关卡id从小到大
    if (stageId_1 > stageId_2) then
        return false
    end
    if (stageId_1 < stageId_2) then
        return true
    end
    return false
end

-- 关卡列表按照关卡sort排序
function __sortStageVoList(stageVo_1, stageVo_2)
    -- 关卡id从小到大
    if (stageVo_1.sort > stageVo_2.sort) then
        return false
    end
    if (stageVo_1.sort < stageVo_2.sort) then
        return true
    end
    return false
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
