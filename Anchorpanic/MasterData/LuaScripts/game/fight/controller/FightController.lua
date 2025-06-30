module("fight.FightController", Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--游戏开始的回调
function gameStartCallBack(self)

end
function reLogin(self)
    super.reLogin(self)
    -- fight.FightCamera:setCameraGeneralCtrl(nil)
    -- fight.SceneManager:clearMap()
    -- AudioManager:stopMusic()
    -- AudioManager:stopAllFightSoundEffect()
end
--模块间事件监听
function listNotification(self)
    -- GameDispatcher:addEventListener(EventName.BEGIN_FIGHT, self.onBeginFightHandler, self)
    GameDispatcher:addEventListener(EventName.FIGHT_SCENE_COMPLETE, self.onFightSceneCompleteHandler, self)
    GameDispatcher:addEventListener(EventName.ACCOUNT_RELOGIN_SUC, self.onRelogin, self)
    GameDispatcher:addEventListener(EventName.SERVER_PING_STOP, self.onServerPingStop, self)
    GameDispatcher:addEventListener(EventName.SERVER_PING_REGAIN, self.onServerPingRegain, self)
    GameDispatcher:addEventListener(EventName.REQ_FIGHT_OUTSIDE_SKIP_RECHECK, self.onReqBattleOutSideSkipRecheckHandle, self)

end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_BATTLE_FIELD_INFO = self.onRecvBATTLE_FIELD_INFO,
        SC_BATTLE_ACTION = self.onRecvBATTLE_ACTION,
        SC_BATTLE_ACTION_END = self.onRecvSC_BATTLE_ACTION_END,
        SC_BATTLE_RESULT = self.onRecvSC_BATTLE_RESULT,
        SC_BATTLE_AUTO = self.onRecvSC_BATTLE_AUTO,
        -- 回放消息
        SC_BATTLE_REPLAY_INFOS = self.onRecvSC_BATTLE_REPLAY_INFOS,
        SC_BATTLE_REPLAY_UPDATE = self.onRecvSC_BATTLE_REPLAY_UPDATE,
        SC_BATTLE_REPLAY = self.onRecvSC_BATTLE_REPLAY,

        SC_BATTLE_USE_SKILL = self.onRecvSC_BATTLE_USE_SKILL,

        SC_BATTLE_NONE = self.onRecvSC_BATTLE_NONE,

        SC_BATTLE_NEW_WAVE = self.onRecvSC_BATTLE_NEW_WAVE,
        SC_BATTLE_HERO_CHANGE = self.onRecvSC_BATTLE_HERO_CHANGE,

        SC_BATTLE_FORCES_SKILL_ENERGY = self.onRecvSC_BATTLE_FORCES_SKILL_ENERGY,

        --- *s2c* 战斗回放统计数据 20124
        SC_BATTLE_REPLAY_STATISTIC = self.onResFightReplay,

        --- *s2c* 战斗效果通知 20125
        SC_BATTLE_ACTION_NOTICE = self.onRecvSC_BATTLE_ACTION_NOTICE,
        --- *s2c* 战斗行动顺序更新 20126
        SC_BATTLE_ORDER = self.onRecvSC_BATTLE_ORDER,
        --- *s2c* 战员自动战斗规则更换返回 20128
        SC_HERO_AUTO_RULE_CHANGE = self.onRecvSC_HERO_AUTO_RULE_CHANGE,
        --- *s2c* 战斗中行动队列修改 20129
        SC_BATTLE_ORDER_CHANGE = self.onRecvSC_BATTLE_ORDER_CHANGE,
        --- *s2c* 战斗外跳过结果 20141
        SC_BATTLE_OUTSIDE_SKIP_RESULT = self.onRecvSC_BATTLE_OUTSIDE_SKIP_RESULT,
        --- *s2c* 战斗外跳过结果重新确认 20143
        SC_BATTLE_OUTSIDE_SKIP_RECHECK = self.onBattleOutSideSkipRecheckHandler,
    }
end

--- *c2s* 战斗回放统计数据 20123
function reqBattleRePlayDate(self, fightType, replayDataId)
    fight.FightManager:setLastReqInfoBattleType(fightType)
    SOCKET_SEND(Protocol.CS_BATTLE_REPLAY_STATISTIC, { type = fightType, id = replayDataId })
end

--- *s2c* 战斗回放统计数据 20124
function onResFightReplay(self, msg)
    GameDispatcher:dispatchEvent(EventName.SERVER_BATTLEREPLAY_RES, msg)
end

--- *c2s* 战斗外跳过 20140
function reqBattleOutsideSkip(self, battleType, battleFieldId)
    fight.FightManager:setBeReplaying(false)
    fight.FightManager:setBattleData(battleType, battleFieldId)
    SOCKET_SEND(Protocol.CS_BATTLE_OUTSIDE_SKIP, { battle_type = battleType, battle_field_id = battleFieldId })
end

--- *c2s* 战斗外跳过结果重新确认 20142
function onReqBattleOutSideSkipRecheckHandle(self)
    SOCKET_SEND(Protocol.CS_BATTLE_OUTSIDE_SKIP_RECHECK, { battle_type = PreFightBattleType.Guild_boss_war })
end

function onRelogin(self)
    if fight.FightManager:getIsBattleing() then
        local autoType = fight.FightSetting:getAutoCfg()
        if fight.FightManager:getIsAutoFight() or (autoType == 2 or autoType == 4) then
            fight.FightManager:reqAuto(1)
        else
            fight.FightManager:reqAuto(0)
        end
        fight.FightManager.m_videoEnding = false

        fight.FightAction:moveNext()
    end
end

-- 服务器心跳停止
function onServerPingStop(self)
    if not fight.FightManager:getIsBattleing() then
        return
    end

    self.reconnectView = UIFactory:showReconnect()
end

-- 服务器心跳恢复
function onServerPingRegain(self)
    -- if self.nextActionTimeId then
    --     RateLooper:removeTimerByIndex(self.nextActionTimeId)
    --     self.nextActionTimeId = nil
    -- end

    if self.reconnectView then
        self.reconnectView:close()
        self.reconnectView = nil
    end
end

--- *s2c* 战斗新波数 20117
function onRecvSC_BATTLE_NEW_WAVE(self, msg)
    print("onRecvSC_BATTLE_NEW_WAVE")
    if not fight.FightManager:setSyncWord(msg.sync_word) then
        return
    end

    -- 新一波守方信息
    if msg.def_info then
        for _, hero in ipairs(msg.def_info.hero_list) do
            hero.id = fight.FightManager:toUniqueID(2, hero.id)
        end
        msg.def_info._actType = fight.FightDef.ACTION_TYPE_WAVE
        msg.def_info._waveCnt = fight.FightManager:getWaveCnt()
        fight.FightManager:setWaveCnt(fight.FightManager:getWaveCnt() + 1)
        fight.FightManager:pushAction(msg.def_info)
    end
end

--- *s2c* 战斗中角色加入 20118
function onRecvSC_BATTLE_HERO_CHANGE(self, msg)
    print("onRecvSC_BATTLE_HERO_CHANGE")
    if not fight.FightManager:setSyncWord(msg.sync_word) then
        return
    end

    for _, hero in ipairs(msg.hero_list) do
        hero.id = fight.FightManager:toUniqueID(msg.side, hero.id)
        hero.__side = msg.side
        if msg.side == 1 then
            fight.FightManager:setHeroSkillTmpData(hero, hero.skill_list)
        end
        if msg.story_id < 1 then
            fight.FightManager:addHeroCache(hero.id, hero)
        else
            storyTalk.StoryTalkManager:addStoryHero(msg.story_id, msg.talk_id, hero)
        end
        --print("onRecvSC_BATTLE_HERO_CHANGE======= ", msg.side, hero.id)
    end
end

--- *s2c* 无战斗状态通知 20116
function onRecvSC_BATTLE_NONE(self, msg)
    if fight.FightManager:getIsBattleing() then
        -- GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PANEL_OVER,{isWin = true})
        local t = {}
        t._actType = fight.FightDef.ACTION_TYPE_RESULT_OVER
        fight.FightManager:pushAction(t)
    end
end

--- *s2c* 使用技能返回 20115
function onRecvSC_BATTLE_USE_SKILL(self, msg)
    if msg.result == 1 then
        -- 此处只有成功才同步同步码
        if not fight.FightManager:setSyncWord(msg.sync_word) then
            return
        end

        local liveID = fight.FightManager:toUniqueID(1, msg.hero_id)
        local liveVo = fight.SceneManager:getThing(liveID)
        if liveVo and msg.skill_soul then
            -- print("onRecvSC_BATTLE_USE_SKILL====== ", liveID, msg.skill_soul, msg.rage/10)
            local rage = msg.rage / 10
            if rage > fight.FightManager:getMaxRage(liveID) then
                rage = fight.FightManager:getMaxRage(liveID)
            end
            -- if (liveVo:isAttacker()==1) then
            --     print("onRecvSC_BATTLE_USE_SKILL", rage)
            -- end
            -- print("onRecvSC_BATTLE_USE_SKILL =============", rage)
            liveVo:setAtt(AttConst.MP, rage, true)
            liveVo:setAtt(AttConst.SKILL_SOUL, msg.skill_soul, true)
            fight.SceneItemManager:updateLiveHead(liveID)

            fight.FightManager.skillSyncMP = msg.sync_word
        end
        GameDispatcher:dispatchEvent(EventName.SKILL_USE_SUCCESS, msg)

        -- fight.FightManager:reqBattleVideoEnd()
    end
end

--- *s2c* 战斗回放信息 20111
function onRecvSC_BATTLE_REPLAY_INFOS(self, msg)
    -- print("onRecvSC_BATTLE_REPLAY_INFOS ======")
    for _, v in ipairs(msg.replay_list) do
        for _, replayData in ipairs(v.replay_list) do
            fight.FightManager:updateReplayData(v.type, replayData)
        end
    end
end

--- *s2c* 战斗回放信息更新 20112
function onRecvSC_BATTLE_REPLAY_UPDATE(self, msg)
    for _, v in ipairs(msg.del_list) do
        fight.FightManager:removeReplayData(msg.type, v)
    end
    for _, v in ipairs(msg.update_list) do
        fight.FightManager:updateReplayData(msg.type, v)
    end
end

--- *s2c* 战斗回放请求返回 20119
function onRecvSC_BATTLE_REPLAY(self, msg)
    if msg then
        if msg.result == fight.FightDef.REPLAY_NONE then
            -- gs.Message.Show("没有找到回放")
            gs.Message.Show(_TT(1120))
        elseif msg.result == fight.FightDef.REPLAY_VSN then
            -- gs.Message.Show("回放失效")
            gs.Message.Show(_TT(1199))
        end
    end
end

--- *s2c* 战场信息 20101
function onRecvBATTLE_FIELD_INFO(self, msg)
    if msg.enter_result == 2 then
        gs.Message.Show(_TT(97061))
        return
    end

    --进入战场失败
    if msg.enter_result == 0 then
        return
    end

    if fight.SceneManager:isInFightScene() then
        GameDispatcher:dispatchEvent(EventName.EXIT_FIGHT_SCENE)
        gs.Message.Show("错误：当前战斗未退出，新的进入请求出错，将返回主场景")
        return
    end
    guide.GuideCondition:resetTempData()
    fight.FightManager:initData()
    fight.FightManager:initUniqueID()

    if not fight.FightManager:setSyncWord(msg.sync_word) then
        return
    end

    fight.FightManager:setBattleData(msg.battle_type, msg.battle_field_id)
    fight.FightAction:initAction()

    fight.FightManager:setRoleList(fight.FightManager:parseHeroList(msg.hero_order))
    for _, hero in ipairs(msg.att_info.hero_list) do
        hero.id = fight.FightManager:toUniqueID(1, hero.id)
    end

    for _, hero in ipairs(msg.def_info.hero_list) do
        hero.id = fight.FightManager:toUniqueID(2, hero.id)
    end
    fight.FightManager:setIsAutoFight(msg.is_auto == 1)
    fight.FightManager:setBeReplaying(msg.is_replay == 1)
    fight.FightManager:setMaxRound(msg.max_round)
    fight.FightManager:setTeamData(msg.att_info, msg.def_info)
    fight.FightManager:setBlockVal(msg.att_info.qte_energy, 1)
    fight.FightManager:setBlockVal(msg.def_info.qte_energy, 2)
    fight.FightManager:setBattleAssistList(msg.att_info.assist_fight_list, 1)
    fight.FightManager:setBattleAssistList(msg.def_info.assist_fight_list, 2)
    fight.FightManager:setSceneSkillList(msg.scene_skill_id_list)
    -- 删除指挥官技能机制
    fight.FightManager:setForcesSkillList(msg.forces_skill_list)
    fight.FightManager:setForcesSkillEnergy(msg.forces_skill_energy)

    storyTalk.StoryTalkCondition:resetCanNeedWait()
    GameDispatcher:dispatchEvent(EventName.ONLY_CLOSE_TALK_PANEL)
    fight.SceneManager:build(msg)
    fight.FightManager:setIsFighting(true)
end

--- *s2c* 战斗行动 20103
function onRecvBATTLE_ACTION(self, msg)
    -- print("==========onRecvBATTLE_ACTION")
    if not fight.FightManager:setSyncWord(msg.sync_word) then
        return
    end

    msg.hero_id = fight.FightManager:toUniqueID(msg.side, msg.hero_id)
    msg.target_id = fight.FightManager:toUniqueID(msg.target_side, msg.target_id)
    -- -- 旧的数据结构
    for _, v in ipairs(msg.hero_list) do
        v.hero_id = fight.FightManager:toUniqueID(v.side, v.hero_id)
    end
    msg.rage = msg.rage / 10
    if msg.rage > fight.FightManager:getMaxRage(msg.hero_id) then
        msg.rage = fight.FightManager:getMaxRage(msg.hero_id)
    end

    -- 新的数据结构
    for _, v in ipairs(msg.result_list) do
        for _, subVal in ipairs(v.hero_list) do
            subVal.hero_id = fight.FightManager:toUniqueID(subVal.side, subVal.hero_id)
        end
    end
    -- 技能目标
    for _, v in ipairs(msg.target_list) do
        v.hero_id = fight.FightManager:toUniqueID(v.side, v.hero_id)
    end
    fight.FightManager:addRoleAction(msg)
end

-- 回合结束
function onRecvSC_BATTLE_ACTION_END(self, msg)
    -- print("==========onRecvSC_BATTLE_ACTION_END")
    if not fight.FightManager:setSyncWord(msg.sync_word) then
        return
    end

    msg._actType = fight.FightDef.ACTION_TYPE_END
    fight.FightManager:pushAction(msg)
end

--- *s2c* 整场战斗结束 20106
function onRecvSC_BATTLE_RESULT(self, msg)
    -- print("onRecvSC_BATTLE_RESULT================")
    if not fight.FightManager:getIsBattleing() then
        return
    end

    -- 64位转换为数值类型
    for i = 1, #msg.args do
        local val = msg.args[i]
        msg.args[i] = tonumber(val)
    end

    fight.FightManager:clearSyncWord()
    fight.FightManager:setResultData(msg)
    if fight.FightManager:getIsFighting() then
        if msg.result == 1 and fight.FightManager:getBattleType() ~= PreFightBattleType.Arena_Peak_Pvp and fight.FightManager:getBattleType() ~= PreFightBattleType.GuildWar then
            -- 胜利
            msg._actType = fight.FightDef.ACTION_TYPE_WIN
        elseif msg.result == 3 then
            -- 主动退出
            msg._actType = fight.FightDef.ACTION_TYPE_RESULT
            fight.FightManager:clearRoleAciton()
        else
            -- 正常失败
            msg._actType = fight.FightDef.ACTION_TYPE_RESULT
        end
        fight.FightManager:pushAction(msg)
    else
        fight.FightManager:battleFinish()
    end
    fight.FightManager:setIsBattleing(false)
end
function onRecvSC_BATTLE_AUTO(self, msg)
    -- print("onRecvSC_BATTLE_AUTO", msg.is_auto)

    fight.FightManager:setIsAutoFight(msg.is_auto == 1)
    if msg.is_auto == 1 then
        fight.FightSetting:setAutoCfg(2)
    else
        fight.FightSetting:setAutoCfg(1)
    end
    GameDispatcher:dispatchEvent(EventName.AUTO_FIGHT_EVENT)
end

--- *s2c* 盟约技能能量更新 20122
function onRecvSC_BATTLE_FORCES_SKILL_ENERGY(self, msg)
    -- 删除指挥官技能
    if not fight.FightManager:setSyncWord(msg.sync_word) then
        return
    end
    fight.FightManager:setForcesSkillEnergy(msg.energy)
end

--- *s2c* 战斗效果通知 20125
function onRecvSC_BATTLE_ACTION_NOTICE(self, msg)
    -- print("==================onRecvSC_BATTLE_ACTION_NOTICE")
    if not fight.FightManager:setSyncWord(msg.sync_word) then
        return
    end
    msg.hero_id = fight.FightManager:toUniqueID(msg.side, msg.hero_id)
    for _, v in ipairs(msg.hero_list) do
        v.hero_id = fight.FightManager:toUniqueID(v.side, v.hero_id)
    end
    msg.result_list = {}
    msg._actType = fight.FightDef.ACTION_TYPE_EFFECT
    fight.FightManager:addRoleAction(msg)
end

--- *s2c* 战斗行动顺序更新 20126
function onRecvSC_BATTLE_ORDER(self, msg)
    print("==================onRecvSC_BATTLE_ORDER")
    if not fight.FightManager:setSyncWord(msg.sync_word) then
        return
    end
    fight.FightManager:setRoleList(fight.FightManager:parseHeroList(msg.curl_order), fight.FightManager:parseHeroList(msg.next_order))
end

--- *s2c* 战员自动战斗规则更换返回 20128
function onRecvSC_HERO_AUTO_RULE_CHANGE(self, msg)
    print("==================onRecvSC_HERO_AUTO_RULE_CHANGE", msg.rule_type)
    msg.hero_id = fight.FightManager:toUniqueID(1, msg.hero_id)
    local heroData = fight.FightManager:getHero(msg.hero_id)
    heroData.auto_battle_rule = msg.rule_type
end

--- *s2c* 战斗中行动队列修改 20129 鹿灵额外技能特别协议（临时写死）
function onRecvSC_BATTLE_ORDER_CHANGE(self, msg)
    print("====================onRecvSC_BATTLE_ORDER_CHANGE")
    msg.hero_id = fight.FightManager:toUniqueID(1, msg.hero_id)
    local liveVo = fight.LivethingVo.new(msg.hero_id, msg.hero_side)
    liveVo:setTID(msg.hero_tid, msg.hero_type, 0)
    fight.SceneManager:addThing(liveVo)
end

--- *s2c* 战斗外跳过结果 20141
function onRecvSC_BATTLE_OUTSIDE_SKIP_RESULT(self, msg)
    print("====================onRecvSC_BATTLE_OUTSIDE_SKIP_RESULT")
    if msg.result == 0 then
        gs.Message.Show("战斗出现异常，请重试")
    else
        fight.FightManager:setResultData(msg)
        GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PANEL_SHOW)
    end
    GameDispatcher:dispatchEvent(EventName.FIGHT_OUTSIDE_SKIP_RESULT)
end

--- *s2c* 战斗外跳过结果重新确认 20143 "结果 0:没有跳过结果"
function onBattleOutSideSkipRecheckHandler(self, msg)
    if msg.result == 0 then
        -- 没有结果需要重新展示，直接清除状态
        arenaEntrance.ArenaEntranceManager.isSkipFighting = false
    end
end

-- 场景准备完毕，开始战斗
function onFightSceneCompleteHandler(self)
    -- GameDispatcher:dispatchEvent(EventName.HIDE_MAIN_UI)
    local function _finishCall(beSuccess, storyRo)
        if beSuccess and storyRo then
            if storyRo:getEffectType() == 1 then
                fight.FightManager:setSelfModelRemove(false)
            end
            -- fight.FightManager:setSelfModelRemove(false)
        end
        self:__startFight()
    end
    storyTalk.StoryTalkCondition:condition02(_finishCall)
end

-- 开始战斗
function __startFight(self)
    fight.FightManager:setIsBattleing(true)
    -- GameDispatcher:dispatchEvent(EventName.FIGHT_START)
    fight.FightManager:reqBattleStart()
    GameDispatcher:dispatchEvent(EventName.FIGHT_START)
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]