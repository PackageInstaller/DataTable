local ActivityBossAmatsukazeBuffSelectLayer = class("ActivityBossAmatsukazeBuffSelectLayer", import(".ActivityBossBuffSelectLayerTemplate"))

function ActivityBossAmatsukazeBuffSelectLayer:getUIName()
	return "ActivityBossAmatsukazeBuffSelectUI"
end

function ActivityBossAmatsukazeBuffSelectLayer:init()
	ActivityBossAmatsukazeBuffSelectLayer.super.init(self)
	setText(self.top:Find("TopPage/top/deco/Text"), i18n("event_worldboss_0827_title"))
	setText(self.top:Find("TopPage/top/deco/Text/Text_1"), i18n("event_worldboss_0827_title_en"))

	return
end

function ActivityBossAmatsukazeBuffSelectLayer:didEnter()
	ActivityBossAmatsukazeBuffSelectLayer.super.didEnter(self)
	onButton(self, self.top:Find("TopPage/top/btn_back"), function()
		self:closeView()

		return
	end, SOUND_BACK)
	onButton(self, self.top:Find("TopPage/top/btn_home"), function()
		self.event:emit(BaseUI.ON_HOME)

		return
	end, SFX_PANEL)

	return
end

return ActivityBossAmatsukazeBuffSelectLayer
