-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/work/display/WorkMoveRoleToTarget.lua

module("logic.extensions.roguelike.flow.work.display.WorkMoveRoleToTarget", package.seeall)

local M = class("WorkMoveRoleToTarget", WorkBase)

function M:onEnter(context)
	local mapMgr = RogueMgr.instance:getMapMgr()

	if not context.isActive then
		local coordinate = context.mapItem:getCoordinate()
		local roomMos = RoguelikeModel.instance:getCurMapRoomMOs()
		local mapRole = mapMgr:getMapRole()
		local curPos = mapRole.go.transform.position
		local srcMo, index1 = RoguelikeModel.instance:getMoByCoordinate(coordinate[1], coordinate[2], roomMos)
		local srcMapItem = context.isSecondMap and mapMgr:getUnit2(index1) or mapMgr:getUnit(index1)
		local srcPos = srcMapItem.go.transform.position

		mapRole.transform:setActive(false)
		context.mapItem:getMapRole().transform:setActive(false)

		local targetMo, index = RoguelikeModel.instance:getMoByCoordinate(coordinate[1] - 1, coordinate[2], roomMos)

		if targetMo ~= nil then
			local targetMapItem = context.isSecondMap and mapMgr:getUnit2(index) or mapMgr:getUnit(index)

			mapRole.go.transform:DOMove(targetMapItem.go.transform.position, 0.3):OnComplete(function()
				mapRole.transform:SetEulerAngles(0, 0, 0)
				settimer(0.02, function()
					context.mapItem:getMapRole().meshModel:setDirection(UnitSpineDir.Right)
					mapRole.meshModel:setDirection(UnitSpineDir.Right)
				end, self, false)
				settimer(0.05, function()
					context.mapItem:getMapRole().transform:setActive(true)
					mapRole.transform:setActive(true)
					self:onDone(WorkResult.Succeed)
				end, self, false)
			end, self)
		else
			local originCoordinate = RoguelikeTempParam.ROOM_START_COORDINATE
			local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE
			local pos = Vector3.New((coordinate[1] - 1 - originCoordinate[1]) * kMapItemSize, 0, (coordinate[2] - originCoordinate[2]) * -kMapItemSize)
			local block = mapMgr:createEmptyBlock(pos)

			mapRole.transform:doMove(pos, 0.3):OnComplete(function()
				mapRole.transform:SetEulerAngles(0, 0, 0)
				settimer(0.02, function()
					context.mapItem:getMapRole().meshModel:setDirection(UnitSpineDir.Right)
					mapRole.meshModel:setDirection(UnitSpineDir.Right)
				end, self, false)
				settimer(0.05, function()
					context.mapItem:getMapRole().transform:setActive(true)
					mapRole.transform:setActive(true)
					self:onDone(WorkResult.Succeed)
				end, self, false)
			end, self)
		end
	else
		local coordinate = context.mapItem:getCoordinate()
		local originCoordinate = RoguelikeTempParam.ROOM_START_COORDINATE
		local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE
		local pos = Vector3.New((coordinate[1] - originCoordinate[1]) * kMapItemSize, 0, (coordinate[2] - originCoordinate[2]) * -kMapItemSize)
		local mapRole = mapMgr:getMapRole()

		mapRole.meshModel:play(RoguelikeConst.ROGUE_ROLE_ANI.IDLE, true)
		mapRole.transform:doMove(pos, 0.5):OnComplete(function()
			mapMgr:destroyEmptyBlock()
			self:onDone(WorkResult.Succeed)
		end)
	end
end

function M:onExit(isInterrupt)
	return
end

return M
