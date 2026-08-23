local var_0_0 = g.core.const.ConstMgr.KNIGHT_CONST
local FormationPartnerIcon = class("FormationPartnerIcon", require("app.fairyGUI.formation.UI_FormationPartnerIcon"))

function FormationPartnerIcon:ctor()
	self._unLock = true
	self._partnerPos = 0
	self._formationPos = 0
	self._knightId = 0
	self._knight = {}
	self._unLockText = nil
	self._canClick = true

	self:addClickListener(handler(self, self._onClick))
end

function FormationPartnerIcon:setPartnerPos(arg_2_1)
	self._partnerPos = arg_2_1
	self._formationPos = var_0_0.LINEUP_MAX + arg_2_1
end

function FormationPartnerIcon:getPartnerPos()
	return self._partnerPos
end

function FormationPartnerIcon:updateFormatUnlock(arg_4_1, arg_4_2)
	self._unLock = false

	self.m_stateController:setSelectedIndex(2)

	self._unLockText = g.core.lang:get(202514, {
		level = arg_4_1
	})
	self._unLockDirection = arg_4_2

	self.m_openText:setText(self._unLockText)
end

function FormationPartnerIcon:updatePartnerFormatIcon(arg_5_1)
	if arg_5_1 == 0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				pos = 999
			}
		})
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				pos = self._partnerPos
			}
		})
	end

	self._canClick = true

	if arg_5_1 == 0 then
		self.m_stateController:setSelectedIndex(1)

		return
	end

	self._knightId = arg_5_1

	self.m_stateController:setSelectedIndex(0)
	self.m_knightIcon:updateIcon({
		isNeedShowWedding = true,
		sid = arg_5_1
	})
end

function FormationPartnerIcon:freshRedPoint()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			pos = 666
		}
	})
end

function FormationPartnerIcon:updatePartnerFormatIconByKnightStruct(arg_7_1)
	self._canClick = false

	if arg_7_1 == nil then
		self.m_stateController:setSelectedIndex(3)

		return
	end

	self.m_stateController:setSelectedIndex(0)
	self.m_knightIcon:updateIcon({
		struct = arg_7_1
	})
end

function FormationPartnerIcon:_onClick()
	if not self._canClick then
		-- block empty
	elseif self._unLock then
		g.core.module.ModuleManager:pushModule(g.view.entrance.LINE_UP_CHOOSE, {
			isHelper = true,
			index = self._formationPos,
			knightSid = self._knightId
		})
	elseif not self._unLock and self._unLockDirection then
		g.core.module.ModuleManager:tip(self._unLockDirection)
	end
end

return FormationPartnerIcon
