-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/component/AirWorkHotAreaChecker.lua

module("logic.extensions.airworkshop.flow.defflow.component.AirWorkHotAreaChecker", package.seeall)

local M = class("AirWorkHotAreaChecker", IBattleFlowComp)
local kRaycastPosList = {}
local kP1Vector = {}
local kP2Vector = {}
local kTempVec3 = Vector3.New()

function M:onInit()
	return
end

function M:onStart()
	self._boardModel = self.flow.boardModel or false
	self._unitMgr = self.flow.unitMgr or false
	self._model = self.flow.model or false
	self._boardMgr = self.flow.boardMgr or false
	self._screenWidth = UnityEngine.Screen.width
	self._screenHeight = UnityEngine.Screen.height
	self._kHotAreaWidth = 0.282 * self._screenWidth
	self._kHotAreaDownHeight = 0.283 * self._screenHeight
	self._kHotAreaUpHeight = 0.335 * self._screenHeight
	self._timeWaiter = TimeWaiter.New()
end

function M:onClear()
	self:_clearForNextCheck()

	self._resMgr = false
	self._boardModel = false
	self._unitMgr = false
	self._screenWidth = false
	self._screenHeight = false
	self._kHotAreaWidth = false
	self._kHotAreaDownHeight = false
	self._kHotAreaUpHeight = false
end

function M:_clearForNextCheck()
	self._timeWaiter:clear()

	self._toUnit = false
	self._wpos1 = false
	self._wpos2 = false
	self._screenPos1 = false
	self._screenPos2 = false
	self._curWpos = false
	self._curScreenPos = false
	self._fromUnionIndex = false
	self._toUnionIndex = false
end

function M:tryMoveCameraInHotArea(fromUnionIndex, toUnionIndex)
	self:_clearForNextCheck()

	self._fromUnionIndex = fromUnionIndex
	self._toUnionIndex = toUnionIndex

	local mainCamera = CameraTargetMgr.instance:getMainCameraTarget():getCamera()
	local screenWidth = self._screenWidth
	local screenHeight = self._screenHeight
	local boardMgr = self._boardMgr
	local wpos1 = boardMgr:getCellPosition(fromUnionIndex)
	local screenPos1 = mainCamera:WorldToScreenPoint(wpos1)
	local wpos2 = boardMgr:getCellPosition(toUnionIndex)
	local screenPos2 = mainCamera:WorldToScreenPoint(wpos2)

	self._wpos1 = wpos1
	self._wpos2 = wpos2
	self._screenPos1 = screenPos1
	self._screenPos2 = screenPos2
	self._curWpos = VirtualCameraMgr.instance:getFollowPosition()
	self._curScreenPos = mainCamera:WorldToScreenPoint(self._curWpos)

	local isP1InHotArea = screenPos1.x >= self._kHotAreaWidth and screenPos1.x <= screenWidth - self._kHotAreaWidth and screenPos1.y >= self._kHotAreaDownHeight and screenPos1.y <= screenHeight - self._kHotAreaUpHeight
	local isP2InHotArea = screenPos2.x >= self._kHotAreaWidth and screenPos2.x <= screenWidth - self._kHotAreaWidth and screenPos2.y >= self._kHotAreaDownHeight and screenPos2.y <= screenHeight - self._kHotAreaUpHeight
	local canBothInHotArea = math.abs(screenPos1.x - screenPos2.x) <= screenWidth - 2 * self._kHotAreaWidth and math.abs(screenPos1.y - screenPos2.y) <= screenHeight - (self._kHotAreaDownHeight + self._kHotAreaUpHeight)

	if self._toUnit and canBothInHotArea then
		self:_handleAsFocusCenter()
	elseif isP1InHotArea and isP2InHotArea then
		self:finish(true)

		return
	elseif not isP2InHotArea then
		self:_handleTargetOutside()
	elseif canBothInHotArea then
		self:_handleAsFocusCenter()
	else
		self:_handleStartOutSide()
	end
end

function M:_handleAsFocusCenter()
	local boardMgr = self._boardMgr
	local x1, y1, z1 = boardMgr:getCellPosition(self._fromUnionIndex):Get()
	local weightA = 4
	local weightB = 4

	weightB = self._toUnit and self._toUnit.property:getMonsterType() == BattleEnum.MonsterType.BOSS and self._toUnit.transform:isComposite() and 6 or 4

	local x2, y2, z2

	if self._toUnit then
		x2, y2, z2 = BattleUnitUtil.getBattleFocusPos(self._toUnit):Get()
	else
		x2, y2, z2 = boardMgr:getCellPosition(self._toUnionIndex):Get()
	end

	local tox, toy, toz = (x1 * weightA + x2 * weightB) / (weightA + weightB), y1, (z1 * weightA + z2 * weightB) / (weightA + weightB)
	local cameraFocusDuration = BattleConst.judgeCameraFocusTime(tox, toy, toz)

	self:doFollowPosition(tox, toy, toz, cameraFocusDuration)
end

function M:_doFollow(dx, dz)
	self:doFollowPosition(self._curWpos.x + dx, self._curWpos.y, self._curWpos.z + dz, 0.4)
end

function M:_handleTargetOutside()
	local nodex, nodey = self:_getNodeOnRectAndLine(self._curScreenPos, self._screenPos2)

	if not nodex or not nodey then
		return
	end

	local nodeWx, nodeWz = self:_getWorldPosOnCheckerBoard(nodex, nodey)

	if not nodeWx or not nodeWz then
		if enableWarnLog then
			printWarn(string.format("M::cannot raycast go,from:%s,to:%s", self._fromUnionIndex, self._toUnionIndex))
		end

		return
	end

	local dx = self._wpos2.x - nodeWx
	local dz = self._wpos2.z - nodeWz

	self:_doFollow(dx, dz)
end

function M:_handleStartOutSide()
	local nodex, nodey = self:_getNodeOnRectAndLine(self._curScreenPos, self._screenPos1)
	local targetX = self._screenPos2.x + (nodex - self._screenPos1.x)
	local targetY = self._screenPos2.y + (nodey - self._screenPos1.y)

	nodex, nodey = self:_moveNodeOnLineToHotArea(nodex, nodey)
	kP1Vector.x = nodex
	kP1Vector.y = nodey
	kP2Vector.x = targetX
	kP2Vector.y = targetY
	targetX, targetY = self:_getNodeOnRectAndLine(kP1Vector, kP2Vector)

	local nodeWx, nodeWz = self:_getWorldPosOnCheckerBoard(targetX, targetY)

	if not nodeWx or nodeWz then
		if enableWarnLog then
			printWarn(string.format("M::cannot raycast go,from:%s,to:%s", self._fromUnionIndex, self._toUnionIndex))
		end

		return
	end

	local dx = self._wpos2.x - nodeWx
	local dz = self._wpos2.z - nodeWz

	self:_doFollow(dx, dz)
end

function M:_moveNodeOnLineToHotArea(nodex, nodey)
	local screenWidth = self._screenWidth
	local screenHeight = self._screenHeight
	local rectx1, rectx2 = self._kHotAreaWidth, screenWidth - self._kHotAreaWidth
	local recty1, recty2 = self._kHotAreaDownHeight, screenHeight - self._kHotAreaUpHeight

	if nodex == rectx1 then
		nodex = nodex + 0.01
	end

	if nodex == rectx2 then
		nodex = nodex - 0.01
	end

	if nodey == recty1 then
		nodey = nodey + 0.01
	end

	if nodey == recty2 then
		nodey = nodey - 0.01
	end

	return nodex, nodey
end

function M:_isNodeInRect(x, y)
	local screenWidth = self._screenWidth
	local screenHeight = self._screenHeight
	local rectx1, rectx2 = self._kHotAreaWidth, screenWidth - self._kHotAreaWidth
	local recty1, recty2 = self._kHotAreaDownHeight, screenHeight - self._kHotAreaUpHeight

	if x < rectx1 or rectx2 < x or y < recty1 or recty2 < y then
		return false
	end

	return true
end

function M:_getNodeOnRectAndLine(screenPos1, screenPos2)
	local screenWidth = self._screenWidth
	local screenHeight = self._screenHeight
	local rectx1, rectx2 = self._kHotAreaWidth, screenWidth - self._kHotAreaWidth
	local recty1, recty2 = self._kHotAreaDownHeight, screenHeight - self._kHotAreaUpHeight
	local funcA, funcK, funcB = 1, 1, 0

	if screenPos1.x == screenPos2.x then
		funcA = 0
		funcK = 1
		funcB = -screenPos1.x
	else
		funcK = (screenPos2.y - screenPos1.y) / (screenPos2.x - screenPos1.x)
		funcB = screenPos1.y - screenPos1.x * (screenPos2.y - screenPos1.y) / (screenPos2.x - screenPos1.x)
	end

	local nodex, nodey

	if funcA == 0 then
		nodex = screenPos2.x

		if recty1 > screenPos2.y then
			nodey = recty1
		else
			nodey = recty2
		end

		return nodex, nodey
	end

	nodex = rectx1
	nodey = funcK * nodex + funcB

	if recty1 <= nodey and nodey <= recty2 and (nodex - screenPos1.x) * (nodex - screenPos2.x) <= 0 then
		return nodex, nodey
	end

	nodex = rectx2
	nodey = funcK * nodex + funcB

	if recty1 <= nodey and nodey <= recty2 and (nodex - screenPos1.x) * (nodex - screenPos2.x) <= 0 then
		return nodex, nodey
	end

	nodey = recty1
	nodex = (nodey - funcB) / funcK

	if rectx1 <= nodex and nodex <= rectx2 and (nodex - screenPos1.x) * (nodex - screenPos2.x) <= 0 then
		return nodex, nodey
	end

	nodey = recty2
	nodex = (nodey - funcB) / funcK

	if rectx1 <= nodex and nodex <= rectx2 and (nodex - screenPos1.x) * (nodex - screenPos2.x) <= 0 then
		return nodex, nodey
	end
end

function M:_getWorldPosOnCheckerBoard(screenX, screenY)
	local mainCamera = CameraTargetMgr.instance:getMainCameraTarget():getCamera()
	local sceneType = SceneMgr.instance:getCurSceneType()
	local layerMask = Astral.LayerUtil.GetLayerMask(unpack(SceneEnum.TypeToPickerLayers[sceneType]))

	kRaycastPosList = RaycastUtils.GetHitWorldPointByScreenPoint(mainCamera, screenX, screenY, layerMask, kRaycastPosList)

	local boardMgr = self._boardMgr
	local count = math.min(ScenePickerViewFacade.instance:getHitCount(), 2)

	for i = 1, #kRaycastPosList do
		local x, y, z = kRaycastPosList[i].x, kRaycastPosList[i].y, kRaycastPosList[i].z
		local isHitTopFace = math.abs(boardMgr:calculateWorldYOffset(x, z) - y) <= 0.02

		if isHitTopFace then
			BattleTableUtil.clearTable(kRaycastPosList)

			return x, z
		end
	end

	if #kRaycastPosList >= 1 then
		local x, y, z = kRaycastPosList[1].x, kRaycastPosList[1].y, kRaycastPosList[1].z

		BattleTableUtil.clearTable(kRaycastPosList)

		return x, z
	end
end

function M:_getNeareastNodeOffsetOnRect(nodex, nodey)
	local screenWidth = self._screenWidth
	local screenHeight = self._screenHeight
	local rectx1, rectx2 = self._kHotAreaWidth, screenWidth - self._kHotAreaWidth
	local recty1, recty2 = self._kHotAreaDownHeight, screenHeight - self._kHotAreaUpHeight
	local dx, dy = 0, 0

	if nodex < rectx1 then
		dx = rectx1 - nodex
	elseif rectx2 < nodex then
		dx = rectx2 - nodex
	end

	if nodey < recty1 then
		dy = recty1 - nodey
	elseif recty2 < nodey then
		dy = recty2 - nodey
	end

	return dx, dy
end

function M:finish()
	return
end

function M:doFollowPosition(x, y, z, duration)
	local tween = VirtualCameraMgr.instance:doFollowPosition(x, y, z, duration)

	return tween
end

return M
