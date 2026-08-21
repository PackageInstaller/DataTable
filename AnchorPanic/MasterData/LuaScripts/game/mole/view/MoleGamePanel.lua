module("mole.MoleGamePanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("mole/MoleGamePanel.prefab")
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

    self.mMoleItems = {}

    self.mPosItemDic = {}

    self.mHitItemDic = {}
    self.mScoreItemDic = {}

    self.mDesSnDic = {}
    self.mHitSnDic = {}
    self.mScoreSnDic = {}
    self.mClearSnDic = {}

    self.mStarItemDic = {}

    self.hitBossList = {}

    self.endSet = false
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.m_startView = mole.MoleStartView.new()
    self.m_startView:initData(self:getChildGO('StartGroup'))

    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
    self.mTxtScore = self:getChildGO("mTxtScore"):GetComponent(ty.Text)
    self.mPosTranDic = {}
    for i = 1, 8, 1 do
        self.mPosTranDic[i] = self:getChildTrans("pos" .. i)
    end

    self.mPosTranDic[0] = self:getChildTrans("pos0")

    self.mClickDic = {}
    for i = 1, 8, 1 do
        self.mClickDic[i] = self:getChildGO("click" .. i)
    end

    -- self.mKeyDic = {}
    for i = 1, 8, 1 do
        -- self.mKeyDic[i] = self:getChildGO("mKey".. i)
        self:getChildGO("mKey" .. i):SetActive(gs.ApplicationUtil.IsPC())
    end

    self.mMoleItem = self:getChildGO("mMoleItem")

    self.mSliderTimerBg = self:getChildTrans("mSliderTimerBg")
    self.mSliderTimer = self:getChildTrans("mSliderTimer")

    self.mBtnPause = self:getChildGO("mBtnPause")
    self.mScoreItem = self:getChildGO("mScoreItem")
    self.mHitItem = self:getChildGO("mHitItem")

    self.mScoreContent = self:getChildTrans("mScoreContent")
    self.mScoreNeedItem = self:getChildGO("mScoreNeedItem")

    self.mGroupPause = self:getChildGO("mGroupPause")
    self.mBtnExit = self:getChildGO("mBtnExit")
    self.mBtnReplay = self:getChildGO("mBtnReplay")
    self.mBtnPlay = self:getChildGO("mBtnPlay")
    self.screenW, self.screenH = ScreenUtil:getScreenSize()

end

function initViewText(self)
end

-- 激活
function active(self, args)
    super.active(self, args)
    self.dupId = args.dupId
    self.mBtnPause:SetActive(true)
    MoneyManager:setMoneyTidList({})

    self:clearAll()
    local function _finishCall()
        self.m_startView:setActive(false)
        self:showPanel()
    end
    self.m_startView:setActive(true)
    self.m_startView:start(_finishCall)

    -- self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})

    self:clearAllStarItem()
    self:clearAllDesSn()
    self:clearMoleItems()
    self:clearAllClearSn()
    self:clearAllHitSn()
    self:clearAllScoreSn()

    self.mPosItemDic = {}

    if self.gameSn ~= nil then
        LoopManager:removeFrameByIndex(self.gameSn)
        self.gameSn = nil
    end
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnPause, self.onClickPause)

    self:addUIEvent(self.mBtnExit, self.onClickExit)
    self:addUIEvent(self.mBtnReplay, self.onClickReplay)
    self:addUIEvent(self.mBtnPlay, self.onClickPlay)

    for k, v in pairs(self.mClickDic) do
        self:addUIEvent(v, self.onClickMoleHandler, "", k)
    end
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
    self:clearAll()

end

function onClickPlay(self)
    self.isPasue = false
    self.mGroupPause:SetActive(false)
end

function onClickPause(self)
    self.isPasue = true
    self.mGroupPause:SetActive(true)
end

function clearAll(self)
   
    self.endSet = false
    self.hitBossList = {}
    self.moleBossTimer = sysParam.SysParamManager:getValue(SysParamType.MOLE_BOSS_TIMER) / 1000
    self.gameVo = mole.MoleManager:getMoleDataById(self.dupId)
    self.gameEndTime = self.gameVo.roundTime

    self.curEvent = 1
    self.hitCount = 0
    self.gameCurTime = 0
    self.mScore = 0
    self.lastBossTime = 0

    self:clearHitItem()
    self:updateScore()

    self:clearAllStarItem()
    self:clearAllDesSn()
    self:clearMoleItems()
    self:clearAllClearSn()
    self:clearAllHitSn()
    self:clearAllScoreSn()
    self:clearAllScoreItem()
    self.mPosItemDic = {}

    if self.gameSn ~= nil then
        LoopManager:removeFrameByIndex(self.gameSn)
        self.gameSn = nil
    end

    local remTime = gs.Mathf.Clamp(math.ceil(self.gameEndTime - self.gameCurTime), 0, self.gameEndTime)
    self.mTxtTime.text = math.abs(remTime) .. "s"

    gs.TransQuick:SizeDelta01(self.mSliderTimer, (self.mSliderTimerBg.sizeDelta.x - 8) * 1)
end

function showPanel(self)

    self:clearAll()

    for i = 1, #self.gameVo.starList do
        local starItem = SimpleInsItem:create(self.mScoreNeedItem, self.mScoreContent, "mGameStarNeed")
        local starVo = mole.MoleManager:getStarDataById(self.gameVo.starList[i])
        starItem:getChildGO("mTxtScoreNeed"):GetComponent(ty.Text).text = "≥ " .. starVo.point
        starItem:getChildGO("mImgStar"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("mole/star_no.png"),
            false)
        self.mStarItemDic[i] = {
            item = starItem,
            needScore = starVo.point
        }
    end

    self.gameEvent = self.gameVo.eventList

    self:updateScore()
    self:updateStarDic()
    self.gameSn = LoopManager:addFrame(0, 0, self, self.updateGame)
end

function updateGame(self)
    if self.isPasue then
        return
    end

    self.gameCurTime = self.gameCurTime + gs.Time.deltaTime

    local remTime = gs.Mathf.Clamp(math.ceil(self.gameEndTime - self.gameCurTime), 0, self.gameEndTime)
    self.mTxtTime.text = math.abs(remTime) .. "s"

    if self.gameEvent[self.curEvent] ~= nil and self.gameCurTime >= self.gameEvent[self.curEvent].timePoint / 1000 then
        self:createMole(self.curEvent)
        self.curEvent = self.curEvent + 1
    end

    if gs.ApplicationUtil.IsPC() then
        if gs.Input.GetKeyUp(gs.KeyCode.A) then
            self:onClickMoleHandler(1)
        elseif gs.Input.GetKeyUp(gs.KeyCode.S) then
            self:onClickMoleHandler(2)
        elseif gs.Input.GetKeyUp(gs.KeyCode.D) then
            self:onClickMoleHandler(3)
        elseif gs.Input.GetKeyUp(gs.KeyCode.F) then
            self:onClickMoleHandler(4)
        elseif gs.Input.GetKeyUp(gs.KeyCode.J) then
            self:onClickMoleHandler(5)
        elseif gs.Input.GetKeyUp(gs.KeyCode.K) then
            self:onClickMoleHandler(6)
        elseif gs.Input.GetKeyUp(gs.KeyCode.L) then
            self:onClickMoleHandler(7)
        elseif gs.Input.GetKeyUp(gs.KeyCode.Semicolon) then
            self:onClickMoleHandler(8)
        end
    end

    if gs.Input.GetMouseButtonDown(0) then
        local mousePos = gs.Input.mousePosition

        local list = gs.UnityEngineUtil.GetRaycastUIResults(gs.Vector2(mousePos.x, mousePos.y), true)

  
        if list.Count > 0 and list[0].gameObject.name == "moelBg" then
            self.hitCount = self.hitCount + 1
            local mouseWorldPos = gs.CameraMgr:ScreenToWorldByUICamera(mousePos)
            local localPos = self.mPosTranDic[0]:GetComponent(ty.RectTransform):InverseTransformPoint(mouseWorldPos)
        
            self:creatHitClick(localPos.x , localPos.y , self.hitCount)
        end
    end

    gs.TransQuick:SizeDelta01(self.mSliderTimer, (self.mSliderTimerBg.sizeDelta.x - 8) *
        (self.gameEndTime - self.gameCurTime) / self.gameEndTime)

    -- if self.gameCurTime >= self.gameEndTime - 3 and self.endSet == false then
    --     self.endSet = true
    --     self.mBtnPause:SetActive(false)
    --     AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_common_2.prefab")
    -- end
    if self.gameCurTime >= self.gameEndTime then
        self.gameCurTime = self.gameEndTime
        self:gameEnd()
    end
end

function updateClickRay(self)
    for k, v in pairs(self.mClickDic) do
        v:GetComponent(ty.Image).raycastTarget = self.mPosItemDic[k] ~= nil
    end
    -- self.mClickDic[1].raycastTarget = true
end

function createMole(self, curEvent)
    local curVo = self.gameVo.eventList[curEvent]
    local moleId = curVo.moleId
    local pos = curVo.pos

    local moelItem = SimpleInsItem:create(self.mMoleItem, self.mPosTranDic[pos], "MoleItem")
    local moleItemVo = mole.MoleManager:getMoleItemData(moleId)
    gs.TransQuick:UIPos(moelItem:getGo():GetComponent(ty.RectTransform), 0, 0)
    moelItem:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(
        UrlManager:getIconPath("mole/" .. moleItemVo.icon .. ".png"), false)

    local destoryTime = moleItemVo.time / 1000
    self.mPosItemDic[pos] = {
        item = moelItem,
        eventId = curEvent,
        moleItemVo = moleItemVo
    }

    self.mMoleItems[curEvent] = moelItem

    local clearTime = self.gameCurTime + moleItemVo.time / 1000
    self.mDesSnDic[curEvent] = LoopManager:addFrame(0, 0, self, function()
        if self.mPosItemDic[pos] and self.mPosItemDic[pos].moleItemVo.type == mole.MoleType.Boss then
            if self.gameCurTime >= clearTime - 0.3 then
                if table.indexof01(self.hitBossList, pos) > 0 then
                    self.mMoleItems[curEvent]:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(
                        UrlManager:getIconPath("mole/" .. moleItemVo.icon .. "_hit.png"), false)
                    self.mMoleItems[curEvent].m_go:GetComponent(ty.Animator):SetTrigger("exit")
                    table.remove(self.hitBossList, pos)
                end
            end
        end

        if self.gameCurTime >= clearTime then
            self:clearMole(curEvent, pos)
        end
    end)
    self:updateClickRay()
end

function updateStarDic(self)
    for k, v in pairs(self.mStarItemDic) do
        v.item:getChildGO("mImgStar"):GetComponent(ty.AutoRefImage):SetImg(
            v.needScore > self.mScore and UrlManager:getPackPath("mole/star_no.png") or
                UrlManager:getPackPath("mole/star_has.png"), false)
    end
end

function clearMole(self, curEvent, pos)
    if self.mPosItemDic[pos] ~= nil then
        self.mPosItemDic[pos] = nil
    end

    LoopManager:removeFrameByIndex(self.mDesSnDic[curEvent])
    if self.mMoleItems[curEvent] ~= nil then
        self.mMoleItems[curEvent]:poolRecover()
        self.mMoleItems[curEvent] = nil
    end
end

function hitMoel(self, x, y, count, score, clickId, isBoss)
    local moleItemVo = self.mPosItemDic[clickId].moleItemVo
    local curEvent = self.mPosItemDic[clickId].eventId

    if not isBoss then
        self.mMoleItems[curEvent]:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(
            "mole/" .. moleItemVo.icon .. "_hit.png"), false)
        self.mMoleItems[curEvent].m_go:GetComponent(ty.Animator):SetTrigger("exit")
    end

    if isBoss then
        if table.indexof01(self.hitBossList, clickId) == 0 then
            table.insert(self.hitBossList, clickId)
        end
    else
        self.mPosItemDic[clickId] = nil
        self.mClearSnDic[curEvent] = LoopManager:addTimer(0.3, 0, self, function()
            self:clearMole(curEvent)
            LoopManager:removeTimerByIndex(self.mClearSnDic[curEvent])
            self.mClearSnDic[curEvent] = nil
        end)
    end

    self:updateClickRay()
end

function creatHitClick(self, x, y, hitCount, score, clickId, isBoss)
    local hitClickItem = SimpleInsItem:create(self.mHitItem, self.mPosTranDic[0], "hitClickItem")
    gs.TransQuick:UIPos(hitClickItem:getGo():GetComponent(ty.RectTransform), x, y)

    self.mHitItemDic[hitCount] = {
        item = hitClickItem
    }
    self.mHitSnDic[hitCount] = LoopManager:addTimer(0.4, 0, self, function()
        LoopManager:removeTimerByIndex(self.mHitSnDic[hitCount])
        self.mHitItemDic[hitCount].item:poolRecover()
        self.mHitItemDic[hitCount] = nil
    end)

    if score ~= nil then
        local scoreItem = SimpleInsItem:create(self.mScoreItem, self.mPosTranDic[0], "scoreShow")
        gs.TransQuick:UIPos(scoreItem:getGo():GetComponent(ty.RectTransform), x + 60, y + 60)
        scoreItem:getChildGO("mTxtHitScore"):GetComponent(ty.Text).text = score
        -- scoreItem:getChildGO("mTxtHitScore"):GetComponent(ty.Text).text = score
        self.mScoreItemDic[hitCount] = {
            item = scoreItem
        }
        self.mScoreSnDic[hitCount] = LoopManager:addTimer(0.4, 0, self, function()
            self.mScoreItemDic[hitCount].item:poolRecover()
            self.mScoreItemDic[hitCount] = nil
            LoopManager:removeTimerByIndex(self.mScoreSnDic[hitCount])
        end)
        self:hitMoel(x, y, hitCount, score, clickId, isBoss)

        if score > 0 then
            AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_mole_2.prefab")
        else
            AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_mole_3.prefab")
        end
    else
        AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_mole_1.prefab")
    end

end

function onClickMoleHandler(self, clickId)
    self.hitCount = self.hitCount + 1
    if self.mPosItemDic[clickId] then

        -- boss 不销毁
        if self.mPosItemDic[clickId].moleItemVo.type == mole.MoleType.Boss then
            if self.gameCurTime - self.lastBossTime > self.moleBossTimer then

                self.lastBossTime = self.gameCurTime
                self.mScore = self.mScore + self.mPosItemDic[clickId].moleItemVo.score

                self:creatHitClick(self.mPosTranDic[clickId].localPosition.x, self.mPosTranDic[clickId].localPosition.y,
                    self.hitCount, self.mPosItemDic[clickId].moleItemVo.score, clickId, true)
            end
        else
            self.mScore = self.mScore + self.mPosItemDic[clickId].moleItemVo.score
            self:creatHitClick(self.mPosTranDic[clickId].localPosition.x, self.mPosTranDic[clickId].localPosition.y,
                self.hitCount, self.mPosItemDic[clickId].moleItemVo.score, clickId, false)
        end
        self:updateScore()
        self:updateStarDic()
    else
        self:creatHitClick(self.mPosTranDic[clickId].localPosition.x, self.mPosTranDic[clickId].localPosition.y,
            self.hitCount)
    end
end

function updateScore(self)
    self.mTxtScore.text = _TT(139102) .. self.mScore
end

function clearMoleItems(self)
    for k, v in pairs(self.mMoleItems) do
        v:poolRecover()
    end
    self.mMoleItems = {}
end

function clearAllDesSn(self)
    for k, v in pairs(self.mDesSnDic) do
        LoopManager:removeFrameByIndex(v)
    end
    self.mDesSnDic = {}
end

function clearAllClearSn(self)
    for k, v in pairs(self.mClearSnDic) do
        LoopManager:removeTimerByIndex(v)
    end
    self.mClearSnDic = {}
end

function clearAllScoreSn(self)
    for k, v in pairs(self.mScoreSnDic) do
        --v.item:poolRecover()
        v = nil
        LoopManager:removeTimerByIndex(v)
    end
    self.mScoreSnDic = {}
end

function clearAllScoreItem(self)
    for k, v in pairs(self.mScoreItemDic) do
        v.item:poolRecover()
    end
    self.mScoreItemDic = {}
end

function clearAllHitSn(self)
    for k, v in pairs(self.mHitSnDic) do
        LoopManager:removeTimerByIndex(v)
    end
    self.mHitSnDic = {}
end

function clearAllStarItem(self)
    for k, v in pairs(self.mStarItemDic) do
        v.item:poolRecover()
    end
    self.mStarItemDic = {}
end

function clearHitItem(self)
    for k, v in pairs(self.mHitItemDic) do
        v.item:poolRecover()
    end
    self.mHitItemDic = {}
end

function gameEnd(self)
    self:clearAllStarItem()
    self:clearAllDesSn()
    self:clearMoleItems()
    self:clearAllClearSn()
    self:clearAllHitSn()
    -- self:clearAllScoreSn()

    self.mPosItemDic = {}

    if self.gameSn ~= nil then
        LoopManager:removeFrameByIndex(self.gameSn)
        self.gameSn = nil
    end
    local isFirst = mole.MoleManager:getDupPassStar(self.dupId) == 0
    GameDispatcher:dispatchEvent(EventName.OPEN_MOLE_SETTLE_PANEL, {
        dupId = self.dupId,
        first = isFirst,
        score = self.mScore
    })
end
return _M
