local FormationBossfightManager = class("FormationBossfightManager", (require("controller.formation.base_formation_manager")))

FormationBossfightManager.MULTITON_MSG = "formationGroupfightManager instancealready constructed!"

local playermodel = require("model.playermodel")
local activity_manager = require("controller.activity_manager")
local level_manager = require("controller.level_manager")

function FormationBossfightManager:ctor()
	FormationBossfightManager.super.ctor(self)
end

function FormationBossfightManager:CountTeamNum(arg_2_1)
	local var_2_0
	local var_2_1 = level_manager.getCurLevelData(arg_2_1.mode, arg_2_1.chapter .. "-" .. arg_2_1.level)

	for iter_2_0 = 1, 10 do
		if iter_2_0 ~= 1 and not var_2_1["boss_team_" .. iter_2_0] then
			var_2_0 = iter_2_0 - 1

			break
		end
	end

	return var_2_0
end

function FormationBossfightManager:CheckTeam()
	local var_3_0 = self:getFormationInfo()

	for iter_3_0 = 1, self.groupNum do
		for iter_3_1 = 1, 5 do
			if var_3_0[iter_3_0][iter_3_1].fight_girl then
				break
			end

			if iter_3_1 == 5 and not var_3_0[iter_3_0][5].fight_girl then
				return iter_3_0
			end
		end
	end

	return nil
end

function FormationBossfightManager:requestInfo(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self.groupNum = self:CountTeamNum(arg_4_3)

	self:requestModeInfo(arg_4_1, arg_4_2, function(arg_5_0)
		if arg_5_0.result == 1 then
			self._mode = arg_4_1

			if arg_4_4 then
				arg_4_4(arg_5_0)
			end
		end
	end)
end

function FormationBossfightManager:handlerInfo(arg_6_1)
	self:updateFormationInfo(arg_6_1)
	self:updateLayer()
end

function FormationBossfightManager:updateInfo(arg_7_1)
	self:updateFormationInfo(arg_7_1)
	self:updateGirl()
end

function FormationBossfightManager:requestModeInfo(arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = {
		{
			{}
		}
	}

	for iter_8_0 = 1, self.groupNum do
		var_8_0[iter_8_0] = {}

		for iter_8_1 = 1, 5 do
			if RoleDefault:getInstance():getStringForKey(tostring(arg_8_1) .. "-" .. tostring(iter_8_0) .. "-" .. tostring(iter_8_1)) then
				local var_8_1 = {}

				var_8_1.fight_girl = tonumber(RoleDefault:getInstance():getStringForKey(tostring(arg_8_1) .. "-" .. tostring(iter_8_0) .. "-" .. tostring(iter_8_1)))
				var_8_1.pos = iter_8_1
				var_8_0[iter_8_0][iter_8_1] = var_8_1
				var_8_0[iter_8_0][iter_8_1].pos = iter_8_1
			else
				var_8_0[iter_8_0][iter_8_1] = {
					pos = iter_8_1
				}
				var_8_0[iter_8_0][iter_8_1].pos = iter_8_1
			end
		end
	end

	self:handlerInfo(var_8_0)
end

function FormationBossfightManager:updateModeInfo(arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = {
		{
			{}
		}
	}

	for iter_9_0 = 1, self.groupNum do
		var_9_0[iter_9_0] = {}

		for iter_9_1 = 1, 5 do
			if RoleDefault:getInstance():getStringForKey(tostring(arg_9_1) .. "-" .. tostring(iter_9_0) .. "-" .. tostring(iter_9_1)) then
				local var_9_1 = {}

				var_9_1.fight_girl = tonumber(RoleDefault:getInstance():getStringForKey(tostring(arg_9_1) .. "-" .. tostring(iter_9_0) .. "-" .. tostring(iter_9_1)))
				var_9_1.pos = iter_9_1
				var_9_0[iter_9_0][iter_9_1] = var_9_1
				var_9_0[iter_9_0][iter_9_1].pos = iter_9_1
			else
				var_9_0[iter_9_0][iter_9_1] = {
					pos = iter_9_1
				}
				var_9_0[iter_9_0][iter_9_1].pos = iter_9_1
			end
		end
	end

	self:updateInfo(var_9_0)
end

function FormationBossfightManager:autoTeam(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	for iter_10_0 = arg_10_4 + 1, 5 do
		for iter_10_1 = 1, 5 do
			for iter_10_2, iter_10_3 in pairs(arg_10_2) do
				if RoleDefault:getInstance():getStringForKey(tostring(arg_10_1) .. "-" .. tostring(iter_10_0) .. "-" .. tostring(iter_10_1)) then
					if RoleDefault:getInstance():getStringForKey(tostring(arg_10_1) .. "-" .. tostring(iter_10_0) .. "-" .. tostring(iter_10_1)) == tostring(iter_10_3.fight_girl) then
						RoleDefault:getInstance():setStringForKey(tostring(arg_10_1) .. "-" .. tostring(iter_10_0) .. "-" .. tostring(iter_10_1), nil)
					end
				end
			end
		end
	end

	for iter_10_4, iter_10_5 in pairs(arg_10_2) do
		if string.sub(iter_10_4, 1, 3) == "pos" then
			RoleDefault:getInstance():setStringForKey(tostring(arg_10_1) .. "-" .. tostring(arg_10_3) .. "-" .. tostring(iter_10_5.pos), iter_10_5.fight_girl)
		end
	end

	self:updateModeInfo(arg_10_1)
end

function FormationBossfightManager:requestUpdateModeFightGirl(arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	local var_11_0 = self:getFormationInfo()

	for iter_11_0 = 1, 5 do
		for iter_11_1 = 1, 5 do
			if RoleDefault:getInstance():getStringForKey(tostring(arg_11_1) .. "-" .. tostring(iter_11_0) .. "-" .. tostring(iter_11_1)) then
				if RoleDefault:getInstance():getStringForKey(tostring(arg_11_1) .. "-" .. tostring(iter_11_0) .. "-" .. tostring(iter_11_1)) == tostring(arg_11_3) then
					RoleDefault:getInstance():setStringForKey(tostring(arg_11_1) .. "-" .. tostring(iter_11_0) .. "-" .. tostring(iter_11_1), nil)

					break
				end
			end
		end
	end

	RoleDefault:getInstance():setStringForKey(tostring(arg_11_1) .. "-" .. tostring(arg_11_4) .. "-" .. tostring(arg_11_2), arg_11_3)
	self:updateModeInfo(arg_11_1)
end

function FormationBossfightManager:updateFormationInfo(arg_12_1)
	self._formationInfo = {}

	for iter_12_0 = 1, self.groupNum do
		self._formationInfo[iter_12_0] = arg_12_1[iter_12_0]
	end
end

function FormationBossfightManager:getFormationInfo()
	return self._formationInfo
end

function FormationBossfightManager:getAssistsInfo()
	local var_14_0 = {}
	local var_14_1 = self:getFormationInfo()

	for iter_14_0 = 1, #var_14_1 do
		var_14_0[iter_14_0] = var_14_1[iter_14_0].assist or {}
	end

	return var_14_0
end

function FormationBossfightManager:requestOneTimeUpdateArray(arg_15_1, arg_15_2, arg_15_3)
	arg_15_1 = arg_15_1 or 1

	local var_15_0 = self:getFormationInfo()[arg_15_1]
	local audio_manager = require("controller.audio_manager")

	arg_15_2.assist = arg_15_2.assist or var_15_0.assist or {}

	require("network.network"):rpc("update_adventure_array_onekey", {
		mode = self._mode,
		battlearray = arg_15_2
	}, function(arg_16_0)
		if arg_16_0.result == 1 then
			self:updateFormationInfo(arg_16_0.array)
			self:oneTimeUpdateSuccess()

			local var_16_0 = {}

			for iter_16_0, iter_16_1 in pairs(arg_15_2) do
				if type(iter_16_1) == "table" then
					var_16_0[iter_16_0] = iter_16_1
				end
			end

			if arg_15_3 then
				arg_15_3(arg_16_0)
			end

			self:playVoiceByArray(var_15_0, var_16_0)
		elseif arg_16_0.result == 2 then
			global_ShowBlockWords("角色未解锁")
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_16_0.result == 3 then
			global_ShowBlockWords("无效魂器")
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_16_0.result == 4 then
			global_ShowBlockWords("魂器对应位置未设置角色")
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_16_0.result == 5 then
			global_ShowBlockWords("设置了重复角色和魂器")
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_16_0.result == 6 then
			global_ShowBlockWords("挂机阵容不能为空")
			audio_manager:playeffectMusicTest("sound/invalid")
		end
	end)
end

function FormationBossfightManager:getAdvanceForcesOneTimeArray()
	local playermodel = require("model.playermodel")
	local var_17_1 = {}

	for iter_17_0, iter_17_1 in pairs(playermodel.arrays[playermodel.curArray]) do
		if type(iter_17_1) == "table" then
			var_17_1[iter_17_0] = iter_17_1
		end
	end

	return var_17_1
end

return FormationBossfightManager
