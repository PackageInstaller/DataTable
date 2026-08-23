local BattleConst = require("app.view.battle.const.BattleConst")
local ConsolePanel = class("ConsolePanel", function()
	return cc.Node:create()
end)

function ConsolePanel:ctor()
	self._battleLayer = nil
	self._logYOffset = {}
	self._logs = {}
	self._labels = {}
	self._attackIndex = {
		1,
		1
	}

	self:setContentSize(300, 500)

	local var_2_0 = cc.DrawNode:create()

	self:addChild(var_2_0)
	var_2_0:drawSolidRect(cc.p(0, 0), cc.p(300, 500), cc.c4f(0, 0, 0, 0.8))

	local var_2_1 = ccui.ScrollView:create()

	self:addChild(var_2_1)
	var_2_1:setContentSize(300, 500)
	var_2_1:onEvent(handler(self, self._onscrollViewEvent))

	self._scrollView = var_2_1

	if require("battle.const.BattleConst").BATTLE_LOG_TYPE == 1 then
		local var_2_2 = device.writablePath .. "battle_log/log/" .. g.core.common.ServerTime:getDate()

		if not cc.FileUtils:getInstance():isDirectoryExist(var_2_2) then
			cc.FileUtils:getInstance():createDirectory(var_2_2)
		end

		local var_2_3, var_2_4, var_2_5 = g.core.common.ServerTime:getCurrentHHMMSS()

		self._logFile = io.open(var_2_2 .. "/" .. (var_2_3 .. "_" .. var_2_4 .. "_" .. var_2_5) .. ".txt", "w")
	end
end

function ConsolePanel:init(arg_3_1)
	self._battleLayer = arg_3_1
	self._battleField = arg_3_1._battleField
end

function ConsolePanel:addResult(arg_4_1, arg_4_2, arg_4_3)
	self:_addLog(string.format("当前出手次数：%s,回合：%s\n", self._battleField:getAttackCount(), self._battleField:getRoundCount()))
	self:_addLogs(arg_4_1, arg_4_3)
	self:_updateListItem()
	self._scrollView:scrollToBottom(0, false)

	if require("battle.const.BattleConst").BATTLE_LOG_TYPE == 1 and arg_4_2 == self._battleField.BATTLE_FINISH then
		self._logFile:write("战斗结果:")
		self._logFile:write("\n")
		self:logTable(self._battleField:getBattleResult())
		self._logFile:close()

		self._logFile = nil
	end
end

function ConsolePanel:addBuff267Data(arg_5_1, arg_5_2)
	if not next(arg_5_1) or not next(arg_5_2) then
		return
	end

	self:_addLog("buff267统计伤害:")

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		self:_addLog(string.format("%s(%d)攻击%s(%d)  %s %d", iter_5_1.attacker.isPlayer and "古物" or iter_5_1.attacker.knightCfg.name, iter_5_1.attacker.serialId, iter_5_1.victim.knightCfg.name, iter_5_1.victim.serialId, iter_5_1.value < 0 and "消耗" or "提供", math.abs(iter_5_1.value)))
	end

	local var_5_2 = "当前%s剩余总量 %d"

	for iter_5_2, iter_5_3 in pairs(arg_5_2) do
		self:_addLog(string.format(var_5_2, iter_5_2 == 1 and "我方" or "敌方", iter_5_3))
	end

	self:_addLog("\n")
end

local function var_0_2(arg_6_0, arg_6_1, arg_6_2)
	if type(arg_6_2) ~= "number" then
		arg_6_2 = 10
	end

	local var_6_0 = {}
	local var_6_1 = {}

	local function var_6_2(arg_7_0, arg_7_1)
		if arg_7_1 and type(arg_7_0) == "string" then
			arg_7_0 = "\"" .. arg_7_0 .. "\""
		end

		if type(arg_7_0) == "number" and arg_7_0 > math.pow(10, 9) then
			arg_7_0 = string.format("%d", arg_7_0)
		end

		return tostring(arg_7_0)
	end

	local function var_6_3(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
		arg_8_1 = type(arg_8_1) == "number" and string.format("[%s]", arg_8_1) or arg_8_1 or "local result"

		local var_8_0 = ""

		if type(arg_8_4) == "number" then
			var_8_0 = string.rep(" ", arg_8_4 - string.len(var_6_2(arg_8_1)))
		end

		if type(arg_8_0) ~= "table" then
			var_6_1[#var_6_1 + 1] = string.format("%s%s%s = %s,", arg_8_2, var_6_2(arg_8_1), var_8_0, var_6_2(arg_8_0, true))
		elseif var_6_0[tostring(arg_8_0)] then
			var_6_1[#var_6_1 + 1] = string.format("%s%s%s = \"*REF*,\"", arg_8_2, var_6_2(arg_8_1), var_8_0)
		else
			var_6_0[tostring(arg_8_0)] = true

			if arg_8_3 > arg_6_2 then
				var_6_1[#var_6_1 + 1] = string.format("%s%s = \"*MAX NESTING*,\"", arg_8_2, var_6_2(arg_8_1))
			else
				var_6_1[#var_6_1 + 1] = string.format("%s%s = {", arg_8_2, var_6_2(arg_8_1))

				local var_8_1 = arg_8_2 .. "    "
				local var_8_2 = {}
				local var_8_3 = 0
				local var_8_4 = {}

				for iter_8_0, iter_8_1 in pairs(arg_8_0) do
					var_8_2[#var_8_2 + 1] = iter_8_0

					local var_8_5 = string.len((var_6_2(iter_8_0)))

					if var_8_3 < var_8_5 then
						var_8_3 = var_8_5
					end

					var_8_4[iter_8_0] = iter_8_1
				end

				table.sort(var_8_2, function(arg_9_0, arg_9_1)
					if type(arg_9_0) == "number" and type(arg_9_1) == "number" then
						return arg_9_0 < arg_9_1
					else
						return tostring(arg_9_0) < tostring(arg_9_1)
					end
				end)

				for iter_8_2, iter_8_3 in ipairs(var_8_2) do
					var_6_3(var_8_4[iter_8_3], iter_8_3, var_8_1, arg_8_3 + 1, var_8_3, iter_8_2 == #var_8_2)
				end

				var_6_1[#var_6_1 + 1] = string.format("%s}%s", arg_8_2, arg_8_5 and "" or ",")
			end
		end
	end

	var_6_3(arg_6_0, arg_6_1, "", 1, nil, true)

	return var_6_1
end

function ConsolePanel:logTable(arg_10_1, arg_10_2)
	if not self._logFile then
		return
	end

	for iter_10_0, iter_10_1 in ipairs(var_0_2(arg_10_1, arg_10_2)) do
		self._logFile:write(iter_10_1)
		self._logFile:write("\n")
	end
end

function ConsolePanel:_onCellCreate(arg_11_1, arg_11_2)
	local var_11_0 = ccui.ListViewCell:create()

	var_11_0.index = arg_11_2

	local var_11_1 = cc.size(280, 22)

	var_11_0:setContentSize(var_11_1)

	local var_11_2 = ccui.Text:create("", BattleConst.FONT, 20)

	var_11_2:setTextAreaSize(var_11_1)
	var_11_2:setAnchorPoint(cc.p(0, 0.5))
	var_11_0:addChild(var_11_2)
	var_11_2:setPosition(0, var_11_1.height / 2)

	var_11_0.label = var_11_2

	return var_11_0
end

function ConsolePanel:_onCellUpdate(arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = self._logs[arg_12_2 + 1] or ""

	if var_12_0 then
		arg_12_3.label:setString(var_12_0)
	else
		arg_12_3.label:setString("")
	end

	print("index:" .. arg_12_2 .. "," .. var_12_0)
end

function ConsolePanel:_getKnightName(arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = ""
	local var_13_1 = arg_13_1 <= 10 and 1 or 2

	if arg_13_1 % 10 ~= 7 then
		local var_13_2 = self._battleField:getBattleData():getKnightData(arg_13_1)

		if var_13_2 then
			var_13_0 = ((var_13_2.isMonster and self._battleField:getBattlePlayId() ~= BattleConst.ServerPlayId.EXPLORATION_BOSS or nil) and (g.core.config.monster_info or g.core.config.knight_info)).get(var_13_2.baseData.id).name
		end
	elseif var_13_1 == 1 then
		return "我方"
	else
		return "敌方"
	end

	return var_13_0 .. "(" .. arg_13_1 .. ")"
end

function ConsolePanel:_addLog(arg_14_1, arg_14_2)
	arg_14_1 = string.gsub(arg_14_1, "%[.-%]", " ")

	if not arg_14_2 then
		local var_14_0 = ccui.Text:create(arg_14_1, BattleConst.FONT, 20)

		var_14_0:getVirtualRenderer():setMaxLineWidth(280)
		var_14_0:setAnchorPoint(cc.p(0, 0))
		self._scrollView:addChild(var_14_0)
		table.insert(self._labels, var_14_0)
		table.insert(self._logs, arg_14_1)

		local var_14_1 = self._scrollView:getInnerContainerPosition()
		local var_14_2 = self._scrollView:getContentSize()
		local var_14_3 = {}
		local var_14_4 = 0

		for iter_14_0, iter_14_1 in ipairs(self._labels) do
			var_14_4 = var_14_4 + iter_14_1:getContentSize().height
			var_14_3[iter_14_0] = var_14_4
		end

		local var_14_5 = math.max(500, var_14_4)

		for iter_14_2, iter_14_3 in ipairs(self._labels) do
			iter_14_3:setPosition(10, var_14_5 - var_14_3[iter_14_2])
		end

		self._scrollView:setInnerContainerSize(cc.size(300, var_14_5))
	end

	if require("battle.const.BattleConst").BATTLE_LOG_TYPE == 1 and self._logFile then
		self._logFile:write(arg_14_1)
		self._logFile:write("\n")
	end
end

function ConsolePanel:_addLogs(arg_15_1, arg_15_2)
	local var_15_0 = ""

	if arg_15_1.round_start and arg_15_1.round_start.buffs then
		for iter_15_0, iter_15_1 in ipairs(arg_15_1.round_start.buffs) do
			var_15_0 = var_15_0 .. self:_formatBuff(iter_15_1) .. "\n"
		end
	end

	local var_15_1 = var_15_0 .. self:_formatAttackInfo(arg_15_1) .. "\n"

	for iter_15_2, iter_15_3 in ipairs(arg_15_1.passive_infos or {}) do
		var_15_1 = var_15_1 .. self:_formatAttackInfo(iter_15_3) .. "\n"
	end

	self:_addLog(var_15_1, arg_15_2)
end

function ConsolePanel:_formatEffect(arg_16_1)
	local var_16_0 = ""

	local function var_16_1(arg_17_0)
		var_16_0 = var_16_0 .. arg_17_0
	end

	local var_16_2 = arg_16_1.effect_value

	if arg_16_1.effect_type == 1 or arg_16_1.effect_type == 2 then
		if arg_16_1.effect_type == 1 then
			var_16_1("扣血")
		else
			var_16_1("加血")
		end

		var_16_1(var_16_2 .. "点 ")
	elseif arg_16_1.effect_type == 3 or arg_16_1.effect_type == 4 then
		if arg_16_1.effect_type == 3 and arg_16_1.add_value == 1 then
			var_16_1("清空怒气")
		else
			if arg_16_1.effect_type == 3 then
				var_16_1("减怒气")
			else
				var_16_1("加怒气")
			end

			var_16_1(var_16_2 .. "点")
		end
	elseif arg_16_1.effect_type == 5 or arg_16_1.effect_type == 6 then
		if arg_16_1.effect_type == 3 then
			var_16_1("减合计值")
		else
			var_16_1("加合计值")
		end

		var_16_1(var_16_2 .. "点")
	elseif arg_16_1.effect_type == 7 or arg_16_1.effect_type == 8 then
		if arg_16_1.effect_type == 7 then
			var_16_1("清除减益")
		else
			var_16_1("清除增益")
		end

		for iter_16_0, iter_16_1 in ipairs(arg_16_1.debugLogData or {}) do
			var_16_1("，buffId:" .. iter_16_1.buffId)
		end
	elseif arg_16_1.effect_type == 9 then
		-- block empty
	elseif arg_16_1.effect_type == 10 then
		var_16_1("破冰")
	elseif arg_16_1.effect_type == 11 then
		var_16_1("灼烧回合数+" .. var_16_2)
	elseif arg_16_1.effect_type == 12 or arg_16_1.effect_type == 13 then
		if arg_16_1.effect_type == 12 then
			var_16_1("减杀意值")
		else
			var_16_1("加杀意值")
		end

		var_16_1(var_16_2 .. "点")
	elseif arg_16_1.effect_type == 205 then
		var_16_1("减临界值" .. var_16_2 .. "点")
	elseif arg_16_1.effect_type == 206 then
		var_16_1("加临界值" .. var_16_2 .. "点")
	elseif arg_16_1.effect_type == 14 then
		var_16_1("召唤，id" .. var_16_2)
	elseif arg_16_1.effect_type == 15 then
		var_16_1("加护盾" .. var_16_2 .. "点")
	elseif arg_16_1.effect_type == 16 or arg_16_1.effect_type == 17 then
		if arg_16_1.effect_type == 16 then
			var_16_1("加标记 id ")
		else
			var_16_1("减标记 type ")
		end

		var_16_1(var_16_2 .. "层数" .. arg_16_1.add_value)
	elseif arg_16_1.effect_type == 18 then
		var_16_1("复活，生命千分比" .. var_16_2)
	elseif arg_16_1.effect_type == 19 then
		var_16_1("清除护盾")
	elseif arg_16_1.effect_type == 20 then
		var_16_1("获得额外回合")
	elseif arg_16_1.effect_type == 21 then
		var_16_1("灼烧引爆")
	elseif arg_16_1.effect_type == 22 then
		var_16_1("灼烧传染")
	elseif arg_16_1.effect_type == 23 then
		var_16_1("添加地形id" .. var_16_2 .. "回合" .. (arg_16_1.add_value or 0))
	elseif arg_16_1.effect_type == 24 or arg_16_1.effect_type == 25 then
		-- block empty
	elseif arg_16_1.effect_type == 26 then
		var_16_1("重开战斗")
	elseif arg_16_1.effect_type == 27 then
		var_16_1("清除控制效果")
	elseif arg_16_1.effect_type == 28 then
		var_16_1("修改灼烧回合" .. var_16_2)
	elseif arg_16_1.effect_type == 29 then
		var_16_1("转移增益数量" .. var_16_2 .. "回合" .. arg_16_1.add_value)
	elseif arg_16_1.effect_type == 30 then
		var_16_1("灼伤引燃")
	elseif arg_16_1.effect_type == 31 then
		var_16_1("延长减益回合数" .. var_16_2 .. "个" .. arg_16_1.add_value .. "回合")
	elseif arg_16_1.effect_type == 32 then
		var_16_1("复制攻击方随机增益" .. var_16_2 .. "个，额外加" .. arg_16_1.add_value .. "回合")
	elseif arg_16_1.effect_type == 33 then
		var_16_1("转移" .. "所有最高" .. arg_16_1.add_value .. "级" .. "减益，额外加" .. var_16_2 .. "回合")
	elseif arg_16_1.effect_type == 34 then
		var_16_1("清除中毒效果")
	elseif arg_16_1.effect_type == 46 then
		var_16_1("角色加幽灵态")
	elseif arg_16_1.effect_type == 47 then
		var_16_1("删除角色加幽灵态")
	elseif arg_16_1.effect_type == 80 then
		var_16_1("增加临时护盾 " .. var_16_2 .. "点")
	elseif arg_16_1.effect_type == 81 then
		var_16_1("扣除临时护盾 " .. var_16_2 .. "点")
	elseif arg_16_1.effect_type == 82 then
		var_16_1("当前临时护盾 " .. arg_16_1.add_value .. "点")
	elseif arg_16_1.effect_type == 99 then
		var_16_1("结算 " .. var_16_2 .. " 个buff_id" .. arg_16_1.add_value .. " 的buff " .. arg_16_1.add_value2 .. " 次")
	elseif arg_16_1.effect_type == 100 then
		var_16_1("清除护盾 " .. (arg_16_1.add_value or "-错误-") .. "点")
	elseif arg_16_1.effect_type == 105 then
		for iter_16_2, iter_16_3 in pairs(arg_16_1.debugLogData or {}) do
			var_16_1("buff: " .. iter_16_3.id .. iter_16_3.name .. " 回合数" .. iter_16_3.curTimes .. "变化" .. iter_16_3.changeValue .. "变成" .. math.max(0, iter_16_3.curTimes + iter_16_3.changeValue))
		end
	elseif arg_16_1.effect_type == 108 then
		for iter_16_4, iter_16_5 in pairs(arg_16_1.debugLogData or {}) do
			var_16_1("buff清除: " .. iter_16_5.id .. iter_16_5.name .. ",回复调率值" .. iter_16_5.value2)
		end
	elseif arg_16_1.effect_type == 109 then
		local var_16_7 = arg_16_1.debugLogData.comboSkill

		if arg_16_1.debugLogData.comboSkill then
			var_16_1((arg_16_1.debugLogData.identity == 1 and "我方" or "敌方") .. "古物" .. tostring(var_16_7:getAdvId()) .. "CD减少，当前剩余CD: " .. tostring(var_16_7:getCD()))
		end
	elseif arg_16_1.effect_type == 117 then
		if arg_16_1.debugLogData then
			var_16_1("回溯: 血量:" .. arg_16_1.debugLogData.recordHp .. ",护盾:" .. arg_16_1.debugLogData.recordShield)
		end
	elseif arg_16_1.effect_type == 124 then
		for iter_16_6, iter_16_7 in ipairs(arg_16_1.debugLogData or {}) do
			var_16_1("buff: " .. iter_16_7.id .. " 延长回合数到" .. iter_16_7.curTime)
		end
	elseif arg_16_1.effect_type == 125 then
		for iter_16_8, iter_16_9 in ipairs((arg_16_1.debugLogData or {}).removeList or {}) do
			var_16_1("效果125移除buffId: " .. iter_16_9.id)
		end
	elseif arg_16_1.effect_type == 126 then
		for iter_16_10, iter_16_11 in ipairs((arg_16_1.debugLogData or {}).recordList or {}) do
			var_16_1("效果126记录buffId: " .. iter_16_11.id)
		end
	elseif arg_16_1.effect_type == 152 then
		var_16_1("效果152引爆伤害: " .. (arg_16_1.debugLogData or {}).totalDamage)
	elseif arg_16_1.effect_type == 201 then
		var_16_1("扣除魔女能量 " .. var_16_2 .. "点")
	elseif arg_16_1.effect_type == 202 then
		var_16_1("增加魔女能量 " .. var_16_2 .. "点")
	elseif arg_16_1.effect_type == 203 then
		var_16_1("扣除最大生命值 " .. var_16_2 .. "点")
	elseif arg_16_1.effect_type == 204 then
		var_16_1("增加最大生命值 " .. var_16_2 .. "点")
	elseif arg_16_1.effect_type == 207 then
		var_16_1("扣除队长能量值 " .. var_16_2 .. "点")
	elseif arg_16_1.effect_type == 208 then
		var_16_1("增加队长能量值 " .. var_16_2 .. "点")
	end

	if var_16_0 == "" then
		return ""
	end

	local var_16_12 = arg_16_1.add_effects or {}
	local var_16_13 = #var_16_12

	if #var_16_12 > 0 then
		var_16_0 = var_16_0 .. "("
	end

	for iter_16_12, iter_16_13 in ipairs(var_16_12) do
		var_16_0 = var_16_0 .. self:_formatAddEffect(iter_16_13)

		if iter_16_12 < var_16_13 then
			var_16_0 = var_16_0 .. "|"
		end
	end

	if var_16_13 > 0 then
		var_16_0 = var_16_0 .. ")"
	end

	return var_16_0
end

function ConsolePanel:_formatBuff(arg_18_1)
	local var_18_1 = g.core.config.buff_info.get(arg_18_1.buff_id)
	local var_18_2 = self:_getKnightName(arg_18_1.knight_serial_id)

	if not arg_18_1.buff_effect then
		-- block empty
	end

	local var_18_5 = ""

	if arg_18_1.buff_action == 1 then
		var_18_5 = "添加"
	elseif arg_18_1.buff_action == 2 then
		var_18_5 = "移除"
	elseif arg_18_1.buff_action == 3 then
		var_18_5 = "生效"
	end

	local var_18_6 = g.core.lang:getByString("#victim##action#buff#buffName# id:#id#", {
		victim = var_18_2,
		action = var_18_5,
		buffName = g.core.utils.String.formatBuffDesc(var_18_1.id),
		id = var_18_1.id
	})

	if arg_18_1.buff_effect then
		var_18_6 = var_18_6 .. "," .. self:_formatEffect(arg_18_1.buff_effect)
	end

	return var_18_6
end

function ConsolePanel:_formatAddEffect(arg_19_1)
	local var_19_0 = {
		"暴击",
		"闪避",
		"格挡",
		"吸血",
		"反弹",
		"清除buff成功",
		"无敌",
		"吸怒",
		"秒杀",
		"生命链接",
		"斩杀",
		"引爆灼烧",
		nil,
		"隐匿",
		"免疫",
		"龙魂",
		"灼烧暴击",
		nil,
		nil,
		"无视护盾"
	}

	var_19_0[13] = "吸收" .. (arg_19_1.add_value or 0) .. "点"

	return var_19_0[arg_19_1.add_type] or ""
end

function ConsolePanel:_formatSkillName(arg_20_1)
	local var_20_0 = {
		"普攻",
		"怒气",
		"合击",
		"专武技能",
		"专武技能",
		"神兽技能",
		"时光之力",
		"时光之力",
		"饰品技能",
		"饰品技能",
		"武将技能",
		"必杀技",
		"召唤物技能",
		"神兽附加技能",
		"装备技能",
		"装备技能",
		"被动技能",
		"战法技能",
		"战法技能",
		"地形技能",
		"战阵",
		"锦囊技能"
	}
	local var_20_1 = arg_20_1.curtain_name

	if var_20_0[arg_20_1.skill_type] then
		var_20_1 = var_20_1 .. "(" .. var_20_0[arg_20_1.skill_type] .. "id:" .. arg_20_1.id .. ")"
	end

	return var_20_1
end

function ConsolePanel:_formatAttackInfo(arg_21_1)
	local var_21_0 = ""

	local function var_21_1(arg_22_0)
		if arg_22_0 and arg_22_0 ~= "" then
			var_21_0 = var_21_0 .. arg_22_0 .. "\n"
		end
	end

	var_21_1("---攻击前")

	if arg_21_1.attack_before then
		for iter_21_0, iter_21_1 in ipairs(arg_21_1.attack_before.buff or {}) do
			var_21_1((self:_formatBuff(iter_21_1)))
		end

		for iter_21_2, iter_21_3 in ipairs(arg_21_1.attack_before.removeList or {}) do
			var_21_1(self:_getKnightName(iter_21_3.knight_serial_id) .. "移除buff:" .. g.core.config.buff_info.get(iter_21_3.buff_id).name .. " id:" .. iter_21_3.buff_id)
		end

		for iter_21_4, iter_21_5 in ipairs(arg_21_1.attack_before.effect or {}) do
			var_21_1((iter_21_5.victim_serial_id and self:_getKnightName(iter_21_5.victim_serial_id) or self:_getKnightName(arg_21_1.attack_serial_id)) .. self:_formatEffect(iter_21_5))
		end
	end

	var_21_1("---攻击中")

	if not arg_21_1.attack_id or arg_21_1.attack_type == 3 then
		-- block empty
	else
		var_21_1(self:_getKnightName(arg_21_1.attack_serial_id) .. "释放skillId:" .. arg_21_1.attack_id .. " " .. self:_formatSkillName((g.core.config.skill_info.get(arg_21_1.attack_id))))
	end

	for iter_21_6, iter_21_7 in ipairs(arg_21_1.attack_infos or {}) do
		local var_21_4 = self:_getKnightName(iter_21_7.victim_serial_id)
		local var_21_5 = self:_formatEffect(iter_21_7.effect)

		if var_21_5 ~= "" then
			var_21_1(var_21_4 .. " " .. var_21_5)
		end

		if iter_21_7.is_dead and iter_21_7.effect and iter_21_7.effect.effect_type == 1 then
			var_21_1(var_21_4 .. " 死亡")
		end
	end

	var_21_1("---攻击后")

	local var_21_6 = arg_21_1.attack_after or {}

	for iter_21_8, iter_21_9 in ipairs(var_21_6.effect or {}) do
		local var_21_8 = self:_getKnightName(iter_21_9.victim_serial_id or arg_21_1.attack_serial_id)
		local var_21_9 = self:_formatEffect(iter_21_9)

		if var_21_9 ~= "" then
			var_21_1(var_21_8 .. " " .. var_21_9)
		end

		if iter_21_9.is_dead and iter_21_9.effect_type == 1 then
			var_21_1(var_21_8 .. " 死亡")
		end
	end

	for iter_21_10, iter_21_11 in ipairs(var_21_6.buff or {}) do
		var_21_1((self:_formatBuff(iter_21_11)))
	end

	return ""
end

function ConsolePanel:_onscrollViewEvent(arg_23_1)
	if arg_23_1.name == "CONTAINER_MOVED" then
		-- block empty
	end
end

function ConsolePanel:_updateListItem()
	return
end

function ConsolePanel:_findBeginIdx()
	local var_25_0 = self._scrollView:getInnerContainerPosition()
	local var_25_1 = self._scrollView:getContentSize().height

	for iter_25_0, iter_25_1 in ipairs(self._logYOffset) do
		-- block empty
	end
end

return ConsolePanel
