class = var_0_10000

local var_0_0 = "NavalAcademyProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NetProxy"))

var_0_1.COURSE_START = "NavalAcademyProxy:COURSE_START"
var_0_1.COURSE_UPDATED = "NavalAcademyProxy:COURSE_UPDATED"
var_0_1.COURSE_REWARD = "NavalAcademyProxy:COURSE_REWARD"
var_0_1.COURSE_CANCEL = "NavalAcademyProxy:COURSE_CANCEL"
var_0_1.RESOURCE_UPGRADE = "NavalAcademyProxy:RESOURCE_UPGRADE"
var_0_1.RESOURCE_UPGRADE_DONE = "NavalAcademyProxy:RESOURCE_UPGRADE_DONE"
var_0_1.BUILDING_FINISH = "NavalAcademyProxy:BUILDING_FINISH"
var_0_1.START_LEARN_TACTICS = "NavalAcademyProxy:START_LEARN_TACTICS"
var_0_1.CANCEL_LEARN_TACTICS = "NavalAcademyProxy:CANCEL_LEARN_TACTICS"
var_0_1.SKILL_CLASS_POS_UPDATED = "NavalAcademyProxy:SKILL_CLASS_POS_UPDATED"

function var_0_1.register(arg_1_0)
	arg_1_0.timers = {}
	arg_1_0.students = {}
	AcademyCourse = var_1
	arg_1_0.course = var_1.New()
	arg_1_0.recentShips = {}

	arg_1_0:on(22001, function(arg_2_0)
		OilResourceField = var_2_10001

		local var_2_0 = var_2_10001.New()

		var_1.SetLevel(var_2_0, arg_2_0.oil_well_level)
		var_1:SetUpgradeTimeStamp(arg_2_0.oil_well_lv_up_time)

		local var_2_1 = arg_1_0

		var_2_1._oilVO = var_1
		GoldResourceField = var_2_1

		local var_2_2 = var_2_1.New()

		var_2.SetLevel(var_2_2, arg_2_0.gold_well_level)
		var_2:SetUpgradeTimeStamp(arg_2_0.gold_well_lv_up_time)

		local var_2_3 = arg_1_0

		var_2_3._goldVO = var_2
		ClassResourceField = var_2_3

		local var_2_4 = var_2_3.New()

		var_3.SetLevel(var_2_4, arg_2_0.class_lv)
		var_3:SetUpgradeTimeStamp(arg_2_0.class_lv_up_time)

		arg_1_0._classVO = var_3

		local var_2_5 = arg_1_0.course

		var_4.update(var_2_5, arg_2_0.class)

		local var_2_6 = {}

		ipairs = var_2_5

		for iter_2_0, iter_2_1 in var_2_5(arg_2_0.skill_class_list) do
			Student = var_2_10010
			var_2_6[var_2_10010.New(iter_2_1).id] = var_2_10010
		end

		local var_2_7 = arg_1_0

		LOCK_CLASSROOM = var_6

		local var_2_8

		if var_6 then
			var_2_8 = 2
		elseif not arg_2_0.skill_class_num then
			var_2_8 = 2
		end

		var_2_7.skillClassNum = var_2_8

		local var_2_9 = arg_1_0

		var_5.setStudents(var_2_9, var_2_6)

		pg = var_5

		local var_2_10 = var_5.ShipFlagMgr.GetInstance()

		var_5.UpdateFlagShips(var_2_10, "inClass")

		local var_2_11 = arg_1_0

		var_5.CheckResFields(var_2_11)

		local var_2_12 = arg_1_0
		local var_2_13

		if not arg_2_0.daily_finish_buff_cnt then
			var_2_13 = 0
		end

		var_2_12.dailyFinsihCnt = var_2_13

		return
	end)
	arg_1_0:on(22013, function(arg_3_0)
		local var_3_0 = arg_1_0.course

		var_1.SetProficiency(var_3_0, arg_3_0.proficiency)

		getProxy = var_1
		PlayerProxy = var_3_0

		local var_3_1 = var_1(var_3_0)
		local var_3_2 = var_1.getData(var_3_1)

		var_3_2.expField = arg_3_0.exp_in_well
		getProxy = var_2
		PlayerProxy = var_3

		local var_3_3 = var_2(var_3)

		var_2.updatePlayer(var_3_3, var_3_2)

		local var_3_4 = arg_1_0

		var_2.sendNotification(var_3_4, var_0_1.COURSE_UPDATED)

		return
	end)

	return
end

function var_0_1.timeCall(arg_4_0)
	local var_4_0 = {}

	ProxyRegister = var_1_10002
	var_4_0[var_1_10002.DayCall] = function(arg_5_0)
		local var_5_0 = arg_4_0

		var_1.setCourse(var_5_0, arg_4_0.course)

		local var_5_1 = arg_4_0
		local var_5_2 = var_1.sendNotification

		GAME = var_3

		var_5_2(var_5_1, var_3.CLASS_FORCE_UPDATE)

		getProxy = var_5_2
		NavalAcademyProxy = var_5_1

		local var_5_3 = var_5_2(var_5_1)

		var_1.resetUsedDailyFinishCnt(var_5_3)

		return
	end

	return var_4_0
end

function var_0_1.GetRecentShips(arg_6_0)
	local var_6_0 = #arg_6_0.recentShips

	if 0 < var_6_0 then
		for iter_6_0 = #arg_6_0.recentShips, 1, -1 do
			local var_6_1 = arg_6_0.recentShips[iter_6_0]

			getProxy = var_1_10006
			BayProxy = var_1_10007
			var_1_10007 = var_1_10006(var_1_10007)

			if var_1_10006.RawGetShipById(var_1_10007, var_6_1) then
				_ = var_1_10007
				var_1_10007 = var_1_10007.all
				var_1_10009 = var_1_10006

				if var_1_10007(var_1_10006.getSkillList(var_1_10009), function(arg_7_0)
					ShipSkill = var_2_10001

					local var_7_0 = var_2_10001.New(var_1_10006.skills[arg_7_0])

					return var_1.IsMaxLevel(var_7_0)
				end) then
					table = var_1_10007

					var_1_10007.remove(arg_6_0.recentShips, iter_6_0)
				end
			end
		end

		return arg_6_0.recentShips
	end

	getProxy = var_6_0
	PlayerProxy = var_2

	local var_6_2 = var_6_0(var_2)
	local var_6_3 = var_1.getRawData(var_6_2).id

	PlayerPrefs = var_6_2

	local var_6_4 = var_6_2.GetString("NavTacticsRecentShipId" .. var_6_3)

	string = var_3

	local var_6_5 = var_3.split(var_6_4, "#")

	ipairs = var_4

	for iter_6_1, iter_6_2 in var_4(var_6_5) do
		tonumber = var_1_10009

		if not var_1_10009(iter_6_2) then
			var_1_10009 = 0
		end

		if 0 < var_1_10009 then
			getProxy = var_10
			BayProxy = var_1_10011
			var_1_10011 = var_10(var_1_10011)

			if var_10.RawGetShipById(var_1_10011, var_1_10009) then
				table = var_1_10011

				if not var_1_10011.contains(arg_6_0.recentShips, var_1_10009) then
					_ = var_1_10011

					if var_1_10011.any(var_10:getSkillList(), function(arg_8_0)
						ShipSkill = var_2_10001

						local var_8_0 = var_2_10001.New(var_0.skills[arg_8_0])

						return not var_1.IsMaxLevel(var_8_0)
					end) then
						table = var_1_10011

						var_1_10011.insert(arg_6_0.recentShips, var_1_10009)
					end
				end
			end
		end
	end

	return arg_6_0.recentShips
end

function var_0_1.SaveRecentShip(arg_9_0, arg_9_1)
	table = var_1_10002

	if not var_1_10002.contains(arg_9_0.recentShips, arg_9_1) then
		table = var_2

		var_2.insert(arg_9_0.recentShips, arg_9_1)

		for iter_9_0 = 1, #arg_9_0.recentShips - 11 do
			table = var_1_10006

			var_1_10006.remove(arg_9_0.recentShips, iter_9_0)
		end

		table = var_2

		local var_9_0 = var_2.concat(arg_9_0.recentShips, "#")

		getProxy = var_3
		PlayerProxy = var_4

		local var_9_1 = var_3(var_4)
		local var_9_2 = var_3.getRawData(var_9_1).id

		PlayerPrefs = var_9_1

		var_9_1.SetString("NavTacticsRecentShipId" .. var_9_2, var_9_0)

		PlayerPrefs = var_4

		var_4.Save()
	end

	return
end

function var_0_1.getSkillClassNum(arg_10_0)
	return arg_10_0.skillClassNum
end

var_0_1.MAX_SKILL_CLASS_NUM = 4

function var_0_1.inCreaseKillClassNum(arg_11_0)
	math = var_1_10001
	arg_11_0.skillClassNum = var_1_10001.min(arg_11_0.skillClassNum + 1, var_0_1.MAX_SKILL_CLASS_NUM)

	arg_11_0:sendNotification(var_0_1.SKILL_CLASS_POS_UPDATED, arg_11_0.skillClassNum)

	return
end

function var_0_1.onRemove(arg_12_0)
	pairs = var_1_10001

	for iter_12_0, iter_12_1 in var_1_10001(arg_12_0.timers) do
		iter_12_1:Stop()
	end

	arg_12_0.timers = nil

	var_0_1.super.onRemove(arg_12_0)

	return
end

function var_0_1.ExistStudent(arg_13_0, arg_13_1)
	return arg_13_0.students[arg_13_1] ~= nil
end

function var_0_1.getStudentById(arg_14_0, arg_14_1)
	if arg_14_0.students[arg_14_1] then
		local var_14_0 = arg_14_0.students[arg_14_1]

		return var_2.clone(var_14_0)
	end

	return
end

function var_0_1.getStudentIdByShipId(arg_15_0, arg_15_1)
	pairs = var_1_10002

	for iter_15_0, iter_15_1 in var_1_10002(arg_15_0.students) do
		if iter_15_1.shipId == arg_15_1 then
			return iter_15_1.id
		end
	end

	return
end

function var_0_1.getStudentByShipId(arg_16_0, arg_16_1)
	pairs = var_1_10002

	for iter_16_0, iter_16_1 in var_1_10002(arg_16_0.students) do
		if iter_16_1.shipId == arg_16_1 then
			return iter_16_1
		end
	end

	return
end

function var_0_1.setStudents(arg_17_0, arg_17_1)
	arg_17_0.students = arg_17_1
	pg = var_1_10002

	local var_17_0 = var_1_10002.ShipFlagMgr.GetInstance()

	var_2.UpdateFlagShips(var_17_0, "inTactics")

	return
end

function var_0_1.getStudents(arg_18_0)
	Clone = var_1_10001

	return var_1_10001(arg_18_0.students)
end

function var_0_1.RawGetStudentList(arg_19_0)
	return arg_19_0.students
end

function var_0_1.addStudent(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0.students

	var_20_0[arg_20_1.id] = arg_20_1
	pg = var_20_0

	local var_20_1 = var_20_0.ShipFlagMgr.GetInstance()

	var_2.UpdateFlagShips(var_20_1, "inTactics")

	local var_20_2 = arg_20_0
	local var_20_3 = arg_20_0.sendNotification
	local var_20_4 = var_0_1.START_LEARN_TACTICS

	Clone = var_1_10005

	var_20_3(var_20_2, var_20_4, var_1_10005(arg_20_1))

	return
end

function var_0_1.updateStudent(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.students

	var_21_0[arg_21_1.id] = arg_21_1
	pg = var_21_0

	local var_21_1 = var_21_0.ShipFlagMgr.GetInstance()

	var_2.UpdateFlagShips(var_21_1, "inTactics")

	return
end

function var_0_1.deleteStudent(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.students

	var_22_0[arg_22_1] = nil
	pg = var_22_0

	local var_22_1 = var_22_0.ShipFlagMgr.GetInstance()

	var_2.UpdateFlagShips(var_22_1, "inTactics")
	arg_22_0:sendNotification(var_0_1.CANCEL_LEARN_TACTICS, arg_22_1)

	return
end

function var_0_1.GetOilVO(arg_23_0)
	return arg_23_0._oilVO
end

function var_0_1.GetGoldVO(arg_24_0)
	return arg_24_0._goldVO
end

function var_0_1.GetClassVO(arg_25_0)
	return arg_25_0._classVO
end

function var_0_1.getCourse(arg_26_0)
	Clone = var_1_10001

	return var_1_10001(arg_26_0.course)
end

function var_0_1.setCourse(arg_27_0, arg_27_1)
	arg_27_0.course = arg_27_1
	pg = var_1_10002

	local var_27_0 = var_1_10002.ShipFlagMgr.GetInstance()

	var_2.UpdateFlagShips(var_27_0, "inClass")

	return
end

function var_0_1.GetShipIDs(arg_28_0)
	return {}
end

function var_0_1.CheckResFields(arg_29_0)
	local var_29_0 = arg_29_0._oilVO

	if var_1.IsStarting(var_29_0) then
		arg_29_0:AddResFieldListener(arg_29_0._oilVO)
	end

	local var_29_1 = arg_29_0._goldVO

	if var_1.IsStarting(var_29_1) then
		arg_29_0:AddResFieldListener(arg_29_0._goldVO)
	end

	local var_29_2 = arg_29_0._classVO

	if var_1.IsStarting(var_29_2) then
		arg_29_0:AddResFieldListener(arg_29_0._classVO)
	end

	return
end

function var_0_1.StartUpGradeSuccess(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_1:bindConfigTable()[arg_30_1:GetLevel()].time
	local var_30_1 = arg_30_1
	local var_30_2 = arg_30_1.SetUpgradeTimeStamp

	pg = var_1_10006

	local var_30_3 = var_1_10006.TimeMgr.GetInstance()

	var_30_2(var_30_1, var_6.GetServerTime(var_30_3) + var_30_0)
	arg_30_0:AddResFieldListener(arg_30_1)

	local var_30_4 = arg_30_0.facade

	var_4.sendNotification(var_30_4, var_0_1.RESOURCE_UPGRADE, {
		resVO = arg_30_1
	})

	return
end

function var_0_1.AddResFieldListener(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_1._upgradeTimeStamp

	pg = var_1_10003

	local var_31_1 = var_1_10003.TimeMgr.GetInstance()

	if var_31_0 - var_3.GetServerTime(var_31_1) > 0 then
		local var_31_2 = arg_31_1:GetUpgradeType()

		if arg_31_0.timers[var_31_2] then
			var_1_10005 = arg_31_0.timers[var_31_2]

			var_4.Stop(var_1_10005)

			arg_31_0.timers[var_31_2] = nil
		end

		local var_31_3 = arg_31_0.timers

		Timer = var_1_10005
		var_31_3[var_31_2] = var_1_10005.New(function()
			local var_32_0 = arg_31_0

			var_0.UpgradeFinish(var_32_0)

			local var_32_1 = arg_31_0.timers[var_31_2]

			var_0.Stop(var_32_1)

			arg_31_0.timers[var_31_2] = nil

			return
		end, var_2, 1)

		local var_31_4 = arg_31_0.timers[var_31_2]

		var_4.Start(var_31_4)
	end

	return
end

function var_0_1.UpgradeFinish(arg_33_0)
	local var_33_0 = arg_33_0._goldVO

	if var_1.GetDuration(var_33_0) then
		local var_33_1 = arg_33_0._goldVO

		if var_1.GetDuration(var_33_1) <= 0 then
			local var_33_2 = arg_33_0._goldVO
			local var_33_3 = var_1.bindConfigTable(var_33_2)
			local var_33_4 = arg_33_0._goldVO
			local var_33_5 = var_33_3[var_2.GetLevel(var_33_4)].store
			local var_33_6 = arg_33_0._goldVO
			local var_33_7 = var_2.SetLevel
			local var_33_8 = arg_33_0._goldVO

			var_33_7(var_33_6, var_4.GetLevel(var_33_8) + 1)

			local var_33_9 = arg_33_0._goldVO

			var_2.SetUpgradeTimeStamp(var_33_9, 0)

			local var_33_10 = arg_33_0._goldVO
			local var_33_11 = var_2.bindConfigTable(var_33_10)
			local var_33_12 = arg_33_0._goldVO
			local var_33_13 = var_33_11[var_3.GetLevel(var_33_12)].store

			arg_33_0:sendNotification(var_0_1.RESOURCE_UPGRADE_DONE, {
				field = arg_33_0._goldVO,
				value = var_33_13 - var_33_5
			})
		end
	end

	local var_33_14 = arg_33_0._oilVO

	if var_1.GetDuration(var_33_14) then
		local var_33_15 = arg_33_0._oilVO

		if var_1.GetDuration(var_33_15) <= 0 then
			local var_33_16 = arg_33_0._oilVO
			local var_33_17 = var_1.bindConfigTable(var_33_16)
			local var_33_18 = arg_33_0._oilVO
			local var_33_19 = var_33_17[var_2.GetLevel(var_33_18)].store
			local var_33_20 = arg_33_0._oilVO
			local var_33_21 = var_2.SetLevel
			local var_33_22 = arg_33_0._oilVO

			var_33_21(var_33_20, var_4.GetLevel(var_33_22) + 1)

			local var_33_23 = arg_33_0._oilVO

			var_2.SetUpgradeTimeStamp(var_33_23, 0)

			local var_33_24 = arg_33_0._oilVO
			local var_33_25 = var_2.bindConfigTable(var_33_24)
			local var_33_26 = arg_33_0._oilVO
			local var_33_27 = var_33_25[var_3.GetLevel(var_33_26)].store

			arg_33_0:sendNotification(var_0_1.RESOURCE_UPGRADE_DONE, {
				field = arg_33_0._oilVO,
				value = var_33_27 - var_33_19
			})
		end
	end

	local var_33_28 = arg_33_0._classVO

	if var_1.GetDuration(var_33_28) then
		local var_33_29 = arg_33_0._classVO

		if var_1.GetDuration(var_33_29) <= 0 then
			local var_33_30 = arg_33_0._classVO
			local var_33_31 = var_1.bindConfigTable(var_33_30)
			local var_33_32 = arg_33_0._classVO
			local var_33_33 = var_33_31[var_2.GetLevel(var_33_32)].store
			local var_33_34 = arg_33_0._classVO
			local var_33_35 = var_2.bindConfigTable(var_33_34)
			local var_33_36 = arg_33_0._classVO
			local var_33_37 = var_33_35[var_3.GetLevel(var_33_36)].proficency_get_percent
			local var_33_38 = arg_33_0._classVO
			local var_33_39 = var_3.bindConfigTable(var_33_38)
			local var_33_40 = arg_33_0._classVO
			local var_33_41 = var_33_39[var_4.GetLevel(var_33_40)].proficency_cost_per_min
			local var_33_42 = arg_33_0._classVO
			local var_33_43 = var_4.SetLevel
			local var_33_44 = arg_33_0._classVO

			var_33_43(var_33_42, var_6.GetLevel(var_33_44) + 1)

			local var_33_45 = arg_33_0._classVO

			var_4.SetUpgradeTimeStamp(var_33_45, 0)

			local var_33_46 = arg_33_0._classVO
			local var_33_47 = var_4.bindConfigTable(var_33_46)
			local var_33_48 = arg_33_0._classVO
			local var_33_49 = var_33_47[var_5.GetLevel(var_33_48)].store
			local var_33_50 = arg_33_0._classVO
			local var_33_51 = var_5.bindConfigTable(var_33_50)
			local var_33_52 = arg_33_0._classVO
			local var_33_53 = var_33_51[var_6.GetLevel(var_33_52)].proficency_get_percent
			local var_33_54 = arg_33_0._classVO
			local var_33_55 = var_6.bindConfigTable(var_33_54)
			local var_33_56 = arg_33_0._classVO
			local var_33_57 = var_33_55[var_7.GetLevel(var_33_56)].proficency_cost_per_min

			arg_33_0:sendNotification(var_0_1.RESOURCE_UPGRADE_DONE, {
				field = arg_33_0._classVO,
				value = var_33_49 - var_33_33,
				rate = var_33_53 - var_33_37,
				exp = (var_33_57 - var_33_41) * 60
			})
		end
	end

	return
end

function var_0_1.isResourceFieldUpgradeConditionSatisfy(arg_34_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_34_0 = var_1_10001(var_1_10002)
	local var_34_1 = var_1.getData(var_34_0)
	local var_34_2 = arg_34_0:GetOilVO()

	if not var_3.CanUpgrade(var_34_2, var_34_1.level, var_34_1.gold) then
		local var_34_3 = arg_34_0:GetGoldVO()

		if not var_3.CanUpgrade(var_34_3, var_34_1.level, var_34_1.gold) then
			local var_34_4 = arg_34_0:GetClassVO()

			if var_3.CanUpgrade(var_34_4, var_34_1.level, var_34_1.gold) then
				return true
			end

			return false
		end
	end
end

function var_0_1.AddCourseProficiency(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0:getCourse()
	local var_35_1 = arg_35_0:GetClassVO()
	local var_35_2 = var_3.GetExp2ProficiencyRatio(var_35_1) * var_35_0:getExtraRate()
	local var_35_3 = var_35_0
	local var_35_4 = var_35_0.GetProficiency(var_35_3)

	math = var_35_3

	local var_35_5 = var_35_4 + var_35_3.floor(arg_35_1 * var_35_2 * 0.01)

	math = var_6

	local var_35_6 = var_6.min(var_35_5, var_3:GetMaxProficiency())

	var_35_0:SetProficiency(var_35_6)
	arg_35_0:setCourse(var_35_0)

	return
end

function var_0_1.fillStudens(arg_36_0, arg_36_1)
	pg = var_1_10002

	local var_36_0 = var_1_10002.gameset.academy_random_ship_count.key_value
	local var_36_1 = {}

	pairs = var_1_10004

	for iter_36_0, iter_36_1 in var_1_10004(arg_36_1) do
		var_36_1[iter_36_1.groupId] = true
		var_36_0 = var_36_0 - 1
	end

	pg = var_4

	local var_36_2 = var_4.gameset.academy_random_ship_coldtime.key_value

	if arg_36_0._timeStamp then
		os = var_5

		if var_36_2 < var_5.time() - arg_36_0._timeStamp then
			arg_36_0._studentsFiller = nil
		end

		if not arg_36_0._studentsFiller then
			math = var_5

			local var_36_3 = var_5.random(1, var_36_0)

			os = var_5
			arg_36_0._timeStamp = var_5.time()
			arg_36_0._studentsFiller = {}
			getProxy = var_5
			CollectionProxy = var_6

			local var_36_4 = var_5(var_6)
			local var_36_5 = var_5.getGroups(var_36_4)

			getProxy = var_36_4
			BayProxy = iter_36_1

			local var_36_6 = var_36_4(iter_36_1)

			getProxy = iter_36_1
			ShipSkinProxy = var_1_10009

			local var_36_7 = iter_36_1(var_1_10009)
			local var_36_8 = var_8.getSkinList(var_36_7)
			local var_36_9 = {}

			pairs = var_1_10011

			for iter_36_2, iter_36_3 in var_1_10011(var_36_5) do
				table = var_1_10016

				if not var_1_10016.contains(var_36_1, iter_36_2) then
					var_36_9[#var_36_9 + 1] = iter_36_2
				end
			end

			var_1_10011 = #var_36_9

			while var_36_3 > 0 and 0 < var_1_10011 do
				math = var_12

				local var_36_10 = var_36_5[var_36_9[var_12.random(#var_36_9)]]
				local var_36_11 = 10000000000 + (var_13 * 10 + 1)

				ShipGroup = var_1_10017
				var_1_10017 = var_1_10017.getSkinList(var_13)

				local var_36_12 = {}
				local var_36_13
				local var_36_14 = {}

				ipairs = var_1_10021

				for iter_36_4, iter_36_5 in var_1_10021(var_1_10017) do
					local var_36_15 = iter_36_5.skin_type

					ShipSkin = var_1_10027

					if var_36_15 ~= var_1_10027.SKIN_TYPE_DEFAULT then
						table = var_1_10027

						if not var_1_10027.contains(var_36_8, iter_36_5.id) then
							ShipSkin = var_1_10027

							if var_36_15 ~= var_1_10027.SKIN_TYPE_REMAKE or not var_36_10.trans then
								ShipSkin = var_1_10027

								if var_36_15 == var_1_10027.SKIN_TYPE_PROPOSE and var_36_10.married == 1 then
									var_36_14[#var_36_14 + 1] = iter_36_5.id
								end

								math = var_1_10027
								var_36_13 = var_36_14[var_1_10027.random(#var_36_14)]
							end
						end
					end
				end

				var_1_10021 = {
					id = var_36_11,
					groupId = var_13,
					configId = var_15,
					skin_id = var_36_13
				}
				table = var_22

				var_22.remove(var_36_9, var_12)

				var_1_10011 = var_1_10011 - 1
				var_36_3 = var_36_3 - 1
				arg_36_0._studentsFiller[#arg_36_0._studentsFiller + 1] = var_1_10021
			end
		end

		ipairs = var_5

		for iter_36_6, iter_36_7 in var_5(arg_36_0._studentsFiller) do
			local var_36_16 = #arg_36_1 + 1

			Ship = var_1_10011
			arg_36_1[var_36_16] = var_1_10011.New(iter_36_7)
		end

		return arg_36_1
	end
end

function var_0_1.IsShowTip(arg_37_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	if var_1_10001(var_1_10002) then
		var_1_10003 = var_1

		if var_1.getData(var_1_10003) then
			var_1_10003 = arg_37_0

			if arg_37_0.isResourceFieldUpgradeConditionSatisfy(var_1_10003) then
				return true
			end
		end
	end

	getProxy = var_1_10002
	ShopsProxy = var_1_10003

	if var_1_10002(var_1_10003) and var_2:getShopStreet() and var_1_10003:isUpdateGoods() then
		return true
	end

	pg = var_1_10003

	local var_37_0 = var_1_10003.TimeMgr.GetInstance()
	local var_37_1 = var_3.GetServerTime(var_37_0)

	pairs = var_37_0

	for iter_37_0, iter_37_1 in var_37_0(arg_37_0.students) do
		var_1_10010 = iter_37_1

		if iter_37_1.getFinishTime(var_1_10010) <= var_37_1 then
			return true
		end
	end

	getProxy = var_4
	CollectionProxy = var_5

	local var_37_2 = var_4(var_5)
	local var_37_3 = var_4.unclaimTrophyCount(var_37_2)

	if 0 < var_37_3 then
		return true
	end

	getProxy = var_6
	TaskProxy = iter_37_0

	local var_37_4 = var_6(iter_37_0)

	_ = iter_37_0

	local var_37_5 = iter_37_0.any

	getProxy = iter_37_1
	ActivityProxy = var_1_10009

	local var_37_6 = iter_37_1(var_1_10009)
	local var_37_7 = var_8.getActivitiesByType

	ActivityConst = var_1_10010

	if var_37_5(var_37_7(var_37_6, var_1_10010.ACTIVITY_TYPE_TASK_LIST), function(arg_38_0)
		if arg_38_0:getTaskShip() then
			local var_38_0 = var_37_4
			local var_38_1

			if not var_2.getAcademyTask(var_38_0, var_1.groupId) then
				var_38_1 = nil
			end

			local var_38_2 = var_37_4
			local var_38_3 = var_3.getTaskById(var_38_2, var_38_1)
			local var_38_4 = var_37_4
			local var_38_5 = var_4.getFinishTaskById(var_38_4, var_38_1)

			return var_1 and (var_38_1 and not var_38_3 and not var_38_5 or var_38_3 and var_38_3:isFinish())
		end
	end) then
		return true
	end

	return false
end

function var_0_1.getDailyFinishCnt(arg_39_0)
	_ = var_1_10001

	local var_39_0 = var_1_10001.detect

	BuffHelper = var_1_10002

	local var_39_1 = var_1_10002.GetBuffsByActivityType

	ActivityConst = var_1_10003

	if var_39_0(var_39_1(var_1_10003.ACTIVITY_TYPE_BUFF), function(arg_40_0)
		return arg_40_0:getConfig("benefit_type") == "skill_learn_time"
	end) then
		tonumber = var_2

		local var_39_2

		if not var_2(var_1:getConfig("benefit_effect")) then
			var_39_2 = 0
		end

		return var_39_2 - arg_39_0.dailyFinsihCnt
	end
end

function var_0_1.updateUsedDailyFinishCnt(arg_41_0)
	arg_41_0.dailyFinsihCnt = arg_41_0.dailyFinsihCnt + 1

	return
end

function var_0_1.resetUsedDailyFinishCnt(arg_42_0)
	arg_42_0.dailyFinsihCnt = 0

	return
end

return var_0_1
