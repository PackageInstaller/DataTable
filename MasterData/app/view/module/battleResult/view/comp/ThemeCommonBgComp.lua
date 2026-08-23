local var_0_0 = {
	LI_JIN = 4,
	JIAO_GUO = 1,
	DONG_XI = 3,
	LIN_DONG = 2
}
local var_0_1 = {
	[var_0_0.JIAO_GUO] = "ui://base_new/icon_jiaoguo_4",
	[var_0_0.LIN_DONG] = "ui://base_new/icon_lindonggongye_4",
	[var_0_0.DONG_XI] = "ui://base_new/icon_dongxi_4",
	[var_0_0.LI_JIN] = "ui://base_new/icon_lijinlianmeng_4"
}
local ThemeCommonBgComp = class("ThemeCommonBgComp", require("app.fairyGUI.battleResult.UI_ThemeCommonBgComp"))

function ThemeCommonBgComp:ctor()
	self._startPos = {
		x = self.m_redImg:getX(),
		y = self.m_redImg:getY()
	}

	self.m_comEnterTransition:setHook("playImgEnter", handler(self, self._playEnterRedImg))
	self.m_againChallengeBtn:addClickListener(handler(self, self._onClickAgainChallengeBtn))
end

function ThemeCommonBgComp:_playEnterRedImg()
	local var_2_0 = (display.width - 1334) / 2

	if (display.width - 1334) / 2 > 0 then
		if self._startPos.x + var_2_0 > 0 then
			var_2_0 = -self._startPos.x

			self.m_redImg:setWidth(self.m_redImg:getWidth() + (self._startPos.x + var_2_0))
		end

		self.m_redImgEnterTransition:changeParams({
			changePos = {
				self._startPos.x + var_2_0,
				self._startPos.y
			}
		}):play()
	else
		self.m_redImgEnterTransition:play()
	end
end

function ThemeCommonBgComp:update(arg_3_1)
	if arg_3_1.isWin and arg_3_1.knight_id then
		self.m_campIcon:setURL(var_0_1[g.core.config.knight_info.get(arg_3_1.knight_id).group])
	else
		self:_showFailureState(arg_3_1)
	end
end

function ThemeCommonBgComp:_showFailureState(arg_4_1)
	if self.m_failEnterTransition then
		self.m_failEnterTransition:setHook("failDot", handler(self, self._onFailDotBegin))
	end
end

function ThemeCommonBgComp:_onFailDotBegin()
	self.m_failDot:addEffectSpine({
		remove = true,
		name = "eff_ui_dungeon_failDot",
		isLoop = false
	})
end

function ThemeCommonBgComp:_onClickAgainChallengeBtn()
	g.core.module.ModuleManager:tip("~againChallenge~")
end

return ThemeCommonBgComp
