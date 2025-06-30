--[[ 
-----------------------------------------------------
@filename       : MainExploreScene
@Description    : 主线探索场景逻辑
@date           : 2022-2-18 13:44:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreScene", Class.impl())

function open(self)
    self:__addEvent()
    self:__initData()
    self:__initScene()
    mainExplore.MainExploreCamera:setData(gs.CameraMgr:GetSceneCameraTrans(), gs.CameraMgr:GetSceneCamera())
    self:__addUpdateFramSn()
end

function close(self)
    self:__removeEvent()
    self:__removeUpdateFrameSn()
    mainExplore.MainExploreCamera:reset()
    gs.GameObject.Destroy(self.mMainExploreSceneGo)
    self.mMainExploreSceneGo = nil
end

function __addEvent(self)
    mainExplore.MainExploreSceneThingManager:addEventListener(mainExplore.MainExploreSceneThingManager.ADD_THING, self.onAddThingHandler, self)
    mainExplore.MainExploreSceneThingManager:addEventListener(mainExplore.MainExploreSceneThingManager.REMOVE_THING, self.onRemoveThingHandler, self)
end

function __removeEvent(self)
    mainExplore.MainExploreSceneThingManager:removeEventListener(mainExplore.MainExploreSceneThingManager.ADD_THING, self.onAddThingHandler, self)
    mainExplore.MainExploreSceneThingManager:removeEventListener(mainExplore.MainExploreSceneThingManager.REMOVE_THING, self.onRemoveThingHandler, self)
end

function __initData(self)
    self.mSceneRes = UrlManager:getPrefabPath('ui/mainExplore/MainExploreScene.prefab')
end

function __initScene(self)
    self.mMainExploreSceneGo = AssetLoader.GetGO(self.mSceneRes)
    -- local childGos, childTrans = GoUtil.GetChildHash(self.mMainExploreSceneGo)
end

---------------------------------------------------------------触发器---------------------------------------------------------------
function addEventTrigger(self)
    self:removeEventTrigger()
    local eventTrigger = mainExplore.MainExploreSceneThingManager:getEventTrigger()
    eventTrigger:SetIsPassEvent(false)
    local function _onLongPressHandler()
        self:__onLongPressHandler()
    end
    eventTrigger.onLongPress:AddListener(_onLongPressHandler)
    local function _onPointDownHandler()
        self:__onPointDownHandler()
    end
    eventTrigger.onPointerDown:AddListener(_onPointDownHandler)
    local function _onPointerUpHandler()
        self:__onPointerUpHandler()
    end
    eventTrigger.onPointerUp:AddListener(_onPointerUpHandler)
    -- local function _onPointerExitHandler()
    --     self:__onPointerUpHandler()
    -- end
    -- eventTrigger.onPointerExit:AddListener(_onPointerExitHandler)
    local function _onWheelScrollHandler()
        self:__onWheelScrollHandler()
    end
    eventTrigger.onScroll:AddListener(_onWheelScrollHandler)
    mainExplore.MainExploreCamera:addEventTrigger(eventTrigger)
end

function removeEventTrigger(self)
    local eventTrigger = mainExplore.MainExploreSceneThingManager:getEventTrigger()
    eventTrigger:SetIsPassEvent(true)
    if(eventTrigger)then
        eventTrigger.onLongPress:RemoveAllListeners()
        eventTrigger.onPointerDown:RemoveAllListeners()
        eventTrigger.onPointerUp:RemoveAllListeners()
        eventTrigger.onPointerExit:RemoveAllListeners()
        eventTrigger.onScroll:RemoveAllListeners()
        mainExplore.MainExploreCamera:removeEventTrigger(eventTrigger)
    end
end

-- 长按
function __onLongPressHandler(self, args)
end

-- 滚轮
function __onWheelScrollHandler(sel, args)
end

-- 按下
function __onPointDownHandler(self, args)
    self.mDownTime = gs.Time.time
    self.mDownX = gs.Input.mousePosition.x
    self.mDownY = gs.Input.mousePosition.y

    mainExplore.MainExploreCamera:setEnableDrag(true)
end

-- 抬起
function __onPointerUpHandler(self, args)
    if(self.mDownX and self.mDownY)then
        local deltaX = gs.Input.mousePosition.x - self.mDownX
        local deltaY = gs.Input.mousePosition.y - self.mDownY
        if (deltaX == 0 and deltaY == 0) then
            local deltaTime = gs.Time.time - self.mDownTime
            if (deltaTime < 0.5) then
                self:__onClickHandler()
            end
        end
        -- 这里要置为空，否则onPointerExit可能导致触发两次抬起
        self.mDownX = nil
        self.mDownY = nil
    end

    mainExplore.MainExploreCamera:setEnableDrag(false)
end

-- 点击
function __onClickHandler(self)
end

---------------------------------------------------------------start 事件更新相关---------------------------------------------------------------
-- 添加物件实体
function onAddThingHandler(self, thing)
    -- local thingVo = thing:getThingVo()
    -- if(thingVo)then
    --     if(thingVo:getType() == mainExplore.ThingType.PLAYER)then
    --     elseif(thingVo:getType() == mainExplore.ThingType.OTHER_PLAYER)then
    --     elseif (thingVo:getType() == mainExplore.ThingType.NPC) then
    --     elseif (thingVo:getType() == mainExplore.ThingType.MONSTER) then
    --     elseif (thingVo:getType() == mainExplore.ThingType.NORMAL) then
    --     end
    -- end
end

-- 移除物件实体
function onRemoveThingHandler(self, thing)
    mainExplore.MainExplorePlayerProxy:checkClearThing(thing)
end
-----------------------------------------------------------------end 事件更新相关-----------------------------------------------------------------
function __addUpdateFramSn(self)
    self:__removeUpdateFrameSn()
    self.mUpdateFrameSn = LoopManager:addFrame(1, 0, self, self.__onUpdateFrameHandler)
end

function __removeUpdateFrameSn(self)
    if (self.mUpdateFrameSn) then
        LoopManager:removeFrameByIndex(self.mUpdateFrameSn)
        self.mUpdateFrameSn = nil
    end
end

-- 帧更新
function __onUpdateFrameHandler(self, deltaTime)
end

---------------------------------------------------------------触发器---------------------------------------------------------------

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
