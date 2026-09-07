local CollectionProxy = class("CollectionProxy", import(".NetProxy"))

CollectionProxy.AWARDS_UPDATE = "awards update"
CollectionProxy.GROUP_INFO_UPDATE = "group info update"
CollectionProxy.GROUP_EVALUATION_UPDATE = "group evaluation update"
CollectionProxy.TROPHY_UPDATE = "trophy update"
CollectionProxy.MAX_DAILY_EVA_COUNT = 1
CollectionProxy.KEY_17001_TIME_STAMP = "KEY_17001_TIME_STAMP"

function CollectionProxy:register()
	self.shipGroups = {}
	self.awards = {}
	self.trophy = {}
	self.trophyGroup = {}
	self.dailyEvaCount = 0

	self:on(17001, function(arg_2_0)
		self.shipGroups = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.ship_info_list) do
			self.shipGroups[iter_2_1.id] = ShipGroup.New(iter_2_1)
		end

		for iter_2_2, iter_2_3 in ipairs(arg_2_0.transform_list) do
			if self.shipGroups[iter_2_3] then
				self.shipGroups[iter_2_3].trans = true
			end
		end

		self.awards = {}

		for iter_2_4, iter_2_5 in ipairs(arg_2_0.ship_award_list) do
			table.sort(iter_2_5.award_index)

			self.awards[iter_2_5.id] = iter_2_5.award_index[#iter_2_5.award_index]
		end

		for iter_2_6, iter_2_7 in ipairs(arg_2_0.progress_list) do
			self.trophy[iter_2_7.id] = Trophy.New(iter_2_7)
		end

		self:bindTrophyGroup()
		self:bindComplexTrophy()
		self:hiddenTrophyAutoClaim()
		self:updateTrophy()

		return
	end)
	self:on(17002, function(arg_3_0)
		for iter_3_0, iter_3_1 in ipairs(arg_3_0.progress_list) do
			local var_3_0 = false
			local var_3_1 = iter_3_1.id

			if self.trophy[iter_3_1.id] then
				local var_3_2 = self.trophy[var_3_1]:canClaimed()

				self.trophy[var_3_1]:update(iter_3_1)

				if not self.trophy[var_3_1]:isHide() and var_3_2 ~= self.trophy[var_3_1]:canClaimed() then
					var_3_0 = true
				end
			else
				self.trophy[var_3_1] = Trophy.New(iter_3_1)

				if self.trophy[var_3_1]:canClaimed() then
					var_3_0 = true
				end
			end

			if var_3_0 then
				self:dispatchClaimRemind(var_3_1)
			end
		end

		self:hiddenTrophyAutoClaim()
		self:updateTrophy()

		return
	end)
	self:on(17004, function(arg_4_0)
		self.shipGroups[arg_4_0.ship_info.id] = ShipGroup.New(arg_4_0.ship_info)

		return
	end)

	return
end

function CollectionProxy:timeCall()
	return {
		[ProxyRegister.DayCall] = function(arg_6_0)
			self:resetEvaCount()

			return
		end
	}
end

function CollectionProxy:resetEvaCount()
	for iter_7_0, iter_7_1 in pairs(self.shipGroups) do
		if iter_7_1.evaluation then
			iter_7_1.evaluation.ievaCount = 0
		end
	end

	return
end

function CollectionProxy:updateDailyEvaCount(arg_8_1)
	self.dailyEvaCount = arg_8_1

	return
end

function CollectionProxy:updateAward(arg_9_1, arg_9_2)
	self.awards[arg_9_1] = arg_9_2

	self:sendNotification(CollectionProxy.AWARDS_UPDATE, Clone(self.awards))

	return
end

function CollectionProxy:getShipGroup(arg_10_1)
	return Clone(self.shipGroups[arg_10_1])
end

function CollectionProxy:updateShipGroup(arg_11_1)
	assert(arg_11_1, "update ship group: group cannot be nil.")

	self.shipGroups[arg_11_1.id] = Clone(arg_11_1)

	return
end

function CollectionProxy:getGroups()
	return Clone(self.shipGroups)
end

function CollectionProxy:RawgetGroups()
	return self.shipGroups
end

function CollectionProxy:getAwards()
	return Clone(self.awards)
end

function CollectionProxy:hasFinish()
	for iter_15_0, iter_15_1 in ipairs(pg.storeup_data_template.all) do
		if Favorite.New({
			id = iter_15_1
		}):canGetRes(self.shipGroups, self.awards) then
			return true
		end
	end

	return false
end

function CollectionProxy:getCollectionRate()
	local var_16_0 = self:getCollectionCount()
	local var_16_1 = self:getCollectionTotal()

	return string.format("%0.3f", var_16_0 / var_16_1), var_16_0, var_16_1
end

function CollectionProxy:getCollectionCount()
	return _.reduce(_.values(self.shipGroups), 0, function(arg_18_0, arg_18_1)
		return arg_18_0 + (Nation.IsLinkType(arg_18_1:getNation()) and 0 or arg_18_1.trans and 2 or 1)
	end)
end

function CollectionProxy:getCollectionTotal()
	return _.reduce(pg.ship_data_group.all, 0, function(arg_20_0, arg_20_1)
		return arg_20_0 + (Nation.IsLinkType(ShipGroup.getDefaultShipConfig(pg.ship_data_group[arg_20_1].group_type).nationality) and 0 or 1)
	end) + #pg.ship_data_trans.all
end

function CollectionProxy:getLinkCollectionCount()
	return _.reduce(_.values(self.shipGroups), 0, function(arg_22_0, arg_22_1)
		return arg_22_0 + (Nation.IsLinkType(arg_22_1:getNation()) and 1 or 0)
	end)
end

function CollectionProxy:flushCollection(arg_23_1)
	local var_23_0 = self:getShipGroup(arg_23_1.groupId)
	local var_23_1

	if not var_23_0 then
		var_23_0 = ShipGroup.New({
			heart_flag = 0,
			heart_count = 0,
			lv_max = 1,
			id = arg_23_1.groupId,
			star = arg_23_1:getStar(),
			marry_flag = arg_23_1.propose and 1 or 0,
			intimacy_max = arg_23_1.intimacy
		})

		if OPEN_TEC_TREE_SYSTEM and table.indexof(pg.fleet_tech_ship_template.all, arg_23_1.groupId, 1) then
			var_23_1 = true
		end
	else
		if OPEN_TEC_TREE_SYSTEM and table.indexof(pg.fleet_tech_ship_template.all, arg_23_1.groupId, 1) then
			if var_23_0.star < arg_23_1:getStar() and arg_23_1:getStar() == pg.fleet_tech_ship_template[arg_23_1.groupId].max_star then
				var_23_1 = true

				pg.ToastMgr.GetInstance():ShowToast(pg.ToastMgr.TYPE_TECPOINT, {
					point = pg.fleet_tech_ship_template[arg_23_1.groupId].pt_upgrage
				})
			end

			if var_23_0.maxLV < arg_23_1.level and arg_23_1.level == TechnologyConst.SHIP_LEVEL_FOR_BUFF then
				var_23_1 = true

				pg.ToastMgr.GetInstance():ShowToast(pg.ToastMgr.TYPE_TECPOINT, {
					point = pg.fleet_tech_ship_template[arg_23_1.groupId].pt_level,
					typeList = ShipType.FilterOverQuZhuType(pg.fleet_tech_ship_template[arg_23_1.groupId].add_level_shiptype),
					attr = pg.fleet_tech_ship_template[arg_23_1.groupId].add_level_attr,
					value = pg.fleet_tech_ship_template[arg_23_1.groupId].add_level_value
				})
			end
		end

		var_23_0.star = math.max(var_23_0.star, arg_23_1:getStar())
		var_23_0.maxIntimacy = math.max(var_23_0.maxIntimacy, arg_23_1.intimacy)
		var_23_0.married = math.max(var_23_0.married, arg_23_1.propose and 1 or 0)
		var_23_0.maxLV = math.max(var_23_0.maxLV, arg_23_1.level)
	end

	self:updateShipGroup(var_23_0)

	if var_23_1 then
		getProxy(TechnologyNationProxy):flushData()
	end

	return
end

function CollectionProxy:updateTrophyClaim(arg_24_1, arg_24_2)
	self.trophy[arg_24_1]:updateTimeStamp(arg_24_2)

	return
end

function CollectionProxy:unlockNewTrophy(arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
		self.trophy[iter_25_1.id] = iter_25_1
	end

	self:bindTrophyGroup()
	self:bindComplexTrophy()
	self:hiddenTrophyAutoClaim()

	return
end

function CollectionProxy:getTrophyGroup()
	return Clone(self.trophyGroup)
end

function CollectionProxy:getTrophys()
	for iter_27_0, iter_27_1 in pairs(self.trophy) do
		iter_27_1:clearNew()
	end

	return (Clone(self.trophy))
end

function CollectionProxy:GetTrophyById(arg_28_1)
	return self.trophy[arg_28_1]
end

function CollectionProxy:hiddenTrophyAutoClaim()
	for iter_29_0, iter_29_1 in pairs(self.trophy) do
		if iter_29_1:getHideType() ~= Trophy.ALWAYS_SHOW and iter_29_1:getHideType() ~= Trophy.COMING_SOON and iter_29_1:canClaimed() and not iter_29_1:isClaimed() then
			self:sendNotification(GAME.TROPHY_CLAIM, {
				trophyID = iter_29_0
			})
		end
	end

	return
end

function CollectionProxy:unclaimTrophyCount()
	local var_30_0 = 0

	for iter_30_0, iter_30_1 in pairs(self.trophy) do
		if iter_30_1:getHideType() == Trophy.ALWAYS_SHOW and iter_30_1:canClaimed() and not iter_30_1:isClaimed() then
			var_30_0 = var_30_0 + 1
		end
	end

	return var_30_0
end

function CollectionProxy:updateTrophy()
	self:sendNotification(CollectionProxy.TROPHY_UPDATE, Clone(self.trophy))

	return
end

function CollectionProxy:dispatchClaimRemind(arg_32_1)
	pg.ToastMgr.GetInstance():ShowToast(pg.ToastMgr.TYPE_TROPHY, {
		id = arg_32_1
	})

	return
end

function CollectionProxy:bindComplexTrophy()
	for iter_33_0, iter_33_1 in pairs(self.trophyGroup) do
		for iter_33_2, iter_33_3 in pairs((iter_33_1:getTrophyList())) do
			if iter_33_3:isComplexTrophy() then
				for iter_33_4, iter_33_5 in ipairs(iter_33_3:getTargetID()) do
					iter_33_3:bindTrophys(self.trophy[iter_33_5] or Trophy.generateDummyTrophy(iter_33_5))
				end
			end
		end
	end

	return
end

function CollectionProxy:bindTrophyGroup()
	for iter_34_0, iter_34_1 in ipairs(pg.medal_template.all) do
		if pg.medal_template[iter_34_1].hide == Trophy.ALWAYS_SHOW then
			local var_34_0 = math.floor(iter_34_1 / 10)

			self.trophyGroup[var_34_0] = self.trophyGroup[var_34_0] or TrophyGroup.New(var_34_0)

			local var_34_1 = self.trophyGroup[var_34_0]

			if self.trophy[iter_34_1] then
				var_34_1:addTrophy(self.trophy[iter_34_1])
			else
				var_34_1:addDummyTrophy(iter_34_1)
			end
		end
	end

	for iter_34_2, iter_34_3 in pairs(self.trophyGroup) do
		iter_34_3:sortGroup()
	end

	table.sort(self.trophyGroup, function(arg_35_0, arg_35_1)
		return arg_35_0:getGroupID() < arg_35_1:getGroupID()
	end)

	return
end

return CollectionProxy
