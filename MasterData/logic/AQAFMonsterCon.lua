-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/obj/AQAFMonsterCon.lua

module("logic.extensions.aoqiattackforce.minigame.obj.AQAFMonsterCon", package.seeall)

local AQAFMonsterCon = class("AQAFMonsterCon")

function AQAFMonsterCon:ctor(container, view)
	self._view = view
	self.curUnit = nil
	self.isDie = true

	self:buildUI(container)
end

function AQAFMonsterCon:buildUI(container)
	self.container = container
	self.roleCon = goutil.findChild(self.container, "role")
	self.shiedld = goutil.findChild(self.container, "shield")
	self._effCon = goutil.findChild(self.container, "effCon")
	self._statusCon = goutil.findChild(self.container, "statusCon")
	self._txtStatus = goutil.findChild(self.container, "txtStatus")

	GameUtil.SetActive(self._txtStatus, false)
end

function AQAFMonsterCon:setUnit(unit)
	self.curUnit = unit

	if self.curUnit then
		self.isDie = false

		local relativeScale = self.curUnit.modelCfg.relativeScale
		local relativePos = self.curUnit.modelCfg.relativePos

		GameUtil.setLocalScale(self.roleCon, relativeScale[1], relativeScale[2], relativeScale[3])
		GameUtil.setLocalPos(self.roleCon, relativePos[1], relativePos[2], relativePos[3])

		self._role = RoleObjectPool.instance:addSpineToParent(self._role, self.curUnit.modelCfg.resPath, self.roleCon, 1, function()
			self:playAnimation(self.roleCon, self.curUnit.modelCfg.idleAni, true)
		end, 0, 0)

		goutil.setActive(self.container, true)

		if unit:isBoss() then
			GameUtil.setLocalScale(self.container, 2, 2, 2)
		else
			GameUtil.setLocalScale(self.container, 1, 1, 1)
		end

		self:updatePos()

		self.container.name = "monster_" .. self.curUnit.id

		GlobalDispatcher:addListener(GlobalNotify.AQAFUnitStatusChange, self._onChangeStatus, self)
	end
end

function AQAFMonsterCon:lateUpdate()
	if self.isDie then
		return
	end

	if self.curUnit then
		if self.curUnit.isMove then
			self:updatePos()
		end

		if self.curUnit.isTriHit then
			for _, dam in ipairs(self.curUnit.curRecordDamages) do
				if dam.type == AQAFGameEnum.AttackDamageType.Physics and self.curUnit:getTypeTakDamRate(AQAFGameEnum.AttackDamageType.Physics) > 1 then
					GlobalDispatcher:dispatch(GlobalNotify.AQAFShowAlertTxt, -Mathf.Ceil(dam.dam), self.curUnit.position.x, self.curUnit.position.y + 50, AQAFSimpleFloatTipsMgr.TYPE_PHYSICS_TEXT)
				elseif dam.type == AQAFGameEnum.AttackDamageType.Magic and self.curUnit:getTypeTakDamRate(AQAFGameEnum.AttackDamageType.Magic) > 1 then
					GlobalDispatcher:dispatch(GlobalNotify.AQAFShowAlertTxt, -Mathf.Ceil(dam.dam), self.curUnit.position.x, self.curUnit.position.y + 50, AQAFSimpleFloatTipsMgr.TYPE_MAGIC_TEXT)
				else
					GlobalDispatcher:dispatch(GlobalNotify.AQAFShowAlertTxt, -Mathf.Ceil(dam.dam), self.curUnit.position.x, self.curUnit.position.y + 50)
				end
			end

			self:playHitAni()
		end

		if self.curUnit.isTriFrozen then
			self:_playEffOnce(AQAFBuffMgr.IDX_ICE)
		end

		if self.curUnit.isTriAtk then
			self:playAtkAni()
		end

		goutil.setActive(self.shiedld, self.curUnit:getCurShield() > 0)
	end
end

function AQAFMonsterCon:reset()
	self.isDie = true
	self.curUnit = nil

	if self._role then
		RoleObjectPool.instance:removeRole(self._role)
	end

	self._role = nil

	GameUtil.SetActive(self.container, false)
	GlobalDispatcher:removeListener(GlobalNotify.AQAFUnitStatusChange, self._onChangeStatus, self)
end

function AQAFMonsterCon:_onChangeStatus(id)
	if self.curUnit and self.curUnit.id == id then
		goutil.clearChildren(self._statusCon)

		for k, v in pairs(self.curUnit._statusMap) do
			if v > 0 then
				local go = goutil.cloneAndSetParent(self._txtStatus, self._statusCon.transform, "status")

				GameUtil.SetActive(go, true)

				local txt = go:GetComponent(goutil.Type_UIText)

				txt.text = k
			end
		end
	end
end

function AQAFMonsterCon:_playEffOnce(idx)
	local effPath = AQAFBuffMgr.EFFECT_PATH_LIST[idx]

	if effPath then
		local effect = UIEffectManager.instance:playEffect(self._view, effPath, self._effCon, 0, 0, false, false, function(handlerTarget, eff)
			UIEffectManager.instance:stopEffect(eff)
		end)
	end
end

function AQAFMonsterCon:updatePos()
	if self.curUnit then
		GameUtil.setLocalPos(self.container, self.curUnit.position.x, self.curUnit.position.y, 0)
	end
end

function AQAFMonsterCon:playHitAni()
	if self._role then
		self:playAnimation(self.roleCon, self.curUnit.modelCfg.hitAni, false, function()
			self:playAnimation(self.roleCon, self.curUnit.modelCfg.idleAni, true)
		end)
	end
end

function AQAFMonsterCon:playDieAni()
	if self._role then
		self:playAnimation(self.roleCon, self.curUnit.modelCfg.dieAni, false)
	end
end

function AQAFMonsterCon:playAtkAni()
	if self._role then
		self:playAnimation(self.roleCon, self.curUnit.modelCfg.atkAni, false, function()
			self:playAnimation(self.roleCon, self.curUnit.modelCfg.idleAni, true)
		end)
	end
end

function AQAFMonsterCon:die(handler, handlerTarget)
	if self._role then
		self:playAnimation(self.roleCon, self.curUnit.modelCfg.dieAni, false, function()
			if handler then
				handler(handlerTarget)
			end

			self:reset()
		end)
	else
		self:reset()
	end
end

function AQAFMonsterCon:playAnimation(go, animName, loop, callBack, reStart)
	if not go then
		return
	end

	self._graphic = go:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))

	if self._trackEntry then
		AQAFMonsterCon._callBackMap[self._trackEntry] = nil
		self._trackEntry = nil
	end

	local graphic = self._graphic

	if graphic then
		local sk = graphic.skeletonDataAsset

		if sk ~= nil then
			local data = sk:GetAnimationStateData()
			local skd = data.SkeletonData
			local ani = skd:FindAnimation(animName)

			if ani ~= nil then
				graphic:Initialize(true)

				graphic.startingAnimation = animName

				local trackEntry = graphic.AnimationState:SetAnimation(0, animName, loop)

				graphic:Update(0)

				AQAFMonsterCon._callBackMap = AQAFMonsterCon._callBackMap or {}
				AQAFMonsterCon._callBackMap[trackEntry] = callBack
				trackEntry.Complete = trackEntry.Complete + AQAFMonsterCon.onComplete
				self._trackEntry = trackEntry
			end
		end
	end
end

function AQAFMonsterCon.onComplete(trackEntry)
	GameUtil.callBack(AQAFMonsterCon._callBackMap[trackEntry])

	AQAFMonsterCon._callBackMap[trackEntry] = nil
	trackEntry.Complete = trackEntry.Complete - AQAFMonsterCon.onComplete
end

function AQAFMonsterCon:destroy()
	self:reset()
	goutil.destroy(self.container)

	self.container = nil
end

return AQAFMonsterCon
