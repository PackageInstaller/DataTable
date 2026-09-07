local DOADailyStoryPage = class("DOADailyStoryPage", import("view.activity.CorePage.CoreActivityPage"))
local var_0_1 = "event_icon"

function DOADailyStoryPage:OnInit()
	self.AD = self._tf:Find("AD")
	self.Image = self.AD:Find("Image")
	self.pageLock = self.Image:Find("lock")
	self.lockTxt = self.pageLock:Find("Text"):GetComponent("RichText")
	self.playCombo = self.AD:Find("playCombo")
	self.playShow = self.playCombo:Find("line_on")
	self.playShowBtn = self.playShow:Find("play")
	self.playShowTxt = self.playShow:Find("Text")
	self.playClose = self.playCombo:Find("line_off")
	self.playCloseTxt1 = self.playClose:Find("Text")
	self.playCloseTxt2 = self.playClose:Find("tip/rule")
	self.award = self.playCombo:Find("award")
	self.gotAward = self.award:Find("got")
	self.lockAward = self.award:Find("lock")
	self.tabTitle = self.AD:Find("tabTitle")
	self.titleTxt1 = self.tabTitle:Find("title")
	self.titleTxt2 = self.tabTitle:Find("normalTitle")
	self.tabs = self.AD:Find("tabs")
	self.tabsListCount = self.tabs.transform.childCount

	return
end

function DOADailyStoryPage:OnFirstFlush()
	self.taskProxy = getProxy(TaskProxy)
	self.config_data = self.activity:getConfig("config_data")
	self.config_client = self.activity:getConfig("config_client").story

	self:InitLocalText()
	self:OnUpdateFlush()
	self:OnShowFlush()

	return
end

function DOADailyStoryPage:InitLocalText()
	setText(self.playCloseTxt2, i18n("doa3_activityPageUI_2"))
	setText(self.playCloseTxt1, i18n("doa3_activityPageUI_3"))
	setText(self.titleTxt2, i18n("doa3_activityPageUI_4"))
	setText(self.playShowTxt, i18n("doa3_activityPageUI_5"))
	self.lockTxt:AddSprite(var_0_1, (GetSpriteFromAtlas("ui/DOADailyStoryPage_atlas", "icon")))

	return
end

function DOADailyStoryPage:OnShowFlush()
	if self.tabs and self.config_data then
		triggerToggle(self.tabs:Find("1"), true)
		self:OnUpdata(1)
	end

	return
end

function DOADailyStoryPage:OnUpdateFlush()
	for iter_5_0 = 1, #self.config_data do
		local var_5_1 = self.taskProxy:getTaskVO(self.config_data[iter_5_0]):getTaskStatus()

		self:SetRedPoint(iter_5_0, var_5_1)

		if var_5_1 == 2 then
			if not pg.NewStoryMgr.GetInstance():IsPlayed(self.config_client[iter_5_0][1]) then
				local var_5_3, var_5_4 = pg.NewStoryMgr.GetInstance():StoryName2StoryId(self.config_client[iter_5_0][1])

				pg.m02:sendNotification(GAME.STORY_UPDATE_LIST, {
					storyIds = {
						var_5_3
					},
					callback = callback
				})
			end
		end
	end

	local var_5_5 = -1

	for iter_5_1 = 0, self.tabsListCount - 1 do
		onToggle(self, self.tabs:GetChild(iter_5_1), function(arg_6_0)
			if arg_6_0 then
				if var_5_5 ~= iter_5_1 then
					self:OnUpdata(iter_5_1 + 1)
				end

				var_5_5 = iter_5_1
			end

			return
		end, SFX_PANEL)
	end

	return
end

function DOADailyStoryPage:SetRedPoint(arg_7_1, arg_7_2)
	setActive(self.AD:Find("tabs/" .. arg_7_1 .. "/red"), arg_7_2 == 1)

	return
end

function DOADailyStoryPage:OnUpdata(arg_8_1)
	local var_8_0 = self.taskProxy:getTaskVO(self.config_data[arg_8_1])

	self:UpdataAward(var_8_0)
	self:UpdateUI(arg_8_1, var_8_0)
	self:UpdataBtnInv(arg_8_1, var_8_0)

	return
end

function DOADailyStoryPage:UpdataAward(arg_9_1)
	local var_9_0 = arg_9_1:getConfig("award_display")[1]
	local var_9_1 = {
		type = var_9_0[1],
		id = var_9_0[2],
		count = var_9_0[3]
	}

	onButton(self, self.award, function()
		self:emit(BaseUI.ON_DROP, var_9_1)

		return
	end, SFX_PANEL)
	updateDrop(self.award, var_9_1)

	return
end

function DOADailyStoryPage:UpdataBtnInv(arg_11_1, arg_11_2)
	onButton(self, self.playShowBtn, function()
		pg.NewStoryMgr.GetInstance():Play(self.config_client[arg_11_1][1], function()
			self:emit(ActivityMediator.ON_TASK_SUBMIT, arg_11_2, function(arg_14_0)
				if arg_14_0 then
					self:OnUpdata(arg_11_1)
				end

				return
			end)

			return
		end, true)

		return
	end, SFX_PANEL)
	onButton(self, self.playClose, function()
		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)

	return
end

function DOADailyStoryPage:UpdateUI(arg_16_1, arg_16_2)
	local var_16_0 = arg_16_2:getTaskStatus()
	local var_16_3 = arg_16_2:getProgress()
	local var_16_4 = arg_16_2:getConfig("target_num")

	setImageSprite(self.Image, LoadSprite("ui/DOADailyStoryPage_atlas", "page_img" .. arg_16_1), true)
	setActive(self.pageLock, var_16_0 == 0)

	self.lockTxt.text = string.format("%s<icon name=%s /> %d/%d", i18n("doa3_activityPageUI_1"), var_0_1, var_16_3, var_16_4)

	setActive(self.playShow, var_16_0 ~= 0)

	local var_16_5 = pg.NewStoryMgr.GetInstance():IsPlayed(self.config_client[arg_16_1][1])

	setActive(self.playShowBtn, var_16_0 == 1)
	setActive(self.playClose, var_16_0 == 0)
	setText(self.titleTxt1, "0" .. arg_16_1 .. arg_16_2:getConfig("name"))
	setActive(self.gotAward, var_16_0 == 2 or var_16_5)
	setActive(self.lockAward, var_16_0 == 0)

	return
end

return DOADailyStoryPage
