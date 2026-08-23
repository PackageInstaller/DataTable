local var_0_0 = {
	4,
	5,
	2,
	1,
	6,
	3
}
local var_0_1 = 7
local GuildStatueBgComp = class("GuildStatueBgComp", require("app.fairyGUI.guildStatue.UI_GuildStatueBgComp"))

function GuildStatueBgComp:ctor()
	self.m_bgIcon:setURL("bg/guild/bg_jt_juntuanzhuxiang.jpg")
	self.m_bgIcon:addClickListener(handler(self, self._onBgTouchClick))

	self._qualityEffName = {}
	self._qualityEff = {}
end

function GuildStatueBgComp:_onBgTouchClick()
	self:dispatchCompEvent("EVENT_BG_BACK_NORMAL_STATE")
end

function GuildStatueBgComp:updateCompView(arg_3_1)
	self._centerQuality = g.core.model.User.guildStatueData:getStatueQuality()
	self._param = arg_3_1

	self.m_statueComp:updateCompView(arg_3_1)
	self:_updateEffect()
	self:updateCenterLoader()
end

function GuildStatueBgComp:updateCenterLoader()
	self.m_centerIcon:setURL("ui://guildStatue/pic_bg_lv" .. self._centerQuality)
end

function GuildStatueBgComp:updateFocusState(arg_5_1)
	self.m_statueComp:setFocus(arg_5_1)

	if arg_5_1 then
		self:setAnimPause()
	else
		self:setAnimContinue()
	end
end

function GuildStatueBgComp:setAnimPause()
	for iter_6_0, iter_6_1 in ipairs(self._qualityEff) do
		iter_6_1:pause()
	end
end

function GuildStatueBgComp:setAnimContinue()
	for iter_7_0, iter_7_1 in ipairs(self._qualityEff) do
		iter_7_1:resume()
	end
end

function GuildStatueBgComp:onAnimEnd()
	self.m_statueComp:onAnimEnd()
end

function GuildStatueBgComp:_updateEffect()
	for iter_9_0, iter_9_1 in ipairs(self._param.statueData) do
		self:playQualityEffect(g.core.config.guild_statue_info.get(iter_9_1.base_id).stage, iter_9_1.type)
	end

	self:playQualityEffect(self._centerQuality, var_0_1)
end

function GuildStatueBgComp:playQualityEffect(arg_10_1, arg_10_2)
	local var_10_0 = ""
	local var_10_1 = arg_10_2

	if arg_10_2 == 7 then
		var_10_0 = "eff_ui_guildstatu_bgEff_lv" .. arg_10_1 .. "_centre"
		var_10_1 = "Center"
	else
		var_10_0 = "eff_ui_guildstatu_bgEff_lv" .. arg_10_1 .. "_0" .. var_0_0[arg_10_2]
	end

	if not self._qualityEffName[arg_10_2] or self._qualityEffName[arg_10_2] ~= var_10_0 then
		if self._qualityEff[arg_10_2] then
			self._qualityEff[arg_10_2]:removeSelf()

			self._qualityEff[arg_10_2] = nil
		end

		self._qualityEffName[arg_10_2] = var_10_0
		self._qualityEff[arg_10_2] = self["m_effComp" .. var_10_1]:addEffectSpine({
			anim = "play",
			isLoop = true,
			name = var_10_0
		})

		self._qualityEff[arg_10_2]:setScale(0.8)
	end
end

return GuildStatueBgComp
