local KnightSpProtectKnightIcon = class("KnightSpProtectKnightIcon", require("app.fairyGUI.knight.UI_KnightSpProtectKnightIcon"))

function KnightSpProtectKnightIcon:ctor()
	self._isCanActive = false
	self._knightStruct = nil
	self._ownerKnight = nil
	self._activeState = false
	self._isFirst = true

	self:addClickListener(handler(self, self._onKnightActiveClick))
	self.m_knightIcon:setShowInfoEnable(true)
end

function KnightSpProtectKnightIcon:updateIcon(arg_2_1, arg_2_2)
	self._isCanActive = false

	local var_2_0 = g.core.model.User.knightsData:getKnight({
		advance_id = arg_2_1[1].knightAdvId
	})

	self._knightStruct = var_2_0

	self.m_knightIcon:updateIcon({
		overrideClick = true,
		struct = var_2_0,
		star = var_2_0:getStar()
	})
	self.m_knightIcon:setTouchFunc(handler(self, self._onKnightActiveClick))

	self._ownerKnight = arg_2_2

	local var_2_1 = arg_2_2:isSpSupportActive(arg_2_1[1].knightAdvId)

	self.m_eff:removeAllEffect()

	if not self._isFirst and not self._activeState and var_2_1 then
		self.m_eff:addEffectSpine({
			anim = "activate",
			name = "eff_ui_knight_iconactivate",
			remove = true,
			isLoop = false
		})
	end

	self._activeState = var_2_1
	self._isFirst = false

	self.m_stateController:setSelectedIndex(var_2_1 and 1 or 0)

	if not var_2_1 and var_2_0:isOwn() then
		self._isCanActive = true

		self.m_eff:addEffectSpine({
			anim = "loop",
			name = "eff_ui_knight_iconactivate",
			isLoop = true
		})
	end
end

function KnightSpProtectKnightIcon:_onKnightActiveClick()
	if self._isCanActive then
		g.core.network.GameNetProxy:send_C2S_Knight_MR_SupportActive({
			knight_id = self._ownerKnight:getServerId(),
			target_id = self._knightStruct:getServerId()
		})
	else
		g.core.common.GlobalFunc.pushInfoPop({
			type = g.core.common.Goods.TYPE_KNIGHT,
			value = self._knightStruct:getBaseId()
		})
	end
end

return KnightSpProtectKnightIcon
