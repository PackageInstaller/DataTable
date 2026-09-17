local var_0_0 = {
	CANACTIVE = 4,
	HAVEACTIVATED = 0,
	UNLEVELUP = 3,
	UNACTIVE_NONE = 1,
	UNACTIVE_UNALL = 2,
	CANLEVELUP = 5
}
local var_0_1 = {
	REVIEW = 3,
	FIRST = 2,
	LOCK = 1,
	UNHAVE = 0
}
local var_0_3 = {
	fire = "EquipLayer/fire.png",
	shiling = "EquipLayer/shiling.png",
	water = "EquipLayer/water.png",
	umaru = "EquipLayer/umaru.png",
	light = "EquipLayer/light.png",
	dark = "EquipLayer/dark.png",
	imaginary = "EquipLayer/imaginary.png",
	wind = "EquipLayer/wind.png",
	zerosupperession = "EquipLayer/zerosupperession.png",
	devil = "EquipLayer/devil.png"
}

setmetatable(var_0_3, {
	__index = function(arg_1_0, arg_1_1)
		return "EquipLayer/" .. arg_1_1 .. ".png"
	end
})

local var_0_4 = {
	"BondLayer/student_bg.png",
	"BondLayer/student_bg_on.png"
}
local var_0_5 = {
	"BondLayer/bondDetail/bg_sr.png",
	"BondLayer/bondDetail/bg_sr.png",
	"BondLayer/bondDetail/bg_ur.png",
	"BondLayer/bondDetail/bg_mr.png",
	"BondLayer/bondDetail/bg_sp.png"
}
local var_0_6 = 3
local var_0_7 = 4
local bond_data = require("data/bond_data")
local servant_data = require("data.servant_data")
local model_data = require("data.model_data")
local playermodel = require("model.playermodel")
local network = require("network.network")
local bit = require("bit")
local tips_manager = require("controller.tips_manager")
local item_manager = require("controller.item_manager")
local core_manager = require("controller.core_manager")
local BondManager = class("BondManager")

function BondManager:init(arg_2_1)
	self.bondInfo = {}

	self:initDataInfo(self.bondInfo)
	self:requestBondInfo(arg_2_1)
end

function BondManager:initEnemyBond(arg_3_1)
	self.enemyBondInfo = {}

	self:initDataInfo(self.enemyBondInfo)
	self:initBondInfo(arg_3_1, self.enemyBondInfo)
end

function BondManager:updateCurDataInfo(arg_4_1, arg_4_2)
	local var_4_0 = {}

	while arg_4_1["servant" .. 1] ~= nil do
		local var_4_1 = ""
		local var_4_2 = "赛娜"
		local var_4_3 = "EquipLayer/wind.png"
		local var_4_4 = ""
		local var_4_5 = playermodel.soulContract[arg_4_1["servant" .. 1]]

		var_4_5 = (playermodel.addRollRarity[arg_4_1["servant" .. 1]] or 0) > 0 and 5 or var_4_5

		local var_4_6 = "EquipLayer/no_signal.png"

		if var_4_5 >= 1 then
			var_4_6 = "public/rolebg/+" .. var_4_5 .. ".png"
		end

		if servant_data[arg_4_1["servant" .. 1]] then
			var_4_1 = ROLE_PORTRAIT_PATH .. model_data[servant_data[arg_4_1["servant" .. 1]].modelid].portrait_image .. ".png"
			var_4_2 = servant_data[arg_4_1["servant" .. 1]].name
			var_4_3 = var_0_3[global_get_model_attr(servant_data[arg_4_1["servant" .. 1]].modelid)]
			var_4_4 = "role/shop_image/" .. model_data[servant_data[arg_4_1["servant" .. 1]].modelid].role_image .. ".png"
		end

		local var_4_7 = tonumber(playermodel.haveServant[arg_4_1["servant" .. 1]] and 1)
		local var_4_8
		local var_4_10

		if not var_4_7 then
			var_4_7 = 0
			var_4_8 = var_0_5[self:get_servant_cur_roll_rarity(arg_4_1["servant" .. 1])]
			var_4_10 = {
				index = 1,
				id = arg_4_1["servant" .. 1],
				isHave = var_4_7,
				curVibrationLevel = var_4_5
			}
		end

		var_4_10.bgPath = var_0_4[var_4_7 + 1]
		var_4_10.playerPath = var_4_4
		var_4_10.detailBgPath = var_4_8
		var_4_10.detailPlayerPath = var_4_1
		var_4_10.typePath = var_4_3
		var_4_10.contractPath = var_4_6
		var_4_10.name = var_4_2
		var_4_10.isCanVibration = self:isBreakLimit(arg_4_1["servant" .. 1])

		table.insert(var_4_0, var_4_10)
	end

	local var_4_12 = {}
	local var_4_13 = 1

	while arg_4_1["effect" .. var_4_13] ~= nil do
		local var_4_14 = 0
		local var_4_15 = #var_4_0
		local var_4_16 = arg_4_1["param" .. var_4_13]

		if arg_4_1["condition" .. var_4_13] == 1 then
			for iter_4_0 = 1, var_4_15 do
				if var_4_0[iter_4_0].isHave == 1 then
					var_4_14 = var_4_14 + 1
				end
			end
		else
			for iter_4_1 = 1, var_4_15 do
				if var_4_16 <= var_4_0[iter_4_1].curVibrationLevel then
					var_4_14 = var_4_14 + 1
				end
			end
		end

		local var_4_17 = arg_4_1["story" .. var_4_13]

		table.insert(var_4_12, {
			isHaveFirstWatch = false,
			id = var_4_13,
			isEffectAll = arg_4_1["is_effect" .. var_4_13 .. "_all"],
			condition = arg_4_1["condition" .. var_4_13],
			param = var_4_16,
			des1 = "(" .. var_4_14 .. "/" .. var_4_15 .. ") " .. arg_4_1["des" .. var_4_13],
			des2 = arg_4_1["effect" .. var_4_13],
			des3 = arg_4_1["effect_all_" .. var_4_13],
			haveNum = var_4_14,
			totalNum = var_4_15,
			skillId = arg_4_1["skill" .. var_4_13],
			classification = var_4_17,
			btnPlotStatus = (arg_4_1["story" .. var_4_13] ~= nil or nil) and var_0_1.LOCK
		})

		var_4_13 = var_4_13 + 1
	end

	local var_4_19 = {
		isDouble = false,
		maxLevel = 0,
		addLevel = 0,
		des = "",
		index = arg_4_2.index,
		id = arg_4_1.id,
		name = arg_4_1.name,
		playerList = var_4_0
	}

	var_4_19.curLevel = arg_4_2.curLevel or 0
	var_4_19.levelList = var_4_12
	var_4_19.bondStatus = var_0_0.UNACTIVE_NONE
	var_4_19.postcard = arg_4_1.postcard
	var_4_19.sort = arg_4_1.sort

	self:initCurBondInfo(var_4_19)

	for iter_4_2 = 1, #self.bondInfo do
		if self.bondInfo[iter_4_2].id == var_4_19.id then
			self.bondInfo[iter_4_2] = var_4_19

			break
		end
	end
end

function BondManager:updateBreakOutInfo(arg_5_1)
	for iter_5_0, iter_5_1 in pairs(self.bondInfo) do
		self:initDataInfo(self.bondInfo, iter_5_0)
	end

	if type(arg_5_1) == "function" then
		arg_5_1()
	end
end

function BondManager:initDataInfo(arg_6_1, arg_6_2)
	if arg_6_2 ~= nil then
		local var_6_0

		for iter_6_0, iter_6_1 in pairs(bond_data) do
			if iter_6_1.id == arg_6_1[arg_6_2].id then
				var_6_0 = iter_6_1

				break
			end
		end

		self:updateCurDataInfo(var_6_0, arg_6_1[arg_6_2])

		return
	end

	for iter_6_2, iter_6_3 in pairs(bond_data) do
		local var_6_1 = {}
		local var_6_2 = 1

		while iter_6_3["servant" .. var_6_2] ~= nil do
			local var_6_3 = ""
			local var_6_4 = "赛娜"
			local var_6_5 = "EquipLayer/wind.png"
			local var_6_6 = ""
			local var_6_7 = playermodel.soulContract[iter_6_3["servant" .. var_6_2]]

			var_6_7 = (playermodel.addRollRarity[iter_6_3["servant" .. var_6_2]] or 0) > 0 and 5 or var_6_7

			local var_6_8 = "EquipLayer/no_signal.png"

			if var_6_7 >= 1 then
				var_6_8 = "public/rolebg/+" .. var_6_7 .. ".png"
			end

			if servant_data[iter_6_3["servant" .. var_6_2]] then
				var_6_3 = ROLE_PORTRAIT_PATH .. model_data[servant_data[iter_6_3["servant" .. var_6_2]].modelid].portrait_image .. ".png"
				var_6_4 = servant_data[iter_6_3["servant" .. var_6_2]].name
				var_6_5 = var_0_3[global_get_model_attr(servant_data[iter_6_3["servant" .. var_6_2]].modelid)]
				var_6_6 = "role/shop_image/" .. model_data[servant_data[iter_6_3["servant" .. var_6_2]].modelid].role_image .. ".png"
			end

			local var_6_9 = tonumber(playermodel.haveServant[iter_6_3["servant" .. var_6_2]] and 1)
			local var_6_12
			local var_6_10

			if not var_6_9 then
				var_6_9 = 0
				var_6_10 = var_0_5[self:get_servant_cur_roll_rarity(iter_6_3["servant" .. var_6_2])]
				var_6_12 = {
					index = var_6_2,
					id = iter_6_3["servant" .. var_6_2],
					isHave = var_6_9,
					curVibrationLevel = var_6_7
				}
			end

			var_6_12.bgPath = var_0_4[var_6_9 + 1]
			var_6_12.playerPath = var_6_6
			var_6_12.detailBgPath = var_6_10
			var_6_12.detailPlayerPath = var_6_3
			var_6_12.typePath = var_6_5
			var_6_12.contractPath = var_6_8
			var_6_12.name = var_6_4
			var_6_12.isCanVibration = self:isBreakLimit(iter_6_3["servant" .. var_6_2])

			table.insert(var_6_1, var_6_12)

			var_6_2 = var_6_2 + 1
		end

		local var_6_13 = {}
		local var_6_14 = 1

		while iter_6_3["effect" .. var_6_14] ~= nil do
			local var_6_15 = 0
			local var_6_16 = #var_6_1
			local var_6_17 = iter_6_3["param" .. var_6_14]

			if iter_6_3["condition" .. var_6_14] == 1 then
				for iter_6_4 = 1, var_6_16 do
					if var_6_1[iter_6_4].isHave == 1 then
						var_6_15 = var_6_15 + 1
					end
				end
			else
				for iter_6_5 = 1, var_6_16 do
					if var_6_17 <= var_6_1[iter_6_5].curVibrationLevel then
						var_6_15 = var_6_15 + 1
					end
				end
			end

			local var_6_18 = iter_6_3["story" .. var_6_14]

			table.insert(var_6_13, {
				isHaveFirstWatch = false,
				id = var_6_14,
				isEffectAll = iter_6_3["is_effect" .. var_6_14 .. "_all"],
				condition = iter_6_3["condition" .. var_6_14],
				param = var_6_17,
				des1 = "(" .. var_6_15 .. "/" .. var_6_16 .. ") " .. iter_6_3["des" .. var_6_14],
				des2 = iter_6_3["effect" .. var_6_14],
				des3 = iter_6_3["effect_all_" .. var_6_14],
				haveNum = var_6_15,
				totalNum = var_6_16,
				skillId = iter_6_3["skill" .. var_6_14],
				classification = var_6_18,
				btnPlotStatus = (iter_6_3["story" .. var_6_14] ~= nil or nil) and var_0_1.LOCK
			})

			var_6_14 = var_6_14 + 1
		end

		local var_6_22 = {
			isDouble = false,
			curLevel = 0,
			maxLevel = 0,
			addLevel = 0,
			des = "",
			index = #arg_6_1 + 1,
			id = iter_6_3.id,
			name = iter_6_3.name,
			playerList = var_6_1,
			levelList = var_6_13,
			bondStatus = var_0_0.UNACTIVE_NONE,
			postcard = iter_6_3.postcard,
			sort = iter_6_3.sort
		}

		self:initCurBondInfo(var_6_22)

		if iter_6_3.is_need_have_all == 0 or self:isHaveAllServant(var_6_1) == true then
			table.insert(arg_6_1, var_6_22)
		end
	end

	table.sort(arg_6_1, function(arg_7_0, arg_7_1)
		return arg_7_0.sort < arg_7_1.sort
	end)
end

function BondManager:isHaveAllServant(arg_8_1)
	local var_8_0 = true

	for iter_8_0, iter_8_1 in pairs(arg_8_1) do
		if iter_8_1.isHave == 0 then
			var_8_0 = false

			break
		end
	end

	return var_8_0
end

function BondManager:updateDataInfo(arg_9_1)
	for iter_9_0 = 1, #self.bondInfo do
		for iter_9_1 = 1, #self.bondInfo[iter_9_0].playerList do
			if self.bondInfo[iter_9_0].playerList[iter_9_1].id == arg_9_1 then
				self:initDataInfo(self.bondInfo, iter_9_0)
				self:checkIsShowBondBubble(iter_9_0)

				break
			end
		end
	end
end

function BondManager:initCurBondInfo(arg_10_1)
	local var_10_0 = arg_10_1.playerList
	local var_10_1 = #arg_10_1.playerList > var_0_7
	local var_10_2 = arg_10_1.curLevel or 0
	local var_10_3 = var_10_2 < var_0_6 and arg_10_1.levelList[var_10_2 + 1] or arg_10_1.levelList[var_10_2]
	local var_10_4 = var_0_0.UNACTIVE_NONE

	if var_10_3.condition == 1 then
		local var_10_5 = {}

		for iter_10_0, iter_10_1 in pairs(var_10_0) do
			if iter_10_1.isHave == 1 then
				table.insert(var_10_5, iter_10_1)
			end
		end

		if var_10_2 == var_0_6 then
			var_10_4 = var_0_0.HAVEACTIVATED
		elseif #var_10_5 == #var_10_0 and var_10_2 == 0 then
			var_10_4 = var_0_0.CANACTIVE
		elseif #var_10_5 == #var_10_0 and var_10_2 ~= 0 then
			var_10_4 = var_0_0.CANLEVELUP
		elseif #var_10_5 > 0 and #var_10_5 ~= #var_10_0 and var_10_2 == 0 then
			var_10_4 = var_0_0.UNACTIVE_UNALL
		elseif #var_10_5 <= 0 and #var_10_5 ~= #var_10_0 and var_10_2 == 0 then
			var_10_4 = var_0_0.UNACTIVE_NONE
		elseif #var_10_5 ~= #var_10_0 and var_10_2 ~= 0 then
			var_10_4 = var_0_0.UNLEVELUP
		end
	elseif var_10_3.condition == 2 then
		local var_10_6 = {}

		for iter_10_2, iter_10_3 in pairs(var_10_0) do
			if iter_10_3.curVibrationLevel >= var_10_3.param then
				table.insert(var_10_6, iter_10_3)
			end
		end

		if var_10_2 == var_0_6 then
			var_10_4 = var_0_0.HAVEACTIVATED
		elseif #var_10_6 == #var_10_0 and var_10_2 == 0 then
			var_10_4 = var_0_0.CANACTIVE
		elseif #var_10_6 == #var_10_0 and var_10_2 ~= 0 then
			var_10_4 = var_0_0.CANLEVELUP
		elseif #var_10_6 > 0 and #var_10_6 ~= #var_10_0 and var_10_2 == 0 then
			var_10_4 = var_0_0.UNACTIVE_UNALL
		elseif #var_10_6 <= 0 and #var_10_6 ~= #var_10_0 and var_10_2 == 0 then
			var_10_4 = var_0_0.UNACTIVE_NONE
		elseif #var_10_6 ~= #var_10_0 and var_10_2 ~= 0 then
			var_10_4 = var_0_0.UNLEVELUP
		end
	end

	for iter_10_4 = 1, #arg_10_1.levelList do
		if iter_10_4 <= var_10_2 and arg_10_1.levelList[iter_10_4].btnPlotStatus ~= var_0_1.REVIEW and arg_10_1.levelList[iter_10_4].btnPlotStatus ~= var_0_1.UNHAVE then
			arg_10_1.levelList[iter_10_4].btnPlotStatus = var_0_1.FIRST
		end
	end

	arg_10_1.curLevel = var_10_2
	arg_10_1.des = arg_10_1.levelList[math.max(var_10_2, 1)].des2
	arg_10_1.bondStatus = var_10_4
	arg_10_1.isDouble = var_10_1

	local var_10_7 = self:getcurMaxLevel(arg_10_1)

	arg_10_1.maxLevel = var_10_7
	arg_10_1.addLevel = var_10_7 - var_10_2
end

local var_0_18 = {
	1,
	2,
	4
}

function BondManager:initBondInfo(arg_11_1, arg_11_2)
	if arg_11_1 == nil or arg_11_2 == nil then
		return
	end

	for iter_11_0 = 1, #arg_11_1 do
		for iter_11_1 = 1, #arg_11_2 do
			if arg_11_1[iter_11_0].id == arg_11_2[iter_11_1].id then
				arg_11_2[iter_11_1].curLevel = arg_11_1[iter_11_0].level

				if arg_11_1[iter_11_0].plot ~= nil then
					for iter_11_2 = 1, #arg_11_2[iter_11_1].levelList do
						if bit.band(arg_11_1[iter_11_0].plot, var_0_18[iter_11_2]) ~= 0 and arg_11_2[iter_11_1].levelList[iter_11_2].btnPlotStatus ~= var_0_1.UNHAVE then
							arg_11_2[iter_11_1].levelList[iter_11_2].btnPlotStatus = var_0_1.REVIEW
						end
					end
				end

				self:initCurBondInfo(arg_11_2[iter_11_1])

				break
			end
		end
	end

	table.sort(arg_11_2, function(arg_12_0, arg_12_1)
		if arg_12_0.bondStatus == arg_12_1.bondStatus then
			return arg_12_0.sort < arg_12_1.sort
		else
			return arg_12_0.bondStatus > arg_12_1.bondStatus
		end
	end)
end

function BondManager:requestBondInfo(arg_13_1)
	network:rpc("get_bond_info", nil, function(arg_14_0)
		if arg_14_0.result == 1 then
			self:initBondInfo(arg_14_0.teams, self.bondInfo)

			if type(arg_13_1) == "function" then
				arg_13_1()
			end
		else
			print("get_bond_info msg.result is " .. arg_14_0.result)
		end
	end)
end

function BondManager:getcurMaxLevel(arg_15_1)
	if arg_15_1 == nil then
		return
	end

	local var_15_0 = arg_15_1.levelList
	local var_15_1 = arg_15_1.curLevel
	local var_15_2 = false

	for iter_15_0 = #arg_15_1.levelList, 1, -1 do
		if var_15_0[iter_15_0].condition == 1 then
			local var_15_3 = {}

			for iter_15_1, iter_15_2 in pairs(arg_15_1.playerList) do
				if iter_15_2.isHave == 1 then
					table.insert(var_15_3, iter_15_2)
				end
			end

			if arg_15_1.curLevel == var_0_6 or #var_15_3 == #arg_15_1.playerList then
				var_15_1 = iter_15_0
				var_15_2 = true
			end
		else
			local var_15_4 = {}

			for iter_15_3, iter_15_4 in pairs(arg_15_1.playerList) do
				if iter_15_4.curVibrationLevel >= var_15_0[iter_15_0].param then
					table.insert(var_15_4, iter_15_4)
				end
			end

			if arg_15_1.curLevel == var_0_6 or #var_15_4 == #arg_15_1.playerList then
				var_15_1 = iter_15_0
				var_15_2 = true
			end
		end

		if var_15_2 == true then
			break
		end
	end

	return var_15_1
end

function BondManager:updateCurBondInfo(arg_16_1)
	if arg_16_1 == nil then
		return
	end

	local var_16_0 = arg_16_1.id
	local var_16_1

	for iter_16_0, iter_16_1 in pairs(self.bondInfo) do
		if var_16_0 == iter_16_1.id then
			var_16_1 = iter_16_1

			break
		end
	end

	var_16_1.maxLevel = var_16_1.curLevel + arg_16_1.addLevel
	var_16_1.curLevel = var_16_1.maxLevel

	self:initCurBondInfo(var_16_1)

	for iter_16_2 = 1, #self.bondInfo do
		if self.bondInfo[iter_16_2].id == var_16_0 then
			self.bondInfo[iter_16_2] = var_16_1

			break
		end
	end
end

function BondManager:operateBond(arg_17_1, arg_17_2)
	network:rpc("do_bond", {
		id = arg_17_1.id,
		level = arg_17_1.maxLevel
	}, function(arg_18_0)
		if arg_18_0.result == 1 then
			arg_17_1.addLevel = arg_18_0.level - arg_17_1.curLevel

			self:updateCurBondInfo(arg_17_1)

			if type(arg_17_2) == "function" then
				arg_17_2(arg_17_1)
			end
		elseif arg_18_0.result == 2 then
			global_ShowBlockWords("找不到羁绊组")
		elseif arg_18_0.result == 3 then
			global_ShowBlockWords("该档位已激活")
		elseif arg_18_0.result == 4 then
			global_ShowBlockWords("激活条件不满足")
		end
	end)
end

function BondManager:getBondInfo(arg_19_1)
	if arg_19_1 == nil then
		return self.bondInfo
	else
		local var_19_0

		for iter_19_0 = 1, #self.bondInfo do
			if self.bondInfo[iter_19_0].id == arg_19_1 then
				var_19_0 = self.bondInfo[iter_19_0]

				break
			end
		end

		return var_19_0
	end
end

function BondManager:getEnemyBondInfo(arg_20_1)
	if arg_20_1 == nil then
		return self.enemyBondInfo
	else
		local var_20_0

		for iter_20_0 = 1, #self.enemyBondInfo do
			if self.enemyBondInfo[iter_20_0].id == arg_20_1 then
				var_20_0 = self.enemyBondInfo[iter_20_0]

				break
			end
		end

		return var_20_0
	end
end

function BondManager:getBondAttribute(arg_21_1, arg_21_2)
	if self.bondInfo == nil or #self.bondInfo == 0 then
		return 0
	end

	local var_21_0 = 0

	for iter_21_0, iter_21_1 in pairs(self.bondInfo) do
		if iter_21_1.curLevel <= 0 or arg_21_2 == "hp" then
			-- block empty
		elseif arg_21_2 == "damage" then
			-- block empty
		end
	end

	return var_21_0
end

function BondManager:getEnemyBondAttribute(arg_22_1, arg_22_2)
	if self.enemyBondInfo == nil or #self.enemyBondInfo == 0 then
		return 0
	end

	local var_22_0 = 0

	for iter_22_0, iter_22_1 in pairs(self.enemyBondInfo) do
		if iter_22_1.curLevel <= 0 or arg_22_2 == "hp" then
			-- block empty
		elseif arg_22_2 == "damage" then
			-- block empty
		end
	end

	return var_22_0
end

function BondManager:isShowRemind()
	local var_23_0 = false

	if self.bondInfo == nil or #self.bondInfo == 0 then
		return var_23_0
	end

	for iter_23_0 = 1, #self.bondInfo do
		if self.bondInfo[iter_23_0].bondStatus == var_0_0.CANACTIVE or self.bondInfo[iter_23_0].bondStatus == var_0_0.CANLEVELUP then
			var_23_0 = true

			break
		end
	end

	return var_23_0
end

function BondManager:checkIsShowBondBubble(arg_24_1)
	if self.bondInfo == nil or self.bondInfo[arg_24_1] == nil then
		return false
	end

	local var_24_0 = self.bondInfo[arg_24_1]

	if self.bondInfo[arg_24_1].addLevel > 0 and var_24_0.curLevel == 0 then
		tips_manager:pushBackTipsEventWithClient({
			title = var_24_0.name,
			type = L_BOND_TIPS.ACTIVE,
			tipsid = E_TIPS_GET_BOND
		})
	elseif var_24_0.addLevel > 0 and var_24_0.curLevel ~= 0 then
		tips_manager:pushBackTipsEventWithClient({
			title = var_24_0.name,
			type = L_BOND_TIPS.LEVEL,
			tipsid = E_TIPS_GET_BOND
		})
	end
end

function BondManager:isBreakLimit(arg_25_1)
	if not playermodel.haveServant[arg_25_1] then
		return false
	end

	local var_25_0 = playermodel.soulContract[arg_25_1]
	local var_25_1 = playermodel.soulOverClock[arg_25_1] or 0
	local var_25_2 = core_manager:getUpgradeCostRoleCardNum(arg_25_1, var_25_0 + 1) or 0
	local var_25_3 = playermodel.servantNum[arg_25_1]
	local var_25_4 = item_manager:getItemNumber(servant_data[arg_25_1].studentCard)

	if var_25_0 >= 5 then
		if servant_data[arg_25_1]["oc_isopen" .. var_25_1 + 1] == 1 then
			return core_manager:getOcCostCpuNum(arg_25_1, var_25_1 + 1) <= item_manager:getItemNumber((core_manager:getOcCpuId(arg_25_1, var_25_1 + 1))) and core_manager:getOcCostCardNum(arg_25_1, var_25_1 + 1) <= var_25_3 + ((servant_data[arg_25_1].studentCard or nil) and (var_25_4 / servant_data[arg_25_1].studentCardRate or 0))
		else
			return false
		end
	end

	local var_25_7 = core_manager:getUpgradeCostMaterial(arg_25_1, var_25_0 + 1)

	if var_25_7 then
		return core_manager:getUpgradeCostMaterialNum(arg_25_1, var_25_0 + 1) <= item_manager:getItemNumber(var_25_7)
	else
		return var_25_2 <= var_25_3 + ((servant_data[arg_25_1].studentCard or nil) and (var_25_4 / servant_data[arg_25_1].studentCardRate or 0))
	end
end

function BondManager:playBondPlot(arg_26_1, arg_26_2)
	network:rpc("do_bond_plot", arg_26_1, function(arg_27_0)
		if arg_27_0.result == 1 then
			for iter_27_0 = 1, #self.bondInfo do
				if self.bondInfo[iter_27_0].id == arg_26_1.id and self.bondInfo[iter_27_0].levelList[arg_26_1.level].btnPlotStatus ~= var_0_1.UNHAVE then
					self.bondInfo[iter_27_0].levelList[arg_26_1.level].btnPlotStatus = var_0_1.REVIEW

					break
				end
			end

			if type(arg_26_2) == "function" then
				arg_26_2()
			end
		else
			print("观看剧情失败")
		end
	end)
end

function BondManager:getBondConfig(arg_28_1)
	local var_28_0 = {
		skillList = {}
	}
	local var_28_1 = {}
	local var_28_2

	if arg_28_1 == "player" then
		var_28_2 = self.bondInfo
	elseif arg_28_1 == "enemy" then
		var_28_2 = self.enemyBondInfo
	end

	for iter_28_0 = 1, (var_28_2 or nil) and (#var_28_2 or 0) do
		if var_28_2[iter_28_0].curLevel > 0 then
			table.insert(var_28_1, var_28_2[iter_28_0].levelList[var_28_2[iter_28_0].curLevel].skillId)
		end
	end

	var_28_0.skillList = var_28_1

	return var_28_0
end

function BondManager:isHaveBondEffect()
	local var_29_0 = false

	if not self.bondInfo then
		return var_29_0
	end

	for iter_29_0 = 1, #self.bondInfo do
		if self.bondInfo[iter_29_0].curLevel > 0 then
			var_29_0 = true

			break
		end
	end

	return var_29_0
end

function BondManager:getClassificationId(arg_30_1, arg_30_2)
	if arg_30_1 == nil then
		return nil
	end

	local var_30_0

	if arg_30_2 ~= nil then
		var_30_0 = arg_30_1.levelList[arg_30_2].classification
	else
		for iter_30_0 = #arg_30_1.levelList, 1, -1 do
			if arg_30_1.levelList[iter_30_0].classification and arg_30_1.levelList[iter_30_0].btnPlotStatus == var_0_1.FIRST then
				var_30_0 = arg_30_1.levelList[iter_30_0].classification

				self:playBondPlot({
					id = arg_30_1.id,
					level = iter_30_0
				})

				break
			end
		end
	end

	return var_30_0
end

function BondManager:isHaveEnemyBondEffect()
	local var_31_0 = false

	for iter_31_0 = 1, #self.enemyBondInfo do
		if self.enemyBondInfo[iter_31_0].curLevel > 0 then
			var_31_0 = true

			break
		end
	end

	return var_31_0
end

function BondManager:get_servant_initial_roll_rarity(arg_32_1)
	return servant_data[arg_32_1].roll_rarity
end

function BondManager:get_servant_cur_roll_rarity(arg_33_1)
	return self:get_servant_initial_roll_rarity(arg_33_1) + playermodel.addRollRarity[arg_33_1]
end

return BondManager
