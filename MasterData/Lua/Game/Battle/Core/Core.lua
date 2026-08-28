--
-- Author:luqucheng
-- Date: 2019-10-22 10:31:16
--

local ee = Constants.CardAttrType
local gameUtils = CS.GameUtils

---@class Core
local Core = {}
Core.initData = nil

Core.elementCounte = nil

Core.statusAbility = nil

Core.Random = nil
Core.pseudoRandomList = nil
Core.pseudoRandomBaseId = nil

Core.baseBuffID = nil
Core.baseSkillCardID = nil

Core.battleParam = nil

Core.effectDatas = nil--效果的缓存，防止多次gc
Core.skillDatas = nil
Core.triggerDatas = nil
Core.targetDatas = nil
Core.damageDatas = nil
Core.buffEffectDatas = nil
Core.buffDatas = nil
Core.battleParams = nil
Core.overwhelmRatio = nil

Core.damageScripts = {
    -- [1] = import('Game.Battle.Script.DamageEffect.DamageScript1')
}
Core.damageScriptBase = nil

Core.triggerEnvData = nil   -- 用来给触发器的子条件保存状态数据

--@region 通用
function Core:Init(initData)
    self.initData = initData
    self:InitElementCounte()
    self:InitStatusAbility()
    Core.Random = Tools.baRandFactory(initData.randomSeed)
    Core.Random()
    Core.Random()
    Core.Random()
    --先随机三次，增加初始化的随机性

    self.pseudoRandomList = {}
    self.pseudoRandomBaseId = 0

    RandomShift = Core.Random(100,1)

    self:InitBattleParam()
    self.effectDatas = {}
    self.skillDatas = {}
    self.triggerDatas = {}
    -- self.damageScripts = {}
    self.targetDatas = {}
    self.damageDatas = {}
    self.buffEffectDatas = {}
    self.buffDatas = {}
    self.levels = {}
    self.baseBuffID = 0
    self.baseSkillCardID = 0
    self.damageScriptBase = import("Game.Battle.Script.DamageEffect.DamageEffectBase")

    local overwhelmingGroup = checkNumber(initData.overwhelmingGroup)
    local overwhelmRatio = checkNumber(initData.playerCombatVal) / checkNumber(initData.recommendCombatVal)
    if overwhelmingGroup == 0 then
        self.overwhelmGiveDamage = 1
        self.overwhelmTakeDamage = 1
    else
        local giveDamage, takeDamage = self:GetOverwhelmParam(overwhelmingGroup, overwhelmRatio)
        self.overwhelmGiveDamage = giveDamage + 1
        self.overwhelmTakeDamage = takeDamage + 1
    end

    self.triggerEnvData = {}
end

function Core:Clear(  )
    self.initData = nil
    self.elementCounte = nil
    self.statusAbility = nil
    self.Random = nil
    self.pseudoRandomList = nil
    self.pseudoRandomBaseId = nil
    self.baseBuffID = nil
    self.baseSkillCardID = nil
    self.battleParams = nil
    self.effectDatas = nil--效果的缓存，防止多次gc
    self.skillDatas = nil
    -- self.damageScripts = nil
    self.damageScriptBase = nil
    self.triggerDatas = nil
    self.targetDatas = nil
    self.damageDatas = nil
    self.buffEffectDatas = nil
    self.buffDatas = nil
    self.triggerEnvData = nil
end

--初始化战斗相关参数
function Core:InitBattleParam(  )
    local BattleParam = Constants.BattleParam

    self.battleParams = {}
    self.battleParams[BattleParam.EvadeDamageReduce] = self:GetBattleParamNum(BattleParam.EvadeDamageReduce)
    self.battleParams[BattleParam.CardMakeUpLimit] = self:GetBattleParamNum(BattleParam.CardMakeUpLimit)
    self.battleParams[BattleParam.CardWeightArray] = self:GetBattleParamNum(BattleParam.CardWeightArray, true)
    self.battleParams[BattleParam.CardWeightValue] = self:GetBattleParamNum(BattleParam.CardWeightValue)
    self.battleParams[BattleParam.LuckyValuePara] = self:GetBattleParamNum(BattleParam.LuckyValuePara)
    self.battleParams[BattleParam.SkillVoicePlayRate] = self:GetBattleParamNum(BattleParam.SkillVoicePlayRate)
end

function Core:GetBattleParamNum( key, isArray )
    local value = self.battleParams[key]
    if value then
        return value
    end
    local data = BattleConfig:GetSetting(AutoIds.IdSetting267)
    local row = data:GetByPrimaryKey(key)
    assert(row, '找不到对应的战斗参数'..key)
    return isArray and Tools.splitToNum(parse_string(row,"para", ''), ';') or parse_number(row,"para", 0)
end

function Core:IsEnemy( camp1, camp2 )
    return camp1 ~= camp2
end

--- 查找猫球
---@param camp any
---@param type any
function Core:FindSkillCat(camp, type)
    local type = type or 1
    local cats = BattleMgr.skillCats
    for i, cat in ipairs(cats) do
        if cat.camp == camp and cat.skillCatType == type then
            return cat
        end
    end
    return nil
end

--@return [Game.Battle.Entity.Role#Role]
function Core:FindRole( id, roles )
    local roleList = {}
    table.link(roleList, BattleMgr.skillCats)
    table.link(roleList, BattleMgr.roles)
    roles = roles or roleList
    for i,role in ipairs(roles) do
        if role.id == id then
            return role
        end
    end
    return nil
end

function Core:FindSelectRole()
    return self:FindRole(BattleMgr.selectRoleID)
end

function Core:GetEnemyRoles( myCamp, roles )
    roles = roles or BattleMgr.roles
    local rs = {}
    for i,role in ipairs(roles) do
        if self:IsEnemy(myCamp, role.camp) == true then
            table.insert( rs, role )
        end
    end
    return rs
end
--@return [Game.Battle.Entity.Role#Role<>]
function Core:GetFriendRoles( myCamp, roles )
    roles = roles or BattleMgr.roles
    local rs = {}
    for i,role in ipairs(roles) do
        if self:IsEnemy(myCamp, role.camp) == false then
            table.insert( rs, role )
        end
    end
    return rs
end

function Core:GetEnemyRolesWithoutSpecialSummon( myCamp, roles )
    roles = roles or BattleMgr.roles
    local rs = {}
    for i,role in ipairs(roles) do
        if self:IsEnemy(myCamp, role.camp) == true and role.roleType ~= Constants.RoleType.SpecialSummon then
            table.insert( rs, role )
        end
    end
    return rs
end
--@return [Game.Battle.Entity.Role#Role<>]
function Core:GetFriendRolesWithoutSpecialSummon( myCamp, roles )
    roles = roles or BattleMgr.roles
    local rs = {}
    for i,role in ipairs(roles) do
        if self:IsEnemy(myCamp, role.camp) == false and role.roleType ~= Constants.RoleType.SpecialSummon then
            table.insert( rs, role )
        end
    end
    return rs
end

function Core:FindRoleDataInTeam(id, team)
    if IsNull(team) then
        return nil
    end
    for i,rs in ipairs(team) do
        for j,v in ipairs(rs) do
            if v.id == id then
                return v
            end
            if v.summons and #v.summons > 0 then
                for k,summon in ipairs(v.summons) do
                    if summon.id == id then
                        return summon
                    end
                end
            end
        end
    end
end

function Core:FindRoleDataById( id )
    local initData = self.initData
    local roleDatas = {}

    local d = nil
    d = self:FindRoleDataInTeam(id, initData.playerTeam)
    if d then
        return d
    end

    d = self:FindRoleDataInTeam(id, initData.enemyTeam)
    if d then
        return d
    end

    d = self:FindRoleDataInTeam(id, initData.callTeam)
    if d then
        return d
    end

    d = self:FindRoleDataInTeam(id, initData.specialTeam)
    if d then
        return d
    end

    return nil
end

function Core:GetNextBuffID( )
    -- body
    self.baseBuffID = self.baseBuffID + 1
    return self.baseBuffID
end

function Core:GetNextSkillCardID( )
    -- body
    self.baseSkillCardID = self.baseSkillCardID + 1
    return self.baseSkillCardID
end

function Core:Shuffle(array)
    if #array <= 1 then
        return array
    end
    -- let clone = array.concat();
    local len = #array;
    for i=1,len do
        local index = self.Random(len);
        local temp = array[i];
        array[i] = array[index];
        array[index] = temp;
    end
    return array
end


function Core:GetRandomIndexByWeight( array )
    local totalW = 0
    for i,v in ipairs(array) do
        totalW = totalW + v
    end

    local r = self.Random() * totalW

    for i,v in ipairs(array) do
        if r <= v then
            return i
        end
        r = r - v
    end
    return 1
end

function Core:RandomSelect(t)
    if not t or #t <= 0 then
        return nil
    end

    if #t == 1 then
        return t[1]
    end

    local index = self.Random(#t, 1)
    return t[index]
end

--随机给数组洗牌
function Core:Shuffle(array)
    if #array <= 1 then
        return array
    end
    -- let clone = array.concat();
    local len = #array;
    for i=1,len do
        local index = self.Random( len, 1 );
        local temp = array[i];
        array[i] = array[index];
        array[index] = temp;
    end
    return array
end

--伤害减免公式
function Core:GetDamageReduceByDef( def )
    local sqrtDef = math.sqrt( def ) / 455
    local dr = def / (def + 1000) - ( sqrtDef > 0.1 and 0.1 or sqrtDef) + 0.03
    return dr
end

function Core:GetDamageRandomShift()
    local x = self.Random() * 0.1 + 0.95
    local num = 1000
    return num_floor(x * num + 0.5) / num
end

--税后伤害计算公式
--@dmgTypeVo: [Game.Setting.Vo.DamageTypeVo#DamageTypeVo]
function Core:FinalDamageCalcation( attacker, target, dmg, dmgTypeVo, isHit, isCrit, element, comboRatio, star)
    -- 拥有11,4,1效果的时候，指定的伤害类型必暴击，并且暴击伤害发生变化
    local hasSpecialCrit = false
    local attackerCritDamageAttr = attacker:GetAttr(Constants.AttrTypeId.CritDamage)
    target.buffMgr:WalkAllBuffEffects(function ( v )
        if target.buffMgr:IsBuffByType2(v.data.mainEffectType, v.data.subEffectType, v.data.miniEffectType, v.buff.data.buffType, 11, 4, 1, 0) then
            local params = v.data.effectNum1
            local dmgType = params[1]
            if dmgType == dmgTypeVo.id then
                hasSpecialCrit = true
                attackerCritDamageAttr = v.buff.attacker:GetAttr(Constants.AttrTypeId.CritDamage)   -- 使用buff施加者的暴击伤害属性
                attackerCritDamageAttr = math.max(attackerCritDamageAttr * params[2], params[3])
                return true
            end
        end
    end)

    --星级系数
    local dmgTags = dmgTypeVo.damageTags
    local dmgType = dmgTypeVo.damageType
    local dmgTypeId = dmgTypeVo.id
    local dmgRatioParams = dmgTypeVo.damageRatioParams
    local attr = Constants.AttrTypeId
    local starRate = Constants.StarDamageRate[star]
    local DamageType = Constants.DamageType
    local ed = 1 + element
    local hitd = isHit and 1 or Core:GetBattleParamNum(Constants.BattleParam.EvadeDamageReduce)
    local overCird = math.max(0, (attacker:GetAttr(attr.Critical) - target:GetAttr(attr.CriticalResist) - 1)) * attacker:GetAttr(attr.OverCritTransToCritDamage)
    local crid = isCrit and math.max(attackerCritDamageAttr + overCird - target:GetAttr(attr.CritDamageResist), Constants.MinCritDamage) or 1
    local baseDamageChange = math.max(1 + attacker:GetAttr(attr.GiveBaseDamageIncrease) + target:GetAttr(attr.TakeBaseDamageIncrease), 0 )
    local normalDamageChange = math.max(1 + attacker:GetAttr(attr.GiveNormalDamageIncrease) + target:GetAttr(attr.TakeNormalDamageIncrease), 0)
    local finalDamageChange = math.max(1 + attacker:GetAttr(attr.GiveFinalDamageIncrease) + target:GetAttr(attr.TakeFinalDamageIncrease), 0)
    local specialDamageChange = math.max(1 + attacker:GetGiveSpecialDamage(dmgTypeId) + target:GetTakeSpecialDamage(dmgTypeId), 0)
    local raceDamageChange = math.max(1 + attacker:GetGiveRaceDamage(target.race) + target:GetTakeRaceDamage(attacker.race), 0)

    local def = target:GetAttr( attr.Defense)
    local atk = attacker:GetAttr(attr.Attack)
    local pen = attacker:GetAttr(attr.Penetration)
    local bear = target:GetAttr(attr.Bear)


    if Core:DamageFitTag(dmgTags, Constants.DamageTag.TriplePenetration) then
        pen = pen * checkNumber(dmgRatioParams[1])
    end
    if Core:DamageFitTag(dmgTags, Constants.DamageTag.DoubleCritDamage) then
        crid = isCrit and math.max(attackerCritDamageAttr * checkNumber(dmgRatioParams[1]) + overCird - target:GetAttr(attr.CritDamageResist), Constants.MinCritDamage) or 1
    end

    local indirectDamageChange = 0

    local switch = {
        [DamageType.Normal] = function ( )
            local d1 = math.max((dmg - def) * baseDamageChange * crid * ed, 0)
            local d2 = (atk * pen - bear * def)
            local fdmg = (d1 + d2) * finalDamageChange
            return fdmg
        end,
        [DamageType.Real] = function ( )
            local d1 = math.max(dmg * baseDamageChange * crid * ed, 0)
            local d2 = (atk * pen - bear * def)
            local fdmg = (d1 + d2) * finalDamageChange
            return fdmg
        end,
        [DamageType.FullPenetrate] = function ( )
            local d1 = math.max((dmg - def) * baseDamageChange * crid * ed, 0)
            local d2 = atk * pen
            local fdmg = (d1 + d2) * finalDamageChange
            return fdmg
        end,
        [DamageType.Indirect] = function ( )
            indirectDamageChange = math.max(1 + attacker:GetAttr(attr.GiveIndirectDamageIncrease) + target:GetAttr(attr.TakeIndirectDamageIncrease), 0)
            return hasSpecialCrit and dmg * indirectDamageChange * crid or dmg * indirectDamageChange
        end,
        [DamageType.Pure] = function ( )
            return hasSpecialCrit and dmg * crid or dmg
        end,
    }
    local func = switch[dmgType]

    assert(func, '找不到对应伤害类型:'..dmgType)

    local finalDmg = func()

    --针对伤害类型id的加成
    finalDmg = finalDmg * specialDamageChange

    --如果是我方打敌方，则需要处理一次战力碾压伤害增加
    if attacker.camp == Constants.Camp.One and target.camp == Constants.Camp.Two then
        finalDmg = finalDmg * self.overwhelmGiveDamage
    end
    --如果是敌方打我方，则需要处理一次战力碾压伤害减少
    if attacker.camp == Constants.Camp.Two and target.camp == Constants.Camp.One then
        finalDmg = finalDmg * self.overwhelmTakeDamage
    end
    --只有三种伤害类型才会有波动
    local randomShift = 1
    if dmgType == DamageType.Normal or dmgType == DamageType.FullPenetrate or dmgType == DamageType.Real then
        randomShift = self:GetDamageRandomShift()
        -- finalDmg = finalDmg * self.overwhelmRatio    -- 这里好像多乘了一次碾压系数

        finalDmg = finalDmg * raceDamageChange
    end
    finalDmg = finalDmg * randomShift
    finalDmg = finalDmg * comboRatio

    local beforeNormalDamageChange = finalDmg

    -- 计算伤害量加成
    finalDmg = finalDmg * normalDamageChange

    local afterNormalDamageChange = finalDmg
    local normalDamageChangeValue = afterNormalDamageChange - beforeNormalDamageChange      -- changeValue可能是正数，也可能是负数

    -- 保存角色的一些需要记录的数据
    local beAtkDataInSkillRange = target.roleContextData.beAtkDataInSkillRange
    beAtkDataInSkillRange.normalDamageChangeValue = beAtkDataInSkillRange.normalDamageChangeValue + normalDamageChangeValue
    beAtkDataInSkillRange.fdmgBeforeNormalDamageChange = beAtkDataInSkillRange.fdmgBeforeNormalDamageChange + beforeNormalDamageChange
    beAtkDataInSkillRange.fdmg = beAtkDataInSkillRange.fdmg + finalDmg
   
    
    finalDmg = math.max( 1, finalDmg )
    finalDmg = num_floor( finalDmg )
    local w = {
        "fdmg: ", finalDmg, "\n",
        "dmg: ", dmg, "\n",
        "atk: ", atk, "\n",
        "def: ", def, "\n",
        "pen: ", pen, "\n",
        "bear: ", bear, "\n",
        "crid: ", crid, "\n",
        "hitd: ", hitd, "\n",
        "randomShift: ", randomShift, "\n",
        "comboRatio: ", comboRatio, "\n",
        "element: ", ed, "\n",
        "baseDamageChange: ", baseDamageChange, "\n",
        "normalDamageChange: ", normalDamageChange, "\n",
        "finalDamageChange: ", finalDamageChange, "\n",
        "overwhelmGive: ", self.overwhelmGiveDamage, "\n",
        "overwhelmTake: ", self.overwhelmTakeDamage, "\n",
        "specialDamageChange: ", specialDamageChange, "\n",
        "raceDamageChange: ", raceDamageChange, "\n",
        "indirectDamageChange: ", indirectDamageChange, "\n",
        "attacker: ", attacker.id, "\n",
        "specialCrit: ", hasSpecialCrit and "true" or "false", "\n",
        "specialCritAttr: ", attackerCritDamageAttr, "\n",
    }
    print(table.concat(w))
    return finalDmg
end

--初始化能力值配置
function Core:InitStatusAbility( )
    -- body
    self.statusAbility = {}
    local tableFile = BattleConfig:GetSetting(AutoIds.IdSetting266)
    local length = tableFile:GetRowCount()
    for i=1,length do
        local row = tableFile:GetRow(i)
        local data = {}
        for k,v in pairs(Constants.StatusAbility) do
            data[k] = row:Get(v) == "1"
        end
        --把属性克制记录
        self.statusAbility[tonumber(row:Get('id'))] = data
    end
    print(table.toString(self.statusAbility, 'statusAbility'))
end

--根据状态变更类型获取对应的能力
function Core:GetStatusAbility( statusId )
    local data = self.statusAbility[statusId]
    assert(data, '找不到对应的能力值数据'..statusId)
    return data
end

--@endregion

--@region 元素克制
function Core:InitElementCounte()
    -- body
    self.elementCounte = {}
    ---@type TableML.TableFile
    local tableFile = BattleConfig:GetSetting(AutoIds.IdSetting261)
    local length = tableFile:GetRowCount()
    for i=1,length do
        local row = tableFile:GetRow(i)
        --把属性克制记录
        self.elementCounte[ self.GetElementCounteID(row:Get('elementId'), row:Get('restraintElementId')) ] = { tonumber(row:Get('damagePara')), tonumber(row:Get('HitPara')), tonumber(row:Get('dodge'))}
    end
    print(table.toString(self.elementCounte, 'element counte'))
end

function Core.GetElementCounteID( atkElement, defElement )
    -- body
    return atkElement..'|'..defElement
end

--[[
    @desc: 获取属性克制相关的伤害补正
    author:luqucheng
    time:2019-10-22 15:06:17
    --@atkElement:进攻方元素属性
	--@defElement: 防御方元素属性
    @return:伤害变化补正参数 0.1表示伤害增加10%,可以为负数
]]
function Core:GetElementCounteDamage( atkElement, defElement )
    -- body
    local id = self.GetElementCounteID(atkElement, defElement)
    local data = self.elementCounte[id]
    if data then
        return data[1]
    end
    return 0
end

--- 计算最终属性克制加成
---@param atker any
---@param defer any
function Core:GetElementCounteDamageWithBuff(atker, defer)
    local atkElement = atker.elementType
    local defElement = defer.elementType
    -- 配表参数
    local dmgParam = self:GetElementCounteDamage(atkElement, defElement)
    -- 计算攻方buff带来的加法公式加成和乘法公式加成
    local addParam1, mulParam1 = atker.buffMgr:ElementAdvantageChange(atkElement, defElement, dmgParam, 1)
    -- 计算守方buff带来的加法公式加成和乘法公式加成
    local addParam2, mulParam2 = defer.buffMgr:ElementAdvantageChange(atkElement, defElement, dmgParam, 2)
    -- 计算最终属性克制加成
    -- print("[属性克制] ", dmgParam, addParam1, addParam2, mulParam1, mulParam2)
    return (dmgParam + addParam1 + addParam2) * (1 + mulParam1 + mulParam2)
end

--获取属性克制相关的命中补正
function Core:GetElementCounteHit( atkElement, defElement )
    -- body
    local id = self.GetElementCounteID(atkElement, defElement)
    local data = self.elementCounte[id]
    if data then
        return data[2]
    end
    return 0
end

--获取属性克制相关的闪避补正
function Core:GetElementCounteDodge( atkElement, defElement )
    --闪避的获取是看防守方是否克制进攻方
    local id = self.GetElementCounteID(defElement, atkElement)
    local data = self.elementCounte[id]
    if data then
        return data[3]
    end
    return 0
end

function Core:ElementCounteTest(  )
    printInfo( self:GetElementCounteDamage(1, 3) )
end

--@endregion

--@region 行动槽
function Core:HandleAction( roles, queue, maxS )
    -- body
    local spdType = Constants.AttrTypeId.Speed
    local queueValue = Constants.BattleActionQueueValue

     --根据速度排序之后再计算
    local rs = self:SortAction(roles, queue)


    local minT = 9999999
    local minRole = nil

    --获取当前排队列表,如果列表内有人，则以第一人行动为准
    if #queue > 0 then
        minRole = rs[1]
        minT = (maxS - minRole.nowAction) / minRole:GetAttr(spdType)
    else
        --排队列表内没有人的话就正常算
        for i,role in ipairs(rs) do
            local remainS = maxS - role.nowAction
            local t = remainS / role:GetAttr(spdType)
            if t < minT then
                minRole = role
                minT = t
            end
        end
    end

    local len = #queue
    --先计算需要插入到排队内角色，行动值计算过后，大于等于98%最大行动值的角色加入队伍
    for i=len+1,#rs do
        local role = rs[i]
        role.nowAction = minT * role:GetAttr(spdType) + role.nowAction
        if role.nowAction >= maxS * queueValue then
            table.insert( queue, role )
        end
    end
    

    self:ActionNumHandle(queue, rs, maxS)
    
    --把下个行动的角色移除队伍,行动值清0
    minRole.nowAction = 0
    if #queue then
        table.remove( queue, 1 )
    end

    local log = {}
    table.insert( log, "[HandleActionValue]max s:"..maxS )
    table.insert( log, "  min t:"..minT)
    table.insert( log, "  first :"..minRole.id)
    table.insert( log, "  queue len:"..#queue)
    table.insert( log, "  actions:")
    for i,v in ipairs(roles) do
        table.insert( log, v.nowAction )
        table.insert( log, ',' )
    end
    printInfo(table.concat( log, ''))

    return minRole
end

--排序顺序:在队列内的按顺序优先，其余的按照速度优先
function Core:SortAction( roles, queue )
    local spdType = Constants.AttrTypeId.Speed

     local rs = table.link({}, roles)
     for i,role in fipairs(rs) do
         if table.isContain(queue, role) then
             table.remove( rs, i )
         end
         --死人不参与
         if role:IsDead() then
            table.remove( rs, i )
         end
     end
     table.inPlaceBubbleSort( rs, function(r1, r2)
         --速度不同，速度快的优先，速度相同则进度高的优先
         if r1:GetAttr(spdType) ~= r2:GetAttr(spdType) then
             return r1:GetAttr(spdType) > r2:GetAttr(spdType)
         end
         return r1.nowAction > r2.nowAction
     end )
     local temp = table.link({}, queue)
     rs = table.link( temp, rs )

     return rs
end

--处理队伍尾部的数值排队，数值相同的情况
function Core:ActionNumHandle( queue, rs, maxS )
    local queueValue = Constants.BattleActionQueueValue

    --修改队伍内的行动值
    local len = #queue
    for i=2,len do
        local role = rs[i]
        role.nowAction = maxS * (queueValue - (i - 2) * 0.01 )
    end

    --计算队伍外的角色的行动值
    len = #queue
    local minQueuePer = (queueValue - (len - 2) * 0.01 )--当前排队队伍中排最低的行动值百分比，队伍外的人不能高于这个数，如果有多个超过这个值，则按速度顺序一个个减去1%
    for i=len+1,#rs do
        local role = rs[i]
        if role.nowAction >= minQueuePer * maxS then
            minQueuePer = minQueuePer - 0.01
            role.nowAction = minQueuePer * maxS
        end
    end

    --判断队伍内是否有多个有相同行动值的角色，如果有，则行动值-1
    local function check( r, startIndex, endIndex )
        for j=startIndex,endIndex do
            local r2 = rs[j]
            if r.nowAction == r2.nowAction then
                r.nowAction = r.nowAction - 1
                if r.nowAction <= 0 then
                    r.nowAction = 0
                    return false
                end
                return true
            end
        end
        return false
    end
    for i=len+1,#rs do
        local role = rs[i]
        while check(role, len+1, i-1) do
        end
    end
end

function Core:RemoveFromQueue( role, queue )
    local isInQueue = false
    for i,v in ipairs(queue) do
        if role.id == v.id then
            isInQueue = true
            table.remove(queue, i)
            break
        end
    end
    return isInQueue
end

function Core:HandleOneRoleAction( role, changeValue, roles, queue, maxS )
    local queueValue = Constants.BattleActionQueueValue
    --先排除出队伍
    local isInQueue = self:RemoveFromQueue(role, queue)

    --数值变化直接导致大于等于100%,直接拉到队伍的最前面
    if role.nowAction + changeValue >= maxS then
        table.insert(queue, 1, role)
        role.nowAction = maxS
    elseif role.nowAction + changeValue >= queueValue * maxS then
    --没到100%但是达到了进入队伍的线，则排在最后

        --加了之后到达队伍线
        --如果之前已经在队伍里，就说有问题
        printError("在队伍内的单位通过技能修改行动槽之后仍然在队伍内。。")
        table.insert(queue, role)
        role.nowAction = maxS * (queueValue - (#queue - 2) * 0.01 )
    else
    --不足加入队伍的线，则数值不变
        role.nowAction = math.max( 0, role.nowAction + changeValue )
    end
    --排序
    -- local rs = self:SortAction(roles, queue)
    -- -- --后续处理
    -- self:ActionNumHandle(queue, rs, maxS)
end

--@endregion

--@region 目标选择

--仅根据阵营获取候选人
--@return [Game.Battle.Entity.Role#Role<>]
function Core:GetCampTargets( attacker, roles, targetCamp )
    local tc = Constants.TargetCamp

    --获取阵营相关的所有角色
    local switch = {
        [tc.Friend] = function (  )
            return self:GetFriendRoles(attacker.camp, roles)
        end,
        [tc.Enemy] = function (  )
            return self:GetEnemyRoles(attacker.camp, roles)
        end,
        [tc.All0] = function (  )
            return roles
        end,
        [tc.All] = function (  )
            return roles
        end,
        [tc.Self] = function (  )
            return {attacker}
        end,
        [tc.FriendWithoutSelf] = function (  )
            local rs = self:GetFriendRoles(attacker.camp, roles)
            table.removebyvalue(rs, attacker)
            return rs
        end,
        [tc.FriendWithoutSpecialSummon] = function (  )
            local rs = self:GetFriendRolesWithoutSpecialSummon(attacker.camp, roles)
            return rs
        end,
        [tc.FriendWithoutSelfAndSpecialSummon] = function (  )
            local rs = self:GetFriendRolesWithoutSpecialSummon(attacker.camp, roles)
            table.removebyvalue(rs, attacker)
            return rs
        end,
    }
    local func = switch[targetCamp]
    if func then
        local ts = func()
        for i,v in fipairs(ts) do
            if v:IsDead() then
                table.remove(ts, i)
            end
        end
        return ts
    end

    return {}
end

function Core:SelectTargets(targetType, attacker, mainTarget, roles)

    --读取配置获得目标类型数据
    ---@type TableML.TableFile
    -- local data = setting:Get(targetType)
    local data = self:GetTargetData(targetType)
    -- print("targetType:"..targetType)
    assert(data, '目标选择数据没有找到：'..targetType)

    local targets = {}
    local tt = Constants.TargetType
    local camp = data.camp
    local values = data.conditionNum
    local rs = self:GetCampTargets(attacker, roles, camp)
    -- print("num:"..#rs)
    -- print("camp:"..camp)

    --获取真实的目标
    local switch = {
        [tt.All] = function (  )
            for i,v in ipairs(rs) do
                if v:CanBeSelected()  then
                    table.insert( targets,v )
                end
            end
        end,
        [tt.Select] = function ()
            if mainTarget:CanBeSelected() then
                table.insert(targets,mainTarget)
            end
        end,
        [tt.ExceptSelect] = function ()
            for i,v in ipairs(rs) do
                if v:CanBeSelected() and (v.id ~= mainTarget.id) then
                    table.insert( targets,v )
                end
            end
        end,
        [tt.SelectAndRandomNum] = function ()
            local value = values[1]
            if mainTarget:CanBeSelected() then
                table.insert(targets,mainTarget)
            end
            --随机选择一定数量的角色
            rs = self:Shuffle(rs)
            local count = 0
            for i,v in ipairs(rs) do
                if v:CanBeSelected() and v.id ~= mainTarget.id then
                    table.insert( targets,v )
                    count = count + 1
                end
                if count >= value then
                    break
                end
            end
        end,
        [tt.RandomNum] = function ( )
            local value = values[1]
            rs = self:Shuffle(rs)
            local count = 0
            for i,v in ipairs(rs) do
                if v:CanBeSelected() then
                    table.insert( targets,v )
                    count = count + 1
                end
                if count >= value then
                    break
                end
            end
        end,
        [tt.AttrMin] = function(  )
            table.inPlaceBubbleSort(rs, function (r1, r2)
                return r1:GetAttr(values[1]) < r2:GetAttr(values[1])
            end)
            local count = 0
            for i,v in ipairs(rs) do
                if v:CanBeSelected() then
                    table.insert( targets,v )
                    count = count + 1
                end
                if count >= values[2] then
                    break
                end
            end
        end,
        [tt.AttrMax] = function(  )
            table.inPlaceBubbleSort(rs, function (r1, r2)
                return r1:GetAttr(values[1]) > r2:GetAttr(values[1])
            end)
            local count = 0
            for i,v in ipairs(rs) do
                if v:CanBeSelected() then
                    table.insert( targets,v )
                    count = count + 1
                end
                if count >= values[2] then
                    break
                end
            end
        end,
        [tt.AttrMaxExceptMainTarget] = function(  )
            table.inPlaceBubbleSort(rs, function (r1, r2)
                return r1:GetAttr(values[1]) < r2:GetAttr(values[1])
            end)
            local count = 0
            for i,v in ipairs(rs) do
                if v:CanBeSelected() and v.id ~= mainTarget.id then
                    table.insert( targets,v )
                    count = count + 1
                end
                if count >= values[2] then
                    break
                end
            end
        end,
        [tt.AttrMinExceptMainTarget] = function(  )
            table.inPlaceBubbleSort(rs, function (r1, r2)
                return r1:GetAttr(values[1]) > r2:GetAttr(values[1])
            end)
            local count = 0
            for i,v in ipairs(rs) do
                if v:CanBeSelected() and v.id ~= mainTarget.id then
                    table.insert( targets,v )
                    count = count + 1
                end
                if count >= values[2] then
                    break
                end
            end
        end,
        [tt.OriginAttrMin] = function(  )
            table.inPlaceBubbleSort(rs, function (r1, r2)
                return r1:GetBaseAttr(values[1]) < r2:GetBaseAttr(values[1])
            end)
            local count = 0
            for i,v in ipairs(rs) do
                if v:CanBeSelected() then
                    table.insert( targets,v )
                    count = count + 1
                end
                if count >= values[2] then
                    break
                end
            end
        end,
        [tt.OriginAttrMax] = function(  )
            table.inPlaceBubbleSort(rs, function (r1, r2)
                return r1:GetBaseAttr(values[1]) > r2:GetBaseAttr(values[1])
            end)
            local count = 0
            for i,v in ipairs(rs) do
                if v:CanBeSelected() then
                    table.insert( targets,v )
                    count = count + 1
                end
                if count >= values[2] then
                    break
                end
            end
        end,
        [tt.HPPercentMax] = function(  )
            table.inPlaceBubbleSort(rs, function (r1, r2)
                return r1:GetAttr(Constants.AttrTypeId.NowHp) / r1:GetAttr(Constants.AttrTypeId.Hp) 
                > r2:GetAttr(Constants.AttrTypeId.NowHp) / r2:GetAttr(Constants.AttrTypeId.Hp) 
            end)
            local count = 0
            for i,v in ipairs(rs) do
                if v:CanBeSelected() then
                    table.insert( targets,v )
                    count = count + 1
                end
                if count >= values[1] then
                    break
                end
            end
        end,
        [tt.HPPercentMin] = function(  )
            table.inPlaceBubbleSort(rs, function (r1, r2)
                return r1:GetAttr(Constants.AttrTypeId.NowHp) / r1:GetAttr(Constants.AttrTypeId.Hp) 
                < r2:GetAttr(Constants.AttrTypeId.NowHp) / r2:GetAttr(Constants.AttrTypeId.Hp) 
            end)
            local count = 0
            for i,v in ipairs(rs) do
                if v:CanBeSelected() then
                    table.insert( targets,v )
                    count = count + 1
                end
                if count >= values[1] then
                    break
                end
            end
        end,
        [tt.Self] = function (  )
            targets = {attacker}
        end,
        [tt.Side] = function (  )
            if #rs <= 0 then
                return
            end
            local role = mainTarget
            local alives = BattleMgr:GetAliveRoles(role.camp)
            for i, v in ipairs(alives) do
                -- print("Side", v.standPosition, role.standPosition, math.abs( v.standPosition - role.standPosition ))
                if v:CanBeSelected() and math.abs( v.standPosition - role.standPosition ) == 1  then
                    table.insert( targets,v )
                end
            end
        end,
        [tt.SideAndMiddle] = function (  )
            if #rs <= 0 then
                return
            end
            local role = mainTarget
            table.insert( targets, role )
            local alives = BattleMgr:GetAliveRoles(role.camp)
            for i, v in ipairs(alives) do
                if v:CanBeSelected() and math.abs( v.standPosition - role.standPosition ) == 1  then
                    table.insert( targets,v )
                end
            end
        end,
        [tt.CampLeftOrRight] = function (  )
            if #rs <= 0 then
                return
            end
            table.inPlaceBubbleSort(rs, function (r1, r2)
                return r1.standPosition < r2.standPosition
            end)
            local leftOrRight = values[1]
            if leftOrRight == 0 then
                local r = rs[1]
                table.insert( targets,r )
            elseif leftOrRight == 1 then
                local r = rs[#rs]
                table.insert( targets,r )
            end
        end,
        [tt.SelectCareer] = function (  )
            for i,v in ipairs(rs) do
                if v:CanBeSelected() and v.career == values[1] then
                    table.insert( targets,v )
                end
            end
        end,
        [tt.SelectMonsterType] = function (  )
            for i,v in ipairs(rs) do
                if v:CanBeSelected() and math.min(v.monsterClass, 2) == values[1] then
                    table.insert( targets,v )
                end
            end
        end,
        [tt.SelectElement] = function (  )
            for i,v in ipairs(rs) do
                if v:CanBeSelected() and v.elementType == values[1] then
                    table.insert( targets,v )
                end
            end
        end,
        [tt.God] = function (  )
            if BattleMgr.agent then
                table.insert( targets, BattleMgr.agent )
            end
        end,
        [tt.HPSmaller] = function(  )
            local count = 0
            for i,v in ipairs(rs) do
                if v:CanBeSelected() and v:GetNowHPPercent() <= values[1] then
                    table.insert( targets,v )
                    count = count + 1
                end
                if count >= values[2] then
                    break
                end
            end
        end,
        [tt.HPBigger] = function(  )
            local count = 0
            for i,v in ipairs(rs) do
                if v:CanBeSelected() and v:GetNowHPPercent() > values[1] then
                    table.insert( targets,v )
                    count = count + 1
                end
                if count >= values[2] then
                    break
                end
            end
        end,
        [tt.SpecialSummon] = function (  )
            for i,v in ipairs(rs) do
                if v:CanBeSelected() and v.roleType == Constants.RoleType.SpecialSummon then
                    table.insert( targets,v )
                end
            end
        end,
        [tt.TypeId] = function (  )
            for i,v in ipairs(rs) do
                if v:CanBeSelected() and v.typeId == values[1] then
                    table.insert( targets,v )
                end
            end
        end,
        [tt.CatType] = function (  )
            for i,v in ipairs(rs) do
                if v:CanBeSelected() and v.catType == values[1] then
                    table.insert( targets,v )
                end
            end
        end,
        [tt.Race] = function (  )
            for i,v in ipairs(rs) do
                if v:CanBeSelected() and v.race == values[1] then
                    table.insert( targets,v )
                end
            end
        end,
        [tt.CharacterId] = function (  )
            for i,v in ipairs(rs) do
                if v:CanBeSelected() and v.characterId == values[1] then
                    table.insert( targets,v )
                end
            end
        end,
        [tt.HasSomeBuffLayerGreater] = function (  )
            for i,v in ipairs(rs) do
                if v:CanBeSelected() and v.buffMgr:GetBuffLayNumByBuffTypeID(values[1]) > values[2] then
                    table.insert( targets,v )
                end
            end
        end,
        [tt.HasSomeBuffLayerLess] = function (  )
            for i,v in ipairs(rs) do
                if v:CanBeSelected() and v.buffMgr:GetBuffLayNumByBuffTypeID(values[1]) <= values[2] then
                    table.insert( targets,v )
                end
            end
        end,
        [tt.BuffOrDebuffMax] = function (  )
            local buffType = values[1] == 2
            local selectCount = values[2]
            table.inPlaceBubbleSort(rs, function (r1, r2)
                return r1.buffMgr:GetBuffOrDebuffNum(buffType) > r2.buffMgr:GetBuffOrDebuffNum(buffType)
            end)
            local count = 0
            for i,v in ipairs(rs) do
                if v:CanBeSelected() then
                    table.insert( targets,v )
                    count = count + 1
                end
                if count >= selectCount then
                    break
                end
            end
        end,
        [tt.BuffOrDebuffMin] = function (  )
            local buffType = values[1] == 2
            local selectCount = values[2]
            table.inPlaceBubbleSort(rs, function (r1, r2)
                return r1.buffMgr:GetBuffOrDebuffNum(buffType) < r2.buffMgr:GetBuffOrDebuffNum(buffType)
            end)
            local count = 0
            for i,v in ipairs(rs) do
                if v:CanBeSelected() then
                    table.insert( targets,v )
                    count = count + 1
                end
                if count >= selectCount then
                    break
                end
            end
        end,
        [tt.BuffIdLayerMinMax] = function (  )
            local buffId = values[1]
            local cendingType = values[2]
            local selectCount = values[3]

            table.inPlaceBubbleSort(rs, function (r1, r2)
                if cendingType == 1 then
                    return r1.buffMgr:GetBuffLayNumByBuffTypeID(buffId) > r2.buffMgr:GetBuffLayNumByBuffTypeID(buffId)
                elseif cendingType == 2 then
                    return r1.buffMgr:GetBuffLayNumByBuffTypeID(buffId) < r2.buffMgr:GetBuffLayNumByBuffTypeID(buffId)
                end
            end)

            local count = 0
            for i,v in ipairs(rs) do
                if v:CanBeSelected() then
                    table.insert( targets,v )
                    count = count + 1
                end
                if count >= selectCount then
                    break
                end
            end
        end,
    }
    local func = switch[data.conditionId]
    if not func then
        printError('找不到对应的寻找目标的方法：'.. data.conditionId)
        return {}
    end
    func()
    return targets
end

function Core:GetModleId( skinId )
    local modelId = 0
    --读取橘色表和怪物表
    -- if isCreep then
    --     print(typeId)
    --     --@RefType [Game.Setting.Vo.MonsterTypeVo#MonsterTypeVo]
    --     local monsterTypeVo = setting:Get(typeId)
    --     -- print(table.toString(monsterTypeVo, "monsterTypeVo"))
    --     modelId = monsterTypeVo.mode
    -- else
    --     --@RefType [Game.Setting.Vo.CardVo#CardVo]
    --     local cardVo = CardConfMgr:GetInstance():GetCardByRefId(typeId)
    --     modelId = cardVo.modelRes
    -- end
    local skinData = self:GetSkinData(skinId)

    assert(skinData, "找不到皮肤数据:" .. skinId)
    return skinData.mode
end

function Core:GetCardByRefId(refId)
    local setting = BattleConfig:GetSettingVo(AutoIds.IdSetting28, "CardVo")
    return setting:Get(refId)
end

function Core:GetSkinData(skinId)
    local setting = BattleConfig:GetSettingVo(AutoIds.IdSetting113, "CardSkinVo")
    local skinData = setting:Get(skinId)

    return skinData
end

function Core:GetLobbyModleId( skinId )
    local modelId = 0

    local skinData = self:GetSkinData(skinId)

    assert(skinData, "找不到皮肤数据:" .. skinId)
    return skinData.lobbyMode
end

function Core:GetCareer( typeId, isCreep )
    local career = 0
    --读取角色表和怪物表
    if isCreep then
        local setting = BattleConfig:GetSettingVo(AutoIds.IdSetting39, "MonsterTypeVo")
        print(typeId)
        --@RefType [Game.Setting.Vo.MonsterTypeVo#MonsterTypeVo]
        local monsterTypeVo = setting:Get(typeId)
        -- print(table.toString(monsterTypeVo, "monsterTypeVo"))
        career = monsterTypeVo.location
    else
        --@RefType [Game.Setting.Vo.CardVo#CardVo]
        local cardVo = self:GetCardByRefId(typeId)
        career = cardVo.career
    end

    return career
end

function Core:GetCatType(typeId, isCreep)
    --读取角色表和怪物表
    if isCreep then
        return 0
    else
        --@RefType [Game.Setting.Vo.CardVo#CardVo]
        local cardVo = self:GetCardByRefId(typeId)
        return cardVo.catType
    end
end

function Core:GetCharacterId(typeId, isCreep)
    --读取角色表和怪物表
    if isCreep then
        return 0
    else
        --@RefType [Game.Setting.Vo.CardVo#CardVo]
        local cardVo = self:GetCardByRefId(typeId)
        return cardVo.characterId
    end
end

function Core:GetCharacterRace(typeId, isCreep)
      --读取角色表和怪物表
      if isCreep then
        local setting = BattleConfig:GetSettingVo(AutoIds.IdSetting39, "MonsterTypeVo")
        --@RefType [Game.Setting.Vo.MonsterTypeVo#MonsterTypeVo]
        local monsterTypeVo = setting:Get(typeId)
        -- print(table.toString(monsterTypeVo, "monsterTypeVo"))
        return monsterTypeVo.race
    else
        --@RefType [Game.Setting.Vo.CardVo#CardVo]
        local cardVo = self:GetCardByRefId(typeId)
        return cardVo.race
    end
    return 0
end

--@endregion
--获得技能效果的配置
--@return [Game.Battle.Data.EffectData#EffectData]
function Core:GetSkillEffectData( skillEffectID, star, lv, isSPSkill, isSPSkillMainEffect )
    star = star or 1
    local key = table.concat({skillEffectID, '_', star})
    --先找本地的缓存
    local data = self.effectDatas[key]
    if not data then
        local tableFile = BattleConfig:GetSetting(AutoIds.IdSetting263)
        local skillEffect = tableFile:GetByPrimaryKey(skillEffectID)
        assert(skillEffect, "Can not found skill effect data: id:"..skillEffectID)
        data = {}
        data.mainEffectType = parse_number(skillEffect,"mainEffectType", 0)
        data.subEffectType = parse_number(skillEffect,"subEffectType", 0)
        data.miniEffectType = parse_number(skillEffect,"miniEffectType", 0)
        data.showId = parse_number(skillEffect,"showId", 0)
        data.effectLv = parse_number(skillEffect,"effectLv", 0)
        data.dispelLv = parse_number(skillEffect,"dispelLv", 0)

        tableFile = BattleConfig:GetSetting(AutoIds.IdSetting264)
        --原来的效果等级数据被星级替代了，多出了个升级成长数据
        -- print(skillEffectID..'_'..star)
        local skillEffectLv = 1
        if isSPSkill then
            -- 如果是大招，效果升级只读1星的数据，然后主效果会走公式表乘对应等级的系数
            skillEffectLv = tableFile:GetByPrimaryKey(skillEffectID..'_'.."1")
        else
            -- 目前除了大招的其他技能，都是按照星级读表
            skillEffectLv = tableFile:GetByPrimaryKey(skillEffectID..'_'..star)
        end
        
        -- 读取效果参数
        data.effectNum1 = Tools.splitToNum(parse_string(skillEffectLv,"effectNum1", ''), ';')
        
        -- 如果是大招的主效果，那么会使用升级公示表里的参数进行升级
        if isSPSkill and isSPSkillMainEffect
        and (data.mainEffectType == Constants.SkillEffectMainType.DirectDamage or data.mainEffectType == Constants.SkillEffectMainType.DirectHeal) then
            if #data.effectNum1 > 1 then
                print("大招技能的主效果有多个参数,只有第一个参数按升级表升级 "..skillEffectID)
            end
            local oldValue = data.effectNum1[1]
            local newValue = data.effectNum1[1] * self:GetSPSkillMainEffectUpgradeParam(star)
            data.effectNum1[1] = num_floor(newValue * 100) / 100
            print("[大招] 参数升级 技能效果", skillEffectID, oldValue, newValue, data.effectNum1[1], star, debug.traceback())
        end
        
        -- print("[升级] 技能效果", isSPSkill or false, isSPSkillMainEffect or false, star, data.effectNum1[1])
        -- 技能系数加密
        if data.mainEffectType == Constants.SkillEffectMainType.DirectDamage
        or data.mainEffectType == Constants.SkillEffectMainType.HPChange
        or data.mainEffectType == Constants.SkillEffectMainType.ShieldChange then
            for i,v in ipairs(data.effectNum1) do
                data.effectNum1[i] = data.effectNum1[i] + (RandomShift or 23)
            end
        end

        -- 针对召唤的特殊处理，覆盖前面的逻辑，直接用效果升级数据表
        if data.mainEffectType == Constants.SkillEffectMainType.SpecialSummon then
            skillEffectLv = tableFile:GetByPrimaryKey(skillEffectID..'_'..star)
            data.effectNum1 = Tools.splitToNum(parse_string(skillEffectLv,"effectNum1", ''), ';')
        end

        data.isIgnore = parse_number(skillEffect,"isIgnore", 0)
        self.effectDatas[key] = data
    end
    data.id = tonumber(skillEffectID)
    data.lv = tonumber(lv)
    data.star = (isSPSkill and not isSPSkillMainEffect) and 1 or tonumber(star)
    return data
end

--@return [Game.Setting.Vo.SkillCardVo#SkillCardVo]
function Core:GetSkillCardData(skillCardId)
    local setting = BattleConfig:GetSettingVo(AutoIds.IdSetting576, "SkillCardVo")
    local skillCardData = setting:Get(skillCardId)

    assert(skillCardData, "Can not found skill card data: id:"..skillCardId)

    return skillCardData
end

---@param buffEffectID integer
---@param star integer
---@param lv integer
---@return table
function Core:GetBuffEffectData( buffEffectID, star, lv, upgradeType )
    star = star or 1
    local key = table.concat({buffEffectID, '_', star})
    --先找本地的缓存
    local data = self.buffEffectDatas[key]
    if not data then
        local tableFile = BattleConfig:GetSetting(AutoIds.IdSetting571)
        -- print(buffEffectID)
        local buffEffect = tableFile:GetByPrimaryKey(buffEffectID)
        assert(buffEffect, "Can not found skill effect data: id:"..buffEffectID)
        data = {}
        data.mainEffectType = parse_number(buffEffect,"mainEffectType", 0)
        data.subEffectType = parse_number(buffEffect,"subEffectType", 0)
        data.miniEffectType = parse_number(buffEffect,"miniEffectType", 0)
        data.effectLv = parse_number(buffEffect,"effectLv", 0)
        data.dispelLv = parse_number(buffEffect,"dispelLv", 0)

        tableFile = BattleConfig:GetSetting(AutoIds.IdSetting572)
        --原来的效果等级数据被星级替代了，多出了个升级成长数据
        -- print(buffEffectID..'_'..star)

        local buffEffectLv = tableFile:GetByPrimaryKey(buffEffectID..'_'.."1")
        if upgradeType > 1 then
            buffEffectLv = tableFile:GetByPrimaryKey(buffEffectID..'_'.."1")
        else
            buffEffectLv = tableFile:GetByPrimaryKey(buffEffectID..'_'..star)
        end

        data.effectNum1 = Tools.splitToNum(parse_string(buffEffectLv,"effectNum1", ''), ';')
        if upgradeType == 2 then
            if #data.effectNum1 > 1 then
                printError("buff效果有多个参数,不能使用升级表 "..buffEffectID)
            else
                local oldValue = data.effectNum1[1]
                local newValue = data.effectNum1[1] * self:GetSPSkillMainEffectUpgradeParam(star)
                data.effectNum1[1] = num_floor(newValue * 100) / 100
                print("[大招] 参数升级 buff效果", buffEffectID, oldValue, newValue, data.effectNum1[1], star, debug.traceback())
            end
        end
        -- print("[升级] Buff效果", upgradeType, star, data.effectNum1[1])
        --综合类型ID
        data.multiType = string.format("%d_%d_%d_%d", data.mainEffectType, data.subEffectType, data.miniEffectType, data.effectNum1[1] > 0 and 1 or 0)
        self.buffEffectDatas[key] = data
    end
    data.id = tonumber(buffEffectID)
    data.lv = tonumber(lv)
    data.star = upgradeType == 3 and 1 or tonumber(star)
    return data
end

function Core:GetBuffData( buffID, star, lv )
    -- print("GetBuffData", buffID, star, lv)
    star = star or 1
    local key = table.concat({buffID, '_', star})
    --先找本地的缓存
    local data = self.buffDatas[key]
    if not data then
        local tableFile = BattleConfig:GetSetting(AutoIds.IdSetting573)
        -- print("GetBuffData:" .. buffID)
        local buffData = tableFile:GetByPrimaryKey(buffID)
        assert(buffData, "Can not found skill effect data: id:"..buffID)
        data = {}
        data.buffType = parse_number(buffData,"buffType", 0)
        -- data.buffClass = parse_number(buffData,"buffClass")--buff组
        data.effectTarget = parse_number(buffData,"effectTarget", 0)--触发指向的目标
        data.effectType = parse_number(buffData,"effectType", 0)--附加的类型（1 效果 2 技能）
        data.effectTrigger = parse_number(buffData,"effectTrigger", 0)--该BUFF触发其他BUFF（填写触发表内的ID）
        data.effectId = Tools.splitToNum(parse_string(buffData,"effectId", ''), ';')--附加的技能或者效果id
        data.triggerOrder = parse_number(buffData,"triggerOrder", 0)--普通触发器的触发优先级
        data.endType = parse_number(buffData,"endType", 0)
        data.endOrder = parse_number(buffData,"endOrder", 0)--结束buff的触发优先级
        data.stackingType = parse_number(buffData,"stackingType", 0)--叠加方式（1覆盖叠加  2独立)
        data.sameBuffStackingType = parse_number(buffData,"sameBuffStackingType", 0)--相同id的叠加方式（1覆盖叠加  2独立 3叠加)
        data.isClear = parse_number(buffData,"isClear", 0)--是否能被清除
        data.isStolen = parse_number(buffData,"isStolen", 0)--是否能被偷取
        data.isIgnore = parse_number(buffData,"isIgnore", 0)--是否无视免疫
        -- data.addBuffScript = ParseUtils.ParseString(buffData,"buffAddScript")--添加buff时候的脚本
        data.isUnique = Tools.splitToNum(parse_string(buffData,"isUnique", ''), ';')--是否唯一
        data.isUniqueAll = parse_number(buffData,"isUniqueAll", 0) == 1--是否唯一
        data.desc = parse_localizeText(buffData, 'desc')
        data.showIds =  Tools.splitToNum(parse_string(buffData,"showId", ''), ';')
        data.endNum = parse_number(buffData,"endNum", 0)
        data.removeWhenOwnerDead = parse_number(buffData,"removeByMaster", 0) == 1

        
        -- data.showDesc = parse_number(buffTypeData, "showDesc")
        data.triggerCdType = parse_number(buffData, "triggerCd", 0)
        data.effects = Tools.splitToNum(parse_string(buffData, "effects", ''), ';')--buff效果

        data.triggerEffectTypes = Tools.splitToNum(parse_string(buffData,"effectType", ''), ';') --附加类型（1 BUFF 2 技能 3技能效果）
        data.triggerClickType = parse_number(buffData,"triggerClickType", 0)

        data.buffTags = Tools.splitToNum(parse_string(buffData,"buffTags", ''), ';')--BUFF标签（1、装备效果；2、人物被动；3、共鸣被动）
        data.refresh = parse_number(buffData, "refresh", 0)

        data.upgradeType = parse_number(buffData, "levelUpType", 1)     -- buff升级数据类型
        
        tableFile = BattleConfig:GetSetting(AutoIds.IdSetting574)
        --原来的效果等级数据被星级替代了，多出了个升级成长数据
        local buffDataLv = tableFile:GetByPrimaryKey(buffID..'_'.."1")
        if data.upgradeType > 1 then
            -- 如果是2,3类型，那么读1星的数据，类型2还会额外乘一个升级系数
            buffDataLv = tableFile:GetByPrimaryKey(buffID..'_'.."1")
        else
            buffDataLv = tableFile:GetByPrimaryKey(buffID..'_'..star)
        end
        data.buffConditionPara = Tools.splitToNum(parse_string(buffDataLv,"buffConditionPara", ''), ';', ',')
        data.buffEndPara = Tools.splitToNum(parse_string(buffDataLv,"buffEndPara", ''), ';', ',')
        data.stackTime = Tools.splitToNum(parse_string(buffDataLv,"stackTime", ''), ';')
        data.triggerCdNum = parse_number(buffDataLv,"triggerCdNum", 1)
        data.round = parse_number(buffDataLv,"round", 0)
        data.stackingMax = parse_number(buffDataLv,"stackingMax", 0)
        data.effectRate = parse_number(buffDataLv,"crowdControl", -1)
        

        --如果触发主动技能，则一定需要填写cd，这里做一下容错
        local hasTrigSkill =false
        for i,v in ipairs(data.triggerEffectTypes) do
            if v == Constants.EffectType.Skill then
                hasTrigSkill = true
            end
        end
        if hasTrigSkill and (data.triggerCdType == 0 or (data.triggerCdType == Constants.TriggerCdType.Round and data.triggerCdNum == 0) ) then
            data.triggerCdType = Constants.TriggerCdType.CountInOnSkill
            data.triggerCdNum = 1
        end

        --类型数据查看子效果
        if #data.effects > 0 then
            local buffEffectData = self:GetBuffEffectData(data.effects[1], star, lv, data.upgradeType)
            if buffEffectData then
                data.mainEffectType = buffEffectData.mainEffectType
                data.subEffectType = buffEffectData.subEffectType
                data.miniEffectType = buffEffectData.miniEffectType
                data.dispelLv = buffEffectData.dispelLv
            end
        end
        
        

        self.buffDatas[key] = data
    end
    data.id = tonumber(buffID)
    data.lv = tonumber(lv)
    data.star = data.upgradeType == 3 and 1 or tonumber(star)
    return data
end

--@return [Game.Battle.Data.SkillData#SkillData]
function Core:GetSkillData( skillId, star, lv, d )

    if Tools.isNullKey(skillId) then
        return
    end

    local uid = table.concat({skillId, star, lv})
    -- local data = self.skillDatas[uid]
    -- if not data then
        local data = d or {}
        local tf = BattleConfig:GetSetting(string.format("%s%s",AutoIds.IdSetting268, "IDGroup"))
        local key = parse_number( tf:GetByPrimaryKey(string.format("%s_%s", skillId, star)), 'id' , 0)
        local tableFile = BattleConfig:GetSetting(AutoIds.IdSetting268)
        local skillData = tableFile:GetByPrimaryKey(key)
        assert(skillData, "Can not found skill data: id:"..skillId)

        data.skillId = skillId
        data.lv = lv
        data.star = star
        
        -- data.comboType = parse_number(skillData,"involvedPosition", 0)--连携位置（目前是4个位置，分别是A B C D，对应填写1 2 3 4与系统描述一致，当该招数为大招时，则填写为0）
        data.skillClass = parse_number(skillData,"skillClass", 0)--技能分类(1主动 2被动）
        data.skillType = parse_number(skillData,"skillType", 0)--技能类型（1普攻2高级技能3大招4强化技）
        -- data.skillCondition = parse_number(skillData,"skillCondition", 0)
        -- data.castConditionPara = parse_number(skillData,"castConditionPara", 0)
        -- data.clickType = parse_number(skillData,"clickType", 0)--技能点选规则（1己方 2敌方 3全体）
        data.damageTarget = parse_number(skillData,"damageTarget", 0)--伤害效果目标
        data.damageEffect = parse_number(skillData,"damageEffect", 0)--伤害效果ID
        data.damageEffectType = parse_number(skillData,"damageEffectType", 0)
        -- data.isCounterAttack = parse_number(skillData,"isCounterAttack", 0)--是否触发反击（1触发,0不触发）
        -- data.isContinuousAttack = parse_number(skillData,"isContinuousAttack", 0)--是否连击（1触发,0不触发）
        data.comboTargetSelectScript = parse_number(skillData,"scriptType", 0)
        data.comboTargetSelectParams = Tools.splitToNum(parse_string(skillData,"scriptNum", ''), ';')
        data.isAoe = parse_number(skillData,"isAoe", 0) == 1
        data.triggerRule = parse_number(skillData,"triggerRule", 0)
        -- data.ignoreTaunt = parse_number(skillData,"ignoreTaunt", 0) == 1
        data.skillTags = Tools.splitToNum(parse_string(skillData,"skillTags", ''), ';')--技能标记自身是追击还是连击等

        data.action = parse_number(skillData,"action", 0)
        
        
        -- data.effectCondition1 = ParseUtils.ParseInt(skillData,"effectCondition1")
        -- data.effectTarget1 = ParseUtils.ParseInt(skillData,"effectTarget1")
        -- data.effect1 = ParseUtils.ParseInt(skillData,"effect1")
        -- data.effectCondition2 = ParseUtils.ParseInt(skillData,"effectCondition2")
        -- data.effectTarget2 = ParseUtils.ParseInt(skillData,"effectTarget2")
        -- data.effect2 = ParseUtils.ParseInt(skillData,"effect2")
        -- data.effectCondition3 = ParseUtils.ParseInt(skillData,"effectCondition3")
        -- data.effectTarget3 = ParseUtils.ParseInt(skillData,"effectTarget3")
        -- data.effect3 = ParseUtils.ParseInt(skillData,"effect3")
        data.label = parse_number(skillData,"label", 0)--标签（1、buff 2、进攻3、debuff 4、恢复）
        data.skillStarMax = parse_number(skillData,"skillStarMax", 0)--最大星级
        data.hitRatio = Tools.splitToNum(parse_string(skillData,"hitRatio", ''), ';')--伤害or治疗多段系数
        if #data.hitRatio <= 0 then
            data.hitRatio = {1}
        end
        

        -- data.starEffect1 = ParseUtils.ParseInt(skillData,"starEffect1")--附加效果对于星级的要求
        -- data.starEffect2 = ParseUtils.ParseInt(skillData,"starEffect2")
        -- data.starEffect3 = ParseUtils.ParseInt(skillData,"starEffect3")

        -- data.extraCondition = Tools.splitToNum(parse_string(skillData,"extraCondition", ''), ';')--额外条件类型（此字段直接填写枚举的ID）
        -- data.castCondition = Tools.splitToNum(parse_string(skillData,"castCondition", ''), ';')--消耗条件（此字段直接填写枚举的ID）
        
        tableFile = BattleConfig:GetSetting(AutoIds.IdSetting269)
        -- local key = ParseUtils.ParseInt( tf:GetByPrimaryKey(string.format("%s_%s_%s", skillId, star, lv)), 'id' )
        local key = string.format("%s_%s", skillId, star)
        if data.skillType == 3 then
            -- 如果是大招，只读1级的数据
            key = string.format("%s_%s", skillId, 1)
        end

        -- print("skill lv", key)
        local skillLvData = tableFile:GetByPrimaryKey(key)
        -- local skillLvData = nil
        -- local length = tableFile:GetRowCount()
        -- for i=1,length do
        --     local row = tableFile:GetRow(i)
        --     if skillId == ParseUtils.ParseInt(row,"skillId") and lv == ParseUtils.ParseInt(row,"lv") then
        --         skillLvData = row
        --         break
        --     end
        -- end
        assert(skillLvData, "Can not found skill level data: id:"..skillId.." lv:"..star)

        data.cd = parse_number(skillLvData,"cd", 0)
        -- data.mp = parse_number(skillLvData,"mp", 0)
        data.disAtkNum = parse_number(skillLvData,"disAtkNum", 0)--解体槽伤害值
        -- data.powerNum = parse_number(skillLvData,"powerNum", 0)--战斗强化点消耗
        -- data.effectConditionPara1 = Tools.splitToNum(ParseUtils.ParseString(skillLvData,"effectConditionPara1"), ';', ',')
        -- data.effectConditionPara2 = Tools.splitToNum(ParseUtils.ParseString(skillLvData,"effectConditionPara2"), ';', ',')
        -- data.effectConditionPara3 = Tools.splitToNum(ParseUtils.ParseString(skillLvData,"effectConditionPara3"), ';', ',')
        -- data.extraConditionPara = Tools.splitToNum(parse_string(skillLvData,"extraConditionPara", ''), ';', ',')
        -- data.castConditionPara = Tools.splitToNum(parse_string(skillLvData,"castConditionPara", ''), ';', ',')
        -- data.stackTime1 = parse_number(skillLvData,"stackTime1")
        -- data.stackTime2 = parse_number(skillLvData,"stackTime2")
        -- data.stackTime3 = parse_number(skillLvData,"stackTime3")

        data.subEffects = {}
        for i=1,Constants.SkillSubEffectCount do
            local effect = {
                effectId = parse_number(skillData,"effect"..i, 0),
                effectCondition = parse_number(skillData,"effectCondition"..i, 0),
                effectTarget = parse_number(skillData,"effectTarget"..i, 0),
                starEffect = parse_number(skillData,"starEffect"..i, 0),
                effectConditionPara = Tools.splitToNum(parse_string(skillLvData,"effectConditionPara"..i, ''), ';', ','),
                stackTime = parse_number(skillLvData,"stackTime"..i, 0),
                effectType = parse_number(skillData,"effectType"..i, 0),
            }

            table.insert(data.subEffects, effect)
        end

        -- self.skillDatas[uid] = data
    -- end
    return data
end

function Core:GetTriggerData( triggerId )
    local data = self.triggerDatas[triggerId]
    if not data then
        local tableFile = BattleConfig:GetSetting(AutoIds.IdSetting265)
        local cfg = tableFile:GetByPrimaryKey(triggerId)
        assert(cfg, "找不到触发器数据::"..triggerId)
        data = {}
        data.mainType = parse_number(cfg,"mainType", 0)
        data.condition = {}
        data.conditionIsTrue = {}
        data.condition[1] = parse_number(cfg,"condition1", 0)
        data.conditionIsTrue[1] = parse_number(cfg,"condition1IsTure", 0)
        data.condition[2] = parse_number(cfg,"condition2", 0)
        data.conditionIsTrue[2] = parse_number(cfg,"condition2IsTure", 0)
        data.condition[3] = parse_number(cfg,"condition3", 0)
        data.conditionIsTrue[3] = parse_number(cfg,"condition3IsTure", 0)
        data.condition[4] = parse_number(cfg,"condition4", 0)
        data.conditionIsTrue[4] = parse_number(cfg,"condition4IsTure", 0)
        data.condition[5] = parse_number(cfg,"condition5", 0)
        data.conditionIsTrue[5] = parse_number(cfg,"condition5IsTure", 0)
        data.isFinal =  parse_number(cfg,"isFinal", 0)

        -- 条件合法化
        self:ValidateCondition(data)

        self.triggerDatas[triggerId] = data
    end
    return data
end

--- 条件合法化
---@param data any
function Core:ValidateCondition(data)
    local mainType = data.mainType
    if mainType == Constants.TriggerMainType.Attack then
        -- 主条件10如果没有133的子条件，默认添加一个133的子条件，默认的行为是只有主效果生效
        local subType = Constants.TriggerSubType.SkillEffectSourceType
        local has = self:CheckHasCondition(data, subType)
        if not has then
            self:AddCondition(data, { type = subType, isTrue = 1 })
        end
    elseif mainType == Constants.TriggerMainType.BeAttack then
        -- 主条件20如果没有133的子条件，默认添加一个133的子条件，默认的行为是只有主效果生效
        local subType = Constants.TriggerSubType.SkillEffectSourceType
        local has = self:CheckHasCondition(data, subType)
        if not has then
            self:AddCondition(data, { type = subType, isTrue = 1 })
        end
    end
end

function Core:CheckHasCondition(data, subType)
    for i, conditionType in ipairs(data.condition) do
        if conditionType == subType then
            return true
        end
    end
    return false
end

function Core:AddCondition(data, newCondition)
    local emptyIndex = nil
    for i, conditionType in ipairs(data.condition) do
        if conditionType == 0 then
            emptyIndex = i
        end
    end
    if isNotNull(emptyIndex) then
        data.condition[emptyIndex] = newCondition.type
        data.conditionIsTrue[emptyIndex] = newCondition.isTrue
    end
end

--@return [Game.Setting.Vo.TargetTypeVo#TargetTypeVo]
function Core:GetTargetData( type )
    local data = self.targetDatas[type]
    if not data then
        local setting = BattleConfig:GetSettingVo(AutoIds.IdSetting262, "TargetTypeVo")
        data = setting:Get(type)
        self.targetDatas[type] = data
    end
    return data
end

--@return [Game.Setting.Vo.DamageTypeVo#DamageTypeVo]
function Core:GetDamageData( damageTypeId )
    local data = self.damageDatas[damageTypeId]
    if not data then
        local setting = BattleConfig:GetSettingVo(AutoIds.IdSetting276, "DamageTypeVo")
        --@RefType [Game.Setting.Vo.DamageTypeVo#DamageTypeVo]
        data = setting:Get(damageTypeId)
        self.damageDatas[damageTypeId] = data
    end
    return data
end

--@return [Game.Setting.Vo.WaveVo#WaveVo<>]
function Core:GetLevelData( levelId )
    if not levelId or levelId == 0 then
        return {}
    end
    if not self.levels then
        self.levels = {} 
    end
    if self.levels[levelId] then
        return self.levels[levelId]
    end

    if self.initData and self.initData.questMonster then
        -- 服务器下发阵容表的替换数据，使用服务器数据构建waveVo
        local levels = {}
        local levelData = self.initData.questMonster
        for i, waveData in ipairs(levelData) do
            levels[i] = self:ConvertWaveData2WaveVo(waveData)
        end
        self.levels[levelId] = levels
        return levels
    else
        -- 服务器没有替换数据，直接读本地表格
        local setting = BattleConfig:GetSettingVo(AutoIds.IdSetting24, "WaveVo")
        -- local levelVo = 
        local tableFile = BattleConfig:GetSetting(AutoIds.IdSetting24)
        local length = tableFile:GetRowCount()
        local levels = {}
        for i=1,length do
            local row = tableFile:GetRow(i)
            if row:Get('id') == tostring(levelId) then
                levels[ tonumber(row:Get('wave')) ] = setting:Get(row:Get('index'))
            end
        end
        self.levels[levelId] = levels
        return levels
    end
end

--@return [Game.Setting.Vo.WaveEndConditionVo#WaveEndConditionVo]
function Core:GetWaveEndConditionData( conditionId )
    -- if conditionId == 0 then
    --     return nil
    -- end
    -- if self.levels then
    --     return self.levels
    -- end
    local setting = BattleConfig:GetSettingVo(AutoIds.IdSetting755, "WaveEndConditionVo")
    local data = setting:Get(conditionId)
    return data
end

function Core:GetBattleConditionData(conditionTypeId)
    local setting = BattleConfig:GetSettingVo(AutoIds.IdSetting756, "WaveEndConditionTypeVo")
    local data = setting:Get(conditionTypeId)
    return data
end

--根据提供的效果子类型，获得直接伤害的脚本
--@TODO 2019-10-24 16:45:07 看情况需不需要做缓存,其实Lua的require是会自己做缓存的
function Core:GetDamageHandler( subType )
    --摘到这个特效对应的脚本
    local script = nil
    script = self.damageScripts[subType]
    if not script then
        script = self.damageScriptBase
        -- xpcall(function ()
        --     --如果写了脚本就调用此脚本
        --     script = require('Game.Battle.Script.DamageEffect.DamageScript'..subType)
        -- end,function ()
        --     --如果没写则调用默认脚本
        --     script = self.damageScriptBase
        -- end)
    end
    
    -- self.damageScripts[subType] = script
    return script
end

local ComboResult = {
    Yes = 1,
    No = 2,
    Maybe = 3,
}

--获取出来卡牌的combo
function Core:GetCardCombo( cardComboTypes )
    --记录一个连携结果
    local results = nil

    --记录combo数量
    local combos = {}

    local ptr = 1
    --按照顺序遍历
    local len = #cardComboTypes
    --最后个没必要去检查了
    results = {}
    local isNext = false
    for i = 1,len do
        local result = self:__CheckResultIsCombo(cardComboTypes, ptr, i)
        -- print('combo result', result, ptr, i)
        --如果结果不会终结连携，就记录下来继续往下遍历
        if result == ComboResult.Yes 
            or result == ComboResult.Maybe then
            table.insert(results, result)
        else
            --如果终结连携，则去除记录头部底部的暂定类型，剩下超过两个，则算连携
            local combo = self:__CheckCombos(results, ptr)
            if combo then
                table.insert(combos, combo)
            end
            results = {}
            ptr = i
            --自己还需要再测试一遍
            local result = self:__CheckResultIsCombo(cardComboTypes, ptr, i)
            if result == ComboResult.Yes 
                or result == ComboResult.Maybe then
                table.insert(results, result)
            end
            -- print(table.toString(result, 'combo'))
        end
        --跳过连携卡牌继续遍历
    end
    --所有卡牌遍历完之后，也需要触发一次判定
    local combo = self:__CheckCombos(results, ptr)
    if combo then
        table.insert(combos, combo)
    end

    return combos
end

--把连携信息转换成技能顺序对应的combo数
function Core:CardComboResultToCombos( comboResult, cardComboTypes )
    local combos = {}
    for i,v in ipairs(cardComboTypes) do
        if v ~= Constants.CardComboType.X then
            --在comboResult中找到自己
            local c = 1
            for k,combo in ipairs(comboResult) do
                local comboCount = #combo
                for j,index in ipairs(combo) do
                    if index == i then
                        c = comboCount
                    end
                end
            end
            table.insert(combos, c)
        end
    end
    return combos
end

function Core:__CheckCombos( results, head )
    local cs = self:__CheckComboResult(results)
    if #cs >= 2 then
        --可以判定连携，加入combos记录
        local combo = {}
        for j,csItem in ipairs(cs) do
            table.insert(combo, j + head - 1)
        end
        return combo
    end
end

--检查已经获取的结果是否可以形成连携
function Core:__CheckComboResult( combos )
    --去除头和尾的待定，获得真实结果
    local cs = table.link({}, combos)
    if #cs <= 0 then
        return {}
    end
    while cs[1] == ComboResult.Maybe do
        table.remove(cs, 1)
    end

    for i,v in fipairs(cs) do
        if v == ComboResult.Maybe then
            table.remove(cs, i)
        else
            break
        end
    end

    return cs
end

function Core:__CheckResultIsCombo( cardComboTypes, head, index )
    --从后往前找到第一个非SP的卡，计算连携
    local CardComboType = Constants.CardComboType
    if #cardComboTypes <= 0 then
        return ComboResult.No
    end
    local t = cardComboTypes[index]


    if index <= head then
        return (t ~= CardComboType.SP and t ~= CardComboType.X and t ~= CardComboType.D) and ComboResult.Yes or ComboResult.No
    end

    for i=index-1, head, -1 do
        local t1 = cardComboTypes[i]
        if t1 ~= CardComboType.SP then
            return self:__ChecIsCombo(t1, t, index - i)
        end
    end
    return ComboResult.No
end

function Core:__ChecIsCombo( t1, t2, range )
    --如果两个里有一个X则直接取消
    local CardComboType = Constants.CardComboType
    if t1 == CardComboType.X or t2 == CardComboType.X then
        return ComboResult.No
    end

    --如果两个里有一个sp，则算maybe
    if t1 == CardComboType.SP or t2 == CardComboType.SP then
        return ComboResult.Maybe
    end

    --如果都是ABCD，则按照跨度计算
    return ( (t2 - t1) == range) and ComboResult.Yes or ComboResult.No
end

--- 计算伤害前改写属性
---@param buffMgr any
---@param attr any
---@param trigData any
---@param target any
function Core:RefreshAttrWithType2(buffMgr, attr, trigData, target)
    local sa = {}
    for k,v in pairs(Constants.AttrAdditionIdType) do
        sa[tostring(v)] = 0
    end

    buffMgr:WalkAllBuffEffects(function ( buffEffect )
        --只有属性变更类buff需要计算
        if buffEffect.data.mainEffectType == Constants.BuffType.AttributeChange
        and ((buffEffect.buff.data.refresh == 0) or (buffEffect.buff.data.refresh == 1)) then
            sa[tostring(buffEffect.data.subEffectType)] = sa[tostring(buffEffect.data.subEffectType)] + buffEffect.value * buffEffect.buff.layNum
        end
    end)

    buffMgr:TrigBuffType2(function(buffEffect)
        if buffEffect.data.mainEffectType == Constants.BuffType.AttributeChange then
            sa[tostring(buffEffect.data.subEffectType)] = sa[tostring(buffEffect.data.subEffectType)] + buffEffect.value * buffEffect.buff.layNum
        end
    end, trigData, target)

    attr.subValues = sa

    -- 锁定属性
    local idDict = buffMgr:GetLockAttrIds()
    if table.count(idDict) > 0 then
        attr:LockAttr(idDict)
    end

    attr:RefreshNowValues()

    -- 解锁属性
    if table.count(idDict) > 0 then
        attr:UnlockAttr()
    end

    return attr
end

--刷新buff所添加的属性
function Core:RefreshAttr( buffMgr, attr )
    local sa = {}
    for k,v in pairs(Constants.AttrAdditionIdType) do
        sa[tostring(v)] = 0
    end

    buffMgr:WalkAllBuffEffects(function ( buffEffect )
        --只有属性变更类buff需要计算
        if buffEffect.data.mainEffectType == Constants.BuffType.AttributeChange
        and ((buffEffect.buff.data.refresh == 0) or (buffEffect.buff.data.refresh == 1)) then
            sa[tostring(buffEffect.data.subEffectType)] = sa[tostring(buffEffect.data.subEffectType)] + buffEffect.value * buffEffect.buff.layNum
        end
    end)

    attr.subValues = sa

    -- 锁定属性
    local idDict = buffMgr:GetLockAttrIds()
    if table.count(idDict) > 0 then
        attr:LockAttr(idDict)
    end

    attr:RefreshNowValues()

    -- 解锁属性
    if table.count(idDict) > 0 then
        attr:UnlockAttr()
    end

    return attr
end

function Core:RefreshStatus( buffMgr, statusAbility )
    --过滤所有的状态变更类Buff
    for k,v in pairs(Constants.StatusAbility) do
        statusAbility[k] = true
    end
    local StatusType = Constants.BuffType.Status

    buffMgr:WalkAllBuffEffects(function ( buffEffect )
        if buffEffect.data.mainEffectType == StatusType then
            local abilitys = Core:GetStatusAbility(buffEffect.data.subEffectType)
            --如果有一个buff禁止某样能力，则所有能力都被禁止
            for k,v in pairs(Constants.StatusAbility) do
                if not abilitys[k] then
                    statusAbility[k] = false
                end
            end
        end
    end)

    return statusAbility
end

function Core:RefreshUnique( buffMgr )
    local maxs = {}

    local _betterThan = function(buffEffect1, buffEffect2)
        -- 先比较value
        local result1 = math.abs(buffEffect1.value * buffEffect1.buff.layNum)
        local result2 = math.abs(buffEffect2.value * buffEffect2.buff.layNum)
        if result1 == result2 then
            -- 再比较配表参数
            local config1 = math.abs(buffEffect1.data.effectNum1[1])
            local config2 = math.abs(buffEffect2.data.effectNum1[1])
            if config1 == config2 then
                -- 再比较回合数
                local remainRound1 = math.abs(buffEffect1.buff.remainRound)
                local remainRound2 = math.abs(buffEffect2.buff.remainRound)
                return remainRound1 > remainRound2
            else
                return config1 > config2
            end
        else
            return result1 > result2
        end
    end

    buffMgr:WalkAllBuffEffects(function ( buffEffect )
        if buffEffect.isUnique then
            local key = buffEffect.data.multiType
            local maxBuff = maxs[key]
            
            if maxBuff == nil or _betterThan(buffEffect, maxBuff)  then
            -- if maxBuff == nil or math.abs(buffEffect.data.effectNum1[1]) > math.abs(maxBuff.data.effectNum1[1])  then
                --替代
                maxs[key] = buffEffect
                buffEffect.enable = true
                if maxBuff then
                    maxBuff.enable = false
                end
                
            else
                buffEffect.enable = false
            end
        end
    end, true)
end

function Core:RefreshScreen(buffMgr)
    --先标记所有inactive到active
    local Inactive = Constants.BuffState.Inactive
    for i,v in ipairs(buffMgr._buffs) do
        if v.state == Inactive then
            v.state = Constants.BuffState.Active
            buffMgr:CheckUpdate(v)
        end
    end

    local ScreenBuff = Constants.BuffType.ScreenBuff
    --找到所有的screen类型，遍历buff标记,数量不多，直接就循环嵌套遍历了
    buffMgr:WalkAllBuffEffects(function (buffEffect)
        if buffEffect.data.mainEffectType == ScreenBuff then
            buffMgr:WalkAllBuff(function (buff)
                --遍历是否不处理带屏蔽类型的buff，防止循环
                if buffEffect:IsScreen(buff) and not buff:HasBuffEffectType(ScreenBuff) then
                    buff.state = Inactive
                    buffMgr:CheckUpdate(buff)
                end
            end)
        end
    end)
end

function Core:GetAttributeEstimateValue( attrId, attrValue )
    local tableFile = BattleConfig:GetSetting(AutoIds.IdSetting46)
    local cfg = tableFile:GetByPrimaryKey(attrId)
    if not cfg then
        return 0
    end
    local combatEff = parse_number(cfg,"combatEff", 0) or 0
    return attrValue * combatEff
end

function Core:GetProjectile( projectileId )
    -- print(projectileId)
    local setting = BattleConfig:GetSettingVo(AutoIds.IdSetting275, "BulletVo")
    --@RefType [Game.Setting.Vo.BulletVo#BulletVo]
    local bulletVo = setting:Get(projectileId)
    -- print(projectileId, table.toString(bulletVo, "bulletVo"))
    assert(bulletVo, "找不到对应的子弹配置:"..projectileId)

    local switch = {
        [Constants.BulletType.OneWay] = function (  )
            return import('Game.BattleView.Script.Projectile.NormalOneWayProjectile'), bulletVo
        end,
        [Constants.BulletType.Back] = function (  )
            return import('Game.BattleView.Script.Projectile.NormalBackProjectile'), bulletVo
        end
    }
    return switch[bulletVo.bulletType]()
end

function Core:IsSameTypeBuff( buff1, buff2 )
    return buff1.mainEffectType == buff2.mainEffectType
        and buff1.subEffectType == buff2.subEffectType
        and buff1.miniEffectType == buff2.miniEffectType
end

function Core:IsBuffType( buff, mainEffectType, subEffectType, miniEffectType )
    return buff.mainEffectType == mainEffectType
        and buff.subEffectType == subEffectType
        and buff.miniEffectType == miniEffectType
end

function Core:DamageCanCrit(damageTags)
    return not self:DamageFitTag(damageTags, Constants.DamageTag.AntiCrit)
end

function Core:IsDamageAlwaysHit(damageTags)
    return self:DamageFitTag(damageTags, Constants.DamageTag.Accurate)
    -- return damageType == Constants.DamageType.Accurate or damageType == Constants.DamageType.Real or damageType == Constants.DamageType.Indirect
end

function Core:DamageCanBeBounced(damageTags)
    return not self:DamageFitTag(damageTags, Constants.DamageTag.AntiBounce)
end

function Core:DamageCanAbsorb(damageTags)
    return not self:DamageFitTag(damageTags, Constants.DamageTag.AntiAbsorb)
end

function Core:DamageFitTag(damageTags, targetTag)
    if not damageTags or #damageTags <= 0 then
        return false
    end
    for i,tag in ipairs(damageTags) do
        if tag == targetTag then
            return true
        end
    end
    return false
end

--返回值，第一个参数表示是否命中，第二个表示是否抵抗(为了显示考虑，不要出现没抵抗数值也有抵抗的情况)
function Core:CheckEffectHit(attacker, target, rate)
    if rate < 0 or not attacker then
        return true
    end
    if not target then
        return false
    end
    local k = Core:GetBattleParamNum(Constants.BattleParam.BuffDodgeParam)
    local hit = attacker:GetAttr(Constants.AttrTypeId.EffectHit) / k
    local dodge = target:GetAttr(Constants.AttrTypeId.EffectDodge) / k

    local expRate = rate * (1 + hit)
    local finalRate = expRate / (1 + dodge)
    if finalRate >= 1 then
        return true
    elseif finalRate <= 0 then
        return false
    else
        local r = Core.Random()
        return r <= finalRate, (r <= expRate and r > finalRate )
    end
end

-- 获取触发器子条件环境数据
function Core:GetTriggerEnvData(triggerSubType)
    local envData = self.triggerEnvData[triggerSubType]
    if envData == nil then
        envData = {}
        self.triggerEnvData[triggerSubType] = envData
    end
    return envData
end

-- 获取伪随机状态数据的key
function Core:GetPseudoRandomKey(trigData)
    local key = nil
    if trigData.trigger ~= nil then
        -- buff触发时构造key
        local buffId = trigData.trigger.id
        local trigType = trigData.triggerType

        key = tostring(buffId) .. "_" .. tostring(trigType)
    end
    return key
end

-- 默认的伪随机概率算法
function Core:DefaultPseudoRandom(randomData)
    local validate = function(data)
        if data.validated then return end

        data.originRate = data.originRate ~= nil and data.originRate or 0                   
        data.increaseRate = data.increaseRate ~= nil and data.increaseRate or 0.1
        data.regressionRate = data.regressionRate ~= nil and data.regressionRate or 0
        data.randTimes = data.randTimes ~= nil and data.randTimes or 1
        data.hasSucceed = data.hasSucceed ~= nil and data.hasSucceed or false
        data.validated = true
    end

    validate(randomData)

    local originRate = randomData.originRate            -- 初始概率
    local increaseRate = randomData.increaseRate        -- 概率增量
    local regressionRate = randomData.regressionRate    -- 回归值

    local baseRate = randomData.hasSucceed and regressionRate or originRate

    local finalRate = baseRate + increaseRate * (randomData.randTimes - 1)

    printInfo("[伪随机] id：" .. tostring(randomData.id) .. "  实际概率：" .. tostring(finalRate) .. "  随机次数：" .. tostring(randomData.randTimes))

    if finalRate >= 1 then
        randomData.randTimes = 1
        randomData.hasSucceed = true
        return true
    elseif finalRate <= 0 then
        randomData.randTimes = randomData.randTimes + 1
        return false
    else
        local r = Core.Random()
        if r <= finalRate then
            randomData.randTimes = 1
            randomData.hasSucceed = true
            return true
        else
            randomData.randTimes = randomData.randTimes + 1
            return false
        end
    end
end

-- 注册一个伪随机，返回伪随机标识id
function Core:RegisteredPseudoRandom(randomData)
    self.pseudoRandomBaseId = self.pseudoRandomBaseId + 1
    self.pseudoRandomList[self.pseudoRandomBaseId] = randomData

    randomData.id = self.pseudoRandomBaseId     -- debug用的，在随机的时候可以知道是哪一个id的

    return self.pseudoRandomBaseId
end

-- 使用标识id的状态数据进行一次伪随机
function Core:PseudoRandom(pseudoRandomId)
    local randomData = self.pseudoRandomList[pseudoRandomId]
    if randomData == nil then
        printError("没有找到伪随机id: " .. tostring(pseudoRandomId))
        return false
    end
    if randomData.pseudoRandomFunc == nil then
        randomData.pseudoRandomFunc = Bind(self, self.DefaultPseudoRandom)
    end
    return randomData.pseudoRandomFunc(randomData)
end

--- 获取大招的升级参数
---@param lv any
function Core:GetSPSkillMainEffectUpgradeParam(lv)
    local tableFile = BattleConfig:GetSetting(AutoIds.IdSetting1202)
    local row = tableFile:GetRow(lv)
    if row then
        return parse_number(row,"para1", 1)
    else
        return 1
    end
end

--- 获取猫球主动技能参数
---@param catId any
---@param star any
function Core:GetSkillCatSkillParam(catId, star)
    local tableFile = BattleConfig:GetSetting(AutoIds.IdSetting6031)     -- 猫球升星表
    local key = string.format("%d%02d", catId, star)
    local starData = tableFile:GetByPrimaryKey(key)
    local skillId = parse_number(starData, "SkillId", 100100)

    local tableFile1 = BattleConfig:GetSetting(AutoIds.IdSetting6032)    -- 猫球主动技能参数表
    local paramData = tableFile1:GetByPrimaryKey(skillId)

    local skillParam = {}
    skillParam.initCD = parse_number(paramData, "initCD", 0)
    skillParam.skillCD = parse_number(paramData, "skillCD", 0)
    skillParam.maxNum = parse_number(paramData, "maxNum", 0)
    skillParam.aiSlotIndex = parse_number(paramData, "skillOrder", 1)   -- 开启自动时的出牌位置

    return skillParam
end

--- 获取战力碾压参数
---@param groupId number 组别
---@param ratio number 比值
function Core:GetOverwhelmParam(groupId, ratio)
    ratio = checkNumber(ratio)
    local tableFile = BattleConfig:GetSetting(string.format("%s%s",AutoIds.IdSetting287, "IDGroup"))    -- 战力碾压反解表
    local row = tableFile:GetByPrimaryKey(tostring(groupId))
    local ratios = parse_strings(parse_string(row, "ratios"), ",")
    -- 看玩家的比值在表里对应到哪个区间的index
    local index = 1
    for idx, rto in ipairs(ratios) do
        if ratio > checkNumber(rto) then
            index = idx
        end
    end
    -- 根据index获取碾压表的id
    local ids = parse_strings(parse_string(row, "ids"), ",")
    local id = ids[index]

    -- 读碾压表
    local tableFile1 = BattleConfig:GetSetting(AutoIds.IdSetting287)    -- 战力碾压表
    local row1 = tableFile1:GetByPrimaryKey(id)
    local giveDamage = parse_number(row1, "damageAddition", 0)
    local takeDamage = parse_number(row1, "damageReduction", 0)

    return giveDamage, takeDamage
end

--- 筛选主目标（buff表 triggerClickType字段 2和3）
---@param buff any
---@param effectID any
---@param attacker any
---@param target any
function Core:BuffTriggerSkillSelectTarget(buff, effectID, attacker, target)
    local t
    --判定主目标，新增了规则
    local TriggerClickType = Constants.TriggerClickType
    if buff.data.triggerClickType == TriggerClickType.AI then
        --找到卡牌对应的技能
        local skillCardData = Core:GetSkillCardData(effectID)
        t = AI:ChooseSkillTarget(attacker, skillCardData)
    elseif buff.data.triggerClickType == TriggerClickType.SelectFirstTarget then
        --根据获取第一个目标作为点选目标
        local targets = Core:SelectTargets(buff.data.effectTarget, attacker, target or attacker, BattleMgr.roles)
        if #targets > 0 then
            t = targets[1]
        else
            t = nil
        end
    end
    if BattleMgr.BATTLE_FILTER_SHOW_LOG then
        print(BattleMgr:GetBuffTrigSpan() .. "[筛选] 触发技筛选主目标 触发buffId:".. buff.buffID, " 触发技能牌Id:".. effectID or -1, " 目标选定规则 " .. buff.data.triggerClickType, 
        " 主体 " .. attacker.id, "  客体 " .. (target and target.id or "null"), "  目标 " .. (t and t.id or "null"))
    end
    return t
end

--- 把服务器下发的波次数据转换为客户端的waveVo
---@param waveData any
function Core:ConvertWaveData2WaveVo(waveData)
    waveData = DeepCopy(waveData)
    waveData.Get = function (self, header_name, defaultV)
        return self[header_name] or ""
    end
    waveData.GetPrimaryKey = function (self)
        return self.id
    end
    local WaveVo = import("Game.Setting.Vo.WaveVo")
    local waveVo = WaveVo.New()
    waveVo:FillVo(waveData)
    return waveVo
end

--根据条件判断是否使用复写技能
function Core:GetOverwirteSkill(skillCardData, attacker, mainTarget, star)
    local Trigger = import('Game.Battle.Core.Trigger')
    local canOverwrite = false
    local overwriteIndex = -1
    for i, overCondition in fipairs(skillCardData.overCondition) do
        canOverwrite = Trigger.CheckTrigger(overCondition, Constants.TriggerMainType.Direct, attacker, mainTarget, {}, skillCardData.overConditionParam[i] )
        if canOverwrite then
            overwriteIndex = i
            break
        end
    end
    
    local skillId = nil
    local skillStar = skillCardData.skillType == 3 and 1 or star    -- 大招卡技能不会改变，永远只读1星的数据
    if canOverwrite then
        skillId = skillCardData.overSkills[skillStar][overwriteIndex]
    else
        skillId = skillCardData.orginSkills[skillStar]
    end
    return skillId
end

return Core