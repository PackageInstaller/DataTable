local ClueMapScene = class("ClueMapScene", import("view.base.BaseUI"))
local var_0_1 = pg.activity_single_enemy
local var_0_2 = pg.activity_clue

function ClueMapScene:getUIName()
	return "ClueMapUI"
end

function ClueMapScene:init()
	self.ui = self._tf:Find("ui")
	self.closeBtn = self._tf:Find("ui/top/back_button")
	self.homeBtn = self._tf:Find("ui/top/home_button")
	self.bgs = {
		self._tf:Find("bgs/bg1"),
		self._tf:Find("bgs/bg2"),
		self._tf:Find("bgs/bg3")
	}
	self.mapsSwitch = {
		self._tf:Find("ui/mapsSwitch/map1"),
		self._tf:Find("ui/mapsSwitch/map2"),
		self._tf:Find("ui/mapsSwitch/map3")
	}
	self.chapters = {
		self._tf:Find("ui/chapters/t1"),
		self._tf:Find("ui/chapters/t2"),
		self._tf:Find("ui/chapters/t3"),
		self._tf:Find("ui/chapters/t4")
	}
	self.chapterSp = self._tf:Find("ui/chapterSp")
	self.pt = self._tf:Find("ui/pt")
	self.explore = self._tf:Find("ui/exploreTarget")
	self.taskBtn = self._tf:Find("ui/taskBtn")
	self.bookBtn = self._tf:Find("ui/bookBtn")

	setText(self.pt:Find("total"), i18n("clue_pt_tip"))

	return
end

function ClueMapScene:didEnter()
	self:InitData()
	self:ShowResUI()
	self:InitMapsSwitch()
	self:UpdateCluePanel()
	setText(self.pt:Find("Text"), self.ptData.count)
	onButton(self, self.closeBtn, function()
		self:StopBgm()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.homeBtn, function()
		self:emit(ClueMapScene.ON_HOME)

		return
	end, SFX_CANCEL)
	setActive(self.taskBtn:Find("tip"), ClueTasksLayer.ShouldShowTip())
	onButton(self, self.taskBtn, function()
		self:emit(ClueMapMediator.OPEN_CLUE_TASk, function()
			if self._tf then
				setActive(self.taskBtn:Find("tip"), ClueTasksLayer.ShouldShowTip())

				self.ptActivity = getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_PT_ACT_ID)
				self.ptData = ActivityPtData.New(self.ptActivity)

				setText(self.pt:Find("Text"), self.ptData.count)

				self.activity = getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_ACT_ID)

				setText(self.chapterSp:Find("ticket/count"), "X " .. self.activity.data1)
			end

			return
		end)

		return
	end, SFX_PANEL)
	setActive(self.bookBtn:Find("tip"), ClueBookLayer.ShouldShowTip())
	onButton(self, self.bookBtn, function()
		self:emit(ClueMapMediator.OPEN_CLUE_BOOK, function()
			if self._tf then
				self:UpdateCluePanel()
				setActive(self.bookBtn:Find("tip"), ClueBookLayer.ShouldShowTip())

				self.ptActivity = getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_PT_ACT_ID)
				self.ptData = ActivityPtData.New(self.ptActivity)

				setText(self.pt:Find("Text"), self.ptData.count)

				self.activity = getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_ACT_ID)

				setText(self.chapterSp:Find("ticket/count"), "X " .. self.activity.data1)
			end

			return
		end)

		return
	end, SFX_PANEL)
	pg.NewStoryMgr.GetInstance():Play(self.enterStory)
	self:SubmitClueTask()

	if getProxy(ContextProxy):getContextByMediator(ClueMapMediator).cleanChild and self.contextData.bookOpen then
		triggerButton(self.bookBtn)
	end

	return
end

function ClueMapScene:InitData()
	self.easyChapters = {}
	self.normalChapters = {}
	self.hardChapters = {}
	self.spChapter = nil

	for iter_10_0, iter_10_1 in ipairs(var_0_1.all) do
		if var_0_1[iter_10_1].activity_type == 2 then
			if var_0_1[iter_10_1].type == 1 then
				table.insert(self.easyChapters, var_0_1[iter_10_1])
			elseif var_0_1[iter_10_1].type == 2 then
				table.insert(self.normalChapters, var_0_1[iter_10_1])
			elseif var_0_1[iter_10_1].type == 3 then
				table.insert(self.hardChapters, var_0_1[iter_10_1])
			elseif var_0_1[iter_10_1].type == 4 then
				self.spChapter = var_0_1[iter_10_1]
			end
		end
	end

	self.activity = getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_ACT_ID)
	self.ptActivity = getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_PT_ACT_ID)
	self.ptData = ActivityPtData.New(self.ptActivity)
	self.contextData.mapIndex = defaultValue(self.contextData.mapIndex, 1)
	self.submitGroupIds = {}
	self.canSubmitTaskIds = {}
	self.submitClueIds = {}

	for iter_10_2, iter_10_3 in pairs(var_0_2.get_id_list_by_group) do
		local var_10_0 = false

		for iter_10_4, iter_10_5 in ipairs(iter_10_3) do
			local var_10_1 = tonumber(var_0_2[iter_10_5].task_id)

			if getProxy(TaskProxy):getTaskVO(var_10_1):getTaskStatus() == 1 then
				if not self.canSubmitTaskIds[iter_10_2] then
					self.canSubmitTaskIds[iter_10_2] = {}
					self.submitClueIds[iter_10_2] = {}
				end

				table.insert(self.canSubmitTaskIds[iter_10_2], var_10_1)
				table.insert(self.submitClueIds[iter_10_2], iter_10_5)

				var_10_0 = true
			end
		end

		if var_10_0 then
			table.insert(self.submitGroupIds, iter_10_2)
		end
	end

	local var_10_2 = self.activity:getConfig("config_client")

	self.enterStory = var_10_2.enterStory
	self.bgms = var_10_2.bgm1

	return
end

function ClueMapScene:RefreshPtAndTicket()
	self.ptActivity = getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_PT_ACT_ID)
	self.ptData = ActivityPtData.New(self.ptActivity)

	setText(self.pt:Find("Text"), self.ptData.count)

	self.activity = getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_ACT_ID)

	setText(self.chapterSp:Find("ticket/count"), "X " .. self.activity.data1)

	return
end

function ClueMapScene:ShowResUI()
	self.goldMax = findTF(self._tf, "ui/top/res/gold/max"):GetComponent(typeof(Text))
	self.goldValue = findTF(self._tf, "ui/top/res/gold/Text"):GetComponent(typeof(Text))
	self.oilMax = findTF(self._tf, "ui/top/res/oil/max"):GetComponent(typeof(Text))
	self.oilValue = findTF(self._tf, "ui/top/res/oil/Text"):GetComponent(typeof(Text))
	self.gemValue = findTF(self._tf, "ui/top/res/gem/Text"):GetComponent(typeof(Text))

	PlayerResUI.StaticFlush(getProxy(PlayerProxy):getRawData(), self.goldMax, self.goldValue, self.oilMax, self.oilValue, self.gemValue)
	onButton(self, findTF(self._tf, "ui/top/res/gold"), function()
		pg.playerResUI:ClickGold()

		return
	end, SFX_PANEL)
	onButton(self, findTF(self._tf, "ui/top/res/oil"), function()
		pg.playerResUI:ClickOil()

		return
	end, SFX_PANEL)
	onButton(self, findTF(self._tf, "ui/top/res/gem"), function()
		pg.playerResUI:ClickGem()

		return
	end, SFX_PANEL)

	return
end

function ClueMapScene:UpdateCluePanel()
	local var_16_0 = PlayerPrefs.GetInt("investigatingGroupId_" .. ActivityConst.Valleyhospital_ACT_ID .. "_" .. getProxy(PlayerProxy):getRawData().id, 0)
	local var_16_1 = true
	local var_16_2
	local var_16_3 = 0

	if var_16_0 ~= 0 then
		var_16_2 = {
			var_0_2[var_0_2.get_id_list_by_group[var_16_0][1]],
			var_0_2[var_0_2.get_id_list_by_group[var_16_0][2]],
			var_0_2[var_0_2.get_id_list_by_group[var_16_0][3]]
		}
		var_16_3 = getProxy(TaskProxy):getTaskVO(tonumber(var_16_2[3].task_id)):getProgress()

		for iter_16_0 = 1, 3 do
			if not getProxy(TaskProxy):getFinishTaskById(tonumber(var_16_2[iter_16_0].task_id)) then
				var_16_1 = false

				break
			end
		end
	end

	if var_16_1 then
		setText(self.explore:Find("target/Text"), i18n("clue_unselect_tip"))
	else
		setText(self.explore:Find("target/Text"), var_16_2[1].unlock_desc .. var_16_2[1].unlock_num .. "/" .. var_16_2[2].unlock_num .. "/" .. var_16_2[3].unlock_num .. i18n("clue_task_tip", var_16_3))
	end

	return
end

function ClueMapScene:InitMapsSwitch()
	for iter_17_0, iter_17_1 in ipairs(self.mapsSwitch) do
		onToggle(self, iter_17_1, function(arg_18_0)
			if arg_18_0 then
				self.contextData.mapIndex = iter_17_0

				for iter_18_0 = 1, 3 do
					setActive(self.bgs[iter_18_0], iter_18_0 == iter_17_0)

					self.mapsSwitch[iter_18_0]:GetComponent(typeof(CanvasGroup)).alpha = iter_18_0 == iter_17_0 and 1 or 0.4
				end

				if iter_17_0 == 1 then
					for iter_18_1, iter_18_2 in ipairs(self.chapters) do
						setActive(iter_18_2:Find("dusk"), iter_17_0 == 2)
						setActive(iter_18_2:Find("night"), iter_17_0 == 3)
						setActive(iter_18_2:Find("title"), true)
						setActive(iter_18_2:Find("title2"), false)
						onButton(self, iter_18_2, function()
							self:OpenChapterLayer(self.easyChapters[iter_18_1].id)

							return
						end, SFX_PANEL)
					end
				elseif iter_17_0 == 2 then
					for iter_18_3, iter_18_4 in ipairs(self.chapters) do
						setActive(iter_18_4:Find("dusk"), iter_17_0 == 2)
						setActive(iter_18_4:Find("night"), iter_17_0 == 3)
						setActive(iter_18_4:Find("title"), true)
						setActive(iter_18_4:Find("title2"), false)
						onButton(self, iter_18_4, function()
							self:OpenChapterLayer(self.normalChapters[iter_18_3].id)

							return
						end, SFX_PANEL)
					end
				else
					for iter_18_5, iter_18_6 in ipairs(self.chapters) do
						setActive(iter_18_6:Find("dusk"), iter_17_0 == 2)
						setActive(iter_18_6:Find("night"), iter_17_0 == 3)
						setActive(iter_18_6:Find("title"), false)
						setActive(iter_18_6:Find("title2"), true)
						onButton(self, iter_18_6, function()
							self:OpenChapterLayer(self.hardChapters[iter_18_5].id)

							return
						end, SFX_PANEL)
					end
				end

				setActive(self.chapterSp:Find("dusk"), iter_17_0 == 2)
				setActive(self.chapterSp:Find("night"), iter_17_0 == 3)
				GetImageSpriteFromAtlasAsync(pg.item_virtual_data_statistics[self.spChapter.enter_cost].icon, "", self.chapterSp:Find("ticket/icon"), false)

				self.activity = getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_ACT_ID)

				setText(self.chapterSp:Find("ticket/count"), "X " .. self.activity.data1)
				onButton(self, self.chapterSp, function()
					self:OpenChapterLayer(self.spChapter.id)

					return
				end, SFX_PANEL)
				pg.BgmMgr.GetInstance():Push(self.__cname, self.bgms[self.contextData.mapIndex])
			end

			return
		end, SFX_PANEL)

		if self.contextData.mapIndex == iter_17_0 then
			triggerToggle(iter_17_1, true)
		end
	end

	return
end

function ClueMapScene:OpenChapterLayer(arg_23_1)
	self:emit(ClueMapMediator.OPEN_STAGE, arg_23_1)

	return
end

function ClueMapScene:SubmitClueTask()
	if #self.submitGroupIds > 0 then
		self:emit(ClueMapMediator.ON_TASK_SUBMIT_ONESTEP, ActivityConst.Valleyhospital_TASK_ID, self.canSubmitTaskIds[self.submitGroupIds[1]], function(arg_25_0)
			if arg_25_0 then
				self:UpdateCluePanel()
				self:OpenSingleClueGroupPanel()
			end

			return
		end)

		self.showClueGroupId = table.remove(self.submitGroupIds, 1)
	end

	return
end

function ClueMapScene:OpenSingleClueGroupPanel()
	self:emit(ClueMapMediator.OPEN_SINGLE_CLUE_GROUP, self.showClueGroupId, self.submitClueIds[self.showClueGroupId], function()
		self:SubmitClueTask()
		self:UpdateCluePanel()
		setActive(self.bookBtn:Find("tip"), ClueBookLayer.ShouldShowTip())

		return
	end)

	return
end

function ClueMapScene:willExit()
	return
end

function ClueMapScene:onBackPressed()
	self:StopBgm()
	self:closeView()

	return
end

return ClueMapScene
