local ThemeTurnTablePlateIconBg = class("ThemeTurnTablePlateIconBg", require("app.fairyGUI.summerThemeGame.UI_ThemeTurnTablePlateIconBg"), function()
	return fgui.GComponent:create({
		resName = "ThemeTurnTablePlateIconBg",
		pkgPath = "ui/summerThemeGame/summerThemeGame",
		pkgName = "summerThemeGame"
	})
end)

function ThemeTurnTablePlateIconBg:ctor(arg_2_1)
	self._quality = 1
	self._effSpine = nil
end

function ThemeTurnTablePlateIconBg:updateBgUrl(arg_3_1, arg_3_2)
	self.m_bgLoader:setURL(arg_3_1)

	if arg_3_2 then
		self._quality = arg_3_2
	end
end

function ThemeTurnTablePlateIconBg:getShowQuality()
	return self._quality
end

function ThemeTurnTablePlateIconBg:showGetSpine(arg_5_1)
	if not self._effSpine and arg_5_1 then
		self._effSpine = self.m_effectHolderComp:addEffectSpine({
			isLoop = true,
			name = "eff_ui_turntable_getloop",
			anim = "play_" .. self._quality
		})
	end

	if self._effSpine then
		self._effSpine:setVisible(arg_5_1)
	end
end

return ThemeTurnTablePlateIconBg
