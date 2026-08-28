--[[
    author:luqucheng
    time:2020-12-21 14:57:37
]]

local ComboTargetSelect = {}

function ComboTargetSelect:GetScript( type )
    if Tools.isNullKey(type) then
        return self.DefaultFunc
    end
    local func = self['SelectFunc' .. type]
    assert(func, "找不到对应的连击目标选择脚本, 脚本id:" .. type)

    return func
end

function ComboTargetSelect.DefaultFunc( hitIndex, skillRec, lastReturnParams )
    return {
        targets = skillRec.mainTargets,
        ratio = 1,
        returnParams = lastReturnParams
    }
end

--1 主效果筛选目标后，每段hit从中随机选取1个  （伤害衰减）
function ComboTargetSelect.SelectFunc1( hitIndex, skillRec, lastReturnParams )
    local dualChange = skillRec.skill.comboTargetSelectParams[1] or 1
    local damageReduce = skillRec.skill.comboTargetSelectParams[2] or 0
    local rs = {}
    local mainTargets = skillRec.mainTargets
    for i,v in ipairs(mainTargets) do
        if v:CanBeSelected() then
            table.insert(rs, v)
        end
    end

    if #rs <= 0 then
        --没有任何可选择目标
        return {
            targets = {},
            ratio = 1,
            returnParams = lastReturnParams
        }
    end

    --完全随机，后面可能会加优先选择没有命中过的
    local index = Core.Random(#rs, 1)

    --@RefType [Lua.Game.Battle.Entity.Role#Role]
    local role = rs[index]

    if not lastReturnParams then
        lastReturnParams = {}
    end

    if not lastReturnParams[role.id] then
        lastReturnParams[role.id] = 0
    end
    lastReturnParams[role.id] = lastReturnParams[role.id] + 1
    
    --查看这个角色之前的命中系数，需要做衰减
    local ratio = 1
    ratio = math.max(1 - (lastReturnParams[role.id] - 1) * damageReduce, 0) * (lastReturnParams[role.id] > 1 and dualChange or 1)

    return {
        targets = {role},
        ratio = ratio,
        returnParams = lastReturnParams
    }
end

--2 每段攻击点选目标，如果点选目标死亡，则按照主效果规则重新选取 （伤害按照转移次数提升）
function ComboTargetSelect.SelectFunc2( hitIndex, skillRec, lastReturnParams )
    if not lastReturnParams then
        lastReturnParams = {}
    end
    --@RefType [Lua.Game.Battle.Entity.Role#Role]
    local role = lastReturnParams.nowTarget or skillRec.mainTarget
    if role and not role:IsDead() then
        lastReturnParams.nowTarget = role
        return {
            targets = {role},
            ratio = 1,
            returnParams = lastReturnParams
        }
    end

    --转换目标
    --根据主效果的条件寻找目标
    --@RefType [Lua.Game.Battle.Core.Skill#Skill]
    local targets = Core:SelectTargets(skillRec.skill.damageTarget, skillRec.attacker, skillRec.mainTarget)
    if #targets <= 0 then
        return {
            targets = {},
            ratio = 1,
            returnParams = lastReturnParams
        }
    end

    role = targets[1]
    lastReturnParams.nowTarget = role

    if not lastReturnParams.changeCount then
        lastReturnParams.changeCount = 0
    end
    lastReturnParams.changeCount = lastReturnParams.changeCount + 1

    --转换之后的伤害变化
    local params = skillRec.skill.comboTargetSelectParams
    local p1 = params[1] or 1
    local p2 = params[2] or 0
    
    local ratio = p1 * (1 + lastReturnParams.changeCount * p2)

    return {
        targets = {role},
        ratio = ratio,
        returnParams = lastReturnParams
    }
end

--3 先打一下主效果选择的单体目标，之后随机选取其他目标(使用这个脚本的时候，主效果的目标选择必须是单体)
function ComboTargetSelect.SelectFunc3( hitIndex, skillRec, lastReturnParams )
    local dualChange = skillRec.skill.comboTargetSelectParams[1] or 1
    local damageReduce = skillRec.skill.comboTargetSelectParams[2] or 0
    local damageReduceMin = skillRec.skill.comboTargetSelectParams[3] or 0

    local rs = {}
    local mainTarget = skillRec.mainTargets[1]

    if mainTarget == nil then
        --没有任何可选择目标
        return {
            targets = {},
            ratio = 1,
            returnParams = lastReturnParams
        }
    end

    local role = nil
    if not lastReturnParams then
        -- 第一下hit打主目标
        role = mainTarget
    else
        -- 之后的hit随机选取
        local mainTargets = BattleMgr:GetAliveRoles(mainTarget.camp)
        for i,v in ipairs(mainTargets) do
            if v:CanBeSelected() then
                table.insert(rs, v)
            end
        end

        --完全随机，后面可能会加优先选择没有命中过的
        local index = Core.Random(#rs, 1)

        --@RefType [Lua.Game.Battle.Entity.Role#Role]
        role = rs[index]
    end    

    if role == nil then
        --没有任何可选择目标
        return {
            targets = {},
            ratio = 1,
            returnParams = lastReturnParams
        }
    end

    if not lastReturnParams then
        lastReturnParams = {}
    end

    if not lastReturnParams[role.id] then
        lastReturnParams[role.id] = 0
    end
    lastReturnParams[role.id] = lastReturnParams[role.id] + 1
    
    --查看这个角色之前的命中系数，需要做衰减
    local ratio = 1
    ratio = math.max(1 - (lastReturnParams[role.id] - 1) * damageReduce, damageReduceMin) * (lastReturnParams[role.id] > 1 and dualChange or 1)

    return {
        targets = {role},
        ratio = ratio,
        returnParams = lastReturnParams
    }
end


--4 先打一下主效果选择的单体目标，之后随机选取其他目标(使用这个脚本的时候，主效果的目标选择必须是单体)
function ComboTargetSelect.SelectFunc4( hitIndex, skillRec, lastReturnParams )
    local dualChange = skillRec.skill.comboTargetSelectParams[1] or 1
    local damageIncreas = skillRec.skill.comboTargetSelectParams[2] or 0
    local damageIncreasMax = skillRec.skill.comboTargetSelectParams[3] or 0

    local rs = {}
    local mainTarget = skillRec.mainTargets[1]

    if mainTarget == nil then
        --没有任何可选择目标
        return {
            targets = {},
            ratio = 1,
            returnParams = lastReturnParams
        }
    end

    local role = nil
    if not lastReturnParams then
        -- 第一下hit打主目标
        role = mainTarget
    else
        -- 之后的hit随机选取
        local mainTargets = BattleMgr:GetAliveRoles(mainTarget.camp)
        for i,v in ipairs(mainTargets) do
            if v:CanBeSelected() then
                table.insert(rs, v)
            end
        end

        --完全随机，后面可能会加优先选择没有命中过的
        local index = Core.Random(#rs, 1)

        --@RefType [Lua.Game.Battle.Entity.Role#Role]
        role = rs[index]
    end    

    if role == nil then
        --没有任何可选择目标
        return {
            targets = {},
            ratio = 1,
            returnParams = lastReturnParams
        }
    end

    if not lastReturnParams then
        lastReturnParams = {}
    end

    if not lastReturnParams[role.id] then
        lastReturnParams[role.id] = 0
    end
    lastReturnParams[role.id] = lastReturnParams[role.id] + 1
    
    --查看这个角色之前的命中系数，需要做增伤
    local ratio = 1
    ratio = math.min(1 + (lastReturnParams[role.id] - 1) * damageIncreas, damageIncreasMax) * (lastReturnParams[role.id] > 1 and dualChange or 1)

    return {
        targets = {role},
        ratio = ratio,
        returnParams = lastReturnParams
    }
end

return ComboTargetSelect