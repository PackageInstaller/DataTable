local Chuixue7daySkinPage = class("Chuixue7daySkinPage", import(".TemplatePage.SkinTemplatePage"))

function Chuixue7daySkinPage:OnInit()
	Chuixue7daySkinPage.super.OnInit(self)

	self.step_txt = self.bg:Find("step_text")

	return
end

function Chuixue7daySkinPage:OnFirstFlush()
	self.uilist:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			local var_3_0 = arg_3_2:Find("item")
			local var_3_1 = self.taskProxy:getTaskById(self.taskGroup[self.nday][arg_3_1 + 1]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][arg_3_1 + 1])

			assert(var_3_1, "without this task by id: " .. self.taskGroup[self.nday][arg_3_1 + 1])

			local var_3_2 = var_3_1:getConfig("award_display")[1]
			local var_3_3 = {
				type = var_3_2[1],
				id = var_3_2[2],
				count = var_3_2[3]
			}

			updateDrop(var_3_0, var_3_3)
			onButton(self, var_3_0, function()
				self:emit(BaseUI.ON_DROP, var_3_3)

				return
			end, SFX_PANEL)

			local var_3_4 = var_3_1:getProgress()
			local var_3_5 = var_3_1:getConfig("target_num")

			setText(arg_3_2:Find("description"), var_3_1:getConfig("desc"))
			setText(arg_3_2:Find("progressText"), var_3_4 .. "/" .. var_3_5)
			setSlider(arg_3_2:Find("progress"), 0, var_3_5, var_3_4)

			local var_3_6 = arg_3_2:Find("go_btn")
			local var_3_7 = arg_3_2:Find("get_btn")
			local var_3_8 = arg_3_2:Find("got_btn")
			local var_3_9 = var_3_1:getTaskStatus()

			setActive(var_3_6, var_3_9 == 0)
			setActive(var_3_7, var_3_9 == 1)
			setActive(var_3_8, var_3_9 == 2)
			onButton(self, var_3_6, function()
				self:emit(ActivityMediator.ON_TASK_GO, var_3_1)

				return
			end, SFX_PANEL)
			onButton(self, var_3_7, function()
				self:emit(ActivityMediator.ON_TASK_SUBMIT, var_3_1)

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function Chuixue7daySkinPage:OnUpdateFlush()
	Chuixue7daySkinPage.super.OnUpdateFlush(self)
	setText(self.step_txt, setColorStr(self.nday, "#89FF59FF") .. "/" .. #self.taskGroup)

	return
end

return Chuixue7daySkinPage
