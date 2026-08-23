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

function loadCfg(arg_3_0)
	local var_3_1 = BATTLE_CONFIG_TYPE.isOs and (BATTLE_CONFIG_TYPE.config[arg_3_0] or arg_3_0) or arg_3_0
	local var_3_2 = require(table.concat({
		"app.",
		var_3_1
	}, ""))

	if not string.find(arg_3_0, "language_info") and type(var_3_2) == "table" and not var_3_2.oldGet and var_3_2.get then
		var_3_2.oldGet = var_3_2.get

		function var_3_2.get()
			local var_4_0 = var_3_2.oldGet(...)

			if not var_4_0 then
				printError(string.format("cannot find %s key %s", var_3_1, table.concat({
					...
				})))
			end

			return var_4_0
		end
	end

	return var_3_2
end

local BattleConst = require("battle.const.BattleConst")
local BattleLogCheck = require("app.view.module.debug.BattleLog.BattleLogCheck")

local function var_0_2(arg_5_0, arg_5_1)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_0) do
		var_5_0[iter_5_0] = iter_5_1
	end

	var_5_0.victim = var_5_0.victim or arg_5_1

	return var_5_0
end

local var_0_3 = {
	succubaSkill = "魔女出手",
	effect = "[effect]",
	comboSkill = "玩家出手",
	doBuff = "[doBuff]",
	delBuff = "[delBuff]",
	addBuff = "[addBuff]",
	round = "回合攻击次数",
	passiveSkill = "被动触发",
	onSkillEffect = "[onSkillEffect]",
	hpChange = "血量实际变化",
	extraEffect = "[extraEffect]",
	fightSkill = "计算技能",
	attackKnight = "角色出手",
	logTip = "打印提示"
}
local var_0_4 = {}
local var_0_5 = {
	LogText = function(arg_6_0)
		table.insert(var_0_4, {
			tag = var_0_3.logTip,
			data = arg_6_0
		})
	end,
	ExecuteStart = function()
		var_0_4 = {}
	end
}
local var_0_6 = "        "
local var_0_7 = {
	[var_0_3.round] = function(arg_8_0)
		var_0_5.file:log("\n")
		var_0_5.file:log("", string.format("> 第%d回合,攻击次数:%d", arg_8_0.dataList[1].round, arg_8_0.dataList[1].count))
		var_0_5.file:log("\n")
	end,
	[var_0_3.effect] = function(arg_9_0)
		var_0_5.file:log("", "->[effect] x " .. #arg_9_0.dataList)

		for iter_9_0, iter_9_1 in ipairs(arg_9_0.dataList) do
			var_0_5.file:log(BattleLogCheck.getEffectCheck(iter_9_1), var_0_6)
		end
	end,
	[var_0_3.extraEffect] = function(arg_10_0)
		var_0_5.file:log("", "->[extraEffect] x " .. #arg_10_0.dataList)

		for iter_10_0, iter_10_1 in ipairs(arg_10_0.dataList) do
			var_0_5.file:log(BattleLogCheck.getEffectCheck(iter_10_1.effect), var_0_6)
		end
	end,
	[var_0_3.onSkillEffect] = function(arg_11_0)
		var_0_5.file:log("", "->[onSkillEffect] x " .. #arg_11_0.dataList)

		for iter_11_0, iter_11_1 in ipairs(arg_11_0.dataList) do
			var_0_5.file:log(string.format("开始计算技能效果:%d %s", iter_11_1.tp, BattleLogCheck.getSkillEffectCheck(iter_11_1.tp, iter_11_1.effect)), var_0_6)
		end
	end,
	[var_0_3.doBuff] = function(arg_12_0, arg_12_1)
		arg_12_1 = arg_12_1 or ""

		var_0_5.file:log("", "->" .. arg_12_1 .. "[doBuff] x " .. #arg_12_0.dataList)

		if BattleConst.BL_MERGE_SAME_BUFF then
			local var_12_0 = {}

			for iter_12_0, iter_12_1 in ipairs(arg_12_0.dataList) do
				local var_12_1 = BattleLogCheck.getBuffStrCheck(iter_12_1)

				if var_12_0[var_12_1] then
					var_12_0[var_12_1].count = var_12_0[var_12_1].count + 1
				else
					var_12_0[var_12_1] = {
						count = 1,
						data = iter_12_1
					}
				end
			end

			for iter_12_2, iter_12_3 in pairs(var_12_0) do
				var_0_5.file:log(iter_12_2 .. " x " .. iter_12_3.count, var_0_6 .. arg_12_1)
			end
		else
			for iter_12_4, iter_12_5 in ipairs(arg_12_0.dataList) do
				var_0_5.file:log(BattleLogCheck.getBuffStrCheck(iter_12_5), var_0_6 .. arg_12_1)
			end
		end
	end,
	[var_0_3.addBuff] = function(arg_13_0)
		var_0_5.file:log("", "->[addBuff] x " .. #arg_13_0.dataList)

		if BattleConst.BL_MERGE_SAME_BUFF then
			local var_13_0 = {}

			for iter_13_0, iter_13_1 in ipairs(arg_13_0.dataList) do
				local var_13_1 = BattleLogCheck.getAddBuffStrCheck(iter_13_1)

				if var_13_0[var_13_1] then
					var_13_0[var_13_1].count = var_13_0[var_13_1].count + 1
				else
					var_13_0[var_13_1] = {
						count = 1,
						data = iter_13_1
					}
				end
			end

			for iter_13_2, iter_13_3 in pairs(var_13_0) do
				var_0_5.file:log(iter_13_2 .. " x " .. iter_13_3.count, var_0_6)
			end
		else
			for iter_13_4, iter_13_5 in ipairs(arg_13_0.dataList) do
				var_0_5.file:log(BattleLogCheck.getAddBuffStrCheck(iter_13_5), var_0_6)
			end
		end
	end,
	[var_0_3.delBuff] = function(arg_14_0)
		var_0_5.file:log("", "->[delBuff] x " .. #arg_14_0.dataList)

		if BattleConst.BL_MERGE_SAME_BUFF then
			local var_14_0 = {}

			for iter_14_0, iter_14_1 in ipairs(arg_14_0.dataList) do
				local var_14_1 = BattleLogCheck.getDelBuffStrCheck(iter_14_1)

				if var_14_0[var_14_1] then
					var_14_0[var_14_1].count = var_14_0[var_14_1].count + 1
				else
					var_14_0[var_14_1] = {
						count = 1,
						data = iter_14_1
					}
				end
			end

			for iter_14_2, iter_14_3 in pairs(var_14_0) do
				var_0_5.file:log(iter_14_2 .. " x " .. iter_14_3.count, var_0_6)
			end
		else
			for iter_14_4, iter_14_5 in ipairs(arg_14_0.dataList) do
				var_0_5.file:log(BattleLogCheck.getDelBuffStrCheck(iter_14_5), var_0_6)
			end
		end
	end,
	[var_0_3.attackKnight] = function(arg_15_0)
		var_0_5.file:log(BattleLogCheck.GetKnightName(arg_15_0.dataList[1]), "->角色出手 ")
	end,
	[var_0_3.comboSkill] = function(arg_16_0)
		var_0_5.file:log(string.format("%s 释放合击:%d-%s", arg_16_0.dataList[1].identity == 2 and "敌方" or "我方", arg_16_0.dataList[1].id, arg_16_0.dataList[1].name or ""), "-> 玩家出手 ")
	end,
	[var_0_3.passiveSkill] = function(arg_17_0)
		var_0_5.file:log("", "-> 被动触发 ")
		var_0_5.file:log(BattleLogCheck.getPassiveStrCheck(arg_17_0.dataList[1]), var_0_6)
	end,
	[var_0_3.fightSkill] = function(arg_18_0)
		var_0_5.file:log("", "-> 计算技能 skill_info.id :" .. arg_18_0.dataList[1].id)
	end,
	[var_0_3.hpChange] = function(arg_19_0, arg_19_1)
		arg_19_1 = arg_19_1 or ""

		var_0_5.file:log("", "-> " .. arg_19_1 .. " 血量实际变化 ")

		local var_19_0 = arg_19_0.dataList[1].knight
		local var_19_1 = arg_19_0.dataList[1].damage
		local var_19_2 = arg_19_0.dataList[1].afterValue - arg_19_0.dataList[1].beforeValue
		local var_19_3 = ""

		if arg_19_0.dataList[1].damage > 0 then
			var_19_3 = "%s  原本:%d 变为:%d 实际加血:%d 实际治疗值:%d 剩余护盾:%d 当前血量千分比:%d"
		else
			var_19_3 = "%s  原本:%d 变为:%d 实际扣血:%d 造成实际伤害:%d 剩余护盾:%d 当前血量千分比:%d"
			var_19_1 = -var_19_1
			var_19_2 = -var_19_2
		end

		var_0_5.file:log(string.format(var_19_3, BattleLogCheck.GetKnightName(var_19_0), arg_19_0.dataList[1].beforeValue, arg_19_0.dataList[1].afterValue, var_19_2, var_19_1, arg_19_0.dataList[1].knight.baseInfo.SHIELD, var_19_0:getHpRate()), var_0_6 .. arg_19_1)
	end,
	[var_0_3.succubaSkill] = function(arg_20_0)
		var_0_5.file:log(string.format("%s 魔女出手:%d-%s", arg_20_0.dataList[1].identity == 2 and "敌方" or "我方", arg_20_0.dataList[1].id, arg_20_0.dataList[1].name or ""), "-> 魔女主动 ")
	end,
	[var_0_3.logTip] = function(arg_21_0)
		for iter_21_0, iter_21_1 in ipairs(arg_21_0.dataList) do
			var_0_5.file:log(string.format("> 打印提示:%s", iter_21_1), var_0_6)
		end
	end
}

function var_0_5.ExecuteEnd()
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs(var_0_4) do
		local var_22_1

		if "" == iter_22_1.tag then
			table.insert(var_22_0[#var_22_0].dataList, iter_22_1.data)
		else
			var_22_1 = iter_22_1.tag

			table.insert(var_22_0, {
				tag = iter_22_1.tag,
				dataList = {
					iter_22_1.data
				}
			})
		end
	end

	local var_22_2 = ""
	local var_22_3 = false

	for iter_22_2, iter_22_3 in ipairs(var_22_0) do
		if iter_22_3.tag == var_0_3.onSkillEffect then
			var_22_3 = true
			var_22_2 = ""
		end

		if var_22_3 then
			var_22_2 = var_22_2 .. "\t"
		end

		var_0_7[iter_22_3.tag](iter_22_3, var_22_2)

		if iter_22_3.tag == var_0_3.hpChange or iter_22_3.tag == var_0_3.attackKnight or iter_22_3.tag == var_0_3.comboSkill or iter_22_3.tag == var_0_3.passiveSkill or iter_22_3.tag == var_0_3.fightSkill or iter_22_3.tag == var_0_3.doBuff or iter_22_3.tag == var_0_3.round then
			var_22_3 = false
			var_22_2 = ""
		end
	end
end

function var_0_5.LogEffect(arg_23_0)
	table.insert(var_0_4, {
		tag = var_0_3.effect,
		data = var_0_2(arg_23_0)
	})
end

function var_0_5.LogExtraEffect(arg_24_0, arg_24_1)
	table.insert(var_0_4, {
		tag = var_0_3.extraEffect,
		data = {
			effect = var_0_2(arg_24_0),
			tp = arg_24_1
		}
	})
end

function var_0_5.LogSkillEffect(arg_25_0, arg_25_1, arg_25_2)
	if BattleConst.BL_SHOW_SHOW_SKILL_EFFECT[0] ~= true and BattleConst.BL_SHOW_SHOW_SKILL_EFFECT[arg_25_0] ~= true then
		return
	end

	table.insert(var_0_4, {
		tag = var_0_3.onSkillEffect,
		data = {
			effect = var_0_2(arg_25_1, arg_25_2),
			tp = arg_25_0
		}
	})
end

function var_0_5.LogAttackRound(arg_26_0, arg_26_1)
	table.insert(var_0_4, {
		tag = var_0_3.round,
		data = {
			count = arg_26_0,
			round = arg_26_1
		}
	})
end

function var_0_5.LogBuff(arg_27_0)
	table.insert(var_0_4, {
		tag = var_0_3.doBuff,
		data = arg_27_0
	})
end

function var_0_5.LogAddBuff(arg_28_0)
	table.insert(var_0_4, {
		tag = var_0_3.addBuff,
		data = arg_28_0
	})
end

function var_0_5.LogDelBuff(arg_29_0)
	table.insert(var_0_4, {
		tag = var_0_3.delBuff,
		data = arg_29_0
	})
end

function var_0_5.LogAttackKnight(arg_30_0)
	table.insert(var_0_4, {
		tag = var_0_3.attackKnight,
		data = arg_30_0
	})
end

function var_0_5.LogComboSkill(arg_31_0)
	table.insert(var_0_4, {
		tag = var_0_3.comboSkill,
		data = arg_31_0
	})
end

function var_0_5.LogSuccubaSkill(arg_32_0)
	table.insert(var_0_4, {
		tag = var_0_3.succubaSkill,
		data = arg_32_0
	})
end

function var_0_5.LogPassiveSkill(arg_33_0)
	table.insert(var_0_4, {
		tag = var_0_3.passiveSkill,
		data = arg_33_0
	})
end

function var_0_5.LogFightSkill(arg_34_0)
	table.insert(var_0_4, {
		tag = var_0_3.fightSkill,
		data = arg_34_0
	})
end

function var_0_5.LogHpChange(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	table.insert(var_0_4, {
		tag = var_0_3.hpChange,
		data = {
			knight = arg_35_0,
			beforeValue = arg_35_1,
			afterValue = arg_35_2,
			damage = arg_35_3
		}
	})
end

function var_0_5.LogStart()
	var_0_5.file:openFile()
end

function var_0_5.LogEnd(arg_37_0)
	var_0_5.file:closeFile(arg_37_0)
end

BLog = {}

setmetatable(BLog, {
	__index = var_0_5
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

	local var_39_0 = device.writablePath .. "battle_log/BLog/" .. g.core.common.ServerTime:getDate()

	if not cc.FileUtils:getInstance():isDirectoryExist(var_39_0) then
		cc.FileUtils:getInstance():createDirectory(var_39_0)
	end

	local var_39_1, var_39_2, var_39_3 = g.core.common.ServerTime:getCurrentHHMMSS()

	self._logFile = io.open(var_39_0 .. "/" .. (var_39_1 .. "_" .. var_39_2 .. "_" .. var_39_3) .. ".txt", "w")
end

function BattleLog:closeFile(arg_40_1)
	if self._logFile then
		self._logFile:write("\n\n战斗结束\n")

		if BattleConst.BL_SHOW_SHOW_RESULT then
			self:logTable(arg_40_1, "result")
		end

		self._logFile:close()
	end

	self._logFile = nil
end

function BattleLog:log(arg_41_1, arg_41_2)
	if not self._logFile then
		return
	end

	arg_41_2 = arg_41_2 or ""

	for iter_41_0, iter_41_1 in pairs(BattleConst.BL_SHOW_SHOW_TAG) do
		if not iter_41_1 and string.find(arg_41_2, string.format("[%s]", iter_41_0), 1, true) then
			return
		end
	end

	self._logFile:write("\n")
	self._logFile:write(arg_41_2:gsub("^%-+", function(arg_42_0)
		return arg_42_0:gsub("%-", " ")
	end) .. arg_41_1)
end

local function var_0_9(arg_43_0, arg_43_1, arg_43_2)
	if type(arg_43_2) ~= "number" then
		arg_43_2 = 10
	end

	local var_43_0 = {}
	local var_43_1 = {}

	local function var_43_2(arg_44_0, arg_44_1)
		if arg_44_1 and type(arg_44_0) == "string" then
			arg_44_0 = "\"" .. arg_44_0 .. "\""
		end

		if type(arg_44_0) == "number" and arg_44_0 > math.pow(10, 9) then
			arg_44_0 = string.format("%d", arg_44_0)
		end

		return tostring(arg_44_0)
	end

	local function var_43_3(arg_45_0, arg_45_1, arg_45_2, arg_45_3, arg_45_4, arg_45_5)
		arg_45_1 = type(arg_45_1) == "number" and string.format("[%s]", arg_45_1) or arg_45_1 or "local result"

		local var_45_0 = ""

		if type(arg_45_4) == "number" then
			var_45_0 = string.rep(" ", arg_45_4 - string.len(var_43_2(arg_45_1)))
		end

		if type(arg_45_0) ~= "table" then
			var_43_1[#var_43_1 + 1] = string.format("%s%s%s = %s,", arg_45_2, var_43_2(arg_45_1), var_45_0, var_43_2(arg_45_0, true))
		elseif var_43_0[tostring(arg_45_0)] then
			var_43_1[#var_43_1 + 1] = string.format("%s%s%s = \"*REF*,\"", arg_45_2, var_43_2(arg_45_1), var_45_0)
		else
			var_43_0[tostring(arg_45_0)] = true

			if arg_45_3 > arg_43_2 then
				var_43_1[#var_43_1 + 1] = string.format("%s%s = \"*MAX NESTING*,\"", arg_45_2, var_43_2(arg_45_1))
			else
				var_43_1[#var_43_1 + 1] = string.format("%s%s = {", arg_45_2, var_43_2(arg_45_1))

				local var_45_1 = arg_45_2 .. "    "
				local var_45_2 = {}
				local var_45_3 = 0
				local var_45_4 = {}

				for iter_45_0, iter_45_1 in pairs(arg_45_0) do
					var_45_2[#var_45_2 + 1] = iter_45_0

					local var_45_5 = string.len((var_43_2(iter_45_0)))

					if var_45_3 < var_45_5 then
						var_45_3 = var_45_5
					end

					var_45_4[iter_45_0] = iter_45_1
				end

				table.sort(var_45_2, function(arg_46_0, arg_46_1)
					if type(arg_46_0) == "number" and type(arg_46_1) == "number" then
						return arg_46_0 < arg_46_1
					else
						return tostring(arg_46_0) < tostring(arg_46_1)
					end
				end)

				for iter_45_2, iter_45_3 in ipairs(var_45_2) do
					var_43_3(var_45_4[iter_45_3], iter_45_3, var_45_1, arg_45_3 + 1, var_45_3, iter_45_2 == #var_45_2)
				end

				var_43_1[#var_43_1 + 1] = string.format("%s}%s", arg_45_2, arg_45_5 and "" or ",")
			end
		end
	end

	var_43_3(arg_43_0, arg_43_1, "", 1, nil, true)

	return var_43_1
end

function BattleLog:logTable(arg_47_1, arg_47_2)
	for iter_47_0, iter_47_1 in ipairs(var_0_9(arg_47_1, arg_47_2)) do
		self._logFile:write(iter_47_1)
		self._logFile:write("\n")
	end
end

var_0_5.file = BattleLog.new()
