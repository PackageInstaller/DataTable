local LuoenTecCatchupPage = class("LuoenTecCatchupPage", import("...base.BaseActivityPage"))

function LuoenTecCatchupPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.itemTF = self.bg:Find("Award")
	self.sliderTF = self.bg:Find("Slider")
	self.progressText = self.bg:Find("Progress")
	self.goBtn = self.bg:Find("GoBtn")
	self.finishBtn = self.bg:Find("FinishBtn")

	return
end

function LuoenTecCatchupPage:OnDataSetting()
	self.curCount = self.activity.data1
	self.maxCount = pg.activity_event_blueprint_catchup[self.activity:getConfig("config_id")].obtain_max
	self.itemID = self.activity:getConfig("config_client").itemid

	return
end

function LuoenTecCatchupPage:OnFirstFlush()
	local var_3_0 = {
		count = 1,
		type = DROP_TYPE_ITEM,
		id = self.itemID
	}

	updateDrop(self.itemTF, var_3_0)
	onButton(self, self.itemTF, function()
		self:emit(BaseUI.ON_DROP, var_3_0)

		return
	end, SFX_PANEL)
	setSlider(self.sliderTF, 0, self.maxCount, self.curCount)
	setText(self.progressText, self.curCount .. "/" .. self.maxCount)
	onButton(self, self.goBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TECHNOLOGY)

		return
	end, SFX_PANEL)

	return
end

function LuoenTecCatchupPage:OnUpdateFlush()
	local var_6_0 = self.curCount >= self.maxCount

	setActive(self.goBtn, not (self.curCount >= self.maxCount))
	setActive(self.finishBtn, var_6_0)

	return
end

function LuoenTecCatchupPage:OnDestroy()
	return
end

return LuoenTecCatchupPage
