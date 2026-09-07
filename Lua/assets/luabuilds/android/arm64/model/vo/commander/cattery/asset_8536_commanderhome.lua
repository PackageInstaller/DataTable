local CommanderHome = class("CommanderHome", import("...BaseVO"))

function CommanderHome:Ctor(arg_1_1)
	self.level = arg_1_1.level
	self.configId = self.level
	self.exp = arg_1_1.exp
	self.catterys = {}
	self.unlockCatteryId = 1
	self.clean = arg_1_1.clean or 0

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.slots) do
		self.catterys[iter_1_1.id] = Cattery.New(self, iter_1_1)

		if iter_1_1.id > self.unlockCatteryId then
			self.unlockCatteryId = iter_1_1.id
		end
	end

	for iter_1_2 = 1, pg.gameset.commander_home_number.key_value do
		self.catterys[iter_1_2] = self.catterys[iter_1_2] or Cattery.New(self, {
			op_flag = 7,
			id = iter_1_2
		})
	end

	return
end

function CommanderHome:bindConfigTable()
	return pg.commander_home
end

function CommanderHome:GetLevel()
	return self.level
end

function CommanderHome:GetMaxLevel()
	local var_4_0 = self:bindConfigTable()

	return var_4_0.all[#var_4_0.all]
end

function CommanderHome:IsMaxLevel()
	return self:GetMaxLevel() <= self.level
end

function CommanderHome:AddExp(arg_6_1)
	self.exp = self.exp + arg_6_1

	while self:CanUpgrade() do
		local var_6_0 = self:GetNextLevelExp()

		self:LevelUp(self.level + 1)

		self.exp = self.exp - var_6_0
	end

	return
end

function CommanderHome:UpdateExpAndLevel(arg_7_1, arg_7_2)
	if arg_7_1 > self.level then
		self:LevelUp(arg_7_1)
	end

	self.exp = arg_7_2

	return
end

function CommanderHome:LevelUp(arg_8_1)
	self.level = arg_8_1
	self.configId = arg_8_1

	return
end

function CommanderHome:CanUpgrade()
	if self:GetNextLevelExp() <= self.exp and not self:IsMaxLevel() then
		return true
	end

	return false
end

function CommanderHome:GetNextLevelExp()
	return self:getConfig("home_exp")
end

function CommanderHome:GetPrevLevelExp()
	local var_11_0 = self:bindConfigTable()

	return (var_11_0[self.level - 1] or nil) and (var_11_0[self.level - 1].home_exp or 0)
end

function CommanderHome:GetCatteries()
	return self.catterys
end

function CommanderHome:GetCatteryById(arg_13_1)
	return self.catterys[arg_13_1]
end

function CommanderHome:GetAllLevel()
	return self:bindConfigTable().all
end

function CommanderHome:IsHeadLevel(arg_15_1)
	return self:GetAllLevel()[1] == arg_15_1
end

function CommanderHome:isTailLevel(arg_16_1)
	local var_16_0 = self:GetAllLevel()

	return var_16_0[#var_16_0] == arg_16_1
end

function CommanderHome:GetLevelConfig(arg_17_1)
	return self:bindConfigTable()[arg_17_1]
end

function CommanderHome:GetTargetExpForLevel(arg_18_1)
	local var_18_0 = 0

	for iter_18_0 = 1, arg_18_1 - 1 do
		var_18_0 = var_18_0 + self:GetLevelConfig(iter_18_0).home_exp
	end

	return var_18_0
end

function CommanderHome:GetClean()
	return self.clean
end

function CommanderHome:IncCleanValue()
	self.clean = self.clean + self:getConfig("flower")[1]

	return
end

function CommanderHome:ReduceClean()
	local var_21_1 = self:getConfig("flower")[2]

	for iter_21_0, iter_21_1 in pairs((self:GetCatteries())) do
		if iter_21_1:IsDirty() then
			self.clean = self.clean - var_21_1

			break
		end
	end

	return
end

function CommanderHome:GetCleanLevel()
	local var_22_0 = 0

	for iter_22_0, iter_22_1 in ipairs(self:getConfig("flower")[3]) do
		if iter_22_1 <= self.clean then
			var_22_0 = iter_22_0
		end
	end

	return var_22_0
end

function CommanderHome:GetOwnStyles()
	return self:getConfig("nest_appearance")
end

function CommanderHome:GetMaxCatteryCnt()
	return self:getConfig("nest_number")
end

function CommanderHome:GetCatteriesCommanders()
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in pairs(self:GetCatteries()) do
		if iter_25_1:ExistCommander() then
			table.insert(var_25_0, iter_25_1:GetCommanderId())
		end
	end

	return var_25_0
end

function CommanderHome:ResetCatteryOP()
	for iter_26_0, iter_26_1 in pairs((self:GetCatteries())) do
		if iter_26_1:ExistCommander() then
			iter_26_1:ResetOP()
		end
	end

	return
end

function CommanderHome:GetFeedCommanderExp()
	return self:getConfig("feed_level")[2]
end

function CommanderHome:AnyCatteryExistOP()
	for iter_28_0, iter_28_1 in pairs(self:GetCatteries()) do
		if not iter_28_1:IsLocked() and (iter_28_1:ExiseFeedOP() or iter_28_1:ExistPlayOP() or iter_28_1:ExistCleanOP()) then
			return true
		end
	end

	return false
end

function CommanderHome:AnyCatteryCanUse()
	for iter_29_0, iter_29_1 in pairs(self:GetCatteries()) do
		if iter_29_1:GetState() == Cattery.STATE_EMPTY then
			return true
		end
	end

	return false
end

function CommanderHome:GetFeedLevel()
	return self:getConfig("feed_level")[1]
end

function CommanderHome:GetPlayLevel()
	return self:getConfig("teast_level")[1]
end

function CommanderHome:GetExistCommanderCattertCnt()
	local var_32_0 = 0

	for iter_32_0, iter_32_1 in pairs((self:GetCatteries())) do
		if iter_32_1:ExistCommander() then
			var_32_0 = var_32_0 + 1
		end
	end

	return var_32_0
end

function CommanderHome:CommanderInHome(arg_33_1)
	for iter_33_0, iter_33_1 in pairs((self:GetCatteries())) do
		if iter_33_1:GetCommanderId() == arg_33_1 then
			return true
		end
	end

	return false
end

function CommanderHome:ShouldSettleCattery()
	for iter_34_0, iter_34_1 in pairs((self:GetCatteries())) do
		if iter_34_1:ExistCommander() and iter_34_1:ExistCacheExp() then
			return true
		end
	end

	return false
end

return CommanderHome
