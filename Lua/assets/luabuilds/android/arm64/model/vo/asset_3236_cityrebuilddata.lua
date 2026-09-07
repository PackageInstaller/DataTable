local CityRebuildData = class("CityRebuildData", import("..vo.BaseVO"))
local var_0_1 = pg.activity_ninja_city
local var_0_2 = pg.activity_ninja_building
local var_0_3 = pg.activity_ninja_buff

CityRebuildData.Thousand = 1000
CityRebuildData.Million = 1000000
CityRebuildData.Billion = 0
CityRebuildData.MaxGold = 99999999999

function CityRebuildData:Ctor(arg_1_1)
	self.isInited = arg_1_1.is_inited
	self.pt = arg_1_1.pt.k + arg_1_1.pt.m * CityRebuildData.Million + arg_1_1.pt.b * CityRebuildData.Billion
	self.buildings = arg_1_1.builds
	self.roles = arg_1_1.roles
	self.recruiting = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.recruits) do
		self.recruiting[iter_1_1.id] = iter_1_1.start_time
	end

	self.buffs = arg_1_1.buffs
	self.buffLevels = {}

	for iter_1_2, iter_1_3 in ipairs(self.buffs) do
		self.buffLevels[var_0_3[iter_1_3].group] = var_0_3[iter_1_3].level
	end

	self.maxLevel = arg_1_1.max_level
	self.curLevel = arg_1_1.cur_level
	self.maxChooseLevel = arg_1_1.max_display
	self.startTime = arg_1_1.adjust.time
	self.leftHp = arg_1_1.adjust.left_hp.k + arg_1_1.adjust.left_hp.m * CityRebuildData.Million + arg_1_1.adjust.left_hp.b * CityRebuildData.Billion
	self.summaryPt = arg_1_1.summary_pt.k + arg_1_1.summary_pt.m * CityRebuildData.Million + arg_1_1.summary_pt.b * CityRebuildData.Billion
	self.cityLevel = 1
	self.allBuildingIds = {}
	self.allCharaIds = {}

	for iter_1_4, iter_1_5 in ipairs(var_0_2.all) do
		if var_0_2[iter_1_5].type == 1 then
			table.insert(self.allBuildingIds, iter_1_5)
		elseif var_0_2[iter_1_5].type == 2 then
			table.insert(self.allCharaIds, iter_1_5)
		end
	end

	self.unlockBuildingOrCharaIds = Clone(var_0_1[1].include)

	self:TryUpgradeCityLevel(true)

	self.Levelbuildings = {}
	self.Levelcharas = {}

	self:SetLevelDatas()

	return
end

function CityRebuildData:TryUpgradeCityLevel(arg_2_1)
	local var_2_0 = true

	while var_2_0 do
		local var_2_1
		local var_2_2

		for iter_2_0, iter_2_1 in ipairs(var_0_1.all) do
			if var_2_1 then
				var_2_2 = var_0_1[iter_2_1]

				break
			end

			if var_0_1[iter_2_1].level == self.cityLevel then
				var_2_1 = var_0_1[iter_2_1]
			end
		end

		if not var_2_1 or not var_2_2 then
			return
		end

		for iter_2_2, iter_2_3 in ipairs(var_2_1.include) do
			if not table.contains(self.buildings, iter_2_3) and not table.contains(self.roles, iter_2_3) then
				var_2_0 = false

				break
			end
		end

		if var_2_0 then
			self.cityLevel = self.cityLevel + 1

			table.insertto(self.unlockBuildingOrCharaIds, var_2_2.include)

			for iter_2_4, iter_2_5 in ipairs(var_2_2.include) do
				if var_0_2[iter_2_5].default_state == 2 then
					if type == 1 and not table.contains(self.buildings, iter_2_5) then
						table.insert(self.buildings, iter_2_5)
					elseif type == 2 and not table.contains(self.roles, iter_2_5) then
						table.insert(self.roles, iter_2_5)
					end
				end
			end

			if arg_2_1 and var_2_2.story ~= "" then
				pg.NewStoryMgr.GetInstance():Play(var_2_2.story)
			end
		end
	end

	return
end

function CityRebuildData:RebuildDone(arg_3_1)
	table.insert(self.buildings, arg_3_1)
	self:TryUpgradeCityLevel(true)

	return
end

function CityRebuildData:StartRecruit(arg_4_1)
	self.recruiting[arg_4_1] = pg.TimeMgr.GetInstance():GetServerTime()

	return
end

function CityRebuildData:RecruitDone(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		self.recruiting[iter_5_1] = nil

		table.insert(self.roles, iter_5_1)
	end

	self:TryUpgradeCityLevel(true)

	return
end

function CityRebuildData:UpgradeBuff(arg_6_1, arg_6_2)
	table.sort(var_0_3.get_id_list_by_group[arg_6_1], function(arg_7_0, arg_7_1)
		return var_0_3[arg_7_0].level < var_0_3[arg_7_1].level
	end)

	local var_6_0 = 0

	for iter_6_0, iter_6_1 in ipairs(self.buffs) do
		if var_0_3[iter_6_1].group == arg_6_1 then
			var_6_0 = iter_6_1

			table.remove(self.buffs, iter_6_0)

			break
		end
	end

	local var_6_1 = table.indexof(var_0_3.get_id_list_by_group[arg_6_1], var_6_0) + arg_6_2

	table.insert(self.buffs, var_0_3.get_id_list_by_group[arg_6_1][var_6_1])

	self.buffLevels[arg_6_1] = var_6_1

	return
end

function CityRebuildData:Result(arg_8_1)
	self.pt = self.pt + arg_8_1.summary_pt.k + arg_8_1.summary_pt.m * CityRebuildData.Million + arg_8_1.summary_pt.b * CityRebuildData.Billion

	self:Adjust(arg_8_1.adjust)

	self.summaryPt = 0

	return
end

function CityRebuildData:ConsumePt(arg_9_1)
	self.pt = self.pt - arg_9_1

	return
end

function CityRebuildData:AddPt(arg_10_1)
	self.pt = self.pt + arg_10_1

	return
end

function CityRebuildData:Adjust(arg_11_1)
	self.startTime = arg_11_1.time
	self.leftHp = arg_11_1.left_hp.k + arg_11_1.left_hp.m * CityRebuildData.Million + arg_11_1.left_hp.b * CityRebuildData.Billion
	self.maxLevel = arg_11_1.max_level

	return
end

function CityRebuildData:IsRepairedOrRecruited(arg_12_1)
	return table.contains(self.buildings, arg_12_1) or table.contains(self.roles, arg_12_1)
end

function CityRebuildData:IsUnlock(arg_13_1)
	return table.contains(self.unlockBuildingOrCharaIds, arg_13_1)
end

function CityRebuildData:UpdateChooseLevel(arg_14_1)
	self.curLevel = arg_14_1

	if arg_14_1 > self.maxChooseLevel then
		self.maxChooseLevel = arg_14_1
	end

	return
end

function CityRebuildData:SetLevelDatas()
	self.Levelbuildings = {}
	self.Levelcharas = {}

	for iter_15_0, iter_15_1 in ipairs(var_0_1.all) do
		self.Levelbuildings[iter_15_0] = {}
		self.Levelcharas[iter_15_0] = {}

		for iter_15_2, iter_15_3 in ipairs(var_0_1[iter_15_1].include) do
			if var_0_2[iter_15_3].type == 1 then
				table.insert(self.Levelbuildings[iter_15_0], iter_15_3)
			elseif var_0_2[iter_15_3].type == 2 then
				table.insert(self.Levelcharas[iter_15_0], iter_15_3)
			end
		end
	end

	return
end

function CityRebuildData:KeepDecimal(arg_16_1)
	return math.floor(10^arg_16_1 * self) / 10^arg_16_1
end

CityRebuildData.SHOW_NUM_CNT = 4

function CityRebuildData:PtToShow()
	if self >= CityRebuildData.MaxGold then
		return 99.99 .. "B"
	end

	if self >= CityRebuildData.Billion then
		if self % CityRebuildData.Billion == 0 then
			return self / CityRebuildData.Billion .. "B"
		end

		return CityRebuildData.KeepDecimal(self / CityRebuildData.Billion, CityRebuildData.SHOW_NUM_CNT - #tostring(math.floor(self / CityRebuildData.Billion))) .. "B"
	elseif self >= CityRebuildData.Million then
		if self % CityRebuildData.Million == 0 then
			return self / CityRebuildData.Million .. "M"
		end

		return CityRebuildData.KeepDecimal(self / CityRebuildData.Million, CityRebuildData.SHOW_NUM_CNT - #tostring(math.floor(self / CityRebuildData.Million))) .. "M"
	elseif self >= CityRebuildData.Thousand then
		if self % CityRebuildData.Thousand == 0 then
			return self / CityRebuildData.Thousand .. "K"
		end

		return CityRebuildData.KeepDecimal(self / CityRebuildData.Thousand, CityRebuildData.SHOW_NUM_CNT - #tostring(math.floor(self / CityRebuildData.Thousand))) .. "K"
	end

	return self
end

return CityRebuildData
