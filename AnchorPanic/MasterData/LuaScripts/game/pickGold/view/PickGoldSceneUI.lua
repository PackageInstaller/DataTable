-- @FileName:   PickGoldSceneUI.lua
-- @Description:   描述
-- @Author: ZDH
-- @Date:   2024-07-03 17:48:19
-- @Copyright:   (LY) 2024 锚点降临

module('game.pickGold.view.PickGoldSceneUI', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("pickGold/PickGoldSceneUI.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isScreensave = 0 -- 是否使用黑屏过渡(仅1全屏UI有效，默认开启，0关闭)
isBlur = 0
escapeClose = 0 -- 是否能通过esc关闭窗口
isShowCloseAll = false

--构造函数
function ctor(self)
    super.ctor(self)
    -- self:setSize(750, 600)
    -- self:setBg("")
    -- self:setTxtTitle(_TT(138601))
    self:setUICode(LinkCode.PickGold)
end

function initData(self)

end

-- 初始化
function configUI(self)
    self.m_startView = fightUI.FightStartView.new()
    self.m_startView:initData(self:getChildGO('StartGroup'))

    self.mBtnPause = self:getChildGO("mBtnPause")
    self.mGroupPause = self:getChildGO("mGroupPause")
    self.mGroupStar = self:getChildTrans("mGroupStar")
    self.mBtnReplay = self:getChildGO("mBtnReplay")
    self.mBtnPlay = self:getChildGO("mBtnPlay")
    self.mBtnExit = self:getChildGO("mBtnExit")
    self.mBtnFinish = self:getChildGO("mBtnFinish")

    self.mImgStart = self:getChildGO("mImgStart")
    self.mImgPause = self:getChildGO("mImgPause")

    self.mapGroup = self:getChildTrans("mapGroup")
    self.mGridItem = self:getChildGO("mGridItem")

    self.mTextCurScore = self:getChildGO("mTextCurScore"):GetComponent(ty.Text)
    self.mTextTagerScore = self:getChildGO("mTextTagerScore"):GetComponent(ty.Text)
    self.mTextCurScoreTitle = self:getChildGO("mTextCurScoreTitle"):GetComponent(ty.Text)
    self.mTextTagerScoreTitle = self:getChildGO("mTextTagerScoreTitle"):GetComponent(ty.Text)

    self.mTextPassScore = self:getChildGO("mTextPassScore"):GetComponent(ty.Text)
    self.mTextTargerScore = self:getChildGO("mTextTargerScore"):GetComponent(ty.Text)
    self.mTextFinish = self:getChildGO("mTextFinish"):GetComponent(ty.Text)
    self.mTextNoFinish = self:getChildGO("mTextNoFinish"):GetComponent(ty.Text)

    self.mTxtPause = self:getChildGO("mTxtPause"):GetComponent(ty.Text)

    self.mFinish = self:getChildGO("mFinish")
    self.mNoFinish = self:getChildGO("mNoFinish")

    self.mHeroAnimator = self:getChildGO("mHero"):GetComponent(ty.Animator)
    self.mHeroRectTrans = self:getChildGO("mHero"):GetComponent(ty.RectTransform)
    self.mHeroPhysicsTrigger2D = self:getChildGO("mHero"):GetComponent(ty.PhysicsTrigger2D)
    self.mEffect01 = self:getChildGO("mEffect01")
    self.mEffect02 = self:getChildGO("mEffect02")

    self.mBtnLeft = self:getChildGO("mBtnLeft"):GetComponent(ty.LongPressOrClickEventTrigger)
    self.mBtnRight = self:getChildGO("mBtnRight"):GetComponent(ty.LongPressOrClickEventTrigger)
end

function initViewText(self)
    self.mTextFinish.text = _TT(151245)
    self.mTextNoFinish.text = _TT(98966)

    self.mTextCurScoreTitle.text = _TT(151209)
    self.mTextTagerScoreTitle.text = _TT(151208)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnPause, self.onPauseClick)

    self:addUIEvent(self.mBtnReplay, self.onReplayClick)
    self:addUIEvent(self.mBtnPlay, self.onPlayClick)
    self:addUIEvent(self.mBtnExit, self.onExitClick)
    self:addUIEvent(self.mBtnFinish, self.onFinishClick)

    local function leftDown()
        self:onLeftDown()
    end
    self.mBtnLeft.onPointerDown:AddListener(leftDown)

    local function rightDown()
        self:onRightDown()
    end
    self.mBtnRight.onPointerDown:AddListener(rightDown)

    local function leftUp()
        self:onLeftUp()
    end
    self.mBtnLeft.onPointerUp:AddListener(leftUp)

    local function rightUp()
        self:onRightUp()
    end
    self.mBtnRight.onPointerUp:AddListener(rightUp)

    self.mHeroPhysicsTrigger2D:SetCollisionCallFun(self, self.onHeroTriggerEnter2D, nil, nil)
end

--激活
function active(self, args)
    super.active(self)

    self:AddEventListener()

    self:clearData()

    self.mGroupPause:SetActive(false)
    self.mImgStart:SetActive(pauseState)
    self.mImgPause:SetActive(not pauseState)

    self:refreshView(args)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    self:RemoveEventListener()

    self.mBtnLeft.onPointerDown:RemoveAllListeners()
    self.mBtnLeft.onPointerDown:RemoveAllListeners()
    self.mBtnLeft.onPointerUp:RemoveAllListeners()
    self.mBtnRight.onPointerUp:RemoveAllListeners()

    self:clearData()
end

function clearData(self)
    self.mTextCurScore.text = "0"
    self.mTextTagerScore.text = "0"

    self.mEffect01:SetActive(false)
    self.mEffect02:SetActive(false)

    self.m_isAutoPause = nil

    self:clearFrame()
    self:clearGold()
end

function AddEventListener(self)
    GameDispatcher:addEventListener(EventName.PICKGOLD_UPDATE_PAUSESTATE, self.refreshPauseState, self)

end

function RemoveEventListener(self)
    GameDispatcher:removeEventListener(EventName.PICKGOLD_UPDATE_PAUSESTATE, self.refreshPauseState, self)

end

function refreshView(self, args)
    self.m_DupConfigVo = args

    self:clearData()

    local function _finishCall()
        self.m_startView:setActive(false)

        self:onStartGame()
    end
    self.m_startView:setActive(true)
    self.m_startView:start(_finishCall)
end

function onStartGame(self)
    self.m_curScore = 0
    self.mTextCurScore.text = self.m_curScore
    self.mTextTagerScore.text = self.m_DupConfigVo.target_score

    self.m_gameTime = 0
    self.m_goldIndex = 0
    self.m_goldList = {}
    self.m_leftDonw = false
    self.m_rightDonw = false

    self.m_heroInputDir = 0
    self.m_heroHP = 5
    self:refreshHeroHP()

    self:addFrame()
end

--点击右边
function onRightDown(self)
    self.m_rightDonw = true
end

function onLeftDown(self)
    self.m_leftDonw = true
end

function onRightUp(self)
    self.m_rightDonw = false
end

function onLeftUp(self)
    self.m_leftDonw = false
end

function onHeroTriggerEnter2D(self, collider2D)
    local strArr = string.split(collider2D.gameObject.name, ",")
    local type = tonumber(strArr[1])
    local index = tonumber(strArr[2])

    local configVo = pickGold.PickGoldManager:getIconConfigVo(type)
    if configVo.score == 0 then
        self.m_heroHP = self.m_heroHP - 1
        self:refreshHeroHP()

        self.mHeroAnimator:Play("PickGoldSceneUIHero_sad")
        self.mEffect01:SetActive(false)
        self.mEffect02:SetActive(false)

        self.mEffect01:SetActive(true)

        if self.m_heroHP <= 0 then
            GameDispatcher:dispatchEvent(EventName.ONREQ_PICKGOLD_PASS_DUP, {dup_config = self.m_DupConfigVo, score = self.m_curScore})
        end
    else

        self.m_curScore = self.m_curScore + configVo.score
        self.mTextCurScore.text = self.m_curScore

        self.mHeroAnimator:Play("PickGoldSceneUIHero_happy")
        self.mEffect01:SetActive(false)
        self.mEffect02:SetActive(false)

        self.mEffect02:SetActive(true)

        if self.m_isAutoPause ~= true and self.m_curScore >= self.m_DupConfigVo.target_score and not pickGold.PickGoldManager:isPassDup(self.m_DupConfigVo.id) then
            GameDispatcher:dispatchEvent(EventName.PICKGOLD_UPDATE_PAUSESTATE, true)
            self.mGroupPause:SetActive(true)

            self.mBtnExit:SetActive(false)
            self.mBtnFinish:SetActive(true)

            self:updateStarInfo()

            self.m_isAutoPause = true
        end
    end

    AudioManager:playSoundEffect(configVo:getSoundPath())

    for i = #self.m_goldList, 1, -1 do
        if self.m_goldList[i].data.index == index then
            self.m_goldList[i].data = nil
            self.m_goldList[i]:poolRecover()

            table.remove(self.m_goldList, i)
        end
    end
end

function refreshHeroHP(self)
    for i = 1, 5 do
        self:getChildGO(string.format("mImgHP%02d", i)):SetActive(self.m_heroHP >= i)
    end
end

function addFrame(self)
    if self.m_frameSn == nil then
        self.m_frameSn = LoopManager:addFrame(1, 0, self, self.onFrame)
    end
end

function onFrame(self, deltaTime)
    if gs.Time.time - self.m_gameTime >= self.m_DupConfigVo.interval then
        self.m_goldIndex = self.m_goldIndex + 1
        local item = SimpleInsItem:create(self.mGridItem, self.mapGroup, "PickGoldSceneUI_GoldItem")
        table.insert(self.m_goldList, item)

        local gold = self.m_DupConfigVo:getGoldWeight()
        local speed = math.random(self.m_DupConfigVo.speed[1], self.m_DupConfigVo.speed[2])
        local configVo = pickGold.PickGoldManager:getIconConfigVo(gold.type)
        item:getGo():GetComponent(ty.Image):SetImg("arts/ui/pack/pickGold/" .. configVo.icon, true)

        item:getTrans().localEulerAngles = gs.Vector3(0, 0, math.random(configVo.angle[1], configVo.angle[2]))
        item:getGo():GetComponent(ty.RectTransform).anchoredPosition = gs.Vector2(math.random(0, 875), 0)

        item:getGo().name = gold.type .. "," .. self.m_goldIndex
        item.data =
        {
            index = self.m_goldIndex,
            speed = speed,
        }

        self.m_gameTime = gs.Time.time
    end

    for i = #self.m_goldList, 1, -1 do
        self.m_goldList[i]:getTrans():Translate(self.m_goldList[i].data.speed * gs.Vector3(0, -1, 0) * deltaTime, gs.Space.World)

        if self.m_goldList[i]:getGo():GetComponent(ty.RectTransform).anchoredPosition.y <= -770 then
            self.m_goldList[i].data = nil
            self.m_goldList[i]:poolRecover()

            table.remove(self.m_goldList, i)
        end
    end

    if gs.ApplicationUtil.IsPC() then
        local input_x = gs.Input.GetAxisRaw("Horizontal")
        if input_x > 0 then
            self.m_heroInputDir = -1
        elseif input_x < 0 then
            self.m_heroInputDir = 1
        else
            self.m_heroInputDir = 0
        end
    end

    if self.m_rightDonw == true and self.m_leftDonw == false then
        self.m_heroBtnDir = -1
        self:onHeroMove(-1, deltaTime)
    elseif self.m_rightDonw == false and self.m_leftDonw == true then
        self:onHeroMove(1, deltaTime)
    end

    if self.m_heroInputDir ~= 0 then
        self:onHeroMove(self.m_heroInputDir, deltaTime)
    end
end

function clearGold(self)
    if self.m_goldList then
        for k, v in pairs(self.m_goldList) do
            v:poolRecover()
        end

        self.m_goldList = nil
    end
end

function onHeroMove(self, dir, deltaTime)
    self.mHeroRectTrans.localScale = gs.Vector3(dir, 1, 1)

    if (dir > 0 and self.mHeroRectTrans.anchoredPosition.x > -425) or (dir < 0 and self.mHeroRectTrans.anchoredPosition.x < 423) then
        self.mHeroRectTrans:Translate(5 * gs.Vector3(dir * -1, 0, 0) * deltaTime, gs.Space.World)
    end
end

function clearFrame(self)
    if self.m_frameSn then
        LoopManager:removeFrameByIndex(self.m_frameSn)
        self.m_frameSn = nil
    end
end

-------------------暂停界面Start--------------------------------

-- 暂停
function onPauseClick(self)
    GameDispatcher:dispatchEvent(EventName.PICKGOLD_UPDATE_PAUSESTATE, true)
    self.mGroupPause:SetActive(true)

    self.mBtnExit:SetActive(self.m_curScore < self.m_DupConfigVo.target_score)
    self.mBtnFinish:SetActive(self.m_curScore >= self.m_DupConfigVo.target_score)

    self:updateStarInfo()

end

-- 继续
function onPlayClick(self)
    GameDispatcher:dispatchEvent(EventName.PICKGOLD_UPDATE_PAUSESTATE, false)

    self.mGroupPause:SetActive(false)

end

-- 重新开始
function onReplayClick(self)
    GameDispatcher:dispatchEvent(EventName.PICKGOLD_UPDATE_PAUSESTATE, false)

    self.mGroupPause:SetActive(false)
    self:refreshView(self.m_DupConfigVo)
end

-- 退出
function onExitClick(self)
    self:close()
end

function onFinishClick(self)
    self.mGroupPause:SetActive(false)
    GameDispatcher:dispatchEvent(EventName.ONREQ_PICKGOLD_PASS_DUP, {dup_config = self.m_DupConfigVo, score = self.m_curScore})
end

function refreshPauseState(self, pauseState)
    self.mImgStart:SetActive(pauseState)
    self.mImgPause:SetActive(not pauseState)

    if pauseState then
        self:clearFrame()
    else
        self:addFrame()
    end
end

-------------------暂停界面

-- 更新星级
function updateStarInfo(self)
    self.mTextPassScore.text = _TT(151209) .. self.m_curScore
    self.mTextTargerScore.text = _TT(151208) .. self.m_DupConfigVo.target_score
    self.mFinish:SetActive(self.m_curScore >= self.m_DupConfigVo.target_score)
    self.mNoFinish:SetActive(self.m_curScore < self.m_DupConfigVo.target_score)

end

-------------------暂停界面End--------------------------------

return _M
