local BossRushAlvitPassedLayer = class("BossRushAlvitPassedLayer", import("view.activity.BossRush.BossRushPassedCombatLoadLayer"))

BossRushAlvitPassedLayer.GROW_TIME = 0.55

function BossRushAlvitPassedLayer:getUIName()
	return "BossRushAlvitPassedUI"
end

function BossRushAlvitPassedLayer:didEnter()
	BossRushAlvitPassedLayer.super.didEnter(self)

	local var_2_0 = self._tf:Find("Image")
	local var_2_1 = math.random(1, var_2_0.childCount)

	eachChild(var_2_0, function(arg_3_0)
		setActive(arg_3_0, tonumber(arg_3_0.name) == var_2_1)

		return
	end)

	return
end

return BossRushAlvitPassedLayer
