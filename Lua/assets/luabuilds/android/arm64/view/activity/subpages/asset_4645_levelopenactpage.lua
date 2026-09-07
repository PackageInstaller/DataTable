local LevelOpenActPage = class("LevelOpenActPage", import("view.base.BaseActivityPage"))

function LevelOpenActPage:OnInit()
	local var_1_0 = self._tf:Find("AD/task_list/content")

	self.uiList = UIItemList.New(var_1_0, var_1_0:Find("tpl"))

	self.uiList:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			self:UpdateTask(arg_2_2, self.taskVOs[arg_2_1 + 1])
		end

		return
	end)

	return
end

function LevelOpenActPage:OnDataSetting()
	if not getProxy(TaskProxy):getTaskVO(self.activity:getConfig("config_data")[1][1]) then
		pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = self.activity.id
		})

		return true
	else
		return false
	end

	return
end

function LevelOpenActPage:OnUpdateFlush()
	local var_4_0 = getProxy(TaskProxy)

	self.taskVOs = underscore.map(self.activity:getConfig("config_data")[1], function(arg_5_0)
		return var_4_0:getTaskVO(arg_5_0)
	end)

	table.sort(self.taskVOs, CompareFuncs({
		function(arg_6_0)
			if arg_6_0:isReceive() then
				return 2
			elseif arg_6_0:isFinish() then
				return 0
			else
				return 1
			end

			return
		end
	}))
	self.uiList:align(#self.taskVOs)

	return
end

function LevelOpenActPage:UpdateTask(arg_7_1, arg_7_2)
	local var_7_0 = arg_7_2:getTaskStatus()

	setImageAlpha(arg_7_1:Find("bg"), var_7_0 == 2 and 0.5 or 1)
	eachChild(arg_7_1:Find("status"), function(arg_8_0)
		setActive(arg_8_0, arg_8_0:GetSiblingIndex() == var_7_0)

		return
	end)

	local var_7_1 = arg_7_1:Find("canvas")

	setCanvasGroupAlpha(var_7_1, var_7_0 == 2 and 0.2 or 1)

	local var_7_2 = arg_7_2:getConfig("desc")

	if var_7_0 == 2 then
		setSlider(var_7_1:Find("progress"), 0, 1, 1)
	else
		local var_7_3 = arg_7_2:getProgress()
		local var_7_4 = arg_7_2:getConfig("target_num")

		var_7_2 = var_7_2 .. " " .. setColorStr("(" .. var_7_3 .. "/" .. var_7_4 .. ")", COLOR_RED)

		setSlider(var_7_1:Find("progress"), 0, var_7_4, var_7_3)
	end

	setText(arg_7_1:Find("canvas/Text"), var_7_2)

	local var_7_5 = underscore.rest(arg_7_2:getConfig("award_display"), 1)

	while #var_7_5 > 3 do
		table.remove(var_7_5)
	end

	local var_7_6 = UIItemList.New(var_7_1:Find("items"), var_7_1:Find("items/IconTpl"))

	var_7_6:make(function(arg_9_0, arg_9_1, arg_9_2)
		arg_9_1 = arg_9_1 + 1

		if arg_9_0 == UIItemList.EventUpdate then
			local var_9_0 = {
				type = var_7_5[arg_9_1][1],
				id = var_7_5[arg_9_1][2],
				count = var_7_5[arg_9_1][3]
			}

			updateDrop(arg_9_2, var_9_0)
			onButton(self, arg_9_2, function()
				self:emit(BaseUI.ON_DROP, var_9_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	var_7_6:align(#var_7_5)

	if var_7_0 == 2 then
		removeOnButton(arg_7_1)
	elseif var_7_0 == 1 then
		onButton(self, arg_7_1, function()
			self:emit(ActivityMediator.ON_TASK_SUBMIT, arg_7_2)

			return
		end, SFX_PANEL)
	elseif var_7_0 == 0 then
		onButton(self, arg_7_1, function()
			self:emit(ActivityMediator.ON_TASK_GO, arg_7_2)

			return
		end, SFX_PANEL)
	else
		assert(false, "task status error:" .. arg_7_2.id)
	end

	return
end

return LevelOpenActPage
