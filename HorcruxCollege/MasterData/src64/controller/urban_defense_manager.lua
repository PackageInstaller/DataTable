local UrbanDefenseManager = class("UrbanDefenseManager", (require("controller.base_manager")))

UrbanDefenseManager.MULTITON_MSG = "UrbanDefenseManager instancealready constructed!"

local var_0_1 = string.split

UrbanDefenseManager.STATUS = {
	Fighting = 2,
	Garrisoning = 3,
	Normal = 1
}

function UrbanDefenseManager:ctor()
	UrbanDefenseManager.super.ctor(self)

	self._data = {}
	self._activityId = nil
	self._tokens = {}
	self._challengeInfos = {}
	self._config = {}

	for iter_1_0, iter_1_1 in pairs((require("data/citydefend_city_data"))) do
		local var_1_0 = var_0_1(iter_1_0, "-")
		local var_1_1 = tonumber(var_1_0[1])
		local var_1_2 = tonumber(var_1_0[2])

		self._config[var_1_1] = self._config[var_1_1] or {}
		self._config[var_1_1][var_1_2] = iter_1_1
		self._config[var_1_1][var_1_2].status = UrbanDefenseManager.STATUS.Normal
		self._config[var_1_1][var_1_2].servantIds = {}
		self._config[var_1_1][var_1_2].endTime = 0
	end
end

function UrbanDefenseManager:setActivityId(arg_2_1)
	self._activityId = arg_2_1
end

function UrbanDefenseManager:getActivityId()
	return self._activityId
end

function UrbanDefenseManager:getMode(arg_4_1)
	return self._config[self._activityId][arg_4_1].leve_ID
end

function UrbanDefenseManager:getStatus(arg_5_1)
	return self._config[self._activityId][arg_5_1].status
end

function UrbanDefenseManager:requestInfo(arg_6_1)
	require("network.network"):rpc("activity_citydefined_data", {
		activityid = self._activityId
	}, function(arg_7_0)
		if arg_7_0.result == 1 then
			self:handlerInfo(arg_7_0)

			if arg_6_1 then
				arg_6_1(arg_7_0)
			end
		elseif arg_7_0.result == 0 then
			global_ShowBlockWords(L_URBANDEFENSE[1])
		end
	end)
end

function UrbanDefenseManager:requestBegin(arg_8_1)
	local var_8_0 = self:getStatus(arg_8_1)

	if var_8_0 == UrbanDefenseManager.STATUS.Garrisoning then
		global_ShowBlockWords(L_URBANDEFENSE[8])

		return
	elseif var_8_0 == UrbanDefenseManager.STATUS.Normal then
		global_ShowBlockWords(L_URBANDEFENSE[7])

		return
	end

	require("network.network"):rpc("activity_citydefined_begin", {
		activityid = self._activityId,
		cityid = self._activityId .. "-" .. arg_8_1
	}, function(arg_9_0)
		if arg_9_0.result == 1 then
			self._tokens[self._activityId] = arg_9_0.token
			self._challengeInfos[self._activityId] = {
				chapter = 1,
				mode = self:getMode(arg_8_1),
				index = arg_8_1
			}

			local var_9_0 = self:getMode(arg_8_1)

			if var_9_0 then
				local var_9_1 = 1
				local tower_defence_manager = require("controller.tower_defence_manager")
				local var_9_3 = {
					mode = var_9_0
				}

				var_9_3.chapter = 1

				function var_9_3.surecallback()
					LayerManager:switchShowLayer("UrbanDefenseSelectLayer", {
						mode = var_9_0,
						chapter = var_9_1,
						sureCallback = function(arg_11_0)
							tower_defence_manager:switchToTowerDefence(var_9_0, var_9_1, arg_11_0, function(arg_12_0)
								if arg_12_0.result == 1 then
									local level_manager = require("controller.level_manager")

									RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", 1044)
									RoleDefault:getInstance():setIntegerForKey("SpecialAdventureEnterMode", 1044)
									FightManager.refreshFightToType(FIGHTTYPE_TOWER)
									LayerManager:switchShowLayer("FightLayer", {
										is_hide_topcost = true,
										is_hide_listbutton = true
									})
								end
							end, {
								type = 1
							})
						end
					})
				end

				LayerManager:pushInLayer("TowerDefenceDetailLayer", var_9_3)
			end
		elseif arg_9_0.result == 0 then
			global_ShowBlockWords(L_URBANDEFENSE[1])
		elseif arg_9_0.result == 2 then
			global_ShowBlockWords(L_URBANDEFENSE[2])
		elseif arg_9_0.result == 3 then
			global_ShowBlockWords(L_URBANDEFENSE[3])
		end
	end)
end

function UrbanDefenseManager:towerDefenceSuccess(arg_13_1)
	if not self._activityId then
		return
	end

	if self._challengeInfos[self._activityId] then
		local var_13_0 = self._challengeInfos[self._activityId].index

		if tonumber(self._challengeInfos[self._activityId].mode) == tonumber(arg_13_1.mode) and tonumber(self._challengeInfos[self._activityId].chapter) == tonumber(arg_13_1.chapter) then
			local var_13_1 = {}

			for iter_13_0 = 1, #arg_13_1.curSoul do
				var_13_1[#var_13_1 + 1] = arg_13_1.curSoul[iter_13_0]
			end

			require("network.network"):rpc("activity_citydefined_win", {
				activityid = self._activityId,
				cityid = self._activityId .. "-" .. self._challengeInfos[self._activityId].index,
				token = self._tokens[self._activityId],
				servantids = var_13_1
			}, function(arg_14_0)
				if arg_14_0.result == 1 then
					self._config[self._activityId][var_13_0].status = arg_14_0.citydata.status
					self._config[self._activityId][var_13_0].servantIds = arg_14_0.citydata.servantids
					self._config[self._activityId][var_13_0].endTime = arg_14_0.citydata.endtime

					sendNotification("ActivityCityDefinedWin")
				elseif arg_14_0.result == 0 then
					global_ShowBlockWords(L_URBANDEFENSE[1])
				elseif arg_14_0.result == 2 then
					global_ShowBlockWords(L_URBANDEFENSE[4])
				elseif arg_14_0.result == 3 then
					global_ShowBlockWords(L_URBANDEFENSE[5])
				end
			end)
		end
	end
end

function UrbanDefenseManager:handlerInfo(arg_15_1)
	for iter_15_0 = 1, #arg_15_1.citys do
		local var_15_0 = var_0_1(arg_15_1.citys[iter_15_0].id, "-")
		local var_15_1 = tonumber(var_15_0[1])
		local var_15_2 = tonumber(var_15_0[2])

		self._config[var_15_1][var_15_2].status = arg_15_1.citys[iter_15_0].status
		self._config[var_15_1][var_15_2].servantIds = arg_15_1.citys[iter_15_0].servantids
		self._config[var_15_1][var_15_2].endTime = arg_15_1.citys[iter_15_0].endtime
	end

	self:updateLayer()
end

function UrbanDefenseManager:getStatus(arg_16_1)
	if self._config[self._activityId] then
		return self._config[self._activityId][arg_16_1].status
	end

	return UrbanDefenseManager.STATUS.Normal
end

function UrbanDefenseManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function UrbanDefenseManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

function UrbanDefenseManager:getDefendGirls()
	local var_19_0 = {}

	if self._config[self._activityId] then
		for iter_19_0, iter_19_1 in pairs(self._config[self._activityId]) do
			for iter_19_2, iter_19_3 in pairs(iter_19_1.servantIds) do
				var_19_0[iter_19_3] = 1
			end
		end
	end

	return var_19_0
end

function UrbanDefenseManager:isUrbanDefenseModetype(arg_20_1)
	return arg_20_1 == 1044
end

return UrbanDefenseManager
