module("build.BuildGamePanel", Class.impl(View))

-- 说明：小游戏基础参数集中配置，避免玩法数值散落在流程代码中。
-- launcherRange：发射器横向移动边界；launcherDefaultSpeed：默认移动速度；launcherY：发射器固定高度。
-- createItemInterval：方块生成点击冷却；initHp：初始容错次数；scorePerItem：每次成功堆叠得分。
local GAME_CONFIG = {
    launcherRange = 250,
    launcherDefaultSpeed = 260,
    launcherY = 120,
    contentMoveTime = 1,
    createItemInterval = 0.3,
    initHp = 3,
    iconMinId = 1,
    iconMaxId = 5,
    scorePerItem = 100
}

-- 说明：堆叠判定与偏移表现配置。
-- maxCount：场上最多保留的堆叠方块数量；maxOffsetX：本次落点相对上一块的最大容错距离。
-- arrowOffsetScale/contentMoveScale：将实际堆叠偏移转换为箭头偏移和底座摆动幅度。
local STACK_CONFIG = {
    maxCount = 3,
    maxOffsetX = 50,
    arrowOffsetScale = 4 / 5,
    contentMoveScale = 0.5
}

-- 说明：所有堆叠相关动画参数集中管理，方便调整落下、整理队列和倒塌表现。
-- collapse 系列参数会按方块层级递增，形成由下至上的连续倒塌效果。
local ANIM_CONFIG = {
    dropTime = 0.1,
    stackMoveTime = 0.2,
    collapseDelay = 0.08,
    collapseMoveTime = 0.6,
    collapseBaseRotate = 65,
    collapseRotateStep = 12,
    collapseBaseMoveX = 520,
    collapseMoveXStep = 80,
    collapseBaseMoveY = 180,
    collapseMoveYStep = 45,
    bottomMoveTime = 0.2
}

-- 说明：界面资源与面板基础行为配置。
-- 本面板为全屏玩法界面，不使用黑屏过渡、ESC 关闭和关闭全部按钮，生命周期结束时即时销毁。
UIRes = UrlManager:getUIPrefabPath("build/BuildGamePanel.prefab")
destroyTime = 0
panelType = 1
isScreensave = 0
isBlur = 0
escapeClose = 0
isShowCloseAll = false

function ctor(self)
    super.ctor(self)
end

function initData(self)
    super.initData(self)
    -- 说明：分数状态分为当前局内得分和关卡目标得分，重开或重新进入面板时统一重置。
    self.mScore = 0
    self.mTargetScore = 0
    -- 说明：循环材质动画状态，参考 BirdGamePanel 只在玩法运行时开启 shader 滚动。
    self.shaderScrolling = false
    self.loopMaterialOffset = 0
    self.loopMaterialLastUpdateTime = 0
    -- 说明：缓存帧循环/延时回调序号与运行中方块数据，便于关闭界面和重玩时统一释放。
    self.destroySnList = {}
    self.mGameItemList = {}
    -- 说明：发射器状态包含移动边界、基础速度、实时速度、固定高度、当前位置和方向。
    self.mLauncherRange = GAME_CONFIG.launcherRange
    self.mLauncherDefaultSpeed = GAME_CONFIG.launcherDefaultSpeed
    self.mLauncherSpeed = self.mLauncherDefaultSpeed
    self.mLauncherY = GAME_CONFIG.launcherY
    self.mLauncherX = 0
    self.mLauncherDir = 1
    -- 说明：底座摆动由当前堆叠总偏移驱动，偏移越大摆动范围越大，用于强化失衡反馈。
    self.mGameContentMoveRange = 0
    self.mGameContentMoveDir = 1
    self.mGameContentMoveTime = GAME_CONFIG.contentMoveTime
    -- 说明：点击生成方块使用时间戳冷却，防止同一帧或短时间连续点击造成重复落块。
    self.mCreateGameItemInterval = GAME_CONFIG.createItemInterval
    self.mNextCreateGameItemTime = 0
end

function configUI(self)
    super.configUI(self)

    -- 说明：开始界面独立控制进入动画，动画完成后再显示主玩法循环。
    self.m_startView = build.BuildStartView.new()
    self.m_startView:initData(self:getChildGO('StartGroup'))
    -- 说明：玩法控制按钮，分别负责暂停、退出、重玩、继续和完成结算。
    self.mBtnPause = self:getChildGO("mBtnPause")
    self.mBtnExit = self:getChildGO("mBtnExit")
    self.mBtnReplay = self:getChildGO("mBtnReplay")
    self.mBtnPlay = self:getChildGO("mBtnPlay")
    self.mGroupPause = self:getChildGO("mGroupPause")

    -- 说明：核心玩法容器、发射器、方向提示、下一块预览图标与偏移箭头。
    self.mGame = self:getChildGO("mGame")
    self.mGameContent = self:getChildTrans("mGameContent")
    self.mGameContentBaseX = self.mGameContent.anchoredPosition.x
    self.mLauncher = self:getChildGO("mLauncher")
    self.mImgRight = self:getChildGO("mImgRight")
    self.mImgLeft = self:getChildGO("mImgLeft")
    self.mImgGamePre = self:getChildGO("mImgGamePre"):GetComponent(ty.AutoRefImage)
    self.mImgArrow = self:getChildTrans("mImgArrow")

    -- 说明：分数、目标和生命值显示节点，暂停面板与局内 HUD 会复用这些数据。
    self.mTxtCurrentScore = self:getChildGO("mTxtCurrentScore"):GetComponent(ty.Text)
    self.mTxtSocreInfo = self:getChildGO("mTxtSocreInfo"):GetComponent(ty.Text)
    self.mTxtTargetGame = self:getChildGO("mTxtTargetGame"):GetComponent(ty.Text)
    self.mTxtTargetScore = self:getChildGO("mTxtTargetScore"):GetComponent(ty.Text)
    self.mHpList = {self:getChildGO("mHp1"), self:getChildGO("mHp2"), self:getChildGO("mHp3")}

    -- 说明：方块模板默认隐藏，实际玩法中通过对象池克隆并挂载到 mGameContent 下。
    self.mGameItem = self:getChildGO("mGameItem")
    self.mGameItem:SetActive(false)

    -- 说明：达标/未达标状态节点用于暂停界面提示当前是否满足结算条件。
    self.mIsTarget = self:getChildGO("mIsTarget")

    self.mIsTargetNot = self:getChildGO("mIsTargetNot")
    self.mTxtCurrentSocre = self:getChildGO("mTxtCurrentSocre"):GetComponent(ty.Text)
    self.mTxtCurrentGame = self:getChildGO("mTxtCurrentGame"):GetComponent(ty.Text)

    self.mBtnFinish = self:getChildGO("mBtnFinish")

    self.mAutoImgGamePre = self:getChildGO("mImgGamePre"):GetComponent(ty.AutoRefImage)

    self.mImgLoop = self:getChildGO("mImgLoop")
    self.mImgLoopMat = self:getChildGO("mImgLoop"):GetComponent(ty.Image).material
    self.mImgBottomTrans = self:getChildTrans("mImgBottom")
    self.mImgBottomBaseY = self.mImgBottomTrans.anchoredPosition.y
    self.mImgBottomTween = nil
end

function initViewText(self)
    self.mTxtSocreInfo.text = _TT(151261)
    self.mTxtCurrentSocre.text = _TT(151260)
end

function active(self, args)
    super.active(self, args)
    self.dupId = args.dupId
    MoneyManager:setMoneyTidList({})
    local function _finishCall()
        self.m_startView:setActive(false)
        self:showPanel()
    end
    self.m_startView:setActive(true)
    self.m_startView:start(_finishCall)
    self:initGameData()
end

function deActive(self)
    self:clearAllSn()
    self:clearAllGameItem()
    super.deActive(self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnPause, self.onClickPause)
    self:addUIEvent(self.mBtnExit, self.onClickExit)
    self:addUIEvent(self.mBtnReplay, self.onClickReplay)
    self:addUIEvent(self.mBtnPlay, self.onClickPlay)
    self:addUIEvent(self.mBtnFinish, self.onClickFinish)
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
    self.isPasue = false
    self.mGroupPause:SetActive(false)
    self.canRun = true
end

function onClickPause(self)
    self.canRun = false
    self.isPasue = true
    self:stopLoopMaterialScrolling()

    self.mTxtCurrentScore.text = _TT(151209) .. self.mScore
    self.mTxtTargetScore.text = _TT(151208) .. self.mTargetScore

    if self.mScore >= self.mTargetScore then
        self.mBtnFinish:SetActive(true)
        self.mBtnExit:SetActive(false)
    else
        self.mBtnFinish:SetActive(false)
        self.mBtnExit:SetActive(true)
    end

    self.mIsTarget:SetActive(self.mScore >= self.mTargetScore)
    self.mIsTargetNot:SetActive(self.mScore < self.mTargetScore)
    self.mGroupPause:SetActive(true)
end

function onClickGame(self)
    if self.isPasue or self.isEnd or not self.canRun then
        return
    end
    self:createGameItemToBottom()
end

function isClickPauseButton(self)
    if not self.mBtnPause then
        return false
    end

    local mousePos = gs.Input.mousePosition
    local list = gs.UnityEngineUtil.GetRaycastUIResults(gs.Vector2(mousePos.x, mousePos.y), true)
    if not list or list.Count <= 0 then
        return false
    end

    for i = 0, list.Count - 1 do
        local go = list[i].gameObject
        if go == self.mBtnPause or go.transform:IsChildOf(self.mBtnPause.transform) then
            return true
        end
    end
    return false
end

function getGameIconPath(self, iconId)
    return UrlManager:getPackPath(string.format("build/icon_%s.png", iconId))
end

function randomNextGameIcon(self)
    self.randomIconId = math.random(GAME_CONFIG.iconMinId, GAME_CONFIG.iconMaxId)
    if self.mImgGamePre then
        self.mImgGamePre:SetImg(self:getGameIconPath(self.randomIconId), false)
    end
end

function updateLauncherSpeed(self)
    -- 说明：根据当前得分匹配关卡速度表，未配置速度表时保持默认发射器速度。
    self.mLauncherSpeed = self.mLauncherDefaultSpeed or self.mLauncherSpeed
    if not self.mGameDataVo or not self.mGameDataVo.scoreSpeed then
        return
    end

    for i = 1, #self.mGameDataVo.scoreSpeed do
        local config = self.mGameDataVo.scoreSpeed[i]
        self.mLauncherSpeed = config[2]
        if self.mScore < config[1] then
            return
        end
    end
end

function updateGameHpView(self)
    local hp = self.mGameHp or 0
    if not self.mHpList then
        return
    end
    for i = 1, #self.mHpList do
        local hpGo = self.mHpList[i]
        if hpGo then
            hpGo:SetActive(i <= hp)
        end
    end
end

function getGameItem(self, data)
    return data and (data.item or data) or nil
end

function getGameItemRect(self, data)
    local item = self:getGameItem(data)
    if not item then
        return nil
    end
    return item:getGo():GetComponent(ty.RectTransform)
end

function killGameItemTween(self, data)
    if data and data.tween then
        data.tween:Kill()
        data.tween = nil
    end
end

function recoverGameItem(self, data)
    if not data then
        return
    end
    self:killGameItemTween(data)
    if data.effectSn then
        self:clearTimeout(data.effectSn)
        data.effectSn = nil
    end
    if data.effect then
        data.effect:SetActive(false)
    end
    local item = self:getGameItem(data)
    if item then
        item:poolRecover()
    end
end

function createGameItemData(self, posX, posY)
    local item = SimpleInsItem:create(self.mGameItem, self.mGameContent, "mBuildGameItem")
    local go = item:getGo()
    local rect = go:GetComponent(ty.RectTransform)
    gs.TransQuick:SetLRotation(rect, 0, 0, 0)

    local icon = item:getChildGO("mImgGame"):GetComponent(ty.AutoRefImage)
    icon:SetImg(self:getGameIconPath(self.randomIconId or 1), false)

    local effect = item:getChildGO("mEffect")
    if effect then
        effect:SetActive(false)
    end

    go.transform:SetAsLastSibling()
    gs.TransQuick:UIPos(rect, posX or 0, posY or 0)
    return {
        item = item,
        rect = rect,
        effect = effect
    }
end

function getStackLayoutInfo(self)
    local contentRect = self.mGameContent:GetComponent(ty.RectTransform)
    local templateRect = self.mGameItem:GetComponent(ty.RectTransform)
    local itemHeight = templateRect.rect.height
    local bottomY = -contentRect.rect.height * 0.5 + itemHeight * 0.5
    return itemHeight, bottomY
end

function canCreateGameItem(self)
    local nowTime = gs.Time.time
    if self.mNextCreateGameItemTime and nowTime < self.mNextCreateGameItemTime then
        return false
    end
    self.mNextCreateGameItemTime = nowTime + (self.mCreateGameItemInterval or GAME_CONFIG.createItemInterval)
    return true
end

function resetGameRunState(self)
    self:clearAllGameItem()
    self.mAutoImgGamePre.enabled = true
    self.mScore = 0
    self.mTxtCurrentGame.text = self.mScore
    self.isEnd = false
    self.isCollapse = false
    self.isPasue = false
    self.canRun = true
    self.loopMaterialOffset = 0
    self.loopMaterialLastUpdateTime = 0
    self:stopLoopMaterialScrolling()
    if self.mImgBottomTween then
        self.mImgBottomTween:Kill()
        self.mImgBottomTween = nil
    end
    if self.mImgBottomTrans then
        gs.TransQuick:UIPosY(self.mImgBottomTrans, self.mImgBottomBaseY or self.mImgBottomTrans.anchoredPosition.y)
    end
    self.mGameHp = GAME_CONFIG.initHp
    self:updateGameHpView()
    self.mGameIndex = 0
    self.mNextCreateGameItemTime = 0
    self.mGameContentMoveDir = 1
    self:updateOffsetArrow()
    self.isFirstFinish = true
end

function resetLauncherState(self)
    self.mLauncherX = -self.mLauncherRange
    self.mLauncherDir = 1
    self:updateLauncherDirView()
    if self.mLauncher then
        gs.TransQuick:UIPos(self.mLauncher:GetComponent(ty.RectTransform), self.mLauncherX, self.mLauncherY)
    end
end

function loadGameConfig(self)
    local gameDataVo = build.BuildManager:getBuildDataById(self.dupId)
    self.mGameDataVo = gameDataVo
    self.mTargetScore = gameDataVo.targetScore or 0
    self:updateLauncherSpeed()
end

function refreshTargetView(self)
    if self.mTxtTargetGame then
        self.mTxtTargetGame.text = self.mTargetScore
    end
    if self.mTxtTargetScore then
        self.mTxtTargetScore.text = _TT(151208) .. self.mTargetScore
    end
end

function addScoreForStackSuccess(self)
    self.mScore = self.mScore + GAME_CONFIG.scorePerItem
    self:updateLauncherSpeed()
    self.mTxtCurrentGame.text = self.mScore
end

function tryShowTargetPause(self)
    if self.mScore >= self.mTargetScore and self.isFirstFinish then
        self:onClickPause()
        self.isFirstFinish = false
    end
end

function deductGameHp(self)
    self.mGameHp = (self.mGameHp or GAME_CONFIG.initHp) - 1
    self:updateGameHpView()
end

function isStackFailed(self, targetX)
    local lastData = self.mGameItemList[#self.mGameItemList]
    local lastRect = self:getGameItemRect(lastData)
    if not lastRect then
        return false
    end
    return math.abs(targetX - lastRect.anchoredPosition.x) > STACK_CONFIG.maxOffsetX
end

function getStackTargetY(self, isStackFailed, itemHeight, bottomY)
    if isStackFailed then
        return bottomY
    end
    return bottomY + #self.mGameItemList * itemHeight
end

function onStackFailedDropComplete(self, data)
    self:recoverGameItem(data)
    self:updateOffsetArrow()
    if self.mGameHp <= 0 and not self.isCollapse then
        self:onGameEnd(false)
    end
end

function onStackSuccessDropComplete(self, data, itemHeight, bottomY)
    self:updateOffsetArrow()
    if self.isCollapse then
        return
    end

    self:playStackSuccessEffect(data)
    AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_build_2.prefab")
    self:addScoreForStackSuccess()
    self:playBottomMoveDown(itemHeight)
    self:tryShowTargetPause()
    self:trimOverflowStack(itemHeight, bottomY)
end

function playStackSuccessEffect(self, data)
    if not data or not data.effect then
        return
    end

    if data.effectSn then
        self:clearTimeout(data.effectSn)
        data.effectSn = nil
    end
    data.effect:SetActive(true)
    data.effectSn = self:setTimeout(0.8, function()
        if data.effect then
            data.effect:SetActive(false)
        end
        data.effectSn = nil
    end)
    table.insert(self.destroySnList, data.effectSn)
end

function playBottomMoveDown(self, itemHeight)
    if not self.mImgBottomTrans then
        return
    end
    if self.mImgBottomTween then
        self.mImgBottomTween:Kill()
        self.mImgBottomTween = nil
        self:stopLoopMaterialScrolling()
    end

    self:startLoopMaterialScrolling()
    local curPos = self.mImgBottomTrans.anchoredPosition
    self.mImgBottomTween = self.mImgBottomTrans:DOAnchorPosY(curPos.y - itemHeight / 6, ANIM_CONFIG.bottomMoveTime)
    self.mImgBottomTween:OnComplete(function()
        self.mImgBottomTween = nil
        self:stopLoopMaterialScrolling()
    end)
end

function trimOverflowStack(self, itemHeight, bottomY)
    if #self.mGameItemList <= STACK_CONFIG.maxCount then
        return
    end

    self:recoverGameItem(table.remove(self.mGameItemList, 1))
    for i = 1, #self.mGameItemList do
        local moveData = self.mGameItemList[i]
        local moveRect = self:getGameItemRect(moveData)
        if moveRect then
            self:killGameItemTween(moveData)
            local moveX = moveRect.anchoredPosition.x
            local moveY = bottomY + (i - 1) * itemHeight
            moveData.tween = moveRect:DOLocalMove(gs.Vector3(moveX, moveY, 0), ANIM_CONFIG.stackMoveTime)
            moveData.tween:OnComplete(function()
                moveData.tween = nil
                self:updateOffsetArrow()
            end)
        end
    end
end

function finishCollapseItem(self, data, item, collapseCount)
    if data then
        data.tween = nil
        if data.effectSn then
            self:clearTimeout(data.effectSn)
            data.effectSn = nil
        end
        if data.effect then
            data.effect:SetActive(false)
        end
    end
    if item then
        item:poolRecover()
    end
    self.mCollapseFinishCount = (self.mCollapseFinishCount or 0) + 1
    if self.mCollapseFinishCount >= collapseCount then
        self.mGameItemList = {}
        self.mGameContentMoveRange = 0
        self:onGameEnd(false)
    end
end

function playCollapseTween(self, data, item, rect, index, dir, collapseCount)
    self:killGameItemTween(data)
    local curPos = rect.anchoredPosition
    local delay = (index - 1) * ANIM_CONFIG.collapseDelay
    local moveTime = ANIM_CONFIG.collapseMoveTime
    local sequence = gs.DT.DOTween.Sequence()
    sequence:AppendInterval(delay)
    sequence:Join(rect:DOLocalRotate(gs.Vector3(0, 0, -dir * (ANIM_CONFIG.collapseBaseRotate + index * ANIM_CONFIG.collapseRotateStep)), moveTime))
    sequence:Join(rect:DOLocalMove(gs.Vector3(curPos.x + dir * (ANIM_CONFIG.collapseBaseMoveX + index * ANIM_CONFIG.collapseMoveXStep), curPos.y - ANIM_CONFIG.collapseBaseMoveY - index * ANIM_CONFIG.collapseMoveYStep, 0), moveTime))
    data.tween = sequence
    sequence:OnComplete(function()
        self:finishCollapseItem(data, item, collapseCount)
    end)
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
end

function clearAllGameItem(self)
    -- 说明：统一回收当前场景中的所有方块，并终止其仍在播放的 Tween，避免重玩或关闭界面后残留对象。
    for i = 1, #self.mGameItemList do
        self:recoverGameItem(self.mGameItemList[i])
    end
    if self.mImgBottomTween then
        self.mImgBottomTween:Kill()
        self.mImgBottomTween = nil
        self:stopLoopMaterialScrolling()
    end
    self.mGameItemList = {}
    self:updateOffsetArrow()
end

function initGameData(self)
    -- 说明：开局入口按固定顺序准备运行状态、发射器、预览图、默认底块、关卡配置和目标显示。
    self:resetGameRunState()
    self:resetLauncherState()
    self:randomNextGameIcon()
    self:createDefaultGameItem()
    self:loadGameConfig()
    self:refreshTargetView()
end

function showPanel(self)
    if self.gameSn ~= nil then
        LoopManager:removeFrameByIndex(self.gameSn)
        self.gameSn = nil
    end
    self.loopMaterialLastUpdateTime = gs.Time.time
    self.gameSn = LoopManager:addFrame(0, 0, self, self.updateGame)
end

function startLoopMaterialScrolling(self)
    self.shaderScrolling = true
    self.loopMaterialLastUpdateTime = gs.Time.time
    self:updateLoopMaterial()
end

function stopLoopMaterialScrolling(self)
    self.shaderScrolling = false
    self:updateLoopMaterial()
end

function updateLoopMaterial(self)
    if not self.mImgLoopMat then
        return
    end
    self.mImgLoopMat:SetFloat("_EnableScrolling", self.shaderScrolling and 1 or 0)
    self.mImgLoopMat:SetFloat("_ScrollOffset", self.loopMaterialOffset or 0)
end

function updateGame(self)
    self:updateLoopMaterial()
    if self.isPasue or self.isEnd or not self.canRun then
        return
    end

    local nowTime = gs.Time.time
    local deltaTime = nowTime - (self.loopMaterialLastUpdateTime or nowTime)
    self.loopMaterialLastUpdateTime = nowTime
    if self.shaderScrolling then
        self.loopMaterialOffset = (self.loopMaterialOffset or 0) + deltaTime * 0.01
        self:updateLoopMaterial()
    end

    self:updateLauncherMove()
    self:updateGameContentMove()
    if gs.Input.GetMouseButtonDown(0) and not self:isClickPauseButton() then
        self:createGameItemToBottom()
    end
end

function updateLauncherDirView(self)
    local isRight = (self.mLauncherDir or 1) < 0
    if self.mImgRight then
        self.mImgRight:SetActive(isRight)
    end
    if self.mImgLeft then
        self.mImgLeft:SetActive(not isRight)
    end
end

function updateLauncherMove(self)
    if not self.mLauncher then
        return
    end
    self.mLauncherX = self.mLauncherX + self.mLauncherDir * self.mLauncherSpeed * gs.Time.deltaTime
    if self.mLauncherX >= self.mLauncherRange then
        self.mLauncherX = self.mLauncherRange
        self.mLauncherDir = -1
    elseif self.mLauncherX <= -self.mLauncherRange then
        self.mLauncherX = -self.mLauncherRange
        self.mLauncherDir = 1
    end
    self:updateLauncherDirView()
    gs.TransQuick:UIPos(self.mLauncher:GetComponent(ty.RectTransform), self.mLauncherX, self.mLauncherY)
end

function getGameStackTotalOffset(self)
    local lastRect = self:getGameItemRect(self.mGameItemList[#self.mGameItemList])
    if not lastRect then
        return 0
    end

    return lastRect.anchoredPosition.x - (self.mDefaultGameItemX or 0)
end

function updateOffsetArrow(self)
    local totalOffset = self:getGameStackTotalOffset()
    if self.mImgArrow then
        gs.TransQuick:UIPosX(self.mImgArrow, totalOffset * STACK_CONFIG.arrowOffsetScale)
    end
    self.mGameContentMoveRange = math.abs(totalOffset) * STACK_CONFIG.contentMoveScale
    if math.abs(totalOffset) > STACK_CONFIG.maxOffsetX then
        self:playGameItemCollapse(totalOffset)
    elseif self.mGameContentMoveRange <= 0 and self.mGameContent then
        gs.TransQuick:UIPosX(self.mGameContent, self.mGameContentBaseX or 0)
    end
end

function playGameItemCollapse(self, totalOffset)
    if self.isCollapse then
        return
    end
    self.isCollapse = true
    self.canRun = false
    if self.mGroupPause then
        self.mGroupPause:SetActive(false)
    end

    local dir = totalOffset > 0 and 1 or -1
    local collapseCount = #self.mGameItemList
    if collapseCount <= 0 then
        self:onGameEnd(false)
        return
    end

    self.mCollapseFinishCount = 0
    for i = 1, collapseCount do
        local data = self.mGameItemList[i]
        local item = self:getGameItem(data)
        local rect = self:getGameItemRect(data)
        if item and rect then
            self:playCollapseTween(data, item, rect, i, dir, collapseCount)
        else
            self:finishCollapseItem(data, item, collapseCount)
        end
    end
end

function updateGameContentMove(self)
    -- 说明：当堆叠总偏移不为 0 时，底座围绕初始 X 坐标往返移动，移动范围由偏移量动态决定。
    if not self.mGameContent then
        return
    end
    local moveRange = self.mGameContentMoveRange or 0
    if moveRange <= 0 then
        return
    end

    local baseX = self.mGameContentBaseX or 0
    local curX = self.mGameContent.anchoredPosition.x
    local moveSpeed = moveRange * 2 / (self.mGameContentMoveTime or 1)
    curX = curX + (self.mGameContentMoveDir or 1) * moveSpeed * gs.Time.deltaTime
    if curX >= baseX + moveRange then
        curX = baseX + moveRange
        self.mGameContentMoveDir = -1
    elseif curX <= baseX - moveRange then
        curX = baseX - moveRange
        self.mGameContentMoveDir = 1
    end
    gs.TransQuick:UIPosX(self.mGameContent, curX)
end

function createDefaultGameItem(self)
    local _, bottomY = self:getStackLayoutInfo()
    local data = self:createGameItemData(0, bottomY)
    self.mDefaultGameItemX = data.rect.anchoredPosition.x
    table.insert(self.mGameItemList, data)
    self.mGameIndex = #self.mGameItemList
    self:updateOffsetArrow()
end

function createGameItemToBottom(self)
    if not self:canCreateGameItem() then
        return
    end

    AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_build_1.prefab")
    local itemHeight, bottomY = self:getStackLayoutInfo()
    local targetX = self.mLauncherX or 0
    local isStackFailed = self:isStackFailed(targetX)
    if isStackFailed then
        -- 说明：落点相对上一块超出容错距离时视为失败，本次方块只播放落地回收流程，不进入堆叠列表。
        self:deductGameHp()
    end

    local targetY = self:getStackTargetY(isStackFailed, itemHeight, bottomY)
    local data = self:createGameItemData(targetX, self.mLauncherY or 0)
    self.mAutoImgGamePre.enabled = false
    data.tween = data.rect:DOLocalMove(gs.Vector3(targetX, targetY, 0), ANIM_CONFIG.dropTime)
    data.tween:OnComplete(function()
        self.mAutoImgGamePre.enabled = true
        data.tween = nil
        if isStackFailed then
            self:onStackFailedDropComplete(data)
        else
            self:onStackSuccessDropComplete(data, itemHeight, bottomY)
        end
    end)

    if not isStackFailed then
        table.insert(self.mGameItemList, data)
        self.mGameIndex = #self.mGameItemList
    end
    self:randomNextGameIcon()
end

function onGameEnd(self, isWin)
    if self.isEnd then
        return
    end
    self.isEnd = true
    self.canRun = false
    self:stopLoopMaterialScrolling()

    local isPass = build.BuildManager:getDupPassState(self.dupId)

    self.isWin = isWin ~= nil and isWin or self.mScore >= self.mTargetScore
    local isFirst = self.isWin and isPass == false
    if self.isWin and isPass == false then
        isFirst = true
    end

    GameDispatcher:dispatchEvent(EventName.OPEN_BUILD_SETTLE_PANEL, {
        dupId = self.dupId,
        score = self.mScore,
        first = isFirst,
        isWin = self.isWin
    })
end

return _M