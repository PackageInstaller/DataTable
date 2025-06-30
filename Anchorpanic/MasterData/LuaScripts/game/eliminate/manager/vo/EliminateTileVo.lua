--[[ 
-----------------------------------------------------
@filename       : EliminateTileVo
@Description    : 消消乐网格方格数据
@date           : 2022-3-2 
@Author         : zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("eliminate.EliminateTileVo", Class.impl("lib.event.EventDispatcher"))

UPDATE_STATE = "UPDATE_STATE"

function setConfig(self, stageConfigVo, tileConfigVo)
    self.mapRow = stageConfigVo.mapRow
    self.mapCol = stageConfigVo.mapCol
    self.rowIndex = tileConfigVo.rowIndex
    self.colIndex = tileConfigVo.colIndex
    self.tileType = tileConfigVo.tileType
    self.iceType = tileConfigVo.iceType
    self.mIceCount = self:getIceCountByIceType(self.iceType)
end

function getIceCountByIceType(self, iceType)
    if(iceType == eliminate.ThingType.TileIce_1)then
        return 1
    elseif(iceType == eliminate.ThingType.TileIce_2)then
        return 2
    elseif(iceType == eliminate.ThingType.TileIce_3)then
        return 3
    end
    return 0
end

function getIceTypeByIceCount(self, iceCount)
    if(iceCount == 1)then
        return eliminate.ThingType.TileIce_1
    elseif(iceCount == 2)then
        return eliminate.ThingType.TileIce_2
    elseif(iceCount == 3)then
        return eliminate.ThingType.TileIce_3
    end
    return eliminate.ThingType.Empty
end

function getTileIcon(self)
    local thingConfigVo = eliminate.EliminateManager:getThingConfigVo(self.tileType)
    if(thingConfigVo)then
        return thingConfigVo.icon
    else
        return ""
    end
end

function getIceIcon(self)
    if(self.iceType == eliminate.ThingType.Empty)then
        return nil
    else
        local thingConfigVo = eliminate.EliminateManager:getThingConfigVo(self.iceType)
        if(thingConfigVo)then
            return thingConfigVo.icon
        else
            return ""
        end
    end
end

function getIcon(self)
    local type = nil
    if(self.iceType ~= eliminate.ThingType.Empty)then
        type = self.iceType
    else
        type = self.tileType
    end
    local thingConfigVo = eliminate.EliminateManager:getThingConfigVo(type)
    if(thingConfigVo)then
        return thingConfigVo.icon
    else
        return ""
    end
end

-- 是否可消除
function isCanEliminate(self)
    return false
end

-- 是否可移动
function isCanMove(self)
    return true
end

function setIceCount(self, iceCount)
    if(iceCount ~= self.mIceCount)then
        self.mIceCount = math.max(0, iceCount)
        self.iceType = self:getIceTypeByIceCount(self.mIceCount)
        self:dispatchEvent(self.UPDATE_STATE)
    end
end

function getIceCount(self)
    return self.mIceCount
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
