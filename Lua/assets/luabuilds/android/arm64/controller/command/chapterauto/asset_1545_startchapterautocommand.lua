local StartChapterAutoCommand = class("StartChapterAutoCommand", pm.SimpleCommand)

function StartChapterAutoCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.type
	local var_1_2 = var_1_0.id
	local var_1_3 = var_1_0.ticketNum
	local var_1_4 = getProxy(ChapterProxy):getRemasterTicketCost()

	if BeginStageCommand.DockOverload() then
		return
	end

	local var_1_5 = getProxy(ChapterAutoProxy)
	local var_1_6 = var_1_5:GetRemainTime()

	if var_1_6 <= 0 or var_1_6 <= var_1_5:GetRecord(var_1_0.type, var_1_0.id) * (var_1_0.num - 1) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("auto_battle_not_enough_time"))

		return
	end

	if var_1_0.ticketNum > var_1_5:GetValidTicketCntByType(ChapterAutoTicket.TYPE.MAIN) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("auto_battle_not_enough_resource"))

		return
	end

	local var_1_7 = ChapterAutoCommission.GetOnceOil(var_1_0.type, var_1_0.id) * var_1_0.ticketNum
	local var_1_8 = math.max(0, var_1_7 - var_1_5:GetOil())

	if var_1_8 > getProxy(PlayerProxy):getRawData().oil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("auto_battle_not_enough_resource"))

		return
	end

	local var_1_9 = false
	local var_1_10 = getProxy(ChapterProxy)

	if var_1_0.type == ChapterAutoProxy.TYPE.SLG then
		if var_1_10:getMapById(var_1_10:getChapterById(var_1_0.id, true):getConfig("map")):isRemaster() then
			var_1_9 = true
		end
	end

	if var_1_9 and var_1_10.remasterTickets < var_1_0.ticketNum * var_1_4 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("levelScene_remaster_tickets_not_enough"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(13012, {
		type = var_1_0.type,
		id = var_1_0.id,
		num = var_1_0.num,
		ticket_num = var_1_0.ticketNum
	}, 13013, function(arg_2_0)
		if arg_2_0.result == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("auto_battle_start_tips"))

			local var_2_0 = getProxy(ChapterAutoProxy)

			var_2_0:SetCommissionList(arg_2_0.chapter_auto_battle_list)
			var_2_0:AddCostTime((underscore.reduce(arg_2_0.chapter_auto_battle_list, 0, function(arg_3_0, arg_3_1)
				return arg_3_0 + arg_3_1.seconds
			end)))
			var_2_0:ReduceTicketByType(ChapterAutoTicket.TYPE.MAIN, var_1_3)

			if var_1_8 > 0 then
				local var_2_1 = getProxy(PlayerProxy)
				local var_2_2 = var_2_1:getData()

				var_2_2:consume({
					oil = var_1_8
				})
				var_2_1:updatePlayer(var_2_2)
			end

			var_2_0:ReduceOil(var_1_7 - var_1_8)

			if var_1_9 then
				local var_2_3 = getProxy(ChapterProxy)

				var_2_3.remasterTickets = var_2_3.remasterTickets - var_1_3 * var_1_4
			end

			self:sendNotification(GAME.START_CHAPTER_AUTO_DONE, {
				isRemaster = var_1_9,
				type = var_1_1,
				id = var_1_2
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("chapter_auto_start_fail", arg_2_0.result))
		end

		return
	end)

	return
end

function StartChapterAutoCommand.CheckOccupied()
	if #getProxy(ChapterAutoProxy):GetCommissionList() > 0 then
		local var_4_0 = getProxy(ChapterProxy)
		local var_4_1 = var_4_0:GetAutoChapterId()

		if var_4_1 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("auto_drop_is_activation", var_4_0:getChapterById(var_4_1):getConfig("name")),
				onYes = function()
					local var_5_0 = var_4_0:getActiveChapter()

					pg.m02:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, {
						chapterId = var_5_0 and var_5_0.id,
						mapIdx = var_5_0 and var_5_0:getConfig("map")
					})

					return
				end,
				yesText = i18n("auto_drop_is_activation_go"),
				noText = i18n("auto_drop_is_activation_cancle")
			})
		end

		return true
	end

	return false
end

return StartChapterAutoCommand
