--[[
-----------------------------------------------------
@filename       : FightResultProxy
@Description    : 战斗结算界面
@date           : 2021-01-21 15:02:49
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
FightResultProxy = {}

-- 打开结算胜利界面
function FightResultProxy:showWinView(cusBattleType, cusBattleFieldID, cusData, closeCall, thisObject, callParams)
    local destroyView = function()
        self.mFightWinView:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
        self.mFightWinView = nil
        -- storyTalk.StoryTalkCondition:condition06()
    end
    local closeView = function()
        if closeCall then
            closeCall(thisObject, callParams)
        end
    end

    if self.mFightWinView == nil then
        -- if (cusBattleType == PreFightBattleType.ArenaChallenge) then
        --     self.mFightWinView = fightUI.ArenaFightWinEndView.new()
        -- else
        if cusBattleType == PreFightBattleType.InfiniteCity then
            self.mFightWinView = fightUI.InfiniteCityFightResultWinView.new()
        elseif cusBattleType == PreFightBattleType.DupImplied then
            self.mFightWinView = fightUI.DupImpliedFightResultWinView.new()
        elseif cusBattleType == PreFightBattleType.DupMaze then
            self.mFightWinView = fightUI.MazeFightResultWinView.new()
        elseif cusBattleType == PreFightBattleType.RogueLike then
            self.mFightWinView = fightUI.RogueLikeResultWinView.new()
        elseif cusBattleType == PreFightBattleType.MainExplore then
            self.mFightWinView = fightUI.MainExploreFightResultWinView.new()
        elseif cusBattleType == PreFightBattleType.ActiveDup then
            self.mFightWinView = mainActivity.ActiveDupFightResultWinView.new()
            -- elseif cusBattleType == PreFightBattleType.Doundless then
            --     self.mFightWinView = doundless.DoundlessResultPanel.new()
        else
            self.mFightWinView = fightUI.FightResultWinView.new()
        end
        self.mFightWinView:addEventListener(View.EVENT_CLOSE, closeView, self)
        self.mFightWinView:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
    end
    local data = {battleType = cusBattleType, battleFieldID = cusBattleFieldID, resultData = cusData}
    self.mFightWinView:open(data)

    return self.mFightWinView
end
-- 战斗胜利界面是否打开状态
function FightResultProxy:getWinViewIsPop(self)
    if self.mFightWinView and self.mFightWinView.isPop then
        return true
    end
    return false
end

-- 打开结算失败界面
function FightResultProxy:showFailView(cusBattleType, cusBattleFieldID, cusData, closeCall, thisObject, callParams)
    local destroyView = function()
        self.mFightFailView:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
        self.mFightFailView = nil
    end
    local closeView = function()
        if closeCall then
            closeCall(thisObject, callParams)
        end
    end
    if self.mFightFailView == nil then
        -- if (cusBattleType == PreFightBattleType.ArenaChallenge) then
        --     self.mFightFailView = fightUI.ArenaFightFailEndView.new()
        -- else
        self.mFightFailView = fightUI.FightResultFailView.new()
        -- end
        self.mFightFailView:addEventListener(View.EVENT_CLOSE, closeView, self)
        self.mFightFailView:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
    end
    local data = {battleType = cusBattleType, battleFieldID = cusBattleFieldID, resultData = cusData}
    self.mFightFailView:open(data)

    return self.mFightFailView
end

-- 返回对应副本的章节名、副本名
function FightResultProxy:getDupName(cusBattleType, cusBattleFieldID)
    return ""
    -- if cusBattleType == 99 then
    --     -- gm测试战斗类型
    --     return "M100", "GM测试战斗类型"
    -- end

    -- local mgr = FightResultProxy.battleMgrDic[cusBattleType]
    -- if not mgr then
    --     logError(string.format("战斗类型%s未注册", cusBattleType), "FightResultProxy")
    --     return "M100", _TT(3042)
    -- end
    -- if not mgr.getDupName then
    --     logError(string.format("战斗类型%s的manager未提供getDupName方法", cusBattleType), "FightResultProxy")
    --     return "M100", _TT(3042)
    -- end
    -- return mgr:getDupName(tonumber(cusBattleFieldID), cusBattleType)
end

-- 额外的战斗单位(预加载用)
function FightResultProxy:getExtraHeros(cusBattleType, cusBattleFieldID)
    local mgr = FightResultProxy.battleMgrDic[cusBattleType]
    if mgr and mgr.getExtraHeros then
        local list = {}
        local monIds = mgr:getExtraHeros(tonumber(cusBattleFieldID), cusBattleType)
        if monIds then
            for i, v in ipairs(monIds) do
                local monsterVo = monster.MonsterManager:getMonsterVo(v)
                table.insert(list, monsterVo.tid)
            end
        end
        return list
    end
    return nil
end

-- 对应副本能获取到副本章节名、副本名的数据管理器（必须有getDupName）
FightResultProxy.battleMgrDic = {}
FightResultProxy.battleMgrDic[PreFightBattleType.MainMapStage] = battleMap.MainMapManager
FightResultProxy.battleMgrDic[PreFightBattleType.Fragment] = battleMap.FragmentMapManager
FightResultProxy.battleMgrDic[PreFightBattleType.ClimbTowerDup] = dup.DupClimbTowerManager
FightResultProxy.battleMgrDic[PreFightBattleType.ElementTower] = dup.DupClimbTowerManager
FightResultProxy.battleMgrDic[PreFightBattleType.HeroBiography] = battleMap.BiographyManager
FightResultProxy.battleMgrDic[PreFightBattleType.DupMoney] = dup.DupDailyMainManager
FightResultProxy.battleMgrDic[PreFightBattleType.DupEquip_Low] = dup.DupEquipMainManager
FightResultProxy.battleMgrDic[PreFightBattleType.DupEquip_Mid] = dup.DupEquipMainManager
FightResultProxy.battleMgrDic[PreFightBattleType.DupEquip_High] = dup.DupEquipMainManager
FightResultProxy.battleMgrDic[PreFightBattleType.DupApostle2War] = dup.DupApostlesWarManager
--FightResultProxy.battleMgrDic[PreFightBattleType.DupEquip_4] = dup.DupDailyMainManager
--FightResultProxy.battleMgrDic[PreFightBattleType.DupEquip_5] = dup.DupDailyMainManager
FightResultProxy.battleMgrDic[PreFightBattleType.DupEquipTupo] = dup.DupDailyMainManager
FightResultProxy.battleMgrDic[PreFightBattleType.DupExp] = dup.DupDailyMainManager
FightResultProxy.battleMgrDic[PreFightBattleType.DupBracelets] = dup.DupDailyMainManager
FightResultProxy.battleMgrDic[PreFightBattleType.DupHeroStarUp] = dup.DupDailyMainManager
FightResultProxy.battleMgrDic[PreFightBattleType.DupHeroGrowUp] = dup.DupDailyMainManager
FightResultProxy.battleMgrDic[PreFightBattleType.DupHeroSkill] = dup.DupDailyMainManager
FightResultProxy.battleMgrDic[PreFightBattleType.DupBraceletUp] = dup.DupDailyMainManager
FightResultProxy.battleMgrDic[PreFightBattleType.DupBraceletEvolve] = dup.DupDailyMainManager
FightResultProxy.battleMgrDic[PreFightBattleType.DupFirePotency] = dup.DupPotencyManager
FightResultProxy.battleMgrDic[PreFightBattleType.DupIcePotency] = dup.DupPotencyManager
FightResultProxy.battleMgrDic[PreFightBattleType.DupElectricPotency] = dup.DupPotencyManager
FightResultProxy.battleMgrDic[PreFightBattleType.DupCavitationPotency] = dup.DupPotencyManager
FightResultProxy.battleMgrDic[PreFightBattleType.DupLifePotency] = dup.DupPotencyManager
FightResultProxy.battleMgrDic[PreFightBattleType.ArenaChallenge] = arena.ArenaManager
--FightResultProxy.battleMgrDic[PreFightBattleType.InfiniteCity] = infiniteCity.InfiniteCityManager
FightResultProxy.battleMgrDic[PreFightBattleType.CodeHopeDup] = dup.DupCodeHopeManager
FightResultProxy.battleMgrDic[PreFightBattleType.Training] = training.TrainingManager
FightResultProxy.battleMgrDic[PreFightBattleType.DupImplied] = dup.DupImpliedManager
FightResultProxy.battleMgrDic[PreFightBattleType.DupBranchEquip] = branchStory.BranchStoryManager
FightResultProxy.battleMgrDic[PreFightBattleType.DupMaze] = maze.MazeManager
FightResultProxy.battleMgrDic[PreFightBattleType.DupTactivs] = branchStory.BranchTactivsManager
FightResultProxy.battleMgrDic[PreFightBattleType.BranchMain] = branchStory.BranchMainManager
FightResultProxy.battleMgrDic[PreFightBattleType.BranchPower] = branchStory.BranchPowerManager
--FightResultProxy.battleMgrDic[PreFightBattleType.RogueLike] =  rogueLike.RogueLikeManager
FightResultProxy.battleMgrDic[PreFightBattleType.MainExplore] = mainExplore.MainExploreManager
FightResultProxy.battleMgrDic[PreFightBattleType.HeroTrial] = recruit.RecruitTrialManager
FightResultProxy.battleMgrDic[PreFightBattleType.Cycle] = cycle.CycleManager
FightResultProxy.battleMgrDic[PreFightBattleType.ActiveDup] = mainActivity.ActiveDupManager
FightResultProxy.battleMgrDic[PreFightBattleType.Friend] = training.TrainingManager
FightResultProxy.battleMgrDic[PreFightBattleType.Doundless] = doundless.DoundlessManager
-- FightResultProxy.battleMgrDic[PreFightBattleType.SandPlay] = sandPlay.SandPlayManager
FightResultProxy.battleMgrDic[PreFightBattleType.Seabed] = seabed.SeabedManager
FightResultProxy.battleMgrDic[PreFightBattleType.GuildWar] = guildWar.GuildWarManager
FightResultProxy.battleMgrDic[PreFightBattleType.Guild_Imitate] = guildBossImitate.GuildBossImitateManager

--[[ 替换语言包自动生成，请勿修改！
语言包: _TT(3042):"异空间"
语言包: _TT(3042):"异空间"
]]
