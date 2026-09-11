local ActivityBossAmatsukazeScene = class("ActivityBossAmatsukazeScene", import(".ActivityBossGoriziaScene"))

function ActivityBossAmatsukazeScene:getUIName()
	return "ActivityBossAmatsukazeUI"
end

function ActivityBossAmatsukazeScene:init()
	ActivityBossAmatsukazeScene.super.init(self)
	onButton(self, self.top:Find("TopPage/top/btn_back"), function()
		self:emit(ActivityBossAmatsukazeScene.ON_BACK)

		return
	end, SOUND_BACK)
	onButton(self, self.top:Find("TopPage/top/btn_home"), function()
		self.event:emit(BaseUI.ON_HOME)

		return
	end, SFX_PANEL)
	setText(self.top:Find("TopPage/top/deco/Text"), i18n("event_worldboss_0827_title"))
	setText(self.top:Find("TopPage/top/deco/Text/Text_1"), i18n("event_worldboss_0827_title_en"))
	setText(self.top:Find("ticket/Desc"), i18n("word_special_challenge_ticket"))

	return
end

return ActivityBossAmatsukazeScene
