local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.model.User.pubgData
local PubgMiniMapComp = class("PubgMiniMapComp", require("app.fairyGUI.pubg.UI_PubgMiniMapComp"))

function PubgMiniMapComp:ctor()
	self._curPos = {
		y = 0,
		x = 0
	}
	self._moveTime = 0.5
	self._moveSpeed = 0
	self._showTime = g.core.model.User.pubgData:getParams(g.core.const.ConstMgr.PubgConst.Params.AIRDROP_MINIMAP_MOVE_TIME)
	self._airDropMoveTimer = nil
	self._tipShowPlay = false
end

function PubgMiniMapComp:updateMapPos(arg_2_1, arg_2_2)
	if not self._airDropMoveTimer then
		self._curPos = {
			x = arg_2_1,
			y = arg_2_2
		}

		self.m_cutComp:updateMapPos(arg_2_1, arg_2_2)
	end
end

function PubgMiniMapComp:updateKillNum(arg_3_1)
	self.m_killValueTxt:setText(arg_3_1)
end

function PubgMiniMapComp:updateDeadNum(arg_4_1)
	self.m_deadValueTxt:setText(arg_4_1)
end

function PubgMiniMapComp:updateEventTime(arg_5_1)
	if arg_5_1 > 0 then
		self.m_refreshTxt:setText(g.core.lang:get(430936, {
			num = arg_5_1
		}))
	else
		self.m_refreshTxt:setText("")
	end
end

function PubgMiniMapComp:updateStartInvincibleTime(arg_6_1)
	if arg_6_1 > 0 then
		self.m_startInvincibleTime:setText(g.core.lang:get(430940, {
			num = arg_6_1
		}))
		self.m_hasStartInvincibleController:setSelectedIndex(1)
	else
		self.m_hasStartInvincibleController:setSelectedIndex(0)
	end
end

function PubgMiniMapComp:updateAirDropTip(arg_7_1)
	if arg_7_1 then
		self.m_hasAirDropController:setSelectedIndex(1)

		self._lightEff = self._lightEff or self.m_effLight:addEffectSpine({
			anim = "play",
			remove = false,
			scale = 1,
			name = "eff_ui_pubg_airdroptxtlight",
			isLoop = true
		})
	elseif self._lightEff then
		self.m_txtHideTransition:play(handler(self, self._tipHideTranEnd))
		self.m_effLight:removeAllEffect()

		self._lightEff = nil
	end
end

function PubgMiniMapComp:_tipHideTranEnd()
	self.m_hasAirDropController:setSelectedIndex(0)
end

function PubgMiniMapComp:playAirDropShow(arg_9_1)
	self._finalPos = {
		x = arg_9_1.airdrop.x,
		y = arg_9_1.airdrop.y
	}
	self._curMoveStartTime = var_0_0:getTime() + self._moveTime
	self._moveSpeed = math.sqrt((self._finalPos.x - self._curPos.x)^2 + (self._finalPos.y - self._curPos.y)^2) / self._moveTime
	self._airDropMoveTimer = self._airDropMoveTimer or self:newSchedule(handler(self, self._moveAirDropPos), 0.05)

	self.m_txtShowTransition:play()

	self._isShowInAirDropItem = false
end

function PubgMiniMapComp:_moveAirDropPos(arg_10_1)
	if self._curMoveStartTime + self._showTime < var_0_0:getTime() then
		if self._airDropMoveTimer then
			self:cancelSchedule(self._airDropMoveTimer)

			self._airDropMoveTimer = nil

			local var_10_0, var_10_1 = var_0_1:getMapData():getMyPos()

			self._curPos = {
				x = var_10_0,
				y = var_10_1
			}

			self.m_cutComp:updateMapPos(self._curPos.x, self._curPos.y)
		end

		return
	end

	local var_10_2 = self._finalPos.x - self._curPos.x
	local var_10_3 = math.sqrt((self._finalPos.x - self._curPos.x)^2 + (self._finalPos.y - self._curPos.y)^2)

	if var_10_3 <= 0.5 then
		self._curPos = {
			x = self._finalPos.x,
			y = self._finalPos.y
		}

		if not self._isShowInAirDropItem then
			self._isShowInAirDropItem = true

			self.m_cutComp:showInAirDropItem(self._finalPos.x, self._finalPos.y)
		end

		return
	end

	self._curPos.x = self._curPos.x + var_10_2 / var_10_3 * self._moveSpeed * 0.05
	self._curPos.y = self._curPos.y + (self._finalPos.y - self._curPos.y) / var_10_3 * self._moveSpeed * 0.05

	self.m_cutComp:updateMapPos(self._curPos.x, self._curPos.y, true)
end

return PubgMiniMapComp
