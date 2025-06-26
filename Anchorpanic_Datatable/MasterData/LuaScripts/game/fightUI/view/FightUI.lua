--[[     战斗UI
]] -- module('fightUI.FightUI', Class.impl('lib.component.BaseContainer'))
module('fightUI.FightUI', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("fight/FightUI.prefab")

panelType = 1
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isScreensave = 0 -- 是否使用黑屏过渡(仅1全屏UI有效，默认开启，0关闭)
isBlur = 0

function initData(self)
    self.m_skillView = nil
    self.m_settingView = nil

    self.m_curHeroID = nil
    self.m_totalDamage = 0
    self.m_totalCure = 0

    self.m_showBuffPanel = false

    self.mSupportList = {}
end

-- 初始化UI
function configUI(self)
    self.m_startView = fightUI.FightStartView.new()
    self.m_startView:initData(self:getChildGO('StartGroup'))

    self.m_skillView = fightUI.FightSkillView.new()
    self.m_skillView:initData(self:getChildGO('SkillGroup'))
    self.m_skillView:setVisibleByScale(false)
    self.m_skillView:setMainUI(self)

    self.m_queueView = fightUI.FightQueueView.new()
    self.m_queueView:initData(self:getChildGO('QueueGroup'))
    self.m_queueView:updateQueue()
    self.m_queueView:setActive(false)

    self.m_soulView = fightUI.FightSoulView.new()
    self.m_soulView:initData(self:getChildGO('BottomGroup'))
    self.m_soulView:setActive(false)

    self.m_waveView = fightUI.FightWaveView.new()
    self.m_waveView:initData(self:getChildGO('WaveGroup'))

    self.m_hitView = fightUI.FightHitView.new()
    self.m_hitView:initData(self:getChildGO('HitGroup'))
    self.m_hitView:setVisibleByScale(false)

    self.m_autoFightView = fightUI.FightAutoFightView.new()
    self.m_autoFightView:initData(self:getChildGO('AutoFightGroup'))
    self.m_autoFightView:showAutoFight(false)

    self.m_bossHeadAreaView = fightUI.FightBossHeadAreaView.new()
    self.m_bossHeadAreaView:initData(self:getChildGO('BossAreaGroup'))
    self.m_bossHeadAreaView:setVisibleByScale(false)

    self.m_forcesSkillView = fightUI.FightForcesSkillView.new()
    self.m_forcesSkillView:initData(self:getChildGO('ForcesSkillGroup'))
    self.m_forcesSkillView:setVisibleByScale(false)

    self.m_buffBtn = self:getChildGO("BuffBtn")
    self.m_speedBtn = self:getChildGO("SpeedBtn")
    self.m_settingBtn = self:getChildGO("SettingBtn")
    self.m_omitBtn = self:getChildGO("OmitBtn")

    self.m_speedIcon = self:getChildGO("SpeedIcon"):GetComponent(ty.Image)

    self:addOnClick(self.m_settingBtn, self.onSettingHandler)
    self:addOnClick(self:getChildGO('ChatBtn'), self.onChatHandler)
    self:addOnClick(self.m_omitBtn, self.onOmitHandler)

    self.m_skillTimeBar = self:getChildTrans("SkillTimeBar"):GetComponent(ty.Image)
    self.m_skillTimeBarValTxt = self:getChildGO('SkillTimeBarValTxt'):GetComponent(ty.Text)

    self.m_totalDamageTransLeft = self:getChildGO("TotalDamageLeft")
    self.m_totalDamageTransRight = self:getChildGO("TotalDamageRight")
    self.m_damageTxtLeft = self:getChildGO('DamageTxtLeft'):GetComponent(ty.Text)
    self.m_damageTxtRight = self:getChildGO('DamageTxtRigth'):GetComponent(ty.Text)

    self.m_damageDescTxtLeft = self:getChildGO('DamageDescTxtLeft'):GetComponent(ty.Text)
    self.m_damageDescTxtLeft.text = _TT(3003)
    self.m_damageDescTxtRight = self:getChildGO('DamageDescTxtRight'):GetComponent(ty.Text)
    self.m_damageDescTxtRight.text = _TT(3003)

    self.m_totalCureTransLeft = self:getChildGO("TotalCureLeft")
    self.m_totalCureTransRight = self:getChildGO("TotalCureRight")
    self.m_cureTxtLeft = self:getChildGO('CureTxtLeft'):GetComponent(ty.Text)
    self.m_cureTxtRight = self:getChildGO('CureTxtRigth'):GetComponent(ty.Text)

    self.m_cureDescTxtLeft = self:getChildGO('CureDescTxtLeft'):GetComponent(ty.Text)
    self.m_cureDescTxtLeft.text = "总治疗" -- _TT(3003)
    self.m_cureDescTxtRight = self:getChildGO('CureDescTxtRight'):GetComponent(ty.Text)
    self.m_cureDescTxtRight.text = "总治疗" -- _TT(3003)

    -- 战场过载
    self.mTxtTips_1 = self:getChildGO("mTxtTips_1"):GetComponent(ty.Text)
    self.mTxtTips_1.text = _TT(3061)
    self.mTxtTips_2 = self:getChildGO("mTxtTips_2"):GetComponent(ty.Text)
    self.mTxtTips_3 = self:getChildGO("mTxtTips_3"):GetComponent(ty.Text)
    self.OverloadTips = self:getChildGO("OverloadTips")
    self.OverloadTips:SetActive(false)

    self.m_autoBtn = self:getChildGO('AutoBtn')
    self.m_imgRound = self:getChildTrans('ImgRound')
    self.m_autoText = self:getChildTrans('AutoText'):GetComponent(ty.Text)

    self.mDebuffGroup = self:getChildGO("mDebuffGroup")
    self.mDebuffGroup:SetActive(false)
    self.mTextDeBuffValue_1 = self:getChildGO("mTextDeBuffValue_1"):GetComponent(ty.Text)
    self.mTextDeBuffValue_2 = self:getChildGO("mTextDeBuffValue_2"):GetComponent(ty.Text)

    self.SkillNameGroupLeft = self:getChildGO("SkillNameGroupLeft")
    self.mImgLeftHeroIcon = self:getChildGO("mImgLeftHeroIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtLeft_SkillName = self:getChildGO("mTxtLeft_SkillName"):GetComponent(ty.Text)
    self.mTxtLeft_HeroName = self:getChildGO("mTxtLeft_HeroName"):GetComponent(ty.Text)
    self.SkillNameGroupLeft:SetActive(false)
    self.mSkillNameAnimator_Left = self.SkillNameGroupLeft:GetComponent(ty.Animator)

    self.SkillNameGroupRight = self:getChildGO("SkillNameGroupRight")
    self.mImgRightHeroIcon = self:getChildGO("mImgRightHeroIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtRight_SkillName = self:getChildGO("mTxtRight_SkillName"):GetComponent(ty.Text)
    self.mTxtRight_HeroName = self:getChildGO("mTxtRight_HeroName"):GetComponent(ty.Text)
    self.SkillNameGroupRight:SetActive(false)
    self.mSkillNameAnimator_Right = self.SkillNameGroupRight:GetComponent(ty.Animator)

    -- self.mTxtElementReaction = self:getChildGO("mTxtElementReaction"):GetComponent(ty.Text)
    -- self.mTxtElementReaction.text = _TT(3068)

    -- self.mElementReactionS = self:getChildGO("mTxtElementReactionS")
    -- self.mElementReactionS:SetActive(false)
    -- self.mTxtElementReactionS = self:getChildGO("mTxtElementReactionS"):GetComponent(ty.Text)
    -- self.mTxtElementReactionS.text = _TT(3068)

    -- self.mToggleElementReaction = self:getChildGO("mToggleElementReaction"):GetComponent(ty.Toggle)
    -- local function elementOnValFun(val)
    --     if val then
    --         GameDispatcher:dispatchEvent(EventName.OPEN_FIGHT_ELEMENTREACTIONPANEL)
    --     else
    --         GameDispatcher:dispatchEvent(EventName.CLOSE_FIGHT_ELEMENTREACTIONPANEL)
    --     end
    --     self.mElementReactionS:SetActive(val)
    -- end
    -- self.mToggleElementReaction.onValueChanged:AddListener(elementOnValFun)

    local function _autoController()

        if fight.FightManager.m_canGuideAuto == true and not guide.GuideManager:getCurGuideRo() then
            return
        end

        if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FIGHT_AUTO, true) == false then
            return
        end
        if self.m_beAutoLock == true then
            return
        end
        if not fight.FightManager:getIsBattleing() then
            return
        end

        fight.FightManager.m_canGuideAuto = false
        if fight.FightManager:getIsAutoFight() then
            self:updateAutoFight(false)
            self:setAutoFight(false)
        else
            self:updateAutoFight(true)
            self:setAutoFight(true)
        end
    end

    guide.GuideCondition:condition28()

    self:addOnClick(self.m_autoBtn, _autoController)

    self.m_blockView = fightUI.FightBlockView.new()
    self.m_blockView:initData(self:getChildGO('BlockArea'))
    self.m_blockView:setVisibleByScale(false)

    self:addOnClick(self.m_buffBtn, self.onBuffHandler)
    self:addOnClick(self.m_speedBtn, self.onSpeedHandler)

    self.m_speedTxtX = self:getChildGO('SpeedTxtX'):GetComponent(ty.Text)
    self.m_speedTxt = self:getChildGO('SpeedTxt'):GetComponent(ty.Text)
    self:updateSpeedTxt(fight.FightManager:getTimeScaleType())

    self.m_buffTxt = self:getChildGO('BuffTxt'):GetComponent(ty.Text)

    self.m_leftSFormat = fightUI.FightSmallFormatView.new()
    self.m_leftSFormat:setup(UrlManager:getUIPrefabPath("fight/FightSmallFormat.prefab"))
    self.m_leftSFormat:addOnParent(self:getChildTrans("LeftFormat"))
    self.m_leftSFormat:setItemPrefabPath(UrlManager:getUIPrefabPath("fight/FightSFormatLeft.prefab"))
    self.m_rightSFormat = fightUI.FightSmallFormatView.new()
    self.m_rightSFormat:setup(UrlManager:getUIPrefabPath("fight/FightSmallFormat.prefab"))
    self.m_rightSFormat:addOnParent(self:getChildTrans("RightFormat"))
    self.m_rightSFormat:setItemPrefabPath(UrlManager:getUIPrefabPath("fight/FightSFormatRight.prefab"))
    self.m_rightSFormat:setScaleX(-1)

    -- self.m_roundTxt1 = self:getChildGO('RoundTxt'):GetComponent(ty.Text)
    self.m_roundTxt2 = self:getChildGO('RoundTxt2'):GetComponent(ty.Text)
    self.m_roundDestTxt = self:getChildGO('RoundDestTxt'):GetComponent(ty.Text)
    self.m_roundDestTxt.text = "回合:" -- _TT(3001)

    self:getChildGO('WaveDescTxt'):GetComponent(ty.Text).text = _TT(3002)
    self.m_waveTxt = self:getChildGO('WaveTxt'):GetComponent(ty.Text)

    self.m_autoSkillMask = self:getChildGO('AutoMask')
    self.m_autoSkillMaskIconTrans = self:getChildTrans('AutoRotatIcon')

    self.m_blockTeachingView = fightUI.FightBlockTeachingView.new()
    self.m_blockTeachingView:initData(self:getChildGO("BlockCountGroup"))

    self.m_firstTipsContent = self:getChildGO("FirstTipsContent")
    self.m_firstTipsContent:SetActive(false)

    self.mGroupSupport = self:getChildTrans("mGroupSupport")
    self:addOnClick(self:getChildGO("mGroupSupport"), self.onShowSupportHandler)

    self.mGuildBossDamage = self:getChildGO("GuildBossDamage")
    self.mTextGuildBossDamage = self:getChildGO("mTextGuildBossDamage"):GetComponent(ty.Text)

    -- self.mBossSkill = self:getChildGO("mToggleBossSkill")
    -- self.mTxtBossSelect = self:getChildGO("mTxtBossSelect")
    -- self.mTxtBossSelect:SetActive(false)
    -- self.mToggleBossSkill = self.mBossSkill:GetComponent(ty.Toggle)
    -- local function onValChanggeBossSkill(val)
    --     if val then
    --         TipsFactory:showBossSkillTips()
    --     else
    --         TipsFactory:closeBossSkillTips()
    --     end
    --     self.mTxtBossSelect:SetActive(val)
    -- end
    -- self.mToggleBossSkill.onValueChanged:AddListener(onValChanggeBossSkill)

    -- GUIDE============================================================================
    self:setGuideTrans("BlockBtn", self:getChildTrans("BlockBtn"))
    self:setGuideTrans("GuideFrame1", self:getChildTrans("GuideFrame1"))
    self:setGuideTrans("GuideFrame2", self:getChildTrans("GuideFrame2"))
    self:setGuideTrans("GuideFrame3", self:getChildTrans("GuideFrame3"))
    self:setGuideTrans("GuideFrame4", self:getChildTrans("GuideFrame4"))
    self:setGuideTrans("GuideFrame5", self:getChildTrans("GuideFrame5"))
    self:setGuideTrans("AutoBtn1", self:getChildTrans("AutoBtn"))
    self:setGuideTrans("guide_soulBG", self:getChildTrans("guide_soulBG"))
    self:setGuideTrans("guide_fight_speedBtn", self:getChildTrans("SpeedBtn"))
end
-- 取父容器
function getParentTrans(self)
    return GameView.mainUI
end

function setAutoFight(self, beAuto)
    if beAuto then
        self.m_autoBtn:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getFightUIPath("fight_btn_5.png"), true)
        self.m_imgRound:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getFightUIPath("fight_icon_5.png"), true)
        self.m_autoText.color = gs.ColorUtil.GetColor("40484bff")
        self.m_skillTimeBar.gameObject:SetActive(false)
        self.m_skillView:setVisibleByScale(false)
        local autoType = fight.FightSetting:getAutoCfg()
        if autoType ~= 4 then
            self.m_autoFightView:showAutoFight(true)
        end
    else
        self.m_autoBtn:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getFightUIPath("fight_btn_4.png"), true)
        self.m_imgRound:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getFightUIPath("fight_icon_4.png"), true)
        self.m_autoText.color = gs.ColorUtil.GetColor("ffffffff")
        self.m_autoFightView:showAutoFight(false)

        local liveVo = fight.SceneManager:getThing(self.m_curHeroID)
        if liveVo then
            if liveVo:isAttacker() == 1 and liveVo:getRaceType() == 0 then
                self.m_skillView:setVisibleByScale(true)
            end
        end
    end
end

-- 点击聊天
function onChatHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_CHAT_PANEL)
end

-- 竞技场跳过
function onOmitHandler(self)

    local dupVo = fight.FightManager:getDupSettingData(fight.FightManager:getBattleType())
    local promptId = dupVo:getPromptId()
    local needRound = dupVo:getSkipNeedRound()

    --海底的特殊处理
    if fight.FightManager:getBattleType() == PreFightBattleType.Seabed then
        if fight.FightManager:getCurRound() >= needRound then
            if fight.SceneManager:isInFightScene() then
                UIFactory:alertMessge(_TT(promptId), true, function()
                    fight.FightManager:reqBattleSkip()
                    self:close()
                end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, RemindConst.SEABED_JUMP)
            end
        else
            gs.Message.Show(_TT(3057, needRound))
        end
    else
        if promptId > 0 then
            if fight.FightManager:getCurRound() >= needRound then
                if fight.SceneManager:isInFightScene() then
                    UIFactory:alertMessge(_TT(promptId), true, function()
                        fight.FightManager:reqBattleSkip()
                        self:close()
                    end, _TT(1), nil, true, nil, _TT(2), _TT(5))
                end
            else
                gs.Message.Show(_TT(3057, needRound))
            end
        else
            if fight.FightManager:getCurRound() >= needRound then
                if fight.SceneManager:isInFightScene() then
                    fight.FightManager:reqBattleSkip()
                end
                self:close()
            else
                gs.Message.Show(_TT(3057, needRound))
            end
        end
    end

    -- if fight.FightManager:getBattleType() == PreFightBattleType.ArenaChallenge or fight.FightManager:getBattleType() == PreFightBattleType.Friend or fight.FightManager:getBattleType() == PreFightBattleType.Arena_Peak_Pvp then
    --     local round = sysParam.SysParamManager:getValue(SysParamType.ARENA_JUMP_ROUND, 2)
    --     if fight.FightManager:getCurRound() >= round then
    --         if fight.SceneManager:isInFightScene() then
    --             fight.FightManager:reqBattleSkip()
    --         end
    --         self:close()
    --     else
    --         gs.Message.Show(_TT(3057, round))
    --     end
    -- end

    -- if fight.FightManager:getBattleType() == PreFightBattleType.Guild_boss_war or
    --     fight.FightManager:getBattleType() == PreFightBattleType.Guild_boss_imitate then
    --     local round = sysParam.SysParamManager:getValue(SysParamType.GUILDBOSS_FIGHT_SKIP, 2)
    --     if fight.FightManager:getCurRound() >= round then
    --         if fight.SceneManager:isInFightScene() then
    --             UIFactory:alertMessge(_TT(94987), true, function()
    --                 fight.FightManager:reqBattleSkip()
    --                 self:close()
    --             end, _TT(1), nil, true, nil, _TT(2), _TT(5))
    --         end
    --     else
    --         gs.Message.Show(_TT(3057, round))
    --     end
    -- end

    -- if fight.FightManager:getBattleType() == PreFightBattleType.Guild_Sweep or
    --     fight.FightManager:getBattleType() == PreFightBattleType.Guild_Imitate then
    --     local round = sysParam.SysParamManager:getValue(SysParamType.GUILD_SWEEP_SKIP, 2)
    --     if fight.FightManager:getCurRound() >= round then
    --         if fight.SceneManager:isInFightScene() then
    --             UIFactory:alertMessge(_TT(94987), true, function()
    --                 fight.FightManager:reqBattleSkip()
    --                 self:close()
    --             end, _TT(1), nil, true, nil, _TT(2), _TT(5))
    --         end
    --     else
    --         gs.Message.Show(_TT(3057, round))
    --     end
    -- end

    -- if fight.FightManager:getBattleType() == PreFightBattleType.Doundless then
    --     local round = sysParam.SysParamManager:getValue(SysParamType.DOUNDLESS_FIGHT_SKIP, 2)
    --     if fight.FightManager:getCurRound() >= round then
    --         if fight.SceneManager:isInFightScene() then
    --             UIFactory:alertMessge(_TT(94987), true, function()
    --                 fight.FightManager:reqBattleSkip()
    --                 self:close()
    --             end, _TT(1), nil, true, nil, _TT(2), _TT(5))
    --         end
    --     else
    --         gs.Message.Show(_TT(3057, round))
    --     end
    -- end

    -- if fight.FightManager:getBattleType() == PreFightBattleType.Disaster or fight.FightManager:getBattleType() == PreFightBattleType.Disater_imitate then
    --     local round = sysParam.SysParamManager:getValue(SysParamType.DISASTER_FIGHT_SKIP, 2)
    --     if fight.FightManager:getCurRound() >= round then
    --         if fight.SceneManager:isInFightScene() then
    --             UIFactory:alertMessge(_TT(94987), true, function()
    --                 fight.FightManager:reqBattleSkip()
    --                 self:close()
    --             end, _TT(1), nil, true, nil, _TT(2), _TT(5))
    --         end
    --     else
    --         gs.Message.Show(_TT(3057, round))
    --     end
    -- end

    -- if fight.FightManager:getBattleType() == PreFightBattleType.Seabed then
    --     local round = sysParam.SysParamManager:getValue(SysParamType.SEABED_FIGHT_SKIP, 2)
    --     if fight.FightManager:getCurRound() >= round then
    --         if fight.SceneManager:isInFightScene() then
    --             UIFactory:alertMessge(_TT(112522), true, function()
    --                 fight.FightManager:reqBattleSkip()
    --                 self:close()
    --             end, _TT(1), nil, true, nil, _TT(2), _TT(5),nil,RemindConst.SEABED_JUMP)
    --         end
    --     else
    --         gs.Message.Show(_TT(3057, round))
    --     end
    -- end
end

-- 点击BUFF按钮
function onBuffHandler(self)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FIGHT_BUFF_INFO, true) == false then
        return
    end
    self.m_showBuffPanel = not self.m_showBuffPanel
    self:updateBuffPanel()
    self:updateBuffBtn()
end

-- 更新buff界面打开状态
function updateBuffPanel(self)
    if self.m_showBuffPanel then
        if self.m_buffPanel == nil then
            self.m_buffPanel = fightUI.FightBuffInfoView.new()
            self.m_buffPanel:addEventListener(View.EVENT_CLOSE, self.onBuffPanelCloseHandler, self)
        end
        self.m_buffPanel:open()
    else
        self.m_buffPanel:close()
    end
end

function onBuffPanelCloseHandler(self)
    self.m_showBuffPanel = false
    self.m_buffPanel:removeEventListener(View.EVENT_CLOSE, self.onBuffPanelCloseHandler, self)
    self.m_buffPanel = nil
    self:updateBuffBtn()
end

-- 更新buff按钮状态
function updateBuffBtn(self)
    if self.m_showBuffPanel then
        self.m_buffTxt.color = gs.ColorUtil.GetColor("40484bff")
        self.m_buffBtn:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getFightUIPath("fight_btn_5.png"), true)
    else
        self.m_buffTxt.color = gs.ColorUtil.GetColor("ffffffff")
        self.m_buffBtn:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getFightUIPath("fight_btn_4.png"), true)
    end
end

-- 点击加速
function onSpeedHandler(self)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FIGHT_SPEED, true) == false then
        return
    end

    if self.m_beSpeedLock == true or not fight.FightManager:getIsFighting() then
        return
    end
    fight.FightManager:updateTimeScale()
    if fight.FightManager:getTimeScaleType() == 1 then
        fight.FightSetting:setSpeedCfg(1)
    elseif fight.FightManager:getTimeScaleType() == 2 then
        fight.FightSetting:setSpeedCfg(2)
    elseif fight.FightManager:getTimeScaleType() == 3 then
        fight.FightSetting:setSpeedCfg(3)
    elseif fight.FightManager:getTimeScaleType() == 4 then
        fight.FightSetting:setSpeedCfg(4)
    else
        fight.FightSetting:setSpeedCfg(5)
    end
    self:updateSpeedTxt(fight.FightManager:getTimeScaleType())
end

-- 更新倍速文本显示
function updateSpeedTxt(self, cusTxt)
    self.m_speedTxt.text = cusTxt

    if fight.FightSetting:getSpeedCfg() > 1 then
        self.m_speedTxt.color = gs.ColorUtil.GetColor("40484bff")
        self.m_speedIcon.color = gs.ColorUtil.GetColor("40484bff")
        self.m_speedTxtX.color = gs.ColorUtil.GetColor("40484bff")
        self.m_speedBtn:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getFightUIPath("fight_btn_5.png"), true)
    else
        self.m_speedTxt.color = gs.ColorUtil.GetColor("ffffffff")
        self.m_speedIcon.color = gs.ColorUtil.GetColor("ffffffff")
        self.m_speedTxtX.color = gs.ColorUtil.GetColor("ffffffff")
        self.m_speedBtn:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getFightUIPath("fight_btn_4.png"), true)
    end
end

-- 更新自动战斗状态
function updateAutoFight(self, bool)
    if bool then
        fight.FightManager:reqAuto(1)
        LoopManager:addFrame(1, 0, self, self._autoFightStateCall)
    else
        fight.FightManager:reqAuto(0)
        LoopManager:removeFrame(self, self._autoFightStateCall)
    end
end

function _autoFightStateCall(self)
    gs.TransQuick:SetLRotation(self.m_imgRound, 0, 0, gs.TransQuick:GetRotationZ(self.m_imgRound) + 3)
end

-- 点击暂停
function onSettingHandler(self)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FIGHT_SETTING, true) == false then
        return
    end
    if self.m_settingView == nil then
        self.m_settingView = fightUI.FightSettingView.new()
        self.m_settingView:addEventListener(View.EVENT_CLOSE, self.onSettingViewCloseHandler, self)
    end
    self.m_settingView:open()
end

function onSettingViewCloseHandler(self)
    self.m_settingView:removeEventListener(View.EVENT_CLOSE, self.onSettingViewCloseHandler, self)
    self.m_settingView = nil
    self.m_queueView:updateMaxCount()
    self:_heroBarProfessionTypeUpdate()
end

function getParentTrans(self)
    return GameView.mainUI
end

-- 打开战场环境信息
function onShowSupportHandler(self)
    local dupVo = fight.SceneManager:getCusDupData()
    if dupVo and dupVo.getSupportSkill and #dupVo:getSupportSkill() > 0 then
        local skillList = dupVo:getSupportSkill()
        if self.mFightSupportTips == nil then
            self.mFightSupportTips = fightUI.FightSupportInfoTips.new()
            self.mFightSupportTips:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFightSupportTips, self)
        end
        self.mFightSupportTips:open({
            skillList = skillList
        })
    end
end
function onDestroyFightSupportTips(self)
    self.mFightSupportTips:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFightSupportTips, self)
    self.mFightSupportTips = nil
end

-- 激活
function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.ROLE_GO_ACTION, self._roleGoAction, self)
    GameDispatcher:addEventListener(EventName.LIEN_UP_LIST_UPDATE, self._lineUpListUpdate, self)
    GameDispatcher:addEventListener(EventName.FIGHT_HERO_ATTR_UPDATE, self._heroAttrUpdate, self)
    GameDispatcher:addEventListener(EventName.SKILL_END, self._skillEnd, self)
    GameDispatcher:addEventListener(EventName.LAST_HIT_ACTION, self._lastHit, self)
    GameDispatcher:addEventListener(EventName.RUN_SKILL_ACTION, self._runSkillAction, self)
    GameDispatcher:addEventListener(EventName.UPDATE_BUFF, self._updateBuff, self)
    GameDispatcher:addEventListener(EventName.START_RUN_SKILL_ACTION, self._startRunSkill, self)
    GameDispatcher:addEventListener(EventName.START_PLAYSKILL_ACITON, self.showSkillName, self)
    GameDispatcher:addEventListener(EventName.AUTO_FIGHT_EVENT, self._autoFightChange, self)
    GameDispatcher:addEventListener(EventName.SKILL_USE_SUCCESS, self._skillUseSuccess, self)
    GameDispatcher:addEventListener(EventName.UPDATE_SKILL_ROUNT, self._updateSkillRount, self)
    GameDispatcher:addEventListener(EventName.START_WAVE, self._startWave, self)
    GameDispatcher:addEventListener(EventName.GUIDE_BLOCK_EVENT, self._guideBlock, self)
    GameDispatcher:addEventListener(EventName.FORCRES_SKILL_ENERGY_UPDATE, self._forcesSkillEnergy, self)
    GameDispatcher:addEventListener(EventName.BLOCK_SUC_COUNT_UPDATE, self._blockSucUpdate, self)

    GameDispatcher:addEventListener(EventName.FIGHT_RESULT_PANEL_SHOW, self._battleFinish, self)

    GameDispatcher:addEventListener(EventName.UPDATE_FIGHT_BUFF_LAYOUT_COUNT, self.onUpdateBuffValue, self)
    GameDispatcher:addEventListener(EventName.EVENT_UI_CLOSE, self.onCloseViewHandler, self)
    GameDispatcher:addEventListener(EventName.FIHGT_HERO_IN_SCENE, self.onHeroInSceneHandler, self)
    GameDispatcher:addEventListener(EventName.FIGHT_GUILDBOSS_DAMAGE_UPDATE, self.showGuildBossTotalDamageInfo, self)

    -- gs.CameraMgr:SetUICameraProjetion(false)

    fight.FightCamera:setFightCamera(true)

    self:_lineUpListUpdate()
    self:_refreshFormat()
    local roleIDList = fight.FightManager:getCurRoleList()
    if not table.empty(roleIDList) then
        local liveVo = fight.SceneManager:getThing(roleIDList[1])
        if liveVo then
            self.m_queueView:setActiveItem(roleIDList[1], liveVo:isAttacker())
        end
    end

    -- self.m_roundTxt1.text = string.format("%02d/%02d", fight.FightManager:getCurRound(), fight.FightManager:getMaxRound())
    self.m_roundTxt2.text = string.format("%02d/%02d", fight.FightManager:getCurRound(),
    fight.FightManager:getMaxRound())

    self.m_beAutoLock = false
    self.m_beSpeedLock = false
    local bType = fight.FightManager:getBattleType()
    local autoType = fight.FightSetting:getAutoCfg()
    self.m_beAutoLock = false
    if autoType == 3 or autoType == 4 then
        self.m_beAutoLock = true
    end
    if fight.FightManager:getIsAutoFight() or (autoType == 2 or autoType == 4) then
        self:setAutoFight(true)
        self:updateAutoFight(true)
    else
        self:setAutoFight(false)
        self:updateAutoFight(false)
    end
    -- if (fight.FightManager:getIsAutoFight() and (autoType == 2 or autoType == 4)) or (fight.FightManager:getIsAutoFight() == false and (autoType == 1 or autoType == 3)) then
    --     self:_autoFightChange()
    -- else
    --     if (autoType == 2 or autoType == 4) then
    --         self:updateAutoFight(true)
    --     else
    --         self:updateAutoFight(false)
    --     end
    -- end

    local speedTxt = "1"
    local speedType = fight.FightSetting:getSpeedCfg()
    -- if speedType == 2 then
    --     speedTxt = "2"
    -- elseif speedType == 4 then
    --     speedTxt = "2"
    -- elseif speedType == 5 then
    --     speedTxt = "3"
    -- elseif speedType == 6 then
    --     speedTxt = "3"
    -- end
    self:updateSpeedTxt(speedType)

    RateLooper:clearTimeout(self.m_startSn)
    local function _timeoutCall()
        self.m_startSn = 0
        local function _finishCall()
            self.m_startView:setActive(false)
            local speedType, dupSpeedType = fight.FightSetting:getSpeedCfg()
            if dupSpeedType == 1 then
                fight.FightManager:updateTimeScale(speedType)
            elseif dupSpeedType == 2 then
                fight.FightManager:updateTimeScale(speedType)
            elseif dupSpeedType == 3 then
                fight.FightManager:updateTimeScale(1)
                self.m_beSpeedLock = true
            elseif dupSpeedType == 4 then
                fight.FightManager:updateTimeScale(2)
                self.m_beSpeedLock = true
            elseif dupSpeedType == 5 then
                fight.FightManager:updateTimeScale(3)
            elseif dupSpeedType == 6 then
                fight.FightManager:updateTimeScale(3)
                self.m_beSpeedLock = true
            else
                fight.FightManager:updateTimeScale(speedType)
            end
            self:updateSpeedTxt(fight.FightManager:getTimeScaleType())

            fight.FightAction:start()

            local dupVo = fight.FightManager:getDupSettingData(fight.FightManager:getBattleType())
            -- 跳过按钮显示控制
            self.m_omitBtn:SetActive(dupVo and dupVo:getSkipNeedRound() > 0)
        end
        self.m_startView:setActive(true)
        self.m_startView:start(_finishCall)
    end

    self.m_startSn = RateLooper:setTimeout(0.1, self, _timeoutCall)

    self.m_hitView:show()
    self.m_blockView:show()
    self.m_blockTeachingView:show()

    self.m_beHideBlock = guide.GuideCondition:condition17()
    if self.m_beHideBlock == true then
        self.m_blockView:setVisibleByScale(false)
    end

    self.m_hideMaxSkill = guide.GuideCondition:condition23()
    self.m_skillView:hideMaxSkill(self.m_hideMaxSkill)

    self.mGuildBossDamage:SetActive(bType == PreFightBattleType.Guild_boss_war or bType ==
        PreFightBattleType.Guild_boss_imitate or bType == PreFightBattleType.Guild_Sweep or
        bType == PreFightBattleType.Disaster or bType ==
    PreFightBattleType.Disater_imitate or bType == PreFightBattleType.Guild_Imitate)
    -- local langId = 94588
    -- if bType == PreFightBattleType.Guild_boss_war then
    --     langId = 94588
    -- elseif bType == PreFightBattleType.Guild_boss_imitate then
    --     langId = 94593
    -- elseif bType == PreFightBattleType.Guild_Sweep then
    --     langId = 94588
    -- end
    local langId = bType == (PreFightBattleType.Guild_boss_imitate or bType == PreFightBattleType.Disater_imitate) and
    94593 or 94588
    self.mTextGuildBossDamage.text = _TT(langId) .. 0

    self.needSmallerStage = sysParam.SysParamManager:getValue(1904)
    self.needStage = sysParam.SysParamManager:getValue(1905)
    self.outTime = sysParam.SysParamManager:getValue(1903) / 1000

    self:updateSupport()
    self:updateBossHead()
    -- local dupData = fight.SceneManager:getCusDupData()

    -- if dupData and dupData.bossId and dupData.bossId > 0 then
    --     self.mBossSkill:SetActive(true)
    -- else
    --     self.mBossSkill:SetActive(false)
    -- end
end

-- 非激活
function deActive(self)

    TipsFactory:closeBossSkillTips()

    GameDispatcher:removeEventListener(EventName.ROLE_GO_ACTION, self._roleGoAction, self)
    GameDispatcher:removeEventListener(EventName.LIEN_UP_LIST_UPDATE, self._lineUpListUpdate, self)
    GameDispatcher:removeEventListener(EventName.FIGHT_HERO_ATTR_UPDATE, self._heroAttrUpdate, self)

    GameDispatcher:removeEventListener(EventName.SKILL_END, self._skillEnd, self)
    GameDispatcher:removeEventListener(EventName.LAST_HIT_ACTION, self._lastHit, self)
    GameDispatcher:removeEventListener(EventName.RUN_SKILL_ACTION, self._runSkillAction, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_BUFF, self._updateBuff, self)
    GameDispatcher:removeEventListener(EventName.START_RUN_SKILL_ACTION, self._startRunSkill, self)
    GameDispatcher:removeEventListener(EventName.START_PLAYSKILL_ACITON, self.showSkillName, self)
    GameDispatcher:removeEventListener(EventName.AUTO_FIGHT_EVENT, self._autoFightChange, self)
    GameDispatcher:removeEventListener(EventName.SKILL_USE_SUCCESS, self._skillUseSuccess, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_SKILL_ROUNT, self._updateSkillRount, self)
    GameDispatcher:removeEventListener(EventName.START_WAVE, self._startWave, self)
    GameDispatcher:removeEventListener(EventName.GUIDE_BLOCK_EVENT, self._guideBlock, self)
    GameDispatcher:removeEventListener(EventName.FORCRES_SKILL_ENERGY_UPDATE, self._forcesSkillEnergy, self)
    GameDispatcher:removeEventListener(EventName.BLOCK_SUC_COUNT_UPDATE, self._blockSucUpdate, self)

    GameDispatcher:removeEventListener(EventName.FIGHT_RESULT_PANEL_SHOW, self._battleFinish, self)

    GameDispatcher:removeEventListener(EventName.UPDATE_FIGHT_BUFF_LAYOUT_COUNT, self.onUpdateBuffValue, self)
    GameDispatcher:removeEventListener(EventName.EVENT_UI_CLOSE, self.onCloseViewHandler, self)
    GameDispatcher:removeEventListener(EventName.FIHGT_HERO_IN_SCENE, self.onHeroInSceneHandler, self)
    GameDispatcher:removeEventListener(EventName.FIGHT_GUILDBOSS_DAMAGE_UPDATE, self.showGuildBossTotalDamageInfo, self)

    -- gs.CameraMgr:SetUICameraProjetion(true)

    if (self.m_skillTimeTween) then
        self.m_skillTimeTween:Kill()
        self.m_skillTimeTween = nil
    end

    RateLooper:clearTimeout(self.m_totalDamageSn)
    self.m_totalDamageSn = 0
    RateLooper:clearTimeout(self.m_totalCureSn)
    self.m_totalCureSn = 0

    RateLooper:clearTimeout(self.m_startSn)
    self.m_startSn = 0
    self.m_skillView:resetSkill()
    self.m_hitView:close()
    LoopManager:removeFrame(self, self._autoFightStateCall)

    self.m_blockView:close()

    if self.mSetTimeOutSn then
        LoopManager:clearTimeout(self.mSetTimeOutSn)
        self.mSetTimeOutSn = nil
    end

    self:recoverSupportList()

    super.deActive(self)
end

function onClickClose(self)
end

function onCloseViewHandler(self, viewClassName)
    -- if viewClassName.__cname == "fightUI.FightElementReactionPanel" then
    --     self.mToggleElementReaction.isOn = false
    -- else
    -- if viewClassName.__cname == "tips.BossSkillTips" then
    --     self.mToggleBossSkill.isOn = false
    -- end
end

function close(self)
    if self.m_settingView and self.m_settingView.isPop then
        self.m_settingView:close()
    end
    super.close(self)
end

-- 增伤和减治疗Buff值变化
function onUpdateBuffValue(self, layoutCount)
    if not self.mDebuffGroup.activeSelf then
        self.mDebuffGroup:SetActive(true)

        gs.TransQuick:LPosY(self.mGroupSupport, -140)
    end

    if not self.OverloadTips.activeSelf then
        self.OverloadTips:SetActive(true)
    end

    local curBattle = fight.FightManager:getBattleType()
    local dupFightConfig = fight.FightManager:getDupSettingData(curBattle)
    self.mTextDeBuffValue_1.text = string.format("+%s%%", dupFightConfig:getAttackValue() * layoutCount)
    self.mTextDeBuffValue_2.text = string.format("+%s%%", dupFightConfig:getReduceValue() * layoutCount)

    self.mTxtTips_2.text = _TT(3062, dupFightConfig:getAttackValue() * layoutCount)
    self.mTxtTips_3.text = _TT(3063, dupFightConfig:getReduceValue() * layoutCount)

    if self.m_outTimer then
        self:clearTimeout(self.m_outTimer)
        self.m_outTimer = nil
    end

    self.m_outTimer = self:setTimeout(3, function()
        self.OverloadTips:SetActive(false)
    end)
end

-- 盟约能力变化
function _forcesSkillEnergy(self)
    if self.m_forcesSkillView then
        local list = fight.FightManager:getForcesSkillList()
        if list and #list > 0 then
            self.m_forcesSkillView:udateForcesSkillEnergy()
        end
    end
end

-- 格挡成功次数更新
function _blockSucUpdate(self)
    if self.m_blockTeachingView then
        self.m_blockTeachingView:updateCount()
    end
end

-- 战斗结束
function _battleFinish(self)
    if self.m_hitView then
        self.m_hitView:setVisibleByScale(false)
    end
end

-- 波次
function _startWave(self)
    self.m_waveTxt.text = fight.FightManager:getWaveCnt()
    self.m_waveView:startWave()
end

-- 引导格挡
function _guideBlock(self)
    self.m_beHideBlock = nil
    if self.m_blockView and not fight.FightManager:isReplaying() then
        self.m_blockView:setVisibleByScale(true)
        self.m_blockView:updateBlockVal()
    end
end

-- 使用技能成功
function _skillUseSuccess(self, msg)

    self:resetFirstTipsContent()

    if fight.FightManager:toUniqueID(1, msg.hero_id) == self.m_curHeroID then
        self.m_skillView:setUseSkill(msg.skill_id)
        self.m_skillView:updateSoul()
    end
end

function _updateSkillRount(self, skillID)
    self.m_skillView:updateRount(skillID)
end

function _autoFightChange(self)
    self:setAutoFight(fight.FightManager:getIsAutoFight())
end

function _refreshSkill(self)
    self.m_skillView:setReadyLive(self.m_curHeroID)
    self.m_autoFightView:setActionLiveId(self.m_curHeroID)
    self:_updateBuff(self.m_curHeroID)
end

function _refreshRound(self)
    -- self.m_roundTxt1.text = string.format("%02d", fight.FightManager:getCurRound())
    self.m_roundTxt2.text = string.format("%02d/%02d", fight.FightManager:getCurRound(),
    fight.FightManager:getMaxRound())
end

-- 更新阵容雷达
function _refreshFormat(self)
    self.m_leftSFormat:closeAllFlag()
    self.m_rightSFormat:closeAllFlag()
    local liveDict = fight.SceneManager:getAllThing()
    for k, v in pairs(liveDict) do
        if v:getGridID() ~= 0 then
            if v:isAttacker() == 1 then
                if v:isDead() then
                    self.m_leftSFormat:setDisableFlag(v:getGridID())
                else
                    if fight.FightAction:isLiveVoActiving(v) then
                        self.m_leftSFormat:setAttackFlag(v:getGridID())
                    elseif fight.FightAction:isTargetLiveVo(v.id) then
                        self.m_leftSFormat:setTargetFlag(v:getGridID())
                    else
                        self.m_leftSFormat:setNorFlag(v:getGridID())
                    end
                end
            else
                if v:isDead() then
                    self.m_rightSFormat:setDisableFlag(v:getGridID())
                else
                    if fight.FightAction:isLiveVoActiving(v) then
                        self.m_rightSFormat:setAttackFlag(v:getGridID())
                    elseif fight.FightAction:isTargetLiveVo(v.id) then
                        self.m_rightSFormat:setTargetFlag(v:getGridID())
                    else
                        self.m_rightSFormat:setNorFlag(v:getGridID())
                    end
                end
            end
            --if v.m_raceVo.mon
        end

        local format
        if v:isAttacker() == 1 then
            format = self.m_leftSFormat
        else
            format = self.m_rightSFormat
        end

        if v:getRaceVo().monType == monster.MonsterType.NO_HP_MONSTER then
            format:setNoHpFlag(v:getGridID(),v:isDead())
        end
    end
end

-- 更新盟约技能
function _refreshForcesSkill(self)
    if self.m_forcesSkillView then
        local list = fight.FightManager:getForcesSkillList()
        if list and #list > 0 then
            self.m_forcesSkillView:setForcesSkill(list)
            self.m_forcesSkillView:setVisibleByScale(true)
            self:_forcesSkillEnergy()
        else
            self.m_forcesSkillView:setVisibleByScale(false)
        end
    end
end

----------------------------------------------------------------------------
function _heroBarProfessionTypeUpdate(self)
    local dict = fight.SceneItemManager:getAllLiveThing()
    for _, live in pairs(dict) do
        local liveVo = live:getLiveVo()
        if liveVo and not liveVo:isDead() then
            live:updateProfessionType()
        end
    end
end

function _heroAttrUpdate(self, heroID)
    if self.m_curHeroID == heroID then
        self:_refreshSkill()
        self.m_skillView:updateSoul()
    end
    local liveObj = fight.SceneItemManager:getLivething(heroID)
    if liveObj then
        liveObj:updateHeadBar()
    end

    -- self.m_soulView:updateBar()
    self.m_autoFightView:updateState()
end

function _roleGoAction(self, actionData)
    local dict = fight.SceneItemManager:getAllLiveThing()
    if StorageUtil:getBool1(gstor.FIGHT_SHOW_HP) == false then
        for _, live in pairs(dict) do
            local liveVo = live:getLiveVo()
            if liveVo and not liveVo:isDead() then
                live:closeHeadBar()
            end
        end
    end
    self.m_hitView:resetHit()
    self.m_hitView:setVisibleByScale(false)
    self.m_queueView:setActive(true)
    self.m_curHeroID = actionData.hero_id
    self.m_soulView:setActive(true)
    self.m_soulView:setHeroLiveID(self.m_curHeroID)
    self.m_totalDamage = nil
    self.m_totalCure = nil
    local liveVo = fight.SceneManager:getThing(self.m_curHeroID)
    if liveVo then
        if liveVo:isAttacker() ~= 1 or liveVo:getRaceType() ~= 0 then
            self.m_skillView:setVisibleByScale(false)
            if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FIGHT_ABBLOCK) and self.m_beHideBlock ~=
                true and not fight.FightManager:isReplaying() then
                self.m_blockView:setVisibleByScale(true)
                self.m_blockView:updateBlockVal()
            else
                self.m_blockView:setVisibleByScale(false)
            end
        else
            if fight.FightManager:getIsAutoFight() == true and StorageUtil:getBool1(gstor.FIGHT_SHOW_UI) == true then
                self.m_skillView:setVisibleByScale(false)
            else
                if not fight.FightManager:isReplaying() and not fight.FightManager:getIsAutoFight() then
                    self.m_skillView:setVisibleByScale(true)
                end
            end
            self.m_skillView:resetSkill()
            self:_refreshSkill()
            self.m_blockView:setVisibleByScale(false)
        end
    end

    self:_refreshRound()
    self:_refreshFormat()
    self:_refreshForcesSkill()

    self.m_queueView:setActiveItem(self.m_curHeroID, liveVo:isAttacker())
    self:resetFirstTipsContent()

    if battleMap.MainMapManager:isStagePass(self.needSmallerStage) == nil and
        tonumber(fight.FightManager:getBattleFieldID()) > self.needStage then
        self.mSetTimeOutSn = LoopManager:setTimeout(self.outTime, self, self.showFirstEff)
    end
end

function _lineUpListUpdate(self)
    self.m_queueView:setActive(true)
    self.m_queueView:updateQueue()
    self:_refreshRound()
end

-- 技能相关的buff实现方法
function _updateBuff(self, targetLiveID)
    if targetLiveID == self.m_curHeroID then
        local liveVo = fight.SceneManager:getThing(self.m_curHeroID)
        if liveVo then
            local bDict = liveVo:getBuffDataDict()
            if bDict then
                for buffRefID, v in pairs(bDict) do
                    local bRo = Buff.BuffRoMgr:getBuffRo(buffRefID)
                    if bRo then
                        local fID = bRo:getFid()
                        -- print("=============",buffRefID, fID)
                        if fID == BuffDef.BUFF_TYPE_PALSY then -- 沉默
                            self.m_skillView:disableNorSkill(_TT(3052))
                            self.m_skillView:disableUprightSkill(_TT(3052))
                        elseif fID == BuffDef.BUFF_TYPE_DIZZY then
                            self.m_skillView:disableNorSkill(_TT(3053))
                            self.m_skillView:disableUprightSkill(_TT(3053))
                        elseif fID == BuffDef.BUFF_TYPE_CONFUSED then
                            self.m_skillView:disableNorSkill(_TT(3054))
                            self.m_skillView:disableUprightSkill(_TT(3054))
                        elseif fID == BuffDef.BUFF_TYPE_FROZE_INJURY_RAND_REMOVE then
                            self.m_skillView:disableNorSkill(_TT(3055))
                            self.m_skillView:disableUprightSkill(_TT(3055))
                        elseif fID == BuffDef.BUFF_TYPE_FENGJI then -- 封技
                            self.m_skillView:disableNorSkill("封技")
                        elseif fID == BuffDef.BUFF_TYPE_FENGYIN then -- 封印
                            self.m_skillView:disableUprightSkill(_TT(3056))
                        elseif fID == BuffDef.BUFF_TYPE_SKILL_SOUL_COST_ADD then
                            self.m_skillView:changeSoul(v[3] * v[2]) -- 层数 * 数值
                        elseif fID == BuffDef.BUFF_TYPE_SKILL_SOUL_COST_CUT or fID ==
                            BuffDef.BUFF_TYPE_SKILL_SOUL_COST_CUT_2 then
                            self.m_skillView:changeSoul(-v[3] * v[2]) -- 层数 * 数值
                        end
                    end
                end
            end
        end
    end
end

function _runSkillAction(self, actionData)
    if actionData.skill_id == 0 then
        return
    end

    self.m_curActionData = actionData
    self:_heroAttrUpdate(self.m_curHeroID)
    local skillVo = fight.SkillManager:getSkillRo(self.m_curActionData.skill_id)
    local liveVo = fight.SceneManager:getThing(self.m_curHeroID)
    if liveVo == nil or liveVo:isAttacker() ~= 1 then
        if skillVo and skillVo:getQteArg() == 1 then
            if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FIGHT_ABBLOCK) and self.m_beHideBlock ~=
                true and not fight.FightManager:isReplaying() then
                self.m_blockView:setVisibleByScale(true)
                self.m_blockView:updateBlockVal()
            else
                self.m_blockView:setVisibleByScale(false)
            end
        end
    else
        self.m_blockView:setVisibleByScale(false)
    end
    if liveVo then
        self:_updateBuff(self.m_curHeroID)
        if liveVo:isAttacker() == 1 then
            self.m_skillView:setUseSkill(self.m_curActionData.skill_id, false)
            self.m_skillView:updateSoul()
            if skillVo:getType() == 3 or skillVo:getType() == 2 then
                self.m_skillView:setVisibleByScale(false)
            end
            -- local skillVo = fight.SkillManager:getSkillRo(self.m_curActionData.skill_id)
            -- if skillVo then
            -- if skillVo:getType()==1 or skillVo:getType()==2 or skillVo:getType()==3 then
            -- self.m_totalDamage = tostring(self.m_curActionData.m_totalDamage)
            -- end
            -- end
        end
    end
    self:_refreshFormat()
end

-- 显示技能名称
function showSkillName(self, skillData)

    local skillName = skillData.skillName
    local liveVo = skillData.liveVo

    if liveVo.isAtt == 1 then
        self.SkillNameGroupLeft:SetActive(true)
        self.mSkillNameAnimator_Left:SetTrigger("show")
        self.mTxtLeft_SkillName.text = skillName

        if liveVo:getRaceType() == 0 then
            self.mImgLeftHeroIcon:SetImg(string.format(UrlManager:getFormationHeadUrl(liveVo:getModelID())), false)
            self.mTxtLeft_HeroName.text = liveVo:getRaceVo().name
        else
            local monsterVo = monster.MonsterManager:getMonsterVo01(liveVo.tid)
            self.mImgLeftHeroIcon:SetImg(UrlManager:getFormationHeadUrl(monsterVo:getShowModelld()), true)
            self.mTxtLeft_HeroName.text = monsterVo.name
        end
    else
        self.SkillNameGroupRight:SetActive(true)
        self.mSkillNameAnimator_Right:SetTrigger("show")
        self.mTxtRight_SkillName.text = skillName

        if liveVo:getRaceType() == 0 then
            self.mImgRightHeroIcon:SetImg(UrlManager:getFormationHeadUrl(liveVo:getModelID()), false)
            self.mTxtRight_HeroName.text = liveVo:getRaceVo().name
        else
            local monsterVo = monster.MonsterManager:getMonsterVo01(liveVo.tid)
            self.mImgRightHeroIcon:SetImg(UrlManager:getFormationHeadUrl(monsterVo:getShowModelld()), true)
            self.mTxtRight_HeroName.text = monsterVo.name
        end
    end

end

-- 更新战场环境
function updateSupport(self)
    self:recoverSupportList()

    local dupVo = fight.SceneManager:getCusDupData()
    if dupVo and dupVo.getSupportSkill then
        local skillList = dupVo:getSupportSkill()
        if skillList and #skillList > 0 then
            for i, v in ipairs(skillList) do
                local skillVo = fight.SkillManager:getSkillRo(v)
                local item = SimpleInsItem:create(self:getChildGO("GroupSupportItem"), self.mGroupSupport,
                "FightUISupportItem")
                item:getChildGO("mImgSupportIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getSkillIconPath(
                skillVo:getIcon()), false)
                table.insert(self.mSupportList, item)
            end
        end
    end
end

-- 回收战场环境图标
function recoverSupportList(self)
    for i, v in ipairs(self.mSupportList) do
        v:poolRecover()
    end
    self.mSupportList = {}
end

-- 更新战斗单位加入战场
function onHeroInSceneHandler(self, liveId)
    local liveVo = fight.SceneManager:getThing(liveId)
    if liveVo and not liveVo:isDead() and liveVo:getRaceVo().monType == monster.MonsterType.SUPER_BOSS then
        self.m_bossHeadAreaView:setBossLiveId(liveId)
    end
end

-- 设置boss头像显示
function updateBossHead(self)
    local bType = fight.FightManager:getBattleType()
    if bType == PreFightBattleType.Guild_Imitate then
        self.m_bossHeadAreaView:setVisibleByScale(false)
        return
    end

    -- if bType == PreFightBattleType.Disaster or bType == PreFightBattleType.Disater_imitate then
    --     local curDif = disaster.DisasterManager:getCurChallengingDif()
    --     local maxDif = disaster.DisasterManager:getDisasterDupMaxDif()
    --     if curDif == maxDif then
    --         self.m_bossHeadAreaView:setVisibleByScale(false)
    --     else
    --         local defList = fight.SceneManager:getSideThingIDs(2)
    --         for i, v in ipairs(defList) do
    --             local liveId = defList[i]
    --             local liveVo = fight.SceneManager:getThing(liveId)
    --             if liveVo and not liveVo:isDead() and liveVo:getRaceVo().monType == monster.MonsterType.SUPER_BOSS then
    --                 self.m_bossHeadAreaView:setVisibleByScale(true)
    --                 self.m_bossHeadAreaView:setBossLiveId(liveId)
    --                 break
    --             end
    --         end
    --     end
    -- else
    local defList = fight.SceneManager:getSideThingIDs(2)
    for i, v in ipairs(defList) do
        local liveId = defList[i]
        local liveVo = fight.SceneManager:getThing(liveId)
        if liveVo and not liveVo:isDead() and liveVo:getRaceVo().monType == monster.MonsterType.SUPER_BOSS then
            self.m_bossHeadAreaView:setVisibleByScale(true)
            self.m_bossHeadAreaView:setBossLiveId(liveId)
            break
        end
    end
    -- end
end

-- 有角色出招 会通知这里
function _startRunSkill(self, skillData)
    if (self.m_skillTimeTween) then
        self.m_skillTimeTween:Kill()
        self.m_skillTimeTween = nil
    end

    local isBarActive = false
    if fight.FightManager:getIsAutoFight() ~= 1 then
        local liveVo = fight.SceneManager:getThing(self.m_curHeroID)
        if liveVo and liveVo:isAttacker() == 1 then

            -- 不是终结 或 奥义
            if skillData[3] ~= 2 and skillData[3] ~= 3 then
                isBarActive = true
                local skillTime = skillData[2]
                self.m_skillTimeBar.gameObject:SetActive(true)
                self.m_skillTimeBar.fillAmount = 1
                -- self.m_skillTimeBar.color = gs.COlOR_GREEN
                self.m_skillTimeBarValTxt.text = string.format("%.1f", skillTime)
                -- self.m_skillTimeBarValTxt.text = string.format("%.1f", skillTime / 100 * 10)
                local function _progressCall(val)
                    val = val / 100
                    self.m_skillTimeBar.fillAmount = val
                    self.m_skillTimeBarValTxt.text = string.format("%.1f", skillTime * val)
                    -- if val >= 0.75 then
                    --     self.m_skillTimeBar.color = gs.COlOR_GREEN
                    -- elseif val <= 0.25 then
                    --     self.m_skillTimeBar.color = gs.COlOR_RED
                    -- elseif val >= 0.5 and val < 0.75 then
                    --     self.m_skillTimeBar.color = gs.COlOR_YELLOW
                    -- elseif val > 0.25 and val < 0.5 then
                    --     self.m_skillTimeBar.color = gs.ColorUtil.GetColor(ColorDef.c6)
                    -- end
                end

                local function _finishCall()
                    self.m_skillTimeTween = gs.DT.DoTweenEx.DOProgressIntVal(20, 0, 0.5, _progressCall)
                end

                local canGuide = guide.GuideCondition:condition27(skillData[4], skillData[1], skillData[2], _finishCall)
                if canGuide then
                    self.m_skillTimeTween = gs.DT.DoTweenEx.DOProgressIntVal(100, 20, skillTime - 0.5, _progressCall)
                else
                    self.m_skillTimeTween = gs.DT.DoTweenEx.DOProgressIntVal(100, 0, skillTime, _progressCall)
                end

                -- self.m_skillTimeTween = self.m_skillTimeBar:DOProgress(100, skillTime)
                -- local function _tweenFinish()
                --     self.m_skillTimeTween = nil
                --     self.m_skillTimeBar.gameObject:SetActive(false)
                --     fight.FightManager:reqBattleVideoEnd()
                -- end
                -- self.m_skillTimeTween:OnComplete(finishCall)
            else
                fight.FightManager:reqBattleVideoEnd()
            end
        end
    end
    if isBarActive == false then
        self.m_skillTimeBar.gameObject:SetActive(false)
    end

    local liveVo = fight.SceneManager:getThing(self.m_curHeroID)
    if liveVo then
        if liveVo:isAttacker() == 1 then
            -- 我方出指定技能时触发
            if guide.GuideCondition:condition10(skillData[1]) then
                return
            end

            -- 非终结技和奥义时 判断新手引导
            if skillData[3] ~= 2 and skillData[3] ~= 3 then
                if guide.GuideCondition:condition02() then
                    return
                end
            end
        else
            -- 敌方出指定技能时触发
            if guide.GuideCondition:condition12(skillData[1]) then
                return
            end
        end
        if skillData[3] ~= 2 and skillData[3] ~= 3 then
            -- 某单位满足使用大招时触发
            if liveVo:getAtt(AttConst.MP) >= liveVo:getAtt(AttConst.MP_MAX) then
                if guide.GuideCondition:condition05(liveVo:getTID(), skillData[1]) then
                    return
                end
                guide.GuideCondition:condition18(liveVo:getTID(), skillData[1])
            end
        end
    end
end

function showFirstEff(self)
    if self.mSetTimeOutSn then
        if storyTalk.StoryTalkManager:getCurHasStory() == false and guide.GuideManager:getCurHasGuide() == false and
            gs.PopPanelManager.HasSubPopActive() == false then
            self.m_firstTipsContent:SetActive(true)
        else
            self.m_firstTipsContent:SetActive(false)
        end
        LoopManager:clearTimeout(self.mSetTimeOutSn)
        self.mSetTimeOutSn = nil
    end
end

function resetFirstTipsContent(self)
    self.m_firstTipsContent:SetActive(false)
end

function _lastHit(self)
    self:showDamageInfo()
    self:showWeekBreak()
end

-- 被弱点打击提示
function showWeekBreak(self)
    local thingDic = fight.SceneItemManager:getAllLiveThing()
    local actData = fight.FightAction:getCurActData()
    if not actData then
        return
    end
    local actHeroList = fight.FightManager:actionHeroList(actData)
    local attLiveVo = fight.SceneManager:getThing(self.m_curHeroID)
    if attLiveVo and actHeroList and not table.empty(actHeroList) then
        for _, hero in ipairs(actHeroList) do
            if hero.hero_id ~= self.m_curHeroID and hero.side ~= attLiveVo:isAttacker() then
                local targetLive = thingDic[hero.hero_id]
                if targetLive then
                    targetLive:showWeakBreak(attLiveVo:getRaceVo().eleType)
                end

                -- boss区域
                if self.m_bossHeadAreaView then
                    self.m_bossHeadAreaView:showWeakBreak(attLiveVo:getRaceVo().eleType, hero.hero_id)
                end
            end
        end
    end

end

-- 总伤害、治疗信息
function showDamageInfo(self)
    if StorageUtil:getBool1(gstor.FIGHT_HIDE_INFO) then
        return
    end
    self.m_totalDamage = nil
    self.m_totalCure = nil
    local liveVo = fight.SceneManager:getThing(self.m_curHeroID)
    if liveVo and self.m_curActionData then
        local qteType = fight.FightManager:getQteType()
        self.m_totalDamage = self.m_curActionData.m_totalDamage[qteType]
        self.m_totalCure = self.m_curActionData.m_totalCure[qteType]

        if self.m_totalDamage ~= nil and self.m_totalDamage > 0 then
            local damageTrans
            if liveVo:isAttacker() == 1 then
                self.m_damageTxtRight.text = tostring(self.m_totalDamage)
                self.m_totalDamageTransRight:SetActive(true)
                self.m_totalDamageTransLeft:SetActive(false)
                damageTrans = self.m_totalDamageTransRight
            else
                self.m_damageTxtLeft.text = tostring(self.m_totalDamage)
                self.m_totalDamageTransLeft:SetActive(true)
                self.m_totalDamageTransRight:SetActive(false)
                damageTrans = self.m_totalDamageTransLeft
            end

            RateLooper:clearTimeout(self.m_totalDamageSn)
            local function _timeoutCall()
                self.m_totalDamageSn = 0
                damageTrans:SetActive(false)
            end
            self.m_totalDamageSn = RateLooper:setTimeout(2, self, _timeoutCall)
        else
            self.m_totalDamageTransRight:SetActive(false)
            self.m_totalDamageTransLeft:SetActive(false)

            -- 治疗
            if self.m_totalCure ~= nil and self.m_totalCure > 0 then
                local cureTrans
                if liveVo:isAttacker() == 1 then
                    self.m_cureTxtRight.text = tostring(self.m_totalCure)
                    self.m_totalCureTransRight:SetActive(true)
                    self.m_totalCureTransLeft:SetActive(false)
                    cureTrans = self.m_totalCureTransRight
                else
                    self.m_cureTxtLeft.text = tostring(self.m_totalCure)
                    self.m_totalCureTransLeft:SetActive(true)
                    self.m_totalCureTransRight:SetActive(false)
                    cureTrans = self.m_totalCureTransLeft
                end

                RateLooper:clearTimeout(self.m_totalCureSn)
                local function _timeoutCall()
                    self.m_totalCureSn = 0
                    cureTrans:SetActive(false)
                end
                self.m_totalCureSn = RateLooper:setTimeout(2, self, _timeoutCall)
            else
                self.m_totalCureTransRight:SetActive(false)
                self.m_totalCureTransLeft:SetActive(false)
            end
        end
    end
end

-- 公会战总伤害
function showGuildBossTotalDamageInfo(self, damage)
    local battleType = fight.FightManager:getBattleType()
    if battleType ~= PreFightBattleType.Guild_boss_war and battleType ~= PreFightBattleType.Guild_boss_imitate and
        battleType ~= PreFightBattleType.Guild_Sweep and battleType ~= PreFightBattleType.Disaster and battleType ~=
        PreFightBattleType.Disater_imitate and battleType ~= PreFightBattleType.Guild_Imitate then
        return
    end
    -- local langId = 94588
    -- if battleType == PreFightBattleType.Guild_boss_imitate then
    --     langId = 94593
    -- end
    local langId = battleType == (PreFightBattleType.Guild_boss_imitate or battleType == PreFightBattleType.Disater_imitate) and 94593 or 94588
    if damage >= 100000000 then --亿
        damage = string.format("%.2f", damage / 100000000) .. _TT(3090)
    elseif damage >= 1000000000000 then --万亿
        damage = string.format("%.2f", damage / 1000000000000) _TT(3091)
    end
    self.mTextGuildBossDamage.text = _TT(langId) .. tostring(damage)
end

function _skillEnd(self)
    self:_refreshFormat()
end

function destroyChildren(self)
    self.m_skillView:removeSelf()
    self.m_skillView:destroy()
    self.m_queueView:removeSelf()
    self.m_queueView:destroy()
    self.m_startView:removeSelf()
    self.m_startView:destroy()
    self.m_soulView:removeSelf()
    self.m_soulView:destroy()
    self.m_waveView:removeSelf()
    self.m_waveView:destroy()
    self.m_leftSFormat:removeSelf()
    self.m_leftSFormat:destroy()
    self.m_rightSFormat:removeSelf()
    self.m_rightSFormat:destroy()
    self.m_blockView:removeSelf()
    self.m_blockView:destroy()
    self.m_forcesSkillView:destroy()
end

function destroy(self, isAuto)
    if self.m_buffPanel ~= nil then
        self.m_buffPanel:close()
    end
    self:destroyChildren()
    super.destroy(self)
end

-- FightUI的预加载资源（战斗时加载）
function getFightUIPreloadPrefabs()
    return {UrlManager:getUIPrefabPath("fight/FightUI.prefab"),
        UrlManager:getUIPrefabPath("fight/FightSkillItem.prefab"),
        UrlManager:getUIPrefabPath("fight/FightForcesSkillItem.prefab"),
        UrlManager:getUIPrefabPath("fight/FightMaxSkillItem.prefab"),
        UrlManager:getUIPrefabPath("fight/FightQueueItem.prefab"),
        UrlManager:getUIPrefabPath("fight/FightSmallFormat.prefab"),
        UrlManager:getUIPrefabPath("fight/FightSFormatLeft.prefab"),
        UrlManager:getUIPrefabPath("fight/FightSFormatRight.prefab"),
        UrlManager:getUIPrefabPath("fight/FlyHudText.prefab"),
        UrlManager:getUIPrefabPath("fight/FightQueueIcon.prefab"),
        UrlManager:getUIPrefabPath("fight/FlyHudImg.prefab"),
        UrlManager:getUIPrefabPath("fight/liveui/FightOtherIcon.prefab"),
        UrlManager:getUIPrefabPath("fight/liveui/BuffEleIcon.prefab"),
        UrlManager:getUIPrefabPath("fight/liveui/HeadAreaItem1.prefab"),
        UrlManager:getUIPrefabPath("fight/liveui/FightBuffIcon.prefab"),
        UrlManager:getUIBaseSoundPath("ui_start_mission.prefab"),
    UrlManager:getUIEfxPath("fx_ui_common_aoyibaofa.prefab")}
end

-- FightUI的预加载资源（战斗时加载）
-- function getFightUIPreloadSprites()
--     return { UrlManager:getFightUIPath("fight_bg_1.png"), UrlManager:getFightArtfontPath("baolie_01.png") }
-- end

return _M

--[[ 替换语言包自动生成，请勿修改！
语言包: _TT(3068):"元素反应"
语言包: _TT(3068):"元素反应"
语言包: _TT(3056):"封印"
语言包: _TT(3055):"冰冻"
语言包: _TT(3055):"冰冻"
语言包: _TT(3054):"混乱"
语言包: _TT(3054):"混乱"
语言包: _TT(3053):"眩晕"
语言包: _TT(3053):"眩晕"
语言包: _TT(3052):"沉默"
语言包: _TT(3052):"沉默"
]]
