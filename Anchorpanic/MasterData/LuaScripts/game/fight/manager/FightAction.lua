module("fight.FightAction", Class.impl())

MoveCls = require('game/fight/ai/move/Move_3')
local PER_FRAME_SEC = 1 / 30
--构造函数
function ctor(self)
    self.m_curLiveVo = nil
    -- 当前使用的技能AI
    self.m_curSkillAI = nil
    self.m_pauseAction = false
    self.m_actioning = false
    self.m_waitingBack = false
    self.m_isStart = false
end

function initAction(self)
    self.m_isStart = false
    if self.m_curSkillAI then
        self.m_curSkillAI:removeEventListener(fight.AIEvent.SKILL_AI_END, self.onSkillEnd, self)
        self.m_curSkillAI:reset()
        Class.delete(self.m_curSkillAI)
        self.m_curSkillAI = nil
    end
    self.m_pauseAction = false
    -- 当前出手者
    self.m_curLiveVo = nil
    self.m_actioning = false
    self.m_waitingBack = false
    -- 最后出手的玩家方战员id
    self.m_attLastLiveId = nil
end

function getCurSkillAI(self)
    return self.m_curSkillAI
end

function getCurActData(self)
    return self.m_actData
end

function start(self)
    self.m_isStart = true
    guide.GuideCondition:condition19()
    guide.GuideCondition:condition25()
    self:moveNext()
end

function stop(self)
    GameDispatcher:dispatchEvent(EventName.SKILL_END)
    self.m_actioning = false
    if self.m_curSkillAI then
        self.m_curSkillAI:removeEventListener(fight.AIEvent.SKILL_AI_END, self.onSkillEnd, self)
        self.m_curSkillAI:reset()
        Class.delete(self.m_curSkillAI)
        self.m_curSkillAI = nil
    end
    if self.m_curLiveVo and not self.m_curLiveVo:isDead() then
        self:back2StartPoint()
    else
        self:moveNext()
    end
end

-- 是否是当时行动角色
function isLiveVoActiving(self, liveVo)
    if self.m_curLiveVo and liveVo == self.m_curLiveVo then
        return true
    end
    return false
end

-- 是否是受击目标
function isTargetLiveVo(self, liveId)
    local targetList = fight.FightManager:actionHeroList(self.m_actData)
    if targetList then
        for i, hero in ipairs(targetList) do
            if hero.hero_id == liveId then
                return true
            end
        end
    end
end

-- 镜头回退时战员死亡
function heroDealCameraBack(self)
    self.m_waitingBack = true
    self.m_curLiveVo = nil
    GameDispatcher:dispatchEvent(EventName.FIGHT_CAMERA_MOVE)
    fight.FightCamera:checkReturnCamera()
    fight.FightCamera:resetTranparency()
    local function _moveNext()
        self.m_waitingBack = false
        self:moveNext()
    end
    RateLooper:setTimeout(0.3, self, _moveNext)
end

-- 回到起跑站位
function back2StartPoint(self, beInstant)
    self.m_waitingBack = true
    local curLiveVo = self.m_curLiveVo
    self.m_curLiveVo = nil

    GameDispatcher:dispatchEvent(EventName.FIGHT_CAMERA_MOVE)
    fight.FightCamera:checkReturnCamera()
    fight.FightCamera:resetTranparency()

    if fight.SceneManager:isInRestorePos(curLiveVo) then

        -- 原地释放技能，不用回归站位
        local function _moveNext()
            self.m_waitingBack = false
            self:moveNext()
        end
        RateLooper:setTimeout(0.3, self, _moveNext)
        return
    end

    local live = fight.SceneItemManager:getLivething(curLiveVo:getLiveID())
    if live then
        local moveTime = 0.7
        live:getAniLenght(fight.FightDef.ACTION_NAMEs[fight.FightDef.ACT_EXIT], function(length)
            local speed = length / moveTime

            local function _endCall()
                curLiveVo:updateAniSpeed(1)
                self.m_waitingBack = false
                self:moveNext()

                -- 切换为低模
                -- live:switchLowModel()
            end

            local function _startCall()
                local targetPos = fight.SceneManager:getGridPos01(curLiveVo)
                local ro = fight.RoleShowManager:getShowData(curLiveVo:getModelID())

                -- if ro then
                --     curLiveVo:moveTo3(targetPos, moveTime, ro:getBackBefore() * PER_FRAME_SEC, ro:getBackAfter() * PER_FRAME_SEC, nil, _endCall)
                -- else
                curLiveVo:moveTo(targetPos, moveTime, _endCall)
                -- end
                -- local function _moveNext()
                --     self.m_waitingBack = false
                --     self:moveNext()
                -- end
                -- RateLooper:setTimeout(0.1, self, _moveNext)
            end

            curLiveVo:transAni(fight.FightDef.TRANS_EXIT, _startCall)
            curLiveVo:updateAniSpeed(speed)
        end)
    else
        local function _moveNext()
            self.m_waitingBack = false
            self:moveNext()
        end
        RateLooper:setTimeout(0.1, self, _moveNext)
    end
end

function setPauseAction(self, beEnable)
    self.m_pauseAction = beEnable
end

-- 下一波
function _playNewWave(self, act)
    self.m_actioning = true
    local function _loadStep()
        if act then
            if act.qte_energy then
                fight.FightManager:setBlockVal(act.qte_energy, 2)
            end
            local heroData = act.hero_list[1]
            if heroData then
                table.remove(act.hero_list, 1)
                fight.FightLoader:loadHeroLive(2, heroData, false, _loadStep)
                return
            else
                act = nil
            end
        end
        local function _goinOkCall()
            self.m_actioning = false
            -- 弹出一个技能数据
            fight.FightManager:popRoleAction()
            self:moveNext()
        end
        fight.FightLoader:loadEnterSceneSide(2, _goinOkCall)
    end
    fight.SceneManager:removeSideThing(2)
    storyTalk.StoryTalkCondition:condition07(act._waveCnt, _loadStep)
end

-- 普通行动处理（主要）
function _playNorAction(self, act)
    self.m_actioning = true
    self.m_actData = act

    -- 出手者已不存在 或 更新下一个角色出手
    if not self.m_curLiveVo or not fight.FightManager:isRoleAction01(self.m_curLiveVo) then

        -- 获取新的出手者
        self.m_curLiveVo = fight.SceneManager:getThing(act.hero_id)
        if self.m_curLiveVo then
            -- 保存出手角色 设置角色属性
            fight.FightManager:skillTurn(act.hero_id)

            LoopManager:dispatchEventDelayFrame(GameDispatcher, 2, EventName.ROLE_GO_ACTION, act)
            --GameDispatcher:dispatchEvent(EventName.ROLE_GO_ACTION, act)

            -- 把攻击者和受击者显示到镜头内
            local targetLiveVo = fight.SceneManager:getThing(act.target_id)
            if targetLiveVo then
                fight.FightCamera:showHeroInCamera(self.m_curLiveVo, targetLiveVo)
            end
        end
    end

    if self.m_curLiveVo then

        -- 触发复活技能，暂停当前action，等待复活动作完成（倒下-爬起）
        local reAlivefinishCall = function()
            self:_playNorAction(self.m_actData)
        end
        if self.m_curLiveVo:isReAliveing(reAlivefinishCall, act) then
            self.m_actioning = false
            return
        end

        self.m_curLiveVo:setAtt(AttConst.MP, act.rage, true)
        self.m_curLiveVo:setAtt(AttConst.SKILL_SOUL, act.skill_soul, true)

        LoopManager:dispatchEventDelayFrame(GameDispatcher, 3, EventName.FIGHT_HERO_ATTR_UPDATE, act.hero_id)
        --GameDispatcher:dispatchEvent(EventName.FIGHT_HERO_ATTR_UPDATE, act.hero_id)
        fight.SceneItemManager:updateLiveHead(act.hero_id)

    end
    -- 弹出一个技能数据
    fight.FightManager:popRoleAction()

    -- 技能ID为0 表示回合结束 用于处理buff一系列的效果
    if act.skill_id == 0 then
        local function _finishCall()
            self.m_actioning = false
            self:moveNext()
        end

        fight.FightActionPlayer:setActionData(act, act.hero_id, self.m_curLiveVo)
        if self.m_curLiveVo then
            fight.FightActionPlayer:playAll()
            fight.FightCamera:focusAttacker(self.m_curLiveVo)
            LoopManager:setTimeout(1.2, self, function()
                _finishCall()
            end)
        else
            fight.FightActionPlayer:playAll(_finishCall)
        end
        return
    else
        -- 获取技能数据
        local skillVo = fight.SkillManager:getSkillRo(act.skill_id)
        if not skillVo then
            Debug:log_error("FightAction", "skillVo is nil")
            self.m_actioning = false
            self:moveNext()
            return
        end

        --检测目标是否存在
        local targetLiveVo = fight.SceneManager:getThing(act.target_id)
        if not targetLiveVo then
            local noTargetOK = false
            if act.target_id ~= nil then
                local d1, d2 = fight.FightManager:parseUniqueID(act.target_id)
                -- 只是放效果 所有没有目标
                if d1 == 0 and d2 == 0 then
                    noTargetOK = true
                elseif d1 then
                    Debug:log_warn("FightAction", "targetLiveVo is nil (%s %s)", d1, d2)
                    self.m_actioning = false
                    self:moveNext()
                    return
                end
            end
            if noTargetOK == false then
                Debug:log_warn("FightAction", "[%s] targetLiveVo is nil", tostring(act.target_id))
                self.m_actioning = false
                self:moveNext()
                return
            end
        end

        local useSkillID = act.skill_id
        -- 指定战员时 作技能替换逻辑
        if fight.FightManager.m_gmModelTid and self.m_curLiveVo.m_skillList then
            local beRepeat = false
            for _, sID in ipairs(self.m_curLiveVo.m_skillList) do
                local sVo = fight.SkillManager:getSkillRo(sID)
                if sVo:getType() == skillVo:getType() then
                    skillVo = sVo
                    beRepeat = true
                    useSkillID = sID
                    break
                end
            end
            if beRepeat == false then
                skillVo = fight.SkillManager:getSkillRo(self.m_curLiveVo.m_skillList[1])
                useSkillID = self.m_curLiveVo.m_skillList[1]
            end
        end
        self.m_curSkillAI = fight.AIManager:createSkillAI(0)
        self.m_curSkillAI:setData(self.m_curLiveVo, targetLiveVo, useSkillID, useSkillID)
    end
    -- 记录我方最后出手人
    if self.m_curLiveVo and self.m_curLiveVo:isAttacker() == 1 then
        fight.FightManager:setMyAttLiveTId(self.m_curLiveVo:getTID())
        fight.FightManager:setMyAttLiveId(self.m_curLiveVo:getLiveID())
    end

    -- 延帧处理
    RateLooper:setFrameout(5, self, function()
        self.m_curSkillAI:setActionData(act)
        self.m_curSkillAI:addEventListener(fight.AIEvent.SKILL_AI_END, self.onSkillEnd, self)
        self.m_curSkillAI:execute()
    end)

    LoopManager:dispatchEventDelayFrame(GameDispatcher, 6, EventName.RUN_SKILL_ACTION, act)
    --GameDispatcher:dispatchEvent(EventName.RUN_SKILL_ACTION, act)

end

-- 添加效果
function _playEffectAction(self, act)
    local function _finishCall()
        self.m_actioning = false
        self:moveNext()
    end

    fight.FightManager:popRoleAction()

    fight.FightActionPlayer:setActionData(act, act.hero_id, self.m_curLiveVo)
    if self.m_curLiveVo then
        fight.FightActionPlayer:playAll()
        fight.FightCamera:focusAttacker(self.m_curLiveVo)
        LoopManager:setTimeout(1.2, self, function()
            _finishCall()
        end)
    else
        fight.FightActionPlayer:playAll(_finishCall)
    end
end

-- 回合结束
function _playActionEnd(self, act)
    self.m_actioning = true

    local function _storyFinishCall()
        fight.FightManager:setRoleList(fight.FightManager:parseHeroList(act.curl_order), fight.FightManager:parseHeroList(act.next_order))
        for _, info in ipairs(act.del_buff) do
            local targetLiveID = fight.FightManager:toUniqueID(info.side, info.hero_id)
            local targetLiveVo = fight.SceneManager:getThing(targetLiveID)
            --print("BUFF_移除前", v.side, v.hero_id,  targetLiveVo==nil)
            if targetLiveVo then
                for _, v in ipairs(info.buff_list) do
                    targetLiveVo:removeBuff(v.buff_id, v.round, v.layer)
                end
                fight.SceneItemManager:updateLiveHeadBuff(targetLiveID)
                GameDispatcher:dispatchEvent(EventName.UPDATE_BUFF, targetLiveID)
            end
        end

        LoopManager:dispatchEventDelayFrame(GameDispatcher, 1, EventName.LIEN_UP_LIST_UPDATE)
        --GameDispatcher:dispatchEvent(EventName.LIEN_UP_LIST_UPDATE)

        fight.FightManager:popRoleAction()
        self.m_actioning = false
        self:moveNext()
    end
    if fight.FightManager:getCurRound() == act.round then
        _storyFinishCall()
    else
        fight.FightManager:setCurRound(act.round)
        _storyFinishCall()
    end
end

-- 播放胜利动作特写
function _playWinAction(self, act)
    -- 出手者已不存在
    local liveId = nil
    if self.m_curLiveVo and self.m_curLiveVo:isAttacker() == 1 and self.m_curLiveVo:getModelType() == 0 then
        -- 最后一击
        liveId = self.m_curLiveVo:getLiveID()
    else
        -- 最后出手者
        liveId = fight.FightManager:getMyAttLiveId()
    end

    -- 存活的
    local liveVo = fight.SceneManager:getThing(liveId)
    if not liveVo or liveVo:isDead() or liveVo:getModelType() ~= 0 then
        liveId = nil
        local attList = fight.SceneManager:getSideThingIDs(1)
        if attList and #attList > 0 then
            for i, v in ipairs(attList) do
                liveVo = fight.SceneManager:getThing(v)
                if liveVo and not liveVo:isDead() and liveVo:getModelType() == 0 then
                    liveId = v
                    break
                end
            end
        end
    end

    fight.FightCamera:resetTranparency()
    fight.FightManager:popRoleAction()

    local thing = fight.SceneItemManager:getLivething(liveId)
    local finishCall = function()
        if not fight.FightManager.isShortCutResult then
            GameDispatcher:dispatchEvent(EventName.LAST_HIT_TO_WIN)
            if thing then
                thing:setAniSpeed(0)
            end
            local t = {}
            t._actType = fight.FightDef.ACTION_TYPE_RESULT
            fight.FightManager:pushAction(t)
        end
    end
    if thing then
        local switchHighFinishCall = function()
            local useTime = os.time() - self.switchStartTime
            useTime = math.max((1 - useTime), 0.1)
            fight.SceneItemManager:closeAllHeadBar()
            BuffHandler:removeAllBuff()

            local dict = fight.SceneItemManager:getAllLiveThing()
            for _, live in pairs(dict) do
                local _liveVo = live:getLiveVo()
                if _liveVo and _liveVo:getLiveID() ~= liveId then
                    -- 隐藏胜利镜头以外的其他战员
                    _liveVo:setVisible(false)
                end
            end
            local liveTid = liveVo.tid
            LoopManager:setTimeout(useTime, self, function()
                thing:setIsHitModel(false)
                liveVo:setVisible(true)
                thing:setDofPrepare()

                fight.FightManager:updateTimeScale(1)
                GameDispatcher:dispatchEvent(EventName.HIDE_FIGHT_UI)
                GameDispatcher:dispatchEvent(EventName.HIDE_FIGHT_BLACK_MASK)
                fight.FightCamera:focusOnLive(liveId)
                thing:playAction(fight.FightDef.ACT_WIN, nil, finishCall)
                AudioManager:playFightSoundEffect(UrlManager:getFightSoundPath(string.format("%s/sfx_role_%s_win.prefab", liveVo:getBaseModelId(), liveVo:getBaseModelId())), false, nil, thing:getTrans())


                AudioManager:playHeroCVByFieldName(liveTid, "win_voice", nil, true)
                -- AudioManager:pauseMusicByFade(2, function()
                AudioManager:playMusicById(30, false) --胜利音乐
                -- end)
            end)
        end
        GameDispatcher:dispatchEvent(EventName.SHOW_FIGHT_BLACK_MASK)
        fight.FightCamera:checkReturnCamera()
        fight.FightCamera:setCameraDof()
        self.switchStartTime = os.time()
        thing:getLiveVo():clearBuff()
        thing:switchHighModel(switchHighFinishCall, true)
    else
        finishCall()
    end
end

function isRoleHaveNextAttAction(self)
    -- 获取战斗数据
    local actionData = fight.FightManager:checkFirstRoleAction()
    if actionData and self.m_curLiveVo and not self.m_curLiveVo:isDead() and not fight.FightManager:isRoleAction01(self.m_curLiveVo) then
        if actionData._actType == fight.FightDef.ACTION_TYPE_NOR then
            -- 技能ID为0 表示回合结束 用于处理buff一系列的效果
            if actionData.skill_id ~= 0 then
                return true
            end
        end
    end
    return false
end

function moveNext(self)
    -- 获取战斗数据
    local actionData = fight.FightManager:checkFirstRoleAction()
    -- 没有时请求新数据 
    if not actionData and not self.m_curSkillAI then
        fight.FightManager:reqBattleVideoEnd()
        return
    end
    -- 未开始
    if self.m_isStart == false then return end

    if self.m_waitingBack == true then return end
    -- 在后退中 或 技能还未播放完成 或暂停中
    if self.m_curSkillAI or (actionData._actType ~= fight.FightDef.ACTION_TYPE_RESULT and (self.m_actioning == true or self.m_pauseAction == true)) then
        return
    end
    -- 在等待效果演出，不继续
    if fight.FightActionPlayer.curBeforePriority ~= nil then
        return
    end

    if self.m_curLiveVo and (not fight.FightManager:isRoleAction01(self.m_curLiveVo) or (self.m_actData and self.m_actData.is_extra_skill == 1)) and actionData._actType < fight.FightDef.ACTION_TYPE_RESULT then
        if not self.m_curLiveVo:isDead() then
            self:back2StartPoint()
        else
            self:heroDealCameraBack()
        end
        return
    end

    if actionData._actType == fight.FightDef.ACTION_TYPE_WAVE then
        self:_playNewWave(actionData)
    elseif actionData._actType == fight.FightDef.ACTION_TYPE_NOR then
        self:_playNorAction(actionData)
    elseif actionData._actType == fight.FightDef.ACTION_TYPE_RESULT_OVER then
        if fight.SceneManager:isInFightScene() then
            GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PANEL_OVER, { isWin = true })
        end
    elseif actionData._actType == fight.FightDef.ACTION_TYPE_END then
        self:_playActionEnd(actionData)
    elseif actionData._actType == fight.FightDef.ACTION_TYPE_RESULT then
        fight.FightManager:battleFinish()
        fight.FightManager:popRoleAction()
    elseif actionData._actType == fight.FightDef.ACTION_TYPE_WIN then
        self:_playWinAction(actionData)
    elseif actionData._actType == fight.FightDef.ACTION_TYPE_EFFECT then
        self:_playEffectAction(actionData)
    end
end

-- 整个技能结束了
function onSkillEnd(self, args)
    local skillAISn = args.sn
    local skillId = args.skillId
    GameDispatcher:dispatchEvent(EventName.SKILL_END, { skillId = skillId })
    if self.m_curSkillAI and self.m_curSkillAI:sn() == skillAISn then
        self.m_curSkillAI:removeEventListener(fight.AIEvent.SKILL_AI_END, self.onSkillEnd, self)
        Class.delete(self.m_curSkillAI)
        self.m_curSkillAI = nil

        self.m_actioning = false
        self:moveNext()
    end
end


function stopCurSkillAI(self)
    GameDispatcher:dispatchEvent(EventName.SKILL_END)
    self.m_actioning = false
    if self.m_curSkillAI then
        self.m_curSkillAI:removeEventListener(fight.AIEvent.SKILL_AI_END, self.onSkillEnd, self)
        self.m_curSkillAI:reset()
        Class.delete(self.m_curSkillAI)
        self.m_curSkillAI = nil
    end
    self:moveNext()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]