local GuildBossWeekTabComp = class("GuildBossWeekTabComp", require("app.fairyGUI.guildBoss.UI_GuildBossWeekTabComp"))

function GuildBossWeekTabComp:updateComp(arg_1_1, arg_1_2)
	self.m_typeController:setSelectedIndex(arg_1_1.type == 1 and 0 or 1)
	self.m_isNextController:setSelectedIndex(arg_1_2 and 1 or 0)
	self:setIcon("icon/guildBoss/" .. arg_1_1.res .. ".png")
	self.m_effectHolder:addEffectSpine({
		anim = "play_idle",
		name = "eff_ui_guildboss_xuanzhong",
		isLoop = true
	})
end

function GuildBossWeekTabComp:showClickEffect()
	self.m_effectHolder:addEffectSpine({
		anim = "play_click",
		name = "eff_ui_guildboss_xuanzhong",
		isLoop = false
	})
end

function GuildBossWeekTabComp:playEnterEffect(arg_3_1)
	if arg_3_1 > 0 then
		self:newScheduleOnce(function()
			self.m_effectEnter:addEffectSpine({
				anim = "play",
				name = "eff_ui_guildboss_mainlayer",
				remove = true,
				isLoop = false
			})
		end, arg_3_1)
	else
		self.m_effectEnter:addEffectSpine({
			anim = "play",
			name = "eff_ui_guildboss_mainlayer",
			remove = true,
			isLoop = false
		})
	end
end

function GuildBossWeekTabComp:onUnload()
	self:cancelAllSchedule()
end

return GuildBossWeekTabComp
