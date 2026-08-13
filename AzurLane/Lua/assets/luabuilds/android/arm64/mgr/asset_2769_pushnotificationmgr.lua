pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.PushNotificationMgr = var_0_10001("PushNotificationMgr")

local var_0_1 = var_0.PushNotificationMgr

var_0_1.PUSH_TYPE_EVENT = 1
var_0_1.PUSH_TYPE_GOLD = 2
var_0_1.PUSH_TYPE_OIL = 3
var_0_1.PUSH_TYPE_BACKYARD = 4
var_0_1.PUSH_TYPE_SCHOOL = 5
var_0_1.PUSH_TYPE_CLASS = 6
var_0_1.PUSH_TYPE_TECHNOLOGY = 7
var_0_1.PUSH_TYPE_BLUEPRINT = 8
var_0_1.PUSH_TYPE_COMMANDER = 9
var_0_1.PUSH_TYPE_GUILD_MISSION_FORMATION = 10

local var_0_2 = {}
local var_0_3 = false

function var_0_1.Init(arg_1_0)
	var_0_2 = {}
	ipairs = var_1

	for iter_1_0, iter_1_1 in var_1(var_0.push_data_template.all) do
		local var_1_0 = var_0.push_data_template[iter_1_1]

		PlayerPrefs = var_1_10007
		var_1_10007 = var_1_10007.GetInt("push_setting_" .. var_1_0.id)
		var_0_2[var_1_0.id] = var_1_10007 == 0
	end

	PlayerPrefs = var_1
	var_0_3 = var_1.GetInt("setting_ship_name") == 1

	return
end

function var_0_1.Reset(arg_2_0)
	var_0_2 = {}
	ipairs = var_1

	for iter_2_0, iter_2_1 in var_1(var_0.push_data_template.all) do
		local var_2_0 = var_0.push_data_template[iter_2_1]

		PlayerPrefs = var_1_10007

		var_1_10007.SetInt("push_setting_" .. var_2_0.id, 0)

		var_1_10007 = var_0_2
		var_1_10007[var_2_0.id] = true
	end

	PlayerPrefs = var_1

	var_1.SetInt("setting_ship_name", 0)

	var_0_3 = false

	return
end

function var_0_1.setSwitch(arg_3_0, arg_3_1, arg_3_2)
	if not var_0.push_data_template[arg_3_1] then
		return
	end

	local var_3_0 = var_0_2

	var_3_0[arg_3_1] = arg_3_2
	PlayerPrefs = var_3_0

	var_3_0.SetInt("push_setting_" .. arg_3_1, arg_3_2 and 0 or 1)

	return
end

function var_0_1.setSwitchShipName(arg_4_0, arg_4_1)
	var_0_3 = arg_4_1
	PlayerPrefs = var_1_10002

	var_1_10002.SetInt("setting_ship_name", arg_4_1 and 1 or 0)

	return
end

function var_0_1.isEnabled(arg_5_0, arg_5_1)
	return var_0_2[arg_5_1]
end

function var_0_1.isEnableShipName(arg_6_0)
	return var_0_3
end

local var_0_4 = {}

function var_0_1.Push(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = var_0.TimeMgr.GetInstance()
	local var_7_1 = arg_7_3 - var_4.GetServerTime(var_7_0)

	os = var_1_10005

	local var_7_2 = var_1_10005.time() + var_7_1

	arg_7_0:log(arg_7_1, arg_7_2, var_7_2)

	local var_7_3 = {
		title = arg_7_1,
		content = arg_7_2,
		offsetSecond = var_7_1
	}

	table = var_1_10007

	var_1_10007.insert(var_0_4, var_7_3)

	return
end

function var_0_1.PushCache(arg_8_0)
	ipairs = var_1_10001

	for iter_8_0, iter_8_1 in var_1_10001(var_0_4) do
		local var_8_0 = iter_8_0
		local var_8_1 = iter_8_1.title
		local var_8_2 = iter_8_1.content
		local var_8_3 = iter_8_1.offsetSecond * 1000

		YSNormalTool = var_1_10010

		var_1_10010.NotificationTool.ScheduleNotification(var_8_0, var_8_1, var_8_2, var_8_3, "ys_icon_notification")
	end

	return
end

function var_0_1.cancelAll(arg_9_0)
	originalPrint = var_1_10001

	var_1_10001("取消通知")

	YSNormalTool = var_1_10001

	var_1_10001.NotificationTool.CancelAllNotification()

	var_0_4 = {}

	return
end

function var_0_1.PushAll(arg_10_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	if var_1_10001(var_1_10003) and var_1:getInited() then
		PUSH_NOTIFICATION_TEST_TAG = var_2

		if not var_2 then
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

function var_0_1.PushEvent(arg_11_0)
	getProxy = var_1_10001
	EventProxy = var_1_10003

	local var_11_0 = var_1_10001(var_1_10003)
	local var_11_1 = var_1.getActiveEvents(var_11_0)
	local var_11_2 = var_0.push_data_template[arg_11_0.PUSH_TYPE_EVENT]

	ipairs = var_3

	for iter_11_0, iter_11_1 in var_3(var_11_1) do
		string = var_1_10008
		var_1_10008 = var_1_10008.gsub(var_11_2.content, "$1", iter_11_1.template.title)

		arg_11_0:Push(var_11_2.title, var_1_10008, iter_11_1.finishTime)
	end

	return
end

function var_0_1.PushGold(arg_12_0)
	getProxy = var_1_10001
	NavalAcademyProxy = var_1_10003

	local var_12_0 = var_1_10001(var_1_10003)
	local var_12_1 = var_1.GetGoldVO(var_12_0)
	local var_12_2 = var_1.bindConfigTable(var_12_1)[var_1:GetLevel()].store
	local var_12_3 = var_2[var_3].production
	local var_12_4 = var_2[var_3].hour_time

	getProxy = var_1_10007
	PlayerProxy = var_1_10009

	local var_12_5 = var_1_10007(var_1_10009).data.resUpdateTm

	if var_7.goldField < var_12_2 then
		local var_12_6 = var_12_5 + (var_12_2 - var_9) / var_12_3 * 60 * 60 / 3
		local var_12_7 = var_0.TimeMgr.GetInstance()

		if var_12_6 > var_11.GetServerTime(var_12_7) then
			local var_12_8 = var_0.push_data_template[arg_12_0.PUSH_TYPE_GOLD]

			arg_12_0:Push(var_12_8.title, var_12_8.content, var_12_6)
		end
	end

	return
end

function var_0_1.PushOil(arg_13_0)
	getProxy = var_1_10001
	NavalAcademyProxy = var_1_10003

	local var_13_0 = var_1_10001(var_1_10003)
	local var_13_1 = var_1.GetOilVO(var_13_0)
	local var_13_2 = var_1.bindConfigTable(var_13_1)[var_1:GetLevel()].store
	local var_13_3 = var_2[var_3].production
	local var_13_4 = var_2[var_3].hour_time

	getProxy = var_1_10007
	PlayerProxy = var_1_10009

	local var_13_5 = var_1_10007(var_1_10009).data.resUpdateTm

	if var_7.oilField < var_13_2 then
		local var_13_6 = var_13_5 + (var_13_2 - var_9) / var_13_3 * 60 * 60 / 3
		local var_13_7 = var_0.TimeMgr.GetInstance()

		if var_13_6 > var_11.GetServerTime(var_13_7) then
			local var_13_8 = var_0.push_data_template[arg_13_0.PUSH_TYPE_OIL]

			arg_13_0:Push(var_13_8.title, var_13_8.content, var_13_6)
		end
	end

	return
end

function var_0_1.PushBackyard(arg_14_0)
	getProxy = var_1_10001
	DormProxy = var_1_10003

	local var_14_0 = var_1_10001(var_1_10003)
	local var_14_1 = var_1.getRawData(var_14_0)
	local var_14_2 = var_1.getFoodLeftTime(var_14_1)
	local var_14_3 = var_0.TimeMgr.GetInstance()

	if var_14_2 > var_3.GetServerTime(var_14_3) then
		local var_14_4 = var_0.push_data_template[arg_14_0.PUSH_TYPE_BACKYARD]

		arg_14_0:Push(var_14_4.title, var_14_4.content, var_14_2)
	end

	return
end

function var_0_1.PushSchool(arg_15_0)
	getProxy = var_1_10001
	NavalAcademyProxy = var_1_10003

	local var_15_0 = var_1_10001(var_1_10003)
	local var_15_1 = var_1.getStudents(var_15_0)
	local var_15_2 = var_0.push_data_template[arg_15_0.PUSH_TYPE_SCHOOL]

	getProxy = var_3
	BayProxy = var_1_10005

	local var_15_3 = var_3(var_1_10005)
	local var_15_4 = var_3.getData(var_15_3)

	ipairs = var_1_10005

	for iter_15_0, iter_15_1 in var_1_10005(var_15_1) do
		local var_15_5 = iter_15_1.finishTime
		local var_15_6 = var_0.TimeMgr.GetInstance()

		if var_15_5 > var_11.GetServerTime(var_15_6) then
			local var_15_7 = var_15_4[iter_15_1.shipId]
			local var_15_8 = iter_15_1:getSkillId(var_15_7)
			local var_15_9 = var_15_7.skills[var_15_8]
			local var_15_10 = var_15_7
			local var_15_11 = var_15_7.getName(var_15_10)

			getSkillName = var_14

			local var_15_12 = var_14(iter_15_1:getSkillId(var_15_7))

			string = var_15_10

			local var_15_13 = var_15_10.gsub(var_15_2.content, "$1", var_15_11)

			string = var_16

			local var_15_14 = var_16.gsub(var_15_13, "$2", var_15_12)

			arg_15_0:Push(var_15_2.title, var_15_14, iter_15_1.finishTime)
		end
	end

	return
end

function var_0_1.PushTechnlogy(arg_16_0)
	local var_16_0 = var_0.push_data_template[var_0_1.PUSH_TYPE_TECHNOLOGY]

	getProxy = var_2
	TechnologyProxy = var_1_10004

	local var_16_1 = var_2(var_1_10004)

	if var_16_0 and var_16_1 and #var_16_1:getPlanningTechnologys() > 0 then
		local var_16_2 = var_3[#var_3]

		if not var_4.isFinish(var_16_2) then
			arg_16_0:Push(var_16_0.title, var_16_0.content, var_3[#var_3].time)
		end
	end

	return
end

function var_0_1.PushBluePrint(arg_17_0)
	local var_17_0 = var_0.push_data_template[var_0_1.PUSH_TYPE_BLUEPRINT]

	getProxy = var_2
	TechnologyProxy = var_1_10004

	local var_17_1 = var_2(var_1_10004)

	getProxy = var_1_10003
	TaskProxy = var_1_10005

	local var_17_2 = var_1_10003(var_1_10005)

	if var_17_0 and var_17_1 and var_17_2 then
		local var_17_3 = var_17_1

		if var_17_1.getBuildingBluePrint(var_17_3) then
			local var_17_4 = var_4:getTaskIds()

			ipairs = var_17_3

			for iter_17_0, iter_17_1 in var_17_3(var_17_4) do
				local var_17_5 = var_4:getTaskOpenTimeStamp(iter_17_1)
				local var_17_6 = var_0.TimeMgr.GetInstance()

				if var_17_5 > var_12.GetServerTime(var_17_6) then
					local var_17_7

					if not var_17_2:getTaskById(iter_17_1) then
						var_17_7 = var_17_2:getFinishTaskById(iter_17_1)
					end

					local var_17_8 = var_17_2
					local var_17_9 = var_17_2.isFinishPrevTasks(var_17_8, iter_17_1)

					if not var_17_7 and var_17_9 then
						local var_17_10 = var_4:getShipVO()

						string = var_17_8

						local var_17_11 = var_17_8.gsub(var_17_0.content, "$1", var_17_10:getConfig("name"))

						arg_17_0:Push(var_17_0.title, var_17_11, var_17_5)
					end
				end
			end
		end
	end

	return
end

function var_0_1.PushCommander(arg_18_0)
	local var_18_0 = var_0.push_data_template[var_0_1.PUSH_TYPE_COMMANDER]

	getProxy = var_2
	CommanderProxy = var_1_10004

	local var_18_1 = var_2(var_1_10004)

	if var_18_0 and var_18_1 then
		local var_18_2 = var_18_1:getBoxes()

		pairs = var_1_10004

		for iter_18_0, iter_18_1 in var_1_10004(var_18_2) do
			local var_18_3 = iter_18_1:getState()

			CommanderBox = var_1_10010

			if var_18_3 == var_1_10010.STATE_STARTING then
				local var_18_4 = var_18_0.content

				arg_18_0:Push(var_18_0.title, var_18_4, iter_18_1.finishTime)

				break
			end
		end
	end

	return
end

function var_0_1.PushGuildMissionFormation(arg_19_0)
	getProxy = var_1_10001
	GuildProxy = var_1_10003

	local var_19_0 = var_1_10001(var_1_10003)

	if not var_1.getRawData(var_19_0) then
		return
	end

	if not var_1:GetActiveEvent() or var_2 and not var_2:IsParticipant() then
		return
	end

	if not var_2:GetUnlockMission() then
		return
	end

	local var_19_1 = var_3:GetNextFormationTime()
	local var_19_2 = var_0.TimeMgr.GetInstance()

	if var_19_1 <= var_5.GetServerTime(var_19_2) then
		return
	end

	local var_19_3 = var_0.push_data_template[var_0_1.PUSH_TYPE_GUILD_MISSION_FORMATION]

	arg_19_0:Push(var_19_3.title, var_19_3.content, var_19_1)

	return
end

function var_0_1.log(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	os = var_1_10004

	local var_20_0 = arg_20_3 - var_1_10004.time()
	local var_20_1 = var_0.TimeMgr.GetInstance()
	local var_20_2 = var_5.CTimeDescC(var_20_1, arg_20_3)

	originalPrint = var_1_10006

	var_1_10006(var_20_2, "-", arg_20_1, " - ", arg_20_2, " - ", var_20_0, "s后推送")

	return
end

return
