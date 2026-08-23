local ObtDebugConst = require("app.view.module.debug.OnlineBattleTest.ObtDebugConst")
local ObtData = class("ObtData")

function ObtData:ctor()
	self._curVersion = 0
	self._showProgressIndex = 1
	self._ip = ObtDebugConst.DEFAULT_IP
	self._port = ObtDebugConst.DEFAULT_PORT

	self:resetData()
end

function ObtData:setIp(arg_2_1)
	self._ip = arg_2_1
end

function ObtData:getIp()
	return self._ip
end

function ObtData:setPort(arg_4_1)
	self._port = arg_4_1
end

function ObtData:getPort()
	return self._port
end

function ObtData:resetData()
	self._allUserBattleTeamDict = {}
	self._indexBattleTeam = {}
	self._allBattleList = {}
	self._battleResultDict = {}
	self._versionConfig = {}
end

function ObtData:getShowProgressIndex()
	return self._showProgressIndex
end

function ObtData:setShowProgressIndex(arg_8_1)
	self._showProgressIndex = arg_8_1
end

function ObtData:setAllBattle(arg_9_1)
	self._allBattleList = arg_9_1
end

function ObtData:getAllBattleList()
	return self._allBattleList
end

function ObtData:getBattle(arg_11_1)
	return self._allBattleList[arg_11_1]
end

function ObtData:setUserBattleTeamUid(arg_12_1, arg_12_2)
	self._allUserBattleTeamDict[arg_12_2] = arg_12_1
end

function ObtData:setUserBattleTeamIndex(arg_13_1, arg_13_2)
	self._indexBattleTeam[arg_13_2] = arg_13_1
end

function ObtData:getUserBattleTeamUid(arg_14_1)
	return self._allUserBattleTeamDict[arg_14_1]
end

function ObtData:getUserBattleTeamIndex(arg_15_1)
	return self._indexBattleTeam[arg_15_1]
end

function ObtData:setBattleResult(arg_16_1, arg_16_2, arg_16_3)
	self._battleResultDict[arg_16_1 .. "_" .. arg_16_2] = arg_16_3
end

function ObtData:getBattleResult(arg_17_1, arg_17_2)
	return self._battleResultDict[arg_17_1 .. "_" .. arg_17_2]
end

function ObtData:setVersionConfig(arg_18_1)
	self._versionConfig = arg_18_1
end

function ObtData:getOnceBattleCount()
	if self._versionConfig then
		return self._versionConfig.BattleCount
	end

	return 0
end

function ObtData:setVersion(arg_20_1)
	if self._curVersion == arg_20_1 then
		return
	end

	self._curVersion = arg_20_1

	self:resetData()
end

local var_0_2

return setmetatable({}, {
	__index = function(arg_21_0, arg_21_1)
		var_0_2 = var_0_2 or ObtData.new()

		return var_0_2[arg_21_1]
	end,
	__newindex = function(arg_22_0, arg_22_1, arg_22_2)
		var_0_2 = var_0_2 or ObtData.new()
		var_0_2[arg_22_1] = arg_22_2
	end
})
