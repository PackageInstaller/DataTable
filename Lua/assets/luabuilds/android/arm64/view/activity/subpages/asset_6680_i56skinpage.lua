local I56SkinPage = class("I56SkinPage", import(".TemplatePage.SkinTemplatePage"))

function I56SkinPage:OnFirstFlush()
	self.uilist:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			local var_2_0 = arg_2_2:Find("item")
			local var_2_1 = self.taskProxy:getTaskById(self.taskGroup[self.nday][arg_2_1 + 1]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][arg_2_1 + 1])

			assert(var_2_1, "without this task by id: " .. self.taskGroup[self.nday][arg_2_1 + 1])

			local var_2_2 = var_2_1:getConfig("award_display")[1]
			local var_2_3 = {
				type = var_2_2[1],
				id = var_2_2[2],
				count = var_2_2[3]
			}

			updateDrop(var_2_0, var_2_3)
			onButton(self, var_2_0, function()
				self:emit(BaseUI.ON_DROP, var_2_3)

				return
			end, SFX_PANEL)

			local var_2_4 = var_2_1:getProgress()
			local var_2_5 = var_2_1:getConfig("target_num")

			setText(arg_2_2:Find("description"), var_2_1:getConfig("desc") .. " " .. "(" .. var_2_4 .. "/" .. var_2_5 .. ")")
			setSlider(arg_2_2:Find("progress"), 0, var_2_5, var_2_4)

			local var_2_6 = arg_2_2:Find("go_btn")
			local var_2_7 = arg_2_2:Find("get_btn")
			local var_2_8 = arg_2_2:Find("got_btn")
			local var_2_9 = var_2_1:getTaskStatus()

			setActive(var_2_6, var_2_9 == 0)
			setActive(var_2_7, var_2_9 == 1)
			setActive(var_2_8, var_2_9 == 2)
			onButton(self, var_2_6, function()
				self:emit(ActivityMediator.ON_TASK_GO, var_2_1)

				return
			end, SFX_PANEL)
			onButton(self, var_2_7, function()
				self:emit(ActivityMediator.ON_TASK_SUBMIT, var_2_1)

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function I56SkinPage:OnUpdateFlush()
	I56SkinPage.super.OnUpdateFlush(self)
	setText(self.dayTF, self.nday .. " " .. #self.taskGroup)
	eachChild(self.items, function(arg_7_0)
		local var_7_0 = arg_7_0:Find("get_btn")
		local var_7_1 = arg_7_0:Find("got_btn")
		local var_7_2 = isActive(var_7_1)

		setButtonEnabled(var_7_1, false)
		setButtonEnabled(var_7_0, not var_7_2)

		if var_7_2 then
			setActive(var_7_0, true)
		end

		return
	end)

	return
end

return I56SkinPage
