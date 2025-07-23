--[[ 
-----------------------------------------------------
@filename       : MiningScenePanel
@Description    : 捞宝藏小游戏
@date           : 2023-11-29 11:04:47
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.mining.view.MiningScenePanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("mining/MiningScenePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowBlackBg = 0
escapeClose = 0 -- 是否能通过esc关闭窗口

--构造函数
function ctor(self)
    super.ctor(self)
    -- self:setSize(750, 600)
    -- self:setTxtTitle("捞宝藏")
    -- self:setBg("")
end
--析构  
function dtor(self)
end

function initData(self)
    -- 当前甩勾角度
    self.mRotation = 0
    -- 当前甩勾方向
    self.mCurrDir = 1
    -- 是否抓取状态（包括收爪阶段）
    self.isCatching = false
    -- 当前伸爪长度
    self.mScaleLen = 50
    -- 最大伸缩距离
    self.mMaxScaleLen = 800
    -- 最小伸缩距离
    self.mMinScaleLen = 50
    -- 当前需要的总积分
    self.mAllNeedScore = 0

    -- 剩余时间
    self.mRemaidTime = 0

    self.mThingDic = {}
end

-- 初始化
function configUI(self)
    -- self.aa = self:getChildGO("aa"):GetComponent(ty.Image)
    -- self.bb = self:getChildTrans("bb")
    self.mBtnCatch = self:getChildGO("mBtnCatch")
    self.mGroupFly = self:getChildTrans("mGroupFly")

    self.mImgCurrScore = self:getChildGO("mImgCurrScore"):GetComponent(ty.AutoRefImage)
    self.mTxtCurrScore = self:getChildGO("mTxtCurrScore"):GetComponent(ty.Text)
    self.mTxtWave = self:getChildGO("mTxtWave"):GetComponent(ty.Text)
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
    self.mTxtNeed = self:getChildGO("mTxtNeed"):GetComponent(ty.Text)
    self.mImgNeedScore = self:getChildGO("mImgNeedScore"):GetComponent(ty.AutoRefImage)
    self.mTxtNeedScore = self:getChildGO("mTxtNeedScore"):GetComponent(ty.Text)

    self.mGroupWave = self:getChildGO("mGroupWave")
    self.mTxtCurrWave = self:getChildGO("mTxtCurrWave"):GetComponent(ty.Text)
    self.mTxtCurrNeed = self:getChildGO("mTxtCurrNeed"):GetComponent(ty.Text)
    self.mImgCurrNeedScore = self:getChildGO("mImgCurrNeedScore"):GetComponent(ty.AutoRefImage)
    self.mTxtCurrNeedScore = self:getChildGO("mTxtCurrNeedScore"):GetComponent(ty.Text)

    self.mBtnPause = self:getChildGO("mBtnPause")
    self.mGroupPause = self:getChildGO("mGroupPause")

    self.mBtnExit = self:getChildGO("mBtnExit")
    self.mBtnReplay = self:getChildGO("mBtnReplay")
    self.mBtnPlay = self:getChildGO("mBtnPlay")
    self.mBtnFinish = self:getChildGO("mBtnFinish")

    self.mGroupStar = self:getChildTrans("mGroupStar")
end

--激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.MINING_SPEED_UP, self.onSpeedUpHandler, self)
    local dupId = args.dupId
    self.dupVo = mining.MiningManager:getDupVo(dupId)
    self:initScene()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()

    GameDispatcher:removeEventListener(EventName.MINING_SPEED_UP, self.onSpeedUpHandler, self)

    if self.mSceneGo then
        gs.GameObject.Destroy(self.mSceneGo)
    end
    self:clearMining()
    self:resetState()
    gs.Time.timeScale = 1
    LoopManager:setStop(false)

    self.mAllNeedScore = 0

    self.mSceneChildGos = nil
    self.mSceneChildTrans = nil

    self.mGroupClaw = nil
    self.mClawLine = nil
    self.mImgClaw01 = nil
    self.mGroupThing = nil
    self.mGroupCatch = nil
    self.mFX_01 = nil
    self.mFX_02 = nil

    self.mMiningRoleAnim = nil
    self.mHasShowAnim = false

    self:removeFrame()
    self:shopAudioSound()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
    self.mTxtNeed.text = "所需："
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnCatch, self.onCatchClick)
    self:addUIEvent(self.mBtnPause, self.onPauseClick)

    self:addUIEvent(self.mBtnExit, self.onClickClose)
    self:addUIEvent(self.mBtnReplay, self.onReplayClick)
    self:addUIEvent(self.mBtnPlay, self.onPlayClick)
    self:addUIEvent(self.mBtnFinish, self.onFinishClick)
end

-- 暂停
function onPauseClick(self)
    self.mGroupPause:SetActive(true)
    gs.Time.timeScale = 0
    LoopManager:setStop(true)
    self:updateStarInfo()
    self:pauseAudioSound()
end

-- 继续
function onPlayClick(self)
    self.mGroupPause:SetActive(false)
    gs.Time.timeScale = 1
    LoopManager:setStop(false)
    self:resumAudioSound()
end

-- 重新开始
function onReplayClick(self)
    self.mGroupPause:SetActive(false)
    gs.Time.timeScale = 1
    LoopManager:setStop(false)
    self:resetState()
    GameDispatcher:dispatchEvent(EventName.SEND_MINING_REPLAY, { dupId = self.dupVo.id })
end

-- 提前结算
function onFinishClick(self)
    self.mGroupPause:SetActive(false)
    gs.Time.timeScale = 1
    LoopManager:setStop(false)
    self:resetState()
    GameDispatcher:dispatchEvent(EventName.OPEN_MINING_DUP_RESULT, { dupVo = self.dupVo })
end

function initScene(self)
    self.mSceneGo = gs.ResMgr:LoadGO("arts/fx/ui/mining_01/prefabs/MiningScene.prefab")
    gs.TransQuick:SetParentOrg(self.mSceneGo.transform, GameView.UINode["SCENE"])
    -- gs.TransQuick:Scale0(self.mSceneGo.transform, 90)
    -- gs.TransQuick:LPosZ(self.mSceneGo.transform, 10)
    self.mSceneChildGos, self.mSceneChildTrans = GoUtil.GetChildHash(self.mSceneGo)

    if not self.mGroupClaw then
        self.mGroupClaw = self.mSceneChildTrans["mGroupClaw"]
    end
    if not self.mClawLine then
        self.mClawLine = self.mSceneChildTrans["mImgLine"]
    end
    if not self.mImgClaw01 then
        self.mImgClaw01 = self.mSceneChildTrans["mImgClaw01"]
    end
    if not self.mGroupThing then
        self.mGroupThing = self.mSceneChildTrans["mGroupThing"]
    end
    if not self.mGroupCatch then
        self.mGroupCatch = self.mSceneChildTrans["mGroupCatch"]
    end
    if not self.mFX_01 then
        self.mFX_01 = self.mSceneChildGos["mFX_01"]
    end
    if not self.mFX_02 then
        self.mFX_02 = self.mSceneChildGos["mFX_02"]
    end

    if not self.mMiningRoleAnim then
        self.mMiningRoleAnim = self.mSceneChildGos["MiningRole"]:GetComponent(ty.Animator)
    end

    self.mClawAnim = self.mImgClaw01.gameObject:GetComponent(ty.Animator)
    self.mColliderCall = self.mImgClaw01.gameObject:GetComponent(ty.ColliderCall)
    if not self.mColliderCall or gs.GoUtil.IsCompNull(self.mColliderCall) then
        self.mColliderCall = self.mImgClaw01.gameObject:AddComponent(ty.ColliderCall)
        self.mColliderCall:OpenColliderCheck()
        self.mColliderCall:AddColliderTags({ "MiningThing" })
        self.mColliderCall.SelfColliderTag = "MiningClaw"
        self.mColliderCall.IsTrigger = true
    end

    -- self.mColliderCall.onTriggerEnterCall = function(tag, colliderTagID)
    --     self:onColliderEnter(tag, colliderTagID)
    -- end

    mining.MiningManager.currScore = 0
    mining.MiningManager.currWave = 1

    self:addFrame()
    self:initMining()
end

function addFrame(self)
    LoopManager:addFrame(1, 0, self, self.onFrame)
end

function removeFrame(self)
    LoopManager:removeFrame(self, self.onFrame)
end

function onFrame(self)
    if self.isCatching then
        self:onCatchHandler()
    else
        self:onRotaionHandler()
    end
    self:checkSpeedUpEff()
end

-- 检测菠菜加速特效是否显示
function checkSpeedUpEff(self)
    if self.mFX_01.activeSelf == true and mining.MiningManager.spinachOverTime <= GameManager:getClientTime() then
        self.mFX_01:SetActive(false)
    end
end

-- 菠菜效果
function onSpeedUpHandler(self)
    if self.mFX_01 then
        self.mFX_01:SetActive(true)
    end
end

-- 点击抓取
function onCatchClick(self)
    if self.isCatching then
        return
    end
    mining.MiningManager.currCatchState = 1
    self.isCatching = true
    self:playSoundEffect("mng_sm_1.prefab", true)
    if self.mClawAnim then
        self.mClawAnim:SetTrigger("on")
    end
end

-- 甩钩逻辑
function onRotaionHandler(self)
    if self.mGroupClaw then
        if self.mRotation >= 70 then
            self.mCurrDir = 2
        end
        if self.mRotation <= -70 then
            self.mCurrDir = 1
        end
        if self.mCurrDir == 2 then
            self.mRotation = self.mRotation - 1
        else
            self.mRotation = self.mRotation + 1
        end
        gs.TransQuick:SetLRotation(self.mGroupClaw, 0, 0, self.mRotation)
    end
end

-- 抓取逻辑
function onCatchHandler(self)
    if self.mScaleLen >= self.mMaxScaleLen then
        mining.MiningManager.currCatchState = 0
        if self.mClawAnim then
            self.mClawAnim:SetTrigger("off")
        end
    end

    if mining.MiningManager.currCatchState == 1 then
        self.mScaleLen = self.mScaleLen + 600 * gs.Time.deltaTime
        gs.TransQuick:SizeDelta02(self.mClawLine, self.mScaleLen)
    else

        if mining.MiningManager.currCatchId ~= nil and not self.mHasShowAnim then
            self.mHasShowAnim = true
            self.mMiningRoleAnim:Play("MiningRole_Loop01")
            self:playSoundEffect("mng_sm_2.prefab")
            self.holdFrame = math.floor(0.2 / gs.Time.deltaTime) --抓到东西停顿
            if self.mClawAnim then
                self.mClawAnim:SetTrigger("off")
            end
        end
        if self.holdFrame and self.holdFrame > 0 then
            self.holdFrame = self.holdFrame - 1
            if self.holdFrame == 0 then
                self:playSoundEffect("mng_sm_4.prefab", true) --成功获得物品往回收束得音效
            end
            return
        end

        self.mScaleLen = self.mScaleLen - 600 * gs.Time.deltaTime * mining.MiningManager:getGrabSpeed()
        gs.TransQuick:SizeDelta02(self.mClawLine, self.mScaleLen)
    end

    gs.TransQuick:LPosY(self.mImgClaw01, -self.mScaleLen)

    if self.mScaleLen < self.mMinScaleLen then
        self:shopAudioSound()
        -- 回收结束
        self.isCatching = false
        self.mScaleLen = self.mMinScaleLen

        mining.MiningManager:setGrabSpeed(1)
        if mining.MiningManager.currCatchId ~= nil then
            self.mMiningRoleAnim:Play("MiningRole_Loop")
            self.mHasShowAnim = false

            -- 抓到了
            self:addScore()
            local thing = self.mThingDic[mining.MiningManager.currCatchId]
            if thing then
                thing:catchFinish()
                thing = nil
            end
            self.mThingDic[mining.MiningManager.currCatchId] = nil
            mining.MiningManager.currCatchId = nil
            self.mCheckWaveTimeoutId = self:setTimeout(1, function()
                self:checkWaveChange()
            end)
        end
    end
end

-- 判断积分要求
function checkScoreFinish(self)
    if mining.MiningManager.currScore >= self.mAllNeedScore then
        return true
    end
    -- 小于积分要求直接结束
    self:clearMining()
    self:resetState()
    GameDispatcher:dispatchEvent(EventName.OPEN_MINING_DUP_RESULT, { dupVo = self.dupVo })
    return false
end

-- 判断波次变化
function checkWaveChange(self)
    if table.nums(self.mThingDic) <= 0 then
        mining.MiningManager.currWave = mining.MiningManager.currWave + 1
        self:initMining()
    end
end

-- 重置状态
function resetState(self)
    self:removeTimer(self.onTimer)
    self:clearTimeout(self.mCheckWaveTimeoutId)
    mining.MiningManager:setGrabSpeed(1)
    mining.MiningManager.currCatchId = nil
    mining.MiningManager.spinachOverTime = 0
    self.mMiningRoleAnim:Play("MiningRole_Loop")
    self.mHasShowAnim = false
    self.mFX_01:SetActive(false)
    self.mFX_02:SetActive(false)
end

-- 初始化矿物
function initMining(self)
    self:resetState()

    local currWave = mining.MiningManager.currWave
    local wareId = self.dupVo.waveList[currWave]
    if self.dupVo.waveList[1] ~= 0 then
        if not wareId then
            -- gs.Message.Show("结算啦")
            GameDispatcher:dispatchEvent(EventName.OPEN_MINING_DUP_RESULT, { dupVo = self.dupVo })
            return
        end
        self.waveVo = mining.MiningManager:getWaveVo(wareId)
    else
        -- 无尽模式
        self.waveVo = mining.MiningManager:getRandomWaveVo(wareId)
    end
    self.mRemaidTime = self.waveVo.timeLimit

    local time = 2
    if currWave > 1 then
        time = 3.5
        self.mFX_02:SetActive(true)
        self:playSoundEffect("mng_sm_8.prefab")
        self:setTimeout(1.5, function()
            self.mFX_02:SetActive(false)
            self.mGroupWave:SetActive(true)
            self.mTxtCurrWave.text = "波次：" .. currWave
        end)
    else
        self.mGroupWave:SetActive(true)
        self.mTxtCurrWave.text = "波次：" .. currWave
    end

    self:setTimeout(time, function()
        self.mGroupWave:SetActive(false)

        for i, v in pairs(self.waveVo.eventList) do
            local livething = mining.MiningLivething.new()
            livething:createThing(i, v, self.mGroupThing, self.mGroupCatch)
            self.mThingDic[i .. "_" .. v.event_id] = livething
        end

        self:addTimer(1, 0, self.onTimer)
        self:onTimer()
    end)

    self:updateView()
end

-- 加积分飘字
function addScore(self)
    local score = mining.MiningManager:getCatchScore()
    if score and score > 0 then
        mining.MiningManager.currScore = mining.MiningManager.currScore + score
        local name = "arts/prefabs/ui/fight/FlyHText.prefab"
        local font = gs.ResMgr:Load(UrlManager:getFntPath("score_add_num.fontsettings"))
        fightUI.FightFlyUtil:fly2D(self.mGroupFly, name, gs.Vector2(-130, 270), "+" .. score, nil, font)
    end
    self:playSoundEffect("mng_sm_5.prefab")

    local catchId = mining.MiningManager.currCatchId
    local idList = string.split(catchId, "_")
    local eventId = tonumber(idList[2])
    GameDispatcher:dispatchEvent(EventName.SEND_MINING_EVENT_TO_SEVER, eventId)

    self:updateScore()
end

function updateView(self)
    self:updateWave()
    self:updateScore()
    self:updateNeedScore()
    self:updateTime()
end

-- 更新波次
function updateWave(self)
    self.mTxtWave.text = "当前波次：" .. mining.MiningManager.currWave
    self.mTxtCurrWave.text = "当前波次：" .. mining.MiningManager.currWave
end

-- 更新波次
function updateScore(self)
    self.mTxtCurrScore.text = mining.MiningManager.currScore
end

-- 当前所需积分
function updateNeedScore(self)
    self.mAllNeedScore = self.mAllNeedScore + self.waveVo.requirePoint
    self.mTxtNeedScore.text = self.mAllNeedScore
    self.mTxtCurrNeedScore.text = self.mAllNeedScore
end

-- 时间步进
function onTimer(self)
    self.mRemaidTime = self.mRemaidTime - 1
    self:updateTime()
    if self.mRemaidTime <= 0 and self:checkScoreFinish() then
        self:clearMining()
        self:checkWaveChange()
    end
end

-- 更新时间
function updateTime(self)
    local color = "ffffffff"
    if self.mRemaidTime <= 10 then
        color = "ff0000ff"
    end
    self.mTxtTime.text = "剩余时间：" .. HtmlUtil:color(TimeUtil.getHMSByTime_1(self.mRemaidTime), color)
end

-- 清理矿物
function clearMining(self)
    if self.mThingDic then
        for k, v in pairs(self.mThingDic) do
            v:destroy()
        end
    end
    self.mThingDic = {}
end

-- 矿物列表
function getThingDic(self)
    return self.mThingDic
end

-------------------暂停界面

-- 更新星级
function updateStarInfo(self)
    local list = self.dupVo.starList
    local score = mining.MiningManager.currScore
    local starCount = mining.MiningManager:getPlayerDupStar(self.dupVo.id, score)
    self:recoverStarItem()
    for i = 1, #list do
        local item = SimpleInsItem:create(self:getChildGO("GroupTaskItem"), self.mGroupStar, "MiningScenePanelStarItem")
        local starConfig = mining.MiningManager:getStarConfigVo(list[i])

        local isMeet = starCount >= starConfig.star
        local color = "82898c"
        if isMeet then
            color = "ffffff"
        end
        item:getChildGO("mImgStar"):SetActive(isMeet)
        item:setText("mTextDesc", nil, string.format("<color=#%s>%s</color>", color, _TT(starConfig.des)))

        table.insert(self.mStarItemList, item)
    end
end

function recoverStarItem(self)
    if self.mStarItemList then
        for k, v in pairs(self.mStarItemList) do
            v:poolRecover()
        end
    end
    self.mStarItemList = {}
end

-- 播放音效
function playSoundEffect(self, soundName, isLoop)
    self:shopAudioSound()
    self.audioData = AudioManager:playSoundEffect(UrlManager:getUISoundPath("minigames/" .. soundName), isLoop)

end
-- 停止音效
function shopAudioSound(self)
    if self.audioData then
        AudioManager:stopAudioSound(self.audioData)
        self.audioData = nil
    end
end
-- 暂停音效
function pauseAudioSound(self)
    if self.audioData then
        self.audioData:pauseAudioData()
    end
end
-- 继续音效
function resumAudioSound(self)
    if self.audioData then
        self.audioData:resumeAudioData()
    end
end

return _M