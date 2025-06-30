module("fight.BattlePriorityVo", Class.impl())

function ctor(self)
    self.m_effectInfo = nil
    self.m_targetLiveID = 0
end

function setData(self, effectInfo)
    self.m_effectInfo = effectInfo
    --     pt_battle_effect_info =
    -- {    
    --     {"type", "int8", "效果类型 1-伤害 2-加buff 3-治疗"}, 
    --     {"priority", "int8", "优先级"}, 
    --     {"count", "int32", "效果值"}, 
    --     {"count_list", "int32", "额外效果值", "repeated"},
    -- }
end

function getActionID(self)
    if self.m_effectInfo then
        return self.m_effectInfo.actionID
    end
end

function getType(self)
    if self.m_effectInfo then
        return self.m_effectInfo.type
    end
end

function getValue(self)
    if self.m_effectInfo then
        return self.m_effectInfo.count
    end
end

function setTargetLiveID(self, liveID)
    self.m_targetLiveID = liveID
end

function getTargetLiveID(self)
    return self.m_targetLiveID
end

function action(self, senderLiveID, targetLiveID, hitData, skillRo, finishCall)
    if hitData and fight.FightDef.DAMAGE_HIT_ACTION_SET[self.m_effectInfo.type] then
        local targetLiveVo = fight.SceneManager:getThing(targetLiveID)
        local senderLiveVo = fight.SceneManager:getThing(senderLiveID)
        if targetLiveVo and senderLiveVo then
            self:_hitTarget(senderLiveVo, targetLiveVo, hitData, skillRo)
        end
    end

    if fight.FightDef.FLY_TEXT_ACTION_SET[self.m_effectInfo.type] and not ABBlock.ABBlockMgr.noTargetHit then
        fight.FightEffectHandle:setFlyTextEnable(true)
    else
        fight.FightEffectHandle:setFlyTextEnable(false)
    end
    fight.FightEffectHandle:action(self.m_effectInfo, senderLiveID, targetLiveID, finishCall)
end

-- 受击表现
function _hitTarget(self, senderLiveVo, targetVo, hitData, skillRo)
    if skillRo then
        local tid = senderLiveVo:getTID()
        guide.GuideCondition:condition20(tid, skillRo:getRefID())
        guide.GuideCondition:condition21(tid, skillRo:getRefID())
    end

    local tmpSkip = false
    if fight.FightManager.m_gmOpenAudio == true then
        tmpSkip = true
    end

    if tmpSkip == false and not fight.FightAction:isLiveVoActiving(targetVo) and not ABBlock.ABBlockMgr.noTargetHit then
        -- 受击动作
        if hitData.hitActHash == fight.FightDef.ACT_DIE then
            targetVo:updateAni(hitData.hitActHash)
            targetVo:setAnimationBoolVal(fight.FightDef.ANI_BOOL_TO_GETUP, true)
        else
            targetVo:updateAni(hitData.hitActHash)
        end
    end

    -- 普通攻击才追加受击音效 --更改做法了，受击和攻击做一起了，材质直接区分
    -- if skillRo and skillRo:getType() == 0 then
    --     -- 受击音效
    --     local voiceType = 1
    --     local hitType = fight.FightDef.HITTYPE_REVERSE[hitData.hitActHash] or 1

    --     local orgData = targetVo:getOrgData()
    --     if orgData then
    --         voiceType = orgData.stagger_voice
    --     end
    --     local curLiveVo = senderLiveVo:getCurDisplayLiveVo()

    --     local modelID = curLiveVo:getModelID()
    --     local soundRo = fight.FightLoader:getSoundRo(modelID)
    --     if soundRo then
    --         local audioUrl = nil
    --         local lst = nil
    --         if voiceType == 1 then
    --             lst = soundRo:getFlesh()
    --             audioUrl = lst[hitType]
    --         elseif voiceType == 2 then
    --             lst = soundRo:getMetal()
    --             audioUrl = lst[hitType]
    --         else
    --             lst = soundRo:getFmType()
    --             audioUrl = lst[hitType]
    --         end
    --         if audioUrl then
    --             AudioManager:playFightSoundEffect(UrlManager:getFightSoundPath(modelID .. "/" .. audioUrl), nil, nil, targetVo:getCurPos())
    --         end
    --     end
    -- end

    -- 受击特效
    if hitData.hitEft and #hitData.hitEft > 0 then
        local travel = STravelFactory:travel02(skillRo:getRefID(), 3, senderLiveVo.id, targetVo:getLiveID())
        travel:setPerfData(UrlManager:getEfxRolePath(hitData.hitEft), nil, 1)
        travel:setSimplePoint(1)
        travel:start()
    end
    -- 能源立场受击特效
    if fight.FightManager:getQteType() ~= fight.FightDef.BATTLE_QTE_NONE then
        ABBlock.ABBlockMgr:blockTargetHit(targetVo)
    end
    if senderLiveVo:isAttacker() == 1 and not StorageUtil:getBool1(gstor.FIGHT_HIDE_INFO) then
        GameDispatcher:dispatchEvent(EventName.FIGHT_ADD_HIT)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]