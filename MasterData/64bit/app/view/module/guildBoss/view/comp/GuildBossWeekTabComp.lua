local GuildBossWeekTabComp = class("GuildBossWeekTabComp", require("app.fairyGUI.guildBoss.UI_GuildBossWeekTabComp"))

function GuildBossWeekTabComp:updateComp(arg_1_1, arg_1_2)
	self.m_typeController:setSelectedIndex(arg_1_1.type == 1 and 0 or 1)
	self.m_isNextController:setSelectedIndex(arg_1_2 and 1 or 0)
	self:setIcon("icon/guildBoss/" .. arg_1_1.res .. ".png")
	self.m_effectHolder:addEffectSpine({
		isLoop = true,
		name = "eff_ui_guildboss_xuanzhong",
		anim = "play_idle"
	})
end

function GuildBossWeekTabComp:showClickEffect()
	self.m_effectHolder:addEffectSpine({
		isLoop = false,
		name = "eff_ui_guildboss_xuanzhong",
		anim = "play_click"
	})
end

function GuildBossWeekTabComp:playEnterEffect(arg_3_1)
	if arg_3_1 > 0 then
		self:newScheduleOnce(function()
			self.m_effectEnter:addEffectSpine({
				remove = true,
				isLoop = false,
				name = "eff_ui_guildboss_mainlayer",
				anim = "play"
			})
		end, arg_3_1)
	else
		self.m_effectEnter:addEffectSpine({
			remove = true,
			isLoop = false,
			name = "eff_ui_guildboss_mainlayer",
			anim = "play"
		})
	end
end

function GuildBossWeekTabComp:onUnload()
	self:cancelAllSchedule()
end

return GuildBossWeekTabComp
