module("maze.MazeEventVo", Class.impl())

function setData(self, cusData)
    -- 格子id
    self.mTileId = cusData.id
    -- 事件id
    self.mEventId = cusData.event_id
    -- 事件方向
    self.mEventDirectionList = cusData.direction
    -- 事件的动作状态
    self.mActState = cusData.state
    -- 事件效果
    self.mEventEffectList = cusData.event_effect

    -- 服务器发来如果为空，则取默认方向
    if(#self.mEventDirectionList <= 0)then
        local eventConfigVo = maze.MazeSceneManager:getEventConfigVo(self.mEventId)
        if(eventConfigVo)then
            self.mEventDirectionList = eventConfigVo:getDirectionList()
        else
            Debug:log_error("MazeEventVo", string.format("服务器发来的事件找不到配置，格子id=%s，事件id=%s", self.mTileId, self.mEventId))
        end
    end
end

function getTileId(self)
    return self.mTileId
end

function getEventId(self)
    return self.mEventId
end

function getDirectionList(self)
    return self.mEventDirectionList
end

function getActState(self)
    return self.mActState
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
    self.mTileId = nil
    self.mEventId = nil
    self.mEventEffectList = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
