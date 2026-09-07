local TaskPtAwardWindow = class("TaskPtAwardWindow", import("..activity.Panels.PtAwardWindow"))

function TaskPtAwardWindow:UpdateList(arg_1_1, arg_1_2, arg_1_3)
	assert(#arg_1_1 == #arg_1_2)
	self.UIlist:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			self:UpdateDrop(arg_2_2:Find("award"), arg_1_1[arg_2_1 + 1][1])
			self:UpdateDrop(arg_2_2:Find("award1"), arg_1_1[arg_2_1 + 1][2])
			setText(arg_2_2:Find("title/Text"), "PHASE " .. arg_2_1 + 1)
			setText(arg_2_2:Find("target/Text"), arg_1_2[arg_2_1 + 1])
			setText(arg_2_2:Find("target/title"), self.resTitle)
			setActive(arg_2_2:Find("award/mask"), arg_2_1 + 1 <= arg_1_3)
			setActive(arg_2_2:Find("award1/mask"), arg_2_1 + 1 <= arg_1_3)

			if arg_2_2:Find("target/icon") then
				if self.resIcon == "" then
					self.resIcon = nil
				end

				if self.resIcon then
					LoadImageSpriteAsync(self.resIcon, arg_2_2:Find("target/icon"), false)
				end

				setActive(arg_2_2:Find("target/icon"), self.resIcon)
				setActive(arg_2_2:Find("target/mark"), self.resIcon)
			end
		end

		return
	end)
	self.UIlist:align(#arg_1_1)

	return
end

function TaskPtAwardWindow:UpdateDrop(arg_3_1, arg_3_2)
	if arg_3_2 then
		setActive(arg_3_1, true)

		local var_3_0 = {
			type = arg_3_2[1],
			id = arg_3_2[2],
			count = arg_3_2[3]
		}

		updateDrop(arg_3_1, var_3_0, {
			hideName = true
		})
		onButton(self.binder, arg_3_1, function()
			self.binder:emit(BaseUI.ON_DROP, var_3_0)

			return
		end, SFX_PANEL)
	else
		setActive(arg_3_1, false)
	end

	return
end

return TaskPtAwardWindow
