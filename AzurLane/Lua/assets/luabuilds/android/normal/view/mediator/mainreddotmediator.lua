class = var_0_10000

local var_0_0 = "MainReddotMediator"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.Mediator)

function var_0_1.GetNotifyDic(arg_1_0)
	local var_1_0

	if not arg_1_0.listener then
		var_1_0 = {}

		local var_1_1 = {}

		GAME = var_1_10003
		var_1_1[1] = var_1_10003.EDUCATE_GET_ENDINGS_DONE
		AttireProxy = var_3
		var_1_1[2] = var_3.ATTIREFRAME_ADDED
		var_1_0.ATTIRE = var_1_1

		local var_1_2 = {}

		TaskProxy = var_3
		var_1_2[1] = var_3.TASK_ADDED
		TaskProxy = var_3
		var_1_2[2] = var_3.TASK_UPDATED
		TaskProxy = var_3
		var_1_2[3] = var_3.TASK_REMOVED
		TaskProxy = var_3
		var_1_2[4] = var_3.TASK_DELETE
		TaskProxy = var_3
		var_1_2[5] = var_3.WEEK_TASK_UPDATED
		TaskProxy = var_3
		var_1_2[6] = var_3.WEEK_TASKS_ADDED
		TaskProxy = var_3
		var_1_2[7] = var_3.WEEK_TASKS_DELETED
		TaskProxy = var_3
		var_1_2[8] = var_3.WEEK_TASK_RESET
		GAME = var_3
		var_1_2[9] = var_3.SUBMIT_TASK_DONE
		GAME = var_3
		var_1_2[10] = var_3.SUBMIT_ACTIVITY_TASK_DONE
		GAME = var_3
		var_1_2[11] = var_3.SUBMIT_WEEK_TASK_PROGRESS_DONE
		GAME = var_3
		var_1_2[12] = var_3.TOTAL_TASK_UPDATED
		AvatarFrameProxy = var_3
		var_1_2[13] = var_3.FRAME_TASK_UPDATED
		GAME = var_3
		var_1_2[14] = var_3.SUBMIT_WEEK_TASK_DONE
		GAME = var_3
		var_1_2[15] = var_3.BATCH_SUBMIT_WEEK_TASK_DONE
		var_1_0.TASK = var_1_2

		local var_1_3 = {}

		DormProxy = var_3
		var_1_3[1] = var_3.INIMACY_AND_MONEY_ADD
		var_1_0.COURTYARD = var_1_3

		local var_1_4 = {}

		MailProxy = var_3
		var_1_4[1] = var_3.UPDATE_ATTACHMENT_COUNT
		var_1_0.MAIL = var_1_4

		local var_1_5 = {}

		BuildShipProxy = var_3
		var_1_5[1] = var_3.TIMEUP
		BuildShipProxy = var_3
		var_1_5[2] = var_3.UPDATED
		BuildShipProxy = var_3
		var_1_5[3] = var_3.REMOVED
		GAME = var_3
		var_1_5[4] = var_3.BUILD_SHIP_IMMEDIATELY_DONE
		GAME = var_3
		var_1_5[5] = var_3.GET_SHIP_DONE
		GAME = var_3
		var_1_5[6] = var_3.CONFIRM_GET_SHIP
		var_1_0.BUILD = var_1_5

		local var_1_6 = {}

		GuildProxy = var_3
		var_1_6[1] = var_3.GUILD_UPDATED
		GuildProxy = var_3
		var_1_6[2] = var_3.REQUEST_DELETED
		GuildProxy = var_3
		var_1_6[3] = var_3.REQUEST_COUNT_UPDATED
		GuildProxy = var_3
		var_1_6[4] = var_3.WEEKLYTASK_ADDED
		GuildProxy = var_3
		var_1_6[5] = var_3.SUPPLY_STARTED
		GuildProxy = var_3
		var_1_6[6] = var_3.DONATE_UPDTAE
		GuildProxy = var_3
		var_1_6[7] = var_3.ON_DONATE_LIST_UPDATED
		GuildProxy = var_3
		var_1_6[8] = var_3.TECHNOLOGY_START
		GuildProxy = var_3
		var_1_6[9] = var_3.CAPITAL_UPDATED
		GAME = var_3
		var_1_6[10] = var_3.SUBMIT_GUILD_REPORT_DONE
		GAME = var_3
		var_1_6[11] = var_3.GUILD_GET_BOSS_INFO_DONE
		GAME = var_3
		var_1_6[12] = var_3.GUILD_REFRESH_MISSION_DONE
		GAME = var_3
		var_1_6[13] = var_3.GUILD_JOIN_MISSION_DONE
		GuildProxy = var_3
		var_1_6[14] = var_3.BATTLE_BTN_FLAG_CHANGE
		var_1_0.GUILD = var_1_6

		local var_1_7 = {}

		CollectionProxy = var_3
		var_1_7[1] = var_3.TROPHY_UPDATE
		GAME = var_3
		var_1_7[2] = var_3.CANCEL_LEARN_TACTICS_DONE
		var_1_0.SCHOOL = var_1_7

		local var_1_8 = {}

		NotificationProxy = var_3
		var_1_8[1] = var_3.FRIEND_REQUEST_ADDED
		NotificationProxy = var_3
		var_1_8[2] = var_3.FRIEND_REQUEST_REMOVED
		FriendProxy = var_3
		var_1_8[3] = var_3.FRIEND_NEW_MSG
		FriendProxy = var_3
		var_1_8[4] = var_3.FRIEND_UPDATED
		var_1_0.FRIEND = var_1_8

		local var_1_9 = {}

		PlayerProxy = var_3
		var_1_9[1] = var_3.UPDATED
		GAME = var_3
		var_1_9[2] = var_3.EVENT_LIST_UPDATE
		GAME = var_3
		var_1_9[3] = var_3.EVENT_FINISH_UPDATE
		GAME = var_3
		var_1_9[4] = var_3.CANCEL_LEARN_TACTICS_DONE
		var_1_0.COMMISSION = var_1_9

		local var_1_10 = {}

		ServerNoticeProxy = var_3
		var_1_10[1] = var_3.SERVER_NOTICES_UPDATE
		var_1_0.SERVER = var_1_10

		local var_1_11 = {}

		TechnologyConst = var_3
		var_1_11[1] = var_3.UPDATE_REDPOINT_ON_TOP
		TechnologyProxy = var_3
		var_1_11[2] = var_3.BLUEPRINT_UPDATED
		GAME = var_3
		var_1_11[3] = var_3.REMOVE_LAYERS
		var_1_0.BLUEPRINT = var_1_11

		local var_1_12 = {}

		GAME = var_3
		var_1_12[1] = var_3.EVENT_LIST_UPDATE
		GAME = var_3
		var_1_12[2] = var_3.EVENT_FINISH_UPDATE
		var_1_0.EVENT = var_1_12

		local var_1_13 = {}

		GAME = var_3
		var_1_13[1] = var_3.REMOVE_LAYERS
		var_1_0.ACT_NEWBIE = var_1_13

		local var_1_14 = {}

		GAME = var_3
		var_1_14[1] = var_3.REMOVE_LAYERS
		var_1_0.ACT_RETURN = var_1_14

		local var_1_15 = {}

		CollectionProxy = var_3
		var_1_15[1] = var_3.AWARDS_UPDATE
		CollectionProxy = var_3
		var_1_15[2] = var_3.GROUP_INFO_UPDATE
		CollectionProxy = var_3
		var_1_15[3] = var_3.GROUP_EVALUATION_UPDATE
		var_1_0.COLLECTION = var_1_15

		local var_1_16 = {}

		CommanderProxy = var_3
		var_1_16[1] = var_3.COMMANDER_UPDATED
		PlayerProxy = var_3
		var_1_16[2] = var_3.UPDATED
		var_1_0.COMMANDER = var_1_16

		local var_1_17 = {}

		LoveLetterProxy = var_3
		var_1_17[1] = var_3.UPDATE_LOVE_LETTER
		var_1_0.MEMORY_REVIEW = var_1_17

		local var_1_18 = {}

		ActivityProxy = var_3
		var_1_18[1] = var_3.ACTIVITY_ADDED
		ActivityProxy = var_3
		var_1_18[2] = var_3.ACTIVITY_UPDATED
		ActivityProxy = var_3
		var_1_18[3] = var_3.ACTIVITY_END
		var_1_0.ISLAND = var_1_18

		local var_1_19 = {}

		ActivityProxy = var_3
		var_1_19[1] = var_3.ACTIVITY_UPDATED
		ActivityProxy = var_3
		var_1_19[2] = var_3.ACTIVITY_ADDED
		var_1_0.RYZA_TASK = var_1_19

		local var_1_20 = {}

		TechnologyConst = var_3
		var_1_20[1] = var_3.UPDATE_REDPOINT_ON_TOP
		GAME = var_3
		var_1_20[2] = var_3.REMOVE_LAYERS
		var_1_0.COMMANDER_MANUAL = var_1_20

		local var_1_21 = {}

		GAME = var_3
		var_1_21[1] = var_3.REMOVE_LAYERS
		var_1_0.NEW_SERVER = var_1_21

		local var_1_22 = {}

		GAME = var_3
		var_1_22[1] = var_3.REMOVE_LAYERS
		var_1_0.SETTING = var_1_22

		local var_1_23 = {}

		GAME = var_3
		var_1_23[1] = var_3.REMOVE_LAYERS
		var_1_0.DORM3D_SHOP_TIMELIMIT = var_1_23

		local var_1_24 = {}

		GAME = var_3
		var_1_24[1] = var_3.REMOVE_LAYERS
		var_1_0.EDUCATE_NEW_CHILD = var_1_24

		local var_1_25 = {}

		GAME = var_3
		var_1_25[1] = var_3.REMOVE_LAYERS
		var_1_0.ISLAND_3D = var_1_25
	end

	arg_1_0.listener = var_1_0

	if not arg_1_0.dic then
		arg_1_0.dic = {}
		pairs = var_1

		for iter_1_0, iter_1_1 in var_1(arg_1_0.listener) do
			pairs = var_1_10006

			for iter_1_2, iter_1_3 in var_1_10006(iter_1_1) do
				local var_1_26 = arg_1_0.dic
				local var_1_27

				if not arg_1_0.dic[iter_1_3] then
					var_1_27 = {}
				end

				var_1_26[iter_1_3] = var_1_27
				table = var_1_26

				var_1_26.insert(arg_1_0.dic[iter_1_3], iter_1_0)
			end
		end
	end

	return arg_1_0.dic
end

function var_0_1.listNotificationInterests(arg_2_0)
	underscore = var_1_10001

	return var_1_10001.keys(arg_2_0:GetNotifyDic())
end

function var_0_1.handleNotification(arg_3_0, arg_3_1)
	if not arg_3_0:GetNotifyDic()[arg_3_1:getName()] then
		return
	end

	pg = var_3

	local var_3_0 = var_3.EasyRedDotMgr.GetInstance()
	local var_3_1 = var_3.TriggerMarks

	unpack = var_1_10005

	var_3_1(var_3_0, var_1_10005(var_2))

	return
end

return var_0_1
