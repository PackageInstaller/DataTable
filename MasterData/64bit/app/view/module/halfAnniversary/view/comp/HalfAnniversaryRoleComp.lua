local CommonKnight = require("app.view.common.CommonKnight")
local var_0_1 = g.core.const.ConstMgr.SpineConst
local var_0_2 = g.core.model.User.halfAnniversaryData
local HalfAnniversaryRoleComp = class("HalfAnniversaryRoleComp", require("app.fairyGUI.halfAnniversary.UI_HalfAnniversaryRoleComp"))

function HalfAnniversaryRoleComp:ctor()
	self._knight = nil

	self:_initRoleAvatar()
end

function HalfAnniversaryRoleComp:_initRoleAvatar()
	self._knight = CommonKnight.new({
		scale = 0.8,
		resId = var_0_2:getHalfYearActivityCfg().spine_id
	})

	self.m_knightComp:addChild(self._knight)
end

function HalfAnniversaryRoleComp:playAction(arg_3_1)
	self._knight:playAction(arg_3_1)
end

function HalfAnniversaryRoleComp:playGetAwardEffect(arg_4_1)
	self:playAction(var_0_1.ACTION.SHOW)
	self:newScheduleOnce(handler(self, function()
		self.m_effGet:removeAllEffect()
		self.m_effGet:addEffectSpine({
			name = "eff_ui_halfAnniversary_get",
			isLoop = false,
			remove = true,
			eventHandler = handler(self, function()
				if arg_4_1 then
					arg_4_1()
				end
			end)
		})
	end), 0.5)
end

function HalfAnniversaryRoleComp:playAwardPosEffect()
	self.m_effUp:removeAllEffect()
	self.m_effUp:addEffectSpine({
		name = "eff_ui_halfAnniversary_getup",
		isLoop = true
	})
	self.m_effDown:removeAllEffect()
	self.m_effDown:addEffectSpine({
		name = "eff_ui_halfAnniversary_getdown",
		isLoop = true
	})
end

function HalfAnniversaryRoleComp:removeAllEffect()
	self.m_effUp:removeAllEffect()
	self.m_effDown:removeAllEffect()
	self.m_effGet:removeAllEffect()
end

return HalfAnniversaryRoleComp
