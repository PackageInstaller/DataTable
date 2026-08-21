
---@class AutoChessSkill
local AutoChessSkill = class("AutoChessSkill")

local acMgr = AutoChessManager.instance()
---@class AutoChessSkillHander
---@field OnStart fun(self:AutoChessSkillHander, skill:AutoChessSkill)?
---@field OnUpdate fun(self:AutoChessSkillHander, skill:AutoChessSkill, dt:number)?
---@field OnCastPoint fun(self:AutoChessSkillHander, skill:AutoChessSkill)?
---@field OnComplete fun(self:AutoChessSkillHander, skill:AutoChessSkill)?
---@field OnBreak fun(self:AutoChessSkillHander, skill:AutoChessSkill)?

---@param owner AutoChessEntity
---@param skillId integer
function AutoChessSkill:ctor(owner, skillId, handler)
	self.owner = owner
	self.skillId = skillId
	self.targetId = nil
	---@type AutoChessEntity?
	self.target = nil
	---@type Vector3
	self.releasePos = Vector3.New()
	---@type number 技能持续时间
	self.elapsed = 0

	---@type boolean
	self.isComplete = false
	---@type boolean  是否已经释放点
	self.hasCastPoint = false

	---@type int[]
	self.bulletIds = {}
	---@type int[]
	self.summonIds = {}
	---@type int 当前技能攻击次数
	self.curHitCount = 0

	---@type AutoChessSkillTable
	self.skillCfg = Config.GetAutoChessSkillTable(skillId)
	if self.skillCfg == nil then
		self.isComplete = true
	end
	local handerName = "Skill_Default"
	if self.skillCfg ~= nil and not string.isNullOrEmpty(self.skillCfg.script) then
		handerName = self.skillCfg.script
	end
	---@type Skill_Default
	self.hander = require(handerName)
end

---释放技能
---@param targetId int? 目标id
---@param releastPos Vector3? 释放位置
function AutoChessSkill:Start(targetId, releastPos)
	self:ClearCache()
	self.isComplete = false
	self.targetId = targetId
	self.curHitCount = 0
	---@type AutoChessEntity
	self.target = nil
	if targetId ~= nil then
		self.target = acMgr:GetEntity(targetId)
	end

	self.releasePos:Set(0, 0, 0)
	if releastPos ~= nil then
		self.releasePos:Set(releastPos:Get())
	end

    if self.releasePos:SqrMagnitude() <= 1e-10 then
		if self.target ~= nil then
			self.releasePos:Set(self.target:GetPosition():Get())
		else
			self.releasePos:Set(self.owner:GetPosition():Get())
		end
	end

	local skillPayload = {
        caster = self.owner,
        target = self.target,
        skillId = self.skillId, 	-- 假设你的 Skill 类里存了技能 id
        releasePos = self.releasePos
    }
    self.owner.buffControl:TakeEvent(GE.AutoChessCombatEvent.OnSkillCast, skillPayload)
	self.hander:OnStart(self, targetId, releastPos)
end

---@param dt number
function AutoChessSkill:Update(dt)
	if self.isComplete then
		return
	end
	local cfg = self.skillCfg
	self.elapsed = self.elapsed + dt
	local preTime = cfg.preTime

	local curHit = self.curHitCount
	local t = self.elapsed - preTime


	local directHitCount = cfg.attackHitCount
	directHitCount = math.max(directHitCount, 1)
	local directHitInterval = cfg.attackHitInterval

	while self.curHitCount < directHitCount and t >= (self.curHitCount * directHitInterval) do
        self:ExecuteSkillEffect()
    end

	local finalEndTime = preTime + cfg.postTime
	local maxTime = preTime + directHitCount * directHitInterval
	finalEndTime = math.max(finalEndTime, maxTime)	

	if self.elapsed >= finalEndTime then
		self:Complete()
	end
	self.hander:OnUpdate(self, dt)
end


--- 每一次触发伤害周期时执行的逻辑
function AutoChessSkill:ExecuteSkillEffect()
    local cfg = self.skillCfg
	self.curHitCount = self.curHitCount + 1
    if self.curHitCount == 1 then
		self:AddSummons()
        self:AddSelfBuffs()
		self:FireBullets()
		self:AddTargetBuffs()
	else
		if cfg.bulletEmitType == 1 then  --表示每次都释放子弹
			self:FireBullets()
		end
		self:AddTargetBuffs()
    end
	self:ExecuteDirectDamage()
	self.hander:OnExecuteSkillEffect(self)
end


---发射子弹
function AutoChessSkill:FireBullets()
    local cfg = self.skillCfg
	if cfg.addBullets == nil then
		return
	end
	---创建子弹
	local addBullets = self.skillCfg.addBullets
	for i = 1, #addBullets do
		local id = addBullets[i]
		local bullet = acMgr:CreateBullet(id, self.owner, self.skillId)
		if bullet ~= nil then
			table.insert(self.bulletIds, bullet:GetUID())
		else
			table.insert(self.bulletIds, 0)
		end
	end
end

---添加怪物
function AutoChessSkill:AddSummons()
    local cfg = self.skillCfg
	if cfg.addSummons == nil then
		return
	end
	---创建召唤物
	local addSummons = self.skillCfg.addSummons
	for i = 1, #addSummons do
		local id = addSummons[i]
		local summoner = acMgr:CreateSummoner(id, self.owner, self.skillId)
		if summoner ~= nil then
			table.insert(self.summonIds, summoner:GetUID())
		else
			table.insert(self.summonIds, 0)
		end
	end
end


---添加主角buff
function AutoChessSkill:AddSelfBuffs()
    local cfg = self.skillCfg
	if cfg.addBuffs == nil then
		return
	end
	---添加状态
	local buffs = self.skillCfg.addBuffs
	for i = 1, #buffs do
		local id = buffs[i]
		acMgr:AddBuff(self.owner:GetUID(), id, self.owner:GetUID())
	end
end

---添加目标buff
function AutoChessSkill:AddTargetBuffs()
    local cfg = self.skillCfg
	if cfg.targetAddBuffs == nil then
		return
	end
	---添加状态
	local buffs = self.skillCfg.targetAddBuffs
	for i = 1, #buffs do
		local id = buffs[i]
		acMgr:AddBuff(self.targetId, id, self.owner:GetUID())
	end
end


---执行技能扣血逻辑
---寻找技能范围内的敌人进行扣血
function AutoChessSkill:ExecuteDirectDamage()



	local cfg = self.skillCfg
	if cfg.attackHitType == 0 then
		return
	end
	local selectEntities = nil
	if cfg.selectShapeType == nil or tablex.empty(cfg.selectShapeType) then
		selectEntities = {self.target}
	else
		local type = cfg.selectShapeType[1]
		if type == GE.AutoChessSelectShape.Circle then
			local r = cfg.selectShapeType[2]
			selectEntities = acMgr:GetEntitiesInRange(self.releasePos, r, self.owner, self.skillCfg.targetMask, nil)
		elseif type == GE.AutoChessSelectShape.Rect then
			local w = cfg.selectShapeType[2]
			local h = cfg.selectShapeType[3]
			selectEntities = acMgr:GetEntitiesInRectangle(self.releasePos, self.owner:GetRotation(), h, w, self.owner, self.skillCfg.targetMask, nil)
		elseif type == GE.AutoChessSelectShape.Ring then
			local r = cfg.selectShapeType[2]
			local minR = cfg.selectShapeType[3]
			selectEntities = acMgr:GetEntitiesInRing(self.releasePos, r, minR, self.owner, self.skillCfg.targetMask, nil)
		end
	end

	if selectEntities == nil then
		return
	end




	----TODO aoe 前

	for i = 1, #selectEntities do
		self:AttackDamage(selectEntities[i])
	end

---AOE后




end

---子弹攻击目标
---@param target AutoChessEntity
function AutoChessSkill:AttackDamage(target)
    if target == nil or target.destroyed or target.isDead then 
        return
    end
    local caster = self.owner
    if caster == nil then 
        return
    end

    local skillCfg = self.skillCfg
    -- 2. 提取伤害参数
    local baseDamage = skillCfg.baseDamage
    local damageType = skillCfg.damageType
	---@type number
    local casterAtk = 0
    if skillCfg.adRate ~= 0 then
        casterAtk = casterAtk + caster:GetAttribute(GE.AutoChessAttributeType.bombard) * skillCfg.adRate
    end
    if skillCfg.apRate ~= 0 then
        casterAtk = casterAtk + caster:GetAttribute(GE.AutoChessAttributeType.torpedo) * skillCfg.apRate
    end
    local initialDamage = baseDamage + casterAtk


    local damageInfo = {
        value = initialDamage,
        type = damageType,
		skillId = self.skillId,
        caster = caster,
        source = caster,
    }
    --- 进行护甲扣除
    target:TakeDamage(damageInfo)
	
end

---技能完成
function AutoChessSkill:Complete()
	if self.isComplete then
		return
	end
	self.isComplete = true
	self.hander:OnComplete(self)
	self:ClearCache()
end


---被打断
function AutoChessSkill:Break()
	if self.isComplete then
		return
	end
	self.isComplete = true
	self.hander:OnBreak(self)
	self:ClearCache()
end

function AutoChessSkill:ClearCache()
	self.bulletIds = {}
	self.summonIds = {}
	self.curHitCount = 0
	self.releasePos:Set(0, 0, 0)
	self.hasCastPoint = false
	self.target = nil
	self.targetId = 0
	self.elapsed = 0
end


return AutoChessSkill
