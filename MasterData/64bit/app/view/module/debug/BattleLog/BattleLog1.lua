if require("battle.const.BattleConst").BATTLE_LOG_BL ~= 1 then
	setmetatable(BLog, {
		__index = function(arg_1_0, arg_1_1)
			if BLog[arg_1_1] then
				return BLog[arg_1_1]
			end

			return function()
				return
			end
		end
	})

	return
end

local BattleConst = require("battle.const.BattleConst")
local BattleLogCheck = require("app.view.module.debug.BattleLog.BattleLogCheck")
local var_0_2 = {}

function var_0_2.LogText(arg_3_0)
	var_0_2.file:log(arg_3_0)
end

function var_0_2.LogEffect(arg_4_0)
	var_0_2.file:log(BattleLogCheck.getEffectCheck(arg_4_0), "->[effect] ")
end

function var_0_2.LogExtraEffect(arg_5_0, arg_5_1)
	var_0_2.file:log(BattleLogCheck.getEffectCheck(arg_5_0), string.format("->[extraEffect] %s ", arg_5_1))
end

function var_0_2.LogSkillEffect(arg_6_0, arg_6_1)
	if BattleConst.BL_SHOW_SHOW_SKILL_EFFECT[arg_6_0] ~= true then
		return
	end

	var_0_2.file:log(string.format("开始计算技能效果:%d %s", arg_6_0, BattleLogCheck.getSkillEffectCheck(arg_6_0, arg_6_1)), "-->[onSkillEffect] ")
end

function var_0_2.LogAttackRound(arg_7_0, arg_7_1)
	var_0_2.file:log("\n")
	var_0_2.file:log(string.format("第%d回合,攻击次数:%d", arg_7_1, arg_7_0), "> ")
	var_0_2.file:log("\n")
end

local var_0_3 = false

function var_0_2.EnableLogBuff(arg_8_0)
	var_0_3 = arg_8_0
end

function var_0_2:LogBuff()
	if not var_0_3 then
		return
	end

	if BattleConst.BL_SHOW_BUFF[0] ~= true and BattleConst.BL_SHOW_BUFF[self.buffCfg.id] ~= true then
		return
	end

	var_0_2.file:log(BattleLogCheck.getBuffStrCheck(self), "--->[doBuff] ")
end

function var_0_2:LogAddBuff()
	if BattleConst.BL_SHOW_BUFF[0] ~= true and BattleConst.BL_SHOW_BUFF[self.buffCfg.id] ~= true then
		return
	end

	var_0_2.file:log(BattleLogCheck.getAddBuffStrCheck(self), "--->[addBuff] ")
end

function var_0_2:LogDelBuff()
	if BattleConst.BL_SHOW_BUFF[0] ~= true and BattleConst.BL_SHOW_BUFF[self.buffCfg.id] ~= true then
		return
	end

	var_0_2.file:log(BattleLogCheck.getDelBuffStrCheck(self), "--->[delBuff] ")
end

function var_0_2.LogAttackKnight(arg_12_0)
	var_0_2.file:log(BattleLogCheck.GetKnightName(arg_12_0), "->角色出手 ")
end

function var_0_2:LogComboSkill()
	var_0_2.file:log(string.format("%s 释放合击:%d-%s", self.identity == 2 and "敌方" or "我方", self.id, self.name), "->玩家出手 ")
end

function var_0_2.LogPassiveSkill(arg_14_0)
	var_0_2.file:log(BattleLogCheck.getPassiveStrCheck(arg_14_0), "->被动触发 ")
end

function var_0_2:LogHpChange(arg_15_1, arg_15_2)
	var_0_2.file:log(string.format("%s  原本:%d 变为:%d 扣血:%d 剩余护盾:%d 当前血量千分比:%d", BattleLogCheck.GetKnightName(self), arg_15_1, arg_15_2, arg_15_2 - arg_15_1, self.baseInfo.SHIELD, self:getHpRate()), "---->血量实际变化 ")
end

function var_0_2.LogStart()
	var_0_2.file:openFile()
end

function var_0_2.LogEnd(arg_17_0)
	var_0_2.file:closeFile(arg_17_0)
end

BLog = {}

setmetatable(BLog, {
	__index = var_0_2
})

local BattleLog = class("BattleLog")

function BattleLog:ctor()
	self._logList = {}
	self._logFile = nil
end

function BattleLog:openFile()
	if self._logFile then
		return
	end

	local var_19_0 = device.writablePath .. "battle_log/BLog/" .. g.core.common.ServerTime:getDate()

	if not cc.FileUtils:getInstance():isDirectoryExist(var_19_0) then
		cc.FileUtils:getInstance():createDirectory(var_19_0)
	end

	local var_19_1, var_19_2, var_19_3 = g.core.common.ServerTime:getCurrentHHMMSS()

	self._logFile = io.open(var_19_0 .. "/" .. (var_19_1 .. "_" .. var_19_2 .. "_" .. var_19_3) .. ".txt", "w")
end

function BattleLog:closeFile(arg_20_1)
	if self._logFile then
		self._logFile:write("\n\n战斗结束\n")

		if BattleConst.BL_SHOW_SHOW_RESULT then
			self:logTable(arg_20_1, "result")
		end

		self._logFile:close()
	end

	self._logFile = nil
end

function BattleLog:log(arg_21_1, arg_21_2)
	arg_21_2 = arg_21_2 or ""

	for iter_21_0, iter_21_1 in pairs(BattleConst.BL_SHOW_SHOW_TAG) do
		if not iter_21_1 and string.find(arg_21_2, string.format("[%s]", iter_21_0), 1, true) then
			return
		end
	end

	self._logFile:write("\n")
	self._logFile:write(arg_21_2:gsub("^%-+", function(arg_22_0)
		return arg_22_0:gsub("%-", " ")
	end) .. arg_21_1)
end

local function var_0_5(arg_23_0, arg_23_1, arg_23_2)
	if type(arg_23_2) ~= "number" then
		arg_23_2 = 10
	end

	local var_23_0 = {}
	local var_23_1 = {}

	local function var_23_2(arg_24_0, arg_24_1)
		if arg_24_1 and type(arg_24_0) == "string" then
			arg_24_0 = "\"" .. arg_24_0 .. "\""
		end

		if type(arg_24_0) == "number" and arg_24_0 > math.pow(10, 9) then
			arg_24_0 = string.format("%d", arg_24_0)
		end

		return tostring(arg_24_0)
	end

	local function var_23_3(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5)
		arg_25_1 = type(arg_25_1) == "number" and string.format("[%s]", arg_25_1) or arg_25_1 or "local result"

		local var_25_0 = ""

		if type(arg_25_4) == "number" then
			var_25_0 = string.rep(" ", arg_25_4 - string.len(var_23_2(arg_25_1)))
		end

		if type(arg_25_0) ~= "table" then
			var_23_1[#var_23_1 + 1] = string.format("%s%s%s = %s,", arg_25_2, var_23_2(arg_25_1), var_25_0, var_23_2(arg_25_0, true))
		elseif var_23_0[tostring(arg_25_0)] then
			var_23_1[#var_23_1 + 1] = string.format("%s%s%s = \"*REF*,\"", arg_25_2, var_23_2(arg_25_1), var_25_0)
		else
			var_23_0[tostring(arg_25_0)] = true

			if arg_25_3 > arg_23_2 then
				var_23_1[#var_23_1 + 1] = string.format("%s%s = \"*MAX NESTING*,\"", arg_25_2, var_23_2(arg_25_1))
			else
				var_23_1[#var_23_1 + 1] = string.format("%s%s = {", arg_25_2, var_23_2(arg_25_1))

				local var_25_1 = arg_25_2 .. "    "
				local var_25_2 = {}
				local var_25_3 = 0
				local var_25_4 = {}

				for iter_25_0, iter_25_1 in pairs(arg_25_0) do
					var_25_2[#var_25_2 + 1] = iter_25_0

					local var_25_5 = string.len((var_23_2(iter_25_0)))

					if var_25_3 < var_25_5 then
						var_25_3 = var_25_5
					end

					var_25_4[iter_25_0] = iter_25_1
				end

				table.sort(var_25_2, function(arg_26_0, arg_26_1)
					if type(arg_26_0) == "number" and type(arg_26_1) == "number" then
						return arg_26_0 < arg_26_1
					else
						return tostring(arg_26_0) < tostring(arg_26_1)
					end
				end)

				for iter_25_2, iter_25_3 in ipairs(var_25_2) do
					var_23_3(var_25_4[iter_25_3], iter_25_3, var_25_1, arg_25_3 + 1, var_25_3, iter_25_2 == #var_25_2)
				end

				var_23_1[#var_23_1 + 1] = string.format("%s}%s", arg_25_2, arg_25_5 and "" or ",")
			end
		end
	end

	var_23_3(arg_23_0, arg_23_1, "", 1, nil, true)

	return var_23_1
end

function BattleLog:logTable(arg_27_1, arg_27_2)
	for iter_27_0, iter_27_1 in ipairs(var_0_5(arg_27_1, arg_27_2)) do
		self._logFile:write(iter_27_1)
		self._logFile:write("\n")
	end
end

var_0_2.file = BattleLog.new()
