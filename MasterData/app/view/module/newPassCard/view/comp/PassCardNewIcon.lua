local var_0_0 = g.core.model.User.gmPassCardData
local PassCardNewIcon = class("PassCardNewIcon", require("app.fairyGUI.newPassCard.UI_PassCardNewIcon"))

function PassCardNewIcon:ctor()
	self:addClickListener(handler(self, self._onClick))
end

function PassCardNewIcon:updateIcon(arg_2_1)
	self._param = arg_2_1

	self.m_iconComp:updateIcon(arg_2_1)
end

function PassCardNewIcon:updateState(arg_3_1, arg_3_2)
	self._cfg = arg_3_1 or self._cfg
	self._canReward = false
	self._type = arg_3_2 and 2 or 1

	if self._cfg then
		self.m_redPointComp:setShow(false)

		if arg_3_2 and not var_0_0:isRecharge() then
			self.m_stateController:setSelectedIndex(0)
		elseif var_0_0:getPassCardLv() >= arg_3_1.level then
			local var_3_0 = var_0_0:isGetLvReward(arg_3_1.level, not arg_3_2)

			self.m_stateController:setSelectedIndex(var_3_0 and 3 or 2)

			if not var_3_0 then
				self.m_redPointComp:setShow(true)
			end

			self._canReward = not var_3_0
		else
			self.m_stateController:setSelectedIndex(1)
		end
	end
end

function PassCardNewIcon:_onClick()
	if self._cfg and self._canReward then
		g.core.network.GameNetProxy:send_C2S_PasscardActivity_LevelAward({
			lv = self._cfg.level,
			type = self._type
		})
	elseif self._param then
		g.core.common.GlobalFunc.pushInfoPop(self._param)
	end
end

return PassCardNewIcon
