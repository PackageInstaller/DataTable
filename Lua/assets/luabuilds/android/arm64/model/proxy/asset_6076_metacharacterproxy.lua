local MetaCharacterProxy = class("MetaCharacterProxy", import(".NetProxy"))

MetaCharacterProxy.METAPROGRESS_UPDATED = "MetaCharacterProxy:METAPROGRESS_UPDATED"

local var_0_1 = pg.ship_strengthen_meta

function MetaCharacterProxy:register()
	self.data = {}
	self.metaProgressVOList = {}
	self.metaTacticsInfoTable = nil
	self.metaTacticsInfoTableOnStart = nil
	self.metaSkillLevelMaxInfoList = nil
	self.lastMetaSkillExpInfoList = nil
	self.startRecordTag = false
	self.metaIDMark = {}

	for iter_1_0, iter_1_1 in pairs(var_0_1.all) do
		local var_1_0 = MetaProgress.New({
			id = iter_1_1
		})

		self.data[iter_1_1] = var_1_0

		table.insert(self.metaProgressVOList, var_1_0)
	end

	self.redTagTable = {}

	for iter_1_2, iter_1_3 in pairs(var_0_1.all) do
		self.redTagTable[iter_1_3] = {
			false,
			false
		}
	end

	self:on(63315, function(arg_2_0)
		print("63315 get red tag info")

		local var_2_0 = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.arg1) do
			table.insert(var_2_0, (MetaCharacterConst.GetMetaShipGroupIDByConfigID(iter_2_1)))
		end

		if arg_2_0.type == 1 then
			for iter_2_2, iter_2_3 in pairs(self.redTagTable) do
				if table.contains(var_2_0, iter_2_2) then
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
	self:on(63316, function(arg_3_0)
		print("63316 get meta skill exp info")

		local var_3_1 = {}
		local var_3_2 = self.metaSkillLevelMaxInfoList or {}

		for iter_3_0, iter_3_1 in ipairs(arg_3_0.skill_info_list) do
			print("shipID", iter_3_1.ship_id)

			local var_3_3 = iter_3_1.skill_id
			local var_3_4 = iter_3_1.skill_level
			local var_3_5 = iter_3_1.skill_exp
			local var_3_6 = iter_3_1.day_exp
			local var_3_7 = iter_3_1.add_exp

			self:addExpToMetaTacticsInfo(iter_3_1)
			self:setLastMetaSkillExpInfo(var_3_1, iter_3_1)
			self:setMetaSkillLevelMaxInfo(var_3_2, iter_3_1)

			local var_3_8 = getProxy(BayProxy)
			local var_3_9 = var_3_8:getShipById(iter_3_1.ship_id)
			local var_3_10 = var_3_9:getMetaSkillLevelBySkillID(var_3_3)

			if pg.gameset.meta_skill_exp_max.key_value <= var_3_6 or var_3_8 < var_3_4 then
				pg.ToastMgr.GetInstance():ShowToast(pg.ToastMgr.TYPE_META, {
					metaShipVO = var_3_9,
					newDayExp = var_3_6,
					addDayExp = var_3_7,
					curSkillID = var_3_3,
					newSkillLevel = var_3_4,
					oldSkillLevel = var_3_10
				})
			end

			var_3_9:updateSkill({
				skill_id = var_3_3,
				skill_lv = var_3_4,
				skill_exp = var_3_5
			})
			getProxy(BayProxy):updateShip(var_3_9)
		end

		if #var_3_2 > 0 then
			self.metaSkillLevelMaxInfoList = var_3_2
		end

		if #var_3_1 > 0 then
			self.lastMetaSkillExpInfoList = var_3_1
		end

		return
	end)

	return
end

function MetaCharacterProxy:getMetaProgressVOList()
	for iter_4_0, iter_4_1 in ipairs(self.metaProgressVOList) do
		iter_4_1:setDataBeforeGet()
	end

	return self.metaProgressVOList
end

function MetaCharacterProxy:getMetaProgressVOByID(arg_5_1)
	assert(self.data[arg_5_1], "progressVO is null:" .. arg_5_1)

	if self.data[arg_5_1] then
		self.data[arg_5_1]:setDataBeforeGet()
	end

	return self.data[arg_5_1]
end

function MetaCharacterProxy:setAllProgressPTData(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		assert(self.data[iter_6_1.group_id], "Null ProgressVO, ID:", iter_6_1.group_id)
		self.data[iter_6_1.group_id].metaPtData:initFromServerData(iter_6_1)
	end

	return
end

function MetaCharacterProxy:updateRedTag(arg_7_1)
	if self.redTagTable[arg_7_1][1] == true then
		self.redTagTable[arg_7_1][2] = true
	end

	return
end

function MetaCharacterProxy:getRedTag(arg_8_1)
	return self.redTagTable[arg_8_1][2] == false and self.redTagTable[arg_8_1][1] == true
end

function MetaCharacterProxy:isHaveValidMetaProgressVO()
	for iter_9_0, iter_9_1 in ipairs((self:getMetaProgressVOList())) do
		if iter_9_1:isShow() then
			return true
		end
	end

	return false
end

function MetaCharacterProxy:setMetaTacticsInfo(arg_10_1)
	self.metaTacticsInfoTable = self.metaTacticsInfoTable or {}

	local var_10_0 = MetaTacticsInfo.New(arg_10_1)

	if var_10_0 then
		self.metaTacticsInfoTable[arg_10_1.ship_id] = var_10_0

		var_10_0:printInfo()
	else
		errorMessage("Creat MetaTacticsInfo Fail!")
	end

	return
end

function MetaCharacterProxy:addExpToMetaTacticsInfo(arg_11_1)
	if self.metaTacticsInfoTable[arg_11_1.ship_id] then
		self.metaTacticsInfoTable[arg_11_1.ship_id]:updateExp(arg_11_1)
		self.metaTacticsInfoTable[arg_11_1.ship_id]:printInfo()
	else
		errorMsg("MetaTacticsInfo is Null", arg_11_1.ship_id)
	end

	return
end

function MetaCharacterProxy:switchMetaTacticsSkill(arg_12_1, arg_12_2)
	if self.metaTacticsInfoTable[arg_12_1] then
		self.metaTacticsInfoTable[arg_12_1]:switchSkill(arg_12_2)
		self.metaTacticsInfoTable[arg_12_1]:printInfo()
	else
		errorMsg("MetaTacticsInfo is Null", arg_12_1)
	end

	return
end

function MetaCharacterProxy:unlockMetaTacticsSkill(arg_13_1, arg_13_2, arg_13_3)
	self.metaTacticsInfoTable = self.metaTacticsInfoTable or {}

	local var_13_0 = self.metaTacticsInfoTable[arg_13_1]

	if self.metaTacticsInfoTable[arg_13_1] then
		var_13_0:unlockSkill(arg_13_2, arg_13_3)
	else
		self.metaTacticsInfoTable[arg_13_1] = MetaTacticsInfo.New({
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

function MetaCharacterProxy:requestMetaTacticsInfo(arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1 or getProxy(BayProxy):getMetaShipIDList()

	if #var_14_0 == 0 then
		return
	end

	if arg_14_2 then
		self:sendNotification(GAME.TACTICS_EXP_META_INFO_REQUEST, {
			idList = var_14_0
		})
	elseif not self.metaTacticsInfoTable then
		self:sendNotification(GAME.TACTICS_EXP_META_INFO_REQUEST, {
			idList = var_14_0
		})
	end

	return
end

function MetaCharacterProxy:getMetaTacticsInfoByShipID(arg_15_1)
	if not self.metaTacticsInfoTable then
		return MetaTacticsInfo.New()
	end

	return self.metaTacticsInfoTable[arg_15_1] or MetaTacticsInfo.New()
end

function MetaCharacterProxy:printAllMetaTacticsInfo()
	for iter_16_0, iter_16_1 in pairs(self.metaTacticsInfoTable) do
		iter_16_1:printInfo()
	end

	return
end

function MetaCharacterProxy:setMetaTacticsInfoOnStart()
	if self.startRecordTag then
		return
	end

	local var_17_0 = true

	if self.metaTacticsInfoTable then
		for iter_17_0, iter_17_1 in pairs(self.metaTacticsInfoTable) do
			if iter_17_1 then
				var_17_0 = false

				break
			end
		end
	end

	if self.metaTacticsInfoTable and not var_17_0 then
		self.metaTacticsInfoTableOnStart = Clone(self.metaTacticsInfoTable)
		self.startRecordTag = true
	end

	return
end

function MetaCharacterProxy:getMetaTacticsInfoOnEnd()
	if not self.metaTacticsInfoTableOnStart then
		return false
	end

	local var_18_0 = {}

	for iter_18_0, iter_18_1 in pairs(self.metaTacticsInfoTable) do
		local var_18_1 = iter_18_1.shipID
		local var_18_2 = self.metaTacticsInfoTable[iter_18_1.shipID]
		local var_18_3 = self.metaTacticsInfoTableOnStart[iter_18_1.shipID] or MetaTacticsInfo.New()

		if var_18_2:isAnyLearning() and var_18_3:isAnyLearning() and not getProxy(BayProxy):getShipById(var_18_1):isAllMetaSkillLevelMax() and not (var_18_3 and var_18_3:isExpMaxPerDay() or false) then
			local var_18_6 = var_18_2.curDayExp - var_18_3.curDayExp
			local var_18_7 = getProxy(BayProxy):getShipById(var_18_1):isSkillLevelMax(var_18_2.curSkillID)
			local var_18_8 = var_18_2.curDayExp - var_18_3.curDayExp > 0 and var_18_7
			local var_18_9 = var_18_2:isExpMaxPerDay()

			if var_18_2.curDayExp - var_18_3.curDayExp > 0 then
				table.insert(var_18_0, {
					shipID = var_18_1,
					addDayExp = var_18_6,
					isUpLevel = var_18_8,
					isMaxLevel = var_18_7,
					isExpMax = var_18_9,
					progressOld = var_18_3.curDayExp / pg.gameset.meta_skill_exp_max.key_value,
					progressNew = var_18_2.curDayExp / pg.gameset.meta_skill_exp_max.key_value
				})
			end
		end
	end

	self:clearMetaTacticsInfoRecord()

	return var_18_0
end

function MetaCharacterProxy:clearMetaTacticsInfoRecord()
	self.metaTacticsInfoTableOnStart = nil
	self.startRecordTag = false

	return
end

function MetaCharacterProxy:setMetaSkillLevelMaxInfo(arg_20_1, arg_20_2)
	local var_20_0 = arg_20_2.skill_id
	local var_20_4 = getProxy(BayProxy):getShipById(arg_20_2.ship_id)

	if var_20_4:getMetaSkillLevelBySkillID(arg_20_2.skill_id) < arg_20_2.skill_level and pg.skill_data_template[arg_20_2.skill_id].max_level <= arg_20_2.skill_level then
		local var_20_5 = {
			metaShipVO = var_20_4,
			metaSkillID = var_20_0
		}
		local var_20_6 = false

		for iter_20_0, iter_20_1 in pairs(arg_20_1) do
			if iter_20_1.metaShipVO.configId == var_20_5.metaShipVO.configId then
				var_20_6 = true

				break
			end
		end

		if not var_20_6 then
			table.insert(arg_20_1, var_20_5)
		end
	end

	return
end

function MetaCharacterProxy:getMetaSkillLevelMaxInfoList()
	return self.metaSkillLevelMaxInfoList or {}
end

function MetaCharacterProxy:clearMetaSkillLevelMaxInfoList()
	self.metaSkillLevelMaxInfoList = nil

	return
end

function MetaCharacterProxy:tryRemoveMetaSkillLevelMaxInfo(arg_23_1, arg_23_2)
	if self.metaSkillLevelMaxInfoList and #self.metaSkillLevelMaxInfoList > 0 then
		local var_23_0

		for iter_23_0, iter_23_1 in ipairs(self.metaSkillLevelMaxInfoList) do
			if arg_23_1 == iter_23_1.metaShipVO.id and arg_23_2 ~= iter_23_1.metaShipVO.metaSkillID then
				var_23_0 = iter_23_0

				break
			end
		end

		if var_23_0 then
			table.remove(self.metaSkillLevelMaxInfoList, var_23_0)
		end
	end

	return
end

function MetaCharacterProxy:setLastMetaSkillExpInfo(arg_24_1, arg_24_2)
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

function MetaCharacterProxy:getLastMetaSkillExpInfoList()
	return self.lastMetaSkillExpInfoList or {}
end

function MetaCharacterProxy:clearLastMetaSkillExpInfoList()
	self.lastMetaSkillExpInfoList = nil

	return
end

function MetaCharacterProxy:setMetaIDMark(arg_27_1)
	self.metaIDMark[arg_27_1] = (self.metaIDMark[arg_27_1] or -1) + 1

	return
end

function MetaCharacterProxy:getMetaIDMark(arg_28_1)
	return self.metaIDMark[arg_28_1]
end

return MetaCharacterProxy
