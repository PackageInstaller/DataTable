local MainActBossSingleBtn = class("MainActBossSingleBtn", import(".MainBaseActivityBtn"))

function MainActBossSingleBtn:GetEventName()
	return "event_boss_single"
end

function MainActBossSingleBtn:GetActivity()
	return (_.detect(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_BOSSSINGLE), function(arg_3_0)
		return not arg_3_0:isEnd()
	end))
end

function MainActBossSingleBtn:GetActivityID()
	local var_4_0 = self:GetActivity()

	return var_4_0 and var_4_0.id
end

function MainActBossSingleBtn:OnInit()
	setActive(self.tipTr.gameObject, self:IsShowTip())

	return
end

function MainActBossSingleBtn:CustomOnClick()
	pg.m02:sendNotification(GAME.GO_SCENE, SCENE.OTHERWORLD_MAP)

	return
end

function MainActBossSingleBtn:IsShowTip()
	if self:GetActivityID() == ActivityConst.OTHER_WORLD_TERMINAL_BATTLE_ID then
		return OtherworldMapScene.IsShowTip()
	end

	return false
end

return MainActBossSingleBtn
