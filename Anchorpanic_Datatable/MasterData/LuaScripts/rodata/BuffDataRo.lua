module("BuffDataRo", Class.impl())

function parseData(self, refID, refData)
    self.m_refID = refID

    self.m_eleUiEffect = refData.ele_ui_effect
    self.m_eleUiIcon = refData.ele_ui_icon
    self.m_round = refData.round
    self.m_hangHead = refData.hang_head
    self.m_castType = refData.cast_type
    self.m_isEffectInc = refData.is_effect_inc
    self.m_isShow = refData.is_show
    self.m_zeroIcon = refData.zero_icon
    self.m_icon = refData.icon
    self.m_rate = refData.rate
    self.m_damageType = refData.damage_type
    self.m_hangBody = refData.hang_body
    self.m_hangWeapon = refData.hang_weapon
    self.m_spIcon = refData.sp_icon
    self.m_settle = refData.settle
    self.m_desc = refData.desc
    self.m_hangStand = refData.hang_stand
    self.m_value = refData.value
    self.m_type = refData.type
    self.m_fid = refData.fid
    self.m_name = refData.name
    self.m_maxOverlying = refData.max_overlying
    self.m_buff_show = refData.buff_show
    self.m_effect_coexist = refData.effect_coexist
    self.m_model_state = refData.model_state
    self.m_fly_text = refData.fly_text
    self.m_hang_stand_model = refData.hang_stand_model
    self.m_hang_body_model = refData.hang_body_model
    self.m_hang_head_model = refData.hang_head_model
    self.m_hang_weapon_model = refData.hang_weapon_model
    self.m_hang_camera = refData.hang_camera
end

-- 模型状态表现，0无 1冰冻效果，2金属封印
function getModelState(self)
    return self.m_model_state
end

-- 允许特效共存
function getEffectCoexist(self)
    return self.m_effect_coexist == 1
end

function getBuff_show(self)
    return self.m_buff_show == 1
end

function getRefID(self)
    return self.m_refID
end

function getEleUiEffect(self)
    return self.m_eleUiEffect
end

function getEleUiIcon(self)
    return self.m_eleUiIcon
end

function getRound(self)
    return self.m_round
end

function getHangHead(self, modelId)
    for i, effStr in ipairs(self.m_hang_head_model) do
        local arr = string.split(effStr, "|")

        if modelId and arr[1] == modelId then
            local list = {}
            for i = 2, #arr do
                table.insert(list, arr[i])
            end
            return list
        end
    end
    return self.m_hangHead
end

function getCastType(self)
    return self.m_castType
end

function getIsEffectInc(self)
    return self.m_isEffectInc
end

function getIsShow(self)
    return self.m_isShow
end

function getZeroIcon(self)
    return self.m_zeroIcon
end

function getIcon(self)
    return self.m_icon
end

function getRate(self)
    return self.m_rate
end

function getDamageType(self)
    return self.m_damageType
end

function getHangBody(self, modelId)
    for i, effStr in ipairs(self.m_hang_body_model) do
        local arr = string.split(effStr, "|")

        if modelId and arr[1] == modelId then
            local list = {}
            for i = 2, #arr do
                table.insert(list, arr[i])
            end
            return list
        end
    end
    return self.m_hangBody
end

function getHangWeapon(self, modelId)
    for i, effStr in ipairs(self.m_hang_weapon_model) do
        local arr = string.split(effStr, "|")

        if modelId and arr[1] == modelId then
            local list = {}
            for i = 2, #arr do
                table.insert(list, arr[i])
            end
            return list
        end
    end
    return self.m_hangWeapon
end

function getSpIcon(self)
    return self.m_spIcon
end

function getSettle(self)
    return self.m_settle
end

function getDesc(self)
    return self.m_desc
end

function getHangStand(self, modelId)
    for i, effStr in ipairs(self.m_hang_stand_model) do
        local arr = string.split(effStr, "|")

        if modelId and arr[1] == modelId then
            local list = {}
            for i = 2, #arr do
                table.insert(list, arr[i])
            end
            return list
        end
    end
    return self.m_hangStand
end

function getValue(self)
    return self.m_value
end

function getType(self)
    return self.m_type
end

function getFid(self)
    return self.m_fid
end

function getName(self)
    return self.m_name
end

function getMaxOverlying(self)
    return self.m_maxOverlying
end

function getFlyText(self)
    return self.m_fly_text
end

function getHangCamera(self, modelId)
    for i, effStr in ipairs(self.m_hang_camera) do
        local arr = string.split(effStr, "|")

        if modelId and arr[1] == modelId then
            local list = {}
            for i = 2, #arr do
                table.insert(list, arr[i])
            end
            return list
        end
    end
    return {}
end

return _M