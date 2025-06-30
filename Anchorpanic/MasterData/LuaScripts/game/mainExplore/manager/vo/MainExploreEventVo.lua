--[[ 
-----------------------------------------------------
@filename       : MainExploreEventVo
@Description    : 事件数据
@date           : 2021-08-07 14:16:01
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreEventVo", Class.impl())

function setData(self, cusData)
    -- 事件id
    self.mEventId = cusData.event_id
    -- 事件效果
    self.mEventEffectList = cusData.event_effect
end

function getEventId(self)
    return self.mEventId
end

function getEffecctList(self, startIndex, endIndex)
    if (self.mEventEffectList) then
        if (startIndex == nil and endIndex == nil) then
            return self.mEventEffectList
        else
            local list = {}
            local effectLen = #self.mEventEffectList
            startIndex = startIndex == nil and 1 or startIndex
            endIndex = endIndex == nil and effectLen or endIndex

            startIndex = startIndex < 1 and 1 or startIndex
            startIndex = startIndex > effectLen and effectLen or startIndex

            endIndex = endIndex < 1 and 1 or endIndex
            endIndex = endIndex > effectLen and effectLen or endIndex

            if (startIndex > endIndex) then
                startIndex, endIndex = endIndex, startIndex
            end

            for i = startIndex, endIndex do
                table.insert(list, self.mEventEffectList[i])
            end
            return list
        end
    else
        return {}
    end
end

function onRecover(self)
    self.mEventId = nil
    self.mEventEffectList = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
