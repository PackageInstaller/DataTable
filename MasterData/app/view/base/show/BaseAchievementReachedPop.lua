local var_0_0 = g.core.const.ConstMgr.AchievementConst
local BaseAchievementReachedPop = class("BaseAchievementReachedPop", require("app.fairyGUI.base_new.UI_BaseAchievementReachedPop"), function()
	return fgui.GComponent:create({
		resName = "BaseAchievementReachedPop",
		pkgPath = "ui/base_new/base_new",
		pkgName = "base_new"
	})
end)

function BaseAchievementReachedPop:ctor(arg_2_1)
	self._itemDataStruct = arg_2_1

	self:getView():setPosition(display.width * 0.523, display.height * 0.81)

	local var_2_0 = arg_2_1:getInfo()

	self.m_achievementTypeController:setSelectedIndex(var_2_0.achievement_type)
	self.m_name:setText(var_2_0.name)
end

function BaseAchievementReachedPop:onLoad()
	local var_3_0 = self.m_achievementTypeController:getSelectedIndex()

	self.m_effComp:addEffectSpine({
		name = "eff_ui_common_achievement",
		remove = true,
		isLoop = false,
		anim = "play_" .. var_3_0
	})

	if var_3_0 == var_0_0.Type.HIDE then
		self.m_enter_1Transition:play(handler(self, self._onExit))
	else
		self.m_enter_0Transition:play(handler(self, self._onExit))
	end
end

function BaseAchievementReachedPop:_onExit()
	self:dispatchCompEvent("Event_close_pop_layer")
end

return BaseAchievementReachedPop
