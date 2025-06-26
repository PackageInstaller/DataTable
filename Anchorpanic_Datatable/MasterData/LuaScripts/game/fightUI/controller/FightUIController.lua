--[[
     战斗UI控制器
]]
module("fight.FightUIController", Class.impl(Controller))

--构造函数
function ctor(self)
    super.ctor(self)
    self.mFightUI = nil
    self.m_fightWinView = nil
    self.m_fightFailView = nil

    self.m_beforeFlagDirty = false
end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.FIGHT_START, self.onShowFightUIHandler, self)
    GameDispatcher:addEventListener(EventName.HIDE_FIGHT_UI, self.onHideFightHandler, self)
    GameDispatcher:addEventListener(EventName.FIGHT_AGAIN, self.onFightAgainHandler, self)
    GameDispatcher:addEventListener(EventName.FIGHT_RESULT_PANEL_SHOW, self.onFightResultShowHandler, self)
    GameDispatcher:addEventListener(EventName.FIGHT_RESULT_PANEL_OVER, self.onFightResultOverHandler, self)
    GameDispatcher:addEventListener(EventName.FIGHT_RESULT_REQ_LINK, self.onFightResultReqLinkHandler, self)
    GameDispatcher:addEventListener(EventName.FIGHT_RESULT_SHOW_BEFORE_SCENE, self._openTheBeforeScene, self)
    GameDispatcher:addEventListener(EventName.FIGHT_RESULT_SHOW_BEFORE_UI, self._openTheBeforeUI, self)
    GameDispatcher:addEventListener(EventName.FIGHT_REQUEST_FLY, self.onRequestFlyHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_FIGHT_SKILL_TIPS, self.onShowFightSkillTips, self)
    GameDispatcher:addEventListener(EventName.OPEN_FORCES_SKILL_TIPS, self.onShowForcesSkillTips, self)
    GameDispatcher:addEventListener(EventName.CLOSE_FORCES_SKILL_TIPS, self.onCloseForcesSkillTips, self)

    GameDispatcher:addEventListener(EventName.EXIT_SCENE_AFTER_OPEN_PANEL, self.exitSceneAfterOpenPanel, self)
    GameDispatcher:addEventListener(EventName.FIGHT_RESULT_PREVIEW_SHOW, self.onShowPreviewHanlder, self)
    GameDispatcher:addEventListener(EventName.SHOW_FIGHT_BLACK_MASK, self.onShowFightBlackHanlder, self)
    GameDispatcher:addEventListener(EventName.HIDE_FIGHT_BLACK_MASK, self.onCloseWinBlackHanlder, self)
    GameDispatcher:addEventListener(EventName.LAST_HIT_TO_WIN, self.openWinSignView, self)
    -- GameDispatcher:addEventListener(EventName.OPEN_FIGHT_ELEMENTREACTIONPANEL, self.onOpenElementPanel, self)
    -- GameDispatcher:addEventListener(EventName.CLOSE_FIGHT_ELEMENTREACTIONPANEL, self.onCloseElementPanel, self)
    GameDispatcher:addEventListener(EventName.SHOW_SKIP_AOYI_EFFECT, self.onShowSkipAoyiEffect, self)
    GameDispatcher:addEventListener(EventName.REMOVE_SKIP_AOYI_EFFECT, self.onRemoveSkipAoyiEffect, self)
    GameDispatcher:addEventListener(EventName.CLOSE_FIGHT_SKILL_TIPS, self.onCloseFightSkillTips, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        -- SC_BATTLE_CALC = self.onBattleCalcMsg
    }
end

--- *s2c* 整场战斗校验结果 20006
function onBattleCalcMsg(self, msg)
    self:onFightResultShowHandler(msg)
end

-- 战斗结果返回 战斗结果（0:无效的战斗,1:胜利,2:失败）
function onFightResultShowHandler(self)
    self:onHideFightHandler()
    self:onCloseForcesSkillTips()
    self:onCloseFightSkillTips()
    if fight.FightManager:getLatestBattleType() == PreFightBattleType.Arena_Peak_Pvp and not fight.FightManager:isReplaying() then

        local fightResult = fight.FightManager:getResultData()
        if fightResult and fightResult.args[1] == 1 then
            GameDispatcher:dispatchEvent(EventName.EXIT_FIGHT_END_RESET)
            -- 巅峰pvp
            map.MapLoader:resetMapCtrl()

            fight.FightManager:reqBattleEnter(PreFightBattleType.Arena_Peak_Pvp, fight.FightManager:getLatestBattleFieldIDStr())
            return
        end
    end

    if fight.FightManager:getLatestBattleType() == PreFightBattleType.GuildWar and not fight.FightManager:isReplaying() then
        local fightResult = fight.FightManager:getResultData()
        if fightResult and fightResult.args[1] == 1 then
            GameDispatcher:dispatchEvent(EventName.EXIT_FIGHT_END_RESET)
            -- 巅峰pvp
            map.MapLoader:resetMapCtrl()

            fight.FightManager:reqBattleEnter(PreFightBattleType.GuildWar, fight.FightManager:getLatestBattleFieldIDStr())
            return
        end
    end

    if fight.FightManager.m_manualExitReplay == true then
        GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PANEL_OVER, {isWin = true})
    else
        if socket.SocketController:isBanReconnect() then
            -- 掉线了
            return
        end
        local resultData = fight.FightManager:getResultData()
        if not resultData or resultData.result == 0 then
            self:onOpenFailViewHandler(resultData)
            gs.Message.Show('战斗无效')
        elseif resultData.result == 1 then
            self:onOpenWinViewHandler(resultData)
        else
            self:onOpenFailViewHandler(resultData)
        end
    end
    -- GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PANEL_ACTVIE)
end

-- 关闭结算界面
function onFightResultOverHandler(self, data)
    local battleType = fight.FightManager:getBattleType()
    local targetId = fight.FightManager:getBattleFieldID()

    if data.isWin then

        local function callback()
            self:__fightOverExitScene(battleType, tonumber(targetId))
        end
        storyTalk.StoryTalkCondition:setAlwayCallback(callback)
        storyTalk.StoryTalkCondition:condition11()
    else
        self:__fightOverExitScene(battleType, tonumber(targetId))
    end
    --storyTalk.StoryTalkCondition:condition11()
end

-- 战斗结算结束退出场景等操作
function __fightOverExitScene(self, cusBattleType, cusTargetId)
    self.m_beforeFlagDirty = true
    self.m_lastBattleType = cusBattleType
    self.m_lastTargetID = cusTargetId

    -- 退出战斗场景
    GameDispatcher:dispatchEvent(EventName.EXIT_FIGHT_SCENE)
    LoadOnManager:setNowBattleSign(nil, nil)
end

-- 退出场景后打开UI(通用)
function exitSceneAfterOpenPanel(self, args)
    self.m_beforeFlagDirty = true
    self.m_lastBattleType = args.battleType
    self.m_lastTargetID = args.dupId
end

function onFightResultReqLinkHandler(self, args)
    self.m_beforeFlagDirty = true
    self.m_LinkID = args.linkId

    -- 退出战斗场景
    GameDispatcher:dispatchEvent(EventName.EXIT_FIGHT_SCENE)
    LoadOnManager:setNowBattleSign(nil, nil)
end

-- 战斗结束打开对应的功能场景
function _openTheBeforeScene(self)
    if (self.m_lastBattleType == PreFightBattleType.Training) then
        GameDispatcher:dispatchEvent(EventName.ENTER_TRAINING_SCENE, {})
    elseif (self.m_lastBattleType == PreFightBattleType.DupMaze) then
        GameDispatcher:dispatchEvent(EventName.TRY_LAST_MAZE_ENTER)
    elseif (self.m_lastBattleType == PreFightBattleType.MainExplore) then
        GameDispatcher:dispatchEvent(EventName.TRY_LAST_MAIN_EXPLORE_ENTER)
    elseif self.m_lastBattleType == PreFightBattleType.ClimbTowerDup and dup.DupClimbTowerManager:getGotoNextLevel() then
        logInfo("=================================reqBattleEnter ClimbTowerDup")
        map.MapLoader:resetMapCtrl()
        fight.FightManager:reqBattleEnter(PreFightBattleType.ClimbTowerDup, dup.DupClimbTowerManager:getNextDupId())
        dup.DupClimbTowerManager:setGotoNextLevel(false)
    elseif self.m_lastBattleType == PreFightBattleType.ElementTower and dup.DupClimbTowerManager:getGotoNextDeepLevel() then
        map.MapLoader:resetMapCtrl()
        fight.FightManager:reqBattleEnter(PreFightBattleType.ElementTower, dup.DupClimbTowerManager:getNextDeepDupId())
        dup.DupClimbTowerManager:setGotoNextDeepLevel(false)
        -- elseif (self.m_lastBattleType == PreFightBattleType.Arena_Peak_Pvp) then
        --     -- 综合对抗不处理
    elseif self.m_lastBattleType == PreFightBattleType.ActiveDup or self.m_lastBattleType == PreFightBattleType.SandPlay then
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.MainActivity})
    else
        GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)
    end
    -- 通知资源下载模块更新相关处理
    GameDispatcher:dispatchEvent(EventName.UPDATE_FIGHT_BACKGROUND_DOWNLOAD, false)
end

--打开胜利标识
function openWinSignView(self)
    if self.mFightWinSignView == nil then
        self.mFightWinSignView = fightUI.FightWinSignView.new()
        self.mFightWinSignView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyWinSignViewHandler, self)
    end
    self.mFightWinSignView:open()

    if self.mFightResultShortcut and self.mFightResultShortcut.isPop then
        self.mFightResultShortcut:close()
    end
end

function onDestroyWinSignViewHandler(self)
    self.mFightWinSignView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyWinSignViewHandler, self)
    self.mFightWinSignView = nil
end

--打开快速结算点击层
function openShortcutResultView(self)
    if self.mFightResultShortcut == nil then
        self.mFightResultShortcut = fightUI.FightResultShortcut.new()
        self.mFightResultShortcut:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyShortcutResultViewHandler, self)
    end
    self.mFightResultShortcut:open()
end

function onDestroyShortcutResultViewHandler(self)
    self.mFightResultShortcut:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyShortcutResultViewHandler, self)
    self.mFightResultShortcut = nil
end

--打开元素反应界面
-- function onOpenElementPanel(self)
--     if self.mFightElementReactionPanel == nil then
--         self.mFightElementReactionPanel = fightUI.FightElementReactionPanel.new()
--         self.mFightElementReactionPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyElementPanelHandler, self)
--     end
--     self.mFightElementReactionPanel:open()
-- end

-- function onDestroyElementPanelHandler(self)
--     if self.mFightElementReactionPanel then
--         self.mFightElementReactionPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyElementPanelHandler, self)
--         self.mFightElementReactionPanel = nil
--     end
-- end

-- function onCloseElementPanel(self)
--     if self.mFightElementReactionPanel then
--         self.mFightElementReactionPanel:close()
--     end
-- end

-- 战斗结束打开对应的功能界面
function _openTheBeforeUI(self)

    -- print("_openTheBeforeUI ======== ", self.m_beforeFlagDirty, self.m_lastBattleType, self.m_lastTargetID)
    if self.m_beforeFlagDirty == false then
        return
    end
    self.m_beforeFlagDirty = false

    if socket.SocketController:isBanReconnect() then
        -- 掉线了
        return
    end
    fight.FightManager:setIsUIByFightEnd(true)

    if (self.m_LinkID) then
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = self.m_LinkID})
        self.m_LinkID = nil
    else
        -- 退出结算界面，打开对应的功能界面
        if self.m_lastBattleType == PreFightBattleType.ClimbTowerDup then
            local curdupId = self.m_lastTargetID
            if curdupId == 0 then
                curdupId = dup.DupClimbTowerManager:maxDupId()
            end
            local dupVo = dup.DupClimbTowerManager:getDupVo(curdupId)
            local areaVo = dup.DupClimbTowerManager:getAreaVo(dupVo.areaId)
            dup.DupClimbTowerManager:setPosIndex(areaVo.areaId)
            GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_CHALLAGE})
            GameDispatcher:dispatchEvent(EventName.OPEN_CHALLENGE_DUP, DupType.DUP_CLIMB_TOWER)
            GameDispatcher:dispatchEvent(EventName.OPEN_CLIMB_TOWER_AREA_PANEL, {areaVo = areaVo})
            dup.DupClimbTowerManager.isInTowerFight = false
        elseif self.m_lastBattleType == PreFightBattleType.MainMapStage then
            local curIsPass = battleMap.MainMapManager:isStagePass(self.m_lastTargetID)
            local chapterVo, stageVo = battleMap.MainMapManager:getChapterVoByStageId(self.m_lastTargetID)
            if (chapterVo and stageVo) then
                GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_MAIN, data = {chapterId = chapterVo.chapterId}})
                --结算时的最后一关自动打开下一章第一关
                if (chapterVo:getEndStageId(battleMap.MainMapManager:getStyle()) == stageVo.stageId and curIsPass) then
                    -- local nextChapterVo = battleMap.MainMapManager:getChapterVo(chapterVo.chapterId + 1)
                    -- if(nextChapterVo)then
                    --     GameDispatcher:dispatchEvent(EventName.OPEN_MAIN_STAGE_LIST_PANEL, {chapterVo = nextChapterVo, stageVo = nil})
                    -- else
                    GameDispatcher:dispatchEvent(EventName.OPEN_MAIN_STAGE_LIST_PANEL, {chapterVo = chapterVo, stageVo = stageVo})
                    --end
                else
                    GameDispatcher:dispatchEvent(EventName.OPEN_MAIN_STAGE_LIST_PANEL, {chapterVo = chapterVo, stageVo = stageVo})
                end
            else
                if (chapterVo) then
                    Debug:log_error("FightUIController", chapterVo.chapterId)
                end
                if (stageVo) then
                    Debug:log_error("FightUIController", stageVo.stageId)
                end
                Debug:log_error("FightUIController", string.format("打开主线界面找不到对应关卡数据：%s", self.m_lastTargetID))
            end
        elseif self.m_lastBattleType == PreFightBattleType.DupOldEquip then
            GameDispatcher:dispatchEvent(EventName.OPEN_DUP_OLD_EQUIP_PANEL)
        elseif self.m_lastBattleType == PreFightBattleType.HeroTrial then
            GameDispatcher:dispatchEvent(EventName.OPEN_MAINACTIVITY_TRIAL_PANEL, {dupId = self.m_lastTargetID})

        elseif self.m_lastBattleType == PreFightBattleType.DupMoney then
            GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_DUP})
            GameDispatcher:dispatchEvent(EventName.OPEN_DUP_DAILY_PANEL, {dupType = DupType.DUP_MONEY, dupId = self.m_lastTargetID, isFight = true})
        elseif self.m_lastBattleType == PreFightBattleType.DupExp then
            GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_DUP})
            GameDispatcher:dispatchEvent(EventName.OPEN_DUP_DAILY_PANEL, {dupType = DupType.DUP_EXP, dupId = self.m_lastTargetID, isFight = true})
            -------------------------------------------------equip start-----------------------------------------------------------
        elseif self.m_lastBattleType == PreFightBattleType.DupEquip_Low then
            GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_DUP})
            GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_DUP, {dupType = DupType.DUP_EQUIP_LOW, dupId = self.m_lastTargetID, isFight = true})
        elseif self.m_lastBattleType == PreFightBattleType.DupEquip_Mid then
            GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_DUP})
            GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_DUP, {dupType = DupType.DUP_EQUIP_MID, dupId = self.m_lastTargetID, isFight = true})
        elseif self.m_lastBattleType == PreFightBattleType.DupEquip_High then
            GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_DUP})
            GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_DUP, {dupType = DupType.DUP_EQUIP_HIGH, dupId = self.m_lastTargetID, isFight = true})
            -------------------------------------------------equip end-----------------------------------------------------------
        elseif self.m_lastBattleType == PreFightBattleType.DupEquipTupo then
            GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_DUP})
            GameDispatcher:dispatchEvent(EventName.OPEN_DUP_DAILY_PANEL, {dupType = DupType.DUP_EQUIP_TUPO, dupId = self.m_lastTargetID, isFight = true})
        elseif self.m_lastBattleType == PreFightBattleType.DupBracelets then
            GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_DUP})
            GameDispatcher:dispatchEvent(EventName.OPEN_DUP_DAILY_PANEL, {dupType = DupType.DUP_BRACELETS, dupId = self.m_lastTargetID, isFight = true})
        elseif self.m_lastBattleType == PreFightBattleType.DupHeroStarUp then
            GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_DUP})
            GameDispatcher:dispatchEvent(EventName.OPEN_DUP_POTENCY_VIEW, {dupType = DupType.DUP_HERO_STAR_UP, dupId = self.m_lastTargetID, isFight = true})
        elseif self.m_lastBattleType == PreFightBattleType.DupHeroGrowUp then
            GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_DUP})
            GameDispatcher:dispatchEvent(EventName.OPEN_DUP_DAILY_PANEL, {dupType = DupType.DUP_HERO_GROW_UP, dupId = self.m_lastTargetID, isFight = true})
        elseif self.m_lastBattleType == PreFightBattleType.DupHeroSkill then
            GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_DUP})
            GameDispatcher:dispatchEvent(EventName.OPEN_DUP_DAILY_PANEL, {dupType = DupType.DUP_HERO_SKILL, dupId = self.m_lastTargetID, isFight = true})
        elseif self.m_lastBattleType == PreFightBattleType.DupBraceletUp then--资源副本-手环升级副本
            GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_DUP})
            GameDispatcher:dispatchEvent(EventName.OPEN_DUP_DAILY_PANEL, {dupType = DupType.DUP_BRACELET_UP, dupId = self.m_lastTargetID, isFight = true})
        elseif self.m_lastBattleType == PreFightBattleType.DupBraceletEvolve then--资源副本-手环突破副本
            GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_DUP})
            GameDispatcher:dispatchEvent(EventName.OPEN_DUP_DAILY_PANEL, {dupType = DupType.DUP_BRACELET_EVOLVE, dupId = self.m_lastTargetID, isFight = true})
        elseif self.m_lastBattleType == PreFightBattleType.DupFirePotency then
            --潜能副本-火潜能副本
            GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_DUP})
            GameDispatcher:dispatchEvent(EventName.OPEN_DUP_POTENCY_VIEW, {dupType = DupType.DUP_FIRE_POTENCY, dupId = self.m_lastTargetID, isFight = true})
        elseif self.m_lastBattleType == PreFightBattleType.DupIcePotency then
            --潜能副本-冰潜能副本
            GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_DUP})
            GameDispatcher:dispatchEvent(EventName.OPEN_DUP_POTENCY_VIEW, {dupType = DupType.DUP_ICE_POTENCY, dupId = self.m_lastTargetID, isFight = true})
        elseif self.m_lastBattleType == PreFightBattleType.DupElectricPotency then
            --潜能副本-电潜能副本
            GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_DUP})
            GameDispatcher:dispatchEvent(EventName.OPEN_DUP_POTENCY_VIEW, {dupType = DupType.DUP_ELECTRIC_POTENCY, dupId = self.m_lastTargetID, isFight = true})
        elseif self.m_lastBattleType == PreFightBattleType.DupCavitationPotency then
            --潜能副本-虚蚀潜能副本
            GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_DUP})
            GameDispatcher:dispatchEvent(EventName.OPEN_DUP_POTENCY_VIEW, {dupType = DupType.DUP_CAVITATION_POTENCY, dupId = self.m_lastTargetID, isFight = true})
        elseif self.m_lastBattleType == PreFightBattleType.DupLifePotency then
            --潜能副本-生蕴潜能副本
            GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_DUP})
            GameDispatcher:dispatchEvent(EventName.OPEN_DUP_POTENCY_VIEW, {dupType = DupType.DUP_LIFE_POTENCY, dupId = self.m_lastTargetID, isFight = true})
        elseif self.m_lastBattleType == PreFightBattleType.ArenaChallenge then
            GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.Pvp})
            GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.PvpArena})
        elseif self.m_lastBattleType == PreFightBattleType.Arena_Peak_Pvp then
            -- 3v3
            GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.Pvp})
            GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.PvpArenaHell})
            if fight.FightManager:isReplaying() then
                -- 回放额外打开记录
                GameDispatcher:dispatchEvent(EventName.OPEN_ARENA_HELL_HIS_PANEL)
            end
        elseif self.m_lastBattleType == PreFightBattleType.GuildWar then
            GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.Guild})
            GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_WAR_MAIN_PANEL)
        elseif self.m_lastBattleType == PreFightBattleType.HeroBiography then
            local dupId = self.m_lastTargetID
            local biographyVo = battleMap.BiographyManager:getBiographyVoById(dupId)
            if (biographyVo) then
                GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_BIOGRAPHY})
                local heroTid, biographyId = battleMap.BiographyManager:getLastData()
                GameDispatcher:dispatchEvent(EventName.OPEN_HERO_BIOGRAPHY_PANEL, {heroTid = heroTid, biographyId = biographyId})
            else
                Debug:log_error("FightUIController", "找不到对应英雄传记副本id：" .. dupId)
            end
        elseif self.m_lastBattleType == PreFightBattleType.InfiniteCity then
            GameDispatcher:dispatchEvent(EventName.OPEN_INFINITE_CITY_MAIN_PANEL)
            GameDispatcher:dispatchEvent(EventName.OPEN_INFINITE_CITY_DUP_PANEL)
        elseif self.m_lastBattleType == PreFightBattleType.CodeHopeDup then
            GameDispatcher:dispatchEvent(EventName.OPEN_DUP_CODE_HOPE_PANEL)
            GameDispatcher:dispatchEvent(EventName.OPEN_CODE_HOPE_CHAPTER, {dupId = self.m_lastTargetID})
        elseif self.m_lastBattleType == PreFightBattleType.DupImplied then
            local curDiffId = dup.DupImpliedManager:getImpliedDiffId()
            if curDiffId ~= 0 then
                GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_CHALLAGE})
                GameDispatcher:dispatchEvent(EventName.OPEN_DUP_IMPLIED_DUP_PANEL, {dupId = self.m_lastTargetID})
            end
        elseif self.m_lastBattleType == PreFightBattleType.DupMaze then
            GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_PANEL)
        elseif self.m_lastBattleType == PreFightBattleType.Training then
        elseif self.m_lastBattleType == PreFightBattleType.DupBranchEquip then
            GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_STORY})
            local stageVo = branchStory.BranchStoryManager:getStageConfigVo(self.m_lastTargetID)
            local chapterVo = branchStory.BranchStoryManager:getChapterConfigVo(stageVo.chapterId)
            GameDispatcher:dispatchEvent(EventName.OPEN_BRANCH_EQUIP_STAGE_PANEL, {chapterVo = chapterVo, stageVo = stageVo})
        elseif self.m_lastBattleType == PreFightBattleType.DupTactivs then
            GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_STORY})
            local stageVo = branchStory.BranchTactivsManager:getTactivsStageConfigVo(self.m_lastTargetID)
            local chapterVo = branchStory.BranchTactivsManager:getTactivsChapterConfigById(stageVo.chapterId)
            GameDispatcher:dispatchEvent(EventName.OPEN_BRANCH_TACIVS_PANEL, {chapterVo = chapterVo, stageVo = stageVo, type = chapterVo.chapter})
        elseif self.m_lastBattleType == PreFightBattleType.BranchPower then
            GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_STORY})
        elseif self.m_lastBattleType == PreFightBattleType.RogueLike then
            GameDispatcher:dispatchEvent(EventName.OPEN_ROGUELIKE_MAIN_PANEL)
            GameDispatcher:dispatchEvent(EventName.OPEN_ROGUELIKE_MAP_PANEL)
        elseif self.m_lastBattleType == PreFightBattleType.MainExplore then
        elseif self.m_lastBattleType == PreFightBattleType.DupApostle2War then
            if (not dup.DupApostlesWarManager:getWeekEnd() or not dup.DupApostlesWarManager:getWeekEndInFight()) then
                GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_CHALLAGE})
                GameDispatcher:dispatchEvent(EventName.OPEN_DUP_APOSTLES_WAR_PANEL)
            end
        elseif self.m_lastBattleType == PreFightBattleType.ElementTower then
            if (dup.DupClimbTowerManager.backToMain) then
                GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_CHALLAGE})
                dup.DupClimbTowerManager.isInElementFight = false
                dup.DupClimbTowerManager.backToMain = false
                return
            end
            GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_CHALLAGE})
            GameDispatcher:dispatchEvent(EventName.OPEN_CHALLENGE_DUP, DupType.DUP_CLIMB_TOWER)
            local curdupId = self.m_lastTargetID
            if curdupId ~= 0 then
                local dupVo = dup.DupClimbTowerManager:getDeepDupVo(curdupId)
                local areaVo = dup.DupClimbTowerManager:getDeepAreaData()[dupVo.areaId]
                dup.DupClimbTowerManager:setDeepPosIndex(dupVo.areaId)
                GameDispatcher:dispatchEvent(EventName.OPEN_DEEP_TOWER_PANEL)
                GameDispatcher:dispatchEvent(EventName.OPEN_DEEP_TOWER_DUP_PANEL, {areaVo = areaVo})
            else
                GameDispatcher:dispatchEvent(EventName.OPEN_DEEP_TOWER_PANEL)
            end
            dup.DupClimbTowerManager.isInElementFight = false
        elseif self.m_lastBattleType == PreFightBattleType.Cycle then
            GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_DUP})
            GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_MAIN_PANEL)
            if not cycle.CycleManager:getFightEnd() then
                GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_MAP_PANEL)
            end
            cycle.CycleManager:setFightEnd(false)
        elseif self.m_lastBattleType == PreFightBattleType.Fragment then
            local curIsPass = battleMap.FragmentMapManager:isStagePass(self.m_lastTargetID)
            local chapterVo, stageVo = battleMap.FragmentMapManager:getChapterVoByStageId(self.m_lastTargetID)
            if (chapterVo and stageVo) then
                GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_FRAGMENT, data = {chapterId = chapterVo.chapterId}})
                --结算时的最后一关自动打开下一章第一关
                if (chapterVo:getEndStageId() == stageVo.stageId and curIsPass) then
                    local nowChapter = battleMap.FragmentMapManager:getChapterVo(battleMap.FragmentMapManager:getNowSelectChapter())
                    GameDispatcher:dispatchEvent(EventName.OPEN_FRAGMENT_STAGEVIEW, {chapterVo = chapterVo})
                else
                    GameDispatcher:dispatchEvent(EventName.OPEN_FRAGMENT_STAGEVIEW, {chapterVo = chapterVo})
                end
            else
                if (chapterVo) then
                    Debug:log_error("FightUIController", chapterVo.chapterId)
                end
                if (stageVo) then
                    Debug:log_error("FightUIController", stageVo.stageId)
                end
                Debug:log_error("FightUIController", string.format("打开支线界面找不到对应关卡数据：%s", self.m_lastTargetID))
            end
        elseif self.m_lastBattleType == PreFightBattleType.ActiveDup then
            GameDispatcher:dispatchEvent(EventName.OPEN_ACTIVEDUP_STAGE_PANEL, mainActivity.ActiveDupManager:getStyle())
        elseif self.m_lastBattleType == PreFightBattleType.Friend then
            GameDispatcher:dispatchEvent(EventName.OPEN_FRIEND_PANEL)
            --GameDispatcher:dispatchEvent(EventName.OPEN_ACTIVEDUP_STAGE_PANEL, mainActivity.ActiveDupManager:getStyle())
        elseif self.m_lastBattleType == PreFightBattleType.Guild_boss_war or self.m_lastBattleType == PreFightBattleType.Guild_boss_imitate then
            if not guild.GuildManager:getGuildBossIsOpen() then
                gs.Message.Show(_TT(94503))
                GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_MAIN_PANEL)
                return
            end

            GameDispatcher:dispatchEvent(EventName.OPEN_GUILDBOSS_MAINUI, {lateBattleDupId = self.m_lastTargetID})
        elseif self.m_lastBattleType == PreFightBattleType.Doundless then
            --GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, {type = mainPlay.MainPlayConst.MAINPLAY_CHALLAGE})
            GameDispatcher:dispatchEvent(EventName.REQ_DOUNDLESS_INFO)
        elseif self.m_lastBattleType == PreFightBattleType.Guild_Sweep then
            if guild.GuildManager:getGuildSweepState() == 1 then
                gs.Message.Show("锁定中")
                GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_MAIN_PANEL)
                return
            end
            GameDispatcher:dispatchEvent(EventName.REQ_GUILD_SWEEP_INFO)
        elseif self.m_lastBattleType == PreFightBattleType.Disaster or self.m_lastBattleType == PreFightBattleType.Disater_imitate then

            if disaster.DisasterManager:getDisasterIsOpen() == false then
                gs.Message.Show("活动已关闭")
                return
            end

            GameDispatcher:dispatchEvent(EventName.CAN_OPEN_DISASTER_PANEL)
            local curDif = disaster.DisasterManager:getCurChallengingDif()
            if curDif > 0 then
                local dupVo = disaster.DisasterManager:getDisasterDupDataByDif(curDif)

                formation.checkFormationFight(PreFightBattleType.Disaster, DupType.Disaster, dupVo.dupId,
                formation.TYPE.DISASTER, nil, nil, nil)
            end
        elseif self.m_lastBattleType == PreFightBattleType.Guild_Imitate then
            GameDispatcher:dispatchEvent(EventName.OPEN_GUILDBOSSIMITATE_STAGEPANEL)
        elseif self.m_lastBattleType == PreFightBattleType.Seabed then
            GameDispatcher:dispatchEvent(EventName.OPEN_SEABED_MAIN_PANEL)

            local hasData = seabed.SeabedManager:getSeabedHasSettleData()
            if hasData == false then
                GameDispatcher:dispatchEvent(EventName.CAN_SEABED_NEED_PANEL)
            end
        end

        -- 延迟1s检查成就tip，防止有些界面打开加载时间超过成就tip动画时间导致成就tip一闪而过
        LoopManager:addTimer(2, 1, self, function() GameDispatcher:dispatchEvent(EventName.CHECK_ACHIEVEMENT_TIP) end)
        note.NoteManager:addEnableByFight(true)

        fight.FightManager:setIsUIByFightEnd(false)

        local resultData = fight.FightManager:getResultData()
        if resultData and resultData.result == 1 then
            guide.GuideCondition:condition04()
        end

        self.m_lastBattleType = nil
        self.m_lastTargetID = nil
    end
end

--显示战斗UI
function onShowFightUIHandler(self)
    if self.mFightUI == nil then
        self.mFightUI = fightUI.FightUI.new()
        self.mFightUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFightUI, self)
    end
    self.mFightUI:open()
end

-- 关闭战斗UI
function onHideFightHandler(self)
    if self.mFightUI then
        self.mFightUI:close()
    end
end

-- 销毁战斗UI
function onDestroyFightUI(self)
    self.mFightUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFightUI, self)
    self.mFightUI = nil
end

-- 打开战斗黑幕转场
function onShowFightBlackHanlder(self)
    if self.mFightBlackMask == nil then
        self.mFightBlackMask = fightUI.FightBlackMask.new()
        self.mFightBlackMask:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryFightBlackMask, self)
    end
    self.mFightBlackMask:open()
end

-- 关闭战斗黑幕转场
function onCloseWinBlackHanlder(self)
    if self.mFightBlackMask then
        self.mFightBlackMask:hideWinBlack()
    end

    self:openShortcutResultView()
end

-- 销毁战斗黑幕转场
function onDestoryFightBlackMask(self)
    self.mFightBlackMask:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryFightBlackMask, self)
    self.mFightBlackMask = nil
end

-- 显示胜利界面
function onOpenWinViewHandler(self, msg)
    -- if (self.m_fightWinView) then
    --     self.m_fightWinView:close()
    --     self.m_fightWinView = nil
    -- end
    local battleType = fight.FightManager:getBattleType()
    local battleFieldID = fight.FightManager:getBattleFieldID()

    if battleType == PreFightBattleType.ArenaChallenge then
        msg.state = "Win"
        GameDispatcher:dispatchEvent(EventName.UPDATE_ARENA_FIGHT_INFO, msg)
        GameDispatcher:dispatchEvent(EventName.OPEN_ARENA_DAN_PANEL, arena.ArenaManager.myFightInfo)
        return

    elseif battleType == PreFightBattleType.Arena_Peak_Pvp then
        msg.state = arenaEntrance.ResultState.WIN
        GameDispatcher:dispatchEvent(EventName.OPEN_ARENA_HELL_RESULT_PANEL, msg)
        return
    elseif battleType == PreFightBattleType.GuildWar then
        msg.state = guildWar.ResultState.WIN
        GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_WAR_RESULT_PANEL, msg)
        return
    elseif battleType == PreFightBattleType.Cycle then
        if cycle.CycleManager:getResourceInfo().reason_point == 0 then
            GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PANEL_OVER, {
                isWin = false
            })
        else
            GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_RESULT_WIN_PANEL, msg)
        end
        return
    elseif battleType == PreFightBattleType.Guild_boss_war or battleType == PreFightBattleType.Guild_boss_imitate then
        local resultData = fight.FightManager:getResultData()
        local dupId = tonumber(battleFieldID)
        local args = {stage = resultData.args[1], max_hp = resultData.args[2], now_hp = resultData.args[3], isAlive = resultData.args[4] == 1, damage = resultData.args[5], dupId = dupId}

        GameDispatcher:dispatchEvent(EventName.OPEN_GUILDBOSS_RESULT_VIEW, args)
        return

    elseif battleType == PreFightBattleType.Guild_Imitate then
        local resultData = fight.FightManager:getResultData()
        local dupId = tonumber(battleFieldID)
        local args = {damage = resultData.args[1], cache_damage = resultData.args[2], new_record = resultData.args[3] == 1, rank = resultData.args[4], dupId = dupId}

        GameDispatcher:dispatchEvent(EventName.OPEN_GUILDBOSSIMITATE_RESULTVIEW, args)
        return
    elseif battleType == PreFightBattleType.Guild_Sweep then
        local resultData = fight.FightManager:getResultData()
        local dupId = tonumber(battleFieldID)
        local args = {stage = resultData.args[1], max_hp = resultData.args[2], now_hp = resultData.args[3], isAlive = resultData.args[4] == 1, damage = resultData.args[5], dupId = dupId}

        GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_SEEEP_RESULT_VIEW, args)
        return
    elseif battleType == PreFightBattleType.Doundless then
        GameDispatcher:dispatchEvent(EventName.OPEN_DOUNDLESS_RESULT_PANEL, msg)
        return
    elseif battleType == PreFightBattleType.Disaster or battleType == PreFightBattleType.Disater_imitate then
        local resultData = fight.FightManager:getResultData()
        local dupId = tonumber(battleFieldID)
        local args = {max_hp = resultData.args[1], now_hp = resultData.args[2], damage = resultData.args[3], hisDamage = resultData.args[4], dupId = dupId, award = resultData.award}
        GameDispatcher:dispatchEvent(EventName.OPEN_DISASTER_RESULT_PANEL, args)
        return
    end

    -- if (battleType == PreFightBattleType.ArenaChallenge) then
    --     self.m_fightWinView = fightUI.ArenaFightWinEndView.new()
    -- else
    --     self.m_fightWinView = fightUI.FightResultWinView.new()
    -- end
    -- self.m_fightWinView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyWinViewHandler, self)
    -- self.m_fightWinView:open(msg)
    FightResultProxy:showWinView(battleType, battleFieldID, msg, self.onFightResultClose, self)

end

function onFightResultClose(self)
    --
end

-- -- ui销毁
-- function onDestroyWinViewHandler(self)
--     self.m_fightWinView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyWinViewHandler, self)
--     self.m_fightWinView = nil
-- end

-- 显示失败界面
function onOpenFailViewHandler(self, msg)
    -- if (self.m_fightFailView and self.m_fightFailView.isPop == 1) then
    --     self.m_fightFailView:close()
    --     self.m_fightFailView = nil
    -- end
    local battleType = fight.FightManager:getBattleType()
    local battleFieldID = fight.FightManager:getBattleFieldID()

    --公会Boss不显示战败页面
    if battleType == PreFightBattleType.Guild_boss_war or battleType == PreFightBattleType.Guild_boss_imitate or
        battleType == PreFightBattleType.Guild_Sweep or battleType == PreFightBattleType.Disaster or battleType == PreFightBattleType.Disater_imitate then
        GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PANEL_OVER, {isWin = false})
        return
    end

    if battleType == PreFightBattleType.Guild_Imitate then
        local resultData = fight.FightManager:getResultData()
        local dupId = tonumber(battleFieldID)
        local args = {damage = resultData.args[1], cache_damage = resultData.args[2], new_record = resultData.args[3] == 1, rank = resultData.args[4], dupId = dupId}

        GameDispatcher:dispatchEvent(EventName.OPEN_GUILDBOSSIMITATE_RESULTVIEW, args)
        return
    end
    if battleType == PreFightBattleType.ArenaChallenge then
        msg.state = "Fail"
        GameDispatcher:dispatchEvent(EventName.UPDATE_ARENA_FIGHT_INFO, msg)
        GameDispatcher:dispatchEvent(EventName.OPEN_ARENA_DAN_PANEL, arena.ArenaManager.myFightInfo)
        return
    end

    if battleType == PreFightBattleType.Arena_Peak_Pvp then
        msg.state = arenaEntrance.ResultState.LOSE
        GameDispatcher:dispatchEvent(EventName.OPEN_ARENA_HELL_RESULT_PANEL, msg)
        return
    elseif battleType == PreFightBattleType.GuildWar then
        msg.state = msg.result
        GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_WAR_RESULT_PANEL, msg)
        return
    end

    --无限城的失败就直接失败 不显示战败页面
    if (battleType == PreFightBattleType.Cycle) then
        GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PANEL_OVER, {isWin = false})
        --self.m_fightFailView = fight.ArenaFightFailEndView.new()
        return
    end
    -- else
    --     self.m_fightFailView = fight.FightFailEndView.new()
    -- end
    -- self.m_fightFailView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFailViewHandler, self)
    -- self.m_fightFailView:setData(msg)
    -- self.m_fightFailView:open()

    LoopManager:setTimeout(0.3, self, function()
        FightResultProxy:showFailView(battleType, battleFieldID, msg, self.onFightResultClose, self)
    end)
end
-- ui销毁
function onDestroyFailViewHandler(self)
    self.m_fightFailView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFailViewHandler, self)
    self.m_fightFailView = nil
end

function onRequestFlyHandler(self, cusData)
    local id = cusData.id
    local type = cusData.type
    local value = cusData.value

    local thing = fight.SceneItemManager:getLivething(id)
    if (thing and thing:getTrans()) then
        local pos = thing:getTrans().position
        -- 微调坐标
        -- fight.HarmUtil:fly(CalculatorType.CUT_HP, thing.m_position, 123)
        -- 微调坐标，以模型实际坐标测试，在界面中拖动查看
        if (not fight.FightManager:getIsPause()) then
            fightUI.HarmUtil:fly(CalculatorType.CUT_HP, thing:getTrans().position, value)
        end
    end
end

-- 再次挑战
function onFightAgainHandler(self)

end

-- 打开战斗中的技能tips
function onShowFightSkillTips(self, args)
    if self.mFightSkillTips == nil then
        self.mFightSkillTips = fightUI.FightSkillTips.new()
        self.mFightSkillTips:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFightSkillTips, self)
    end
    self.mFightSkillTips:open(args)
end

function onCloseFightSkillTips(self)
    if self.mFightSkillTips and self.mFightSkillTips.isPop == 1 then
        self.mFightSkillTips:close()
    end
end

function onDestroyFightSkillTips(self)
    self.mFightSkillTips:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFightSkillTips, self)
    self.mFightSkillTips = nil
end

function onShowForcesSkillTips(self, args)
    if self.mForcesSkillTips == nil then
        self.mForcesSkillTips = fightUI.FightForcesSkillTips.new()
        self.mForcesSkillTips:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyForcesSkillTips, self)
    end
    self.mForcesSkillTips:open(args)
end

function onCloseForcesSkillTips(self)
    if self.mForcesSkillTips and self.mForcesSkillTips.isPop == 1 then
        self.mForcesSkillTips:close()
    end
end

function onDestroyForcesSkillTips(self)
    self.mForcesSkillTips:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyForcesSkillTips, self)
    self.mForcesSkillTips = nil
end

function onShowPreviewHanlder(self, args)
    if self.mPreview == nil then
        self.mPreview = fightUI.FightDataPreView.new()
        self.mPreview:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPreview, self)
    end
    self.mPreview:open(args)
end

function onDestroyPreview(self)
    self.mPreview:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPreview, self)
    self.mPreview = nil
end

-- 打开跳过奥义转场
function onShowSkipAoyiEffect(self)
    UIEffectMgr:addEffect("fx_ui_skipaoyi", GameView.pop)
end
-- 移除跳过奥义转场
function onRemoveSkipAoyiEffect(self)
    UIEffectMgr:removeEffect("fx_ui_skipaoyi", GameView.pop)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
