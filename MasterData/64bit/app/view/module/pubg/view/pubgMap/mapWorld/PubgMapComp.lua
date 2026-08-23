local var_0_0 = g.core.const.ConstMgr.PubgConst
local var_0_1 = g.core.model.User.pubgData
local var_0_2
local PubgMapWorld = require("app.view.module.pubg.view.pubgMap.mapWorld.PubgMapWorld")
local PubgMapComp = class("PubgMapComp", require("app.fairyGUI.pubg.UI_PubgMapComp"))

function PubgMapComp:ctor()
	var_0_2 = var_0_1:getMapData()
	self._stage = nil
end

function PubgMapComp:setStage(arg_2_1)
	self._stage = arg_2_1

	self:_initTiledMap()
	self.m_floorComp:loadConfig(var_0_2:getMapId())
end

function PubgMapComp:_initTiledMap()
	self._mapWorld = PubgMapWorld.new(self, var_0_2:getMapId())

	self._mapWorld:startObserver(self.m_touchMap)
	self.m_tiledHolder:addNode(self._mapWorld)
end

function PubgMapComp:getMapWorld()
	return self._mapWorld
end

function PubgMapComp:moveToPoint(arg_5_1, arg_5_2)
	self._mapWorld:moveCell2SC({
		x = arg_5_1,
		y = arg_5_2
	})
	self:onMapMoveEnd()
end

function PubgMapComp:getScreenCenterPoint()
	local var_6_0 = self:getMapWorld():convertToNodeSpace({
		x = display.cx,
		y = display.cy
	})
	local var_6_1, var_6_2 = self:getMapWorld():getMapGround():pixelToCoord(var_6_0.x, var_6_0.y)

	return {
		x = var_6_1,
		y = var_6_2
	}
end

function PubgMapComp:onMapMoveEnd()
	return
end

function PubgMapComp:updatePlayerIcon()
	local var_8_0, var_8_1 = var_0_2:getMyPos()
	local var_8_2, var_8_3 = self:getMapWorld():getMapGround():coordToPixel(var_8_0, var_8_1)

	return self._stage:updatePlayerIcon(self:getMapWorld():convertToNodeSpace({
		x = display.cx,
		y = display.cy
	}), {
		x = var_8_2,
		y = var_8_3
	})
end

function PubgMapComp:updateFloorCompPos(arg_9_1, arg_9_2)
	self.m_floorComp:setPosition(arg_9_1, arg_9_2)
	self.m_floorComp:updateCurPos(arg_9_1, arg_9_2)
end

function PubgMapComp:getFloorComp()
	return self.m_floorComp
end

function PubgMapComp:userMove()
	if not var_0_2:checkInMapTime() then
		return
	end

	local var_11_0 = var_0_2:getMyUser()

	if var_11_0 then
		local var_11_1 = var_11_0:getMovingPos()

		if var_11_1 and not var_11_0:isDead() then
			g.core.network.GameNetProxy:send_C2S_Pubg_Move({
				x = var_11_1.x,
				y = var_11_1.y
			})
		end
	end
end

function PubgMapComp:checkGetBuff()
	local var_12_0 = var_0_2:getMyUser()
	local var_12_1 = var_12_0:getTargetOnlyId()
	local var_12_2 = var_0_2:getItemByOid(var_12_1)

	if var_12_2 and var_12_2:getType() == var_0_0.map.itemType.buff then
		local var_12_3, var_12_4 = var_12_2:getPos()
		local var_12_5 = var_12_0:getMovingPos()

		if (var_12_3 - var_12_5.x) * (var_12_3 - var_12_5.x) + (var_12_4 - var_12_5.y) * (var_12_4 - var_12_5.y) <= 2 then
			self:newScheduleOnce(function()
				local var_13_0 = var_12_2:getUid()

				if not var_0_2:getBuffById(var_13_0) or var_0_2:isSendGet(var_12_1) then
					return
				end

				g.core.network.GameNetProxy:send_C2S_Pubg_PickBuff({
					id = var_13_0
				})
				var_0_2:addSendGet(var_12_1)
				var_12_0:setTargetOnlyId("")
			end, var_12_0:getMovingActionTime() + 0.1)
		end
	elseif var_12_2 and var_12_2:getType() == var_0_0.map.itemType.airDrop then
		local var_12_6, var_12_7 = var_12_2:getPos()
		local var_12_8 = var_12_0:getMovingPos()

		if (var_12_6 - var_12_8.x) * (var_12_6 - var_12_8.x) + (var_12_7 - var_12_8.y) * (var_12_7 - var_12_8.y) <= 2 then
			self:newScheduleOnce(function()
				local var_14_0 = var_12_2:getUid()

				if not var_0_2:getAirDropById(var_14_0) or var_0_2:isSendGet(var_12_1) then
					return
				end

				g.core.network.GameNetProxy:send_C2S_Pubg_PickAirdrop({
					id = var_14_0
				})
				var_0_2:addSendGet(var_12_1)
				var_12_0:setTargetOnlyId("")
			end, var_12_0:getMovingActionTime() + 0.1)
		end
	end
end

function PubgMapComp:refreshAttackUsers(arg_15_1)
	self.m_hasAttackUsersController:setSelectedIndex(#arg_15_1 > 0 and 1 or 0)
	self.m_floorComp:updateCanAttackUsersComp((self.m_usersComp:updateUsersComp(arg_15_1)))
end

function PubgMapComp:refreshInvincibleUsers(arg_16_1)
	self.m_floorComp:refreshInvincibleUsers(arg_16_1)
end

function PubgMapComp:refreshAddExp(arg_17_1)
	self.m_floorComp:refreshAddExp(arg_17_1)
end

function PubgMapComp:refreshAttackUserComp()
	self.m_usersComp:refreshUsersComp()
end

function PubgMapComp:removeBuffFightValue()
	self._stage:updateRankComp()
end

return PubgMapComp
