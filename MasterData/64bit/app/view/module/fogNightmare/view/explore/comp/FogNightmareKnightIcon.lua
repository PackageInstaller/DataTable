local var_0_0 = g.core.const.ConstMgr.FogNightmareConst
local FogNightmareKnightIcon = class("FogNightmareKnightIcon", require("app.fairyGUI.fogNightmare.UI_FogNightmareKnightIcon"))

function FogNightmareKnightIcon:ctor()
	self._knightStruct = nil
	self._spine = self.m_effIcon:addEffectSpine({
		name = "eff_ui_FogNightmare_icon",
		isLoop = false
	})

	self:addClickListener(handler(self, self._onClick))
end

function FogNightmareKnightIcon:_onClick()
	if self._knightStruct then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.explore.pop.FogNightmareKnightKeepsakeInfoPop").new(self._knightStruct), {
			ignoreTouch = false,
			touchDisappear = true,
			hideContinue = false
		})
	end
end

function FogNightmareKnightIcon:updateCell(arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3 then
		self:cancelAllSchedule()
		self:newScheduleOnce(handler(self, self._playAnim), arg_3_2 * 0.03)
	end

	self._knightStruct = arg_3_1

	self.m_knightComp:updateIcon({
		changeControllers = true,
		struct = arg_3_1
	})
	self.m_knightComp:hideAdvanceShow()

	local var_3_0 = self._knightStruct:getDevelopStruct(var_0_0.KNIGHT_DEVELOP_KEY.KEEPSAKE)

	if var_3_0 then
		self.m_sealLoader:setURL(g.core.common.Path:getFogNightmareKeepsakePicRes(var_3_0:getBaseInfo().seal_icon))
		self.m_sealIcon:setVisible(true)
	else
		self.m_sealIcon:setVisible(false)
	end
end

function FogNightmareKnightIcon:_playAnim()
	self.m_keepsakeEnterTransition:play()

	if self._spine and not tolua.isnull(self._spine) then
		self._spine:setAnimation(0, "play", false)
	end
end

return FogNightmareKnightIcon
