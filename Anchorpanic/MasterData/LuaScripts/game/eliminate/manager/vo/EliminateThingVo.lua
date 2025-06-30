--[[ 
-----------------------------------------------------
@filename       : EliminateThingVo
@Description    : 消消乐物件数据
@date           : 2022-3-2 
@Author         : zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("eliminate.EliminateThingVo", Class.impl("lib.event.EventDispatcher"))

UPDATE_POS = "UPDATE_POS"
UPDATE_MOVE = "UPDATE_MOVE"
UPDATE_SELECT = "UPDATE_SELECT"

function setConfig(self, stageConfigVo, tileConfigVo)
    self.mapRow = stageConfigVo.mapRow
    self.mapCol = stageConfigVo.mapCol
    self.thingType = tileConfigVo.thingType
    self.rowIndex = tileConfigVo.rowIndex
    self.colIndex = tileConfigVo.colIndex
end

function getIcon(self)
    local thingConfigVo = eliminate.EliminateManager:getThingConfigVo(self.thingType)
    if(thingConfigVo)then
        return thingConfigVo.icon
    else
        return ""
    end
end

function setRowColToUpdate(self, rowIndex, colIndex)
    self.rowIndex = rowIndex
    self.colIndex = colIndex
    self:dispatchEvent(self.UPDATE_POS)
end

function setMoveToRowCol(self, rowIndex, colIndex, moveCall, moveTime, moveEaseTypeX, moveEaseTypeY)
    self.rowIndex = rowIndex
    self.colIndex = colIndex
    self:dispatchEvent(self.UPDATE_MOVE, {moveCall = moveCall, moveTime = moveTime or 0.2, moveEaseTypeX = moveEaseTypeX or gs.DT.Ease.Linear, moveEaseTypeY = moveEaseTypeY or gs.DT.Ease.Linear})
end

function setSelect(self, isSelect)
    self:dispatchEvent(self.UPDATE_SELECT, isSelect)
end

-- 是否可消除
function isCanEliminateByEffect(self)
    if(self.thingType == eliminate.ThingType.Empty or self.thingType == eliminate.ThingType.ObstacleForbid)then
        return false
    else
        return true
    end
end

-- 是否可受颜色匹配影响一并被消除
function isCanEliminateByMatch(self)
    if(self.thingType == eliminate.ThingType.ObstacleNormal)then
        return true
    else
        return false
    end
end

-- 是否可移动
function isCanMove(self)
    if(self.thingType == eliminate.ThingType.ObstacleForbid or self.thingType == eliminate.ThingType.ObstacleNormal)then
        return false
    else
        return true
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
