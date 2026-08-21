module("bird.BirdGamePanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("bird/BirdGamePanel.prefab")
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
    -- self:setSize(0, 0)
    -- self:setBg("guild_bg.jpg", false, "guild")
    -- self:setUICode(LinkCode.GuildWar)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.topSpeed = 5
    self.wallSpeed = 5
    self.coinScore = 10

    self.easyIndex = 20

    self.easyCap = 500
    self.hardCap = 400

    self.wallItems = {}
    self.coinItems = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.m_startView = bird.BirdStartView.new()
    self.m_startView:initData(self:getChildGO('StartGroup'))

    self.mPlayer = self:getChildGO("mPlayer")
    self.mRig = self:getChildGO("mPlayer"):GetComponent(ty.Rigidbody2D)
    self.mCollider = self:getChildGO("mPlayer"):GetComponent(ty.Collider2D)
    self.mPhysicsCollider = self:getChildGO("mPlayer"):GetComponent(ty.PhysicsTrigger2D)
    self.mPhysicsCollider:SetCollisionCallFun(self, self.onColliderEnter2D, nil, nil)

    self.mPhysicsFrame = self:getChildGO("mGame"):GetComponent(ty.PhysicsFrame)
    self.mPhysicsFrame:SetUpdateCall(self, self.onFixFrame)

    self.mWall1 = self:getChildGO("mWall1")
    self.mWall2 = self:getChildGO("mWall2")
    self.mCreatePos = self:getChildTrans("mCreatePos")
    self.mEndPos = self:getChildTrans("mEndPos")

    self.mTxtCurPoint = self:getChildGO("mTxtCurPoint"):GetComponent(ty.Text)
    self.mTxtTargetPoint = self:getChildGO("mTxtTargetPoint"):GetComponent(ty.Text)

    self.mCoin = self:getChildGO("mCoin")

    self.mBg1Material = self:getChildGO("mBg1"):GetComponent(ty.Image).material
    self.mBg2Material = self:getChildGO("mBg2"):GetComponent(ty.Image).material

    self.mBtnPause = self:getChildGO("mBtnPause")
    self.mGroupPause = self:getChildGO("mGroupPause")
    self.mTxtPause = self:getChildGO("mTxtPause"):GetComponent(ty.Text)
    self.mTxtCurrentScore = self:getChildGO("mTxtCurrentScore"):GetComponent(ty.Text)
    self.mTxtTargetScore = self:getChildGO("mTxtTargetScore"):GetComponent(ty.Text)

    self.mBtnExit = self:getChildGO("mBtnExit")
    self.mBtnFinish = self:getChildGO("mBtnFinish")
    self.mBtnReplay = self:getChildGO("mBtnReplay")
    self.mBtnPlay = self:getChildGO("mBtnPlay")

    self.mIsTarget = self:getChildGO("mIsTarget")
    self.mIsTargetNot = self:getChildGO("mIsTargetNot")

    self.mTxtCurPointTips = self:getChildGO("mTxtCurPointTips"):GetComponent(ty.Text)
    self.mTxtTargetPointTips = self:getChildGO("mTxtTargetPointTips"):GetComponent(ty.Text)

    -- self.mEffect01 = self:getChildGO("mEffect01")
    -- self.mEffect02 = self:getChildGO("mEffect02")

    self.gameAni = self.UIObject:GetComponent(ty.Animator)
    self.mPlayerAni = self:getChildGO("mPlayerAni"):GetComponent(ty.Animator)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnPause, self.onClickPause)
    self:addUIEvent(self.mBtnExit, self.onClickExit)
    self:addUIEvent(self.mBtnFinish, self.onClickFinish)
    self:addUIEvent(self.mBtnReplay, self.onClickReplay)
    self:addUIEvent(self.mBtnPlay, self.onClickPlay)
end


function initViewText(self)
    self.mTxtCurPointTips.text = _TT(151260)
    self.mTxtTargetPointTips.text = _TT(151261)
end

function onClickPause(self)
    self.isPasue = true
    self.shaderScrolling = false
    self.mPlayerAni:SetTrigger("def")
    self.mRig.bodyType = 2

    if self.gameData.targetScore <= self.score then
        self.mBtnFinish:SetActive(true)
        self.mBtnExit:SetActive(false)
        -- self.mBtnReplay:SetActive(false)
    else
        self.mBtnFinish:SetActive(false)
        self.mBtnExit:SetActive(true)
    end
    self.mGroupPause:SetActive(true)
    self.mTxtCurrentScore.text = _TT(151209) .. self.score
    self.mTxtTargetScore.text = _TT(151208) .. self.gameData.targetScore
    self.mIsTarget:SetActive(self.gameData.targetScore <= self.score)
    self.mIsTargetNot:SetActive(self.gameData.targetScore > self.score)

end

function onClickExit(self)
    self:close()
end

function onClickFinish(self)
    self.mGroupPause:SetActive(false)
    self:onGameEnd()
end

function onClickPlay(self)
    self.isPasue = false
    self.mGroupPause:SetActive(false)


    self.shaderScrolling = true
    self.mRig.bodyType = 0
end

function onClickReplay(self)
    self.isPasue = false
    self.mGroupPause:SetActive(false)
    self:clearGameSn()
    self:clearAllItems()

    local function _finishCall()
        self.m_startView:setActive(false)
        self:showPanel()
    end

    self.m_startView:setActive(true)
    self.m_startView:start(_finishCall)
    self:initGameData()
end

function onColliderEnter2D(self, collider2D)
    if collider2D.gameObject.name == "getScore" then
        AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_bird_2.prefab")
        self.score = self.score + 1
    end
    local isCoin = string.find(collider2D.gameObject.name, "mCoin|")
    if isCoin then
        local spStrings = string.split(collider2D.gameObject.name, "|")
        self.score = self.score + self.coinScore
        self.coinItems[tonumber(spStrings[2])]:poolRecover()
        self.coinItems[tonumber(spStrings[2])] = nil
        AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_bird_3.prefab")
        self.gameAni:SetTrigger("show01")
    end

    local isWall = string.find(collider2D.gameObject.name, "wall")
    if isWall then
        AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_common_1.prefab")
        self.gameAni:SetTrigger("show02")
        self:onGameEnd()
        return
    end

    self.mTxtCurPoint.text = self.score
    if self.score >= self.gameData.targetScore and self.isFirstFinish == false then
        self.isFirstFinish = true
        self:onClickPause()
    end
end

function initViewText(self)

end

function onFixFrame(self)
    self.shaderCurrentTime = gs.Time.time
    self.shaderDeltaTime = self.shaderCurrentTime - self.lastUpdateTime
    self.lastUpdateTime = self.shaderCurrentTime

    if self.shaderScrolling then
        self.currentOffset1 = self.currentOffset1 + self.shaderDeltaTime * 0.005
        self.currentOffset2 = self.currentOffset2 + self.shaderDeltaTime * 0.01
    end
    -- self.mBg1Material:SetFloat("_ScrollX", 0.005)
    -- self.mBg2Material:SetFloat("_ScrollX", 0.01)
    self.mBg1Material:SetFloat("_EnableScrolling", self.shaderScrolling and 1 or 0)
    self.mBg2Material:SetFloat("_EnableScrolling", self.shaderScrolling and 1 or 0)
    self.mBg1Material:SetFloat("_ScrollOffset", self.currentOffset1)
    self.mBg2Material:SetFloat("_ScrollOffset", self.currentOffset2)
end

-- GameDispatcher:dispatchEvent(EventName.OPEN_BIRD_GAME_PANEL)
-- 激活
function active(self, args)
    super.active(self, args)
    self.dupId = args.dupId
    self.shaderScrolling = false
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
    super.deActive(self)
    self:clearGameSn()
    self:clearAllItems()

end

function initGameData(self)
    self:clearAllItems()
    self.isPasue = false
    self.score = 0
    self.index = 0
    self.isFirstFinish = false
    self.mTxtCurPoint.text = self.score

    self.lastUpdateTime = 0.0
    self.shaderScrolling = false
    self.currentOffset1 = 0
    self.currentOffset2 = 0

    gs.TransQuick:UIPos(self.mPlayer:GetComponent(ty.RectTransform), -470, 0)
    self.mPlayerAni:SetTrigger("def")
    self.mRig.bodyType = 2

    self.isEnd = false
    self.gameData = bird.BirdManager:getBirdDataById(self.dupId)
    self.mTxtTargetPoint.text = self.gameData.targetScore
end

function clearGameSn(self)
        if self.gameSn ~= nil then
        LoopManager:removeFrameByIndex(self.gameSn)
        self.gameSn = nil
    end
end

function showPanel(self)
    self.mRig.bodyType = 0
    self.curTime = 0
    self.createTime = 1.6

    self.shaderScrolling = true
    self:clearGameSn()
    self.gameSn = LoopManager:addFrame(0, 0, self, self.updateGame)
end

function updateGame(self)
    if self.isPasue then
        return
    end

    if self.isEnd then
        return
    end

    if gs.Input.GetMouseButtonUp(0) then
        self.mRig.velocity = gs.Vector2(0, self.topSpeed)
        self.mPlayerAni:SetTrigger("show01")
        AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_bird_1.prefab")
    end

    -- if self.mRig.velocity.y > 0 then
         
    -- else
    --      self.mPlayerAni:ResetTrigger("show")
    -- end

    self.curTime = self.curTime + gs.Time.deltaTime
    if self.curTime >= self.createTime then
        self.curTime = 0
        self:createWall()
    end

    for i = #self.wallItems, 1, -1 do
        self.wallItems[i].item:getGo().transform:Translate(gs.Vector3(-1, 0, 0) * gs.Time.deltaTime * self.wallSpeed,
            gs.Space.World)
        if self.wallItems[i].item:getGo().transform.position.x < self.mEndPos.position.x then
            self.wallItems[i].item:poolRecover()
            if self.wallItems[i].hasCoin and self.coinItems[self.wallItems[i].index] then
                self.coinItems[self.wallItems[i].index]:poolRecover()
                self.coinItems[self.wallItems[i].index] = nil
            end
            table.remove(self.wallItems, i)
        end
    end
end

function createWall(self)
    self.index = self.index + 1
    local random = math.random(1, 2)

    local item
    local yMax = 0
    local yMin = 0
    local cap = self.index <= self.easyIndex and self.easyCap or self.hardCap
    local wallY = 0
    if random == 1 then
        item = SimpleInsItem:create(self.mWall1, self.mCreatePos, "mWallItem1")
        yMax = 210
        yMin = -700
        wallY = 249
    else
        item = SimpleInsItem:create(self.mWall2, self.mCreatePos, "mWallItem2")
        yMax = 357
        yMin = 0
        wallY = 396
    end
    local halfY = wallY / 2

    item:getGo().name = "wall" .. self.index
    gs.TransQuick:UIPos(item:getGo():GetComponent(ty.RectTransform), 0, 0)
    local randomY = math.random(yMin, yMax)
    if random == 1 then
        gs.TransQuick:UIPos(item:getChildGO("wallCenter"):GetComponent(ty.RectTransform), 0, randomY)
    else
        gs.TransQuick:UIPos(item:getChildGO("wallTop"):GetComponent(ty.RectTransform), 0, randomY)
        gs.TransQuick:UIPos(item:getChildGO("wallBot"):GetComponent(ty.RectTransform), 0, randomY - wallY - cap)
    end

    local randomPro = math.random(1, 100)
    local pro = 0
    if self.index <= 50 then
        pro = 30
    elseif self.index > 50 and self.index <= 100 then
        pro = 50
    else
        pro = 70
    end
    local hasCoin = false
    if randomPro <= pro then
        local posY = 0
        local coinItem = SimpleInsItem:create(self.mCoin, item:getGo().transform, "mCoinItem")
        if random == 1 then
            if randomY <= -250 then
                posY = randomY + halfY
            else
                posY = randomY - wallY - halfY
            end
            gs.TransQuick:UIPos(coinItem:getGo():GetComponent(ty.RectTransform), 0, posY)
        else
            posY = (randomY + (randomY - wallY - cap)) / 2 - halfY
            gs.TransQuick:UIPos(coinItem:getGo():GetComponent(ty.RectTransform), 0, posY)
        end
        coinItem:getGo().name = "mCoin|" .. self.index
        self.coinItems[self.index] = coinItem
        hasCoin = true
    end

    table.insert(self.wallItems, {
        item = item,
        index = self.index,
        hasCoin = hasCoin
    })
end

function clearAllItems(self)
    for k, v in pairs(self.coinItems) do
        v:poolRecover()
    end
    self.coinItems = {}

    for i = 1, #self.wallItems do
        self.wallItems[i].item:poolRecover()
    end
    self.wallItems = {}
end

function onGameEnd(self)
    self.isEnd = true

    self.mPlayerAni:SetTrigger("def")
    self.mRig.bodyType = 2

    local his = bird.BirdManager:getDupPassStar(self.dupId)
    local isPass = bird.BirdManager:getDupPassState(self.dupId)
    local isFirst = false
    if self.score >= self.gameData.targetScore and isPass == false then
        isFirst = true
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_BIRD_SETTLE_PANEL, {
        dupId = self.dupId,
        score = self.score,
        first = isFirst
    })
end

return _M
