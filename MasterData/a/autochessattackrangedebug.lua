--- 测试用：在场景中绘制单位 attackRange 圆形范围（LineRenderer，Game 视图可见）
--- 开关：AutoChessManager:SetShowAttackRangeDebug(true) 或按 R 键
---@class AutoChessAttackRangeDebug
local AutoChessAttackRangeDebug = class("AutoChessAttackRangeDebug")

local SEGMENTS = 64
local LINE_Y_OFFSET = 0.12
local LINE_WIDTH = 0.08

local SIDE_COLORS = {
	[1] = Color.New(1, 0.3, 0.3, 0.95),
	[2] = Color.New(0.3, 0.75, 1, 0.95),
}
local DEFAULT_COLOR = Color.New(0.4, 1, 0.5, 0.95)

---@param mgr AutoChessManager
function AutoChessAttackRangeDebug:ctor(mgr)
	self.mgr = mgr
	self.enabled = false
	---@type UnityEngine.GameObject?
	self.root = nil
	---@type table<integer, {go: UnityEngine.GameObject, lr: UnityEngine.LineRenderer, points: Vector3[]}>
	self.rings = {}
end

---@param enabled boolean
function AutoChessAttackRangeDebug:SetEnabled(enabled)
	self.enabled = enabled == true
	if not self.enabled then
		self:ClearAll()
	end
end

function AutoChessAttackRangeDebug:GetRoot()
	if self.root ~= nil and not IsNull(self.root) then
		return self.root
	end
	local parent = self.mgr.sceneRoot
	self.root = GameObject("AutoChessAttackRangeDebug")
	if parent ~= nil and not IsNull(parent) then
		self.root.transform:SetParent(parent.transform, false)
	end
	return self.root
end

---@param entity AutoChessEntity
---@return number maxRange
function AutoChessAttackRangeDebug:GetEntityAttackRange(entity)
	local sc = entity.skillController
	if sc == nil or sc.skillPriority == nil then
		return 0
	end
	local maxRange = 0
	for i = 1, #sc.skillPriority do
		local cfg = Config.GetAutoChessSkillTable(sc.skillPriority[i])
		if cfg ~= nil and cfg.attackRange ~= nil and cfg.attackRange > maxRange then
			maxRange = cfg.attackRange
		end
	end
	return maxRange
end

---@param uid integer
---@return {go: UnityEngine.GameObject, lr: UnityEngine.LineRenderer, points: Vector3[]}
function AutoChessAttackRangeDebug:GetOrCreateRing(uid)
	local ring = self.rings[uid]
	if ring ~= nil and not IsNull(ring.go) then
		return ring
	end
	local go = GameObject("AttackRange_" .. tostring(uid))
	go.transform:SetParent(self:GetRoot().transform, false)
	local lr = go:AddComponent(TypeInfo.LineRenderer)
	lr.useWorldSpace = true
	lr.loop = true
	lr.startWidth = LINE_WIDTH
	lr.endWidth = LINE_WIDTH
	lr.numCornerVertices = 2
	lr.numCapVertices = 2
	local shader = UnityEngine.Shader.Find("Sprites/Default")
	if shader ~= nil then
		lr.material = UnityEngine.Material(shader)
	end
	local points = {}
	for i = 1, SEGMENTS do
		points[i] = Vector3.New(0, 0, 0)
	end
	lr.positionCount = SEGMENTS
	ring = { go = go, lr = lr, points = points }
	self.rings[uid] = ring
	return ring
end

---@param ring table
---@param cx number
---@param cy number
---@param cz number
---@param radius number
---@param color Color
function AutoChessAttackRangeDebug:ApplyCircle(ring, cx, cy, cz, radius, color)
	local lr = ring.lr
	local points = ring.points
	for i = 1, SEGMENTS do
		local t = (i - 1) / SEGMENTS * math.pi * 2
		local p = points[i]
		p:Set(cx + math.cos(t) * radius, cy, cz + math.sin(t) * radius)
	end
	lr.startColor = color
	lr.endColor = color
	lr.positionCount = SEGMENTS
	lr:SetPositions(points)
	if not ring.go.activeSelf then
		ring.go:SetActive(true)
	end
end

---@param uid integer
function AutoChessAttackRangeDebug:RemoveRing(uid)
	local ring = self.rings[uid]
	if ring == nil then
		return
	end
	if ring.go ~= nil and not IsNull(ring.go) then
		GameObject.Destroy(ring.go)
	end
	self.rings[uid] = nil
end

function AutoChessAttackRangeDebug:ClearAll()
	for uid, _ in pairs(self.rings) do
		self:RemoveRing(uid)
	end
	if self.root ~= nil and not IsNull(self.root) then
		GameObject.Destroy(self.root)
	end
	self.root = nil
end

function AutoChessAttackRangeDebug:Update()
	if not self.enabled or self.mgr.entityTables == nil then
		return
	end
	local alive = {}
	for _, entity in pairs(self.mgr.entityTables) do
		if entity ~= nil and not entity.destroyed and not entity:IsDead()
			and entity.entityType ~= GE.EntityType.Bullet then
			local uid = entity:GetUID()
			alive[uid] = true
			local maxRange = self:GetEntityAttackRange(entity)
			if maxRange > 0 then
				local pos = entity:GetPosition()
				local side = entity.GetSide and entity:GetSide() or 1
				local color = SIDE_COLORS[side] or DEFAULT_COLOR
				local ring = self:GetOrCreateRing(uid)
				self:ApplyCircle(ring, pos.x, pos.y + LINE_Y_OFFSET, pos.z, maxRange, color)
			else
				self:RemoveRing(uid)
			end
		end
	end
	for uid, _ in pairs(self.rings) do
		if not alive[uid] then
			self:RemoveRing(uid)
		end
	end
end

return AutoChessAttackRangeDebug
