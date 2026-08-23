local MuiltFightAutoPop = class("MuiltFightAutoPop", function()
	return fgui.GComponent:create({
		pkgName = "debug",
		pkgPath = "ui/debug/debug",
		resName = "MuiltFightAutoPop"
	})
end, require("app.fairyGUI.debug.UI_MuiltFightAutoPop"))
local TestFightData = require("app.view.module.debug.model.TestFightData")
local var_0_4 = require("app.view.module.debug.model.TestFightUtils").MARK_TYPE

function MuiltFightAutoPop:ctor(arg_2_1)
	self:getView():center(true)

	arg_2_1 = arg_2_1 or {}

	local var_2_0 = arg_2_1.teams or {}

	self._battleCount = math.max(arg_2_1.battleCount or 1, 1)
	self._users = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		table.insert(self._users, iter_2_1.user)
	end

	self._baseRecord = {}
	self._iterRecords = {}

	for iter_2_2, iter_2_3 in ipairs(self._users) do
		local var_2_1, var_2_2 = self:_getFormations(iter_2_3.id)

		self._baseRecord[iter_2_2] = var_2_1
		self._iterRecords[iter_2_2] = var_2_2
	end

	self:_initView()

	self._roundCountRandomSeedDict = {
		{},
		{}
	}

	self.m_fightBtn:addClickListener(handler(self, self._onClickFight))
	self.m_roundReportBtn:addClickListener(handler(self, self._onClickRoundReport))
	self.m_cancelBtn:addClickListener(handler(self, self._onClickCancel))
end

function MuiltFightAutoPop:_onClickRoundReport()
	local var_3_0 = 0

	for iter_3_0, iter_3_1 in pairs(self._roundCountRandomSeedDict[1]) do
		var_3_0 = math.max(var_3_0, iter_3_0)
	end

	if var_3_0 > 0 then
		local var_3_1 = io.open("myBattleMaxRound.txt", "w")

		var_3_1:write(json.encode(self._roundCountRandomSeedDict[1][var_3_0]))
		var_3_1:close()
	end

	local var_3_2 = 0

	for iter_3_2, iter_3_3 in pairs(self._roundCountRandomSeedDict[2]) do
		var_3_2 = math.max(var_3_2, iter_3_2)
	end

	if var_3_2 > 0 then
		local var_3_3 = io.open("enemyBattleMaxRound.txt", "w")

		var_3_3:write(json.encode(self._roundCountRandomSeedDict[2][var_3_2]))
		var_3_3:close()
	end

	g.core.module.ModuleManager:tip(string.format("打印成功,我方先手最大回合数%d 敌方先手最大回合数%d", var_3_0, var_3_2))
end

function MuiltFightAutoPop:_initView()
	for iter_4_0, iter_4_1 in ipairs(self._users) do
		self["m_playerText" .. iter_4_0]:setText(iter_4_1.name)

		local var_4_0 = {}

		if self._baseRecord[iter_4_0] then
			table.insert(var_4_0, self._baseRecord[iter_4_0])
		end

		table.insertto(var_4_0, self._iterRecords[iter_4_0] or {})
		self["m_recordList" .. iter_4_0]:setVirtual(self)
		self["m_recordList" .. iter_4_0]:setItemRenderer(function(arg_5_0, arg_5_1)
			local var_5_0 = var_4_0[arg_5_0 + 1]

			if var_4_0[arg_5_0 + 1] then
				local var_5_1 = arg_5_1:getChild("markText")

				if var_5_0:getMarkType() == var_0_4.BASE then
					var_5_1:setText("基础阵容")
					var_5_1:setColor(cc.c3b(210, 75, 68))
				elseif var_5_0:getMarkType() == var_0_4.ITER then
					var_5_1:setText("迭代阵容" .. var_5_0:getOrder())
					var_5_1:setColor(cc.c3b(113, 155, 46))
				end

				arg_5_1:getChild("nameText"):setText(var_5_0:getName())
			end
		end)
		self["m_recordList" .. iter_4_0]:setNumItems(#var_4_0)
	end
end

function MuiltFightAutoPop:_getFormations(arg_6_1)
	local var_6_0 = TestFightData.new(arg_6_1)

	var_6_0:loadData()

	local var_6_1
	local var_6_2 = {}

	for iter_6_0, iter_6_1 in ipairs((var_6_0:getRecords())) do
		local var_6_3 = iter_6_1:getMarkType()

		if var_6_3 == var_0_4.BASE then
			var_6_1 = iter_6_1
		elseif var_6_3 == var_0_4.ITER then
			table.insert(var_6_2, iter_6_1)
		end
	end

	table.sort(var_6_2, function(arg_7_0, arg_7_1)
		return arg_7_0:getOrder() < arg_7_1:getOrder()
	end)

	return var_6_1, var_6_2
end

function MuiltFightAutoPop:fight(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	if self.m_batchFight:isSelected() then
		return self:batchFight(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	end

	local var_8_1 = {}

	var_8_1.battle_id = 0
	var_8_1.atk_type = 2
	var_8_1.is_auto = true
	var_8_1.random_seeds = {}
	var_8_1.own_teams = {
		arg_8_1:getBattleTeam()
	}
	var_8_1.enemy_teams = {
		arg_8_2:getBattleTeam()
	}

	local var_8_2 = 0
	local var_8_3 = 0
	local var_8_4 = 0
	local var_8_5 = 0
	local var_8_6 = 0
	local var_8_7 = 0
	local var_8_8 = 0
	local var_8_9 = 0
	local var_8_10 = 0
	local var_8_11 = 0
	local var_8_12 = {}
	local var_8_13 = {}

	for iter_8_0 = 1, self._battleCount do
		for iter_8_1 = 1, 50 do
			var_8_1.random_seeds[iter_8_1] = math.random(1000) - 1
		end

		local var_8_14, var_8_15 = g.core.battle.BattleProxy:fastFight(var_8_1, 1)

		table.insert(var_8_12, var_8_15:getRecord()[1])
		table.insert(var_8_13, var_8_15:getRecord()[2])

		local var_8_16, var_8_17 = g.core.battle.BattleProxy:fastFight(var_8_1, 2)

		table.insert(var_8_12, var_8_17:getRecord()[1])
		table.insert(var_8_13, var_8_17:getRecord()[2])

		var_8_2 = var_8_2 + (var_8_14.is_win and 1 or 0)
		var_8_7 = var_8_7 + (var_8_16.is_win and 1 or 0)
		var_8_3 = var_8_3 + var_8_14.round
		var_8_8 = var_8_8 + var_8_16.round
		self._roundCountRandomSeedDict[1][var_8_14.round] = self._roundCountRandomSeedDict[1][var_8_14.round] or clone(var_8_1)
		self._roundCountRandomSeedDict[2][var_8_16.round] = self._roundCountRandomSeedDict[2][var_8_16.round] or clone(var_8_1)

		if var_8_14.command then
			for iter_8_2, iter_8_3 in ipairs(var_8_14.command) do
				if iter_8_3.identity == 1 then
					var_8_4 = var_8_4 + 1
				else
					var_8_5 = var_8_5 + 1
				end
			end
		end

		if var_8_16.command then
			for iter_8_4, iter_8_5 in ipairs(var_8_16.command) do
				if iter_8_5.identity == 1 then
					var_8_9 = var_8_9 + 1
				else
					var_8_10 = var_8_10 + 1
				end
			end
		end

		var_8_6 = var_8_6 + 1
		var_8_11 = var_8_11 + 1
		self._cur = self._cur + 1

		print("当前进度: " .. self._cur .. "/" .. self._max)
	end

	return {
		winCount1 = var_8_2,
		winCount2 = var_8_7,
		roundCount1 = var_8_3,
		roundCount2 = var_8_8,
		uniteCount11 = var_8_4,
		uniteCount12 = var_8_5,
		uniteCount21 = var_8_9,
		uniteCount22 = var_8_10,
		fightCount1 = var_8_6,
		fightCount2 = var_8_11
	}, var_8_12, var_8_13
end

function MuiltFightAutoPop:batchFight(arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	local var_9_1 = {}

	var_9_1.battle_id = 0
	var_9_1.atk_type = 2
	var_9_1.is_auto = true
	var_9_1.random_seeds = {}
	var_9_1.own_teams = {
		arg_9_1:getBattleTeam()
	}
	var_9_1.enemy_teams = {
		arg_9_2:getBattleTeam()
	}

	local var_9_2, var_9_3, var_9_4

	if not self._batchBattleClient then
		self._batchBattleClient = require("BatchBattle.BatchBattleClient").new(self.m_batchServerIp:getText(), (tonumber(self.m_batchServerPort:getText())))
		var_9_2 = {
			winCount1 = 0,
			fightCount2 = 0,
			uniteCount22 = 0,
			uniteCount21 = 0,
			roundCount2 = 0,
			winCount2 = 0,
			fightCount1 = 0,
			uniteCount12 = 0,
			uniteCount11 = 0,
			roundCount1 = 0
		}
		var_9_3 = {}
		var_9_4 = {}
	end

	for iter_9_0, iter_9_1 in ipairs((self._batchBattleClient:run(var_9_1, self._battleCount, arg_9_5))) do
		var_9_2.winCount1 = var_9_2.winCount1 + iter_9_1.winCount1
		var_9_2.winCount2 = var_9_2.winCount2 + iter_9_1.winCount2
		var_9_2.roundCount1 = var_9_2.roundCount1 + iter_9_1.roundCount1
		var_9_2.roundCount2 = var_9_2.roundCount2 + iter_9_1.roundCount2
		var_9_2.uniteCount11 = var_9_2.uniteCount11 + iter_9_1.uniteCount11
		var_9_2.uniteCount12 = var_9_2.uniteCount12 + iter_9_1.uniteCount12
		var_9_2.uniteCount21 = var_9_2.uniteCount21 + iter_9_1.uniteCount21
		var_9_2.uniteCount22 = var_9_2.uniteCount22 + iter_9_1.uniteCount22
		var_9_2.fightCount1 = var_9_2.fightCount1 + iter_9_1.fightCount1
		var_9_2.fightCount2 = var_9_2.fightCount2 + iter_9_1.fightCount2

		table.insertto(var_9_3, iter_9_1.records1)
		table.insertto(var_9_4, iter_9_1.records2)

		if iter_9_1.finalReport then
			local var_9_5 = io.open("battle_report.txt", "w")

			var_9_5:write(json.encode(iter_9_1.finalReport))
			var_9_5:close()
		end
	end

	return var_9_2, var_9_3, var_9_4
end

function MuiltFightAutoPop:_onClickFight()
	local var_10_0 = os.clock()

	self._roundCountRandomSeedDict = {
		{},
		{}
	}

	local function var_10_1(arg_11_0)
		local var_11_0 = {}

		for iter_11_0, iter_11_1 in ipairs(arg_11_0) do
			for iter_11_2, iter_11_3 in ipairs(iter_11_1) do
				if not var_11_0[iter_11_3.type .. "_" .. iter_11_3.id] then
					var_11_0[iter_11_3.type .. "_" .. iter_11_3.id] = iter_11_3
				else
					local var_11_1 = var_11_0[iter_11_3.type .. "_" .. iter_11_3.id]

					var_11_1.dam = var_11_0[iter_11_3.type .. "_" .. iter_11_3.id].dam + iter_11_3.dam
					var_11_1.recover = var_11_1.recover + iter_11_3.recover
					var_11_1.take_dam = var_11_1.take_dam + iter_11_3.take_dam
					var_11_1.normal_skill_num = var_11_1.normal_skill_num or 0
					var_11_1.skill_num = var_11_1.skill_num or 0
					var_11_1.skill_dam = var_11_1.skill_dam or 0
					iter_11_3.normal_skill_num = iter_11_3.normal_skill_num or 0
					iter_11_3.skill_num = iter_11_3.skill_num or 0
					iter_11_3.skill_dam = iter_11_3.skill_dam or 0
					var_11_1.normal_skill_num = var_11_1.normal_skill_num + iter_11_3.normal_skill_num
					var_11_1.skill_num = var_11_1.skill_num + iter_11_3.skill_num
					var_11_1.skill_dam = var_11_1.skill_dam + iter_11_3.skill_dam
				end
			end
		end

		local var_11_2 = #arg_11_0
		local var_11_3 = {}

		for iter_11_4, iter_11_5 in pairs(var_11_0) do
			local var_11_4 = ""

			if iter_11_5.type == 2 then
				var_11_4 = g.core.config.unite_token_info.get(iter_11_5.id).name
			elseif iter_11_5.type == 3 then
				var_11_4 = g.core.config.pet_info.get(iter_11_5.id).name
			elseif iter_11_5.type == 4 then
				var_11_4 = g.core.config.artifact_info.get(iter_11_5.id).name
			elseif iter_11_5.type == 6 then
				var_11_4 = g.core.config.succuba_info.get(iter_11_5.id).name
			elseif iter_11_5.type == 7 then
				var_11_4 = "元素" .. g.core.config.skill_info.get(iter_11_5.id).curtain_name
			elseif iter_11_5.avartar_id then
				var_11_4 = g.core.config.knight_info.get(iter_11_5.id).name
			else
				local var_11_6 = g.core.config.monster_info.fetch(iter_11_5.id)

				var_11_6 = var_11_6 or g.core.config.knight_info.get((var_11_6 or nil) and (var_11_6.advance_id or iter_11_5.id))
				var_11_4 = var_11_6.name
			end

			iter_11_5.name = var_11_4
			iter_11_5.dam = iter_11_5.dam / var_11_2
			iter_11_5.recover = iter_11_5.recover / var_11_2
			iter_11_5.take_dam = iter_11_5.take_dam / var_11_2
			iter_11_5.normal_skill_num = (iter_11_5.normal_skill_num or 0) / var_11_2
			iter_11_5.skill_num = (iter_11_5.skill_num or 0) / var_11_2
			iter_11_5.skill_dam = (iter_11_5.skill_dam or 0) / var_11_2

			table.insert(var_11_3, iter_11_5)
		end

		return var_11_3
	end

	local var_10_2 = ""
	local var_10_3 = self.m_baseTestBtn:isSelected()

	self._max = 0
	self._cur = 0

	for iter_10_0, iter_10_1 in ipairs(self._users) do
		for iter_10_2 = iter_10_0 + 1, #self._users do
			if ((var_10_3 or nil) and (self._baseRecord or self._iterRecords))[iter_10_2] then
				self._max = self._max + self._battleCount
			end
		end
	end

	if var_10_3 then
		local var_10_4 = true
		local var_10_5 = {}
		local var_10_6 = 0

		for iter_10_3, iter_10_4 in ipairs(self._users) do
			if self._baseRecord[iter_10_3] then
				local var_10_7 = true

				for iter_10_5 = iter_10_3 + 1, #self._users do
					if self._baseRecord[iter_10_5] then
						if var_10_4 then
							var_10_2 = var_10_2 .. "基准测试\r\n"
							var_10_2 = var_10_2 .. "\t\t\t先手\t后手\t胜率平均值\t先手平均回合数\t后手平均回合数\r\n"
							var_10_4 = false
						end

						var_10_6 = var_10_6 + 1

						local var_10_8, var_10_9, var_10_10 = self:fight(self._baseRecord[iter_10_3], self._baseRecord[iter_10_5], iter_10_4, self._users[iter_10_5])

						var_10_2 = var_10_7 and var_10_2 .. string.format("%s\tVS\t%s\t%.2f%%\t%.2f%%\t%.2f%%\t%.2f\t%.2f\r\n", iter_10_4.name, self._users[iter_10_5].name, var_10_8.winCount1 / var_10_8.fightCount1 * 100, var_10_8.winCount2 / var_10_8.fightCount2 * 100, (var_10_8.winCount1 / var_10_8.fightCount1 * 100 + var_10_8.winCount2 / var_10_8.fightCount2 * 100) / 2, var_10_8.roundCount1 / var_10_8.fightCount1, var_10_8.roundCount2 / var_10_8.fightCount2) or var_10_2 .. string.format("\t\t%s\t%.2f%%\t%.2f%%\t%.2f%%\t%.2f\t%.2f\r\n", self._users[iter_10_5].name, var_10_8.winCount1 / var_10_8.fightCount1 * 100, var_10_8.winCount2 / var_10_8.fightCount2 * 100, (var_10_8.winCount1 / var_10_8.fightCount1 * 100 + var_10_8.winCount2 / var_10_8.fightCount2 * 100) / 2, var_10_8.roundCount1 / var_10_8.fightCount1, var_10_8.roundCount2 / var_10_8.fightCount2)
						var_10_5[iter_10_3] = var_10_5[iter_10_3] or {}

						table.insertto(var_10_5[iter_10_3], var_10_9)

						var_10_5[iter_10_5] = var_10_5[iter_10_5] or {}

						table.insertto(var_10_5[iter_10_5], var_10_10)

						var_10_7 = var_10_7 and false
					end
				end

				if not var_10_7 then
					var_10_2 = var_10_2 .. "\r\n"
				end
			end
		end

		if var_10_4 then
			var_10_2 = var_10_2 .. "\r\n"
		end

		for iter_10_6, iter_10_7 in ipairs(self._users) do
			if var_10_5[iter_10_6] then
				var_10_2 = var_10_2 .. iter_10_7.name .. "阵容统计\r\n"
				var_10_2 = var_10_2 .. "名称\t伤害\t技能伤害\t承伤\t治疗\t普攻\t技能\r\n"

				for iter_10_8, iter_10_9 in ipairs((var_10_1(var_10_5[iter_10_6]))) do
					var_10_2 = var_10_2 .. string.format("%s\t%d\t%d\t%d\t%d\t%.2f\t%.2f\r\n", iter_10_9.name, iter_10_9.dam, iter_10_9.skill_dam, iter_10_9.take_dam, iter_10_9.recover, iter_10_9.normal_skill_num, iter_10_9.skill_num)
				end

				var_10_2 = var_10_2 .. "\r\n"
			end
		end

		if next(var_10_5) then
			var_10_2 = var_10_2 .. "\r\n"
		end
	end

	local var_10_11 = 1

	while true do
		local var_10_12 = false
		local var_10_13 = {}
		local var_10_14 = 0

		for iter_10_10, iter_10_11 in ipairs(self._users) do
			var_10_13[iter_10_10] = {}

			for iter_10_12, iter_10_13 in ipairs(self._iterRecords[iter_10_10]) do
				if iter_10_13:getOrder() == var_10_11 then
					for iter_10_14, iter_10_15 in ipairs(self._users) do
						if iter_10_10 ~= iter_10_14 and self._baseRecord[iter_10_14] then
							var_10_14 = var_10_14 + 1

							local var_10_15, var_10_16, var_10_17 = self:fight(iter_10_13, self._baseRecord[iter_10_14], iter_10_11, self._users[iter_10_14], var_10_14)

							table.insert(var_10_13[iter_10_10], {
								var_10_15,
								var_10_16,
								var_10_17,
								iter_10_11,
								self._users[iter_10_14]
							})

							var_10_12 = true
						end
					end

					break
				end
			end
		end

		if not var_10_12 then
			break
		end

		var_10_2 = var_10_2 .. "迭代测试" .. var_10_11 .. "\r\n"

		for iter_10_16, iter_10_17 in ipairs(self._users) do
			if next(var_10_13[iter_10_16]) then
				var_10_2 = var_10_2 .. "\t\t\t先手\t后手\t胜率平均值\t先手平均回合数\t后手平均回合数\t\t"
			end
		end

		var_10_2 = var_10_2 .. "\r\n"

		for iter_10_18 = 1, #self._users - 1 do
			for iter_10_19 = 1, #self._users do
				if var_10_13[iter_10_19][iter_10_18] then
					var_10_2 = iter_10_18 == 1 and var_10_2 .. string.format("%s\tVS\t%s\t%.2f%%\t%.2f%%\t%.2f%%\t%.2f\t%.2f\t\t", var_10_13[iter_10_19][iter_10_18][4].name, var_10_13[iter_10_19][iter_10_18][5].name, var_10_13[iter_10_19][iter_10_18][1].winCount1 / var_10_13[iter_10_19][iter_10_18][1].fightCount1 * 100, var_10_13[iter_10_19][iter_10_18][1].winCount2 / var_10_13[iter_10_19][iter_10_18][1].fightCount2 * 100, (var_10_13[iter_10_19][iter_10_18][1].winCount1 / var_10_13[iter_10_19][iter_10_18][1].fightCount1 * 100 + var_10_13[iter_10_19][iter_10_18][1].winCount2 / var_10_13[iter_10_19][iter_10_18][1].fightCount2 * 100) / 2, var_10_13[iter_10_19][iter_10_18][1].roundCount1 / var_10_13[iter_10_19][iter_10_18][1].fightCount1, var_10_13[iter_10_19][iter_10_18][1].roundCount2 / var_10_13[iter_10_19][iter_10_18][1].fightCount2) or var_10_2 .. string.format("\t\t%s\t%.2f%%\t%.2f%%\t%.2f%%\t%.2f\t%.2f\t\t", var_10_13[iter_10_19][iter_10_18][5].name, var_10_13[iter_10_19][iter_10_18][1].winCount1 / var_10_13[iter_10_19][iter_10_18][1].fightCount1 * 100, var_10_13[iter_10_19][iter_10_18][1].winCount2 / var_10_13[iter_10_19][iter_10_18][1].fightCount2 * 100, (var_10_13[iter_10_19][iter_10_18][1].winCount1 / var_10_13[iter_10_19][iter_10_18][1].fightCount1 * 100 + var_10_13[iter_10_19][iter_10_18][1].winCount2 / var_10_13[iter_10_19][iter_10_18][1].fightCount2 * 100) / 2, var_10_13[iter_10_19][iter_10_18][1].roundCount1 / var_10_13[iter_10_19][iter_10_18][1].fightCount1, var_10_13[iter_10_19][iter_10_18][1].roundCount2 / var_10_13[iter_10_19][iter_10_18][1].fightCount2)
				end
			end

			var_10_2 = var_10_2 .. "\r\n"
		end

		var_10_2 = var_10_2 .. "\r\n"

		for iter_10_20, iter_10_21 in ipairs(self._users) do
			if next(var_10_13[iter_10_20]) then
				var_10_2 = var_10_2 .. iter_10_21.name .. "阵容统计\t\t\t\t\t\t\t\t\t"
			end
		end

		var_10_2 = var_10_2 .. "\r\n"

		for iter_10_22, iter_10_23 in ipairs(self._users) do
			if next(var_10_13[iter_10_22]) then
				var_10_2 = var_10_2 .. "\t名称\t\t伤害\t技能伤害\t承伤\t治疗\t普攻\t技能\t\t\t\t"
			end
		end

		var_10_2 = var_10_2 .. "\r\n"

		local var_10_20 = {}
		local var_10_21 = 0

		for iter_10_24 = 1, #self._users do
			local var_10_22 = {}

			for iter_10_25, iter_10_26 in ipairs(var_10_13[iter_10_24]) do
				table.insertto(var_10_22, iter_10_26[2])
			end

			local var_10_23 = var_10_1(var_10_22)

			var_10_20[iter_10_24] = var_10_23
			var_10_21 = math.max(var_10_21, #var_10_23)
		end

		for iter_10_27 = 1, var_10_21 do
			for iter_10_28 = 1, #self._users do
				if var_10_20[iter_10_28] and var_10_20[iter_10_28][iter_10_27] then
					var_10_2 = var_10_2 .. string.format("\t%s\t\t%d\t%d\t%d\t%d\t%.2f\t%.2f\t\t\t\t", var_10_20[iter_10_28][iter_10_27].name, var_10_20[iter_10_28][iter_10_27].dam, var_10_20[iter_10_28][iter_10_27].skill_dam, var_10_20[iter_10_28][iter_10_27].take_dam, var_10_20[iter_10_28][iter_10_27].recover, var_10_20[iter_10_28][iter_10_27].normal_skill_num, var_10_20[iter_10_28][iter_10_27].skill_num)
				end
			end

			var_10_2 = var_10_2 .. "\r\n"
		end

		var_10_2 = var_10_2 .. "\r\n"
		var_10_11 = var_10_11 + 1
	end

	if self._batchBattleClient then
		self._batchBattleClient:sendLog("batch battle end,total use time:" .. os.clock() - var_10_0 .. "s")
		self._batchBattleClient:shotDown()
	end

	local var_10_24 = cc.FileUtils:getInstance()
	local var_10_25 = var_10_24:getWritablePath() .. "/battle_test_log/"

	if not var_10_24:isDirectoryExist(var_10_25) then
		var_10_24:createDirectory(var_10_25)
	end

	local var_10_26 = os.date("*t")

	print(var_10_25)
	print(var_10_26.year .. "-" .. var_10_26.month .. "-" .. var_10_26.day .. " " .. var_10_26.hour .. "-" .. var_10_26.min .. "-" .. var_10_26.sec)
	print(var_10_2)

	if not var_10_2 or #var_10_2 < 2 then
		g.core.module.ModuleManager:tip("日志为空，请检查对应阵容数据")

		return
	end

	var_10_24:writeStringToFile(var_10_2, var_10_25 .. (var_10_26.year .. "-" .. var_10_26.month .. "-" .. var_10_26.day .. " " .. var_10_26.hour .. "-" .. var_10_26.min .. "-" .. var_10_26.sec) .. ".txt")
end

function MuiltFightAutoPop:_onClickCancel()
	self:removeSelf()
end

return MuiltFightAutoPop
