module("SkillDataRo", Class.impl())

function parseData(self, refID, refData)
    self.m_refID = refID

    self.m_isScene = refData.is_scene
    self.m_icon = refData.icon
    self.m_voice = refData.voice
    self.m_conditions = refData.conditions
    self.m_skillAttr = refData.skill_attr
    self.m_desc = refData.desc
    self.m_qteArg = refData.qte_arg
    self.m_animation = refData.animation
    self.m_name = refData.name
    self.m_roundCd = refData.round_cd
    self.m_roundLimit = refData.round_limit
    self.m_location = refData.location
    self.m_type = refData.type
    self.m_subType = refData.subtype
    self.m_effect = refData.effect
    self.m_cost = refData.cost
    self.m_skillTarget = refData.skill_target
    self.m_gain_type = refData.gain_type
    self.m_effect_type = refData.effect_type
    self.m_camera_type = refData.camera_type
    self.m_scope = refData.scope
    self.m_skill_locate = refData.skill_locate
    self.mDescTip = refData.desc_tips
    self.m_camera_focus = refData.camera_focus
    
end

function getGainType(self)
    return self.m_gain_type
end

function getRefID(self)
    return self.m_refID
end

function getSkillTarget(self)
    return self.m_skillTarget
end

function getIsScene(self)
    return self.m_isScene
end

function getIcon(self)
    return self.m_icon
end

function getVoice(self)
    return self.m_voice
end

function getConditions(self)
    return self.m_conditions
end

function getSkillAttr(self)
    return self.m_skillAttr
end

function getDesc(self)
    return self.m_desc
end

function getQteArg(self)
    return self.m_qteArg
end

function getAnimation(self)
    return self.m_animation
end

function getName(self)
    return self.m_name
end

function getRoundCd(self)
    return self.m_roundCd
end

function getRoundLimit(self)
    return self.m_roundLimit
end

function getLocation(self)
    return self.m_location
end

function getType(self)
    return self.m_type
end
function getSubType(self)
    return self.m_subType
end

function getEffect(self)
    return self.m_effect
end

function getCost(self)
    return self.m_cost
end

function getEffectType(self)
    return self.m_effect_type
end

function getCameraType(self)
    return self.m_camera_type
end

function getScope(self)
    return self.m_scope
end

function getSkillLocate(self)
    return self.m_skill_locate
end

function getDescTip(self)
    return self.mDescTip
end

-- 奥义镜头
function getCameraFocus(self)
    return self.m_camera_focus
end

return _M