-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/controller/claw_doll/sencemgr/ClawDollClawMove.lua

module("logic.extensions.welfare.controller.claw_doll.sencemgr.ClawDollClawMove", package.seeall)

local M = class("ClawDollClawMove")
local MoveLeftLimit = 2.2
local MoveRightLimit = -3
local MoveFrontLimit = -0.6
local MoveBackLimit = 0.6
local STATE = {
	DEFAULT = 1,
	CLAW = 2
}
local high = 1.6
local RopeSpeed = 0.6
local MaxLimitLength = 1.2
local MinLimitLength = 0.065
local SPEED = ClawDollConfig.instance:getSpeedByCfgId(ClawDollActivityView.CONFIGID)
local DEFAULT_STARTMOVE_POSITION = Vector3.New(0, 0, 2)
local DEFAULT_STARTENGINE_POSITION = Vector3.New(-0.6, 0, 0)

function M:ctor(go)
	self._go = go.gameObject
end

function M:onStart(table)
	self._verticalTrack = table.vertical
	self._engine = table.engine
	self._objCube = table.cube
	self._objRope = table.rope
	self._cursorRope = self._objRope:GetComponent(ComponentType.ObiRopeCursor)
	self._rope = self._objRope:GetComponent(ComponentType.ObiRope)
	self._isChange = false
	self._claw = table.claw
	self._clawLocalPosition = Vector3.New(self._claw.gameObject.transform.localPosition.x, self._claw.gameObject.transform.localPosition.y, self._claw.gameObject.transform.localPosition.z)
	self._animator = self._claw:GetComponent(ComponentType.Animator)
	self._initDirection = Vector3.New(0, 0, 0)
	self._staus = STATE.DEFAULT
	self._moveToInitPosition = false
	self._bollListFirst = table.bollListFirst
	self._bollListSecond = table.bollListSecond
	self._bollListThird = table.bollListThird
	self._curClawBoll = nil
end

function M:onMove(initMoveDirection)
	self._initDirection = initMoveDirection
end

function M:Update()
	if MoveRightLimit - 1e-05 <= self._verticalTrack.transform.localPosition.z and self._verticalTrack.transform.localPosition.z <= MoveLeftLimit + 1e-05 then
		local verticallTaskMoveDirection = Vector3.New(0, 0, -self._initDirection.x)
		local tempV3 = self._verticalTrack.transform.localPosition + verticallTaskMoveDirection * Time.deltaTime * SPEED

		if tempV3.z < MoveRightLimit - 1e-05 then
			local tempLimit = Vector3.New(0, 0, MoveRightLimit)

			self._verticalTrack.transform.localPosition = Vector3.MoveTowards(self._verticalTrack.transform.localPosition, tempLimit, Time.deltaTime * SPEED)
		elseif tempV3.z > MoveLeftLimit + 1e-05 then
			local tempLimit = Vector3.New(0, 0, MoveLeftLimit)

			self._verticalTrack.transform.localPosition = Vector3.MoveTowards(self._verticalTrack.transform.localPosition, tempLimit, Time.deltaTime * SPEED)
		else
			self._verticalTrack.transform:Translate(verticallTaskMoveDirection * Time.deltaTime * SPEED)
		end
	end

	if MoveFrontLimit - 1e-05 <= self._engine.transform.localPosition.x and self._engine.transform.localPosition.x <= MoveBackLimit + 1e-05 then
		local engineMoveDirection = Vector3.New(self._initDirection.y, 0, 0)
		local tempV3 = self._engine.transform.localPosition + engineMoveDirection * Time.deltaTime * SPEED

		if tempV3.x < MoveFrontLimit - 1e-05 then
			local tempLimit = Vector3.New(MoveFrontLimit, 0, 0)

			self._engine.transform.localPosition = Vector3.MoveTowards(self._engine.transform.localPosition, tempLimit, Time.deltaTime * SPEED)

			Astral.TransformUtil.SetLocalPos(self._engine.transform, MoveFrontLimit, 0, 0)
		elseif tempV3.x > MoveBackLimit + 1e-05 then
			local tempLimit = Vector3.New(MoveBackLimit, 0, 0)

			self._engine.transform.localPosition = Vector3.MoveTowards(self._engine.transform.localPosition, tempLimit, Time.deltaTime * SPEED)

			Astral.TransformUtil.SetLocalPos(self._engine.transform, MoveBackLimit, 0, 0)
		else
			self._engine.transform:Translate(engineMoveDirection * Time.deltaTime * SPEED)
		end
	end

	if self._isChange == true and self._rope.restLength < MaxLimitLength then
		ViewBlockMgr.instance:blockClick(true, ViewBlockKey.Anim)

		self._staus = STATE.CLAW

		self._cursorRope:ChangeLength(self._rope.restLength + RopeSpeed * Time.deltaTime)

		if self._rope.restLength > MaxLimitLength then
			self._animator:SetBool("isClaw", true)
			settimer(2, self._grabCallBack, self, false)
		end
	elseif self._isChange == false and self._rope.restLength > MinLimitLength then
		self._cursorRope:ChangeLength(self._rope.restLength - RopeSpeed * Time.deltaTime)

		if self._rope.restLength < MinLimitLength then
			if self:isClawBoll() then
				self:_enableRigidbody(false)
			end

			self._moveToInitPosition = true
		end
	end

	if self._moveToInitPosition == true and self._staus == STATE.CLAW then
		self._verticalTrack.transform.localPosition = Vector3.MoveTowards(self._verticalTrack.transform.localPosition, DEFAULT_STARTMOVE_POSITION, Time.deltaTime * SPEED)
		self._engine.transform.localPosition = Vector3.MoveTowards(self._engine.transform.localPosition, DEFAULT_STARTENGINE_POSITION, Time.deltaTime * SPEED)

		if self._curClawBoll and (self._verticalTrack.transform.localPosition ~= DEFAULT_STARTMOVE_POSITION or self._engine.transform.localPosition ~= DEFAULT_STARTENGINE_POSITION) then
			local dis = Vector3.Distance(self._curClawBoll.transform.position, self._objCube.transform.position)

			if dis > 1 then
				self:_enableRigidbody(true)
			end
		elseif self._verticalTrack.transform.localPosition == DEFAULT_STARTMOVE_POSITION and self._engine.transform.localPosition == DEFAULT_STARTENGINE_POSITION then
			self:_enableRigidbody(true)
			self._animator:SetBool("isClaw", false)
			settimer(2, self.noGetBoll, self, false)
		end
	end

	if self._staus == STATE.DEFAULT then
		self:checkOutLine(true)
	else
		self:checkOutLine(false)
	end
end

function M:noGetBoll()
	self._staus = STATE.DEFAULT
	self._moveToInitPosition = false
	self._curClawBoll = nil

	GlobalDispatcher:dispatchEvent(EventType.CLAW_DOLL_BTNINTERACT_DRAG, false)
	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Anim)
end

function M:isClawBoll()
	for i = 0, self._bollListFirst.transform.childCount - 1 do
		local childObj = self._bollListFirst.transform:GetChild(i).gameObject

		if childObj.transform.childCount == 1 then
			local bollTran = childObj.transform:GetChild(0).gameObject.transform

			if bollTran.localPosition.y > high then
				self._curClawBoll = bollTran.gameObject

				return true
			end
		elseif childObj.transform.childCount == 0 then
			break
		end
	end

	for i = 0, self._bollListSecond.transform.childCount - 1 do
		local childObj = self._bollListSecond.transform:GetChild(i).gameObject

		if childObj.transform.childCount == 1 then
			local bollTran = childObj.transform:GetChild(0).gameObject.transform

			if bollTran.localPosition.y > high then
				self._curClawBoll = bollTran.gameObject

				return true
			end
		elseif childObj.transform.childCount == 0 then
			break
		end
	end

	for i = 0, self._bollListThird.transform.childCount - 1 do
		local childObj = self._bollListThird.transform:GetChild(i).gameObject

		if childObj.transform.childCount == 1 then
			local bollTran = childObj.transform:GetChild(0).gameObject.transform

			if bollTran.localPosition.y > high then
				self._curClawBoll = bollTran.gameObject

				return true
			end
		elseif childObj.transform.childCount == 0 then
			break
		end
	end

	return nil
end

function M:_enableRigidbody(bool)
	if self._curClawBoll then
		self._curClawBoll:GetComponent("Rigidbody").useGravity = bool
	end
end

function M:checkOutLine(bool)
	for i = 0, self._bollListFirst.transform.childCount - 1 do
		local childObj = self._bollListFirst.transform:GetChild(i).gameObject

		if childObj.transform.childCount == 1 then
			local bollObj = childObj.transform:GetChild(0).gameObject

			self:_isInClawSize(bollObj, bool)
		elseif childObj.transform.childCount == 0 then
			break
		end
	end

	for i = 0, self._bollListSecond.transform.childCount - 1 do
		local childObj = self._bollListSecond.transform:GetChild(i).gameObject

		if childObj.transform.childCount == 1 then
			local bollObj = childObj.transform:GetChild(0).gameObject

			self:_isInClawSize(bollObj, bool)
		elseif childObj.transform.childCount == 0 then
			break
		end
	end

	for i = 0, self._bollListThird.transform.childCount - 1 do
		local childObj = self._bollListThird.transform:GetChild(i).gameObject

		if childObj.transform.childCount == 1 then
			local bollObj = childObj.transform:GetChild(0).gameObject

			self:_isInClawSize(bollObj, bool)
		elseif childObj.transform.childCount == 0 then
			break
		end
	end
end

function M:_isInClawSize(bollObj, bool)
	local colorHemisphere = goutil.findChild(bollObj, "s301_ball_c")

	if colorHemisphere == nil then
		colorHemisphere = goutil.findChild(bollObj, "s301_ball_d")

		if colorHemisphere == nil then
			colorHemisphere = goutil.findChild(bollObj, "s301_ball_b")
		end
	end

	local transparentHemisphere = goutil.findChild(bollObj, "s301_ball_a")

	if bool and math.abs(bollObj.transform.position.x - self._objCube.transform.position.x) <= 0.3 and math.abs(bollObj.transform.position.z - self._objCube.transform.position.z) <= 0.3 then
		self:_setEdge(colorHemisphere.gameObject, 0.03)
		self:_setEdge(transparentHemisphere.gameObject, 0.03)
	else
		self:_setEdge(colorHemisphere.gameObject, 0)
		self:_setEdge(transparentHemisphere.gameObject, 0)
	end
end

function M:_setEdge(edgeGo, size)
	local setter = MaterialSetter.Get(edgeGo)
	local meshrender = edgeGo:GetComponent(typeof(UnityEngine.MeshRenderer))

	if size == 0 then
		meshrender.renderingLayerMask = 1
	else
		meshrender.renderingLayerMask = 1048577
	end

	setter:SetFloat(UnityEngine.Shader.PropertyToID("_SelectOutline"), size)
end

function M:_grabCallBack()
	self._isChange = false
end

function M:Release()
	return
end

function M:ropeLengthChange(msg)
	self._isChange = msg
end

return M
