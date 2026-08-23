local AncientsSoulEchoKnightComp = class("AncientsSoulEchoKnightComp", require("app.fairyGUI.ancients.UI_AncientsSoulEchoKnightComp"))

function var_0_0:ctor()
	self.m_Btn_change:addClickListener(handler(self, self._onClickBtnChange))

	self._knightUnitsMap = {}
end

function var_0_0:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_GETOTHER, handler(self, self._onRcvGetUserBattleTeam), self)
end

function var_0_0:_onRcvGetUserBattleTeam(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if arg_3_4.target_id == self._echoUserId then
		self._knightUnitsMap[self._echoUserId] = arg_3_4.knights

		if g.core.model.User.ancientsData:shouldFixAdvIdByUnits(self._knightUnitsMap[self._echoUserId] or {}, self._knightPos) then
			self._knightPos = 0
		end

		self:_refreshView()
	end
end

function var_0_0:updateView(arg_4_1, arg_4_2)
	if not g.core.model.User.ancientsData:isEchoUnlock(arg_4_2) then
		self.m_statusController:setSelectedIndex(4)

		local var_4_0 = g.core.model.User.ancientsData:getPetBaseId()

		self.m_lockTxt:setText(g.core.lang:get(433395, {
			level = g.core.config.ancients_pet_level_info.match(function(arg_5_0)
				if arg_5_0.pet_id == var_4_0 and arg_5_0.echo_num == arg_4_2 then
					return arg_5_0
				end
			end)[1].level
		}))

		return
	end

	if not arg_4_1 then
		return
	end

	self._pos = arg_4_2
	self._echoUserId = arg_4_1.main_user_id or 0
	self._knightPos = arg_4_1.main_knight or 0

	self:_refreshView()
end

function var_0_0:_refreshView()
	if self._echoUserId == 0 then
		self.m_statusController:setSelectedIndex(1)
	elseif self._echoUserId == g.core.model.User:getId() then
		if self._knightPos == 0 then
			self.m_statusController:setSelectedIndex(2)
		else
			self.m_statusController:setSelectedIndex(0)
		end

		if self._knightUnitsMap[self._echoUserId] then
			self:_updateKnightInfo()
		else
			g.core.network.GameNetProxy:send_C2S_Formation_GetOther({
				target_id = self._echoUserId,
				tp = g.core.const.ConstMgr.LineUpConst.MulTeamType.ANCIENTS
			})
		end
	elseif self._knightPos == 0 then
		self.m_statusController:setSelectedIndex(1)
	else
		self.m_statusController:setSelectedIndex(3)

		if self._knightUnitsMap[self._echoUserId] then
			self:_updateKnightInfo()
		else
			g.core.network.GameNetProxy:send_C2S_Formation_GetOther({
				target_id = self._echoUserId,
				tp = g.core.const.ConstMgr.LineUpConst.MulTeamType.ANCIENTS
			})
		end
	end
end

function var_0_0:_updateKnightInfo()
	local var_7_1

	for iter_7_0, iter_7_1 in ipairs(self._knightUnitsMap[self._echoUserId] or {}) do
		if g.core.model.User.ancientsData:getAdvIdByUnit(iter_7_1) == self._knightPos then
			var_7_1 = iter_7_1

			break
		end
	end

	if not var_7_1 then
		return
	end

	local var_7_2 = var_7_1.base_id
	local var_7_3 = g.core.config.knight_info.get(var_7_1.base_id)

	if self._resId ~= var_7_3.res_id then
		self.m_Comp_knight:updateIcon({
			type = g.core.common.Goods.TYPE_KNIGHT,
			value = var_7_2
		})
	end

	self._resId = var_7_3.res_id

	self.m_Comp_star:initStar({
		index = 3,
		style = 2,
		gap = -5,
		num = var_7_3.star
	})
	g.core.model.User.ancientsData:setEchoQualityByIndex(self._pos, var_7_3.quality)
	self.m_Comp_name:setText(var_7_3.name)

	self._unit = var_7_1
end

function var_0_0:_onClickBtnChange()
	g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_SELECT_KNIGHT_POP, {
		pos = self._pos,
		units = self._knightUnitsMap[self._echoUserId],
		knightPos = self._knightPos
	})
end

return var_0_0
