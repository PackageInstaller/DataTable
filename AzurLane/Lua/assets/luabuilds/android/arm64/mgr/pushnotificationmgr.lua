pg = pg or {}

local var_0_0 = pg

pg.PushNotificationMgr = singletonClass("PushNotificationMgr")

local var_0_1 = pg.PushNotificationMgr

pg.PushNotificationMgr.PUSH_TYPE_EVENT = 1
pg.PushNotificationMgr.PUSH_TYPE_GOLD = 2
pg.PushNotificationMgr.PUSH_TYPE_OIL = 3
pg.PushNotificationMgr.PUSH_TYPE_BACKYARD = 4
pg.PushNotificationMgr.PUSH_TYPE_SCHOOL = 5
pg.PushNotificationMgr.PUSH_TYPE_CLASS = 6
pg.PushNotificationMgr.PUSH_TYPE_TECHNOLOGY = 7
pg.PushNotificationMgr.PUSH_TYPE_BLUEPRINT = 8
pg.PushNotificationMgr.PUSH_TYPE_COMMANDER = 9
pg.PushNotificationMgr.PUSH_TYPE_GUILD_MISSION_FORMATION = 10

local var_0_2 = {}
local var_0_3 = false

function pg.PushNotificationMgr.Init(arg_1_0)
	var_0_2 = {}

	for iter_1_0, iter_1_1 in ipairs(var_0_0.push_data_template.all) do
		var_0_2[var_0_0.push_data_template[iter_1_1].id] = PlayerPrefs.GetInt("push_setting_" .. var_0_0.push_data_template[iter_1_1].id) == 0
	end

	var_0_3 = PlayerPrefs.GetInt("setting_ship_name") == 1

	return
end

function pg.PushNotificationMgr.Reset(arg_2_0)
	var_0_2 = {}

	for iter_2_0, iter_2_1 in ipairs(var_0_0.push_data_template.all) do
		PlayerPrefs.SetInt("push_setting_" .. var_0_0.push_data_template[iter_2_1].id, 0)

		var_0_2[var_0_0.push_data_template[iter_2_1].id] = true
	end

	PlayerPrefs.SetInt("setting_ship_name", 0)

	var_0_3 = false

	return
end

function pg.PushNotificationMgr.setSwitch(arg_3_0, arg_3_1, arg_3_2)
	if not var_0_0.push_data_template[arg_3_1] then
		return
	end

	var_0_2[arg_3_1] = arg_3_2

	PlayerPrefs.SetInt("push_setting_" .. arg_3_1, arg_3_2 and 0 or 1)

	return
end

function pg.PushNotificationMgr.setSwitchShipName(arg_4_0, arg_4_1)
	var_0_3 = arg_4_1

	PlayerPrefs.SetInt("setting_ship_name", arg_4_1 and 1 or 0)

	return
end

function pg.PushNotificationMgr.isEnabled(arg_5_0, arg_5_1)
	return var_0_2[arg_5_1]
end

function pg.PushNotificationMgr.isEnableShipName(arg_6_0)
	return var_0_3
end

local var_0_4 = {}

function pg.PushNotificationMgr.Push(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_3 - var_0_0.TimeMgr.GetInstance():GetServerTime()

	arg_7_0:log(arg_7_1, arg_7_2, os.time() + var_7_0)
	table.insert(var_0_4, {
		title = arg_7_1,
		content = arg_7_2,
		offsetSecond = var_7_0
	})

	return
end

function pg.PushNotificationMgr.PushCache(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(var_0_4) do
		YSNormalTool.NotificationTool.ScheduleNotification(iter_8_0, iter_8_1.title, iter_8_1.content, iter_8_1.offsetSecond * 1000, "ys_icon_notification")
	end

	return
end

function pg.PushNotificationMgr.cancelAll(arg_9_0)
	originalPrint("取消通知")
	YSNormalTool.NotificationTool.CancelAllNotification()

	var_0_4 = {}

	return
end

function pg.PushNotificationMgr.PushAll(arg_10_0)
	local var_10_0 = getProxy(PlayerProxy)

	if var_10_0 and var_10_0:getInited() then
		if not PUSH_NOTIFICATION_TEST_TAG then
			arg_10_0:cancelAll()
		end

		if var_0_2[var_0_1.PUSH_TYPE_EVENT] then
			arg_10_0:PushEvent()
		end

		if var_0_2[var_0_1.PUSH_TYPE_GOLD] then
			arg_10_0:PushGold()
		end

		if var_0_2[var_0_1.PUSH_TYPE_OIL] then
			arg_10_0:PushOil()
		end

		if var_0_2[var_0_1.PUSH_TYPE_BACKYARD] then
			arg_10_0:PushBackyard()
		end

		if var_0_2[var_0_1.PUSH_TYPE_SCHOOL] then
			arg_10_0:PushSchool()
		end

		if var_0_2[var_0_1.PUSH_TYPE_TECHNOLOGY] then
			arg_10_0:PushTechnlogy()
		end

		if var_0_2[var_0_1.PUSH_TYPE_BLUEPRINT] then
			arg_10_0:PushBluePrint()
		end

		if var_0_2[var_0_1.PUSH_TYPE_COMMANDER] then
			arg_10_0:PushCommander()
		end

		if var_0_2[var_0_1.PUSH_TYPE_GUILD_MISSION_FORMATION] then
			arg_10_0:PushGuildMissionFormation()
		end

		arg_10_0:PushCache()
	end

	return
end

function pg.PushNotificationMgr.PushEvent(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs((getProxy(EventProxy):getActiveEvents())) do
		arg_11_0:Push(var_0_0.push_data_template[arg_11_0.PUSH_TYPE_EVENT].title, string.gsub(var_0_0.push_data_template[arg_11_0.PUSH_TYPE_EVENT].content, "$1", iter_11_1.template.title), iter_11_1.finishTime)
	end

	return
end

function pg.PushNotificationMgr.PushGold(arg_12_0)
	local var_12_9000
	local var_12_0 = getProxy(NavalAcademyProxy)
	local var_12_1 = var_12_0.GetGoldVO(var_12_9000)
	local var_12_2 = var_12_1:bindConfigTable()
	local var_12_3 = var_12_1:GetLevel()
	local var_12_5 = getProxy(PlayerProxy).data

	if var_12_5.goldField < var_12_2[var_12_0].store then
		if var_12_5.resUpdateTm + (var_12_2[var_12_0].store - var_12_5.goldField) / var_12_2[var_12_3].production * 60 * 60 / 3 > var_0_0.TimeMgr.GetInstance():GetServerTime() then
			arg_12_0:Push(var_0_0.push_data_template[arg_12_0.PUSH_TYPE_GOLD].title, var_0_0.push_data_template[arg_12_0.PUSH_TYPE_GOLD].content, var_12_5.resUpdateTm + (var_12_2[var_12_0].store - var_12_5.goldField) / var_12_2[var_12_3].production * 60 * 60 / 3)
		end
	end

	return
end

function pg.PushNotificationMgr.PushOil(arg_13_0)
	local var_13_9000
	local var_13_0 = getProxy(NavalAcademyProxy)
	local var_13_1 = var_13_0.GetOilVO(var_13_9000)
	local var_13_2 = var_13_1:bindConfigTable()
	local var_13_3 = var_13_1:GetLevel()
	local var_13_5 = getProxy(PlayerProxy).data

	if var_13_5.oilField < var_13_2[var_13_0].store then
		if var_13_5.resUpdateTm + (var_13_2[var_13_0].store - var_13_5.oilField) / var_13_2[var_13_3].production * 60 * 60 / 3 > var_0_0.TimeMgr.GetInstance():GetServerTime() then
			arg_13_0:Push(var_0_0.push_data_template[arg_13_0.PUSH_TYPE_OIL].title, var_0_0.push_data_template[arg_13_0.PUSH_TYPE_OIL].content, var_13_5.resUpdateTm + (var_13_2[var_13_0].store - var_13_5.oilField) / var_13_2[var_13_3].production * 60 * 60 / 3)
		end
	end

	return
end

function pg.PushNotificationMgr.PushBackyard(arg_14_0)
	local var_14_9000
	local var_14_0 = getProxy(DormProxy)
	local var_14_1 = var_14_0.getRawData(var_14_9000):getFoodLeftTime()

	if var_14_1 > var_0_0.TimeMgr.GetInstance().GetServerTime(var_14_0) then
		arg_14_0:Push(var_0_0.push_data_template[arg_14_0.PUSH_TYPE_BACKYARD].title, var_0_0.push_data_template[arg_14_0.PUSH_TYPE_BACKYARD].content, var_14_1)
	end

	return
end

function pg.PushNotificationMgr.PushSchool(arg_15_0)
	local var_15_9000
	local var_15_0 = getProxy(NavalAcademyProxy)
	local var_15_1 = getProxy(BayProxy).getData(var_15_0)

	for iter_15_0, iter_15_1 in ipairs((var_15_0.getStudents(var_15_9000))) do
		local var_15_2 = var_0_0.TimeMgr.GetInstance()

		if iter_15_1.finishTime > var_15_2:GetServerTime() then
			local var_15_3 = var_15_1[iter_15_1.shipId].skills[iter_15_1:getSkillId(var_15_1[iter_15_1.shipId])]

			arg_15_0:Push(var_0_0.push_data_template[arg_15_0.PUSH_TYPE_SCHOOL].title, string.gsub(string.gsub(var_0_0.push_data_template[arg_15_0.PUSH_TYPE_SCHOOL].content, "$1", (var_15_1[iter_15_1.shipId]:getName())), "$2", (getSkillName(iter_15_1:getSkillId(var_15_1[iter_15_1.shipId])))), iter_15_1.finishTime)
		end
	end

	return
end

function pg.PushNotificationMgr.PushTechnlogy(arg_16_0)
	local var_16_0 = getProxy(TechnologyProxy)

	if var_0_0.push_data_template[var_0_1.PUSH_TYPE_TECHNOLOGY] and var_16_0 then
		local var_16_1 = var_16_0:getPlanningTechnologys()

		if #var_16_1 > 0 and not var_16_1[#var_16_1]:isFinish() then
			arg_16_0:Push(var_0_0.push_data_template[var_0_1.PUSH_TYPE_TECHNOLOGY].title, var_0_0.push_data_template[var_0_1.PUSH_TYPE_TECHNOLOGY].content, var_16_1[#var_16_1].time)
		end
	end

	return
end

function pg.PushNotificationMgr.PushBluePrint(arg_17_0)
	local var_17_0 = getProxy(TechnologyProxy)
	local var_17_1 = getProxy(TaskProxy)

	if var_0_0.push_data_template[var_0_1.PUSH_TYPE_BLUEPRINT] and var_17_0 and var_17_1 then
		local var_17_2 = var_17_0:getBuildingBluePrint()

		if var_17_2 then
			for iter_17_0, iter_17_1 in ipairs((var_17_2:getTaskIds())) do
				local var_17_3 = var_17_2:getTaskOpenTimeStamp(iter_17_1)
				local var_17_4 = var_0_0.TimeMgr.GetInstance()

				if var_17_3 > var_17_4:GetServerTime() then
					local var_17_5 = var_17_1:getTaskById(iter_17_1) or var_17_1:getFinishTaskById(iter_17_1)
					local var_17_6 = var_17_1:isFinishPrevTasks(iter_17_1)

					if not var_17_5 and var_17_6 then
						local var_17_7 = var_17_2:getShipVO()

						arg_17_0:Push(var_0_0.push_data_template[var_0_1.PUSH_TYPE_BLUEPRINT].title, string.gsub(var_0_0.push_data_template[var_0_1.PUSH_TYPE_BLUEPRINT].content, "$1", var_17_7:getConfig("name")), var_17_3)
					end
				end
			end
		end
	end

	return
end

function pg.PushNotificationMgr.PushCommander(arg_18_0)
	local var_18_0 = getProxy(CommanderProxy)

	if var_0_0.push_data_template[var_0_1.PUSH_TYPE_COMMANDER] and var_18_0 then
		for iter_18_0, iter_18_1 in pairs((var_18_0:getBoxes())) do
			if iter_18_1:getState() == CommanderBox.STATE_STARTING then
				arg_18_0:Push(var_0_0.push_data_template[var_0_1.PUSH_TYPE_COMMANDER].title, var_0_0.push_data_template[var_0_1.PUSH_TYPE_COMMANDER].content, iter_18_1.finishTime)

				break
			end
		end
	end

	return
end

function pg.PushNotificationMgr.PushGuildMissionFormation(arg_19_0)
	local var_19_0 = getProxy(GuildProxy):getRawData()

	if not var_19_0 then
		return
	end

	local var_19_1 = var_19_0:GetActiveEvent()

	if not var_19_1 or var_19_1 and not var_19_1:IsParticipant() then
		return
	end

	local var_19_2 = var_19_1:GetUnlockMission()

	if not var_19_2 then
		return
	end

	local var_19_3 = var_19_2:GetNextFormationTime()

	if var_19_3 <= var_0_0.TimeMgr.GetInstance():GetServerTime() then
		return
	end

	arg_19_0:Push(var_0_0.push_data_template[var_0_1.PUSH_TYPE_GUILD_MISSION_FORMATION].title, var_0_0.push_data_template[var_0_1.PUSH_TYPE_GUILD_MISSION_FORMATION].content, var_19_3)

	return
end

function pg.PushNotificationMgr.log(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	originalPrint(var_0_0.TimeMgr.GetInstance():CTimeDescC(arg_20_3), "-", arg_20_1, " - ", arg_20_2, " - ", arg_20_3 - os.time(), "s后推送")

	return
end

return
