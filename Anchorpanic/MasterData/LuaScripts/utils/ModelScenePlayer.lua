module("ModelScenePlayer", Class.impl())

-- 为组件加入侦听点击事件
function addOnClick(self, obj, callBack, soundPath, ...)
    if obj == nil then
        error('obj is nil', 2)
    end
    local params = nil
    if select("#", ...) > 0 then
        params = { ... }
    end
    local func = function()
        if (soundPath == nil) then
            AudioManager:playSoundEffect(UrlManager:getUIBaseSoundPath("ui_basic_click.prefab"))
        else
            AudioManager:playSoundEffect(soundPath)
        end
        if params then
            callBack(self, unpack(params))
        else
            callBack(self)
        end
    end
    gs.UIComponentProxy.AddListener(obj, func)
end

-- 为组件移除侦听点击事件
function removeOnClick(self, obj)
    gs.UIComponentProxy.RemoveListener(obj)
end

function ctor(self)
    self:__initData()
end

function __initData(self)
    -- 旋转速度，0~1
    self.m_rotateSpeed = 0.5
    -- 最大帧旋转速度差
    self.m_maxFrameRotateSpeed = 10
    -- 当前帧旋转速度差
    self.m_frameRotateSpeed = 0
    -- 旋转的角度显示
    self.m_anglesMinAndMax = gs.Vector2(0, 0)
    -- 初始旋转的角度
    self.m_initAngle = 180
    -- 当前旋转的角度
    self.m_angle = gs.Vector3(0, 0, 0)
    -- 当前的鼠标坐标
    self.mBeginMousePos = gs.Vector3(0, 0, 0)

    self.m_isLoaded = nil
    self.m_actionName = nil
    self.m_showType = nil
    self.m_showBgPath = nil
    self.m_isCanRotate = nil

    self.m_modelView = nil
    self.m_clickGo = nil
    self.m_frameSn = nil

    self.m_lampStandPath = nil

    self.currZ = nil
    self.currY = nil
    self.currX = nil
    self.spineNode = nil

    self.oldPosition1 = { x = 0, y = 0, z = 0 } --双指缩放  上一次手指1的位置
    self.oldPosition2 = { x = 0, y = 0, z = 0 } --双指缩放  上一次手指2的位置 

    self.mScaleTimes = 0

    -- 转动速度
    self.mAroundSpeed = 0
    self.mMoveYSpeed = 0
    self.mIsMoveZMax = false

    self.mMoveDis = 0
    -- 缓动列表
    self.mTweenList = {}

    -- 能否缩放
    self.isCanScale = false

    -- 进场动作需要等待动作完成才可以缩放的模型id列表
    self.mWaitActionModels = { "4510", "4510_2", "4511", "4508_3", "4511_2", "4514", "4514_2", "4515", "4515_2", "3108_3", "4516", "4516_2", "4512_3",
    "4517", "4517_2", "4519", "4519_2", "1105_2", "4520", "4520_2", "4515_3" }
end

function reset(self, isResetMainCity)

    -- if self.mMain10 and self.mMain10Sphere then
    --     self.mMain10Sphere.transform:SetParent(self.mMain10.transform, true)
    --     gs.TransQuick:Pos(self.mMain10Sphere.transform, self.spherePos)
    -- end

    if (self.m_modelView) then
        gs.GoUtil.RemoveComponent(self.m_modelView:getRootGO(), ty.LightRotate)
        self.m_modelView:destroy()
    end

    if (self.m_clickGo) then
        self.m_trigger.onBeginDrag:RemoveAllListeners()
        self.m_trigger.onEndDrag:RemoveAllListeners()
        self.m_trigger.onPointerDown:RemoveAllListeners()
        self.m_trigger.onPointerUp:RemoveAllListeners()
        self.m_trigger.onPointerExit:RemoveAllListeners()
        gs.GoUtil.RemoveComponent(self.m_clickGo, ty.LongPressOrClickEventTrigger)
    end

    if (self.m_frameSn) then
        LoopManager:removeFrameByIndex(self.m_frameSn)
    end

    if (isResetMainCity) then
        Perset3dHandler:toNormalShowData()
    end
    -- if (self:__getLampStandPath()) then
    --     Perset3dHandler:removeLampstandGo(self:__getLampStandPath())
    -- end

    if self.mTouchFrameSn then
        LoopManager:removeFrameByIndex(self.mTouchFrameSn)
        self.mTouchFrameSn = nil
    end

    if (self.m_frameSn) then
        LoopManager:removeFrameByIndex(self.m_frameSn)
        self.m_frameSn = nil
    end

    self:clearTween()

    self:__initData()
end

function __setLampStandPath(self, tid, isMonster)
    -- local color = nil
    -- if not isMonster then
    --     local heroConfigVo = hero.HeroManager:getHeroConfigVo(tid)
    --     color = heroConfigVo and heroConfigVo.color or nil
    -- elseif isMonster then
    --     local monsterConfigVo = monster.MonsterManager:getMonsterVo01(tid)
    --     color = monsterConfigVo and monsterConfigVo.color or nil
    -- end
    -- if(color)then
    --     if(color == ColorType.GREEN)then
    --         self.m_lampStandPath = UrlManager:get3DSceneFx("scene/fx_scene_main_10_qing.prefab")
    --     elseif(color == ColorType.BLUE)then
    --         self.m_lampStandPath = UrlManager:get3DSceneFx("scene/fx_scene_main_10_lan.prefab")
    --     elseif(color == ColorType.VIOLET)then
    --         self.m_lampStandPath = UrlManager:get3DSceneFx("scene/fx_scene_main_10_fen.prefab")
    --     elseif(color == ColorType.ORANGE)then
    --         self.m_lampStandPath = UrlManager:get3DSceneFx("scene/fx_scene_main_10_cheng.prefab")
    --     end
    -- end
end

function __getLampStandPath(self)
    return self.m_lampStandPath
end

-- 战员模型展示（带时装）
function setData(self, heroId, isEffect, weaponIndex, isUIAction, showType, showBgPath, clickGo, isClickAction, finishCall)
    Perset3dHandler:setupShowData(showType, nil, nil, showBgPath)
    self:__setLampStandPath(heroId, false)
    local function __finishCall()
        self.m_isLoaded = true
        -- 修改层级为Ground才有阴影，战斗中的用Role
        self.m_modelView:setDisplayLayer("Ground")
        -- self:__updateRefreshEffect()
        self:__updateShowType()
        self:__updateAction()
        self:__updateScale()
        self:__updateRotation()
        -- self:__updateCameraPos(showType)
        if (finishCall) then
            finishCall()
        end
    end
    if (self.m_isLoaded) then
        if (self.m_modelView.heroId == heroId) then
            __finishCall()
        else
            self.m_modelView:setModeType(showType)
            self.m_modelView:setHeroId(heroId, isEffect, weaponIndex, __finishCall)
        end
    else
        if (self.m_modelView) then
            if (self.m_modelView.heroId ~= heroId) then
                self.m_modelView:clearModel()
            end
        else
            self:__addClickEven(clickGo, isClickAction)
            self.m_modelView = fight.LiveView.new()
        end
        if (self.m_modelView.heroId ~= heroId) then
            self.m_modelView:setModeType(showType)
            self.m_modelView:setHeroId(heroId, isEffect, weaponIndex, __finishCall)
            self.m_modelView:setDynamicBoneEnable(not GameManager:getIsInCommiting())
        end
    end

    -- if (isUIAction) then
    --     self:setAction(fight.FightDef.ACT_SHOW_STAND)
    -- else
    --     self:setAction(fight.FightDef.ACT_STAND)
    -- end
    -- local heroVo = hero.HeroManager:getHeroVo(heroId)
    -- if heroVo and table.indexof(self.mWaitActionModels, heroVo:getUIModel()) ~= false then
    local finishCall = function()
        self.isCanScale = true
        self:__updateCameraPos()
    end
    self.m_modelView:setStartActionFinishCall(finishCall)
    -- else
    --     self.isCanScale = true
    -- end
    -- self.m_modelView:playStartAction()
    self:setShowType(showType, showBgPath)
end

-- 战员和怪物模型展示（不和身上的时装挂钩）
function setModelData(self, modelId, isMonster, isEffect, weaponIndex, isUIAction, showType, showBgPath, clickGo, isClickAction, finishCall)
    if isMonster then
        -- 怪物默认无武器
        weaponIndex = nil
    end
    Perset3dHandler:setupShowData(showType, nil, nil, showBgPath)
    self:__setLampStandPath(modelId, isMonster)
    local function __finishCall()
        self.m_isLoaded = true
        -- 修改层级为Ground才有阴影，战斗中的用Role
        self.m_modelView:setDisplayLayer("Ground")
        -- self:__updateRefreshEffect()
        self:__updateShowType()
        self:__updateAction()
        self:__updateScale()
        self:__updateRotation()
        -- self:__updateCameraPos(showType)
        if (finishCall) then
            finishCall()
        end
    end
    if (self.m_isLoaded) then
        if (self.m_modelView:getModelId() == modelId) then
            __finishCall()
        else
            self.m_modelView:setModelID(isMonster and 1 or 0, modelId, isEffect, weaponIndex, __finishCall)
            self.m_modelView:setModeType(showType)
        end
    else
        if (self.m_modelView) then
            if (self.m_modelView:getModelId() ~= modelId) then
                self.m_modelView:clearModel()
            end
        else
            self:__addClickEven(clickGo, isClickAction)
            self.m_modelView = fight.LiveView.new()
        end
        if (self.m_modelView:getModelId() ~= modelId) then
            self.m_modelView:setModelID(isMonster and 1 or 0, modelId, isEffect, weaponIndex, __finishCall)
            self.m_modelView:setModeType(showType)
            self.m_modelView:setDynamicBoneEnable(not GameManager:getIsInCommiting())
        end
    end

    -- if table.indexof(self.mWaitActionModels, modelId) ~= false then
    local finishCall = function()
        self.isCanScale = true
        self:__updateCameraPos()
    end
    self.m_modelView:setStartActionFinishCall(finishCall)
    -- else
    --     self.isCanScale = true
    -- end
    -- self.m_modelView:playStartAction()
    self:setShowType(showType, showBgPath)
end

-- 外部设置模型材质球变化
function setMaterial(self, pos, mats, dissolves)
    if self.m_modelView then
        self.m_modelView:updateMaterial(pos, mats, dissolves)
    end
end

function __updateRefreshEffect(self)
    if (self.m_isLoaded) then
        self.m_modelView:removeOtherEft1()
        self.m_modelView:addOtherEft1("arts/fx/3d/scene/fx_ui_common_zhuanhuan.prefab", nil, nil, nil)
    end
end

function getModelTrans(self)
    if (self.m_isLoaded and self.m_modelView) then
        return self.m_modelView:getTrans()
    end
    return nil
end

function setShowType(self, showType, showBgPath)
    if (self.m_showType ~= showType or self.m_showBgPath ~= showBgPath) then
        self.m_showType = showType
        self.m_showBgPath = showBgPath
        self:__updateShowType()
    end
end

function __updateShowType(self)
    local showBgPath = self.m_showBgPath
    local showType = self.m_showType
    if (showType) then
        if (showBgPath == "") then
            showBgPath = self:getShowBgPath(showType)
        end
        local function tweenFinishCall()
            self:__updateCameraPos(showType)
        end
        if self.m_modelView then
            Perset3dHandler:setupShowData(showType, self:getModelTrans(), self.m_modelView:getModelId(), showBgPath, tweenFinishCall)
            gs.GoUtil.AddComponent(self.m_modelView:getRootGO(), ty.LightRotate)
        end
        if (showType == MainCityConst.ROLE_MODE_OVERVIEW) then
            -- if (self:__getLampStandPath()) then
            --     Perset3dHandler:addLampstandGo(self:__getLampStandPath())
            -- end

            if self.m_modelView then
                local lightRotate = self.m_modelView:getRootGO():GetComponent(ty.LightRotate)
                lightRotate:SetTargetTrans(self.m_modelView:getTrans().parent)
            end
        end
        self:__updateRotation()

        self:__updateSceneColor(showType)
    end
end

function getShowBgPath(self, showType)
    local showBgPath = nil
    if (showType == MainCityConst.ROLE_MODE_FORMATION) then               --编队
        showBgPath = UrlManager:getBgPath("common/common_bg_6.jpg")
    elseif (showType == MainCityConst.ROLE_MODE_OVERVIEW) then            --总览
        showBgPath = UrlManager:getBgPath("common/common_bg_003.jpg")
    elseif (showType == MainCityConst.ROLE_MODE_CULTIVATE) then           --养成
        showBgPath = UrlManager:getBgPath("common/common_bg_003.jpg")
    elseif (showType == MainCityConst.ROLE_MODE_INTERACTION) then         --互动
        showBgPath = UrlManager:getBgPath("common/common_bg_003.jpg")
    elseif (showType == MainCityConst.ROLE_MODE_CLIP) then                --芯片
        showBgPath = nil
    elseif (showType == MainCityConst.ROLE_MODE_MANUAL_MONSTER) then      --怪物档案
        showBgPath = nil
    elseif (showType == MainCityConst.ROLE_MODE_APOSTLE_MONSTER) then     --怪物使徒
        showBgPath = nil
    elseif (showType == MainCityConst.ROLE_MODE_UI or showType == MainCityConst.APOSTLE_MONSTER_UI) then                  --UI
        showBgPath = nil
    elseif (showType == MainCityConst.ROLE_MODE_MAIN) then                --主界面
        showBgPath = UrlManager:getBgPath("mainUI/main_ui_bg.jpg")
    elseif (showType == MainCityConst.ROLE_MODE_STORY) then               --剧情
        showBgPath = nil
    end
    return showBgPath
end

function setAction(self, actionName)
    -- if(self.m_actionName ~= actionName)then
    --     self.m_actionName = actionName
    --     self:__updateAction()
    -- end
    self:__updateAction()
end

function __updateAction(self)
    -- if (self.m_isLoaded) then
    --     if(self.m_actionName)then
    --         self.m_modelView:playFade(self.m_actionName)
    --     end
    -- end
    self.m_modelView:playClickAction()
end

function setScale(self, cusScale)
    self.m_scale = cusScale == nil and 1 or cusScale
    self:__updateScale()
end

function __updateScale(self)
    if (self.m_scale ~= nil) then
        if (self:getModelTrans()) then
            gs.TransQuick:Scale(self:getModelTrans(), self.m_scale, self.m_scale, self.m_scale)
        end
    end
end

function __addClickEven(self, cusClickGo, cusIsClickAction)
    -- self.m_angle = self.m_parentTrans.eulerAngles
    if (cusClickGo) then
        self.m_clickGo = cusClickGo
        self.m_trigger = self.m_clickGo:GetComponent(ty.LongPressOrClickEventTrigger)
        if not self.m_trigger then
            self.m_trigger = gs.GoUtil.AddComponent(self.m_clickGo, ty.LongPressOrClickEventTrigger)
        end
        local function _onBeginDragHandler()
            self:__onBeginDragHandler()
        end
        self.m_trigger.onBeginDrag:AddListener(_onBeginDragHandler)
        local function _onEndDragHandler()
            self:__onEndDragHandler()
        end
        self.m_trigger.onEndDrag:AddListener(_onEndDragHandler)
        if (cusIsClickAction) then
            local function _onPointerDownHandler()
                Perset3dHandler:clearTween()
                self.mBeginMousePos = gs.Input.mousePosition
                self.m_clickStartPos = gs.Input.mousePosition
                self.mPointerDown = true
            end
            self.m_trigger.onPointerDown:AddListener(_onPointerDownHandler)
            local function _onPointerUpHandler()
                local clickStartPos = self.m_clickStartPos
                local clickEndPos = gs.Input.mousePosition
                self.mPointerDown = false
                if (clickStartPos and clickEndPos) then
                    if (math.abs(clickStartPos.x - clickEndPos.x) < 2 and math.abs(clickStartPos.y - clickEndPos.y) < 2) then
                        self:__onClickHandler()
                    end
                end
                self.m_clickStartPos = nil
            end
            self.m_trigger.onPointerUp:AddListener(_onPointerUpHandler)
            -- self.m_trigger.onPointerExit:AddListener(_onPointerUpHandler)

            if self.mTouchFrameSn then
                LoopManager:removeFrameByIndex(self.mTouchFrameSn)
                self.mTouchFrameSn = nil
            end
            self.mTouchFrameSn = LoopManager:addFrame(1, 0, self, self.onTouchFrameHandler)
        end
    end
end

function onTouchFrameHandler(self)
    if self.m_showType == MainCityConst.ROLE_MODE_OVERVIEW or self.m_showType == MainCityConst.ROLE_MODE_UI or self.m_showType == MainCityConst.APOSTLE_MONSTER_UI or self.m_showType == MainCityConst.ROLE_MODE_CLIP then
        if gs.Application.isMobilePlatform then
            if gs.Input.touchCount == 1 then
                self.m_IsSingleFinger = true
            elseif gs.Input.touchCount == 2 and (gs.Input.GetTouch(0).phase == gs.TouchPhase.Moved or gs.Input.GetTouch(1).phase == gs.TouchPhase.Moved) then
                self.touch_1 = gs.Input.GetTouch(0)
                self.touch_2 = gs.Input.GetTouch(1)
                if self.m_IsSingleFinger then
                    self.oldPosition1.x = gs.TransQuick:GetTouchPosition_X(self.touch_1)
                    self.oldPosition1.y = gs.TransQuick:GetTouchPosition_Y(self.touch_1)
                    self.oldPosition1.z = 0

                    self.oldPosition2.x = gs.TransQuick:GetTouchPosition_X(self.touch_2)
                    self.oldPosition2.y = gs.TransQuick:GetTouchPosition_Y(self.touch_2)
                    self.oldPosition2.z = 0
                end

                local tempPosition1 = {}
                tempPosition1.x = gs.TransQuick:GetTouchPosition_X(self.touch_1)
                tempPosition1.y = gs.TransQuick:GetTouchPosition_Y(self.touch_1)
                tempPosition1.z = 0

                local tempPosition2 = {}
                tempPosition2.x = gs.TransQuick:GetTouchPosition_X(self.touch_2)
                tempPosition2.y = gs.TransQuick:GetTouchPosition_Y(self.touch_2)
                tempPosition2.z = 0

                local currentTouchDistance = (gs.Vector3(tempPosition1.x, tempPosition1.y, tempPosition1.z) - gs.Vector3(tempPosition2.x, tempPosition2.y, tempPosition2.z)).magnitude
                local lastTouchDistance = (gs.Vector3(self.oldPosition1.x, self.oldPosition1.y, self.oldPosition1.z) - gs.Vector3(self.oldPosition2.x, self.oldPosition2.y, self.oldPosition2.z)).magnitude

                local distance = (currentTouchDistance - lastTouchDistance) * gs.Time.deltaTime

                --备份上一次触摸点的位置，用于对比
                self.oldPosition1 = tempPosition1
                self.oldPosition2 = tempPosition2
                self.m_IsSingleFinger = false

                self:updateScaleModel(distance * 0.1)
            end
        else
            local wheel = gs.Input.GetAxis("Mouse ScrollWheel")
            if wheel ~= 0 then
                self:updateScaleModel(wheel)
            end
        end
    end
end

function showSiwai(self)
    if not self.isCanScale or not self.m_modelView then
        return
    end

    if self:getModelTrans() == nil or not self:getModelTrans().parent or not self.mScenceCamera then
        return
    end

    local baseVo = fashion.FashionManager:getFColorBaseVoByModeId(self.m_modelView:getModelId())
    if baseVo.cameraType == 1 then
        local tragetDis = gs.Vector3.Distance(gs.Vector3(0, -0.3, 2.4), self.mScenceCamera.transform.position)
        local normal = (gs.Vector3(0, -0.3, 2.4) - self.mScenceCamera.transform.position).normalized

        local targetPos = normal * (tragetDis * 1) + self.mScenceCamera.transform.position
        table.insert(self.mTweenList, TweenFactory:move2Lpos(self.mScenceCamera.transform, targetPos, 0.5))

        table.insert(self.mTweenList, TweenFactory:move2Lpos(self:getModelTrans().parent, self.modelVerticalInitPos, 0.5))
        self.mIsMoveZMax = false
    end
end

-- 更新模型缩放效果（相机移动） 
function updateScaleModel(self, dis)
    if not self.m_isLoaded or not self.isCanScale then
        return
    end
    if self.m_showType ~= MainCityConst.ROLE_MODE_OVERVIEW or not self.targetMoveZPos then
        return
    end

    self.mMoveDis = gs.Mathf.Clamp(self.mMoveDis + dis, 0, 1)

    if self.mMoveDis >= 1 then
        self.mIsMoveZMax = true
    else
        self.mIsMoveZMax = false
    end

    -- 模型放大缩小
    local tragetDis = gs.Vector3.Distance(self.targetMoveZPos, self.cameraInitPos)
    local normal = (self.targetMoveZPos - self.cameraInitPos).normalized

    local targetPos = normal * (tragetDis * self.mMoveDis) + self.cameraInitPos
    table.insert(self.mTweenList, TweenFactory:move2Lpos(self.mScenceCamera.transform, targetPos, 0.5))

    -- 模型被拖到下面还原高度
    if dis < 0 and (self:getModelTrans().parent.localPosition.y > self.modelVerticalInitPos.y) then
        local tragetDis = gs.Vector3.Distance(self.modelTargetPos, self.modelVerticalInitPos)
        if tragetDis * (1 - self.mMoveDis) > gs.Vector3.Distance(self.modelTargetPos, self:getModelTrans().parent.localPosition) then
            local normal = (self.modelTargetPos - self.modelVerticalInitPos).normalized
            local targetPos = self.modelTargetPos - normal * (tragetDis * (1 - self.mMoveDis))
            table.insert(self.mTweenList, TweenFactory:move2Lpos(self:getModelTrans().parent, targetPos, 0.5))
        end
    end
end

-- 开始拖动
function __onBeginDragHandler(self)
    if (not self.m_frameSn) then
        self.m_frameSn = LoopManager:addFrame(1, 0, self, self.__onFrameUpdateHandler)
    end
end

function __onEndDragHandler(self)
end

function __onClickHandler(self)
    if (self.m_isLoaded) then
        if not self.m_tmpAniList then
            self.m_tmpAniList = { fight.FightDef.ACT_SHOW_TIME_1, fight.FightDef.ACT_SHOW_TIME_2, fight.FightDef.ACT_SHOW_TIME_3 }
        end
        self:setAction(self.m_tmpAniList[math.random(1, #self.m_tmpAniList)])
    end
end

function __onFrameUpdateHandler(self)
    if (self.m_isLoaded and self.m_isCanRotate) then
        if gs.Application.isMobilePlatform and gs.Input.touchCount == 2 then
            if (self.m_frameSn) then
                LoopManager:removeFrameByIndex(self.m_frameSn)
                self.m_frameSn = nil
                return
            end
        end

        if (gs.Input:GetMouseButton(0) or gs.Input.touchCount == 1) and self.mPointerDown then
            -- 手指在屏幕上
            self.mMouseMovePos = gs.Input.mousePosition - self.mBeginMousePos

            self.mAroundSpeed = self.mMouseMovePos.x / (gs.Time.deltaTime * 4)
            self.mMoveYSpeed = self.mMouseMovePos.y
            if math.abs(self.mMouseMovePos.x) > math.abs(self.mMouseMovePos.y) then
                self.mMoveYSpeed = 0
            else
                self.mAroundSpeed = 0
            end

        end
        if (self.m_showType ~= MainCityConst.ROLE_MODE_OVERVIEW) then
            -- 模型转
            self.m_angle = self.m_angle - gs.Vector3(-self.mMouseMovePos.y * self.m_rotateSpeed, self.mMouseMovePos.x * self.m_rotateSpeed, 0)
            self.m_angle.x = gs.Mathf.Clamp(self.m_angle.x, self.m_anglesMinAndMax.x, self.m_anglesMinAndMax.y)
            gs.TransQuick:SetLRotation(self:getModelTrans(), self.m_angle.x, self.m_angle.y, self.m_angle.z)
            if not gs.Input:GetMouseButton(0) then
                if (self.m_frameSn) then
                    LoopManager:removeFrameByIndex(self.m_frameSn)
                    self.m_frameSn = nil
                end
            end
        else
            -- 场景转
            self:getModelTrans().parent:RotateAround(self:getModelTrans().position, gs.Vector3.up, -self.mAroundSpeed * gs.Time.deltaTime)
            self.mAroundSpeed = self.mAroundSpeed * 0.85-- gs.Mathf.Pow(0.01, gs.Time.deltaTime)

            -------------------------------------------------------------

            -- 模型上下拖动
            if self.mIsMoveZMax then
                local modelY = self:getModelTrans().parent.localPosition.y
                local tempY = modelY + self.mMoveYSpeed * gs.Time.deltaTime * 0.04

                local newY = gs.Mathf.Clamp(tempY, self.modelVerticalInitPos.y, self.modelTargetPos.y)
                local modelPos = gs.Vector3(self:getModelTrans().parent.localPosition.x, newY, self:getModelTrans().parent.localPosition.z)
                self.mMoveYSpeed = self.mMoveYSpeed * 0.8
                gs.TransQuick:LPos(self:getModelTrans().parent, modelPos)
            else
                self.mMoveYSpeed = 0
            end
        end

        if not gs.Input:GetMouseButton(0) and math.abs(self.mAroundSpeed) < 0.1 and math.abs(self.mMoveYSpeed) < 0.01 then
            if (self.m_frameSn) then
                LoopManager:removeFrameByIndex(self.m_frameSn)
                self.m_frameSn = nil
            end
        end

        self.mBeginMousePos = gs.Input.mousePosition
    end
end

function __updateRotation(self)
    if (self.m_showType) then
        -- 根据配置是否允许旋转
        local modelShowData = fight.RoleShowManager:getModeData(self.m_showType)
        if (not self.m_showType or not modelShowData or modelShowData:getIsPlayXz() == 0) then
            self.m_isCanRotate = false
        else
            self.m_isCanRotate = true
        end
        if (self:getModelTrans()) then
            -- gs.TransQuick:SetLRotation(self:getModelTrans(), self.m_angle.x, self.m_angle.y, self.m_angle.z)
        end
    end
end

-- UI要的动态修改小场景的颜色(废弃)
function __updateSceneColor(self, showType)
    -- if not self.mMain10Box then
    --     self.mMain10Box = gs.GameObject.Find("main10_platform")
    -- end
    -- if showType == MainCityConst.ROLE_MODE_MANUAL_MONSTER then
    --     self.mMain10Box:GetComponent(ty.Renderer).material:SetColor("_Color", gs.ColorUtil.GetColor("CFD9F8FF"))
    -- elseif showType ~= MainCityConst.ROLE_MODE_UI and self.m_showType ~= MainCityConst.APOSTLE_MONSTER_UI then
    --     self.mMain10Box:GetComponent(ty.Renderer).material:SetColor("_Color", gs.ColorUtil.GetColor("FFFFFFFF"))
    -- end
end

-- 更新摄像机位置
function __updateCameraPos(self, showType)
    -- if not self.mMain10 then
    --     self.mScenceCamera = gs.CameraMgr:GetDefSceneCameraTrans()
    --     self.mMain10 = gs.GameObject.Find("ui_main_10")
    --     self.mMain10Sphere = gs.GameObject.Find("sphere")
    --     self.spherePos = self.mMain10Sphere.transform.position
    --     self.mUIOverView = gs.GameObject.Find("UI_OVERVIEW")
    --     self.mUIDecorateNode = self.mUIOverView.transform:Find("DECORATE_NODE")
    -- end
    if not self.m_isLoaded or not Perset3dHandler.isTweenFinish or not self.isCanScale then
        return
    end

    if not self.mScenceCamera then
        self.mScenceCamera = gs.CameraMgr:GetDefSceneCameraTrans()
    end

    if not self.spineNode then
        self.spineNode = self.m_modelView:getPointTrans(fight.FightDef.POINT_HEAD) --取胸部挂点
        if self.spineNode then
            self.spineNodePos = self.mScenceCamera.transform.parent:InverseTransformPoint(self.spineNode.position) --胸部挂点位置转换为相机挂点的位置
            self.targetMoveZPos = gs.Vector3(self.spineNodePos.x, self.spineNodePos.y, self.spineNodePos.z - 2.5)
            self.cameraInitPos = self.mScenceCamera.transform.localPosition
            self.modelVerticalInitPos = self:getModelTrans().parent.localPosition

            self.rootNode = self.m_modelView:getPointTrans(fight.FightDef.POINT_ROOT) --脚部挂点
            self.rootNodePos = self.mScenceCamera.transform.parent:InverseTransformPoint(self.rootNode.position) --胸部挂点位置转换为相机挂点的位置
            local temp = self.spineNodePos.y - self.rootNodePos.y + self.modelVerticalInitPos.y - 0.2
            self.modelTargetPos = gs.Vector3(self.modelVerticalInitPos.x, temp, self.modelVerticalInitPos.z)
        end
    end

    -- if showType == MainCityConst.ROLE_MODE_OVERVIEW then
    --     self.mMain10Sphere.transform:SetParent(self.mScenceCamera, true)
    -- else
    --     self.mMain10Sphere.transform:SetParent(self.mMain10.transform, true)
    --     gs.TransQuick:Pos(self.mMain10Sphere.transform, self.spherePos)
    -- end

    -- 小动作准备，暂时不用
    -- if showType == MainCityConst.ROLE_MODE_CULTIVATE then
    --     local roleCameraNode = self.m_modelView:getPointTrans(fight.FightDef.POINT_CAMERA)
    --     if roleCameraNode then
    --         self.mScenceCamera.transform:SetParent(roleCameraNode, true)
    --         self.mMain10.transform:SetParent(self.mScenceCamera.transform, true)
    --     end
    -- else
    --     self.mMain10.transform:SetParent(self.mUIDecorateNode, true)
    --     gs.TransQuick:LPos(self.mMain10.transform, gs.VEC3_ZERO)
    -- end


    -- if showType == MainCityConst.ROLE_MODE_OVERVIEW or showType == MainCityConst.ROLE_MODE_MANUAL_MONSTER then
    --     self:deepCamera()
    -- end
end

--镜头往返切换
function deepCamera(self)
    if self.mScenceCamera then
        local offsetY = fight.RoleShowManager:getCameraOffsetY(self.m_modelView:getModelId())
        gs.TransQuick:LPosY(self.mScenceCamera.transform, offsetY)
    end
end

function clearTween(self)
    for i, tween in ipairs(self.mTweenList) do
        if tween then
            tween:Kill()
        end
    end
    self.mTweenList = {}
end


return _M