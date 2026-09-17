local QuickFormationManager = class("QuickFormationManager", (require("controller.base_manager")))

QuickFormationManager.MULTITON_MSG = "QuickFormationManager instancealready constructed!"
QuickFormationManager.SHOW_TYPE = {
	NUM_FOUR = 1,
	NORMAL = 2,
	MORE = 3
}

local servant_data = require("data.servant_data")
local major_factor_data = require("data.major_factor_data")
local model_data = require("data.model_data")
local levelmode_data = require("data.levelmode_data")
local level_manager = require("controller.level_manager")

function QuickFormationManager:ctor()
	QuickFormationManager.super.ctor(self)

	self._data = {}
	self._showType = QuickFormationManager.SHOW_TYPE.NUM_FOUR
	self._layerType = nil
	self._selectGirlType = nil
	self._selectHorcruxType = nil
	self._mode = nil
	self._type = nil
	self._formationIndex = 1
	self._initialData = nil
	self._curSelectRoleInfo = {}
	self._alternativeRoleInfo = {}
	self._selectChangeIndexTable = {}
	self._excludeRoleInfo = {}
end

function QuickFormationManager:switchShowType()
	if self._showType == QuickFormationManager.SHOW_TYPE.NORMAL then
		self._showType = QuickFormationManager.SHOW_TYPE.MORE
	elseif self._showType == QuickFormationManager.SHOW_TYPE.MORE then
		self._showType = QuickFormationManager.SHOW_TYPE.NUM_FOUR
	elseif self._showType == QuickFormationManager.SHOW_TYPE.NUM_FOUR then
		self._showType = QuickFormationManager.SHOW_TYPE.NORMAL
	end
end

function QuickFormationManager:getShowType()
	return self._showType
end

function QuickFormationManager:requestInfo(arg_4_1)
	return
end

function QuickFormationManager:requestExtend(arg_5_1)
	L_TEAM_TIPS.Expansion_Labels.titleNewImage = "public/title/title_add_teams.png"

	local playermodel = require("model.playermodel")

	LayerManager:pushInLayer("PopDoLayer", {
		cost = 100,
		costtype = "diamond",
		labels = L_TEAM_TIPS.Expansion_Labels,
		own = playermodel.diamond,
		surecallback = function()
			local audio_manager = require("controller.audio_manager")
			local level_manager = require("controller.level_manager")

			require("network.network"):rpc("add_array", nil, function(arg_7_0)
				if arg_7_0.result == 1 then
					playermodel.arrays[#playermodel.arrays + 1] = arg_7_0.array
					self._curSelectRoleInfo[#playermodel.arrays] = {}

					for iter_7_0 = 1, FORMATION_SHOW_GIRL_NUM do
						self._curSelectRoleInfo[#playermodel.arrays][iter_7_0] = {
							isFixed = false,
							pos = iter_7_0,
							isLockGirl = not level_manager:isPlayerPassLevel(BATTLEARRAY_SOUL_UNLOCK[iter_7_0]),
							isLockHorcrux = not level_manager:isPlayerPassLevel(BATTLEARRAY_HORCRUX_UNLOCK[iter_7_0])
						}
					end

					if arg_7_0.diamond then
						playermodel.diamond = playermodel.diamond - arg_7_0.diamond
					end

					global_update_gold_stone_diamond(nil, nil, arg_7_0.diamond)
					AnalyticManager.add_array()

					if arg_5_1 then
						arg_5_1(arg_7_0)
					end
				elseif result == 2 then
					global_ShowBlockWords(L_TEAM_Array_WARNING.Team_Add[2])
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif result == 3 then
					global_ShowBlockWords(L_TEAM_Array_WARNING.Team_Add[3])
					audio_manager:playeffectMusicTest("sound/invalid")
				end
			end)
		end
	})
end

function QuickFormationManager:requestSelectParts(arg_8_1, arg_8_2)
	if CONFIG_TYPE_TEST_FIGHT_EMPTY == self._layerType or CONFIG_TYPE_TEST_FIGHT_PLAYER == self._layerType then
		global_ShowBlockWords(L_SPECIAL_TEAM_WARNING.Test_Fight_UN_CHOOSE)

		return
	end

	local var_8_0 = self:getSelectRoleInfo()

	if var_8_0[arg_8_1].fight_girl then
		LayerManager:pushInLayer("SoulsLayer", {
			showtype = 6,
			cursoul = var_8_0[arg_8_1].fight_girl,
			exitCallback = function()
				if arg_8_2 then
					arg_8_2()
				end
			end
		})
	else
		global_ShowBlockWords(L_SPECIAL_TEAM_WARNING.Assist_Girl_Nil)
		require("controller.audio_manager"):playeffectMusicTest("sound/invalid")
	end
end

function QuickFormationManager:requestChangeHorcrux(arg_10_1, arg_10_2)
	if CONFIG_TYPE_TEST_FIGHT_EMPTY == self._layerType or CONFIG_TYPE_TEST_FIGHT_PLAYER == self._layerType then
		global_ShowBlockWords(L_SPECIAL_TEAM_WARNING.Test_Fight_UN_CHOOSE)

		return
	end

	local var_10_0 = self:getSelectRoleInfo()

	if var_10_0[arg_10_1].fight_girl and not var_10_0[arg_10_1].isLockHorcrux and not var_10_0[arg_10_1].isFixed then
		local var_10_1 = {}

		for iter_10_0, iter_10_1 in pairs(var_10_0) do
			if iter_10_1.assist_girl then
				var_10_1[#var_10_1 + 1] = iter_10_1.assist_girl
			end
		end

		local var_10_2 = {
			selectType = self._selectHorcruxType,
			curHorcrux = var_10_0[arg_10_1].assist_girl,
			arrayIndex = self._formationIndex,
			arrayPos = arg_10_1,
			outSide = var_10_1,
			selectGirlServantId = var_10_0[arg_10_1].fight_girl,
			selectCallback = function()
				local var_11_0 = self:getCurFormationInfo()
				local var_11_1 = self:getSelectRoleInfo()

				for iter_11_0 = 1, #var_11_1 do
					var_11_1[iter_11_0].assist_girl = nil

					if var_11_0[iter_11_0] and var_11_0[iter_11_0].assist_girl then
						var_11_1[iter_11_0].assist_girl = var_11_0[iter_11_0].assist_girl
					end
				end

				if arg_10_2 then
					arg_10_2()
				end
			end
		}

		if self._layerType == CONFIG_TYPE_MODE then
			var_10_2.adverturemode = self._mode
		end

		if self._layerType == CONFIG_TYPE_EXPLORE then
			var_10_2.battleInfo = self:getCurFormationInfo()[arg_10_1]
		end

		LayerManager:pushInLayer("HorcruxSelectLayer", var_10_2)
	else
		global_ShowBlockWords(L_SPECIAL_TEAM_WARNING.Assist_Girl_Nil)
		require("controller.audio_manager"):playeffectMusicTest("sound/invalid")
	end
end

function QuickFormationManager:requestChangeRole(arg_12_1, arg_12_2)
	local playermodel = require("model.playermodel")

	if arg_12_1 and not playermodel.haveServant[arg_12_1] and self._layerType ~= CONFIG_TYPE_TEST_FIGHT_EMPTY and self._layerType ~= CONFIG_TYPE_TEST_FIGHT_PLAYER then
		global_ShowBlockWords(L_QUICKFORMATIONLAYER[16])

		return
	end

	local var_12_1 = self._selectChangeIndexTable[self._formationIndex]

	if not self._selectChangeIndexTable[self._formationIndex] then
		global_ShowBlockWords(L_QUICKFORMATIONLAYER[15])

		return
	end

	local var_12_2 = 0

	for iter_12_0, iter_12_1 in pairs(self._curSelectRoleInfo[self._formationIndex]) do
		if iter_12_1.fight_girl then
			var_12_2 = var_12_2 + 1
		end

		if arg_12_1 and iter_12_1.fight_girl == arg_12_1 then
			global_ShowBlockWords(L_QUICKFORMATIONLAYER[7])

			return
		end
	end

	if self._layerType ~= CONFIG_TYPE_SUBSTITUTION_OLD and var_12_2 <= 1 and not arg_12_1 then
		global_ShowBlockWords(L_QUICKFORMATIONLAYER[6])

		return
	end

	if self._layerType == CONFIG_TYPE_HANGUP or self._layerType == CONFIG_TYPE_REFIGHT then
		require("controller.array_manager"):updateArrayFightgirl(self._formationIndex, var_12_1, arg_12_1, false, function(arg_13_0)
			if arg_13_0 == 1 then
				self._curSelectRoleInfo[self._formationIndex][var_12_1].fight_girl = playermodel.arrays[self._formationIndex]["pos_" .. var_12_1].fight_girl
				self._curSelectRoleInfo[self._formationIndex][var_12_1].assist_girl = playermodel.arrays[self._formationIndex]["pos_" .. var_12_1].assist_girl

				self:filterGirlData()
				require("controller.formation.base_formation_manager"):getInstance():playVoiceById(arg_12_1)
				require("controller.formation.formation_manager"):getInstance():updateGirl()

				if arg_12_1 ~= nil then
					for iter_13_0 = 1, #self._curSelectRoleInfo[self._formationIndex] do
						if not self._curSelectRoleInfo[self._formationIndex][iter_13_0].fight_girl then
							self._selectChangeIndexTable[self._formationIndex] = iter_13_0

							break
						end
					end
				end

				if arg_12_2 then
					arg_12_2()
				end
			end
		end)
	elseif self._layerType == CONFIG_TYPE_MODE then
		require("controller.formation.formation_mode_manager"):getInstance():requestUpdateModeFightGirl(self._mode, var_12_1, arg_12_1, function(arg_14_0)
			if arg_14_0.result == 1 then
				local var_14_0 = self:getFormationInfo()

				self._curSelectRoleInfo[self._formationIndex][var_12_1].fight_girl = var_14_0[self._formationIndex][var_12_1].fight_girl
				self._curSelectRoleInfo[self._formationIndex][var_12_1].assist_girl = var_14_0[self._formationIndex][var_12_1].assist_girl

				self:filterGirlData()

				if arg_12_1 ~= nil then
					for iter_14_0 = 1, #self._curSelectRoleInfo[self._formationIndex] do
						if not self._curSelectRoleInfo[self._formationIndex][iter_14_0].fight_girl then
							self._selectChangeIndexTable[self._formationIndex] = iter_14_0

							break
						end
					end
				end

				if arg_12_2 then
					arg_12_2()
				end
			end
		end)
	elseif self._layerType == CONFIG_TYPE_SCOREARENA then
		require("controller.formation.formation_points_match_manager"):getInstance():requestUpdateArrayFightgirl(var_12_1, arg_12_1, function(arg_15_0)
			if arg_15_0.result == 1 then
				local var_15_0 = self:getFormationInfo()

				self._curSelectRoleInfo[self._formationIndex][var_12_1].fight_girl = var_15_0[self._formationIndex][var_12_1].fight_girl
				self._curSelectRoleInfo[self._formationIndex][var_12_1].assist_girl = var_15_0[self._formationIndex][var_12_1].assist_girl

				self:filterGirlData()

				if arg_12_1 ~= nil then
					for iter_15_0 = 1, #self._curSelectRoleInfo[self._formationIndex] do
						if not self._curSelectRoleInfo[self._formationIndex][iter_15_0].fight_girl then
							self._selectChangeIndexTable[self._formationIndex] = iter_15_0

							break
						end
					end
				end

				if arg_12_2 then
					arg_12_2()
				end
			end
		end)
	elseif self._layerType == CONFIG_TYPE_ARENA or self._layerType == CONFIG_TYPE_ARENA_DEFENCE then
		require("controller.formation.formation_grab_match_manager"):getInstance():requestUpdateArrayFightgirl(self._type, arg_12_1, var_12_1, function(arg_16_0)
			if arg_16_0.result == 1 then
				local var_16_0 = self:getFormationInfo()

				self._curSelectRoleInfo[self._formationIndex][var_12_1].fight_girl = var_16_0[self._formationIndex][var_12_1].fight_girl
				self._curSelectRoleInfo[self._formationIndex][var_12_1].assist_girl = var_16_0[self._formationIndex][var_12_1].assist_girl

				self:filterGirlData()

				if arg_12_1 ~= nil then
					for iter_16_0 = 1, #self._curSelectRoleInfo[self._formationIndex] do
						if not self._curSelectRoleInfo[self._formationIndex][iter_16_0].fight_girl then
							self._selectChangeIndexTable[self._formationIndex] = iter_16_0

							break
						end
					end
				end

				if arg_12_2 then
					arg_12_2()
				end
			end
		end)
	elseif self._layerType == CONFIG_TYPE_SUBSTITUTION then
		require("controller.formation.formation_overclock_manager"):getInstance():requestUpdateArrayFightgirl(self._mode, arg_12_1, var_12_1, self._formationIndex, function(arg_17_0)
			if arg_17_0.result == 1 then
				local var_17_0 = self:getFormationInfo()

				self._curSelectRoleInfo[self._formationIndex][var_12_1].fight_girl = var_17_0[self._formationIndex][var_12_1].fight_girl
				self._curSelectRoleInfo[self._formationIndex][var_12_1].assist_girl = var_17_0[self._formationIndex][var_12_1].assist_girl

				self:filterGirlData()

				if arg_12_1 ~= nil then
					for iter_17_0 = 1, #self._curSelectRoleInfo[self._formationIndex] do
						if not self._curSelectRoleInfo[self._formationIndex][iter_17_0].fight_girl then
							self._selectChangeIndexTable[self._formationIndex] = iter_17_0

							break
						end
					end
				end

				if arg_12_2 then
					arg_12_2()
				end
			end
		end)
	elseif self._layerType == CONFIG_TYPE_EXPLORE_HP_INHERIT or self._layerType == CONFIG_TYPE_EXPLORE then
		require("controller/formation/formation_explore_manager"):getInstance():requestUpdateArrayFightgirl(self._formationIndex, var_12_1, arg_12_1, function(arg_18_0)
			if arg_18_0 == 1 then
				local var_18_0 = self:getFormationInfo()

				self._curSelectRoleInfo[self._formationIndex][var_12_1].fight_girl = var_18_0[self._formationIndex][var_12_1].fight_girl
				self._curSelectRoleInfo[self._formationIndex][var_12_1].assist_girl = var_18_0[self._formationIndex][var_12_1].assist_girl

				self:filterGirlData()

				if arg_12_1 ~= nil then
					for iter_18_0 = 1, #self._curSelectRoleInfo[self._formationIndex] do
						if not self._curSelectRoleInfo[self._formationIndex][iter_18_0].fight_girl then
							self._selectChangeIndexTable[self._formationIndex] = iter_18_0

							break
						end
					end
				end

				if arg_12_2 then
					arg_12_2()
				end
			end
		end)
	elseif self._layerType == CONFIG_TYPE_TEST_FIGHT_EMPTY or self._layerType == CONFIG_TYPE_TEST_FIGHT_PLAYER then
		if arg_12_1 then
			LayerManager:pushInLayer("DormRoomPopLayer", {
				curShowPanel = "Panel_dress",
				isTestFightSelect = true,
				soulid = servant_data[arg_12_1].major,
				servantid = arg_12_1,
				selectType = self._selectGirlType,
				arrayIndex = var_12_1
			})
		else
			local test_fight_manager = require("controller.test_fight_manager")

			if self._layerType == CONFIG_TYPE_TEST_FIGHT_EMPTY then
				test_fight_manager:changePvpArrayByIndes(var_12_1, arg_12_1)
			elseif self._layerType == CONFIG_TYPE_TEST_FIGHT_PLAYER then
				test_fight_manager:changePlayerArrayByIndes(var_12_1, arg_12_1)
			end
		end
	elseif self._layerType == CONFIG_TYPE_EXPEDITION then
		require("controller.expedition_manager"):setExpeditionStudentList(var_12_1, arg_12_1, function(arg_19_0)
			if arg_19_0 == 1 then
				local var_19_0 = self:getFormationInfo()

				self._curSelectRoleInfo[self._formationIndex][var_12_1].fight_girl = var_19_0[self._formationIndex][var_12_1].fight_girl
				self._curSelectRoleInfo[self._formationIndex][var_12_1].assist_girl = var_19_0[self._formationIndex][var_12_1].assist_girl

				self:filterGirlData()

				if arg_12_1 ~= nil then
					for iter_19_0 = 1, #self._curSelectRoleInfo[self._formationIndex] do
						if not self._curSelectRoleInfo[self._formationIndex][iter_19_0].fight_girl then
							self._selectChangeIndexTable[self._formationIndex] = iter_19_0

							break
						end
					end
				end

				if arg_12_2 then
					arg_12_2()
				end
			end
		end)
	elseif self._layerType == CONFIG_TYPE_SUBSTITUTION_OLD then
		require("controller.formation.formation_old_substitute_manager"):getInstance():requestUpdateArrayFightgirl(self._mode, arg_12_1, var_12_1, self._formationIndex, function(arg_20_0)
			if arg_20_0.result == 1 then
				local var_20_0 = self:getFormationInfo()

				self._curSelectRoleInfo[self._formationIndex][var_12_1].fight_girl = var_20_0[self._formationIndex][var_12_1].fight_girl
				self._curSelectRoleInfo[self._formationIndex][var_12_1].assist_girl = var_20_0[self._formationIndex][var_12_1].assist_girl

				self:filterGirlData()

				if arg_12_1 ~= nil then
					for iter_20_0 = 1, #self._curSelectRoleInfo[self._formationIndex] do
						if not self._curSelectRoleInfo[self._formationIndex][iter_20_0].fight_girl then
							self._selectChangeIndexTable[self._formationIndex] = iter_20_0

							break
						end
					end
				end

				if arg_12_2 then
					arg_12_2()
				end
			end
		end)
	elseif self._layerType == CONFIG_TYPE_JUMP_TOWER then
		require("controller.formation.formation_jumptower_manager"):getInstance():requestUpdateJumptowerGirl(self._mode, arg_12_1, var_12_1, self._formationIndex)

		local var_12_4 = self:getFormationInfo()

		self._curSelectRoleInfo[self._formationIndex][var_12_1].fight_girl = var_12_4[self._formationIndex][var_12_1].fight_girl
		self._curSelectRoleInfo[self._formationIndex][var_12_1].assist_girl = var_12_4[self._formationIndex][var_12_1].assist_girl

		self:filterGirlData()

		if arg_12_1 ~= nil then
			for iter_12_2 = 1, #self._curSelectRoleInfo[self._formationIndex] do
				if not self._curSelectRoleInfo[self._formationIndex][iter_12_2].fight_girl then
					self._selectChangeIndexTable[self._formationIndex] = iter_12_2

					break
				end
			end
		end

		if arg_12_2 then
			arg_12_2()
		end
	elseif self._layerType == CONFIG_TYPE_BOSS_FIGHT then
		require("controller.formation.formation_bossfight_manager"):getInstance():requestUpdateBossfightGirl(self._mode, arg_12_1, var_12_1, self._formationIndex)

		local var_12_5 = self:getFormationInfo()

		self._curSelectRoleInfo[self._formationIndex][var_12_1].fight_girl = var_12_5[self._formationIndex][var_12_1].fight_girl
		self._curSelectRoleInfo[self._formationIndex][var_12_1].assist_girl = var_12_5[self._formationIndex][var_12_1].assist_girl

		self:filterGirlData()

		if arg_12_1 ~= nil then
			for iter_12_3 = 1, #self._curSelectRoleInfo[self._formationIndex] do
				if not self._curSelectRoleInfo[self._formationIndex][iter_12_3].fight_girl then
					self._selectChangeIndexTable[self._formationIndex] = iter_12_3

					break
				end
			end
		end

		if arg_12_2 then
			arg_12_2()
		end
	elseif self._layerType == CONFIG_TYPE_GROUP_FIGHT then
		require("controller.formation.formation_groupfight_manager"):getInstance():requestUpdateModeFightGirl(self._mode, var_12_1, arg_12_1, self._formationIndex)

		local var_12_6 = self:getFormationInfo()

		for iter_12_4 = 1, #self._curSelectRoleInfo do
			for iter_12_5 = 1, 5 do
				if self._curSelectRoleInfo[iter_12_4][iter_12_5].fight_girl == arg_12_1 then
					self._curSelectRoleInfo[iter_12_4][iter_12_5].fight_girl = nil
				end
			end
		end

		self._curSelectRoleInfo[self._formationIndex][var_12_1].fight_girl = var_12_6[self._formationIndex][var_12_1].fight_girl
		self._curSelectRoleInfo[self._formationIndex][var_12_1].assist_girl = var_12_6[self._formationIndex][var_12_1].assist_girl

		self:filterGirlData()

		if arg_12_1 ~= nil then
			for iter_12_6 = 1, #self._curSelectRoleInfo[self._formationIndex] do
				if not self._curSelectRoleInfo[self._formationIndex][iter_12_6].fight_girl then
					self._selectChangeIndexTable[self._formationIndex] = iter_12_6

					break
				end
			end
		end

		if arg_12_2 then
			arg_12_2()
		end
	end
end

function QuickFormationManager:testFightChangeRoleSuccess()
	local level_manager = require("controller.level_manager")

	self._curSelectRoleInfo = {}

	local var_21_1 = self:getFormationInfo()

	for iter_21_0 = 1, #var_21_1 do
		self._curSelectRoleInfo[iter_21_0] = {}

		for iter_21_1 = 1, FORMATION_SHOW_GIRL_NUM do
			self._curSelectRoleInfo[iter_21_0][iter_21_1] = {
				isFixed = false,
				pos = iter_21_1,
				isLockGirl = not level_manager:isPlayerPassLevel(BATTLEARRAY_SOUL_UNLOCK[iter_21_1]),
				isLockHorcrux = not level_manager:isPlayerPassLevel(BATTLEARRAY_HORCRUX_UNLOCK[iter_21_1])
			}

			if var_21_1[iter_21_0][iter_21_1] and var_21_1[iter_21_0][iter_21_1].fight_girl then
				self._curSelectRoleInfo[iter_21_0][iter_21_1].fight_girl = var_21_1[iter_21_0][iter_21_1].fight_girl
			end

			if var_21_1[iter_21_0][iter_21_1] and var_21_1[iter_21_0][iter_21_1].assist_girl then
				self._curSelectRoleInfo[iter_21_0][iter_21_1].assist_girl = var_21_1[iter_21_0][iter_21_1].assist_girl
			end
		end
	end

	if self._curSelectRoleInfo[self._formationIndex][self._selectChangeIndexTable[self._formationIndex]].fight_girl then
		for iter_21_2 = 1, #self._curSelectRoleInfo[self._formationIndex] do
			if not self._curSelectRoleInfo[self._formationIndex][iter_21_2].fight_girl then
				self._selectChangeIndexTable[self._formationIndex] = iter_21_2

				break
			end
		end
	end

	self:filterGirlData()

	if self.layer then
		self.layer:changeRoleSuccess()
	end
end

function QuickFormationManager:requestTeamRestoration()
	if self._layerType == CONFIG_TYPE_HANGUP or self._layerType == CONFIG_TYPE_REFIGHT then
		local var_22_0 = require("controller.formation.formation_main_manager"):getInstance()

		for iter_22_0 = 1, #self._initialData do
			var_22_0:requestOneTimeUpdateArray(iter_22_0, self._initialData[iter_22_0])
		end
	elseif self._layerType == CONFIG_TYPE_MODE then
		local var_22_1 = require("controller.formation.formation_mode_manager"):getInstance()

		for iter_22_1 = 1, #self._initialData do
			var_22_1:requestOneTimeUpdateArray(iter_22_1, self._initialData[iter_22_1])
		end
	elseif self._layerType == CONFIG_TYPE_SCOREARENA then
		local var_22_2 = require("controller.formation.formation_points_match_manager"):getInstance()

		for iter_22_2 = 1, #self._initialData do
			var_22_2:requestOneTimeUpdateArray(iter_22_2, self._initialData[iter_22_2])
		end
	elseif self._layerType == CONFIG_TYPE_ARENA or self._layerType == CONFIG_TYPE_ARENA_DEFENCE then
		local var_22_3 = require("controller.formation.formation_grab_match_manager"):getInstance()

		for iter_22_3 = 1, #self._initialData do
			var_22_3:requestOneTimeUpdateArray(iter_22_3, self._initialData[iter_22_3])
		end
	elseif self._layerType == CONFIG_TYPE_SUBSTITUTION then
		-- block empty
	elseif self._layerType == CONFIG_TYPE_EXPLORE_HP_INHERIT or self._layerType == CONFIG_TYPE_EXPLORE then
		local var_22_4 = require("controller/formation/formation_explore_manager"):getInstance()

		for iter_22_4 = 1, #self._initialData do
			var_22_4:requestOneTimeUpdateArray(iter_22_4, self._initialData[iter_22_4])
		end
	elseif self._layerType == CONFIG_TYPE_TEST_FIGHT_EMPTY or self._layerType == CONFIG_TYPE_TEST_FIGHT_PLAYER then
		-- block empty
	elseif self._layerType == CONFIG_TYPE_EXPEDITION then
		-- block empty
	elseif self._layerType == CONFIG_TYPE_SUBSTITUTION_OLD then
		-- block empty
	elseif self._layerType == CONFIG_TYPE_GROUP_FIGHT then
		-- block empty
	end
end

function QuickFormationManager:handlerInfo(arg_23_1)
	return
end

function QuickFormationManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function QuickFormationManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

function QuickFormationManager:resetData()
	self._layerType = nil
	self._selectGirlType = nil
	self._selectHorcruxType = nil
	self._mode = nil
	self._type = nil
	self._formationIndex = 1
	self._initialData = nil
	self._curSelectRoleInfo = {}
	self._alternativeRoleInfo = {}
	self._selectChangeIndexTable = {}
	self._excludeRoleInfo = {}
	self.filterTbl = nil
end

function QuickFormationManager:initData(arg_27_1)
	local level_manager = require("controller.level_manager")

	self:resetData()
	self:initExcludeData(arg_27_1.excludelist)
	self:setLayerInfo(arg_27_1)
	self:initFormationIndex(arg_27_1.formationIndex or 1)

	self._initialData = clone(self:getInitialFormationData())

	if self._layerType == CONFIG_TYPE_HANGUP or self._layerType == CONFIG_TYPE_MODE or self._layerType == CONFIG_TYPE_SCOREARENA or self._layerType == CONFIG_TYPE_ARENA or self._layerType == CONFIG_TYPE_ARENA_DEFENCE or self._layerType == CONFIG_TYPE_SUBSTITUTION or self._layerType == CONFIG_TYPE_EXPLORE_HP_INHERIT or self._layerType == CONFIG_TYPE_EXPLORE or self._layerType == CONFIG_TYPE_TEST_FIGHT_EMPTY or self._layerType == CONFIG_TYPE_TEST_FIGHT_PLAYER or self._layerType == CONFIG_TYPE_EXPEDITION or self._layerType == CONFIG_TYPE_REFIGHT or self._layerType == CONFIG_TYPE_SUBSTITUTION_OLD or self._layerType == CONFIG_TYPE_JUMP_TOWER or self._layerType == CONFIG_TYPE_BOSS_FIGHT or self._layerType == CONFIG_TYPE_GROUP_FIGHT then
		self._curSelectRoleInfo = {}

		local var_27_1 = self:getFormationInfo()

		for iter_27_0 = 1, #var_27_1 do
			self._curSelectRoleInfo[iter_27_0] = {}

			for iter_27_1 = 1, FORMATION_SHOW_GIRL_NUM do
				self._curSelectRoleInfo[iter_27_0][iter_27_1] = {
					isFixed = false,
					pos = iter_27_1,
					isLockGirl = not level_manager:isPlayerPassLevel(BATTLEARRAY_SOUL_UNLOCK[iter_27_1]),
					isLockHorcrux = not level_manager:isPlayerPassLevel(BATTLEARRAY_HORCRUX_UNLOCK[iter_27_1])
				}

				if var_27_1[iter_27_0][iter_27_1] and var_27_1[iter_27_0][iter_27_1].fight_girl then
					self._curSelectRoleInfo[iter_27_0][iter_27_1].fight_girl = var_27_1[iter_27_0][iter_27_1].fight_girl
				end

				if var_27_1[iter_27_0][iter_27_1] and var_27_1[iter_27_0][iter_27_1].assist_girl then
					self._curSelectRoleInfo[iter_27_0][iter_27_1].assist_girl = var_27_1[iter_27_0][iter_27_1].assist_girl
				end
			end
		end
	end

	for iter_27_2 = 1, #self._curSelectRoleInfo do
		if not self._selectChangeIndexTable[iter_27_2] then
			local var_27_2 = self._curSelectRoleInfo[iter_27_2]

			for iter_27_3 = 1, #self._curSelectRoleInfo[iter_27_2] do
				if not var_27_2[iter_27_3].fight_girl and not var_27_2[iter_27_3].isLockGirl and not var_27_2[iter_27_3].isFixed then
					self._selectChangeIndexTable[iter_27_2] = iter_27_3

					break
				end
			end
		end
	end

	self._alternativeRoleInfo = self:getAlternativeRoleInfo()
end

function QuickFormationManager:initExcludeData(arg_28_1)
	self._excludeRoleInfo = {}

	if not arg_28_1 then
		return
	end

	for iter_28_0, iter_28_1 in ipairs(arg_28_1) do
		self._excludeRoleInfo[iter_28_1] = true
	end
end

function QuickFormationManager:formationIndexUpdate()
	self._alternativeRoleInfo = self:getAlternativeRoleInfo()

	self:filterGirlData()
end

function QuickFormationManager:setLayerInfo(arg_30_1)
	arg_30_1 = arg_30_1 or {}
	self._layerType = arg_30_1.layerType or CONFIG_TYPE_HANGUP
	self.selectType = arg_30_1.selectGirlType
	self._isHpInherit = nil

	if self._layerType == CONFIG_TYPE_HANGUP or self._layerType == CONFIG_TYPE_REFIGHT then
		self._selectGirlType = SELECT_GIRL_FIGHT
		self._selectHorcruxType = SELECT_HORCRUX_FIGHT
	elseif self._layerType == CONFIG_TYPE_MODE then
		self._selectGirlType = arg_30_1.selectGirlType
		self._selectHorcruxType = arg_30_1.selectHorcruxType
		self._mode = arg_30_1.mode
	elseif self._layerType == CONFIG_TYPE_SCOREARENA then
		self._selectGirlType = arg_30_1.selectGirlType
		self._selectHorcruxType = arg_30_1.selectHorcruxType
	elseif self._layerType == CONFIG_TYPE_ARENA or self._layerType == CONFIG_TYPE_ARENA_DEFENCE then
		self._selectGirlType = arg_30_1.selectGirlType
		self._selectHorcruxType = arg_30_1.selectHorcruxType
		self._type = arg_30_1.type
	elseif self._layerType == CONFIG_TYPE_SUBSTITUTION then
		self._selectGirlType = arg_30_1.selectGirlType
		self._selectHorcruxType = arg_30_1.selectHorcruxType
		self._mode = arg_30_1.mode
	elseif self._layerType == CONFIG_TYPE_EXPLORE_HP_INHERIT or self._layerType == CONFIG_TYPE_EXPLORE then
		self._selectGirlType = arg_30_1.selectGirlType
		self._selectHorcruxType = arg_30_1.selectHorcruxType
		self._isHpInherit = arg_30_1.is_hp_inherit
	elseif self._layerType == CONFIG_TYPE_TEST_FIGHT_EMPTY or self._layerType == CONFIG_TYPE_TEST_FIGHT_PLAYER then
		self._selectGirlType = arg_30_1.selectGirlType
		self._selectHorcruxType = arg_30_1.selectHorcruxType
	elseif self._layerType == CONFIG_TYPE_EXPEDITION then
		self._selectGirlType = arg_30_1.selectGirlType
		self._selectHorcruxType = arg_30_1.selectHorcruxType
	elseif self._layerType == CONFIG_TYPE_SUBSTITUTION_OLD then
		self._selectGirlType = arg_30_1.selectGirlType
		self._selectHorcruxType = arg_30_1.selectHorcruxType
		self._mode = arg_30_1.mode
	elseif self._layerType == CONFIG_TYPE_JUMP_TOWER then
		self._selectGirlType = arg_30_1.selectGirlType
		self._selectHorcruxType = arg_30_1.selectHorcruxType
		self._mode = arg_30_1.mode
	elseif self._layerType == CONFIG_TYPE_BOSS_FIGHT then
		self._selectGirlType = arg_30_1.selectGirlType
		self._selectHorcruxType = arg_30_1.selectHorcruxType
		self._mode = arg_30_1.mode
	elseif self._layerType == CONFIG_TYPE_GROUP_FIGHT then
		self._selectGirlType = arg_30_1.selectGirlType
		self._selectHorcruxType = arg_30_1.selectHorcruxType
		self._mode = arg_30_1.mode
	end
end

function QuickFormationManager:getLayerType()
	return self._layerType
end

function QuickFormationManager:initFormationIndex(arg_32_1)
	self._formationIndex = arg_32_1
end

function QuickFormationManager:setFormationIndex(arg_33_1)
	self._formationIndex = arg_33_1

	self:formationIndexUpdate()
end

function QuickFormationManager:getFormationIndex()
	return self._formationIndex
end

function QuickFormationManager:setSelectChangeIndex(arg_35_1)
	self._selectChangeIndexTable[self._formationIndex] = arg_35_1
end

function QuickFormationManager:getSelectChangeIndex()
	return self._selectChangeIndexTable[self._formationIndex]
end

function QuickFormationManager:initFilterData()
	local filter_config_manager = require("controller.filter_config_manager")

	self.filterType = {
		{},
		{},
		{},
		{}
	}
	self.sortOrder = self.sortOrder or 0

	if self._selectGirlType == SELECT_GIRL_FIGHT or self._selectGirlType == SELECT_GIRL_FIGHT_MODE or self._selectGirlType == SELECT_GIRL_FIGHT_POINT or self._selectGirlType == SELECT_GIRL_FIGHT_MATERIAL or self._selectGirlType == SELECT_GIRL_FIGHT_ELEMENTS then
		self.sortType = 1
		self.curSort = 1
	elseif self._selectGirlType == SELECT_GIRL_EXPLORE then
		self.sortType = 1
		self.curSort = 1
		self.exploreTimeLabel = {}
	elseif self._selectGirlType == SELECT_GIRL_EXPLORE_HP_INHERIT then
		self.sortType = 1
		self.curSort = 1
	elseif self._selectGirlType == SELECT_GIRL_DORMITORY then
		self.sortType = 2
		self.curSort = 2
	else
		self.sortType = 1
		self.curSort = 1
	end

	self.filterTbl = filter_config_manager:getDefaultFilterData(filter_config_manager.SERVANT)
	self.curSort = self.filterTbl.sortType
	self.filterListData = self.layer._filterList:getFilterData()

	if self.filterTbl.filterConfig.pos then
		self.filterType[1] = global_deepCopy(self.filterTbl.filterConfig.pos)
	end

	if self.filterTbl.filterConfig.attr then
		self.filterType[2] = global_deepCopy(self.filterTbl.filterConfig.attr)
	end

	if self.filterTbl.filterConfig.rarity then
		self.filterType[3] = global_deepCopy(self.filterTbl.filterConfig.rarity)
	end

	if self.filterTbl.filterConfig.career then
		self.filterType[4] = global_deepCopy(self.filterTbl.filterConfig.career)
	end

	if self.filterTbl.filterConfig.other then
		self.filterType[5] = global_deepCopy(self.filterTbl.filterConfig.other)
	end

	self:filterGirlData()

	if self.layer then
		self.layer:initAllTableView()
	end
end

function QuickFormationManager:getFilterParam()
	local filter_config_manager = require("controller.filter_config_manager")
	local var_38_1 = {}
	local var_38_2 = false

	for iter_38_0, iter_38_1 in pairs(self.filterListData.btnState) do
		if iter_38_1 == 1 then
			var_38_2 = true
		end
	end

	for iter_38_2, iter_38_3 in pairs(self.filterListData.btnState) do
		var_38_1[iter_38_2] = var_38_2 and (iter_38_3 == 1 and -2 or -1) or iter_38_3
	end

	local function var_38_3(arg_42_0, arg_42_1)
		for iter_42_0, iter_42_1 in pairs(arg_42_0) do
			if iter_42_1 == arg_42_1 then
				return true
			end
		end

		return false
	end

	local var_38_4 = {}
	local var_38_5 = {}

	for iter_38_4, iter_38_5 in pairs(filter_config_manager.ConfigTable[filter_config_manager.SERVANT].filter_key) do
		for iter_38_6, iter_38_7 in pairs(self.filterTbl.filterConfig) do
			if iter_38_6 == iter_38_5 then
				var_38_4[iter_38_4] = iter_38_4
				var_38_5[iter_38_4] = {}

				for iter_38_8, iter_38_9 in pairs(filter_config_manager.ConfigTable[filter_config_manager.SERVANT].filter_table[iter_38_4]) do
					var_38_5[iter_38_4][iter_38_8] = var_38_3(iter_38_7, iter_38_9) and 1 or 0
				end
			end
		end
	end

	local var_38_6 = {}

	for iter_38_10 = 1, self.filterTbl.sortType do
		if iter_38_10 < self.filterTbl.sortType then
			table.insert(var_38_6, 0)
		else
			table.insert(var_38_6, 1)
		end
	end

	local var_38_7 = {
		filterType = filter_config_manager.SERVANT,
		filterCallback = function(self)
			if self then
				self.filterTbl.sortType = self.sortType or self.filterTbl.sortType

				for iter_39_0, iter_39_1 in pairs(self.filterConfig) do
					self.filterTbl.filterConfig[iter_39_0] = global_deepCopy(iter_39_1)
				end

				self.curSort = self.filterTbl.sortType

				if self.selectType == SELECT_GIRL_HOME then
					if self.filterTbl.filterConfig.type then
						self.filterType[1] = global_deepCopy(self.filterTbl.filterConfig.type)
					end
				else
					if self.filterTbl.filterConfig.pos then
						self.filterType[1] = global_deepCopy(self.filterTbl.filterConfig.pos)
					end

					if self.filterTbl.filterConfig.attr then
						self.filterType[2] = global_deepCopy(self.filterTbl.filterConfig.attr)
					end

					if self.filterTbl.filterConfig.rarity then
						self.filterType[3] = global_deepCopy(self.filterTbl.filterConfig.rarity)
					end

					if self.filterTbl.filterConfig.career then
						self.filterType[4] = global_deepCopy(self.filterTbl.filterConfig.career)
					end

					if self.filterTbl.filterConfig.other then
						self.filterType[5] = global_deepCopy(self.filterTbl.filterConfig.other)
					end
				end
			end

			self:filterGirlData()

			self.curIndex = 1
			self.selectGirl = self.curData[self.curIndex] and self.curData[self.curIndex].soulid

			if self.layer then
				self.layer:reloadData()
			end
		end,
		maskTouchCallback = function(arg_40_0)
			arg_40_0()
		end,
		sortOrderChangeCallback = function(arg_41_0)
			self.sortOrder = self.sortOrder == 0 and 1 or 0

			self:filterGirlData()

			if self.layer then
				self.layer:updateShowingCells()
			end
		end,
		initButtonConfig = {
			[self.filterListData.col] = var_38_1
		},
		defaultSortOrder = self.sortOrder
	}

	var_38_7.filterType = self.selectType == SELECT_GIRL_HOME and filter_config_manager.MAJOR or self.selectType == SELECT_GIRL_DORMITORY and filter_config_manager.DORMITORY or (self.selectType == SELECT_GIRL_TEST_FIGHT_EMPTY or self.selectType == SELECT_GIRL_TEST_FIGHT_PLAYER) and filter_config_manager.TEST_FIGHT or filter_config_manager.SERVANT

	return var_38_7, {
		statTbl = var_38_5,
		sortTypeCol = var_38_6,
		cols = var_38_4
	}
end

function QuickFormationManager:filterGirlData()
	local souls_manager = require("controller.souls_manager")
	local core_manager = require("controller.core_manager")
	local array_manager = require("controller.array_manager")
	local playermodel = require("model.playermodel")

	self.curData = {}

	local function var_43_4(arg_44_0, arg_44_1)
		if not next(arg_44_0) then
			return true
		end

		if servant_data[arg_44_1] then
			return true
		end

		for iter_44_0, iter_44_1 in pairs(arg_44_0) do
			if iter_44_1 == var_44_0 then
				return true
			end
		end

		return false
	end

	local function var_43_5(arg_45_0, arg_45_1)
		if not arg_45_0 then
			return true
		end

		if not next(arg_45_0) then
			return true
		end

		local var_45_0 = false

		for iter_45_0, iter_45_1 in pairs(arg_45_0) do
			if iter_45_1 == "linkage" then
				var_45_0 = true
			end
		end

		if var_45_0 then
			local var_45_1 = {}

			for iter_45_2, iter_45_3 in pairs(servant_data) do
				if iter_45_3.classtype == 1 and iter_45_3.linkage then
					var_45_1[global_get_model_attr(iter_45_3.modelid)] = true
				end
			end

			for iter_45_4, iter_45_5 in pairs(var_45_1) do
				table.insert(arg_45_0, iter_45_4)
			end
		end

		local var_45_2 = false

		for iter_45_6, iter_45_7 in pairs(arg_45_0) do
			if iter_45_7 == "other" then
				var_45_2 = true
			end
		end

		if var_45_2 then
			local var_45_3 = {}

			for iter_45_8, iter_45_9 in pairs(ATTR_OTHER_LIST) do
				var_45_3[iter_45_8] = true
			end

			for iter_45_10, iter_45_11 in pairs(var_45_3) do
				table.insert(arg_45_0, iter_45_10)
			end
		end

		local var_45_4 = (self._selectGirlType == SELECT_GIRL_FIGHT or self._selectGirlType == SELECT_GIRL_FIGHT_MODE or self._selectGirlType == SELECT_GIRL_DATABASE or self._selectGirlType == SELECT_GIRL_EXPLORE or self._selectGirlType == SELECT_GIRL_QUICKFIGHT or self._selectGirlType == SELECT_GIRL_TRAIN or self._selectGirlType == SELECT_GIRL_ARENA_DEFENCE or self._selectGirlType == SELECT_GIRL_SPECIAL or self._selectGirlType == SELECT_GIRL_ARENA_ATTACK or self._selectGirlType == SELECT_GIRL_TVT_DEFENCE or self._selectGirlType == SELECT_GIRL_TVT_ATTACK or self._selectGirlType == SELECT_GIRL_SUBSTITUTION or self._selectGirlType == SELECT_GIRL_EXPLORE_HP_INHERIT or self._selectGirlType == SELECT_GIRL_EXPEDITION or self._selectGirlType == SELECT_GIRL_EXPEDITION_LIST or self._selectGirlType == SELECT_GIRL_FIGHT_POINT or self._selectGirlType == SELECT_GIRL_FIGHT_MATERIAL or self._selectGirlType == SELECT_GIRL_FIGHT_ELEMENTS or self._selectGirlType == SELECT_GIRL_TEST_FIGHT_EMPTY or self._selectGirlType == SELECT_GIRL_TEST_FIGHT_PLAYER or self._selectGirlType == SELECT_GIRL_SUBSTITUTION_OLD or self._selectGirlType == SELECT_GIRL_JUMP_TOWER or self._selectGirlType == SELECT_GIRL_BOSS_FIGHT or self._selectGirlType == SELECT_GIRL_GROUP_FIGHT) and servant_data[arg_45_1].modelid or major_factor_data[arg_45_1].model

		for iter_45_12, iter_45_13 in pairs(arg_45_0) do
			if model_data[var_45_4][iter_45_13] then
				return true
			end
		end

		return false
	end

	local function var_43_6(arg_46_0, arg_46_1)
		if not arg_46_0 or not next(arg_46_0) then
			return true
		end

		if not servant_data[arg_46_1] then
			return false
		end

		local var_46_0 = souls_manager:get_servant_cur_roll_rarity(arg_46_1)

		for iter_46_0, iter_46_1 in pairs(arg_46_0) do
			if iter_46_1 == var_46_0 then
				return true
			end
		end

		return false
	end

	local function var_43_7(arg_47_0, arg_47_1)
		if not arg_47_0 or not next(arg_47_0) then
			return true
		end

		if not servant_data[arg_47_1] then
			return false
		end

		local var_47_0 = SERVANT_CAREE_TBL[model_data[servant_data[arg_47_1].modelid].career]

		for iter_47_0, iter_47_1 in pairs(arg_47_0) do
			if iter_47_1 == var_47_0 then
				return true
			end
		end

		return false
	end

	local function var_43_8(arg_48_0, arg_48_1)
		if not arg_48_0 or not next(arg_48_0) then
			return true
		end

		if not servant_data[arg_48_1] then
			return false
		end

		for iter_48_0, iter_48_1 in pairs(arg_48_0) do
			if iter_48_1 == "breakLimit" and core_manager:isBreakLimit(arg_48_1) then
				return true
			end

			if iter_48_1 == "linkage" and servant_data[arg_48_1].linkage_new then
				return true
			end
		end

		return false
	end

	local var_43_9 = {}

	for iter_43_0, iter_43_1 in pairs(self._alternativeRoleInfo) do
		if self._selectGirlType == SELECT_GIRL_DATABASE and servant_data[iter_43_1.soulid] and array_manager:isServantInHangup(iter_43_1.soulid) then
			table.insert(var_43_9, iter_43_1)
		elseif var_43_4(self.filterType[1], iter_43_1.soulid) and var_43_5(self.filterType[2], iter_43_1.soulid) and var_43_6(self.filterType[3], iter_43_1.soulid) and var_43_7(self.filterType[4], iter_43_1.soulid) and var_43_8(self.filterType[5], iter_43_1.soulid) then
			table.insert(self.curData, iter_43_1)
		end
	end

	if self._selectGirlType == SELECT_GIRL_DATABASE then
		(function()
			table.sort(var_43_9, function(arg_50_0, arg_50_1)
				if arg_50_0.LV == arg_50_1.LV then
					return arg_50_0.soulid > arg_50_1.soulid
				else
					return arg_50_0.LV <= arg_50_1.LV
				end
			end)

			for iter_49_0, iter_49_1 in pairs(var_43_9) do
				if var_43_4(self.filterType[1], iter_49_1.soulid) and var_43_5(self.filterType[2], iter_49_1.soulid) and var_43_6(self.filterType[3], iter_49_1.soulid) and var_43_7(self.filterType[4], iter_49_1.soulid) and var_43_8(self.filterType[5], iter_49_1.soulid) then
					if self._selectGirlType == SELECT_GIRL_DATABASE then
						if playermodel.haveServant[iter_49_1.soulid] then
							table.insert(self.curData, 1, iter_49_1)
						end
					else
						table.insert(self.curData, 1, iter_49_1)
					end
				end
			end
		end)()
	end

	;(function(arg_52_0, arg_52_1)
		local function var_52_0(arg_53_0, arg_53_1)
			if arg_52_1 == 0 then
				return arg_53_0.soulid < arg_53_1.soulid
			else
				return arg_53_0.soulid > arg_53_1.soulid
			end
		end

		local function var_52_1(arg_54_0, arg_54_1)
			if self._selectGirlType == SELECT_GIRL_DORMITORY then
				if arg_52_1 == 0 then
					return arg_54_0.soulid < arg_54_1.soulid
				else
					return arg_54_0.soulid > arg_54_1.soulid
				end
			elseif arg_54_0.soulid > 1000 then
				if arg_52_1 == 0 then
					return servant_data[arg_54_0.soulid].major < servant_data[arg_54_1.soulid].major
				else
					return servant_data[arg_54_0.soulid].major > servant_data[arg_54_1.soulid].major
				end
			elseif arg_52_1 == 0 then
				return arg_54_0.soulid < arg_54_1.soulid
			else
				return arg_54_0.soulid > arg_54_1.soulid
			end
		end

		local function var_52_2(arg_55_0, arg_55_1)
			local var_55_0 = playermodel.servant_unlock_time and playermodel.servant_unlock_time[arg_55_0.soulid]
			local var_55_1 = playermodel.servant_unlock_time and playermodel.servant_unlock_time[arg_55_1.soulid]

			if var_55_0 == 0 then
				var_55_0 = servant_data[arg_55_0.soulid].major
			end

			if var_55_1 == 0 then
				var_55_1 = servant_data[arg_55_1.soulid].major
			end

			if var_55_0 == var_55_1 then
				return "=="
			else
				return var_55_1 < var_55_0
			end
		end

		local function var_52_3(arg_56_0, arg_56_1)
			local var_56_0 = playermodel.soulOverClock[arg_56_0.soulid] > 0 and 6 or playermodel.soulContract[arg_56_0.soulid] or 0
			local var_56_1 = playermodel.soulOverClock[arg_56_1.soulid] > 0 and 6 or playermodel.soulContract[arg_56_1.soulid] or 0

			if var_56_0 == var_56_1 then
				return "=="
			else
				return var_56_1 < var_56_0
			end
		end

		local function var_52_4(arg_57_0, arg_57_1)
			if arg_57_0.LV == arg_57_1.LV then
				return "=="
			elseif arg_52_1 == 0 then
				return arg_57_0.LV < arg_57_1.LV
			else
				return arg_57_0.LV > arg_57_1.LV
			end
		end

		local function var_52_6(arg_59_0, arg_59_1)
			if not arg_59_0.sortRarity or not arg_59_1.sortRarity then
				return "=="
			end

			if arg_59_0.sortRarity == arg_59_1.sortRarity then
				return "=="
			end

			if arg_52_1 == 0 then
				return arg_59_0.sortRarity < arg_59_1.sortRarity
			else
				return arg_59_0.sortRarity > arg_59_1.sortRarity
			end
		end

		local function var_52_10(arg_64_0, arg_64_1)
			if self._selectGirlType ~= SELECT_GIRL_HOME and self._selectGirlType ~= SELECT_GIRL_DORMITORY then
				local var_64_0 = playermodel.haveServant[arg_64_0.soulid] and 1 or 0
				local var_64_1 = playermodel.haveServant[arg_64_1.soulid] and 1 or 0

				if (playermodel.haveServant[arg_64_0.soulid] and 1 or 0) == (playermodel.haveServant[arg_64_1.soulid] and 1 or 0) then
					return "=="
				else
					return var_64_1 < var_64_0
				end
			else
				local var_64_2 = playermodel.haveSuit[arg_64_0.soulid] and 1 or 0
				local var_64_3 = playermodel.haveSuit[arg_64_1.soulid] and 1 or 0

				if (playermodel.haveSuit[arg_64_0.soulid] and 1 or 0) == (playermodel.haveSuit[arg_64_1.soulid] and 1 or 0) then
					return "=="
				else
					return var_64_3 < var_64_2
				end
			end
		end

		local function var_52_11(arg_65_0, arg_65_1)
			local var_65_0 = require("controller.formation.formation_manager"):getInstance():getFormationInfoBySelectType(self._selectGirlType, self._formationIndex)

			local function var_65_1(arg_66_0)
				for iter_66_0 = 1, #var_65_0 do
					if var_65_0[iter_66_0] and var_65_0[iter_66_0].fight_girl == arg_66_0 then
						return true
					end
				end

				return false
			end

			local function var_65_2(arg_67_0)
				for iter_67_0 = 1, #var_65_0 do
					if var_65_0[iter_67_0] and var_65_0[iter_67_0].fight_girl == arg_67_0 then
						return iter_67_0
					end
				end
			end

			local var_65_3 = var_65_1(arg_65_0.soulid)
			local var_65_4 = var_65_1(arg_65_1.soulid)
			local var_65_5
			local var_65_6

			if var_65_3 and var_65_4 then
				var_65_5 = var_65_2(arg_65_0.soulid)
				var_65_6 = var_65_2(arg_65_1.soulid)
			elseif var_65_3 and not var_65_4 then
				var_65_5 = var_65_2(arg_65_0.soulid)
				var_65_6 = 999
			elseif not var_65_3 and var_65_4 then
				var_65_5 = 999
				var_65_6 = var_65_2(arg_65_1.soulid)
			else
				var_65_5 = 999
				var_65_6 = 999
			end

			if var_65_5 == var_65_6 then
				return "=="
			end

			return var_65_5 < var_65_6
		end

		local var_52_13 = {
			{
				weight = 7,
				func = var_52_6
			},
			{
				weight = 6,
				func = var_52_4
			},
			{
				weight = 4,
				func = var_52_2
			},
			{
				weight = 5,
				func = var_52_3
			},
			{
				weight = 2,
				func = var_52_0
			},
			{
				weight = 3,
				func = var_52_1
			},
			{
				func = function(self, arg_63_1)
					local var_63_0 = playermodel.newservants[self.soulid] and 1 or 0
					local var_63_1 = playermodel.newservants[arg_63_1.soulid] and 1 or 0

					if (playermodel.newservants[self.soulid] and 1 or 0) == (playermodel.newservants[arg_63_1.soulid] and 1 or 0) then
						return "=="
					else
						return var_63_1 < var_63_0
					end
				end,
				weight = (not level_manager:isPlayerPassLevel(QUICK_FORMATION_ISNEW_SORT_UNLOCK_LEVEL) or nil) and 1
			},
			{
				weight = 12000,
				func = var_52_10
			},
			{
				weight = 1,
				func = var_52_11
			}
		}

		if self._selectGirlType ~= SELECT_GIRL_DORMITORY then
			if self._selectGirlType == SELECT_GIRL_HOME then
				local var_52_14 = {}
				local var_52_15 = {
					weight = 3
				}

				function var_52_15:func(arg_68_1)
					local var_68_0 = playermodel.favor[self.soulid].favorlevel or 0
					local var_68_1 = playermodel.favor[arg_68_1.soulid].favorlevel or 0

					if var_68_0 == var_68_1 then
						return "=="
					else
						return var_68_1 < var_68_0
					end
				end

				var_52_14[1] = var_52_15
				var_52_14[2] = {
					weight = 2,
					func = function(self, arg_69_1)
						if arg_52_1 == 0 then
							return self.soulid < arg_69_1.soulid
						else
							return self.soulid > arg_69_1.soulid
						end
					end
				}
				var_52_14[3] = {
					weight = 11000,
					func = function(self, arg_70_1)
						local var_70_0 = self.soulid < 1000 and 0 or 1
						local var_70_1 = arg_70_1.soulid < 1000 and 0 or 1

						if (self.soulid < 1000 and 0 or 1) == (arg_70_1.soulid < 1000 and 0 or 1) then
							return "=="
						end

						if arg_52_1 == 0 then
							return var_70_0 < var_70_1
						else
							return var_70_1 < var_70_0
						end
					end
				}
				var_52_14[4] = {
					weight = 12000,
					func = var_52_10
				}
				var_52_13 = var_52_14
			elseif self._selectGirlType == SELECT_GIRL_TEST_FIGHT_EMPTY or self._selectGirlType == SELECT_GIRL_TEST_FIGHT_PLAYER then
				var_52_13 = {
					{
						weight = 3,
						func = var_52_1
					},
					{
						weight = 6,
						func = var_52_4
					},
					{
						weight = 7,
						func = var_52_6
					},
					{
						weight = 5,
						func = var_52_3
					},
					{
						weight = 4,
						func = var_52_2
					},
					{
						weight = 2,
						func = var_52_0
					},
					{
						weight = 13000,
						func = var_52_11
					}
				}
			end
		end

		var_52_13[arg_52_0].weight = var_52_13[arg_52_0].weight + 100

		table.sort(var_52_13, function(arg_71_0, arg_71_1)
			return arg_71_0.weight > arg_71_1.weight
		end)
		table.sort(self.curData, function(arg_72_0, arg_72_1)
			for iter_72_0 = 1, #var_52_13 do
				if var_52_13[iter_72_0].func(arg_72_0, arg_72_1) ~= "==" then
					return var_52_13[iter_72_0].func(arg_72_0, arg_72_1)
				end
			end
		end)

		if self.isHpInherit then
			(function(arg_73_0)
				local var_73_0 = {}

				for iter_73_0 = #arg_73_0, 1, -1 do
					if arg_73_0[iter_73_0].hpInherit and arg_73_0[iter_73_0].hpInherit <= 0 then
						table.insert(var_73_0, table.remove(arg_73_0, iter_73_0))
					end
				end

				local var_73_1 = #arg_73_0 + 1

				for iter_73_1, iter_73_2 in ipairs(arg_73_0) do
					if (playermodel.haveServant[iter_73_2.soulid] and 1 or 0) == 0 then
						var_73_1 = iter_73_1

						break
					end
				end

				for iter_73_3 = #var_73_0, 1, -1 do
					table.insert(arg_73_0, var_73_1, table.remove(var_73_0, iter_73_3))

					var_73_1 = var_73_1 + 1
				end
			end)(self.curData)
		end
	end)(self.curSort, self.orderType)

	function insertNpcDataToCurData()
		local var_74_0 = #self.curData + 1

		for iter_74_0, iter_74_1 in pairs(self.curData) do
			if not playermodel.haveSuit[iter_74_1.soulid] then
				var_74_0 = iter_74_0

				break
			end
		end

		local var_74_1 = #self.allNpcData

		while var_74_1 > 0 do
			table.insert(self.curData, var_74_0, self.allNpcData[var_74_1])

			var_74_1 = var_74_1 - 1
		end
	end

	if self._selectGirlType == SELECT_GIRL_HOME then
		for iter_43_2, iter_43_3 in pairs(self.filterType[1]) do
			if iter_43_3 == 2 then
				insertNpcDataToCurData()

				break
			end
		end

		if not next(self.filterType[1]) then
			insertNpcDataToCurData()
		end
	end

	if self.sortOrder == 1 then
		local var_43_11 = {}

		for iter_43_4 = #self.curData, 1, -1 do
			table.insert(var_43_11, self.curData[iter_43_4])
		end

		self.curData = var_43_11
	end

	local var_43_12 = self:getSelectRoleInfo() or {}
	local var_43_13 = {}
	local var_43_14 = {}

	for iter_43_5 = 1, #var_43_12 do
		var_43_14[iter_43_5] = {}

		if var_43_12[iter_43_5].fight_girl then
			var_43_13[var_43_12[iter_43_5].fight_girl] = var_43_12[iter_43_5]
		end
	end

	if self._selectGirlType ~= SELECT_GIRL_DATABASE then
		for iter_43_6 = #self.curData, 1, -1 do
			if var_43_13[self.curData[iter_43_6].soulid] then
				table.remove(self.curData, iter_43_6)

				var_43_14[var_43_13[self.curData[iter_43_6].soulid].pos] = self.curData[iter_43_6]
			end
		end
	end

	for iter_43_7 = 1, #var_43_14 do
		if next(var_43_14[iter_43_7]) then
			table.insert(self.curData, var_43_14[iter_43_7])
		end
	end

	if self._mode then
		if levelmode_data[self._mode] and (levelmode_data[self._mode].ele_type or levelmode_data[self._mode].element_type) then
			local var_43_15 = levelmode_data[self._mode].ele_type or levelmode_data[self._mode].element_type

			if levelmode_data[self._mode].ele_type_show then
				var_43_15 = levelmode_data[self._mode].ele_type_show .. ",imaginary"
			end

			local var_43_16 = {}

			if var_43_15 == "all" then
				var_43_15 = nil
			end

			if var_43_15 then
				for iter_43_8 in var_43_15:gmatch("([^,]+)") do
					table.insert(var_43_16, iter_43_8)
				end
			end

			local var_43_17 = {
				wind = true,
				water = true,
				fire = true,
				light = true,
				dark = true
			}

			local function var_43_18(arg_75_0, arg_75_1)
				if not arg_75_1 or not arg_75_0 then
					return
				end

				local var_75_0 = (self._selectGirlType == SELECT_GIRL_FIGHT or self._selectGirlType == SELECT_GIRL_FIGHT_MODE or self._selectGirlType == SELECT_GIRL_DATABASE or self._selectGirlType == SELECT_GIRL_EXPLORE or self._selectGirlType == SELECT_GIRL_QUICKFIGHT or self._selectGirlType == SELECT_GIRL_TRAIN or self._selectGirlType == SELECT_GIRL_ARENA_DEFENCE or self._selectGirlType == SELECT_GIRL_SPECIAL or self._selectGirlType == SELECT_GIRL_ARENA_ATTACK or self._selectGirlType == SELECT_GIRL_TVT_DEFENCE or self._selectGirlType == SELECT_GIRL_TVT_ATTACK or self._selectGirlType == SELECT_GIRL_SUBSTITUTION or self._selectGirlType == SELECT_GIRL_EXPLORE_HP_INHERIT or self._selectGirlType == SELECT_GIRL_FIGHT_POINT or self._selectGirlType == SELECT_GIRL_FIGHT_MATERIAL or self._selectGirlType == SELECT_GIRL_FIGHT_ELEMENTS or self._selectGirlType == SELECT_GIRL_SUBSTITUTION_OLD or self._selectGirlType == SELECT_GIRL_JUMP_TOWER or self._selectGirlType == SELECT_GIRL_BOSS_FIGHT or self._selectGirlType == SELECT_GIRL_GROUP_FIGHT) and servant_data[arg_75_1].modelid or major_factor_data[arg_75_1].model

				if not var_75_0 then
					return
				end

				local var_75_1 = false
				local var_75_2 = false

				for iter_75_0, iter_75_1 in ipairs(arg_75_0) do
					if model_data[var_75_0][iter_75_1] then
						var_75_1 = true

						break
					end

					if var_43_17[iter_75_1] then
						var_75_2 = true
					end
				end

				if not var_75_1 and var_75_2 and model_data[var_75_0].imaginary then
					var_75_1 = true
				end

				return var_75_1
			end

			local var_43_19 = {}

			if next(var_43_16) then
				for iter_43_9, iter_43_10 in ipairs(self.curData) do
					if var_43_18(var_43_16, iter_43_10.soulid) then
						table.insert(var_43_19, iter_43_10)
					end
				end

				self.curData = var_43_19
			end
		end

		local var_43_20 = level_manager:getDropUpServants(self._mode)
		local var_43_21 = {}

		if var_43_20 and next(var_43_20) then
			for iter_43_11, iter_43_12 in ipairs(self.curData) do
				local var_43_22 = false

				for iter_43_13, iter_43_14 in ipairs(var_43_20) do
					if iter_43_14 == iter_43_12.soulid then
						var_43_22 = true
					end
				end

				if var_43_22 then
					table.insert(var_43_21, 1, iter_43_12)
				else
					table.insert(var_43_21, iter_43_12)
				end
			end

			self.curData = var_43_21
		end
	end
end

function QuickFormationManager:getFilterListSpriteCallBack()
	local filter_config_manager = require("controller.filter_config_manager")
	local var_76_1 = {
		defaultSelected = 1,
		bagLayerType = filter_config_manager.SERVANT,
		filterCallback = function(self)
			local var_77_0

			if self.curIndex then
				self.curIndex = 1
				var_77_0 = {}
			end

			var_77_0[1] = self.filterValue
			self.filterTbl.filterConfig[self.filterKey] = var_77_0
			self.filterListData = self

			if self._layerType == SELECT_GIRL_HOME then
				if self.filterTbl.filterConfig.type then
					self.filterType[1] = global_deepCopy(self.filterTbl.filterConfig.type)
				end
			elseif self._layerType == CONFIG_TYPE_EXPEDITION then
				if self.filterTbl.filterConfig.rarity then
					self.filterType[3] = global_deepCopy(self.filterTbl.filterConfig.rarity)
				end

				if self.filterTbl.filterConfig.career then
					self.filterType[4] = global_deepCopy(self.filterTbl.filterConfig.career)
				end

				if self.filterTbl.filterConfig.attr then
					self.filterType[2] = global_deepCopy(self.filterTbl.filterConfig.attr)
				end
			else
				if self.filterTbl.filterConfig.pos then
					self.filterType[1] = global_deepCopy(self.filterTbl.filterConfig.pos)
				end

				if self.filterTbl.filterConfig.attr then
					self.filterType[2] = global_deepCopy(self.filterTbl.filterConfig.attr)
				end

				if self.filterTbl.filterConfig.rarity then
					self.filterType[3] = global_deepCopy(self.filterTbl.filterConfig.rarity)
				end

				if self.filterTbl.filterConfig.career then
					self.filterType[4] = global_deepCopy(self.filterTbl.filterConfig.career)
				end
			end

			self:filterGirlData()

			self.curIndex = 1
			self.selectGirl = self.curData[self.curIndex] and self.curData[self.curIndex].soulid

			if self.layer then
				self.layer:updateFilterListSprite()
			end
		end
	}

	if self._selectGirlType == SELECT_GIRL_HOME then
		var_76_1.bagLayerType = filter_config_manager.MAJOR
		var_76_1.style = "style_major_filter"
	elseif self._selectGirlType == SELECT_GIRL_DORMITORY then
		var_76_1.bagLayerType = filter_config_manager.DORMITORY
		var_76_1.hideAll = true
	elseif self._selectGirlType == SELECT_GIRL_TEST_FIGHT_EMPTY or self._selectGirlType == SELECT_GIRL_TEST_FIGHT_PLAYER then
		var_76_1.bagLayerType = filter_config_manager.TEST_FIGHT
		var_76_1.style = "style_servant_attr"
		var_76_1.defaultFilter = self.filterTbl
	else
		var_76_1.bagLayerType = filter_config_manager.SERVANT
		var_76_1.style = "style_servant_attr_new"
		var_76_1.defaultFilter = self.filterTbl
	end

	if self._layerType == CONFIG_TYPE_MODE then
		local var_76_2 = global_get_levelmode_ele_type(self._mode)

		if var_76_2 then
			if string.find(var_76_2, ",") then
				var_76_1.lock_ele_type = string.split(var_76_2, ",")

				table.insert(var_76_1.lock_ele_type, "other")
			else
				var_76_1.lock_ele_type = {
					var_76_2,
					"other"
				}
			end

			for iter_76_0, iter_76_1 in ipairs(var_76_1.lock_ele_type) do
				if ATTR_OTHER_LIST[iter_76_1] then
					table.remove(var_76_1.lock_ele_type, iter_76_0)
				end
			end
		end
	end

	return var_76_1
end

function QuickFormationManager:getLevelMode()
	if self._layerType == CONFIG_TYPE_MODE then
		return self._mode
	end

	return nil
end

function QuickFormationManager:getFormationInfo()
	local var_79_0 = {}

	if self._layerType ~= CONFIG_TYPE_HANGUP then
		if self._layerType == CONFIG_TYPE_REFIGHT then
			for iter_79_0, iter_79_1 in pairs(require("model.playermodel").arrays) do
				var_79_0[iter_79_1.id] = {}

				for iter_79_2, iter_79_3 in pairs(iter_79_1) do
					if type(iter_79_3) == "table" and iter_79_2 ~= "assist" then
						var_79_0[iter_79_1.id][iter_79_3.pos] = iter_79_3
					end
				end
			end
		elseif self._layerType == CONFIG_TYPE_MODE then
			var_79_0 = require("controller/formation/formation_mode_manager"):getInstance():getFormationInfo()
		elseif self._layerType == CONFIG_TYPE_SCOREARENA then
			var_79_0 = require("controller/formation/formation_points_match_manager"):getInstance():getFormationInfo()
		elseif self._layerType == CONFIG_TYPE_ARENA or self._layerType == CONFIG_TYPE_ARENA_DEFENCE then
			var_79_0 = require("controller/formation/formation_grab_match_manager"):getInstance():getFormationInfo()
		elseif self._layerType == CONFIG_TYPE_SUBSTITUTION then
			var_79_0 = require("controller/formation/formation_overclock_manager"):getInstance():getFormationInfo()
		elseif self._layerType == CONFIG_TYPE_EXPLORE_HP_INHERIT or self._layerType == CONFIG_TYPE_EXPLORE then
			var_79_0 = require("controller/formation/formation_explore_manager"):getInstance():getFormationInfo()
		elseif self._layerType == CONFIG_TYPE_TEST_FIGHT_EMPTY or self._layerType == CONFIG_TYPE_TEST_FIGHT_PLAYER then
			var_79_0 = require("controller/formation/formation_test_fight_manager"):getInstance():getFormationInfo()
		elseif self._layerType == CONFIG_TYPE_EXPEDITION then
			var_79_0 = require("controller.formation.formation_manager"):getInstance():getFormationInfoBySelectType(self.selectType, 1)
			var_79_0 = {
				var_79_0
			}
		elseif self._layerType == CONFIG_TYPE_SUBSTITUTION_OLD then
			var_79_0 = require("controller.formation.formation_old_substitute_manager"):getInstance():getFormationInfo()
		elseif self._layerType == CONFIG_TYPE_JUMP_TOWER then
			var_79_0 = require("controller.formation.formation_jumptower_manager"):getInstance():getFormationInfo()
		elseif self._layerType == CONFIG_TYPE_BOSS_FIGHT then
			var_79_0 = require("controller.formation.formation_bossfight_manager"):getInstance():getFormationInfo()
		elseif self._layerType == CONFIG_TYPE_GROUP_FIGHT then
			var_79_0 = require("controller.formation.formation_groupfight_manager"):getInstance():getFormationInfo()
		end
	end

	return var_79_0
end

function QuickFormationManager:getInitialFormationData()
	if self._layerType == CONFIG_TYPE_HANGUP or self._layerType == CONFIG_TYPE_REFIGHT then
		return require("model.playermodel").arrays
	elseif self._layerType == CONFIG_TYPE_MODE then
		local formation_mode_manager = require("controller/formation/formation_mode_manager")
		local var_80_1 = formation_mode_manager:getInstance():getFormationInfo()
		local var_80_2 = {}

		for iter_80_0 = 1, #formation_mode_manager do
			var_80_2[iter_80_0] = {
				id = iter_80_0
			}

			for iter_80_1 = 1, #var_80_1[iter_80_0] do
				var_80_2[iter_80_0]["pos_" .. var_80_1[iter_80_0][iter_80_1].pos] = var_80_1[iter_80_0][iter_80_1]
			end
		end

		return var_80_2
	elseif self._layerType == CONFIG_TYPE_SCOREARENA then
		local formation_points_match_manager = require("controller/formation/formation_points_match_manager")
		local var_80_4 = formation_points_match_manager:getInstance():getFormationInfo()
		local var_80_5 = {}

		for iter_80_2 = 1, #formation_points_match_manager do
			var_80_5[iter_80_2] = {
				id = iter_80_2
			}

			for iter_80_3 = 1, #var_80_4[iter_80_2] do
				var_80_5[iter_80_2]["pos_" .. var_80_4[iter_80_2][iter_80_3].pos] = var_80_4[iter_80_2][iter_80_3]
			end
		end

		return var_80_5
	elseif self._layerType == CONFIG_TYPE_ARENA or self._layerType == CONFIG_TYPE_ARENA_DEFENCE then
		local formation_grab_match_manager = require("controller/formation/formation_grab_match_manager")
		local var_80_7 = formation_grab_match_manager:getInstance():getFormationInfo()
		local var_80_8 = {}

		for iter_80_4 = 1, #formation_grab_match_manager do
			var_80_8[iter_80_4] = {
				id = iter_80_4
			}

			for iter_80_5 = 1, #var_80_7[iter_80_4] do
				var_80_8[iter_80_4]["pos_" .. var_80_7[iter_80_4][iter_80_5].pos] = var_80_7[iter_80_4][iter_80_5]
			end
		end

		return var_80_8
	elseif self._layerType == CONFIG_TYPE_SUBSTITUTION then
		local formation_overclock_manager = require("controller/formation/formation_overclock_manager")
		local var_80_10 = formation_overclock_manager:getInstance():getFormationInfo()
		local var_80_11 = {}

		for iter_80_6 = 1, #formation_overclock_manager do
			var_80_11[iter_80_6] = {
				id = iter_80_6
			}

			for iter_80_7 = 1, #var_80_10[iter_80_6] do
				var_80_11[iter_80_6]["pos_" .. var_80_10[iter_80_6][iter_80_7].pos] = var_80_10[iter_80_6][iter_80_7]
			end
		end

		return var_80_11
	elseif self._layerType == CONFIG_TYPE_EXPLORE_HP_INHERIT or self._layerType == CONFIG_TYPE_EXPLORE then
		local formation_explore_manager = require("controller/formation/formation_explore_manager")
		local var_80_13 = formation_explore_manager:getInstance():getFormationInfo()
		local var_80_14 = {}

		for iter_80_8 = 1, #formation_explore_manager do
			var_80_14[iter_80_8] = {
				id = iter_80_8
			}

			for iter_80_9 = 1, #var_80_13[iter_80_8] do
				var_80_14[iter_80_8]["pos_" .. var_80_13[iter_80_8][iter_80_9].pos] = var_80_13[iter_80_8][iter_80_9]
			end
		end

		return var_80_14
	elseif self._layerType == CONFIG_TYPE_TEST_FIGHT_EMPTY or self._layerType == CONFIG_TYPE_TEST_FIGHT_PLAYER then
		local formation_test_fight_manager = require("controller/formation/formation_test_fight_manager")
		local var_80_16 = formation_test_fight_manager:getInstance():getFormationInfo()
		local var_80_17 = {}

		for iter_80_10 = 1, #formation_test_fight_manager do
			var_80_17[iter_80_10] = {
				id = iter_80_10
			}

			for iter_80_11 = 1, #var_80_16[iter_80_10] do
				var_80_17[iter_80_10]["pos_" .. var_80_16[iter_80_10][iter_80_11].pos] = var_80_16[iter_80_10][iter_80_11]
			end
		end

		return var_80_17
	elseif self._layerType == CONFIG_TYPE_EXPEDITION then
		local formation_manager = require("controller.formation.formation_manager")
		local var_80_19 = formation_manager:getInstance():getFormationInfoBySelectType(self.selectType, 1)
		local var_80_20 = {}

		for iter_80_12 = 1, #formation_manager do
			var_80_20[iter_80_12] = {
				id = iter_80_12
			}

			for iter_80_13 = 1, #var_80_19[iter_80_12] do
				var_80_20[iter_80_12]["pos_" .. var_80_19[iter_80_12][iter_80_13].pos] = var_80_19[iter_80_12][iter_80_13]
			end
		end

		return var_80_20
	elseif self._layerType == CONFIG_TYPE_SUBSTITUTION_OLD then
		local formation_old_substitute_manager = require("controller.formation.formation_old_substitute_manager")
		local var_80_22 = formation_old_substitute_manager:getInstance():getFormationInfo()
		local var_80_23 = {}

		for iter_80_14 = 1, #formation_old_substitute_manager do
			var_80_23[iter_80_14] = {
				id = iter_80_14
			}

			for iter_80_15 = 1, #var_80_22[iter_80_14] do
				var_80_23[iter_80_14]["pos_" .. var_80_22[iter_80_14][iter_80_15].pos] = var_80_22[iter_80_14][iter_80_15]
			end
		end
	elseif self._layerType == CONFIG_TYPE_JUMP_TOWER then
		local formation_jumptower_manager = require("controller.formation.formation_jumptower_manager")
		local var_80_25 = formation_jumptower_manager:getInstance():getFormationInfo()
		local var_80_26 = {}

		for iter_80_16 = 1, #formation_jumptower_manager do
			var_80_26[iter_80_16] = {
				id = iter_80_16
			}

			for iter_80_17 = 1, #var_80_25[iter_80_16] do
				var_80_26[iter_80_16]["pos_" .. var_80_25[iter_80_16][iter_80_17].pos] = var_80_25[iter_80_16][iter_80_17]
			end
		end
	elseif self._layerType == CONFIG_TYPE_BOSS_FIGHT then
		local formation_bossfight_manager = require("controller.formation.formation_bossfight_manager")
		local var_80_28 = formation_bossfight_manager:getInstance():getFormationInfo()
		local var_80_29 = {}

		for iter_80_18 = 1, #formation_bossfight_manager do
			var_80_29[iter_80_18] = {
				id = iter_80_18
			}

			for iter_80_19 = 1, #var_80_28[iter_80_18] do
				var_80_29[iter_80_18]["pos_" .. var_80_28[iter_80_18][iter_80_19].pos] = var_80_28[iter_80_18][iter_80_19]
			end
		end
	elseif self._layerType == CONFIG_TYPE_GROUP_FIGHT then
		local formation_groupfight_manager = require("controller.formation.formation_groupfight_manager")
		local var_80_31 = formation_groupfight_manager:getInstance():getFormationInfo()
		local var_80_32 = {}

		for iter_80_20 = 1, #formation_groupfight_manager do
			var_80_32[iter_80_20] = {
				id = iter_80_20
			}

			for iter_80_21 = 1, #var_80_31[iter_80_20] do
				var_80_32[iter_80_20]["pos_" .. var_80_31[iter_80_20][iter_80_21].pos] = var_80_31[iter_80_20][iter_80_21]
			end
		end

		return var_80_32
	end

	return {}
end

function QuickFormationManager:getCurFormationInfo()
	return self:getFormationInfo()[self._formationIndex] or {}
end

function QuickFormationManager:getFormationNum()
	if self._layerType == CONFIG_TYPE_HANGUP or self._layerType == CONFIG_TYPE_REFIGHT or self._layerType == CONFIG_TYPE_EXPLORE then
		return #require("model.playermodel").arrays
	elseif self._layerType == CONFIG_TYPE_SUBSTITUTION then
		return #self:getFormationInfo()
	elseif self._layerType == CONFIG_TYPE_EXPLORE_HP_INHERIT then
		return 1
	elseif self._layerType == CONFIG_TYPE_GROUP_FIGHT then
		return #self:getFormationInfo()
	end

	return 1
end

function QuickFormationManager:canExtendFormation()
	if self._layerType == CONFIG_TYPE_HANGUP or self._layerType == CONFIG_TYPE_REFIGHT then
		return #(require("model.playermodel").arrays or {}) < MAX_ARRAY_COUNT
	end

	return false
end

function QuickFormationManager:getFightingCapacity()
	if CONFIG_TYPE_TEST_FIGHT_EMPTY == self._layerType or CONFIG_TYPE_TEST_FIGHT_PLAYER == self._layerType then
		return 0
	end

	local var_84_0 = self:getFormationInfo()

	if var_84_0 and var_84_0[self._formationIndex] then
		return (global_trans_number((require("controller.fight_capacity_manager"):getArrayFightCapacity(var_84_0[self._formationIndex], nil, nil, FORMATION_TYPE_TO_FIGHT_TYPE[self._layerType], self._mode or self.mode))))
	end

	return 0
end

function QuickFormationManager:getFightingCapacityByIndex(arg_85_1)
	if CONFIG_TYPE_TEST_FIGHT_EMPTY == self._layerType or CONFIG_TYPE_TEST_FIGHT_PLAYER == self._layerType then
		return 0
	end

	local fight_capacity_manager = require("controller.fight_capacity_manager")
	local var_85_1 = self:getSelectRoleInfo()

	if var_85_1[arg_85_1] then
		if var_85_1[arg_85_1].fight_girl then
			return (global_trans_number((fight_capacity_manager:getSoulFightCapacity(var_85_1[arg_85_1].fight_girl, "number", nil, var_85_1[arg_85_1].assist_girl, nil, nil, FORMATION_TYPE_TO_FIGHT_TYPE[self._layerType], self._mode or self.mode))))
		end
	end

	return 0
end

function QuickFormationManager:isRegisterTeamSkill()
	return true
end

function QuickFormationManager:getTeamSkill()
	local var_87_0 = self:getFormationInfo()

	if var_87_0 and var_87_0[self._formationIndex] then
		local team_skill_manager = require("controller.team_skill_manager")

		return (team_skill_manager:getSkillDes((team_skill_manager:getTeamskillByArrayTbl(var_87_0[self._formationIndex]))))
	end

	return {}
end

function QuickFormationManager:extendSuccess()
	if self.layer then
		self.layer:extendSuccess()
	end
end

function QuickFormationManager:getShowRoleInfo()
	return self.curData
end

function QuickFormationManager:getSelectRoleInfo()
	if self._layerType == CONFIG_TYPE_HANGUP or self._layerType == CONFIG_TYPE_MODE or self._layerType == CONFIG_TYPE_SCOREARENA or self._layerType == CONFIG_TYPE_ARENA or self._layerType == CONFIG_TYPE_ARENA_DEFENCE or self._layerType == CONFIG_TYPE_SUBSTITUTION or self._layerType == CONFIG_TYPE_EXPLORE_HP_INHERIT or self._layerType == CONFIG_TYPE_EXPLORE or self._layerType == CONFIG_TYPE_TEST_FIGHT_EMPTY or self._layerType == CONFIG_TYPE_TEST_FIGHT_PLAYER or self._layerType == CONFIG_TYPE_EXPEDITION or self._layerType == CONFIG_TYPE_REFIGHT or self._layerType == CONFIG_TYPE_SUBSTITUTION_OLD or self._layerType == CONFIG_TYPE_JUMP_TOWER or self._layerType == CONFIG_TYPE_BOSS_FIGHT or self._layerType == CONFIG_TYPE_GROUP_FIGHT then
		return self._curSelectRoleInfo[self._formationIndex]
	end

	return {}
end

function QuickFormationManager:createGirlSprite()
	require("view/Sprite/GirlSprite")

	if self._layerType == CONFIG_TYPE_TEST_FIGHT_EMPTY or self._layerType == CONFIG_TYPE_TEST_FIGHT_PLAYER then
		return GirlSprite:create({
			initType = "enemyFormationStyle",
			isHpInherit = self._isHpInherit
		})
	end

	return GirlSprite:create({
		initType = "formationStype",
		isHpInherit = self._isHpInherit
	})
end

function QuickFormationManager:createTableViewCellSprite()
	require("view/Sprite/GirlSprite")

	if self._layerType == CONFIG_TYPE_TEST_FIGHT_EMPTY or self._layerType == CONFIG_TYPE_TEST_FIGHT_PLAYER then
		return GirlSprite:create({
			initType = "girlSelectTestFightStype",
			isHpInherit = self.isHpInherit
		})
	end

	return GirlSprite:create({
		initType = "formationStype",
		isHpInherit = self._isHpInherit
	})
end

function QuickFormationManager:getAlternativeRoleInfo()
	local hexie_manager = require("controller.hexie_manager")
	local train_manager = require("controller.train_manager")
	local core_manager = require("controller.core_manager")
	local souls_manager = require("controller.souls_manager")
	local explore_manager = require("controller.explore_manager")
	local fight_capacity_manager = require("controller.fight_capacity_manager")
	local playermodel = require("model.playermodel")
	local var_93_7 = {}

	if self._layerType == CONFIG_TYPE_HANGUP or self._layerType == CONFIG_TYPE_MODE or self._layerType == CONFIG_TYPE_SCOREARENA or self._layerType == CONFIG_TYPE_ARENA or self._layerType == CONFIG_TYPE_ARENA_DEFENCE or self._layerType == CONFIG_TYPE_SUBSTITUTION or self._layerType == CONFIG_TYPE_EXPLORE_HP_INHERIT or self._layerType == CONFIG_TYPE_EXPLORE or self._layerType == CONFIG_TYPE_TEST_FIGHT_EMPTY or self._layerType == CONFIG_TYPE_TEST_FIGHT_PLAYER or self._layerType == CONFIG_TYPE_EXPEDITION or self._layerType == CONFIG_TYPE_REFIGHT or self._layerType == CONFIG_TYPE_SUBSTITUTION_OLD or self._layerType == CONFIG_TYPE_JUMP_TOWER or self._layerType == CONFIG_TYPE_BOSS_FIGHT or self._layerType == CONFIG_TYPE_GROUP_FIGHT then
		for iter_93_0, iter_93_1 in pairs(servant_data) do
			local var_93_8 = iter_93_1.classtype == 1 and not playermodel:isServantLockByTime(iter_93_1.id)

			if iter_93_1.classtype == 1 and servant_data[iter_93_1.id].linkage and not playermodel.haveServant[iter_93_1.id] then
				var_93_8 = false
			end

			if not hexie_manager:canShowServant(iter_93_1.id) then
				var_93_8 = false
			end

			if self._excludeRoleInfo[iter_93_1.id] then
				var_93_8 = false
			end

			if (not playermodel.haveServant[iter_93_1.id] or nil) and false then
				if playermodel.skill1Level[iter_93_1.id] >= MAX_SKILL1_LEVLE then
					-- block empty
				end

				if playermodel.fitness[iter_93_1.id].fitnesslevel == train_manager:getSwimMaxLevel() then
					-- block empty
				end

				local var_93_11 = {
					ownNum = 0,
					skill1UpLevel = 0,
					fitnessLevel = 0,
					favorlevel = 0,
					soulid = iter_93_1.id,
					LV = core_manager:getCoreLv(iter_93_1.id),
					fightCapacity = fight_capacity_manager:getSoulFightCapacity(iter_93_1.id, "number"),
					order = servant_data[iter_93_1.id].order,
					rarity = souls_manager:get_servant_cur_roll_rarity(iter_93_1.id),
					sortRarity = souls_manager:get_servant_cur_roll_rarity(iter_93_1.id),
					hpInherit = explore_manager:getHpInherit(iter_93_1.id),
					isHelpBattle = self:isHelpBattle(iter_93_1.id)
				}

				if not playermodel.haveServant[iter_93_1.id] then
					var_93_11.LV = 0
					var_93_11.fightCapacity = 0
					var_93_11.skill1UpLevel = 0
					var_93_11.fitnessLevel = 0
					var_93_11.order = 0
				end

				table.insert(var_93_7, var_93_11)
			end
		end
	end

	return var_93_7
end

function QuickFormationManager:isHelpBattle(arg_94_1, arg_94_2)
	if self._layerType == CONFIG_TYPE_EXPEDITION then
		return false
	end

	arg_94_2 = arg_94_2 or self._formationIndex

	for iter_94_0, iter_94_1 in pairs((require("controller/help_battle/help_battle_manager"):getInstance():getAllServants(arg_94_2))) do
		for iter_94_2, iter_94_3 in pairs(iter_94_1) do
			if arg_94_1 == iter_94_3 then
				return true
			end
		end
	end

	return false
end

function QuickFormationManager:soulsLayerExitCallBack()
	if self.layer then
		self.layer:soulsLayerExitCallBack()
	end
end

function QuickFormationManager:changeHorcruxSuccess()
	if self.layer then
		self.layer:changeHorcruxSuccess()
	end
end

function QuickFormationManager:changeRoleSuccess(arg_97_1)
	if self.layer then
		self.layer:changeRoleSuccess(arg_97_1)
	end
end

function QuickFormationManager:selectWeapon(arg_98_1)
	local playermodel = require("model.playermodel")
	local item_data = require("data.item_data")
	local var_98_2 = self:getSelectRoleInfo()

	if var_98_2[arg_98_1] and var_98_2[arg_98_1].fight_girl and (self._layerType == CONFIG_TYPE_HANGUP or self._layerType == CONFIG_TYPE_MODE or self._layerType == CONFIG_TYPE_SCOREARENA or self._layerType == CONFIG_TYPE_ARENA or self._layerType == CONFIG_TYPE_ARENA_DEFENCE or self._layerType == CONFIG_TYPE_SUBSTITUTION or self._layerType == CONFIG_TYPE_EXPLORE or self._layerType == CONFIG_TYPE_EXPEDITION or self._layerType == CONFIG_TYPE_REFIGHT or self._layerType == CONFIG_TYPE_EXPLORE_HP_INHERIT or self._layerType == CONFIG_TYPE_GROUP_FIGHT) then
		local var_98_3 = var_98_2[arg_98_1].fight_girl

		if playermodel.items[playermodel.weaponId[var_98_2[arg_98_1].fight_girl]] then
			LayerManager:pushInLayer("PopWeaponUpLevelList", {
				entityid = playermodel.weaponId[var_98_2[arg_98_1].fight_girl]
			})
		else
			local weapon_manager = require("controller.weapon_manager")

			if weapon_manager:checkIsCanReplaceBetter(var_98_3) then
				local var_98_5

				for iter_98_0, iter_98_1 in pairs(playermodel.items) do
					if iter_98_1.itemtype == kITEM_WEAPON and item_data[iter_98_1.itemid].servant == var_98_3 then
						var_98_5 = iter_98_0
					end
				end

				local var_98_6 = require("controller.model_manager").new()

				var_98_6:initPlayerAttribute(var_98_3)

				local var_98_7, var_98_8 = require("controller.component_manager"):getSoulComponentlist(var_98_3)

				var_98_6:updateComponentAttr(var_98_7)

				if playermodel.haveServant[var_98_3] and playermodel.weaponId[var_98_3] then
					var_98_6:updateWeaponAttr((weapon_manager:getWeaponConfig(playermodel.items[playermodel.weaponId[var_98_3]])))
				end

				require("controller.fight_capacity_manager"):saveSoulAttr(var_98_3, var_98_6)
				weapon_manager:replaceRoleWeapon(var_98_3, var_98_5, function(arg_99_0)
					if arg_99_0 == 1 then
						LayerManager:pushInLayer("WeaponBreakAnimationLayer", {
							servantId = var_98_3
						})
					end
				end)
			else
				LayerManager:pushInLayer("PopItemLayer", {
					itemid = require("data.servant_data")[var_98_3].recommend_weapon2
				})
			end
		end
	end
end

return QuickFormationManager
