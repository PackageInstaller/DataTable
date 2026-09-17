local var_0_1 = math
local var_0_2 = table
local playermodel = require("model.playermodel")
local FightMessage = require("fight.FightMessage")
local xp_effect_manager = require("fight.xp.xp_effect_manager")

function FightCharacter:doBehavior(arg_1_1, ...)
	assert(self[arg_1_1] ~= nil, "do a nil behavior " .. arg_1_1)

	local var_1_0, var_1_1 = self[arg_1_1](self, ...)

	return var_1_0, var_1_1
end

function FightCharacter:check_basic_xp_distance()
	if self:getSkillMaxdistance("xp") < 0 then
		return true
	end

	local var_2_0, var_2_1 = self:getNearestOponentPos()

	if not var_2_0 then
		return false
	end

	return var_0_1.abs(var_2_0 - self:getStandardPosition()) <= self:getSkillMaxdistance("xp") + var_2_1
end

function FightCharacter:can_xp_usable()
	if (FightManager.getFightType() == FIGHTTYPE_TOWER or FightManager.getFightType() == FIGHTTYPE_EXPEDITION_TOWER) and self.charactertype == "player" then
		return false
	end

	if FightManager.isNormalFight() and not FightManager.isBigBossFight() then
		return false
	end

	if xp_effect_manager.isXPNow() then
		return false
	end

	if self.charactertype == "player" and self.playerItem and not playermodel.autoXP then
		return false
	end

	if not self:check_basic_xp_distance() then
		return false
	end

	if self.statuspool:checkStatus("addict") then
		return false
	end

	if self.statuspool:checkStatus("silence") then
		return false
	elseif self.statuspool:checkStatus("ragefree") then
		return true
	else
		return self:getAttribute("rage") >= self:getAttribute("maxrage")
	end
end

function FightCharacter:check_basic_skill_distance(arg_4_1)
	if self:getSkillMaxdistance(arg_4_1) < 0 then
		return true
	end

	local var_4_0, var_4_1 = self:getNearestOponentPos()

	if not var_4_0 then
		return false
	end

	return var_0_1.abs(var_4_0 - self:getStandardPosition()) <= self:getSkillMaxdistance(arg_4_1) + var_4_1
end

function FightCharacter:can_skill_usable(arg_5_1)
	if arg_5_1 == "xp" then
		return self:can_xp_usable()
	end

	if not self:check_basic_skill_distance(arg_5_1) then
		return false
	end

	if self.statuspool:checkStatus("addict") then
		return false
	end

	if self.statuspool:checkStatus("silence") then
		return false
	else
		return self:canSkillCDEnable(arg_5_1)
	end
end

function FightCharacter:check_character_hp_percent(arg_6_1, arg_6_2)
	return compareByoperator(arg_6_2, self:getAttribute("curhp") / self:getAttribute("singlehp"), arg_6_1)
end

function FightCharacter:check_targetpool_hp_percent(arg_7_1, arg_7_2)
	if not self._locktargetpool then
		return false
	end

	local var_7_0 = self:getAttackUnitOrder()

	for iter_7_0, iter_7_1 in pairs(FightManager[self._locktargetpool]) do
		if iter_7_1:canBeLocked((self:is_locking_teammate(self._locktargetpool) or nil) and 999) and compareByoperator(arg_7_2, iter_7_1:getAttribute("curhp") / iter_7_1:getAttribute("hp"), arg_7_1) then
			return true
		end
	end

	return false
end

function FightCharacter:check_attackcount(arg_8_1, arg_8_2)
	return compareByoperator(arg_8_2, self:getAttackcount(), arg_8_1)
end

function FightCharacter:check_targetpool_in_area(arg_9_1, arg_9_2)
	if not self._locktargetpool then
		return false
	end

	local var_9_0 = self:getStandardPosition() + arg_9_1.center
	local var_9_1 = {}

	if self._direction == 1 then
		var_9_1.left = var_9_0 - arg_9_1.left
		var_9_1.right = var_9_0 + arg_9_1.right
	else
		var_9_1.left = var_9_0 - arg_9_1.right
		var_9_1.right = var_9_0 + arg_9_1.left
	end

	local var_9_2 = self:getAttackUnitOrder()

	if self:is_locking_teammate(self._locktargetpool) then
		var_9_2 = 999
	end

	local var_9_3 = 0

	for iter_9_0, iter_9_1 in pairs(FightManager[self._locktargetpool]) do
		if iter_9_1:canBeLocked(var_9_2) and (iter_9_1.index ~= self.index or not self.statuspool:checkStatus("addict")) and FightManager.fightSpriteCrash(var_9_1, iter_9_1:getCrashRect()) then
			var_9_3 = var_9_3 + 1
		end
	end

	return compareByoperator(arg_9_2, var_9_3, arg_9_1.count)
end

function FightCharacter:lock_target_pool(arg_10_1)
	if arg_10_1 == "all" then
		return true
	end

	local var_10_0 = arg_10_1 == "teammate" and 0 or 1

	if self.statuspool:checkStatus("addict") then
		var_10_0 = 1 - var_10_0
	end

	if self.charactertype == "player" then
		self._locktargetpool = var_10_0 == 0 and "players" or "enemies"
	elseif self.charactertype == "enemy" then
		self._locktargetpool = var_10_0 == 0 and "enemies" or "players"
	elseif self.charactertype == "slave" then
		self._locktargetpool = self.index:match("slave(.+)") == "players" and (var_10_0 == 0 and "players" or "enemies") or var_10_0 == 0 and "enemies" or "players"
	end

	return true
end

local var_0_7 = setmetatable({
	buff = function(self, arg_11_1)
		return self:getBuffCount(arg_11_1)
	end,
	attackcount = function(self)
		return self:getAttackcount()
	end
}, {
	__index = function(arg_13_0, arg_13_1)
		return function(arg_14_0)
			return arg_14_0:getAttribute(arg_13_1)
		end
	end
})
local var_0_8 = setmetatable({
	add = function(arg_15_0, arg_15_1)
		return arg_15_0 + arg_15_1
	end,
	minus = function(arg_16_0, arg_16_1)
		return arg_16_0 - arg_16_1
	end,
	multi = function(arg_17_0, arg_17_1)
		return arg_17_0 * arg_17_1
	end,
	divide = function(arg_18_0, arg_18_1)
		return arg_18_0 / arg_18_1
	end,
	mode = function(arg_19_0, arg_19_1)
		return arg_19_0 % arg_19_1
	end
}, {
	__call = function(self, arg_20_1, arg_20_2, arg_20_3)
		if not arg_20_2 then
			return arg_20_1
		end

		if arg_20_3 == "+" then
			return self.add(arg_20_1, arg_20_2)
		elseif arg_20_3 == "-" then
			return self.minus(arg_20_1, arg_20_2)
		elseif arg_20_3 == "*" then
			return self.multi(arg_20_1, arg_20_2)
		elseif arg_20_3 == "/" then
			return self.divide(arg_20_1, arg_20_2)
		elseif arg_20_3 == "%" then
			return self.mode(arg_20_1, arg_20_2)
		end
	end
})

local function var_0_9(arg_21_0, arg_21_1, arg_21_2)
	local function var_21_0(arg_22_0)
		if not arg_22_0 then
			return nil
		end

		local var_22_0, var_22_1 = arg_22_0:match("^([^:]+):(.+)$")
		local var_22_2

		if var_22_0 == "self" then
			var_22_2 = arg_21_1 or arg_21_2

			if not var_22_2 then
				return 0
			end

			if var_22_1:find("buff") then
				do return var_0_7.buff(var_22_2, tonumber((var_22_1:match("(%d+)$")))) end

				goto label_22_0
			end
		end

		do return var_0_7[var_22_1](var_22_2) end

		::label_22_0::
	end

	return var_0_8(var_21_0(arg_21_0[1]), var_21_0(arg_21_0[2]), arg_21_0[3])
end

function FightCharacter:judge_sequence_condition(arg_23_1, arg_23_2)
	for iter_23_0 = 1, #arg_23_2 do
		if not (arg_23_2[iter_23_0].equation and compareByoperator(arg_23_2[iter_23_0].operator, var_0_9(arg_23_2[iter_23_0].equation, self, arg_23_1), arg_23_2[iter_23_0].value) or self:judge_condition(arg_23_2[iter_23_0])) then
			return false
		end
	end

	return true
end

function FightCharacter:judge_selector_condition(arg_24_1, arg_24_2)
	for iter_24_0 = 1, #arg_24_2 do
		if arg_24_2[iter_24_0].equation and compareByoperator(arg_24_2[iter_24_0].operator, var_0_9(arg_24_2[iter_24_0].equation, self, arg_24_1), arg_24_2[iter_24_0].value) or self:judge_condition(arg_24_2[iter_24_0]) then
			return true
		end
	end

	return false
end

function FightCharacter:judge_condition(arg_25_1, arg_25_2)
	if arg_25_2.type == 1 then
		return self:judge_sequence_condition(arg_25_1, arg_25_2)
	elseif arg_25_2.type == 2 then
		return self:judge_selector_condition(arg_25_1, arg_25_2)
	elseif arg_25_2.equation then
		return compareByoperator(arg_25_2.operator, var_0_9(arg_25_2.equation, self, arg_25_1), arg_25_2.value)
	else
		return false
	end
end

function FightCharacter:check_character_attribute(arg_26_1)
	return self.judge_condition(self, self, (decode_condition_str2tbl(arg_26_1)))
end

function FightCharacter:filter_target_by_condition(arg_27_1)
	if not self._locktargetpool then
		return false
	end

	local var_27_0 = decode_condition_str2tbl(arg_27_1)
	local var_27_1 = self:getPosition()
	local var_27_2 = {}
	local var_27_3 = self:getAttackUnitOrder()

	for iter_27_0, iter_27_1 in pairs(FightManager[self._locktargetpool]) do
		if iter_27_1:canBeLocked((self:is_locking_teammate(self._locktargetpool) or nil) and 999) and (iter_27_1.index ~= self.index or not self.statuspool:checkStatus("addict")) then
			local var_27_4, var_27_5 = iter_27_1:getRectPosition()
			local var_27_6 = var_27_4 <= var_27_1 and var_0_1.abs(var_27_4 + var_27_5 / 2 - var_27_1) or var_0_1.abs(var_27_4 - var_27_5 / 2 - var_27_1)

			if iter_27_1:judge_condition(var_27_0) then
				var_0_2.insert(var_27_2, {
					id = iter_27_0,
					index = iter_27_1.index,
					distance = var_27_6,
					mock_status = iter_27_1.statuspool:checkStatus("mock_status") and 1 or 0
				})
			end
		end
	end

	if #var_27_2 < 0 then
		return false
	end

	var_0_2.sort(var_27_2, function(arg_28_0, arg_28_1)
		if arg_28_0.mock_status ~= arg_28_1.mock_status then
			return arg_28_0.mock_status > arg_28_1.mock_status
		end

		if arg_28_0.distance == arg_28_1.distance then
			return arg_28_0.id < arg_28_1.id
		else
			return arg_28_0.distance < arg_28_1.distance
		end
	end)
	self:lockTarget(var_27_2[1].index)

	return true
end

local function var_0_10(arg_29_0, arg_29_1)
	if not arg_29_0 then
		return false
	end

	return arg_29_0 > 1 and arg_29_1 > 1
end

function FightCharacter:lock_target_by_distance(arg_30_1, arg_30_2, arg_30_3, arg_30_4)
	local var_30_0 = self:getPosition()
	local var_30_1 = {}

	for iter_30_0, iter_30_1 in pairs(arg_30_1) do
		if iter_30_1:canBeLocked(arg_30_3) and (iter_30_1.index ~= self.index or not self.statuspool:checkStatus("addict")) then
			local var_30_2, var_30_3 = iter_30_1:getRectPosition()
			local var_30_4 = var_30_2 <= var_30_0 and var_0_1.abs(var_30_2 + var_30_3 / 2 - var_30_0) or var_0_1.abs(var_30_2 - var_30_3 / 2 - var_30_0)

			var_30_1[#var_30_1 + 1] = {
				id = iter_30_0,
				index = iter_30_1.index,
				distance = var_30_4,
				mock_status = iter_30_1.statuspool:checkStatus("mock_status") and 1 or 0
			}
		end
	end

	if #var_30_1 <= 0 then
		return false
	end

	var_0_2.sort(var_30_1, function(arg_31_0, arg_31_1)
		if arg_31_0.mock_status ~= arg_31_1.mock_status then
			if arg_30_2 == "nearest" then
				return arg_31_0.mock_status > arg_31_1.mock_status
			elseif arg_30_2 == "farest" then
				return arg_31_0.mock_status < arg_31_1.mock_status
			end
		end

		if arg_31_0.distance == arg_31_1.distance then
			return arg_31_0.id > arg_31_1.id
		else
			return arg_31_0.distance < arg_31_1.distance
		end
	end)

	if arg_30_2 == "nearest" then
		if not var_0_10(arg_30_4, #var_30_1) then
			self:lockTarget(var_30_1[1].index)
		else
			local var_30_5 = {}

			for iter_30_2 = 1, arg_30_4 do
				var_0_2.insert(var_30_5, var_30_1[iter_30_2].index)
			end

			self:lockTarget(var_30_5)
		end
	elseif arg_30_2 == "farest" then
		if not var_0_10(arg_30_4, #var_30_1) then
			self:lockTarget(var_30_1[#var_30_1].index)
		else
			local var_30_6 = {}

			for iter_30_3 = 1, arg_30_4 do
				var_0_2.insert(var_30_6, var_30_1[#var_30_1 + 1 - iter_30_3].index)
			end

			self:lockTarget(var_30_6)
		end
	elseif arg_30_2 == "middle" then
		if not var_0_10(arg_30_4, #var_30_1) then
			self:lockTarget(var_30_1[var_0_1.floor((#var_30_1 + 1) / 2)].index)
		else
			local var_30_7 = {}
			local var_30_8 = var_0_1.floor((#var_30_1 + 1) / 2)

			var_0_2.insert(var_30_7, var_30_1[var_30_8].index)

			local var_30_9 = 1

			while var_30_9 < arg_30_4 do
				var_30_8 = var_30_9 % 2 == 0 and var_30_8 + var_30_9 or var_30_8 - var_30_9

				if not var_30_1[var_30_8] then
					break
				end

				var_0_2.insert(var_30_7, var_30_1[var_30_8].index)

				var_30_9 = var_30_9 + 1
			end
		end
	end

	return true
end

function FightCharacter:lock_target_by_hatred(arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = self:getPosition()
	local var_32_1 = self:getDirection()
	local var_32_2 = {}
	local var_32_3 = {}

	for iter_32_0, iter_32_1 in pairs(arg_32_1) do
		if iter_32_1:canBeLocked(arg_32_2) and (iter_32_1.index ~= self.index or not self.statuspool:checkStatus("addict")) then
			local var_32_4, var_32_5 = iter_32_1:getRectPosition()

			if var_32_1 * (var_32_4 - var_32_0) >= 0 then
				local var_32_6 = var_32_4 <= var_32_0 and var_0_1.abs(var_32_4 + var_32_5 / 2 - var_32_0) or var_0_1.abs(var_32_4 - var_32_5 / 2 - var_32_0)

				var_32_2[#var_32_2 + 1] = {
					id = iter_32_0,
					index = iter_32_1.index,
					distance = var_32_6,
					hatred = iter_32_1:getCharacterHatred(self:getAttribute("career")),
					mock_status = iter_32_1.statuspool:checkStatus("mock_status") and 1 or 0
				}
			else
				local var_32_7 = var_32_4 <= var_32_0 and var_0_1.abs(var_32_4 + var_32_5 / 2 - var_32_0) or var_0_1.abs(var_32_4 - var_32_5 / 2 - var_32_0)

				var_32_3[#var_32_3 + 1] = {
					id = iter_32_0,
					index = iter_32_1.index,
					distance = var_32_7,
					hatred = iter_32_1:getCharacterHatred(self:getAttribute("career")),
					mock_status = iter_32_1.statuspool:checkStatus("mock_status") and 1 or 0
				}
			end
		end
	end

	if #var_32_2 <= 0 and #var_32_3 <= 0 then
		return false
	end

	var_0_2.sort(var_32_2, function(arg_33_0, arg_33_1)
		if arg_33_0.mock_status ~= arg_33_1.mock_status then
			return arg_33_0.mock_status > arg_33_1.mock_status
		end

		if arg_33_0.distance == arg_33_1.distance then
			if arg_33_0.hatred == arg_33_1.hatred then
				return arg_33_0.id > arg_33_1.id
			else
				return arg_33_0.hatred > arg_33_1.hatred
			end
		else
			return arg_33_0.distance < arg_33_1.distance
		end
	end)
	var_0_2.sort(var_32_3, function(arg_34_0, arg_34_1)
		if arg_34_0.mock_status ~= arg_34_1.mock_status then
			return arg_34_0.mock_status > arg_34_1.mock_status
		end

		if arg_34_0.distance == arg_34_1.distance then
			if arg_34_0.hatred == arg_34_1.hatred then
				return arg_34_0.id < arg_34_1.id
			else
				return arg_34_0.hatred > arg_34_1.hatred
			end
		else
			return arg_34_0.distance < arg_34_1.distance
		end
	end)

	if #var_32_2 <= 0 then
		self:lockTarget(var_32_3[1].index)
	elseif #var_32_3 <= 0 then
		self:lockTarget(var_32_2[1].index)
	elseif var_32_3[1].hatred > var_32_2[1].hatred then
		self:lockTarget(var_32_3[1].index)
	else
		self:lockTarget(var_32_2[1].index)
	end

	return true
end

function FightCharacter:lock_target_by_hp(arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	local var_35_0 = {}

	for iter_35_0, iter_35_1 in pairs(arg_35_1) do
		if iter_35_1:canBeLocked(arg_35_3) and (iter_35_1.index ~= self.index or not self.statuspool:checkStatus("addict")) then
			var_35_0[#var_35_0 + 1] = {
				id = iter_35_0,
				index = iter_35_1.index,
				hp = iter_35_1:getAttribute("curhp") + iter_35_1:getAttribute("singlehp") * (iter_35_1:getAttribute("curhpcount") - 1),
				mock_status = iter_35_1.statuspool:checkStatus("mock_status") and 1 or 0
			}
		end
	end

	if #var_35_0 <= 0 then
		return false
	end

	var_0_2.sort(var_35_0, function(arg_36_0, arg_36_1)
		if arg_36_0.mock_status ~= arg_36_1.mock_status then
			if arg_35_2 == "hp_lowest" then
				return arg_36_0.mock_status > arg_36_1.mock_status
			elseif arg_35_2 == "hp_highest" then
				return arg_36_0.mock_status < arg_36_1.mock_status
			end
		end

		if arg_36_0.hp == arg_36_1.hp then
			return arg_36_0.id < arg_36_1.id
		else
			return arg_36_0.hp < arg_36_1.hp
		end
	end)

	if arg_35_2 == "hp_lowest" then
		if not var_0_10(arg_35_4, #var_35_0) then
			self:lockTarget(var_35_0[1].index)
		else
			local var_35_1 = {}

			for iter_35_2 = 1, arg_35_4 do
				var_0_2.insert(var_35_1, var_35_0[iter_35_2].index)
			end

			self:lockTarget(var_35_1)
		end
	elseif arg_35_2 == "hp_highest" then
		if not var_0_10(arg_35_4, #var_35_0) then
			self:lockTarget(var_35_0[#var_35_0].index)
		else
			local var_35_2 = {}

			for iter_35_3 = 1, arg_35_4 do
				var_0_2.insert(var_35_2, var_35_0[#var_35_0 + 1 - iter_35_3].index)
			end

			self:lockTarget(var_35_2)
		end
	end

	return true
end

function FightCharacter:lock_target_normal_attr(arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	local var_37_0 = {}
	local var_37_1, var_37_2 = arg_37_2:match("(.+)_(.+)$")

	if not var_37_1 or not var_37_2 then
		return false
	end

	for iter_37_0, iter_37_1 in pairs(arg_37_1) do
		if iter_37_1:canBeLocked(arg_37_3) and (iter_37_1.index ~= self.index or not self.statuspool:checkStatus("addict")) then
			var_0_2.insert(var_37_0, {
				id = iter_37_0,
				index = iter_37_1.index,
				param = iter_37_1:getAttribute(var_37_1),
				mock_status = iter_37_1.statuspool:checkStatus("mock_status") and 1 or 0
			})
		end
	end

	if #var_37_0 <= 0 then
		return false
	end

	var_0_2.sort(var_37_0, function(arg_38_0, arg_38_1)
		if arg_38_0.mock_status ~= arg_38_1.mock_status then
			if var_37_2 == "lowest" then
				return arg_38_0.mock_status > arg_38_1.mock_status
			elseif var_37_2 == "highest" then
				return arg_38_0.mock_status < arg_38_1.mock_status
			end
		end

		if arg_38_0.param == arg_38_1.param then
			return arg_38_0.id < arg_38_1.id
		else
			return arg_38_0.param < arg_38_1.param
		end
	end)

	if var_37_2 == "lowest" then
		if not var_0_10(arg_37_4, #var_37_0) then
			self:lockTarget(var_37_0[1].index)
		else
			local var_37_3 = {}

			for iter_37_2 = 1, arg_37_4 do
				var_0_2.insert(var_37_3, var_37_0[iter_37_2].index)
			end

			self:lockTarget(var_37_3)
		end
	elseif var_37_2 == "highest" then
		if not var_0_10(arg_37_4, #var_37_0) then
			self:lockTarget(var_37_0[#var_37_0].index)
		else
			local var_37_4 = {}

			for iter_37_3 = 1, arg_37_4 do
				var_0_2.insert(var_37_4, var_37_0[#var_37_0 + 1 - iter_37_3].index)
			end

			self:lockTarget(var_37_4)
		end
	end

	return true
end

function FightCharacter:lock_target_by_hppercent(arg_39_1, arg_39_2, arg_39_3, arg_39_4)
	local var_39_0 = {}

	for iter_39_0, iter_39_1 in pairs(arg_39_1) do
		if iter_39_1:canBeLocked(arg_39_3) and (iter_39_1.index ~= self.index or not self.statuspool:checkStatus("addict")) then
			var_39_0[#var_39_0 + 1] = {
				id = iter_39_0,
				index = iter_39_1.index,
				hp = (iter_39_1:getAttribute("curhp") + iter_39_1:getAttribute("singlehp") * (iter_39_1:getAttribute("curhpcount") - 1)) / iter_39_1:getAttribute("hp"),
				mock_status = iter_39_1.statuspool:checkStatus("mock_status") and 1 or 0
			}
		end
	end

	if #var_39_0 <= 0 then
		return false
	end

	var_0_2.sort(var_39_0, function(arg_40_0, arg_40_1)
		if arg_40_0.mock_status ~= arg_40_1.mock_status then
			if arg_39_2 == "hp_percent_lowest" then
				return arg_40_0.mock_status > arg_40_1.mock_status
			elseif arg_39_2 == "hp_percent_highest" then
				return arg_40_0.mock_status < arg_40_1.mock_status
			end
		end

		if arg_40_0.hp == arg_40_1.hp then
			return arg_40_0.id < arg_40_1.id
		else
			return arg_40_0.hp < arg_40_1.hp
		end
	end)

	if arg_39_2 == "hp_percent_lowest" then
		if not var_0_10(arg_39_4, #var_39_0) then
			self:lockTarget(var_39_0[1].index)
		else
			local var_39_1 = {}

			for iter_39_2 = 1, arg_39_4 do
				var_0_2.insert(var_39_1, var_39_0[iter_39_2].index)
			end

			self:lockTarget(var_39_1)
		end
	elseif arg_39_2 == "hp_percent_highest" then
		if not var_0_10(arg_39_4, #var_39_0) then
			self:lockTarget(var_39_0[#var_39_0].index)
		else
			local var_39_2 = {}

			for iter_39_3 = 1, arg_39_4 do
				var_0_2.insert(var_39_2, var_39_0[#var_39_0 + 1 - iter_39_3].index)
			end

			self:lockTarget(var_39_2)
		end
	end

	return true
end

function FightCharacter:lock_target_by_range(arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	local var_41_0 = {}

	for iter_41_0, iter_41_1 in pairs(arg_41_1) do
		if iter_41_1:canBeLocked(arg_41_3) and (iter_41_1.index ~= self.index or not self.statuspool:checkStatus("addict")) then
			var_41_0[#var_41_0 + 1] = {
				id = iter_41_0,
				index = iter_41_1.index,
				range = iter_41_1:getAttribute("range"),
				mock_status = iter_41_1.statuspool:checkStatus("mock_status") and 1 or 0
			}
		end
	end

	if #var_41_0 <= 0 then
		return false
	end

	var_0_2.sort(var_41_0, function(arg_42_0, arg_42_1)
		if arg_42_0.mock_status ~= arg_42_1.mock_status then
			if arg_41_2 == "range_lowest" then
				return arg_42_0.mock_status > arg_42_1.mock_status
			elseif arg_41_2 == "range_highest" then
				return arg_42_0.mock_status < arg_42_1.mock_status
			end
		end

		if arg_42_0.range == arg_42_1.range then
			return arg_42_0.id < arg_42_1.id
		else
			return arg_42_0.range < arg_42_1.range
		end
	end)

	if arg_41_2 == "range_lowest" then
		if not var_0_10(arg_41_4, #var_41_0) then
			self:lockTarget(var_41_0[1].index)
		else
			local var_41_1 = {}

			for iter_41_2 = 1, arg_41_4 do
				var_0_2.insert(var_41_1, var_41_0[iter_41_2].index)
			end

			self:lockTarget(var_41_1)
		end
	elseif arg_41_2 == "range_highest" then
		if not var_0_10(arg_41_4, #var_41_0) then
			self:lockTarget(var_41_0[#var_41_0].index)
		else
			local var_41_2 = {}

			for iter_41_3 = 1, arg_41_4 do
				var_0_2.insert(var_41_2, var_41_0[#var_41_0 + 1 - iter_41_3].index)
			end

			self:lockTarget(var_41_2)
		end
	end

	return true
end

local function var_0_11(arg_43_0, arg_43_1)
	local var_43_0 = {}
	local var_43_1 = arg_43_0

	for iter_43_0 = 1, arg_43_1 do
		if var_43_1 >= var_0_1.random(1, arg_43_1 - iter_43_0 + 1) then
			var_0_2.insert(var_43_0, iter_43_0)

			var_43_1 = var_43_1 - 1

			if var_43_1 <= 0 then
				break
			end
		end
	end

	return var_43_0
end

function FightCharacter:lock_target_random(arg_44_1, arg_44_2, arg_44_3)
	local var_44_0 = {}

	for iter_44_0, iter_44_1 in pairs(arg_44_1) do
		if iter_44_1:canBeLocked(arg_44_2) and (iter_44_1.index ~= self.index or not self.statuspool:checkStatus("addict")) then
			var_0_2.insert(var_44_0, iter_44_1.index)
		end
	end

	if #var_44_0 <= 0 then
		return false
	end

	if #var_44_0 == 1 then
		self:lockTarget(var_44_0[1])
	elseif not var_0_10(arg_44_3, #var_44_0) then
		self:lockTarget(var_44_0[var_0_1.random(#var_44_0)])
	else
		local var_44_1 = {}

		for iter_44_2, iter_44_3 in ipairs((var_0_11(arg_44_3, #var_44_0))) do
			var_0_2.insert(var_44_1, var_44_0[iter_44_3])
		end

		self:lockTarget(var_44_1)
	end

	return true
end

function FightCharacter:lock_target_random_without_self(arg_45_1, arg_45_2, arg_45_3)
	local var_45_0 = {}

	for iter_45_0, iter_45_1 in pairs(arg_45_1) do
		if iter_45_1:canBeLocked(arg_45_2) and iter_45_1.index ~= self.index then
			var_0_2.insert(var_45_0, iter_45_1.index)
		end
	end

	if #var_45_0 <= 0 then
		return false
	end

	if #var_45_0 == 1 then
		self:lockTarget(var_45_0[1])
	elseif not var_0_10(arg_45_3, #var_45_0) then
		self:lockTarget(var_45_0[var_0_1.random(#var_45_0)])
	else
		local var_45_1 = {}

		for iter_45_2, iter_45_3 in ipairs((var_0_11(arg_45_3, #var_45_0))) do
			var_0_2.insert(var_45_1, iter_45_3)
		end

		self:lockTarget(var_45_1)
	end

	return true
end

function FightCharacter:lock_target_all(arg_46_1, arg_46_2)
	local var_46_0 = {}

	for iter_46_0, iter_46_1 in pairs(arg_46_1) do
		if iter_46_1:canBeLocked(arg_46_2) and (iter_46_1.index ~= self.index or not self.statuspool:checkStatus("addict")) then
			var_46_0[#var_46_0 + 1] = iter_46_1.index
		end
	end

	self:lockTarget(var_46_0)

	return true
end

function FightCharacter:lock_target_all_without_self(arg_47_1, arg_47_2)
	local var_47_0 = {}

	for iter_47_0, iter_47_1 in pairs(arg_47_1) do
		if iter_47_1:canBeLocked(arg_47_2) and iter_47_1.index ~= self.index then
			var_47_0[#var_47_0 + 1] = iter_47_1.index
		end
	end

	self:lockTarget(var_47_0)

	return true
end

function FightCharacter:lock_target_by_condition(arg_48_1)
	if not self._locktargetpool then
		return false
	end

	local var_48_0
	local var_48_1

	if type(arg_48_1) == "table" then
		var_48_1 = arg_48_1.condition
		var_48_0 = arg_48_1.unitorder or self:getAttackUnitOrder()
		lockcount = arg_48_1.count or 1
	else
		var_48_1 = arg_48_1
		var_48_0 = self:getAttackUnitOrder()
		lockcount = 1
	end

	if self:is_locking_teammate(self._locktargetpool) then
		var_48_0 = 999
	end

	local var_48_2 = FightManager[self._locktargetpool]

	if var_48_1 == "nearest" or var_48_1 == "farest" or var_48_1 == "middle" then
		return self:lock_target_by_distance(var_48_2, var_48_1, var_48_0, lockcount)
	elseif var_48_1 == "nearest_hatred" then
		return self:lock_target_by_hatred(var_48_2, var_48_0, lockcount)
	elseif var_48_1 == "hp_lowest" or var_48_1 == "hp_highest" then
		return self:lock_target_by_hp(var_48_2, var_48_1, var_48_0, lockcount)
	elseif var_48_1 == "hp_percent_lowest" or var_48_1 == "hp_percent_highest" then
		return self:lock_target_by_hppercent(var_48_2, var_48_1, var_48_0, lockcount)
	elseif var_48_1 == "range_lowest" or var_48_1 == "range_highest" then
		return self:lock_target_by_range(var_48_2, var_48_1, var_48_0, lockcount)
	elseif var_48_1 == "random" then
		return self:lock_target_random(var_48_2, var_48_0, lockcount)
	elseif var_48_1 == "randomwithoutself" then
		return self:lock_target_random_without_self(var_48_2, var_48_0, lockcount)
	elseif var_48_1 == "all" then
		return self:lock_target_all(var_48_2, var_48_0)
	elseif var_48_1 == "withoutself" then
		return self:lock_target_all_without_self(var_48_2, var_48_0)
	else
		return self:lock_target_normal_attr(var_48_2, var_48_1, var_48_0, lockcount)
	end

	return true
end

function FightCharacter:lock_target_in_area(arg_49_1)
	if not self._locktargetpool then
		return false
	end

	local var_49_0

	if type(arg_49_1.area) == "number" then
		var_49_0 = arg_49_1.area or self:getAttribute("range")
	end

	local var_49_1 = arg_49_1.condition
	local var_49_2 = arg_49_1.unitorder or self:getAttackUnitOrder()
	local var_49_3 = arg_49_1.count or 1
	local var_49_4 = self:filter_target_in_area(self._locktargetpool, var_49_0, var_49_0, var_49_2)

	if #var_49_4 <= 0 then
		return false
	end

	if self:is_locking_teammate(self._locktargetpool) then
		var_49_2 = 999
	end

	if var_49_1 == "nearest" or var_49_1 == "farest" or var_49_1 == "middle" then
		return self:lock_target_by_distance(var_49_4, var_49_1, var_49_2, var_49_3)
	elseif var_49_1 == "hp_lowest" or var_49_1 == "hp_highest" then
		return self:lock_target_by_hp(var_49_4, var_49_1, var_49_2, var_49_3)
	elseif var_49_1 == "hp_percent_lowest" or var_49_1 == "hp_percent_highest" then
		return self:lock_target_by_hppercent(var_49_4, var_49_1, var_49_2, var_49_3)
	elseif var_49_1 == "random" then
		return self:lock_target_random(var_49_4, var_49_2, var_49_3)
	elseif var_49_1 == "randomwithoutself" then
		return self:lock_target_random_without_self(var_49_4, var_49_2, var_49_3)
	elseif var_49_1 == "all" then
		return self:lock_target_all(var_49_4, var_49_2)
	elseif var_49_1 == "withoutself" then
		return self:lock_target_all_without_self(var_49_4, var_49_2)
	else
		return self:lock_target_normal_attr(var_49_4, var_49_1, var_49_2, var_49_3)
	end

	return true
end

function FightCharacter:lock_target_by_attr(arg_50_1)
	if not self._locktargetpool then
		return false
	end

	local var_50_0 = {}

	if arg_50_1.area then
		local var_50_1

		if type(arg_50_1.area) == "number" then
			var_50_1 = arg_50_1.area or self:getAttribute("range")
		end

		var_50_0 = self:filter_target_in_area(self._locktargetpool, var_50_1, var_50_1)
	else
		var_50_0 = FightManager[self._locktargetpool]
	end

	if #var_50_0 <= 0 then
		return false
	end

	local var_50_2 = {}

	if arg_50_1.lockcondition then
		local var_50_3 = decode_condition_str2tbl(arg_50_1.lockcondition)

		for iter_50_0, iter_50_1 in pairs(var_50_0) do
			if self:judge_condition(iter_50_1, var_50_3) then
				var_0_2.insert(var_50_2, iter_50_1)
			end
		end

		if #var_50_2 <= 0 then
			return false
		end
	else
		var_50_2 = var_50_0
	end

	local var_50_4 = arg_50_1.condition
	local var_50_5 = arg_50_1.unitorder or self:getAttackUnitOrder()
	local var_50_6 = arg_50_1.count or 1

	if self:is_locking_teammate(self._locktargetpool) then
		var_50_5 = 999
	end

	if var_50_4 == "nearest" or var_50_4 == "farest" or var_50_4 == "middle" then
		return self:lock_target_by_distance(var_50_2, var_50_4, var_50_5, var_50_6)
	elseif var_50_4 == "hp_lowest" or var_50_4 == "hp_highest" then
		return self:lock_target_by_hp(var_50_2, var_50_4, var_50_5, var_50_6)
	elseif var_50_4 == "hp_percent_lowest" or var_50_4 == "hp_percent_highest" then
		return self:lock_target_by_hppercent(var_50_2, var_50_4, var_50_5, var_50_6)
	elseif var_50_4 == "random" then
		return self:lock_target_random(var_50_2, var_50_5, var_50_6)
	elseif var_50_4 == "randomwithoutself" then
		return self:lock_target_random_without_self(var_50_2, var_50_5, var_50_6)
	elseif var_50_4 == "all" then
		return self:lock_target_all(var_50_2, var_50_5)
	elseif var_50_4 == "withoutself" then
		return self:lock_target_all_without_self(var_50_2, var_50_5)
	else
		return self:lock_target_normal_attr(var_50_2, var_50_4, var_50_5, var_50_6)
	end

	return true
end

function FightCharacter:lock_distance_by_targetpool()
	if not self._locktargetpool then
		return false
	end

	local var_51_0 = 0
	local var_51_1 = 0
	local var_51_2 = self:getStandardPosition()
	local var_51_3 = self:getAttackUnitOrder()

	for iter_51_0, iter_51_1 in pairs(FightManager[self._locktargetpool]) do
		if iter_51_1:canBeLocked((self:is_locking_teammate(self._locktargetpool) or nil) and 999) and (iter_51_1.index ~= self.index or not self.statuspool:checkStatus("addict")) then
			var_51_0 = var_51_0 + (iter_51_1:getStandardPosition() - var_51_2)
			var_51_1 = var_51_1 + 1
		end
	end

	if var_51_1 > 0 then
		local var_51_4 = var_0_1.floor(var_51_0 / var_51_1)

		self._lockdistance = var_51_0

		return true
	else
		return false
	end
end

function FightCharacter.lock_distance(arg_52_0, arg_52_1)
	arg_52_0._lockdistance = arg_52_1

	return true
end

function FightCharacter:check_target_distance(arg_53_1, arg_53_2)
	if not self:getTarget() then
		return false
	end

	if type(arg_53_1) == "string" then
		arg_53_1 = self:getAttribute(arg_53_1)
	end

	local var_53_0 = self:getStandardPosition()
	local var_53_1, var_53_2 = self:getTarget()
	local var_53_3

	if var_53_2 then
		var_53_3 = var_53_1[1]:getStandardPosition()
		arg_53_1 = arg_53_1 + var_53_1[1]:getModelWidth() / 2
	else
		var_53_3 = var_53_1:getStandardPosition()
		arg_53_1 = arg_53_1 + var_53_1:getModelWidth() / 2
	end

	return compareByoperator(arg_53_2, var_0_1.abs(var_53_0 - var_53_3), arg_53_1)
end

function FightCharacter.move_to_target(arg_54_0, arg_54_1, arg_54_2)
	print("move_to_target is deprecated")
end

function FightCharacter:move_forward()
	self._movingForward = true

	self:keepMoving()

	return true
end

function FightCharacter:move_back()
	self._movingForward = true

	self:keepMoving(nil, -1)

	return true
end

function FightCharacter:useSkill(arg_57_1)
	self:stopMoving()

	local var_57_0
	local var_57_1

	if type(arg_57_1) == "table" then
		var_57_0 = arg_57_1.id
		var_57_1 = arg_57_1.cfg
	else
		var_57_0 = arg_57_1
	end

	if not var_57_0:find("^attack") then
		if self.__cname == "MonsterCharacter" then
			if self.charactertype == "player" then
				local var_57_2 = self.model:getAttribute("ai_monster_level")

				if var_57_2 and var_57_2 >= 2 then
					self:showSkillSP(var_57_0)
				end
			else
				self:showSkillSP(var_57_0)
			end
		end

		self:addSkillcount()
		self.triggerStatus(self, "onCast", self)

		if var_57_0 ~= "xp" then
			self.triggerStatus(self, "onNormalCast", self)
		end
	else
		self.statuspool:updateStatusPoolOnAttack()
		self:addAttackcount()
		self:addAttackCDCount()
		self:addRageOnAttack()
	end

	if var_57_0 == "xp" then
		self.triggerStatus(self, "onXPCast", self)
	end

	self.skilllogic:execute(var_57_0, FightMessage.newSkillmsg(var_57_0), var_57_1)

	return true
end

function FightCharacter:wait(arg_58_1)
	self:stopMoving()
	self:playIdle()

	arg_58_1 = arg_58_1 or 0.1

	self:pushInFightWaitHandler(arg_58_1)

	return true
end

function FightCharacter:change_to_invincible()
	self.statuspool:setStatus("invincible", true)
	self.statuspool:addStatus("invincible_count", 1)

	return true
end

function FightCharacter:remove_invincible()
	self.statuspool:addStatus("invincible_count", -1)

	if self.statuspool:getStatus("invincible_count") <= 0 then
		self.statuspool:setStatus("invincible_count", 0)
		self.statuspool:setStatus("invincible", false)
	end

	return true
end

function FightCharacter:is_target_valid()
	if not self.target then
		return false
	end

	local var_61_0 = FightManager.getCharacter(self.target)
	local var_61_1 = self:getAttackUnitOrder()

	return var_61_0:canBeLocked((self:is_taget_teammate(var_61_0) or nil) and 999)
end

function FightCharacter.endai(arg_62_0)
	return true
end

function FightCharacter.random(arg_63_0, arg_63_1, arg_63_2)
	return compareByoperator(arg_63_2, var_0_1.random(arg_63_1.range), arg_63_1.num)
end

function FightCharacter:check_target_buffcount(arg_64_1, arg_64_2)
	local var_64_0

	if arg_64_1.target == "self" then
		var_64_0 = self
	else
		if not self:getTarget() then
			return false
		end

		local var_64_1, var_64_2 = self:getTarget()

		var_64_0 = var_64_2 and var_64_1[1] or var_64_1
	end

	return compareByoperator(arg_64_2, var_64_0:getBuffCount(arg_64_1.buff), arg_64_1.value)
end

function FightCharacter.check_fight_stage(arg_65_0, arg_65_1, arg_65_2)
	return compareByoperator(arg_65_2, FightManager.getFightStage(), arg_65_1)
end

function FightCharacter.check_fight_time(arg_66_0, arg_66_1, arg_66_2)
	return compareByoperator(arg_66_2, FightManager.getFightTimeStatistics(), arg_66_1)
end

function FightCharacter:switch_unit_order(arg_67_1)
	self:setUnitOrder(arg_67_1)

	return true
end

function FightCharacter:check_unit_order(arg_68_1)
	return self._unitorder == arg_68_1
end

function FightCharacter:add_anti_hitdown()
	self.statuspool:setStatus("antihitdown", true)
	self.statuspool:addStatus("antihitdown_count", 1)

	return true
end

function FightCharacter:remove_anti_hitdown()
	self.statuspool:addStatus("antihitdown_count", -1)

	if self.statuspool:getStatus("antihitdown_count") <= 0 then
		self.statuspool:setStatus("antihitdown_count", 0)
		self.statuspool:setStatus("antihitdown", false)
	end

	return true
end

function FightCharacter.set_turnback_limit(arg_71_0, arg_71_1)
	arg_71_0._lockturnbacklimit = arg_71_1

	return true
end
