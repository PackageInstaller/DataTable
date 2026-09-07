local AnniversaryNineHwahJahSkinPage = class("AnniversaryNineHwahJahSkinPage", import("view.activity.CorePage.OutPost.OutPostOmenPage"))

function AnniversaryNineHwahJahSkinPage:OnInit()
	self.bg = self._tf:Find("bg")
	self.dayTF = self.bg:Find("total_progress/day")
	self.maxDayTF = self.bg:Find("total_progress/max_day")
	self.item = self.bg:Find("item")
	self.items = self.bg:Find("items")
	self.uilist = UIItemList.New(self.items, self.item)
	self.btnDetail = self.bg:Find("btn_detail")
	self.txtDetail = self.btnDetail:Find("detail")
	self.btnStory = self.bg:Find("btn_story")
	self.taskWindow = AnniversaryNineHwahJahTaskWindow.New(self._tf, self.event)

	setActive(self.item, false)

	self.progressLabel = self.bg:Find("total_progress/label_1")

	setText(self.progressLabel, i18n("Outpost_20250904_Progress"))
	setText(self.txtDetail, i18n("Outpost_20260514_Detail"))

	return
end

function AnniversaryNineHwahJahSkinPage:OnFirstFlush()
	AnniversaryNineHwahJahSkinPage.super.OnFirstFlush(self)
	self:playStory()

	return
end

function AnniversaryNineHwahJahSkinPage:OnUpdateFlush()
	self.nday = self:getTaskIdx(self.activity)

	self:PlayStory()

	if self.dayTF then
		setText(self.dayTF, self.nday)
		setText(self.maxDayTF, "/" .. #self.taskGroup)
	end

	self.uilist:align(#self.taskGroup[self.nday])

	if self.taskWindow:isShowing() then
		self.taskWindow:ExecuteAction("Show", self.activity)
	end

	return
end

function AnniversaryNineHwahJahSkinPage:UpdateTask(arg_4_1, arg_4_2)
	local var_4_0 = arg_4_2:Find("item")
	local var_4_1 = self.taskProxy:getTaskById(self.taskGroup[self.nday][arg_4_1 + 1]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][arg_4_1 + 1])

	assert(var_4_1, "without this task by id: " .. self.taskGroup[self.nday][arg_4_1 + 1])

	local var_4_2 = Drop.Create(var_4_1:getConfig("award_display")[1])

	updateDrop(var_4_0, var_4_2)
	onButton(self, var_4_0, function()
		self:emit(BaseUI.ON_DROP, var_4_2)

		return
	end, SFX_PANEL)

	local var_4_3 = var_4_1:getProgress()
	local var_4_4 = var_4_1:getConfig("target_num")
	local var_4_5 = var_4_1:getConfig("desc")

	if utf8.len(var_4_5) >= 11 then
		setScrollText(arg_4_2:Find("mask/description"), var_4_5)
	else
		setText(arg_4_2:Find("mask/description"), var_4_5)
	end

	local var_4_6, var_4_7 = self:GetProgressColor()

	setText(arg_4_2:Find("progressText"), (var_4_6 and setColorStr(var_4_3, var_4_6) or var_4_3) .. (var_4_7 and setColorStr("/" .. var_4_4, var_4_7) or "/" .. var_4_4))
	setSlider(arg_4_2:Find("progress"), 0, var_4_4, var_4_3)

	local var_4_9 = arg_4_2:Find("go_btn")
	local var_4_10 = arg_4_2:Find("get_btn")
	local var_4_11 = arg_4_2:Find("got_btn")
	local var_4_12 = var_4_1:getTaskStatus()

	setActive(var_4_9, var_4_12 == 0)
	setActive(var_4_10, var_4_12 == 1)
	setActive(var_4_11, var_4_12 == 2)
	onButton(self, var_4_9, function()
		self:emit(ActivityMediator.ON_TASK_GO, var_4_1)

		return
	end, SFX_PANEL)
	onButton(self, var_4_10, function()
		local var_7_0 = {}
		local var_7_1 = var_4_1:getConfig("award_display")
		local var_7_2 = getProxy(PlayerProxy):getRawData()
		local var_7_3, var_7_4 = Task.StaticJudgeOverflow(var_7_2.gold, var_7_2.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, var_7_1)

		if var_7_3 then
			table.insert(var_7_0, function(arg_8_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_7_4,
					onYes = arg_8_0
				})

				return
			end)
		end

		seriesAsync(var_7_0, function()
			self:emit(ActivityMediator.ON_TASK_SUBMIT, var_4_1)

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function AnniversaryNineHwahJahSkinPage:playStory()
	self.storyList = self.activity:getConfig("config_client").story

	if not pg.NewStoryMgr.GetInstance():IsPlayed(self.storyList[1][1]) then
		local var_10_0, var_10_1 = pg.NewStoryMgr.GetInstance():StoryName2StoryId(self.storyList[1][1])

		pg.m02:sendNotification(GAME.STORY_UPDATE_LIST, {
			storyIds = {
				var_10_0
			}
		})
	end

	return
end

return AnniversaryNineHwahJahSkinPage
