local HelpBattleFormationManager = class("HelpBattleFormationManager", (require("controller.base_manager")))

HelpBattleFormationManager.MULTITON_MSG = "HelpBattleFormationManager instancealready constructed!"
HelpBattleFormationManager.SHOW_TYPE = {
	NUM_FOUR = 1,
	NORMAL = 2,
	MORE = 3
}
HelpBattleFormationManager.CAREER_STR_MAP = {
	shooter = 2,
	witcher = 3,
	assassin = 5,
	fighter = 1,
	tank = 4,
	support = 6
}

function HelpBattleFormationManager:ctor()
	HelpBattleFormationManager.super.ctor(self)

	self._data = {}
	self._selectCareer = nil
	self._showNum = 4
	self._maxShowNum = 6
	self._minShowNum = 4
	self._showType = HelpBattleFormationManager.SHOW_TYPE.NUM_FOUR
	self._showInfo = {}
end

function HelpBattleFormationManager:requestInfo(arg_2_1)
	return
end

function HelpBattleFormationManager:requestUpdateGirl(arg_3_1)
	local var_3_0 = require("controller/help_battle/help_battle_manager"):getInstance()

	if arg_3_1 and not require("model.playermodel").haveServant[arg_3_1] then
		global_ShowBlockWords(L_HELP_BATTLE[123])

		return
	end

	if var_3_0:isInFormation(arg_3_1) then
		global_ShowBlockWords(L_HELP_BATTLE[129])

		return
	end

	local var_3_1 = self:getSelectCareer()
	local var_3_2 = clone(var_3_0:getServants(var_3_1))
	local var_3_3 = true

	for iter_3_0 = #var_3_2, 1, -1 do
		if var_3_2[iter_3_0] == arg_3_1 then
			table.remove(var_3_2, iter_3_0)

			var_3_3 = false

			break
		end
	end

	if #var_3_2 >= var_3_0.ADD_NUM then
		global_ShowBlockWords(L_HELP_BATTLE_FORMATION[9])
	else
		if var_3_3 then
			var_3_2[#var_3_2 + 1] = arg_3_1
		end

		var_3_0:requestUpdate(var_3_1, var_3_2, function()
			self:updateGirlSuccess(arg_3_1, var_3_1, var_3_3)
			sendNotification("HelpBattleRoleChanged", 666)
			cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("updateNewSchoolDeanOfficeData")))
		end)
	end
end

function HelpBattleFormationManager:handlerInfo(arg_5_1)
	return
end

function HelpBattleFormationManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function HelpBattleFormationManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

function HelpBattleFormationManager:updateGirlSuccess(arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = self:getShowInfo()
	local var_8_1

	if arg_8_3 then
		for iter_8_0 = 1, #var_8_0 do
			if var_8_0[iter_8_0].soulid == arg_8_1 then
				var_8_1 = table.remove(var_8_0, iter_8_0)

				break
			end
		end

		if var_8_1 then
			table.insert(var_8_0, var_8_1)
		end
	else
		local var_8_2 = require("controller/help_battle/help_battle_manager"):getInstance()
		local var_8_3 = {}

		for iter_8_1, iter_8_2 in pairs((var_8_2:getServants(arg_8_2))) do
			var_8_3[iter_8_2] = 1
		end

		local var_8_4 = {}

		for iter_8_3 = #var_8_0, #var_8_0 - var_8_2.ADD_NUM, -1 do
			if var_8_3[var_8_0[iter_8_3].soulid] then
				table.insert(var_8_4, 1, (table.remove(var_8_0, iter_8_3)))
			end
		end

		self:sortShowInfo(var_8_0)

		for iter_8_4 = 1, #var_8_4 do
			var_8_0[#var_8_0 + 1] = var_8_4[iter_8_4]
		end
	end

	if self.layer then
		self.layer:updateGirlSuccess()
	end
end

function HelpBattleFormationManager:setShowType(arg_9_1)
	self._showType = arg_9_1
end

function HelpBattleFormationManager:getShowType()
	return self._showType
end

function HelpBattleFormationManager:switchShowType()
	local var_11_0 = self:getShowType()

	if var_11_0 == HelpBattleFormationManager.SHOW_TYPE.NUM_FOUR then
		self:setShowType(HelpBattleFormationManager.SHOW_TYPE.NORMAL)
		self:setShowNum(5)
	elseif var_11_0 == HelpBattleFormationManager.SHOW_TYPE.NORMAL then
		self:setShowType(HelpBattleFormationManager.SHOW_TYPE.MORE)
		self:setShowNum(6)
	elseif var_11_0 == HelpBattleFormationManager.SHOW_TYPE.MORE then
		self:setShowType(HelpBattleFormationManager.SHOW_TYPE.NUM_FOUR)
		self:setShowNum(4)
	end
end

function HelpBattleFormationManager:getSelectCareer()
	self._selectCareer = self._selectCareer or require("controller/help_battle/help_battle_manager"):getInstance().CAREER.WARRIOR

	return self._selectCareer
end

function HelpBattleFormationManager:setSelectCareer(arg_13_1)
	self._selectCareer = arg_13_1
end

function HelpBattleFormationManager:setShowNum(arg_14_1)
	self._showNum = arg_14_1
end

function HelpBattleFormationManager:getShowNum()
	return self._showNum
end

function HelpBattleFormationManager:getMaxShowNum()
	return self._maxShowNum
end

function HelpBattleFormationManager:getMinShowNum()
	return self._minShowNum
end

function HelpBattleFormationManager:initShowInfo()
	local playermodel = require("model.playermodel")
	local servant_data = require("data.servant_data")
	local major_factor_data = require("data.major_factor_data")
	local model_data = require("data/model_data")
	local hexie_manager = require("controller.hexie_manager")
	local souls_manager = require("controller.souls_manager")
	local explore_manager = require("controller.explore_manager")
	local core_manager = require("controller.core_manager")
	local fight_capacity_manager = require("controller.fight_capacity_manager")
	local help_battle_manager = require("controller/help_battle/help_battle_manager")
	local var_18_10 = help_battle_manager:getInstance()
	local var_18_11 = {}

	for iter_18_0, iter_18_1 in pairs(help_battle_manager) do
		for iter_18_2, iter_18_3 in pairs(iter_18_1) do
			var_18_11[iter_18_3] = true
		end
	end

	local var_18_12 = {}

	for iter_18_4, iter_18_5 in pairs(servant_data) do
		local var_18_13 = iter_18_5.classtype == 1 and not playermodel:isServantLockByTime(iter_18_5.id)

		if iter_18_5.classtype == 1 and servant_data[iter_18_5.id].linkage and not playermodel.haveServant[iter_18_5.id] then
			var_18_13 = false
		end

		if not hexie_manager:canShowServant(iter_18_5.id) then
			var_18_13 = false
		end

		if (var_18_11[iter_18_5.id] or nil) and false then
			local var_18_14 = {
				ownNum = 0,
				skill1UpLevel = 0,
				fitnessLevel = 0,
				favorlevel = 0,
				soulid = iter_18_5.id,
				LV = core_manager:getCoreLv(iter_18_5.id),
				fightCapacity = fight_capacity_manager:getSoulFightCapacity(iter_18_5.id, "number"),
				order = servant_data[iter_18_5.id].order,
				rarity = souls_manager:get_servant_cur_roll_rarity(iter_18_5.id),
				sortRarity = souls_manager:get_servant_cur_roll_rarity(iter_18_5.id),
				hpInherit = explore_manager:getHpInherit(iter_18_5.id),
				career = HelpBattleFormationManager.CAREER_STR_MAP[model_data[iter_18_5.modelid].career],
				bonusInfo = var_18_10:getBonusByServantId(iter_18_5.id)
			}

			if not playermodel.haveServant[iter_18_5.id] then
				var_18_14.LV = 0
				var_18_14.fightCapacity = 0
				var_18_14.skill1UpLevel = 0
				var_18_14.fitnessLevel = 0
				var_18_14.order = 0
			end

			table.insert(var_18_12, var_18_14)
		end
	end

	self:sortShowInfo(var_18_12)

	self._showInfo = {}

	for iter_18_6, iter_18_7 in pairs((var_18_10:getCareerInfo())) do
		self._showInfo[iter_18_7.career] = {}
	end

	for iter_18_8 = 1, #var_18_12 do
		table.insert(self._showInfo[var_18_12[iter_18_8].career], var_18_12[iter_18_8])
	end

	for iter_18_9, iter_18_10 in pairs((var_18_10:getAllServants())) do
		for iter_18_11 = 1, #iter_18_10 do
			local var_18_15 = {
				ownNum = 0,
				skill1UpLevel = 0,
				fitnessLevel = 0,
				favorlevel = 0,
				soulid = servant_data[iter_18_10[iter_18_11]].id,
				LV = core_manager:getCoreLv(servant_data[iter_18_10[iter_18_11]].id),
				fightCapacity = fight_capacity_manager:getSoulFightCapacity(servant_data[iter_18_10[iter_18_11]].id, "number"),
				order = servant_data[servant_data[iter_18_10[iter_18_11]].id].order,
				rarity = souls_manager:get_servant_cur_roll_rarity(servant_data[iter_18_10[iter_18_11]].id),
				sortRarity = souls_manager:get_servant_cur_roll_rarity(servant_data[iter_18_10[iter_18_11]].id),
				hpInherit = explore_manager:getHpInherit(servant_data[iter_18_10[iter_18_11]].id),
				career = HelpBattleFormationManager.CAREER_STR_MAP[model_data[servant_data[iter_18_10[iter_18_11]].modelid].career],
				bonusInfo = var_18_10:getBonusByServantId(servant_data[iter_18_10[iter_18_11]].id)
			}

			if not playermodel.haveServant[servant_data[iter_18_10[iter_18_11]].id] then
				var_18_15.LV = 0
				var_18_15.fightCapacity = 0
				var_18_15.skill1UpLevel = 0
				var_18_15.fitnessLevel = 0
				var_18_15.order = 0
			end

			table.insert(self._showInfo[var_18_15.career], var_18_15)
		end
	end
end

function HelpBattleFormationManager:getShowInfo(arg_19_1)
	arg_19_1 = arg_19_1 or self:getSelectCareer()

	return self._showInfo[arg_19_1]
end

function HelpBattleFormationManager:getAllShowInfo()
	return self._showInfo
end

function HelpBattleFormationManager:sortShowInfo(arg_21_1)
	local var_21_0 = require("controller/help_battle/help_battle_manager"):getInstance()
	local major_factor_data = require("data.major_factor_data")
	local souls_manager = require("controller.souls_manager")
	local explore_manager = require("controller.explore_manager")
	local core_manager = require("controller.core_manager")
	local fight_capacity_manager = require("controller.fight_capacity_manager")
	local playermodel = require("model.playermodel")
	local servant_data = require("data.servant_data")
	local var_21_8 = 1
	local var_21_9 = {
		{
			weight = 7,
			func = function(self, arg_27_1)
				if not self.sortRarity or not arg_27_1.sortRarity then
					return "=="
				end

				if self.sortRarity == arg_27_1.sortRarity then
					return "=="
				end

				if var_21_8 == 0 then
					return self.sortRarity < arg_27_1.sortRarity
				else
					return self.sortRarity > arg_27_1.sortRarity
				end
			end
		},
		{
			weight = 6,
			func = function(self, arg_26_1)
				if self.LV == arg_26_1.LV then
					return "=="
				elseif var_21_8 == 0 then
					return self.LV < arg_26_1.LV
				else
					return self.LV > arg_26_1.LV
				end
			end
		},
		{
			weight = 4,
			func = function(self, arg_24_1)
				local var_24_0 = playermodel.servant_unlock_time and playermodel.servant_unlock_time[self.soulid]
				local var_24_1 = playermodel.servant_unlock_time and playermodel.servant_unlock_time[arg_24_1.soulid]

				if var_24_0 == 0 then
					var_24_0 = servant_data[self.soulid].major
				end

				if var_24_1 == 0 then
					var_24_1 = servant_data[arg_24_1.soulid].major
				end

				if var_24_0 == var_24_1 then
					return "=="
				else
					return var_24_1 < var_24_0
				end
			end
		},
		{
			weight = 5,
			func = function(self, arg_25_1)
				local var_25_0 = playermodel.soulOverClock[self.soulid] > 0 and 6 or playermodel.soulContract[self.soulid] or 0
				local var_25_1 = playermodel.soulOverClock[arg_25_1.soulid] > 0 and 6 or playermodel.soulContract[arg_25_1.soulid] or 0

				if var_25_0 == var_25_1 then
					return "=="
				else
					return var_25_1 < var_25_0
				end
			end
		},
		{
			weight = 2,
			func = function(self, arg_22_1)
				if var_21_8 == 0 then
					return self.soulid < arg_22_1.soulid
				else
					return self.soulid > arg_22_1.soulid
				end
			end
		},
		{
			weight = 3,
			func = function(self, arg_23_1)
				if self.soulid > 1000 then
					if var_21_8 == 0 then
						return servant_data[self.soulid].major < servant_data[arg_23_1.soulid].major
					else
						return servant_data[self.soulid].major > servant_data[arg_23_1.soulid].major
					end
				elseif var_21_8 == 0 then
					return self.soulid < arg_23_1.soulid
				else
					return self.soulid > arg_23_1.soulid
				end
			end
		},
		{
			weight = 12000,
			func = function(self, arg_29_1)
				local var_29_0 = self.bonusInfo.value.fightCapacity
				local var_29_1 = arg_29_1.bonusInfo.value.fightCapacity

				if self.bonusInfo.value.fightCapacity == arg_29_1.bonusInfo.value.fightCapacity then
					return "=="
				elseif var_21_8 == 0 then
					return var_29_0 < var_29_1
				else
					return var_29_1 < var_29_0
				end
			end
		},
		{
			weight = 12500,
			func = function(self, arg_28_1)
				local var_28_0 = playermodel.haveServant[self.soulid] and 1 or 0
				local var_28_1 = playermodel.haveServant[arg_28_1.soulid] and 1 or 0

				if (playermodel.haveServant[self.soulid] and 1 or 0) == (playermodel.haveServant[arg_28_1.soulid] and 1 or 0) then
					return "=="
				else
					return var_28_1 < var_28_0
				end
			end
		},
		{
			weight = 13000,
			func = function(self, arg_30_1)
				local var_30_0 = var_21_0:isInFormation(self.soulid) and 1 or 0
				local var_30_1 = var_21_0:isInFormation(arg_30_1.soulid) and 1 or 0

				if var_30_0 == var_30_1 then
					return "=="
				else
					return var_30_0 < var_30_1
				end
			end
		}
	}

	table.sort(var_21_9, function(arg_31_0, arg_31_1)
		return arg_31_0.weight > arg_31_1.weight
	end)
	table.sort(arg_21_1, function(arg_32_0, arg_32_1)
		for iter_32_0 = 1, #var_21_9 do
			if var_21_9[iter_32_0].func(arg_32_0, arg_32_1) ~= "==" then
				return var_21_9[iter_32_0].func(arg_32_0, arg_32_1)
			end
		end
	end)
end

function HelpBattleFormationManager:updateGirlList()
	if self.layer then
		self.layer:updateGirlList()
	end
end

function HelpBattleFormationManager:updateShowingCells()
	if self.layer then
		self.layer:updateShowingCells()
	end
end

return HelpBattleFormationManager
