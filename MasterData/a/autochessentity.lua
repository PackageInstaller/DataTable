---@type AutoChessMoveController
local AutoChessMoveController = require("AutoChessMoveController")
local AutoChessSkillController = require("AutoChessSkillController")
local AutoChessAIController = require("AutoChessAIController")
local AutoChessBuffController = require("client.Main.Assets.Content.Lua.GameScene.AutoChess.Controller.AutoChessBuffController")

---@class AutoChessEntity
local AutoChessEntity = class("AutoChessEntity")

local acMgr = AutoChessManager.instance()

---@type Vector3
local temp_v3 = Vector3.New()
---@param data AutoChessEntityInfo
function AutoChessEntity:ctor(data)
    self.data = data
	self.uid = data.uid
	self.id = data.id

	---@type boolean 是否已经删除
	self.destroyed = false
	---@type boolean 是否已经死亡
	self.isDead = false

	---@type UnityEngine.GameObject
	self.rootObj = nil
	---@type UnityEngine.GameObject
	self.modelObj = nil
	---@type RoleModelController?
	self.modelController = nil
	---@type CoveType
	self.entityType = data.entityType
	---@type Vector3
	self.position = Vector3.zero
	if data.gridPos ~= nil then
		local mgr = AutoChessManager.instance()
		local px, pz = mgr:GridPosToWorldPos(data.gridPos.x, data.gridPos.y)
		self.position = Vector3.New(px, 0, pz)
	end

	---@type Vector3
	self.rotation = Vector3.New()

	if data.dir == nil then
		data.dir = {x = 1, y = 0}
	end

	local targetDirection = Vector3.New(data.dir.x, 0, data.dir.y)
	self.rotation = targetDirection
	self:SetRotation(self.rotation)


	---@type int 攻击对象
	self.attackId = 0

	---@type table<AutoChessAttributeType, number> 属性
	self.attributes = {}
	---@type table<string, table> 缓存数据动态技能配置会用到
	self.cacheData = {}
	---@type AutoChessFlag
	self.flags = 0
	---@type table<AutoChessFlag, integer> 标签对应的次数
	self.flagCounts = {}
	self.createTime = acMgr:GetTime()

	---@type table<integer, UnityEngine.GameObject> 特效
	self.effects = {}
	---@type table<integer, {isActive:boolean, isDestroy:boolean}>
	self.tempEffectActiveInfo = {}
end


---@param key string
---@return any
function AutoChessEntity:GetCacheDataVal(key)
	if key == nil then
		return
	end
	if self.cacheData[key] ~= nil then
		return self.cacheData[key]
	end
	return nil
end

---@param key string
---@param val any
function AutoChessEntity:SetCacheDataVal(key, val)
	if key == nil then
		return
	end
	self.cacheData[key] = val
end

function AutoChessEntity:Init()
	self:CreateModel()
	---@type AutoChessSkillController 技能控制
	self.skillController = AutoChessSkillController:new(self)

	---@type AutoChessMoveController 移动控制
	self.moveController = AutoChessMoveController:new(self)

	---@type AutoChessBuffController
	self.buffControl = AutoChessBuffController.new(self)

	---@type AutoChessAIController AI控制
	self.aiController = AutoChessAIController:new(self)
end

function AutoChessEntity:GetUID()
	return self.uid
end

function AutoChessEntity:GetID()
	return self.id
end

function AutoChessEntity:GetSide()
	return self.data.side
end


---@return string
function AutoChessEntity:GetContainerName()
	return ""
end

---@return string
function AutoChessEntity:GetModelPath()
	return ""
end


---@return Vector3
function AutoChessEntity:GetPosition()
	return self.position
end

---@param pos Vector3
function AutoChessEntity:SetPosition(pos)
	self.position:Set(pos.x, pos.y, pos.z)
	if self.rootObj ~= nil then
		self.rootObj.transform.position = pos
	end
end


---@param x number
---@param y number
---@param z number
function AutoChessEntity:SetPositionXYZ(x, y, z)
	self.position:Set(x, y, z)
	if self.rootObj ~= nil then
		self.rootObj.transform.position = self.position
	end
end

---设置移动位置 会重置方向
---@param pos Vector3
function AutoChessEntity:SetMovePosition(pos)
	local oldPos = self:GetPosition()
	temp_v3:Set(oldPos.x, oldPos.y, oldPos.z)
	self:SetPosition(pos)
	if self:HasFlag(GE.AutoChessFlag.eStatus_KeepFacing) then
		return
	end

	temp_v3:Set(pos.x - temp_v3.x, pos.y - temp_v3.y, pos.z -temp_v3.z)
	local dir = temp_v3
	dir:SetNormalize()
	self:SetRotation(dir)
end

---@param dir Vector3 朝向
function AutoChessEntity:SetRotation(dir)
	if dir:SqrMagnitude() <= 1e-10 then
		return
	end
	temp_v3:Set(dir.x, dir.y, dir.z)
	temp_v3:SetNormalize()

	self.rotation:Set(temp_v3.x, temp_v3.y, temp_v3.z)
	local targetRotation = Quaternion.LookRotation(self.rotation)
	if self.rootObj ~= nil then
		self.rootObj.transform.rotation = targetRotation
	end
	self.data.dir.x = math.floor(temp_v3.x * 100)
	self.data.dir.y = math.floor(temp_v3.z * 100)
end

---设置朝向
---@param x number
---@param y number
function AutoChessEntity:SetRotationXY(x, y)
	temp_v3:Set(x, 0, y)
	self:SetRotation(temp_v3)
end


---获取朝向
---@return Vector3
function AutoChessEntity:GetRotation()
	return self.rotation
end

---获取朝向
---@return number x, number y
function AutoChessEntity:GetDir()
	local dir = self.data.dir
	return dir.x, dir.y
end

---获得当前对应的格子信息（按世界坐标四舍五入）
function AutoChessEntity:GetGridPos()
	local pos = self:GetPosition()
	local x, y = AutoChessManager.instance():WorldPosToGridPos(pos.x, pos.z)
	return x, y
end

---逻辑占格：移动中固定为出发格，避免插值中途格坐标抖动导致决策/闪回
---@return integer gx
---@return integer gy
function AutoChessEntity:GetLogicalGridPos()
	local mc = self.moveController
	if mc ~= nil and mc.isMoveing and mc.fromGx ~= nil and mc.fromGy ~= nil then
		return mc.fromGx, mc.fromGy
	end
	return self:GetGridPos()
end


function AutoChessEntity:IsDead()
	if self.isDead or self.destroyed then
		return true
	end
	return false
end

---获得属性
---@param attrType AutoChessAttributeType
---@return number
function AutoChessEntity:GetAttribute(attrType)
	if self.attributes[attrType] ~= nil then
		return self.attributes[attrType]
	end
	return 0
end

---设置属性
---@param attrType AutoChessAttributeType
---@param val number
---@return number
function AutoChessEntity:SetAttribute(attrType, val)
	self.attributes[attrType] = val
	return val
end

---添加属性
---@param attrType AutoChessAttributeType
---@param val number
function AutoChessEntity:AddAttribute(attrType, val)
	local v = self:GetAttribute(attrType)
	v = v + val
	self:SetAttribute(attrType, v)
	return v
end

---是否可以移動
---@return boolean
function AutoChessEntity:CanMove()
	if self:HasFlag(GE.AutoChessFlag.eStatus_Fixed) then
		return false
	end
	return true
end

local atomicFlags = {}
for k, v in pairs(GE.AutoChessFlag) do
	if v > 0 then
		table.insert(atomicFlags, v)
	end
end

---添加flag
---@param flag AutoChessFlag
function AutoChessEntity:AddFlag(flag)
	if flag == GE.AutoChessFlag.eStatus_None then 
		return 
	end
	for k, v in ipairs(atomicFlags) do
		if acMgr:HasFlag(flag, v) then
			-- 1. 计数器自增
			local count = self.flagCounts[v] or 0
			count = count + 1
			self.flagCounts[v] = count

			if count == 1 then
                self.status = self.status + v
			end
		end
	end

end

---移除flag
---@param flag AutoChessFlag
function AutoChessEntity:RemoveFlag(flag)
	if flag <= 0 then 
		return
	end

    for k, v in ipairs(atomicFlags) do
        if acMgr:HasFlag(flag, v) then
            local count = (self.flagCounts[v] or 0)
			count = math.max(0, count - 1)
            self.flagCounts[v] = count
            
            if count == 0 then
                self.status = self.status - v
            end
        end
    end
end


---@param flag AutoChessFlag  判断是否有这个flag
---@return boolean
function AutoChessEntity:HasFlag(flag)
	return acMgr:HasFlag(self.flags, flag)
end


function AutoChessEntity:GetAiName()
	return nil
end

function AutoChessEntity:CreateModel(completeFun)
	if self.destroyed then
		LuaLogger.es("角色已经被删除")
		return
	end

	PoolMgr:Get(self:GetContainerName(), function (rootObj)
		if self.destroyed then
			LuaLogger.es("角色已经被删除")
			PoolMgr.Free(rootObj)
			return
		end

        self.rootObj = rootObj


		local parentRoot = AutoChessManager.instance():GetEntityRoot(self.entityType)
		rootObj:SetParent(parentRoot)
	
		local modelkey = self:GetModelPath()
		PoolMgr:Get(modelkey , function (modelObj)
			if self.destroyed then
				LuaLogger.es("角色已经被删除")
				PoolMgr.Free(modelObj)
				return
			end	
			local modelRoot = self.rootObj.transform:Find("ModelRoot").gameObject
			modelObj.transform:SetParent(modelRoot.transform)
			modelObj.transform.localPosition = Vector3.New(0,0,0)
			modelObj.transform.localRotation = Quaternion.identity
			modelObj.transform.localScale = Vector3.one

			---@type RoleModelController?
			self.modelController = modelObj.transform:GetComponent("RoleModelController")
			modelObj:SetActive(true)
			self.modelObj = modelObj


			local model = modelObj.transform:Find("model")
			if model ~= nil then
				---@type AnimOverCallBack
				local animOverCallBack = model:GetComponent(TypeInfo.AnimOverCallBack)
				if not IsNull(animOverCallBack) then			
					animOverCallBack:SetCallBackOfName(BindCallback_NoParams(self, self.OnAnimOverCallBack))
				end
			end
			if self.modelController ~= nil then
				self.modelController:FadeIn()
			end
			
			self:OnModelLoadFinish()
			if completeFun then
				completeFun()
			end	
		end)
	end)
end

function AutoChessEntity:OnModelLoadFinish()
	self.modelLoadFinish = true
	self:SetPosition(self.position)
	self:SetRotationXY(self.data.dir.x, self.data.dir.y)
end


function AutoChessEntity:OnHit()
	
	
end

function AutoChessEntity:OnDeath()
	self.isDead = true
	----死亡事件回调
	self.buffControl:TakeEvent(GE.AutoChessCombatEvent.OnDeath)
end

function AutoChessEntity:AddEffect(effectId, obj)
	if self.effects[effectId] ~= nil then
		PoolMgr.Free(self.effects[effectId])
		self.effects[effectId] = nil
	end

	local efTemp = self.tempEffectActiveInfo[effectId]
	self.tempEffectActiveInfo[effectId] = nil
	if efTemp ~= nil then
		obj:SetActive(efTemp)
	else
		obj:SetActive(true)
	end
	self.effects[effectId] = obj
end


function AutoChessEntity:RemoveEffect(effectId)
	if self.effects[effectId] == nil then
		return false
	end
	self.tempEffectActiveInfo[effectId] = nil
	local obj = self.effects[effectId]
	PoolMgr.Free(obj)
	self.effects[effectId] = nil
	return true
end


function AutoChessEntity:GetEffect(effectId)
	return self.effects[effectId]
end

function AutoChessEntity:SetEffectActive(effectId, active)
	local effect = self:GetEffect(effectId)
	if effect == nil then
		self.tempEffectActiveInfo[effectId] = active
		return
	end
	if IsNull(effect) then
		self.effects[effectId] = nil
		return
	end
	effect:SetActive(active)
end


function AutoChessEntity:Destroy()
	self.destroyed = true
	if UICommonUtils.Checkobj(self.rootObj) then
		PoolMgr.Free(self.rootObj)
		self.rootObj = nil
	end
	if UICommonUtils.Checkobj(self.modelObj) then
		PoolMgr.Free(self.modelObj)
		self.modelObj = nil
	end

	self.tempEffectActiveInfo = nil
	if self.effects ~= nil then
		for k, v in pairs(self.effects) do
			if not IsNull(v) then
				PoolMgr.Free(v)
			end
		end
		self.effects = nil
	end


	self.modelController = nil
	self.moveController = nil
	self.aiController = nil
end

function AutoChessEntity:OnAnimOverCallBack()
end


function AutoChessEntity:GetMoveSpeed()
	return self:GetAttribute(GE.AutoChessAttributeType.MoveSpeed)
end

function AutoChessEntity:GetHp()
	return self:GetAttribute(GE.AutoChessAttributeType.HP)
end

function AutoChessEntity:GetHpMax()
	return self:GetAttribute(GE.AutoChessAttributeType.MaxHP)
end

function AutoChessEntity:GetMp()
	return self:GetAttribute(GE.AutoChessAttributeType.MP)
end

function AutoChessEntity:GetMpMax()
	return self:GetAttribute(GE.AutoChessAttributeType.MaxMP)
end



function AutoChessEntity:Update(dt)
	if self.moveController ~= nil then
		self.moveController:Update(dt)
	end
	if self.skillController ~= nil then
		self.skillController:Update(dt)
	end
	if self.aiController ~= nil then
		self.aiController:Update(dt)
	end
end

---释放技能
function AutoChessEntity:CastSkill(skillId, targetId, gridPos)
	self.attackId = targetId
	self.skillController:CastSkill(skillId, targetId, gridPos)
end


---移动到目标点
---@param pos Vector3|Vector3[]
---@param cb fun(entity:AutoChessEntity)?
function AutoChessEntity:MoveTo(pos, cb)

	self.moveController:MoveTo(pos, GE.AutoChessMoveType.Point, nil, cb)
end


function AutoChessEntity:PlayAnim(animaName, cb)
	if self.modelController == nil then
		if cb ~= nil then
			cb()
		end
		return
	end

	local animInfo = RoleModelAllAnimType[animaName]
	self.modelController:PlayAnim(animInfo.value, function()
		if cb ~= nil then
			cb()
		end
	end)
end


---获取对应bind点信息（不存在时返回 nil，不报错）
---@param bindType int
---@param bindIndex int
---@return UnityEngine.Transform?
function AutoChessEntity:GetBindPoint(bindType, bindIndex)
	if self.modelController == nil then
		return nil
	end
	bindIndex = bindIndex - 1
	local points = nil
	if bindType == 1 then
		points = self.modelController.shootPoints
	elseif bindType == 2 then
		points = self.modelController.shootPoints2
	elseif bindType == 3 then
		points = self.modelController.hitPoints
	elseif bindType == 4 then
		points = self.modelController.effectPoints
	elseif bindType == 5 then
		points = self.modelController.footPoints
	end
	if points == nil or bindIndex < 0 or bindIndex >= points.Length then
		return nil
	end
	return points[bindIndex]
end

---绑点世界坐标；无绑点时回退到实体当前位置
---@param bindType int
---@param bindIndex int
---@return Vector3
function AutoChessEntity:GetBindPointWorldPos(bindType, bindIndex)
	local trs = self:GetBindPoint(bindType, bindIndex)
	if trs ~= nil and not IsNull(trs) then
		local p = trs.position
		if p ~= nil then
			temp_v3:Set(p.x, p.y, p.z)
			return temp_v3
		end
	end
	return self:GetPosition()
end

---绑点 Transform + 世界坐标；无绑点时回退实体根节点与当前位置（供追踪弹等）
---@param bindType int
---@param bindIndex int
---@return UnityEngine.Transform?
---@return Vector3
function AutoChessEntity:GetBindPointOrRoot(bindType, bindIndex)
	local trs = self:GetBindPoint(bindType, bindIndex)
	if trs ~= nil and not IsNull(trs) then
		local p = trs.position
		if p ~= nil then
			temp_v3:Set(p.x, p.y, p.z)
			return trs, temp_v3
		end
	end
	local pos = self:GetPosition()
	local rootTrs = nil
	if self.rootObj ~= nil and not IsNull(self.rootObj) then
		rootTrs = self.rootObj.transform
	end
	return rootTrs, pos
end




---@class AutoChessDamageInfo
---@field value number
---@field type AutoChessDamageType
---@field skillId integer
---@field target AutoChessEntity     ---技能攻击目标对象
---@field caster AutoChessEntity		----技能释放对象
---@field source AutoChessEntity		----技能释放对象主人对象 没有主人就是技能释放对象
---@field canDead boolean?

---收到伤害
---@param damageInfo AutoChessDamageInfo
function AutoChessEntity:TakeDamage(damageInfo)
	damageInfo.canDead = true
	local caster = damageInfo.caster
	local initialDamage = damageInfo.value

	acMgr:TakeEvent(GE.AutoChessCombatEvent.OnBeforeDamage, damageInfo)


	local hpBefore = self:GetAttribute(GE.AutoChessAttributeType.HP)
	local maxHp = self:GetAttribute(GE.AutoChessAttributeType.MaxHP)
	local hp = hpBefore - initialDamage

	hp = mathx.clamp(hp, 0, maxHp)
	self:SetAttribute(GE.AutoChessAttributeType.HP, hp)
	local mgr = AutoChessManager.instance()

	if hp == 0 then
		----收到致命伤害
		acMgr:TakeEvent(GE.AutoChessCombatEvent.OnFatalDamage, damageInfo)
		if damageInfo.canDead then
			self:OnDeath()
			acMgr:TakeEvent(GE.AutoChessCombatEvent.OnDeath, damageInfo)
		end
	end

	acMgr:TakeEvent(GE.AutoChessCombatEvent.OnAfterDamage, damageInfo)

	if mgr.isBattleing and initialDamage > 0 then
		local AILog = require("AILog")
		AILog.Damage(caster, self, initialDamage, hpBefore, hp, maxHp, hp <= 0)
	elseif mgr.isBattleing and initialDamage < 0 and hp > hpBefore then
		local AILog = require("AILog")
		local skillLabel = nil
		if damageInfo.skillId ~= nil and damageInfo.skillId ~= 0 then
			local skillCfg = Config.GetAutoChessSkillTable(damageInfo.skillId)
			if skillCfg ~= nil and skillCfg.name ~= nil and skillCfg.name ~= "" then
				skillLabel = skillCfg.name
			else
				skillLabel = tostring(damageInfo.skillId)
			end
		end
		AILog.Heal(caster, self, -initialDamage, hpBefore, hp, maxHp, skillLabel)
	end

end

function AutoChessEntity:SetDead()
	self.isDead = true
end


return AutoChessEntity