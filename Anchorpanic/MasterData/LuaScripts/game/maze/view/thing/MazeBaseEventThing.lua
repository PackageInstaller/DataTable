module("maze.MazeBaseEventThing", Class.impl())

function getLayer(self)
    return maze.LAYER_THING
end

function onRecover(self)
    self:removeEvents()
    self:clearEffectList()
    self:clearModel()
    self.mEventThingVo = nil
end

function create(self, eventThingVo, finishCall)
    self.mEventThingVo = eventThingVo
    self.mTilePos = math.Vector3(0, 0, 0)
    self:addEvents()
    self:updateModel(finishCall)
end

function getData(self)
    return self.mEventThingVo
end

function addEvents(self)
end

function removeEvents(self)
end

function updateModel(self, finishCall)
    local layoutType = self:getMazeConfigVo():getLayoutType()
    local tileHalfH = self:getMazeConfigVo():getTileHalfH()
    local tileSideLen = self:getMazeConfigVo():getTileSideLen()
    local mazeSizeW, mazeSizeH = self:getMazeConfigVo():getMapSize()
    local eventConfigVo = self:getEventConfigVo()

    local thingGo = AssetLoader.GetGO(eventConfigVo:getPrefabName())
    if(not thingGo)then
        thingGo = gs.GameObject()
        Debug:log_error(self.__cname, "迷宫事件找不到对应资源：" .. eventConfigVo:getPrefabName())
    end
    self:setTrans(thingGo.transform)
    local eventTrans = self:getTrans()
    eventTrans:SetParent(maze.MazeSceneThingManager:getLayer(self:getLayer()), true)
    eventTrans.name = string.format("Row%s_Col%s", self:getRow(), self:getCol())
    -- 不设置大小，由美术实际大小
    -- local tileRealScale = self:getMazeConfigVo():getTileRealScale()
    -- gs.TransQuick:Scale(eventTrans, tileRealScale, tileRealScale, tileRealScale)
    gs.TransQuick:SetLRotation(eventTrans, 0, self:getRotation(), 0)
    local tileX, tileY = maze.getTilePosByRowCol(mazeSizeW, mazeSizeH, layoutType, self:getRow(), self:getCol(), tileSideLen, tileHalfH)
    gs.TransQuick:LPos(eventTrans, tileX, 0, tileY)
    if(finishCall)then
        finishCall()
    end
end

function getRotation(self)
    local eventVo = self:getEventVo()
    if(eventVo)then
        return maze.getRotationByDirectionList(eventVo:getEventId(), self:getEventConfigVo():getDirectionList(), eventVo:getDirectionList())
    else
        return maze.getRotationByDirectionList(0, self:getEventConfigVo():getDirectionList(), nil)
    end
end

function getEventConfigVo(self)
    if(self:getEventVo())then
        return maze.MazeSceneManager:getEventConfigVo(self:getEventId())
    end
    return nil
end

function getEventId(self)
    return self:getEventVo():getEventId()
end

function getEventVo(self)
    return maze.MazeSceneManager:getMazeEventVo(self:getTileId())
end

function getTilePos(self)
    local mazeSizeW, mazeSizeH = self:getMazeConfigVo():getMapSize()
    self.mTilePos.x, self.mTilePos.z = maze.getTilePosByRowCol(mazeSizeW, mazeSizeH, self:getMazeConfigVo():getLayoutType(), self:getData():getRow(), self:getData():getCol(), self:getMazeConfigVo():getTileSideLen(), self:getMazeConfigVo():getTileHalfH())
    return self.mTilePos
end

function setTrans(self, trans)
    self.mTrans = trans
end

function getTrans(self)
    return self.mTrans
end

function setVisible(self, isShow)
    if(self:getTrans() and not gs.GoUtil.IsTransNull(self:getTrans()))then
        self:getTrans().gameObject:SetActive(isShow)
    end
end

function recordEffect(self, effectObj)
    if(not self.mEffectList)then
        self.mEffectList = {}
    end
    table.insert(self.mEffectList, effectObj)
end

function clearEffectList(self)
    if(self.mEffectList)then
        for i = 1, #self.mEffectList do
            maze.MazeEffectExecutor:removeEffect(self.mEffectList[i])
        end
        self.mEffectList = nil
    end
end

function clearModel(self)
    local trans = self:getTrans()
    if (trans and not gs.GoUtil.IsTransNull(trans)) then
        -- local eventConfigVo = self:getEventConfigVo()
        -- gs.GOPoolMgr:Recover(trans.gameObject, eventConfigVo:getPrefabName())
        gs.GameObject.Destroy(trans.gameObject)
        self:setTrans(nil)
    end
end

-------------------------------------------------------------------从数据获取方便使用-------------------------------------------------------------------
function getMazeId(self)
    return self:getData():getMazeId()
end

function getTileId(self)
    return self:getData():getTileId()
end

function getType(self)
    return self:getData():getType()
end

function getRow(self)
    return self:getData():getRow()
end

function getCol(self)
    return self:getData():getCol()
end

function getTileConfigVo(self)
    return self:getData():getTileConfigVo()
end

function getMazeConfigVo(self)
    return self:getData():getMazeConfigVo()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
