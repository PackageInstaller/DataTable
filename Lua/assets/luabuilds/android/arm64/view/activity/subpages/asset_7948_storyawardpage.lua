local StoryAwardPage = class("StoryAwardPage", import("...base.BaseActivityPage"))

function StoryAwardPage:OnInit()
	self.bg = self._tf:Find("bg")
	self.itemTpl = self._tf:Find("Item")
	self.taskItemTpl = self._tf:Find("TaskItem")
	self.scrollTF = self._tf:Find("Mask/ScrollView")
	self.container = self._tf:Find("Mask/ScrollView/Content")
	self.arrow = self._tf:Find("Mask/Arrow")

	return
end

function StoryAwardPage:OnDataSetting()
	self.config = pg.activity_event_chapter_award[self.activity:getConfig("config_id")]
	self.chapterIDList = self.config.chapter

	return
end

function StoryAwardPage:OnFirstFlush()
	for iter_3_0 = 1, #self.chapterIDList do
		local var_3_0 = self.chapterIDList[iter_3_0]
		local var_3_1 = cloneTplTo(self.taskItemTpl, self.container, "TaskItem" .. tostring(iter_3_0))
		local var_3_2 = var_3_1:Find("ItemListContainer")
		local var_3_3 = var_3_1:Find("GotTag")
		local var_3_4 = var_3_1:Find("GetBtn")

		setText(var_3_1:Find("TaskTitle/LevelBum"), pg.chapter_template[self.chapterIDList[iter_3_0]].chapter_name)

		for iter_3_1 = 1, #self.config.award_display[iter_3_0] do
			local var_3_5 = cloneTplTo(self.itemTpl, var_3_2)
			local var_3_6 = {
				type = self.config.award_display[iter_3_0][iter_3_1][1],
				id = self.config.award_display[iter_3_0][iter_3_1][2],
				count = self.config.award_display[iter_3_0][iter_3_1][3]
			}

			updateDrop(var_3_5, var_3_6)
			onButton(self, var_3_5, function()
				self:emit(BaseUI.ON_DROP, var_3_6)

				return
			end, SFX_PANEL)
		end

		onButton(self, var_3_4, function()
			self:emit(ActivityMediator.EVENT_OPERATION, {
				cmd = 1,
				activity_id = self.activity.id,
				arg1 = var_3_0
			})

			return
		end, SFX_PANEL)
	end

	onScroll(self, self.scrollTF, function(arg_6_0)
		setActive(self.arrow, arg_6_0.y >= 0.01)

		return
	end)

	return
end

function StoryAwardPage:OnUpdateFlush()
	for iter_7_0 = 1, #self.chapterIDList do
		local var_7_0 = self.container:Find("TaskItem" .. tostring(iter_7_0))
		local var_7_1 = var_7_0:Find("GotTag")
		local var_7_2 = var_7_0:Find("GetBtn")
		local var_7_3 = _.include(self.activity.data1_list, self.chapterIDList[iter_7_0])
		local var_7_4

		if var_7_3 then
			var_7_0.transform:SetAsLastSibling()

			var_7_4 = var_7_0:Find("ItemListContainer")
		end

		setGray(var_7_0:Find("TaskTitle"), var_7_3)
		setGray(var_7_4, var_7_3)
		setActive(var_7_1, var_7_3)

		local var_7_6 = getProxy(ChapterProxy):isClear(self.chapterIDList[iter_7_0])

		var_7_6 = var_7_6 and not var_7_3

		setActive(var_7_2, var_7_6)
	end

	return
end

function StoryAwardPage:OnDestroy()
	return
end

return StoryAwardPage
