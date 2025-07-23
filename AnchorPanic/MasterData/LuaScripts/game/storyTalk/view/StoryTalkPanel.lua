module('game.storyTalk.view.StoryTalkPanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('storyTalk/StoryTalkPanel.prefab')
panelType = -1  -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isBlur = 2      -- 是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
isAdapta = 1    -- 是否开启适配刘海

function getAdaptaTrans(self)
    return self.UITrans
end

-- 重写父类实现
function setMask(self)
end

-- 重写父类实现
function __playOpenAction(self)
end

-- 取父容器
function getParentTrans(self)
    return GameView.story
end

function dtor(self)

end

-- 打开剧情 段落id
function open(self, talkID)
    if self.isPop == 1 then
        return
    end

    self:setAdapta()
    self.isOpenInEditor = storyTalk.StoryTalkManager:getIsEditor()
    if not self.isOpenInEditor then
        self:openOption()
    end

    -- 起始段落ID
    self.startTalkId = talkID
    self.isPop = 1
    if self.UIObject then
        self:addOnParent()
    end
    GameDispatcher:dispatchEvent(EventName.EVENT_UI_OPEN, self)
end

-- 非编辑器下对相机的相关操作(渲染压力相关)
function openOption(self)
    self.defCameraObj = gs.CameraMgr:GetDefSceneCamera().gameObject
    if self.defCameraObj then
        self.defSceneActive = self.defCameraObj.activeSelf
        self.defCameraObj:SetActive(false)
    end

    self.fightCameraObj = fight.FightCamera:getCameraTrans().gameObject
    if self.fightCameraObj then
        self.fightCameraActive = self.fightCameraObj.activeSelf
        self.fightCameraObj:SetActive(false)
    end
end

-- 关闭剧情
function close(self)
    if self.isPop == 0 then
        return
    end

    self.isPop = 0
    self.isCloseing = false

    if self.UITrans then
        self.UITrans:SetParent(GameView.UICache, false)
    end

    if self.UIBaseTrans then
        self.UIBaseTrans:SetParent(GameView.UICache, false)
    end

    if self.UIRootNode then
        self.UIRootNode:SetParent(GameView.UICache, false)
    end

    ----------------该顺序不可变------------------
    -- 关闭UI的deactive先调用，再恢复其他UI（active）
    self:__deActive()
    ----------------该顺序不可变------------------
    -- UI被完全关闭
    self:dispatchEvent(EVENT_CLOSE)
    GameDispatcher:dispatchEvent(EventName.EVENT_UI_CLOSE, self)
    self:destroyPanel()
end

-- 自定义的关闭剧情界面 过渡
function customCloseStory(self)
    self.isCustomClose = true

    if self.waitChooseCall then
        self.waitChooseCall = nil
    end

    -- 还原初始相机
    if not self.isOpenInEditor and self.defCameraObj then
        if self.defCameraObj then
            self.defCameraObj:SetActive(self.defSceneActive)
        end

        if self.fightCameraObj and not gs.GoUtil.IsGoNull(self.fightCameraObj) then
            self.fightCameraObj:SetActive(self.fightCameraActive)
        end
    end
    GameView:setUIDNode(true)
    self:destoryPrefabCall(true)
    self:destoryClickPrefabCall()
    self:destoryMultipPrefabCall()

    self.mIsAutoEnable = true
    self.mClickImg.gameObject:SetActive(false)

    self:stopAllAudio()
    self.mSceneView:callStorySkip()
    self.mSceneView:Destroy()

    self.mFlashEff.color = gs.COlOR_BLACK
    -- gs.ColorUtil.SetColorA(self.mFlashEff, 0)
    -- self.mFlashEff:DOFadeR(1, self.mCloseTime)
    -- self:setTimeout(self.mCloseTime, function()

    storyTalk.StoryTalkManager:setNotAllowdPlay(false)
    AudioManager:stopStoryMusic()
    AudioManager:resumeMusicByFade(0)

    GameDispatcher:dispatchEvent(EventName.CLOSE_STORY_TALK_PANEL)
    -- end)
end

function stopAllAudio(self)
    for _, snId in pairs(self.mPlayAudioList) do
        AudioManager:stopAudioBySnId(snId)
    end
    self.mPlayAudioList = {}
end

-- 初始化UI
function configUI(self)
    self:initCustomDataValue()
    self.mOneTalkFinishedLock = MultiLock.new()

    self.mClickImg = self:getChildGO("mClickImg")

    self.mStoryTalkScene = self:getChildGO("mStoryTalkScene")
    self.mSceneView = UI.new(storyTalk.StoryTalkSceneView)
    self.m2DView = UI.new(storyTalk.StoryTalk2DView)

    self.mSceneView:initData(self.mStoryTalkScene)
    self.mCreatePrefabRoot = self:getChildGO("mCreatePrefabRoot")
    self.m2DView:initData(self.mStoryTalkScene, self.mCreatePrefabRoot)

    self.mStoryBGComponent = self.mSceneView:getChildGO("BG"):GetComponent(ty.StoryBGComponent)
    self.mStoryBGComponent:SetSartEvent(function(eventType, url, isLoop)
        if eventType == 3 then
            local audioData = AudioManager:playSoundEffect(url, isLoop == 1)
            if audioData then
                table.insert(self.mPlayAudioList, audioData.m_snId)
                local index = string.find(audioData.m_path, "story_cv/")
                if index ~= nil then
                    self.mAutoTime = 0
                    self.mAutoNeedTime = audioData.m_source.clip.length + 1
                end
            end
        end
    end)

    self.mStoryBGComponent:SetEndEvnet(function(eventType, url)
        if eventType == 3 then
            local index = string.find(url, "story_cv/")
            if index == nil then
                AudioManager:stopAudioByUrl(url)
            end
            --self:stopAllAudio()
            -- for _, audioData in pairs(self.mPlayAudioList) do

                --     if audioData.m_path == url then
                    --         AudioManager:stopAudioSound(audioData)
                    --     end
                    -- end
        end
    end)

    self.mStoryBGComponent:SetPlayAniEvent(function(pos, name)
        self.mSceneView:loadAni(pos, name)
    end)

    self.mStoryBGComponent:SetSartListEvent(function(list)
        self.m2DView:viewEventUpdate(list)
    end)
    -- ================================Panel容器层=============================== --
    self.showEffectsList = {}

    -- ================================低层级效果================================ --
    self.mBottomEffLayer = self:getChildGO("mBottomEffLayer")
    self.mBottomEffLayerTrans = self.mBottomEffLayer.transform
    self.mRecallEff = self:getChildGO("mRecallEff"):GetComponent(ty.AutoRefImage)

    -- ================================预制体创建层================================ --
    self.mCreatePrefabRootTrans = self:getChildGO("mCreatePrefabRoot").transform

    -- ================================对话层================================ --

    self.mTalkBlockLayer = self:getChildGO("mTalkBlockLayer")
    self.mTalkBlockLayer:SetActive(false)
    self.mGroup = self:getChildGO("mGroup"):GetComponent(ty.VerticalLayoutGroup)
    self.mGroupRect = self:getChildGO("mGroup"):GetComponent(ty.RectTransform)
    self.mGroupOriPosX = self.mGroup.transform.localPosition.x
    self.mGroupOriPosY = self.mGroup.transform.localPosition.y

    self.mNameLayout = self:getChildGO("mNameLayout")
    self.mNameTxt = self:getChildGO("mNameTxt"):GetComponent(ty.Text)
    self.mMsgTxt = self:getChildGO("mMsgTxt"):GetComponent(ty.Text)
    self.mTalkHeadImg = self:getChildGO("mTalkHeadImg"):GetComponent(ty.AutoRefImage)
    self.mTalkHeadImg.gameObject:SetActive(false)

    -- ================================分支层================================ --
    self.mChooseLayer = self:getChildGO("mChooseLayer")
    self.mChooseLayer:SetActive(false)

    self.mOptionView = storyTalk.StoryTalkOptionView.new()
    self.mOptionView:initData(self.mChooseLayer)

    local function optResult(currentId, talkID)
        self:subWaitEvent("optResult")
        self.curTalkId = talkID
        -- 特殊的添加了当前选中的分支内容
        self.mHistoryView:addTalkID(currentId)
        self:runTalk()
    end
    self.mOptionView:setResultCall(optResult)

    -- ================================按钮层================================ --
    self.mBtnLayer = self:getChildGO("mBtnLayer")
    self.mHistoryBtn = self:getChildGO("mHistoryBtn")
    self.mHistoryTxt = self:getChildGO("mHistoryTxt"):GetComponent(ty.Text)

    self.mAutoBtn = self:getChildGO("mAutoBtn")
    self.mAutoRunTrans = self:getChildTrans("mAutoRunImg")
    self.mAutoTxt = self:getChildGO("mAutoTxt"):GetComponent(ty.AutoRefImage)

    self.mSkipBtn = self:getChildGO("mSkipBtn")
    self.mSkipTxt = self:getChildGO("mSkipTxt"):GetComponent(ty.Text)

    self.mHideBtn = self:getChildGO("mHideBtn")
    self.mHideTxt = self:getChildGO("mHideTxt"):GetComponent(ty.Text)

    -- ================================历史层================================ --
    self.mHistoryLayer = self:getChildGO("mHistoryLayer")
    self.mHistoryLayer:SetActive(false)
    self.mScrollView = self:getChildGO("mScrollView"):GetComponent(ty.ScrollRect)
    self.mHistoryTxt = self:getChildGO("mHistoryTxt"):GetComponent(ty.Text)

    self.mHistoryView = storyTalk.StoryTalkHistoryView.new()
    self.mHistoryView:initData(self.mHistoryLayer)

    local function hideHistoryResult()
        self:subWaitEvent("hideHistoryResult")
    end
    self.mHistoryView:setCloseCall(hideHistoryResult)

    -- ================================剧本层================================ --
    self.mStoryScrollLayer = self:getChildGO("mStoryScrollLayer")
    self.mStoryScrollLayer:SetActive(false)

    self.mStoryScrollView = storyTalk.StoryScrollView.new()
    self.mStoryScrollView:initData(self.mStoryScrollLayer)

    -- ================================高层级效果================================ --
    self.mTopEffLayer = self:getChildGO("mTopEffLayer")
    self.mTopEffLayerTrans = self.mTopEffLayer.transform
    self.mFlashEff = self:getChildGO("mFlashEff"):GetComponent(ty.AutoRefImage)

    -- ================================顶层遮挡================================ --
    self.mTopMask = self:getChildGO("mTopMask")
    -- ================================视频层================================ --
    self.mVideoLayer = self:getChildGO("mVideoLayer")
    VideoAdaptUtil:updateSize(self:getChildGO("mAVProVideo"):GetComponent(ty.RectTransform), 2)
    self.mVideoLayer:SetActive(false)
    self.mAvproPlayer = self:getChildGO("MediaPlayer"):GetComponent(ty.MediaPlayer)
    AvproUtil:init(self.mAvproPlayer)
    self.mAvproPlayer.Events:AddListener(function(mediaPlayer, eventType, errorCode)
        if (eventType == gs.MediaPlayerEventType.FinishedPlaying) then
            self:onJumVideoClick()
        end
    end)

    self.mBtnResetHide = self:getChildGO("mBtnResetHide")
    self.mJumpVideoBtn = self:getChildGO("mJumpVideoBtn")
    self.mJumpVideoBtn:SetActive(false)
    self:addBtnClickOption()
    self:updateDefClickState()
end

function setSandCus(self)
    self.mSceneView:hideRenderCamera()
end

-- 未被管理的自定义数据值
function initCustomDataValue(self)
    self.mAutoOneWordTime = 0.2 -- 自动点击单字时间
    self.mAutoNeedTime = 3      -- 自动点击最短时间
    self.mAutoRunImgFrame = 1   -- 自动背景旋转帧间隔
    self.mPlayAudioDatas = {}   -- 在播放中的音效
    self.mWaitPrintTime = 0.04  -- Msg打字时间间隔
    self.mOptionData = {}       -- 分支选项记录 [1] 普通分支 [2] 特殊分支(需要全选)
    -- self.mDisableAuto = false -- 禁止自动操作

    self.mNeedWaitSomething = 0
    self.mCloseTime = 0 -- 结束剧情的过渡时间
    self.canWaitIds = {}

    self.mMinWaitTime = 0.2 -- 最小等待时间

    self.mPlayAudioList = {}
    self.mAutoTime = 0
end

-- 添加按钮的各类监听
function addBtnClickOption(self)
    self:addOnClick(self.mClickImg, self.onPlayerClick)
    self:addOnClick(self.mHistoryBtn, self.onHistoryClick)
    self:addOnClick(self.mAutoBtn, self.onAutoClick)
    self:addOnClick(self.mSkipBtn, self.onSkipClick)

    self:addOnClick(self.mJumpVideoBtn, self.onJumVideoClick)

    self:addOnClick(self.mHideBtn, self.onHideClick)
    self:addOnClick(self.mBtnResetHide, self.onBtnResetHideClick)
end

function onHideClick(self)
    self.isHideLayer = true
    self.mTalkBlockLayer:SetActive(false)
    self.mBtnResetHide:SetActive(true)

    self.mBtnLayer:SetActive(false)
    self.mChooseLayer:SetActive(false)

    StorageUtil:saveBool0(gstor.STORY_AUTO, false) -- 保存自动状态到本地

    if self.mAutoSn then
        LoopManager:removeFrameByIndex(self.mAutoSn)
        self.mAutoSn = nil
    end
    if self.mRotationAutoSn then
        LoopManager:removeFrameByIndex(self.mRotationAutoSn)
        self.mRotationAutoSn = nil
    end
    self.mIsAutoEnable = false
    StorageUtil:saveBool0(gstor.STORY_AUTO, self.mIsAutoEnable) -- 保存自动状态到本地
    GameView:setUIDNode(false)
end

function onBtnResetHideClick(self)
    GameView:setUIDNode(true)
    self.mTalkBlockLayer:SetActive(self.dialog == 1)
    self.mBtnResetHide:SetActive(false)

    self.mBtnLayer:SetActive(true)
    self.mChooseLayer:SetActive(true)

    self.isHideLayer = false
end

-- 更新默认的点击状态
function updateDefClickState(self)
    self.mIsAutoEnable = StorageUtil:hasKey0(gstor.STORY_AUTO) and StorageUtil:getBool0(gstor.STORY_AUTO) == true
    if self.mIsAutoEnable then
        self.mAutoSn = LoopManager:addFrame(0, 0, self, self.autoRunTalk)
        self.mRotationAutoSn = LoopManager:addFrame(self.mAutoRunImgFrame, 0, self, self.rotationAutoState)
    end
end

-- 玩家点击
function onPlayerClick(self)
    self.mAutoTime = 0
    if (self.mOneTalkFinishedLock:isAllUnlocked()) then
        self:runTalk()
    end
    self.clickData = AudioManager:playSoundEffect(UrlManager:getUIBaseSoundPath("ui_story_click.prefab"))
end

-- 历史回顾点击
function onHistoryClick(self)
    self:addWaitEvent("onHistoryClick")
    self.mHistoryView:open()
end

-- 自动按钮点击
function onAutoClick(self)
    self.mIsAutoEnable = not self.mIsAutoEnable
    StorageUtil:saveBool0(gstor.STORY_AUTO, self.mIsAutoEnable) -- 保存自动状态到本地

    if self.mIsAutoEnable then
        self.mAutoSn = LoopManager:addFrame(0, 0, self, self.autoRunTalk)
        self.mRotationAutoSn = LoopManager:addFrame(self.mAutoRunImgFrame, 0, self, self.rotationAutoState)
    else
        if self.mAutoSn then
            LoopManager:removeFrameByIndex(self.mAutoSn)
            self.mAutoSn = nil
        end
        if self.mRotationAutoSn then
            LoopManager:removeFrameByIndex(self.mRotationAutoSn)
            self.mRotationAutoSn = nil
        end
    end
end

-- 跳过按钮点击
function onSkipClick(self)
    self.mOneTalkFinishedLock:unlockAll()
    self:customCloseStory()
end

-- 旋转自动按钮的背景图
function rotationAutoState(self)
    gs.TransQuick:SetLRotation(self.mAutoRunTrans, 0, 0, gs.TransQuick:GetRotationZ(self.mAutoRunTrans) - 3)
end

function addWaitEvent(self, str)
    cusLog("添加了需要等待的事件:" .. str)
    self.mNeedWaitSomething = self.mNeedWaitSomething + 1
end

function subWaitEvent(self, str)
    cusLog("减少了需要等待的事件:" .. str)
    self.mNeedWaitSomething = self.mNeedWaitSomething - 1
end

-- 自动点击逻辑
function autoRunTalk(self)
    self.mAutoTime = self.mAutoTime + gs.Time.deltaTime

    if self.mOneTalkFinishedLock:isAllUnlocked() and self.mAutoTime >= self.mReadTotalTime and self.mAutoTime >=
        self.mAutoNeedTime and self.mNeedWaitSomething <= 0 then
        self.mAutoTime = 0
        self:runTalk()
    end
end

function onChooseClick(self, args)
    if self.lastList and table.indexof01(self.lastList, args.talkID) <= 0 then
        table.insert(self.lastList, args.talkID)
    end
end

function onChooseClose(self)
    self.lastList = {}
end

function showMask(self)
    self.mTopMask:SetActive(true)
end

function active(self)
    self.isHideLayer = false
    GameDispatcher:addEventListener(EventName.STORY_CHOOSE_CLICK, self.onChooseClick, self)
    GameDispatcher:addEventListener(EventName.CLOSE_CHOOSE_CLICK, self.onChooseClose, self)
    GameDispatcher:addEventListener(EventName.STORY_SHOW_MASK, self.showMask, self)
    GameDispatcher:addEventListener(EventName.STORY_BACK_TO_STORY, self.onBack2Story, self)
    storyTalk.StoryTalkManager:setNotAllowdPlay(true)
    self:initView()

    local sceneCtrl = map.MapLoader:getCurSceneCtrl()
    if sceneCtrl then
        sceneCtrl:pauseMapEnvAudio()
    end

    AudioManager:pauseMusicByFade(0)
end

function deActive(self)
    self.isCustomClose = true

    GameDispatcher:removeEventListener(EventName.STORY_CHOOSE_CLICK, self.onChooseClick, self)
    GameDispatcher:removeEventListener(EventName.CLOSE_CHOOSE_CLICK, self.onChooseClose, self)
    GameDispatcher:removeEventListener(EventName.STORY_SHOW_MASK, self.showMask, self)
    GameDispatcher:removeEventListener(EventName.STORY_BACK_TO_STORY, self.onBack2Story, self)
    self.mSceneView:destroy()
    self.m2DView:destroy()
    local sceneCtrl = map.MapLoader:getCurSceneCtrl()
    if sceneCtrl then
        sceneCtrl:resumeMapEnvAudio()
    end

    if self.mAvproPlayer then
        self.mAvproPlayer:Stop()
        self.mAvproPlayer:CloseVideo()
        self.mAvproPlayer.Events:RemoveAllListeners()
        self.mAvproPlayer = nil
    end

    if self.loopSn then
        LoopManager:removeFrameByIndex(self.loopSn)
        self.loopSn = nil
    end
    if self.mAutoSn then
        LoopManager:removeFrameByIndex(self.mAutoSn)
        self.mAutoSn = nil
    end

    if self.mRotationAutoSn then
        LoopManager:removeFrameByIndex(self.mRotationAutoSn)
        self.mRotationAutoSn = nil
    end

    if self.mPrintSn then
        LoopManager:clearTimeout(self.mPrintSn)
        self.mPrintSn = nil
    end

    if self.runTalkSn then
        LoopManager:removeTimerByIndex(self.runTalkSn)
        self.runTalkSn = nil
    end

    if self.destorySn then
        LoopManager:removeTimerByIndex(self.destorySn)
        self.destorySn = nil
    end

    local curSotryID = self.mCurStoryRo:getRefID()
    if (curSotryID == 10011) then
        GameDispatcher:dispatchEvent(EventName.REQ_GAME_REPORT, {
            key = stepReport.GAME_REPORT_STEP.FIRST_GUIDE_STORY_END,
            value = nil
        })
    end
end

function onBack2Story(self, passData)
    GameView:SceneStoryHideUI()
    self:subWaitEvent("第三方")
    self:setActive(true)
    self:runTalk()
end

-- 初始化剧情信息
function initView(self)
    self.mBtnResetHide:SetActive(false)
    self.mCurStoryRo = storyTalk.StoryTalkManager:getCurStoryRo()

    if not self.mCurStoryRo then
        print("没有获得剧情数据")
        return
    end

    GameView:SceneStoryHideUI()

    local tempData = {
        img = "arts/storyPrefab/prefab/common/texture/black.png"
    }
    self.mSceneView:updateSceneBGBegin(tempData)
    self.mCurSotryID = self.mCurStoryRo:getRefID()
    self.mSkipBtn:SetActive(storyTalk.StoryTalkManager:canPassStory(self.mCurSotryID))
    self.mBGMusicPlay = false
    self.mCurTalkDatas = self.mCurStoryRo:getTalkGroup()
    if self.mCurTalkDatas == nil then
        self:customCloseStory()
        return
    end

    for k, v in pairs(self.mCurTalkDatas) do
        v.refId = k
    end

    if self.startTalkId then
        self.curTalkId = self.startTalkId
        self.startTalkId = nil
    else
        local keys = table.keys(self.mCurTalkDatas)
        table.sort(keys)
        self.curTalkId = keys[1]
    end

    self.mHistoryView:setTalkDatas(self.mCurTalkDatas)
    self.mOptionView:setTalkDatas(self.mCurTalkDatas)
    self:runTalk()
end

-- 开始展示内容
function runTalk(self)
    if self.isCustomClose or self.mOptionView:isActive() then
        return
    end

    self.mAutoTime = 0

    -- 如果还没有打完字
    if self.mPrintSn then
        self:onStopPrint()
        return
    end

    if self.waitChooseCall then
        self.waitChooseCall()
        self.waitChooseCall = nil
        return
    end
    local curData = self.mCurTalkDatas[self.curTalkId]

    cusLog("还有未完成的事件数:" .. self.mNeedWaitSomething)
    if self.mNeedWaitSomething > 0 then
        return
    end

    -- 当前段落的数据
    local curData = self.mCurTalkDatas[self.curTalkId]
    if not curData then
        self:customCloseStory()
        return
    end

    -- 当前段落初始化
    curData.curTalkId = self.curTalkId

    -- 音效相关
    self:stopAllAudio()
    self:playMusic(curData)

    if curData.pType ~= 5 and curData.dialog == 1 then
        self.mHistoryView:addTalkID(self.curTalkId) -- 添加到历史列表
    end

    if table.indexof01(self.canWaitIds, self.curTalkId) > 0 then
        self:destoryPrefabCall()
        self.canWaitIds = {}
    end

    self:OneTalkFinished(curData)
end

-- 一帧剧情结束
function OneTalkFinished(self, curData)
    local function finishCall()
        self:setTalkData(curData) -- 新一帧动画开始

        local optData = self.mOptionData[self.curTalkId]
        if optData then
            if self.lastList == nil then
                self.lastList = {}
            end

            local function openView()
                self:addWaitEvent("optData")
                self.mOptionView:open(optData, self.lastList, curData.last_id, curData.special_id)
            end
            self.waitChooseCall = openView

            if curData.pType == 5 then
                self.waitChooseCall()
                self.waitChooseCall = nil
            end
        end
    end

    -- 需要黑屏过渡过来的情况
    if curData.grad_time > 0 and self.curTalkId > 1 then
        self:addWaitEvent("gradTime")
        self.mFlashEff.color = gs.COlOR_BLACK
        gs.ColorUtil.SetColorA(self.mFlashEff, 0)

        self.gradTweenFront = self.mFlashEff:DOFadeR(1, curData.grad_time / 200)

        local function gradTweenFrontFinishCall()
            local function allTweenFinishCall()
                self:subWaitEvent("allTweenFinishCall")
            end
            finishCall()
            self.gradTweenBefore = self.mFlashEff:DOFadeR(0, curData.grad_time / 200)
            LoopManager:setTimeout(curData.grad_time / 200, self, allTweenFinishCall)
        end
        LoopManager:setTimeout(curData.grad_time / 200, self, gradTweenFrontFinishCall)
    else -- 不需要黑屏过渡
        -- 背景淡出效果
        self.mOneTalkFinishedLock:lock("updateSceneBGEnd")
        self.mSceneView:updateSceneBGEnd(curData, function()
            self.mOneTalkFinishedLock:unlock("updateSceneBGEnd", finishCall)
        end)
    end
end

-- 获取剧情音乐音量系数
function getStoryMusicVolume(self, data)
    local musicVolume = 1
    if data.page_show_effect and data.page_show_effect[storyTalk.PageShowEffect.backgroundMusicVolume] then
        musicVolume = data.page_show_effect[storyTalk.PageShowEffect.backgroundMusicVolume]
        if (musicVolume < 0.000001) then -- 解决配置生成问题（配置生成用了反射，值默认为0，但配置表不填表示音量为1）
            musicVolume = 1
        end
    end
    return musicVolume
end

-- 播放/停止背景音乐
function playMusic(self, data)
    local volume = self:getStoryMusicVolume(data)
    if string.find(data.music_id, " ") then -- 多个背景音乐id同时播放
        local musicList = LuaUtil:split(data.music_id, " ")
        for _, musicId in pairs(musicList) do
            musicId = tonumber(musicId)
            if musicId > 0 then
                AudioManager:playStoryBG(musicId, volume)
            end
        end
        return
    end

    data.music_id = tonumber(data.music_id)
    -- 0 不操作 |  正数：播放对应id的背景音乐 | 负数：停止播放背景音乐
    if data.music_id == 0 then
        return
    elseif data.music_id > 0 then
        AudioManager:stopStoryMusic()
        self.mBGMusicPlay = true
        AudioManager:playStoryBG(data.music_id, volume)
    else                                         -- 停止播放背景音乐
        local music_id = math.abs(data.music_id) -- 负数变正数
        if music_id == 1 then                    -- 音乐立即停止
            AudioManager:stopStoryMusic()
        elseif music_id == 2 then                -- 音乐逐渐退出
            self.mOneTalkFinishedLock:lock("pauseAllStoryBGByFade")
            AudioManager:pauseAllStoryBGByFade(2, function()
                self.mOneTalkFinishedLock:unlock("pauseAllStoryBGByFade")
            end)
        else
            AudioManager:pauseStoryBGByFade(music_id)
        end
    end
end

-- 新一帧动画的开始，设置剧情内容
function setTalkData(self, curData)
    -- 关闭原对话框
    if self.mTalkBlockLayer and self.mTalkBlockLayer.name == "mTalkBlockLayer" then
        self.mTalkBlockLayer:SetActive(false)
    end
    -- 回忆效果
    self.mRecallEff.gameObject:SetActive(curData.is_memory == 1)

    -- 如果非分支选项
    if table.empty(curData.abreast_id) then
        self.curTalkId = curData.next_id
    else
        -- 如果是分支则将普通分支和特殊分支分别存储
        local optData = {}
        optData["abreastList"] = table.copy(curData.abreast_id)
        optData["lastId"] = table.copy(curData.last_id)
        self.mOptionData[self.curTalkId] = optData
    end

    if curData.pType ~= 5 then -- 5代表着连续分支
        self:runCGType(curData)

        self:addWaitEvent("minWaitTime")
        LoopManager:setTimeout(self.mMinWaitTime, self, function()
            self:subWaitEvent("minWaitTime")
        end)
    end
end

-- 设置传统的对话剧情内容
function setTalkTraditionalDialogContent(self, curData)
    -- ================================背景框================================ --
    self.mTalkBlockLayer:GetComponent(ty.Image).color = gs.COlOR_WHITE

    -- ================================头像框================================ --
    if curData.head_path == "" then
        self.mTalkHeadImg.gameObject:SetActive(false)
    else
        self.mTalkHeadImg:SetImg(curData.head_path)
        self.mTalkHeadImg.gameObject:SetActive(true)
    end

    -- ================================名字================================ --
    local playerName = role.RoleManager:getRoleVo():getPlayerName() or _TT(72202)
    self.mNameTxt.text = string.gsub(curData.talker, _TT(72202), playerName)
    if #curData.talker > 0 then
        self.mGroup.padding.top = 12
        self.mGroup.childAlignment = gs.TextAnchor.UpperCenter
    else
        self.mGroup.padding.top = 0
        self.mGroup.childAlignment = gs.TextAnchor.MiddleCenter
    end

    self.mNameLayout:SetActive(#curData.talker > 0)

    -- ================================内容================================ --
    -- 设置锚点为左上角
    self.mGroupRect.anchorMin = gs.Vector2(0.5, 0.5)
    self.mGroupRect.anchorMax = gs.Vector2(0.5, 0.5)
    self.mGroup.transform.localPosition = gs.Vector3(self.mGroupOriPosX, self.mGroupOriPosY,
        self.mGroup.transform.localPosition.z)
    self.mMsgTxt.fontSize = curData.msg_size == 0 and 24 or curData.msg_size
    self.mMsgTxt.color = curData.msg_color == "" and gs.ColorUtil.GetColor(ColorUtil.WHITE_NUM) or
        gs.ColorUtil.GetColor(curData.msg_color)

    self.msg = string.gsub(curData.msg, _TT(72202), playerName)
    self.mMsgChar = string.toCharArray(self.msg)
    self.mReadTotalTime = #self.mMsgChar * self.mAutoOneWordTime
    self.mLastPrintIndex = 1
    self.mCurrentMsgLen = #self.mMsgChar

    self.mMsgTxt.text = ""

    self:addWaitEvent("printMsg")
    -- self.mNeedWaitSomething = self.mNeedWaitSomething + 1
    self:onStartPrint()

    self.dialog = curData.dialog

    -- ================================头像层================================ --
    self.mTalkBlockLayer:SetActive(curData.dialog == 1 and self.isHideLayer == false)
end

-- 设置策划自定义的对话剧情内容
function setTalkCustomDialogContent(self, curData)
    -- ================================背景框================================ --
    self.mTalkBlockLayer:GetComponent(ty.Image).color = gs.ColorUtil.GetColor("FFFFFF00")

    -- ================================头像框================================ --
    self.mTalkHeadImg.gameObject:SetActive(false)

    -- ================================名字================================ --
    self.mNameLayout:SetActive(false)

    -- ================================内容================================ --
    -- 设置锚点为左上角
    self.mGroupRect.anchorMin = gs.Vector2(0, 0.5)
    self.mGroupRect.anchorMax = gs.Vector2(0, 0.5)
    self.mGroupRect.anchoredPosition = gs.Vector2(curData.page_show_effect[storyTalk.PageShowEffect.wordOffsetX],
        curData.page_show_effect[storyTalk.PageShowEffect.wordOffsetY])

    local playerName = role.RoleManager:getRoleVo():getPlayerName() or _TT(72202)
    -- 文字框
    self.mMsgTxtRect = self.mMsgTxt:GetComponent(ty.RectTransform)
    self.mMsgTxtRect.sizeDelta = gs.Vector2(1000, self.mMsgTxtRect.sizeDelta.y) -- 设置文字框的宽度
    self.mMsgTxt.fontSize = curData.msg_size == 0 and 24 or curData.msg_size
    self.mMsgTxt.color = curData.msg_color == "" and gs.ColorUtil.GetColor(ColorUtil.WHITE_NUM) or
        gs.ColorUtil.GetColor(curData.msg_color)

    self.msg = string.gsub(curData.msg, _TT(72202), playerName)
    self.mMsgChar = string.toCharArray(self.msg)
    self.mReadTotalTime = #self.mMsgChar * self.mAutoOneWordTime
    self.mLastPrintIndex = 1
    self.mCurrentMsgLen = #self.mMsgChar

    self.mMsgTxt.text = ""

    self:addWaitEvent("printMsg")
    -- self.mNeedWaitSomething = self.mNeedWaitSomething + 1
    self:onStartPrint()

    -- ================================头像层================================ --
    self.mTalkBlockLayer:SetActive(true and self.isHideLayer == false)
end

-- 区分主线和活动剧情
function isMainStory(self)
    -- 主线都是以x0开头，比如10011、20023、30011
    -- 活动剧情id都是以44开头
    local index = math.floor(self.mCurSotryID / 1000)
    return index ~= 44 and index < 70 -- 从主线第七章开始，因为没钱配音，所以加上打字音(临时)
end

-- 开始打字
function onStartPrint(self)
    if self.mCurrentMsgLen > self.mLastPrintIndex then
        local char = self.mMsgChar[self.mLastPrintIndex]
        self.mMsgTxt.text = self.mMsgTxt.text .. char
        self.mLastPrintIndex = self.mLastPrintIndex + 1
        self.mPrintSn = LoopManager:setTimeout(self.mWaitPrintTime, self, self.onStartPrint)
        -- 打字音(短)
        if not self:isMainStory() and self.mPrintSoundEffect == nil then -- 主线剧情都有配音，无需打字音
            self.mPrintSoundEffect = AudioManager:playSoundEffect(UrlManager:getStorySoundPath("sfx_jq_1.4_01.prefab"),
                true)
            if self.mPrintSoundEffect then
                table.insert(self.mPlayAudioList, self.mPrintSoundEffect.m_snId)
            end
        end
    else
        self:onStopPrint()
    end
end

-- 停止打字
function onStopPrint(self)
    if self.mPrintSoundEffect then
        AudioManager:stopAudioBySnId(self.mPrintSoundEffect.m_snId)
        self.mPrintSoundEffect = nil
    end

    LoopManager:clearTimeout(self.mPrintSn)
    self:subWaitEvent("printMsg")
    -- self.mNeedWaitSomething = self.mNeedWaitSomething - 1
    -- self.mDisableAuto = false
    self.mPrintSn = nil
    self.mMsgTxt.text = self.msg

    -- if self.waitChooseCall then
    --     self.waitChooseCall()
    --     self.waitChooseCall = nil
    -- end
end

function runCGType(self, curData)
    logInfo("当前播放剧情Id:" .. self.mCurSotryID .. "| 段落Id:" .. curData.refId)

    if (self.mCurSotryID == 10011 and curData.refId == 1) then
        GameDispatcher:dispatchEvent(EventName.REQ_GAME_REPORT, {
            key = stepReport.GAME_REPORT_STEP.FIRST_GUIDE_STORY_START,
            value = nil
        })
    end

    if (self.mCurSotryID == 10011 and curData.refId == 2) then
        GameDispatcher:dispatchEvent(EventName.REQ_GAME_REPORT, {
            key = stepReport.GAME_REPORT_STEP.FIRST_STORY_START,
            value = nil
        })
    end

    -- Panel级别的效果
    self.mOneTalkFinishedLock:lock("SceneViewBegin")
    self.mSceneView:updateSceneBGBegin(curData, self.mFlashEff, function()
        self.mOneTalkFinishedLock:unlock("SceneViewBegin", function()
            if curData.page_show_effect then
                local wordOffsetX = curData.page_show_effect[storyTalk.PageShowEffect.wordOffsetX]
                local wordOffsetY = curData.page_show_effect[storyTalk.PageShowEffect.wordOffsetY]
                -- 判断上述两个值是否为0，如果为0则不需要偏移
                if wordOffsetX and wordOffsetY and wordOffsetX ~= 0 or wordOffsetY ~= 0 then
                    self:setTalkCustomDialogContent(curData)
                else
                    self:setTalkTraditionalDialogContent(curData)
                end
            else
                self:setTalkTraditionalDialogContent(curData)
            end
        end)
    end)

    -- 特效效果
    self.mSceneView:destoryEff()
    if curData.page_show_effect then
        if curData.page_show_effect[storyTalk.PageShowEffect.backgroundStopEffects] then
            self:destroyPanelEff(curData.page_show_effect[storyTalk.PageShowEffect.backgroundStopEffects])
        end
    end

    if curData.effUrl and curData.effUrl ~= "" then
        local v3 = gs.Vector3(0, 0, 0)
        if curData.effPos then
            v3 = gs.Vector3(curData.effPos[1], curData.effPos[2], curData.effPos[3])
        end
        self.mSceneView:loadEff(curData.effUrl, v3)
    end
    if curData.page_show_effect then
        if curData.page_show_effect[storyTalk.PageShowEffect.backgroundStartEffects] then
            self:setPanelEff(curData.page_show_effect[storyTalk.PageShowEffect.backgroundStartEffects])
        end
    end

    -- 3D模型默认CG类型
    if curData.cg_type == storyTalk.CGType.Model then
        self:modelUpdate(curData)
        -- 2D模型默认CG类型
        -- elseif curData.cg_type == storyTalk.CGType.Model2D then
        --     self:model2DUpdate(curData)
        -- 2D贴图默认CG类型
    elseif curData.cg_type == storyTalk.CGType.Texture2D then
        self:texture2DUpdate(curData)
        -- 章节动画
    elseif curData.cg_type == storyTalk.CGType.MainMapFinish then
        self:mainMapAni()
        -- 画质选择
    elseif curData.cg_type == storyTalk.CGType.Quality then
        self:openCGTypeView(EventName.OPEN_QUALITY_CHOOSE_VIEW)
        -- 起名
    elseif curData.cg_type == storyTalk.CGType.ReName then
        self:openCGTypeView(EventName.OPEN_ROLE_TO_NAME_PANEL)
        -- 动态字幕
    elseif curData.cg_type == storyTalk.CGType.ScrollCG then
        local function finishCall()
            self:runTalk()
        end
        self.mStoryScrollView:open(curData, finishCall)
    elseif curData.cg_type == storyTalk.CGType.CreatePrefab then
        self:prefabEffectsUpdate(curData)

        if curData.runTalkTime > 0 then
            self:onStopPrint()
            self.runTalkSn = LoopManager:addTimer(curData.runTalkTime / 1000, 1, self, self.runTalkCall)
        end

        if curData.destoryTime > 0 then
            self.destorySn = LoopManager:addTimer(curData.destoryTime / 1000, 1, self, self.destoryPrefabCall)
        end

        self.canWaitIds = curData.waitIDs
    elseif curData.cg_type == storyTalk.CGType.Video then
        self.currentHideTimer = 0
        self.mNeedHideTimer = 2
        self.lastCurPosX = gs.UnityEngineUtil.GetMousePosX()
        self.lastCurPosY = gs.UnityEngineUtil.GetMousePosX()

        self.hideCursorSn = LoopManager:addFrame(0, 0, self, self.hideCursorHandler)

        self:addWaitEvent("video")
        -- self.mNeedWaitSomething = self.mNeedWaitSomething + 1
        local function showJumpBtn()
            self.mJumpVideoBtn:SetActive(true)
        end
        LoopManager:setTimeout(5, self, showJumpBtn)

        self.mVideoLayer:SetActive(true)
        self.openPath = gs.PathUtil.GetExistFullPath(curData.video_url) -- gs.PathUtil.GetExistFullPath("extra/video/ui/aoyi_cg.mp4")
        if (self.mAvproPlayer) then
            self.mAvproPlayer:Stop()
            self.mAvproPlayer:CloseVideo()
            self.mAvproPlayer:OpenVideoFromFile(gs.MediaPlayer.FileLocation.AbsolutePathOrURL, self.openPath, false)
            self.mAvproPlayer:Play()

            local volume = AudioManager:getMusicVolume() * AudioManager:getTotalVolume()
            local totalVolumeSwitch = systemSetting.SystemSettingManager:getSystemSettingBoolValue(
                systemSetting.SystemSettingDefine.totalVolumeSwitch)
            local musicVolumeSwitch = systemSetting.SystemSettingManager:getSystemSettingBoolValue(
                systemSetting.SystemSettingDefine.musicVolumeSwitch)
            if totalVolumeSwitch and musicVolumeSwitch then

            else
                volume = 0
            end
            AvproUtil:setVolume(self.mAvproPlayer, volume)
        end
    elseif curData.cg_type == storyTalk.CGType.Click then
        self:addWaitEvent("click")
        -- self.mNeedWaitSomething = self.mNeedWaitSomething + 1
        self.createClickGo = AssetLoader.GetGO(curData.prefab_path)
        self.createClickGo.transform:SetParent(self.mCreatePrefabRootTrans, false)

        self.createClickGo.transform:Find("mClickBtn"):GetComponent(ty.Button).onClick:AddListener(function()
            self:destoryClickPrefabCall()
            self:runTalk()
        end)
    elseif curData.cg_type == storyTalk.CGType.Multiple then
        self.needClick = curData.clickTimes
        self.currentClick = 0
        self:addWaitEvent("multiple")
        -- self.mNeedWaitSomething = self.mNeedWaitSomething + 1
        self.createMultipeClickGo = AssetLoader.GetGO(curData.prefab_path)
        self.createMultipeClickGo.transform:SetParent(self.mCreatePrefabRootTrans, false)
        self.createMultipeClickGo.transform:Find("mTxtTimer"):GetComponent(ty.Text).text = self.currentClick .. "/" ..
            self.needClick
        self.createMultipeClickGo.transform:Find("mClickBtn"):GetComponent(ty.Button).onClick:AddListener(function()
            self.currentClick = self.currentClick + 1
            self.createMultipeClickGo.transform:Find("mTxtTimer"):GetComponent(ty.Text).text =
                self.currentClick .. "/" .. self.needClick

            if self.currentClick >= self.needClick then
                self:destoryMultipPrefabCall()
                self:runTalk()
            end
        end)
    elseif curData.cg_type == storyTalk.CGType.LongClick then
        self.needTimer = curData.clickTimes
        self.currentTimer = 0
        self:addWaitEvent("longClick")
        -- self.mNeedWaitSomething = self.mNeedWaitSomething + 1
        self.createLongClickGo = AssetLoader.GetGO(curData.prefab_path)
        self.createLongClickGo.transform:SetParent(self.mCreatePrefabRootTrans, false)

        self.createLongClickGo.transform:Find("mTxtTimer"):GetComponent(ty.Text).text = string.format("%.2f",
            self.currentTimer) .. "/" .. self.needTimer

        self.createLongClickGo.transform:Find("mClickBtn"):GetComponent(ty.LongPressOrClickEventTrigger).onPointerUp
            :AddListener(
                function()
                    if self.loopSn then
                        LoopManager:removeFrameByIndex(self.loopSn)
                        self.loopSn = nil
                    end
                end)
        self.createLongClickGo.transform:Find("mClickBtn"):GetComponent(ty.LongPressOrClickEventTrigger).onPointerDown
            :AddListener(
                function()
                    self.loopSn = LoopManager:addFrame(0, 0, self, self.onLoopEvent)
                end)
    end

    if curData.cg_type ~= storyTalk.CGType.Model and curData.cg_type ~= storyTalk.CGType.Model2D and curData.cg_type ~=
        storyTalk.CGType.Texture2D then
        self.mStoryBGComponent:StartPlayTimeLine(self.mCurSotryID, curData.refId)
    end
end

function hideCursorHandler(self)
    if self.lastCurPosX ~= gs.UnityEngineUtil.GetMousePosX() or self.lastCurPosY ~= gs.UnityEngineUtil.GetMousePosX() then
        self.currentHideTimer = 0
    end

    self.currentHideTimer = self.currentHideTimer + gs.Time.deltaTime
    if self.currentHideTimer >= self.mNeedHideTimer then
        gs.Cursor.visible = false
    else
        gs.Cursor.visible = true
    end
    self.lastCurPosX = gs.UnityEngineUtil.GetMousePosX()
    self.lastCurPosY = gs.UnityEngineUtil.GetMousePosX()
end

function onLoopEvent(self)
    self.currentTimer = self.currentTimer + gs.Time.deltaTime

    self.createLongClickGo.transform:Find("mTxtTimer"):GetComponent(ty.Text).text = string.format("%.2f",
        self.currentTimer) .. "/" .. self.needTimer
    self.createLongClickGo.transform:Find("mSliderImg"):GetComponent(ty.Image).fillAmount = self.currentTimer /
        self.needTimer

    if self.currentTimer >= self.needTimer then
        if self.loopSn then
            LoopManager:removeFrameByIndex(self.loopSn)
            self.loopSn = nil
            self:destoryLongTimePrefabCall()
            self:runTalk()
        end
    end
end

function onJumVideoClick(self)
    if (self.mAvproPlayer) then
        self.mAvproPlayer:Stop()
        self.mAvproPlayer:CloseVideo()
    end

    if self.hideCursorSn then
        LoopManager:removeFrameByIndex(self.hideCursorSn)
        self.hideCursorSn = nil
    end
    gs.Cursor.visible = true

    self:subWaitEvent("jumpVideo")
    -- self.mNeedWaitSomething = self.mNeedWaitSomething - 1
    self.mVideoLayer:SetActive(false)
    self:runTalk()
end

function runTalkCall(self)
    self:runTalk()
end

function destoryPrefabCall(self, allDestroy)
    if self.createGo then
        gs.GameObject.Destroy(self.createGo)
        self.createGo = nil
    end
    if allDestroy == true then
        for k, v in pairs(self.showEffectsList) do
            if k.m_layer ~= "camera" then
                gs.GameObject.Destroy(v)
            end
            self.showEffectsList[k] = nil
        end
        self.showEffectsList = {}
    end
end

function destoryClickPrefabCall(self)
    if self.createClickGo then
        gs.GameObject.Destroy(self.createClickGo)
        self.createClickGo = nil
        self:subWaitEvent("destoryClickPrefabCall")
        -- self.mNeedWaitSomething = self.mNeedWaitSomething - 1
    end
end

function destoryMultipPrefabCall(self)
    if self.createMultipeClickGo then
        gs.GameObject.Destroy(self.createMultipeClickGo)
        self.createMultipeClickGo = nil
        self:subWaitEvent("createMultipeClickGo")
        -- self.mNeedWaitSomething = self.mNeedWaitSomething - 1
    end
end

function destoryLongTimePrefabCall(self)
    if self.createLongClickGo then
        gs.GameObject.Destroy(self.createLongClickGo)
        self.createLongClickGo = nil
        self:subWaitEvent("destoryLongTimePrefabCall")
        -- self.mNeedWaitSomething = self.mNeedWaitSomething - 1
    end
end

-- 3D模型操作
function modelUpdate(self, curData)
    self.mSceneView:setOptData(self.mCurSotryID, curData.refId)

    self.mSceneView:setPostEff(curData.is_memory)

    self.mSceneView:modelsChange(curData.model_tid, curData.model_pos)
    self.mSceneView:powersChange(curData.update_model)
    -- 背景震动
    self.mSceneView:stopShake()
    self.mSceneView:shakeAni(curData.shake_ani)
end

-- 2D贴图操作
function texture2DUpdate(self, curData, modelPos)
    self.m2DView:setOptData(self.mCurSotryID, curData.refId)
    self.m2DView:setPostEff(curData.is_memory)
    self.m2DView:texturesChange(curData)
    -- 震動
    if curData.shake_ani and curData.shake_ani ~= 0 then
        self.mSceneView:shakeAni(100)
    end
end

-- 2D模型操作
function model2DUpdate(self, curData)
    print("2D模型暂未支持")
    -- self.mSceneView:setOptData(self.mCurSotryID, curData.refId)
    -- self.mSceneView:setPostEff(curData.is_memory)
    -- self.m2DView:model2DChange(curData)
end

-- 章节动画
function mainMapAni(self)
    if self.isOpenInEditor then
        print("剧情编辑器模式下跳过打开章节动画")
        self:runTalk()
    else
        self:addWaitEvent("mainMapAni")
        -- self.mNeedWaitSomething = self.mNeedWaitSomething + 1
        local function noticeServer()
            if not self.isOpenInEditor then
                SOCKET_SEND(Protocol.CS_MAIN_STORY_PLAY_CHAPTER_PIC, {
                    chapter_id = 1
                })
            end
            self:subWaitEvent("mainMapAni")
            -- self.mNeedWaitSomething = self.mNeedWaitSomething - 1
            self:runTalk()
        end

        GameDispatcher:dispatchEvent(EventName.PLAY_STORY_PIC_ANI, {
            callback = noticeServer,
            id = 1
        })
    end
end

function prefabEffectsUpdate(self, curData)
    if curData.prefab_path then
        self.createGo = AssetLoader.GetGO(curData.prefab_path)
        if self.createGo and not gs.GoUtil.IsGoNull(self.createGo) then
            self.createGo.transform:SetParent(self.mCreatePrefabRootTrans, false)
        end
    end
end

-- 设置场景特效
function setPanelEff(self, prefabData)
    if prefabData then
        for _, v in pairs(prefabData) do
            -- 通过键找值
            local ro = storyTalk.StoryTalkManager:getStoryPrefab(v)
            if ro then
                -- 如果已经ro存在showEffectsList就直接跳过
                if not LuaUtil:isKeyInTable(self.showEffectsList, ro) then
                    local createGo = self:loadEff(ro)
                    if createGo then
                        self.showEffectsList[ro] = createGo
                    end
                end
            else
                logError("剧情配置表 story_prefab_data 不包含 " .. v)
            end
        end
    end
end

function loadEff(self, readOnlyData)
    local go = nil
    -- 对不同层级的特效进行不同的处理
    local layer = readOnlyData:getLayer()
    if layer == "top" then
        go = self:setFXEffect(self.mTopEffLayer, readOnlyData:getPath())
    elseif layer == "bottom" then
        go = self:setFXEffect(self.mBottomEffLayer, readOnlyData:getPath())
    elseif layer == "camera" then
        go = self:setCameraEffect(readOnlyData)
    else
        logError("story_prefab_data : " .. readOnlyData:getPath() .. " 层级错误")
    end
    return go
end

function setFXEffect(self, parentNode, dataPath)
    local createGo = AssetLoader.GetGO(dataPath)
    if createGo and not gs.GoUtil.IsGoNull(createGo) then
        createGo.transform:SetParent(parentNode.transform, false)
        local rectTransform = createGo:GetComponent(ty.RectTransform)
        if rectTransform then
            local parentSizeX, parentSizeY = ScreenUtil:getScreenSize()
            local childSize = rectTransform.rect.size
            local scaleX = parentSizeX / childSize.x
            local scaleY = parentSizeY / childSize.y
            rectTransform.localScale = gs.Vector3(scaleX, scaleY, 1)
        end
    else
        logError("story_prefab_data : " .. dataPath .. " 加载失败")
    end
    return createGo
end

function setCameraEffect(self, readOnlyData)
    return self.mSceneView:setCameraEffect(readOnlyData)
end

function destroyPanelEff(self, prefabData)
    if prefabData then
        for _, v in pairs(prefabData) do
            -- 通过键找值
            local ro = storyTalk.StoryTalkManager:getStoryPrefab(v)
            if ro then
                if LuaUtil:isKeyInTable(self.showEffectsList, ro) then
                    if ro:getLayer() == "camera" then
                        self.mSceneView:destroyCameraEffect(ro)
                    else
                        gs.GameObject.Destroy(self.showEffectsList[ro])
                    end
                    self.showEffectsList[ro] = nil
                end
            end
        end
    end
end

-- 打开CG对应事件页面
function openCGTypeView(self, eventName)
    if self.isOpenInEditor then
        print("剧情编辑器模式下跳过打开CG页面")
        self:runTalk()
    else
        if fight.PlayerManager:getIsRename() then
            self:runTalk()
        else
            self:addWaitEvent(eventName)
            -- self.mNeedWaitSomething = self.mNeedWaitSomething + 1
            self:setActive(false)
            GameView:SceneStoryShowUI()
            GameDispatcher:dispatchEvent(eventName, {
                data = { self.mCurSotryID, self.curTalkId }
            })
        end
    end
end

return _M
