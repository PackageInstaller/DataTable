local NavalAcademyProxy = class("NavalAcademyProxy", import(".NetProxy"))

NavalAcademyProxy.COURSE_START = "NavalAcademyProxy:COURSE_START"
NavalAcademyProxy.COURSE_UPDATED = "NavalAcademyProxy:COURSE_UPDATED"
NavalAcademyProxy.COURSE_REWARD = "NavalAcademyProxy:COURSE_REWARD"
NavalAcademyProxy.COURSE_CANCEL = "NavalAcademyProxy:COURSE_CANCEL"
NavalAcademyProxy.RESOURCE_UPGRADE = "NavalAcademyProxy:RESOURCE_UPGRADE"
NavalAcademyProxy.RESOURCE_UPGRADE_DONE = "NavalAcademyProxy:RESOURCE_UPGRADE_DONE"
NavalAcademyProxy.BUILDING_FINISH = "NavalAcademyProxy:BUILDING_FINISH"
NavalAcademyProxy.START_LEARN_TACTICS = "NavalAcademyProxy:START_LEARN_TACTICS"
NavalAcademyProxy.CANCEL_LEARN_TACTICS = "NavalAcademyProxy:CANCEL_LEARN_TACTICS"
NavalAcademyProxy.SKILL_CLASS_POS_UPDATED = "NavalAcademyProxy:SKILL_CLASS_POS_UPDATED"

function NavalAcademyProxy:register()
	self.timers = {}
	self.students = {}
	self.course = AcademyCourse.New()
	self.recentShips = {}

	self:on(22001, function(arg_2_0)
		local var_2_0 = OilResourceField.New()

		var_2_0:SetLevel(arg_2_0.oil_well_level)
		var_2_0:SetUpgradeTimeStamp(arg_2_0.oil_well_lv_up_time)

		self._oilVO = var_2_0

		local var_2_1 = GoldResourceField.New()

		var_2_1:SetLevel(arg_2_0.gold_well_level)
		var_2_1:SetUpgradeTimeStamp(arg_2_0.gold_well_lv_up_time)

		self._goldVO = var_2_1

		local var_2_2 = ClassResourceField.New()

		var_2_2:SetLevel(arg_2_0.class_lv)
		var_2_2:SetUpgradeTimeStamp(arg_2_0.class_lv_up_time)

		self._classVO = var_2_2

		self.course:update(arg_2_0.class)

		local var_2_3 = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.skill_class_list) do
			local var_2_4 = Student.New(iter_2_1)

			var_2_3[var_2_4.id] = var_2_4
		end

		self.skillClassNum = LOCK_CLASSROOM and 2 or arg_2_0.skill_class_num or 2

		self:setStudents(var_2_3)
		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inClass")
		self:CheckResFields()

		self.dailyFinsihCnt = arg_2_0.daily_finish_buff_cnt or 0

		return
	end)
	self:on(22013, function(arg_3_0)
		self.course:SetProficiency(arg_3_0.proficiency)

		local var_3_0 = getProxy(PlayerProxy):getData()

		var_3_0.expField = arg_3_0.exp_in_well

		getProxy(PlayerProxy):updatePlayer(var_3_0)
		self:sendNotification(NavalAcademyProxy.COURSE_UPDATED)

		return
	end)

	return
end

function NavalAcademyProxy:timeCall()
	return {
		[ProxyRegister.DayCall] = function(arg_5_0)
			self:setCourse(self.course)
			self:sendNotification(GAME.CLASS_FORCE_UPDATE)
			getProxy(NavalAcademyProxy):resetUsedDailyFinishCnt()

			return
		end
	}
end

function NavalAcademyProxy:GetRecentShips()
	if #self.recentShips > 0 then
		for iter_6_0 = #self.recentShips, 1, -1 do
			local var_6_0 = getProxy(BayProxy):RawGetShipById(self.recentShips[iter_6_0])

			if not var_6_0 or _.all(var_6_0:getSkillList(), function(arg_7_0)
				return ShipSkill.New(var_6_0.skills[arg_7_0]):IsMaxLevel()
			end) then
				table.remove(self.recentShips, iter_6_0)
			end
		end

		return self.recentShips
	end

	for iter_6_1, iter_6_2 in ipairs((string.split(PlayerPrefs.GetString("NavTacticsRecentShipId" .. getProxy(PlayerProxy):getRawData().id), "#"))) do
		local var_6_1 = tonumber(iter_6_2) or 0

		if var_6_1 > 0 then
			local var_6_2 = getProxy(BayProxy):RawGetShipById(var_6_1)

			if var_6_2 and not table.contains(self.recentShips, var_6_1) and _.any(var_6_2:getSkillList(), function(arg_8_0)
				return not ShipSkill.New(var_6_2.skills[arg_8_0]):IsMaxLevel()
			end) then
				table.insert(self.recentShips, var_6_1)
			end
		end
	end

	return self.recentShips
end

function NavalAcademyProxy:SaveRecentShip(arg_9_1)
	if not table.contains(self.recentShips, arg_9_1) then
		table.insert(self.recentShips, arg_9_1)

		for iter_9_0 = 1, #self.recentShips - 11 do
			table.remove(self.recentShips, iter_9_0)
		end

		PlayerPrefs.SetString("NavTacticsRecentShipId" .. getProxy(PlayerProxy):getRawData().id, (table.concat(self.recentShips, "#")))
		PlayerPrefs.Save()
	end

	return
end

function NavalAcademyProxy:getSkillClassNum()
	return self.skillClassNum
end

NavalAcademyProxy.MAX_SKILL_CLASS_NUM = 4

function NavalAcademyProxy:inCreaseKillClassNum()
	self.skillClassNum = math.min(self.skillClassNum + 1, NavalAcademyProxy.MAX_SKILL_CLASS_NUM)

	self:sendNotification(NavalAcademyProxy.SKILL_CLASS_POS_UPDATED, self.skillClassNum)

	return
end

function NavalAcademyProxy:onRemove()
	for iter_12_0, iter_12_1 in pairs(self.timers) do
		iter_12_1:Stop()
	end

	self.timers = nil

	NavalAcademyProxy.super.onRemove(self)

	return
end

function NavalAcademyProxy:ExistStudent(arg_13_1)
	return self.students[arg_13_1] ~= nil
end

function NavalAcademyProxy:getStudentById(arg_14_1)
	if self.students[arg_14_1] then
		return self.students[arg_14_1]:clone()
	end

	return
end

function NavalAcademyProxy:getStudentIdByShipId(arg_15_1)
	for iter_15_0, iter_15_1 in pairs(self.students) do
		if iter_15_1.shipId == arg_15_1 then
			return iter_15_1.id
		end
	end

	return
end

function NavalAcademyProxy:getStudentByShipId(arg_16_1)
	for iter_16_0, iter_16_1 in pairs(self.students) do
		if iter_16_1.shipId == arg_16_1 then
			return iter_16_1
		end
	end

	return
end

function NavalAcademyProxy:setStudents(arg_17_1)
	self.students = arg_17_1

	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inTactics")

	return
end

function NavalAcademyProxy:getStudents()
	return Clone(self.students)
end

function NavalAcademyProxy:RawGetStudentList()
	return self.students
end

function NavalAcademyProxy:addStudent(arg_20_1)
	self.students[arg_20_1.id] = arg_20_1

	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inTactics")
	self:sendNotification(NavalAcademyProxy.START_LEARN_TACTICS, Clone(arg_20_1))

	return
end

function NavalAcademyProxy:updateStudent(arg_21_1)
	self.students[arg_21_1.id] = arg_21_1

	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inTactics")

	return
end

function NavalAcademyProxy:deleteStudent(arg_22_1)
	self.students[arg_22_1] = nil

	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inTactics")
	self:sendNotification(NavalAcademyProxy.CANCEL_LEARN_TACTICS, arg_22_1)

	return
end

function NavalAcademyProxy:GetOilVO()
	return self._oilVO
end

function NavalAcademyProxy:GetGoldVO()
	return self._goldVO
end

function NavalAcademyProxy:GetClassVO()
	return self._classVO
end

function NavalAcademyProxy:getCourse()
	return Clone(self.course)
end

function NavalAcademyProxy:setCourse(arg_27_1)
	self.course = arg_27_1

	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inClass")

	return
end

function NavalAcademyProxy:GetShipIDs()
	return {}
end

function NavalAcademyProxy:CheckResFields()
	if self._oilVO:IsStarting() then
		self:AddResFieldListener(self._oilVO)
	end

	if self._goldVO:IsStarting() then
		self:AddResFieldListener(self._goldVO)
	end

	if self._classVO:IsStarting() then
		self:AddResFieldListener(self._classVO)
	end

	return
end

function NavalAcademyProxy:StartUpGradeSuccess(arg_30_1)
	arg_30_1:SetUpgradeTimeStamp(pg.TimeMgr.GetInstance():GetServerTime() + arg_30_1:bindConfigTable()[arg_30_1:GetLevel()].time)
	self:AddResFieldListener(arg_30_1)
	self.facade:sendNotification(NavalAcademyProxy.RESOURCE_UPGRADE, {
		resVO = arg_30_1
	})

	return
end

function NavalAcademyProxy:AddResFieldListener(arg_31_1)
	local var_31_0 = arg_31_1._upgradeTimeStamp - pg.TimeMgr.GetInstance():GetServerTime()

	if var_31_0 > 0 then
		local var_31_1 = arg_31_1:GetUpgradeType()

		if self.timers[var_31_1] then
			self.timers[var_31_1]:Stop()

			self.timers[var_31_1] = nil
		end

		self.timers[var_31_1] = Timer.New(function()
			self:UpgradeFinish()
			self.timers[var_31_1]:Stop()

			self.timers[var_31_1] = nil

			return
		end, var_31_0, 1)

		self.timers[var_31_1]:Start()
	end

	return
end

function NavalAcademyProxy:UpgradeFinish()
	if self._goldVO:GetDuration() and self._goldVO:GetDuration() <= 0 then
		self._goldVO:SetLevel(self._goldVO:GetLevel() + 1)
		self._goldVO:SetUpgradeTimeStamp(0)
		self:sendNotification(NavalAcademyProxy.RESOURCE_UPGRADE_DONE, {
			field = self._goldVO,
			value = self._goldVO:bindConfigTable()[self._goldVO:GetLevel()].store - self._goldVO:bindConfigTable()[self._goldVO:GetLevel()].store
		})
	end

	if self._oilVO:GetDuration() and self._oilVO:GetDuration() <= 0 then
		self._oilVO:SetLevel(self._oilVO:GetLevel() + 1)
		self._oilVO:SetUpgradeTimeStamp(0)
		self:sendNotification(NavalAcademyProxy.RESOURCE_UPGRADE_DONE, {
			field = self._oilVO,
			value = self._oilVO:bindConfigTable()[self._oilVO:GetLevel()].store - self._oilVO:bindConfigTable()[self._oilVO:GetLevel()].store
		})
	end

	if self._classVO:GetDuration() and self._classVO:GetDuration() <= 0 then
		self._classVO:SetLevel(self._classVO:GetLevel() + 1)
		self._classVO:SetUpgradeTimeStamp(0)
		self:sendNotification(NavalAcademyProxy.RESOURCE_UPGRADE_DONE, {
			field = self._classVO,
			value = self._classVO:bindConfigTable()[self._classVO:GetLevel()].store - self._classVO:bindConfigTable()[self._classVO:GetLevel()].store,
			rate = self._classVO:bindConfigTable()[self._classVO:GetLevel()].proficency_get_percent - self._classVO:bindConfigTable()[self._classVO:GetLevel()].proficency_get_percent,
			exp = (self._classVO:bindConfigTable()[self._classVO:GetLevel()].proficency_cost_per_min - self._classVO:bindConfigTable()[self._classVO:GetLevel()].proficency_cost_per_min) * 60
		})
	end

	return
end

function NavalAcademyProxy:isResourceFieldUpgradeConditionSatisfy()
	local var_34_0 = getProxy(PlayerProxy):getData()

	if not self:GetOilVO():CanUpgrade(var_34_0.level, var_34_0.gold) then
		if not self:GetGoldVO():CanUpgrade(var_34_0.level, var_34_0.gold) then
			if self:GetClassVO():CanUpgrade(var_34_0.level, var_34_0.gold) then
				return true
			end
		end
	end

	return false
end

function NavalAcademyProxy:AddCourseProficiency(arg_35_1)
	local var_35_0 = self:getCourse()
	local var_35_1 = self:GetClassVO()

	var_35_0:SetProficiency((math.min(var_35_0:GetProficiency() + math.floor(arg_35_1 * (var_35_1:GetExp2ProficiencyRatio() * var_35_0:getExtraRate()) * 0.01), var_35_1:GetMaxProficiency())))
	self:setCourse(var_35_0)

	return
end

function NavalAcademyProxy:AddProficiency(arg_36_1)
	local var_36_0 = self:getCourse()

	var_36_0:SetProficiency(math.min(var_36_0:GetProficiency() + arg_36_1, self:GetClassVO():GetMaxProficiency()))
	self:setCourse(var_36_0)

	return
end

function NavalAcademyProxy:fillStudens(arg_37_1)
	local var_37_0 = pg.gameset.academy_random_ship_count.key_value
	local var_37_1 = {}

	for iter_37_0, iter_37_1 in pairs(arg_37_1) do
		var_37_1[iter_37_1.groupId] = true
		var_37_0 = var_37_0 - 1
	end

	if not self._timeStamp or pg.gameset.academy_random_ship_coldtime.key_value < os.time() - self._timeStamp then
		self._studentsFiller = nil
	end

	if not self._studentsFiller then
		local var_37_2 = math.random(1, var_37_0)

		self._timeStamp = os.time()
		self._studentsFiller = {}

		local var_37_3 = getProxy(CollectionProxy):getGroups()
		local var_37_4 = getProxy(BayProxy)
		local var_37_5 = getProxy(ShipSkinProxy):getSkinList()
		local var_37_6 = {}

		for iter_37_2, iter_37_3 in pairs(var_37_3) do
			if not table.contains(var_37_1, iter_37_2) then
				var_37_6[#var_37_6 + 1] = iter_37_2
			end
		end

		while var_37_2 > 0 and #var_37_6 > 0 do
			local var_37_7 = math.random(#var_37_6)
			local var_37_9
			local var_37_10 = {}

			for iter_37_4, iter_37_5 in ipairs((ShipGroup.getSkinList(var_37_6[var_37_7]))) do
				if iter_37_5.skin_type == ShipSkin.SKIN_TYPE_DEFAULT or table.contains(var_37_5, iter_37_5.id) or iter_37_5.skin_type == ShipSkin.SKIN_TYPE_REMAKE and var_37_3[var_37_6[var_37_7]].trans or iter_37_5.skin_type == ShipSkin.SKIN_TYPE_PROPOSE and var_37_3[var_37_6[var_37_7]].married == 1 then
					var_37_10[#var_37_10 + 1] = iter_37_5.id
				end

				var_37_9 = var_37_10[math.random(#var_37_10)]
			end

			local var_37_11 = {
				id = 10000000000 + (var_37_6[var_37_7] * 10 + 1),
				groupId = var_37_6[var_37_7],
				configId = var_37_6[var_37_7] * 10 + 1,
				skin_id = var_37_9
			}

			table.remove(var_37_6, var_37_7)

			var_37_2 = var_37_2 - 1
			self._studentsFiller[#self._studentsFiller + 1] = var_37_11
		end
	end

	for iter_37_6, iter_37_7 in ipairs(self._studentsFiller) do
		arg_37_1[#arg_37_1 + 1] = Ship.New(iter_37_7)
	end

	return arg_37_1
end

function NavalAcademyProxy:IsShowTip()
	local var_38_0 = getProxy(PlayerProxy)

	if var_38_0 and var_38_0:getData() and self:isResourceFieldUpgradeConditionSatisfy() then
		return true
	end

	local var_38_1 = getProxy(ShopsProxy)

	if var_38_1 then
		local var_38_2 = var_38_1:getShopStreet()

		if var_38_2 and var_38_2:isUpdateGoods() then
			return true
		end
	end

	local var_38_3 = pg.TimeMgr.GetInstance():GetServerTime()

	for iter_38_0, iter_38_1 in pairs(self.students) do
		if var_38_3 >= iter_38_1:getFinishTime() then
			return true
		end
	end

	if getProxy(CollectionProxy):unclaimTrophyCount() > 0 then
		return true
	end

	local var_38_4 = getProxy(TaskProxy)

	if _.any(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_TASK_LIST), function(arg_39_0)
		local var_39_0 = arg_39_0:getTaskShip()
		local var_39_1 = var_39_0 and var_38_4:getAcademyTask(var_39_0.groupId) or nil
		local var_39_2 = var_38_4:getTaskById(var_39_1)

		return var_39_0 and (var_39_1 and not var_39_2 and not var_38_4:getFinishTaskById(var_39_1) or var_39_2 and var_39_2:isFinish())
	end) then
		return true
	end

	return false
end

function NavalAcademyProxy:getDailyFinishCnt()
	local var_40_0 = _.detect(BuffHelper.GetBuffsByActivityType(ActivityConst.ACTIVITY_TYPE_BUFF), function(arg_41_0)
		return arg_41_0:getConfig("benefit_type") == "skill_learn_time"
	end)

	return (var_40_0 and tonumber(var_40_0:getConfig("benefit_effect")) or 0) - self.dailyFinsihCnt
end

function NavalAcademyProxy:updateUsedDailyFinishCnt()
	self.dailyFinsihCnt = self.dailyFinsihCnt + 1

	return
end

function NavalAcademyProxy:resetUsedDailyFinishCnt()
	self.dailyFinsihCnt = 0

	return
end

return NavalAcademyProxy
