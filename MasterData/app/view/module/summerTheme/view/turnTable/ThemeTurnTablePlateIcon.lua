local ThemeTurnTablePlateIcon = class("ThemeTurnTablePlateIcon", require("app.fairyGUI.summerThemeGame.UI_ThemeTurnTablePlateIcon"), function()
	return fgui.GComponent:create({
		resName = "ThemeTurnTablePlateIcon",
		pkgPath = "ui/summerThemeGame/summerThemeGame",
		pkgName = "summerThemeGame"
	})
end)

function ThemeTurnTablePlateIcon:ctor(arg_2_1)
	self._quality = 1
end

function ThemeTurnTablePlateIcon:updateIcon(arg_3_1, arg_3_2, arg_3_3)
	if arg_3_2 then
		self.m_iconLoader:setURL(arg_3_2)
	end

	if arg_3_3 then
		self._quality = arg_3_3
	end

	if arg_3_1 then
		self.m_numText:setText(arg_3_1.cfg.reward_size)

		local var_3_0 = arg_3_1.cfg.times - arg_3_1.turnNum

		if arg_3_1.cfg.times ~= 0 and var_3_0 <= 0 then
			self.m_iconLoader:setGrayed(var_3_0 <= 0)
			self.m_isUnlimitedController:setSelectedIndex(1)
		end
	end
end

function ThemeTurnTablePlateIcon:showGetSpine()
	self.m_onceEffectHolderComp:addEffectSpine({
		name = "eff_ui_turntable_get",
		remove = true,
		isLoop = false,
		anim = "play_" .. self._quality
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.TURN_TABLE_RESULT)
end

return ThemeTurnTablePlateIcon
