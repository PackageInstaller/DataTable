-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/obj/AQAFPlayerCon.lua

module("logic.extensions.aoqiattackforce.minigame.obj.AQAFPlayerCon", package.seeall)

local AQAFPlayerCon = class("AQAFPlayerCon")

function AQAFPlayerCon:ctor(container, view)
	self._view = view
	self.curUnit = nil
	self.isDie = true

	self:buildUI(container)
end

function AQAFPlayerCon:buildUI(container)
	self.container = container
	self.roleCon = goutil.findChild(self.container, "role")
	self.shiedld = goutil.findChild(self.container, "shield")
	self._effCon = goutil.findChild(self.container, "effCon")
	self._statusCon = goutil.findChild(self.container, "statusCon")
	self._txtStatus = goutil.findChild(self.container, "txtStatus")

	GameUtil.SetActive(self._txtStatus, false)
end

function AQAFPlayerCon:setUnit(unit)
	self.curUnit = unit

	if self.curUnit then
		self:updatePos()

		self.isDie = false

		local relativeScale = self.curUnit.modelCfg.relativeScale
		local relativePos = self.curUnit.modelCfg.relativePos

		GameUtil.setLocalScale(self.roleCon, relativeScale[1], relativeScale[2], relativeScale[3])
		GameUtil.setLocalPos(self.roleCon, relativePos[1], relativePos[2], relativePos[3])

		self._role = RoleObjectPool.instance:addSpineToParent(self._role, self.curUnit.modelCfg.resPath, self.roleCon, 1, nil, 0, 0)

		goutil.setActive(self.container, true)
		self:updatePos()

		self.container.name = "mainplayer"
	end
end

function AQAFPlayerCon:lateUpdate()
	if self.isDie then
		return
	end

	if self.curUnit then
		if self.curUnit.isMove then
			self:updatePos()
		end

		if self.curUnit.isTriHit then
			if self.curUnit:getCurHp() <= 0 then
				self:playDieAni()
			else
				self:playHitAni()
			end
		end

		if self.curUnit.isTriAtk then
			self:playAtkAni()
		end

		goutil.setActive(self.shiedld, self.curUnit:getCurShield() > 0)
	end
end

function AQAFPlayerCon:reset()
	self.curUnit = nil
	self.isDie = true

	if self._role then
		RoleObjectPool.instance:removeRole(self._role)
	end

	goutil.setActive(self.container, false)
end

function AQAFPlayerCon:updatePos()
	if self.curUnit then
		GameUtil.setLocalPos(self.container, self.curUnit.position.x, self.curUnit.position.y, 0)
	end
end

function AQAFPlayerCon:playHitAni()
	if self._role then
		RoleObjectPool.instance:playAnimation(self.roleCon, self.curUnit.modelCfg.hitAni, false, function()
			RoleObjectPool.instance:playAnimation(self.roleCon, self.curUnit.modelCfg.idleAni, true)
		end)
	end
end

function AQAFPlayerCon:playDieAni()
	if self._role then
		RoleObjectPool.instance:playAnimation(self.roleCon, self.curUnit.modelCfg.dieAni, false)
	end
end

function AQAFPlayerCon:playAtkAni()
	if self._role then
		RoleObjectPool.instance:playAnimation(self.roleCon, self.curUnit.modelCfg.atkAni, false, function()
			RoleObjectPool.instance:playAnimation(self.roleCon, self.curUnit.modelCfg.idleAni, true)
		end)
	end
end

function AQAFPlayerCon:die()
	self:reset()
end

function AQAFPlayerCon:destroy()
	self:reset()
	goutil.destroy(self.container)

	self.container = nil
end

return AQAFPlayerCon
