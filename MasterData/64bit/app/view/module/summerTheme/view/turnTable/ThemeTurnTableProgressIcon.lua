local var_0_0 = g.core.const.ConstMgr.ThemeConst
local var_0_1 = g.core.model.User.themeData
local ThemeTurnTableProgressIcon = class("ThemeTurnTableProgressIcon", require("app.fairyGUI.summerThemeGame.UI_ThemeTurnTableProgressIcon"))

function ThemeTurnTableProgressIcon:ctor()
	self._activeThemeValue = var_0_0.THEME_VALUE.MOLLY
	self._index = 0
	self._turnTableData = nil
	self._progressData = nil
	self._canGetEffSpine = nil
end

function ThemeTurnTableProgressIcon:updateProgressIcon(arg_2_1, arg_2_2)
	self._activeThemeValue = arg_2_1
	self._index = arg_2_2

	local var_2_0 = var_0_1:getThemeData(arg_2_1)

	if not var_2_0 then
		return
	end

	self._turnTableData = var_2_0:getTurnTableData()

	local var_2_1 = self._turnTableData:getProgressList()[arg_2_2]

	if not var_2_1 then
		return
	end

	self._progressData = var_2_1

	self.m_progText:setText(var_2_1.cfg.times)
	self.m_progIcon:updateIcon({
		overrideClick = true,
		type = var_2_1.cfg.show_type,
		value = var_2_1.cfg.show_value,
		touchFunc = handler(self, self._onIconClick)
	})

	local var_2_2 = self.m_progIcon:getIconComp()

	if var_2_2 and var_2_2.setClickRate then
		var_2_2:setClickRate(1)
	end

	local var_2_3 = self._turnTableData:isProgAwardCanGet(self._index)

	self.m_isAwardGetController:setSelectedIndex(var_2_3 and 2 or var_2_1.isGet and 1 or 0)

	if var_2_3 and not self._canGetEffSpine then
		self._canGetEffSpine = self.m_effectHolderComp:addEffectSpine({
			anim = "play_0",
			name = "eff_ui_common_iconget",
			isLoop = true
		})
	end
end

function ThemeTurnTableProgressIcon:_onIconClick()
	if not self._turnTableData or not self._progressData then
		return
	end

	if self._turnTableData:isTurnTableClose() then
		return
	end

	if self._turnTableData:isProgAwardCanGet(self._index) then
		g.core.network.GameNetProxy:send_C2S_Turntable_Reward({
			act_id = self._activeThemeValue,
			box_id = self._progressData.cfg.id
		})
	else
		local var_3_0 = require("app.view.module.summerTheme.view.turnTable.ThemeTurnTableProgressPop").new

		g.core.module.ModuleManager:pushPopup((require("app.view.module.summerTheme.view.turnTable.ThemeTurnTableProgressPop").new({
			themeValue = self._activeThemeValue
		})))
	end
end

return ThemeTurnTableProgressIcon
