local ActivityBossBristolScene = class("ActivityBossBristolScene", import(".ActivityBossSceneTemplate"))

function ActivityBossBristolScene:getUIName()
	return "ActivityBossBristolUI"
end

function ActivityBossBristolScene:init()
	ActivityBossBristolScene.super.init(self)
	setText(self.top:Find("ticket/Desc"), i18n("word_special_challenge_ticket"))

	return
end

function ActivityBossBristolScene:UpdateDropItems()
	for iter_3_0, iter_3_1 in ipairs(self.contextData.DisplayItems or {}) do
		local var_3_1 = self.barList[iter_3_0]:Find("milestone/item/IconTpl")
		local var_3_2 = {
			type = self.contextData.DisplayItems[5 - iter_3_0][1],
			id = self.contextData.DisplayItems[5 - iter_3_0][2],
			count = self.contextData.DisplayItems[5 - iter_3_0][3]
		}

		updateDrop(var_3_1, var_3_2)
		onButton(self, var_3_1, function()
			self:emit(ActivityBossBristolScene.ON_DROP, var_3_2)

			return
		end, SFX_PANEL)
	end

	return
end

return ActivityBossBristolScene
