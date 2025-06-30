module("StoryDataRo", Class.impl())

function parseData(self, refID, refData)
    self.m_refID = refID

    self.m_happenArg = refData.happen_arg
    self.m_isRepeat = refData.is_repeat
    self.m_canPass = refData.can_pass
    self.m_happenType = refData.happen_type
    self.m_talkGroupId = refData.talk_group_id

    self.m_talkGroup = {} -- = refData.talk_group
    self.m_battleType = refData.battle_type
    self.m_effectType = refData.effect_type
    self.m_effectParam = refData.effect_param
    self.m_battleFieldId = refData.battle_field_id
    self.m_synopsis = refData.synopsis
    self.m_line_id = refData.line_id

    -- 是否可以加速
    self.m_isSpeedUp = refData.is_speedup
end

function getRefID(self)
    return self.m_refID
end

function getLineID(self)
    return self.m_line_id
end

function getHappenArg(self)
    return self.m_happenArg
end

function getIsRepeat(self)
    return self.m_isRepeat
end

function getCanPass(self)
    return self.m_canPass
end

function getHappenType(self)
    return self.m_happenType
end

function getTalkGroup(self)
    if self.m_talkGroupId == 0 then
        return nil
    end
    self.isEditor = storyTalk.StoryTalkManager:getIsEditor()


    if self.m_talkGroupId == 0 then
        return nil
    end
    self.m_talkGroup = {}
    if #self.m_talkGroup == 0 or self.isEditor == true then
        local baseData = RefMgr:getData('storyData/story_data_' .. self.m_talkGroupId, self.isEditor)
        if baseData ~= nil then
            for k, v in pairs(baseData) do
                self.m_talkGroup[k] = v
            end
        else
            logError("剧情lua文件出错，请检查：" .. 'storyData/story_data_' .. self.m_talkGroupId)
        end
    end

    return self.m_talkGroup
end

function getBattleType(self)
    return self.m_battleType
end

function getEffectType(self)
    return self.m_effectType
end

function getEffectParam(self)
    return self.m_effectParam
end

function getBattleFieldId(self)
    return self.m_battleFieldId
end

function getSynopsis(self)
    return self.m_synopsis
end

function getCanSpeedUp(self)
    return self.m_isSpeedUp
end

return _M
