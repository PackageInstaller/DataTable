--
-- Author:luqucheng
-- Date: 2019-11-13 17:01:58
--
local BuffEffect = import("Game.Battle.Core.BuffEffect")

local BuffEffectFactory = {}

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function BuffEffectFactory:GetBuffEffect( buff, buffEffectData, effectParams )
    --获取buff的脚本
    local bt = Constants.BuffType
    local switch = {
        [bt.AttributeChange] = function ()
            return import('Game.Battle.Script.BuffEffect.AttributeChange')
        end,
        [bt.Dot] = function ()
            return import('Game.Battle.Script.BuffEffect.Dot')
        end,
        [bt.Hot] = function ()
            return import('Game.Battle.Script.BuffEffect.Hot')
        end,
        [bt.Shield] = function ()
            return import('Game.Battle.Script.BuffEffect.Shield')
        end,
        [bt.DamageChange] = function ()
            return import('Game.Battle.Script.BuffEffect.DamageChange')
        end,
        [bt.HealChange] = function ()
            return import('Game.Battle.Script.BuffEffect.HealChange')
        end,
        [bt.Resist] = function (  )
            return import('Game.Battle.Script.BuffEffect.Resist')
        end,
        [bt.ScreenBuff] = function (  )
            return import('Game.Battle.Script.BuffEffect.ScreenBuff')
        end,
        
        [bt.Special] = function ( subType )
            local st = Constants.SpecialBuffType
            local sw = {
                [st.WeakExpose] = function (  )
                    return import('Game.Battle.Script.BuffEffect.WeakExpose')
                end,
                [st.Weak] = function (  )
                    return import('Game.Battle.Script.BuffEffect.Weak')
                end,
                [st.SpTypeChange] = function (  )
                    return import('Game.Battle.Script.BuffEffect.SPTypeChange')
                end,
                [st.SkillCardCantGetSp] = function (  )
                    return import('Game.Battle.Script.BuffEffect.SkillCardCantGetSp')
                end,
                [st.ChangePushCardProb] = function (  )
                    return import('Game.Battle.Script.BuffEffect.ChangePushCardProb')
                end,
                [st.MarkForSkillTag] = function (  )
                    return import('Game.Battle.Script.BuffEffect.MarkForSkillTag')
                end,
                [st.LockAttrNum] = function (  )
                    return import('Game.Battle.Script.BuffEffect.LockAttrNum')
                end,
            }
            local f = sw[subType] 
            return f and f() or BuffEffect
        end,
    }
    local func = switch[buffEffectData.mainEffectType]
    local C = func and func(buffEffectData.subEffectType) or BuffEffect

    local buffEffect = C.New(buff, buffEffectData, effectParams)

    return buffEffect
end

return  BuffEffectFactory