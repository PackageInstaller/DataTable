local ShadowCityOmenPage = class("ShadowCityOmenPage", import("view.activity.CorePage.OutPost.OutPostOmenPage"))

function ShadowCityOmenPage:OnInit()
	self.bg = self._tf:Find("bg")
	self.dayTF = self.bg:Find("total_progress/day")
	self.maxDayTF = self.bg:Find("total_progress/max_day")
	self.item = self.bg:Find("item")
	self.items = self.bg:Find("items")
	self.uilist = UIItemList.New(self.items, self.item)
	self.btnDetail = self.bg:Find("btn_detail")
	self.txtDetail = self.btnDetail:Find("detail")
	self.btnStory = self.bg:Find("btn_story")
	self.taskWindow = ShadowCityOmenTaskWindow.New(self._tf, self.event)

	setActive(self.item, false)

	self.progressLabel = self.bg:Find("total_progress/label")

	setText(self.progressLabel, i18n("Outpost_20250904_Progress"))
	setText(self.txtDetail, i18n("Outpost_20260514_Detail"))

	return
end

function ShadowCityOmenPage:GetProgressColor()
	return "#25A1FF", "#393A3C"
end

function ShadowCityOmenPage:UpdateTask(arg_3_1, arg_3_2)
	ShadowCityOmenPage.super.UpdateTask(self, arg_3_1, arg_3_2)
	changeToScrollText(arg_3_2:Find("description"), (self.taskProxy:getTaskById(self.taskGroup[self.nday][arg_3_1 + 1]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][arg_3_1 + 1])):getConfig("desc"))

	return
end

function ShadowCityOmenPage:PlayStory()
	local var_4_0 = self.activity:getConfig("config_client").story
	local var_4_1 = 1

	pg.NewStoryMgr.GetInstance():Play(var_4_0[self.nday][1], function()
		var_4_1 = var_4_1 + 1

		if var_4_0[self.nday][var_4_1] then
			pg.NewStoryMgr.GetInstance():Play(var_4_0[self.nday][var_4_1])
		end

		return
	end)

	return
end

return ShadowCityOmenPage
