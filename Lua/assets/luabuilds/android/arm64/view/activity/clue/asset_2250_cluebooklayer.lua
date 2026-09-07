local ClueBookLayer = class("ClueBookLayer", import("view.base.BaseUI"))
local var_0_1 = pg.activity_clue
local var_0_2 = pg.activity_clue_group
local var_0_3 = pg.activity_clue_ending

function ClueBookLayer:getUIName()
	return "ClueBookUI"
end

function ClueBookLayer:init()
	self.closeBtn = self._tf:Find("frame/close")
	self.pageTgs = {
		self._tf:Find("frame/toggles/sitePageTg"),
		self._tf:Find("frame/toggles/charaPageTg"),
		self._tf:Find("frame/toggles/endingPageTg"),
		self._tf:Find("frame/toggles/storyPageTg")
	}
	self.pages = self._tf:Find("frame/pages")
	self.sitePage = self.pages:Find("sitePage")
	self.charaPage = self.pages:Find("charaPage")
	self.endingPage = self.pages:Find("endingPage")
	self.storyPage = self.pages:Find("storyPage")
	self.award = self._tf:Find("frame/award")

	setText(self.pageTgs[1]:Find("Text"), i18n("clue_title_1"))
	setText(self.pageTgs[1]:Find("selected/Text"), i18n("clue_title_1"))
	setText(self.pageTgs[2]:Find("Text"), i18n("clue_title_2"))
	setText(self.pageTgs[2]:Find("selected/Text"), i18n("clue_title_2"))
	setText(self.pageTgs[3]:Find("Text"), i18n("clue_title_3"))
	setText(self.pageTgs[3]:Find("selected/Text"), i18n("clue_title_3"))
	setText(self.pageTgs[4]:Find("Text"), i18n("clue_title_4"))
	setText(self.pageTgs[4]:Find("selected/Text"), i18n("clue_title_4"))

	for iter_2_0 = 1, 3 do
		setText(self.sitePage:Find("right/Viewport/Content/siteGroup" .. iter_2_0 .. "/goBtn/Text"), i18n("clue_task_goto"))
	end

	setText(self.charaPage:Find("right/goBtn/Text"), i18n("clue_task_goto"))
	setText(self.award:Find("doing/Text"), i18n("clue_get"))
	setText(self.award:Find("get/Text"), i18n("clue_get"))
	setText(self.award:Find("got/Text"), i18n("clue_got"))

	return
end

function ClueBookLayer:didEnter()
	self:InitData()
	onButton(self, self.closeBtn, function()
		self:StopBgm()
		self:closeView()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("mask"), function()
		self:StopBgm()
		self:closeView()

		return
	end, SFX_PANEL)
	self:InitView()
	self:UpdateView()
	pg.BgmMgr.GetInstance():Push(self.__cname, self.bgm)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function ClueBookLayer:InitData()
	self.activityId = ActivityConst.Valleyhospital_ACT_ID
	self.taskActivityId = ActivityConst.Valleyhospital_TASK_ID
	self.activity = getProxy(ActivityProxy):getActivityById(self.activityId)
	self.taskProxy = getProxy(TaskProxy)

	local var_6_0 = self.activity:getConfig("config_client")

	self.clueSite = var_6_0.clue_site
	self.clueChara = var_6_0.clue_chara
	self.clueEnding = var_6_0.clue_ending
	self.story = var_6_0.story
	self.storyTaskId = var_6_0.storyTaskId
	self.afterStory = var_6_0.afterStory
	self.bgm = var_6_0.bgm2
	self.contextData.indexInfo.pageIndex = self.contextData.indexInfo.pageIndex or 1
	self.contextData.indexInfo.subPageSiteIndex = self.contextData.indexInfo.subPageSiteIndex or 1
	self.contextData.indexInfo.subPageCharaIndex = self.contextData.indexInfo.subPageCharaIndex or 1
	self.contextData.indexInfo.subPageEndingIndex = self.contextData.indexInfo.subPageEndingIndex or 1
	self.endingIndex = 1
	self.storyIndex = 1
	self.playerId = getProxy(PlayerProxy):getRawData().id
	self.investigatingGroupId = PlayerPrefs.GetInt("investigatingGroupId_" .. self.activityId .. "_" .. self.playerId)

	return
end

function ClueBookLayer:InitView()
	for iter_7_0, iter_7_1 in ipairs(self.pageTgs) do
		setActive(iter_7_1:Find("selected"), self.contextData.indexInfo.pageIndex == iter_7_0)
		onToggle(self, iter_7_1, function(arg_8_0)
			if arg_8_0 then
				self.contextData.indexInfo.pageIndex = iter_7_0

				for iter_8_0 = 0, self.pages.childCount - 1 do
					setActive(self.pages:GetChild(iter_8_0), iter_8_0 == iter_7_0 - 1)
					setActive(self.pageTgs[iter_8_0 + 1]:Find("tip"), ClueBookLayer.ShouldShowTip(iter_8_0 + 1))
					setActive(self.pageTgs[iter_8_0 + 1]:Find("selected"), self.contextData.indexInfo.pageIndex == iter_8_0 + 1)
				end

				if iter_7_0 == 1 then
					self:ShowSitePage()
				elseif iter_7_0 == 2 then
					self:ShowCharaPage()
				elseif iter_7_0 == 3 then
					self:ShowEndingPage()
				elseif iter_7_0 == 4 then
					self:ShowStoryPage()
				end
			end

			return
		end, SFX_PANEL)
	end

	return
end

function ClueBookLayer:UpdateView()
	triggerToggle(self.pageTgs[self.contextData.indexInfo.pageIndex], true)

	return
end

function ClueBookLayer:SetClueGroup(arg_10_1, arg_10_2)
	local var_10_0 = var_0_2[arg_10_1]
	local var_10_1 = {
		var_0_1[var_0_1.get_id_list_by_group[arg_10_1][1]],
		var_0_1[var_0_1.get_id_list_by_group[arg_10_1][2]],
		var_0_1[var_0_1.get_id_list_by_group[arg_10_1][3]]
	}
	local var_10_2 = {}
	local var_10_3 = self.taskProxy:getTaskVO(tonumber(var_10_1[3].task_id)):getProgress()

	for iter_10_0 = 1, 3 do
		var_10_2[iter_10_0] = self.taskProxy:getFinishTaskById(tonumber(var_10_1[iter_10_0].task_id))
	end

	setText(arg_10_2:Find("title/Text"), var_10_0.title)
	setActive(arg_10_2:Find("title/Text"), var_10_2[1] or var_10_2[2] or var_10_2[3])
	setActive(arg_10_2:Find("title/lock"), not var_10_2[1] and not var_10_2[2] and not var_10_2[3])
	LoadImageSpriteAsync("cluepictures/" .. var_10_0.pic, arg_10_2:Find("picture"), false)
	setActive(arg_10_2:Find("picture/lock"), not var_10_2[1] and not var_10_2[2] and not var_10_2[3])

	for iter_10_1 = 1, 3 do
		if var_10_2[iter_10_1] then
			setText(arg_10_2:Find("clue" .. iter_10_1), var_10_1[iter_10_1].desc)
		elseif self.investigatingGroupId == arg_10_1 then
			setText(arg_10_2:Find("clue" .. iter_10_1), "<color=#858593>" .. var_10_1[iter_10_1].unlock_desc .. var_10_1[iter_10_1].unlock_num .. i18n("clue_task_tip", var_10_3) .. "</color>")
		else
			local var_10_4

			if not false then
				var_10_4 = true

				setText(arg_10_2:Find("clue" .. iter_10_1), "<color=#858593>" .. var_10_1[iter_10_1].unlock_desc .. var_10_1[iter_10_1].unlock_num .. i18n("clue_task_tip", var_10_3) .. "</color>")
			else
				setText(arg_10_2:Find("clue" .. iter_10_1), "<color=#858593>？？？</color>")
			end
		end
	end

	setActive(arg_10_2:Find("goBtn"), not var_10_2[1] or not var_10_2[2] or not var_10_2[3])
	setActive(arg_10_2:Find("goBtn/selected"), self.investigatingGroupId == arg_10_1)
	onButton(self, arg_10_2:Find("goBtn"), function()
		self.investigatingGroupId = arg_10_1

		PlayerPrefs.SetInt("investigatingGroupId_" .. self.activityId .. "_" .. self.playerId, arg_10_1)
		setActive(arg_10_2:Find("goBtn/selected"), true)

		if self.contextData.indexInfo.pageIndex == 1 then
			self:ShowSitePage()
		elseif self.contextData.indexInfo.pageIndex == 2 then
			self:ShowCharaPage()
		end

		self:OpenChapter(arg_10_1)

		return
	end, SFX_PANEL)

	return
end

function ClueBookLayer:SetAward(arg_12_1, arg_12_2)
	local var_12_0 = self.taskProxy:getTaskVO(arg_12_1)
	local var_12_1 = var_12_0:getConfig("award_display")[1]
	local var_12_2 = {
		type = var_12_1[1],
		id = var_12_1[2],
		count = var_12_1[3]
	}

	updateDrop(self.award:Find("mask/IconTpl"), var_12_2)
	onButton(self, self.award:Find("mask"), function()
		self:emit(BaseUI.ON_DROP, var_12_2)

		return
	end, SFX_PANEL)

	local var_12_3 = var_12_0:getTaskStatus()

	setText(self.award:Find("Text"), var_12_0:getConfig("desc"))
	setActive(self.award:Find("mask/IconTpl/mask"), var_12_3 == 2)
	setActive(self.award:Find("doing"), var_12_3 == 0)
	setActive(self.award:Find("get"), var_12_3 == 1)
	setActive(self.award:Find("got"), var_12_3 == 2)

	if arg_12_2 then
		onButton(self, self.award:Find("get"), function()
			self:emit(ClueBookMediator.ON_TASK_SUBMIT_ONESTEP, self.taskActivityId, {
				arg_12_1
			}, function(arg_15_0)
				if arg_15_0 then
					arg_12_2()
				end

				return
			end)

			return
		end, SFX_PANEL)
	else
		onButton(self, self.award:Find("get"), function()
			local var_16_0 = {}
			local var_16_1 = var_12_0:getConfig("award_display")
			local var_16_2 = getProxy(PlayerProxy):getRawData()
			local var_16_3, var_16_4 = Task.StaticJudgeOverflow(var_16_2.gold, var_16_2.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, var_16_1)

			if var_16_3 then
				table.insert(var_16_0, function(arg_17_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						type = MSGBOX_TYPE_ITEM_BOX,
						content = i18n("award_max_warning"),
						items = var_16_4,
						onYes = arg_17_0
					})

					return
				end)
			end

			seriesAsync(var_16_0, function()
				self:emit(ClueBookMediator.ON_TASK_SUBMIT_ONESTEP, self.taskActivityId, {
					arg_12_1
				})

				return
			end)

			return
		end, SFX_PANEL)
	end

	return
end

function ClueBookLayer:ShowSitePage()
	local var_19_0 = UIItemList.New(self.sitePage:Find("left/Viewport/Content"), self.sitePage:Find("left/Viewport/Content/pageTg"))

	var_19_0:make(function(arg_20_0, arg_20_1, arg_20_2)
		if arg_20_0 == UIItemList.EventUpdate then
			local var_20_0 = self.clueSite[arg_20_1 + 1]
			local var_20_1 = tonumber(var_0_2[self.clueSite[arg_20_1 + 1][1]].task_id)
			local var_20_2 = self.taskProxy:getTaskVO(var_20_1):getTaskStatus()

			setText(arg_20_2:Find("Text"), "PAGE  " .. string.format("%02d", arg_20_1 + 1))
			setText(arg_20_2:Find("selected/Text"), "PAGE  " .. string.format("%02d", arg_20_1 + 1))
			setActive(arg_20_2:Find("Text"), self.contextData.indexInfo.subPageSiteIndex ~= arg_20_1 + 1)
			setActive(arg_20_2:Find("selected"), self.contextData.indexInfo.subPageSiteIndex == arg_20_1 + 1)
			setActive(arg_20_2:Find("completed"), var_20_2 == 2)
			setActive(arg_20_2:Find("tip"), var_20_2 == 1)
			onToggle(self, arg_20_2, function(arg_21_0)
				if arg_21_0 then
					self.contextData.indexInfo.subPageSiteIndex = arg_20_1 + 1

					for iter_21_0 = 1, #self.clueSite do
						setActive(self.sitePage:Find("left/Viewport/Content"):GetChild(iter_21_0 - 1):Find("Text"), self.contextData.indexInfo.subPageSiteIndex ~= iter_21_0)
						setActive(self.sitePage:Find("left/Viewport/Content"):GetChild(iter_21_0 - 1):Find("selected"), self.contextData.indexInfo.subPageSiteIndex == iter_21_0)
					end

					for iter_21_1 = 1, 3 do
						self:SetClueGroup(var_20_0[iter_21_1], self.sitePage:Find("right/Viewport/Content/siteGroup" .. iter_21_1))
					end

					self:SetAward(var_20_1)
				end

				return
			end, SFX_PANEL)

			if self.contextData.indexInfo.subPageSiteIndex == arg_20_1 + 1 then
				triggerToggle(arg_20_2, true)
			end
		end

		return
	end)
	var_19_0:align(#self.clueSite)

	return
end

function ClueBookLayer:ShowCharaPage()
	local var_22_0 = UIItemList.New(self.charaPage:Find("left/Viewport/Content"), self.charaPage:Find("left/Viewport/Content/pageTg"))

	var_22_0:make(function(arg_23_0, arg_23_1, arg_23_2)
		if arg_23_0 == UIItemList.EventUpdate then
			local var_23_0 = self.clueChara[arg_23_1 + 1][1]
			local var_23_1 = tonumber(var_0_2[self.clueChara[arg_23_1 + 1][1]].task_id)
			local var_23_2 = self.taskProxy:getTaskVO(var_23_1):getTaskStatus()

			if self:GetGroupClueCompleteCount(self.clueChara[arg_23_1 + 1][1]) == 0 then
				setText(arg_23_2:Find("Text"), "？？？")
				setText(arg_23_2:Find("selected/Text"), "？？？")
			else
				setText(arg_23_2:Find("Text"), var_0_2[self.clueChara[arg_23_1 + 1][1]].title)
				setText(arg_23_2:Find("selected/Text"), var_0_2[self.clueChara[arg_23_1 + 1][1]].title)
			end

			setActive(arg_23_2:Find("Text"), self.contextData.indexInfo.subPageCharaIndex ~= arg_23_1 + 1)
			setActive(arg_23_2:Find("selected"), self.contextData.indexInfo.subPageCharaIndex == arg_23_1 + 1)
			setActive(arg_23_2:Find("Text/completed"), var_23_2 == 2)
			setActive(arg_23_2:Find("selected/Text/completed"), var_23_2 == 2)
			setActive(arg_23_2:Find("tip"), var_23_2 == 1)
			onToggle(self, arg_23_2, function(arg_24_0)
				if arg_24_0 then
					self.contextData.indexInfo.subPageCharaIndex = arg_23_1 + 1

					for iter_24_0 = 1, #self.clueChara do
						setActive(self.charaPage:Find("left/Viewport/Content"):GetChild(iter_24_0 - 1):Find("Text"), self.contextData.indexInfo.subPageCharaIndex ~= iter_24_0)
						setActive(self.charaPage:Find("left/Viewport/Content"):GetChild(iter_24_0 - 1):Find("selected"), self.contextData.indexInfo.subPageCharaIndex == iter_24_0)
					end

					self:SetClueGroup(var_23_0, self.charaPage:Find("right"))
					self:SetAward(var_23_1)
				end

				return
			end, SFX_PANEL)

			if self.contextData.indexInfo.subPageCharaIndex == arg_23_1 + 1 then
				triggerToggle(arg_23_2, true)
			end
		end

		return
	end)
	var_22_0:align(#self.clueChara)
	onScroll(self, self.charaPage:Find("left"), function(arg_25_0)
		setActive(self.charaPage:Find("triangle"), arg_25_0.y > 0.01)

		return
	end)

	return
end

function ClueBookLayer:GetGroupClueCompleteCount(arg_26_1)
	local var_26_0 = {
		var_0_1[var_0_1.get_id_list_by_group[arg_26_1][1]],
		var_0_1[var_0_1.get_id_list_by_group[arg_26_1][2]],
		var_0_1[var_0_1.get_id_list_by_group[arg_26_1][3]]
	}
	local var_26_1 = 0

	for iter_26_0 = 1, 3 do
		if self.taskProxy:getFinishTaskById(tonumber(var_26_0[iter_26_0].task_id)) then
			var_26_1 = var_26_1 + 1
		end
	end

	return var_26_1
end

function ClueBookLayer:ShowEndingPage()
	local var_27_0 = UIItemList.New(self.endingPage:Find("left/Viewport/Content"), self.endingPage:Find("left/Viewport/Content/pageTg"))

	var_27_0:make(function(arg_28_0, arg_28_1, arg_28_2)
		if arg_28_0 == UIItemList.EventUpdate then
			local var_28_0 = self.clueEnding[arg_28_1 + 1][1]
			local var_28_1 = self.clueEnding[arg_28_1 + 1][2]
			local var_28_2 = self.taskProxy:getTaskVO(self.clueEnding[arg_28_1 + 1][2]):getTaskStatus()

			setText(arg_28_2:Find("Text"), var_0_3[self.clueEnding[arg_28_1 + 1][1][#self.clueEnding[arg_28_1 + 1][1]]].title2)
			setText(arg_28_2:Find("selected/Text"), var_0_3[var_28_0[#var_28_0]].title2)
			setActive(arg_28_2:Find("Text"), self.contextData.indexInfo.subPageEndingIndex ~= arg_28_1 + 1)
			setActive(arg_28_2:Find("selected"), self.contextData.indexInfo.subPageEndingIndex == arg_28_1 + 1)
			setActive(arg_28_2:Find("Text/completed"), var_28_2 == 2)
			setActive(arg_28_2:Find("selected/Text/completed"), var_28_2 == 2)

			local var_28_3 = false

			if var_28_2 == 1 then
				var_28_3 = true
			else
				local var_28_4 = true

				for iter_28_0 = 1, #var_28_0 do
					local var_28_5 = self.taskProxy:getTaskVO(tonumber(var_0_3[var_28_0[iter_28_0]].task_id)):getTaskStatus()

					if var_28_5 == 1 and var_28_4 then
						var_28_3 = true
					end

					if var_28_5 ~= 2 then
						var_28_4 = false
					end
				end
			end

			setActive(arg_28_2:Find("tip"), var_28_3)
			onToggle(self, arg_28_2, function(arg_29_0)
				if arg_29_0 then
					self.contextData.indexInfo.subPageEndingIndex = arg_28_1 + 1

					for iter_29_0 = 1, #self.clueEnding do
						setActive(self.endingPage:Find("left/Viewport/Content"):GetChild(iter_29_0 - 1):Find("Text"), self.contextData.indexInfo.subPageEndingIndex ~= iter_29_0)
						setActive(self.endingPage:Find("left/Viewport/Content"):GetChild(iter_29_0 - 1):Find("selected"), self.contextData.indexInfo.subPageEndingIndex == iter_29_0)
					end

					table.sort(var_28_0, function(arg_30_0, arg_30_1)
						return var_0_3[arg_30_0].unlock_pre < var_0_3[arg_30_1].unlock_pre
					end)

					local var_29_0 = true

					for iter_29_1 = 1, #var_28_0 do
						local var_29_1 = var_0_3[var_28_0[iter_29_1]]
						local var_29_2 = self.taskProxy:getTaskVO(tonumber(var_0_3[var_28_0[iter_29_1]].task_id)):getTaskStatus()

						setActive(self.endingPage:Find("right/ending" .. iter_29_1 .. "/icon"), var_29_0)
						setActive(self.endingPage:Find("right/ending" .. iter_29_1 .. "/selected"), self.endingIndex == iter_29_1)
						setActive(self.endingPage:Find("right/ending" .. iter_29_1 .. "/lock"), not var_29_0)
						setActive(self.endingPage:Find("right/ending" .. iter_29_1 .. "/tip"), var_29_2 == 1 and var_29_0)

						self.endingPage:Find("right/ending" .. iter_29_1):GetComponent(typeof(CanvasGroup)).alpha = var_29_0 and 1 or 0.8

						if var_29_0 then
							setText(self.endingPage:Find("right/ending" .. iter_29_1 .. "/title"), var_29_1.title)
							onToggle(self, self.endingPage:Find("right/ending" .. iter_29_1), function(arg_31_0)
								if arg_31_0 then
									self.endingIndex = iter_29_1

									for iter_31_0 = 1, #var_28_0 do
										setActive(self.endingPage:Find("right/ending" .. iter_31_0 .. "/selected"), iter_31_0 == self.endingIndex)
									end

									local var_31_0 = var_29_1.clue
									local var_31_1 = var_29_1.locate

									setText(self.endingPage:Find("middle/titleBg/Text"), var_29_1.title2)
									setText(self.endingPage:Find("middle/endingDetail/Viewport/Content/detail"), var_29_1.desc)
									onScroll(self, self.endingPage:Find("middle/endingDetail"), function(arg_32_0)
										setActive(self.endingPage:Find("middle/triangle"), arg_32_0.y > 0.01)

										return
									end)
									setActive(self.endingPage:Find("right/combine"), var_29_2 == 1)
									onButton(self, self.endingPage:Find("right/combine"), function()
										self:emit(ClueBookMediator.ON_TASK_SUBMIT_ONESTEP, self.taskActivityId, {
											tonumber(var_29_1.task_id)
										})

										return
									end, SFX_PANEL)
									setActive(self.endingPage:Find("middle/cluePanel"), var_29_2 ~= 2)

									if var_29_2 ~= 2 then
										local var_31_2 = UIItemList.New(self.endingPage:Find("middle/cluePanel"), self.endingPage:Find("middle/cluePanel/clueGroup"))

										var_31_2:make(function(arg_34_0, arg_34_1, arg_34_2)
											if arg_34_0 == UIItemList.EventUpdate then
												local var_34_0 = var_31_0[arg_34_1 + 1]
												local var_34_1 = var_31_1[arg_34_1 + 1][1]
												local var_34_2 = var_31_1[arg_34_1 + 1][2]
												local var_34_3 = var_31_1[arg_34_1 + 1][3]

												if var_29_1.type == 1 then
													local var_34_4 = var_0_2[var_31_0[arg_34_1 + 1]]

													for iter_34_0 = 1, 4 do
														setActive(arg_34_2:Find("" .. iter_34_0), var_34_1 == iter_34_0)
													end

													setActive(arg_34_2:Find("ending"), false)

													local var_34_5 = arg_34_2:GetChild(var_34_1 - 1)
													local var_34_6 = self:GetGroupClueCompleteCount(var_31_0[arg_34_1 + 1])

													var_34_5:GetComponent(typeof(CanvasGroup)).alpha = var_34_6 == 0 and 0.4 or 1

													if var_34_6 == 0 then
														setText(var_34_5:Find("name/Text"), "？？？")
													else
														setText(var_34_5:Find("name/Text"), var_34_4.title)
													end

													setText(var_34_5:Find("progress"), var_34_6 .. "/3")
													setActive(var_34_5:Find("progress"), var_34_6 == 1 or var_34_6 == 2)
													setActive(var_34_5:Find("complete"), var_34_6 == 3)
													onButton(self, arg_34_2, function()
														self:emit(ClueBookMediator.OPEN_SINGLE_CLUE_GROUP, var_34_0)

														return
													end, SFX_PANEL)
												else
													setText(arg_34_2:Find("ending/name"), var_0_3[var_31_0[arg_34_1 + 1]].title2)

													for iter_34_1 = 1, 4 do
														setActive(arg_34_2:Find("" .. iter_34_1), false)
													end

													setActive(arg_34_2:Find("ending"), true)

													for iter_34_2 = 1, 3 do
														setActive(arg_34_2:Find("ending/icon" .. iter_34_2), arg_34_1 + 1 == iter_34_2)
													end

													onButton(self, arg_34_2, function()
														triggerToggle(self.endingPage:Find("right/ending" .. arg_34_1 + 1), true)

														return
													end, SFX_PANEL)
												end

												arg_34_2.anchoredPosition = Vector2(var_34_2[1], var_34_2[2])
												arg_34_2.localScale = Vector3(var_34_3, var_34_3, 1)
											end

											return
										end)
										var_31_2:align(#var_31_0)
									end
								end

								return
							end, SFX_PANEL)
						else
							setText(self.endingPage:Find("right/ending" .. iter_29_1 .. "/title"), "<color=#" .. ((iter_29_1 == #var_28_0 or nil) and "6683cf") .. ">" .. var_29_1.title .. "</color>")
							removeOnToggle(self.endingPage:Find("right/ending" .. iter_29_1))
						end

						if var_29_2 ~= 2 then
							var_29_0 = false
						end
					end

					triggerToggle(self.endingPage:Find("right/ending" .. self.endingIndex), true)
					self:SetAward(var_28_1)
				end

				return
			end, SFX_PANEL)

			if self.contextData.indexInfo.subPageEndingIndex == arg_28_1 + 1 then
				triggerToggle(arg_28_2, true)
			end
		end

		return
	end)
	var_27_0:align(#self.clueEnding)

	return
end

function ClueBookLayer:ShowStoryPage()
	local function var_37_0()
		setText(self.storyPage:Find("pageIndex/Text"), self.storyIndex .. "/2")
		setActive(self.storyPage:Find("leftBtn"), self.storyIndex == 2)
		setActive(self.storyPage:Find("rightBtn"), self.storyIndex == 1)
		setActive(self.storyPage:Find("subPages/page1"), self.storyIndex == 1)
		setActive(self.storyPage:Find("subPages/page2"), self.storyIndex == 2)

		return
	end

	var_37_0()
	onButton(self, self.storyPage:Find("leftBtn"), function()
		self.storyIndex = 1

		var_37_0()

		return
	end, SFX_PANEL)
	onButton(self, self.storyPage:Find("rightBtn"), function()
		self.storyIndex = 2

		var_37_0()

		return
	end, SFX_PANEL)

	for iter_37_0 = 1, #self.story do
		local var_37_1

		if iter_37_0 <= 5 then
			var_37_1 = self.storyPage:Find("subPages/page1"):GetChild(iter_37_0 - 1)
		else
			var_37_1 = self.storyPage:Find("subPages/page2"):GetChild(iter_37_0 - 6)

			local var_37_2 = self.story[iter_37_0][3]
		end

		local var_37_3 = self.story[iter_37_0][4]
		local var_37_4 = self.taskProxy:getTaskVO(self.story[iter_37_0][3]):getTaskStatus()

		if self.story[iter_37_0][1] == 1 then
			setText(var_37_1:Find("lock/Text"), i18n("clue_lock_tip1"))
		else
			setText(var_37_1:Find("lock/Text"), i18n("clue_lock_tip2", var_0_3[self.story[iter_37_0][2]].title))
		end

		setActive(var_37_1:Find("lock"), var_37_4 == 0)
		setActive(var_37_1:Find("canGet"), var_37_4 == 1)

		var_37_1:GetComponent(typeof(CanvasGroup)).alpha = var_37_4 == 0 and 0.4 or 1

		if var_37_4 == 1 then
			onButton(self, var_37_1, function()
				self:emit(ClueBookMediator.ON_TASK_SUBMIT_ONESTEP, self.taskActivityId, {
					var_37_2
				}, function(arg_42_0)
					if arg_42_0 then
						pg.NewStoryMgr.GetInstance():Play(var_37_3)
					end

					return
				end)

				return
			end, SFX_PANEL)
		elseif var_37_4 == 2 then
			onButton(self, var_37_1, function()
				pg.NewStoryMgr.GetInstance():Play(var_37_3, nil, true)

				return
			end, SFX_PANEL)
		else
			removeOnButton(var_37_1)
		end
	end

	self:SetAward(self.storyTaskId, function()
		pg.NewStoryMgr.GetInstance():Play(self.afterStory)

		return
	end)

	return
end

function ClueBookLayer:OpenChapter(arg_45_1)
	self:emit(ClueBookMediator.OPEN_CLUE_JUMP, arg_45_1)

	return
end

function ClueBookLayer:willExit()
	return
end

function ClueBookLayer:onBackPressed()
	self:StopBgm()
	self:closeView()

	return
end

function ClueBookLayer:ShouldShowTip()
	local var_48_0 = getProxy(ActivityProxy)
	local var_48_1 = getProxy(TaskProxy)
	local var_48_2 = var_48_0:getActivityById(ActivityConst.Valleyhospital_ACT_ID):getConfig("config_client")
	local var_48_3 = var_48_2.clue_chara
	local var_48_4 = var_48_2.clue_ending
	local var_48_5 = var_48_2.story
	local var_48_6 = var_48_2.storyTaskId

	if not self or self == 1 then
		for iter_48_0 = 1, #var_48_0.clue_site do
			if var_48_1:getTaskVO((tonumber(var_0_2[var_48_0.clue_site[iter_48_0][1]].task_id))):getTaskStatus() == 1 then
				return true
			end
		end
	end

	if not self or self == 2 then
		for iter_48_1 = 1, #var_48_3 do
			if var_48_1:getTaskVO((tonumber(var_0_2[var_48_3[iter_48_1][1]].task_id))):getTaskStatus() == 1 then
				return true
			end
		end
	end

	if not self or self == 3 then
		for iter_48_2 = 1, #var_48_4 do
			if var_48_1:getTaskVO(var_48_4[iter_48_2][2]):getTaskStatus() == 1 then
				return true
			end

			local var_48_7 = true

			for iter_48_3 = 1, #var_48_4[iter_48_2][1] do
				local var_48_8 = var_48_1:getTaskVO(tonumber(var_0_3[var_48_4[iter_48_2][1][iter_48_3]].task_id)):getTaskStatus()

				if var_48_8 == 1 and var_48_7 then
					return true
				end

				if var_48_8 ~= 2 then
					var_48_7 = false
				end
			end
		end
	end

	if not self or self == 4 then
		if var_48_1:getTaskVO(var_48_6):getTaskStatus() == 1 then
			return true
		end

		for iter_48_4 = 1, #var_48_5 do
			if var_48_1:getTaskVO(var_48_5[iter_48_4][3]):getTaskStatus() == 1 then
				return true
			end
		end
	end

	return false
end

return ClueBookLayer
