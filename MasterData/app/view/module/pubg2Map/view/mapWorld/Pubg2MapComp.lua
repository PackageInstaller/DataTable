local var_0_0 = g.core.const.ConstMgr.PubgConst
local var_0_1 = g.core.const.ConstMgr.PubgConst.fsm
local var_0_2 = g.core.model.User.pubgData
local var_0_3
local Pubg2MapWorld = require("app.view.module.pubg2Map.view.mapWorld.Pubg2MapWorld")
local Pubg2MapComp = class("Pubg2MapComp", require("app.fairyGUI.pubg.UI_Pubg2MapComp"))

function Pubg2MapComp:ctor()
	var_0_3 = var_0_2:getMapData()
	self._stage = nil
end

function Pubg2MapComp:setStage(arg_2_1)
	self._stage = arg_2_1

	self:_initTiledMap()

	local var_2_0 = self:getMapWorld()
	local var_2_1 = var_2_0:getMapGround()

	self.m_floorComp:loadConfig(1, var_2_1:getMapWidth(), (self:getMapWorld().getMapGround(var_2_1).getMapHeight(var_2_0)))

	local var_2_2 = self:getFloorComp()
	local var_2_3 = var_2_2:getMyCompPos()

	self:getMapWorld().setFollowCenter(var_2_2, cc.p(var_2_3.x, -var_2_3.y))
end

function Pubg2MapComp:_initTiledMap()
	self._mapWorld = Pubg2MapWorld.new(self, 1)

	self._mapWorld:startObserver(self.m_touchMap)
	self.m_tiledHolder:addNode(self._mapWorld)
end

function Pubg2MapComp:getMapWorld()
	return self._mapWorld
end

function Pubg2MapComp:moveToPoint(arg_5_1, arg_5_2)
	self._mapWorld:movePA2SC({
		x = arg_5_1,
		y = arg_5_2
	})
	self:onMapMoveEnd()
end

function Pubg2MapComp:getScreenCenterPoint()
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

function Pubg2MapComp:onMapMoveEnd()
	return
end

function Pubg2MapComp:updatePlayerIcon()
	local var_8_0, var_8_1 = var_0_3:getMyPos()
	local var_8_2, var_8_3 = self:getMapWorld():getMapGround():coordToPixel(var_8_0, var_8_1)

	return self._stage:updatePlayerIcon(self:getMapWorld():convertToNodeSpace({
		x = display.cx,
		y = display.cy
	}), {
		x = var_8_2,
		y = var_8_3
	})
end

function Pubg2MapComp:updateFloorCompPos(arg_9_1, arg_9_2)
	self.m_floorComp:setPosition(arg_9_1 + display.cx, arg_9_2 + display.cy)
	self.m_floorComp:updateCurPos(-arg_9_1, -arg_9_2)
end

function Pubg2MapComp:getFloorComp()
	return self.m_floorComp
end

function Pubg2MapComp:userMove()
	if not var_0_3:checkInMapTime() then
		return
	end

	local var_11_0 = var_0_3:getMyUser()

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

function Pubg2MapComp:checkGetBuff()
	local var_12_0 = var_0_3:getMyUser()
	local var_12_1 = var_12_0:getTargetOnlyId()
	local var_12_2 = var_0_3:getItemByOid(var_12_1)

	if var_12_2 and var_12_2:getType() == var_0_0.map.itemType.buff then
		local var_12_3, var_12_4 = var_12_2:getPos()
		local var_12_5 = var_12_0:getMovingPos()

		if (var_12_3 - var_12_5.x) * (var_12_3 - var_12_5.x) + (var_12_4 - var_12_5.y) * (var_12_4 - var_12_5.y) <= 2 then
			self:newScheduleOnce(function()
				local var_13_0 = var_12_2:getUid()

				if not var_0_3:getBuffById(var_13_0) or var_0_3:isSendGet(var_12_1) then
					return
				end

				g.core.network.GameNetProxy:send_C2S_Pubg_PickBuff({
					id = var_13_0
				})
				var_0_3:addSendGet(var_12_1)
				var_12_0:setTargetOnlyId("")
			end, var_12_0:getMovingActionTime() + 0.1)
		end
	end
end

function Pubg2MapComp:refreshAttackUsers(arg_14_1)
	self.m_hasAttackUsersController:setSelectedIndex(#arg_14_1 > 0 and 1 or 0)
	self.m_floorComp:updateCanAttackUsersComp((self.m_usersComp:updateUsersComp(arg_14_1)))
end

function Pubg2MapComp:refreshInvincibleUsers(arg_15_1)
	self.m_floorComp:refreshInvincibleUsers(arg_15_1)
end

function Pubg2MapComp:refreshAddExp(arg_16_1)
	self.m_floorComp:refreshAddExp(arg_16_1)
end

function Pubg2MapComp:refreshAttackUserComp()
	self.m_usersComp:refreshUsersComp()
end

function Pubg2MapComp:removeBuffFightValue()
	self._stage:updateRankComp()
end

function Pubg2MapComp:tickMapUpdate(arg_19_1)
	if self._stage then
		self:getFloorComp():tickUpdate()

		if arg_19_1 then
			local var_19_0 = self:getFloorComp()
			local var_19_1 = var_19_0:getMyCompPos()

			self:getMapWorld().setFollowCenter(var_19_0, cc.p(var_19_1.x, -var_19_1.y))
		end

		self:getMapWorld():tickUpdate(var_0_1.Time.deltaT * 0.001)
	end

	self.m_worldPos:setText(string.format("WorldPos: %.2f, %.2f", self:getMapWorld():getPosition()))
end

return Pubg2MapComp
