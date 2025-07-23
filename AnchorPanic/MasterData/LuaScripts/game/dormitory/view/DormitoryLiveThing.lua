--[[
-----------------------------------------------------
@filename       : DormitoryLiveThing
@Description    : 宿舍战员
@date           : 2021-11-15 17:59:00
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dormitory.view.DormitoryLiveThing', Class.impl(model.modelLive))

--构造函数
function ctor(self)
    super.ctor(self)
    self.lateBubbleTime = 0
    self.isFirstBulle = 0
    self.isControllerMove = false

    self.showOnBringTime = 0.2

    self.audioDataDic = {}

    self.m_rotateSpeed = 10 -- 旋转速度

    self.moveSpeed = 0
end

-- 设置模型
function setModelID(self, liveTid, finishCall)
    self.m_liveTid = liveTid

    local config = hero.HeroCuteManager:getHeroCuteConfigVo(self.m_liveTid)
    if config then
        self.moveSpeed = config:getDormitorySpeed()

        local prefabPath = config.mModelPrefab
        -- local prefabPath = "arts/character/pet/3101_qb/model3101_qb.prefab"
        if string.NullOrEmpty(prefabPath) then
            if finishCall then
                finishCall()
            end
            return
        end

        if self.m_uiPrefabPath ~= prefabPath then
            self:setPrefab(prefabPath, beAlwayEft, finishCall)
            self.m_uiPrefabPath = prefabPath
        end
    end
    self:addEventListener()
end

-- 设置模型
function setPrefab(self, prefabPath, beAlwayEft, callback)
    self.mLoadFinishCall = callback
    self:setupPrefab(prefabPath, beAlwayEft)
    self:playAction(DormitoryCost.ACT_SHOW_STAND)
end

function loadFinish(self, go, finishCall, sorceId)
    super.loadFinish(self, go, finishCall, sorceId)

    self.m_UILoadPoint = gs.GoUtil.FindNameInChilds(go.transform, "Spine_node")
    if self.m_UILoadPoint == nil or gs.GoUtil.IsTransNull(self.m_UILoadPoint) then
        logError("Q版模型缺少 Spine_node 挂点，请找俭城  " .. self.m_prefabName)
    end

    if self.m_ani then
        self:setPreLoadAnisByHashList(DormitoryCost.ACT_LIST, self.mLoadFinishCall)

        local function playWalkAudio(clipName)
            local mFsSoundPath = DormitoryCost.getRandomFSSount()
            if mFsSoundPath then
                -- 播放脚步声
                self:playAuido(mFsSoundPath)
            end
        end
        self.m_ani:AddFrameCallEvent("Qwalk_Audio", playWalkAudio)
    else
        logError("this model no animator,prefabName is " .. self.m_prefabName)
    end

    --添加通用碰撞
    self:addAssembly("arts/character/pet/QModelCollider_00/QModelCollider_00.prefab", nil, function (assembly)
        if assembly then
            local mouseEvent = assembly.m_model:AddComponent(ty.GoMouseEvent)
            mouseEvent:SetCallFun(self, nil, self.onPointDownHandler, self.onPointerUpHandler, self.onPointerExitHandler)

            self.mCollider = assembly
        end
    end)

    --添加气泡监听
    self:addBubbleActEvent()
end

function addEventListener(self)
    GameDispatcher:addEventListener(EventName.DORMITORY_GOONLIVEAI, self.startAI, self)
    GameDispatcher:addEventListener(EventName.MAIN_EXPLORE_JOYSTICK_UPDATE, self.onControlMove, self)
    GameDispatcher:addEventListener(EventName.DORMITORY_EXITCONTROLLERLIVEMOVE, self.onExitController, self)
    GameDispatcher:addEventListener(EventName.DORMITORY_LIVEINTER, self.onLiveInter, self)
    GameDispatcher:addEventListener(EventName.DORMITORY_CONTROLLERLIVEMOVE, self.onStartController, self)

end

function removeEventListener(self)
    GameDispatcher:removeEventListener(EventName.DORMITORY_GOONLIVEAI, self.startAI, self)
    GameDispatcher:removeEventListener(EventName.MAIN_EXPLORE_JOYSTICK_UPDATE, self.onControlMove, self)
    GameDispatcher:removeEventListener(EventName.DORMITORY_EXITCONTROLLERLIVEMOVE, self.onExitController, self)
    GameDispatcher:removeEventListener(EventName.DORMITORY_LIVEINTER, self.onLiveInter, self)
    GameDispatcher:removeEventListener(EventName.DORMITORY_CONTROLLERLIVEMOVE, self.onStartController, self)
end

--继续AI
function startAI(self)
    if dormitory.DormitoryManager:getCurControllerLiveTid() == self.m_liveTid then
        return
    end
    if self.mIsBringUp then
        return
    end
    if self.mQRoleAI then
        self.mQRoleAI:startAI()
    end
end

-- 设置宿舍战员AI
function setQRoleAI(self, cusIns)
    self.mQRoleAI = cusIns
end

function addAssembly(self, prefabPath, beAlwayEft, finishCall)
    self.m_assemblyPathDic[prefabPath] = false

    if self.m_model == nil or self.m_loadSn ~= 0 then return end

    local liveAssembly = model.modelItem.new()
    table.insert(self.m_assemblylist, liveAssembly)

    local function _resultCall(beSucss)
        if beSucss then
            local charAppend = liveAssembly.m_model:GetComponent(ty.CharAppendEffect)
            if charAppend then
                charAppend.CharSet = self.m_model
            end
            if finishCall then
                finishCall(liveAssembly)
            end
        else
            self:removeAssembly(prefabPath)
        end
    end

    liveAssembly:setupPrefab(prefabPath, beAlwayEft, _resultCall, 5)
    liveAssembly:setToParent(self.m_trans)
    liveAssembly:setModelGoName("collider")
    liveAssembly:setPreLoadAnisByHashList(DormitoryCost.ACT_LIST)
end

--复写动画播放函数
function playAction(self, aniHash, startCall, endCall)
    super.playAction(self, aniHash, startCall, endCall)

    if self.mCollider then
        self.mCollider:playAction(aniHash)
    end

    local isOnState = false
    for k, v in pairs(DormitoryCost.NEED_BUBBLE_HASH_ARRAY) do
        if aniHash == DormitoryCost.ACT_SHOW_IDLE then
            isOnState = true
            break
        end
    end
    if isOnState == false then
        GameDispatcher:dispatchEvent(EventName.DORMITORY_HIDELIVEBULLE, self.m_liveTid)
    end
end

--添加气泡动作监听
function addBubbleActEvent(self)
    for k, clipName in pairs(DormitoryCost.NEED_BUBBLE_HASH_ARRAY) do
        self.m_ani:AddFrameCallEvent(clipName, function (_clipName)
            ---第一次播动画不冒气泡
            if self.isFirstBulle < 2 then
                self.isFirstBulle = self.isFirstBulle + 1
                return
            end

            if _clipName == DormitoryCost.QWALK then
                self:sentShowBubble(DormitoryCost.LIVESTATE_RUN)
            elseif _clipName == DormitoryCost.QSTAND then
                self:sentShowBubble(DormitoryCost.LIVESTATE_STAND)
            elseif _clipName == DormitoryCost.QTAB then
                self:sentShowBubble(DormitoryCost.LIVESTATE_CLICK)
            elseif _clipName == DormitoryCost.QBEDWARD_R_ING or _clipName == DormitoryCost.QBEDWARD_L_ING then
                self:sentShowBubble(DormitoryCost.LIVESTATE_INTERACT)
            elseif _clipName == DormitoryCost.QTAB then
                self:sentShowBubble(DormitoryCost.LIVESTATE_OTHER)
            end
        end, 2)
    end
end

function sentShowBubble(self, state)
    if dormitory.DormitoryManager:getCurControllerLiveTid() == self.m_liveTid then return end
    local curTime = GameManager:getClientTime()
    if curTime - self.lateBubbleTime >= sysParam.SysParamManager:getValue(SysParamType.DORMITORY_BUBBLECDTIME) then
        self.lateBubbleTime = curTime
        GameDispatcher:dispatchEvent(EventName.DORMITORY_SETLIVEBULLETXT, {liveTid = self.m_liveTid, ai_state = state, modelTran = self.m_UILoadPoint})
    end
end

--交互
function onLiveInter(self, liveTid)
    if self.m_liveTid ~= liveTid then return end

    if not self.m_ani:IsPlayingShortNameHash(DormitoryCost.ACT_SHOW_TAB) then
        self:playAction(DormitoryCost.ACT_SHOW_TAB)
        self:playAuido("ui_dor_click_voice.prefab")
    end
end

--加入开始移动
function onStartController(self)
    self:updateInteractState()
end

--退出移动控制
function onExitController(self)
    if dormitory.DormitoryManager:getCurControllerLiveTid() ~= self.m_liveTid then
        return
    end
    if not self.m_ani:IsPlayingShortNameHash(DormitoryCost.ACT_SHOW_STAND) then
        self:playAction(DormitoryCost.ACT_SHOW_STAND)
    end
end

--控制移动
function onControlMove(self, args)
    if dormitory.DormitoryManager:getCurControllerLiveTid() ~= self.m_liveTid then return end

    --开始移动
    if args.deltaRatioX == 0 and args.deltaRatioY == 0 then
        if not self.m_ani:IsPlayingShortNameHash(DormitoryCost.ACT_SHOW_STAND) and not self:getIsOnInterAct() then
            self:playAction(DormitoryCost.ACT_SHOW_STAND)
        end
    else
        if not self.m_ani:IsPlayingShortNameHash(DormitoryCost.ACT_SHOW_WALK) then
            self:playAction(DormitoryCost.ACT_SHOW_WALK)
        end

        local sceneCameraTrans = gs.CameraMgr:GetSceneCameraTrans()
        local dir = sceneCameraTrans:TransformDirection(gs.Vector3(args.deltaRatioX, 0, args.deltaRatioY))

        if dir.x ~= 0 or dir.y ~= 0 or dir.z ~= 0 then
            local targetRotation = gs.Quaternion.LookRotation(dir)
            if gs.Quaternion.Angle(self.m_trans.rotation, targetRotation) > 1 then
                local rotation = gs.Quaternion.Slerp(self.m_trans.rotation, targetRotation, self.m_rotateSpeed * args.deltaTime)
                gs.TransQuick:SetRotation(self.m_trans, 0, rotation.eulerAngles.y, 0)
            end
        end

        --拿到的是当前朝向往前一个格子的世界坐标
        local nextPos = self.m_trans:TransformPoint(gs.Vector3(0, 0, DormitoryCost.TITE_SIZE))
        --判断面前的下一个格子是否可以行走
        if self:getCanMove(nextPos) then
            self.m_trans:Translate(0, 0, args.deltaTime * self.moveSpeed)

            local nextTile = self:getCanMove(self.m_trans.position)
            if nextTile ~= nil then
                self:setCurTile(nextTile)
                self.m_position:copy(self.m_trans.localPosition)
                self:updateInteractState()
            end
        end

        -- -- 测试用
        -- -- nextPos = self.m_trans:TransformPoint(gs.Vector3(0, 0, 0))
        -- nextTile = self:getCanMove(nextPos)
        -- if nextTile ~= nil then
        --     if not self.testObj then
        --         self.testObj = gs.GameObject()
        --     end
        --     self.testObj.name = nextTile.col .. " __ " .. nextTile.row

        --     local floorTileRoot = gs.GameObject.Find(DormitoryCost.FLOOR_TILE_ROOT)
        --     local floorTileRootTrans = floorTileRoot.transform
        --     local pos = floorTileRootTrans:TransformPoint(gs.Vector3(0.3*(nextTile.col-1),0,0.3*(nextTile.row-1)))
        --     self.testObj.transform.position = pos
        -- end
    end
end

--更新当前位置是不是可以交互
function updateInteractState(self)
    if dormitory.DormitoryManager:getCurControllerLiveTid() ~= self.m_liveTid then return end

    local interactData = dormitory.DormitorySceneController.roomScene:getCollideInteractPoint(gs.Vector3(self.m_position.x, 0, self.m_position.z))
    local active = interactData ~= nil

    GameDispatcher:dispatchEvent(EventName.DORMITORT_UPDATAMOVEINTERACTDATA, {active = active, interactData = interactData})
end

--根据位置获取地面的格子 判断是不是可以行走
function getCanMove(self, pos)
    local floorTileRoot = gs.GameObject.Find(DormitoryCost.FLOOR_TILE_ROOT)
    if gs.GoUtil.IsGoNull(floorTileRoot) == nil then return nil end

    local floorTileRootTrans = floorTileRoot.transform
    local pos = floorTileRootTrans:InverseTransformPoint(pos)

    local col = math.ceil(pos.x / DormitoryCost.TITE_SIZE)
    local row = math.ceil(pos.z / DormitoryCost.TITE_SIZE)
    if col <= 0 or col > DormitoryCost.COL_COUNT then return nil end
    if row <= 0 or row > DormitoryCost.ROW_COUNT then return nil end

    -- local tile = dormitory.DormitorySceneController:getTile(DormitoryCost.SITE_FLOOR, col, row)
    -- local type, id = tile:getState2()
    -- if id == 0 or id == self.m_liveTid then
    --     return { col = col, row = row }
    -- end
    -- return nil

    if self.mQRoleAI:checkTileIsCanMove(col, row) then
        return {col = col, row = row}
    end

    return nil
end

-- 移走
function onPointerExitHandler(self)
    LoopManager:removeFrame(self, self.onBringUpHandler)
    dormitory.DormitoryController:onLiveThingBring()
end

-- 鼠标按下
function onPointDownHandler(self)
    if dormitory.DormitoryManager:getCurControllerLiveTid() then
        return
    end
    if self.mIsBringUp then
        return
    end
    if self.mQRoleAI then
        self.mQRoleAI:resetMove()
    end
    if self.mInteractState ~= nil then
        self:stopInteract()
    else
        if not self.m_ani:IsPlayingShortNameHash(DormitoryCost.ACT_SHOW_TAB) then
            self:playAction(DormitoryCost.ACT_SHOW_TAB)
            self:playAuido("ui_dor_click_voice.prefab")

            self:playAuido("ui_dor_click.prefab")

            -- 面向镜头
            local cameraTrans = gs.CameraMgr:GetSceneCameraTrans()
            local cameraPos = self.m_trans.parent:InverseTransformPoint(cameraTrans.position)
            self:turnDirByVector(cameraPos, false)
        end
    end

    --提起逻辑
    if not self.mClientClickTime then
        self.mClientClickTime = GameManager:getClientTime()
    else
        if GameManager:getClientTime() < self.mClientClickTime + 1 then
            return
        else
            self.mClientClickTime = GameManager:getClientTime()
        end
    end
    if dormitory.DormitoryManager:getCurControllerLiveTid() then return end

    if self.mQRoleAI then
        self.mQRoleAI:resetMove()
    end
    self.onMouseDownTime = 0
    LoopManager:addFrame(1, 0, self, self.onBringUpHandler)
end

-- 鼠标按下释放
function onPointerUpHandler(self)
    dormitory.DormitoryController:onLiveThingBring()

    LoopManager:removeFrame(self, self.onBringUpHandler)
    LoopManager:removeFrame(self, self.onBringUpFrame)

    if not self.mIsBringUp then
        if not dormitory.DormitoryManager:getCurControllerLiveTid() and self.mInteractState == nil then
            if self.onMouseDownTime ~= nil and self.onMouseDownTime < self.showOnBringTime then
                GameDispatcher:dispatchEvent(EventName.DORMITORY_CLICKLIVE, self.m_liveTid)
                if self.mQRoleAI then
                    self.mQRoleAI:stopAI()
                end
            end
        end
        return
    end

    self.mIsBringUp = false
    self:setGridState(false)
    self:playAction(DormitoryCost.ACT_SHOW_DOWN)
    self:playAuido("ui_dor_put.prefab")
    self:playAuido("ui_dor_put_voice.prefab")

    self:freedInteract()
    self:startAI()

    GameDispatcher:dispatchEvent(EventName.DORMITORY_HERO_MOVE_END)
end

-- 提起来
function onBringUpHandler(self)
    if self.onMouseDownTime >= 1 then
        dormitory.DormitoryController:onLiveThingBring()

        if not self.mIsBringUp then
            self.mIsBringUp = true
            if self.mQRoleAI then
                self.mQRoleAI:stopAI()
            end
            self:setGridState(true)

            local cameraTrans = gs.CameraMgr:GetToScreenSceneCamera().transform
            local cameraPos = self.m_trans.parent:InverseTransformPoint(cameraTrans.position)
            local dir = (self.m_position - cameraPos)
            local angle = math.get_angle_ignoreY(math.Vector3.BACK, dir)
            self:setAngle(angle + 90, false)

            local lpos = gs.Vector3(self.m_position.x, 0.3, self.m_position.z)
            self:setPosition(lpos)

            self:playAction(DormitoryCost.ACT_SHOW_SHIFT)
            self:resetInterActPoint()
            self:playAuido("ui_dor_carry.prefab")
            self:playAuido("ui_dor_carry_voice.prefab")

            GameDispatcher:dispatchEvent(EventName.DORMITORY_HERO_MOVE_START)
            LoopManager:removeFrame(self, self.onBringUpHandler)

            LoopManager:addFrame(1, 0, self, self.onBringUpFrame)
        end

        self:removeTileInfo()
    else
        self.onMouseDownTime = self.onMouseDownTime + gs.Time.deltaTime
        if self.onMouseDownTime >= self.showOnBringTime then
            dormitory.DormitoryController:onLiveThingBring(self.onMouseDownTime, true, self.m_UILoadPoint)
        end
    end
end

-- 提起来的帧事件
function onBringUpFrame(self)
    local sceneCamera = gs.CameraMgr:GetToScreenSceneCamera()
    local hitInfo = gs.UnityEngineUtil.RaycastByUICamera(sceneCamera, DormitoryCost.TILE_LAYER_NAME, 100)
    if hitInfo and hitInfo.collider then
        local tileGo = hitInfo.collider.gameObject
        local pos = hitInfo.point

        local lpos = self.m_trans.parent.transform:InverseTransformPoint(pos)
        local c = math.floor(lpos.x / DormitoryCost.TITE_SIZE)
        local r = math.floor(lpos.z / DormitoryCost.TITE_SIZE)

        if c - 1 <= 0 then
            c = 2
        end
        if c + 1 > DormitoryCost.COL_COUNT then
            c = DormitoryCost.COL_COUNT
        end
        if r - 1 <= 0 then
            r = 2
        end
        if r + 1 > DormitoryCost.ROW_COUNT then
            r = DormitoryCost.ROW_COUNT
        end

        local tile = dormitory.DormitorySceneController:getTile(DormitoryCost.SITE_FLOOR, c, r)
        local pos = tile:getPosition()
        local movePos = gs.Vector3(pos.x, 0.5, pos.z)
        self.mCurTile = {col = c, row = r}
        self:setPosition(movePos)
        self:resetInterActPoint()

        --更新家具交互状态
        self:rereshInteractOutLineState()
    end
end

--更新家具交互状态描边
function rereshInteractOutLineState(self)
    if self.mCurTile then
        local outLineFurniture = nil
        local outLineState = 0 --0红色，1白色

        local lpos = gs.Vector3(self.m_position.x, 0, self.m_position.z)

        local endCol = self.mCurTile.col + 1
        local endRow = self.mCurTile.row + 1
        local startCol = self.mCurTile.col - 1
        local startRow = self.mCurTile.row - 1

        local isBreak = false
        for c = startCol, endCol do
            for r = startRow, endRow do
                local tile = dormitory.DormitorySceneController:getTile(DormitoryCost.SITE_FLOOR, c, r)
                if tile then
                    local type, id = tile:getState2()
                    if type == 1 then
                        local furnitureObj = dormitory.DormitorySceneController.roomScene:getFurnitureById(id)
                        if furnitureObj then
                            local interactPoint = furnitureObj:getCanActionPoint(lpos)
                            if interactPoint and interactPoint.actName ~= nil and #interactPoint.actName >= 4 then
                                outLineState = 1
                            else
                                outLineState = 0
                            end
                            outLineFurniture = furnitureObj

                            isBreak = true
                            break
                        end
                    end
                end
            end
            if isBreak then break end
        end

        if outLineFurniture then
            if outLineState == 0 then
                outLineFurniture:SetOutLineColor_highlightState("FF0000FF")
            elseif outLineState == 1 then
                outLineFurniture:SetOutLineColor_highlightState("FFFFFFFF")
            end
        end

        if self.m_OutLineFurniture ~= nil and self.m_OutLineFurniture ~= outLineFurniture then
            self.m_OutLineFurniture:SetOutLineColor_normalState()
        end

        self.m_OutLineFurniture = outLineFurniture
    end
end

-- 释放交互
function freedInteract(self)
    if self.mCurTile then
        local lpos = gs.Vector3(self.m_position.x, 0, self.m_position.z)

        local endCol = self.mCurTile.col + 1
        local endRow = self.mCurTile.row + 1
        local startCol = self.mCurTile.col - 1
        local startRow = self.mCurTile.row - 1

        local isBreak = false
        local isCanSetPos = true
        for c = startCol, endCol do
            for r = startRow, endRow do
                local tile = dormitory.DormitorySceneController:getTile(DormitoryCost.SITE_FLOOR, c, r)
                if tile then
                    local type, id = tile:getState2()
                    if type == 1 then
                        local furnitureObj = dormitory.DormitorySceneController.roomScene:getFurnitureById(id)
                        if furnitureObj then
                            local interactPoint = furnitureObj:getCanActionPoint(lpos)
                            if interactPoint and (table.empty(interactPoint.actName) or table.nums(interactPoint.actName) < 4) then
                                logError("这个挂点配置少了" .. furnitureObj:getResName())
                            end

                            if interactPoint and interactPoint.actName ~= nil and #interactPoint.actName >= 4 then
                                self:setInteractFurnitruePoint(interactPoint)
                                self:startInteract(interactPoint.actName[2])
                                isCanSetPos = false
                            else
                                local tileData = self:getTileData(self.mCurTile.col, self.mCurTile.row, self.m_liveTid)
                                if tileData then
                                    self.mCurTile.col = tileData.col
                                    self.mCurTile.row = tileData.row
                                else
                                    self.mCurTile.col = self:getCurTile().col
                                    self.mCurTile.row = self:getCurTile().row
                                end
                            end
                        end
                        isBreak = true
                        break
                    elseif type == 2 and id ~= 0 and id ~= self.m_liveTid then
                        -- 挤走其他小人
                        local ai = dormitory.DormitoryAIManager:getQRoleAI(id)
                        ai:removeTileRoleInfo()

                        self:setCurTile({col = self.mCurTile.col, row = self.mCurTile.row})

                        local tileData = self:getTileData(self.mCurTile.col, self.mCurTile.row, id)
                        ai:setRoleToTile({col = tileData.col, row = tileData.row})
                        isBreak = true
                        break
                    end
                end
            end
            if isBreak then break end
        end
        if isCanSetPos then
            local newTile = dormitory.DormitorySceneController:getTile(DormitoryCost.SITE_FLOOR, self.mCurTile.col, self.mCurTile.row)
            if newTile then
                lpos = newTile:getTileRolePos()
            end
            self:setPosition(lpos)
            self:setCurTile({col = self.mCurTile.col, row = self.mCurTile.row})
        end

        if self.m_OutLineFurniture ~= nil then
            self.m_OutLineFurniture:SetOutLineColor_normalState()
        end
    end
end

--设置当前站员正在交互中
function setIsOnInterAct(self, value)
    self.isOnInterAct = value
end

function getIsOnInterAct(self)
    return self.isOnInterAct
end

--同家具交互
function startInteract(self, actName)
    if not self.mCurInteractPointData then
        return
    end

    --释放占用的格子
    self:setCurTile(nil)
    self:setIsOnInterAct(true)

    local floorTran = gs.GameObject.Find(DormitoryCost.SITE_ROOT_LIST[DormitoryCost.SITE_FLOOR]).transform
    self:setPosition(floorTran:InverseTransformPoint(self.mCurInteractPointData.point.position))
    self:setAngle(self.mCurInteractPointData.point.eulerAngles.y, true)

    actName = actName or self.mCurInteractPointData.actName[1]
    self:playAction(gs.Animator.StringToHash(actName))

    self.mIsStopInterAct = false
    local clipName = ""
    local frameCount = 0

    --每一个阶段开始的时候
    for i = 1, DormitoryCost.INTERACTEND do
        clipName = self.mCurInteractPointData.actName[i]
        self.m_ani:AddFrameCallEvent(clipName, function (_clipName)
            self.mInteractState = i

            if self.mInteractState == DormitoryCost.INTERACTEND then
                self:setCurTile({col = self.mCurInteractPointData.col, row = self.mCurInteractPointData.row})
            end

            if dormitory.DormitoryManager:getCurControllerLiveTid() == self.m_liveTid then
                if self.mInteractState == DormitoryCost.JUMP then
                    GameDispatcher:dispatchEvent(EventName.DORMITORT_UPDATAMOVEINTERACTDATA, {active = false})
                elseif self.mInteractState == DormitoryCost.LIE then
                    GameDispatcher:dispatchEvent(EventName.DORMITORT_UPDATAMOVEINTERACTDATA, {active = false})
                elseif self.mInteractState == DormitoryCost.INTERACTING then
                    self:onStopInteract()
                    GameDispatcher:dispatchEvent(EventName.DORMITORT_UPDATAMOVEINTERACTDATA, {active = true})
                elseif self.mInteractState == DormitoryCost.INTERACTEND then
                    GameDispatcher:dispatchEvent(EventName.DORMITORT_UPDATAMOVEINTERACTDATA, {active = false})
                end
            end
        end, 1)
    end

    --交互动作完成
    clipName = self.mCurInteractPointData.actName[3]
    frameCount = self:GetTotalFrameCount(clipName)
    self.m_ani:AddFrameCallEvent(clipName, function (_clipName)
        local tile = dormitory.DormitorySceneController:getTile(DormitoryCost.SITE_FLOOR, self.mCurInteractPointData.col, self.mCurInteractPointData.row)
        if tile then
            local type, id = tile:getState2()
            -- logAll(id,tile.mCol .. "_" .. tile.mRow .. "的格子状态")
            if id ~= 0 and id ~= self.m_liveTid then
                --继续睡
                self:playAction(gs.Animator.StringToHash(self.mCurInteractPointData.actName[3]))
            else
                local randomIndex = math.random(1, 2)
                if randomIndex <= 1 then
                    --继续睡
                    self:playAction(gs.Animator.StringToHash(self.mCurInteractPointData.actName[3]))
                end
            end
        end
    end, frameCount)

    --交互完成
    clipName = self.mCurInteractPointData.actName[4]
    frameCount = self:GetTotalFrameCount(clipName)
    self.m_ani:AddFrameCallEvent(clipName, function (_clipName)
        self:forceStopInteract()
    end, frameCount)
end

--强行停止交互
function forceStopInteract(self)
    if self.mQRoleAI then
        if not self.mCurInteractPointData then return end

        self:setIsOnInterAct(false)

        if dormitory.DormitoryManager:getCurControllerLiveTid() == nil then
            --放回到寻路的格子上去，不然寻路不了。
            self.mQRoleAI:setRoleToTile({col = self.mCurInteractPointData.col, row = self.mCurInteractPointData.row})
            self.mQRoleAI:onAIStep()
        end

        self:resetInterActPoint()
        self:updateInteractState()

        if dormitory.DormitoryManager:getCurControllerLiveTid() == self.m_liveTid then
            GameDispatcher:dispatchEvent(EventName.DORMITORY_INTERACT_FINISH)
        end
    end
end

--停止交互
function stopInteract(self)
    self.mIsStopInterAct = true
    self:onStopInteract()
end

--停止同家具交互
function onStopInteract(self)
    if self.mInteractState == DormitoryCost.INTERACTING and self.mIsStopInterAct == true then
        if self:isCanStopInteract() then
            self:playAction(gs.Animator.StringToHash(self.mCurInteractPointData.actName[4]))
        end
    end
end

--是否可以停止交互
function isCanStopInteract(self)
    local tile = dormitory.DormitorySceneController:getTile(DormitoryCost.SITE_FLOOR, self.mCurInteractPointData.col, self.mCurInteractPointData.row)
    if tile then
        local type, id = tile:getState2()
        if id == 0 or id == self.m_liveTid then
            return true
        end
    end
end

--当前正在交互的点的数据
function setInteractFurnitruePoint(self, pointData)
    if self.isOnInterAct then return end

    self:resetInterActPoint()
    self.mCurInteractPointData = pointData
    self.mCurInteractPointData.heroTid = self.m_liveTid
end

function getInterActFurnitruePoint(self)
    return self.mCurInteractPointData
end

--重置交互完，归还
function resetInterActPoint(self)
    if not self.mCurInteractPointData then return end
    self:setIsOnInterAct(false)

    self.mCurInteractPointData.heroTid = 0
    self.mCurInteractPointData = nil
    self.mInteractState = nil
end

-- 获取可用的tile
function getTileData(self, col, row, id)
    local index = 0
    local function getTile()
        local min_col = col - index
        local max_col = col + index

        local min_row = row - index
        local max_row = row + index
        --▷
        if max_col <= DormitoryCost.COL_COUNT then
            for c = min_col, max_col do
                local canMove = dormitory.DormitoryManager:getIsCanMove({col = c, row = max_row}, id)
                if canMove then
                    return {col = c, row = max_row}
                end
            end
        end

        --▽
        if min_row >= 0 then
            for r = max_row, min_row, -1 do
                local canMove = dormitory.DormitoryManager:getIsCanMove({col = max_col, row = r}, id)
                if canMove then
                    return {col = max_col, row = r}
                end
            end
        end

        --◁
        if min_col >= 0 then
            for c = max_col, min_col, -1 do
                local canMove = dormitory.DormitoryManager:getIsCanMove({col = c, row = min_row}, id)
                if canMove then
                    return {col = c, row = min_row}
                end
            end
        end

        --△
        if max_row <= DormitoryCost.ROW_COUNT then
            for r = min_row, max_row do
                local canMove = dormitory.DormitoryManager:getIsCanMove({col = min_col, row = r}, id)
                if canMove then
                    return {col = min_col, row = r}
                end
            end
        end

        local maxIndex = DormitoryCost.COL_COUNT > DormitoryCost.ROW_COUNT and DormitoryCost.COL_COUNT or DormitoryCost.ROW_COUNT
        if index > maxIndex then
            return index
        end
        index = index + 1
        return getTile()
    end

    local tileData = getTile()
    if type(tileData) == "number" then
        print("====找不到位置,回去原来的地方====")
        return nil
    end

    return tileData
end

-- 设置网格显示状态(用来检测鼠标位置)
function setGridState(self, isActive)
    -- for i = 1, #DormitoryCost.SITE_WALL_LIST do
    --     local girdGo = gs.GameObject.Find("tile").transform:Find(DormitoryCost.TILE_NAME_LIST[DormitoryCost.SITE_WALL_LIST[i]]).gameObject
    --     girdGo:GetComponent(ty.MeshRenderer).enabled = not isActive
    --     girdGo:SetActive(isActive)
    -- end

    local girdGoFloor = gs.GameObject.Find("tile").transform:Find(DormitoryCost.TILE_NAME_LIST[DormitoryCost.SITE_FLOOR]).gameObject
    girdGoFloor:GetComponent(ty.MeshRenderer).enabled = not isActive
    girdGoFloor:SetActive(isActive)

    -- local girdGoTop = gs.GameObject.Find("tile").transform:Find(DormitoryCost.TILE_NAME_LIST[DormitoryCost.SITE_TOP]).gameObject
    -- girdGoTop:GetComponent(ty.MeshRenderer).enabled = not isActive
    -- girdGoTop:SetActive(isActive)
end

-- 边界判断
function isOutBorder(self, cusTile)
    if cusTile.col - 1 <= 0 or cusTile.col + 1 > DormitoryCost.COL_COUNT then
        return 1
    end
    if cusTile.row - 1 <= 0 or cusTile.row + 1 > DormitoryCost.ROW_COUNT then
        return 2
    end
    return 0
end

-- 获取角色当前占领的格子
function getCurTile(self)
    if self.mQRoleAI then
        return self.mQRoleAI:getRoleCurTile()
    end
end

-- 设置角色当前占有格子
function setCurTile(self, cusTile)
    if self.mQRoleAI then
        self.mQRoleAI:setRoleCurTile(cusTile)
    end
end

-- 解除格子战员占位占有
function removeTileInfo(self)
    if self.mQRoleAI then
        self.mQRoleAI:removeTileRoleInfo()
    end
end

-- 设置坐标位置
function setPosition(self, lpos)
    if not lpos then return end
    if self.m_position == lpos then return end
    self.m_position:copy(lpos)
    if self.m_trans and lpos then
        gs.TransQuick:LPos(self.m_trans, self.m_position.x, self.m_position.y, self.m_position.z)
        GameDispatcher:dispatchEvent(EventName.DORMITORY_UPDATEBULLEPOS, {liveTid = self.m_liveTid, modelTran = self.m_trans})
    end
end

-- 转向某个位置
function turnDirByVector(self, cusPosition, cusNow)
    if self.m_position:equals(cusPosition) then
        return
    end

    local dir = (self.m_position - cusPosition)
    local angle = math.get_angle_ignoreY(math.Vector3.BACK, dir)
    self:setAngle(angle, cusNow)
end

-- 设置角度
function setAngle(self, angle, isNow)
    if isNow then
        self:stopTurnAngle()
        self.m_angle = angle
        gs.TransQuick:SetRotation(self.m_trans, 0, angle, 0)
    else
        if angle ~= self.m_angle then
            self:stopTurnAngle()
            self.m_angle = angle

            local targetRotation = gs.Quaternion.Euler(gs.Vector3(0, self.m_angle, 0))
            self.m_rotationFrameSn = LoopManager:addFrame(1, 0, self, function ()
                local rotation = gs.UnityEngineUtil.Quaternion_Slerp(self.m_trans, targetRotation, self.m_rotateSpeed * LoopManager:getDeltaTime())
                gs.TransQuick:SetRotation(self.m_trans, 0, rotation.eulerAngles.y, 0)

                if rotation.eulerAngles.y > self.m_angle - 0.1 and rotation.eulerAngles.y < self.m_angle + 0.1 then
                    self:stopTurnAngle()
                end
            end)
        end
    end
end

-- 停止转向
function stopTurnAngle(self)
    if self.m_rotationFrameSn ~= nil then
        LoopManager:removeFrameByIndex(self.m_rotationFrameSn)
        self.m_rotationFrameSn = nil
    end
end

-- 清除模型
function clearModel(self)
    self:removeEventListener()
    LoopManager:removeFrame(self, self.onBringUpHandler)
    LoopManager:removeFrame(self, self.onBringUpFrame)
    dormitory.DormitoryController:onLiveThingBring()

    self.isFirstBulle = 0
    self.lateBubbleTime = 0
    self.mCollider = nil
    self:clearAudio()
    self:stopTurnAngle()
    super.clearModel(self)
end

--播放音效
function playAuido(self, audioName)
    local audioData = nil
    local finishCall = function()
        if audioData then
            self.audioDataDic[audioData.m_snId] = nil
        end
    end
    audioData = AudioManager:playSoundEffect(UrlManager:getDormSoundPath(audioName), false, nil, self.m_trans, finishCall)
    if audioData then
        self.audioDataDic[audioData.m_snId] = audioData
    end
end

--清理音效
function clearAudio(self)
    for k, v in pairs(self.audioDataDic) do
        AudioManager:stopAudioSound(v)
    end
    self.audioDataDic = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
