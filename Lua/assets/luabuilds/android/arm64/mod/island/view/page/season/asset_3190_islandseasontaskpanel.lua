local IslandSeasonTaskPanel = class("IslandSeasonTaskPanel", import("view.base.BaseSubView"))

function IslandSeasonTaskPanel:getUIName()
	return "IslandSeasonTaskPanel"
end

function IslandSeasonTaskPanel:OnLoaded()
	local var_2_0 = self._tf:Find("content")

	self.getAllBtn = var_2_0:Find("get_all")

	setText(self.getAllBtn:Find("Text"), i18n("island_season_task_collectall"))
	setActive(var_2_0:Find("tpl"), false)

	self.scrollCom = var_2_0:Find("view"):GetComponent("LScrollRect")

	return
end

function IslandSeasonTaskPanel:OnInit()
	onButton(self, self.getAllBtn, function()
		self:emit(IslandMediator.ON_SUBMIT_TASK_ONE_STEP, self.canSubmitIds)

		return
	end, SFX_PANEL)

	function self.scrollCom.onUpdateItem(arg_5_0, arg_5_1)
		self:UpdateTask(arg_5_0, tf(arg_5_1))

		return
	end

	return
end

function IslandSeasonTaskPanel:UpdateTask(arg_6_1, arg_6_2)
	arg_6_2.name = self.taskIds[arg_6_1 + 1]

	setText(arg_6_2:Find("get/Text"), i18n("island_season_task_collect"))
	setText(arg_6_2:Find("got/Text"), i18n("island_season_task_collected"))

	local var_6_0 = self.taskVODic[self.taskIds[arg_6_1 + 1]]

	setText(arg_6_2:Find("desc"), pg.island_task[self.taskIds[arg_6_1 + 1]].task_desc)
	setText(arg_6_2:Find("name"), pg.island_task[self.taskIds[arg_6_1 + 1]].name)

	local var_6_1 = IslandTask.GetAwardsStatic(self.taskIds[arg_6_1 + 1])

	UIItemList.StaticAlign(arg_6_2:Find("awards"), arg_6_2:Find("awards/tpl"), #var_6_1, function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			updateCustomDrop(arg_7_2, var_6_1[arg_7_1 + 1], {
				style = "island"
			})
			onButton(self, arg_7_2, function()
				self.contextData:ShowMsgBox({
					title = i18n("island_word_desc"),
					type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
					dropData = var_6_1[arg_7_1 + 1]
				})

				return
			end)
		end

		return
	end)

	local var_6_2 = pg.island_task_target[pg.island_task[self.taskIds[arg_6_1 + 1]].target_id[1]].target_num

	setText(arg_6_2:Find("progress"), ((var_6_0 or nil) and (var_6_0:GetTargetList()[1]:GetProgress() or var_6_2)) .. "/" .. var_6_2)
	setActive(arg_6_2:Find("get_bg"), var_6_0 and var_6_0:IsFinish())
	setActive(arg_6_2:Find("get"), var_6_0 and var_6_0:IsSubmitOnUI() and var_6_0:IsFinish())
	setActive(arg_6_2:Find("got"), not var_6_0)
	onButton(self, arg_6_2:Find("get"), function()
		self:emit(IslandMediator.ON_SUBMIT_TASK, var_6_0.id)

		return
	end, SFX_PANEL)

	return
end

function IslandSeasonTaskPanel:Show()
	self.super.Show(self)
	self:Flush()
	IslandGuideChecker.CheckGuide("ISLAND_GUIDE_16")

	return
end

function IslandSeasonTaskPanel:Flush()
	self.taskIds = self.contextData.season:GetTaskIds()
	self.taskVODic = {}

	local var_11_0 = getProxy(IslandProxy):GetIsland():GetTaskAgency()

	for iter_11_0, iter_11_1 in ipairs(self.contextData.season:GetTaskIds()) do
		local var_11_1 = var_11_0:GetTask(iter_11_1)

		if var_11_1 then
			self.taskVODic[iter_11_1] = var_11_1
		end
	end

	table.sort(self.taskIds, CompareFuncs({
		function(arg_12_0)
			return self.taskVODic[arg_12_0] and self.taskVODic[arg_12_0]:IsFinish() and 0 or 1
		end,
		function(arg_13_0)
			return self.taskVODic[arg_13_0] and 0 or 1
		end,
		function(arg_14_0)
			return arg_14_0
		end
	}))
	self.scrollCom:SetTotalCount(#self.taskIds, -1)

	self.canSubmitIds = underscore.select(self.taskIds, function(arg_15_0)
		local var_15_0 = self.taskVODic[arg_15_0]

		if self.taskVODic[arg_15_0] then
			var_15_0 = self.taskVODic[arg_15_0]:IsSubmitOnUI()
			var_15_0 = var_15_0 and self.taskVODic[arg_15_0]:IsFinish()
		end

		return var_15_0
	end)

	setActive(self.getAllBtn, #self.canSubmitIds > 0)

	return
end

function IslandSeasonTaskPanel:OnDestroy()
	ClearLScrollrect(self.scrollCom)

	return
end

return IslandSeasonTaskPanel
