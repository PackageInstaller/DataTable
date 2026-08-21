module("split.SplitGamePanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("split/SplitGamePanel.prefab")
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
    self.runItemList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.m_startView = split.SplitStartView.new()
    self.m_startView:initData(self:getChildGO('StartGroup'))

    self.mBtnPause = self:getChildGO("mBtnPause")

    self.mGroupPause = self:getChildGO("mGroupPause")
    self.mBtnExit = self:getChildGO("mBtnExit")
    self.mBtnFinish = self:getChildGO("mBtnFinish")
    self.mBtnReplay = self:getChildGO("mBtnReplay")
    self.mBtnPlay = self:getChildGO("mBtnPlay")

    self.mTxtCurrentScore = self:getChildGO("mTxtCurrentScore"):GetComponent(ty.Text)
    self.mTxtTargetScore = self:getChildGO("mTxtTargetScore"):GetComponent(ty.Text)
    self.mIsTarget = self:getChildGO("mIsTarget")

    self.mIsTargetNot = self:getChildGO("mIsTargetNot")

    self.mTxtTask = self:getChildGO("mTxtTask"):GetComponent(ty.Text)

    self.mBtnLeft = self:getChildGO("mBtnLeft")
    self.mBtnRight = self:getChildGO("mBtnRight")

    self.mTxtTimerInfo = self:getChildGO("mTxtTimerInfo"):GetComponent(ty.Text)
    self.mTxtTimer = self:getChildGO("mTxtTimer"):GetComponent(ty.Text)

    self.mTxtTaskInfo = self:getChildGO("mTxtTaskInfo"):GetComponent(ty.Text)
    self.mTxtTask = self:getChildGO("mTxtTask"):GetComponent(ty.Text)

    self.mImgSlider = self:getChildGO("mImgSlider"):GetComponent(ty.Image)
    self.mImgFilledAdd = self:getChildGO("mImgFilledAdd"):GetComponent(ty.AutoRefImage)
    self.mImgFilledSub = self:getChildGO("mImgFilledSub"):GetComponent(ty.AutoRefImage)

    self.mPreContent = self:getChildGO("mPreContent")
    self.mPreItems = {}
    self.mPreItems[1] = self:getChildGO("mItemPre1"):GetComponent(ty.AutoRefImage)
    self.mPreItems[2] = self:getChildGO("mItemPre2"):GetComponent(ty.AutoRefImage)
    self.mPreItems[3] = self:getChildGO("mItemPre3"):GetComponent(ty.AutoRefImage)
    self.mPreItems[4] = self:getChildGO("mItemPre4"):GetComponent(ty.AutoRefImage)

    self.mImgWall = self:getChildGO("mImgWall"):GetComponent(ty.Image)

    self.mLeftContent = self:getChildGO("mLeftContent")
    self.mRightContent = self:getChildGO("mRightContent")

    self.mLeftStart = self:getChildTrans("mLeftStart")
    self.mRightStart = self:getChildTrans("mRightStart")

    self.mLeftEnd = self:getChildTrans("mLeftEnd")
    self.mRightEnd = self:getChildTrans("mRightEnd")

    self.mRunItem = self:getChildGO("mRunItem")

    self.mTxtPointInfo = self:getChildGO("mTxtPointInfo"):GetComponent(ty.Text)
    self.mTxtPoint = self:getChildGO("mTxtPoint"):GetComponent(ty.Text)

    self.mImgWallAni = self:getChildGO("mImgWall"):GetComponent(ty.Animator)
    self.mEffectL = self:getChildGO("mEffectL")
    self.mEffectR = self:getChildGO("mEffectR")
    self.mFilled = self:getChildGO("mFilled")

    self.mPlay1 = self:getChildGO("mPlay1"):GetComponent(ty.Animator)
    self.mPlay2 = self:getChildGO("mPlay2"):GetComponent(ty.Animator)

    self.mItemPre1Img = self:getChildGO("mItemPre1"):GetComponent(ty.AutoRefImage)
end

function initViewText(self)
    self.mTxtTimerInfo.text = "倒计时"
    self.mTxtTaskInfo.text = "任务"
    self.mTxtPointInfo.text = "当前分数"
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnPause, self.onClickPause)

    self:addUIEvent(self.mBtnExit, self.onClickExit)
    self:addUIEvent(self.mBtnFinish, self.onClickFinish)
    self:addUIEvent(self.mBtnReplay, self.onClickReplay)
    self:addUIEvent(self.mBtnPlay, self.onClickPlay)

    self:addUIEvent(self.mBtnLeft, self.onClickLeft)
    self:addUIEvent(self.mBtnRight, self.onClickRight)
end

-- GameDispatcher:dispatchEvent(EventName.OPEN_SPLIT_GAME_PANEL, {dupId = 1001})
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
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.WARERMELON_GAME_COMPOUND, self.onColEvent, self)
    GameDispatcher:removeEventListener(EventName.WARERMELON_GAME_MAX, self.onColMaxEvent, self)
    GameDispatcher:removeEventListener(EventName.WARERMELON_GAME_MAX_EXIT, self.onColMaxExitEvent, self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})

    if self.gameSn ~= nil then
        LoopManager:removeFrameByIndex(self.gameSn)
        self.gameSn = nil
    end

end

function onClickFinish(self)
    self.mGroupPause:SetActive(false)
    self:onGameEnd()
end

function onClickExit(self)
    self:close()
end

function onClickReplay(self)
    self.isPasue = false
    self.mGroupPause:SetActive(false)

    local function _finishCall()
        self.m_startView:setActive(false)
        self:showPanel()
    end
    self.m_startView:setActive(true)
    self.m_startView:start(_finishCall)
    self:initGameData()
end

function onClickPlay(self)
    self.isPasue = false

    self.mGroupPause:SetActive(false)
end

function onClickPause(self)
    self.isPasue = true

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

function initGameData(self)
    self.mFilled:SetActive(false)
     self.isPasue = false
    self.isFirstFinish = false
    self.leftTimer = 0
    self.rightTimer = 0
    self.errorTime = 1

    self.remAllTimer = 40
    self.mScore = 0
    self.mTxtPoint.text = self.mScore
    self.gameData = split.SplitManager:getSplitDataById(self.dupId)
    self.mTxtTask.text = "获得" .. self.gameData.targetScore .. "分"

    self.isSuperState = false
    self.needSuperTimer = 0
    self.curOkCount = 0
    self.needOkCount = 8

    self.randomList = {}
    self:updateRandom()
    self:updateFilled()
end

function updateRandomPre(self)
    for i = 1, 4, 1 do
        self.mPreItems[i]:SetImg(UrlManager:getPackPath("split/icon_" .. self.randomList[i] .. ".png"), false)
    end
end

function updateRandom(self)
    for i = 1, 4, 1 do
        if i < 4 and self.randomList[i + 1] ~= nil then
            self.randomList[i] = self.randomList[i + 1]
        else
            local ran = math.random(10)
            if ran < 7 then
                self.randomList[i] = math.random(3)
            else
                self.randomList[i] = 4
            end
        end
    end
    self:updateRandomPre()
end

function showPanel(self)
    if self.gameSn ~= nil then
        LoopManager:removeFrameByIndex(self.gameSn)
        self.gameSn = nil
    end
    self.isGaming = true
    self.gameSn = LoopManager:addFrame(0, 0, self, self.updateGame)
end

function onClickLeft(self)
    if self.isGaming and self.leftTimer > 0.1 then
        self:clickRunItem(1)
        self.leftTimer = 0
    end
end

function onClickRight(self)
    if self.isGaming and self.rightTimer > 0.1 then
        self:clickRunItem(2)
        self.rightTimer = 0
    end
end

function clickRunItem(self, arrow)
    if self.errorTime < 0.5 and not self.isSuperState then
        --gs.Message.Show("惩罚时间 耐心等待")
        return
    end

    local tempType = self.randomList[1]
    local isOK = false
    if arrow == 1 then
        if tempType ~= 1 then
            isOK = true
        end
    else
        if tempType == 1 then
            isOK = true
        end
    end
    if isOK or self.isSuperState then
        local runItem
        if arrow == 1 then
            runItem = SimpleInsItem:create(self.mRunItem, self.mLeftStart, "mRunSplitItem")
            gs.TransQuick:UIPos(runItem.m_trans, 0, 0)
            TweenFactory:move2PosXEx(runItem.m_trans, self.mLeftEnd.anchoredPosition.x, 0.2, gs.DT.Ease.Linear,
                function()
                    runItem:poolRecover()
                end)
            self.mImgWallAni:SetTrigger("showl")
            self.mEffectL:SetActive(false)
            self.mEffectL:SetActive(true)
        else
            runItem = SimpleInsItem:create(self.mRunItem, self.mRightStart, "mRunSplitItem")
            gs.TransQuick:UIPos(runItem.m_trans, 0, 0)
            TweenFactory:move2PosXEx(runItem.m_trans, self.mRightEnd.anchoredPosition.x, 0.2, gs.DT.Ease.Linear,
                function()
                    runItem:poolRecover()
                end)
            self.mImgWallAni:SetTrigger("showr")  
            self.mEffectR:SetActive(false)
            self.mEffectR:SetActive(true)
        end

        runItem.m_go:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("split/icon_" .. tempType .. ".png"),
            false)
        runItem:getChildGO("mRunMask"):GetComponent(ty.AutoRefImage):SetImg(
            UrlManager:getPackPath("split/icon_" .. tempType .. ".png"), false)
        self:updateSocre(isOK)
        self:updateRandom()
        AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_split_1.prefab")

        if arrow == 1 then
            self.mPlay1:SetTrigger("show01")
        else
            self.mPlay2:SetTrigger("show01")
        end
    else
         if arrow == 1 then
            self.mPlay1:SetTrigger("show02")
        else
            self.mPlay2:SetTrigger("show02")
        end
        --gs.Message.Show("错误操作 开始惩罚")
        self.errorTime = 0
        AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_split_2.prefab")
        self.mItemPre1Img.color = gs.ColorUtil.GetColor("7E7E7EFF")
        self:setTimeout(0.5,function()
            self.mItemPre1Img.color = gs.ColorUtil.GetColor("FFFFFFFF")
        end, 0.5)
    end

end

function updateSocre(self, isOk)
    self.mScore = self.isSuperState and self.mScore + 40 or self.mScore + 20
    self.curOkCount = (isOk or self.isSuperState) and self.curOkCount + 1 or self.curOkCount - 1
    self.curOkCount = gs.Mathf.Clamp(self.curOkCount, 0, self.needOkCount)
    if self.curOkCount == self.needOkCount and not self.isSuperState then
        self.isSuperState = true
        self.mFilled:SetActive(true)
        self.needSuperTimer = self.needOkCount
    end
    self.mTxtPoint.text = self.mScore
    self:updateFilled()

    if self.mScore >= self.gameData.targetScore and self.isFirstFinish == false then
        self.isFirstFinish = true
        self:onClickPause()
    end
end

function updateFilled(self)
    self.mImgFilledAdd.gameObject:SetActive(not self.isSuperState)
    self.mImgFilledSub.gameObject:SetActive(self.isSuperState)

    self.mImgFilledAdd.fillAmount = gs.Mathf.Clamp(self.curOkCount / self.needOkCount, 0, 1)
    self.mImgFilledSub.fillAmount = gs.Mathf.Clamp(self.needSuperTimer / self.needOkCount, 0, 1)
end

-- GameDispatcher:dispatchEvent(EventName.OPEN_SPLIT_GAME_PANEL)
function updateGame(self)
    if self.isPasue then
        return
    end

    if gs.ApplicationUtil.IsPC() then
        if gs.Input.GetKeyDown(gs.KeyCode.A) or gs.Input.GetKeyDown(gs.KeyCode.LeftArrow) then
            self:onClickLeft()
        end
        if gs.Input.GetKeyDown(gs.KeyCode.D) or gs.Input.GetKeyDown(gs.KeyCode.RightArrow) then
            self:onClickRight()
        end
    end


    if self.needSuperTimer > 0 and self.isSuperState then
        self.needSuperTimer = self.needSuperTimer - gs.Time.deltaTime
        if self.needSuperTimer <= 0 then
            self.isSuperState = false
            self.mFilled:SetActive(false)
            self.curOkCount = 0
        end
        self:updateFilled()
    end

    self.leftTimer = self.leftTimer + gs.Time.deltaTime
    self.rightTimer = self.rightTimer + gs.Time.deltaTime

    self.errorTime = self.errorTime + gs.Time.deltaTime

    if self.remAllTimer > 0 then
        self.remAllTimer = self.remAllTimer - gs.Time.deltaTime
    end
    self.mTxtTimer.text = math.ceil(gs.Mathf.Clamp(self.remAllTimer, 0, 40)) .. "s"
    if self.remAllTimer <= 0 then
        self:onGameEnd()
    end
end

function randomValue(self, id)
    local random = math.random(#self.gameData.eventList[id].icon_list)
    return self.gameData.eventList[id].icon_list[random]
end

function updateRound(self, isInit)

end

function onGameEnd(self)
    self.isSuperState = false


    if self.gameSn ~= nil then
        LoopManager:removeFrameByIndex(self.gameSn)
        self.gameSn = nil
    end

    local his = split.SplitManager:getDupPassStar(self.dupId)
    local isPass = split.SplitManager:getDupPassState(self.dupId)
    local isFirst = false
    if self.mScore >= self.gameData.targetScore and isPass == false then
        isFirst = true
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_SPLIT_SETTLE_PANEL, {
        dupId = self.dupId,
        score = self.mScore,
        first = isFirst
    })
end

return _M
