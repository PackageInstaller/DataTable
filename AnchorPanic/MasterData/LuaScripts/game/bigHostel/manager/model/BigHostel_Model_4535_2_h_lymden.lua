-- @FileName:   BigHostel_Model_4535_2_h_lymden.lua
-- @Description:   大宿舍红叶模型
-- @Author: ZDH
-- @Date:   2025-04-21 18:17:45
-- @Copyright:   (LY) 2025 锚点降临

module('game.bigHostel.model.BigHostel_Model_4535_2_h_lymden', Class.impl(bigHostel.BigHostelBaseModel))

--允许切换场景的状态
Idle_State = {
    gs.Animator.StringToHash("SF_idle01"),
    gs.Animator.StringToHash("TW_idle01"),
    gs.Animator.StringToHash("CZ_L_idle02"),
    gs.Animator.StringToHash("CZ_idle"),
    gs.Animator.StringToHash("TW_idle"),
}

--允许注视鼠标的动画
LookAtAniState =
{
    cameraReset_state =
    {
        gs.Animator.StringToHash("SF_idle01"),
        gs.Animator.StringToHash("TW_idle01"),
        gs.Animator.StringToHash("CZ_L_idle02"),
    },
    cameraFree_state =
    {
        gs.Animator.StringToHash("SF_idle01"),
        gs.Animator.StringToHash("TW_idle01"),
        gs.Animator.StringToHash("CZ_L_idle02"),
    },
}
--注视鼠标人物前的距离
LookAtDistance = 0.5

--状态对应的待机trigger
Idle_StateTrigger = {
    [gs.Animator.StringToHash("showStart")] = "idle_1",
    [gs.Animator.StringToHash("SF_enter")] = "idle_1",
    [gs.Animator.StringToHash("SF_idle01")] = "idle_1",
    [gs.Animator.StringToHash("SF_show")] = "idle_1",
    [gs.Animator.StringToHash("SF_twist01")] = "idle_1",
    [gs.Animator.StringToHash("SF_twist02")] = "idle_1",
    [gs.Animator.StringToHash("CZ_leave")] = "idle_1",

    [gs.Animator.StringToHash("SF_leave")] = "idle_2",
    [gs.Animator.StringToHash("TW_enter01")] = "idle_2",
    [gs.Animator.StringToHash("TW_enter02")] = "idle_2",
    [gs.Animator.StringToHash("TW_idle")] = "idle_2",
    [gs.Animator.StringToHash("TW_idle01")] = "idle_2",
    [gs.Animator.StringToHash("TW_show")] = "idle_2",
    [gs.Animator.StringToHash("TW_twist01")] = "idle_2",
    [gs.Animator.StringToHash("TW_twist01_idle")] = "idle_2",
    [gs.Animator.StringToHash("TW_twist01_lost")] = "idle_2",
    [gs.Animator.StringToHash("TW_twist02")] = "idle_2",
    [gs.Animator.StringToHash("TW_twist02_idle")] = "idle_2",
    [gs.Animator.StringToHash("TW_twist02_lost")] = "idle_2",
    [gs.Animator.StringToHash("TW_twist03")] = "idle_2",
    [gs.Animator.StringToHash("TW_twist03_idle")] = "idle_2",
    [gs.Animator.StringToHash("TW_twist03_lost")] = "idle_2",
    [gs.Animator.StringToHash("TW_twist04")] = "idle_2",
    [gs.Animator.StringToHash("TW_twist04_idle")] = "idle_2",
    [gs.Animator.StringToHash("TW_twist05")] = "idle_2",
    [gs.Animator.StringToHash("TW_twist05_idle")] = "idle_2",
    [gs.Animator.StringToHash("TW_twist06")] = "idle_2",
    [gs.Animator.StringToHash("TW_twist06_idle")] = "idle_2",
    [gs.Animator.StringToHash("TW_twist07")] = "idle_2",
    [gs.Animator.StringToHash("TW_twist07_idle")] = "idle_2",
    [gs.Animator.StringToHash("TW_twist08")] = "idle_2",
    [gs.Animator.StringToHash("TW_twist08_idle")] = "idle_2",
    [gs.Animator.StringToHash("TW_twist09")] = "idle_2",
    [gs.Animator.StringToHash("TW_twist09_idle")] = "idle_2",

    [gs.Animator.StringToHash("TW_leave")] = "idle_3",
    [gs.Animator.StringToHash("CZ_enter01")] = "idle_3",
    [gs.Animator.StringToHash("CZ_enter02")] = "idle_3",
    [gs.Animator.StringToHash("CZ_idle")] = "idle_3",
    [gs.Animator.StringToHash("CZ_L_idle02")] = "idle_3",
    [gs.Animator.StringToHash("CZ_R_lost")] = "idle_3",
    [gs.Animator.StringToHash("CZ_R_win01")] = "idle_3",
    [gs.Animator.StringToHash("CZ_R_win02")] = "idle_3",
}

--状态对应的音效
ActionSound_list = {
    -- [gs.Animator.StringToHash("showStart")] = {{res = "4530/sfx_role_4530_2_h_01.prefab", layback = 0}},
    -- [gs.Animator.StringToHash("WT_twist01")] = {{res = "4530/sfx_role_4530_2_h_02.prefab", layback = 0}},
    -- [gs.Animator.StringToHash("WT_twist02")] = {{res = "4530/sfx_role_4530_2_h_03.prefab", layback = 0}},
    -- [gs.Animator.StringToHash("WT_show")] = {{res = "4530/sfx_role_4530_2_h_04.prefab", layback = 0}},
    -- [gs.Animator.StringToHash("HYS_enter01")] = {{res = "4530/sfx_role_4530_2_h_05.prefab", layback = 0}},
    -- [gs.Animator.StringToHash("HYS_show")] = {{res = "4530/sfx_role_4530_2_h_06.prefab", layback = 0}},
    -- [gs.Animator.StringToHash("SZT_enter01")] = {{res = "4530/sfx_role_4530_2_h_07.prefab", layback = 0}},
    -- [gs.Animator.StringToHash("SZT_show01")] = {{res = "4530/sfx_role_4530_2_h_08.prefab", layback = 0}},
    -- [gs.Animator.StringToHash("SZT_show02")] = {{res = "4530/sfx_role_4530_2_h_09.prefab", layback = 0}},
    -- [gs.Animator.StringToHash("XQS_twist02_01")] = {{res = "4530/sfx_role_4530_2_h_11.prefab", layback = 0}},
    -- [gs.Animator.StringToHash("XQS_twist02")] = {{res = "4530/sfx_role_4530_2_h_11.prefab", layback = 0}},
    -- [gs.Animator.StringToHash("XQS_twist04")] = {{res = "4530/sfx_role_4530_2_h_12.prefab", layback = 3216}},
    -- [gs.Animator.StringToHash("XQS_show")] = {{res = "4530/sfx_role_4530_2_h_13.prefab", layback = 0}},
    -- [gs.Animator.StringToHash("XQS_enter01")] = {{res = "4530/sfx_role_4530_2_h_14.prefab", layback = 0}},
}

--需要添加自由相机的动作及参数
FreeCamera_AniState =
{
    -- 动作名、相机聚焦点、默认距离、最小距离、最大距离、横向最小角度、横向最大角度、纵向最小角度、纵向最大角度
    [gs.Animator.StringToHash("SF_idle01")] = {lookNode = "Look_node", minDistance = 0.7, maxDistance = 1.0, minimumX = 50, maximumX = 150, minimumY = 330, maximumY = 390},
    [gs.Animator.StringToHash("TW_idle01")] = {lookNode = "Look_node", minDistance = 0.5, maxDistance = 1.8, minimumX = 0, maximumX = 0, minimumY = -40, maximumY = 340},
    [gs.Animator.StringToHash("CZ_L_idle02")] = {lookNode = "Look_node", minDistance = 0.8, maxDistance = 1.8, minimumX = -7, maximumX = 100, minimumY = -15, maximumY = 50},
}

Scene_IconList =
{
    [1] = "bigHostel_sceneIcon_01",
    [2] = "bigHostel_sceneIcon_02",
    [3] = "bigHostel_sceneIcon_03",
}

--注视鼠标的最大权重 (为 0  不开启注视鼠标)
Max_LookWeight = 1
--头部注视权重
LookAt_HeadWeight = 0.5
--眼部注视权重
LookAt_eyeWeight = 1

--注视鼠标的速度
LookAtSpeed = 3

--检测范围
CZPropTargetZ = -4.4
--中心点完美的差值
CZPropPerfectRange = 0.1
---好的差值
CZPropGoodRange = 0.2
--miss的差值
--飘字存活时长
CZTipLifeTime = 0.5

-- --头部注视角度限制(纵向/横向为0表示不做限制)
--LimitLookAngle = {minVertical = 30, maxVertical = 45, minHorizontal = 0, maxHorizontal = 0}

--动作需要添加的特效
FrameAddEffect =
{
    [gs.Animator.StringToHash("showStart")] =
    {
        {name = "fx_showStart", node = "[RESOLUTION_CAMERA]"},
    },

    [gs.Animator.StringToHash("SF_twist01")] =
    {
        {name = "fx_dj_twist01", node = "Root_node"},
        {name = "fx_SF_twist01", node = "[RESOLUTION_CAMERA]"},
    },

    [gs.Animator.StringToHash("SF_twist02")] =
    {
        {name = "fx_dj_twist02", node = "Root_node"},
        {name = "fx_SF_twist02", node = "[RESOLUTION_CAMERA]"},
    },

    [gs.Animator.StringToHash("SF_show")] =
    {
        {name = "fx_dj_show", node = "Root_node"},
        {name = "fx_SF_show", node = "[RESOLUTION_CAMERA]"},
    },

    [gs.Animator.StringToHash("TW_enter01")] =
    {
        {name = "fx_TW_enter01", node = "[RESOLUTION_CAMERA]"},
    },

    [gs.Animator.StringToHash("TW_show")] =
    {
        {name = "fx_TW_show", node = "[RESOLUTION_CAMERA]"},
    },
    [gs.Animator.StringToHash("CZ_R_win01")] =
    {
        {name = "fx_CZ_R_win01", node = "[RESOLUTION_CAMERA]"},
    },
    [gs.Animator.StringToHash("CZ_R_lost")] =
    {
        {name = "fx_CZ_R_lost", node = "[RESOLUTION_CAMERA]"},
    },
    [gs.Animator.StringToHash("TW_twist01")] =
    {
        {name = "fx_TW_twist01", node = "[RESOLUTION_CAMERA]"},
    },
    [gs.Animator.StringToHash("TW_twist02")] =
    {
        {name = "fx_TW_twist01", node = "[RESOLUTION_CAMERA]"},
    },
    [gs.Animator.StringToHash("TW_twist03")] =
    {
        {name = "fx_TW_twist01", node = "[RESOLUTION_CAMERA]"},
    },
    [gs.Animator.StringToHash("TW_twist04")] =
    {
        {name = "fx_TW_twist01", node = "[RESOLUTION_CAMERA]"},
    },
    [gs.Animator.StringToHash("TW_twist05")] =
    {
        {name = "fx_TW_twist01", node = "[RESOLUTION_CAMERA]"},
    },
    [gs.Animator.StringToHash("TW_twist06")] =
    {
        {name = "fx_TW_twist01", node = "[RESOLUTION_CAMERA]"},
    },
    [gs.Animator.StringToHash("TW_twist07")] =
    {
        {name = "fx_TW_twist01", node = "[RESOLUTION_CAMERA]"},
    },
    [gs.Animator.StringToHash("TW_twist08")] =
    {
        {name = "fx_TW_twist01", node = "[RESOLUTION_CAMERA]"},
    },
    [gs.Animator.StringToHash("TW_twist09")] =
    {
        {name = "fx_TW_twist01", node = "[RESOLUTION_CAMERA]"},
    },
}

--删除
function destroy(self)
    super.destroy(self)

    self:refreshTwUIPoint(self.mTWIndex, false)
    self:clearCZTip()
    bigHostel.BigHostelManager:clearUIComponentShowState()

    self.mCreatePoints = nil
    self.mCZDelayTime = nil
    self.mLateCreate = nil

    self.mCZPropCount = nil
    self.mCZWinCount = nil
    self.mCZPerfectCount = nil
    self.mStartCZ = nil
    self.mCZButtonDownL = nil
    self.mCZButtonDownR = nil
    self.mCZCheckIndex = nil
    self.mCZInputSoundPending = nil

    self:clearCZPropModel()
    self:ClearDelayRecoverProp()
    bigHostel.BigHostelManager:setDualViewEnabled(false)
    self:clearShowHeroGo()
    self.mDualViewBindRoot = nil

    self:resumeSceneBgm()
    self:ClearCZBgm()
    self:ClearTWBgm()

    self:ClearCZNodeEffect()
end

function loadFinish(self)
    super.loadFinish(self)
    self:createShowHeroGo()
end

function addEventListener(self)
    super.addEventListener(self)

end

function removeEventListener(self)
    super.removeEventListener(self)

end

function onOtherUIOpen(self)
    super.onOtherUIOpen(self)

end

function onSwitchIdle(self)
    super.onSwitchIdle(self)

end

function onAnimaBodyStateSwitch(self, stateHash)
    super.onAnimaBodyStateSwitch(self, stateHash)

    -- -------------------第一分镜
    if (stateHash == gs.Animator.StringToHash("showStart") or stateHash == gs.Animator.StringToHash("SF_enter") or stateHash == gs.Animator.StringToHash("SF_show") or stateHash == gs.Animator.StringToHash("SF_leave"))
        and (stateHash ~= gs.Animator.StringToHash("SF_twist01") and stateHash ~= gs.Animator.StringToHash("SF_twist02")and stateHash ~= gs.Animator.StringToHash("SF_idle01"))then
        self.mSFTwistIndex = 0
        self:setInt("twist_index", self.mSFTwistIndex)
    end

    if stateHash == gs.Animator.StringToHash("SF_idle01") then
        local function onPointDown()
            self.mSFTwistIndex = self.mSFTwistIndex + 1
            self:setInt("twist_index", self.mSFTwistIndex)
            self:setTrigger("twist")
        end
        self:addBoxColliderEventByName("Bip001 Prop1", gs.Vector3(0.2, 0.2, 0.2), nil, onPointDown)
    elseif stateHash == gs.Animator.StringToHash("SF_twist02") then
        if self.mSFTwistIndex >= 4 then
            self:setTrigger(BigHostelConst.BaseAnimatorParams.Show)
        end
    else
        self:removeBoxColliderEventByName("Bip001 Prop1")
    end

    -- -------------------第二分镜
    if stateHash == gs.Animator.StringToHash("TW_idle01") then
        bigHostel.BigHostelManager:setUIComponentShowState({key = "mBtn4535_2_h_StartTW", val = true, call = function ()
            self:setTrigger("start_game")
        end})
        GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SHOWUICOMPONENT)
    else
        bigHostel.BigHostelManager:setUIComponentShowState({key = "mBtn4535_2_h_StartTW", val = false})
        GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SHOWUICOMPONENT)
    end

    if stateHash == gs.Animator.StringToHash("TW_enter01") then
        self:setInt("enter_TW", 1)
    end

    if stateHash == gs.Animator.StringToHash("TW_idle")
        or stateHash == gs.Animator.StringToHash("TW_twist01_idle")
        or stateHash == gs.Animator.StringToHash("TW_twist02_idle")
        or stateHash == gs.Animator.StringToHash("TW_twist03_idle")
        or stateHash == gs.Animator.StringToHash("TW_twist04_idle")
        or stateHash == gs.Animator.StringToHash("TW_twist05_idle")
        or stateHash == gs.Animator.StringToHash("TW_twist06_idle")
        or stateHash == gs.Animator.StringToHash("TW_twist07_idle")
        or stateHash == gs.Animator.StringToHash("TW_twist08_idle")
        or stateHash == gs.Animator.StringToHash("TW_twist09_idle") then
        bigHostel.BigHostelManager:setUIComponentShowState({key = "4535_2_h_TW_click", val = true})
        bigHostel.BigHostelManager:setUIComponentShowState({key = "mEmptyClick", val = true, call = function ()
            self:setTrigger("lost")
            self:refreshTwUIPoint(self.mTWIndex, false)
        end})
        self:refreshTwUIPoint(1, true, math.random(2, 5))
    else
        bigHostel.BigHostelManager:setUIComponentShowState({key = "4535_2_h_TW_click", val = false})
        self:refreshTwUIPoint(self.mTWIndex, false)

        GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SHOWUICOMPONENT)
    end

    -- -------------------第三分镜
    if stateHash == gs.Animator.StringToHash("CZ_L_idle02") then
        bigHostel.BigHostelManager:setUIComponentShowState({key = "mBtn4535_2_h_StartCZ", val = true, call = function ()
            self:setTrigger("start_game")
        end})
        GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SHOWUICOMPONENT)
    else
        bigHostel.BigHostelManager:setUIComponentShowState({key = "mBtn4535_2_h_StartCZ", val = false})
        GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SHOWUICOMPONENT)
    end

    if stateHash == gs.Animator.StringToHash("CZ_idle") then
        bigHostel.BigHostelManager:setUIComponentShowState({key = "4535_2_h_CZ_click", val = true})
        local clickname_l = gs.Application.isMobilePlatform and "mBtn4535_2_h_CZ_ClickLeft_2" or "mBtn4535_2_h_CZ_ClickLeft_1"
        bigHostel.BigHostelManager:setUIComponentShowState({key = clickname_l, val = true, pointDownCall = function ()
            self.mCZButtonDownL = true
            self:setInt("mouse_down_l", 1)
            self:startCZPropCheck(1)
        end, pointUpCall = function ()
            self.mCZButtonDownL = false
            self:setInt("mouse_down_l", 0)
        end})

        local clickname_r = gs.Application.isMobilePlatform and "mBtn4535_2_h_CZ_ClickRight_2" or "mBtn4535_2_h_CZ_ClickRight_1"
        bigHostel.BigHostelManager:setUIComponentShowState({key = clickname_r, val = true, pointDownCall = function ()
            self.mCZButtonDownR = true
            self:setInt("mouse_down_r", 1)
            self:startCZPropCheck(3)
        end, pointUpCall = function ()
            self.mCZButtonDownR = false
            self:setInt("mouse_down_r", 0)
        end})
        self:refreshCZComboCount()
    else
        bigHostel.BigHostelManager:setUIComponentShowState({key = "4535_2_h_CZ_click", val = false})
        local clickname_l = gs.Application.isMobilePlatform and "mBtn4535_2_h_CZ_ClickLeft_2" or "mBtn4535_2_h_CZ_ClickLeft_1"
        local clickname_r = gs.Application.isMobilePlatform and "mBtn4535_2_h_CZ_ClickRight_2" or "mBtn4535_2_h_CZ_ClickRight_1"

        bigHostel.BigHostelManager:setUIComponentShowState({key = clickname_l, val = false})
        bigHostel.BigHostelManager:setUIComponentShowState({key = clickname_r, val = false})
        bigHostel.BigHostelManager:setUIComponentShowState({key = "mTextComboCount", val = false})

        GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SHOWUICOMPONENT)
    end

    if stateHash == gs.Animator.StringToHash("CZ_idle") then
        self:setLayerWeight("CZ_R", 1)
        self:setLayerWeight("CZ_L", 1)

        self:startCZ()

        self:setShowHeroVisible(true)

        bigHostel.BigHostelManager:setDualViewEnabled(true)
        local node = self.m_modelBaseNode:Find("NODE_5")
        if self.mCZNodeEffect == nil then
            self.mCZNodeEffect = self:addEffect("arts/fx/3d/sceneModule/3Dhostel/4535_2_h/fx_CZ_R_idle01.prefab", node)
        end
    else
        self:ClearCZNodeEffect()
        self:setLayerWeight("CZ_R", 0)
        self:setLayerWeight("CZ_L", 0)

        self.mStartCZ = nil
        self.mCZButtonDownL = false
        self.mCZButtonDownR = false
        self.mCZCheckIndex = nil
        self.mCZInputSoundPending = nil
        self:setInt("mouse_down_l", 0)
        self:setInt("mouse_down_r", 0)
        self:clearCZTip()
        self:clearCZPropModel()
        bigHostel.BigHostelManager:setDualViewEnabled(false)
        self:setShowHeroVisible(false)
    end

    if stateHash == gs.Animator.StringToHash("CZ_enter01") then
        self:setInt("enter_CZ", 1)
    end

    ---背景音乐

    if stateHash == gs.Animator.StringToHash("TW_idle") then
        self:ClearCZBgm()
        self:stopMusic()

        if self.m_TWbgmAudio == nil then
            self.m_TWbgmAudio = AudioManager:playOtherMusic("arts/audio/music/music_3Ddorm_6.prefab", true)
        end
    elseif stateHash == gs.Animator.StringToHash("CZ_idle") then
        self:ClearTWBgm()
        self:stopMusic()

        if self.m_CZgmAudio == nil then
            self.m_CZgmAudio = AudioManager:playOtherMusic("arts/audio/music/music_3Ddorm_7.prefab", true)
        end
    elseif stateHash == gs.Animator.StringToHash("TW_twist01_lost")
        or stateHash == gs.Animator.StringToHash("TW_twist02_lost")
        or stateHash == gs.Animator.StringToHash("TW_twist03_lost")
        or stateHash == gs.Animator.StringToHash("CZ_R_lost") then
        self:ClearTWBgm()
        self:ClearCZBgm()

        AudioManager:playOtherMusic("arts/audio/music/music_3Ddorm_fail.prefab", false)
    elseif stateHash == gs.Animator.StringToHash("TW_show")or stateHash == gs.Animator.StringToHash("CZ_R_win01") then
        self:ClearTWBgm()
        self:ClearCZBgm()
        self.m_WinBgmAudio = AudioManager:playOtherMusic("arts/audio/music/music_3Ddorm_win.prefab", false)
    elseif stateHash ~= gs.Animator.StringToHash("TW_twist01_idle")
        and stateHash ~= gs.Animator.StringToHash("TW_twist02_idle")
        and stateHash ~= gs.Animator.StringToHash("TW_twist03_idle")
        and stateHash ~= gs.Animator.StringToHash("TW_twist04_idle")
        and stateHash ~= gs.Animator.StringToHash("TW_twist05_idle")
        and stateHash ~= gs.Animator.StringToHash("TW_twist06_idle")
        and stateHash ~= gs.Animator.StringToHash("TW_twist07_idle")
        and stateHash ~= gs.Animator.StringToHash("TW_twist08_idle")
        and stateHash ~= gs.Animator.StringToHash("TW_twist09_idle")
        and stateHash ~= gs.Animator.StringToHash("TW_twist01")
        and stateHash ~= gs.Animator.StringToHash("TW_twist02")
        and stateHash ~= gs.Animator.StringToHash("TW_twist03")
        and stateHash ~= gs.Animator.StringToHash("TW_twist04")
        and stateHash ~= gs.Animator.StringToHash("TW_twist05")
        and stateHash ~= gs.Animator.StringToHash("TW_twist06")
        and stateHash ~= gs.Animator.StringToHash("TW_twist07")
        and stateHash ~= gs.Animator.StringToHash("TW_twist08")
        and stateHash ~= gs.Animator.StringToHash("TW_twist09")then

        self:ClearTWBgm()
        self:ClearCZBgm()

        self:resumeSceneBgm()
    end
end

function ClearCZNodeEffect(self)
    if self.mCZNodeEffect then
        self:removeEffect(self.mCZNodeEffect.m_snId)
        self.mCZNodeEffect = nil
    end
end

function stopMusic(self)
    AudioManager:pauseMusicByFade(0)
end

function resumeSceneBgm(self)
    AudioManager:resumeMusicByFade(0)
end

function ClearTWBgm(self)
    if self.m_TWbgmAudio then
        AudioManager:stopAudioSound(self.m_TWbgmAudio)
        self.m_TWbgmAudio = nil
    end
end

function ClearCZBgm(self)
    if self.m_CZgmAudio then
        AudioManager:stopAudioSound(self.m_CZgmAudio)
        self.m_CZgmAudio = nil
    end
end

function getDualViewBindTrans(self)
    if self.mDualViewBindRoot == nil or gs.GoUtil.IsTransNull(self.mDualViewBindRoot) then
        self.mDualViewBindRoot = self.m_modelBaseNode and
        self.m_modelBaseNode:Find("NODE_4/DualViewBindingRoot") or nil
    end
    return self.mDualViewBindRoot
end

function createShowHeroGo(self)
    if self.mShowHeroGo ~= nil then
        return true
    end

    self.mShowHeroGo = gs.GOPoolMgr:Get("arts/character/scene_module_3Dhostel/4535_2_h_lymden/model4535_2_h_s_lymden.prefab")
    self.mShowHeroGo:SetActive(false)

    local bindRoot = self:getDualViewBindTrans()
    if bindRoot == nil or gs.GoUtil.IsTransNull(bindRoot) then
        logError("[DualView] Missing MODEL_NODE/NODE_4/DualViewBindingRoot.")
        self:clearShowHeroGo()
        return false
    end
    gs.TransQuick:SetParentOrg01(self.mShowHeroGo, bindRoot)

    local function frameEventCall (strParame)
        if self.mShowHeroGo then
            local showAnimator = self.mShowHeroGo:GetComponent(ty.Animator)
            local index = math.random(1, 5)
            showAnimator:SetInteger("idle_index", index)
        end
    end

    local aniCall = self.mShowHeroGo:GetComponent(ty.AnimatCall)
    if aniCall ~= nil and not gs.GoUtil.IsCompNull(aniCall) then
        aniCall:SetSimpleFrameEventCall(frameEventCall)
    end
    return true
end

function setShowHeroVisible(self, visible)
    if self.mShowHeroGo == nil and not self:createShowHeroGo() then
        return
    end
    self.mShowHeroGo:SetActive(visible)
end

function clearShowHeroGo(self)
    if self.mShowHeroGo ~= nil then
        bigHostel.BigHostelManager:releaseDualViewTarget()
        gs.GOPoolMgr:Recover(self.mShowHeroGo, "arts/character/scene_module_3Dhostel/4535_2_h_lymden/model4535_2_h_s_lymden.prefab")
        self.mShowHeroGo = nil
    end
end

--缓存数据
function saveMainSceneInfo(self)
    --这些动作不会被缓存
    local t =
    {
        "SF_idle01",
        "TW_idle01",
        "CZ_L_idle02",
    }

    local isSave = false
    for k, v in pairs(t) do
        if self.m_curBodyShortHash == gs.Animator.StringToHash(v) then
            isSave = true
            break
        end
    end

    if isSave == false then
        return
    end

    super.saveMainSceneInfo(self)
end

function onFrame(self)
    super.onFrame(self)

    if self.mStartCZ then
        if self.m_curBodyShortHash == gs.Animator.StringToHash("CZ_idle") then
            if self.mCZInputSoundPending then
                self.mCZInputSoundPending = nil
                AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_ui_2.prefab")
            end

            if self.mCZCheckIndex then
                if gs.Time.time - self.mCheckTime >= 0.2 then
                    self:checkCZProp(self.mCZCheckIndex)
                    self.mCheckTime = gs.Time.time

                    self.mCZCheckIndex = nil
                end
            end
        end

        --生成球
        if self.mCZDelayTime == nil then
            self.mCZDelayTime = math.random(50, 150) / 100
        end

        self:createCZModel()
        self:refreshCZPropPos()
        self:checkDelayRecoverProp()
    end
end

--------------------点圈圈
function startCZPropCheck(self, index)
    self.mCZInputSoundPending = true

    if self.mCZButtonDownL and self.mCZButtonDownR then
        self.mCZCheckIndex = 2
    elseif index == 1 then
        self.mCZCheckIndex = 1
    elseif index == 3 then
        self.mCZCheckIndex = 3
    end
end

function refreshTwUIPoint(self, index, show, num)
    if index then
        self.mTWIndex = index
        bigHostel.BigHostelManager:setUIComponentShowState({key = "mImgCliclItem_" ..index, val = show, nums = num, call = function ()
            self:refreshTwUIPoint(index, false)
            if index < num then
                self:refreshTwUIPoint(index + 1, true, num)
            else
                self:setTrigger("twist")
            end
        end, tweenCall = function ()
            self:setTrigger("lost")
            self:refreshTwUIPoint(self.mTWIndex, false)
        end})

        GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SHOWUICOMPONENT)
    end
end

---------------------夹道具
function startCZ(self)
    self.mCZPoints = {}
    for i = 1, 3 do
        local go = gs.GameObject.Find("CZ_CreatePoint_"..i).transform
        self.mCZPoints[i] = go
    end

    self.mCZGOList = {[1] = {}, [2] = {}, [3] = {}}

    self.mStartCZ = true

    self.mCZPropCount = 100
    self.mCZWinCount = 0
    self.mCZPerfectCount = 0
    self.mCZButtonDownL = false
    self.mCZButtonDownR = false
    self.mCZCheckIndex = nil
    self:refreshCZComboCount()

    self.mCheckTime = 0

    self.mCZDelayRecoverProplist = {}
end

--创建夹气球的道具
function refreshCZComboCount(self)
    bigHostel.BigHostelManager:setUIComponentShowState({
        key = "mTextComboCount",
        val = true,
    text = self.mCZWinCount})
    GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SHOWUICOMPONENT)
end

function showCZTip(self, tipType)
    if self.mCZTipTimeSn then
        LoopManager:clearTimeout(self.mCZTipTimeSn)
        self.mCZTipTimeSn = nil
    end

    local tipTypes = {"perfect", "good", "miss"}
    for _, typeName in ipairs(tipTypes) do
        bigHostel.BigHostelManager:setUIComponentShowState({
            key = "mImg4535_2_h_CZ_Tips_" .. typeName,
            val = typeName == tipType
        })
    end
    GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SHOWUICOMPONENT)

    self.mCZTipTimeSn = LoopManager:setTimeout(CZTipLifeTime, self, function ()
        self.mCZTipTimeSn = nil
        self:clearCZTip()
    end)
end

function clearCZTip(self)
    if self.mCZTipTimeSn then
        LoopManager:clearTimeout(self.mCZTipTimeSn)
        self.mCZTipTimeSn = nil
    end

    local tipTypes = {"perfect", "good", "miss"}
    for _, typeName in ipairs(tipTypes) do
        bigHostel.BigHostelManager:setUIComponentShowState({
            key = "mImg4535_2_h_CZ_Tips_" .. typeName,
            val = false
        })
    end
    GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SHOWUICOMPONENT)
end

function finishCZPropCheck(self, index)
    self.mCZCheckIndex = nil
end

function createCZModel(self)
    if self.mCZLateCreate ~= nil and (gs.Time.time - self.mCZLateCreate) < self.mCZDelayTime then
        return
    end

    if self.mCZPropCount <= 0 then--检测分数播放对应动作
        return
    end

    local index = math.random(1, 3)
    local parent = self.mCZPoints[index]

    local propPath =
    {
        [1] =
        {
            "107_beizi/model107_beizi.prefab",
            "107_jiusai/model107_jiusai.prefab",
        },
        --中间需要夹住的道具
        [2] =
        {
            "107_baozhen/model107_baozhen.prefab",
            "107_yinfub01/model107_yinfub01.prefab",
            "107_yinfub02/model107_yinfub02.prefab",
            "107_xinfeng/model107_xinfeng.prefab"
        },
        [3] =
        {
            "107_yinfua01/model107_yinfua01.prefab",
            "107_yinfua02/model107_yinfua02.prefab"
        },
    }

    local list = propPath[index]
    local path = "arts/sceneModule/3d_hostel_dynamic/" .. list[math.random(1, #list)]
    local go = gs.GOPoolMgr:Get(path)
    gs.TransQuick:SetParentOrg01(go, parent)
    go:GetComponent(ty.Animator):SetTrigger("idle")
    table.insert(self.mCZGOList[index], {path = path, go = go})

    self.mCZLateCreate = gs.Time.time
    self.mCZPropCount = self.mCZPropCount - 1
    self.mCZDelayTime = nil
end

function clearCZPropModel(self)
    if self.mCZGOList then
        for index, props in pairs(self.mCZGOList) do
            for _, v in pairs(props) do
                gs.GOPoolMgr:Recover(v.go, v.path)
            end
        end
    end
    self.mCZGOList = nil
end

--更新夹住道具的移动
function refreshCZPropPos(self)
    if table.empty(self.mCZGOList) then
        return
    end

    local isEmpty = true

    local rcoverList = {}
    for i = 1, #self.mCZGOList do
        local propslist = self.mCZGOList[i]
        for j = #propslist, 1, -1 do
            local props = propslist[j]
            props.go.transform.localPosition = props.go.transform.localPosition - gs.Vector3(0, 0, gs.Time.deltaTime)

            if not props.hasMissed and props.go.transform.localPosition.z <= CZPropTargetZ - CZPropGoodRange then
                props.hasMissed = true
                self:showCZTip("miss")
                self:playCZAudioSound(5)
                self.mCZPerfectCount = 0
            end

            if props.go.transform.localPosition.z <= -5 then
                gs.GOPoolMgr:Recover(props.go, props.path)
                table.remove(propslist, j)
            end

            isEmpty = false
        end
    end

    if isEmpty then
        if self.mCZWinCount < 60 then
            self:setTrigger("lost")
        elseif self.mCZWinCount >= 60 then
            self:setTrigger("win")
        end
    end
end

function playCZAudioSound(self, soundname)
    if math.random(1, 100) > 30 then
        return
    end

    if self.m_CZSound then
        local soundId = self.m_CZSound.m_snId
        if soundId and AudioManager.mAllAudioDataDic and AudioManager.mAllAudioDataDic[soundId] then
            AudioManager:stopAudioSound(self.m_CZSound)
        end
        self.m_CZSound = nil
    end

    self.m_CZSound = AudioManager:playSoundEffect(string.format("arts/audio/cv/hero_4535_cv_new0%s.prefab", soundname))
end

--检测延迟回收的道具
function checkDelayRecoverProp(self)
    if self.mCZDelayRecoverProplist then
        for i = #self.mCZDelayRecoverProplist, 1, -1 do
            local data = self.mCZDelayRecoverProplist[i]
            if gs.Time.time - data.time >= 1.5 then
                self:removeEffect(data.effect)

                gs.GOPoolMgr:Recover(data.vo.go, data.vo.path)
                table.remove(self.mCZDelayRecoverProplist, i)
            end
        end
    end
end

function ClearDelayRecoverProp(self)
    if self.mCZDelayRecoverProplist then
        for k, data in pairs(self.mCZDelayRecoverProplist) do
            self:removeEffect(data.effect)
            gs.GOPoolMgr:Recover(data.vo.go, data.vo.path)
        end
    end
    self.mCZDelayRecoverProplist = nil
end

--踢走道具
function checkCZProp(self, index)
    local propslist = self.mCZGOList[index]
    local closestIndex
    local closestDistance
    for j, props in ipairs(propslist) do
        local distance = math.abs(props.go.transform.localPosition.z - CZPropTargetZ)
        if closestDistance == nil or distance < closestDistance then
            closestIndex = j
            closestDistance = distance
        end
    end

    if closestIndex == nil or closestDistance > CZPropGoodRange then
        return
    end

    local isPerfect = closestDistance <= CZPropPerfectRange
    if isPerfect then
        self:showCZTip("perfect")
    else
        self:showCZTip("good")
    end
    self:finishCZPropCheck(index)

    local props = propslist[closestIndex]
    local parameterName
    if index == 1 then
        parameterName = "twist_2"
    elseif index == 2 then
        parameterName = "twist_1"
    elseif index == 3 then
        parameterName = "twist_3"
    end
    local animator = props.go:GetComponent(ty.Animator)
    if AnimatorUtil.haseParameter(animator, parameterName, gs.AnimatorControllerParameterType.Trigger) then
        animator:SetTrigger(parameterName)
    end

    AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_ui_1.prefab")

    local node = gs.GoUtil.FindNameInChilds(props.go.transform, string.format("twist0%s", index))
    local effect = self:addEffect(string.format("arts/fx/3d/sceneModule/3Dhostel/4535_2_h/fx_twist0%s.prefab", index), node)
    if effect ~= nil then
        table.insert(self.mCZDelayRecoverProplist, {time = gs.Time.time, vo = props, effect = effect.m_snId})
    else
        table.insert(self.mCZDelayRecoverProplist, {time = gs.Time.time, vo = props})
    end
    table.remove(propslist, closestIndex)

    if isPerfect and self.mShowHeroGo then
        local showAnimator = self.mShowHeroGo:GetComponent(ty.Animator)
        showAnimator:SetTrigger("twist")
    end

    if isPerfect then
        self.mCZPerfectCount = (self.mCZPerfectCount or 0) + 1
        if self.mCZPerfectCount == 5 then
            AudioManager:playSoundEffect("arts/audio/cv/hero_4535_cv_new06.prefab")
        else
            local perfectVoiceIndexes = {2, 4}
            local perfectVoiceIndex = perfectVoiceIndexes[math.random(1, #perfectVoiceIndexes)]
            self:playCZAudioSound(perfectVoiceIndex)
        end
    else
        self.mCZPerfectCount = 0
        local goodVoiceIndexes = {1, 3}
        local goodVoiceIndex = goodVoiceIndexes[math.random(1, #goodVoiceIndexes)]
        self:playCZAudioSound(goodVoiceIndex)
    end

    self.mCZWinCount = self.mCZWinCount + (isPerfect and 2 or 1)
    self:refreshCZComboCount()
end

function set_trigger(self, key)
    super.set_trigger(self, key)

end

function setInt(self, key, value)
    super.setInt(self, key, value)

end

function getLayIndex(self, layer_name)
    local layer_list = {
        ["body"] = 0,
        ["face"] = 1,
        ["CZ_R"] = 2,
        ["CZ_L"] = 3,
    }
    return layer_list[layer_name]
end

return _M
