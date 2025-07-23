module("maze.MazeScene", Class.impl())

function open(self)
    self:addEvent()
    self:initData()
    self:initScene()
    self:initTile()
    self:initCamera()
    self:initPlayer()
end

function close(self)
    self:removeEvent()
    self:removeFogLightSn()
    self:destroyFogLight()
    self:removeUpdateFrameSn()
    maze.MazeCamera:reset()
    gs.GameObject.Destroy(self.mMazeSceneGo)
    self.mMazeSceneGo = nil
end

function addEvent(self)
    GameDispatcher:addEventListener(EventName.UPDATE_MAZE_SCENE_DATA, self.onUpdateMazeDataHandler, self)
    GameDispatcher:addEventListener(EventName.MAZE_REFRESH_FOG, self.updateFogLight, self)
end

function removeEvent(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_MAZE_SCENE_DATA, self.onUpdateMazeDataHandler, self)
    GameDispatcher:removeEventListener(EventName.MAZE_REFRESH_FOG, self.updateFogLight, self)
end

function initData(self)
    self.mSceneRes = UrlManager:getPrefabPath('ui/maze/MazeScene.prefab')
    self.mMazeConfigVo = maze.MazeSceneManager:getMazeConfigVo(maze.MazeSceneManager:getMazeId())
    maze.setIsEvenNumOut(self.mMazeConfigVo:getIsEvenNumOut())
end

function initScene(self)
    self.mMazeSceneGo = AssetLoader.GetGO(self.mSceneRes)
    local childGos, childTrans = GoUtil.GetChildHash(self.mMazeSceneGo)
    maze.MazeSceneThingManager:addLayer(maze.LAYER_ROOT, self.mMazeSceneGo.transform)
    maze.MazeSceneThingManager:addLayer(maze.LAYER_RAY_NORMAL, childTrans["LayerRayNormal"])
    maze.MazeSceneThingManager:addLayer(maze.LAYER_RAY_DRAG, childTrans["LayerRayDrag"])
    maze.MazeSceneThingManager:addLayer(maze.LAYER_CAMERA, childTrans["LayerCamera"])
    maze.MazeSceneThingManager:addLayer(maze.LAYER_DYNAMIC_SCALE, childTrans["LayerDynamicScale"])
    maze.MazeSceneThingManager:addLayer(maze.LAYER_STATIC_SCLAE, childTrans["LayerStaticScale"])
    maze.MazeSceneThingManager:addLayer(maze.LAYER_TILE, childTrans["LayerTile"])
    maze.MazeSceneThingManager:addLayer(maze.LAYER_SELECTION, childTrans["LayerSelection"])
    maze.MazeSceneThingManager:addLayer(maze.LAYER_THING, childTrans["LayerThing"])
    maze.MazeSceneThingManager:addLayer(maze.LAYER_PLAYER, childTrans["LayerPlayer"])
    maze.MazeSceneThingManager:addLayer(maze.LAYER_FOG_LIGHT, childTrans["LayerFogLight"])

    self:setLayerPos(maze.LAYER_ROOT, self.mMazeConfigVo:getOffsetX(), self.mMazeConfigVo:getOffsetY(), self.mMazeConfigVo:getOffsetZ())
    self:setLayerRotation(maze.LAYER_ROOT, 0, 0, 0)

    self.mFogLight = childGos["FogLight"]
end

function initCamera(self)
    if(not self.mSceneCameraTrans or gs.GoUtil.IsTransNull(self.mSceneCameraTrans))then
        self.mSceneCameraTrans = gs.CameraMgr:GetSceneCameraTrans()
        self.mSceneCamera = gs.CameraMgr:GetSceneCamera()
    end
    local layerCameraTrans = maze.MazeSceneThingManager:getLayer(maze.LAYER_CAMERA)
    self.mSceneCameraTrans:SetParent(layerCameraTrans, true)

    maze.MazeCamera:setData(self.mMazeConfigVo, self.mSceneCameraTrans, 55, 5, 0)
end

function initTile(self)
    -- local layoutType = self.mMazeConfigVo:getLayoutType()
    local mazeRow, mazeCol = self.mMazeConfigVo:getRowNum(), self.mMazeConfigVo:getColNum()
    local mazeSizeW, mazeSizeH = self.mMazeConfigVo:getMapSize()

    local tileY = 0.17
    local tileH = self:getTileHeight()
    self:setLayerLPos(maze.LAYER_TILE, 0, tileY, 0)
    self:setLayerLPos(maze.LAYER_SELECTION, 0, tileH, 0)
    self:setLayerLPos(maze.LAYER_THING, 0, tileH + 0.06, 0)
    self:setLayerLPos(maze.LAYER_PLAYER, 0, tileH + 0.05, 0)
    
    -- 方式1
    -- -- 根节点大小缩放
    -- self:setLayerScale(maze.LAYER_ROOT, mazeSizeW, tileY, mazeSizeH)
    -- -- 动态层根据地图缩放大小反向缩放
    -- self:setLayerScale(maze.LAYER_DYNAMIC_SCALE, 1 / mazeSizeW, 10000, 1 / mazeSizeH)
    -- -- 静态层根据资源大小需求自定义，以和单位cube的大小匹配
    -- self:setLayerScale(maze.LAYER_STATIC_SCLAE, map.getStaticLayerScale(layoutType), map.getStaticLayerScale(layoutType), map.getStaticLayerScale(layoutType))
    
    -- 方式2
    self:setLayerScale(maze.LAYER_RAY_NORMAL, mazeSizeW, tileY, mazeSizeH)
    self:setLayerLPos(maze.LAYER_RAY_NORMAL, 0, tileH, 0)

    -- 拖拽层尽量大
    self:setLayerScale(maze.LAYER_RAY_DRAG, 1000, tileY, 1000)
    self:setLayerLPos(maze.LAYER_RAY_DRAG, 0, tileH + 0.001, 0) -- 0.001确保比LAYER_RAY_NORMAL高一点点，确保被相机射线优先检测到

    -- maze.MazeSceneThingManager:getLayer(maze.LAYER_RAY_NORMAL):GetComponent(ty.BoxCollider).enabled = false
    -- maze.MazeSceneThingManager:getLayer(maze.LAYER_RAY_NORMAL):GetComponent(ty.BoxCollider).enabled = true

    -- 生成六边形格子
    for row = 1, mazeRow do
        for col = 1, mazeCol do
            local tileConfigVo = maze.MazeSceneManager:getTileConfigVo(self.mMazeConfigVo:getMazeId(), row, col)
            self:checkTileThing(tileConfigVo)
            self:checkEventThing(tileConfigVo)
        end
    end
end

-- 实际运行调整铺在格子层顶部得知，即格子厚度
function getTileHeight(self)
    return 0.2
end

--显示隐藏格子寻路特效
function showFindPathEfx(self,value)
    if self.mFindPathEfx then
        self.mFindPathEfx:SetActive(value)
    end
end
--设置寻路特效的坐标
function setFindPathTileEfxPos(self,row,col)
    if not self.mFindPathEfx and not self.mLoadEfxSn then 
        local efxPath = "arts/fx/3d/sceneModule/maze/fx_mg_daoju02_diban01.prefab"
        self.mLoadEfxSn = gs.ResMgr:LoadGOAysn(efxPath, function(go)
            go.transform:SetParent(self.mMazeSceneGo.transform, false)
            self.mFindPathEfx = go

            local mazeSizeW, mazeSizeH = self.mMazeConfigVo:getMapSize()
            local tile_PosX, tile_PosZ = maze.getTilePosByRowCol(mazeSizeW, mazeSizeH, self.mMazeConfigVo:getLayoutType(), row, col, self.mMazeConfigVo:getTileSideLen(), self.mMazeConfigVo:getTileHalfH())
            gs.TransQuick:LPos(self.mFindPathEfx.transform, tile_PosX, 0, tile_PosZ)

            self.mLoadEfxSn = nil
        end)
    elseif self.mFindPathEfx then
        local mazeSizeW, mazeSizeH = self.mMazeConfigVo:getMapSize()
        local tile_PosX, tile_PosZ = maze.getTilePosByRowCol(mazeSizeW, mazeSizeH, self.mMazeConfigVo:getLayoutType(), row, col, self.mMazeConfigVo:getTileSideLen(), self.mMazeConfigVo:getTileHalfH())
        gs.TransQuick:LPos(self.mFindPathEfx.transform, tile_PosX, 0, tile_PosZ)
    end
end

function checkTileThing(self, tileConfigVo)
    maze.MazeSceneManager:removeThingVo(maze.THING_TYPE_TILE, tileConfigVo:getRow(), tileConfigVo:getCol(), true)
    local isExist = maze.MazeSceneManager:checkTileIsExist(self.mMazeConfigVo:getMazeId(), tileConfigVo:getRow(), tileConfigVo:getCol())
    if(isExist)then
        local thingVo = maze.getEventThingVo(maze.THING_TYPE_TILE)
        thingVo:setData(self.mMazeConfigVo:getMazeId(), tileConfigVo:getTileId())
        maze.MazeSceneManager:addThingVo(thingVo, true)
    end
end

-- 检查事件实体
function checkEventThing(self, tileConfigVo)
    maze.MazeSceneManager:removeThingVo(maze.THING_TYPE_EVENT, tileConfigVo:getRow(), tileConfigVo:getCol(), true)
    local eventVo = maze.MazeSceneManager:getMazeEventVo(tileConfigVo:getTileId())
    if(eventVo)then
        local thingVo = maze.getEventThingVo(maze.THING_TYPE_EVENT)
        thingVo:setData(self.mMazeConfigVo:getMazeId(), tileConfigVo:getTileId())
        maze.MazeSceneManager:addThingVo(thingVo, true)
    end
end

-- 初始化玩家实体
function initPlayer(self)
    local thingVo = maze.getEventThingVo(maze.THING_TYPE_PLAYER)
    thingVo:setData(self.mMazeConfigVo:getMazeId(), maze.MazeSceneManager:getPlayerTileId())
    maze.MazeSceneManager:addThingVo(thingVo, true, 
    function()
        -- 将玩家位置设置相机初始位置
        local playerVo = maze.MazeSceneManager:getPlayerThingVo(self.mMazeConfigVo:getMazeId())
        maze.MazeCamera:setRowCol(playerVo:getRow(), playerVo:getCol(), true, function()
            local function _reqStar()
                -- 场景加载完毕初始通知
                GameDispatcher:dispatchEvent(EventName.MAZE_ASSETS_LOAD_FINISH)
                -- 场景加载完毕初始请求后端初始触发
                GameDispatcher:dispatchEvent(EventName.REQ_MAZE_CHECK_TRIGGER, {mazeId = maze.MazeSceneManager:getMazeId(), tileId = maze.MazeSceneManager:getPlayerTileId()})
            end
            -- 消散对应迷雾
            self:removeFogLightSn()
            self:destroyFogLight()
            self:initFogLight(_reqStar)
        end)
    end)
end

-- 初始化迷雾光源
function initFogLight(self, callFun)
    local layoutType = self.mMazeConfigVo:getLayoutType()
    local mazeSizeW, mazeSizeH = self.mMazeConfigVo:getMapSize()
    local tileHalfH = self.mMazeConfigVo:getTileHalfH()
    local tileSideLen = self.mMazeConfigVo:getTileSideLen()

    local tileIdList = maze.MazeSceneManager:getPassTileIdList()
    for i = 1, #tileIdList do
        local row, col = maze.MazeSceneManager:getRowColByTileId(self.mMazeConfigVo:getMazeId(), tileIdList[i])
        local tileX, tileY = maze.getTilePosByRowCol(mazeSizeW, mazeSizeH, layoutType, row, col, tileSideLen, tileHalfH)
        local cloneGo = gs.GameObject.Instantiate(self.mFogLight)
        cloneGo.transform:SetParent(maze.MazeSceneThingManager:getLayer(maze.LAYER_FOG_LIGHT), false)
        cloneGo:GetComponent(ty.FogRevealerUnit).VisionRange = sysParam.SysParamManager:getValue(SysParamType.MAZE_PLAYER_FOG_LIGHT_RANGE)
        gs.TransQuick:LPos(cloneGo.transform, tileX, 0, tileY)
        cloneGo:SetActive(true)
        table.insert(self.mFogLightList, cloneGo)
    end

    local function _destroyFogLight()
        self:destroyFogLight()
        if callFun then
            callFun()
        end
    end
    if(not self.m_fogLightLoopSn)then
        self.m_fogLightLoopSn = LoopManager:addTimer(1, 1, self, _destroyFogLight)
    end
end

--更新迷雾
function updateFogLight(self)
    self:initFogLight()
end

-- 迷宫数据更新
function onUpdateMazeDataHandler(self, args)
    local mazeId = args.mazeId
    if(mazeId == self.mMazeConfigVo:getMazeId())then
        local mazeRow, mazeCol = self.mMazeConfigVo:getRowNum(), self.mMazeConfigVo:getColNum()
        for row = 1, mazeRow do
            for col = 1, mazeCol do
                local tileConfigVo = maze.MazeSceneManager:getTileConfigVo(self.mMazeConfigVo:getMazeId(), row, col)
                self:checkTileThing(tileConfigVo)
                self:checkEventThing(tileConfigVo)
            end
        end
        local playerVo = maze.MazeSceneManager:getPlayerThingVo(maze.MazeSceneManager:getMazeId())
        playerVo:resetMovePos()
        playerVo:refreshPos()
    end
end

function destroyFogLight(self)
    if(self.mFogLightList)then
        for i = 1, #self.mFogLightList do
            gs.GameObject.Destroy(self.mFogLightList[i])
        end
    end
    self.mFogLightList = {}
end

function removeFogLightSn(self)
    if(self.m_fogLightLoopSn)then
        LoopManager:removeTimerByIndex(self.m_fogLightLoopSn)
    end
    self.m_fogLightLoopSn = nil
end

function setLayerPos(self, layerType, x, y, z)
    local trans = maze.MazeSceneThingManager:getLayer(layerType)
    if(trans)then
        gs.TransQuick:Pos(trans, x, y, z)
    end
end

function setLayerLPos(self, layerType, x, y, z)
    local trans = maze.MazeSceneThingManager:getLayer(layerType)
    if(trans)then
        gs.TransQuick:LPos(trans, x, y, z)
    end
end

function setLayerRotation(self, layerType, x, y, z)
    local trans = maze.MazeSceneThingManager:getLayer(layerType)
    if(trans)then
        gs.TransQuick:SetRotation(trans, x, y, z)
    end
end

function setLayerScale(self, layerType, x, y, z)
    local trans = maze.MazeSceneThingManager:getLayer(layerType)
    if(trans)then
        gs.TransQuick:Scale(trans, x, y, z)
    end
end

---------------------------------------------------------------触发器---------------------------------------------------------------
function addEventTrigger(self)
    self:removeEventTrigger()
    local eventTrigger = maze.MazeSceneThingManager:getEventTrigger()
    eventTrigger:SetIsPassEvent(false)
    local function _onLongPressHandler()
        self:onLongPressHandler()
    end
    eventTrigger.onLongPress:AddListener(_onLongPressHandler)
    local function _onPointDownHandler()
        self:onPointDownHandler()
    end
    eventTrigger.onPointerDown:AddListener(_onPointDownHandler)
    local function _onPointerUpHandler()
        self:onPointerUpHandler()
    end
    eventTrigger.onPointerUp:AddListener(_onPointerUpHandler)
    local function _onPointerExitHandler()
        self:onPointerUpHandler()
    end
    eventTrigger.onPointerExit:AddListener(_onPointerExitHandler)
    local function _onWheelScrollHandler()
        -- self:__onWheelScrollHandler()
    end
    eventTrigger.onScroll:AddListener(_onWheelScrollHandler)
end

function removeEventTrigger(self)
    local eventTrigger = maze.MazeSceneThingManager:getEventTrigger()
    eventTrigger:SetIsPassEvent(true)
    if(eventTrigger)then
        eventTrigger.onLongPress:RemoveAllListeners()
        eventTrigger.onPointerDown:RemoveAllListeners()
        eventTrigger.onPointerUp:RemoveAllListeners()
        eventTrigger.onPointerExit:RemoveAllListeners()
        eventTrigger.onScroll:RemoveAllListeners()
    end
    self:removeUpdateFrameSn()
end

-- 长按
function onLongPressHandler(self, args)
end

-- 滚轮
function onWheelScrollHandler(sel, args)
    local ratio = 3
    local wheelValue = gs.Input.GetAxis("Mouse ScrollWheel")
    if(wheelValue ~= 0)then
        local curHeight = maze.MazeCamera:getCameraCurHeight()
        curHeight = curHeight - wheelValue * ratio
        maze.MazeCamera:setCameraHeight(curHeight)
    end
end

-- 按下
function onPointDownHandler(self, args)
    self.mDownTime = gs.Time.time
    self.mDownX = gs.Input.mousePosition.x
    self.mDownY = gs.Input.mousePosition.y
    
    maze.MazeCamera:dragPointDown()
    self:addUpdateFramSn()
end

-- 帧更新
function onUpdateFrameHandler(self, args)
    -- 屏蔽不给缩放
    -- local ratio = 0.04
    -- if gs.Application.isMobilePlatform then
    --     if gs.Input.touchCount == 2 and (gs.Input.GetTouch(0).phase == gs.TouchPhase.Moved or gs.Input.GetTouch(1).phase == gs.TouchPhase.Moved) then
    --         local tempPosition1 = gs.Input.GetTouch(0).position
    --         local tempPosition2 = gs.Input.GetTouch(1).position
    --         local deltaX = tempPosition1.x - tempPosition2.x
    --         local deltaY = tempPosition1.y - tempPosition2.y
    --         local currentTouchDistance = math.sqrt(deltaX * deltaX + deltaY * deltaY)
    --         local lastTouchDistance = currentTouchDistance
    --         if(self.mOldPosition1 and self.mOldPosition2)then
    --             deltaX = self.mOldPosition1.x - self.mOldPosition2.x
    --             deltaY = self.mOldPosition1.y - self.mOldPosition2.y
    --             lastTouchDistance = math.sqrt(deltaX * deltaX + deltaY * deltaY)
    --         end
    --         self.mOldPosition1 = tempPosition1
    --         self.mOldPosition2 = tempPosition2

    --         local curHeight = maze.MazeCamera:getCameraCurHeight()
    --         curHeight = curHeight - (currentTouchDistance - lastTouchDistance) * ratio
    --         maze.MazeCamera:setCameraHeight(curHeight)
    --         return
    --     end
    -- end

    if(self.mDownX and self.mDownY)then
        local deltaX = gs.Input.mousePosition.x - self.mDownX
        local deltaY = gs.Input.mousePosition.y - self.mDownY
        if (deltaX ~= 0 or deltaY ~= 0) then
            maze.MazeCamera:dragUpdate()
        end
    end
end

-- 抬起
function onPointerUpHandler(self, args)
    -- self.mOldPosition1 = nil
    -- self.mOldPosition2 = nil
    if(self.mDownX and self.mDownY)then
        local deltaX = gs.Input.mousePosition.x - self.mDownX
        local deltaY = gs.Input.mousePosition.y - self.mDownY

        if (math.abs(deltaX) <= 3 and math.abs(deltaY) <= 3) then
            local deltaTime = gs.Time.time - self.mDownTime
            if (deltaTime < 0.5) then
                maze.MazeCamera:hideRay()
                self:onClickHandler()
                maze.MazeCamera:showRay()
            end
        end
        -- 这里要置为空，否则onPointerExit可能导致触发两次抬起
        self.mDownX = nil
        self.mDownY = nil
    end
    maze.MazeCamera:dragPointUp()
    self:removeUpdateFrameSn()
end

-- 点击
function onClickHandler(self, args)
    -- 防止频繁点击
    if(not self.mLastCdTime or gs.Time.time - self.mLastCdTime >= 0.5)then
        self.mLastCdTime = gs.Time.time

        local clickRow, clickCol = self:getClickRowCol()
        maze.MazeEventExecutor:clickCheckEvent(maze.MazeSceneManager:getMazeId(), clickRow, clickCol)
        -- local tileX, tileY = maze.MazeCamera:setRowCol(clickRow, clickCol, true)
        -- self:testRange(clickRow, clickCol)
        -- self:testDirDis(clickRow, clickCol)
    else
        -- gs.Message.Show2("不要点那么快嘛")
    end
end

function getClickRowCol(self)
    local hitInfo = gs.UnityEngineUtil.RaycastByUICamera(gs.CameraMgr:GetToScreenSceneCamera(), "", 1000)
    if(hitInfo) then
        -- if(not web.WebManager:isReleaseApp())then
            -- CS.UnityEngine.Debug.DrawLine(gs.CameraMgr:GetToScreenSceneCamera().transform.position, hitInfo.point, CS.UnityEngine.Color.red)
        -- end
        local transform = hitInfo.transform
        if(transform)then
            if(transform.name == maze.MazeSceneThingManager:getLayer(maze.LAYER_RAY_NORMAL).name)then
                local layoutType = self.mMazeConfigVo:getLayoutType()
                local tileHalfH = self.mMazeConfigVo:getTileHalfH()
                local tileSideLen = self.mMazeConfigVo:getTileSideLen()
                local mazeRow, mazeCol = self.mMazeConfigVo:getRowNum(), self.mMazeConfigVo:getColNum()
                local layerTileTrans = maze.MazeSceneThingManager:getLayer(maze.LAYER_TILE)
                local localPos = layerTileTrans:InverseTransformPoint(hitInfo.point)
                local clickTileX, clickTileY = maze.getTilePosByLocalPos(mazeRow, mazeCol, layoutType, localPos.x, localPos.z, tileSideLen, tileHalfH)
                return maze.getRowColByTilePos(mazeRow, mazeCol, layoutType, clickTileX, clickTileY, tileSideLen, tileHalfH)
            end
        end
    end
end

function addUpdateFramSn(self)
    self:removeUpdateFrameSn()
    self.m_updateFrameSn = LoopManager:addFrame(1, 0, self, self.onUpdateFrameHandler)
end

function removeUpdateFrameSn(self)
    if (self.m_updateFrameSn) then
        LoopManager:removeFrameByIndex(self.m_updateFrameSn)
        self.m_updateFrameSn = nil
    end
end

-- 范围速度测试
function testRange(self, row, col)
    if(not self.mCount or self.mCount >= 10)then
        self.mCount = 0
    end
    if(self.mList)then
        for i = 1, #self.mList do
            self.mList[i]:SetActive(true)
        end
    end
    gs.Message.Show2(tostring(self.mCount))
    self.mList = {}
    local list = maze.getNearRangeList(self.mMazeConfigVo:getLayoutType(), self.mMazeConfigVo:getRowNum(), self.mMazeConfigVo:getColNum(), row, col, self.mCount)
    for i = 1, #list do
        local thing = maze.MazeSceneThingManager:getThing(maze.THING_TYPE_TILE, list[i].row, list[i].col)
        thing:getTrans().gameObject:SetActive(false)
        table.insert(self.mList, thing:getTrans().gameObject)
    end
    self.mCount = self.mCount + 1
end

function testDirDis(self, row, col)
    if(not self.mDir or self.mDir >= 7)then
        self.mDir = 1
    end
    if(self.mList)then
        for i = 1, #self.mList do
            self.mList[i]:SetActive(true)
        end
    end
    gs.Message.Show2(tostring(self.mDir))
    self.mList = {}
    local list = maze.getDirDisList(self.mMazeConfigVo:getLayoutType(), self.mMazeConfigVo:getRowNum(), self.mMazeConfigVo:getColNum(), row, col, self.mDir, 10, true)
    for i = 1, #list do
        local thing = maze.MazeSceneThingManager:getThing(maze.THING_TYPE_TILE, list[i].row, list[i].col)
        if(thing)then
            thing:getTrans().gameObject:SetActive(false)
            table.insert(self.mList, thing:getTrans().gameObject)
        end
    end
    self.mDir = self.mDir + 1
end

---------------------------------------------------------------触发器---------------------------------------------------------------

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
