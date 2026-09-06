-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/AQAFGameMgr.lua

module("logic.extensions.aoqiattackforce.minigame.AQAFGameMgr", package.seeall)

local AQAFGameMgr = class("AQAFGameMgr")

function AQAFGameMgr.Get(go)
	local component = Framework.LuaComponentContainer.Get(go, AQAFGameMgr)

	component = component or Framework.LuaComponentContainer.Add(go, AQAFGameMgr)

	return component
end

function AQAFGameMgr:ctor(luaComponentContainer)
	self.mgrgo = luaComponentContainer.gameObject

	self:_initPool()

	self.playerUnit = AQAFPlayer.New(self)
	self._curActiveMonsters = {}
	self._curActiveMonsterBullets = {}
	self._curActivePlayerBullets = {}
	self._curWeapons = {}
	self._qt = SimpleQuadTree.New(-900, -460, 1800, 920, 4)
	self._found = {}
	self._updateSiblingCD = 0
end

function AQAFGameMgr:_initPool()
	local function createFuncA()
		return AQAFMonster.New(self)
	end

	local function disposeFuncA(obj)
		obj:destroy()
	end

	local function resetFuncA(obj)
		obj:reset()
	end

	self._monsterPool = ObjectPool.New(25, createFuncA, disposeFuncA, resetFuncA)

	local function createFuncB()
		return AQAFBullet.New(self)
	end

	local function disposeFuncB(obj)
		obj:destroy()
	end

	local function resetFuncB(obj)
		obj:reset()
	end

	self._bulletPool = ObjectPool.New(25, createFuncB, disposeFuncB, resetFuncB)

	local function createFuncC()
		return AQAFWeapon.New(self)
	end

	local function disposeFuncC(obj)
		obj:destroy()
	end

	local function resetFuncC(obj)
		obj:reset()
	end

	self._weaponPool = ObjectPool.New(25, createFuncC, disposeFuncC, resetFuncC)
end

function AQAFGameMgr:initGameData(param)
	self.playerUnit:addContainer(param.playerGo)

	self._gameState = AQAFGameEnum.GameState.Init
end

function AQAFGameMgr:initStageData()
	self:resetGame()

	self._bornMonsterParams = AoQiAttackForceModel.instance:getCurMonsterCfgs()
	self._bornCDTimer = 0

	local equipDatas = AoQiAttackForceModel.instance:getCurEquipsInGame()

	for _, equipData in ipairs(equipDatas) do
		if equipData.cfg.equipmentType ~= AQAFGameEnum.WeaponType.Purse then
			self:createWeapon(equipData)
		end
	end

	self.playerUnit:initData()

	if self._gameState == AQAFGameEnum.GameState.Init then
		self._gameState = AQAFGameEnum.GameState.Ready
	elseif self._gameState == AQAFGameEnum.GameState.End then
		self._gameState = AQAFGameEnum.GameState.Ready
	end

	GlobalDispatcher:dispatch(GlobalNotify.AQAFGameSwitchState, self._gameState)
end

function AQAFGameMgr:startGame()
	if self._gameState == AQAFGameEnum.GameState.Ready then
		self._gameState = AQAFGameEnum.GameState.InGame
	end

	self.playerUnit:born()
	GlobalDispatcher:dispatch(GlobalNotify.AQAFGameSwitchState, self._gameState)
end

function AQAFGameMgr:switchPauseState()
	if self._gameState == AQAFGameEnum.GameState.InGame then
		self._gameState = AQAFGameEnum.GameState.Pause
	elseif self._gameState == AQAFGameEnum.GameState.Pause then
		self._gameState = AQAFGameEnum.GameState.InGame
	end

	GlobalDispatcher:dispatch(GlobalNotify.AQAFGameSwitchState, self._gameState)
end

function AQAFGameMgr:endGame()
	if self._gameState == AQAFGameEnum.GameState.InGame then
		self._gameState = AQAFGameEnum.GameState.End
	end

	GlobalDispatcher:dispatch(GlobalNotify.AQAFGameSwitchState, self._gameState)
end

function AQAFGameMgr:destroyGame()
	self:resetGame()
end

function AQAFGameMgr:checkGameFinish()
	if #self._bornMonsterParams <= 0 and table.nums(self._curActiveMonsters) <= 0 then
		return true
	end

	if not self.playerUnit:isActive() then
		return true
	end

	return false
end

function AQAFGameMgr:getIsWin()
	if self.playerUnit:isActive() and #self._bornMonsterParams <= 0 and table.nums(self._curActiveMonsters) <= 0 then
		return true
	end

	return false
end

function AQAFGameMgr:resetGame()
	for _, monster in pairs(self._curActiveMonsters) do
		self:destroyMonster(monster)
	end

	for _, bullet in pairs(self._curActiveMonsterBullets) do
		self:destroyBullet(bullet)
	end

	for _, bullet in pairs(self._curActivePlayerBullets) do
		self:destroyBullet(bullet)
	end

	for _, weapon in pairs(self._curWeapons) do
		self:destroyWeapon(weapon)
	end

	self._curActiveMonsters = {}
	self._curActiveMonsterBullets = {}
	self._curActivePlayerBullets = {}
	self._bornMonsterParams = {}
	self._curWeapons = {}
	self._bornMonsterNum = 0
	self._bornBulletNum = 0
	self._bornWeaponNum = 0
end

function AQAFGameMgr:checkDistanceSquareInRange(distanceSquare, range)
	if distanceSquare >= 0 then
		return distanceSquare <= range * range
	end

	return false
end

function AQAFGameMgr:getDistanceSquareBetween(unitA, unitB)
	local unitGoA = unitA and unitA:getContainer()
	local unitGoB = unitB and unitB:getContainer()

	if unitGoA and unitGoB then
		return (unitA.position.x - unitB.position.x) * (unitA.position.x - unitB.position.x) + (unitA.position.y - unitB.position.y) * (unitA.position.y - unitB.position.y)
	end

	return -1
end

function AQAFGameMgr:checkInRangeBetween(unitA, unitB, range)
	local distanceSquare = self:getDistanceSquareBetween(unitA, unitB)

	return self:checkDistanceSquareInRange(distanceSquare, range)
end

function AQAFGameMgr:checkIsCollisonBetween(unitA, unitB)
	local radiusA = unitA and unitA:getRadiusCollider()
	local radiusB = unitB and unitB:getRadiusCollider()

	if radiusA >= 0 and radiusB >= 0 then
		local disX = unitA.position.x - unitB.position.x
		local disY = unitA.position.y - unitB.position.y
		local range = radiusA + radiusB

		return range * range >= disX * disX + disY * disY
	end
end

function AQAFGameMgr:getNewMonsterParam()
	return table.remove(self._bornMonsterParams, #self._bornMonsterParams)
end

function AQAFGameMgr:bornMonster()
	local param = self:getNewMonsterParam()

	self:createMonster(param)

	if #self._bornMonsterParams == 0 and AoQiAttackForceModel.instance:getIsEndlessState() then
		self._bornMonsterParams = AoQiAttackForceModel.instance:getCurMonsterCfgs()

		AoQiAttackForceModel.instance:strengthenMonster()
	end

	self._bornCDTimer = param.bornTimer
end

function AQAFGameMgr:createMonster(param)
	local monster = self._monsterPool:fetchObject()

	self._bornMonsterNum = self._bornMonsterNum + 1
	monster.id = self._bornMonsterNum

	monster:initData(param)
	monster:born()
end

function AQAFGameMgr:addMonster(monster)
	self._curActiveMonsters[monster.id] = monster
end

function AQAFGameMgr:destroyMonster(monster)
	self._curActiveMonsters[monster.id] = nil

	self._monsterPool:returnObject(monster)
end

function AQAFGameMgr:getCurActiveMonsters()
	return self._curActiveMonsters or {}
end

function AQAFGameMgr:createBullet(param)
	local bullet = self._bulletPool:fetchObject()

	self._bornBulletNum = self._bornBulletNum + 1
	bullet.id = self._bornBulletNum

	bullet:initData(param)
	bullet:born()
end

function AQAFGameMgr:addBullet(bullet)
	if bullet:isPlayersBullet() then
		self._curActivePlayerBullets[bullet.id] = bullet
	else
		self._curActiveMonsterBullets[bullet.id] = bullet
	end
end

function AQAFGameMgr:destroyBullet(bullet)
	if bullet:isPlayersBullet() then
		self._curActivePlayerBullets[bullet.id] = nil
	else
		self._curActiveMonsterBullets[bullet.id] = nil
	end

	self._bulletPool:returnObject(bullet)
end

function AQAFGameMgr:createWeapon(param)
	local weapon = self._weaponPool:fetchObject()

	weapon:initData(param)

	self._bornWeaponNum = self._bornWeaponNum + 1
	weapon.id = self._bornWeaponNum

	weapon:born()
end

function AQAFGameMgr:addWeapon(weapon)
	self._curWeapons[weapon.id] = weapon
end

function AQAFGameMgr:destroyWeapon(weapon)
	self._curWeapons[weapon.id] = nil

	self._weaponPool:returnObject(weapon)
end

function AQAFGameMgr:Update()
	if self._gameState == AQAFGameEnum.GameState.InGame then
		if self:checkGameFinish() then
			self:endGame()

			return
		end

		self._bornCDTimer = self._bornCDTimer - UnityEngine.Time.deltaTime

		if #self._bornMonsterParams > 0 and self._bornCDTimer < 0 then
			self:bornMonster()
		end

		for _, monster in pairs(self._curActiveMonsters) do
			monster:update()
		end

		for _, bullet in pairs(self._curActiveMonsterBullets) do
			bullet:update()
		end

		for _, bullet in pairs(self._curActivePlayerBullets) do
			bullet:update()
		end

		for _, weapon in pairs(self._curWeapons) do
			weapon:update()
		end

		self:checkCollision()
		self:checkAllBullet()
		self:checkAllMonster()
		self.playerUnit:update()
		self:_updateMonsterSibling()
	end
end

function AQAFGameMgr:_updateMonsterSibling()
	self._updateSiblingCD = self._updateSiblingCD - UnityEngine.Time.deltaTime

	if self._updateSiblingCD > 0 then
		return
	end

	self._updateSiblingCD = 1

	local list = {}

	for _, monster in pairs(self._curActiveMonsters) do
		table.insert(list, monster)
	end

	ArraySort.sortOn(list, function(mon)
		return mon.position.y
	end, ArraySort.DESCENDING)

	for i, mon in ipairs(list) do
		local con = mon:getContainer()

		if con then
			con.transform:SetSiblingIndex(i)
		end
	end
end

function AQAFGameMgr:checkCollision()
	for _, bullet in pairs(self._curActiveMonsterBullets) do
		if self:checkIsCollisonBetween(self.playerUnit, bullet) then
			self.playerUnit:beHit(bullet)
		end
	end

	self._qt:clear()

	for _, bullet in pairs(self._curActivePlayerBullets) do
		self._qt:insert(bullet)
	end

	for _, monster in pairs(self._curActiveMonsters) do
		local raius = monster:getRadiusCollider()

		if raius > 0 then
			table.clear(self._found)

			self._found = self._qt:query(monster.rect)

			for i, bullet in ipairs(self._found) do
				if self:checkIsCollisonBetween(monster, bullet) then
					monster:beHit(bullet)
				end
			end
		end
	end
end

function AQAFGameMgr:checkAllBullet()
	local removeTab = {}

	for _, bullet in pairs(self._curActivePlayerBullets) do
		if not bullet:isActive() then
			table.insert(removeTab, bullet)
		end
	end

	for _, bullet in pairs(self._curActiveMonsterBullets) do
		if not bullet:isActive() then
			table.insert(removeTab, bullet)
		end
	end

	for _, bullet in ipairs(removeTab) do
		self:destroyBullet(bullet)
	end
end

function AQAFGameMgr:checkAllMonster()
	local removeTab = {}

	for _, monster in pairs(self._curActiveMonsters) do
		if not monster:isActive() then
			table.insert(removeTab, monster)
		end
	end

	for _, monster in ipairs(removeTab) do
		self:destroyMonster(monster)
	end
end

return AQAFGameMgr
