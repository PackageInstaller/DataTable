class = var_0_10000

local var_0_0 = "MetaCharacterProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NetProxy"))

var_0_1.METAPROGRESS_UPDATED = "MetaCharacterProxy:METAPROGRESS_UPDATED"
pg = var_1

local var_0_2 = var_1.ship_strengthen_meta

function var_0_1.register(arg_1_0)
	arg_1_0.data = {}
	arg_1_0.metaProgressVOList = {}
	arg_1_0.metaTacticsInfoTable = nil
	arg_1_0.metaTacticsInfoTableOnStart = nil
	arg_1_0.metaSkillLevelMaxInfoList = nil
	arg_1_0.lastMetaSkillExpInfoList = nil
	arg_1_0.startRecordTag = false
	arg_1_0.metaIDMark = {}
	pairs = var_1

	for iter_1_0, iter_1_1 in var_1(var_0_2.all) do
		MetaProgress = var_1_10006
		var_1_10006 = var_1_10006.New({
			id = iter_1_1
		})

		local var_1_0 = arg_1_0.data

		var_1_0[iter_1_1] = var_1_10006
		table = var_1_0

		var_1_0.insert(arg_1_0.metaProgressVOList, var_1_10006)
	end

	arg_1_0.redTagTable = {}
	pairs = var_1

	for iter_1_2, iter_1_3 in var_1(var_0_2.all) do
		arg_1_0.redTagTable[iter_1_3] = {
			false,
			false
		}
	end

	arg_1_0:on(63315, function(arg_2_0)
		print = var_2_10001

		var_2_10001("63315 get red tag info")

		local var_2_0 = {}

		ipairs = var_2

		for iter_2_0, iter_2_1 in var_2(arg_2_0.arg1) do
			MetaCharacterConst = var_2_10007
			var_2_10007 = var_2_10007.GetMetaShipGroupIDByConfigID(iter_2_1)
			table = var_8

			var_8.insert(var_2_0, var_2_10007)
		end

		if arg_2_0.type == 1 then
			pairs = var_2

			for iter_2_2, iter_2_3 in var_2(arg_1_0.redTagTable) do
				table = var_2_10007

				if var_2_10007.contains(var_2_0, iter_2_2) then
					iter_2_3[1] = true
					iter_2_3[2] = false
				else
					iter_2_3[1] = false
					iter_2_3[2] = false
				end
			end
		end

		return
	end)
	arg_1_0:on(63316, function(arg_3_0)
		print = var_2_10001

		var_2_10001("63316 get meta skill exp info")

		local var_3_0 = {}
		local var_3_1 = {}
		local var_3_2

		if not arg_1_0.metaSkillLevelMaxInfoList then
			var_3_2 = {}
		end

		ipairs = var_2_10004

		for iter_3_0, iter_3_1 in var_2_10004(arg_3_0.skill_info_list) do
			print = var_2_10009

			var_2_10009("shipID", iter_3_1.ship_id)

			var_2_10009 = iter_3_1.ship_id

			local var_3_3 = iter_3_1.skill_id
			local var_3_4 = iter_3_1.skill_level
			local var_3_5 = iter_3_1.skill_exp
			local var_3_6 = iter_3_1.day_exp
			local var_3_7 = iter_3_1.add_exp
			local var_3_8 = arg_1_0

			var_15.addExpToMetaTacticsInfo(var_3_8, iter_3_1)

			local var_3_9 = arg_1_0

			var_15.setLastMetaSkillExpInfo(var_3_9, var_3_1, iter_3_1)

			local var_3_10 = arg_1_0

			var_15.setMetaSkillLevelMaxInfo(var_3_10, var_3_2, iter_3_1)

			getProxy = var_15
			BayProxy = var_3_10

			local var_3_11 = var_15(var_3_10)
			local var_3_12 = var_15.getShipById(var_3_11, var_2_10009)

			pg = var_3_11

			local var_3_13 = var_3_11.gameset.meta_skill_exp_max.key_value
			local var_3_14 = var_3_12:getMetaSkillLevelBySkillID(var_3_3)
			local var_3_15 = var_3_13 <= var_3_6
			local var_3_16 = var_3_14 < var_3_4

			if var_3_15 or var_3_16 then
				pg = var_2_10020

				local var_3_17 = var_2_10020.ToastMgr.GetInstance()

				var_2_10020 = var_2_10020.ShowToast
				pg = var_2_10022

				var_2_10020(var_3_17, var_2_10022.ToastMgr.TYPE_META, {
					metaShipVO = var_3_12,
					newDayExp = var_3_6,
					addDayExp = var_3_7,
					curSkillID = var_3_3,
					newSkillLevel = var_3_4,
					oldSkillLevel = var_3_14
				})
			end

			local var_3_18 = var_3_12

			var_3_12.updateSkill(var_3_18, {
				skill_id = var_3_3,
				skill_lv = var_3_4,
				skill_exp = var_3_5
			})

			getProxy = var_2_10020
			BayProxy = var_3_18

			local var_3_19 = var_2_10020(var_3_18)

			var_2_10020.updateShip(var_3_19, var_3_12)
		end

		if #var_3_2 > 0 then
			arg_1_0.metaSkillLevelMaxInfoList = var_3_2
		end

		if #var_3_1 > 0 then
			arg_1_0.lastMetaSkillExpInfoList = var_3_1
		end

		return
	end)

	return
end

function var_0_1.getMetaProgressVOList(arg_4_0)
	ipairs = var_1_10001

	for iter_4_0, iter_4_1 in var_1_10001(arg_4_0.metaProgressVOList) do
		iter_4_1:setDataBeforeGet()
	end

	return arg_4_0.metaProgressVOList
end

function var_0_1.getMetaProgressVOByID(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.data[arg_5_1]

	assert = var_1_10003

	var_1_10003(var_5_0, "progressVO is null:" .. arg_5_1)

	if var_5_0 then
		var_5_0:setDataBeforeGet()
	end

	return var_5_0
end

function var_0_1.setAllProgressPTData(arg_6_0, arg_6_1)
	ipairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_1) do
		local var_6_0 = iter_6_1.group_id
		local var_6_1 = arg_6_0.data[var_6_0]

		assert = var_1_10009

		var_1_10009(var_6_1, "Null ProgressVO, ID:", var_6_0)

		local var_6_2 = var_6_1.metaPtData

		var_1_10009.initFromServerData(var_6_2, iter_6_1)
	end

	return
end

function var_0_1.updateRedTag(arg_7_0, arg_7_1)
	if arg_7_0.redTagTable[arg_7_1][1] == true then
		arg_7_0.redTagTable[arg_7_1][2] = true
	end

	return
end

function var_0_1.getRedTag(arg_8_0, arg_8_1)
	return arg_8_0.redTagTable[arg_8_1][2] == false and var_2[1] == true
end

function var_0_1.isHaveValidMetaProgressVO(arg_9_0)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.getMetaProgressVOList(var_9_0)

	ipairs = var_9_0

	for iter_9_0, iter_9_1 in var_9_0(var_9_1) do
		if iter_9_1:isShow() then
			return true
		end
	end

	return false
end

function var_0_1.setMetaTacticsInfo(arg_10_0, arg_10_1)
	local var_10_0

	if not arg_10_0.metaTacticsInfoTable then
		var_10_0 = {}
	end

	arg_10_0.metaTacticsInfoTable = var_10_0

	local var_10_1 = arg_10_1.ship_id

	MetaTacticsInfo = var_1_10003

	local var_10_2

	if var_1_10003.New(arg_10_1) then
		var_10_2 = arg_10_0.metaTacticsInfoTable
		var_10_2[var_10_1] = var_3

		var_3:printInfo()
	else
		errorMessage = var_10_2

		var_10_2("Creat MetaTacticsInfo Fail!")
	end

	return
end

function var_0_1.addExpToMetaTacticsInfo(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.ship_id

	if arg_11_0.metaTacticsInfoTable[var_11_0] then
		var_3:updateExp(arg_11_1)
		var_3:printInfo()
	else
		errorMsg = var_1_10004

		var_1_10004("MetaTacticsInfo is Null", var_11_0)
	end

	return
end

function var_0_1.switchMetaTacticsSkill(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0.metaTacticsInfoTable[arg_12_1] then
		var_3:switchSkill(arg_12_2)
		var_3:printInfo()
	else
		errorMsg = var_1_10004

		var_1_10004("MetaTacticsInfo is Null", arg_12_1)
	end

	return
end

function var_0_1.unlockMetaTacticsSkill(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0

	if not arg_13_0.metaTacticsInfoTable then
		var_13_0 = {}
	end

	arg_13_0.metaTacticsInfoTable = var_13_0

	if arg_13_0.metaTacticsInfoTable[arg_13_1] then
		var_4:unlockSkill(arg_13_2, arg_13_3)
	else
		local var_13_1 = {
			ship_id = arg_13_1,
			exp = arg_13_3 and 0,
			skill_id = arg_13_3 and arg_13_2,
			skill_exp = {
				{
					exp = 0,
					skill_id = arg_13_2
				}
			}
		}
		local var_13_2 = arg_13_0.metaTacticsInfoTable

		MetaTacticsInfo = var_7
		var_13_2[arg_13_1] = var_7.New(var_13_1)
	end

	var_4:printInfo()

	return
end

function var_0_1.requestMetaTacticsInfo(arg_14_0, arg_14_1, arg_14_2)
	local var_14_1

	if not arg_14_1 then
		::label_14_0::

		getProxy = var_14_1
		BayProxy = var_1_10004

		local var_14_0 = var_14_1(var_1_10004)

		var_14_1 = var_14_1.getMetaShipIDList(var_14_0)
	end

	if #var_14_1 == 0 then
		return
	end

	if arg_14_2 then
		local var_14_2 = arg_14_0
		local var_14_3 = arg_14_0.sendNotification

		GAME = var_1_10006

		var_14_3(var_14_2, var_1_10006.TACTICS_EXP_META_INFO_REQUEST, {
			idList = var_14_1
		})
	elseif not arg_14_0.metaTacticsInfoTable then
		local var_14_4 = arg_14_0
		local var_14_5 = arg_14_0.sendNotification

		GAME = var_1_10006

		var_14_5(var_14_4, var_1_10006.TACTICS_EXP_META_INFO_REQUEST, {
			idList = var_14_1
		})
	end

	return
end

function var_0_1.getMetaTacticsInfoByShipID(arg_15_0, arg_15_1)
	if not arg_15_0.metaTacticsInfoTable then
		MetaTacticsInfo = var_2

		return var_2.New()
	end

	if not arg_15_0.metaTacticsInfoTable[arg_15_1] then
		::label_15_0::

		MetaTacticsInfo = var_1_10003
		var_1_10003 = var_1_10003.New()
	end

	return var_1_10003
end

function var_0_1.printAllMetaTacticsInfo(arg_16_0)
	pairs = var_1_10001

	for iter_16_0, iter_16_1 in var_1_10001(arg_16_0.metaTacticsInfoTable) do
		iter_16_1:printInfo()
	end

	return
end

function var_0_1.setMetaTacticsInfoOnStart(arg_17_0)
	if arg_17_0.startRecordTag then
		return
	end

	local var_17_0 = true

	if arg_17_0.metaTacticsInfoTable then
		pairs = var_2

		for iter_17_0, iter_17_1 in var_2(arg_17_0.metaTacticsInfoTable) do
			if iter_17_1 then
				var_17_0 = false

				break
			end
		end
	end

	if arg_17_0.metaTacticsInfoTable and not var_17_0 then
		Clone = var_2
		arg_17_0.metaTacticsInfoTableOnStart = var_2(arg_17_0.metaTacticsInfoTable)
		arg_17_0.startRecordTag = true
	end

	return
end

function var_0_1.getMetaTacticsInfoOnEnd(arg_18_0)
	if not arg_18_0.metaTacticsInfoTableOnStart then
		return false
	end

	local var_18_0 = {}
	local var_18_1 = arg_18_0.metaTacticsInfoTable
	local var_18_2 = arg_18_0.metaTacticsInfoTableOnStart

	pairs = var_1_10004

	for iter_18_0, iter_18_1 in var_1_10004(var_18_1) do
		local var_18_3 = var_18_1[iter_18_1.shipID]
		local var_18_4

		if not var_18_2[var_9] then
			MetaTacticsInfo = var_18_4
			var_18_4 = var_18_4.New()
		end

		local var_18_5 = var_18_3
		local var_18_6

		if var_18_3.isAnyLearning(var_18_5) then
			var_18_5 = var_18_4
			var_18_6 = var_18_4.isAnyLearning(var_18_5)
		end

		getProxy = var_18_5
		BayProxy = var_1_10014
		var_1_10014 = var_18_5(var_1_10014)
		var_1_10014 = var_13.getShipById(var_1_10014, var_9)

		local var_18_7 = var_13.isAllMetaSkillLevelMax(var_1_10014)

		if not var_18_4 or not var_18_4:isExpMaxPerDay() then
			var_1_10014 = false
		end

		if var_18_6 and not var_18_7 and not var_1_10014 then
			local var_18_8 = var_18_3.curSkillID
			local var_18_9 = var_18_3.curDayExp - var_18_4.curDayExp

			getProxy = var_17
			BayProxy = var_1_10018
			var_1_10018 = var_17(var_1_10018)
			var_1_10018 = var_17.getShipById(var_1_10018, var_9)

			local var_18_10 = var_17.isSkillLevelMax(var_1_10018, var_18_8)

			var_1_10018 = 0 < var_18_9 and var_18_10

			local var_18_11 = var_18_3:isExpMaxPerDay()
			local var_18_12 = var_18_4.curDayExp

			pg = var_1_10021

			local var_18_13 = var_18_12 / var_1_10021.gameset.meta_skill_exp_max.key_value

			var_1_10021 = var_18_3.curDayExp
			pg = var_1_10022
			var_1_10021 = var_1_10021 / var_1_10022.gameset.meta_skill_exp_max.key_value

			if 0 < var_18_9 then
				table = var_1_10022

				var_1_10022.insert(var_18_0, {
					shipID = var_9,
					addDayExp = var_18_9,
					isUpLevel = var_1_10018,
					isMaxLevel = var_18_10,
					isExpMax = var_18_11,
					progressOld = var_18_13,
					progressNew = var_1_10021
				})
			end
		end
	end

	arg_18_0:clearMetaTacticsInfoRecord()

	return var_18_0
end

function var_0_1.clearMetaTacticsInfoRecord(arg_19_0)
	arg_19_0.metaTacticsInfoTableOnStart = nil
	arg_19_0.startRecordTag = false

	return
end

function var_0_1.setMetaSkillLevelMaxInfo(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_2.ship_id
	local var_20_1 = arg_20_2.skill_id
	local var_20_2 = arg_20_2.skill_level
	local var_20_3 = arg_20_2.skill_exp
	local var_20_4 = arg_20_2.day_exp
	local var_20_5 = arg_20_2.add_exp

	getProxy = var_1_10009
	BayProxy = var_1_10010

	local var_20_6 = var_1_10009(var_1_10010)
	local var_20_7 = var_9.getShipById(var_20_6, var_20_0)
	local var_20_8 = var_9.getMetaSkillLevelBySkillID(var_20_7, var_20_1)

	pg = var_20_7

	local var_20_9 = var_20_7.skill_data_template[var_20_1].max_level
	local var_20_10 = var_20_8 < var_20_2
	local var_20_11 = var_20_9 <= var_20_2

	if var_20_10 and var_20_11 then
		local var_20_12 = {
			metaShipVO = var_9,
			metaSkillID = var_20_1
		}
		local var_20_13 = false

		pairs = var_1_10016

		for iter_20_0, iter_20_1 in var_1_10016(arg_20_1) do
			if iter_20_1.metaShipVO.configId == var_20_12.metaShipVO.configId then
				var_20_13 = true

				break
			end
		end

		if not var_20_13 then
			table = var_16

			var_16.insert(arg_20_1, var_20_12)
		end
	end

	return
end

function var_0_1.getMetaSkillLevelMaxInfoList(arg_21_0)
	local var_21_0

	if not arg_21_0.metaSkillLevelMaxInfoList then
		var_21_0 = {}
	end

	return var_21_0
end

function var_0_1.clearMetaSkillLevelMaxInfoList(arg_22_0)
	arg_22_0.metaSkillLevelMaxInfoList = nil

	return
end

function var_0_1.tryRemoveMetaSkillLevelMaxInfo(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0.metaSkillLevelMaxInfoList then
		local var_23_0 = #arg_23_0.metaSkillLevelMaxInfoList

		if 0 < var_23_0 then
			local var_23_1

			ipairs = var_4

			for iter_23_0, iter_23_1 in var_4(arg_23_0.metaSkillLevelMaxInfoList) do
				local var_23_2 = iter_23_1.metaShipVO.id
				local var_23_3 = var_9.metaSkillID

				if arg_23_1 == var_23_2 and arg_23_2 ~= var_23_3 then
					var_23_1 = iter_23_0

					break
				end
			end

			if var_23_1 then
				table = var_4

				var_4.remove(arg_23_0.metaSkillLevelMaxInfoList, var_23_1)
			end
		end
	end

	return
end

function var_0_1.setLastMetaSkillExpInfo(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_2.ship_id
	local var_24_1 = arg_24_2.skill_id
	local var_24_2 = arg_24_2.skill_level
	local var_24_3 = arg_24_2.skill_exp
	local var_24_4 = arg_24_2.day_exp
	local var_24_5 = arg_24_2.add_exp

	getProxy = var_1_10009
	BayProxy = var_1_10010

	local var_24_6 = var_1_10009(var_1_10010)
	local var_24_7 = var_9.getShipById(var_24_6, var_24_0)
	local var_24_8 = var_9.getMetaSkillLevelBySkillID(var_24_7, var_24_1)

	pg = var_24_7

	local var_24_9 = var_24_7.skill_data_template[var_24_1].max_level
	local var_24_10 = var_24_8 < var_24_2
	local var_24_11 = var_24_9 <= var_24_2

	pg = var_1_10014

	local var_24_12 = var_24_4 >= var_1_10014.gameset.meta_skill_exp_max.key_value

	table = var_1_10015

	local var_24_13 = var_1_10015.insert
	local var_24_14 = arg_24_1
	local var_24_15 = {
		shipID = var_24_0,
		addDayExp = var_24_5,
		isUpLevel = var_24_10,
		isMaxLevel = var_24_11,
		isExpMax = var_24_12
	}

	pg = var_1_10018
	var_24_15.progress = var_24_4 / var_1_10018.gameset.meta_skill_exp_max.key_value

	var_24_13(var_24_14, var_24_15)

	return
end

function var_0_1.getLastMetaSkillExpInfoList(arg_25_0)
	local var_25_0

	if not arg_25_0.lastMetaSkillExpInfoList then
		var_25_0 = {}
	end

	return var_25_0
end

function var_0_1.clearLastMetaSkillExpInfoList(arg_26_0)
	arg_26_0.lastMetaSkillExpInfoList = nil

	return
end

function var_0_1.setMetaIDMark(arg_27_0, arg_27_1)
	local var_27_0

	if not arg_27_0.metaIDMark[arg_27_1] then
		var_27_0 = -1
	end

	arg_27_0.metaIDMark[arg_27_1] = var_27_0 + 1

	return
end

function var_0_1.getMetaIDMark(arg_28_0, arg_28_1)
	return arg_28_0.metaIDMark[arg_28_1]
end

return var_0_1
