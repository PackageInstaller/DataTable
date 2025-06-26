module("maze.MazeEventThing", Class.impl(maze.MazeBaseEventThing))

function getLayer(self)
    return maze.LAYER_THING
end

function onRecover(self)
    -- local eventConfigVo = self:getEventConfigVo()
    -- if(eventConfigVo and eventConfigVo:isMutexFloor())then
    --     local thingVo = maze.MazeSceneManager:getThingVo(maze.THING_TYPE_TILE, self:getData():getRow(), self:getData():getCol())
    --     if(thingVo)then
    --         local thing = maze.MazeSceneThingManager:getThing(maze.THING_TYPE_TILE, self:getData():getRow(), self:getData():getCol())
    --         if(thing)then
    --             thing:setVisible(true)
    --         end
    --     end
    -- end
    super.onRecover(self)
end

function create(self, eventThingVo, finishCall)
    super.create(self, eventThingVo, finishCall)

    -- local eventConfigVo = self:getEventConfigVo()
    -- if(eventConfigVo and eventConfigVo:isMutexFloor())then
    --     local thingVo = maze.MazeSceneManager:getThingVo(maze.THING_TYPE_TILE, self:getData():getRow(), self:getData():getCol())
    --     if(thingVo)then
    --         local thing = maze.MazeSceneThingManager:getThing(maze.THING_TYPE_TILE, self:getData():getRow(), self:getData():getCol())
    --         if(thing)then
    --             thing:setVisible(false)
    --         end
    --     end
    -- end
end

function addEvents(self)
    self:getData():addEventListener(self:getData().MONSTER_REBORN_UPDATE, self.__onRebornUpdateView, self)
end

function removeEvents(self)
    self:getData():removeEventListener(self:getData().MONSTER_REBORN_UPDATE, self.__onRebornUpdateView, self)
end

function __onRebornUpdateView(self, args)
end

function updateModel(self, finishCall)
    self.mEventModel = maze.MazeEventModel.new()
    self.mEventModel:setPrefab(self:getEventConfigVo():getPrefabName(), false,
        function()
            self:__modelLoadComplete(finishCall)
        end)
        self.mHeroCuteConfigVo = hero.HeroCuteManager:getHeroCuteConfigVo(maze.getPlayerHeroTid())
    end

    function __modelLoadComplete(self, finishCall)
        local layoutType = self:getMazeConfigVo():getLayoutType()
        local tileHalfH = self:getMazeConfigVo():getTileHalfH()
        local tileSideLen = self:getMazeConfigVo():getTileSideLen()
        local mazeSizeW, mazeSizeH = self:getMazeConfigVo():getMapSize()
        local eventConfigVo = self:getEventConfigVo()

        self:setTrans(self.mEventModel:getTrans())
        local eventTrans = self:getTrans()
        eventTrans:SetParent(maze.MazeSceneThingManager:getLayer(self:getLayer()), true)
        eventTrans.name = string.format("%s_%s", self:getRow(), self:getCol())
        -- 不设置大小，由美术实际大小
        -- local tileRealScale = self:getMazeConfigVo():getTileRealScale()
        -- gs.TransQuick:Scale(eventTrans, tileRealScale, tileRealScale, tileRealScale)

        local eventVo = self:getEventVo()
        gs.TransQuick:SetLRotation(eventTrans, 0, self:getRotation(), 0)
        local tileX, tileY = maze.getTilePosByRowCol(mazeSizeW, mazeSizeH, layoutType, self:getRow(), self:getCol(), tileSideLen, tileHalfH)
        gs.TransQuick:LPos(eventTrans, tileX, 0, tileY)

        local function actionListFinish()
            local actState = self:getEventVo():getActState()
            local actHash = maze.getActHashByState(actState)
            self.mEventModel:playAction(actHash, nil, nil)
            if(finishCall)then
                finishCall()
            end
        end
        -- self.mEventModel.m_ani:LoadClipWithHash(maze.ACT_TRIGGER_BEFORE)
        -- self.mEventModel.m_ani:LoadClipWithHash(maze.ACT_TRIGGER_AFTER)
        -- self.mEventModel.m_ani:LoadClipWithHash(maze.ACT_TRIGGER_DOING)
        -- self.mEventModel:setPreLoadAnis({"before", "after", "trigger"}, actionListFinish)
        self.mEventModel:setPreLoadAnisByHashList(maze.ACT_TRIGGER_LIST, actionListFinish)

        self:updateEffect()
    end

    function updateEffect(self)
        local eventTrans = self.mEventModel.m_modelTrans
        local effectNode = eventTrans:Find("effectNode")

        local actState = self:getEventVo():getActState()
        local effectNameList = self:getEventConfigVo().triggerEffectDic[actState]
        if(effectNameList and #effectNameList > 0)then
            for _, effectName in pairs(effectNameList) do
                local effect = maze.MazeEffectExecutor:createParticleEffect(self:getMazeId(), self:getTileId(), maze.getEffectUrl(effectName), nil, effectNode, nil)
                self:recordEffect(effect)
            end
        end
    end

    function playAction(self, actionHash, startCall, endCall)
        if(self.mState ~= actionHash)then
            self.mState = actionHash
            -- self.mEventModel:setAnimationTriggerVal(triggerHash)
            self.mEventModel:playAction(actionHash, startCall, endCall)
            self.mEventModel:setAniSpeed(1)
        else
            if(startCall)then
                startCall()
            end
            if(endCall)then
                endCall()
            end
        end
    end

    function clearModel(self)
        if (self.mEventModel) then
            self.mEventModel:destroy()
            self.mEventModel = nil
        end
    end

    -- 获取动作时长
    function getAniLenght(self, aniName, callback)
        if(self.mEventModel)then
            return self.mEventModel:getAniLenght(aniName, callback)
        end
    end

    return _M

    --[[ 替换语言包自动生成，请勿修改！
]]
