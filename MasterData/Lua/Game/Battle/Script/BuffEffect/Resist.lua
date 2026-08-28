--
-- Author:luqucheng
-- Date: 2019-11-16 10:28:53
--
local BuffEffect = import('Game.Battle.Core.BuffEffect')
local Resist = Class("Resist", BuffEffect)

function Resist:IsResist( effectData, effectType )
    local ResistType = Constants.ResistType
    local data = self.data
    local owner = self.buff.owner
    local attacker = self.buff.attacker
    local checkEffectType = data.effectNum1[5]

    if effectType ~= checkEffectType then
        return false
    end

    local switch = {
        [ResistType.ById] = function (  )
            --根据id来判断是否需要抵抗
            return effectData.id == data.effectNum1[1]
        end,
        [ResistType.ByType] = function (  )
            local buffType = data.effectNum1[1]
            local main = data.effectNum1[2]
            local sub = data.effectNum1[3]
            local mini = data.effectNum1[4]

            -- print(table.toString(data.effectNum1, "effectNum1"), table.toString(effectData, "effectData"), effectData.buffType, effectData.mainEffectType, effectData.subEffectType, effectData.miniEffectType)

            if checkEffectType == Constants.EffectType.Buff then
                local buffTypeOk = buffType == 0 or buffType == effectData.buffType
                if not buffTypeOk then
                    return false
                end
            end
           
            if main == 0 then
                return true
            end

            if main ~= effectData.mainEffectType then
                return false
            end

            if sub == 0 then
                return true
            end

            if sub ~= effectData.subEffectType then
                return false
            end

            if mini == 0 then
                return true
            end

            if mini ~= effectData.miniEffectType then
                return false
            end

            return true
        end
    }
    local func = switch[self.data.subEffectType]
    assert(func, '找不到对应的免疫类型 '.. self.data.subEffectType)
    return func()
end

return  Resist