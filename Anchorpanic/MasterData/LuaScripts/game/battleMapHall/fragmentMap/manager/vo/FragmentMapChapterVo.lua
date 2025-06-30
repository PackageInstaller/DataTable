module("battleMap.FragmentMapChapterVo", Class.impl())
--[[ 
    主线关卡章节数据
]]
function ctor(self)
end

-- 解析数据
function parseData(self, cusId, cusData)
    self.chapterId = cusId
    self.m_name = cusData.name
    self.m_level = cusData.level
    --self.position = cusData.position
    self.m_stageIdList = {}
    self.lang = cusData.lang 
    local len = #cusData.stage
    for i = 1, len do
        table.insert(self.m_stageIdList, cusData.stage[i])
    end
end

function getName(self)
    return _TT(self.m_name)
end

-- 关卡列表按照关卡sort排序
function __sortStageVoList(stageVo_1, stageVo_2)
    -- 关卡id从小到大
    if (stageVo_1.sort > stageVo_2.sort) then
        return false
    elseif (stageVo_1.sort < stageVo_2.sort) then
        return true
    else
        return false
    end
end

-- 获取章节的关卡vo列表
function getStageVoList(self, style)
    local styleType = style and style or battleMap.FragmentMapStyleType.Easy
    local stageVoList = {}
    for i = 1, #self.m_stageIdList do
        local stageId = self.m_stageIdList[i]
        local stageVo = battleMap.FragmentMapManager:getStageVo(stageId)
        -- if (stageVo.styleType == styleType) then
            table.insert(stageVoList, stageVo)
        -- end
    end
    table.sort(stageVoList, self.__sortStageVoList)
    return stageVoList
end

-- 判断指定关卡是否属于当前章节
function isStageBelongChapter(self, stageVo)
    for i = 1, #self.m_stageIdList do
        if (stageVo.stageId == self.m_stageIdList[i]) then
            return true
        end
    end
    return false
end

-- 获取对应风格类型的第一个关卡，用于判断当前章节是否已解锁
function getFirstStageId(self, style)
    for i = 1, #self.m_stageIdList do
        local stageId = self.m_stageIdList[i]
        if (style) then
            local stageVo = battleMap.FragmentMapManager:getStageVo(stageId)
            if (stageVo.styleType == style) then
                return stageId
            end
        else
            return stageId
        end
    end
end

-- 获取对应风格类型的最后一个关卡，用于判断当前章节是否已解锁
function getEndStageId(self)
    return self.m_stageIdList[#self.m_stageIdList]
    -- for i = #self.m_stageIdList, 1, -1 do
    --     local stageId = self.m_stageIdList[i]
    --     if (style) then
    --         local stageVo = battleMap.FragmentMapManager:getStageVo(stageId)
    --         -- if (stageVo.styleType == style) then
    --             return stageId
    --         -- end
    --     else
    --         return stageId
    --     end
    -- end
end

-- 获取章节的关卡进度
function getStagePro(self, style)
    local list = self:getStageVoList(style)
    local totalNum = #list
    local passNum = 0
    for i = 1, totalNum do
        if (battleMap.FragmentMapManager:isStagePass(list[i].stageId)) then
            passNum = passNum + 1
        end
    end
    return math.floor(passNum / totalNum * 100), passNum .. "/" .. totalNum
end

-- 获取章节的关卡进度
function getStage(self, style)
    local list = self:getStageVoList(style)
    local totalNum = #list
    local passNum = 0
    for i = 1, totalNum do
        if (battleMap.FragmentMapManager:isStagePass(list[i].stageId)) then
            passNum = passNum + 1
        end
    end

    return passNum, totalNum
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]