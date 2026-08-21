module("drop.DropGamePanel", Class.impl(View))

-- 说明：本面板为小游戏模块外层框架（开始界面 + 暂停/退出/重玩/继续 + 结算派发）。
-- 具体玩法逻辑（发射器/堆叠/倒塌/计分等）不在此文件中实现，统一由独立玩法模块负责。
UIRes = UrlManager:getUIPrefabPath("drop/DropGamePanel.prefab")
destroyTime = 0
panelType = 1
isScreensave = 0
isBlur = 0
escapeClose = 0
isShowCloseAll = false

-- 说明：玩法配置常量（固定值，便于统一调整）。
local GAME_ITEM_TYPE_COUNT = 10   -- 可随机生成的类型总数
local GAME_LAYER_COUNT = 12        -- 层数量上限（需 ≥ ceil(GAME_ITEM_COUNT / 第一层槽位数)，才能以“连续堆叠、不悬空”方式容纳全部物体）
local GAME_ITEM_COUNT = 150        -- 固定生成的 mGameItem 个数（取 3 的倍数，保证每种类型数量均为 3 的倍数）
local GAME_LAYER1_RATIO = 0.5      -- 第一层生成数量占总数百分比（玩法配置）：第二层仅在该槽位已有第一层物体时生成
local GAME_LAYER_GAP = 24          -- 不同层沿 y 方向的视觉偏移
local GAME_CLEAR_SCORE = 100        -- 单次（单组）消除基础分
local GAME_COMBO_TIME_LIMIT = 5     -- 连击窗口时长（秒）：窗口内再次消除得分翻倍
local GAME_COMBO_SCORE_MULTIPLY = 2  -- 连击窗口内消除得分倍数（基础分 × 此值）
local GAME_MAX_SAME_TYPE_PER_GROUP = 2  -- 单组内同类型数量上限（>2 易自产自消，控制难度/消除节奏）
local GAME_TYPE_ALLOC_MAX_TRY = 80   -- 类型分配最大重试次数（分配失败时兜底，正常远小于此）
-- 说明：动画时长常量（秒），便于统一调整手感。
local GAME_ANIM_MOVE_DURATION = 1       -- 物品移动动画时长（自动排列整盘移动 / 拖拽放入单步移动）
local GAME_ANIM_ITEM_DURATION = 0.3     -- 物品交换 / 下沉 / 透明度渐变的统一时长
local GAME_ANIM_FLOAT_DURATION = 0.5    -- 加分飘字飞行时长
local GAME_ANIM_SCORE_PUNCH_UP = 0.12   -- 分数文本放大脉冲时长
local GAME_ANIM_SCORE_PUNCH_DOWN = 0.18 -- 分数文本回弹时长
local GAME_ANIM_WAIT_FALLBACK = 1.0     -- 视觉动画等待兜底超时（防 tween 被 Kill 永久挂起）
local GAME_ANIM_DESTROY_DURATION = 0.7   -- 物体销毁特效（mEffect）播放时长：深层物体下沉前必须等其播完，避免盖住爆炸特效

function ctor(self)
    super.ctor(self)
end

function initData(self)
    super.initData(self)
    -- 说明：分数状态分为当前局内得分和关卡目标得分，重开或重新进入面板时统一重置。
    self.mScore = 0
    self.mTargetScore = 0
    -- 说明：缓存帧循环/延时回调序号，便于关闭界面和重玩时统一释放。
    self.destroySnList = {}
    -- 说明：玩法运行状态，供暂停/结算复用。
    self.isEnd = false
    -- 说明：正在播放的分数飘字（加分）数量。onGameEnd 确定 isWin 前必须等其归零，
    --       否则 mScore 未累加完会基于未加完的分数错误结算。
    self.mPendingScoreFly = 0
    self.mPendingEndReason = nil  -- 待分数动画结束后再真正结算的结束原因
    self.mEndFallbackSn = nil     -- 分数动画兜底超时回调序号
    self.isPasue = false
    self.canRun = false
    self.isPlaying = false   -- 游戏会话是否进行中（showPanel 起到 onGameEnd 止），与暂停解耦，用于让倒计时暂停时也流逝
    self.isFirstFinish = false
end

function configUI(self)
    super.configUI(self)

    -- 说明：开始界面独立控制进入动画，动画完成后再显示主玩法循环。
    self.m_startView = drop.DropStartView.new()
    self.m_startView:initData(self:getChildGO('StartGroup'))

    -- 说明：玩法控制按钮，分别负责暂停、退出、重玩、继续和完成结算。
    self.mBtnPause = self:getChildGO("mBtnPause")
    self.mBtnExit = self:getChildGO("mBtnExit")
    self.mBtnReplay = self:getChildGO("mBtnReplay")
    self.mBtnPlay = self:getChildGO("mBtnPlay")
    self.mGroupPause = self:getChildGO("mGroupPause")

    -- 说明：分数、目标显示节点，暂停面板与局内 HUD 会复用这些数据。
    self.mTxtCurrentScore = self:getChildGO("mTxtCurrentScore"):GetComponent(ty.Text)
    self.mTxtTargetScore = self:getChildGO("mTxtTargetScore"):GetComponent(ty.Text)
    -- 说明：局内实时显示当前分数的文本节点。
    self.mTxtCurrentGame = self:getChildGO("mTxtCurrentGame"):GetComponent(ty.Text)
    -- 说明：局内倒计时文本（参考 mole 的 mTxtTime / mSliderTimer / mSliderTimerBg）与目标分数文本（参考 build 的 mTxtTargetGame）。
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
    self.mSliderTimerBg = self:getChildTrans("mSliderTimerBg")
    self.mSliderTimer = self:getChildTrans("mSliderTimer")
    self.mTxtTargetGame = self:getChildGO("mTxtTargetGame"):GetComponent(ty.Text)
    -- 说明：combo 连击 UI 节点。
    self.mComboSliderTimerBg = self:getChildGO("mComboSliderTimerBg")
    self.mComboSliderTimerBgT = self:getChildTrans("mComboSliderTimerBg")
    self.mComboSliderTimer = self:getChildGO("mComboSliderTimer")
    self.mComboSliderTimerT = self:getChildTrans("mComboSliderTimer")
    self.mTxtComboTime = self:getChildGO("mTxtComboTime"):GetComponent(ty.Text)
    self.mTxtCombo = self:getChildGO("mTxtCombo"):GetComponent(ty.Text)

    -- 说明：达标/未达标状态节点用于暂停界面提示当前是否满足结算条件。
    self.mIsTarget = self:getChildGO("mIsTarget")
    self.mIsTargetNot = self:getChildGO("mIsTargetNot")

    self.mBtnFinish = self:getChildGO("mBtnFinish")

    -- 说明：GM 调试节点，仅 debug 模式显示。
    self.mGMInfo = self:getChildGO("mGMInfo")
    self.mBtnGMAuto = self:getChildGO("mBtnGMAuto")
    self.mBtnGMRandom = self:getChildGO("mBtnGMRandom")
    self.mBtnGMSocre = self:getChildGO("mBtnGMSocre")
    -- 说明：GM 自动按钮初始文本为“开始自动”。
    if self.mBtnGMAuto then
        self:setBtnLabel(self.mBtnGMAuto, -1, "开始自动")
    end
    -- 说明：GM 调试信息先隐藏，待游戏正式开始（showPanel / onClickPlay 把 canRun 置 true）后再显示。
    if self.mGMInfo then
        self.mGMInfo:SetActive(false)
    end

    -- 说明：格子容器与格子模板。mGameGroup 为父容器，mGroupItem 为组模板，其内部自带 mSingleItem 作为单格模板。
    self.mGameGroup = self:getChildTrans("mGameGroup")
    self.mGroupItem = self:getChildGO("mGroupItem")
    self.mGameItem = self:getChildGO("mGameItem")
    self.mSingleItem = self:getChildGO("mSingleItem")
   
    self.mScoreItem = self:getChildGO("mScoreItem")
end

function initViewText(self)
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
    self:addUIEvent(self.mBtnGMAuto, self.onClickGMAuto)
    self:addUIEvent(self.mBtnGMRandom, self.onClickGMRandom)
    self:addUIEvent(self.mBtnGMSocre, self.onClickGMSocre)
end

function onClickFinish(self)
    self.mGroupPause:SetActive(false)
    self:onGameEnd("手动完成")
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
    -- 说明：从暂停继续（游戏正式运行中）后显示 GM 调试信息。
    if self.mGMInfo then
        self.mGMInfo:SetActive(GameManager.IS_DEBUG)
    end
end

function onClickPause(self)
    self.canRun = false
    self.isPasue = true

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



-- 说明：刷新所有槽位物体的视觉位置与可拖拽状态。
function refreshAllSlotVisual(self, moveDuration, finishCall)
    if not self.mSlotItem then
        if finishCall then
            finishCall()
        end
        return
    end
    local waitCount = 0
    local function _oneDone()
        waitCount = waitCount - 1
        if waitCount <= 0 and finishCall then
            finishCall()
        end
    end
    for g = 1, #self.mSlotItem do
        for s = 1, #self.mSlotItem[g] do
            for L = GAME_LAYER_COUNT, 1, -1 do
                local it = self.mSlotItem[g][s][L]
                if it then
                    if moveDuration and moveDuration > 0 then
                        self:placeItemVisual(it, moveDuration, _oneDone)
                        waitCount = waitCount + 1
                    else
                        self:placeItemVisual(it)
                    end
                    local img = it:getGo():GetComponent(ty.AutoRefImage)
                    if not gs.GoUtil.IsCompNull(img) then
                        img.raycastTarget = false
                    end
                    local trigger = it:getGo():GetComponent(ty.LongPressOrClickEventTrigger)
                    if trigger then
                        trigger.onBeginDrag:RemoveAllListeners()
                        trigger.onEndDrag:RemoveAllListeners()
                    end
                end
            end
        end
    end
    -- 统一按“每个槽位最外层可拖”刷新可点击状态（兼容悬空物体）。
    self:refreshAllDraggable()
    if waitCount <= 0 and finishCall then
        finishCall()
    end
end

-- 说明：等待当前所有正在播放的 placeItemVisual 动画（mMoveTween / mPunchTween）全部完成后再回调。
-- 自动排布必须等移动/下沉动画播放完，才能继续后续结算与下一轮，否则动画会错乱/重叠。
-- 带 DOTween 兜底（1s）：防止个别 tween 被 Kill 导致 OnComplete 不触发而永久挂起（正常路径远小于 1s）。
function waitAllVisual(self, finishCall)
    if not finishCall then
        return
    end
    local tweens = {}
    if self.mGameItemList then
        for _, item in ipairs(self.mGameItemList) do
            if item.mMoveTween then
                table.insert(tweens, item.mMoveTween)
            end
            if item.mPunchTween then
                table.insert(tweens, item.mPunchTween)
            end
        end
    end
    local n = #tweens
    local fired = false
    local function _fire()
        if fired then return end
        fired = true
        finishCall()
    end
    if n == 0 then
        _fire()
        return
    end
    local done = 0
    local started = false
    local function _one()
        done = done + 1
        if started and done >= n then
            _fire()
        end
    end
    for _, tw in ipairs(tweens) do
        tw:OnComplete(_one)
    end
    started = true
    if done >= n then
        _fire()
    end
    -- 兜底：确保即便某些 tween 异常被 Kill 也能继续，避免自动排布卡死。
    gs.DT.DOTween:Sequence():AppendInterval(GAME_ANIM_WAIT_FALLBACK):AppendCallback(_fire)
end

function promoteAllGroupsIfEmpty(self)
    if not self.mSlotItem then
        return
    end
    for g = 1, #self.mSlotItem do
        self:promoteLayer2IfEmpty(g)
    end
end

-- 说明：玩法初始化占位，每次进入/重玩都会调用，负责重建格子与物品。
function initGameData(self)
    self.mGMInfo:SetActive(false)
    -- 说明：无论首次进入、重开还是下一关，都先把分数与运行状态复位，
    -- 避免上一局残留（尤其是 isEnd 残留会导致无法再次结算、updateGame 被拦截）。
    self.mScore = 0
    self.isEnd = false
    self.canRun = false
    self.isPasue = false
    self.isPlaying = false
    self.isFirstFinish = false
    -- 说明：复位“等待分数飘字结束后结算”相关状态，并清掉可能残留的兜底超时回调，
    --       避免上一局残留导致本局 onGameEnd 被提前挂起或兜底误触发。
    if self.mEndFallbackSn then
        self:clearTimeout(self.mEndFallbackSn)
    end
    self.mEndFallbackSn = nil
    self.mPendingScoreFly = 0
    self.mPendingEndReason = nil
    self.mReachedTarget = false  -- 说明：复位“达标自动暂停”触发标志，使新一局可再次首次达标触发。
    self.mDragItem = nil
    -- 说明：GM 自动排布状态复位（防止上一局残留导致下一局“开始自动”被守卫拦截无法启动）。
    self.mGMAutoPlaying = false
    self.mGMAutoStop = false
    self.mGMAutoRunning = false
    -- 说明：连击 combo 状态复位（窗口计数 / 计时 / 时长）。
    self.comboCount = 0
    self.comboCurTime = 0
    self.comboTimeLimit = GAME_COMBO_TIME_LIMIT
    -- 说明：从关卡玩法配置读取目标分数（与 build 一致：DropGameDataVo.targetScore）。
    local gameDataVo = drop.DropManager:getDupConfig(self.dupId)
    self.mTargetScore = gameDataVo and gameDataVo.targetScore or 0
    -- 说明：用配置表 clear_data 的 copy_param 驱动玩法参数（类型数/层数/物品数/第一层占比），
    --       覆盖顶部默认常量（local，本文件玩法函数闭包共享，重赋值后 createGameGroup/createGameItems/assignGroupTypes 等均生效）。
    local cp = gameDataVo and gameDataVo.copyParam
    if cp and #cp >= 4 then
        GAME_ITEM_TYPE_COUNT = cp[1]
        GAME_LAYER_COUNT = cp[2]
        GAME_ITEM_COUNT = cp[3]
        GAME_LAYER1_RATIO = cp[4]
    end
    -- 说明：先回收上一次残留的格子与物品（首次进入时列表为空，无副作用）。
    self:clearAllGameItem()
    -- 说明：重建 12 组 × 3 单格的格子结构。
    self:createGameGroup()
    -- 说明：随机但较为平均地把固定个数的 mGameItem 散布到各 single 节点。
    -- GAME_ITEM_COUNT 为固定生成数量（见文件顶部常量）。
    self:createGameItems(GAME_ITEM_COUNT)
    -- 说明：初始化局内分数显示（重玩时归零显示）。
    self:refreshScore()
    -- 说明：游戏时长使用配置表 clear_data 的 time 字段（秒）；未配置或 ≤0 时兜底 4 分钟（240 秒）。
    -- 时间到由 updateGame 触发 onGameEnd，并在其内部按 mScore >= mTargetScore 判定达标。
    self.gameEndTime = (gameDataVo and gameDataVo.time and gameDataVo.time > 0) and gameDataVo.time or (4 * 60)
    self.gameCurTime = 0
    if self.mTxtTime then
        -- 倒计时格式：超过 60 秒显示 x分y秒（如 1分50秒），不足显示 x秒
        self.mTxtTime.text = TimeUtil.getHMSByTime_1(self.gameEndTime)
    end
    if self.mSliderTimerBg and self.mSliderTimer then
        gs.TransQuick:SizeDelta01(self.mSliderTimer, (self.mSliderTimerBg.sizeDelta.x - 8) * 1)
    end
    if self.mTxtTargetGame then
        self.mTxtTargetGame.text = self.mTargetScore
    end
    -- 说明：初始隐藏 combo 连击 UI（首次消除时才显示）。
    self:showComboUI(false)
end

function showPanel(self)
    if self.gameSn ~= nil then
        LoopManager:removeFrameByIndex(self.gameSn)
        self.gameSn = nil
    end
    self.canRun = true
    self.isPlaying = true   -- 游戏会话开始，倒计时此后即使暂停也继续流逝
    -- 说明：游戏正式开始后才显示 GM 调试信息。
    if self.mGMInfo then
        self.mGMInfo:SetActive(GameManager.IS_DEBUG)
    end
    self.gameSn = LoopManager:addFrame(0, 0, self, self.updateGame)
end

function updateGame(self)
    -- 说明：倒计时与 combo 连击计时即使暂停也继续流逝（时间流失与暂停无关），只要游戏会话进行中且未结算。
    if self.isPlaying and not self.isEnd then
        self:updateGameTimer()
        self:updateComboTimer()
    end
    -- 说明：暂停 / 结算 / 未正式运行时不处理玩法逻辑（拖拽等）。
    if self.isPasue or self.isEnd or not self.canRun then
        return
    end
end

-- 说明：combo 连击窗口计时。窗口内再次消除得分翻倍；超时时隐藏 UI 并归零。
-- 与主倒计时一致：暂停时也继续流逝（时间流失与暂停无关），故放在 updateGame 的 isPlaying 守卫内、不受 isPasue 拦截。
function updateComboTimer(self)
    if self.comboCount <= 0 then
        return
    end
    self.comboCurTime = self.comboCurTime + gs.Time.deltaTime
    local comboRem = gs.Mathf.Clamp(math.ceil(self.comboTimeLimit - self.comboCurTime), 0, self.comboTimeLimit)
    if self.mTxtComboTime then
        -- combo 倒计时同样用中文分秒格式（最大 10 秒，始终显示 x秒）
        self.mTxtComboTime.text = TimeUtil.getFormatTimeBySeconds_14(comboRem)
    end
    if self.mComboSliderTimerBgT and self.mComboSliderTimerT then
        gs.TransQuick:SizeDelta01(self.mComboSliderTimerT,
            (self.mComboSliderTimerBgT.sizeDelta.x - 8) * (self.comboTimeLimit - self.comboCurTime) / self.comboTimeLimit)
    end
    if self.comboCurTime >= self.comboTimeLimit then
        -- 超时：隐藏 combo UI，连击次数归 0。
        self.comboCount = 0
        self:showComboUI(false)
    end
end

-- 说明：倒计时刷新（每秒更新文本与进度条），时间到则结算。暂停时仍会继续流逝，故时间到即使处于暂停中也直接结算。
function updateGameTimer(self)
    -- 说明：倒计时（参考 mole），游戏结束时由 onGameEnd 判定分数是否达标。
    self.gameCurTime = self.gameCurTime + gs.Time.deltaTime
    local remTime = gs.Mathf.Clamp(math.ceil(self.gameEndTime - self.gameCurTime), 0, self.gameEndTime)
    if self.mTxtTime then
        -- 倒计时格式：超过 60 秒显示 x分y秒（如 1分50秒），不足显示 x秒
        self.mTxtTime.text = TimeUtil.getFormatTimeBySeconds_14(remTime)
    end
    if self.mSliderTimerBg and self.mSliderTimer then
        gs.TransQuick:SizeDelta01(self.mSliderTimer,
            (self.mSliderTimerBg.sizeDelta.x - 8) * (self.gameEndTime - self.gameCurTime) / self.gameEndTime)
    end

    if self.gameCurTime >= self.gameEndTime then
        self.gameCurTime = self.gameEndTime
        if self.mTxtTime then
            self.mTxtTime.text = TimeUtil.getFormatTimeBySeconds_14(0)
        end
        if self.mSliderTimerBg and self.mSliderTimer then
            gs.TransQuick:SizeDelta01(self.mSliderTimer, 0)
        end
        -- 时间到：交给 onGameEnd 按 mScore >= mTargetScore 判定胜负并弹出结算。
        self:onGameEnd("时间到")
    end
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

-- 说明：生成 12 组 mGroupItem，每组内再生成 3 个 mSingleItem。
-- mGroupItem / mSingleItem 均为 prefab 顶层模板节点，分别克隆到 mGameGroup 与对应 group 下。
-- SimpleInsItem:create 会自动激活克隆体并隐藏源模板，故无需手动处理模板显隐。
function createGameGroup(self)
    self.mGroupItemList = {}
    -- 说明：组随机；每个随机组内固定禁用第 1、3 位的格子（不再固定第 5、12 组，但保留“每组锁1、3”的结构）。
    self.mBlockSlotMap = {}
    local groupSeq = {}
    for g = 1, 12 do
        table.insert(groupSeq, g)
    end
    self:shuffleArray(groupSeq)
    local blockGroupCount = 2   -- 随机选 2 个组
    for k = 1, blockGroupCount do
        local g = groupSeq[k]
        -- 组内禁用格固定为第 1、3 位（每组 2 格）。
        self.mBlockSlotMap[g] = { [1] = true, [3] = true }
    end
    -- 说明：建立“single 的 GameObject 实例ID 到 槽位”的映射，供拖拽落点时向上回溯命中。
    self.mSingleGoMap = {}
    for i = 1, 12 do
        local groupItem = SimpleInsItem:create(self.mGroupItem, self.mGameGroup, "mGroupItem")
        local singleList = {}
        for j = 1, 3 do
            -- mSingleItem 为顶层模板，克隆后挂到当前 group 下。
            local singleItem = SimpleInsItem:create(self.mSingleItem, groupItem:getTrans(), "mSingleItem")
            singleItem:getChildGO("mTxtIndex"):GetComponent(ty.Text).text = i .. "." .. j
            -- 说明：初始隐藏该 single 的选中高亮 mSelect，仅在拖拽释放到该格时显示。
            local sel = singleItem:getChildGO("mSelect")
            if sel then
                sel:SetActive(false)
            end
            local isNot = singleItem:getChildGO("mIsNot")
            if isNot then
                isNot:SetActive(self:isBlockedSlot(i, j))
            end
            table.insert(singleList, singleItem)
            self.mSingleGoMap[singleItem:getGo():GetInstanceID()] = { g = i, s = j }
        end
        table.insert(self.mGroupItemList, {
            index = i,
            item = groupItem,
            singleList = singleList
        })
    end
end

function isBlockedSlot(self, g, s)
    return self.mBlockSlotMap and self.mBlockSlotMap[g] and self.mBlockSlotMap[g][s] == true
end

-- 说明：被禁用的组（slots 1、3 在 mBlockSlotMap 中禁用）只有“中间槽位”可放物。
-- 当中间槽位也已无任何物体（无第 1 层、也无更深层“后续物体”）时，把它也按禁用格逻辑处理：
--   · 记入 mBlockSlotMap，使 isBlockedSlot 随即返回 true（isFullGroup / 死局判定等下游自然生效）；
--   · 刷新 mIsNot 禁用指示，使该组整体表现为“全禁用”。
-- 该函数仅在棋盘状态变更（消除/落子/下沉）后调用，且一旦标记即永久（禁用格不会再生新物体）。
function refreshBlockedMiddleSlots(self)
    if not self.mBlockSlotMap or not self.mSlotItem or not self.mGroupItemList then
        return
    end
    for g, slots in pairs(self.mBlockSlotMap) do
        local gData = self.mGroupItemList[g]
        if gData and self.mSlotItem[g] then
            -- 中间槽位：single 数量为奇数时取正中（3 个时即第 2 个）。
            local mid = math.ceil(#gData.singleList / 2)
            -- 仅当中间槽位尚未被标记、且确实无任何层物体时才按禁用处理。
            if not slots[mid] then
                local hasItem = false
                for L = 1, GAME_LAYER_COUNT do
                    if self.mSlotItem[g][mid][L] then
                        hasItem = true
                        break
                    end
                end
                if not hasItem then
                    slots[mid] = true
                    -- 刷新禁用指示（与 createGameGroup 中初始化一致）。
                    local isNot = gData.singleList[mid]:getChildGO("mIsNot")
                    if isNot then
                        isNot:SetActive(true)
                    end
                end
            end
        end
    end
end

-- 说明：判断某组是否“完整可用”（所有 single 均非禁用）。自动排列时优先把物体移向这类组。
function isFullGroup(self, g)
    if not self.mGroupItemList or not self.mGroupItemList[g] then
        return false
    end
    local list = self.mGroupItemList[g].singleList
    for s = 1, #list do
        if self:isBlockedSlot(g, s) then
            return false
        end
    end
    return true
end

-- 说明：随机生成固定个数的 mGameItem 插入各 single 节点，并按层分布（保持堆叠关系）。
-- 策略：
--  1) 总数规整为 3 的倍数，保证每种类型总数都是 3 的倍数；
--  2) 第一层数量由玩法配置 GAME_LAYER1_RATIO（占总数百分比）决定，且不超过可用槽位数，规整为 3 的倍数；
--  3) 第二层（及更深）为组级别生成：只要某组在“下一层”至少有 1 个物体（无论落在哪个槽位），
--     该组的所有可用槽位都可以继续加深，满足原始规则“一组中有至少 1 个物体就可以有第二层”；
--     允许悬空（某槽位没有第 1 层而直接有第 2 层）。可点击性保持原始规则——只有“第 1 层”物体
--     可被点击/拖动（悬空物体不可点，这是正确的）；当第二层因下沉（promoteLayer2IfEmpty）移动
--     到第一层后，refreshSlotDraggable 会把它变成可点击，即“第二层移动到第一层时可点击”；
--     逐层进行，直到总数达到 count 或达到最大层数 GAME_LAYER_COUNT；
--  4) 类型分配保证：单个 mGroupItem 内任意类型 ≤ 2 个（即不同时存在 3 个相同类型），且每种类型总数为 3 的倍数。
function createGameItems(self, count)
    if not count or count <= 0 then
        return
    end
    self.mGameItemList = {}
    local groupCount = #self.mGroupItemList
    if groupCount <= 0 then
        return
    end
    local singleCount = #self.mGroupItemList[1].singleList
    if singleCount <= 0 then
        return
    end

    -- 说明：建立“组->单格->层->物体”的逻辑槽位表，拖拽交换/下沉都依赖它。
    self.mSlotItem = {}
    for g = 1, groupCount do
        self.mSlotItem[g] = {}
        for s = 1, singleCount do
            self.mSlotItem[g][s] = {}
        end
    end

    -- 说明：规整为 3 的倍数，确保后续每种类型数量均为 3 的倍数。
    count = math.floor(count / 3) * 3
    if count <= 0 then
        return
    end

    -- 1) 收集所有可用槽位（排除禁用格），并打乱。
    local avail = {}
    for g = 1, groupCount do
        for s = 1, singleCount do
            if not self:isBlockedSlot(g, s) then
                table.insert(avail, { g = g, s = s })
            end
        end
    end
    self:shuffleArray(avail)
    local availCount = #avail

    -- 2) 计算第一层目标数量：玩法配置百分比 GAME_LAYER1_RATIO × 总槽位数（groupCount×singleCount，即 12×3），
    --    且不超过“可用槽位数”（每个可用槽位最多放 1 个第一层物体），并规整为 3 的倍数。
    --    第二层（及更深）为组级别生成：只要组内有 ≥1 个第一层物体，该组所有可用槽位都可加深。
    local layer1Target = math.floor(groupCount * singleCount * GAME_LAYER1_RATIO / 3) * 3
    -- 说明：保证“每组至少 1 个第一层”，故下限提到 groupCount（受可用槽位数限制）。
    layer1Target = math.max(layer1Target, math.min(groupCount, availCount))
    layer1Target = math.min(layer1Target, availCount)

    self.mGroupLayerFlag = {}
    local groupLayerSingles = {}
    for g = 1, groupCount do
        groupLayerSingles[g] = {}
        self.mGroupLayerFlag[g] = {}
    end

    local depth = {}
    for _, ref in ipairs(avail) do
        depth[ref.g .. "_" .. ref.s] = 0
    end

    -- 2.1) 先保证每组至少 1 个第一层，再用剩余配额随机铺满（每个可用槽位至多 1 个）。
    local remain = count
    local placed = 0
    local usedKey = {}
    local groupDone = {}
    -- 2.1.1) 第一轮：按打乱顺序给每个尚未放过的组放 1 个第一层（avail 已打乱，等效随机）。
    for _, ref in ipairs(avail) do
        if placed >= layer1Target then
            break
        end
        local key = ref.g .. "_" .. ref.s
        if not groupDone[ref.g] and not usedKey[key] then
            groupLayerSingles[ref.g][1] = groupLayerSingles[ref.g][1] or {}
            table.insert(groupLayerSingles[ref.g][1], ref.s)
            self.mGroupLayerFlag[ref.g][1] = true
            depth[key] = 1
            usedKey[key] = true
            groupDone[ref.g] = true
            remain = remain - 1
            placed = placed + 1
        end
    end
    -- 2.1.2) 第二轮：剩余额度铺到其余未使用的可用槽位。
    for _, ref in ipairs(avail) do
        if placed >= layer1Target then
            break
        end
        local key = ref.g .. "_" .. ref.s
        if not usedKey[key] then
            groupLayerSingles[ref.g][1] = groupLayerSingles[ref.g][1] or {}
            table.insert(groupLayerSingles[ref.g][1], ref.s)
            self.mGroupLayerFlag[ref.g][1] = true
            depth[key] = 1
            usedKey[key] = true
            remain = remain - 1
            placed = placed + 1
        end
    end

    -- 2.2) 组级别加深（允许悬空）：只要某组 g 在“第 L-1 层”至少有 1 个物体，
    --      该组的所有可用槽位都可以生成第 L 层——即满足“一组中有至少 1 个物体就可以有第二层”的原始规则。
    --      注意：某槽位可能因此没有第 1 层而直接拥有第 2 层（悬空），但只要该槽位“最外层（最小 layer）”
    --      物体可被点击/拖动（见 refreshSlotDraggable），悬空物体即可正常操作；被拖走后由
    --      promoteSingleIfEmpty / promoteLayer2IfEmpty 把剩余深层压实到可见层，不会卡死。
    --      逐层进行，直到总数达到 count 或达到最大层数 GAME_LAYER_COUNT。
    local groupHasLayer = {}
    for g = 1, groupCount do
        groupHasLayer[g] = {}
    end
    for _, ref in ipairs(avail) do
        if depth[ref.g .. "_" .. ref.s] >= 1 then
            groupHasLayer[ref.g][1] = true
        end
    end
    local L = 2
    while remain > 0 and L <= GAME_LAYER_COUNT do
        local added = 0
        for g = 1, groupCount do
            if groupHasLayer[g][L - 1] then
                for s = 1, singleCount do
                    if remain <= 0 then
                        break
                    end
                    if not self:isBlockedSlot(g, s) and depth[g .. "_" .. s] < L then
                        groupLayerSingles[g][L] = groupLayerSingles[g][L] or {}
                        table.insert(groupLayerSingles[g][L], s)
                        self.mGroupLayerFlag[g][L] = true
                        depth[g .. "_" .. s] = L
                        groupHasLayer[g][L] = true
                        remain = remain - 1
                        added = added + 1
                    end
                end
            end
        end
        if added == 0 then
            break
        end
        L = L + 1
    end

    -- 3) 为每个 group 分配类型（满足每类型 3 的倍数、单组内同类型 ≤ 2）。
    --    关键：每种类型数量必须是 3 的倍数（否则会出现“永远消不完整”的残留），故先按 3 步长均摊 typeCounts。
    local typeCounts = self:buildBalancedTypeCounts(count, GAME_ITEM_TYPE_COUNT)
    local groupTypes = self:assignGroupTypes(groupCount, groupLayerSingles, typeCounts)

    -- 4) 实例化 mGameItem 并落位（位置归零，不同层沿 y 偏移）。
    -- 说明：为了让“第 1 层”的物体显示在“最前面”，按层从大到小实例化，
    --      使第 1 层最后成为所在 single 的最后一个子节点（uGUI 后绘制的 sibling 显示在最上层）；
    --      并对第 1 层再次显式 SetAsLastSibling 加固，确保始终绘制在最前面。
    for g = 1, groupCount do
        local types = groupTypes[g]
        if types then
            local posIdx = 1
            for L = GAME_LAYER_COUNT, 1, -1 do
                local chosen = groupLayerSingles[g][L]
                if chosen then
                    for _, s in ipairs(chosen) do
                        local typeId = types[posIdx]
                        posIdx = posIdx + 1
                        local single = self.mGroupItemList[g].singleList[s]
                        local gameItem = SimpleInsItem:create(self.mGameItem, single:getTrans(), "mGameItem")
                        -- 复用时清空上一生命周期的销毁标记/定时器，避免不回收。
                        gameItem.mIsDestroying = false
                        gameItem.mDestroySn = nil
                        gameItem:setPos(0, (L - 1) * GAME_LAYER_GAP)
                        gameItem.typeId = typeId
                        gameItem.groupIdx = g
                        gameItem.singleIdx = s
                        gameItem.layer = L
                        -- 第 1 层：强制置为所在 single 的最后一个子节点，确保绘制在最前面。
                        if L == 1 then
                            gameItem:getTrans():SetAsLastSibling()
                        end
                        -- 说明：类型对应 icon 从配置表 clear_icon_data 取（DropManager 已解析为 DropItemDataVo.icon），不再手写 "drop/icon_<typeId>.png"。
                        local dropItemData = drop.DropManager:getDropItemData(typeId)
                        local iconName = (dropItemData and dropItemData.icon) or ("icon_" .. typeId .. ".png")
                        local iconPath = UrlManager:getIconPath("drop/" .. iconName)
                        local img = gameItem:getGo():GetComponent(ty.AutoRefImage)
                        img:SetImg(iconPath, false)
                        -- 说明：按层级设置透明度（第 1 层 1.0，第 2 层 0.5，第 3 层及以下不显示）。
                        local alpha = L == 1 and 1 or (L == 2 and 0.5 or 0)
                        local aHex = string.format("%02x", math.floor(alpha * 255 + 0.5))
                        img.color = gs.ColorUtil.GetColor("FFFFFF" .. aHex)
                        -- 说明：记录到逻辑槽位表，并先关闭 raycast（可拖状态由末尾 refreshAllDraggable 统一按“最外层可点”设置）。
                        self.mSlotItem[g][s][L] = gameItem
                        img.raycastTarget = false
                        table.insert(self.mGameItemList, gameItem)
                    end
                end
            end
        end
    end
    -- 统一刷新所有槽位的可点击/拖拽状态：每个槽位“最外层”物体可拖（兼容悬空）。
    self:refreshAllDraggable()
end

-- 说明：为每个 group 分配类型序列。
-- 约束：
--  a) 每种类型总数为 3 的倍数（本例固定 15）；
--  b) 单个 group 内任意类型数量 ≤ 2（即不同时存在 3 个相同类型）。
-- 把总数 count 均摊成 typeCount 种类型的数量：每种都是 3 的倍数，且总和 = count。
-- 这是“完全消除”的必要条件：每种类型必须能凑成若干个 3 连消，否则会留下永远消不掉的残留。
function buildBalancedTypeCounts(self, count, typeCount)
    local typeCounts = {}
    local base = math.floor(count / typeCount / 3) * 3  -- 每种类型基础数量（3 的倍数）
    local remain = count - base * typeCount            -- count 是 3 的倍数，故 remain 也是 3 的倍数
    for t = 1, typeCount do
        typeCounts[t] = base
    end
    local idx = 1
    while remain > 0 do
        typeCounts[idx] = typeCounts[idx] + 3
        remain = remain - 3
        idx = idx + 1
        if idx > typeCount then
            idx = 1
        end
    end
    return typeCounts
end

-- 采用“按组物品数降序、组内按剩余权重随机”的贪心，并带重试以保证一定可行。
function assignGroupTypes(self, groupCount, groupLayerSingles, typeCounts)
    -- 计算每组物品数量。
    local groupCnt = {}
    for g = 1, groupCount do
        local cnt = 0
        for L = 1, GAME_LAYER_COUNT do
            local c = groupLayerSingles[g][L]
            if c then
                cnt = cnt + #c
            end
        end
        groupCnt[g] = cnt
    end

    local maxTry = GAME_TYPE_ALLOC_MAX_TRY
    for attempt = 1, maxTry do
        -- 重置每种类型剩余数量。
        local typeRemain = {}
        for t = 1, GAME_ITEM_TYPE_COUNT do
            typeRemain[t] = typeCounts[t]
        end

        -- 组按物品数降序处理，大组优先消耗类型，更易均衡。
        local order = {}
        for g = 1, groupCount do
            table.insert(order, { g = g, cnt = groupCnt[g] })
        end
        table.sort(order, function(a, b)
            return a.cnt > b.cnt
        end)

        local ok = true
        local groupTypes = {}
        for _, o in ipairs(order) do
            local g = o.g
            local cnt = o.cnt
            local gt = {}
            for t = 1, GAME_ITEM_TYPE_COUNT do
                gt[t] = 0
            end
            local types = {}
            local done = true
            for k = 1, cnt do
                -- 候选类型：剩余 > 0 且本组该类型 < 2。
                local cand = {}
                local candWeight = {}
                local sumW = 0
                for t = 1, GAME_ITEM_TYPE_COUNT do
                    if typeRemain[t] > 0 and gt[t] < GAME_MAX_SAME_TYPE_PER_GROUP then
                        table.insert(cand, t)
                        local w = typeRemain[t]
                        table.insert(candWeight, w)
                        sumW = sumW + w
                    end
                end
                if #cand == 0 then
                    done = false
                    break
                end
                -- 按剩余权重随机选一个类型。
                local r = math.random(sumW)
                local pick = cand[1]
                local acc = 0
                for i = 1, #cand do
                    acc = acc + candWeight[i]
                    if r <= acc then
                        pick = cand[i]
                        break
                    end
                end
                gt[pick] = gt[pick] + 1
                typeRemain[pick] = typeRemain[pick] - 1
                table.insert(types, pick)
            end
            if not done then
                ok = false
                break
            end
            groupTypes[g] = types
        end

        if ok then
            -- ok 为真时所有物品已分配完（总数 = 各类型 typeCounts 之和），每种类型必恰好用完（且都是 3 的倍数）。
            return groupTypes
        end
    end

    -- 兜底：按 typeCounts 精确装箱后整体洗牌分配，保证每种类型数量严格等于 typeCounts（仍为 3 的倍数），
    --       绝不因轮转分配而破坏“完全消除”的必要条件；单组同类型 ≤ 2 的约束无法保证时退化为不保证（可接受）。
    local bag = {}
    for t = 1, GAME_ITEM_TYPE_COUNT do
        for _ = 1, typeCounts[t] do
            table.insert(bag, t)
        end
    end
    for i = #bag, 2, -1 do
        local j = math.random(i)
        bag[i], bag[j] = bag[j], bag[i]
    end
    local bi = 1
    local groupTypes = {}
    for g = 1, groupCount do
        local cnt = groupCnt[g]
        local types = {}
        for k = 1, cnt do
            table.insert(types, bag[bi])
            bi = bi + 1
        end
        groupTypes[g] = types
    end
    return groupTypes
end

-- 说明：为某个 mGameItem 挂载第一层拖拽事件（可重复调用，先清后挂，幂等）。
-- 仅第一层物体需要拖拽；下沉（第二层->第一层）后也会调用本函数为新第一层物体挂事件。
function addDragToItem(self, gameItem)
    local go = gameItem:getGo()
    local trigger = go:GetComponent(ty.LongPressOrClickEventTrigger)
    if not trigger then
        trigger = gs.GoUtil.AddComponent(go, ty.LongPressOrClickEventTrigger)
    end
    trigger.onBeginDrag:RemoveAllListeners()
    trigger.onEndDrag:RemoveAllListeners()

    trigger.onBeginDrag:AddListener(function()
        self:onItemBeginDrag(gameItem)
    end)
    trigger.onEndDrag:AddListener(function()
        self:onItemEndDrag(gameItem)
    end)
end

-- 说明：开始拖拽第一层物体。临时挂到面板根节点并跟随指针，关闭自身射线避免遮挡落点检测。
function onItemBeginDrag(self, item)
    if self.isEnd or self.isPasue then
        return
    end
    AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_drop_1.prefab")
    self.mDragItem = item
    -- 说明：记录抓取瞬间“物品中心与鼠标的世界坐标偏移”，拖拽中保持该偏移，
    --       使物体相对鼠标的相对位置不变（不再以中心强行吸附到光标，消除起手跳动与持续偏移）。
    local mp = gs.Input.mousePosition
    local grabWorld = gs.CameraMgr:ScreenToWorldByUICamera(gs.Vector3(mp.x, mp.y, mp.z))
    local itemWorld = item:getTrans().position
    self.mDragOffset = gs.Vector3(itemWorld.x - grabWorld.x, itemWorld.y - grabWorld.y, 0)
    -- 拖动过程中：显示被拖物体所在 single 的选中高亮（松开时再隐藏）。
    self:showSelectSingle(item.groupIdx, item.singleIdx)
    item.mImg = item:getGo():GetComponent(ty.AutoRefImage)
    item.mImg.raycastTarget = false
    -- 临时挂到更靠近世界原点的父节点（UIRootNode.parent）并置顶，避免被同 single 深层遮挡，
    -- 同时保证 TransQuick:PosXY 写入的本地坐标与世界坐标近似一致，物体才能贴合鼠标。
    local dragParent = self.UIRootNode.parent or self.UIRootNode
    item:getTrans():SetParent(dragParent, false)
    item:getTrans():SetAsLastSibling()
    -- 立即跟随到指针（保持偏移，避免起手瞬间的跳动）。
    self:onItemDragUpdate()
    self.mDragSn = LoopManager:addFrame(1, 0, self, self.onItemDragUpdate)
end

-- 说明：拖拽中逐帧让物体跟随指针。
-- 沿用本工程已验证的写法（HeroSkillEditPanel / FormationVisionPanel）：
--   1) ScreenToWorldByUICamera(含 z 的 Vector3) 取鼠标在世界坐标（注意不能用 ScreenToWorldByUICamera2，坐标空间不同会偏移）；
--   2) TransQuick:PosXY 直接写世界坐标。因物体已挂到世界原点附近的父节点，视觉即贴合鼠标。
function onItemDragUpdate(self)
    if not self.mDragItem then
        return
    end
    local mp = gs.Input.mousePosition
    local screenPos = gs.Vector3(mp.x, mp.y, mp.z)
    local worldPos = gs.CameraMgr:ScreenToWorldByUICamera(screenPos)
    -- 说明：保持抓取瞬间的偏移，使物体相对鼠标的相对位置不变（抓取点始终在光标下）。
    local off = self.mDragOffset or gs.Vector3(0, 0, 0)
    gs.TransQuick:PosXY(self.mDragItem:getTrans(), worldPos.x + off.x, worldPos.y + off.y)
    -- 拖拽过程中：高亮跟随鼠标所在的 mSingleItem（无命中则全部隐藏）。
    local t = self:findTargetSingle()
    if t then
        self:showSelectSingle(t.g, t.s)
    else
        self:showSelectSingle(nil, nil)
    end
end

-- 说明：结束拖拽，停止跟随并解析落点（交换/放入/放回），最后处理“第一层空了则第二层下沉”。
function onItemEndDrag(self, item)
    -- 说明：若 beginDrag 因暂停/结束提前返回（未真正开始拖拽），这里直接跳过。
    if not self.mDragItem then
        return
    end
    if self.mDragSn then
        LoopManager:removeFrame(self, self.onItemDragUpdate)
        self.mDragSn = nil
    end
    self.mDragItem = nil
    local waitDrop = self:resolveDrop(item, function()
        self:onItemDropSettled(item)
    end)
    -- 拖拽结束：隐藏全部选中高亮 mSelect。
    self:showSelectSingle(nil, nil)
    if not waitDrop then
        self:onItemDropSettled(item)
    end
end

function onItemDropSettled(self, item)
    -- 拖拽结束后统一检查：同组 3 个相同则消除+100 分，并把第二层补充到第一层。
    self:checkMatchAndClear()
    -- 落点后刷新所有槽位的可点击状态（兼容悬空物体下沉后变可拖）。
    self:refreshAllDraggable()
    -- 全部清除时游戏结束。
    self:checkAllClear()
end

-- 说明：解析拖拽落点。
--  target 为空或落回原 single：放回原第一层位置（无变化）。
--  target single 第一层已有物体：与目标第一层物体“交换位置”。
--  target single 第一层为空：把被拖物体“放入”该第一层位置。
--  解析后：若来源 group 或目标 group 的第一层整体为空，则将其第二层物体下沉到第一层。
function resolveDrop(self, item, finishCall)
    local srcG = item.groupIdx
    local srcS = item.singleIdx
    local target = self:findTargetSingle()
    if not target then
        self:placeItemVisual(item)
        return false
    end
    local tG, tS = target.g, target.s
    if self:isBlockedSlot(tG, tS) then
        self:placeItemVisual(item)
        return false
    end
    if tG == srcG and tS == srcS then
        self:placeItemVisual(item)
        return false
    end
    local targetItem = self.mSlotItem[tG][tS][1]
    if targetItem then
        self:swapItems(item, targetItem, GAME_ANIM_ITEM_DURATION, finishCall)
        return true
    else
        self:moveItemToSlot(item, tG, tS, GAME_ANIM_MOVE_DURATION)
    end
    self:promoteAllGroupsIfEmpty()
    return false
end

-- 说明：遍历所有 group，检查“同组所有 single 第 1 层均存在且 typeId 相同”。
-- 若满足：消除该组第 1 层这些物体、+100 分，并把该组第二层（若有）补充到第一层。
function checkMatchAndClear(self)
    if not self.mSlotItem then
        return
    end
    local groupCount = #self.mSlotItem
    -- 说明：收集每个被消除组首个物品的世界坐标，作为该组分数飘字的独立起点。
    local clearedGroups = {}
    for g = 1, groupCount do
        local singleCount = #self.mGroupItemList[g].singleList
        local matchTypeId = nil
        local allFilled = true
        local matched = true
        local firstItems = {}
        for s = 1, singleCount do
            local it = self.mSlotItem[g][s][1]
            if not it then
                allFilled = false
                break
            end
            firstItems[s] = it
            if matchTypeId == nil then
                matchTypeId = it.typeId
            elseif it.typeId ~= matchTypeId then
                matched = false
            end
        end
        if allFilled and matched and matchTypeId ~= nil then
            -- 说明：飘字起点用“组的正中间”——取该组所有 single（槽位）的世界坐标平均值，
            --       不再用首个被消物品的位置，使飘字居中地出现在整组之上。
            local cx, cy, cz = 0, 0, 0
            for s = 1, singleCount do
                local sp = self.mGroupItemList[g].singleList[s]:getTrans().position
                cx = cx + sp.x
                cy = cy + sp.y
                cz = cz + sp.z
            end
            clearedGroups[#clearedGroups + 1] = gs.Vector3(cx / singleCount, cy / singleCount, cz / singleCount)
            for s = 1, singleCount do
                local it = firstItems[s]
                self.mSlotItem[g][s][1] = nil
                self:recoverGameItem(it)
            end
            -- 消除后该组第一层整体为空，把第二层补充到第一层（并补挂拖拽事件）。
            self:promoteLayer2IfEmpty(g)
        end
    end
    -- 说明：本次有消除发生时，逐组处理连击 combo 与计分（每组独立飘字）。
    if #clearedGroups > 0 then
         AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_drop_2.prefab")
        self:onClearHappened(clearedGroups)
    end
    self:refreshScore()
end

-- 说明：发生消除时处理连击 combo 与计分。
-- 首次消除（comboCount==0）：每组基准分 100，显示 x1。
-- 窗口内再次消除（comboCount>0）：每组得分翻倍（×2，即 200），显示 xN（N 为本次累计后的连击数）。
function onClearHappened(self, groups)
    -- 说明：本次同时消除 groups 组。所有组共用同一 combo 状态：
    -- 窗口内再次消除（comboCount>0）则每组得分翻倍；否则每组基准分（首次=100）。combo 次数逐组累加。
    local perGain
    if self.comboCount > 0 then
        perGain = GAME_CLEAR_SCORE * GAME_COMBO_SCORE_MULTIPLY
    else
        perGain = GAME_CLEAR_SCORE
    end
    -- 每组消除独立生成飘字，动画结束后再各自加分（总分与原公式一致）。
    for i = 1, #groups do
        self:spawnScoreFly(perGain, groups[i])
        self.comboCount = self.comboCount + 1
    end
    -- 说明：必须在累加完本次所有组连击数之后再显示 combo UI，
    --       否则首次消除时 comboCount 仍为 0 会显示“x0”；现在首次即显示“x1”。
    -- 重置 combo 窗口并开始/刷新倒计时（进度条置满）。
    self.comboCurTime = 0
    self:showComboUI(true)
end

-- 说明：生成分数飘字动画——从被消除物品位置飘向 mTxtCurrentGame，
-- 动画结束后才把本次得分累加进 mScore 并刷新显示（避免分数“提前跳动”）。
function spawnScoreFly(self, gain, fromWorldPos)
    -- 说明：本次飘字即将播放，计数 +1；onDone 时 -1。计数归零且正处在“等待分数加完再结算”时，触发真正结算。
    self.mPendingScoreFly = (self.mPendingScoreFly or 0) + 1

    -- 说明：飘字挂到与 mGameGroup（棋盘容器）同级的根节点下，并置顶，
    -- 保证分数飘字渲染在 mGameItem（棋盘格子）之上。mGameGroup 不存在时退回分数文本父节点。
    -- 说明：飘字必须挂在比 mGameItem 动画置顶层更高（或同级最后）的节点，才能确保始终
    -- 显示在 mGameItem 之上。mGameItem 在拖拽(beginDrag)/移动·下沉(placeItemVisual)动画时，
    -- 会临时 SetParent(self.UIRootNode.parent) 并 SetAsLastSibling 置顶（见 816/1165 行）；
    -- 该 UIRootNode.parent 是面板根的父、层级高于 mScoreItemMoveContent 等面板内节点。
    -- 故飘字同样挂 UIRootNode.parent 并 SetAsLastSibling，任何时刻都绘制在 mGameItem 之上。
    -- 兜底：mScoreItemMoveContent / mGameItemMoveContent / mGameGroup.parent / mTxtCurrentGame.parent。
    local flyParent = (self.UIRootNode and self.UIRootNode.parent) or self.mScoreItemMoveContent
        or self.mGameItemMoveContent or (self.mGameGroup and self.mGameGroup.parent)
        or self.mTxtCurrentGame.transform.parent
    local item = SimpleInsItem:create(self.mScoreItem, flyParent, "mScoreItem")

    local cloneGo = item:getGo()
    -- 置顶：在 flyParent 下排到最后一个（同级最后 = 渲染层级最上），显示在 mGameItem 之前。
    cloneGo.transform:SetAsLastSibling()
    local scoreRect = self.mTxtCurrentGame.transform
    local cloneRect = cloneGo:GetComponent(ty.RectTransform)
    local cloneText = item:getChildGO("mTxtScore"):GetComponent(ty.Text)
    cloneText.text = gain

    -- 起点：被消物品世界坐标 -> 飘字父节点本地坐标。
    local localV3 = flyParent:InverseTransformPoint(fromWorldPos)
    cloneRect.anchoredPosition = gs.Vector2(localV3.x, localV3.y)
    -- 终点：分数文本世界位置 -> 同一父节点本地坐标，飘到后融入分数。
    local endV3 = flyParent:InverseTransformPoint(scoreRect.position)
    local endPos = gs.Vector2(endV3.x, endV3.y)
    local tween = cloneRect:DOMoveUI(endPos, GAME_ANIM_FLOAT_DURATION)
    local function onDone()
        if not gs.GoUtil.IsGoNull(cloneGo) then
            item:recover()
        end
        if self.mTxtCurrentGame and not gs.GoUtil.IsGoNull(self.mTxtCurrentGame.gameObject) then
            self.mScore = self.mScore + gain
            self:refreshScore()
        end
        -- 说明：本次飘字加分完成，计数 -1；全部飘字结束且正等待结算时，触发真正结算（此时 mScore 才是真实得分）。
        self.mPendingScoreFly = (self.mPendingScoreFly or 0) - 1
        if self.mPendingScoreFly <= 0 then
            self.mPendingScoreFly = 0
            if self.mEndFallbackSn then
                self:clearTimeout(self.mEndFallbackSn)
                self.mEndFallbackSn = nil
            end
            if self.mPendingEndReason then
                local r = self.mPendingEndReason
                self.mPendingEndReason = nil
                self:onGameEndDo(r)
            end
        end
    end
    if tween then
        tween:OnComplete(onDone)
    else
        onDone()
    end
end

-- 说明：显示/隐藏 combo 连击 UI（背景条、进度条、剩余秒数、x 次数）。
function showComboUI(self, active)
    if self.mComboSliderTimerBg then
        self.mComboSliderTimerBg:SetActive(active)
    end
    if self.mComboSliderTimer then
        self.mComboSliderTimer:SetActive(active)
    end
    if self.mComboSliderTimerBgT and self.mComboSliderTimerT then
        gs.TransQuick:SizeDelta01(self.mComboSliderTimerT,
            active and (self.mComboSliderTimerBgT.sizeDelta.x - 8) * 1 or 0)
    end
    if self.mTxtComboTime then
        self.mTxtComboTime.gameObject:SetActive(false)
    end
    if self.mTxtCombo then
        self.mTxtCombo.gameObject:SetActive(active)
        if active then
            self.mTxtCombo.text = "X" .. self.comboCount
        end
    end
end

-- 说明：回收单个 gameItem（poolRecover 并从列表移除，避免重玩时重复回收报错）。
function recoverGameItem(self, item)
    -- 已经处于销毁特效播放中，避免重复处理
    if item.mIsDestroying then
        return
    end
    item.mIsDestroying = true
    if item.mMoveTween then
        item.mMoveTween:Kill()
        item.mMoveTween = nil
    end
    if item.mAlphaTween then
        item.mAlphaTween:Kill()
        item.mAlphaTween = nil
    end
    if self.mGameItemList then
        for i = #self.mGameItemList, 1, -1 do
            if self.mGameItemList[i] == item then
                table.remove(self.mGameItemList, i)
                break
            end
        end
    end
    -- 显示销毁特效，0.7 秒后再回收
    self:playGameItemDestroyEffect(item)
end

-- 播放 mGameItem 的销毁特效，延迟 0.7 秒后回收
function playGameItemDestroyEffect(self, item)
    local effGo = item:getChildGO("mEffect")
    if effGo then
        effGo:SetActive(true)
    end
    -- 说明：播放销毁特效时把物品自身（图标）透明度置 0，仅显示爆炸特效，避免本体图标与特效重叠。
    local img = item:getGo():GetComponent(ty.AutoRefImage)
    if not gs.GoUtil.IsCompNull(img) then
        if item.mAlphaTween then
            item.mAlphaTween:Kill()
            item.mAlphaTween = nil
        end
        img.color = gs.ColorUtil.GetColor("FFFFFF00")
    end
    item.mDestroySn = self:setTimeout(GAME_ANIM_DESTROY_DURATION, function()
        item.mDestroySn = nil
        self:removeDestroyingItem(item)
        -- 回收前关闭特效，避免复用后特效残留显示。
        if effGo and not gs.GoUtil.IsGoNull(effGo) then
            effGo:SetActive(false)
        end
        if not gs.GoUtil.IsGoNull(item:getGo()) then
            item:poolRecover()
        end
    end)
    self.mDestroyingItemList = self.mDestroyingItemList or {}
    table.insert(self.mDestroyingItemList, item)
end

-- 从正在播放销毁特效的列表中移除
function removeDestroyingItem(self, item)
    if self.mDestroyingItemList then
        for i = #self.mDestroyingItemList, 1, -1 do
            if self.mDestroyingItemList[i] == item then
                table.remove(self.mDestroyingItemList, i)
                break
            end
        end
    end
end

-- 说明：刷新当前得分显示，并同步达标状态（若已存在对应节点）。
function refreshScore(self)
    if self.mTxtCurrentScore then
        self.mTxtCurrentScore.text = _TT(151209) .. self.mScore
    end
    -- 说明：局内实时分数显示，随分数变化同步刷新。
    if self.mTxtCurrentGame then
        -- 分数增加时播放“先放大再缩小”脉冲动画（重置/归零不触发）。
        if self.mLastShowScore and self.mScore > self.mLastShowScore then
            self:playScorePunch()
        end
        self.mLastShowScore = self.mScore
        self.mTxtCurrentGame.text = self.mScore
    end
    if self.mIsTarget and self.mIsTargetNot then
        self.mIsTarget:SetActive(self.mScore >= self.mTargetScore)
        self.mIsTargetNot:SetActive(self.mScore < self.mTargetScore)
    end
    -- 说明：当前分数“初次”达到目标分数时，自动弹出暂停界面（显示“完成”按钮），
    --       让玩家确认结算；用 mReachedTarget 保证整局只触发一次。
    --       跳过条件：游戏未运行 / 已结束 / 已暂停 / 正在 GM 自动排布（避免打断 debug 流程）。
    if not self.mReachedTarget and self.mScore >= self.mTargetScore
        and self.canRun and not self.isEnd and not self.isPasue
        and not self.mGMAutoRunning then
        self.mReachedTarget = true
        self:onClickPause()
    end
end

-- 说明：分数变化时的“先放大再缩小”脉冲动画（作用于 mTxtCurrentGame）。
-- 复用 playDropPunch 的手感：放大到 1.3 倍（OutSine）再回弹回原大小（OutBack）。
function playScorePunch(self)
    if not self.mTxtCurrentGame then
        return
    end
    local trans = self.mTxtCurrentGame.transform
    if self.mScorePunchTween then
        self.mScorePunchTween:Kill()
        self.mScorePunchTween = nil
    end
    -- 每次都以基准 scale 起步，避免连击快速触发时缩放被累积放大。
    if not self.mScoreBaseScale then
        self.mScoreBaseScale = trans.localScale
    end
    local cur = self.mScoreBaseScale
    trans.localScale = cur
    local big = gs.Vector3(cur.x * 1.3, cur.y * 1.3, cur.z)
    local seq = gs.DT.DOTween.Sequence()
    local t1 = trans:DOScale(big, GAME_ANIM_SCORE_PUNCH_UP)
    t1:SetEase(gs.DT.Ease.OutSine)
    local t2 = trans:DOScale(cur, GAME_ANIM_SCORE_PUNCH_DOWN)
    t2:SetEase(gs.DT.Ease.OutBack)
    seq:Append(t1)
    seq:Append(t2)
    self.mScorePunchTween = seq
    seq:OnComplete(function()
        if self.mScorePunchTween == seq then
            self.mScorePunchTween = nil
        end
        if self.mTxtCurrentGame and not gs.GoUtil.IsGoNull(self.mTxtCurrentGame.gameObject) then
            self.mTxtCurrentGame.transform.localScale = cur
        end
    end)
end

-- 说明：通过 UI 射线找到指针下方属于本棋盘的 single（向上回溯父节点匹配 mSingleGoMap）。
function findTargetSingle(self)
    local mousePos = gs.Input.mousePosition
    local hits = gs.UnityEngineUtil.GetRaycastUIResults(gs.Vector2(mousePos.x, mousePos.y), true)
    if not hits or hits.Count <= 0 then
        return nil
    end
    for i = 0, hits.Count - 1 do
        local go = hits[i].gameObject
        local cur = go
        while cur do
            local id = cur:GetInstanceID()
            if self.mSingleGoMap[id] then
                return self.mSingleGoMap[id]
            end
            cur = cur.transform.parent and cur.transform.parent.gameObject or nil
        end
    end
    return nil
end

-- 说明：单选显示指定 single 的选中高亮 mSelect，并隐藏其余所有 single 的 mSelect。
-- 传入 g/s 为 nil 时表示全部隐藏（如开始新一次拖拽时清除上次选中）。
function showSelectSingle(self, g, s)
    if not self.mGroupItemList then
        return
    end
    for gi = 1, #self.mGroupItemList do
        local list = self.mGroupItemList[gi].singleList
        for si = 1, #list do
            local sel = list[si]:getChildGO("mSelect")
            if sel then
                -- 说明：禁用格（isBlockedSlot）不显示选中高亮。
                sel:SetActive(gi == g and si == s and not self:isBlockedSlot(gi, si))
            end
        end
    end
end

-- 说明：按层级把物体摆回其逻辑槽位（重设父节点、局部坐标、透明度、层级置顶）。
function placeItemVisual(self, item, moveDuration, finishCall, punch)
    local g, s, L = item.groupIdx, item.singleIdx, item.layer
    local single = self.mGroupItemList[g].singleList[s]
    local trans = item:getTrans()
    trans:SetParent(single:getTrans(), true)
    trans:SetAsLastSibling()
    local targetPos = gs.Vector3(0, (L - 1) * GAME_LAYER_GAP, 0)
    if moveDuration and moveDuration > 0 then
        local animParent = self.UIRootNode.parent or self.UIRootNode
        local targetWorldPos = single:getTrans():TransformPoint(targetPos)
        local targetLocalPos = animParent:InverseTransformPoint(targetWorldPos)
        trans:SetParent(animParent, true)
        trans:SetAsLastSibling()
        local tweener = trans:DOLocalMove(targetLocalPos, moveDuration)
        -- 下沉（punch）用 OutBack 回弹增强“砸下去”手感；自动排列/交换等批量移动用 OutSine 平滑归位。
        tweener:SetEase(punch and gs.DT.Ease.OutBack or gs.DT.Ease.OutSine)
        item.mMoveTween = tweener
        tweener:OnComplete(function()
            if item.mMoveTween == tweener then
                item.mMoveTween = nil
            end
            trans:SetParent(single:getTrans(), false)
            trans:SetAsLastSibling()
            item:setPos(0, (L - 1) * GAME_LAYER_GAP)
            if finishCall then
                finishCall()
            end
        end)
    else
        if item.mMoveTween then
            item.mMoveTween:Kill()
            item.mMoveTween = nil
        end
        item:setPos(0, (L - 1) * GAME_LAYER_GAP)
        if finishCall then
            finishCall()
        end
    end
    -- 说明：按层级设置透明度（第 1 层 1.0，第 2 层 0.5，第 3 层及以下不显示），用 tween 平滑过渡。
    local alpha = L == 1 and 1 or (L == 2 and 0.5 or 0)
    self:setItemAlphaTween(item, alpha, GAME_ANIM_ITEM_DURATION)
    -- 说明：仅当下沉（punch=true）时叠加“落位弹一下”缩放脉冲，增强打击感；
    -- 自动排列/交换等批量移动不触发脉冲，避免未移动的物体也原地跳动。
    if moveDuration and moveDuration > 0 and punch then
        self:playDropPunch(item, moveDuration)
    end
end

-- 说明：落位“弹一下”缩放脉冲（下沉/交换归位时增强打击感）：先放大到约 1.18 倍再回弹回原大小。
-- 仅在 placeItemVisual 有移动动画（moveDuration>0）时调用，避免初始生成/瞬移归位时误触发。
function playDropPunch(self, item, moveDuration)
    local trans = item:getTrans()
    if item.mPunchTween then
        item.mPunchTween:Kill()
        item.mPunchTween = nil
    end
    local cur = trans.localScale
    local big = gs.Vector3(cur.x * 1.18, cur.y * 1.18, cur.z)
    local seq = gs.DT.DOTween.Sequence()
    local t1 = trans:DOScale(big, moveDuration * 0.35)
    t1:SetEase(gs.DT.Ease.OutSine)
    local t2 = trans:DOScale(cur, moveDuration * 0.65)
    t2:SetEase(gs.DT.Ease.OutBack)
    seq:Append(t1)
    seq:Append(t2)
    item.mPunchTween = seq
    seq:OnComplete(function()
        if item.mPunchTween == seq then
            item.mPunchTween = nil
        end
    end)
end

-- 说明：把物体移动到指定 group/single/层（清空旧槽、记录新槽、视觉归位）。
function moveItemToSlot(self, item, g, s, L)
    self.mSlotItem[item.groupIdx][item.singleIdx][item.layer] = nil
    item.groupIdx = g
    item.singleIdx = s
    item.layer = L
    self.mSlotItem[g][s][L] = item
    self:placeItemVisual(item)
end

-- 说明：交换两个第一层物体的位置（互不相同的 single 槽位，整体互换逻辑与视觉）。
function swapItems(self, a, b, moveDuration, finishCall)
    local ag, as = a.groupIdx, a.singleIdx
    local bg, bs = b.groupIdx, b.singleIdx
    self.mSlotItem[ag][as][1] = nil
    self.mSlotItem[bg][bs][1] = nil
    self.mSlotItem[bg][bs][1] = a
    a.groupIdx, a.singleIdx, a.layer = bg, bs, 1
    self.mSlotItem[ag][as][1] = b
    b.groupIdx, b.singleIdx, b.layer = ag, as, 1
    if moveDuration and moveDuration > 0 then
        local waitCount = 2
        local function _oneDone()
            waitCount = waitCount - 1
            if waitCount <= 0 then
                self:promoteAllGroupsIfEmpty()
                if finishCall then
                    finishCall()
                end
            end
        end
        self:placeItemVisual(a, moveDuration, _oneDone)
        self:placeItemVisual(b, moveDuration, _oneDone)
    else
        self:placeItemVisual(a)
        self:placeItemVisual(b)
    end
end

-- 说明：组 = 该 group 下的 3 个 single。仅当“整组第 1 层全部为空”时才触发下沉；
-- 下沉时对组内每个 single 做层压缩：原第 2 层补到第 1 层、第 3 层补到第 2 层，更深的依此类推。
-- 位置/透明度(tween)由 placeItemVisual 统一处理；第 1 层才可被拖拽。

-- 该组是否还有正在播放销毁特效（mEffect）的物体。
function isGroupDestroying(self, g)
    if not self.mDestroyingItemList then
        return false
    end
    for i = 1, #self.mDestroyingItemList do
        if self.mDestroyingItemList[i].groupIdx == g then
            return true
        end
    end
    return false
end

function promoteLayer2IfEmpty(self, g)
    if not g or not self.mSlotItem[g] then
        return
    end
    -- 本组刚被消除时，销毁特效（mEffect）还在播放，必须先等特效播完再下沉，
    -- 否则深层物体会瞬间顶上来盖住爆炸特效，造成视觉冲突。
    if self:isGroupDestroying(g) then
        self:setTimeout(GAME_ANIM_DESTROY_DURATION, function()
            self:promoteLayer2IfEmpty(g)
        end)
        return
    end
    local singleCount = #self.mGroupItemList[g].singleList
    -- 组级触发条件：只要该组任一 single 第 1 层还有物体，就不下沉。
    for s = 1, singleCount do
        if self.mSlotItem[g][s][1] then
            return
        end
    end
    -- 整组第 1 层全空，对组内每个 single 做层压缩（顶补）。
    for s = 1, singleCount do
        -- 收集该 single 现有物体，按原层号从小到大。
        local items = {}
        for _, it in pairs(self.mSlotItem[g][s]) do
            table.insert(items, it)
        end
        if #items > 0 then
            table.sort(items, function(a, b) return a.layer < b.layer end)
            -- 清空原层表，重新从层 1 连续排列（仅改逻辑层号，视觉随后统一归位）。
            self.mSlotItem[g][s] = {}
            for newL = 1, #items do
                local it = items[newL]
                it.layer = newL
                self.mSlotItem[g][s][newL] = it
            end
            -- 视觉归位：按层从大到小调用，保证第 1 层最后 SetAsLastSibling（绘制在最前）。
            -- 传入 moveDuration 与 punch=true，使深层“落”到第 1 层时有明显移动 + 回弹 + 缩放脉冲动画。
            for newL = #items, 1, -1 do
                self:placeItemVisual(items[newL], GAME_ANIM_ITEM_DURATION, nil, true)
            end
            -- 下沉后统一刷新该 single 的可拖拽状态（最外层可点，兼容悬空）。
            self:refreshSlotDraggable(g, s)
        end
    end
end

-- 说明：刷新单个槽位（g,s）的可拖拽/点击状态。
-- 规则（与原始一致）：只有“第 1 层”物体可被点击/拖动；悬空物体（无第 1 层）不可点。
-- 当第二层因下沉（promote）移动到第一层后，本函数会把它变成可点击，从而“第二层移动到第一层时可点击”。
function refreshSlotDraggable(self, g, s)
    if not self.mSlotItem or not self.mSlotItem[g] or not self.mSlotItem[g][s] then
        return
    end
    -- 先关闭该槽位所有物体的 raycast 与拖拽监听。
    for L = 1, GAME_LAYER_COUNT do
        local it = self.mSlotItem[g][s][L]
        if it then
            local img = it:getGo():GetComponent(ty.AutoRefImage)
            if not gs.GoUtil.IsCompNull(img) then
                img.raycastTarget = false
            end
            local trigger = it:getGo():GetComponent(ty.LongPressOrClickEventTrigger)
            if trigger then
                trigger.onBeginDrag:RemoveAllListeners()
                trigger.onEndDrag:RemoveAllListeners()
            end
        end
    end
    -- 仅第 1 层挂拖拽并开启 raycast（悬空物体因无第 1 层而不会挂，符合原规则）。
    local topIt = self.mSlotItem[g][s][1]
    if topIt and not self.mGMAutoPlaying then
        local img = topIt:getGo():GetComponent(ty.AutoRefImage)
        if not gs.GoUtil.IsCompNull(img) then
            img.raycastTarget = not self.mGMAutoPlaying
        end
        self:addDragToItem(topIt)
    end
end

-- 说明：刷新全部槽位的可拖拽状态（初始生成后、下沉后、拖拽落点后统一调用）。
function refreshAllDraggable(self)
    if not self.mSlotItem then
        return
    end
    for g = 1, #self.mSlotItem do
        for s = 1, #self.mSlotItem[g] do
            self:refreshSlotDraggable(g, s)
        end
    end
end

-- 说明：用补间动画平滑修改物体透明度（后层移动到前层时 a 平滑过渡，而非瞬变）。
-- 每次开新 tween 前 Kill 旧的，避免叠加；回调里检测物体是否已回收（防访问已销毁组件）。
function setItemAlphaTween(self, item, targetAlpha, duration)
    duration = duration or GAME_ANIM_ITEM_DURATION
    if item.mAlphaTween then
        item.mAlphaTween:Kill()
        item.mAlphaTween = nil
    end
    local img = item:getGo():GetComponent(ty.AutoRefImage)
    if gs.GoUtil.IsCompNull(img) then
        return
    end
    local startA = img.color.a
    local function _progress(val)
        local go = item:getGo()
        if gs.GoUtil.IsGoNull(go) then
            return
        end
        local im = go:GetComponent(ty.AutoRefImage)
        if gs.GoUtil.IsCompNull(im) then
            return
        end
        local c = im.color
        c.a = val
        im.color = c
    end
    item.mAlphaTween = gs.DT.DoTweenEx.DOProgressFloatVal(startA, targetAlpha, duration, _progress)
end

-- 说明：Fisher-Yates 洗牌，原地打乱数组，用于随机但均匀的落位分配。
function shuffleArray(self, arr)
    for i = #arr, 2, -1 do
        local j = math.random(i)
        arr[i], arr[j] = arr[j], arr[i]
    end
    return arr
end

-- 说明：回收所有生成的格子与物品节点，避免重玩时重复生成或残留。
function clearAllGameItem(self)
    -- 先停掉可能还在跟随指针的拖拽帧循环，避免回调到已回收物体。
    if self.mDragSn then
        LoopManager:removeFrame(self, self.onItemDragUpdate)
        self.mDragSn = nil
    end
    self.mDragItem = nil
    -- 先回收正在播放销毁特效、已移出 mGameItemList 的 mGameItem，避免重复回收与悬空定时器。
    if self.mDestroyingItemList then
        for i = #self.mDestroyingItemList, 1, -1 do
            local it = self.mDestroyingItemList[i]
            if it.mDestroySn then
                self:clearTimeout(it.mDestroySn)
                it.mDestroySn = nil
            end
            local effGo = it:getChildGO("mEffect")
            if effGo then
                effGo:SetActive(false)
            end
            if not gs.GoUtil.IsGoNull(it:getGo()) then
                it:poolRecover()
            end
        end
        self.mDestroyingItemList = nil
    end
    -- 先回收挂在 single 下的 mGameItem，避免其随 single 进池后被复用残留。
    if self.mGameItemList then
        for i = 1, #self.mGameItemList do
            local it = self.mGameItemList[i]
            if it.mMoveTween then
                it.mMoveTween:Kill()
                it.mMoveTween = nil
            end
            if it.mAlphaTween then
                it.mAlphaTween:Kill()
                it.mAlphaTween = nil
            end
            it:poolRecover()
        end
        self.mGameItemList = nil
    end
    -- 再回收格子（group / single）。
    if self.mGroupItemList then
        for i = 1, #self.mGroupItemList do
            local groupData = self.mGroupItemList[i]
            if groupData.singleList then
                for j = 1, #groupData.singleList do
                    groupData.singleList[j]:poolRecover()
                end
            end
            groupData.item:poolRecover()
        end
        self.mGroupItemList = nil
    end
    -- 说明：重新激活三个模板，供下次克隆使用。
    if self.mGameItem then
        self.mGameItem:SetActive(true)
    end
    if self.mGroupItem then
        self.mGroupItem:SetActive(true)
    end
    if self.mSingleItem then
        self.mSingleItem:SetActive(true)
    end
end

-- 说明：检查游戏是否应该结束。两种情况其一即结束：
--  1) 全部清除（所有槽位无物体）；
--  2) 悬挂死局：再也无法完成任何一次消除。
--
-- 消除判定的核心：消除只需“第 1 层某颜色数量 ≥ 3”。因为第 1 层物体可通过交换/填空
-- 自由重排到任意 single，只要同色 ≥ 3 就能聚到同一组的 3 个格完成消除。
-- 因此：
--   - 第 1 层存在某色 ≥ 3            → 立即可消，非死局；
--   - 第 1 层无色 ≥ 3，但仍能下沉引入新物体（存在深层物体且第 1 层空位 ≥ 3，
--     可腾空某组触发下沉）           → 局面仍可改变，暂不判死；
--   - 第 1 层无色 ≥ 3，且无法再下沉（无深层物体，或第 1 层空位不足 3 无法腾空）→ 悬挂死局。
function checkAllClear(self)
    if self.isEnd or not self.mSlotItem then
        return
    end
    -- 说明：被禁用组的中间槽位若已无任何物体（无后续物体），也按禁用格处理（见 refreshBlockedMiddleSlots）。
    self:refreshBlockedMiddleSlots()
    local colorCnt = {}
    local emptyL1 = 0
    local occL1 = 0
    local hasDeep = false
    for g = 1, #self.mSlotItem do
        for s = 1, #self.mSlotItem[g] do
            local it = self.mSlotItem[g][s][1]
            if it then
                occL1 = occL1 + 1
                colorCnt[it.typeId] = (colorCnt[it.typeId] or 0) + 1
            else
                emptyL1 = emptyL1 + 1
            end
            -- 是否存在深层物体（第 2 层及以下）。
            for L = 2, GAME_LAYER_COUNT do
                if self.mSlotItem[g][s][L] then
                    hasDeep = true
                    break
                end
            end
        end
    end
    -- 情况 1：全部清除（第 1 层与深层都没有物体）。
    if occL1 == 0 and not hasDeep then
        self:onGameEnd("全部清除")
        return
    end
    -- 第 1 层已有某色 ≥ 3 → 可消除，非死局。
    for _, c in pairs(colorCnt) do
        if c >= 3 then
            return
        end
    end
    -- 第 1 层无法凑 3 同：若仍可下沉引入新物体（有深层且空位 ≥ 3 可腾空某组），局面可变，不判死。
    if hasDeep and emptyL1 >= 3 then
        return
    end
    -- 情况 2：既无法消除、也无法再改变局面 → 悬挂死局。
    self:onGameEnd("死局")
end

function onGameEnd(self, reason)
    if self.isEnd then
        return
    end
    reason = reason or "未知"
    -- 说明：分数飘字动画（加分）可能还在播放，mScore 尚未累加完。
    --       必须等所有飘字结束才是真实得分，否则 isWin / score 会基于未加完的分数判定，导致结算错误。
    if (self.mPendingScoreFly or 0) > 0 then
        -- 先冻结游戏循环（停止倒计时/输入），但暂不置 isEnd，待飘字结束再真正结算（onGameEndDo 内部置位）。
        self.canRun = false
        self.isPlaying = false
        self.mPendingEndReason = reason
        -- 兜底：极端情况下飘字回调未触发，避免卡在结束态（超时后强制以当前分结算）。
        if not self.mEndFallbackSn then
            self.mEndFallbackSn = self:setTimeout(GAME_ANIM_WAIT_FALLBACK, function()
                self.mEndFallbackSn = nil
                if self.mPendingEndReason then
                    local r = self.mPendingEndReason
                    self.mPendingEndReason = nil
                    self.mPendingScoreFly = 0
                    self:onGameEndDo(r)
                end
            end)
        end
        return
    end
    self:onGameEndDo(reason)
end

-- 真正执行结算：此时所有分数飘字已结束，mScore 为真实得分。
function onGameEndDo(self, reason)
    if self.isEnd then
        return
    end
    print("DropGamePanel onGameEnd reason: " .. reason)
    self.isEnd = true
    self.canRun = false
    self.isPlaying = false   -- 会话结束，倒计时停止
    self.isPasue = false     -- 若暂停中时间到，解除暂停态
    -- 说明：若暂停中时间到触发结算，需关掉暂停面板，避免其压在结算面板之上。
    if self.mGroupPause then
        self.mGroupPause:SetActive(false)
    end
    -- 结算时清空连击 UI（避免面板背后残留）。
    self.comboCount = 0
    self:showComboUI(false)

    local isWin = self.mScore >= self.mTargetScore
    local isPass = drop.DropManager:getDupPassState(self.dupId)
    local isFirst = isWin and isPass == false

    GameDispatcher:dispatchEvent(EventName.OPEN_DROP_SETTLE_PANEL, {
        dupId = self.dupId,
        score = self.mScore,
        first = isFirst,
        isWin = isWin
    })
end

--==========================================================
-- GM 调试
--==========================================================

function onClickGMAuto(self)
    if not GameManager.IS_DEBUG or not self.mSlotItem then
        return
    end
    -- 说明：再次点击自动按钮时请求停止自动排布（本轮全部处理完后停止）。
    --       守卫同时覆盖“移动动画 + 结算 + 下沉”全程（mGMAutoRunning），
    --       避免两轮间隙点按钮绕过守卫又自启一轮导致“停不下来”。
    if self.mGMAutoRunning or self.mGMAutoStop then
        self.mGMAutoStop = true
        -- 说明：请求停止后立刻把按钮文本切回“开始自动”，即时反映“已停止”状态；
        --       当前这一轮（含后续结算/下沉动画）仍会自然跑完，结束后由 waitAllVisual 回调再次确认复位。
        self:setBtnLabel(self.mBtnGMAuto, -1, "开始自动")
        return
    end
    self.mGMAutoStop = false
    -- 说明：标记整个自动流程开始；覆盖移动动画 + 结算 + 下沉全程，
    --       任意时刻点击停止都能被守卫捕获，不会在间隙自启。
    self.mGMAutoRunning = true
    -- 说明：进入自动排布，按钮文本切换为“停止自动”。
    self:setBtnLabel(self.mBtnGMAuto, -1, "停止自动")

    local slotRefs = {}
    local items = {}
    local typeMap = {}
    local emptyRefs = {}
    local stackedItems = {}
    for g = 1, #self.mSlotItem do
        for s = 1, #self.mSlotItem[g] do
            if not self:isBlockedSlot(g, s) then
                local ref = { g = g, s = s, L = 1 }
                table.insert(slotRefs, ref)
                local it = self.mSlotItem[g][s][1]
                if it then
                    table.insert(items, it)
                    typeMap[it.typeId] = typeMap[it.typeId] or {}
                    table.insert(typeMap[it.typeId], it)
                    for L = 2, GAME_LAYER_COUNT do
                        if self.mSlotItem[g][s][L] then
                            table.insert(stackedItems, it)
                            break
                        end
                    end
                else
                    table.insert(emptyRefs, ref)
                end
            end
        end
    end

    -- 说明：自动排列优先把物体移向“完整可用（非禁用）组”，故移动目标池按组优先级排序（完整组在前）。
    local function _groupPriority(ref)
        return self:isFullGroup(ref.g) and 0 or 1
    end
    local function _sortByGroup(list)
        table.sort(list, function(a, b)
            local pa, pb = _groupPriority(a), _groupPriority(b)
            if pa ~= pb then
                return pa < pb
            end
            if a.g ~= b.g then
                return a.g < b.g
            end
            return a.s < b.s
        end)
    end
    -- 说明：空位目标随机打乱，避免可销毁物品总是按 1-2-3（低 g 低 s）顺序放置。
    self:shuffleArray(emptyRefs)

    -- 说明：自动排列时优先凑可消除组；若有第一层物体压住后层物体且存在空位，再把它挪到空位。
    local matchGroups = {}
    for _, list in pairs(typeMap) do
        while #list >= 3 do
            table.insert(matchGroups, { table.remove(list, 1), table.remove(list, 1), table.remove(list, 1) })
        end
    end

    local targetGroupSlots = {}
    for g = 1, #self.mSlotItem do
        local refs = {}
        for s = 1, #self.mSlotItem[g] do
            if not self:isBlockedSlot(g, s) then
                table.insert(refs, { g = g, s = s, L = 1 })
            end
        end
        if #refs >= 3 then
            -- 组内 3 个目标 single 随机挑选（不再固定 s=1,2,3 顺序放置）。
            self:shuffleArray(refs)
            table.insert(targetGroupSlots, { refs[1], refs[2], refs[3] })
        end
    end
    -- 说明：组间目标顺序随机（不再按“完整组优先 / g 升序”确定性排列）。
    self:shuffleArray(targetGroupSlots)

    local useCount = math.min(#matchGroups, #targetGroupSlots)
    if useCount <= 0 and (#stackedItems <= 0 or #emptyRefs <= 0) then
        -- 说明：无可排布内容，复位按钮文本为“开始自动”，并清掉流程标志（否则会拦截后续点击）。
        self.mGMAutoRunning = false
        self:setBtnLabel(self.mBtnGMAuto, -1, "开始自动")
        return
    end

    local matchSet = {}
    local targetSlotMap = {}
    for i = 1, useCount do
        for j = 1, 3 do
            matchSet[matchGroups[i][j]] = true
            local ref = targetGroupSlots[i][j]
            targetSlotMap[ref.g .. "_" .. ref.s] = true
        end
    end

    local stackedMoveSet = {}
    local emptyIdx = 1
    for i = 1, #stackedItems do
        local it = stackedItems[i]
        if not matchSet[it] then
            local ref = emptyRefs[emptyIdx]
            while ref and targetSlotMap[ref.g .. "_" .. ref.s] do
                emptyIdx = emptyIdx + 1
                ref = emptyRefs[emptyIdx]
            end
            if ref then
                stackedMoveSet[it] = ref
                targetSlotMap[ref.g .. "_" .. ref.s] = true
                emptyIdx = emptyIdx + 1
            end
        end
    end

    for i = 1, #slotRefs do
        local ref = slotRefs[i]
        self.mSlotItem[ref.g][ref.s][ref.L] = nil
    end

    for i = 1, useCount do
        for j = 1, 3 do
            local ref = targetGroupSlots[i][j]
            local it = matchGroups[i][j]
            it.groupIdx = ref.g
            it.singleIdx = ref.s
            it.layer = ref.L
            self.mSlotItem[ref.g][ref.s][ref.L] = it
        end
    end

    for it, ref in pairs(stackedMoveSet) do
        if ref then
            it.groupIdx = ref.g
            it.singleIdx = ref.s
            it.layer = ref.L
            self.mSlotItem[ref.g][ref.s][ref.L] = it
            targetSlotMap[ref.g .. "_" .. ref.s] = true
        end
    end

    local remainItems = {}
    for i = 1, #items do
        local it = items[i]
        if not matchSet[it] and not stackedMoveSet[it] then
            table.insert(remainItems, it)
        end
    end
    local remainSlots = {}
    for i = 1, #slotRefs do
        local ref = slotRefs[i]
        if not targetSlotMap[ref.g .. "_" .. ref.s] then
            table.insert(remainSlots, ref)
        end
    end
    -- 说明：剩余物体目标槽位随机打乱，避免按 1-2-3 顺序放置。
    self:shuffleArray(remainSlots)
    for i = 1, #remainItems do
        local ref = remainSlots[i]
        if ref then
            local it = remainItems[i]
            it.groupIdx = ref.g
            it.singleIdx = ref.s
            it.layer = ref.L
            self.mSlotItem[ref.g][ref.s][ref.L] = it
        end
    end

    self.mGMAutoPlaying = true
    self:refreshAllSlotVisual(GAME_ANIM_MOVE_DURATION, function()
        self.mGMAutoPlaying = false
        -- 说明：GM 自动排列移动动画结束后，走正式游戏相同的结算规则：消除计分、combo、下沉。
        self:promoteAllGroupsIfEmpty()
        self:checkMatchAndClear()
        self:promoteAllGroupsIfEmpty()
        -- 说明：以上结算可能触发下沉动画（placeItemVisual，异步）。必须等全部动画播放完成，
        --      才能 refreshAllSlotVisual 与进入下一轮，否则动画会错乱/重叠。
        self:waitAllVisual(function()
            self:refreshAllSlotVisual()
            self:checkAllClear()
            if self.isEnd then
                -- 说明：游戏已结束，复位自动按钮文本为“开始自动”，并清掉流程/停止标志
                --       （否则残留会泄漏到下一局，导致“开始自动”被守卫拦截）。
                self.mGMAutoStop = false
                self.mGMAutoRunning = false
                self:setBtnLabel(self.mBtnGMAuto, -1, "开始自动")
            elseif self.mGMAutoStop then
                -- 说明：本轮已全部处理完且收到停止请求：恢复所有第一层 item 可拖动并复位按钮文本。
                self.mGMAutoStop = false
                self.mGMAutoRunning = false
                self:refreshAllSlotVisual()
                self:setBtnLabel(self.mBtnGMAuto, -1, "开始自动")
            else
                -- 说明：进入下一轮前临时清掉流程标志，使本轮递归调用能重新进入自动排布
                --       （而非被守卫当成“运行中”而误判为停止请求）；onClickGMAuto 内部会重新置 true。
                self.mGMAutoRunning = false
                self:onClickGMAuto()
            end
        end)
    end)
end

function onClickGMRandom(self)
    if not GameManager.IS_DEBUG or not self.mSlotItem then
        return
    end
    local items = {}
    local slotRefs = {}
    for g = 1, #self.mSlotItem do
        for s = 1, #self.mSlotItem[g] do
            if not self:isBlockedSlot(g, s) then
                for L = 1, GAME_LAYER_COUNT do
                    local it = self.mSlotItem[g][s][L]
                    if it then
                        table.insert(items, it)
                        table.insert(slotRefs, { g = g, s = s, L = L })
                        self.mSlotItem[g][s][L] = nil
                    end
                end
            end
        end
    end
    self:shuffleArray(items)
    for i = 1, #items do
        local ref = slotRefs[i]
        local it = items[i]
        it.groupIdx = ref.g
        it.singleIdx = ref.s
        it.layer = ref.L
        self.mSlotItem[ref.g][ref.s][ref.L] = it
    end
    self:refreshAllSlotVisual()
end

function onClickGMSocre(self)
    if not GameManager.IS_DEBUG then
        return
    end
    self.mScore = self.mScore + self.mTargetScore
    self:refreshScore()
end

return _M
