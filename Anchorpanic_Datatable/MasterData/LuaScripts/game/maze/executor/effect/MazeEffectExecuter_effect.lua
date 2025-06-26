-- 特效效果
module("maze.MazeEffectExecuter_effect", Class.impl(maze.MazeBaseEffectExecuter))

function __initData(self)
    super.__initData(self)

    self.mEffectGo = nil
    self.mEffectSn = nil
    self.mDestroyTimerSn = nil
end

function startPlay(self, mazeId, tileId, prefabName, playTime, parentTrans)
    local function _loadAysnCall(effectGo)
        if (effectGo) then
            self.mEffectGo = effectGo
            local effectTrans = effectGo.transform
            local row, col = maze.MazeSceneManager:getRowColByTileId(mazeId, tileId)
            -- local worldPos = maze.MazeSceneThingManager:getLayer(maze.LAYER_THING):TransformPoint(self:__getPos(mazeId, row, col))
            -- effectTrans:SetParent(maze.MazeSceneThingManager:getLayer(maze.LAYER_THING), true)
            -- gs.TransQuick:Pos(effectTrans, worldPos)
            local tileThing = maze.MazeSceneThingManager:getThing(maze.THING_TYPE_TILE, row, col)
            if(tileThing and tileThing:getTrans() and not gs.GoUtil.IsTransNull(tileThing:getTrans()))then
                local eventThing = maze.MazeSceneThingManager:getThing(maze.THING_TYPE_EVENT, row, col)
                if(eventThing and eventThing:getTrans() and not gs.GoUtil.IsTransNull(eventThing:getTrans()))then
                    gs.TransQuick:SyncTrans(effectTrans, eventThing:getTrans())
                else
                    gs.TransQuick:SyncTrans(effectTrans, tileThing:getTrans())
                end
                if(parentTrans and not gs.GoUtil.IsTransNull(parentTrans))then
                    gs.TransQuick:SetParentOrg(effectTrans, parentTrans)
                else
                    effectTrans:SetParent(tileThing:getTrans(), true)
                end
            else
                maze.MazeEffectExecutor:removeEffect(self)
                return
            end
        end
        if(playTime)then
            self.mDestroyTimerSn = RateLooper:addTimer(playTime, 1, self, function() maze.MazeEffectExecutor:removeEffect(self) end)
        end
    end
    self.mEffectSn = gs.GOPoolMgr:GetAsyc(prefabName, _loadAysnCall)
end

function __reset(self)
    super.__reset(self)
    if(self.mDestroyTimerSn)then
        RateLooper:removeTimerByIndex(self.mDestroyTimerSn)
    end
    if(self.mEffectSn)then
        gs.GOPoolMgr:CancelAsyc(self.mEffectSn)
    end
    if(self.mEffectGo and not gs.GoUtil.IsGoNull(self.mEffectGo))then
        gs.GameObject.Destroy(self.mEffectGo)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
