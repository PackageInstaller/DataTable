local var_0_0 = class("LevelRemasterView", import("..base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "LevelRemasterView"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.content = arg_2_0._tf:Find("list/content")
	arg_2_0.item = arg_2_0.content:Find("item")
	arg_2_0.numsTxt = arg_2_0._tf:Find("nums/text")
	arg_2_0.helpBtn = arg_2_0._tf:Find("help")

	setActive(arg_2_0.item, false)

	arg_2_0.getRemasterTF = arg_2_0._tf:Find("getBtn/state_before")
	arg_2_0.gotRemasterTF = arg_2_0._tf:Find("getBtn/state_after")
	arg_2_0.exToggle = arg_2_0._tf:Find("toggles/EX")
	arg_2_0.spToggle = arg_2_0._tf:Find("toggles/SP")

	arg_2_0:bind(LevelUIConst.FLUSH_REMASTER_INFO, function(arg_3_0)
		if not arg_2_0:isShowing() then
			return
		end

		arg_2_0:flushOnly()

		return
	end)
	arg_2_0:bind(LevelUIConst.FLUSH_REMASTER_TICKET, function(arg_4_0)
		if not arg_2_0:isShowing() then
			return
		end

		arg_2_0:updateTicketDisplay()

		return
	end)

	local var_2_0 = getProxy(ChapterProxy)
	local var_2_1 = pg.TimeMgr.GetInstance()

	arg_2_0.itemList = UIItemList.New(arg_2_0.content, arg_2_0.item)

	arg_2_0.itemList:make(function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1

		if arg_5_0 == UIItemList.EventUpdate then
			local var_5_0 = arg_2_0.temp[arg_5_1]

			setActive(arg_5_2:Find("right"), arg_5_1 % 2 > 0)

			local var_5_1 = arg_5_2:Find("bg/icon")
			local var_5_2 = arg_5_2:Find("bg/lock")
			local var_5_3 = arg_5_2:Find("bg/wait")
			local var_5_4 = arg_5_2:Find("bg/tip")

			setActive(var_5_1, false)
			setActive(var_5_2, false)
			setActive(var_5_3, false)
			setActive(var_5_4, false)

			local var_5_5 = var_5_1:Find("info")
			local var_5_7 = var_5_5:Find("dec1/index")

			if not var_5_0 then
				setActive(var_5_3, true)
				onButton(arg_2_0, var_5_3, function()
					pg.TipsMgr.GetInstance():ShowTips(i18n("levelScene_remaster_do_not_open"))

					return
				end, SFX_PANEL)

				goto label_5_1
			end

			if not var_2_1:inTime(var_5_0.time) then
				setActive(var_5_2, true)
				onButton(arg_2_0, var_5_2, function()
					pg.TipsMgr.GetInstance():ShowTips(i18n("levelScene_remaster_do_not_open"))

					return
				end, SFX_PANEL)

				goto label_5_1
			end

			setActive(var_5_1, true)
			GetImageSpriteFromAtlasAsync("activitybanner/" .. var_5_0.bg, "", var_5_1)

			::label_5_1::

			if arg_5_1 < 10 then
				do
					local var_5_8 = "0" .. arg_5_1 or arg_5_1

					var_5_6(var_5_7, var_5_8)
					setText(var_5_5:Find("progress/Text"), BossRushChapterRemasterHelper.GetProgress(var_5_0.id) .. "%")
					onButton(arg_2_0, var_5_1, function()
						if BossRushChapterRemasterHelper.IsRemasterByActivity(var_5_0.id) then
							arg_2_0:HandleActTypeRemaster(var_5_0)

							return
						end

						local var_8_0 = (function()
							for iter_9_0, iter_9_1 in ipairs({
								PlayerPrefs.GetInt("remaster_lastmap_" .. var_5_0.id, pg.chapter_template[var_5_0.config_data[1]].map),
								pg.chapter_template[var_5_0.config_data[1]].map
							}) do
								local var_9_0 = var_2_0:getMapById(iter_9_1)

								if var_9_0:isUnlock() then
									return iter_9_1
								end
							end

							return
						end)()

						if var_8_0 then
							arg_2_0.onSelectMap(var_8_0)
							arg_2_0:Hide()
						end

						return
					end, SFX_PANEL)

					local var_5_9 = BossRushChapterRemasterHelper.ChapterAwardInfo(var_5_0.id)
					local var_5_10 = underscore.rest(var_5_0.drop_display, 1)

					if var_5_9 then
						table.insert(var_5_10, 1, var_5_9)
					elseif #var_5_0.drop_display_sp > 0 then
						var_5_10 = table.mergeArray(var_5_0.drop_display_sp, var_5_10)
					end

					local var_5_11 = var_5_5:Find("content")

					eachChild(var_5_11, function(arg_10_0)
						setActive(arg_10_0, false)

						return
					end)

					for iter_5_0, iter_5_1 in ipairs(var_5_10) do
						local var_5_12 = iter_5_0 > var_5_11.childCount and cloneTplTo(var_5_11:GetChild(0), var_5_11) or var_5_11:GetChild(iter_5_0 - 1)

						setActive(var_5_12, true)

						local var_5_20

						if var_5_9 and iter_5_0 == 1 then
							local var_5_13 = var_5_9[1]
							local var_5_14, var_5_15, var_5_16, var_5_17, var_5_18 = unpack(var_5_9[2])
							local var_5_19 = var_2_0:getRemasterInfo(var_5_9[3], var_5_14, var_5_9[1])

							setActive(var_5_4, var_5_17 <= var_5_19.count)
							setActive(var_5_12:Find("mark"), var_5_17 > var_5_19.count)
							setActive(var_5_12:Find("Slider"), var_5_17 > var_5_19.count)
							setActive(var_5_12:Find("achieve"), var_5_17 <= var_5_19.count)
							setSlider(var_5_12:Find("Slider"), 0, var_5_17, var_5_19.count)
							updateDrop(var_5_12:Find("IconTpl"), {
								type = var_5_15,
								id = var_5_16
							})
							onButton(arg_2_0, var_5_12:Find("IconTpl"), function()
								pg.MsgboxMgr.GetInstance():ShowMsgBox({
									hideYes = true,
									hideNo = true,
									type = MSGBOX_TYPE_SINGLE_ITEM,
									drop = var_0,
									remaster = {
										word = i18n("level_remaster_tip4", (BossRushChapterRemasterHelper.GetAwardName(var_0, var_5_14))),
										number = var_5_19.count .. "/" .. var_5_17,
										btn_text = i18n(var_5_19.count < var_5_17 and "level_remaster_tip2" or "level_remaster_tip3"),
										btn_call = function()
											if var_5_19.count < var_5_17 then
												if var_0 and var_0 > 0 then
													arg_2_0:emit(LevelMediator2.ON_BOSSRUSH_REMASTER_ACTIVITY, var_0)
													arg_2_0:Hide()

													return
												end

												local var_12_0 = pg.chapter_template[var_5_14].map
												local var_12_1, var_12_2 = var_2_0:getMapById(pg.chapter_template[var_5_14].map):isUnlock()

												if not var_12_1 then
													pg.TipsMgr.GetInstance():ShowTips(var_12_2)
												else
													arg_2_0.onSelectMap(var_12_0)
													arg_2_0:Hide()
												end
											else
												arg_2_0:emit(LevelMediator2.ON_CHAPTER_REMASTER_AWARD, var_5_14, var_5_13, var_0)
											end

											return
										end
									}
								})

								return
							end, SFX_PANEL)

							goto label_5_0

							var_5_20 = var_5_12:Find("IconTpl")
						end

						updateDrop(var_5_20, {
							type = iter_5_1[1][1],
							id = iter_5_1[1][2]
						})
						onButton(arg_2_0, var_5_12:Find("IconTpl"), function()
							pg.MsgboxMgr.GetInstance():ShowMsgBox({
								hideYes = true,
								hideNo = true,
								type = MSGBOX_TYPE_SINGLE_ITEM,
								drop = var_0,
								remaster = {
									word = i18n("level_remaster_tip1") .. iter_5_1[2],
									btn_text = i18n("text_confirm")
								}
							})

							return
						end, SFX_PANEL)
						setActive(var_5_12:Find("mark"), false)
						setActive(var_5_12:Find("Slider"), false)
						setActive(var_5_12:Find("achieve"), false)

						::label_5_0::
					end
				end

				return
			end
		end
	end)
	onButton(arg_2_0, arg_2_0.getRemasterTF, function()
		if var_2_0.remasterTickets + pg.gameset.reactivity_ticket_daily.key_value > pg.gameset.reactivity_ticket_max.key_value then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("tack_tickets_max_warning", math.max(pg.gameset.reactivity_ticket_max.key_value - var_2_0.remasterTickets, 0)),
				onYes = function()
					arg_2_0:emit(LevelMediator2.ON_CLICK_RECEIVE_REMASTER_TICKETS_BTN)

					return
				end
			})

			return
		end

		arg_2_0:emit(LevelMediator2.ON_CLICK_RECEIVE_REMASTER_TICKETS_BTN)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.HandleActTypeRemaster(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.activity_id
	local var_16_1 = getProxy(ActivityPermanentProxy)
	local var_16_2 = var_16_1:GetActivityTypeById(arg_16_1.activity_id)
	local var_16_3 = var_16_2 and var_16_1:getDoingActivityId(var_16_2)

	local function var_16_4()
		arg_16_0:emit(LevelMediator2.ON_BOSSRUSH_REMASTER_ACTIVITY, var_16_0)

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

function var_0_0.OnDestroy(arg_18_0)
	arg_18_0.onItem = nil

	if arg_18_0:isShowing() then
		arg_18_0:Hide()
	end

	return
end

function var_0_0.Show(arg_19_0)
	var_0_0.super.Show(arg_19_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_19_0._tf)

	return
end

function var_0_0.Hide(arg_20_0)
	var_0_0.super.Hide(arg_20_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_20_0._tf, arg_20_0._parentTf)

	return
end

function var_0_0.set(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0.templates = {}

	for iter_21_0, iter_21_1 in ipairs(pg.re_map_template.all) do
		table.insert(arg_21_0.templates, pg.re_map_template[iter_21_1])
	end

	arg_21_0.onSelectMap = arg_21_1

	arg_21_0:flush(arg_21_2)

	return
end

function var_0_0.flush(arg_22_0, arg_22_1)
	onButton(arg_22_0, arg_22_0._tf:Find("bg"), function()
		arg_22_0:Hide()

		return
	end, SFX_CANCEL)
	onButton(arg_22_0, arg_22_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("levelScene_remaster_help_tip")
		})

		return
	end, SFX_PANEL)
	arg_22_0:updateTicketDisplay()

	local var_22_0 = {
		arg_22_0.exToggle,
		arg_22_0.spToggle
	}
	local var_22_1 = getProxy(ChapterProxy)

	for iter_22_0, iter_22_1 in ipairs({
		arg_22_0.exToggle,
		arg_22_0.spToggle
	}) do
		onToggle(arg_22_0, iter_22_1, function(arg_25_0)
			if arg_25_0 then
				arg_22_0.temp = underscore.filter(arg_22_0.templates, function(arg_26_0)
					return BossRushChapterRemasterHelper.GetExOrSp4Filter(arg_26_0.activity_type) == iter_22_0
				end)

				local var_25_0 = {}

				for iter_25_0, iter_25_1 in ipairs(arg_22_0.temp) do
					var_25_0[iter_25_1.id] = BossRushChapterRemasterHelper.ExistCanGetAward(iter_25_1.id) and 0 or 1
				end

				table.sort(arg_22_0.temp, CompareFuncs({
					function(arg_27_0)
						return var_25_0[arg_27_0.id] or 1
					end,
					function(arg_28_0)
						return arg_28_0.order
					end
				}))
				arg_22_0.itemList:align(math.max(math.ceil(#arg_22_0.temp / 2) * 2, 4))
			end

			return
		end, SFX_PANEL)
	end

	triggerToggle(var_22_0[arg_22_1 and 2 or 1], true)

	return
end

function var_0_0.MatchType(arg_29_0, arg_29_1, arg_29_2)
	return arg_29_1 == arg_29_2
end

function var_0_0.flushOnly(arg_30_0)
	arg_30_0.itemList:align(math.max(math.ceil(#arg_30_0.temp / 2) * 2, 4))

	return
end

function var_0_0.updateTicketDisplay(arg_31_0)
	local var_31_0 = getProxy(ChapterProxy)
	local var_31_1 = var_31_0.remasterDailyCount > 0

	SetActive(arg_31_0.getRemasterTF, not (var_31_0.remasterDailyCount > 0))
	SetActive(arg_31_0.gotRemasterTF, var_31_1)
	setText(arg_31_0.numsTxt, var_31_0.remasterTickets .. "/" .. pg.gameset.reactivity_ticket_max.key_value)

	return
end

return var_0_0
