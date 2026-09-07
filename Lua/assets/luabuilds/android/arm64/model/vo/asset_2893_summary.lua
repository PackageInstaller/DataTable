local Summary = class("Summary", import(".BaseVO"))

function Summary:Ctor(arg_1_1)
	local var_1_0 = pg.TimeMgr.GetInstance()

	self.name = getProxy(PlayerProxy):getData().name
	self.registerTime = var_1_0:STimeDescC(arg_1_1.register_date, "%Y.%m.%d")

	local var_1_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_SUMMARY):getStartTime()

	self.days = math.max(math.ceil((var_1_1 - arg_1_1.register_date) / 0), 0) + 1

	local var_1_2 = getProxy(UserProxy):getRawData()

	if getProxy(ServerProxy):getRawData()[(var_1_2 or nil) and (var_1_2.server or 0)] then
		self.serverName = getProxy(ServerProxy):getRawData()[(var_1_2 or nil) and (var_1_2.server or 0)].name or ""
	end

	local var_1_3 = pg.chapter_template[math.max(arg_1_1.chapter_id, 101)]

	self.chapterName = var_1_3.chapter_name .. " " .. var_1_3.name
	self.guildName = arg_1_1.guild_name
	self.proposeCount = arg_1_1.marry_number
	self.medalCount = arg_1_1.medal_number
	self.furnitureCount = arg_1_1.furniture_number
	self.furnitureWorth = arg_1_1.furniture_worth
	self.flagShipId = arg_1_1.character_id
	self.firstLadyId = arg_1_1.first_lady_id
	self.isProPose = self.proposeCount > 0
	self.firstProposeName = ""

	if self.firstLadyId > 0 then
		self.firstProposeName = Ship.New({
			configId = self.firstLadyId
		}):getConfig("name")
	end

	if arg_1_1.first_lady_name ~= "" then
		self.firstProposeName = arg_1_1.first_lady_name
	end

	self.proposeTime = math.ceil((var_1_1 - arg_1_1.first_lady_time) / 0) + 1
	self.firstLadyTime = var_1_0:STimeDescC(arg_1_1.first_lady_time, "%Y-%m-%d %H:%M")
	self.unMarryShipId = 100001

	local var_1_4 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_SUMMARY)

	self.furnitures = {}

	for iter_1_0, iter_1_1 in pairs(getProxy(DormProxy):getRawData().furnitures) do
		self.furnitures[iter_1_1.id] = iter_1_1
	end

	self.medalList = underscore.filter(var_1_4:getConfig("config_data"), function(arg_2_0)
		return tobool(self.furnitures[arg_2_0])
	end)

	local var_1_5 = getProxy(AttireProxy)

	self.iconFrameList = underscore.filter(var_1_4:getConfig("config_client")[1], function(arg_3_0)
		return var_1_5:getAttireFrame(AttireConst.TYPE_ICON_FRAME, arg_3_0[1]):isOwned()
	end)
	self.worldProgressTask = arg_1_1.world_max_task
	self.collectionNum = string.format("%0.1f", arg_1_1.collect_num / var_1_4:getConfig("config_client")[2] * 100)
	self.powerRaw = math.floor(arg_1_1.combat^0.667)
	self.totalShipNum = arg_1_1.ship_num_total
	self.topShipNum = arg_1_1.ship_num_120
	self.bestShipNum = arg_1_1.ship_num_125
	self.maxIntimacyNum = arg_1_1.love200_num
	self.skinNum = arg_1_1.skin_num
	self.skinShipNum = arg_1_1.skin_ship_num
	self.skinId = 0

	local var_1_6 = {}

	for iter_1_2, iter_1_3 in ipairs(getProxy(ShipSkinProxy):GetShopShowingSkins()) do
		if iter_1_3.buyCount > 0 then
			var_1_6[iter_1_3:getSkinId()] = true
		end
	end

	local var_1_7 = getProxy(BayProxy)

	for iter_1_4, iter_1_5 in ipairs(getProxy(PlayerProxy):getRawData().characters) do
		local var_1_8 = var_1_7:getShipById(iter_1_5)

		if var_1_8 and var_1_6[var_1_8.skinId] then
			self.skinId = var_1_8:getSkinId()

			break
		end
	end

	if self.skinId == 0 then
		local var_1_9 = underscore.keys(var_1_6)

		if #var_1_9 > 0 then
			self.skinId = var_1_9[math.max(1, math.ceil(math.random() * #var_1_9))]
		end
	end

	return
end

function Summary:hasGuild()
	return self.guildName and self.guildName ~= ""
end

function Summary:hasMedal()
	return self.medalCount > 0
end

return Summary
