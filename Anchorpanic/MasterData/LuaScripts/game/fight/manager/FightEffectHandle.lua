--[[     战斗效果管理器
]]
module("fight.FightEffectHandle", Class.impl())

--构造函数
function ctor(self)
    self.m_targetEftQueue = {}
    self.m_flyTextEnable = true
end

function init(self)
    self.m_targetEftQueue = {}
end

function setFlyTextEnable(self, beAble)
    self.m_flyTextEnable = beAble
end

-- 战斗效果触发（senderLiveID行动执行者非效果影响对象，targetLiveID效果影响或释放对象）
function action(self, effectInfo, senderLiveID, targetLiveID, finishCall)
    local eftType = effectInfo.type
    local eftVal = tonumber(effectInfo.count)
    local actionID = effectInfo.actionID
    local isImmedCall = true --立即完成回调

    for i = 1, #effectInfo.count_list do
        local val = effectInfo.count_list[i]
        effectInfo.count_list[i] = tonumber(val)
    end

    local targetLiveVo = fight.SceneManager:getThing(targetLiveID)
    if eftType == fight.FightDef.BATTLE_TYPE_REVIVE then
        if targetLiveVo then
            -- print("============ BATTLE_TYPE_REVIVE122  ", targetLiveID, eftVal)
            targetLiveVo:reAlive()
            targetLiveVo:setAtt(AttConst.HP, eftVal, true)
            GameDispatcher:dispatchEvent(EventName.FIGHT_HERO_ATTR_UPDATE, targetLiveID)
        end
    end

    if eftType == fight.FightDef.BATTLE_TYPE_DEAD then
        if targetLiveVo then
            targetLiveVo:setAlive(false)
            -- print("============ BATTLE_TYPE_DEAD", targetLiveID)
        end
    elseif eftType == fight.FightDef.BATTLE_TYPE_DAMAGE then
        self:toDamage(senderLiveID, targetLiveID, eftVal)
        self:seeFly(actionID, targetLiveID, eftType, eftVal)
        -- print("============  ", eftType, targetLiveID, eftVal)
    elseif eftType == fight.FightDef.BATTLE_TYPE_EVADE then
        if targetLiveVo then
            fightUI.FightFlyUtil:fly3DImg(UrlManager:getFightArtfontPath("shanbi.png"), targetLiveVo:getCurPos(), targetLiveVo:isAttacker() == 1)
        end
    elseif eftType == fight.FightDef.BATTLE_TYPE_CRIT then
        self:toDamage(senderLiveID, targetLiveID, eftVal)
        self:seeFly(actionID, targetLiveID, eftType, eftVal)
        -- print("============  ", eftType, targetLiveID, eftVal)
    elseif eftType == fight.FightDef.BATTLE_TYPE_ELE_DAMAGE then
        self:toDamage(senderLiveID, targetLiveID, eftVal)
        self:seeFly(actionID, targetLiveID, eftType, eftVal, effectInfo.count_list)
        -- print("============  ", eftType, targetLiveID, eftVal)
    elseif eftType == fight.FightDef.BATTLE_TYPE_BUFF_ADD then
        if targetLiveVo then
            local sendId = fight.FightManager:toUniqueID(effectInfo.count_list[3], effectInfo.count_list[4]) --buff释放者id（也可能是场景）
            targetLiveVo:addBuff(eftVal, sendId, effectInfo.count_list[2], effectInfo.count_list[1], effectInfo.count_list[5])
            fight.SceneItemManager:updateLiveHeadBuff(targetLiveID)
            GameDispatcher:dispatchEvent(EventName.UPDATE_BUFF, targetLiveID)
        end
    elseif eftType == fight.FightDef.BATTLE_TYPE_BURST then --"爆裂伤害 "..
        self:toDamage(senderLiveID, targetLiveID, eftVal)
        self:seeFly(actionID, targetLiveID, eftType, eftVal)

    elseif eftType == fight.FightDef.BATTLE_TYPE_SWALLOW then

    elseif eftType == fight.FightDef.BATTLE_TYPE_BUFF_TRIGGER then --BUFF触发效果
        -- print("====================BATTLE_TYPE_BUFF_TRIGGER", eftVal, effectInfo.count_list[1])
        fight.BuffTriggerEftManger:buffTrigger(targetLiveID, eftVal, effectInfo.count_list[1])

    elseif eftType == fight.FightDef.BATTLE_TYPE_BUFF_REMOVE then
        if targetLiveVo then
            targetLiveVo:removeBuff(eftVal, effectInfo.count_list[2], effectInfo.count_list[1])
            fight.SceneItemManager:updateLiveHeadBuff(targetLiveID)
            GameDispatcher:dispatchEvent(EventName.UPDATE_BUFF, targetLiveID)
        end
    elseif eftType == fight.FightDef.BATTLE_TYPE_DIRECT_DAMAGE then
        self:toDamage(senderLiveID, targetLiveID, eftVal)
        self:seeFly(actionID, targetLiveID, eftType, eftVal)
    elseif eftType == fight.FightDef.BATTLE_TYPE_CURE then
        self:toCure(senderLiveID, targetLiveID, eftVal)
        self:seeFly(actionID, targetLiveID, eftType, eftVal)

    elseif eftType == fight.FightDef.BATTLE_TYPE_CURL_ORDER then
        fight.FightManager:updateCurRoleList(1, targetLiveID, eftVal)
        GameDispatcher:dispatchEvent(EventName.LIEN_UP_LIST_UPDATE)
    elseif eftType == fight.FightDef.BATTLE_TYPE_NEXT_ORDER then
        fight.FightManager:updateNextRoleList(1, targetLiveID, eftVal)
        GameDispatcher:dispatchEvent(EventName.LIEN_UP_LIST_UPDATE)
    elseif eftType == fight.FightDef.BATTLE_TYPE_ADD_RAGE then
        if fight.FightManager.skillSyncMP == fight.FightManager:getSyncWord() then
            -- 技能已经同步了核能，同一个同步码下的增加效果不处理
            return
        end
        if targetLiveVo then
            local rage = targetLiveVo:getAtt(AttConst.MP) + eftVal / 10
            if rage > fight.FightManager:getMaxRage(targetLiveID) then
                rage = fight.FightManager:getMaxRage(targetLiveID)
            end
            targetLiveVo:setAtt(AttConst.MP, rage, true)
            fight.SceneItemManager:updateLiveHead(targetLiveID)
            GameDispatcher:dispatchEvent(EventName.FIGHT_HERO_ATTR_UPDATE, targetLiveID)
        end
    elseif eftType == fight.FightDef.BATTLE_TYPE_DEC_RAGE then
        if fight.FightManager.skillSyncMP == fight.FightManager:getSyncWord() then
            -- 技能已经同步了核能，同一个同步码下的减少效果不处理
            return
        end
        if targetLiveVo then
            targetLiveVo:setAtt(AttConst.MP, targetLiveVo:getAtt(AttConst.MP) - eftVal / 10, true)
            fight.SceneItemManager:updateLiveHead(targetLiveID)
            GameDispatcher:dispatchEvent(EventName.FIGHT_HERO_ATTR_UPDATE, targetLiveID)
        end
    elseif eftType == fight.FightDef.BATTLE_TYPE_ADD_SKILL_SOUL then
        if targetLiveVo then
            targetLiveVo:setAtt(AttConst.SKILL_SOUL, targetLiveVo:getAtt(AttConst.SKILL_SOUL) + eftVal, true)
            GameDispatcher:dispatchEvent(EventName.FIGHT_HERO_ATTR_UPDATE, targetLiveID)
        end
    elseif eftType == fight.FightDef.BATTLE_TYPE_DEC_SKILL_SOUL then
        if targetLiveVo then
            targetLiveVo:setAtt(AttConst.SKILL_SOUL, targetLiveVo:getAtt(AttConst.SKILL_SOUL) - eftVal, true)
            GameDispatcher:dispatchEvent(EventName.FIGHT_HERO_ATTR_UPDATE, targetLiveID)
        end
    elseif eftType == fight.FightDef.BATTLE_TYPE_CLEAR_ELECTROCUTE then
        self:toDamage(senderLiveID, targetLiveID, eftVal)
        self:seeFly(actionID, targetLiveID, eftType, eftVal)
    elseif eftType == fight.FightDef.BATTLE_TYPE_DARKTHORN then
    elseif eftType == fight.FightDef.BATTLE_TYPE_EXILE then
        if targetLiveVo then
            -- print("fight.FightDef.BATTLE_TYPE_EXILE")
            targetLiveVo:setAtt(AttConst.STATE_BATTLE_EXILE, true)
            targetLiveVo:setVisible(false)
            local target = fight.SceneItemManager:getLivething(targetLiveID)
            if target then
                target:closeHeadBar()
            end
        end
    elseif eftType == fight.FightDef.BATTLE_TYPE_EXILE_BACK then
        if targetLiveVo then
            -- print("fight.FightDef.BATTLE_TYPE_EXILE_BACK")
            local gridID = effectInfo.count_list[1] * 100 + effectInfo.count_list[2]
            targetLiveVo:setGridID00(gridID)
            local pos = fight.SceneGrid:getPos(targetLiveVo:isAttacker(), gridID)
            targetLiveVo:updatePosition(pos)
            targetLiveVo:setAtt(AttConst.STATE_BATTLE_EXILE, nil)
            targetLiveVo:setVisible(true)
            local target = fight.SceneItemManager:getLivething(targetLiveID)
            if target then
                target:showHeadBar()
            end
        end
    elseif eftType == fight.FightDef.BATTLE_TYPE_SHIELD_ADD then
        if targetLiveVo then
            local curVal = targetLiveVo:getAtt(AttConst.SHIELD)
            local maxVal = targetLiveVo:getAtt(AttConst.SHIELD_MAX)
            targetLiveVo:setAtt(AttConst.SHIELD_MAX, maxVal + eftVal, true)
            targetLiveVo:setAtt(AttConst.SHIELD, curVal + eftVal, true)
            self:seeFly(actionID, targetLiveID, eftType, eftVal)
            GameDispatcher:dispatchEvent(EventName.FIGHT_HERO_ATTR_UPDATE, targetLiveID)
        end
    elseif eftType == fight.FightDef.BATTLE_TYPE_SHIELD_DEC then
        if targetLiveVo then
            local curVal = targetLiveVo:getAtt(AttConst.SHIELD)
            if curVal - eftVal <= 0 then
                targetLiveVo:setAtt(AttConst.SHIELD_MAX, 0, true)
                targetLiveVo:setAtt(AttConst.SHIELD, 0, true)
            else
                targetLiveVo:setAtt(AttConst.SHIELD, curVal - eftVal, true)
            end
            GameDispatcher:dispatchEvent(EventName.FIGHT_HERO_ATTR_UPDATE, targetLiveID)
        end
    elseif eftType == fight.FightDef.BATTLE_TYPE_KNOCK_OFF then
        if targetLiveVo then
            local gridID = effectInfo.count_list[1] * 100 + effectInfo.count_list[2]
            local pos = fight.SceneGrid:getPos(targetLiveVo:isAttacker(), gridID)
            if pos then
                targetLiveVo:setGridID00(gridID)
                targetLiveVo:updatePosition(pos)
            else
                Debug:log_error("SceneGrid", "no pos with %d, %d", effectInfo.count_list[1], effectInfo.count_list[2])
            end
        end
    elseif eftType == fight.FightDef.BATTLE_TYPE_ANTI_INJURY then
        self:toDamage(senderLiveID, targetLiveID, eftVal)
        self:seeFly(actionID, targetLiveID, eftType, eftVal)
    elseif eftType == fight.FightDef.BATTLE_TYPE_ELECTROCUTE then
        self:toDamage(senderLiveID, targetLiveID, eftVal)
        self:seeFly(actionID, targetLiveID, eftType, eftVal)
    elseif eftType == fight.FightDef.BATTLE_TYPE_BLEED then
        self:toDamage(senderLiveID, targetLiveID, eftVal)
        self:seeFly(actionID, targetLiveID, eftType, eftVal)
    elseif eftType == fight.FightDef.BATTLE_TYPE_BURN then
        self:toDamage(senderLiveID, targetLiveID, eftVal)
        self:seeFly(actionID, targetLiveID, eftType, eftVal)
    elseif eftType == fight.FightDef.BATTLE_TYPE_BLOCK then
        if targetLiveVo then
            fightUI.FightFlyUtil:fly3DImg(UrlManager:getFightArtfontPath("gedang.png"), targetLiveVo:getCurPos(), targetLiveVo:isAttacker() == 1)
        end
    elseif eftType == fight.FightDef.BATTLE_TYPE_DICE then
        -- self:seeFly(actionID,targetLiveID, eftType, "骰子 "..eftVal)
    elseif eftType == fight.FightDef.BATTLE_TYPE_BLIND then --致盲效果导致攻击落空
        -- self:seeFly(actionID,targetLiveID, eftType, "攻击落空 ")
    elseif eftType == fight.FightDef.BATTLE_TYPE_STORY then --剧情播放(剧情ID)
        local ro = storyTalk.StoryTalkManager:getStoryRo(eftVal)
        if ro then
            fight.FightAction:setPauseAction(true)
            local function _storyFinishCall()
                fight.FightAction:setPauseAction(false)
                fight.FightAction:moveNext()
            end

            storyTalk.StoryTalkCondition:setStoryCallback(ro:getHappenType(), _storyFinishCall)
            storyTalk.StoryTalkCondition:tryToStartStory(ro:getHappenType(), ro)
        end
    elseif eftType == fight.FightDef.BATTLE_TYPE_STORY_HERO_OUT then --剧情导致下场
        AudioManager:stopAllFightSoundEffect()
        PostHandler:resetChromatic()
        fight.SceneManager:removeThing(targetLiveID)
    elseif eftType == fight.FightDef.BATTLE_TYPE_STORY_CHANGE_HP then --剧情导致血量直接变化(新血量)
        if targetLiveVo then
            targetLiveVo:setAtt(AttConst.HP, eftVal, true)
        end
    elseif eftType == fight.FightDef.BATTLE_TYPE_TRANSFORM then --变形(值2:[目标阵营,目标ID])
        if targetLiveVo then
            local uID = fight.FightManager:toUniqueID(effectInfo.count_list[1], effectInfo.count_list[2])
            if uID then
                -- print("======fight.FightDef.BATTLE_TYPE_TRANSFORM 11111111 ", uID)
                local heroData = fight.FightManager:getHero(uID)
                if heroData and targetLiveVo:isAttacker() == 1 then
                    fight.FightManager:setHeroSkillTmpData(targetLiveID, heroData.skill_list)
                end
                local toCopyLiveVo = fight.SceneManager:getThing(uID)
                if toCopyLiveVo then
                    -- print("======fight.FightDef.BATTLE_TYPE_TRANSFORM  ", targetLiveID)
                    local target = fight.SceneItemManager:getLivething(targetLiveID)
                    if target then
                        targetLiveVo:setCopyLiveVo(toCopyLiveVo)
                        fight.FightCamera:checkReturnCamera()
                        target:justChangeAppearance(toCopyLiveVo)
                        target:setDisplayLayer("Role")
                        fight.FightAction:stopCurSkillAI()
                    end
                end
            end
        end
    elseif eftType == fight.FightDef.BATTLE_TYPE_TRANSFORM_END then --变形结束
        if targetLiveVo then
            local target = fight.SceneItemManager:getLivething(targetLiveID)
            if target then
                -- print("======fight.FightDef.BATTLE_TYPE_TRANSFORM_END ", targetLiveID)
                fight.FightCamera:checkReturnCamera()
                targetLiveVo:setCopyLiveVo(nil)
                target:justChangeAppearance(targetLiveVo)
                target:setDisplayLayer("Role")
            end
            local heroData = fight.FightManager:getHero(targetLiveID)
            if heroData and targetLiveVo:isAttacker() == 1 then
                fight.FightManager:setHeroSkillTmpData(targetLiveID, heroData.skill_list)
            end
        end
    elseif eftType == fight.FightDef.BATTLE_TYPE_MAX_HP_CHANGE then --血量最大值改变(值2:[新最大值, 新当前血量值])
        if targetLiveVo then
            targetLiveVo:setAtt(AttConst.HP_MAX, effectInfo.count_list[1], true)
            targetLiveVo:setAtt(AttConst.HP, effectInfo.count_list[2], true)
        end
    elseif eftType == fight.FightDef.BATTLE_TYPE_SKILL_CD_CHANGE then --技能冷却剩余时间变化(值2:[技能ID, 新冷却剩余回合数])
        fight.FightManager:setSkillNewCD(targetLiveID, effectInfo.count_list[1], effectInfo.count_list[2])
    elseif eftType == fight.FightDef.BATTLE_TYPE_ELE_REACTION then --元素反应(值2:[变化类型: 1添加,标记类型,层数|2移除,标记类型,层数|3反应,已有标记类型,新加标记类型])
        -- 废弃
    elseif eftType == fight.FightDef.BATTLE_TYPE_QTE_ENERGY then --qte力场值更新(最新值, 值2:[目标阵营])
        -- print("setBlockVal=====", eftVal, effectInfo.count_list[1])
        fight.FightManager:setBlockVal(eftVal, effectInfo.count_list[1])
        GameDispatcher:dispatchEvent(EventName.BLOCK_VAL_UPDATE_EVENT)
    elseif eftType == fight.FightDef.BATTLE_TYPE_KNOCK_BACK then --% 被击退(值2:[x, y]新位置)
        if targetLiveVo then
            local gridID = effectInfo.count_list[1] * 100 + effectInfo.count_list[2]
            targetLiveVo:setGridID00(gridID)
            local pos = fight.SceneManager:getGridPos01(targetLiveVo)
            if pos then
                targetLiveVo:moveTo(pos, 0.15, nil, gs.DT.Ease.OutCirc)
            end
        end
    elseif eftType == fight.FightDef.BATTLE_TYPE_DEAD_POS_CHANGE or eftType == fight.FightDef.BATTLE_TYPE_CHANGE_POS then
        --% 死亡角色位置变动(值2:[x, y]新位置) / % 效果换位(值2:[x, y])
        if targetLiveVo then
            local gridID = effectInfo.count_list[1] * 100 + effectInfo.count_list[2]
            targetLiveVo:setGridID00(gridID)
            local pos = fight.SceneManager:getGridPos01(targetLiveVo)
            if pos then
                targetLiveVo:moveTo(pos, 0.08)
            end
        end
    elseif eftType == fight.FightDef.BATTLE_TYPE_GHOST then -- 进入灵魂状态

    elseif eftType == fight.FightDef.BATTLE_TYPE_REPLACE_COST then -- 技能消耗替换(值2:[技能ID, 新消耗值])
        local skillTmpVo = fight.FightManager:getHeroSkill(targetLiveID, effectInfo.count_list[1])
        if skillTmpVo then
            skillTmpVo:setNewSkillCost(effectInfo.count_list[2])
            GameDispatcher:dispatchEvent(EventName.FIGHT_HERO_ATTR_UPDATE, targetLiveID)
        end
    elseif eftType == fight.FightDef.BATTLE_TYPE_HERO_IN then -- 角色加入(值2:[角色阵营, 角色ID, 进场类型])
        -- print("========================BATTLE_TYPE_HERO_IN 角色加入")
        local sideList = {}
        local idList = {}
        local typeList = {}

        local group = 1
        local tempData = {}
        for i, v in ipairs(effectInfo.count_list) do
            local value = effectInfo.count_list[i]
            if not tempData[group] then
                tempData[group] = {}
            end
            table.insert(tempData[group], value)
            if i % 3 == 0 then
                group = group + 1
            end
        end

        for i = 1, group do
            local list = tempData[i]
            if list then
                table.insert(sideList, list[1])
                table.insert(idList, list[2])
                table.insert(typeList, list[3])
            end
        end

        local num = 1
        for i, id in ipairs(idList) do
            local side = sideList[i]
            local type = typeList[i]
            local heroLogicId = fight.FightManager:toUniqueID(side, id)
            local heroData = fight.FightManager:getHeroCache(heroLogicId)
            if heroData then
                fight.FightManager:addTeamData(heroLogicId, heroData)

                local function _allHeroEnter()
                    if num >= #idList then
                        GameDispatcher:dispatchEvent(EventName.FIHGT_HERO_IN_SCENE, heroLogicId)
                        if finishCall then
                            finishCall()
                        end
                    else
                        num = num + 1
                    end
                end
                local function _enterHero()
                    local vo = monster.MonsterManager:getMonsterVo01(heroData.tid)
                    if vo.monType == monster.MonsterType.SUPER_BOSS then
                        fight.LivePerformManager:playEnter(heroLogicId, type, _allHeroEnter)
                    else
                        fight.FightLoader:loadEnterSceneList({ heroLogicId }, _allHeroEnter)
                    end
                end
                fight.SceneManager:removeSideThing(heroData.__side, true)
                fight.FightLoader:loadHeroLive(heroData.__side, heroData, false, _enterHero)
            end
        end

        isImmedCall = false

    elseif eftType == fight.FightDef.BATTLE_TYPE_SKILL_NEED_CD then -- 技能冷却所需时间变化(值2:[技能ID, 新冷却所需回合数])
        local skillTmpVo = fight.FightManager:getHeroSkill(targetLiveID, effectInfo.count_list[1])
        if skillTmpVo then
            skillTmpVo:setNewCdRound(effectInfo.count_list[2])
            GameDispatcher:dispatchEvent(EventName.FIGHT_HERO_ATTR_UPDATE, targetLiveID)
        end
    elseif eftType == fight.FightDef.BATTLE_TYPE_FORCES_SKILL_ENERGY then --52). % 盟约技能能量更新(最新值)
        -- 删除指挥官技能
        fight.FightManager:setForcesSkillEnergy(effectInfo.count_list[1])
    elseif eftType == fight.FightDef.BATTLE_TYPE_CHANGE_MAX_RAGE then --53). % 怒气上限修改(值)
        if targetLiveVo then
            -- print("==================BATTLE_TYPE_CHANGE_MAX_RAGE", eftVal)
            fight.FightManager:setMaxRage(targetLiveID, eftVal)
            targetLiveVo:setAtt(AttConst.MP_MAX, fight.FightManager:getMaxRage(targetLiveID))
        end
    elseif eftType == fight.FightDef.BATTLE_TYPE_QTE_COUNT then --54). % 格挡次数
        fight.FightManager:setQteSucCount(eftVal)
    elseif eftType == fight.FightDef.BATTLE_TYPE_BUFF_LAYERS_COUNTS then --55). % buff层数
        GameDispatcher:dispatchEvent(EventName.UPDATE_FIGHT_BUFF_LAYOUT_COUNT, eftVal)
    elseif eftType == fight.FightDef.BATTLE_TYPE_HERO_OUT then --% boss离场
        -- print("====================BATTLE_TYPE_HERO_OUT")
        local function leaveCall()
            fight.SceneManager:removeThing(targetLiveID)
            if finishCall then
                finishCall()
            end
        end
        fight.LivePerformManager:playLeave(targetLiveID, leaveCall)

        isImmedCall = false

    elseif eftType == fight.FightDef.BATTLE_TYPE_CURL_ORDER_DEL then
        fight.FightManager:updateCurRoleList(2, targetLiveID)
        GameDispatcher:dispatchEvent(EventName.LIEN_UP_LIST_UPDATE)
    elseif eftType == fight.FightDef.BATTLE_TYPE_NEXT_ORDER_DEL then
        fight.FightManager:updateNextRoleList(2, targetLiveID)
        GameDispatcher:dispatchEvent(EventName.LIEN_UP_LIST_UPDATE)
    elseif eftType == fight.FightDef.BATTLE_TYPE_HURT_ON_SHIELD then
        self:seeFly(actionID, targetLiveID, eftType, eftVal)
    elseif eftType == fight.FightDef.BATTLE_TYPE_PASSIVE_SKILL then
        -- print("===================BATTLE_TYPE_PASSIVE_SKILL 被动技能效果表现", eftVal)
        --64).  % 被动技能效果表现
        fight.PassiveSkillManager:playPassiveSkillShow(eftVal, targetLiveID, finishCall)
        isImmedCall = false
    elseif eftType == fight.FightDef.BATTLE_TYPE_CHANGE_STAGE then
        -- print("===============BATTLE_TYPE_CHANGE_STAGE 变身")
        local function changeCall()
            if finishCall then
                finishCall()
            end
        end
        fight.LivePerformManager:playChange(targetLiveID, effectInfo.count_list[1], changeCall)
        isImmedCall = false
    elseif eftType == fight.FightDef.BATTLE_TYPE_HIT_STUN then
        -- print("===============BATTLE_TYPE_HIT_STUN")
        -- 硬直更新
        if targetLiveVo then
            -- local curVal = targetLiveVo:getAtt(AttConst.STUN)
            if effectInfo.count_list[1] == 0 then
                -- effectInfo.count_list[1] == 0 硬直正常状态
                targetLiveVo:setAtt(AttConst.STUN, eftVal, true)
                targetLiveVo:setAtt(AttConst.STUN_RESUME, 0, true)
            else
                -- effectInfo.count_list[1] == 1 硬直扣完进入恢复期
                targetLiveVo:setAtt(AttConst.STUN, 0, true)
                targetLiveVo:setAtt(AttConst.STUN_RESUME, eftVal, true)
            end
            -- self:seeFly(actionID, targetLiveID, eftType, eftVal)
            GameDispatcher:dispatchEvent(EventName.FIGHT_HERO_ATTR_UPDATE, targetLiveID)
        end
    elseif eftType == fight.FightDef.BATTLE_TYPE_MAX_HIT_STUN then
        -- print("===============BATTLE_TYPE_MAX_HIT_STUN")
        -- 硬直更新
        if targetLiveVo then
            -- local curVal = targetLiveVo:getAtt(AttConst.STUN)
            targetLiveVo:setAtt(AttConst.STUN_MAX, eftVal, true)
            GameDispatcher:dispatchEvent(EventName.FIGHT_HERO_ATTR_UPDATE, targetLiveID)
        end
    elseif eftType == fight.FightDef.BATTLE_TYPE_CHANGE_MON_DISPLAY then
        -- print("====================BATTLE_TYPE_CHANGE_MON_DISPLAY")
        if targetLiveVo then
            if effectInfo.count_list[1] == 1 then
                -- 进入枯萎状态
                -- print("====================BATTLE_TYPE_CHANGE_MON_DISPLAY 1 进入枯萎状态")
                targetLiveVo:setOtherAniClipBind(fight.FightDef.ACT_DIZZY, fight.FightDef.ACTION_NAMEs[fight.FightDef.ACT_STAND])
            elseif effectInfo.count_list[1] == 2 then
                -- 退出枯萎状态
                -- print("====================BATTLE_TYPE_CHANGE_MON_DISPLAY 2 退出枯萎状态")
                targetLiveVo:setOtherAniClipBind(fight.FightDef.ACT_STAND, fight.FightDef.ACTION_NAMEs[fight.FightDef.ACT_STAND])
            elseif effectInfo.count_list[1] == 3 then
                -- 进入狂暴状态
                -- print("====================BATTLE_TYPE_CHANGE_MON_DISPLAY 3 进入狂暴状态")
                targetLiveVo:setOtherAniClipBind(fight.FightDef.ACT_BERSERK, fight.FightDef.ACTION_NAMEs[fight.FightDef.ACT_STAND])
            elseif effectInfo.count_list[1] == 4 then
                -- 退出狂暴状态
                -- print("====================BATTLE_TYPE_CHANGE_MON_DISPLAY 4 退出狂暴状态")
                targetLiveVo:setOtherAniClipBind(fight.FightDef.ACT_STAND, fight.FightDef.ACTION_NAMEs[fight.FightDef.ACT_STAND])
            end
        end
    elseif eftType == fight.FightDef.BATTLE_TYPE_BOSS_STATE_SHOW_VALUE then
        -- print("====================BATTLE_TYPE_BOSS_STATE_SHOW_VALUE")
        if targetLiveVo then
            targetLiveVo:setAtt(AttConst.BERSERK_NUM, eftVal, true)
            GameDispatcher:dispatchEvent(EventName.FIGHT_HERO_ATTR_UPDATE, targetLiveID)
        end
    elseif eftType == fight.FightDef.BATTLE_TYPE_BOSS_SUFFER_DAMAGE then
        GameDispatcher:dispatchEvent(EventName.FIGHT_GUILDBOSS_DAMAGE_UPDATE, eftVal)
    elseif eftType == fight.FightDef.BATTLE_TYPE_ADD_SCENE_SHIELD then
        -- print("====================BATTLE_TYPE_ADD_SCENE_SHIELD")
        self:seeFly(actionID, targetLiveID, eftType, eftVal)
    elseif eftType == fight.FightDef.BATTLE_TYPE_HURT_ON_SCENE_SHIELD then
        -- print("====================BATTLE_TYPE_HURT_ON_SCENE_SHIELD")
        self:seeFly(actionID, targetLiveID, eftType, eftVal)
    elseif eftType == fight.FightDef.BATTLE_TYPE_SHANDIE_ELE_CAMERA then
        -- print("====================BATTLE_TYPE_SHANDIE_ELE_CAMERA")
        local liveId = fight.FightManager:toUniqueID(effectInfo.count_list[1], effectInfo.count_list[2])
        local liveVo = fight.SceneManager:getThing(liveId)
        local cameraPos
        if liveVo:isAttacker() == 1 then
            cameraPos, _ = fight.SceneGrid:getACenter()
        else
            cameraPos, _ = fight.SceneGrid:getDCenter()
        end
        fight.FightCamera:moveScFilpTrans(true, cameraPos, 10, liveVo.position.z, liveVo.position.z, 0)
        fight.LivePerformManager:playSoundEff(liveId, "4522/sfx_role_4522_tianfu_buff_02_jing.prefab")

        -- fight.FightCamera:focusAttacker(liveVo)
        LoopManager:setTimeout(1.5, self, function()
            if finishCall then
                finishCall()
            end
        end)
        isImmedCall = false
    end

    -- 优先级效果直接回调，需要等待的参考isImmedCall用法
    if isImmedCall and finishCall then
        finishCall()
    end
end

function toCure(self, senderLiveID, targetLiveID, cureVal)
    local targetLiveVo = fight.SceneManager:getThing(targetLiveID)
    if targetLiveVo then
        -- print("toCure===",targetLiveID, cureVal, "==>", targetLiveVo:getAtt(AttConst.HP)+cureVal )
        local resVal = targetLiveVo:getAtt(AttConst.HP) + cureVal
        if resVal > targetLiveVo:getAtt(AttConst.HP_MAX) then
            resVal = targetLiveVo:getAtt(AttConst.HP_MAX)
        end
        targetLiveVo:setAtt(AttConst.HP, resVal, true)
        GameDispatcher:dispatchEvent(EventName.FIGHT_HERO_ATTR_UPDATE, targetLiveID)
    end

    fight.SceneItemManager:updateLiveHead(targetLiveID)
end

function toDamage(self, senderLiveID, targetLiveID, damageVal)
    local targetLiveVo = fight.SceneManager:getThing(targetLiveID)
    if targetLiveVo then
        -- print("toDamage===",targetLiveID, damageVal, "==>", targetLiveVo:getAtt(AttConst.HP)-damageVal)
        -- print("toDamage",targetLiveID, targetLiveVo:getAtt(AttConst.HP), damageVal, targetLiveVo:getAtt(AttConst.HP)-damageVal)
        targetLiveVo:setAtt(AttConst.HP, (targetLiveVo:getAtt(AttConst.HP) - damageVal) or 0, true)
        GameDispatcher:dispatchEvent(EventName.FIGHT_HERO_ATTR_UPDATE, targetLiveID)
    end
    -- if (not senderLiveID or not targetLiveID) then
    --     Debug:log_error("BattlePriorityVo", "伤害ID不正常")
    --     return
    -- end

    -- local calVoList = {}
    -- local calVo = fight.CalculatorAttVo.new()
    -- calVo.id = targetLiveID
    -- calVo.type = AttConst.HP
    -- calVo.value = damageVal
    -- calVo.triggerId = senderLiveID
    -- -- 减值
    -- calVo.change = 1
    -- table.insert(calVoList, calVo)
    -- GameDispatcher:dispatchEvent(EventName.FIGTH_UPDATE_ATT, calVoList)

    fight.SceneItemManager:updateLiveHead(targetLiveID)
end

function seeFly(self, cusActionId, cusId, cusFlyType, cusValue, effectList)
    if self.m_flyTextEnable ~= true then return end
    -- print("seeFly", cusValue)
    -- local flyObj = {}
    -- flyObj.id = cusId
    -- flyObj.type = cusFlyType
    -- flyObj.value = cusValue
    -- GameDispatcher:dispatchEvent(EventName.FIGHT_REQUEST_FLY, flyObj)
    -- 隐藏飘字
    if StorageUtil:getBool1(gstor.FIGHT_SHOW_DAMAGE) == true then return end

    local targetLive = fight.SceneItemManager:getLivething(cusId)
    if not targetLive then return end
    local targetLiveVo = targetLive:getLiveVo()
    local pos = targetLive:getPointPos(fight.FightDef.POINT_SPINE)
    if not pos then
        pos = targetLiveVo:getCurPos()
    end
    -- if cusValue == 0 then
    --     local isFlyed = false
    --     local dict = fight.FightManager:getPriorityDict(cusActionId, cusId)
    --     if not table.empty(dict) then
    --         for _, pVoList in pairs(dict) do
    --             if not table.empty(pVoList) then
    --                 for _, pVo in pairs(pVoList) do
    --                     -- print("pVo==>",pVo.type,pVo.count)
    --                     if pVo:getType() == fight.FightDef.BATTLE_TYPE_BUFF_TRIGGER then
    --                         local buffRo = Buff.BuffRoMgr:getBuffRo(pVo:getValue())
    --                         if buffRo and not table.empty(buffRo:getZeroIcon()) then
    --                             isFlyed = true
    --                             for _, v in ipairs(buffRo:getZeroIcon()) do
    --                                 fightUI.FightFlyUtil:fly3DImg3(cusId, UrlManager:getFightArtfontPath(v), pos, targetLiveVo:isAttacker() == 1)
    --                             end
    --                         end
    --                     end
    --                 end
    --             end
    --             if isFlyed == true then return end
    --         end
    --     end
    -- end

    if cusFlyType == fight.FightDef.BATTLE_TYPE_ELE_DAMAGE then
        fightUI.FightFlyUtil:flyElement(cusId, cusFlyType, cusValue, pos, effectList)
    else
        fightUI.FightFlyUtil:fly3D03(cusId, cusFlyType, cusValue, pos)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]