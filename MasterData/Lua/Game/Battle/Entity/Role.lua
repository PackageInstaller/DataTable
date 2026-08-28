--
-- Author:luqucheng
-- Date: 2019-10-17 14:29:45
--
---@class Game.Battle.Entity.Role
local Role = {}
local gameUtils = CS.GameUtils
local BaseClass = import('Game.Battle.Core.BaseClass')
local Skill = import('Game.Battle.Core.Skill')
local BuffMgr = import('Game.Battle.Core.BuffMgr')
---@type RoleContextData
local RoleContextData = import('Game.Battle.Data.RoleContextData')
local Attr = Constants.AttrTypeId
Role = Class("Role")
Role.id = nil
Role.moudleId = nil --模板id，用于读取initdata数据的id，一般情况下和id是相同的，召唤物的话，两个值会不同
Role.typeId = nil
--@RefType [Game.Battle.Core.Attribute#Attribute]
Role.attr = nil--角色属性类
Role.elementType = 1--元素类型
Role.camp = nil--阵营
--@RefType [Game.Battle.Core.BuffMgr#BuffMgr]
Role.buffMgr = nil--buff管理器
Role.nowAction = 0--当前行动值
Role.continualCount = 0--在敌方行动之前，连续行动的次数
Role.skills = nil--角色的所有技能
Role.career = 0 --职业，对应Constants.CareerType
Role.standPosition = 0--站位
Role.skill1 = nil--普攻
Role.skill2 = nil--二技能
Role.skill3 = nil--大招

Role.catType = nil--猫种
Role.characterId = nil --角色id，海外版跟猫种id是多对一的关系了

Role.monsterClass = nil--类型（1 小怪 2 精英怪 3BOSS）
Role.roleType = nil --角色类型(1英雄，2怪物，3特殊召唤物，4npc)
Role.lv = nil

Role.ultraStar = nil

Role.isPlayer = false --是否是玩家的角色
Role.force = 100--战斗力
Role.nowPose = 100--当前解体值
Role.nowMp = 100--当前蓝量
Role.ultraPoint = 0--大招积攒值

Role.weakCount = 0 --当前已经解体的次数
Role.weakMaxCount = 0 --最大可解体次数

Role.skillCardInfos = nil
Role.rawData = nil
Role.isSummonCreep = false --是否是召唤生物
Role.maxUltraPoint = nil --最大大招点数
Role.killerId = nil --击杀自己的人
Role.playerId = nil

function Role:__init()
    -- printInfo("init")
    -- copy super getter
end

function Role:InitWithData( data, camp, pos, roleType )
    -- print(table.toString(data,"role data"))
    self.rawData = data
    self.id = data.id
    self.moudleId = data.id
    self.camp = camp
    self.standPosition = pos
    self.isPlayer = data.cardId ~= nil
    self.typeId = data.cardId or data.enemyId
    self.elementType = data.attribute
    self.lv = data.level
    self.weakCount = 0
    self.weakId = data.weakId
    self.career = data.career
    self.weakMaxCount = self:GetMaxWeakCount()
    self.skillCardInfos = {}
    self.skills = {}
    --获得怪物类型
    self.monsterClass = data.type or 0
    self.killerId = -1000
    self.roleType = roleType
    self.playerId = data.playerId or BattleInfo:GetDefaultPlayerId(self.camp)

    self.race = Core:GetCharacterRace(self.typeId, not self.isPlayer)
    self.catType = Core:GetCatType(self.typeId, not self.isPlayer)
    self.characterId = Core:GetCharacterId(self.typeId, not self.isPlayer)

    local Attribute = import('Game.Battle.Core.Attribute')
    -- print(data.attr, 'attr')

    self.attr = Attribute.New(data.attr)
    self.attr:RefreshNowValues()

    if data.currentHp then
        --从数据中传入的当前血量
        self:ChangeNowHp(data.currentHp)
    else
        self:ChangeNowHp(self:GetAttr(Constants.AttrTypeId.Hp ))
    end

    self.spPointType = 1    -- 1 正常的sp点 2 红色的sp点

    if data.currentEnergy then
        self.ultraPoint =  checkNumber(data.currentEnergy)
    else
        self.ultraPoint = 0
    end

    self.maxUltraPoint = 6
    ---MODIEFY LIYAJIE 如果玩家，去角色卡牌表中去最大值，如果怪物去怪物类型表中去取
    if data.maxSP then
        self.maxUltraPoint = checkNumber(data.maxSP)
    end
    self.pose = self:GetAttr(Constants.AttrTypeId.Pose)

    -- self.skills = { Skill.New(self, 3, 1, 1) }
    -- self.skill1 = self.skills[1]

    --技能初始化
    for k,v in pairs(data.generalSkills) do
        if not Tools.isNullKey(v) then
            self.skillCardInfos[tonumber(k)] = {id = v, lv = 1}
        end
    end

    local ultraInfo = Tools.splitToNum( data.finalSkills, '=')
    self.ultraStar = ultraInfo[2]
    self.skillCardInfos[0] = {id = ultraInfo[1], lv = 1}

    --@TODO 2019-12-04 16:10:39 初始自带的被动技能

    self.buffMgr = BuffMgr.New(self)

    -- 保存角色的一些需要记录的数据
    self.roleContextData = RoleContextData.New(self.id)
end


function Role:OnEnter(  )
    if isNotNull(self.rawData.catId) then
        -- 猫球不需要给自己添加被动buff
        return
    end
    --被动添加
    local data = self.rawData
    if data.passiveSkills and data.passiveSkills ~= "" then
        --添加被动
        local passives = string.slice( data.passiveSkills, '&')
        for i,v in ipairs(passives) do
            local p = Tools.splitToNum( v, '=')
            self.buffMgr:AddBuff(self, Core:GetBuffData(p[1], p[2], 1), 1, {buffSourceType = p[3]})
        end
        self.buffMgr:AfterChangeBuff()
    end
end

--- 上帝的初始化
---@param id any
---@param camp any
function Role:AgentInit( id, camp )
    self.camp = camp
    self.elementType = 0
    self.lv = 1
    self.weakCount = 0
    self.weakMaxCount = 0
    self.typeId = -1
    self.id = id
    self.playerId = BattleInfo.campOnePlayerIds[1]

    local Attribute = import('Game.Battle.Core.Attribute')
    -- print(data.attr, 'attr')
    self.attr = Attribute.New(Constants.AttrTypeId.Hp .."=1")
    self.attr:RefreshNowValues()
    self:ChangeNowHp(self:GetAttr(Constants.AttrTypeId.Hp ))
    self.ultraPoint = 0
    -- self.skills = { Skill.New(self, 3, 1, 1) }
    -- self.skill1 = self.skills[1]
    self.skills = {}
    self.skillCardInfos = {}
    self.buffMgr = BuffMgr.New(self)

    -- 保存角色的一些需要记录的数据
    self.roleContextData = RoleContextData.New(self.id)
end

--- 猫球初始化
function Role:CatInit(data, camp)
    self.rawData = data
    self.camp = camp
    self.elementType = 0            -- 元素类型默认为无
    self.lv = 1
    self.weakCount = 0
    self.weakMaxCount = 0
    self.typeId = -1
    self.id = data.id
    self.playerId = data.playerId
    self.skillCatType = data.type    -- 1:主动 2:被动

    -- print(data.attr, 'attr')
    local Attribute = import('Game.Battle.Core.Attribute')
    self.attr = Attribute.New(data.attr)
    self.attr:RefreshNowValues()
    self:ChangeNowHp(self:GetAttr(Constants.AttrTypeId.Hp))
    self.ultraPoint = 0
    self.maxUltraPoint = 0
    self.skills = {}
    if not string.isEmpty(data.finalSkills) then
        local ultraInfo = Tools.splitToNum( data.finalSkills, '=')
        self.ultraStar = ultraInfo[2]
        self.skillCardInfos = {}
        self.skillCardInfos[0] = {id = ultraInfo[1], lv = ultraInfo[2]}
    end
    
    self.buffMgr = BuffMgr.New(self)

    -- 保存角色的一些需要记录的数据
    self.roleContextData = RoleContextData.New(self.id)
end

-- function Role:FindRoleClass(  )
--     if not self.isPlayer then
--         --获取怪物表
--         local row = tableFile:GetByPrimaryKey(self.typeId)
--         return tonumber(row:Get("class"))
--     end
-- end

-- function Role:FindElement(  )
--     local tableFile = nil
--     if self.isPlayer then
--     else
--     end
--      --获取属性
--      local row = tableFile:GetByPrimaryKey(self.typeId)
--      return tonumber(row:Get("attribute"))
-- end

--获取最大可解体次数
function Role:GetMaxWeakCount(  )
   local weakId = self.weakId
    if Tools.isNullKey(self.weakId) then
        return 0
    end

    --读取弱点
    local setting = BattleConfig:GetSettingVo(AutoIds.IdSetting568, "WeakVo")
    --@RefType [Game.Setting.Vo.WeakVo#WeakVo]
    local weakVo = setting:Get(weakId)

    if not weakVo then
        return 0
    end
    return #weakVo.weakStars
end

function Role:GetRolePlayer()
    return BattleMgr:GetPlayer(self.playerId)
end

function Role:GetCardMgr()
    return self:GetRolePlayer():GetCardMgr(self)
end

function Role:IsBoss( )
    return self.monsterClass >= Constants.RoleClass.Elite
end

function Role:IsMonster()
    return self.roleType == Constants.RoleType.Monster
end

function Role:IsSpecialSummon()
    return self.roleType == Constants.RoleType.SpecialSummon
end

function Role:IsDead(  )
    return self:GetNowHp() <= 0
end

function Role:CanBeSelected(  )
    return not self:IsDead() and self.buffMgr.statusAbility.canBeSelected
end

function Role:CanBeClickedByFriend(  )
    return self:CanBeSelected() and self.buffMgr.statusAbility.canFriendClick
end

function Role:CanBeClickedByEnemy(  )
    return self:CanBeSelected() and self.buffMgr.statusAbility.canEnemyClick
end

function Role:CanBeClicked( attacker )
    if attacker.camp == self.camp then
        return self:CanBeClickedByFriend()
    else
        return self:CanBeClickedByEnemy()
    end
end

--角色是否可以行动
function Role:CanAction(  )
    return not self:IsDead() and self.buffMgr.statusAbility.canAction
end

--@return [Game.Battle.Core.Skill#Skill]
function Role:GetSkill( skillId, star, lv )
    star = star or 1
    lv = lv or 1
    for i,v in ipairs(self.skills) do
        if skillId == v.skillId and v.star == star then
            return v
        end
    end

    lv = lv or 1
    local skill = Skill.New(self, skillId, star, lv)
    table.insert(self.skills, skill)

    return skill
end

function Role:GetSkillCardIdByIndex(index)
    local skillCardInfo = self.skillCardInfos[index]
    assert(skillCardInfo, "找不到对应的技能"..index)

    return skillCardInfo.id
end

function Role:GetSkillCardDataByIndex(index)
    local skillCardId = self:GetSkillCardIdByIndex(index)
    return Core:GetSkillCardData(skillCardId)
end

--@return [Game.Battle.Core.Skill#Skill]
function Role:GetSkillByIndex( index, star )
    local skillCardInfo = self.skillCardInfos[index]
    assert(skillCardInfo, "找不到对应的技能"..index)

    return self:GetSkill(skillCardInfo.id, star, skillCardInfo.skillLv)
end

function Role:GetIndexBySkillCardId( skillCardId )
    for i,info in pairs(self.skillCardInfos) do
        -- print("GetIndexBySkillId", info.skillId, i)
        if skillCardId == info.id then
            return i
        end
    end
    if self.skillCardInfos[0] and skillCardId == self.skillCardInfos[0].id then
        return 0
    end
    
    -- assert(false, "找不到对应的技能:"..skillId)
    return -1
end

function Role:CanSkillCardBeUsed(index)
    local skillCardId = self:GetSkillCardIdByIndex(index)
    local skillCardData = Core:GetSkillCardData(skillCardId)
    return skillCardData:CanDischarge(self)
end

function Role:CanSkill( )
    -- body
    return not self:IsDead() and self.buffMgr.statusAbility.canAction
end

function Role:UseSkillAddSP(skillCardData, star, isInputSkill)
    --释放技能后回调，增加能量点
    --根据星级，并且只能是主动技能
    if isInputSkill then
        if not skillCardData:IsUltra() and self.buffMgr.statusAbility.canSkillGetSPPoint then

            -- 效果100;13;1 携带者使用自身的Num1（1/2）号技能牌时无法获得sp
            local index = self:GetIndexBySkillCardId(skillCardData.id)
            local canGet = self.buffMgr:SkillCardCanGetSP(index)
            if not canGet then
                return
            end

            local add = Constants.ReleaseCardPoint[star]
            self:SetUltraPoint(self.ultraPoint + add, Constants.AddSPType.Skill)
        end
    end
end

function Role:OnUseSkillCard(skillCardData, star, isInputSkill)
    if skillCardData:IsUltra() then
        local cardMgr = self:GetCardMgr()
        if cardMgr then
            local recs = cardMgr:RemoveRoleCard(self.id, 0)
            RecordMgr:AddRecords(recs)
        end
    end
end

function Role:BeforeSkillEnd(skillCardData, star, isInputSkill)
    if skillCardData:IsUltra() then
        --是大招的情况下，需要消耗能量点
        self:SetUltraPoint(0, Constants.AddSPType.Skill)
    end
end

-- function Role:CanCounter(  )
--     return not self:IsDead() and self.buffMgr.statusAbility.canCounter
-- end

-- function Role:CanCombo(  )
--     return not self:IsDead() and self.buffMgr.statusAbility.canCombo
-- end

function Role:IsSkillInCD( skillId )
    return self:GetSkill(skillId):IsInCD()
end

--所有技能减少一个回合
function Role:TurnAllSkillCD(  )
    for i,v in ipairs(self.skills) do
        if v:IsInCD() then
            v.nowCD = v.nowCD - 1
        end
    end
end

--属性
function Role:GetAttr( attrType )
    return self.attr:GetValue(attrType)
end

function Role:GetGiveSpecialDamage(damageTypeId)
    return self.attr:GetGiveSpecialDamage(damageTypeId)
end

function Role:GetTakeSpecialDamage(damageTypeId)
    return self.attr:GetTakeSpecialDamage(damageTypeId)
end

function Role:GetGiveRaceDamage(targetRace)
    return self.attr:GetGiveRaceDamage(targetRace)
end

function Role:GetTakeRaceDamage(attackerRace)
    return self.attr:GetTakeRaceDamage(attackerRace)
end

function Role:GetGiveDotDamage(dotSubType)
    return self.attr:GetGiveDotDamage(dotSubType)
end

function Role:GetTakeDotDamage(dotSubType)
    return self.attr:GetTakeDotDamage(dotSubType)
end

function Role:GetBaseAttr( attrType )
    return self.attr:GetOriginValue(attrType)
end

function Role:GetSubAttr(attrType)
    return self.attr:GetSubValue(attrType)
end

function Role:GetNowHp( )
    return self:GetAttr(Attr.NowHp)
end

function Role:GetNowHPPercent(  )
    return self:GetAttr(Attr.NowHp) / self:GetAttr(Attr.Hp)
end

function Role:ChangeNowHp( deltaHp, attacker )
    local nowHp = self:GetNowHp()
    local temp = nowHp
    local maxHp = self:GetAttr(Attr.Hp)

    nowHp = nowHp + deltaHp
    nowHp = math.range(nowHp, 0, maxHp)

    if nowHp <= 0 and temp > 0 then
        -- 临死前，血量还未清零时。(此时触发buff，可以通过选择目标找到这个临死的角色，因为他的血量此时还大于零)
        local killer = nil
        if attacker then
            local killerId = attacker.id
            killer = Core:FindRole(killerId)
        end
        BattleMgr:Trig(self, Constants.TriggerMainType.BeforeDead, {}, killer)
        BattleMgr:TrigAll(Constants.TriggerMainType.BeforeOtherDead, {}, self)
    end

    self.attr:SetValue(Attr.NowHp, nowHp)
    if nowHp <= 0 and temp > 0 then
        --死亡
        if attacker then
            self.killerId = attacker.id
        end
        BattleMgr:OnRoleDead(self)
    end
    return nowHp - temp
end


function Role:ForceSetNowHp( hp, attacker )
    if hp <= 0 and attacker then
        self.killerId = attacker.id
    end
    self.attr:SetValue(Attr.NowHp, hp)
end

function Role:GetNowPose(  )
    return self.nowPose
end

function Role:ChangeNowPose( deltaPose )
    self.nowPose = self.nowPose + deltaPose
    if self.nowPose >= self:GetAttr(Constants.AttrTypeId.Pose) then
        --解体值满触发
        BattleMgr:Trig(self, Constants.TriggerMainType.PoseMax, nil, self)
    end
end
--解体
function Role:BreakPose(  )
    self.nowPose = 0
    BattleMgr:Trig(self, Constants.TriggerMainType.PoseBreak, nil, self)
end

function Role:GetNowMp(  )
    return self.nowMp
end

function Role:ChangeMp( deltaMp )
    self.nowMp = self.nowMp + deltaMp
end

function Role:SetUltraPoint( p , type)
    --如果角色身上有不能增加sp点数的效果，则sp增加是无效的
    if p > self.ultraPoint and not self.buffMgr.statusAbility.canGetSPPoint then
        return
    end
    if self.spPointType == 1 then
        local oldPoint = self.ultraPoint
        self.ultraPoint = math.range( p, 0, self.maxUltraPoint)
        RecordMgr:AddRecord(RecordMgr.UltraPointChangeRecord.New(self, type))
        if oldPoint ~= self.ultraPoint then
            local changePoint = self.ultraPoint - oldPoint
            BattleMgr:Trig(self, Constants.TriggerMainType.SPChange, {spChangeSourceType = type, changePoint = changePoint}, self)
        else
            BattleMgr:Trig(self, Constants.TriggerMainType.SPChange2, {spChangeSourceType = type, changePoint = p - self.ultraPoint}, self)
        end
    else
        -- 红色sp点
        if type == Constants.AddSPType.UnitCard then
            -- 合卡变成不加sp
        elseif type == Constants.AddSPType.Skill then
            -- 技能变成减少sp
            local oldPoint = self.ultraPoint
            local changePoint = p - self.ultraPoint
            local newPoint = self.ultraPoint - changePoint
            self.ultraPoint = math.range(newPoint, 0, self.maxUltraPoint)
            RecordMgr:AddRecord(RecordMgr.UltraPointChangeRecord.New(self, type))
            if oldPoint ~= self.ultraPoint then
                BattleMgr:Trig(self, Constants.TriggerMainType.SPChange, {spChangeSourceType = type, changePoint = -changePoint}, self)
            else
                BattleMgr:Trig(self, Constants.TriggerMainType.SPChange2, {spChangeSourceType = type, changePoint = -changePoint}, self)
            end
        elseif type == Constants.AddSPType.SkillEffect then
            -- 技能效果不变
        end
    end
end

--- 修改sp点的上限
---@param newMax any
function Role:ChangeUltraPointMax(newMax)
    local from = self.maxUltraPoint
    self.maxUltraPoint = newMax
    self.ultraPoint = math.min(self.ultraPoint, self.maxUltraPoint)
    RecordMgr:AddRecord(RecordMgr.UltraPointMaxChangeRecord.New(self, from, newMax))
end

function Role:GetUltraPoint(  )
    return self.ultraPoint
end

function Role:IsUltraPointMax(  )
    return self.ultraPoint >= self.maxUltraPoint
end

function Role:ChangeElement( element )
    if not element then
        return
    end
    self.elementType = element
    RecordMgr:AddRecord(RecordMgr.ChangeElementRecord.New(self.id, element))
end

function Role:LogAttribute(  )
    local w = self.attr:ToString()
    print( self.typeId .. ":\n" .. "Level: " .. self.lv .. "\n" .. w)
end

--进攻能力估算值
function Role:GetOffenseAbilityEstimateValue(  )
    --估算输出能力=【角色攻击力*属性定义表的combatEff字段系数+角色穿透*属性定义表的combatEff字段系数+角色命中*属性定义表的combatEff字段系数+角色暴击值*属性定义表的combatEff字段系数+角色暴伤值*属性定义表的combatEff字段系数】*技能修正系数按照【估算输出能力】进行技能牌的降序
    return self.attr:GetOffenseAbilityEstimateValue()
end

function Role:GetHealAbilityEstimateValue(  )
    return self.attr:GetHealAbilityEstimateValue()
end


--状态(是否可以攻击等)
--buff管理器
--拥有的主动技能

--释放技能
--收到攻击


return  Role