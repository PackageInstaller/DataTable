local YamaShiroSwimwearPage = class("YamaShiroSwimwearPage", import(".TemplatePage.SkinTemplatePage"))

function YamaShiroSwimwearPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.goBtn = self._tf:Find("GoBtn")
	self.gotBtn = self._tf:Find("GotBtn")
	self.stepText = self._tf:Find("Step")

	return
end

function YamaShiroSwimwearPage:OnDataSetting()
	self.taskIDList = _.flatten((self.activity:getConfig("config_data")))

	return updateActivityTaskStatus(self.activity)
end

function YamaShiroSwimwearPage:OnFirstFlush()
	onButton(self, self.goBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
			page = "activity"
		})

		return
	end, SFX_PANEL)

	return
end

function YamaShiroSwimwearPage:OnUpdateFlush()
	local var_5_0, var_5_1 = getActivityTask(self.activity)

	setText(self.stepText, (table.indexof(self.taskIDList, var_5_0, 1)))

	local var_5_2 = var_5_1:getTaskStatus()

	setActive(self.goBtn, var_5_2 == 0 or var_5_2 == 1)
	setActive(self.gotBtn, var_5_2 == 2)

	return
end

function YamaShiroSwimwearPage:OnDestroy()
	return
end

return YamaShiroSwimwearPage
