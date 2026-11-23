


PropManager = {}
PropManager.__index = PropManager

function PropManager.New(gridManager)

    local self = {}
    setmetatable(self, PropManager)
    self.gridManager = gridManager
    self.props = {}
    self:InitEvents()
    return self
end

function PropManager:Init(initialProps)
    if initialProps ~= nil then
        self.props[Match3Const.PropType.Eliminate] = initialProps[Match3Const.PropType.Eliminate] or 0
        self.props[Match3Const.PropType.Swap] = initialProps[Match3Const.PropType.Swap] or 0
        self.props[Match3Const.PropType.Reshuffle] = initialProps[Match3Const.PropType.Reshuffle] or 0
    end
end


function PropManager:InitEvents()
    self.useCallback = function(param)
        local pos = param[0].startPos
        self:UseEliminateProp(pos)
    end
    LuaMgr.AddUIEventListener(UIEventConst.UseEliminateProp, self.useCallback)

    self.useCallback1 = function(param)
        local pos1 = param[0].startPos
        local pos2 = param[0].endPos
        self:UseSwapProp(pos1, pos2)
    end
    LuaMgr.AddUIEventListener(UIEventConst.UseSwapProp, self.useCallback1)

    self.useCallback2 = function()
        self:UseReshuffleProp()
    end
    LuaMgr.AddUIEventListener(UIEventConst.UseReshuffleProp, self.useCallback2)
end




function PropManager:GetPropCount(propType)
    return self.props[propType] or 0
end




function PropManager:UseEliminateProp(pos)
    local data = {}
    data.type = Match3Const.PropType.Eliminate
    if self.props[data.type] <= 0 then
        data.reason = Match3Const.UsePropsFaildReason.NotEnough
        LuaMgr.InvokeUIEventListeners(UIEventConst.PropUseResult, data)
        return false
    end

    local element = self.gridManager:GetElementAt(pos)
    if not element then
        data.reason = Match3Const.UsePropsFaildReason.NoneGoalElement
        LuaMgr.InvokeUIEventListeners(UIEventConst.PropUseResult, data)
        return false
    end


    self.props[data.type] = self.props[data.type] - 1
    data.reason = Match3Const.UsePropsFaildReason.Success
    data.remainCount = self.props[data.type]
    LuaMgr.InvokeUIEventListeners(UIEventConst.PropUseResult, data)
    if self.coroutine ~= nil then
        coroutine_runner.stop(self.coroutine)
        self.coroutine = nil
    end
    local func = function()
        local animData = nil
        if element.IsSpecial and element.TriggerEffect ~= nil then
            animData = element:TriggerEffect(self.gridManager)
        else
            animData = {}
            local elements = {element}
            animData.animTime = self.gridManager:EliminateSameTime(elements)
            animData.animTimeType = Match3Const.AnimTimeCalType.Max

            local scoreData = {}
            scoreData.eliminateNum = #elements
            LuaMgr.InvokeUIEventListeners(UIEventConst.Match3ScoreUpdate, scoreData)
        end
        if animData then
            coroutine_runner.wait(animData.animTime)
            local elementsEliminateddData = {}
            elementsEliminateddData.usePropType = Match3Const.PropType.Eliminate
            LuaMgr.InvokeUIEventListeners(UIEventConst.ElementsEliminated, elementsEliminateddData)
        end
    end
    self.coroutine = coroutine_runner.start(func)
    return true
end





function PropManager:UseSwapProp(pos1, pos2)
    local data = {}
    data.type = Match3Const.PropType.Swap
    if self.props[data.type] <= 0 then
        data.reason = Match3Const.UsePropsFaildReason.NotEnough
        LuaMgr.InvokeUIEventListeners(UIEventConst.PropUseResult, data)
        return false
    end

    if not self.gridManager:GetElementAt(pos1) or not self.gridManager:GetElementAt(pos2) then
        data.reason = Match3Const.UsePropsFaildReason.NoneGoalElement
        LuaMgr.InvokeUIEventListeners(UIEventConst.PropUseResult, data)
        return false
    end
    self.props[data.type] = self.props[data.type] - 1
    data.reason = Match3Const.UsePropsFaildReason.Success
    data.remainCount = self.props[data.type]
    LuaMgr.InvokeUIEventListeners(UIEventConst.PropUseResult, data)
    return true
end



function PropManager:UseReshuffleProp()
    local data = {}
    data.type = Match3Const.PropType.Reshuffle
    if self.props[Match3Const.PropType.Reshuffle] <= 0 then
        data.reason = Match3Const.UsePropsFaildReason.NotEnough
        LuaMgr.InvokeUIEventListeners(UIEventConst.PropUseResult, data)
        return false
    end
    self.props[Match3Const.PropType.Reshuffle] = self.props[Match3Const.PropType.Reshuffle] - 1
    data.reason = Match3Const.UsePropsFaildReason.Success
    data.remainCount = self.props[data.type]
    LuaMgr.InvokeUIEventListeners(UIEventConst.PropUseResult, data)


    self.gridManager:ReshuffleGrid()



    local matches = self.gridManager:FindAllMatches()
    if #matches > 0 then

        local elementsToEliminate = {}
        local elementIds = {}

        for _, matchGroup in ipairs(matches) do
            for _, element in ipairs(matchGroup) do
                if not elementIds[element.Id] then
                    elementIds[element.Id] = true
                    table.insert(elementsToEliminate, element)
                end
            end
        end
        
        local scoreData = {}
        scoreData.eliminateNum = #elementsToEliminate
        LuaMgr.InvokeUIEventListeners(UIEventConst.Match3ScoreUpdate, scoreData)

        local animTime = self.gridManager:EliminateSameTime(elementsToEliminate)

        local data = {}
        data.usePropType = Match3Const.PropType.Reshuffle
        data.animTime = animTime
        LuaMgr.InvokeUIEventListeners(UIEventConst.ElementsEliminated, data)
    end
    return true
end




function PropManager:AddProp(propType, count)
    self.props[propType] = (self.props[propType] or 0) + count
    local data = {}
    data.type = propType
    data.reason = Match3Const.UsePropsFaildReason.Success
    data.remainCount = self.props[data.type]
    LuaMgr.InvokeUIEventListeners(UIEventConst.PropUseResult, data)
end

function PropManager:RemoveUIEvent()
    LuaMgr.RemoveUIEventListener(UIEventConst.UseEliminateProp, self.useCallback)
    LuaMgr.RemoveUIEventListener(UIEventConst.UseSwapProp, self.useCallback1)
    LuaMgr.RemoveUIEventListener(UIEventConst.UseReshuffleProp, self.useCallback2)
end

function PropManager:Destroy()
    self:RemoveUIEvent()
end