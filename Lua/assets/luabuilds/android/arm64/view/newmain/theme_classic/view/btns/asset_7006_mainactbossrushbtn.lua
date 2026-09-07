local MainActBossRushBtn = class("MainActBossRushBtn", import(".MainBaseActivityBtn"))

function MainActBossRushBtn:GetEventName()
	return "event_series"
end

function MainActBossRushBtn:GetActivity()
	return (_.detect(getProxy(ActivityProxy):GetBossRushActivities(false), function(arg_3_0)
		return not arg_3_0:isEnd()
	end))
end

function MainActBossRushBtn:GetActivityID()
	local var_4_0 = self:GetActivity()

	return var_4_0 and var_4_0.id
end

function MainActBossRushBtn:OnInit()
	setActive(self.tipTr.gameObject, false)

	if not self.config.text_pic or self.config.text_pic == "" then
		self.hideSubImg = false
		self._tf:Find("Image").anchoredPosition = Vector2(120, -405)
	end

	return
end

function MainActBossRushBtn:CustomOnClick()
	pg.m02:sendNotification(GAME.GO_SCENE, SCENE.BOSSRUSH_MAIN)

	return
end

return MainActBossRushBtn
