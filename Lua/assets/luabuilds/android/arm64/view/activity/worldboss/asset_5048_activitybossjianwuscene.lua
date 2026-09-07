local ActivityBossJianwuScene = class("ActivityBossJianwuScene", import(".ActivityBossSceneTemplate"))

function ActivityBossJianwuScene:getUIName()
	return "ActivityBossJianwuUI"
end

function ActivityBossJianwuScene:UpdateDropItems()
	for iter_2_0, iter_2_1 in ipairs(self.contextData.DisplayItems or {}) do
		local var_2_1 = self.barList[iter_2_0]:Find("milestone/item")
		local var_2_2 = {
			type = self.contextData.DisplayItems[5 - iter_2_0][1],
			id = self.contextData.DisplayItems[5 - iter_2_0][2],
			count = self.contextData.DisplayItems[5 - iter_2_0][3]
		}

		updateDrop(var_2_1:GetChild(0), var_2_2)
		onButton(self, var_2_1, function()
			self:emit(ActivityBossJianwuScene.ON_DROP, var_2_2)

			return
		end, SFX_PANEL)
	end

	return
end

return ActivityBossJianwuScene
