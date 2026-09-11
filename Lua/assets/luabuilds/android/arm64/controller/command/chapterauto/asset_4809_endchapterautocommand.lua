local EndChapterAutoCommand = class("EndChapterAutoCommand", pm.SimpleCommand)

function EndChapterAutoCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(ChapterAutoProxy)
	local var_1_2 = var_1_1:GetCommissionList()
	local var_1_3, var_1_4 = var_1_1:GetFinishedCnt()
	local var_1_5 = #var_1_2 - var_1_3
	local var_1_6 = underscore.reduce(var_1_2, 0, function(arg_2_0, arg_2_1)
		return arg_2_0 + (arg_2_1:UsedTicket() and 1 or 0)
	end) - var_1_4
	local var_1_7 = var_1_2[1].type
	local var_1_8 = var_1_2[1].id
	local var_1_9 = {}

	if #var_1_2 - var_1_3 > 0 then
		table.insert(var_1_9, function(arg_3_0)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("auto_battle_ing_stop_tips"),
				onYes = arg_3_0
			})

			return
		end)
	end

	if underscore.any(var_1_2, function(arg_4_0)
		local var_4_0

		if not arg_4_0:IsFinished() then
			var_4_0 = arg_4_0:UsedTicket()

			if var_4_0 then
				var_4_0 = pg.TimeMgr.GetInstance():GetServerTime() > arg_4_0:GetTicketTime()
			end
		end

		return var_4_0
	end) then
		table.insert(var_1_9, function(arg_5_0)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("auto_battle_drop_book_expired"),
				onYes = arg_5_0
			})

			return
		end)
	end

	local var_1_10 = var_1_2[1]:GetClassExpAward() * var_1_3
	local var_1_11 = getProxy(NavalAcademyProxy)
	local var_1_12 = var_1_11:getCourse()
	local var_1_13 = var_1_11:GetClassVO():GetMaxProficiency()
	local var_1_14 = var_1_12:GetProficiency() + var_1_10

	if var_1_13 < var_1_12 then
		table.insert(var_1_9, function(arg_6_0)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("auto_battle_drop_classEXP_overflow", var_1_14 - var_1_13),
				onYes = arg_6_0
			})

			return
		end)
	end

	local var_1_15 = getProxy(BagProxy):getItemCountById(ChapterAutoCommission.EXP_BOOK_ID) + underscore.reduce(var_1_2, 0, function(arg_7_0, arg_7_1)
		return arg_7_0 + (arg_7_1:IsFinished() and arg_7_1:UsedTicket() and arg_7_1:GetExpBookAward() or 0)
	end)
	local var_1_16 = Item.getConfigData(ChapterAutoCommission.EXP_BOOK_ID).max_num

	if var_1_16 < var_1_15 then
		table.insert(var_1_9, function(arg_8_0)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("auto_battle_drop_bookEXP_overflow", var_1_15 - var_1_16),
				onYes = arg_8_0
			})

			return
		end)
	end

	seriesAsync(var_1_9, function()
		self:Send(var_1_7, var_1_8, var_1_3, var_1_4, var_1_5, var_1_6)

		return
	end)

	return
end

function EndChapterAutoCommand:Send(arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6)
	getProxy(ChapterAutoProxy):SetRecordEventFlag(true)
	pg.ConnectionMgr.GetInstance():Send(13014, {
		num = arg_10_3
	}, 13015, function(arg_11_0)
		if arg_11_0.result == 0 then
			local var_11_0 = getProxy(ChapterAutoProxy)

			var_11_0:SetRecordEventFlag(false)
			var_11_0:ClearCommissionList()
			var_11_0:ReduceCostTime(arg_11_0.seconds)
			var_11_0:AddTickets(arg_11_0.chapter_auto_ticket_list)
			var_11_0:IncreaseOil(arg_11_0.oil)

			local var_11_1 = false

			switch(arg_10_1, {
				[ChapterAutoProxy.TYPE.SLG] = function()
					local var_12_0 = getProxy(ChapterProxy)

					var_12_0:addRemasterPassCount(arg_10_2, nil, arg_10_4)

					local var_12_1 = var_12_0:getChapterById(arg_10_2, true)

					var_12_1:writeDrops(arg_11_0.drop_list)

					if arg_10_6 > 0 then
						if var_12_0:getMapById(var_12_1:getConfig("map")):isRemaster() then
							var_11_1 = true

							var_12_0:updateRemasterTicketsNum(math.min(var_12_0.remasterTickets + arg_10_6 * var_12_0:getRemasterTicketCost(), pg.gameset.reactivity_ticket_max.key_value))
						end
					end

					return
				end
			})
			getProxy(NavalAcademyProxy):AddProficiency(arg_11_0.class_exp)
			self:sendNotification(GAME.END_CHAPTER_AUTO_DONE, {
				isRemaster = false,
				type = arg_10_1,
				id = arg_10_2,
				awards = PlayerConst.addTranDrop(arg_11_0.drop_list),
				proficiency = arg_11_0.class_exp,
				finishCnt = arg_10_3,
				allCnt = arg_10_3 + arg_10_5
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("chapter_auto_end_fail", arg_11_0.result))
		end

		return
	end)

	return
end

return EndChapterAutoCommand
