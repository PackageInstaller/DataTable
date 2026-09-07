local ActivityBossSurugaScene = class("ActivityBossSurugaScene", import(".ActivityBossSceneTemplate"))

function ActivityBossSurugaScene:getUIName()
	return "ActivityBossUI"
end

function ActivityBossSurugaScene:preload(arg_2_1)
	local var_2_0 = PoolMgr.GetInstance()

	var_2_0:GetPrefab("ui/cysx_fk", "cysx_fk", true, function(arg_3_0)
		var_2_0:ReturnPrefab("ui/cysx_fk", "cysx_fk", arg_3_0)
		arg_2_1()

		return
	end)

	return
end

function ActivityBossSurugaScene:init()
	ActivityBossSurugaScene.super.init(self)
	setText(self.rankTF:Find("title/Text"), i18n("word_billboard"))

	self.loader = AutoLoader.New()

	return
end

function ActivityBossSurugaScene:didEnter()
	ActivityBossSurugaScene.super.didEnter(self)
	self.loader:GetPrefab("ui/cysx_fk", "cysx_fk", function(arg_6_0)
		setParent(arg_6_0, self.left)
		setAnchoredPosition(arg_6_0, Vector2(69, 295))
		arg_6_0.transform:SetAsFirstSibling()

		return
	end)

	return
end

function ActivityBossSurugaScene:UpdateRank(arg_7_1)
	arg_7_1 = arg_7_1 or {}

	for iter_7_0 = 1, #self.rankList do
		local var_7_0 = self.rankList[iter_7_0]

		setActive(self.rankList[iter_7_0], iter_7_0 <= #arg_7_1)

		if iter_7_0 <= #arg_7_1 then
			setText(var_7_0:Find("name/Text"), tostring(arg_7_1[iter_7_0].name))
			setText(var_7_0:Find("num/Text"), "NO." .. iter_7_0)
		end
	end

	return
end

function ActivityBossSurugaScene:UpdateDropItems()
	for iter_8_0, iter_8_1 in ipairs(self.contextData.DisplayItems or {}) do
		local var_8_1 = self.barList[iter_8_0]:Find("milestone/item")
		local var_8_2 = {
			type = self.contextData.DisplayItems[5 - iter_8_0][1],
			id = self.contextData.DisplayItems[5 - iter_8_0][2],
			count = self.contextData.DisplayItems[5 - iter_8_0][3]
		}

		updateDrop(var_8_1, var_8_2)
		onButton(self, var_8_1, function()
			self:emit(ActivityBossSurugaScene.ON_DROP, var_8_2)

			return
		end, SFX_PANEL)
	end

	return
end

function ActivityBossSurugaScene:willExit()
	ActivityBossSurugaScene.super.willExit(self)
	self.loader:Clear()

	return
end

return ActivityBossSurugaScene
