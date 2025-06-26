-- @FileName:   ShootBrickSceneUI.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.shootBrick.view.ShootBrickSceneUI', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("shootBrick/ShootBrickSceneUI.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isScreensave = 0 -- 是否使用黑屏过渡(仅1全屏UI有效，默认开启，0关闭)
isBlur = 0
escapeClose = 0 -- 是否能通过esc关闭窗口

-- 初始化数据
function initData(self)
    self.m_lastClickTime = 0
end

-- 初始化
function configUI(self)
    self.m_startView = fightUI.FightStartView.new()
    self.m_startView:initData(self:getChildGO('StartGroup'))

    self.mImgStart = self:getChildGO("mImgStart")
    self.mImgPause = self:getChildGO("mImgPause")

    self.mBtnPause = self:getChildGO("mBtnPause")

    self.mImgBoard = self:getChildGO("mImgBoard")
    self.mImgBoard_rectTrans = self.mImgBoard:GetComponent(ty.RectTransform)
    self.m_boardSize = {width = self.mImgBoard_rectTrans.rect.width, height = self.mImgBoard_rectTrans.rect.height}

    self.mBoardRay = self:getChildGO("mBoardRay")
    self.mImgBoardLongPress = self.mBoardRay:GetComponent(ty.LongPressOrClickEventTrigger)

    self.mImgBall = self:getChildGO("mImgBall")
    self.mBallLayer = self:getChildTrans("mBallLayer")
    local ball_rect = self.mImgBall:GetComponent(ty.RectTransform).rect
    self.mImgBall_Size = {width = ball_rect.width, height = ball_rect.height}

    self.mSceneGroup = self:getChildGO("mSceneGroup"):GetComponent(ty.RectTransform)
    self.mBrickLayer = self:getChildTrans("mBrickLayer")
    self.mBrickItem = self:getChildGO("mBrickItem")

    self.mDropLayer = self:getChildTrans("mDropLayer")
    self.mDrop = self:getChildGO("mDrop")

    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)
    self.mTextScore = self:getChildGO("mTextScore"):GetComponent(ty.Text)

    self.mImgBarrier = self:getChildGO("mImgBarrier")
    self.mImgBarrier_rect = self.mImgBarrier:GetComponent(ty.RectTransform)

    self.mTower = self:getChildGO("mTower")
    self.mImgBullet = self:getChildGO("mImgBullet")
    self.mBulletLayer = self:getChildTrans("mBulletLayer")

    self.mEffect01 = self:getChildGO("mEffect01")

    self.m_sceneWith = self.mSceneGroup.rect.width
    self.m_sceneHeight = self.mSceneGroup.rect.height
end

function initViewText(self)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnPause, self.onPause)
end

--激活
function active(self, args)
    super.active(self)

    self.mImgBoard:SetActive(false)
    self.mImgBall:SetActive(false)
    self.mBrickItem:SetActive(false)
    self.mDrop:SetActive(false)
    self.mImgBarrier:SetActive(false)
    self.mTower:SetActive(false)
    self.mImgBullet:SetActive(false)
    self.m_startView:setActive(false)

    if shootBrick.ShootBrickManager:getTeachingState() then
        self:onOpenTeaching(args)
    else
        self:refreshView(args)
    end

    if self.m_dupConfigVo then
        self.mImgBg:SetImg(self.m_dupConfigVo:getSceneBgPath())
    else
        self.mImgBg:SetImg(args:getSceneBgPath())
    end

    self:refreshPauseState(false)

    self:onAddPointerEvent()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    self:RemoveEventListener()
    self:onRemovePointerEvent()

    self:clearData()
end

---初始化游戏数据
function initGameData(self)
    self.m_lastDragDistance = 0

    self.m_score = 0

    self.m_dropDic = {}
    self.m_dropId = 0
    self.m_dropEffectDic = {} --实现中的掉落物

    self.m_towerDic = {} --炮台
    self.m_towerId = 0
    self.m_towerBulltDic = {} --炮台发射的子弹
    self.m_towerBulltId = 0

    self.m_shoot = false

    self:initBall()
    self:initBrick()

    self:addKeyboardFrame()

    self.mTextScore.text = _TT(138702, self.m_score)
end

function clearData(self)
    self:removeKeyboardFrame()

    self:clearBall()
    self:clearBrick()
    self:clearDrop()
    self:clearTower()
    self:clearTowerBullet()
    self:clearBrickDieEffect()
    self:clearDropEffectTimeSn()

    self.m_lastDragHorizontal = nil
    self.m_lastDragDistance = nil

    self.m_dropEffectTimerSn = nil
end

function AddEventListener(self)
    GameDispatcher:addEventListener(EventName.SHOOTBRICK_UPDATE_PAUSESTATE, self.refreshPauseState, self)
end

function RemoveEventListener(self)
    GameDispatcher:removeEventListener(EventName.SHOOTBRICK_UPDATE_PAUSESTATE, self.refreshPauseState, self)
end

function refreshView(self, args)
    self:clearData()

    self.m_dupConfigVo = args

    self:AddEventListener()

    local function _finishCall()
        self.m_startView:setActive(false)

        self:initGameData()
    end
    self.m_startView:setActive(true)
    self.m_startView:start(_finishCall)

    self.mImgBoard_rectTrans.anchoredPosition = gs.Vector2(0, self.mImgBoard_rectTrans.anchoredPosition.y)
    gs.TransQuick:SizeDelta01(self.mImgBoard_rectTrans, self.m_boardSize.width)

    self:operateBarrier(false)
end

--添加键盘监听事件
function addKeyboardFrame(self)
    LoopManager:addFrame(1, 0, self, self.onKeyboard)
end

--移除键盘事件
function removeKeyboardFrame(self)
    LoopManager:removeFrame(self, self.onKeyboard)
end

function onKeyboard(self, deltaTime)
    if gs.Input.GetKey(gs.KeyCode.RightArrow) or gs.Input.GetKey(gs.KeyCode.LeftArrow) then
        self:onMoveBoard(self.mImgBoard_rectTrans.anchoredPosition.x + gs.Input.GetAxis("Horizontal") * 10)
    end

    if gs.Input.GetKeyUp(gs.KeyCode.RightArrow) or gs.Input.GetKeyUp(gs.KeyCode.LeftArrow) then
        self.m_lastDragHorizontal = nil
        self.m_lastDragDistance = 0
    end

    if gs.Input.GetKeyUp(gs.KeyCode.Space) then
        self:shootBall()
    end
end

function shootBall(self)
    if not self.m_shoot then
        if gs.Time.time - self.m_lastClickTime <= 0.3 then
            self:onShootBall(self.m_brickBallList)
            self.m_shoot = true
        end
        self.m_lastClickTime = gs.Time.time
    end
end

function onMoveBoard(self, horizontal)
    if self.m_lastDragHorizontal then
        self.m_lastDragDistance = (horizontal - self.m_lastDragHorizontal) * 0.05
    end
    self.m_lastDragHorizontal = horizontal

    local min_posX = (self.m_sceneWith * -0.5) + (self.mImgBoard_rectTrans.rect.width * 0.5)
    local max_posX = (self.m_sceneWith * 0.5) - (self.mImgBoard_rectTrans.rect.width * 0.5)
    if self.m_lastDragHorizontal < min_posX then
        self.m_lastDragHorizontal = min_posX
    elseif self.m_lastDragHorizontal > max_posX then
        self.m_lastDragHorizontal = max_posX
    end

    self.mImgBoard_rectTrans.anchoredPosition = gs.Vector2(self.m_lastDragHorizontal, self.mImgBoard_rectTrans.anchoredPosition.y)
end

-- 打开教学
function onOpenTeaching(self, args)
    GameDispatcher:dispatchEvent(EventName.OPEN_SHOOTBRICK_TEACHING_VIEW, {closeCall = function ()
        self:refreshView(args)
    end})
    StorageUtil:saveNumber1(gstor.SHOOTBRICK_TEACHINGSTATE, GameManager:getClientTime())
end

function onPause(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_SHOOTBRICK_PAUSEPANEL, {star_count = self:getCurStarCount(), dup_config = self.m_dupConfigVo})
end

function refreshPauseState(self, pauseState)
    self.mImgStart:SetActive(pauseState)
    self.mImgPause:SetActive(not pauseState)
end

-- 增加长按事件
function onAddPointerEvent(self)
    local function _onclickHandler()
        self:shootBall()
    end

    local function _onDragHandler()
        self:onBoardDragHandler()
    end

    local function _onDragEndHandler()
        self.m_lastDragHorizontal = nil
        self.m_lastDragDistance = 0
    end

    local function _onPointDownHandler()
        local camera = gs.CameraMgr:GetUICamera();

        local vector2 = camera:ScreenToViewportPoint(gs.Input.mousePosition)
        local ScreenResolution_width = gs.Screen.width
        vector2.x = ScreenResolution_width * (vector2.x - 0.5)

        local anchoredPosition = self.mImgBoard_rectTrans.anchoredPosition
        self.m_click_diff_pos = anchoredPosition - gs.Vector2(vector2.x, vector2.y)
    end

    local function _onPointUpHandler()
        self.m_click_diff_pos = nil
    end

    self.mImgBoardLongPress.onClick:AddListener(_onclickHandler)
    self.mImgBoardLongPress.onDrag:AddListener(_onDragHandler)
    self.mImgBoardLongPress.onEndDrag:AddListener(_onDragEndHandler)
    self.mImgBoardLongPress.onPointerDown:AddListener(_onPointDownHandler)
    self.mImgBoardLongPress.onPointerUp:AddListener(_onPointUpHandler)
end

-- 移除长按事件
function onRemovePointerEvent(self)
    self.mImgBoardLongPress.onClick:RemoveAllListeners()
    self.mImgBoardLongPress.onDrag:RemoveAllListeners()
    self.mImgBoardLongPress.onEndDrag:RemoveAllListeners()
    self.mImgBoardLongPress.onPointerDown:RemoveAllListeners()
    self.mImgBoardLongPress.onPointerUp:RemoveAllListeners()
end

function onBoardDragHandler(self)
    local ve2 = gs.Vector2(0, self.mImgBoard_rectTrans.anchoredPosition.y)
    local camera = gs.CameraMgr:GetUICamera();
    local vector2 = camera:ScreenToViewportPoint(gs.Input.mousePosition)

    local ScreenResolution_width = gs.Screen.width
    ve2.x = ScreenResolution_width * (vector2.x - 0.5)

    local anch_pos = gs.Vector2(ve2.x, ve2.y) + self.m_click_diff_pos
    self:onMoveBoard(anch_pos.x)
end

function addScore(self, val)
    self.m_score = self.m_score + val

    self.mTextScore.text = _TT(138702, self.m_score)
end

--检测关卡总的掉落物
function createDupDrop(self, brick_id, brick_pos)
    if not table.empty(self.m_dropBrickDic) and self.m_dropBrickDic[brick_id] ~= nil then
        self:createDrop(self.m_dropBrickDic[brick_id], brick_pos)
        self.m_dropBrickDic[brick_id] = nil
    end
end

function createBrickDrop(self, brick_data, pos)
    if brick_data.drop_id == 0 then
        return false
    end

    self:createDrop(brick_data.drop_id, pos)
    return true
end

--创建掉落物
function createDrop(self, id, pos)
    self.m_dropId = self.m_dropId + 1

    if gs.Application.isEditor then
        shootBrick.ShootBrickDrop = require("game/shootBrick/manager/ShootBrickDrop")
    end

    local dropThing = shootBrick.ShootBrickDrop:create(self.mDrop, self.mDropLayer, "ShootBrickSceneUI_DropItem")
    self.m_dropDic[self.m_dropId] = dropThing
    dropThing:setArgs({config_id = id, pos = pos, id = self.m_dropId, recoverFun = self.deleteDrop, recoverFunClass = self, screen_height = self.m_sceneHeight})
    dropThing:setCheckCollision(self, self.onCheckDropCollider)
end

function deleteDrop(self, id)
    if self.m_dropDic[id] == nil then
        return
    end

    self.m_dropDic[id]:poolRecover()
    self.m_dropDic[id] = nil
end

function clearDrop(self)
    if self.m_dropDic then
        for k, v in pairs(self.m_dropDic) do
            v:poolRecover()
        end
    end
    self.m_dropDic = nil
    self.m_dropId = nil
end

--掉落物的碰撞
function onCheckDropCollider(self, drop)
    ---板子坐标换算
    local anchoredPosition = {x = self.mImgBoard_rectTrans.anchoredPosition.x + (self.m_sceneWith * 0.5), y = self.mImgBoard_rectTrans.anchoredPosition.y - (self.m_sceneHeight * 0.5)}
    local height = self.mImgBoard_rectTrans.rect.height * 0.5
    local width = self.mImgBoard_rectTrans.rect.width * 0.5

    local board_LTPoint = {x = anchoredPosition.x - width, y = anchoredPosition.y + height}
    local board_RDPoint = {x = anchoredPosition.x + width, y = anchoredPosition.y - height}

    local drop_pos = drop:getTrans():GetComponent(ty.RectTransform).anchoredPosition
    local drop_LTPoint = {x = drop_pos.x - 16.5, y = drop_pos.y + 16.5} --左上
    local drop_LDPoint = {x = drop_pos.x - 16.5, y = drop_pos.y - 16.5}--左下
    local drop_RDPoint = {x = drop_pos.x + 16.5, y = drop_pos.y - 16.5}--右下
    local drop_RTPoint = {x = drop_pos.x + 16.5, y = drop_pos.y + 16.5} --右上

    local isCollider = false
    --下层的四个点是不是在上层的左上跟右下范围内
    if (drop_LTPoint.x > board_LTPoint.x and drop_LTPoint.x < board_RDPoint.x) and (drop_LTPoint.y > board_RDPoint.y and drop_LTPoint.y < board_LTPoint.y) then
        isCollider = true
    elseif (drop_LDPoint.x > board_LTPoint.x and drop_LDPoint.x < board_RDPoint.x) and (drop_LDPoint.y > board_RDPoint.y and drop_LDPoint.y < board_LTPoint.y) then
        isCollider = true
    elseif (drop_RDPoint.x > board_LTPoint.x and drop_RDPoint.x < board_RDPoint.x) and (drop_RDPoint.y > board_RDPoint.y and drop_RDPoint.y < board_LTPoint.y) then
        isCollider = true
    elseif (drop_RTPoint.x > board_LTPoint.x and drop_RTPoint.x < board_RDPoint.x) and (drop_RTPoint.y > board_RDPoint.y and drop_RTPoint.y < board_LTPoint.y) then
        isCollider = true
    end

    if isCollider then
        local drop_data = drop:getArgs()
        local dropConfig = shootBrick.ShootBrickManager:getPropConfigVo(drop_data.config_id)
        self:onDropEffect(dropConfig)

        self:deleteDrop(drop_data.id)
    end

    return isCollider
end

function onDropEffect(self, dropConfig)
    AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_birck_3.prefab")
    if not self.m_dropEffectTimerSnList then
        self.m_dropEffectTimerSnList = {}
    end

    if dropConfig.type == ShootBrickConst.DROP_ADDBOARDLENGTH then --增加板子长度
        self:addBoardLength(dropConfig.param[1])
        if dropConfig.life_time > 0 then
            local timeSn = self:setTimeout(dropConfig.life_time, self.addBoardLength, dropConfig.param[1] * -1)
            table.insert(self.m_dropEffectTimerSnList, timeSn)
        end
    elseif dropConfig.type == ShootBrickConst.DROP_DIVIDEBALL then--增加球的数量
        self:divideBall(dropConfig.param[1])
    elseif dropConfig.type == ShootBrickConst.DROP_ADDDAMAGE then --增加球的伤害
        self:addDamage(dropConfig.param[1])
        if dropConfig.life_time > 0 then
            local timeSn = self:setTimeout(dropConfig.life_time, self.addDamage, dropConfig.param[1] * -1)
            table.insert(self.m_dropEffectTimerSnList, timeSn)
        end
    elseif dropConfig.type == ShootBrickConst.DROP_CHANGEBALLSIZE then --改变球的大小
        self:changeBallSize(dropConfig.param[1])

        if dropConfig.life_time > 0 then
            if self.m_dropEffectDic[dropConfig.type] == nil then
                self.m_dropEffectDic[dropConfig.type] = {life_time = dropConfig.life_time}
            else
                self.m_dropEffectDic[dropConfig.type].life_time = self.m_dropEffectDic[dropConfig.type].life_time + dropConfig.life_time
            end
        end
    elseif dropConfig.type == ShootBrickConst.DROP_SHOOTTOWER then --添加一个发射炮台
        self:addTower(dropConfig)
    elseif dropConfig.type == ShootBrickConst.DROP_SHOWBARRIER then --增加挡板
        self:operateBarrier(true)

        if dropConfig.life_time > 0 then
            if self.m_dropEffectDic[dropConfig.type] == nil then
                self.m_dropEffectDic[dropConfig.type] = {life_time = dropConfig.life_time}
            else
                self.m_dropEffectDic[dropConfig.type].life_time = self.m_dropEffectDic[dropConfig.type].life_time + dropConfig.life_time
            end
        end
    else
        logError("掉落物道具类型未定义!!! type = " .. dropConfig.type)
    end

    if not table.empty(self.m_dropEffectDic) and self.m_dropEffectFrameSn == nil then
        self.m_dropEffectFrameSn = LoopManager:addFrame(1, -1, self, self.onDropEffectOver)
    end
end

--掉落物道具效果到期
function onDropEffectOver(self)
    for drop_type, data in pairs(self.m_dropEffectDic) do
        data.life_time = data.life_time - gs.Time.deltaTime
        if data.life_time <= 0 then
            if drop_type == ShootBrickConst.DROP_CHANGEBALLSIZE then
                self:changeBallSize(1)
            elseif drop_type == ShootBrickConst.DROP_SHOWBARRIER then
                self:operateBarrier(false)
            end

            self.m_dropEffectDic[drop_type] = nil
        end
    end
end

function clearDropEffectTimeSn(self)
    LoopManager:removeFrameByIndex(self.m_dropEffectFrameSn)
    self.m_dropEffectFrameSn = nil

    for k, v in pairs(self.m_dropEffectTimerSnList or {}) do
        self:clearTimeout(v)
    end
    self.m_dropEffectTimerSnList = nil
end

------------------------------------------掉落物道具的拾取效果实现-------------------------------------
--增加板子长度
function addBoardLength(self, value)
    local width = self.mImgBoard_rectTrans.rect.width + self.m_boardSize.width * value
    if width < 26 then
        width = 26
    end
    gs.TransQuick:SizeDelta01(self.mImgBoard_rectTrans, width)
end

--分裂球
function divideBall(self, value)
    local ball_list = {}
    for ball_id, ball in pairs(self.m_ballDic) do
        local pos = ball:getTrans():GetComponent(ty.RectTransform).anchoredPosition
        local angle = nil
        for i = 1, value do
            local ball_item = self:createBall(self.mBallLayer, {x = pos.x, y = pos.y})
            table.insert(ball_list, ball_item)

            angle = math.random(3, 15)
            ball_item:shoot(angle * 10)
            ball_item:setDamage(ball:getDamage())
            ball_item:setSpeed(ball:getSpeed())
            ball_item:setScale(ball:getScale())
        end
    end
    for _, ball in pairs(ball_list) do
        self.m_ballDic[ball:getArgs().id] = ball
    end
end

--球增加伤害
function addDamage(self, value)
    for ball_id, ball in pairs(self.m_ballDic or {}) do
        ball:addDamage(value)
    end
end

--改变球的大小
function changeBallSize(self, value)
    for ball_id, ball in pairs(self.m_ballDic) do
        ball:setScale(value)
    end
end

function operateBarrier(self, value)
    if self.mImgBarrier.activeInHierarchy ~= value then
        self.mImgBarrier:SetActive(value)
    end
end

-----------------------炮台
--添加炮台
function addTower(self, dropConfig)
    if gs.Application.isEditor then
        shootBrick.ShootBrickTowerBullet = require("game/shootBrick/manager/ShootBrickTowerBullet")
        shootBrick.ShootBrickTower = require("game/shootBrick/manager/ShootBrickTower")
    end

    -- {数量,子弹发射间隔,子弹飞行速度,子弹伤害}
    local num, interval, speed, damage = dropConfig.param[1], dropConfig.param[2], dropConfig.param[3], dropConfig.param[4]
    for i = 1, num do
        local tower_id = self:createTower(interval, speed, damage)
        if dropConfig.life_time > 0 then
            local timeSn = self:setTimeout(dropConfig.life_time, self.deleteTower, tower_id)
            table.insert(self.m_dropEffectTimerSnList, timeSn)
        end
    end
end

function createTower(self, interval, speed, damage)
    local pos_x, pos_y, index = self:getTowerPos()
    local parent = self:getChildTrans("mRightTower")
    if index % 2 == 1 then
        parent = self:getChildTrans("mLeftTower")
    end

    self.m_towerId = self.m_towerId + 1
    local tower = shootBrick.ShootBrickTower:create(self.mTower, parent, "ShootBrickSceneUI_TowerItem")

    tower:setPos(pos_x, pos_y)

    local args =
    {
        id = self.m_towerId,
        interval = interval,
        speed = speed,
        damage = damage,
        imgBoard_rect = self.mImgBoard_rectTrans,
        shoot_fun = self.shootTowerBullet,
        shoot_class = self,
    }
    tower:setArgs(args)
    self.m_towerDic[index] = tower

    return self.m_towerId
end

function getTowerPos(self)
    local index = #self.m_towerDic
    for i = 1, #self.m_towerDic do
        if self.m_towerDic[i] == nil then
            index = i - 1
            break
        end
    end

    local pos_x, pos_y = 0, 3
    if index % 2 == 1 then
        pos_x = math.floor(index / 2) * (25) + 17
    else
        pos_x = math.floor(index / 2) * (-25) - 17
    end

    return pos_x, pos_y, index + 1
end

function deleteTower(self, id)
    for k, tower in pairs(self.m_towerDic or {}) do
        if tower:getArgs().id == id then
            tower:poolRecover()
            self.m_towerDic[k] = nil
            break
        end
    end
end

function clearTower(self)
    if self.m_towerDic then
        for k, v in pairs(self.m_towerDic) do
            v:poolRecover()
        end
    end

    self.m_towerDic = nil
    self.m_towerId = nil
end

---发射子弹
function shootTowerBullet(self, args)
    self.m_towerBulltId = self.m_towerBulltId + 1

    local bulletItem = shootBrick.ShootBrickTowerBullet:create(self.mImgBullet, self.mBulletLayer, "ShootBrickSceneUI_TowerBulletItem")
    self.m_towerBulltDic[self.m_towerBulltId] = bulletItem

    bulletItem:setPos(args.bullet_pos.x, args.bullet_pos.y)
    bulletItem:setCheckCollision(self, self.towerBulletCheckCollision)
    bulletItem:setArgs({id = self.m_towerBulltId, speed = args.speed, damage = args.damage, recoverFunClass = self, recoverFun = self.deleteTowerBullet, height = self.m_sceneHeight})
end

function deleteTowerBullet(self, id)
    if self.m_towerBulltDic[id] == nil then
        return
    end

    self.m_towerBulltDic[id]:poolRecover()
    self.m_towerBulltDic[id] = nil
end

function clearTowerBullet(self)
    if self.m_towerBulltDic then
        for k, v in pairs(self.m_towerBulltDic) do
            v:poolRecover()
        end
    end

    self.m_towerBulltDic = nil
end

--子弹碰撞检测
function towerBulletCheckCollision(self, bullet, bullet_pos)
    --球的位置换算倒左上角
    bullet_pos.y = bullet_pos.y - (self.m_sceneHeight * 0.5)
    bullet_pos.x = bullet_pos.x + (self.m_sceneWith * 0.5)

    --检测砖块
    if self.m_brickDic then
        local colliderPoint = bullet_pos.y + 4
        local brick_pos, brick_size = nil, nil

        local Screen_MinX = (ShootBrickConst.Screen_Width - (ShootBrickConst.BrickWidth * ShootBrickConst.MaxCol)) / 2
        local col = math.ceil(math.abs((bullet_pos.x - Screen_MinX) / ShootBrickConst.BrickWidth))
        local row = math.ceil(math.abs(colliderPoint / ShootBrickConst.BrickHeight))

        --碰到了
        if self.m_brickDic[row] then
            local brick = self.m_brickDic[row][col]
            if brick then
                brick_pos = brick:getPos()
                brick_size = brick:getSize()

                if colliderPoint >= brick_pos.y - (brick_size.height * 0.5) and bullet_pos.x >= brick_pos.x - (brick_size.width * 0.5)and bullet_pos.x <= brick_pos.x + (brick_size.width * 0.5) then
                    self:onBrickHit(brick, bullet:getArgs().damage)
                    self:deleteTowerBullet(bullet:getArgs().id)
                    return true
                end
            end
        end
    end

    return false
end

------------------------------------------------end---------------------------------------------------
--获取砖块碎掉特效
function getBrickDieEffect(self, pos_x, pos_y)
    if not self.m_brickDieEffectDic then
        self.m_brickDieEffectDic = {}
        self.m_brickDieEffectId = 0
    end

    self.m_brickDieEffectId = self.m_brickDieEffectId + 1

    local effect = SimpleInsItem:create(self.mEffect01, self.mBrickLayer, "ShootBrickSceneUI_BrickEffectItem")
    effect:setPos(pos_x, pos_y)

    local timeOutSn = self:setTimeout(2, function (class, effectId)
        self.m_brickDieEffectDic[effectId].item:poolRecover()
        self.m_brickDieEffectDic[effectId] = nil
    end, self.m_brickDieEffectId)

    self.m_brickDieEffectDic[self.m_brickDieEffectId] =
    {
        item = effect,
        timeOutSn = timeOutSn,
    }
end

function clearBrickDieEffect(self)
    if self.m_brickDieEffectDic then
        for _, tab in pairs(self.m_brickDieEffectDic) do
            tab.item:poolRecover()
            self:clearTimeout(tab.timeOutSn)
        end
    end
    self.m_brickDieEffectDic = nil
end

--创建砖块
function initBrick(self)
    self.m_brickDic = {}

    local max_row = 18
    local max_col = 11

    if gs.Application.isEditor then
        shootBrick.ShootBrickBrick = require("game/shootBrick/manager/ShootBrickBrick")
    end

    local brick_list = self.m_dupConfigVo:getBrickList()
    for row = 1, max_row do
        if brick_list[row] then
            self.m_brickDic[row] = {}
            for col = 1, max_col do
                if brick_list[row][col] then
                    local brick = shootBrick.ShootBrickBrick:create(self.mBrickItem, self.mBrickLayer, "ShootBrickSceneUI_BrickItem")
                    brick:setArgs({data = brick_list[row][col], col = col, row = row})
                    brick:getGo().name = row .. "_" .. col

                    self.m_brickDic[row][col] = brick
                end
            end
        end
    end

    --初始化可能掉落道具的砖块
    local function getRandom (range, old_data)
        local random = math.random(range[1], range[2])
        if old_data[random] ~= nil then
            return getRandom(range, old_data)
        end

        return random
    end

    self.m_dropBrickDic = {}

    local num, range, drop_id = nil, nil, nil
    for i = 1, #self.m_dupConfigVo.drop_data do
        num = self.m_dupConfigVo.drop_data[i][3]
        range = self.m_dupConfigVo.drop_data[i][1]
        drop_id = self.m_dupConfigVo.drop_data[i][2]
        if num <= (range[2] - range[1]) then
            for j = 1, num do
                local id = getRandom(range, self.m_dropBrickDic)
                self.m_dropBrickDic[id] = drop_id
            end
        end
    end
end

function deleteBrick(self, row, col)
    if self.m_brickDic[row] == nil then
        return
    end

    if self.m_brickDic[row][col] == nil then
        return
    end

    self.m_brickDic[row][col]:poolRecover()
    self.m_brickDic[row][col] = nil
end

function clearBrick(self)
    if self.m_brickDic then
        for row, col_dic in pairs(self.m_brickDic) do
            for col, brick in pairs(col_dic) do
                brick:poolRecover()
            end
        end
        self.m_brickDic = nil
    end
end

---砖块受到攻击
function onBrickHit(self, brick, damage)
    if brick:onHit(damage) then
        self:addScore(brick:getScore())

        local brick_pos = brick:getPos()
        local pos = {x = brick_pos.x, y = brick_pos.y}
        local brick_data = brick:getArgs().data
        if self:createBrickDrop(brick_data, pos) == false then
            self:createDupDrop(brick_data.id, pos)
        end

        self:deleteBrick(brick:getArgs().row, brick:getArgs().col)
        self:getBrickDieEffect(brick_pos.x, brick_pos.y)

        self:checkBrickSettlement()
    end
end

--初始化球
function initBall(self)
    self.m_ballId = 0

    self.m_ballDic = {}

    local ball = self:createBall(self.mImgBoard_rectTrans, {x = 0, y = 25.5})
    self.m_ballDic[ball:getArgs().id] = ball

    self.m_brickBallList = {}
    table.insert(self.m_brickBallList, ball)

    self.mImgBoard:SetActive(true)
end

function createBall(self, parent, pos)
    self.m_ballId = self.m_ballId + 1

    if gs.Application.isEditor then
        shootBrick.ShootBrickBall = require("game/shootBrick/manager/ShootBrickBall")
    end

    local ball_item = shootBrick.ShootBrickBall:create(self.mImgBall, parent, "ShootBrickSceneUI_BallItem")
    local data = {id = self.m_ballId, config = self.m_dupConfigVo:getBall(), size = self.mImgBall_Size}
    ball_item:setArgs(data)
    ball_item:setPos(pos.x, pos.y)
    ball_item:setCheckCollision(self, self.ballCheckCollision)
    ball_item:getGo().name = tostring(self.m_ballId)

    return ball_item
end

function deleteBall(self, id)
    local ball = self.m_ballDic[id]
    if ball then
        ball:poolRecover()
        self.m_ballDic[id] = nil
    end
end

function clearBall(self)
    if self.m_ballDic then
        for id, ball in pairs(self.m_ballDic) do
            ball:poolRecover()
        end

        self.m_ballDic = nil
    end
end

function onShootBall(self, ball_list)
    for _, ball in pairs(ball_list) do
        ball:addOnParent01(self.mBallLayer)
        ball:shoot(self.m_dupConfigVo.shoot_angle)
    end
end

function checkBallPointHitBrick(self, point, radius)
    local Screen_MinX = (ShootBrickConst.Screen_Width - (ShootBrickConst.BrickWidth * ShootBrickConst.MaxCol)) / 2

    local col = math.ceil(math.abs((point.x - Screen_MinX) / ShootBrickConst.BrickWidth))
    local row = math.ceil(math.abs(point.y / ShootBrickConst.BrickHeight))

    if self.m_brickDic[row] then
        local brick = self.m_brickDic[row][col]
        if brick then
            local size = brick:getSize()
            local brick_size = {height = size.height, width = size.width * 0.5}
            local brick_pos = brick:getPos()
            if point.y >= brick_pos.y - brick_size.height and point.y <= brick_pos.y + brick_size.height and point.x >= brick_pos.x - brick_size.width and point.x <= brick_pos.x + brick_size.width then
                return brick
            end
        end
    end
end

--球的碰撞检测
function ballCheckCollision(self, ball, move_dir, ball_pos, radius)
    local isCollider = false

    --球的位置换算倒左上角
    ball_pos.y = ball_pos.y - (self.m_sceneHeight * 0.5)
    ball_pos.x = ball_pos.x + (self.m_sceneWith * 0.5)

    --检测砖块
    if self.m_brickDic then
        local collider_brickDic = {}

        if move_dir.y ~= 0 then
            if move_dir.y > 0 then --球往上走
                local hitBrick = self:checkBallPointHitBrick(gs.Vector2(ball_pos.x, ball_pos.y + radius), radius)
                if hitBrick then
                    local args = hitBrick:getArgs()

                    if collider_brickDic[args.row] == nil then
                        collider_brickDic[args.row] = {}
                    end
                    collider_brickDic[args.row][args.col] = hitBrick

                    move_dir.y = move_dir.y * -1

                    isCollider = true
                end
            elseif move_dir.y < 0 then --球往下走
                local hitBrick = self:checkBallPointHitBrick(gs.Vector2(ball_pos.x, ball_pos.y - radius), radius)
                if hitBrick then
                    local args = hitBrick:getArgs()

                    if collider_brickDic[args.row] == nil then
                        collider_brickDic[args.row] = {}
                    end
                    collider_brickDic[args.row][args.col] = hitBrick

                    move_dir.y = move_dir.y * -1

                    isCollider = true
                end
            end

            if isCollider == false then
                local hitBrick = self:checkBallPointHitBrick(gs.Vector2(ball_pos.x - radius, ball_pos.y), radius)
                if hitBrick then
                    local args = hitBrick:getArgs()

                    if collider_brickDic[args.row] == nil then
                        collider_brickDic[args.row] = {}
                    end
                    collider_brickDic[args.row][args.col] = hitBrick

                    move_dir.x = move_dir.x * -1

                    isCollider = true
                end
            end

            if isCollider == false then
                local hitBrick = self:checkBallPointHitBrick(gs.Vector2(ball_pos.x + radius, ball_pos.y), radius)
                if hitBrick then
                    local args = hitBrick:getArgs()

                    if collider_brickDic[args.row] == nil then
                        collider_brickDic[args.row] = {}
                    end
                    collider_brickDic[args.row][args.col] = hitBrick

                    move_dir.x = move_dir.x * -1

                    isCollider = true
                end
            end
        end

        if move_dir.x ~= 0 then
            if move_dir.x > 0 then --球往右走
                local hitBrick = self:checkBallPointHitBrick(gs.Vector2(ball_pos.x + radius, ball_pos.y), radius)
                if hitBrick then
                    local args = hitBrick:getArgs()

                    if collider_brickDic[args.row] == nil then
                        collider_brickDic[args.row] = {}
                    end
                    collider_brickDic[args.row][args.col] = hitBrick

                    move_dir.x = move_dir.x * -1

                    isCollider = true
                end
            elseif move_dir.x < 0 then --球往左走
                local hitBrick = self:checkBallPointHitBrick(gs.Vector2(ball_pos.x - radius, ball_pos.y), radius)
                if hitBrick then
                    local args = hitBrick:getArgs()

                    if collider_brickDic[args.row] == nil then
                        collider_brickDic[args.row] = {}
                    end
                    collider_brickDic[args.row][args.col] = hitBrick

                    move_dir.x = move_dir.x * -1

                    isCollider = true
                end
            end

            if isCollider == false then
                local hitBrick = self:checkBallPointHitBrick(gs.Vector2(ball_pos.x, ball_pos.y + radius), radius)
                if hitBrick then
                    local args = hitBrick:getArgs()

                    if collider_brickDic[args.row] == nil then
                        collider_brickDic[args.row] = {}
                    end
                    collider_brickDic[args.row][args.col] = hitBrick

                    move_dir.y = move_dir.y * -1

                    isCollider = true
                end
            end

            if isCollider == false then
                local hitBrick = self:checkBallPointHitBrick(gs.Vector2(ball_pos.x, ball_pos.y - radius), radius)
                if hitBrick then
                    local args = hitBrick:getArgs()

                    if collider_brickDic[args.row] == nil then
                        collider_brickDic[args.row] = {}
                    end
                    collider_brickDic[args.row][args.col] = hitBrick

                    move_dir.y = move_dir.y * -1

                    isCollider = true
                end
            end
        end

        for row, cow_dic in pairs(collider_brickDic) do
            for col, brick in pairs(cow_dic) do
                self:onBrickHit(brick, ball:getDamage())
            end
        end

        if not table.empty(collider_brickDic) then
            return move_dir
        end
    end

    --检测边缘
    if move_dir.x < 0 then --往左走
        if ball_pos.x - radius <= 0 then
            move_dir.x = move_dir.x *- 1
        end
    elseif move_dir.x > 0 then --往右走
        if ball_pos.x + radius >= 930 then
            move_dir.x = move_dir.x *- 1
        end
    end

    if move_dir.y > 0 then --球往上走
        if ball_pos.y + radius >= 0 then
            move_dir.y = move_dir.y * -1
        end
    elseif move_dir.y < 0 then --球往下走
        local lowPoint_y = ball_pos.y - radius

        --检测挡板道具
        if self.mImgBarrier.activeInHierarchy then
            local barrier_size = self.mImgBarrier_rect.rect
            local anchoredPosition = {x = self.mImgBarrier_rect.anchoredPosition.x + (self.m_sceneWith * 0.5), y = self.mImgBarrier_rect.anchoredPosition.y - (self.m_sceneHeight * 0.5)}
            local height = barrier_size.height * 0.5
            local width = barrier_size.width * 0.5

            if lowPoint_y <= anchoredPosition.y + height and lowPoint_y > anchoredPosition.y - height and (ball_pos.x >= anchoredPosition.x - width and ball_pos.x <= anchoredPosition.x + width) then
                move_dir.y = move_dir.y * -1

                AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_birck_6.prefab")
                return move_dir
            end
        end

        local height = self.mImgBoard_rectTrans.rect.height * 0.5 + 1
        local width = self.mImgBoard_rectTrans.rect.width * 0.5 + 10
        local anchoredPosition = {x = self.mImgBoard_rectTrans.anchoredPosition.x + (self.m_sceneWith * 0.5), y = self.mImgBoard_rectTrans.anchoredPosition.y - (self.m_sceneHeight * 0.5)}

        ---检测板子
        --检测板子上方
        if lowPoint_y <= anchoredPosition.y + height and lowPoint_y > anchoredPosition.y - height and (ball_pos.x >= anchoredPosition.x - width and ball_pos.x <= anchoredPosition.x + width) then
            ball:addHorizontalOffset(self.m_lastDragDistance)--添加横向偏移
            ball:addSpeed(self.m_dupConfigVo.add_speed, self.m_dupConfigVo.max_speed)--添加移动速度

            move_dir.y = move_dir.y * -1

            AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_birck_6.prefab")
            return move_dir
        end

        --检测板子侧面
        local loowPoint_x = ball_pos.x - radius
        if move_dir.x < 0 then --往左走
            if loowPoint_x <= anchoredPosition.x + width and loowPoint_x > anchoredPosition.x - width and (lowPoint_y >= anchoredPosition.y - height and lowPoint_y <= anchoredPosition.y + height) then
                ball:addHorizontalOffset(self.m_lastDragDistance)--添加横向偏移
                ball:addSpeed(self.m_dupConfigVo.add_speed, self.m_dupConfigVo.max_speed)--添加移动速度
                move_dir.x = move_dir.x *- 1
                move_dir.y = move_dir.y * -1

                AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_birck_6.prefab")
                return move_dir
            end
        elseif move_dir.x > 0 then --往右走
            if loowPoint_x <= anchoredPosition.x + width and loowPoint_x > anchoredPosition.x - width and (lowPoint_y >= anchoredPosition.y - height and lowPoint_y <= anchoredPosition.y + height) then
                ball:addHorizontalOffset(self.m_lastDragDistance)--添加横向偏移
                ball:addSpeed(self.m_dupConfigVo.add_speed, self.m_dupConfigVo.max_speed)--添加移动速度
                move_dir.x = move_dir.x *- 1
                move_dir.y = move_dir.y * -1

                AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_birck_6.prefab")
                return move_dir
            end
        end

        --掉出屏幕了
        if ball_pos.y + radius <= -self.m_sceneHeight then
            self:deleteBall(ball:getArgs().id)
            self:checkBallSettlement()
            move_dir = nil

            -- move_dir.y = move_dir.y * -1

            return move_dir
        end
    end

    return move_dir
end

function checkBallSettlement(self)
    if table.empty(self.m_ballDic) then
        self:onSettlement()
    end
end

function checkBrickSettlement(self)
    local curBrickCount = 0
    for row, col_dic in pairs(self.m_brickDic) do
        for col, brick in pairs(col_dic) do
            local brickConfig = shootBrick.ShootBrickManager:getBrickConfigVo(brick:getArgs().data.brick_id)
            if brickConfig.hp > 0 then
                curBrickCount = curBrickCount + 1
            end
        end
    end

    if curBrickCount <= 0 then
        self:onSettlement()
    end
end

function getCurStarCount(self)
    local configBrickCount = 0
    for row, col_dic in pairs(self.m_dupConfigVo:getBrickList()) do
        for col, config in pairs(col_dic) do
            local brickConfig = shootBrick.ShootBrickManager:getBrickConfigVo(config.brick_id)
            if brickConfig.hp > 0 then
                configBrickCount = configBrickCount + 1
            end
        end
    end

    local star = 0
    for i = 1, #self.m_dupConfigVo.star_list do
        local starConfig = shootBrick.ShootBrickManager:getStarConfigVo(self.m_dupConfigVo.star_list[i])
        if starConfig.point == -1 then
            local curBrickCount = 0
            for row, col_dic in pairs(self.m_brickDic) do
                for col, brick in pairs(col_dic) do
                    local brickConfig = shootBrick.ShootBrickManager:getBrickConfigVo(brick:getArgs().data.brick_id)
                    if brickConfig.hp > 0 then
                        curBrickCount = curBrickCount + 1
                    end
                end
            end

            if curBrickCount <= 0 then
                star = starConfig.star
            end
        else
            if self.m_score >= starConfig.point then
                star = starConfig.star
            end
        end
    end

    return star
end

--结算
function onSettlement(self)
    local star = self:getCurStarCount()
    GameDispatcher:dispatchEvent(EventName.ONREQ_SHOOTBRICK_PASS_DUP, {dup_id = self.m_dupConfigVo.id, star_count = star})

    self:removeKeyboardFrame()
end

---------------------------------------Util-------------------

-- 添加一个延时执行
function setTimeout(self, cusDelay, callback, cusCallBackParams)
    local idxSn = SnMgr:getSn()
    self.m_timeoutData = self.m_timeoutData or {}
    self.m_timeoutData[idxSn] = {id = idxSn, delay = cusDelay, callback = callback, callBackParams = cusCallBackParams}

    if not self.m_frameSn then
        self.m_frameSn = LoopManager:addFrame(1, 0, self, self.onFrame)
    end

    return idxSn
end

function onFrame(self)
    local deltaTime = gs.Time.deltaTime
    for id, data in pairs(self.m_timeoutData) do
        data.delay = data.delay - deltaTime
        if data.delay <= 0 then
            if data.callback then
                data.callback(self, data.callBackParams, id)
            end
            self.m_timeoutData[id] = nil
        end
    end
end

-- 清除一个延时执行
function clearTimeout(self, id)
    if self.m_timeoutData then
        for k, v in pairs(self.m_timeoutData) do
            if v.id == id then
                self.m_timeoutData[k] = nil
                break
            end
        end
    end
end

-- 移除所有延时执行
function clearAllTimeout(self)
    if self.m_frameSn then
        LoopManager:removeFrameByIndex(self.m_frameSn)
        self.m_frameSn = nil
    end

    self.m_timeoutData = {}
end

return _M
