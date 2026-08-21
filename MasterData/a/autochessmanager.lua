

---@class AutoChessManager
local AutoChessManager = class("AutoChessManager")
local AutoChessMap = require("AutoChessMap")
local Plane = require("Plane")
local json = require "cjson"


local DIR_OFFSET = {
	{-1, -1},
	{-3, 3},
	{0, 0},
	{3, 3},
	{1, -1},
}

local MAP_OFFSET = {
	{0, 0},
	{0, 1},
	{0.5, 0.5},
	{1, 1},
	{1, 0},
}

-- 预先缓存 Viewport 的 4 个固定角 Vector3，防止重复 new
local VIEW_POINTS = {
    BL = Vector3.New(0, 0, 0),
    TL = Vector3.New(0, 1, 0),
    TR = Vector3.New(1, 1, 0),
    BR = Vector3.New(1, 0, 0)
}

---@type Vector3
local temp_v3 = Vector3.New()

function AutoChessManager:ctor()
	
	---@type UnityEngine.Transform
	self.cameraTrs = nil
	---@type UnityEngine.Camera
	self.camera = nil
	---@type table<int, UnityEngine.Transform>
	self.entityRoots = {}

	---所有entity 列表
	---@type table<integer, AutoChessEntity>
	self.entityTables = {}

	---@type int[] 所有entityID列表
	self.updateKeys = {}
	self.entityUID = 0

	self.cameraMoveData = {
        minPos = Vector3.New(0,0,0),
        maxPos = Vector3.New(0,0,0),
        middlePos = Vector3.New(0,0,0),
        forward = Vector3.New(0,0,0), -- 复制一份 forward
        minHeight = 4,
        maxHeight = 10,
        zoomSpeed = 5,
    }
	---@type boolean 是否战斗中
	self.isBattleing = false
	---@type boolean 是否开启 AI 行军演示（AITextBtn）
	self.isAIBattle = false
	---@type boolean 是否处于自走棋测试场景（隔离家园/大地图等外围逻辑）
	self.inScene = false

	---@type table<EntityType, AutoChessEntity> 所有entityType 创建对象类
	self.entityClassBases = {}
end

---@return AutoChessManager
function AutoChessManager.instance()
	if (AutoChessManager._instance == nil) then
		AutoChessManager._instance = AutoChessManager:new()
	end
	return AutoChessManager._instance
end



function AutoChessManager:IsInScene()
	return self.inScene
end

function AutoChessManager:SetInScene(active)
	self.inScene = active == true
	GV.IsAutoChessScene = self.inScene
end

function AutoChessManager:LoadingAutoChessScene()
	-- 尽早进入隔离模式，避免切场景过程中 SimUpdate 处理家园等协议
	self:SetInScene(true)

	if MyPrefs == nil then
		local prefabKey = "AutoChessBattleInfo"
		MyPrefs = require "DPlayerPrefs":new(prefabKey)
	end

	ResMgr:LoadSceneAsyncLua(Config.ScenePath.AutoChessScene, false, function(sceneName)
		CoveManager.instance():clear()
		UIMgr:clearAllUI(false)
		UIMgr:ClearLoader()
		PoolMgr:Clear()
		SeaMapMgr:Clear()
		self:InitUI()
		self:Init()

	end)
end

function AutoChessManager:Init()
	local AutoChessRole = require("AutoChessRole")
	local AutoChessBullet = require("AutoChessBullet")
	self.entityClassBases = {
		[GE.EntityType.Player] = AutoChessRole,
		[GE.EntityType.Summon] = AutoChessRole,
		[GE.EntityType.Bullet] = AutoChessBullet,
	}

	local sceneRoot = GameObject.Find("SceneRoot")
	self.sceneRoot = sceneRoot
	local cameraTrs = sceneRoot.transform:Find("Main Camera")
	self.cameraTrs = cameraTrs
	---@type UnityEngine.Camera
	self.camera = cameraTrs:GetComponent(TypeInfo.Camera)
	UIMgr.SetBaseCamera(self.camera)

	local entityRoot = sceneRoot.transform:Find("MapEntity")
	local path = {
		"role", "monster", "bullet"
	}
	for i = 1, #path do
		local trs = entityRoot:Find(path[i])
		if not IsNull(trs) then
			self.entityRoots[i] = trs
		end
	end

    if not self.updateHandle then
		self.updateHandle = UpdateBeat:CreateListener(self.Update, self)
	end
    UpdateBeat:AddListener(self.updateHandle)

	self:ResetEntityUID()

	self.gridSize = 1
	---@type AutoChessMap
    self.map = AutoChessMap:new(self.gridSize)
	
	local mapSize = {
		x = 5,
		y = 7
	}
	local battleInfo = self:LoadBattleInfo()
	if battleInfo == nil then
	

		self.map:InitMapSize(mapSize.x, mapSize.y)
		local block = {
			{x = 4, y = 1},
			{x = 4, y = 2},
			{x = 4, y = 3},
			{x = 4, y = 4},
			{x = 4, y = 5},
			{x = 5, y = 5},
			{x = 6, y = 5},
		}
		for i = 1, #block do
			self.map:SetMapBlockVal(block[i].x, block[i].y, 1)
		end
		self.map:CreateMapGrid()
		self.editorMapData = {}
		for y = 1, mapSize.y do
			self.editorMapData[y] = {}
			for x = 1, mapSize.x do
				self.editorMapData[y][x] = self.map:GetMapBlockVal(x, y)
			end
		end
	else
		mapSize.x = #battleInfo.map[1]
		mapSize.y = #battleInfo.map
		self.map:SetMapData(battleInfo.map)
		self.map:CreateMapGrid()
		self.editorMapData = battleInfo.map

		local entitys = battleInfo.entitys
		if entitys ~= nil then
			for i = 1, #entitys do
				local data = entitys[i]
				data.uid = self:GetEntityUID()
				self:CreateEntity(data)
			end
		end
	end

	UIMgr.uiCamera.clearFlags = UnityEngine.CameraClearFlags.Nothing
	self:CalculateCameraBounds()
	self.cameraTrs.position = self.cameraMoveData.middlePos
	self.mapPlane = Plane.New(Vector3.up, 0)
	self.isBattleing = false
	self.isAIBattle = false
	self.showAttackRangeDebug = true
	self.attackRangeDebug = require("AutoChessAttackRangeDebug"):new(self)
	self.conditionChecker = require("ConditionChecker")
	self:SetInScene(true)
end


function AutoChessManager:InitUI()
	UIMgr:popUI("AutoChessMainPanel")
end

---计算相机边界
function AutoChessManager:CalculateCameraBounds()

	local cameraTrs = self.cameraTrs
	local w, h = self.map:GetMapSize()

	---@type Vector3
	local bottomLeftDir  = self.camera:ViewportPointToRay(VIEW_POINTS.BL).direction  --
	local topLeftDir     = self.camera:ViewportPointToRay(VIEW_POINTS.TL).direction
	local topRightDir    = self.camera:ViewportPointToRay(VIEW_POINTS.TR).direction  --
	local bottomRightDir = self.camera:ViewportPointToRay(VIEW_POINTS.BR).direction

	local middleDir = cameraTrs.forward

	local defaultHeight = cameraTrs.position.y
	local px = 1

	local dirV3 = {bottomLeftDir, topLeftDir, middleDir, topRightDir, bottomRightDir}

	local points_x = {}
    local points_z = {}
    local middlePos = self.cameraMoveData.middlePos

	for i = 1, #DIR_OFFSET do
		local offsetX = (DIR_OFFSET[i][1] * px) + (MAP_OFFSET[i][1] * w)
        local offsetZ = (DIR_OFFSET[i][2] * px) + (MAP_OFFSET[i][2] * h)	
		local dirV = dirV3[i]
		local dirVy = dirV.y
        if math.abs(dirVy) < 0.0001 then 
            dirVy = -0.0001 
        end
		local yMinScale = defaultHeight / dirV.y

		-- 计算最终落地点的 X 和 Z
        local finalX = offsetX + (dirV.x * yMinScale)
        local finalZ = offsetZ + (dirV.z * yMinScale)
		points_x[i] = finalX
		points_z[i] = finalZ

		if i == 3 then
            middlePos:Set(finalX, defaultHeight, finalZ)
        end
	end

    local minX = math.min(points_x[1], points_x[2])
    local minZ = math.min(points_z[1], points_z[5])
    
    local maxX = math.max(points_x[4], points_x[5])
    local maxZ = math.max(points_z[4], points_z[2])

	-- 纠正错位
    if minX > maxX then
        minX, maxX = middlePos.x, middlePos.x
    end
    if minZ > maxZ then
        minZ, maxZ = middlePos.z, middlePos.z
    end

    local md = self.cameraMoveData
	md.minPos:Set(minX, defaultHeight, minZ)
	md.maxPos:Set(maxX, defaultHeight, maxZ)
	md.middlePos = middlePos
	md.forward:Set(dirV3[3]:Get())
end


function AutoChessManager:Update()
	local dt = Time.deltaTime
	self:UpdateCameraHeight()
	self:UpdateCameraPos()
	self:UpdateAllEntity(dt)
	self:CheckGameOver()
	if self.inScene and Input.GetKeyDown(KeyCode.R) then
		self:SetShowAttackRangeDebug(not self.showAttackRangeDebug)
	end
	if self.showAttackRangeDebug and self.attackRangeDebug ~= nil then
		self.attackRangeDebug:Update()
	end
end

---测试：显示/隐藏单位 attackRange 圆圈
---@param enabled boolean
function AutoChessManager:SetShowAttackRangeDebug(enabled)
	self.showAttackRangeDebug = enabled == true
	if self.attackRangeDebug ~= nil then
		self.attackRangeDebug:SetEnabled(self.showAttackRangeDebug)
	end
end

function AutoChessManager:UpdateCameraHeight()

	if self.cameraMoveData == nil then
		return
	end
	local cfg = self.cameraMoveData

	-- 鼠标滚轮控制视野缩放
	local scroll = Input.GetAxis("Mouse ScrollWheel")
	if scroll == 0 then
		return
	end


	local forward = cfg.forward * (cfg.zoomSpeed * scroll)
	local curPos = self.cameraTrs.position
	temp_v3:Set(curPos:Get())
	temp_v3:Add(forward)
	local y = mathx.clamp(temp_v3.y, cfg.minHeight, cfg.maxHeight)

	if y ~= temp_v3.y then
        local diffY = y - curPos.y
        -- 【优化1】加上分母防0保护，极度严谨
        if math.abs(forward.y) > 0.0001 then
            local ratio = diffY / forward.y
            local clampedForward = forward * ratio
            temp_v3:Set(curPos:Get())
            temp_v3:Add(clampedForward)
        else
            temp_v3.y = y
        end
	end
	self.cameraTrs.position = temp_v3
	self:CalculateCameraBounds()
end

function AutoChessManager:UpdateCameraPos()
	if self.cameraMoveData == nil then
		return
	end
	local mx, my = 0, 0
	if Input.GetKey(KeyCode.W) then
        my = my + 1
    end

	if Input.GetKey(KeyCode.A) then
        mx = mx - 1
    end
	if Input.GetKey(KeyCode.S) then
        my = my - 1
    end
	if Input.GetKey(KeyCode.D) then
        mx = mx + 1
    end

	if mx == 0 and my == 0 then
		return
	end
	local t = Time.deltaTime * 5
	local pos = self.cameraTrs.position
	temp_v3:Set(mx * t, 0, my * t)
	local addPos = temp_v3:Add(pos)
	addPos.x = mathx.clamp(addPos.x, self.cameraMoveData.minPos.x, self.cameraMoveData.maxPos.x)
	addPos.z = mathx.clamp(addPos.z, self.cameraMoveData.minPos.z, self.cameraMoveData.maxPos.z)
	self.cameraTrs.position = addPos
end

function AutoChessManager:UpdateAllEntity(dt)

	if self.entityTables == nil then
		return
	end
    for i = 1, #self.updateKeys do
        self.updateKeys[i] = nil
    end
    local index = 1
    for uid, _ in pairs(self.entityTables) do
        self.updateKeys[index] = uid
        index = index + 1
    end

    table.sort(self.updateKeys, function(a, b)
        return a < b
    end)

    for i = 1, #self.updateKeys do
        local uid = self.updateKeys[i]
        local entity = self:GetEntity(uid)
        if entity and (not entity.destroyed) then
			local success, err = xpcall(entity.Update, debug.traceback, entity, dt)
            if not success then
				LuaLogger.es(string.format("[AutoChessEntity Update Error] UID:%s \n%s", uid, tostring(err)))
                --entity.destroyed = true 
            end
        end
    end
end


function AutoChessManager:Clear()
	self:SetInScene(false)
	self.isBattleing = false
	self.isAIBattle = false
	if self.updateHandle then
		UpdateBeat:RemoveListener(self.updateHandle)
		self.updateHandle = nil
	end
end

---@return number
function AutoChessManager:GetTime()
	return Time.time
end

---鼠标位置转换地图位置
---@param x number
---@param y number
---@return number|nil, number|nil
function AutoChessManager:MousePosToWorldPos(x, y)
	local ray = self.camera:ScreenPointToRay(Vector3(x, y, 10))
	local isHit, dis = self.mapPlane:Raycast(ray)
	if not isHit then
		return
	end
	local point = ray:GetPoint(dis)
	return point.x, point.z
end


---@return int, int
function AutoChessManager:WorldPosToGridPos(x, y)
	local gx = math.floor(x / self.gridSize + 0.5)
	local gy = math.floor(y / self.gridSize + 0.5)
	if self.map ~= nil then
		local mw, mh = self.map:GetMapSize()
		if mw > 0 and mh > 0 then
			gx = mathx.clamp(gx, 1, mw)
			gy = mathx.clamp(gy, 1, mh)
		end
	else
		gx = math.max(1, gx)
		gy = math.max(1, gy)
	end
	return gx, gy
end


---格子索引转世界坐标（格子中心，与地图地块、寻路路点一致）
---@return number, number
function AutoChessManager:GridPosToWorldPos(x, y)
	return x * self.gridSize, y * self.gridSize
end

---将世界坐标吸附到最近格子中心
---@return number wx, number wz, number gx, number gy
function AutoChessManager:SnapWorldPosToGridCenter(wx, wz)
	local gx, gy = self:WorldPosToGridPos(wx, wz)
	local cx, cz = self:GridPosToWorldPos(gx, gy)
	return cx, cz, gx, gy
end

---@param entity AutoChessEntity
---@param epsilon number?
---@return boolean
function AutoChessManager:IsEntityOnGridCenter(entity, epsilon)
	if entity == nil then
		return true
	end
	epsilon = epsilon or 0.05
	local pos = entity:GetPosition()
	local gx, gy = entity:GetLogicalGridPos()
	local cx, cz = self:GridPosToWorldPos(gx, gy)
	local dx = pos.x - cx
	local dz = pos.z - cz
	return dx * dx + dz * dz <= epsilon * epsilon
end

---@param entity AutoChessEntity
---@return number wx, number wz
function AutoChessManager:GetEntityGridCenterPos(entity)
	local gx, gy = entity:GetLogicalGridPos()
	return self:GridPosToWorldPos(gx, gy)
end

---获取entity根节点
---@param entityType EntityType
---@return UnityEngine.Transform
function AutoChessManager:GetEntityRoot(entityType)
	return self.entityRoots[entityType]
end



---@param id int
---@return AutoChessEntity?
function AutoChessManager:GetEntity(id)
	if id == nil then
		return nil
	end

	if self.entityTables[id] == nil then
		return nil
	end
	return self.entityTables[id]
end

---获得所有非子弹的entity 
---@return AutoChessEntity[]?
function AutoChessManager:GetAllEntity()
	
	local entitys = {}
	for i = 1, #self.updateKeys do
		local id = self.updateKeys[i]
		local entity = self:GetEntity(id)
		if entity ~= nil and entity.entityType ~= CoveType.Bullet then
			table.insert(entitys, entity)
		end
	end
	return entitys
end



function AutoChessManager:GetEntityUID()
	self.entityUID = (self.entityUID or 0) + 1
	return self.entityUID
end


function AutoChessManager:ResetEntityUID()
	self.entityUID = 100000
end

---@param entityData AutoChessEntityInfo
---@return AutoChessEntity?
function AutoChessManager:CreateEntity(entityData)
	entityData.uid = entityData.uid or self:GetEntityUID()
	if entityData.side == nil then
		entityData.side = 1
	end
	local entityType = entityData.entityType
	local baseClass = self.entityClassBases[entityType]
	if baseClass == nil then
		return nil
	end
	---@type AutoChessEntity
	local entity = baseClass:new(entityData)
	entity:Init()
	self.entityTables[entity:GetUID()] = entity
	return entity
end



function AutoChessManager:RemoveEntity(uid)
	local entity = self.entityTables[uid]
	if entity == nil then
		return
	end
	self.entityTables[uid] = nil
	entity:Destroy()
end

function AutoChessManager:ClearAllEntities()
	if self.entityTables == nil then
		return
	end
	for uid, entity in pairs(self.entityTables) do
		if entity ~= nil and not entity.destroyed then
			entity:Destroy()
		end
		self.entityTables[uid] = nil
	end
end


---创建子弹
---@param id int 子弹id
---@param owner int|AutoChessEntity 主人id
---@return AutoChessBullet?
function AutoChessManager:CreateBullet(id, owner, skillId)
	local gridPos = {
		x = 0,
		y = 0
	}
	if type(owner) == "number" then
		owner = self:GetEntity(owner)
	end
	if owner == nil then
		return
	end
	gridPos.x, gridPos.y = owner:GetGridPos()
	local dirx, diry = owner:GetGridPos()
	---@type AutoChessEntityInfo
	local data = {
		entityType = GE.EntityType.Bullet,
		uid = self:GetEntityUID(),
		id = id,
		side = owner:GetSide(),
		owner = owner:GetUID(),
		gridPos = gridPos,
		dir = {x = dirx, y = diry},
		buffs = {},
		skillId = skillId,
	}
	return self:CreateEntity(data)
end

---创建召唤物
---@param id int 子弹id
---@param owner int|AutoChessEntity 主人id
---@return AutoChessBullet?
function AutoChessManager:CreateSummoner(id, owner, skillId)
	local gridPos = {
		x = 0,
		y = 0
	}
	if type(owner) == "number" then
		owner = self:GetEntity(owner)
	end
	if owner == nil then
		return
	end
	gridPos.x, gridPos.y = owner:GetGridPos()
	local dirx, diry = owner:GetGridPos()
	---@type AutoChessEntityInfo
	local data = {
		entityType = GE.EntityType.Player,
		uid = self:GetEntityUID(),
		id = id,
		side = owner:GetSide(),
		owner = owner:GetUID(),
		gridPos = gridPos,
		dir = {x = dirx, y = diry},
		buffs = {},
		skillId = skillId,
	}
	return self:CreateEntity(data)
end



function AutoChessManager:FindNearestEnemy(entity)
	if entity == nil then
		return nil
	end
	local pos = entity:GetPosition()
	local side = entity.GetSide and entity:GetSide() or nil
	local nearest = nil
	local nearestDis = nil
	for _, target in pairs(self.entityTables) do
		if target ~= entity and target.entityType ~= GE.EntityType.Bullet then
			local targetSide = target.GetSide and target:GetSide() or nil
			if side == nil or targetSide == nil or targetSide ~= side then
				local dis = Vector3.Distance(pos, target:GetPosition())
				if nearestDis == nil or dis < nearestDis then
					nearest = target
					nearestDis = dis
				end
			end
		end
	end
	return nearest
end

---行军途中是否遇到敌方（按格子距离，默认相邻格即停下）
---@param entity AutoChessEntity
---@param gridRange number? 切比雪夫距离，1 表示相邻八格
---@return AutoChessEntity?
function AutoChessManager:FindEncounterEnemy(entity, gridRange)
	if entity == nil or entity:IsDead() then
		return nil
	end
	gridRange = gridRange or 1
	local gx, gy = entity:GetGridPos()
	local side = entity:GetSide()
	if side == nil then
		return nil
	end

	local nearest = nil
	local nearestDis = nil
	for _, target in pairs(self.entityTables) do
		if target ~= entity and not target:IsDead() and target.entityType ~= GE.EntityType.Bullet then
			local targetSide = target.GetSide and target:GetSide() or nil
			if targetSide ~= nil and targetSide ~= side then
				local tx, ty = target:GetGridPos()
				local gridDis = math.max(math.abs(tx - gx), math.abs(ty - gy))
				if gridDis <= gridRange then
					if nearestDis == nil or gridDis < nearestDis then
						nearest = target
						nearestDis = gridDis
					end
				end
			end
		end
	end
	return nearest
end

---获取占据某格的角色（不含子弹、死者）
---@param gx integer
---@param gy integer
---@param excludeUid integer?
---@return AutoChessEntity?
function AutoChessManager:GetEntityAtGrid(gx, gy, excludeUid)
	for uid, entity in pairs(self.entityTables) do
		if excludeUid == nil or uid ~= excludeUid then
			if entity ~= nil and not entity.destroyed and not entity:IsDead()
				and entity.entityType ~= GE.EntityType.Bullet then
				local egx, egy = entity:GetLogicalGridPos()
				if egx == gx and egy == gy then
					return entity
				end
			end
		end
	end
	for uid, entity in pairs(self.entityTables) do
		if excludeUid == nil or uid ~= excludeUid then
			if entity ~= nil and not entity.destroyed and not entity:IsDead()
				and entity.entityType ~= GE.EntityType.Bullet then
				local mc = entity.moveController
				if mc ~= nil and mc.isMoveing
					and mc.reserveGx == gx and mc.reserveGy == gy then
					return entity
				end
			end
		end
	end
	return nil
end

---仅逻辑站立格（不含他人 reserve 落点）
---@param gx integer
---@param gy integer
---@param excludeUid integer?
---@return AutoChessEntity?
function AutoChessManager:GetEntityStandingAtGrid(gx, gy, excludeUid)
	for uid, entity in pairs(self.entityTables) do
		if excludeUid == nil or uid ~= excludeUid then
			if entity ~= nil and not entity.destroyed and not entity:IsDead()
				and entity.entityType ~= GE.EntityType.Bullet then
				local egx, egy = entity:GetLogicalGridPos()
				if egx == gx and egy == gy then
					return entity
				end
			end
		end
	end
	return nil
end

---友军是否正从该格离开（逻辑格在此，reserve 指向别处）
---@param entity AutoChessEntity
---@param gx integer
---@param gy integer
---@return boolean
function AutoChessManager:IsAllyVacatingGrid(entity, gx, gy)
	if entity == nil then
		return false
	end
	local mc = entity.moveController
	if mc == nil or not mc.isMoveing then
		return false
	end
	local egx, egy = entity:GetLogicalGridPos()
	if egx ~= gx or egy ~= gy then
		return false
	end
	if mc.reserveGx == nil or mc.reserveGy == nil then
		return false
	end
	return not (mc.reserveGx == gx and mc.reserveGy == gy)
end

---落脚占格：禁止与敌方或「占住/预约落点」的友方重叠；友方正在离开该格时可踏入
---@param selfEntity AutoChessEntity
---@param gx integer
---@param gy integer
---@return boolean blocked
function AutoChessManager:IsGridBlockedForLanding(selfEntity, gx, gy)
	if selfEntity == nil then
		return true
	end
	local excludeUid = selfEntity:GetUID()
	if self:IsGridStandOccupiedByEnemy(gx, gy, selfEntity) then
		return true
	end
	local stander = self:GetEntityStandingAtGrid(gx, gy, excludeUid)
	if stander ~= nil and stander:GetSide() == selfEntity:GetSide() then
		if not self:IsAllyVacatingGrid(stander, gx, gy) then
			return true
		end
	end
	if self:IsGridReservedByUnit(gx, gy, excludeUid) then
		return true
	end
	return false
end

---过境格：仅敌方阻挡，友方站立/路过均可穿过（落脚另判）
---@param selfEntity AutoChessEntity
---@param gx integer
---@param gy integer
---@return boolean blocked
function AutoChessManager:IsGridBlockedForTransit(selfEntity, gx, gy)
	if selfEntity == nil then
		return true
	end
	return self:IsGridStandOccupiedByEnemy(gx, gy, selfEntity)
end

---其他单位是否已预留该格（移动中）
---@param gx integer
---@param gy integer
---@param excludeUid integer?
---@return boolean
function AutoChessManager:IsGridReservedByUnit(gx, gy, excludeUid)
	for uid, entity in pairs(self.entityTables) do
		if excludeUid == nil or uid ~= excludeUid then
			if entity ~= nil and not entity.destroyed and not entity:IsDead()
				and entity.entityType ~= GE.EntityType.Bullet then
				local mc = entity.moveController
				if mc ~= nil and mc.isMoveing
					and mc.reserveGx == gx and mc.reserveGy == gy then
					return true
				end
			end
		end
	end
	return false
end

---@param gx integer
---@param gy integer
---@param excludeUid integer?
---@return boolean
function AutoChessManager:IsGridOccupiedByUnit(gx, gy, excludeUid)
	if self:GetEntityAtGrid(gx, gy, excludeUid) ~= nil then
		return true
	end
	return self:IsGridReservedByUnit(gx, gy, excludeUid)
end

---@param excludeUid integer?
---@param destGx integer?
---@param destGy integer?
function AutoChessManager:ApplyUnitOccupancyBlocks(walkMap, excludeUid, destGx, destGy)
	if walkMap == nil then
		return
	end
	local mover = excludeUid ~= nil and self.entityTables[excludeUid] or nil
	local moverSide = mover ~= nil and mover:GetSide() or nil
	for uid, entity in pairs(self.entityTables) do
		if excludeUid == nil or uid ~= excludeUid then
			if entity ~= nil and not entity.destroyed and not entity:IsDead()
				and entity.entityType ~= GE.EntityType.Bullet then
				local mc = entity.moveController
				if mc == nil or not mc.isMoveing then
					local shouldBlock = true
					if moverSide ~= nil and entity:GetSide() == moverSide then
						shouldBlock = false
					end
					if shouldBlock then
						local egx, egy = entity:GetLogicalGridPos()
						if walkMap[egy] ~= nil and walkMap[egy][egx] ~= nil then
							if not (destGx ~= nil and destGy ~= nil and egx == destGx and egy == destGy) then
								walkMap[egy][egx] = 1
							end
						end
					end
				end
			end
		end
	end
end

---格上是否有敌方单位站立
---@param gx integer
---@param gy integer
---@param selfEntity AutoChessEntity
---@return boolean
function AutoChessManager:IsGridStandOccupiedByEnemy(gx, gy, selfEntity)
	if selfEntity == nil then
		return false
	end
	local other = self:GetEntityAtGrid(gx, gy, selfEntity:GetUID())
	if other == nil then
		return false
	end
	return other:GetSide() ~= selfEntity:GetSide()
end

---格是否被敌方占用（仅统计已站住的敌方单位）
---@param gx integer
---@param gy integer
---@param selfEntity AutoChessEntity
---@return boolean
function AutoChessManager:IsGridBlockedByEnemy(gx, gy, selfEntity)
	return self:IsGridStandOccupiedByEnemy(gx, gy, selfEntity)
end

---@param entity AutoChessEntity
---@param fn fun(enemy: AutoChessEntity)
function AutoChessManager:ForEachEnemyOf(entity, fn)
	if entity == nil or fn == nil then
		return
	end
	local side = entity:GetSide()
	for _, other in pairs(self.entityTables) do
		if other ~= nil and not other.destroyed and not other:IsDead()
			and other.entityType ~= GE.EntityType.Bullet
			and other:GetSide() ~= side then
			fn(other)
		end 
	end
end

---@param entity AutoChessEntity
---@param fn fun(ally: AutoChessEntity)
function AutoChessManager:ForEachAllyOf(entity, fn)
	if entity == nil or fn == nil then
		return
	end
	local side = entity:GetSide()
	for _, other in pairs(self.entityTables) do
		if other ~= nil and not other.destroyed and not other:IsDead()
			and other.entityType ~= GE.EntityType.Bullet
			and other:GetSide() == side then
			fn(other)
		end
	end
end

---@param gx integer
---@param gy integer
---@param excludeUid integer?
---@param avoidGx integer?
---@param avoidGy integer?
---@param preferForwardDx integer? 朝敌方推进的 X 方向（1 或 -1），用于让位时优先前方邻格
---@return integer?
---@return integer?
function AutoChessManager:FindAdjacentVacantGrid(gx, gy, excludeUid, avoidGx, avoidGy, preferForwardDx)
	if self.map == nil then
		return nil, nil
	end
	local w, h = self.map:GetMapSize()
	local dirs = {
		{ 1, 0 }, { -1, 0 }, { 0, 1 }, { 0, -1 },
		{ 1, 1 }, { 1, -1 }, { -1, 1 }, { -1, -1 },
	}
	local bestGx, bestGy, bestScore = nil, nil, nil
	for i = 1, #dirs do
		local nx, ny = gx + dirs[i][1], gy + dirs[i][2]
		if nx >= 1 and nx <= w and ny >= 1 and ny <= h then
			if not (avoidGx ~= nil and avoidGy ~= nil and nx == avoidGx and ny == avoidGy)
				and self.map:GetMapBlockVal(nx, ny) == 0
				and not self:IsGridOccupiedByUnit(nx, ny, excludeUid) then
				local score = 0
				if preferForwardDx ~= nil and preferForwardDx ~= 0 then
					local xDelta = nx - gx
					if xDelta * preferForwardDx < 0 then
						score = score + 80
					elseif xDelta * preferForwardDx > 0 then
						score = score - 8
					end
				end
				if ny < gy then
					score = score + 20
				end
				if bestScore == nil or score < bestScore then
					bestGx, bestGy, bestScore = nx, ny, score
				end
			end
		end
	end
	return bestGx, bestGy
end

---@param entity AutoChessEntity
function AutoChessManager:SnapEntityToGridCenter(entity)
	if entity == nil or entity:IsDead() then
		return
	end
	local gx, gy = entity:GetGridPos()
	local wx, wz = self:GridPosToWorldPos(gx, gy)
	local pos = entity:GetPosition()
	entity:SetMovePosition(Vector3.New(wx, pos.y, wz))
	entity:SetCacheDataVal("ai_grid_aligning", nil)
end

---平滑移动到指定格心（失败则瞬移）
---@param entity AutoChessEntity
---@param gx integer
---@param gy integer
---@param cb fun(entity: AutoChessEntity)?
---@return boolean started 是否已发起移动
function AutoChessManager:SmoothMoveEntityToGrid(entity, gx, gy, cb)
	if entity == nil or entity:IsDead() then
		return false
	end
	local wx, wz = self:GridPosToWorldPos(gx, gy)
	local pos = entity:GetPosition()
	local targetPos = Vector3.New(wx, pos.y, wz)
	local mc = entity.moveController
	if mc ~= nil and entity:CanMove() then
		mc:MoveToWorldPosSmooth(targetPos, cb)
		return true
	end
	entity:SetMovePosition(targetPos)
	if cb ~= nil then
		cb(entity)
	end
	return false
end

---抵达意图格附近时，若落点被占则平滑移到意图格周边最近空格
---@param entity AutoChessEntity
---@param intentGx integer?
---@param intentGy integer?
---@param fromGx integer?
---@param fromGy integer?
---@return boolean relocated
function AutoChessManager:RelocateEntityNearIntentGrid(entity, intentGx, intentGy, fromGx, fromGy)
	if entity == nil or entity:IsDead() or intentGx == nil or intentGy == nil then
		return false
	end
	local gx, gy = entity:GetGridPos()
	if math.abs(gx - intentGx) + math.abs(gy - intentGy) > 1 then
		return false
	end
	local overlapped = self:GetEntityAtGrid(intentGx, intentGy, entity:GetUID()) ~= nil
	if not overlapped then
		return false
	end
	local preferForwardDx = nil
	local side = entity:GetSide()
	if side == 1 then
		preferForwardDx = 1
	elseif side == 2 then
		preferForwardDx = -1
	end
	local vx, vy = self:FindAdjacentVacantGrid(intentGx, intentGy, entity:GetUID(), fromGx, fromGy, preferForwardDx)
	if vx == nil then
		vx, vy = self:FindAdjacentVacantGrid(intentGx, intentGy, entity:GetUID(), nil, nil, preferForwardDx)
	end
	if vx == nil then
		vx, vy = self:FindNearestVacantGrid(intentGx, intentGy, entity:GetUID())
	end
	if vx == gx and vy == gy then
		return false
	end
	return self:SmoothMoveEntityToGrid(entity, vx, vy, nil)
end

---同格重叠时，UID 较大者挪到附近空格
---@param entity AutoChessEntity
function AutoChessManager:ResolveEntityGridOverlap(entity)
	if entity == nil or entity:IsDead() then
		return
	end
	local gx, gy = entity:GetGridPos()
	local other = self:GetEntityAtGrid(gx, gy, entity:GetUID())
	if other == nil then
		return
	end
	if entity:GetUID() > other:GetUID() then
		self:RelocateEntityToVacantGrid(entity)
	end
end

---将单位平滑移到附近可站立格心
---@param entity AutoChessEntity
---@return boolean relocated
function AutoChessManager:RelocateEntityToVacantGrid(entity)
	if entity == nil or entity:IsDead() then
		return false
	end
	local gx, gy = entity:GetGridPos()
	local vx, vy = self:FindAdjacentVacantGrid(gx, gy, entity:GetUID())
	if vx == nil then
		vx, vy = self:FindNearestVacantGrid(gx, gy, entity:GetUID())
	end
	if vx == gx and vy == gy then
		return false
	end
	return self:SmoothMoveEntityToGrid(entity, vx, vy, nil)
end

---目标格被占时，螺旋搜索最近可站立格（地形可走且无人）
---@param gx integer
---@param gy integer
---@param excludeUid integer?
---@return integer
---@return integer
function AutoChessManager:FindNearestVacantGrid(gx, gy, excludeUid)
	if self.map == nil then
		return gx, gy
	end
	local w, h = self.map:GetMapSize()
	gx = mathx.clamp(gx, 1, w)
	gy = mathx.clamp(gy, 1, h)
	if self.map:GetMapBlockVal(gx, gy) == 0 and not self:IsGridOccupiedByUnit(gx, gy, excludeUid) then
		return gx, gy
	end
	for r = 1, math.max(w, h) do
		for dy = -r, r do
			for dx = -r, r do
				if dx ~= 0 or dy ~= 0 then
					local nx, ny = gx + dx, gy + dy
					if nx >= 1 and nx <= w and ny >= 1 and ny <= h then
						if self.map:GetMapBlockVal(nx, ny) == 0
							and not self:IsGridOccupiedByUnit(nx, ny, excludeUid) then
							return nx, ny
						end
					end
				end
			end
		end
	end
	return gx, gy
end

---技能 attackRange 换算为大致格子跨度（世界距离 / gridSize，向上取整）
---@param range number
---@return integer
function AutoChessManager:SkillRangeToGridCount(range)
	if range == nil or range <= 0 then
		return 0
	end
	return math.max(1, math.ceil(range / self.gridSize))
end

---按技能表 attackRange / minAttackRange / targetMask 索敌（世界距离圆形范围，XZ 平面）
---@param entity AutoChessEntity
---@param skillCfg AutoChessSkillTable
---@return AutoChessEntity?
function AutoChessManager:FindEnemyInSkillRange(entity, skillCfg)
	if entity == nil or skillCfg == nil then
		return nil
	end
	local radius = skillCfg.attackRange
	if radius == nil or radius <= 0 then
		return nil
	end
	local minR = skillCfg.minAttackRange or 0
	local searchMask = skillCfg.targetMask
	return self:GetNearestEntityInRange(entity:GetPosition(), radius, entity, searchMask, function(target)
		if entity:GetSide() == target:GetSide() then
			return false
		end
		if minR > 0 then
			local dis = self:GetEnitytDistance(entity:GetUID(), target:GetUID())
			if dis >= 0 and dis < minR then
				return false
			end
		end
		return true
	end)
end

---按技能表在射程内查找最近友方（不含自己）
---@param entity AutoChessEntity
---@param skillCfg AutoChessSkillTable
---@return AutoChessEntity?
function AutoChessManager:FindAllyInSkillRange(entity, skillCfg)
	if entity == nil or skillCfg == nil then
		return nil
	end
	local radius = skillCfg.attackRange
	if radius == nil or radius <= 0 then
		return nil
	end
	local searchMask = skillCfg.targetMask
	return self:GetNearestEntityInRange(entity:GetPosition(), radius, entity, searchMask, function(target)
		if target == entity then
			return false
		end
		return entity:GetSide() == target:GetSide()
	end)
end



function AutoChessManager:SaveBattleInfo()
	if self.isBattleing then	---战斗中不能保存
		return
	end
	local battleInfo = self:CollectBattleInfoFromScene()
	local str = json.encode(battleInfo)
	MyPrefs:SetString("BattleInfo", str)
end

--- 获取编辑器半场地图（未镜像扩展），用于保存与 AI 开战
---@return int[][]?
function AutoChessManager:GetEditorMapData()
	return self.editorMapData
end

--- 从当前场景收集编队（地图 + 单位，不含子弹）
---@return table battleInfo
function AutoChessManager:CollectBattleInfoFromScene()
	local battleInfo = {}
	battleInfo.map = self:GetEditorMapData() or self.map.map
	battleInfo.entitys = {}
	for _, v in pairs(self.entityTables) do
		if v.entityType ~= GE.EntityType.Bullet then
			table.insert(battleInfo.entitys, tablex.copy(v.data, true))
		end
	end
	return battleInfo
end

--- 收集当前场景友方（side=1）编队，用于 AI 测试开战
---@return AutoChessEntityInfo[]
function AutoChessManager:CollectAllyFormationsFromScene()
	local list = {}
	for _, v in pairs(self.entityTables) do
		if v.entityType ~= GE.EntityType.Bullet and not v:IsDead() then
			local side = v:GetSide()
			if side == nil or side == 1 then
				table.insert(list, tablex.copy(v.data, true))
			end
		end
	end
	return list
end

function AutoChessManager:LoadBattleInfo()
	local str = MyPrefs:GetString("BattleInfo")
	if string.isNullOrEmpty(str) then
		return nil
	end
	local battleInfo = json.decode(str)
	if battleInfo == nil or tablex.empty(battleInfo) then
		return nil
	end
	return battleInfo
end



function AutoChessManager:StartBattle()
	if self.isBattleing then
		return
	end
	local battleInfo = self:LoadBattleInfo()
	if battleInfo == nil or battleInfo.map == nil then
		return
	end

	self.isAIBattle = false

	local formations = {}
	local savedEntitys = battleInfo.entitys
	if savedEntitys ~= nil then
		for i = 1, #savedEntitys do
			local d = savedEntitys[i]
			if d.side == nil or d.side == 1 then
				table.insert(formations, tablex.copy(d, true))
			end
		end
	end
	self:SavePreBattleSnapshot(formations, battleInfo.map)

	for k, v in pairs(self.entityTables) do
		self:RemoveEntity(v:GetUID())
	end
	--self.entityTables = {}



	self:ResetEntityUID()
	local w = self:ExpandBattleMap(battleInfo.map)

	self:ResetEntityUID()
	---@type AutoChessEntityInfo[]
	local entitys = battleInfo.entitys

	if entitys ~= nil then
		for i = 1, #entitys do
			local data = entitys[i]
			data.uid = self:GetEntityUID()
			self:CreateEntity(data)

			--创建镜像
			local mirrorData = tablex.copy(data, true)
			mirrorData.uid = self:GetEntityUID()
			local gridPos = mirrorData.gridPos
			gridPos.x = 2 * w - gridPos.x + 1
			mirrorData.gridPos = gridPos
			mirrorData.side = 2
			self:CreateEntity(mirrorData)
		end
	end
	self:FinishBattleStart()
end

--- AI 演示开战：委托 AIModule，便于 AI 子系统独立迁移
function AutoChessManager:StartAIBattle()
	require("AIModule").StartDemoBattle()
end

---@param b_map int[][]
---@return int w
function AutoChessManager:ExpandBattleMap(b_map)
	self.editorMapData = b_map
	local w = #b_map[1]
	local h = #b_map
	local map = {}

	for y = 1, h do
		map[y] = {}
		for x = 1, w do
			map[y][x] = b_map[y][x]
			local turnx = 2 * w - x + 1
			map[y][turnx] = b_map[y][x]
		end
	end
	self.map:SetMapData(map)
	self.map:CreateMapGrid()
	return w
end

function AutoChessManager:FinishBattleStart()
	self:RefreshDeployAnchors()
	self:CalculateCameraBounds()
	self.cameraTrs.position = self.cameraMoveData.middlePos
	self.isBattleing = true
end

---开战时按各方初始站位计算重心，供 AI 默认行军方向
function AutoChessManager:RefreshDeployAnchors()
	self.deployAnchorBySide = {}
	local sums = {}
	for _, entity in pairs(self.entityTables) do
		if entity ~= nil and not entity.destroyed
			and entity.entityType ~= GE.EntityType.Bullet then
			local side = entity:GetSide()
			if side ~= nil then
				local gx, gy = entity:GetGridPos()
				local bucket = sums[side]
				if bucket == nil then
					bucket = { sumX = 0, sumY = 0, count = 0 }
					sums[side] = bucket
				end
				bucket.sumX = bucket.sumX + gx
				bucket.sumY = bucket.sumY + gy
				bucket.count = bucket.count + 1
			end
		end
	end
	for side, bucket in pairs(sums) do
		if bucket.count > 0 then
			self.deployAnchorBySide[side] = {
				gx = math.floor(bucket.sumX / bucket.count + 0.5),
				gy = math.floor(bucket.sumY / bucket.count + 0.5),
			}
		end
	end
end

---@param entity AutoChessEntity
---@return integer gx
---@return integer gy
function AutoChessManager:GetEnemyDeployAnchor(entity)
	if entity == nil or self.map == nil then
		return 1, 1
	end
	local side = entity:GetSide() or 1
	local enemySide = (side == 2) and 1 or 2
	local anchor = self.deployAnchorBySide and self.deployAnchorBySide[enemySide]
	if anchor ~= nil then
		return anchor.gx, anchor.gy
	end
	local w, h = self.map:GetMapSize()
	local gx, gy = entity:GetGridPos()
	local targetGx = (side == 2) and 1 or w
	return targetGx, gy
end

---开战前快照：战斗结束后恢复编辑器编队
---@param allyFormations AutoChessEntityInfo[]
---@param editorMapData int[][]
function AutoChessManager:SavePreBattleSnapshot(allyFormations, editorMapData)
	self.preBattleSnapshot = {
		allies = {},
		mapData = self:CopyMapData(editorMapData),
	}
	if allyFormations ~= nil then
		for i = 1, #allyFormations do
			table.insert(self.preBattleSnapshot.allies, tablex.copy(allyFormations[i], true))
		end
	end
end

---@param mapData int[][]?
---@return int[][]?
function AutoChessManager:CopyMapData(mapData)
	if mapData == nil then
		return nil
	end
	return tablex.copy(mapData, true)
end

---@param entity AutoChessEntity
---@return boolean
local function isBattleUnitEntity(entity)
	return entity.entityType ~= GE.EntityType.Bullet
end

---@return table<integer, integer>
function AutoChessManager:CountAliveBattleUnits()
	local counts = { [1] = 0, [2] = 0 }
	for _, entity in pairs(self.entityTables) do
		if entity ~= nil and not entity.destroyed and not entity:IsDead()
			and isBattleUnitEntity(entity) then
			local side = entity:GetSide()
			if side == 1 then
				counts[1] = counts[1] + 1
			elseif side == 2 then
				counts[2] = counts[2] + 1
			end
		end
	end
	return counts
end

function AutoChessManager:RestorePreBattleScene()
	local snapshot = self.preBattleSnapshot
	self.preBattleSnapshot = nil
	self:ClearAllEntities()
	self:ResetEntityUID()
	if snapshot == nil or snapshot.mapData == nil then
		if self.editorMapData ~= nil then
			self.map:SetMapData(self:CopyMapData(self.editorMapData))
			self.map:CreateMapGrid()
		end
		self:CalculateCameraBounds()
		return
	end
	self.editorMapData = self:CopyMapData(snapshot.mapData)
	self.map:SetMapData(self.editorMapData)
	self.map:CreateMapGrid()
	for i = 1, #snapshot.allies do
		local data = tablex.copy(snapshot.allies[i], true)
		data.uid = self:GetEntityUID()
		data.side = 1
		data.dir = data.dir or { x = 1, y = 0 }
		self:CreateEntity(data)
	end
	self:CalculateCameraBounds()
	self.cameraTrs.position = self.cameraMoveData.middlePos
end


---@param e1Id int
---@param e2Id int
---@return number dis -1表示失败
function AutoChessManager:GetEnitytDistance(e1Id, e2Id)
	if e1Id == e2Id then
		return 0
	end

	local e1 = self:GetEntity(e1Id)
	local e2 = self:GetEntity(e2Id)
	if e1 == nil or e2 == nil then
		return -1
	end
	local pos1 = e1:GetPosition()
	local pos2 = e2:GetPosition()

	temp_v3:Set(pos1.x - pos2.x, pos1.y - pos2.y, pos1.z - pos2.z)
	local dis = temp_v3:Magnitude()
	return dis
end

---@param e1Id int
---@param e2Id int
---@return number dis -1表示失败
function AutoChessManager:GetEnitytSqrDistance(e1Id, e2Id)
	if e1Id == e2Id then
		return 0
	end

	local e1 = self:GetEntity(e1Id)
	local e2 = self:GetEntity(e2Id)
	if e1 == nil or e2 == nil then
		return -1
	end
	local pos1 = e1:GetPosition()
	local pos2 = e2:GetPosition()

	temp_v3:Set(pos1.x - pos2.x, pos1.y - pos2.y, pos1.z - pos2.z)
	local dis = temp_v3:SqrMagnitude()
	return dis
end

---添加buff
function AutoChessManager:AddBuff(targetId, buffId, releaserId)
	local target = self:GetEntity(targetId)
	if target == nil then
		return
	end

	local releaser = self:GetEntity(releaserId)
	if releaser == nil then
		return
	end
	target.buffControl:AddBuff({
		id = buffId,
		lv = 1,
		owner = target:GetUID(),
		source = releaser:GetUID(),
		createTime = self:GetTime(),
	})
end



---获取范围内的实体
---@param centerPos Vector3 中心点
---@param radius number 查找半径
---@param caster AutoChessEntity? 施法者
---@param searchMask AutoChessSearchType? 检索掩码(可为空)
---@param filterFun? fun(entity:AutoChessEntity):boolean|nil 自定义过滤规则(返回true表示符合)
---@return AutoChessEntity[]
function AutoChessManager:GetEntitiesInRange(centerPos, radius, caster, searchMask, filterFun)
	local result = {}
    local radiusSqr = radius * radius
	for uid, target in pairs(self.entityTables) do
		if target.destroyed or target.isDead then
			goto continue
		end
		if target.entityType == GE.EntityType.Bullet then
			goto continue
		end
        local targetPos = target:GetPosition()
        local dx = targetPos.x - centerPos.x
        local dz = targetPos.z - centerPos.z
        local distSqr = dx * dx + dz * dz
        if distSqr > radiusSqr then
            goto continue
        end
        if caster and searchMask and searchMask > 0 then
            if not self:CheckSearchFilter(caster, target, searchMask) then
                goto continue
            end
        end
		if filterFun ~= nil and not filterFun(target) then
			goto continue
		end
		table.insert(result, target)
		::continue::
	end
	return result
end

---获取范围内的实体 callback回调
---@param centerPos Vector3 中心点
---@param radius number 查找半径
---@param caster AutoChessEntity? 施法者
---@param searchMask AutoChessSearchType? 检索掩码(可为空)
---@param callback? fun(entity:AutoChessEntity):boolean|nil 自定义过滤规则(返回true表示符合)
function AutoChessManager:DoEntitiesInRange(centerPos, radius, caster, searchMask, callback)
	if callback == nil then
		return
	end
    local radiusSqr = radius * radius
	for uid, target in pairs(self.entityTables) do
		if target.destroyed or target.isDead then
			goto continue
		end
		if target.entityType == GE.EntityType.Bullet then
			goto continue
		end
        local targetPos = target:GetPosition()
        local dx = targetPos.x - centerPos.x
        local dz = targetPos.z - centerPos.z
        local distSqr = dx * dx + dz * dz
        if distSqr > radiusSqr then
            goto continue
        end
        if caster and searchMask and searchMask > 0 then
            if not self:CheckSearchFilter(caster, target, searchMask) then
                goto continue
            end
        end
		callback(target)
		::continue::
	end
end

---获取范围内距离最近的实体
---@param centerPos Vector3 中心点
---@param radius number 查找半径
---@param caster AutoChessEntity? 施法者
---@param searchMask integer? 检索掩码(可为空)
---@param filterFun? fun(entity:AutoChessEntity):boolean|nil 自定义过滤规则(返回true表示符合)
---@return AutoChessEntity|nil entity 返回最近的目标,如果没找到则返回 nil
function AutoChessManager:GetNearestEntityInRange(centerPos, radius, caster, searchMask, filterFun)
    local nearestTarget = nil
    local radiusSqr = radius * radius
    local minDistSqr = radiusSqr + 1
    for uid, target in pairs(self.entityTables) do
        if target.destroyed or target.isDead then 
			goto continue 
		end
        if target.entityType == GE.EntityType.Bullet then 
			goto continue 
		end
        
        local targetPos = target:GetPosition()
        local dx = targetPos.x - centerPos.x
        local dz = targetPos.z - centerPos.z
        local distSqr = dx * dx + dz * dz
        if distSqr > radiusSqr then
            goto continue
        end
        if distSqr >= minDistSqr then
            goto continue
        end
        if caster and searchMask and searchMask > 0 then
            if not self:CheckSearchFilter(caster, target, searchMask) then
                goto continue
            end
        end
        if filterFun ~= nil and not filterFun(target) then
            goto continue
        end
        minDistSqr = distSqr
        nearestTarget = target
        ::continue::
    end
    return nearestTarget
end



---获取扇形范围内的实体
---@param centerPos Vector3 扇形起点(施法者位置)
---@param forwardDir Vector3 扇形的朝向向量
---@param radius number 扇形半径
---@param angle number 扇形总角度(例如 90度, 120度)
---@param caster AutoChessEntity? 施法者自身(用于掩码判定)
---@param searchMask integer? 检索掩码(GE.AutoChessSearchType)
---@param filterFun? fun(entity:AutoChessEntity):boolean? 自定义过滤规则
---@return AutoChessEntity[]
function AutoChessManager:GetEntitiesInSector(centerPos, forwardDir, radius, angle, caster, searchMask, filterFun)
    local result = {}
    local forward = Vector3.New(forwardDir.x, 0, forwardDir.z)
    forward:SetNormalize()
    local radiusSqr = radius * radius
    local halfAngle = angle * 0.5
    local cosHalfAngle = math.cos(math.rad(halfAngle))
    
    for uid, target in pairs(self.entityTables) do
        if target.destroyed or target.isDead or target.entityType == GE.EntityType.Bullet then
            goto continue
        end
    
        local targetPos = target:GetPosition()
        local dx = targetPos.x - centerPos.x
        local dz = targetPos.z - centerPos.z
        
        local distSqr = dx * dx + dz * dz
        if distSqr > radiusSqr then
            goto continue
        end
        
        if distSqr > 0.0001 then
            -- 算出目标向量与前方向量的点乘
            local dotProduct = dx * forward.x + dz * forward.z
            local magnitude = math.sqrt(distSqr)
            if dotProduct < cosHalfAngle * magnitude then
                goto continue
            end
        end
        if caster and searchMask and searchMask > 0 then
            if not self:CheckSearchFilter(caster, target, searchMask) then
                goto continue
            end
        end
        -- 额外自定义条件
        if filterFun ~= nil and not filterFun(target) then
            goto continue
        end
        table.insert(result, target)
        ::continue::
    end
    return result
end

---获取矩形范围内的实体
---@param centerPos Vector3 矩形中心点
---@param forwardDir Vector3 矩形的朝向向量(需要标准化 normalized)
---@param length number 矩形长度(向前的射程)
---@param width number 矩形宽度(左右的总宽度)
---@param caster AutoChessEntity? 施法者
---@param searchMask AutoChessSearchType? 检索掩码(可为空)
---@param filterFun? fun(entity:AutoChessEntity):boolean? 自定义过滤规则(返回true表示符合)
---@return AutoChessEntity[]
function AutoChessManager:GetEntitiesInRectangle(centerPos, forwardDir, length, width, caster, searchMask, filterFun)
	local result = {}
    local forward = Vector3.New(forwardDir.x, 0, forwardDir.z)
    forward:SetNormalize()
    local right = Vector3.New(forward.z, 0, -forward.x)
    local halfWidth = width * 0.5
	local halfLength = length * 0.5

    local boundingRadiusSqr = (halfLength * halfLength) + (halfWidth * halfWidth)
	for uid, target in pairs(self.entityTables) do
		if target.destroyed or target.isDead then
			goto continue
		end
		if target.entityType == GE.EntityType.Bullet then
			goto continue
		end
		local targetPos = target:GetPosition()
		temp_v3:Set(targetPos.x - centerPos.x, 0, targetPos.z - centerPos.z)
		local offsetVec = temp_v3
		local distSqr = offsetVec:SqrMagnitude()
		if distSqr > boundingRadiusSqr then
			goto continue
		end
		local dotForward = Vector3.Dot(offsetVec, forward)
		local dotRight = Vector3.Dot(offsetVec, right)
		if math.abs(dotForward) > halfLength or math.abs(dotRight) > halfWidth then
			goto continue
		end
        if caster and searchMask and searchMask > 0 then
            if not self:CheckSearchFilter(caster, target, searchMask) then
                goto continue
            end
        end
		-- 符合矩形范围，再走自定义过滤逻辑
		if filterFun == nil or filterFun(target) then
			table.insert(result, target)
		end
		::continue::
	end
	return result
end

---获取环形范围内的实体
---@param centerPos Vector3 矩形中心点
---@param radius number 矩形的朝向向量(需要标准化 normalized)
---@param minRadius number 矩形长度(向前的射程)
---@param caster AutoChessEntity? 施法者
---@param searchMask AutoChessSearchType? 检索掩码(可为空)
---@param filterFun? fun(entity:AutoChessEntity):boolean? 自定义过滤规则(返回true表示符合)
---@return AutoChessEntity[]
function AutoChessManager:GetEntitiesInRing(centerPos, radius, minRadius, caster, searchMask, filterFun)
	local result = {}
    local radiusSqr = radius * radius
	local minRadiusSqr = minRadius * minRadius
	for k, target in pairs(self.entityTables) do
		if target.destroyed or target.isDead then
			goto continue
		end
		if target.entityType == GE.EntityType.Bullet then
			goto continue
		end
        local targetPos = target:GetPosition()
        local dx = targetPos.x - centerPos.x
        local dz = targetPos.z - centerPos.z
        local distSqr = dx * dx + dz * dz
        if distSqr > radiusSqr or distSqr < minRadiusSqr then
            goto continue
        end
        if caster and searchMask and searchMask > 0 then
            if not self:CheckSearchFilter(caster, target, searchMask) then
                goto continue
            end
        end
		if filterFun ~= nil and not filterFun(target) then
			goto continue
		end
		table.insert(result, target)
		::continue::
	end
	return result
end


---根据检索类型筛选目标
---@param caster AutoChessEntity 施法者
---@param target AutoChessEntity 要检测的目标实体
---@param searchMask AutoChessSearchType 检索掩码 (如: GE.AutoChessSearchType.Enemy + GE.AutoChessSearchType.Player)
---@return boolean 是否符合条件
function AutoChessManager:CheckSearchFilter(caster, target, searchMask)
    -- 如果没有配置掩码，通常默认找所有(或者按照你的需求改为 return false)
    if searchMask == 0 or searchMask == nil then
        return true 
    end
    if caster == target then
        if not self:HasFlag(searchMask, GE.AutoChessSearchType.Me) then
            return false -- 目标是自己，但掩码没允许包含自己
        end
    end
    -- 假设你的无敌状态标记是 GE.StatusSpecialFlag.eStatus_Invincible
    local isInvincible = target:HasFlag(GE.AutoChessFlag.eStatus_Invincibility)
    if isInvincible then
        if not self:HasFlag(searchMask, GE.AutoChessSearchType.Invinsible) then
            return false -- 目标无敌，但掩码没允许选中无敌单位
        end
    end

    local hasFriendFlag = self:HasFlag(searchMask, GE.AutoChessSearchType.Friend)
    local hasEnemyFlag = self:HasFlag(searchMask, GE.AutoChessSearchType.Enemy)
    
    if hasFriendFlag or hasEnemyFlag then
        local casterSide = caster:GetSide()
        local targetSide = target:GetSide()
        local isFriend = (casterSide == targetSide)
        
        if isFriend and not hasFriendFlag then
            return false -- 是友军，但只要敌军
        end
        if not isFriend and not hasEnemyFlag then
            return false -- 是敌军，但只要友军
        end
    end
    -- ================= 类型检测 (Player / Monster) =================
    local hasPlayerFlag = self:HasFlag(searchMask, GE.AutoChessSearchType.Player)
    local hasMonsterFlag = self:HasFlag(searchMask, GE.AutoChessSearchType.Monster)
    local hasBulletFlag = self:HasFlag(searchMask, GE.AutoChessSearchType.Bullet)
    -- 如果配了类型过滤，才进行严格检测
    if hasPlayerFlag or hasMonsterFlag or hasBulletFlag then
        local isPlayer = (target.entityType == GE.EntityType.Player)
        local isMonster = (target.entityType == GE.EntityType.Summon)
		local isBullet = (target.entityType == GE.EntityType.Bullet)
        if isPlayer and not hasPlayerFlag then
            return false
        end
        if isMonster and not hasMonsterFlag then
            return false
        end
		if isBullet and not hasBulletFlag then
            return false
        end
    end
    return true
end


---播放特效
---@param uid int 释放者
---@param effectId int 特效id
---@param pos Vector3 位置
---@param rotation Quaternion 朝向
function AutoChessManager:PlayEffect(uid, effectId, pos, rotation, parent, autoDestroyTime)
	--特效
	if effectId == 0 or effectId == "" then
		return
	end
	if parent == nil then
		parent = self:GetEntityRoot(GE.EntityType.Player)
	end
	local effectConfig = Config.GetSoundAndEffectInfo(effectId)
	if not effectConfig then
		LuaLogger.ws("特效配置不存在  ", effectId)
		return
	end
	local entity = self:GetEntity(uid)
    if entity == nil then
        --return
    end

	local effectName = effectConfig.effectResource
	local effectPath = string.format(Config.PrefabPath.BattleEffect, effectName, effectName)
	PoolMgr:Get(effectPath, function (obj)
		if (obj) then
            if entity ~= nil and entity.destroyed then
                PoolMgr.Free(obj)
                return 
            end
			-- LuaLogger.ds("BattleShowManager:playEffect", effectPath)
			obj.transform.position = pos
			if rotation then
				obj.transform.rotation = rotation
			end
			---@type UnityEngine.ParticleSystem
			local particle = obj.transform:Find("Effect"):GetComponent("ParticleSystem")
			particle:Simulate(0)
			particle:Play()
			local effect2 = obj.transform:Find("Effect_2")
			if not IsNull(effect2) then
				---@type UnityEngine.ParticleSystem
				local particle2 = effect2:GetComponent("ParticleSystem")
				particle2:Simulate(0)
				particle2:Play()
			end
			
            obj.transform:SetParent(parent, true)
			if entity ~= nil and not entity:IsDead() then
            	entity:AddEffect(effectId, obj)
			end
			if autoDestroyTime ~= nil then
				TimeMgr:AddWaitTimeExecute(autoDestroyTime, function()
					if entity ~= nil and not entity:IsDead() then
						local success = entity:RemoveEffect(effectId)
						if not success then
							PoolMgr.Free(obj)
						end
					else
						PoolMgr.Free(obj)
					end
				end, nil)
			end
		end
	end)
	--特效对应音效
	local soundName = effectConfig.SoundResource
	local soundPath = string.format(Config.AudioPath.SE, soundName)
	if soundName and soundName ~= "" then
		-- LuaLogger.ds("BattleShowManager:playEffect soundPath", soundPath)
		TimeMgr:AddWaitTimeExecute(effectConfig.delay, function()
			LuaMain:play2DSound(soundPath)
		end, nil)
	end
end

---判断掩码中是否包含某个标识
---@param mask integer 组合掩码
---@param flag integer 要检查的标志
---@return boolean
function AutoChessManager:HasFlag(mask, flag)
	if mask == 0 or flag == 0 then
		return false
	end
	local v = math.floor(mask / flag) % 2
	return v == 1
end


---检测是否战斗结束（任一阵营全灭）
function AutoChessManager:CheckGameOver()
	if not self.isBattleing then
		return
	end
	local counts = self:CountAliveBattleUnits()
	if counts[1] > 0 and counts[2] > 0 then
		return
	end
	local winnerSide = counts[1] > 0 and 1 or (counts[2] > 0 and 2 or 0)
	self:OnGameOver(winnerSide)
end

---结束战斗并恢复战前编队
---@param winnerSide integer? 0=双方全灭 1=友方 2=敌方
function AutoChessManager:OnGameOver(winnerSide)
	if not self.isBattleing then
		return
	end
	local msg = "双方全灭"
	if winnerSide == 1 then
		msg = "友方胜利"
	elseif winnerSide == 2 then
		msg = "敌方胜利"
	end
	local wasAIBattle = self.isAIBattle
	LuaLogger.ds("[AutoChess] 战斗结束: " .. msg .. "，恢复战前编队")
	self.isBattleing = false
	self.isAIBattle = false
	if wasAIBattle then
		require("AILog").EndSession("战斗结束: " .. msg)
	end
	self:SetShowAttackRangeDebug(false)
	self:RestorePreBattleScene()
end



---分发事件
---@param evenType AutoChessCombatEvent
---@param params any
function AutoChessManager:TakeEvent(evenType, params)
	if self.entityTables == nil then
		return
	end
    for i = 1, #self.updateKeys do
        self.updateKeys[i] = nil
    end
    local index = 1
    for uid, _ in pairs(self.entityTables) do
        self.updateKeys[index] = uid
        index = index + 1
    end

    table.sort(self.updateKeys, function(a, b)
        return a < b
    end)

    for i = 1, #self.updateKeys do
        local uid = self.updateKeys[i]
        local entity = self:GetEntity(uid)
        if entity and (not entity.destroyed) then
			entity.buffControl:TakeEvent(evenType, params)
        end
    end
end


function AutoChessManager:ttt(p1, p2, gx, gy)
	local role1 = self:GetEntity(100001)
	if role1 == nil then
		return
	end

	local role2 = self:GetEntity(100002)
	if role2 == nil then
		return
	end



	role1.buffControl:AddBuff({
		id = 2,
		lv = 1,
		owner = role1:GetUID(),
		source = role1:GetUID(),
		createTime = self:GetTime(),
	})

	self:AddBuff(owner:GetUID(), 2, owner:GetUID())

	--role1:CastSkill(10021, role2:GetUID(), role2:GetPosition())




	local context = {
		owner = role1,
		buffCaster = role1,
		eventType = nil,
		skillDamageInfo = GE.AutoChessCombatEvent.OnBeforeDamage,
		buffStack = nil
	}
	local tab = self:GetAllEntity()
	self.conditionChecker:FilterTargets(tab, {10012,20001}, context)
	local a = 0
end

function AutoChessManager:ttt1(endx, endy)
	local role1 = self:GetEntity(100001)
	if role1 == nil then
		return
	end
	local gx, gy = role1:GetGridPos()
    local paths = self.map:FindPath(gx, gy, endx, endy)
	if paths == nil then
		return
	end
	role1.moveController:MoveTo(paths, GE.AutoChessMoveType.Grid, nil, nil)
end


--- AI调试
function AutoChessManager:tttCastScenePlayers()
	local units = {}
	for _, e in pairs(self.entityTables) do
		if e.entityType == GE.EntityType.Player then
			table.insert(units, e)
		end
	end
	if #units < 2 then
		LuaLogger.ds("[AutoChess] tttCastScenePlayers 需要场景中至少 2 个角色")
		return
	end
	units[1]:CastSkill(10010, units[2]:GetUID(), units[2]:GetPosition())
end






return AutoChessManager