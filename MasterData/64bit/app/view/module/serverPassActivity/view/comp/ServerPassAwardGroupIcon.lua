local var_0_0 = g.core.const.ConstMgr.ServerPassActivityConst
local ServerPassAwardGroupIcon = class("ServerPassAwardGroupIcon", require("app.fairyGUI.serverPassActivity.UI_ServerPassAwardGroupIcon"))

function ServerPassAwardGroupIcon:ctor()
	self._data = nil
	self._payType = nil
	self._tempStatue = nil

	self:addClickListener(handler(self, self._onClickSelf))
	self.m_iconEffectComp:addEffectSpine({
		scale = 1,
		isLoop = true,
		name = "eff_ui_serverPass_iconspecial"
	})
	self.m_awardEffectComp:addEffectSpine({
		scale = 0.6,
		isLoop = true,
		name = "eff_ui_common_iconget",
		anim = "play_0"
	})
end

function ServerPassAwardGroupIcon:updateGroupIcon(arg_2_1, arg_2_2)
	self.m_awardEffectComp:setVisible(true)

	self._data = arg_2_1

	self.m_unlockEffectComp:removeAllEffect()
	self.m_unlockEffectComp:setVisible(false)

	if arg_2_1.isPrivilege then
		self.m_otherIcon:setIcon(arg_2_1.icon)
		self.m_qualityIcon:setIcon(g.core.common.Path:getBaseItemIconQualityBg(arg_2_1.quality))
		self.m_upValueTxt:setText(string.format("+%d%%", math.floor(arg_2_1.value / 10)))
		self.m_showUpValueController:setSelectedIndex(1)
	else
		self.m_iconComp:updateIcon(arg_2_1)
		self.m_showUpValueController:setSelectedIndex(0)
	end

	self.m_statueController:setSelectedIndex(arg_2_2)
	self.m_iconEffectComp:setVisible(arg_2_1.isRare)
end

function ServerPassAwardGroupIcon:playUnlockAnim(arg_3_1)
	self._tempStatue = arg_3_1

	self.m_unlockEffectComp:addEffectSpine({
		scale = 1,
		name = "eff_ui_serverPass_iconunlock",
		isLoop = false,
		remove = true,
		eventHandler = handler(self, self._unlockEffectHandler)
	})
	self.m_unlockEffectComp:setVisible(true)
end

function ServerPassAwardGroupIcon:_unlockEffectHandler(arg_4_1, arg_4_2)
	if arg_4_1.type == "event" then
		if (arg_4_1.eventData or {}).name == "cut" then
			self.m_statueController:setSelectedIndex(self._tempStatue)
			self.m_awardEffectComp:setVisible(false)

			self._tempStatue = nil
		end
	end

	if require("app.view.battle.const.BattleConst").SPINE_EVENT.COMPLETE == arg_4_1.type then
		self.m_awardEffectComp:setVisible(true)
	end
end

function ServerPassAwardGroupIcon:_onClickSelf()
	local var_5_0

	if self.m_showUpValueController:getSelectedIndex() == 0 or self.m_statueController:getSelectedIndex() == 1 then
		do return end

		var_5_0 = {
			ratio = self._data.value / 10
		}
	end

	var_5_0.level = g.core.config.parameter_info.get(var_0_0.PARAMETER_ID.PRIVILEGE_LIMIT_LEVEL_ID).parameter

	g.core.module.ModuleManager:tip(g.core.lang:get(433201, var_5_0))
end

return ServerPassAwardGroupIcon
