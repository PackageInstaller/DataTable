-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/halo/HaloLinkLine.lua

module("logic.battle.battleflow.component.halo.HaloLinkLine", package.seeall)

local M = class("HaloLinkLine", IBattleReusable)
local kTexUSpeed = UnityEngine.Shader.PropertyToID("_Basics_Tex_U_Speed")
local kDefaultTexUSpeed = -1
local kSceneRoot = SceneMgr.instance:getSceneRoot()
local kHaloLinksRoot = goutil.create("HaloLinks")

goutil.addChildToParent(kHaloLinksRoot, kSceneRoot)

M.mainGO = false
M._line = false

function M:ctor()
	self._friendLine = nil
	self._enemyLine = nil
	self._timeWaiter = TimeWaiter.New()
	self._removedHandler = Handler.New()
	self.mainGO = goutil.create("line")

	goutil.addChildToParent(self.mainGO, kHaloLinksRoot)
end

function M:getRes(url)
	local resMgr = BattleMgr.instance:getResourceMgr()
	local goLine = resMgr:getInst(url)

	goutil.addChildToParent(goLine, self.mainGO)

	return goLine
end

function M:setEntityId(fromEntityId, toEntityId)
	self._fromEntityId = fromEntityId
	self._toEntityId = toEntityId
end

function M:setShapeAndRange(shape, range)
	self._range = range
	self._shape = shape
end

function M:getShapeAndRange()
	return self._shape, self._range
end

function M:isTargetLink(fromEntityId, toEntityId)
	return self._fromEntityId == fromEntityId and self._toEntityId == toEntityId
end

function M:setRelation(isSameOrFriendRelation)
	self._isFriendRelation = isSameOrFriendRelation

	if isSameOrFriendRelation then
		if self._friendLine then
			goutil.setActive(self._friendLine, true)
		else
			self._friendLine = self:getRes(BattleResourceName.FriendHaloLinks)
			self._friendAnim = self._friendLine:GetComponent(ComponentType.Animation)
		end

		self._animation = self._friendAnim
	else
		if self._enemyLine then
			goutil.setActive(self._enemyLine, true)
		else
			self._enemyLine = self:getRes(BattleResourceName.EnemyHaloLinks)
			self._enemyAnim = self._enemyLine:GetComponent(ComponentType.Animation)
		end

		self._animation = self._enemyAnim
	end
end

function M:reuse()
	goutil.setActive(self.mainGO, true)
	goutil.setActive(self._friendLine, false)
	goutil.setActive(self._enemyLine, false)
	self._timeWaiter:clear()
	self._removedHandler:clear()
end

function M:reset()
	goutil.setActive(self.mainGO, false)
	self._timeWaiter:clear()
	self._removedHandler:clear()
end

function M:show()
	self._animation:Play("scene_halo_enemy_start")
	AnimationUtils.SetPlaySpeed(self._animation, BattleTime.timeScale)
end

function M:hide()
	self._animation:Play("scene_halo_enemy_end")
	self._timeWaiter:start(2, self._onLineHideFinish, self)
	AnimationUtils.SetPlaySpeed(self._animation, BattleTime.timeScale)
end

function M:setReturnCallBack(func, handler)
	self._removedHandler:setListener(func, handler)
end

function M:_onLineHideFinish()
	self._removedHandler:call(self)
end

function M:destroy()
	removetimer(self._onPlayEnd, self)

	if self.mainGO then
		goutil.destroy(self.mainGO)

		self.mainGO = nil
	end
end

function M:setStartPositionXYZ(x, y, z)
	self._startX = x
	self._startY = y
	self._startZ = z

	TransformUtils.SetPosition(self.mainGO.transform, x, y, z)
end

function M:setEndPositionXYZ(x, y, z)
	goutil.setActive(self.mainGO, true)

	local vect = BattleMathUtil.tempVec3

	vect:Set(x - self._startX, y - self._startY, z - self._startZ)

	local scaleX = vect:Magnitude() * 0.5
	local transform = self.mainGO.transform

	TransformUtils.LookAtFromRight(transform, vect.x, vect.y, vect.z)
	TransformUtils.SetLocalScale(transform, scaleX, 1, 1)
end

function M:getToEntityId()
	return self._toEntityId
end

function M:getFromEntityId()
	return self._fromEntityId
end

function M:setPlaySpeed(playSpeed)
	return
end

function M:rebuild()
	return
end

return M
