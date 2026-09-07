local LevelRemasterView = class("LevelRemasterView", import("..base.BaseSubView"))

function LevelRemasterView:getUIName()
	return "LevelRemasterView"
end

function LevelRemasterView:OnInit()
	self.content = self._tf:Find("list/content")
	self.item = self.content:Find("item")
	self.numsTxt = self._tf:Find("nums/text")
	self.helpBtn = self._tf:Find("help")

	setActive(self.item, false)

	self.getRemasterTF = self._tf:Find("getBtn/state_before")
	self.gotRemasterTF = self._tf:Find("getBtn/state_after")
	self.exToggle = self._tf:Find("toggles/EX")
	self.spToggle = self._tf:Find("toggles/SP")

	self:bind(LevelUIConst.FLUSH_REMASTER_INFO, function(arg_3_0)
		if not self:isShowing() then
			return
		end

		self:flushOnly()

		return
	end)
	self:bind(LevelUIConst.FLUSH_REMASTER_TICKET, function(arg_4_0)
		if not self:isShowing() then
			return
		end

		self:updateTicketDisplay()

		return
	end)

	local var_2_0 = getProxy(ChapterProxy)
	local var_2_1 = pg.TimeMgr.GetInstance()

	self.itemList = UIItemList.New(self.content, self.item)

	self.itemList:make(function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1

		if arg_5_0 == UIItemList.EventUpdate then
			local var_5_0 = self.temp[arg_5_1]

			setActive(arg_5_2:Find("right"), arg_5_1 % 2 > 0)

			local var_5_1 = arg_5_2:Find("bg/icon")
			local var_5_2 = arg_5_2:Find("bg/lock")
			local var_5_3 = arg_5_2:Find("bg/wait")
			local var_5_4 = arg_5_2:Find("bg/tip")

			setActive(var_5_1, false)
			setActive(var_5_2, false)
			setActive(var_5_3, false)
			setActive(var_5_4, false)

			if not var_5_0 then
				setActive(var_5_3, true)
				onButton(self, var_5_3, function()
					pg.TipsMgr.GetInstance():ShowTips(i18n("levelScene_remaster_do_not_open"))

					return
				end, SFX_PANEL)
			elseif not var_2_1:inTime(var_5_0.time) then
				setActive(var_5_2, true)
				onButton(self, var_5_2, function()
					pg.TipsMgr.GetInstance():ShowTips(i18n("levelScene_remaster_do_not_open"))

					return
				end, SFX_PANEL)
			else
				setActive(var_5_1, true)
				GetImageSpriteFromAtlasAsync("activitybanner/" .. var_5_0.bg, "", var_5_1)

				local var_5_5 = var_5_1:Find("info")

				setText(var_5_5:Find("dec1/index"), (arg_5_1 < 10 or nil) and ("0" .. arg_5_1 or arg_5_1))
				setText(var_5_5:Find("progress/Text"), BossRushChapterRemasterHelper.GetProgress(var_5_0.id) .. "%")
				onButton(self, var_5_1, function()
					if BossRushChapterRemasterHelper.IsRemasterByActivity(var_5_0.id) then
						self:HandleActTypeRemaster(var_5_0)

						return
					end

					local var_8_0 = (function()
						for iter_9_0, iter_9_1 in ipairs({
							PlayerPrefs.GetInt("remaster_lastmap_" .. var_5_0.id, pg.chapter_template[var_5_0.config_data[1]].map),
							pg.chapter_template[var_5_0.config_data[1]].map
						}) do
							if var_2_0:getMapById(iter_9_1):isUnlock() then
								return iter_9_1
							end
						end

						return
					end)()

					if var_8_0 then
						self.onSelectMap(var_8_0)
						self:Hide()
					end

					return
				end, SFX_PANEL)

				local var_5_7 = BossRushChapterRemasterHelper.ChapterAwardInfo(var_5_0.id)
				local var_5_8 = underscore.rest(var_5_0.drop_display, 1)

				if var_5_7 then
					table.insert(var_5_8, 1, var_5_7)
				elseif #var_5_0.drop_display_sp > 0 then
					var_5_8 = table.mergeArray(var_5_0.drop_display_sp, var_5_8)
				end

				local var_5_9 = var_5_5:Find("content")

				eachChild(var_5_9, function(arg_10_0)
					setActive(arg_10_0, false)

					return
				end)

				for iter_5_0, iter_5_1 in ipairs(var_5_8) do
					local var_5_10 = iter_5_0 > var_5_9.childCount and cloneTplTo(var_5_9:GetChild(0), var_5_9) or var_5_9:GetChild(iter_5_0 - 1)

					setActive(var_5_10, true)

					if var_5_7 and iter_5_0 == 1 then
						local var_5_11 = var_5_7[1]
						local var_5_12, var_5_13, var_5_14, var_5_15, var_5_16 = unpack(var_5_7[2])
						local var_5_17 = var_5_7[3]
						local var_5_18 = var_2_0:getRemasterInfo(var_5_7[3], var_5_12, var_5_7[1])

						setActive(var_5_4, var_5_15 <= var_5_18.count)
						setActive(var_5_10:Find("mark"), var_5_15 > var_5_18.count)
						setActive(var_5_10:Find("Slider"), var_5_15 > var_5_18.count)
						setActive(var_5_10:Find("achieve"), var_5_15 <= var_5_18.count)
						setSlider(var_5_10:Find("Slider"), 0, var_5_15, var_5_18.count)

						local var_5_19 = {
							type = var_5_13,
							id = var_5_14
						}

						updateDrop(var_5_10:Find("IconTpl"), var_5_19)
						onButton(self, var_5_10:Find("IconTpl"), function()
							pg.MsgboxMgr.GetInstance():ShowMsgBox({
								hideYes = true,
								hideNo = true,
								type = MSGBOX_TYPE_SINGLE_ITEM,
								drop = var_5_19,
								remaster = {
									word = i18n("level_remaster_tip4", (BossRushChapterRemasterHelper.GetAwardName(var_5_17, var_5_12))),
									number = var_5_18.count .. "/" .. var_5_15,
									btn_text = i18n(var_5_18.count < var_5_15 and "level_remaster_tip2" or "level_remaster_tip3"),
									btn_call = function()
										if var_5_18.count < var_5_15 then
											if var_5_17 and var_5_17 > 0 then
												self:emit(LevelMediator2.ON_BOSSRUSH_REMASTER_ACTIVITY, var_5_17)
												self:Hide()

												return
											end

											local var_12_0 = pg.chapter_template[var_5_12].map
											local var_12_1, var_12_2 = var_2_0:getMapById(pg.chapter_template[var_5_12].map):isUnlock()

											if not var_12_1 then
												pg.TipsMgr.GetInstance():ShowTips(var_12_2)
											else
												self.onSelectMap(var_12_0)
												self:Hide()
											end
										else
											self:emit(LevelMediator2.ON_CHAPTER_REMASTER_AWARD, var_5_12, var_5_11, var_5_17)
										end

										return
									end
								}
							})

							return
						end, SFX_PANEL)
					else
						local var_5_20 = {
							type = iter_5_1[1][1],
							id = iter_5_1[1][2]
						}

						updateDrop(var_5_10:Find("IconTpl"), var_5_20)
						onButton(self, var_5_10:Find("IconTpl"), function()
							pg.MsgboxMgr.GetInstance():ShowMsgBox({
								hideYes = true,
								hideNo = true,
								type = MSGBOX_TYPE_SINGLE_ITEM,
								drop = var_5_20,
								remaster = {
									word = i18n("level_remaster_tip1") .. iter_5_1[2],
									btn_text = i18n("text_confirm")
								}
							})

							return
						end, SFX_PANEL)
						setActive(var_5_10:Find("mark"), false)
						setActive(var_5_10:Find("Slider"), false)
						setActive(var_5_10:Find("achieve"), false)
					end
				end
			end
		end

		return
	end)
	onButton(self, self.getRemasterTF, function()
		if var_2_0.remasterTickets + pg.gameset.reactivity_ticket_daily.key_value > pg.gameset.reactivity_ticket_max.key_value then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("tack_tickets_max_warning", math.max(pg.gameset.reactivity_ticket_max.key_value - var_2_0.remasterTickets, 0)),
				onYes = function()
					self:emit(LevelMediator2.ON_CLICK_RECEIVE_REMASTER_TICKETS_BTN)

					return
				end
			})

			return
		end

		self:emit(LevelMediator2.ON_CLICK_RECEIVE_REMASTER_TICKETS_BTN)

		return
	end, SFX_PANEL)

	return
end

function LevelRemasterView:HandleActTypeRemaster(arg_16_1)
	local var_16_0 = arg_16_1.activity_id
	local var_16_1 = getProxy(ActivityPermanentProxy)
	local var_16_2 = var_16_1:GetActivityTypeById(arg_16_1.activity_id)
	local var_16_3 = var_16_2 and var_16_1:getDoingActivityId(var_16_2)

	local function var_16_4()
		self:emit(LevelMediator2.ON_BOSSRUSH_REMASTER_ACTIVITY, var_16_0)

		return
	end

	if var_16_3 and var_16_3 ~= arg_16_1.activity_id then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("bossrush_act_remaster_close_prev_one_tip"),
			onYes = var_16_4
		})

		return
	end

	var_16_4()

	return
end

function LevelRemasterView:OnDestroy()
	self.onItem = nil

	if self:isShowing() then
		self:Hide()
	end

	return
end

function LevelRemasterView:Show()
	LevelRemasterView.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function LevelRemasterView:Hide()
	LevelRemasterView.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function LevelRemasterView:set(arg_21_1, arg_21_2)
	self.templates = {}

	for iter_21_0, iter_21_1 in ipairs(pg.re_map_template.all) do
		table.insert(self.templates, pg.re_map_template[iter_21_1])
	end

	self.onSelectMap = arg_21_1

	self:flush(arg_21_2)

	return
end

function LevelRemasterView:flush(arg_22_1)
	onButton(self, self._tf:Find("bg"), function()
		self:Hide()

		return
	end, SFX_CANCEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("levelScene_remaster_help_tip")
		})

		return
	end, SFX_PANEL)
	self:updateTicketDisplay()

	local var_22_0 = {
		self.exToggle,
		self.spToggle
	}
	local var_22_1 = getProxy(ChapterProxy)

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		onToggle(self, iter_22_1, function(arg_25_0)
			if arg_25_0 then
				self.temp = underscore.filter(self.templates, function(arg_26_0)
					return BossRushChapterRemasterHelper.GetExOrSp4Filter(arg_26_0.activity_type) == iter_22_0
				end)

				local var_25_0 = {}

				for iter_25_0, iter_25_1 in ipairs(self.temp) do
					var_25_0[iter_25_1.id] = BossRushChapterRemasterHelper.ExistCanGetAward(iter_25_1.id) and 0 or 1
				end

				table.sort(self.temp, CompareFuncs({
					function(arg_27_0)
						return var_25_0[arg_27_0.id] or 1
					end,
					function(arg_28_0)
						return arg_28_0.order
					end
				}))
				self.itemList:align(math.max(math.ceil(#self.temp / 2) * 2, 4))
			end

			return
		end, SFX_PANEL)
	end

	triggerToggle(var_22_0[arg_22_1 and 2 or 1], true)

	return
end

function LevelRemasterView:MatchType(arg_29_1, arg_29_2)
	return arg_29_1 == arg_29_2
end

function LevelRemasterView:flushOnly()
	self.itemList:align(math.max(math.ceil(#self.temp / 2) * 2, 4))

	return
end

function LevelRemasterView:updateTicketDisplay()
	local var_31_0 = getProxy(ChapterProxy)
	local var_31_1 = var_31_0.remasterDailyCount > 0

	SetActive(self.getRemasterTF, not (var_31_0.remasterDailyCount > 0))
	SetActive(self.gotRemasterTF, var_31_1)
	setText(self.numsTxt, var_31_0.remasterTickets .. "/" .. pg.gameset.reactivity_ticket_max.key_value)

	return
end

return LevelRemasterView
