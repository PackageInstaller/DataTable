module("watermelon.WatermelonGamePanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("watermelon/WatermelonGamePanel.prefab")
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

    self.gameCurTime = 0
    self.gameEndTime = 30
    self.lastBossTime = 0

    self.mScore = 0 -- 分数
    -- self.mGameItemList = {}

    self.mGameItemDic = {}
    self.mMaxGameItemIndexList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.m_startView = watermelon.WatermelonStartView.new()
    self.m_startView:initData(self:getChildGO('StartGroup'))

    self.mNext1 = self:getChildGO("mNext1"):GetComponent(ty.AutoRefImage)
    self.mNext2 = self:getChildGO("mNext2"):GetComponent(ty.AutoRefImage)

    self.mTxtTargetGame = self:getChildGO("mTxtTargetGame"):GetComponent(ty.Text)
    self.mTxtScoreGame = self:getChildGO("mTxtScoreGame"):GetComponent(ty.Text)
    self.mBtnPause = self:getChildGO("mBtnPause")
    self.mBtnSkill = self:getChildGO("mBtnSkill")

    self.mCount1 = self:getChildGO("mCount1")
    self.mCount2 = self:getChildGO("mCount2")

    self.mGame = self:getChildGO("mGame")
    self.mStartContent = self:getChildTrans("mStartContent")
    self.mStartObj = self:getChildGO("mStartContent")

    self.mGameItem = self:getChildGO("mGameItem")

    self.mImgGamePre = self:getChildGO("mImgGamePre"):GetComponent(ty.AutoRefImage)
    -- self.mTxtRemtimer = self:getChildGO("mTxtRemtimer"):GetComponent(ty.Text)
    self.mImgTimerBg = self:getChildGO("mImgTimerBg")
    self.mImgTimer = self:getChildGO("mImgTimer"):GetComponent(ty.AutoRefImage)

    self.mGroupPause = self:getChildGO("mGroupPause")
    self.mBtnExit = self:getChildGO("mBtnExit")
    self.mBtnFinish = self:getChildGO("mBtnFinish")
    self.mBtnReplay = self:getChildGO("mBtnReplay")
    self.mBtnPlay = self:getChildGO("mBtnPlay")

    self.mImgCd = self:getChildGO("mImgCd"):GetComponent(ty.Image)
    self.anim = self.UIObject:GetComponent(ty.Animator)

    self.mObjectContent = self:getChildTrans("mObjectContent")

    self.max = self:getChildGO("max")

    self.mPhysicsFrame = self:getChildGO("mGame"):GetComponent(ty.PhysicsFrame)
    self.mPhysicsFrame:SetUpdateCall(self, self.onFixFrame)

    self.mTxtCurrentScore = self:getChildGO("mTxtCurrentScore"):GetComponent(ty.Text)
    self.mTxtTargetScore = self:getChildGO("mTxtTargetScore"):GetComponent(ty.Text)
    self.mIsTarget = self:getChildGO("mIsTarget")

    self.mIsTargetNot = self:getChildGO("mIsTargetNot")
end

function initViewText(self)

end

function onFixFrame(self)
    watermelon.WatermelonGameWorld:onUpdate()
end
-- 激活
function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.WARERMELON_GAME_COMPOUND, self.onColEvent, self)
    GameDispatcher:addEventListener(EventName.WARERMELON_GAME_MAX, self.onColMaxEvent, self)
    GameDispatcher:addEventListener(EventName.WARERMELON_GAME_MAX_EXIT, self.onColMaxExitEvent, self)
    self.dupId = args.dupId
    self.mBtnPause:SetActive(true)
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
    watermelon.WatermelonGameWorld:unRegisterAll()
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.WARERMELON_GAME_COMPOUND, self.onColEvent, self)
    GameDispatcher:removeEventListener(EventName.WARERMELON_GAME_MAX, self.onColMaxEvent, self)
    GameDispatcher:removeEventListener(EventName.WARERMELON_GAME_MAX_EXIT, self.onColMaxExitEvent, self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnPause, self.onClickPause)

    self:addUIEvent(self.mBtnExit, self.onClickExit)
    self:addUIEvent(self.mBtnFinish, self.onClickFinish)
    self:addUIEvent(self.mBtnReplay, self.onClickReplay)
    self:addUIEvent(self.mBtnPlay, self.onClickPlay)

    self:addUIEvent(self.mBtnSkill, self.onClickSkill)

    -- for k, v in pairs(self.mClickDic) do
    --     self:addUIEvent(v, self.onClickMoleHandler, "", k)
    -- end
end

function onClickFinish(self)
    self.mGroupPause:SetActive(false)
    self:onGameEnd()
end

function onClickSkill(self)
    if self.isSkilling then
        return
    end

    if self.mSkillCount > 0 then
        self.mSkillCount = self.mSkillCount - 1
        self.isSkilling = true

        self.mCount1:SetActive(self.mSkillCount >= 1)
        self.mCount2:SetActive(self.mSkillCount == 2)
        self.curSkillTime = 0
        self.mImgCd.fillAmount = 1
        self.mBtnPause:SetActive(false)

        self.mSkillTime = AnimatorUtil.getAnimatorClipTime(self.anim, "WatermelonGamePanel_Skill")
        self.anim:SetTrigger("skill")
        GameDispatcher:dispatchEvent(EventName.REQ_WATERMELON_EVENT)
        self.skillSn = LoopManager:addFrame(0, 0, self, function()
            self.curSkillTime = self.curSkillTime + gs.Time.deltaTime
            self.mImgCd.fillAmount = (self.mSkillTime - self.curSkillTime) / self.mSkillTime
            if self.curSkillTime >= self.mSkillTime then
                self.mImgCd.fillAmount = 0
                self.isSkilling = false
                self.curMaxTime = 0
                LoopManager:removeFrameByIndex(self.skillSn)
                self.mBtnPause:SetActive(true)
            end
        end)
    else
        gs.Message.Show(_TT(151205))
    end
end

function onClickExit(self)
    self:close()
end

function onClickReplay(self)
    self.isPasue = false
    self.mGroupPause:SetActive(false)
    self:clearAllGameItem()

    local function _finishCall()
        self.m_startView:setActive(false)
        self:showPanel()
    end
    self.m_startView:setActive(true)
    self.m_startView:start(_finishCall)
    self:clearAll()
    self:initGameData()
end

function clearAllGameItem(self)
    for k, v in pairs(self.mGameItemDic) do
        v.simpleInsItem:poolRecover()
    end
    self.mGameItemDic = {}
end

function onClickPlay(self)
    self.isPasue = false
    for k, v in pairs(self.mGameItemDic) do
        v.simpleInsItem.m_go:GetComponent(ty.Rigidbody2D).bodyType = 0 -- :pause()
    end
    self.mGroupPause:SetActive(false)
end

function onClickPause(self)
    self.isPasue = true

    for k, v in pairs(self.mGameItemDic) do
        v.simpleInsItem.m_go:GetComponent(ty.Rigidbody2D).bodyType = 2 -- :pause()
    end

    if self.gameData.targetScore <= self.mScore then
        self.mBtnFinish:SetActive(true)
        self.mBtnExit:SetActive(false)
        -- self.mBtnReplay:SetActive(false)
    else
        self.mBtnFinish:SetActive(false)
        self.mBtnExit:SetActive(true)
    end
    self.mGroupPause:SetActive(true)

    self.mTxtCurrentScore.text = _TT(151209) .. self.mScore
    self.mTxtTargetScore.text = _TT(151208) .. self.gameData.targetScore
    self.mIsTarget:SetActive(self.gameData.targetScore <= self.mScore)
    self.mIsTargetNot:SetActive(self.gameData.targetScore > self.mScore)
end

function clearAll(self)
    if self.gameSn ~= nil then
        LoopManager:removeFrameByIndex(self.gameSn)
        self.gameSn = nil
    end
end

function initGameData(self)
    self.mMaxGameItemIndexList = {}
    self.mImgTimerBg:SetActive(false)
    self.isPasue = false
    -- self.mTxtRemtimer.text = ""
    self.index = 1
    self.maxTime = 5
    self.curMaxTime = 0
    self.createCD = 0.5
    self.curCreateTime = 0
    self.mSkillCount = 2
    self.mSkillTime = 2
    self.mImgCd.fillAmount = 0
    self.curSkillTime = 0
    self.isSkilling = false
    self.isEnd = false
    self.mScore = 0
    self.isFirstFinish = false
    self.mTxtScoreGame.text = self.mScore
    self.gameData = watermelon.WatermelonManager:getWatermelonDataById(self.dupId)
    self.mTxtTargetGame.text = self.gameData.targetScore
    self.mCount1:SetActive(self.mSkillCount >= 1)
    self.mCount2:SetActive(self.mSkillCount == 2)

    self:clearAllGameItem()
    watermelon.WatermelonGameWorld:unRegisterAll()
    -- watermelon.WatermelonGameWorld:buildQuadTree(-247,193,-335,200)
    watermelon.WatermelonGameWorld:registerToTheWorld(0, 0, self.max, "AABB", watermelon.WatermelonGroup.Max,
        {watermelon.WatermelonGroup.Ball}, false, false, function(otherworld)
            self:onColMaxEvent(otherworld.key)
            -- cusLog("触发了增加"..otherworld.key)
        end, nil, function(otherworld)
            -- cusLog("触发了移除"..otherworld.key)
            self:onColMaxExitEvent(otherworld.key)
        end)

    self:updateRound(true)
end

function showPanel(self)
    watermelon.WatermelonGameWorld:setGameRun(true)

    if self.gameSn ~= nil then
        LoopManager:removeFrameByIndex(self.gameSn)
        self.gameSn = nil
    end
    self.gameSn = LoopManager:addFrame(0, 0, self, self.updateGame)
end

function onColMaxEvent(self, index)
    table.insert(self.mMaxGameItemIndexList, index)
end

function onColMaxExitEvent(self, index)
    local i = table.indexof01(self.mMaxGameItemIndexList, index)
    if i > 0 then
        table.remove(self.mMaxGameItemIndexList, i)
    end
end

-- GameDispatcher:dispatchEvent(EventName.OPEN_WATERMELON_GAME_PANEL)
function updateGame(self)
    if self.isPasue then
        return
    end

    local mousePos = gs.Input.mousePosition
    local mouseWorldPos = gs.CameraMgr:ScreenToWorldByUICamera(mousePos)
    local localPos = self.mGame:GetComponent(ty.RectTransform):InverseTransformPoint(mouseWorldPos)

    local clampX = gs.Mathf.Clamp(localPos.x, -195, 140)
    gs.TransQuick:UIPos(self.mStartObj:GetComponent(ty.RectTransform), clampX, 258)

    local curVo = watermelon.WatermelonManager:getWatermelonItemData(self.curLevel)
    self.curCreateTime = self.curCreateTime + gs.Time.deltaTime

    if gs.Input.GetMouseButtonUp(0) and self.curCreateTime >= self.createCD and self.isSkilling == false then

        local list = gs.UnityEngineUtil.GetRaycastUIResults(gs.Vector2(mousePos.x, mousePos.y), true)
        if (list.Count > 0 and list[0].gameObject.name == "mBtnSkill") then
            return
        end
        if self.curCreateTime >= self.createCD then
            self.curCreateTime = 0
            local level = self.curLevel
            local gameItem = SimpleInsItem:create(self.mGameItem, self.mObjectContent.transform, "mGameItem")
            AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_watermelon_1.prefab")

            gameItem.m_go:GetComponent(ty.Rigidbody2D).bodyType = 0
            gameItem:getChildGO("Effect"):SetActive(false)
            gameItem.m_go:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath("watermelon/" .. curVo.icon),
                false)
            self.index = self.index + 1
            gs.TransQuick:UIPos(gameItem:getGo():GetComponent(ty.RectTransform), clampX, 258)
            gs.TransQuick:Scale(gameItem:getGo():GetComponent(ty.RectTransform), curVo.size / 100, curVo.size / 100, 1)
            gameItem.m_go.gameObject.name = "gameItem" .. self.index
            local runGameVo = LuaPoolMgr:poolGet(watermelon.WatermelonRunGameVo)
            runGameVo:setData(self.index, level, gameItem)
            self.mGameItemDic[gameItem.m_go] = {
                simpleInsItem = gameItem,
                index = self.index,
                level = level
            }
            watermelon.WatermelonGameWorld:registerToTheWorld(self.index, level, gameItem.m_go, "Sphere",
                watermelon.WatermelonGroup.Ball, {watermelon.WatermelonGroup.Max, watermelon.WatermelonGroup.Ball},
                true, false, function(otherworld)
                    self:onCompoundNew(gameItem.m_go, otherworld.obj)
                end)
            self:updateRound()
        else
            gs.Message.Show(_TT(151206))
        end
    end
    if #self.mMaxGameItemIndexList >= 1 and self.isSkilling == false then
        self.curMaxTime = self.curMaxTime + gs.Time.deltaTime
        if self.curMaxTime >= self.maxTime then
            self:onGameEnd()
        end
    else
        self.curMaxTime = 0
    end

    if self.curMaxTime <= 1 then
        -- self.mTxtRemtimer.text = ""
        self.mImgTimerBg:SetActive(false)
    elseif self.curMaxTime > 1 and self.curMaxTime < self.maxTime then
        self.mImgTimerBg:SetActive(true)
        local remTime = math.ceil(self.maxTime - self.curMaxTime)
        if remTime <= 1 then
            self.mImgTimer:SetImg(UrlManager:getPackPath("watermelon/timer1.png"), false)
        elseif remTime > 1 and remTime <= 2 then
            self.mImgTimer:SetImg(UrlManager:getPackPath("watermelon/timer2.png"), false)
        elseif remTime > 2 and remTime <= 3 then
            self.mImgTimer:SetImg(UrlManager:getPackPath("watermelon/timer3.png"), false)
        end
        -- self.mTxtRemtimer.text = self.curMaxTime == 0 and "" or math.ceil(self.maxTime - self.curMaxTime)
    else
        self.mImgTimerBg:SetActive(false)
    end

end

function randomValue(self, id)
    local random = math.random(#self.gameData.eventList[id].icon_list)
    return self.gameData.eventList[id].icon_list[random]
end

function updateRound(self, isInit)
    if isInit then
        self.curCreateIndexId = 0
    end
    self.maxRound = table.nums(self.gameData.eventList)

    if isInit then
        self.curCreateId = 1
        self.curCreateIdOne = 2
        self.curCreateIdTwo = 3

        self.curLevel = self:randomValue(self.curCreateId)
        self.nextLevel = self:randomValue(self.curCreateIdOne)
        self.nextTwoLevel = self:randomValue(self.curCreateIdTwo)
    else
        self.curLevel = self.nextLevel
        self.nextLevel = self.nextTwoLevel
        self.curCreateIdTwo = self.index + 3
        if self.curCreateIdTwo > self.maxRound then
            self.curCreateIdTwo = self.maxRound
        end
        self.nextTwoLevel = self:randomValue(self.curCreateIdTwo)
    end

    local curVo = watermelon.WatermelonManager:getWatermelonItemData(self.curLevel)
    local nextVo = watermelon.WatermelonManager:getWatermelonItemData(self.nextLevel)
    local nextTwoVo = watermelon.WatermelonManager:getWatermelonItemData(self.nextTwoLevel)

    self.curCreateIndexId = self.curCreateIndexId + 1

    if self.curCreateIndexId <= 1 then
        self.mNext1:SetImg(UrlManager:getIconPath("watermelon/" .. nextVo.icon), false)
        self.mNext2:SetImg(UrlManager:getIconPath("watermelon/" .. nextTwoVo.icon), false)
    else
        if self.curCreateIndexId % 2 == 0 then
            self.anim:SetTrigger("show01")
            local aniSn = self:setTimeout(0.5, function()
                self.mNext1:SetImg(UrlManager:getIconPath("watermelon/" .. nextTwoVo.icon), false)
            end)

        else
            self.anim:SetTrigger("show02")

            local aniSn = self:setTimeout(0.5, function()
                self.mNext2:SetImg(UrlManager:getIconPath("watermelon/" .. nextTwoVo.icon), false)
            end)
        end
    end
    -- self.mNext1:SetImg(UrlManager:getIconPath("watermelon/" .. nextVo.icon), false)
    -- self.mNext2:SetImg(UrlManager:getIconPath("watermelon/" .. nextTwoVo.icon), false)

    -- self.showTime = AnimatorUtil.getAnimatorClipTime(self.anim, "WatermelonGamePanel_Show1")

    self.mImgGamePre:SetImg(UrlManager:getIconPath("watermelon/" .. curVo.icon), false)
    gs.TransQuick:Scale(self.mImgGamePre.gameObject:GetComponent(ty.RectTransform), curVo.size / 100, curVo.size / 100,
        1)
end

function onColEvent(self, args)

    if self.isEnd then
        return
    end

    local thisObj = args.thisObj
    local colObj = args.colObj

    local thisDic = self.mGameItemDic[thisObj]
    local colDic = self.mGameItemDic[colObj]

    if thisDic == nil or colDic == nil then
        return
    end

    if thisDic.level == colDic.level then
        self:onCompoundNew(thisObj, colObj)
    end
end

function onCompoundNew(self, thisObj, colObj)
    local thisDic = self.mGameItemDic[thisObj]
    local colDic = self.mGameItemDic[colObj]
    if thisDic == nil or colDic == nil then
        return
    end

    if thisDic.level >= 10 then
        return
    end
    local level = thisDic.level + 1
    local curVo = watermelon.WatermelonManager:getWatermelonItemData(level)

    AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_watermelon_2.prefab")
    local newGameItem = SimpleInsItem:create(self.mGameItem, self.mObjectContent.transform, "mGameItem")
    newGameItem.m_go:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath("watermelon/" .. curVo.icon), false)
    newGameItem:getChildGO("Effect"):SetActive(true)
    local thisRect = thisDic.simpleInsItem:getGo():GetComponent(ty.RectTransform)
    local colRect = colDic.simpleInsItem:getGo():GetComponent(ty.RectTransform)
    local newPosX = (thisRect.anchoredPosition.x + colRect.anchoredPosition.x) / 2
    local newPosY = (thisRect.anchoredPosition.y + colRect.anchoredPosition.y) / 2
    -- gs.TransQuick:UIPos(newGameItem:getGo():GetComponent(ty.RectTransform), newPosX, newPosY)

    -- cusLog(self.mGameItemDic[thisObj].index .. "|".. self.mGameItemDic[colObj].index .."碰撞")

    watermelon.WatermelonGameWorld:unRegisterToTheWorld(self.mGameItemDic[thisObj].index)
    watermelon.WatermelonGameWorld:unRegisterToTheWorld(self.mGameItemDic[colObj].index)

    self.mGameItemDic[thisObj].simpleInsItem:poolRecover()
    self.mGameItemDic[colObj].simpleInsItem:poolRecover()
    self.mGameItemDic[thisObj] = nil
    self.mGameItemDic[colObj] = nil

    gs.TransQuick:UIPos(newGameItem:getGo():GetComponent(ty.RectTransform), newPosX, newPosY)
    gs.TransQuick:Scale(newGameItem:getGo():GetComponent(ty.RectTransform), curVo.size / 100, curVo.size / 100, 1)

    newGameItem.m_go:GetComponent(ty.Rigidbody2D).bodyType = 0
    self.index = self.index + 1
    -- cusLog("生成了新的:"..self.index)
    newGameItem.m_go.gameObject.name = "gameItem" .. self.index
    local runGameVo = LuaPoolMgr:poolGet(watermelon.WatermelonRunGameVo)
    runGameVo:setData(self.index, level, newGameItem)

    self.mGameItemDic[newGameItem.m_go] = {
        simpleInsItem = newGameItem,
        index = self.index,
        level = level
    }
    watermelon.WatermelonGameWorld:registerToTheWorld(self.index, level, newGameItem.m_go, "Sphere",
        watermelon.WatermelonGroup.Ball, {watermelon.WatermelonGroup.Max, watermelon.WatermelonGroup.Ball}, true, false,
        function(otherworld)
            self:onCompoundNew(newGameItem.m_go, otherworld.obj)
        end)

    self.mScore = self.mScore + curVo.score
    self.mTxtScoreGame.text = self.mScore

    if self.mScore >= self.gameData.targetScore and self.isFirstFinish == false then
        self.isFirstFinish = true
        self:onClickPause()
    end
end

function onGameEnd(self)
    for k, v in pairs(self.mGameItemDic) do
        v.simpleInsItem.m_go:GetComponent(ty.Rigidbody2D).bodyType = 2
    end
    -- self.mGameItemDic = {}

    self:clearAll()

    self.isEnd = true

    watermelon.WatermelonGameWorld:setGameRun(false)

    local his = watermelon.WatermelonManager:getDupPassStar(self.dupId)
    local isPass = watermelon.WatermelonManager:getDupPassState(self.dupId)
    local isFirst = false
    if self.mScore >= self.gameData.targetScore and isPass == false then
        isFirst = true
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_WATERMELON_SETTLE_PANEL, {
        dupId = self.dupId,
        score = self.mScore,
        first = isFirst
    })
end

return _M
