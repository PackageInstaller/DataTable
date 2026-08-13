class = var_0_10000

local var_0_0 = "GuildMainMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.OPEN_MEMBER = "GuildMainMediator:OPEN_MEMBER"
var_0_1.CLOSE_MEMBER = "GuildMainMediator:CLOSE_MEMBER"
var_0_1.OPEN_APPLY = "GuildMainMediator:OPEN_APPLY"
var_0_1.CLOSE_APPLY = "GuildMainMediator:CLOSE_APPLY"
var_0_1.MODIFY = "GuildMainMediator:MODIFY"
var_0_1.DISSOLVE = "GuildMainMediator:DISSOLVE"
var_0_1.QUIT = "GuildMainMediator:QUIT"
var_0_1.ON_BACK = "GuildMainMediator:ON_BACK"
var_0_1.REBUILD_ALL = "GuildMainMediator:REBUILD_ALL"
var_0_1.ON_REBUILD_LOG_ALL = "GuildMainMediator:ON_REBUILD_LOG_ALL"
var_0_1.SEND_MSG = "GuildMainMediator:SEND_MSG"
var_0_1.OPEN_EMOJI = "GuildMainMediator:OPEN_EMOJI"
var_0_1.OPEN_OFFICE = "GuildMainMediator:OPEN_OFFICE"
var_0_1.OPEN_TECH = "GuildMainMediator:OPEN_TECH"
var_0_1.OPEN_BATTLE = "GuildMainMediator:OPEN_BATTLE"
var_0_1.CLOSE_OFFICE = "GuildMainMediator:CLOSE_OFFICE"
var_0_1.CLOSE_TECH = "GuildMainMediator:CLOSE_TECH"
var_0_1.CLOSE_BATTLE = "GuildMainMediator:CLOSE_BATTLE"
var_0_1.ON_FETCH_CAPITAL = "GuildOfficeMediator:ON_FETCH_CAPITAL"
var_0_1.ON_FETCH_CAPITAL_LOG = "GuildOfficeMediator:ON_FETCH_CAPITAL_LOG"
var_0_1.OPEN_EVENT_REPORT = "GuildOfficeMediator:OPEN_EVENT_REPORT"
var_0_1.OPEN_EVENT = "GuildOfficeMediator:OPEN_EVENT"
var_0_1.OPEN_MAIN = "GuildOfficeMediator:OPEN_MAIN"
var_0_1.SWITCH_TO_OFFICE = "GuildOfficeMediator:SWITCH_TO_OFFICE"
var_0_1.OPEN_SHOP = "GuildMainMediator:OPEN_SHOP"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	ContextProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)
	local var_1_1 = var_1.GetPrevContext(var_1_0, 1).mediator

	NewGuildMediator = var_1_0

	local var_1_2

	if var_1_1 == var_1_0 then
		var_1_2 = var_1

		var_1.RemoveContext(var_1_2, var_2)
	end

	getProxy = var_1_1
	GuildProxy = var_1_2

	local var_1_3 = var_1_1(var_1_2)
	local var_1_4 = var_3.getData(var_1_3)
	local var_1_5 = arg_1_0.viewComponent

	var_5.setGuildVO(var_1_5, var_1_4)

	local var_1_6 = var_3:getChatMsgs()
	local var_1_7 = arg_1_0.viewComponent

	var_6.setChatMsgs(var_1_7, var_1_6)
	arg_1_0:bind(var_0_1.OPEN_SHOP, function()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_2_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		local var_2_3 = var_2_10004.SHOP
		local var_2_4 = {}

		NewShopsScene = var_2_10006
		var_2_4.warp = var_2_10006.TYPE_GUILD

		var_2_1(var_2_0, var_2_2, var_2_3, var_2_4)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_MAIN, function()
		local var_3_0 = arg_1_0
		local var_3_1 = var_0.closePage

		GuildEventReportMediator = var_2_10003

		var_3_1(var_3_0, var_2_10003)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_EVENT, function(arg_4_0)
		local var_4_0 = arg_1_0.viewComponent
		local var_4_1 = var_1.openPage

		GuildMainScene = var_2_10004

		var_4_1(var_4_0, var_2_10004.TOGGLE_TAG[6])

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_EVENT_REPORT, function(arg_5_0)
		local var_5_0 = arg_1_0
		local var_5_1 = var_1.sendNotification

		GAME = var_2_10004

		var_5_1(var_5_0, var_2_10004.GUILD_OPEN_EVENT_REPORT)

		return
	end)

	local var_1_8 = arg_1_0

	arg_1_0.bind(var_1_8, var_0_1.ON_FETCH_CAPITAL, function(arg_6_0)
		local var_6_0 = arg_1_0
		local var_6_1 = var_1.sendNotification

		GAME = var_2_10004

		var_6_1(var_6_0, var_2_10004.GUILD_REFRESH_CAPITAL)

		return
	end)

	getProxy = var_6
	PlayerProxy = var_1_8

	local var_1_9 = var_6(var_1_8)
	local var_1_10 = var_6.getData(var_1_9)
	local var_1_11 = arg_1_0.viewComponent

	var_8.setPlayerVO(var_1_11, var_1_10)
	arg_1_0:bind(var_0_1.ON_BACK, function(arg_7_0)
		local var_7_0 = arg_1_0
		local var_7_1 = var_1.sendNotification

		GAME = var_2_10004

		var_7_1(var_7_0, var_2_10004.GO_BACK)

		return
	end)
	arg_1_0:bind(var_0_1.REBUILD_ALL, function(arg_8_0)
		getProxy = var_2_10001
		GuildProxy = var_2_10003

		local var_8_0 = var_2_10001(var_2_10003)
		local var_8_1 = var_1.getChatMsgs(var_8_0)
		local var_8_2 = arg_1_0.viewComponent

		var_3.UpdateAllChat(var_8_2, var_8_1)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_MEMBER, function()
		local var_9_0 = arg_1_0
		local var_9_1 = var_0.closePage

		GuildEventReportMediator = var_2_10003

		var_9_1(var_9_0, var_2_10003)

		local var_9_2 = arg_1_0
		local var_9_3 = var_0.addSubLayers

		Context = var_2_10003

		local var_9_4 = var_2_10003.New
		local var_9_5 = {}

		GuildMemberLayer = var_2_10006
		var_9_5.viewComponent = var_2_10006
		GuildMemberMediator = var_2_10006
		var_9_5.mediator = var_2_10006

		var_9_3(var_9_2, var_9_4(var_9_5))

		return
	end)
	arg_1_0:bind(var_0_1.CLOSE_MEMBER, function()
		local var_10_0 = arg_1_0
		local var_10_1 = var_0.closePage

		GuildMemberMediator = var_2_10003

		var_10_1(var_10_0, var_2_10003)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_APPLY, function()
		local var_11_0 = arg_1_0
		local var_11_1 = var_0.closePage

		GuildEventReportMediator = var_2_10003

		var_11_1(var_11_0, var_2_10003)

		local var_11_2 = arg_1_0
		local var_11_3 = var_0.addSubLayers

		Context = var_2_10003

		local var_11_4 = var_2_10003.New
		local var_11_5 = {}

		GuildRequestLayer = var_2_10006
		var_11_5.viewComponent = var_2_10006
		GuildRequestMediator = var_2_10006
		var_11_5.mediator = var_2_10006

		var_11_3(var_11_2, var_11_4(var_11_5))

		return
	end)
	arg_1_0:bind(var_0_1.CLOSE_APPLY, function()
		local var_12_0 = arg_1_0
		local var_12_1 = var_0.closePage

		GuildRequestMediator = var_2_10003

		var_12_1(var_12_0, var_2_10003)

		return
	end)
	arg_1_0:bind(var_0_1.MODIFY, function(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
		local var_13_0 = arg_1_0
		local var_13_1 = var_4.sendNotification

		GAME = var_2_10007

		var_13_1(var_13_0, var_2_10007.MODIFY_GUILD_INFO, {
			type = arg_13_1,
			int = arg_13_2,
			string = arg_13_3
		})

		return
	end)
	arg_1_0:bind(var_0_1.DISSOLVE, function(arg_14_0, arg_14_1)
		local var_14_0 = arg_1_0
		local var_14_1 = var_2.sendNotification

		GAME = var_2_10005

		var_14_1(var_14_0, var_2_10005.GUILD_DISSOLVE, arg_14_1)

		return
	end)
	arg_1_0:bind(var_0_1.QUIT, function(arg_15_0, arg_15_1)
		local var_15_0 = arg_1_0
		local var_15_1 = var_2.sendNotification

		GAME = var_2_10005

		var_15_1(var_15_0, var_2_10005.GUILD_QUIT, arg_15_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_REBUILD_LOG_ALL, function(arg_16_0)
		getProxy = var_2_10001
		GuildProxy = var_2_10003

		local var_16_0 = var_2_10001(var_2_10003)
		local var_16_1 = var_1.getData(var_16_0)
		local var_16_2 = var_2.getLogs(var_16_1)
		local var_16_3 = arg_1_0.viewComponent

		var_4.UpdateAllLog(var_16_3, var_16_2)

		return
	end)
	arg_1_0:bind(var_0_1.SEND_MSG, function(arg_17_0, arg_17_1)
		local var_17_0 = arg_1_0
		local var_17_1 = var_2.sendNotification

		GAME = var_2_10005

		var_17_1(var_17_0, var_2_10005.GUILD_SEND_MSG, arg_17_1)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_EMOJI, function(arg_18_0, arg_18_1, arg_18_2)
		local var_18_0 = arg_1_0
		local var_18_1 = var_3.addSubLayers

		Context = var_2_10006

		local var_18_2 = var_2_10006.New
		local var_18_3 = {}

		EmojiLayer = var_2_10009
		var_18_3.viewComponent = var_2_10009
		EmojiMediator = var_2_10009
		var_18_3.mediator = var_2_10009

		local var_18_4 = {
			pos = arg_18_1,
			callback = arg_18_2
		}
		local var_18_5 = arg_1_0.viewComponent

		var_18_4.groupName = var_10.getGroupName(var_18_5)

		function var_18_4.emojiIconCallback(arg_19_0)
			local var_19_0 = arg_1_0.viewComponent

			var_1.insertEmojiToInputText(var_19_0, arg_19_0)

			return
		end

		var_18_3.data = var_18_4

		var_18_1(var_18_0, var_18_2(var_18_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_OFFICE, function()
		local var_20_0 = arg_1_0
		local var_20_1 = var_0.closePage

		GuildEventReportMediator = var_2_10003

		var_20_1(var_20_0, var_2_10003)

		local var_20_2 = arg_1_0
		local var_20_3 = var_0.addSubLayers

		Context = var_2_10003

		local var_20_4 = var_2_10003.New
		local var_20_5 = {}

		GuildOfficeLayer = var_2_10006
		var_20_5.viewComponent = var_2_10006
		GuildOfficeMediator = var_2_10006
		var_20_5.mediator = var_2_10006

		var_20_3(var_20_2, var_20_4(var_20_5))

		return
	end)
	arg_1_0:bind(var_0_1.CLOSE_OFFICE, function()
		local var_21_0 = arg_1_0
		local var_21_1 = var_0.closePage

		GuildOfficeMediator = var_2_10003

		var_21_1(var_21_0, var_2_10003)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_TECH, function()
		local var_22_0 = arg_1_0
		local var_22_1 = var_0.closePage

		GuildEventReportMediator = var_2_10003

		var_22_1(var_22_0, var_2_10003)

		local var_22_2 = arg_1_0
		local var_22_3 = var_0.addSubLayers

		Context = var_2_10003

		local var_22_4 = var_2_10003.New
		local var_22_5 = {}

		GuildTechnologyLayer = var_2_10006
		var_22_5.viewComponent = var_2_10006
		GuildTechnologyMediator = var_2_10006
		var_22_5.mediator = var_2_10006

		var_22_3(var_22_2, var_22_4(var_22_5))

		return
	end)
	arg_1_0:bind(var_0_1.CLOSE_TECH, function()
		local var_23_0 = arg_1_0
		local var_23_1 = var_0.closePage

		GuildTechnologyMediator = var_2_10003

		var_23_1(var_23_0, var_2_10003)

		return
	end)
	arg_1_0:bind(var_0_1.ON_FETCH_CAPITAL_LOG, function(arg_24_0)
		local var_24_0 = var_0
		local var_24_1 = var_1.getData(var_24_0)

		if var_1.shouldRequestCapitalLog(var_24_1) then
			local var_24_2 = arg_1_0
			local var_24_3 = var_2.sendNotification

			GAME = var_2_10005

			var_24_3(var_24_2, var_2_10005.GUILD_FETCH_CAPITAL_LOG)
		else
			local var_24_4 = arg_1_0.viewComponent

			var_2.openResourceLog(var_24_4)
		end

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_BATTLE, function()
		local var_25_0 = arg_1_0
		local var_25_1 = var_0.closePage

		GuildEventReportMediator = var_2_10003

		var_25_1(var_25_0, var_2_10003)

		local var_25_2 = arg_1_0
		local var_25_3 = var_0.addSubLayers

		Context = var_2_10003

		local var_25_4 = var_2_10003.New
		local var_25_5 = {}

		GuildEventLayer = var_2_10006
		var_25_5.viewComponent = var_2_10006
		GuildEventMediator = var_2_10006
		var_25_5.mediator = var_2_10006

		var_25_3(var_25_2, var_25_4(var_25_5))

		return
	end)

	local var_1_12 = arg_1_0

	arg_1_0.bind(var_1_12, var_0_1.CLOSE_BATTLE, function()
		local var_26_0 = arg_1_0
		local var_26_1 = var_0.closePage

		GuildEventMediator = var_2_10003

		var_26_1(var_26_0, var_2_10003)

		return
	end)

	getProxy = var_8
	PlayerProxy = var_1_12

	local var_1_13 = var_8(var_1_12)
	local var_1_14 = var_8.getData(var_1_13)
	local var_1_15 = arg_1_0.viewComponent

	var_10.setPlayerVO(var_1_15, var_1_14)

	return
end

function var_0_1.closePage(arg_27_0, arg_27_1)
	getProxy = var_1_10002
	ContextProxy = var_1_10004

	local var_27_0 = var_1_10002(var_1_10004)

	if var_2.getContextByMediator(var_27_0, arg_27_1) then
		local var_27_1 = arg_27_0
		local var_27_2 = arg_27_0.sendNotification

		GAME = var_1_10007

		var_27_2(var_27_1, var_1_10007.REMOVE_LAYERS, {
			context = var_3
		})
	end

	return
end

function var_0_1.listNotificationInterests(arg_28_0)
	local var_28_0 = {}

	GuildProxy = var_1_10002
	var_28_0[1] = var_1_10002.GUILD_UPDATED
	GuildProxy = var_2
	var_28_0[2] = var_2.EXIT_GUILD
	GAME = var_2
	var_28_0[3] = var_2.MODIFY_GUILD_INFO_DONE
	GuildProxy = var_2
	var_28_0[4] = var_2.NEW_MSG_ADDED
	GuildProxy = var_2
	var_28_0[5] = var_2.LOG_ADDED
	GuildProxy = var_2
	var_28_0[6] = var_2.REQUEST_COUNT_UPDATED
	GuildProxy = var_2
	var_28_0[7] = var_2.REQUEST_DELETED
	GAME = var_2
	var_28_0[8] = var_2.GUILD_GET_REQUEST_LIST_DONE
	GAME = var_2
	var_28_0[9] = var_2.REMOVE_LAYERS
	PlayerProxy = var_2
	var_28_0[10] = var_2.UPDATED
	GAME = var_2
	var_28_0[11] = var_2.GUILD_FETCH_CAPITAL_LOG_DONE
	GAME = var_2
	var_28_0[12] = var_2.GUILD_COMMIT_DONATE_DONE
	GuildProxy = var_2
	var_28_0[13] = var_2.ON_DELETED_MEMBER
	GuildProxy = var_2
	var_28_0[14] = var_2.ON_ADDED_MEMBER
	GAME = var_2
	var_28_0[15] = var_2.GUILD_OPEN_EVENT_REPORT
	GuildProxy = var_2
	var_28_0[16] = var_2.BATTLE_BTN_FLAG_CHANGE
	GAME = var_2
	var_28_0[17] = var_2.BEGIN_STAGE_DONE
	GAME = var_2
	var_28_0[18] = var_2.SUBMIT_GUILD_REPORT_DONE
	GuildTechnologyMediator = var_2
	var_28_0[19] = var_2.ON_OPEN_OFFICE
	GAME = var_2
	var_28_0[20] = var_2.OPEN_MSGBOX_DONE
	GuildProxy = var_2
	var_28_0[21] = var_2.TECHNOLOGY_START
	GAME = var_2
	var_28_0[22] = var_2.GO_WORLD_BOSS_SCENE
	GAME = var_2
	var_28_0[23] = var_2.GUILD_START_TECH_DONE
	GuildMainMediator = var_2
	var_28_0[24] = var_2.SWITCH_TO_OFFICE
	GAME = var_2
	var_28_0[25] = var_2.ON_GUILD_JOIN_EVENT_DONE
	GAME = var_2
	var_28_0[26] = var_2.GUILD_JOIN_MISSION_DONE
	GAME = var_2
	var_28_0[27] = var_2.GUILD_GET_SUPPLY_AWARD_DONE
	GAME = var_2
	var_28_0[28] = var_2.LOAD_LAYERS
	GAME = var_2
	var_28_0[29] = var_2.REMOVE_LAYERS

	return var_28_0
end

function var_0_1.handleNotification(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_1
	local var_29_1 = arg_29_1.getName(var_29_0)
	local var_29_2 = arg_29_1
	local var_29_3 = arg_29_1.getBody(var_29_2)

	GuildProxy = var_29_0

	if var_29_1 == var_29_0.GUILD_UPDATED then
		var_1_10006 = arg_29_0.viewComponent

		var_4.setGuildVO(var_1_10006, var_29_3)

		goto label_29_0
	end

	GuildProxy = var_4

	if var_29_1 == var_4.EXIT_GUILD then
		var_1_10006 = arg_29_0.viewComponent

		var_4.emit(var_1_10006, var_0_1.ON_BACK)

		goto label_29_0
	end

	GAME = var_4

	if var_29_1 == var_4.MODIFY_GUILD_INFO_DONE then
		var_1_10006 = arg_29_0.viewComponent

		var_4.initTheme(var_1_10006)

		goto label_29_0
	end

	GuildProxy = var_4

	if var_29_1 == var_4.NEW_MSG_ADDED then
		var_1_10006 = arg_29_0.viewComponent

		var_4.Append(var_1_10006, var_29_3, -1)

		goto label_29_0
	end

	GuildProxy = var_4

	if var_29_1 == var_4.LOG_ADDED then
		var_1_10006 = arg_29_0.viewComponent

		var_4.AppendLog(var_1_10006, var_29_3, true)

		goto label_29_0
	end

	GuildProxy = var_4

	if var_29_1 ~= var_4.REQUEST_COUNT_UPDATED then
		GuildProxy = var_29_4

		if var_29_1 ~= var_29_4.REQUEST_DELETED then
			GAME = var_29_4

			local var_29_4

			if var_29_1 == var_29_4.GUILD_GET_REQUEST_LIST_DONE then
				getProxy = var_29_4
				GuildProxy = var_1_10006
				var_29_4 = var_29_4(var_1_10006)
				var_1_10007 = arg_29_0.viewComponent
				var_29_2 = var_29_2.UpdateNotices
				GuildMainScene = var_1_10008

				var_29_2(var_1_10007, var_1_10008.NOTIFY_TYPE_APPLY)

				goto label_29_0
			end

			GAME = var_29_4

			if var_29_1 == var_29_4.GUILD_FETCH_CAPITAL_LOG_DONE then
				var_1_10006 = arg_29_0.viewComponent

				var_4.openResourceLog(var_1_10006)

				goto label_29_0
			end

			PlayerProxy = var_4

			if var_29_1 == var_4.UPDATED then
				var_1_10006 = arg_29_0.viewComponent

				var_4.setPlayerVO(var_1_10006, var_29_3)

				var_1_10006 = arg_29_0.viewComponent

				var_4.UpdateRes(var_1_10006)

				goto label_29_0
			end

			GAME = var_4

			if var_29_1 ~= var_4.GUILD_COMMIT_DONATE_DONE then
				GAME = var_29_5

				local var_29_5

				if var_29_1 == var_29_5.GUILD_GET_SUPPLY_AWARD_DONE then
					var_1_10006 = arg_29_0.viewComponent
					var_29_5 = var_29_5.UpdateNotices
					GuildMainScene = var_1_10007

					var_29_5(var_1_10006, var_1_10007.NOTIFY_TYPE_OFFICE)

					goto label_29_0
				end

				GuildProxy = var_29_5

				if var_29_5.ON_DELETED_MEMBER == var_29_1 then
					var_1_10006 = arg_29_0.viewComponent

					var_4.OnDeleteMember(var_1_10006, var_29_3.member)

					goto label_29_0
				end

				GuildProxy = var_4

				if var_4.ON_ADDED_MEMBER == var_29_1 then
					var_1_10006 = arg_29_0.viewComponent

					var_4.OnAddMember(var_1_10006, var_29_3.member)

					goto label_29_0
				end

				GAME = var_4

				local var_29_6

				if var_29_1 == var_4.GUILD_OPEN_EVENT_REPORT then
					var_1_10006 = arg_29_0
					var_29_6 = arg_29_0.addSubLayers
					Context = var_1_10007
					var_1_10007 = var_1_10007.New

					local var_29_7 = {}

					GuildEventReportLayer = var_1_10010
					var_29_7.viewComponent = var_1_10010
					GuildEventReportMediator = var_1_10010
					var_29_7.mediator = var_1_10010

					var_29_6(var_1_10006, var_1_10007(var_29_7))

					goto label_29_0
				end

				GAME = var_29_6

				local var_29_8

				if var_29_1 == var_29_6.SUBMIT_GUILD_REPORT_DONE then
					var_1_10006 = arg_29_0.viewComponent
					var_29_8 = var_29_8.emit
					BaseUI = var_1_10007

					var_29_8(var_1_10006, var_1_10007.ON_ACHIEVE, var_29_3.awards, var_29_3.callback)

					var_1_10006 = arg_29_0.viewComponent

					var_29_8.OnReportUpdated(var_1_10006)

					var_1_10006 = arg_29_0.viewComponent
					var_29_8 = var_29_8.UpdateNotices
					GuildMainScene = var_1_10007

					var_29_8(var_1_10006, var_1_10007.NOTIFY_TYPE_BATTLE)

					var_1_10006 = arg_29_0.viewComponent
					var_29_8 = var_29_8.UpdateNotices
					GuildMainScene = var_1_10007

					var_29_8(var_1_10006, var_1_10007.NOTIFY_TYPE_MAIN)

					goto label_29_0
				end

				GuildProxy = var_29_8

				if var_29_1 ~= var_29_8.BATTLE_BTN_FLAG_CHANGE then
					GAME = var_29_9

					if var_29_1 ~= var_29_9.ON_GUILD_JOIN_EVENT_DONE then
						GAME = var_29_9

						if var_29_1 ~= var_29_9.GUILD_ACTIVE_EVENT_DONE then
							GAME = var_29_9

							do
								local var_29_9

								if var_29_1 == var_29_9.GUILD_JOIN_MISSION_DONE then
									var_1_10006 = arg_29_0.viewComponent
									var_29_9 = var_29_9.UpdateNotices
									GuildMainScene = var_1_10007

									var_29_9(var_1_10006, var_1_10007.NOTIFY_TYPE_BATTLE)
								else
									GAME = var_29_9

									local var_29_10

									if var_29_1 == var_29_9.BEGIN_STAGE_DONE then
										var_1_10006 = arg_29_0
										var_29_10 = arg_29_0.sendNotification
										GAME = var_1_10007
										var_1_10007 = var_1_10007.GO_SCENE
										SCENE = var_1_10008

										var_29_10(var_1_10006, var_1_10007, var_1_10008.COMBATLOAD, var_29_3)
									else
										GuildTechnologyMediator = var_29_10

										local var_29_11

										if var_29_1 == var_29_10.ON_OPEN_OFFICE then
											var_29_11 = arg_29_0.contextData.toggles
											GuildMainScene = var_29_2
											var_29_11 = var_29_11[var_29_2.TOGGLE_TAG[4]]
											triggerToggle = var_29_2

											var_29_2(var_29_11, true)
										else
											GAME = var_29_11

											if var_29_1 == var_29_11.OPEN_MSGBOX_DONE then
												pg = var_4
												var_1_10006 = var_4.GuildLayerMgr.GetInstance()

												var_4.OnShowMsgBox(var_1_10006)
											else
												GuildProxy = var_4

												local var_29_12

												if var_29_1 == var_4.TECHNOLOGY_START then
													var_1_10006 = arg_29_0.viewComponent
													var_29_12 = var_29_12.UpdateNotices
													GuildMainScene = var_1_10007

													var_29_12(var_1_10006, var_1_10007.NOTIFY_TYPE_TECH)
												else
													GAME = var_29_12

													local var_29_14

													if var_29_1 == var_29_12.GUILD_START_TECH_DONE then
														getProxy = var_29_14
														PlayerProxy = var_1_10006

														local var_29_13 = var_29_14(var_1_10006)

														var_29_14 = var_29_14.getData(var_29_13)

														local var_29_15 = arg_29_0.viewComponent

														var_29_2.setPlayerVO(var_29_15, var_29_14)

														local var_29_16 = arg_29_0.viewComponent

														var_29_2.UpdateRes(var_29_16)
													else
														GAME = var_29_14

														local var_29_17

														if var_29_1 == var_29_14.GO_WORLD_BOSS_SCENE then
															var_29_17 = arg_29_0.contextData
															var_29_17.page = nil
														else
															GuildMainMediator = var_29_17

															if var_29_1 == var_29_17.SWITCH_TO_OFFICE then
																local var_29_18 = arg_29_0.viewComponent

																var_4.TriggerOfficePage(var_29_18)
															else
																GAME = var_4

																local var_29_19

																if var_29_1 == var_4.LOAD_LAYERS then
																	var_29_19 = var_29_3.context.mediator
																	AwardInfoMediator = var_29_2

																	if var_29_19 == var_29_2 then
																		pg = var_29_19

																		local var_29_20 = var_29_19.GuildLayerMgr.GetInstance()

																		var_29_19.UnBlurTopPanel(var_29_20)
																	end
																else
																	GAME = var_29_19

																	if var_29_1 == var_29_19.REMOVE_LAYERS then
																		local var_29_21 = var_29_3.context.mediator

																		AwardInfoMediator = var_29_2

																		if var_29_21 == var_29_2 then
																			pg = var_29_21

																			local var_29_22 = var_29_21.GuildLayerMgr.GetInstance()

																			var_4._BlurTopPanel(var_29_22)
																		end
																	end
																end
															end
														end
													end
												end
											end
										end
									end
								end
							end

							::label_29_0::

							return
						end
					end
				end
			end
		end
	end
end

return var_0_1
