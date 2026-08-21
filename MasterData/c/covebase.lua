

local CoveSkillCtrl = require("CoveSkillCtrl")
local CoveSkillPerformence = require("CoveSkillPerformence")
---@class CoveBase
local CoveBase = class("CoveBase")
function CoveBase:ctor(data)
	self.data = data
	self.uid = data.uid
	self.id = data.id
	---@type CoveRoleController
	self._roleCont  = nil
	---@type ScaleButton
	self._eventBtn = nil
	---@type RoleModelController
	self._model = nil
	---@type UnityEngine.GameObject
	self.modelObj = nil

	---@type CoveType
	self.coveType = CoveType.None

	---@type boolean
	self.modelLoadFinish = false

	---@type Vector3
	self.moveToPos = nil

	---@type CharacterSkinTable
	self.skinCfg = nil

	---@type number 攻击距离
	self.attackRange = 0

	self.maxHp = 0
	self.maxMp = 0
	self.moveSpeed = 0
	---模型形态 0默认  1舰装
	---@type integer
	self.coveModelState = 0

	---@type CoveBattleMonsterAI
	self.aiTree = nil

	---@type FrameTimer
	self.update = nil


	---@type CoveBase
	self.attackTarget = nil
	---@type boolean 是否战斗准备完成
	self.battleReady = nil

	---@type table<integer, integer>
	self.resourceTab = {}

	---@type CoveSkillCtrl
	self.skillCtrl = CoveSkillCtrl:new() 


	---@type table<integer, UnityEngine.GameObject>
	self.effects = {}

	---@type table<integer, {isActive:boolean, isDestroy:boolean}>
	self.tempEffectActiveInfo = {}
	---@type UnityEngine.GameObject 水面idle特效
	self.intoIdleEffect = nil
	---@type boolean 是否在移动
	self.isMoveing = nil

	self.isDead = nil
	self.destroyed = nil

	--会否正处于攻击动画状态
	self.isAttackAnimPlaying = false

	---@type table<string, CoveActionBase>
	self.coveActions = {}

	---@type CoveActionBase
	self.currentAction = nil




	---@type AnimOverCallBack?
	self.animOverCallBack = nil
	---@class AnimOverCallBackEvent
	---@field owner table
	---@field callback fun(key:string)

	---@type AnimOverCallBackEvent[]
	self.animOverCallBackEvent = {}
end

---设置攻击动画状态
--@param bool boolean
function CoveBase:SetAttackAnimState(bool)
	self.isAttackAnimPlaying = bool
end

---获取攻击动画状态
function CoveBase:GetAttackAnimState()
	return self.isAttackAnimPlaying
end

function CoveBase:SetEnableUpdate(isEnable)
	if isEnable then
		if self.update ~= nil then
			return
		end
		self.update = FrameTimer.New(function()
			self:OnUpdate()
		end, 1, -1)
		self.update.aa = "Cove" .. self:GetType()
		self.update:Start()
	else
		if self.update == nil then
			return
		end
		self.update:Stop()
		self.update = nil
	end
end


function CoveBase:GetUID()
	return self.uid
end

function CoveBase:GetID()
	return self.id
end


---@return CoveType 类型
function CoveBase:GetType()
	return self.coveType
end

---@type Vector3
local errorPos = Vector3.New(1000, 1000, 1000)

---@return Vector3
function CoveBase:GetPosition()
	if not self.modelLoadFinish then
		LuaLogger.ws("获取位置错误 id:" .. self:GetID())
		return errorPos
	end
	if IsNull(self._roleObj) then
		LuaLogger.ws("获取位置错误 roleObj == nil id:" .. self:GetID())
		return errorPos
	end
	return self._roleObj.transform.position
end

---@param resType HeroAttributeType
---@return integer
function CoveBase:GetResourceVal(resType)
	return self.resourceTab[resType] or 0
end

---@param resType HeroAttributeType
---@param val integer
function CoveBase:SetResourceVal(resType, val)
	self.resourceTab = self.resourceTab or {}
	self.resourceTab[resType] = val

	self:OnResourceValChangeed(resType, val)
end

---@param resType HeroAttributeType
---@param val integer
function CoveBase:OnResourceValChangeed(resType, val)
	if resType == HeroAttributeType.Hp then
		self:SetEffectActive(1107, (val/ self.maxHp) < 0.3)
	end
end

function CoveBase:GetCoveContainerName()
	return nil
end

function CoveBase:GetCoveModelPath()
	return nil
end

function CoveBase:SetCoveModelState(val)
	LuaLogger.ds("设置模型状态 id:" .. self:GetID() .. "  val:" .. val)
	
	if self.coveModelState == val then
		return
	end
	self.coveModelState = val
	if val ~= 1 then
		if not IsNull(self.intoIdleEffect) then
			self.intoIdleEffect:SetActive(false)
		end
	else
		if not IsNull(self.intoIdleEffect) then
			self.intoIdleEffect:SetActive(not self:IsMoveing())
		end 
	end
	local isActive = false
	if val == 1 and self:IsMoveing() then  --舰装 显示移动水花特效
		isActive = true
	end

	self:SetEffectActive(3000, isActive)
end

---角色是否可以点击
---@return boolean
function CoveBase:RoleCanTouch()
	return false
end

function CoveBase:IsDead()
	return self.isDead == true
end

function CoveBase:IsDestroy()
	return self.destroyed == true
end



function CoveBase:OnUpdate()
	if not self.modelLoadFinish then
		return
	end

	if self.aiTree ~= nil then
		self.aiTree:Update()
	end
end

function CoveBase:createRole(completeFun)
	if self.destroyed then
		LuaLogger.es("角色已经被删除")
		return
	end
	self.isCreate = true

	PoolMgr:Get(self:GetCoveContainerName(), function (roleObj)
		if self.destroyed then
			LuaLogger.es("角色已经被删除")
			PoolMgr.Free(roleObj)
			return
		end
		self._roleObj = roleObj
		self._roleCont = self._roleObj:GetComponent("CoveRoleController")
		self._roleCont:SetRoleId(self.id)
	

		local _eventBtn = roleObj.transform:Find("UIRoot/UICanvas/EventBtnP/EventBtn")
		if _eventBtn ~= nil then
			self._eventBtn = _eventBtn:GetComponent(TypeInfo.ScaleButton)
			self._eventBtn.onClick:RemoveAllListeners()
			self._eventBtn.onClick:AddListener(function()
				self:OnClick()
			end)
		end

		local modelkey = self:GetCoveModelPath()
		PoolMgr:Get(string.format(Config.PrefabPath.RoleModelPrefab, modelkey, modelkey) , function (modelObj)
			if self.destroyed then
				LuaLogger.es("角色已经被删除")
				PoolMgr.Free(modelObj)
				return
			end	
			modelObj.transform.parent = self._roleCont.roleRoot.transform
			modelObj.transform.localPosition = Vector3.New(0,self.skinCfg.modelOffset,0)
			modelObj.transform.localRotation = Quaternion.identity
			modelObj.transform.localScale = Vector3.one * self.skinCfg.modelRate

			self._model = modelObj.transform:GetComponent("RoleModelController")
			modelObj:SetActive(true)
			self.modelObj = modelObj


			local model = modelObj.transform:Find("model")
			self.animOverCallBack = nil
			if model ~= nil then
				---@type AnimOverCallBack
				self.animOverCallBack = model:GetComponent(TypeInfo.AnimOverCallBack)
				if not IsNull(self.animOverCallBack) then			
					self.animOverCallBack:SetCallBackOfName(BindCallback_NoParams(self, self.OnAnimOverCallBack))
				end

			end
			self._model:FadeIn()
			self:OnModelLoadFinish()
			self:doIdleBehavior()
			if completeFun then
				completeFun()
			end	
		end)
	end)
end

function CoveBase:OnModelLoadFinish()
	self.modelLoadFinish = true
	self.intoIdleEffect = self._roleObj.transform:Find("into_Idle_effect").gameObject
	self.intoIdleEffect:SetActive(false)


	local val = self.coveModelState
	if val ~= 1 then
		if not IsNull(self.intoIdleEffect) then
			self.intoIdleEffect:SetActive(false)
		end
	else
		if not IsNull(self.intoIdleEffect) then
			self.intoIdleEffect:SetActive(not self:IsMoveing())
		end 
	end
	self._roleCont.jumpingCallback = BindCallback(self, self.OnJumping)
end

function CoveBase:SetMoveing(isMoveing)
	if self.isMoveing == isMoveing then
		return
	end
	if self.coveModelState == 1 then
		if not IsNull(self.intoIdleEffect) then
			self.intoIdleEffect:SetActive(not isMoveing)
		end
		self:SetEffectActive(3000, isMoveing)
	end
	self.isMoveing = isMoveing
end

function CoveBase:IsMoveing()
	if self.isMoveing == nil then
		return false
	end
	return self.isMoveing
end


---
function CoveBase:OnJumping(startPos, endPos, areaType)

	LuaLogger.ds("角色跳转 id:" .. self:GetID() .. "areaType:" .. tostring(areaType))
	local dis = Vector3.Distance(startPos, endPos)
	local speed = self.moveSpeed
	local time = dis / speed

	local trs = self._roleCont.transform

	
	local isxs = false
	if areaType == 2 then
		--LuaLogger.es("areaType ===去海里=====",areaType)
		isxs = startPos.y > endPos.y
		if not isxs then
			self:SetCoveModelState(0)
		end

	elseif areaType == 3 then
		--LuaLogger.es("areaType ===进入浴室=====",areaType)
		
	elseif areaType == 4 then
		--LuaLogger.es("areaType ===出浴室=====",areaType)
		self:ChangeSkinSwinToNormal(false)
	end
	local dir = endPos - startPos
	dir.y = 0
	dir = Vector3.Normalize(dir)
	self._roleCont.transform.forward = dir

	self:SetDefaultState(self:GetMoveStateVal())
	trs:DOMove(endPos, time):OnComplete(function()
		if areaType == 2 then
			if isxs then	
				self:SetCoveModelState(1)
			end
		elseif areaType == 3 then
			--LuaLogger.es("areaType ===进入浴室==2===",areaType)
			self:ChangeSkinNormalToSwin(false)
		elseif areaType == 4 then
			--LuaLogger.es("areaType ===出浴室=2====",areaType)
			
		end

		
		self:SetDefaultState(self:GetMoveStateVal())
		self._roleCont:SetJumpFinished()
	end)
end

function CoveBase:OnClick()
	

end

-- 随机时间待机行为
function CoveBase:doIdleBehavior()
	if (not self._model) then
		return
	end
	self:SetDefaultState(self:GetIdleStateVal())
end


function CoveBase:MoveTo(pos, callback)
	if self._roleCont == nil then
		return
	end

	LuaLogger.ds(string.format(" lua MoveTo 设置行走点 id:%s  pos:  x:%s y:%s z:%s ", self:GetID(), pos.x, pos.y, pos.z))
	self.moveToPos = pos
	self:SetMoveing(true)
	self._roleCont:RemoveIntervalReached()
	self._roleCont:ClearCurrentTarget()
	self._roleCont:ClearTriggerPath()
	self:SetDefaultState(self:GetMoveStateVal())
	self._roleCont:MoveTo(pos, function()
		self:SetDefaultState(self:GetIdleStateVal())
		self:SetMoveing(false)
		if callback ~= nil then
			callback(self)
		end
	end)
end

---@param areaType NavmeshAreas
function CoveBase:EnableAreaMask(areaType)
	if self._roleCont == nil then
		return
	end
	self._roleCont:EnableAreaMask(areaType)
	--LuaLogger.es("激活跳跃层 id:" .. self:GetID())
end

---@param areaType NavmeshAreas
function CoveBase:DisableAreaMask(areaType)
	if self._roleCont == nil then
		return
	end
	self._roleCont:DisableAreaMask(areaType)
	--LuaLogger.es("关闭跳跃层 id:" .. self:GetID())
end


function CoveBase:MoveTo_Direct(pos, callback)
	if self._roleCont == nil then
		return
	end
	if not self._roleCont.agent.enabled then
		LuaLogger.es("角色行走 agent is disable")
	end

	LuaLogger.ds(string.format(" lua MoveTo_Direct 设置行走点 id:%s  pos:  x:%s y:%s z:%s ", self:GetID(), pos.x, pos.y, pos.z))
	self.moveToPos = pos
	self:SetMoveing(true)
	self:SetDefaultState(self:GetMoveStateVal())
	self._roleCont:MoveTo(pos, function()
		self:SetDefaultState(self:GetIdleStateVal())
		self:SetMoveing(false)
		if callback ~= nil then
			callback(self)
		end
	end)
end

function CoveBase:GetIdleStateVal()
	return RoleAnimStateType.Idle
end

function CoveBase:GetMoveStateVal()
	return RoleAnimStateType.Walk
end



---AI
---@param readType CovePlayerReadyType
---@return boolean
function CoveBase:IsReady(readType)

	---@type table<CovePlayerReadyType, boolean>
	self.readTypeInfo = self.readTypeInfo or {}
	return self.readTypeInfo[readType]
end

---@param readType CovePlayerReadyType
function CoveBase:SetReady(readType, val)
	self.readTypeInfo = self.readTypeInfo or {}
	self.readTypeInfo[readType] = val
end

---@param breakKey CovePlayerReadyType?
function CoveBase:IsAllReady(breakKey)
	if self.readTypeInfo == nil then
		return true
	end
	for k, v in pairs(self.readTypeInfo) do
		if (breakKey == nil or k ~= breakKey) and v then
			return false
		end
	end
	return true
end


function CoveBase:StopMove()
	if self._roleCont == nil then
		return
	end
	self:SetMoveing(false)
	LuaLogger.ds(" 停止移动 id:" .. self:GetID())
	self._roleCont:StopMove()
end


function CoveBase:CreateEffect(effectId)
	self.tempEffectActiveInfo[effectId] = nil

	CoveBattleMgr.instance():playEffect(self:GetUID(), effectId, Vector3.zero, Quaternion.identity)end

function CoveBase:AddEffect(effectId, obj)
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

function CoveBase:GetEffect(effectId)
	return self.effects[effectId]
end

function CoveBase:SetEffectActive(effectId, active)
	local effect = self:GetEffect(effectId)
	if effect == nil then
		self.tempEffectActiveInfo[effectId] = active
		return
	end
	if IsNull(effect) then
		LuaLogger.es("当前特效已被删除 roleId:" .. self.id .. " effectId:" .. effectId)
		self.effects[effectId] = nil
		return
	end
	effect:SetActive(active)
end


---等待对战
function CoveBase:CanWait()
	local isBattle = CoveBattleMgr.instance():IsBattle()
	if not isBattle then
		return true
	end
	local isFight = CoveBattleMgr.instance():IsFight()
	if not isFight then
		return true
	end
	return false
end

function CoveBase:GotoWait()
	self._model:SetDefaultState(self:GetIdleStateVal())

	---@type CoveRole
	local role = {}

end


----索敌
function CoveBase:SetAttackRange(val)
	self.attackRange = val
end
function CoveBase:GetAttackRange()
	return self.attackRange
end

---和敌人的分散距离
---@return number
function CoveBase:GetEnemyAwayDis()
	return 0
end

---和队友的分散距离
---@return number
function CoveBase:GetFriendAwayDis()
	return 0
end

function CoveBase:CanSuodi()
	if not self:IsAllReady(CovePlayerReadyType.suodiing) then
		return false
	end
	if self.attackTarget == nil then
		return true
	end
	if self.attackTarget.destroyed then
		self.attackTarget = nil
		return true
	end

	local dis = Vector3.Distance(self:GetPosition(), self.attackTarget:GetPosition())
	if dis >= self:GetAttackRange() then
		return true
	end

	self:SetReady(CovePlayerReadyType.suodiing, false)
	return false
end

function CoveBase:GotoSuodi()

	if self.attackTarget == nil then
		self.attackTarget = self:SearchAttackTarget()
	end
	if self.attackTarget == nil then
		self:SetReady(CovePlayerReadyType.suodiing, false)
		return
	end

	if self.attackTarget.destroyed then
		self.attackTarget = nil
	elseif not self.attackTarget:CanBeAttacked() then
		self.attackTarget = nil
	end
	if self.attackTarget == nil then
		--停止移动
		self:StopMove()
		self:SetReady(CovePlayerReadyType.suodiing, false)
		return
	end
	local targetPos = self.attackTarget:GetPosition()
	self:SetReady(CovePlayerReadyType.suodiing, true)
	local dis = Vector3.Distance(self:GetPosition(), targetPos)

	if dis < self:GetAttackRange() then
		--停止移动
		--表示角色在岸上
		self:StopMove()
		self:SetReady(CovePlayerReadyType.suodiing, false)
		return
	end

	if self.moveToPos ~= nil then
		if Vector3.Distance(self.moveToPos, targetPos) < 0.2 then
			return
		end
	end
	self:MoveTo(self.attackTarget:GetPosition())
end

---获取攻击对象
---@return CoveBase
function CoveBase:SearchAttackTarget()
	---@type CoveBase[]
	local coveMap = CoveRoleManager.instance():GetAllCoveTab()
	local pos = self:GetPosition()
	local minPos = nil
	local target = nil
	for k, v in pairs(coveMap) do
		if v:GetType() == self:GetType() then
			goto continue
		end
		if not v:CanBeAttacked() then
			goto continue
		end
		local vpos = v:GetPosition()
		local dis = Vector3.Distance(vpos, pos)
		if minPos == nil or minPos > dis then
			minPos = dis
			target = v
		end
		::continue::
	end
	return target
end

function CoveBase:CanAttack()
	if not self:IsAllReady(CovePlayerReadyType.Attacking) then
		return false
	end
	if self.attackTarget == nil then
		--self:SetReady(CovePlayerReadyType.Attacking, false)
		return false
	end

	if not self.attackTarget:CanBeAttacked() then
		self.attackTarget = nil
		--self:SetReady(CovePlayerReadyType.Attacking, false)
		return false
	end

	local dis = Vector3.Distance(self:GetPosition(), self.attackTarget:GetPosition())
	if dis >= self:GetAttackRange() then
		return false
	end
	return true
end

function CoveBase:GotoAttack()
	self:SetReady(CovePlayerReadyType.Attacking, true)
	self:StopMove()

	self._roleObj.transform:LookAt(self.attackTarget:GetPosition())
	local mp = self:GetResourceVal(HeroAttributeType.Mp)
	local skillId = self.skillCtrl:GetCanUseSkillId(mp)
	if skillId == 0 then
		self:SetReady(CovePlayerReadyType.Attacking, false)
		self.attackTarget = nil
		return
	end
	self.skillCtrl:UseSkill(skillId)
	local skillInfo = self.skillCtrl:GetSkillInfo(skillId)
	if skillInfo == nil then
		self:SetReady(CovePlayerReadyType.Attacking, false)
		self.attackTarget = nil
		return
	end

	-- [[
	-- local skillId = 250057 --shootBullet
	-- local skillId = 250022 --justhit
	-- local skillId = 250006 --planeattack --鱼雷机
	-- local skillId = 250004 --bomberattack --轰炸机
	-- local skillId = 250018	--鱼雷
	-- local skillId = 250046	--侧翼攻击
	self.waitSkillCallBackId = self.waitSkillCallBackId or 1
	
	local skillCfg = Config.GetSkillInfo(skillId)
	
	--扣除mp
	local mp = self:GetResourceVal(HeroAttributeType.Mp)
	mp = mp - skillInfo.mpCost
	mp = math.max(mp, 0)
	self:SetResourceVal(HeroAttributeType.Mp, mp)

	--释放技能
	local attackPos = self.attackTarget:GetPosition()
	attackPos = Vector3.New(attackPos.x, attackPos.y, attackPos.z)
	local callBack = BindCallback(self.ReleaseSkillCallBack, self, skillInfo, attackPos)
	LuaLogger.ds("我放技能了" .. self:GetID())
	CoveSkillPerformence.instance():doSkill(self, self.skinCfg, skillCfg, self.attackTarget,0.5, callBack)

	---增加释放技能完成回调
	local xzTime = skillInfo.backSwingTime
	if self.xzTimeId ~= nil then
		self:DeleteWaitTimeExecute(self.xzTimeId)
		self.xzTimeId = nil
	end
	self.xzTimeId = self:AddTimeWait(xzTime, BindCallback(self, self.OnReleastSkillFinish))
end

---释放技能结果回到
---@param skillInfo CoveSkill
---@param attackPos Vector3
function CoveBase:ReleaseSkillCallBack(skillInfo, attackPos)
	if not CoveBattleMgr.instance():IsBattle() then
		LuaLogger.ds("  游戏结束了" .. self:GetID())
		return
	end

	if skillInfo == nil then
		return
	end
	if attackPos == nil then
		return
	end
	
	if self.HomeFightSkillArea == nil then
		self.HomeFightSkillArea = Config.GetConfigInfo("HomeFightSkillArea")
	end
	local attackRange = self.HomeFightSkillArea
	---@type table<integer, CoveBase>
	local coveMap = CoveRoleManager.instance():GetAllCoveTab()
	local pos = attackPos
	for k, v in pairs(coveMap) do
		if v:GetType() == self:GetType() then
			goto continue
		end
		if not v:CanBeAttacked() then
			goto continue
		end

		local vpos = v:GetPosition()
		local dis = Vector3.Distance(vpos, pos)
		if dis > attackRange then
			goto continue
		end
		local hp = v:GetResourceVal(HeroAttributeType.Hp)
		hp = hp - skillInfo.hurt
		hp = math.max(hp, 0)
		v:SetResourceVal(HeroAttributeType.Hp, hp)
		::continue::
	end
end

--技能释放完成
function CoveBase:OnReleastSkillFinish()
	if not CoveBattleMgr.instance():IsBattle() then
		LuaLogger.ds("  游戏结束了" .. self:GetID())
		return
	end
	self.attackTarget = nil
	self:SetReady(CovePlayerReadyType.Attacking, false)
	self._model:SetDefaultState(self:GetIdleStateVal())
	self:SetReady(CovePlayerReadyType.RaidSpread, true)
end


function CoveBase:CanRaidSpread()
	if not self:IsAllReady(CovePlayerReadyType.RaidSpread) then
		return false
	end
	return true
end

function CoveBase:GotoRaidSpreadPoint()
	self:SetReady(CovePlayerReadyType.RaidSpread, true)
	LuaLogger.ds(" 设置分散 id:" .. self:GetID() .. "  " .. Time.frameCount)
	---@type CoveBase[]
	local coveMap = CoveRoleManager.instance():GetAllCoveTab()

	local enemyDis = self:GetEnemyAwayDis()
	local friendDis = self:GetFriendAwayDis()
	if enemyDis == 0 or friendDis == 0 then
		LuaLogger.ds(" 分散完成 配置错误 id:" .. self:GetID() .. "  " .. Time.frameCount)
		self:SetReady(CovePlayerReadyType.RaidSpread, false)
		return
	end
	local pos = self:GetPosition()
	pos = Vector3.New(pos.x, pos.y, pos.z)
	---@type Vector3
	local forcePos = Vector3.zero
	local ms = 0
	for k, v in pairs(coveMap) do
		if not v:IsInBattle() then
			goto continue
		end
		if v == self then
			goto continue
		end
		local maxDis = 0.0
		if v:GetType() == self:GetType() then
			maxDis = friendDis
		else
			maxDis = enemyDis
		end
		local dis = Vector3.Distance(pos, v:GetPosition())
		if dis >= maxDis then
			goto continue
		end
		---@type Vector3
		local dir = pos - v:GetPosition()
		dir:SetNormalize()
		dir = dir * (maxDis - dis)
		forcePos = forcePos + dir

		if ms < maxDis - dis then
			ms = maxDis - dis
		end
		::continue::
	end

	local dis = Vector3.Magnitude(forcePos)
	if dis <= 0.001 then
		LuaLogger.ds(" 分散完成 不需要分散" .. self:GetID() .. "  " .. Time.frameCount)
		self:SetReady(CovePlayerReadyType.RaidSpread, false)
		return
	end
	Vector3.SetNormalize(forcePos)
	Vector3.Mul(forcePos, ms)

	forcePos = forcePos + self:GetPosition()
	self:DisableAreaMask(NavmeshAreas.Jump)
	self:MoveTo(forcePos, function()
		LuaLogger.ds(" 分散完成 不需要分散" .. self:GetID() .. "  " .. Time.frameCount)
		self:SetReady(CovePlayerReadyType.RaidSpread, false)
		self:EnableAreaMask(NavmeshAreas.Jump)
	end)
end


function CoveBase:IsInBattle()
	if self.destroyed then
		return false
	end
	local battleMgr = CoveBattleMgr.instance()
	if not battleMgr:IsBattle() then
		return false
	end
	if not battleMgr:IsBattleCharacter(self:GetUID()) then
		return false
	end
	return true
end



---@param defaultState integer
function CoveBase:SetDefaultState(defaultState)
	LuaLogger.ds(string.format(" lua defaultState  id:%s  defaultState:%s", self:GetID(), defaultState) .. "  pos:" .. tostring(self:GetPosition()))

	self.m_currentState = defaultState
	self._model:SetDefaultState(defaultState)
end


---@return boolean 是否可以被攻击
function CoveBase:CanBeAttacked()
	if not self.modelLoadFinish then
		return false
	end
	if self.destroyed then
		return false
	end
	local inBattle = self:IsInBattle()
	if not inBattle then
		return false
	end
	return true
end


function CoveBase:Destroy()

	if self.destroyed then
		LuaLogger.es("Cove 重复删除错误" .. tostring(self:GetType()) .. "   id:" .. tostring( self:GetID()))
		return
	end
	self.destroyed = true
	LuaLogger.ds("Cove 删除 type:" .. tostring(self:GetType()) .. "   id:" .. tostring( self:GetID()))
	self:SetEnableUpdate(false)
	self:DeleteAllWaitTime()

	self.tempEffectActiveInfo = nil
	if self.effects ~= nil then
		for k, v in pairs(self.effects) do
			if not IsNull(v) then
				PoolMgr.Free(v)
			end
		end
		self.effects = nil
	end
	if self.coveActions ~= nil then
		for k, v in pairs(self.coveActions) do
			v:Destroy()
		end
		self.coveActions = nil
	end
	if UICommonUtils.Checkobj(self.modelObj) then
		PoolMgr.Free(self.modelObj)
		self.modelObj = nil
	end
	if UICommonUtils.Checkobj(self._roleObj) then
		PoolMgr.Free(self._roleObj)
		self._roleObj = nil
	end
	
end

function CoveBase:ClearAiTreeVal()
	self.battleReady = nil
	self.isGotoFightPoint = nil
	self.readTypeInfo = nil
 	self.resourceTab = {}
	self.attackTarget = nil
	self.waitSkillCallBack = nil
	self.aiTree = nil
	self:EnableAreaMask(NavmeshAreas.Jump)
end

---模型被删除回调
function CoveBase:OnModelDestroy()
	self.tempEffectActiveInfo = {}
	if self.effects ~= nil then
		for k, v in pairs(self.effects) do
			PoolMgr.Free(v)
		end
		self.effects = {}
	end
	if self.coveActions ~= nil then
		for k, v in pairs(self.coveActions) do
			v:Destroy()
		end
		self.coveActions = {}
	end
end


---获得行为脚本
---@param actionName string
---@return CoveActionBase?
function CoveBase:GetOrCreateAction(actionName)
	local action = self.coveActions[actionName]
	if action ~= nil then
		return action
	end
	local action = require(actionName)
	if action == nil then
		return nil
	end
	---@type CoveActionBase
	local action = action:new(self)
	self.coveActions[actionName] = action
	return action
end


function CoveBase:SetCurrentAction(coveAction)
	if self.currentAction ~= nil then
		self.currentAction:Exit()
	end
	self.currentAction = coveAction
end


---@param duration number
---@param callBack function
function CoveBase:AddTimeWait(duration, callBack)
	return TimeMgr:AddWaitTimeExecute(duration, callBack, self, false)
end

---@param timeId number
function CoveBase:DeleteWaitTimeExecute(timeId)
	return TimeMgr:DeleteWaitTimeExecute(timeId)
end


function CoveBase:DeleteAllWaitTime()
	return TimeMgr:DeleteWaitTimeExecute(self)
end




function CoveBase:AddAnimOverCallBack(owner, callback)
	---@type AnimOverCallBackEvent
	local cb = {
		owner = owner,
		callback = callback,
	}
	for i = #self.animOverCallBackEvent, 1, -1 do
		local event = self.animOverCallBackEvent[i]
		if event.owner == owner and event.callback == callback then
			LuaLogger.es("===>>> 该事件已经被添加")
			return
		end
	end
	table.insert(self.animOverCallBackEvent, cb)
end

function CoveBase:RemoveAnimOverCallBack(owner, callback)
	if callback == nil then
		for i = #self.animOverCallBackEvent, 1, -1 do
			if self.animOverCallBackEvent[i].owner == owner then
				table.remove(self.animOverCallBackEvent, i)
			end
		end
	else
		for i = #self.animOverCallBackEvent, 1, -1 do
			local event = self.animOverCallBackEvent[i]
			if event.owner == owner and event.callback == callback then
				table.remove(self.animOverCallBackEvent, i)
			end
		end
	end
end

function CoveBase:OnAnimOverCallBack(animaKey)

	for i = #self.animOverCallBackEvent, 1, -1 do
		local event = self.animOverCallBackEvent[i]
		event.callback()
		if event.owner ~= nil then
			event.callback(event.owner, animaKey)
		else
			event.callback(animaKey)
		end
	end
end




return CoveBase