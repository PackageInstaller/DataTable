local var_0_0 = class("MetaCharacterProxy", import(".NetProxy"))

var_0_0.METAPROGRESS_UPDATED = "MetaCharacterProxy:METAPROGRESS_UPDATED"

local var_0_1 = pg.ship_strengthen_meta

function var_0_0.register(arg_1_0)
	arg_1_0.data = {}
	arg_1_0.metaProgressVOList = {}
	arg_1_0.metaTacticsInfoTable = nil
	arg_1_0.metaTacticsInfoTableOnStart = nil
	arg_1_0.metaSkillLevelMaxInfoList = nil
	arg_1_0.lastMetaSkillExpInfoList = nil
	arg_1_0.startRecordTag = false
	arg_1_0.metaIDMark = {}

	for iter_1_0, iter_1_1 in pairs(var_0_1.all) do
		local var_1_0 = MetaProgress.New({
			id = iter_1_1
		})

		arg_1_0.data[iter_1_1] = var_1_0

		table.insert(arg_1_0.metaProgressVOList, var_1_0)
	end

	arg_1_0.redTagTable = {}

	for iter_1_2, iter_1_3 in pairs(var_0_1.all) do
		arg_1_0.redTagTable[iter_1_3] = {
			false,
			false
		}
	end

	arg_1_0:on(63315, function(arg_2_0)
		print("63315 get red tag info")

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.arg1) do
			table.insert({}, (MetaCharacterConst.GetMetaShipGroupIDByConfigID(iter_2_1)))
		end

		if arg_2_0.type == 1 then
			for iter_2_2, iter_2_3 in pairs(arg_1_0.redTagTable) do
				if table.contains({}, iter_2_2) then
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
		local var_3_9000

		print("63316 get meta skill exp info")

		local var_3_1 = arg_1_0.metaSkillLevelMaxInfoList or {}

		for iter_3_0, iter_3_1 in ipairs(arg_3_0.skill_info_list) do
			print("shipID", iter_3_1.ship_id)

			local var_3_2 = iter_3_1.skill_id
			local var_3_3 = iter_3_1.skill_level
			local var_3_4 = iter_3_1.skill_exp
			local var_3_5 = iter_3_1.day_exp
			local var_3_6 = iter_3_1.add_exp

			arg_1_0:addExpToMetaTacticsInfo(iter_3_1)
			arg_1_0:setLastMetaSkillExpInfo({}, iter_3_1)
			arg_1_0:setMetaSkillLevelMaxInfo(var_3_1, iter_3_1)

			local var_3_7 = getProxy(BayProxy)
			local var_3_8 = var_3_7.getShipById(var_3_9000, iter_3_1.ship_id)
			local var_3_9 = var_3_8:getMetaSkillLevelBySkillID(var_3_2)
			local var_3_10 = var_3_7 < var_3_3

			if pg.gameset.meta_skill_exp_max.key_value <= var_3_5 or var_3_10 then
				pg.ToastMgr.GetInstance():ShowToast(pg.ToastMgr.TYPE_META, {
					metaShipVO = var_3_8,
					newDayExp = var_3_5,
					addDayExp = var_3_6,
					curSkillID = var_3_2,
					newSkillLevel = var_3_3,
					oldSkillLevel = var_3_9
				})
			end

			var_3_8:updateSkill({
				skill_id = var_3_2,
				skill_lv = var_3_3,
				skill_exp = var_3_4
			})
			getProxy(BayProxy):updateShip(var_3_8)
		end

		if #var_3_1 > 0 then
			arg_1_0.metaSkillLevelMaxInfoList = var_3_1
		end

		if #{} > 0 then
			arg_1_0.lastMetaSkillExpInfoList = {}
		end

		return
	end)

	return
end

function var_0_0.getMetaProgressVOList(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.metaProgressVOList) do
		iter_4_1:setDataBeforeGet()
	end

	return arg_4_0.metaProgressVOList
end

function var_0_0.getMetaProgressVOByID(arg_5_0, arg_5_1)
	assert(arg_5_0.data[arg_5_1], "progressVO is null:" .. arg_5_1)

	if arg_5_0.data[arg_5_1] then
		arg_5_0.data[arg_5_1]:setDataBeforeGet()
	end

	return arg_5_0.data[arg_5_1]
end

function var_0_0.setAllProgressPTData(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		assert(arg_6_0.data[iter_6_1.group_id], "Null ProgressVO, ID:", iter_6_1.group_id)
		arg_6_0.data[iter_6_1.group_id].metaPtData:initFromServerData(iter_6_1)
	end

	return
end

function var_0_0.updateRedTag(arg_7_0, arg_7_1)
	if arg_7_0.redTagTable[arg_7_1][1] == true then
		arg_7_0.redTagTable[arg_7_1][2] = true
	end

	return
end

function var_0_0.getRedTag(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.redTagTable[arg_8_1]

	return arg_8_0.redTagTable[arg_8_1][2] == false and var_8_0[1] == true
end

function var_0_0.isHaveValidMetaProgressVO(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs((arg_9_0:getMetaProgressVOList())) do
		if iter_9_1:isShow() then
			return true
		end
	end

	return false
end

function var_0_0.setMetaTacticsInfo(arg_10_0, arg_10_1)
	arg_10_0.metaTacticsInfoTable = arg_10_0.metaTacticsInfoTable or {}

	local var_10_0 = MetaTacticsInfo.New(arg_10_1)

	if var_10_0 then
		arg_10_0.metaTacticsInfoTable[arg_10_1.ship_id] = var_10_0

		var_10_0:printInfo()
	else
		errorMessage("Creat MetaTacticsInfo Fail!")
	end

	return
end

function var_0_0.addExpToMetaTacticsInfo(arg_11_0, arg_11_1)
	if arg_11_0.metaTacticsInfoTable[arg_11_1.ship_id] then
		arg_11_0.metaTacticsInfoTable[arg_11_1.ship_id]:updateExp(arg_11_1)
		arg_11_0.metaTacticsInfoTable[arg_11_1.ship_id]:printInfo()
	else
		errorMsg("MetaTacticsInfo is Null", arg_11_1.ship_id)
	end

	return
end

function var_0_0.switchMetaTacticsSkill(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0.metaTacticsInfoTable[arg_12_1] then
		arg_12_0.metaTacticsInfoTable[arg_12_1]:switchSkill(arg_12_2)
		arg_12_0.metaTacticsInfoTable[arg_12_1]:printInfo()
	else
		errorMsg("MetaTacticsInfo is Null", arg_12_1)
	end

	return
end

function var_0_0.unlockMetaTacticsSkill(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0.metaTacticsInfoTable = arg_13_0.metaTacticsInfoTable or {}

	if arg_13_0.metaTacticsInfoTable[arg_13_1] then
		var_13_0:unlockSkill(arg_13_2, arg_13_3)
	else
		arg_13_0.metaTacticsInfoTable[arg_13_1] = MetaTacticsInfo.New({
			ship_id = arg_13_1,
			exp = arg_13_3 and 0,
			skill_id = arg_13_3 and arg_13_2,
			skill_exp = {
				{
					exp = 0,
					skill_id = arg_13_2
				}
			}
		})
	end

	var_13_0:printInfo()

	return
end

function var_0_0.requestMetaTacticsInfo(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1 or getProxy(BayProxy):getMetaShipIDList()

	if #var_14_0 == 0 then
		return
	end

	if arg_14_2 then
		arg_14_0:sendNotification(GAME.TACTICS_EXP_META_INFO_REQUEST, {
			idList = var_14_0
		})
	elseif not arg_14_0.metaTacticsInfoTable then
		arg_14_0:sendNotification(GAME.TACTICS_EXP_META_INFO_REQUEST, {
			idList = var_14_0
		})
	end

	return
end

function var_0_0.getMetaTacticsInfoByShipID(arg_15_0, arg_15_1)
	if not arg_15_0.metaTacticsInfoTable then
		return MetaTacticsInfo.New()
	end

	return arg_15_0.metaTacticsInfoTable[arg_15_1] or MetaTacticsInfo.New()
end

function var_0_0.printAllMetaTacticsInfo(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(arg_16_0.metaTacticsInfoTable) do
		iter_16_1:printInfo()
	end

	return
end

function var_0_0.setMetaTacticsInfoOnStart(arg_17_0)
	if arg_17_0.startRecordTag then
		return
	end

	local var_17_0 = true

	if arg_17_0.metaTacticsInfoTable then
		for iter_17_0, iter_17_1 in pairs(arg_17_0.metaTacticsInfoTable) do
			if iter_17_1 then
				var_17_0 = false

				break
			end
		end
	end

	if arg_17_0.metaTacticsInfoTable and not var_17_0 then
		arg_17_0.metaTacticsInfoTableOnStart = Clone(arg_17_0.metaTacticsInfoTable)
		arg_17_0.startRecordTag = true
	end

	return
end

function var_0_0.getMetaTacticsInfoOnEnd(arg_18_0)
	if not arg_18_0.metaTacticsInfoTableOnStart then
		return false
	end

	local var_18_0 = {}

	for iter_18_0, iter_18_1 in pairs(arg_18_0.metaTacticsInfoTable) do
		local var_18_1 = iter_18_1.shipID
		local var_18_2 = arg_18_0.metaTacticsInfoTable[iter_18_1.shipID]
		local var_18_3 = arg_18_0.metaTacticsInfoTableOnStart[iter_18_1.shipID] or MetaTacticsInfo.New()
		local var_18_4 = var_18_2:isAnyLearning() and var_18_3:isAnyLearning()
		local var_18_5 = getProxy(BayProxy):getShipById(var_18_1):isAllMetaSkillLevelMax()
		local var_18_6 = var_18_3 and var_18_3:isExpMaxPerDay() or false

		if var_18_4 and not var_18_5 and not var_18_6 then
			local var_18_7 = var_18_2.curDayExp - var_18_3.curDayExp
			local var_18_8 = getProxy(BayProxy):getShipById(var_18_1):isSkillLevelMax(var_18_2.curSkillID)
			local var_18_9 = var_18_2.curDayExp - var_18_3.curDayExp > 0 and var_18_8
			local var_18_10 = var_18_2:isExpMaxPerDay()

			if var_18_2.curDayExp - var_18_3.curDayExp > 0 then
				table.insert(var_18_0, {
					shipID = var_18_1,
					addDayExp = var_18_7,
					isUpLevel = var_18_9,
					isMaxLevel = var_18_8,
					isExpMax = var_18_10,
					progressOld = var_18_3.curDayExp / pg.gameset.meta_skill_exp_max.key_value,
					progressNew = var_18_2.curDayExp / pg.gameset.meta_skill_exp_max.key_value
				})
			end
		end
	end

	arg_18_0:clearMetaTacticsInfoRecord()

	return var_18_0
end

function var_0_0.clearMetaTacticsInfoRecord(arg_19_0)
	arg_19_0.metaTacticsInfoTableOnStart = nil
	arg_19_0.startRecordTag = false

	return
end

function var_0_0.setMetaSkillLevelMaxInfo(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_2.skill_id
	local var_20_4 = getProxy(BayProxy):getShipById(arg_20_2.ship_id)
	local var_20_5 = pg.skill_data_template[arg_20_2.skill_id].max_level <= arg_20_2.skill_level

	if var_20_4:getMetaSkillLevelBySkillID(arg_20_2.skill_id) < arg_20_2.skill_level and var_20_5 then
		local var_20_6 = false

		for iter_20_0, iter_20_1 in pairs(arg_20_1) do
			if iter_20_1.metaShipVO.configId == ({
				metaShipVO = var_20_4,
				metaSkillID = var_20_0
			}).metaShipVO.configId then
				var_20_6 = true

				break
			end
		end

		if not var_20_6 then
			table.insert(arg_20_1, {
				metaShipVO = var_20_4,
				metaSkillID = var_20_0
			})
		end
	end

	return
end

function var_0_0.getMetaSkillLevelMaxInfoList(arg_21_0)
	return arg_21_0.metaSkillLevelMaxInfoList or {}
end

function var_0_0.clearMetaSkillLevelMaxInfoList(arg_22_0)
	arg_22_0.metaSkillLevelMaxInfoList = nil

	return
end

function var_0_0.tryRemoveMetaSkillLevelMaxInfo(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0.metaSkillLevelMaxInfoList and #arg_23_0.metaSkillLevelMaxInfoList > 0 then
		local var_23_0

		for iter_23_0, iter_23_1 in ipairs(arg_23_0.metaSkillLevelMaxInfoList) do
			if arg_23_1 == iter_23_1.metaShipVO.id and arg_23_2 ~= iter_23_1.metaShipVO.metaSkillID then
				var_23_0 = iter_23_0

				break
			end
		end

		if var_23_0 then
			table.remove(arg_23_0.metaSkillLevelMaxInfoList, var_23_0)
		end
	end

	return
end

function var_0_0.setLastMetaSkillExpInfo(arg_24_0, arg_24_1, arg_24_2)
	local var_24_1 = getProxy(BayProxy):getShipById(arg_24_2.ship_id)

	table.insert(arg_24_1, {
		shipID = arg_24_2.ship_id,
		addDayExp = arg_24_2.add_exp,
		isUpLevel = var_24_1:getMetaSkillLevelBySkillID(arg_24_2.skill_id) < arg_24_2.skill_level,
		isMaxLevel = pg.skill_data_template[arg_24_2.skill_id].max_level <= arg_24_2.skill_level,
		isExpMax = arg_24_2.day_exp >= pg.gameset.meta_skill_exp_max.key_value,
		progress = arg_24_2.day_exp / pg.gameset.meta_skill_exp_max.key_value
	})

	return
end

function var_0_0.getLastMetaSkillExpInfoList(arg_25_0)
	return arg_25_0.lastMetaSkillExpInfoList or {}
end

function var_0_0.clearLastMetaSkillExpInfoList(arg_26_0)
	arg_26_0.lastMetaSkillExpInfoList = nil

	return
end

function var_0_0.setMetaIDMark(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0.metaIDMark[arg_27_1] or -1

	arg_27_0.metaIDMark[arg_27_1] = var_27_0 + 1

	return
end

function var_0_0.getMetaIDMark(arg_28_0, arg_28_1)
	return arg_28_0.metaIDMark[arg_28_1]
end

return var_0_0
