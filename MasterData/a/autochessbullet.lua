
local base = require("AutoChessEntity")
local acMgr = AutoChessManager.instance()

local temp_v3_1 = Vector3.New()
local temp_v3_2 = Vector3.New()
local temp_v3_3 = Vector3.New()

---@class AutoChessBullet:AutoChessEntity
local AutoChessBullet = class("AutoChessBullet", base)




function AutoChessBullet:ctor(data)
	self.id = data.id
	self.entityType = GE.EntityType.Bullet

    ---@type AutoChessBulletTable
    self.bulletCfg = Config.GetAutoChessBulletTable(self.id)

    local str = self.bulletCfg.script
    if string.isNullOrEmpty(str) then
        str = "Bullet_Default"
    end


    local skillId = self.data.skillId
    local skillCfg = Config.GetAutoChessSkillTable(skillId)
    if skillCfg == nil then
        LuaLogger.es("技能未找到id:" .. tostring(skillId))
        return nil
    end
    self.skillCfg = skillCfg

    ---@type Bullet_Default
    self.handler = require(str)


    ---@type boolean 是否已经发射
    self.isFire = false

    ---@type int 当前穿透次数
    self.pierceCount = 0
    ---@type Vector3 目标位置
    self.targetPos = Vector3.New()
end

---@return string
function AutoChessBullet:GetContainerName()
	return Config.PrefabPath.AutoChessRole
end

function AutoChessBullet:GetModelPath()
    if self.bulletCfg == nil then
        return ""
    end
    return self.bulletCfg.modelPath
end

function AutoChessBullet:SetTargetPos(targetPos)
    self.targetPos:Set(targetPos:Get())
end

function AutoChessBullet:Update(dt)
    base.Update(self, dt)

    local time = acMgr:GetTime()
    local maxLiftTime = self.bulletCfg.maxLiftTime
    if maxLiftTime > 0 and (time - self.createTime) > maxLiftTime then
       acMgr:RemoveEntity(self:GetUID())
       return
    end

    if self.bulletCfg.accel ~= 0 then
       local sp = self:GetMoveSpeed()
       sp = sp + self.bulletCfg.accel * dt
       sp = math.min(sp, self.bulletCfg.maxSpeed)
       self:SetAttribute(GE.AutoChessAttributeType.MoveSpeed, sp)
    end

    self.handler:OnUpdate(self, dt)
    if (not self.isFire) then
        local c = self.createTime + self.bulletCfg.delayTime
        if acMgr:GetTime() > c then
            self:OnFire()
        end
    end
end

function AutoChessBullet:Init()
    base.Init(self)
    local owner = acMgr:GetEntity(self.data.owner)
    if owner == nil then
        LuaLogger.es("子弹主人未找到")
        return
    end
    self.attackId = owner.attackId

    self:SetAttribute(GE.AutoChessAttributeType.MoveSpeed, self.bulletCfg.speed)
    self.handler:OnInit(self)
end

function AutoChessBullet:OnModelLoadFinish()
    base.OnModelLoadFinish(self)
	self.modelObj.transform.localPosition = Vector3.zero
    self.modelObj.transform.localScale = Vector3.one
    self:SetPosition(self.position)

    self.handler:OnModelLoadFinish(self)
end


function AutoChessBullet:SetMovePosition(pos)
    temp_v3_1:Set(self:GetPosition():Get())
    base.SetMovePosition(self, pos)

    if self.bulletCfg.hitCount > 0 then
        local entity = self:RayCastEntity(temp_v3_1, pos)
        if entity ~= nil then
            self:OnHit(entity) 
        end
    end
end

---发射子弹 不需要依赖模型加载完成
function AutoChessBullet:OnFire()
    if self.isFire or self.destroyed then
       return 
    end
    self.isFire = true
    self.handler:OnFire(self)
end

---到达目标点
function AutoChessBullet:OnArrive()
    if self.destroyed then
        return
    end
    self.handler:OnArrive(self)

    self:OnDeath()
end


function AutoChessBullet:OnDeath()
    base.OnDeath(self)
    self.handler:OnDeath(self)
end



---当子弹命中一个具体目标时触发
---@param target AutoChessEntity
function AutoChessBullet:OnHit(target)
    self.handler:OnHit(self, target)
end


---子弹攻击目标
---@param target AutoChessEntity
function AutoChessBullet:AttackDamage(target)
    if target == nil or target:IsDead() then 
        return 
    end
    local caster = acMgr:GetEntity(self.data.owner)
    if caster == nil then 
        return
    end 

    -- 1. 获取技能配置
    local skillId = self.data.skillId
    local skillCfg = Config.GetAutoChessSkillTable(skillId)
    if skillCfg == nil then
        LuaLogger.es("技能未找到id:" .. tostring(skillId))
        return
    end

    -- 2. 提取伤害参数
    local baseDamage = skillCfg.baseDamage
    local damageType = skillCfg.damageType
    local casterAtk = 0
    if skillCfg.adRate ~= 0 then
        casterAtk = casterAtk + caster:GetAttribute(GE.AutoChessAttributeType.bombard) * skillCfg.adRate
    end
    if skillCfg.apRate ~= 0 then
        casterAtk = casterAtk + caster:GetAttribute(GE.AutoChessAttributeType.torpedo) * skillCfg.apRate
    end
    local initialDamage = baseDamage + casterAtk
    initialDamage = initialDamage * self.bulletCfg.damageRate
    initialDamage = math.floor(initialDamage) 

    local damageInfo = {
        value = initialDamage,
        type = damageType,
        skillId = skillId,
        caster = caster,
        source = self,
    }
    --- 进行护甲扣除
    target:TakeDamage(damageInfo)
end

---子弹爆炸伤害
function AutoChessBullet:AttackExplosionDamage()
    -- 1. 获取技能配置
    local skillId = self.data.skillId
    local skillCfg = self.skillCfg
    if skillCfg == nil then
        LuaLogger.es("技能未找到id:" .. tostring(skillId))
        return
    end

    local cfg = self.bulletCfg
    if cfg == nil then
        return
    end

    ---只影响攻击者
    if cfg.isAttackerOnly == 1 then
        local dis = acMgr:GetEnitytDistance(self:GetUID(), self.attackId)
        if dis ~= -1 and dis <= cfg.explosionRadius then
            local entity = acMgr:GetEntity(self.attackId)
            self:AttackDamage(entity)
        else
            ---播放miss特效
            if cfg.missEffect ~= 0 then
                acMgr:PlayEffect(nil, cfg.missEffect, self:GetPosition(), nil, nil, 2)
            end
        end
    else
        acMgr:PlayEffect(nil, cfg.explosionEffect, self:GetPosition(),nil, nil, 2)
        acMgr:DoEntitiesInRange(self:GetPosition(), cfg.explosionRadius,self,  skillCfg.targetMask, function(entity)
            self:AttackDamage(entity)
        end)
    end
end





---子弹检测碰撞
---@param lineStart Vector3
---@param lineEnd Vector3
function AutoChessBullet:RayCastEntity(lineStart, lineEnd)
    
    -- 1. 获取核心向量
    temp_v3_2:Set(lineEnd.x - lineStart.x, 0, lineEnd.z - lineStart.z)
    local lineDir = temp_v3_2

    -- 2. 计算线段的长度平方
    local lineLenSqr = lineDir:SqrMagnitude()
    if lineLenSqr <= 0 then
        return nil
    end

    ---@type number?
    local minDis = nil
    ---@type AutoChessEntity?
    local entity = nil

    local ownerId = self.data.owner
    local owner = acMgr:GetEntity(ownerId)
    if owner == nil then
        return nil
    end

    local skillId = self.data.skillId
    local skillCfg = self.skillCfg
    if skillCfg == nil then
        LuaLogger.es("技能未找到id:" .. tostring(skillId))
        return nil
    end
    local searchMask = skillCfg.targetMask

    local entityTables = acMgr.entityTables
	for uid, target in pairs(entityTables) do
		if target.destroyed or target.isDead then
			goto continue
		end
		if target.entityType == GE.EntityType.Bullet then
			goto continue
		end
        if not acMgr:CheckSearchFilter(owner, target, searchMask) then
            goto continue
        end


        local hitRadius = 0.4
        local ratio = self:GetBulletHitRatio(lineStart, lineEnd, target.position, hitRadius)
        if ratio == nil then
           goto continue 
        end
        if minDis == nil or minDis > ratio then
            minDis = ratio
            entity = target
        end
        ::continue::
	end

    if entity == nil then
        return nil
    end
    return entity
end



---获得碰撞位置
---@param startPoint Vector3
---@param endPoint Vector3
---@param entityPos Vector3 entity位置
---@param radius number 怪物半径
---@return number? ratio 碰撞比例 nil 表示没有碰撞
function AutoChessBullet:GetBulletHitRatio(startPoint, endPoint, entityPos, radius)
    temp_v3_2:Set(endPoint.x - startPoint.x, 0, endPoint.z - startPoint.z)
    local lineDir = temp_v3_2
    temp_v3_3:Set(startPoint.x - entityPos.x, 0, startPoint.z - entityPos.z)
    local startToCenter = temp_v3_3
    ---abc 是二次函数的变量
    local a = lineDir:SqrMagnitude()
    local b = Vector3.Dot(startToCenter, lineDir)
    local c = startToCenter:SqrMagnitude() - (radius * radius)
    if c <= 0 then
        return 0
    end
    local discriminant = b * b - a * c
    if discriminant < 0 then
        return nil
    end
    local t = (-b - math.sqrt(discriminant)) / a
    if t >= 0 and t <= 1 then
        return t
    end
    return nil
end



return AutoChessBullet





