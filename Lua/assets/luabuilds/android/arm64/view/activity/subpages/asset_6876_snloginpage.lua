local SNLoginPage = class("SNLoginPage", import(".TemplatePage.LoginTemplatePage"))

function SNLoginPage:OnInit()
	SNLoginPage.super.OnInit(self)

	self.bar = self.bg:Find("bar")

	return
end

function SNLoginPage:OnFirstFlush()
	setActive(self.item, false)
	self.itemList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventInit then
			local var_3_0 = {
				type = self.config.front_drops[arg_3_1 + 1][1],
				id = self.config.front_drops[arg_3_1 + 1][2],
				count = self.config.front_drops[arg_3_1 + 1][3]
			}

			updateDrop(arg_3_2:Find("item"), var_3_0)
			onButton(self, arg_3_2, function()
				self:emit(BaseUI.ON_DROP, var_3_0)

				return
			end, SFX_PANEL)
			GetImageSpriteFromAtlasAsync("ui/activityuipage/snloginpage_atlas", "DAY" .. arg_3_1 + 1, arg_3_2:Find("day"), true)
		elseif arg_3_0 == UIItemList.EventUpdate then
			local var_3_1 = arg_3_1 < self.nday

			setActive(arg_3_2:Find("got"), arg_3_1 < self.nday)
			setActive(arg_3_2:Find("get"), var_3_1)
			setActive(arg_3_2:Find("bg"), not var_3_1)
		end

		return
	end)

	return
end

function SNLoginPage:OnUpdateFlush()
	SNLoginPage.super.OnUpdateFlush(self)
	setFillAmount(self.bar, self.nday / self.Day)

	return
end

function SNLoginPage:OnDestroy()
	return
end

return SNLoginPage
