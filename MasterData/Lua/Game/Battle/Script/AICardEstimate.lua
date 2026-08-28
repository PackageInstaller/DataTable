--[[
    author:luqucheng
    time:2021-08-27 10:47:45
]]

local AICardEstimate = {}

--[[
    @desc: 
    author:{author}
    time:2021-08-27 15:19:10
    --@skillCardData: [Game.Setting.Vo.SkillCardVo#SkillCardVo]
	--@star:
	--@attacker:[Game.Battle.Entity.Role#Role]
	--@OtherParams: 
    @return:
]]
function AICardEstimate:Estimate(skillCardData, star, attacker, otherParams)
    local func = self["Func" .. skillCardData.usefulnessAI]

    if not func then
        return 1
    end
    if not otherParams then
        otherParams = {}
    end
    local isUltra = skillCardData:IsUltra()
    local starRatio = isUltra and Core:GetBattleParamNum("starRatioEffectSpAI", true)[1] or Core:GetBattleParamNum("starRatioEffectAI", true)[star]
    local roleRatio = Core:GetBattleParamNum("standardEffectAI")

    local score = func(self, skillCardData, star, attacker, skillCardData.usefulnessNumAI, otherParams) * starRatio / roleRatio

    return score
end

function AICardEstimate:Func101(skillCardData, star, attacker, params, otherParams)
    return params[1]
end

function AICardEstimate:Func102(skillCardData, star, attacker, params, otherParams)
    local rs = Core:GetCampTargets(attacker, BattleMgr.roles, skillCardData.clickType)
    local targetNumRatio = Core:GetBattleParamNum("targetNumRatio", true)[#rs]
    
    return targetNumRatio * params[1]
end

function AICardEstimate:Func201(skillCardData, star, attacker, params, otherParams)
    local layNum = attacker.buffMgr:GetBuffLayNumByBuffTypeID(params[3])

    return params[1] * (1 + layNum * params[2])
end

function AICardEstimate:Func202(skillCardData, star, attacker, params, otherParams)
    local layNum = attacker.buffMgr:GetBuffLayNumByBuffTypeID(params[3])
    local rs = Core:GetCampTargets(attacker, BattleMgr.roles, Constants.TargetCamp.Enemy)
    local targetNumRatio = Core:GetBattleParamNum("targetNumRatio", true)[#rs]

    return params[1] * (1 + layNum * params[2]) * targetNumRatio
end

function AICardEstimate:Func203(skillCardData, star, attacker, params, otherParams)
    local layNum = attacker.buffMgr:GetBuffLayNumByBuffTypeID(params[3])
    local rs = Core:GetCampTargets(attacker, BattleMgr.roles, Constants.TargetCamp.Friend)
    local targetNumRatio = Core:GetBattleParamNum("targetNumRatio", true)[#rs]

    return params[1] * (1 + layNum * params[2]) * targetNumRatio
end

function AICardEstimate:Func301(skillCardData, star, attacker, params, otherParams)
    local rs = Core:GetCampTargets(attacker, BattleMgr.roles, Constants.TargetCamp.Enemy)

    local minHpPer = 2
    local minHpRole = nil
    for i,role in ipairs(rs) do
        local per = role:GetNowHPPercent()
        if per < minHpPer then
            minHpPer = per
            minHpRole = role
        end
    end

    if not minHpRole then
        return 0
    end
    local layNum = minHpRole.buffMgr:GetBuffLayNumByBuffTypeID(params[3])

    return params[1] * (1 + layNum * params[2])
end

function AICardEstimate:Func302(skillCardData, star, attacker, params, otherParams)
    local rs = Core:GetCampTargets(attacker, BattleMgr.roles, Constants.TargetCamp.Enemy)

    if #rs <= 0 then
        return 0
    end

    local totalLayNum = 0
    for i,role in ipairs(rs) do
        totalLayNum = totalLayNum + role.buffMgr:GetBuffLayNumByBuffTypeID(params[3])
    end

    local rs2 = Core:GetCampTargets(attacker, BattleMgr.roles, skillCardData.clickType)
    local targetNumRatio = Core:GetBattleParamNum("targetNumRatio", true)[#rs2]

    return params[1] * (1 + totalLayNum / #rs * params[2]) * targetNumRatio
end

function AICardEstimate:Func401(skillCardData, star, attacker, params, otherParams)

    return params[1] * (1 + (1 - attacker:GetNowHPPercent()) * params[2])
end

function AICardEstimate:Func402(skillCardData, star, attacker, params, otherParams)
    local rs = Core:GetCampTargets(attacker, BattleMgr.roles, Constants.TargetCamp.Enemy)
    local targetNumRatio = Core:GetBattleParamNum("targetNumRatio", true)[#rs]

    return params[1] * (1 + (1 - attacker:GetNowHPPercent()) * params[2]) * targetNumRatio
end

function AICardEstimate:Func403(skillCardData, star, attacker, params, otherParams)
    local rs = Core:GetCampTargets(attacker, BattleMgr.roles, Constants.TargetCamp.Friend)
    local targetNumRatio = Core:GetBattleParamNum("targetNumRatio", true)[#rs]

    return params[1] * (1 + (1 - attacker:GetNowHPPercent()) * params[2]) * targetNumRatio
end

function AICardEstimate:Func501(skillCardData, star, attacker, params, otherParams)
    local rs = Core:GetCampTargets(attacker, BattleMgr.roles, Constants.TargetCamp.Enemy)

    local minHpPer = 1
    for i,role in ipairs(rs) do
        local per = role:GetNowHPPercent()
        if per < minHpPer then
            minHpPer = per
        end
    end

    return params[1] * (1 + (1 - minHpPer) * params[2])
end

function AICardEstimate:Func502(skillCardData, star, attacker, params, otherParams)
    local rs = Core:GetCampTargets(attacker, BattleMgr.roles, Constants.TargetCamp.Enemy)
    local targetNumRatio = Core:GetBattleParamNum("targetNumRatio", true)[#rs]

    if #rs <= 0 then
        return 0
    end

    local totalLostPer = 0
    for i,role in ipairs(rs) do
        local per = role:GetNowHPPercent()
        totalLostPer = totalLostPer + (1 - per)
    end

    return params[1] * (1 + totalLostPer / #rs * params[2]) * targetNumRatio
end

function AICardEstimate:Func601(skillCardData, star, attacker, params, otherParams)
    local rs = Core:GetCampTargets(attacker, BattleMgr.roles, Constants.TargetCamp.Friend)

    local minHpPer = 1
    for i,role in ipairs(rs) do
        local per = role:GetNowHPPercent()
        if per < minHpPer then
            minHpPer = per
        end
    end

    return ((params[1] * (1 - minHpPer)) + params[2])
end

function AICardEstimate:Func602(skillCardData, star, attacker, params, otherParams)
    local rs = Core:GetCampTargets(attacker, BattleMgr.roles, Constants.TargetCamp.Friend)

    if #rs <= 0 then
        return 0
    end

    local totalHpPer = 0
    for i,role in ipairs(rs) do
        local per = role:GetNowHPPercent()
        totalHpPer  = totalHpPer + per
    end

    return ((params[1] * (1 - totalHpPer / #rs)) + params[2])
end

function AICardEstimate:Func701(skillCardData, star, attacker, params, otherParams)
    local rs = Core:GetCampTargets(attacker, BattleMgr.roles, Constants.TargetCamp.Friend)

    local maxAtk = -1
    local maxAtkRole = nil
    for i,role in ipairs(rs) do
        local atk = role:GetAttr(Constants.AttrTypeId.Attack)
        if atk > maxAtk then
            maxAtk = atk
            maxAtkRole = role
        end
    end

    if not maxAtkRole then
        return 0
    end
    local layNum = maxAtkRole.buffMgr:GetBuffLayNumByBuffTypeID(params[3])

    return params[1] * (1 + layNum * params[2])
end

function AICardEstimate:Func702(skillCardData, star, attacker, params, otherParams)
    local rs = Core:GetCampTargets(attacker, BattleMgr.roles, Constants.TargetCamp.Friend)

    if #rs <= 0 then
        return 0
    end

    local totalLayNum = 0
    for i,role in ipairs(rs) do
        totalLayNum = totalLayNum + role.buffMgr:GetBuffLayNumByBuffTypeID(params[3])
    end

    local rs2 = Core:GetCampTargets(attacker, BattleMgr.roles, skillCardData.clickType)
    local targetNumRatio = Core:GetBattleParamNum("targetNumRatio", true)[#rs2]

    return params[1] * (1 + totalLayNum / #rs * params[2]) * targetNumRatio
end

--- 检测友方身上减益效果
--- num1*(1+min(友方全体携带的可以被驱散的debuff总层数 , num2)*num3)*星级系数1
function AICardEstimate:Func801(skillCardData, star, attacker, params, otherParams)
    local rs = Core:GetCampTargets(attacker, BattleMgr.roles, Constants.TargetCamp.Friend)
    if #rs <= 0 then
        return 0
    end

    local count = 0
    for i,role in ipairs(rs) do
        local buffType = Constants.BuffOrDebuff.Debuff
        role.buffMgr:WalkAllBuff(function ( v )
            if v.data.buffType == buffType and v.data.isClear == 1 then
                count = count + v.layNum
            end
        end)
    end

    return params[1] * (1 + math.min(count, params[2]) * params[3])
end

function AICardEstimate:Func5001(skillCardData, star, attacker, params, otherParams)
    local rs = Core:GetCampTargets(attacker, BattleMgr.roles, Constants.TargetCamp.Enemy)

    if #rs <= 0 then
        return 0
    end

    local selfLostHpPer = 1 - attacker:GetNowHPPercent()

    local selfLayNum = 0
    if not Tools.isNullKey(params[4]) then
        selfLayNum = attacker.buffMgr:GetBuffLayNumByBuffTypeID(params[4])
    end

    local minHpPer = 2
    local minHpPerRole = 0
    for i,role in ipairs(rs) do
        local per = role:GetNowHPPercent()
        if per < minHpPer then
            minHpPer = per
            minHpPerRole = role
        end
    end

    local minLayNum = 0
    if not Tools.isNullKey(params[6]) and minHpPerRole then
        minLayNum = minHpPerRole.buffMgr:GetBuffLayNumByBuffTypeID(params[6])
    end


    return params[1] * (1 + selfLostHpPer * params[2])
        * (1 + minHpPer * params[3])
        * (1 + selfLayNum * params[5])
        * (1 + minLayNum * params[7]) 
end

function AICardEstimate:Func5002(skillCardData, star, attacker, params, otherParams)
    local rs = Core:GetCampTargets(attacker, BattleMgr.roles, Constants.TargetCamp.Enemy)
    local targetNumRatio = Core:GetBattleParamNum("targetNumRatio", true)[#rs]
    return self:Func5001(skillCardData, star, attacker, params, otherParams) * targetNumRatio
end

function AICardEstimate:Func5003(skillCardData, star, attacker, params, otherParams)
    local rs = Core:GetCampTargets(attacker, BattleMgr.roles, Constants.TargetCamp.Friend)
    local targetNumRatio = Core:GetBattleParamNum("targetNumRatio", true)[#rs]
    return self:Func5001(skillCardData, star, attacker, params, otherParams) * targetNumRatio
end

return AICardEstimate