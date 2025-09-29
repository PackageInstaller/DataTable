-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/scenefollow/BattleUnitPropertyBar.lua

module("logic.battle.scenefollow.BattleUnitPropertyBar", package.seeall)

local M = class("BattleUnitPropertyBar", IBattleReusable)

function M:getCapacity()
	return 50
end

function M:ctor(unit)
	self._url = false
	self._hasBuildUI = false
	self._isInBossView = false

	self:reuse(unit)
end

function M:reuse(unit)
	self._unit = unit
	self.rootGO = unit.mountRoot:getBarRoot()

	GlobalDispatcher:addEventListener(EventType.ON_CAMERA_ROTATION_UPDATE, self.doBarRotation, self)
	GlobalDispatcher:addEventListener(EventType.ON_ENTER_OR_EXIT_BATTLE_VS, self._onEnterOrExitBttleVsScene, self)
	goutil.setActive(self.rootGO, true)
end

function M:reset()
	self._isInBossView = false

	GlobalDispatcher:removeEventListener(EventType.ON_CAMERA_ROTATION_UPDATE, self.doBarRotation, self)
	GlobalDispatcher:removeEventListener(EventType.ON_ENTER_OR_EXIT_BATTLE_VS, self._onEnterOrExitBttleVsScene, self)
	goutil.setActive(self.rootGO, false)

	if self._hasBuildUI then
		self._normalBloodBar:reset()
		self._compositeBloodBar:reset()
	end

	if self._enableState then
		self._enableState:clear()
	end
end

function M:destroy()
	self:reset()
	self:_clearResource()

	self._url = false
end

function M:setBossUIStatus(isInBoss)
	self._isInBossView = isInBoss

	self._enableState:setEnable("BattleBossPropertyView", not isInBoss)
end

function M:doBarRotation(_, time)
	local rotationY = BattleMgr.instance:getModel():getCameraRotation()
	local x, y, z = TransformUtils.GetEulerAngles(self.rootGO.transform, 0, 0, 0)

	self.rootGO.transform:DORotate(Vector3.New(x, rotationY, z), time)
end

function M:_onEnterOrExitBttleVsScene(_, isEnter)
	if self._isInBossView then
		BattleBossPropertyFacade.instance:setVisible(not isEnter, "VsScene")
	elseif self._hasBuildUI then
		self._enableState:setEnable("VsScene", not isEnter)
	end
end

function M:_clearResource()
	if self.mainGO then
		self:destroyUI()
		goutil.destroy(self.mainGO)

		self.mainGO = false
	end

	self._url = false
end

function M:buidUI()
	self._hasBuildUI = true
	self._normalPanelGo = goutil.findChild(self.mainGO, "nomal")
	self._bossPanelGo = goutil.findChild(self.mainGO, "boss")
	self._normalBloodBar = SceneBattleBloodBar.New(self._normalPanelGo)
	self._compositeBloodBar = SceneBattleBloodBar.New(self._bossPanelGo)
	self._normalFollowGo = goutil.findChild(self._normalPanelGo, "followPoint")
	self._bossFollowGo = goutil.findChild(self._bossPanelGo, "followPoint")

	if self._enableState then
		self._enableState:clear()
	else
		self._enableState = GameObjectEnableState.New(self.mainGO)
	end

	self:setBossUIStatus(self._isInBossView)
end

function M:destroyUI()
	return
end

function M:setUrl(url)
	if self._url ~= url then
		self:_clearResource()

		local resMgr = BattleMgr.instance:getResourceMgr()
		local mainGO = resMgr:getInst(url)

		goutil.addChildToParent(mainGO, self.rootGO)

		self._url = url
		self.mainGO = mainGO

		self:buidUI()
	end

	self:initBar()
end

function M:initBar()
	if self._unit.transform:isComposite() then
		self._normalBloodBar:setVisible(false)
		self._compositeBloodBar:setVisible(true)

		self._bloodBar = self._compositeBloodBar
	else
		self._normalBloodBar:setVisible(true)
		self._compositeBloodBar:setVisible(false)

		self._bloodBar = self._normalBloodBar
	end

	self._unit.uiBloodFollow:setBloodFollowMainGameObject(self._unit.transform:isComposite() and self._bossFollowGo or self._normalFollowGo)
	self:setPlaySpeed(BattleTime.timeScale)

	local relation = BattleUISettingUtil.getRelationType(self._unit.property:getCampId())

	self._bloodBar:setActiveBloodBar(relation)
	self:_initBarRotation()
end

function M:_initBarRotation()
	local rotationY = BattleMgr.instance:getModel():getCameraRotation()
	local x, y, z = TransformUtils.GetEulerAngles(self.rootGO.transform, 0, 0, 0)

	TransformUtils.SetEulerAngles(self.rootGO.transform, x, rotationY, z)
end

function M:setMask(isMask)
	if self._bloodBar then
		self._bloodBar:setMask(isMask)
	end
end

function M:setPlaySpeed(playSpeed)
	if self._bloodBar then
		self._bloodBar:setPlaySpeed(playSpeed)
	end
end

function M:updateBaseInfo()
	local property = self._unit.property
	local bloodPercent = property:getAttribute(BattleExtension_pb.Attribute.CURRENT_HP) / property:getAttribute(BattleExtension_pb.Attribute.MAX_HP)

	self._bloodBar:setBlood(bloodPercent)
end

function M:onAttributeUpdate()
	local property = self._unit.property
	local bloodPercent = property:getAttribute(BattleExtension_pb.Attribute.CURRENT_HP) / property:getAttribute(BattleExtension_pb.Attribute.MAX_HP)

	self._bloodBar:doBloodBarTween(bloodPercent)
end

function M:forecast(forecastEntityInfo)
	local p1 = self._unit.property:getAttribute(BattleExtension_pb.Attribute.CURRENT_HP) / self._unit.property:getAttribute(BattleExtension_pb.Attribute.MAX_HP)
	local p2 = forecastEntityInfo:getAttribute(BattleExtension_pb.Attribute.CURRENT_HP) / forecastEntityInfo:getAttribute(BattleExtension_pb.Attribute.MAX_HP)
	local isDouble = self._unit.property:isWeakPointBroken()

	self._bloodBar:forecast(p1, p2, isDouble)
end

return M
