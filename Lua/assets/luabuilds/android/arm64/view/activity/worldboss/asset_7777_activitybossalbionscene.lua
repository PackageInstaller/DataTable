local ActivityBossAlbionScene = class("ActivityBossAlbionScene", import(".ActivityBossSceneTemplate"))

function ActivityBossAlbionScene:getUIName()
	return "ActivityBossAlbionUI"
end

function ActivityBossAlbionScene:UpdateDropItems()
	for iter_2_0, iter_2_1 in ipairs(self.contextData.DisplayItems or {}) do
		local var_2_1 = self.barList[iter_2_0]:Find("milestone/item/IconTpl")
		local var_2_2 = {
			type = self.contextData.DisplayItems[5 - iter_2_0][1],
			id = self.contextData.DisplayItems[5 - iter_2_0][2],
			count = self.contextData.DisplayItems[5 - iter_2_0][3]
		}

		updateDrop(var_2_1, var_2_2)
		onButton(self, var_2_1, function()
			self:emit(ActivityBossAlbionScene.ON_DROP, var_2_2)

			return
		end, SFX_PANEL)
	end

	return
end

return ActivityBossAlbionScene
