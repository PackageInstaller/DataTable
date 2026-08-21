module("bulle.BulleGamePanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("bulle/BulleGamePanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isScreensave = 0 -- 是否使用黑屏过渡(仅1全屏UI有效，默认开启，0关闭)
isBlur = 0
escapeClose = 0 -- 是否能通过esc关闭窗口
isShowCloseAll = false
-- 构造函数
function ctor(self)
    super.ctor(self)
    -- self:setTxtTitle(_TT(149186))
    --self:setSize(1334, 750)
    -- self:setBg("guild_bg.jpg", false, "guild")
    -- self:setUICode(LinkCode.GuildWar)
end

-- 初始化数据
function initData(self)
    super.initData(self)

    self.gameCurTime = 0
    self.gameEndTime = 30
    self.lastBossTime = 0

    self.mScore = 0 -- 分数
    -- self.mGameItemList = {}

    self.mMaxGameItemIndexList = {}

    self.mLineItemDic = {}
    self.mGradItemDic = {}
    self.allSamedic = {}

    -- 角度限制
    self.maxAngle = 80
    -- 发射力度系数
    self.mLaunchForce = 12
    -- X行数量
    self.xCount = 10
    -- Y行数量
    self.yCount = 12
    -- 预览线总长度
    self.lineLength = 4
    -- 下移一格间隔
    self.moveTime = 10
    -- 下移一格距离
    self.moveTop = 46

    self.destroySnList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.m_startView = bulle.BulleStartView.new()
    self.m_startView:initData(self:getChildGO('StartGroup'))
    self.mBtnPause = self:getChildGO("mBtnPause")
    self.mGame = self:getChildGO("mGame")
    self.mStartContent = self:getChildTrans("mStartContent")
    self.mStartObj = self:getChildGO("mStartContent")

    self.mGameItem = self:getChildGO("mGameItem")

    self.mImgGamePre = self:getChildGO("mImgGamePre"):GetComponent(ty.AutoRefImage)
    self.mImgTimerBg = self:getChildGO("mImgTimerBg")
    self.mImgTimerBg:SetActive(false)
    self.mImgTimer = self:getChildGO("mImgTimer"):GetComponent(ty.AutoRefImage)

    self.mGroupPause = self:getChildGO("mGroupPause")
    self.mBtnExit = self:getChildGO("mBtnExit")
    self.mBtnFinish = self:getChildGO("mBtnFinish")
    self.mBtnReplay = self:getChildGO("mBtnReplay")
    self.mBtnPlay = self:getChildGO("mBtnPlay")
    self.mPhysicsFrame = self:getChildGO("mGame"):GetComponent(ty.PhysicsFrame)
    self.mPhysicsFrame:SetUpdateCall(self, self.onFixFrame)
    self.mGameScroll = self:getChildGO("mGameScroll"):GetComponent(ty.ScrollRect)
    self.mLineItem = self:getChildGO("mLineItem")
    self.mGardItem = self:getChildGO("mGardItem")

    self.mLineRenderer = self:getChildGO("mLineRenderer"):GetComponent(ty.LineRenderer)

    self.mGameContent = self:getChildTrans("mGameContent")
    self.mLauncher = self:getChildGO("mLauncher")

    self.left = self:getChildGO("left")
    self.right = self:getChildGO("right")
    self.top = self:getChildGO("top")

    self.left.layer = gs.LayerMask.NameToLayer("AirWall")

    self.right.layer = gs.LayerMask.NameToLayer("AirWall")

    self.top.layer = gs.LayerMask.NameToLayer("AirWall")

    self.mGameScrollContentLayout = self.mGameScroll.content:GetComponent(ty.VerticalLayoutGroup)
    self.mGameScrollSizeFitter = self.mGameScroll.content:GetComponent(ty.ContentSizeFitter)

    self.mTxtScoreGame = self:getChildGO("mTxtScoreGame"):GetComponent(ty.Text)

    self.mTxtLevel = self:getChildGO("mTxtLevel"):GetComponent(ty.Text)
    self.mImgNext = self:getChildGO("mImgNext"):GetComponent(ty.AutoRefImage)

    self.mImgCusBg = self:getChildGO("mImgCusBg"):GetComponent(ty.AutoRefImage)

    self.mAni = self:getChildGO("mHero"):GetComponent(ty.Animator)
    -- self.mTxtTargetGame = self:getChildGO("mTxtTargetGame"):GetComponent(ty.Text)
end

function initViewText(self)

end

function onFixFrame(self)
    bulle.BulleGameWorld:onUpdate()
end

function checkGame(self)
    local maxY = 0
    local ballCount = 0
    for k, v in pairs(self.mGradItemDic) do
        if v.ballItem ~= nil then
            ballCount = ballCount + 1
            if v.y > maxY then
                maxY = v.y
            end
        end
    end
    if maxY > self.yCount - self.moveCount - 3 then
        self:onGameEnd(false)
    end
    if ballCount == 0 then
        self:onGameEnd(true)
    end
end

-- 激活
function active(self, args)
    super.active(self, args)
    self.dupId = args.dupId
    -- self.mBtnPause:SetActive(true)
    MoneyManager:setMoneyTidList({})
    local function _finishCall()
        self.m_startView:setActive(false)
        self:showPanel()
    end
    self.m_startView:setActive(true)
    self.m_startView:start(_finishCall)
    self:initGameData()
end

-- 反激活（销毁工作）
function deActive(self)
    self:clearAllGameItem()
    bulle.BulleGameWorld:unRegisterAll()
    super.deActive(self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})

    self:clearAllSn()
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnPause, self.onClickPause)
    self:addUIEvent(self.mBtnExit, self.onClickExit)
    self:addUIEvent(self.mBtnReplay, self.onClickReplay)
    self:addUIEvent(self.mBtnPlay, self.onClickPlay)
end

function onClickExit(self)
    self:close()
end

function clearAllGameItem(self)
    for k, v in pairs(self.mLineItemDic) do
        v:poolRecover()
    end
    self.mLineItemDic = {}
    if self.mRunBallItem ~= nil then
        self.mRunBallItem:poolRecover()
        self.mRunBallItem = nil
    end

    if self.mPreBall.item ~= nil then
        self.mPreBall.item:poolRecover()
        self.mPreBall = nil
    end
    for k, v in pairs(self.mGradItemDic) do
        if v.ballItem ~= nil then
            v.ballItem:poolRecover()
            v.ballItem = nil
        end
        if v.gradItem ~= nil then
            v.gradItem:poolRecover()
            v.gradItem = nil
        end
    end
    self.mGradItemDic = {}

end

function onClickReplay(self)
    self.isPasue = false
    self.mGroupPause:SetActive(false)
    self:clearAllSn()
    self:clearAllGameItem()

    self:initGameData()
    local function _finishCall()
        self.m_startView:setActive(false)
        self:showPanel()
    end
    self.m_startView:setActive(true)
    self.m_startView:start(_finishCall)
end

function onClickPlay(self)
    if self.mRunBallItem then
        self.mRunBallItem:getGo():GetComponent(ty.Rigidbody2D).bodyType = 0
    end
    self.isPasue = false
    self.mGroupPause:SetActive(false)
    self.canRun = true
end

function onClickPause(self)
    self.draw = false
    self.canRun = false
    self.isPasue = true

    if self.mRunBallItem then
        self.mRunBallItem:getGo():GetComponent(ty.Rigidbody2D).bodyType = 2
    end
    self.mGroupPause:SetActive(true)
end

function clearAllSn(self)
    if self.gameSn ~= nil then
        LoopManager:removeFrameByIndex(self.gameSn)
        self.gameSn = nil
    end

    for i = 1, #self.destroySnList do
        self:clearTimeout(self.destroySnList[i])
    end
    self.destroySnList = {}

    if self.createSn then
        self:clearTimeout(self.createSn)
    end
    self.createSn = nil
end

function onMoveBallCollider(self, voList)
    if #voList == 0 then
        return
    end

    local keys = ""
    for i = 1, #voList do
        keys = keys .. voList[i].key .. "|"
    end

    local ballVoList = {}
    local gradVoList = {}
    local hasTop = false
    for i = 1, #voList do
        if voList[i].selfGroup == bulle.BulleGroup.StaticBall then
            table.insert(ballVoList, voList[i])
        elseif voList[i].selfGroup == bulle.BulleGroup.Groud then
            if voList[i].key <= 100 + self.xCount and self.mGradItemDic[voList[i].key].ballItem == nil then
                hasTop = true
            end
            table.insert(gradVoList, voList[i])
        end
    end
    local createKey = 0
    if hasTop then
        local minMag = 99999
        for i = 1, #gradVoList do
            if gradVoList[i].key <= 100 + self.xCount then
                local mag = gs.Vector3.Distance(gradVoList[i].obj.transform.position,
                    self.mRunBallItem:getGo().transform.position)
                if mag < minMag then
                    minMag = mag
                    createKey = gradVoList[i].key
                end
            end
        end
    else
        if #ballVoList >= 1 and #gradVoList >= 1 then
            local minMag = 99999
            for i = 1, #gradVoList do
                local mag = gs.Vector3.Distance(gradVoList[i].obj.transform.position,
                    self.mRunBallItem:getGo().transform.position)
                if mag < minMag then
                    minMag = mag
                    createKey = gradVoList[i].key
                end
            end
        end
    end
    if createKey == 0 then
        return
    end
    bulle.BulleGameWorld:unRegisterToTheWorld(bulle.Id.MoveWorldId)
    local ballItem = self.mRunBallItem
    ballItem:getChildGO("Effect"):SetActive(true)
    ballItem:getGo():GetComponent(ty.Rigidbody2D).simulated = false
    ballItem:getGo():GetComponent(ty.Collider2D).isTrigger = true
    ballItem:getChildGO("mTxtColor"):GetComponent(ty.Text).text = self.mRunBallColor
    self.mGradItemDic[createKey].ballItem = ballItem
    self.mGradItemDic[createKey].color = self.mRunBallColor
    local gradItem = self.mGradItemDic[createKey].gradItem:getGo()
    ballItem:getGo().name = gradItem.name .. " - ball"
    ballItem:getGo().transform:SetParent(gradItem.transform)
    gs.TransQuick:UIPos(ballItem:getGo():GetComponent(ty.RectTransform), 0, 0)
    ballItem:getGo().transform.eulerAngles = gs.Vector3(0, 0, 0)
    bulle.BulleGameWorld:changeWorldVo(createKey, ballItem:getGo(), "Sphere", bulle.BulleGroup.StaticBall)
    self.lastJoinBallKey = createKey
    self.mRunBallItem = nil
    self.canRun = true

    self:checkEvent(self.lastJoinBallKey, self.mRunBallColor)
    self:checkGame()
end

function checkEvent(self, key, color)
    self.allSamedic = {}
    self.checkBallKeyList = {}
    self:check(self.lastJoinBallKey, color)

    if table.nums(self.allSamedic) >= 3 then
        for k, v in pairs(self.allSamedic) do
            local ballItem = self.mGradItemDic[k].ballItem
            ballItem:getChildGO("Effect0" .. self.mGradItemDic[k].color):SetActive(true)
            self.mGradItemDic[k].ballItem = nil
            self.mGradItemDic[k].color = 0
            ballItem:getGo():GetComponent(ty.Rigidbody2D).simulated = true
            ballItem:getGo():GetComponent(ty.Collider2D).enabled = false
            bulle.BulleGameWorld:changeWorldVo(k, self.mGradItemDic[k].gradItem:getGo(), "Sphere",
                bulle.BulleGroup.Groud)

            local rig = ballItem:getGo():GetComponent(ty.Rigidbody2D)
            rig.gravityScale = 0
            rig.velocity = gs.Vector2(0, 0)
            
            local desSn = LoopManager:setTimeout(0.5, self, function()
                ballItem:poolRecover()
            end)
            table.insert(self.destroySnList, desSn)
        end
        AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_bulle_2.prefab")
        self.mScore = self.mScore + table.nums(self.allSamedic) * self.destroyScore
        self.mTxtScoreGame.text = self.mScore
        self.mAni:SetTrigger("show03")
        self:checkToTop()
    end
end

function check(self, key, color)
    local keyList = self:getAdjacentKey(key)
    if next(keyList) == nil then
        return
    end
    for _, childKey in ipairs(keyList) do
        self:checkBallEvent(childKey, color)
    end
    self.allSamedic[key] = 1
    for key, childKey in pairs(self.allSamedic) do
        self:check(key, color)
    end
end

function checkBallEvent(self, key, color)
    if (self.mGradItemDic[key].color == color) and self.allSamedic[key] == nil then
        self.allSamedic[key] = 1
    end
end

function getAdjacentKey(self, key)
    if table.indexof01(self.checkBallKeyList, key) ~= 0 then
        return {}
    end
    table.insert(self.checkBallKeyList, key)
    local x = self.mGradItemDic[key].x
    local y = self.mGradItemDic[key].y
    local isSingle = y % 2 == 1
    local keyList = {}
    -- 如果是单数行
    if isSingle then
        if x >= 2 and y >= 2 then
            local simX = x - 1
            local simY = y - 1
            table.insert(keyList, simX + simY * 100)
        end
        if y >= 2 and x <= self.xCount - 1 then
            local simX = x
            local simY = y - 1
            table.insert(keyList, simX + simY * 100)
        end
        if x >= 2 then
            local simX = x - 1
            local simY = y
            table.insert(keyList, simX + simY * 100)
        end
        if x <= self.xCount - 1 then
            local simX = x + 1
            local simY = y
            table.insert(keyList, simX + simY * 100)
        end
        if x >= 2 and y <= self.yCount - 1 then
            local simX = x - 1
            local simY = y + 1
            table.insert(keyList, simX + simY * 100)
        end
        if y <= self.yCount - 1 and x <= self.xCount - 1 then
            local simX = x
            local simY = y + 1
            table.insert(keyList, simX + simY * 100)
        end
    else
        local simX = x
        local simY = y - 1
        table.insert(keyList, simX + simY * 100)
        simX = x + 1
        simY = y - 1
        table.insert(keyList, simX + simY * 100)

        if x >= 2 then
            simX = x - 1
            simY = y
            table.insert(keyList, simX + simY * 100)
        end

        if x <= self.xCount - 2 then
            simX = x + 1
            simY = y
            table.insert(keyList, simX + simY * 100)
        end

        simX = x
        simY = y + 1
        table.insert(keyList, simX + simY * 100)
        simX = x + 1
        simY = y + 1
        table.insert(keyList, simX + simY * 100)
    end
    return keyList
end

function checkToTop(self)
    self.checkBallKeyList = {}
    self.mFindSameDic = {}
    local startIdKey = {}
    local hasBallIdList = {}
    for k, v in pairs(self.mGradItemDic) do
        if self.mGradItemDic[k].ballItem ~= nil then
            table.insert(hasBallIdList, k)
            if k <= 100 + self.xCount then
                table.insert(startIdKey, k)
            end
        end
    end
    for i = 1, #startIdKey, 1 do
        self:checkNil(startIdKey[i])
    end

    local notFindKeyList = {}
    for k, v in pairs(self.mGradItemDic) do
        if self.mFindSameDic[k] == nil and self.mGradItemDic[k].ballItem ~= nil then
            table.insert(notFindKeyList, k)
        end
    end

    if #notFindKeyList > 0 then
        for i = 1, #notFindKeyList do
            local k = notFindKeyList[i]
            local ballItem = self.mGradItemDic[k].ballItem
            self.mGradItemDic[k].ballItem = nil
            self.mGradItemDic[k].color = 0
            ballItem:getGo():GetComponent(ty.Rigidbody2D).simulated = true
            ballItem:getGo():GetComponent(ty.Collider2D).enabled = false
            bulle.BulleGameWorld:changeWorldVo(k, self.mGradItemDic[k].gradItem:getGo(), "Sphere",
                bulle.BulleGroup.Groud)

            local rig = ballItem:getGo():GetComponent(ty.Rigidbody2D)
            rig.gravityScale = 1.3 --  9.8/  
            rig.velocity = gs.Vector2(0, -2)
            
            local desSn = LoopManager:setTimeout(1, self, function()
                ballItem:poolRecover()
            end)
            table.insert(self.destroySnList, desSn)
        end
        AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_bulle_3.prefab")
        self.mScore = self.mScore + #notFindKeyList * self.dropScore
        self.mTxtScoreGame.text = self.mScore
    end
end

function checkNil(self, key)
    local keyList = self:getAdjacentKey(key)
    if next(keyList) == nil then
        return
    end

    for _, child in pairs(keyList) do
        self:checkNilEvent(child)
    end

    self.mFindSameDic[key] = 1
    for key, childKey in pairs(self.mFindSameDic) do
        self:checkNil(key)
    end
end

function checkNilEvent(self, key)
    if self.mGradItemDic[key].ballItem ~= nil and self.mFindSameDic[key] == nil then
        self.mFindSameDic[key] = 1
    end
end

function initGameData(self)

    self.destroyScore = sysParam.SysParamManager:getValue(SysParamType.BULLE_DESTORY_SCORE)
    self.dropScore = sysParam.SysParamManager:getValue(SysParamType.BULLE_DROP_SCORE)

    self.mLineRenderer.positionCount = 3
    bulle.BulleGameWorld:unRegisterAll()
    self.mScore = 0
    self.mTxtScoreGame.text = self.mScore
    self.isEnd = false
    self.mGameEnd = false
    self.uiCamera = gs.CameraMgr:GetUICamera()
    self.canRun = true
    self.currentTime = 0
    self.moveCount = 0
    self.mGameScrollContentLayout.padding.top = -594
    self.playShow = false

    local gameDataVo = bulle.BulleManager:getBulleDataById(self.dupId)
    self.moveTime = gameDataVo.time

    self.eventDic = gameDataVo.eventDic
    self.randomList = gameDataVo.iconList

    self.mTxtLevel.text = gameDataVo.name
    self.mImgCusBg:SetImg(UrlManager:getBgPath("bulle/bg_0" .. gameDataVo.background .. ".jpg"), false)

    local index = 0
    for y = 1, self.yCount do
        local lineItem = SimpleInsItem:create(self.mLineItem, self.mGameScroll.content, "mLineItem")
        self.mLineItemDic[y] = lineItem
        local needCount = y % 2 == 0 and self.xCount - 1 or self.xCount
        local needLeft = y % 2 == 0 and 26 or 0

        lineItem:getGo():GetComponent(ty.HorizontalLayoutGroup).padding.left = needLeft
        for x = 1, needCount, 1 do
            local gradItem = SimpleInsItem:create(self.mGardItem, lineItem:getGo().transform, "mGardItem")
            index = y * 100 + x
            gradItem:getGo().name = "g-(" .. y .. "-" .. x .. ")" .. " " .. index
            gradItem:getGo():GetComponent(ty.Text).text = ""
            local ballItem = nil
            local color = 0
            if self.eventDic[index] ~= nil then
                ballItem = SimpleInsItem:create(self.mGameItem, gradItem:getGo().transform, "mBallItem")
                ballItem:getChildGO("Effect"):SetActive(false)
                for i = 1, 9 do
                    ballItem:getChildGO("Effect0" .. i):SetActive(false)
                end
                gs.TransQuick:UIPos(ballItem:getGo():GetComponent(ty.RectTransform), 0, 0)
                color = self.eventDic[index].icon_id
                ballItem:getChildGO("mImgBall"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(
                    "bulle/ball_" .. color .. ".png"), false)
                ballItem:getGo():GetComponent(ty.Rigidbody2D).simulated = false
                ballItem:getGo():GetComponent(ty.Collider2D).isTrigger = true
                ballItem:getChildGO("mTxtColor"):GetComponent(ty.Text).text = color
            end
            self.mGradItemDic[index] = {
                gradItem = gradItem,
                ballItem = ballItem,
                data = self.eventDic[index],
                color = color,
                y = y,
                x = x
            }
        end
        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(lineItem:getGo().transform)
    end
    self.mGameScrollSizeFitter.enabled = false
    self.mGameScrollSizeFitter.enabled = true
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mGameScroll.transform)

    for k, v in pairs(self.mGradItemDic) do
        bulle.BulleGameWorld:registerToTheWorld(k, 0, v.gradItem:getGo(), "Sphere", bulle.BulleGroup.Groud,
            {bulle.BulleGroup.None}, false, false, nil, nil, nil)
        if v.ballItem ~= nil then
            bulle.BulleGameWorld:changeWorldVo(k, v.ballItem:getGo(), "Sphere", bulle.BulleGroup.StaticBall)
        end
    end
    self.nextColor = nil
    -- self:createNextBall()
    self:createPreBall()
end

function createPreBall(self)
    local ballItem = SimpleInsItem:create(self.mGameItem, self.mGameContent, "mBallItem")
    gs.TransQuick:UIPos(ballItem:getGo():GetComponent(ty.RectTransform), 0, 0)
    ballItem:getChildGO("Effect"):SetActive(false)
    for i = 1, 9 do
        ballItem:getChildGO("Effect0" .. i):SetActive(false)
    end

    ballItem:getGo():GetComponent(ty.Collider2D).enabled = false
    local rig = ballItem:getGo():GetComponent(ty.Rigidbody2D)
    rig.simulated = false

    local color
    if self.nextColor == nil then
        local randomCurrent = math.random(1, #self.randomList)
        color = self.randomList[randomCurrent]
    else
        color = self.nextColor
    end

    ballItem:getChildGO("mImgBall"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(
        "bulle/ball_" .. color .. ".png"), false)

    self.tempColor = color
    self.mPreBall = {
        item = ballItem,
    }

    self:createNextBall()
end

function createNextBall(self)
    local remColor = {}
    for k,v in pairs(self.mGradItemDic) do
        if v.color > 0 and table.indexof01(remColor, v.color) == 0 then
            table.insert(remColor, v.color)
        end
    end

    local random = math.random(1, #remColor)
    self.nextColor = remColor[random]
    self.mImgNext:SetImg(UrlManager:getPackPath("bulle/ball_" .. self.nextColor .. ".png"), false)
end

function lshift(self, num, bits)
    return num * (2 ^ bits)
end

function showPanel(self)
    bulle.BulleGameWorld:setGameRun(true)

    if self.gameSn ~= nil then
        LoopManager:removeFrameByIndex(self.gameSn)
        self.gameSn = nil
    end
    self.gameSn = LoopManager:addFrame(0, 0, self, self.updateGame)
end

-- GameDispatcher:dispatchEvent(EventName.OPEN_BULLE_GAME_PANEL)
function updateGame(self)
    if self.isPasue or self.isEnd then
        self.mLineRenderer.gameObject:SetActive(false)
        return
    end

    self.currentTime = self.currentTime + gs.Time.deltaTime

    if self.currentTime >= self.moveTime - 3 and self.playShow == false then
        self.playShow = true
        for k, v in pairs(self.mGradItemDic) do
            if v.ballItem ~= nil then
                v.ballItem:getGo():GetComponent(ty.Animator):SetTrigger("show")
            end
        end
    end

    if self.currentTime >= self.moveTime then
        self.len = 0
        self.frame = 30
        self.firstTop = self.mGameScrollContentLayout.padding.top

        self.moveTweenSn = LoopManager:addFrame(1, self.frame, self, function()
            self.len = 1 / self.frame + self.len
            self.mGameScrollContentLayout.padding.top = self.firstTop + self.moveTop * self.len
            self.mGameScrollSizeFitter.enabled = false
            self.mGameScrollSizeFitter.enabled = true
        end, function()
              self.playShow = false
            self:checkGame()
        end)
        self.currentTime = 0
        self.moveCount = self.moveCount + 1
    end

    -- local remTime = self.moveTime - self.currentTime
    -- if remTime <= 3 then
    --     self.mImgTimerBg:SetActive(true)
    --     if remTime <= 1 then
    --         self.mImgTimer:SetImg(UrlManager:getPackPath("watermelon/timer1.png"), false)
    --     elseif remTime > 1 and remTime <= 2 then
    --         self.mImgTimer:SetImg(UrlManager:getPackPath("watermelon/timer2.png"), false)
    --     elseif remTime > 2 and remTime <= 3 then
    --         self.mImgTimer:SetImg(UrlManager:getPackPath("watermelon/timer3.png"), false)
    --     end
    -- else
    --     self.mImgTimerBg:SetActive(false)
    -- end

    if gs.Input.GetMouseButtonDown(0) then
        self.draw = true
    end

    if gs.Input.GetMouseButtonUp(0) and self.draw then
        self.draw = false

        if self.canRun == true then
            self.canRun = false
            local ballItem = self.mPreBall.item
            ballItem:getGo().name = "createBall"
            --ballItem:getGo():SetParent(self.mGameContent.transform)
            ballItem:getGo():GetComponent(ty.Collider2D).enabled = true
            ballItem:getGo():GetComponent(ty.Collider2D).isTrigger = false
            local rig = ballItem:getGo():GetComponent(ty.Rigidbody2D)
            rig.simulated = true
            rig.gravityScale = 0
            local dir = self.mLauncher.transform.up
            rig.velocity = gs.Vector2(dir.x, dir.y) * self.mLaunchForce
            self.mAni:SetTrigger("show02")
            bulle.BulleGameWorld:registerToTheWorld(bulle.Id.MoveWorldId, 0, ballItem:getGo(), "Sphere",
                bulle.BulleGroup.MoveBall, {bulle.BulleGroup.StaticBall, bulle.BulleGroup.Groud}, true, false,
                function(keyList)
                    self:onMoveBallCollider(keyList)
                end,nil,nil)
            -- ballItem:getChildGO("mTxtColor"):GetComponent(ty.Text).text = self.mPreBall.color
            self.mRunBallColor = self.tempColor
            self.mRunBallItem = ballItem
             AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_bulle_1.prefab")
            self:createPreBall()

            -- end)
            -- table.insert(self.destroySnList, createSn)
        end
    end

    if self.draw then

        local mousePos = self.uiCamera:ScreenToWorldPoint(gs.Input.mousePosition)
        local ray = self.uiCamera:ScreenPointToRay(mousePos)

        local direction = (mousePos -
                              gs.Vector3(self.mLauncher.transform.position.x, self.mLauncher.transform.position.y, 0)).normalized
        if self.mGameEnd == false then
            -- 计算限制角度和旋转
            local dirV2 = gs.Vector2(direction.x, direction.y)
            local angle = self:signedAngle(gs.Vector2.up, dirV2)
            angle = gs.Mathf.Clamp(angle, -self.maxAngle, self.maxAngle)

            local euler = gs.Quaternion.Euler(0, 0, angle)
            euler = euler * gs.Vector3.up
            euler = gs.Vector3(euler.x, euler.y, 0)
            self.mLauncher.transform.rotation = gs.Quaternion.LookRotation(gs.Vector3.forward, euler)
            self.mLineRenderer:SetPosition(0, self.mLauncher.transform.position)

            -- 计算射线
            local lineDir = self.mLauncher.transform.up
            local lineDirV2 = gs.Vector2(lineDir.x, lineDir.y)
            local launcherV2 = gs.Vector2(self.mLauncher.transform.position.x, self.mLauncher.transform.position.y)
            local hitInfos =  CS.UnityEngine.Physics2D.RaycastAll(launcherV2, lineDirV2, self.lineLength,
                self:lshift(1, gs.LayerMask.NameToLayer("AirWall")))
            if hitInfos.Length > 0 then
                for i = 0, hitInfos.Length - 1 do
                    -- 射到右边或左边，计算反射方向
                    if hitInfos[i].collider.name == "right" or hitInfos[i].collider.name == "left" then
                        self.mLineRenderer.positionCount = 3
                        local hitV3 = gs.Vector3(hitInfos[i].point.x, hitInfos[i].point.y, 80)
                        self.mLineRenderer:SetPosition(1, hitV3)
                        local refDir = self:reflect(hitInfos[i].point - launcherV2, hitInfos[i].normal)
                        local refDirV3 = gs.Vector3(refDir.x, refDir.y, 0).normalized
                        local remLength = self.lineLength - (hitV3 - self.mLauncher.transform.position).magnitude
                        self.mLineRenderer:SetPosition(2, hitV3 + refDirV3 * remLength)
                        break
                    elseif hitInfos[i].collider.name == "top" then
                        self.mLineRenderer.positionCount = 2
                        self.mLineRenderer:SetPosition(1, self.mLauncher.transform.position + lineDir * self.lineLength)
                        break
                    end
                end
            else
                self.mLineRenderer.positionCount = 2
                self.mLineRenderer:SetPosition(1, self.mLauncher.transform.position + lineDir * self.lineLength)
            end

            self.lastDir = direction

        end
        self.mLineRenderer.gameObject:SetActive(true)
    else
        self.mLineRenderer.gameObject:SetActive(false)
    end

end

function reflect(self,inDir,inNorm)
    local num = -2 * self:dot(inNorm,inDir)
    return gs.Vector2(num*inNorm.x+inDir.x,num * inNorm.y+inDir.y)
end


function signedAngle(self,from,to)
    local num = self:angle(from,to)
    local num2 = gs.Mathf.Sign(from.x*to.y - from.y*to.x)
    return num * num2
end

function angle(self,from,to)
    local num = gs.Mathf.Sqrt(from.sqrMagnitude * to.sqrMagnitude)
    if num <0.00000000001 then
        return  0
    end
    local num2 = gs.Mathf.Clamp(self:dot(from,to) / num,-1,1)
    return gs.Mathf.Acos(num2) * 57.29578
end

function dot(self,lhs,rhs)
    return lhs.x * rhs.x + lhs.y * rhs.y
end


function onGameEnd(self, isWin)
    for k, v in pairs(self.mGradItemDic) do
        if v.ballItem ~= nil then
            v.ballItem:getGo():GetComponent(ty.Rigidbody2D).simulated = false
            v.ballItem:getGo():GetComponent(ty.Collider2D).enabled = false
        end
    end
    self.isEnd = true
    bulle.BulleGameWorld:setGameRun(false)

    local his = bulle.BulleManager:getDupPassStar(self.dupId)
    local isPass = bulle.BulleManager:getDupPassState(self.dupId)
    local isFirst = false
    if isWin and isPass == false then
        isFirst = true
    end

    GameDispatcher:dispatchEvent(EventName.REQ_BULLE_EVENT, self.mScore)
    GameDispatcher:dispatchEvent(EventName.OPEN_BULLE_SETTLE_PANEL, {
        dupId = self.dupId,
        score = self.mScore,
        first = isFirst,
        isWin = isWin
    })
end

return _M
