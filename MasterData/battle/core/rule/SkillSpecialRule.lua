local var_0_0 = load("core.fight.FightCommon")
local var_0_1 = loadCfg("core.config.cfg.battle_extra_value_info")
local var_0_2 = {}
local var_0_3 = table.insert
local var_0_4 = loadCfg("core.config.cfg.passive_skill_info")
local var_0_5 = load("core.rule.BuffRule")
local var_0_6 = loadCfg("core.config.cfg.skill_special_effect_info")
local var_0_7 = loadCfg("core.config.cfg.buff_info")
local var_0_8 = "SkillSpecialRule"

var_0_2.TYPE = {
	ANGER_CHANGE2 = 28,
	AFTER_ROUND_START = 24,
	ATTACK = 22,
	SHIELD_DISAPPEAR = 17,
	COST_INSPIRATION = 23,
	SELF_DYING = 7,
	BEFORE_ROUND_START = 21,
	BEFORE_SKILL = 10,
	SKILL = 4,
	WILL_DAMAGE = 9,
	SKILL_FINISH = 46,
	ATTACK_COUNT = 36,
	ADD_BUFF = 8,
	EX_NORMAL_RULE = 38,
	ANGER_CHANGE = 16,
	BUFF_DOING_EFFECT = 39,
	UNITE_SKILL = 40,
	KILL = 12,
	CLEAR_BUFF = 18,
	KNIGHT_TAKE_DAMAGE = 42,
	ANGER_CHANGE3 = 48,
	ENERGY_CHANGE = 47,
	PLAYER_DYING = 33,
	DAMAGE_KNIGHT = 35,
	ALL_TREAT = 50,
	ALL_SHIELD = 51,
	ACTION = 6,
	BEFORE_UPDATE = 14,
	THRESH_CHANGE = 52,
	KNIGHT_FIGHT = 53,
	ROUND_END = 54,
	KNIGHT_DAMAGE = 26,
	SHIELD_CHANGE = 55,
	ANY_DYING = 25,
	BUFF_REMOVE = 11,
	BLOOD_POOL_CHANGE = 27,
	DAMAGE = 2,
	EFFECT_176 = 65,
	DYING = 3,
	SHIELD = 31,
	TREAT = 30,
	ALL_DEAD = 13,
	BUFF_RESIST = 56,
	ADD_BUFF_BEFORE_BINGO = 29,
	ROUND_START = 1,
	HDOT_EFFECT = 20,
	ADD_X_ANGER = 19,
	KNIGHT_DODGE = 45,
	HIT = 5,
	MARK_CHANGE = 37,
	SKILL_DAMAGE = 32,
	EFFECT_TAKES_EFFECT = 41,
	REBORN = 34,
	AFTER_SUCCUBA_SKILL = 49,
	OTHER_SKILL = 15
}
var_0_2.SP_EX_NORMAL_RULE = {
	SUSPICTION_ADD = 1
}
var_0_2.SP_TYPE = {
	ANGER_EXTRA_DOWN = 1007,
	HIT_ADD_MARK = 1011,
	HITBACK_VICTIMS = 1003,
	BUFF_TIME_UP = 1005,
	ANGER_EXTRA_UP = 1006,
	ATTR_BUFF_UP = 1008,
	HIT_ADD_BUFF = 1017,
	CONVERT_RECOVER = 1002,
	DEFENCE_HITBACK = 1012,
	CONVERT_HITBACK = 1001,
	ATK_HITBACK = 1015,
	BUFF_RATE_UP = 1004,
	ENCHANT = 2,
	ROUND_DAMAGE_LIMIT = 1010,
	SKILL_MULTIPLE = 1,
	COPY_DEBUFF = 1014,
	HIT_STEAL_BUFF = 1016,
	HIT_RECOVER_ALL = 1013,
	GET_VICTIM_ANGER = 1009
}
var_0_2.SHOW_TIME = {
	ATTACK = 1,
	HIT = 2
}
var_0_2.triggerTime = {
	[100059] = 6,
	[100037] = 4,
	[1001] = 2,
	[100024] = 8,
	[100055] = 8,
	[100020] = 4,
	[100051] = 4,
	[100047] = 4,
	[100012] = 1,
	[100043] = 1,
	[100008] = 4,
	[100039] = 6,
	[100004] = 4,
	[100035] = 6,
	[100066] = 8,
	[100031] = 11,
	[100062] = 19,
	[100027] = 9,
	[100058] = 6,
	[100023] = 1,
	[100019] = 6,
	[100050] = 4,
	[100046] = 1,
	[100011] = 4,
	[100042] = 14,
	[100007] = 4,
	[100038] = 6,
	[100069] = 21,
	[100003] = 4,
	[100065] = 11,
	[100030] = 10,
	[100061] = 18,
	[100026] = 9,
	[100022] = 7,
	[100053] = 4,
	[100018] = 2,
	[100049] = 4,
	[100014] = 1,
	[100045] = 1,
	[100010] = 4,
	[100041] = 15,
	[100006] = 5,
	[1002] = 2,
	[100068] = 8,
	[100002] = 4,
	[100033] = 2,
	[100064] = 1,
	[100029] = 5,
	[100025] = 6,
	[100056] = 16,
	[100021] = 4,
	[100052] = 4,
	[100017] = 2,
	[100048] = 4,
	[100013] = 1,
	[100044] = 1,
	[100009] = 1,
	[100040] = 13,
	[100005] = 4,
	[100036] = 6,
	[100067] = 20,
	[100001] = 4,
	[100032] = 5,
	[100063] = 1,
	[100028] = 9,
	[1003] = {
		1,
		2
	},
	[2001] = {
		var_0_2.TYPE.ROUND_START,
		var_0_2.TYPE.DYING
	},
	[2002] = {
		var_0_2.TYPE.ROUND_START,
		var_0_2.TYPE.DYING
	},
	[2003] = {
		var_0_2.TYPE.ROUND_START,
		var_0_2.TYPE.DYING
	},
	[2004] = {
		var_0_2.TYPE.ROUND_START,
		var_0_2.TYPE.DYING
	},
	[2005] = {
		var_0_2.TYPE.ROUND_START,
		var_0_2.TYPE.DYING
	},
	[2006] = {
		var_0_2.TYPE.ROUND_START,
		var_0_2.TYPE.DYING
	},
	[2007] = {
		var_0_2.TYPE.ROUND_END
	},
	[2008] = {
		var_0_2.TYPE.ROUND_END
	},
	[2009] = {
		var_0_2.TYPE.ROUND_END
	},
	[2010] = {
		var_0_2.TYPE.ROUND_END
	},
	[100015] = var_0_2.TYPE.DYING,
	[100016] = var_0_2.TYPE.DYING,
	[100034] = var_0_2.TYPE.KILL,
	[100054] = var_0_2.TYPE.KILL,
	[100057] = var_0_2.TYPE.KILL,
	[100060] = var_0_2.TYPE.SHIELD_DISAPPEAR,
	[100070] = var_0_2.TYPE.COST_INSPIRATION,
	[100071] = var_0_2.TYPE.ATTACK,
	[100072] = var_0_2.TYPE.ROUND_START,
	[100073] = var_0_2.TYPE.BEFORE_ROUND_START,
	[100074] = var_0_2.TYPE.ROUND_START,
	[100075] = var_0_2.TYPE.BUFF_REMOVE,
	[100076] = var_0_2.TYPE.AFTER_ROUND_START,
	[100077] = var_0_2.TYPE.ADD_BUFF,
	[100078] = var_0_2.TYPE.DAMAGE,
	[100079] = var_0_2.TYPE.KNIGHT_DAMAGE,
	[100080] = var_0_2.TYPE.ANY_DYING,
	[100081] = {
		var_0_2.TYPE.SKILL,
		var_0_2.TYPE.OTHER_SKILL
	},
	[100082] = var_0_2.TYPE.OTHER_SKILL,
	[100083] = var_0_2.TYPE.SKILL,
	[100084] = var_0_2.TYPE.SKILL,
	[100085] = var_0_2.TYPE.SKILL,
	[100086] = var_0_2.TYPE.DYING,
	[100087] = var_0_2.TYPE.UNITE_SKILL,
	[100088] = {
		var_0_2.TYPE.DAMAGE,
		var_0_2.TYPE.ACTION
	},
	[100089] = var_0_2.TYPE.ROUND_START,
	[100090] = var_0_2.TYPE.ADD_BUFF,
	[100091] = {
		var_0_2.TYPE.DAMAGE,
		var_0_2.TYPE.BLOOD_POOL_CHANGE
	},
	[100092] = var_0_2.TYPE.BEFORE_UPDATE,
	[100093] = var_0_2.TYPE.ADD_BUFF,
	[100094] = var_0_2.TYPE.ADD_BUFF,
	[100095] = var_0_2.TYPE.ADD_BUFF,
	[100096] = var_0_2.TYPE.SKILL,
	[100097] = var_0_2.TYPE.ADD_BUFF,
	[100098] = var_0_2.TYPE.ANGER_CHANGE2,
	[100099] = var_0_2.TYPE.KNIGHT_DAMAGE,
	[100100] = var_0_2.TYPE.ADD_BUFF,
	[100101] = var_0_2.TYPE.ADD_BUFF_BEFORE_BINGO,
	[100102] = var_0_2.TYPE.SKILL,
	[100103] = var_0_2.TYPE.ATTACK,
	[100104] = var_0_2.TYPE.TREAT,
	[100105] = var_0_2.TYPE.SHIELD,
	[100106] = {
		var_0_2.TYPE.TREAT,
		var_0_2.TYPE.SHIELD
	},
	[100107] = var_0_2.TYPE.ANGER_CHANGE2,
	[100108] = var_0_2.TYPE.ROUND_START,
	[100109] = var_0_2.TYPE.ROUND_START,
	[100110] = var_0_2.TYPE.BEFORE_UPDATE,
	[100111] = var_0_2.TYPE.ROUND_START,
	[100112] = var_0_2.TYPE.OTHER_SKILL,
	[100113] = var_0_2.TYPE.BEFORE_UPDATE,
	[100114] = var_0_2.TYPE.AFTER_ROUND_START,
	[100115] = var_0_2.TYPE.SKILL_DAMAGE,
	[100116] = var_0_2.TYPE.DYING,
	[100117] = var_0_2.TYPE.KILL,
	[100118] = var_0_2.TYPE.PLAYER_DYING,
	[100119] = var_0_2.TYPE.ROUND_START,
	[100120] = {
		var_0_2.TYPE.ANY_DYING,
		var_0_2.TYPE.REBORN
	},
	[100121] = var_0_2.TYPE.DAMAGE_KNIGHT,
	[100122] = var_0_2.TYPE.ACTION,
	[100123] = var_0_2.TYPE.ADD_BUFF,
	[100124] = var_0_2.TYPE.HIT,
	[100125] = var_0_2.TYPE.SKILL_DAMAGE,
	[100126] = var_0_2.TYPE.KILL,
	[100127] = var_0_2.TYPE.DYING,
	[100128] = var_0_2.TYPE.ATTACK_COUNT,
	[100129] = var_0_2.TYPE.TREAT,
	[100130] = var_0_2.TYPE.TREAT,
	[100131] = var_0_2.TYPE.BEFORE_UPDATE,
	[100132] = var_0_2.TYPE.DAMAGE,
	[100133] = var_0_2.TYPE.HIT,
	[100135] = var_0_2.TYPE.ACTION,
	[100136] = var_0_2.TYPE.MARK_CHANGE,
	[100137] = var_0_2.TYPE.ACTION,
	[100138] = var_0_2.TYPE.BUFF_REMOVE,
	[100139] = var_0_2.TYPE.EX_NORMAL_RULE,
	[100140] = var_0_2.TYPE.DAMAGE,
	[100141] = var_0_2.TYPE.DAMAGE,
	[100142] = var_0_2.TYPE.DAMAGE,
	[100143] = var_0_2.TYPE.BEFORE_UPDATE,
	[100144] = var_0_2.TYPE.BUFF_DOING_EFFECT,
	[100145] = var_0_2.TYPE.ADD_BUFF,
	[100146] = var_0_2.TYPE.BUFF_REMOVE,
	[100147] = var_0_2.TYPE.BUFF_DOING_EFFECT,
	[100148] = var_0_2.TYPE.MARK_CHANGE,
	[100149] = var_0_2.TYPE.ADD_BUFF,
	[100150] = var_0_2.TYPE.MARK_CHANGE,
	[100151] = var_0_2.TYPE.DYING,
	[100152] = var_0_2.TYPE.DYING,
	[100153] = var_0_2.TYPE.KNIGHT_DAMAGE,
	[100154] = var_0_2.TYPE.ADD_BUFF,
	[100155] = var_0_2.TYPE.ROUND_START,
	[100156] = {
		var_0_2.TYPE.SKILL,
		var_0_2.TYPE.OTHER_SKILL
	},
	[100157] = {
		var_0_2.TYPE.DYING
	},
	[100158] = var_0_2.TYPE.SHIELD,
	[100159] = {
		var_0_2.TYPE.ROUND_START,
		var_0_2.TYPE.HIT
	},
	[100160] = var_0_2.TYPE.SHIELD_DISAPPEAR,
	[100161] = var_0_2.TYPE.SHIELD,
	[100162] = var_0_2.TYPE.UNITE_SKILL,
	[100163] = var_0_2.TYPE.SKILL,
	[100164] = var_0_2.TYPE.ROUND_START,
	[100165] = {
		var_0_2.TYPE.BUFF_DOING_EFFECT,
		var_0_2.TYPE.EFFECT_TAKES_EFFECT
	},
	[100166] = var_0_2.TYPE.KNIGHT_TAKE_DAMAGE,
	[100167] = var_0_2.TYPE.ADD_BUFF,
	[100168] = var_0_2.TYPE.ADD_BUFF,
	[100169] = var_0_2.TYPE.BUFF_REMOVE,
	[100170] = var_0_2.TYPE.MARK_CHANGE,
	[100171] = var_0_2.TYPE.BUFF_REMOVE,
	[100172] = var_0_2.TYPE.KNIGHT_TAKE_DAMAGE,
	[100173] = var_0_2.TYPE.ACTION,
	[100174] = var_0_2.TYPE.ACTION,
	[100175] = var_0_2.TYPE.SHIELD_DISAPPEAR,
	[100176] = var_0_2.TYPE.KNIGHT_DODGE,
	[100177] = var_0_2.TYPE.MARK_CHANGE,
	[100178] = var_0_2.TYPE.SKILL,
	[100179] = var_0_2.TYPE.KNIGHT_DAMAGE,
	[100180] = var_0_2.TYPE.BUFF_REMOVE,
	[100181] = var_0_2.TYPE.SKILL_FINISH,
	[100182] = var_0_2.TYPE.SKILL_FINISH,
	[100183] = var_0_2.TYPE.ADD_BUFF,
	[100184] = var_0_2.TYPE.SKILL,
	[100185] = var_0_2.TYPE.SKILL_FINISH,
	[100186] = var_0_2.TYPE.ENERGY_CHANGE,
	[100187] = var_0_2.TYPE.ANGER_CHANGE3,
	[100188] = var_0_2.TYPE.DAMAGE_KNIGHT,
	[100189] = var_0_2.TYPE.ADD_BUFF,
	[100190] = var_0_2.TYPE.DYING,
	[100191] = var_0_2.TYPE.MARK_CHANGE,
	[100192] = var_0_2.TYPE.MARK_CHANGE,
	[100193] = var_0_2.TYPE.ADD_BUFF,
	[100194] = var_0_2.TYPE.DAMAGE_KNIGHT,
	[100195] = {
		var_0_2.TYPE.ALL_TREAT,
		var_0_2.TYPE.ALL_SHIELD
	},
	[100196] = var_0_2.TYPE.AFTER_SUCCUBA_SKILL,
	[100197] = var_0_2.TYPE.ADD_BUFF,
	[100198] = var_0_2.TYPE.ATTACK_COUNT,
	[100199] = var_0_2.TYPE.MARK_CHANGE,
	[100200] = var_0_2.TYPE.OTHER_SKILL,
	[100201] = var_0_2.TYPE.BUFF_REMOVE,
	[100202] = var_0_2.TYPE.BUFF_REMOVE,
	[100203] = var_0_2.TYPE.ADD_BUFF,
	[100204] = {
		var_0_2.TYPE.BUFF_REMOVE,
		var_0_2.TYPE.ROUND_START,
		var_0_2.TYPE.DYING
	},
	[100205] = var_0_2.TYPE.OTHER_SKILL,
	[100206] = var_0_2.TYPE.DAMAGE_KNIGHT,
	[100207] = var_0_2.TYPE.DYING,
	[100208] = var_0_2.TYPE.HIT,
	[100209] = var_0_2.TYPE.ACTION,
	[100210] = var_0_2.TYPE.DAMAGE_KNIGHT,
	[100211] = var_0_2.TYPE.DAMAGE_KNIGHT,
	[100212] = var_0_2.TYPE.DAMAGE_KNIGHT,
	[100213] = var_0_2.TYPE.DAMAGE_KNIGHT,
	[100214] = var_0_2.TYPE.HIT,
	[100215] = var_0_2.TYPE.ANY_DYING,
	[100216] = var_0_2.TYPE.ANY_DYING,
	[100217] = var_0_2.TYPE.ANY_DYING,
	[100218] = var_0_2.TYPE.ROUND_START,
	[100219] = var_0_2.TYPE.ADD_BUFF,
	[200000] = var_0_2.TYPE.TREAT,
	[200001] = var_0_2.TYPE.DAMAGE_KNIGHT,
	[200002] = var_0_2.TYPE.KNIGHT_FIGHT,
	[200003] = var_0_2.TYPE.DAMAGE_KNIGHT,
	[200004] = var_0_2.TYPE.THRESH_CHANGE,
	[100220] = var_0_2.TYPE.KNIGHT_FIGHT,
	[100221] = var_0_2.TYPE.KNIGHT_TAKE_DAMAGE,
	[100222] = var_0_2.TYPE.ROUND_END,
	[100223] = var_0_2.TYPE.DYING,
	[100224] = var_0_2.TYPE.KNIGHT_TAKE_DAMAGE,
	[100225] = var_0_2.TYPE.ACTION,
	[100226] = var_0_2.TYPE.ACTION,
	[100227] = var_0_2.TYPE.HIT,
	[100228] = var_0_2.TYPE.DAMAGE_KNIGHT,
	[100229] = var_0_2.TYPE.ADD_BUFF,
	[100230] = var_0_2.TYPE.ATTACK,
	[100231] = var_0_2.TYPE.KNIGHT_FIGHT,
	[100232] = var_0_2.TYPE.KNIGHT_FIGHT,
	[100233] = var_0_2.TYPE.KNIGHT_FIGHT,
	[100234] = var_0_2.TYPE.BUFF_REMOVE,
	[100235] = var_0_2.TYPE.DAMAGE_KNIGHT,
	[100236] = var_0_2.TYPE.MARK_CHANGE,
	[100237] = var_0_2.TYPE.BUFF_DOING_EFFECT,
	[200006] = var_0_2.TYPE.ROUND_END,
	[200007] = var_0_2.TYPE.ACTION,
	[100240] = var_0_2.TYPE.KNIGHT_FIGHT,
	[100241] = var_0_2.TYPE.DAMAGE,
	[100242] = var_0_2.TYPE.DAMAGE_KNIGHT,
	[100243] = var_0_2.TYPE.KNIGHT_DAMAGE,
	[100244] = var_0_2.TYPE.ADD_BUFF,
	[100250] = var_0_2.TYPE.ALL_TREAT,
	[100251] = var_0_2.TYPE.ADD_BUFF,
	[100252] = var_0_2.TYPE.THRESH_CHANGE,
	[100255] = var_0_2.TYPE.KNIGHT_TAKE_DAMAGE,
	[100256] = var_0_2.TYPE.ADD_BUFF,
	[100257] = var_0_2.TYPE.SHIELD,
	[100258] = var_0_2.TYPE.KNIGHT_DODGE,
	[100259] = var_0_2.TYPE.ADD_BUFF,
	[100260] = var_0_2.TYPE.ADD_BUFF,
	[100261] = var_0_2.TYPE.KNIGHT_DODGE,
	[100262] = var_0_2.TYPE.BUFF_DOING_EFFECT,
	[100263] = var_0_2.TYPE.KILL,
	[100264] = var_0_2.TYPE.SHIELD_CHANGE,
	[100265] = {
		var_0_2.TYPE.ROUND_END,
		var_0_2.TYPE.UNITE_SKILL
	},
	[100266] = {
		var_0_2.TYPE.ROUND_END,
		var_0_2.TYPE.UNITE_SKILL
	},
	[100267] = var_0_2.TYPE.AFTER_SUCCUBA_SKILL,
	[100268] = var_0_2.TYPE.ADD_BUFF,
	[100269] = var_0_2.TYPE.EFFECT_176,
	[100270] = var_0_2.TYPE.ROUND_END,
	[100271] = var_0_2.TYPE.DAMAGE_KNIGHT,
	[100272] = var_0_2.TYPE.KNIGHT_DODGE,
	[100273] = var_0_2.TYPE.KNIGHT_DODGE,
	[100274] = var_0_2.TYPE.SKILL,
	[100275] = var_0_2.TYPE.BUFF_DOING_EFFECT,
	[100276] = var_0_2.TYPE.BEFORE_UPDATE,
	[100277] = var_0_2.TYPE.ACTION,
	[100278] = var_0_2.TYPE.SKILL,
	[100279] = {
		var_0_2.TYPE.UNITE_SKILL,
		var_0_2.TYPE.ENERGY_CHANGE,
		var_0_2.TYPE.THRESH_CHANGE
	},
	[100280] = var_0_2.TYPE.ADD_BUFF,
	[100281] = var_0_2.TYPE.ANY_DYING,
	[100282] = var_0_2.TYPE.ADD_BUFF,
	[100283] = var_0_2.TYPE.SKILL_FINISH,
	[100284] = var_0_2.TYPE.BUFF_RESIST,
	[100285] = var_0_2.TYPE.DYING,
	[100286] = var_0_2.TYPE.UNITE_SKILL
}
var_0_2.disable = false
var_0_2.globalTriggerTimes = {}
var_0_2.globalTriggerRound = {}

function var_0_2:_addRule(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = {
		info = arg_1_2
	}

	var_1_0.count = 0
	var_1_0.count2 = 0
	var_1_0.round = 0
	var_1_0.owner = arg_1_4
	var_1_0.check = var_0_2.getCheckFunc(arg_1_2, arg_1_1, arg_1_3, arg_1_4)
	var_1_0.identity = arg_1_3

	function var_1_0:execute()
		if self.owner and not self.owner.isPlayer and self.owner:doBuff(var_0_5.TYPE.HIDE_PASSIVE_SKILL, false, self.info.id) then
			return false
		end

		local var_2_0 = self.info.trigger_maxtime_type

		if self.info.trigger_maxtime_type == 4 and self.count2 >= self.info.trigger_maxtime_value_2 then
			return false
		end

		local var_2_1 = "team_" .. arg_1_3 .. "_" .. arg_1_2.id

		if arg_1_4 then
			var_2_1 = "knight_" .. arg_1_4.serialId .. "_" .. arg_1_2.id
		end

		if var_2_0 == 3 then
			self.count = var_0_2.globalTriggerTimes[var_2_1] or 0
		end

		local var_2_2 = "team_" .. arg_1_3 .. "_" .. arg_1_2.id

		if var_2_0 == 6 or var_2_0 == 7 then
			self.count = var_0_2.globalTriggerTimes[var_2_2] or 0
		end

		local var_2_3 = arg_1_1:getRoundCount()

		if var_2_3 > self.round and (var_2_0 == 2 or var_2_0 == 4) then
			self.count = 0
			self.round = var_2_3
		end

		if (var_0_2.globalTriggerRound[var_2_2] or 0) < var_2_3 and var_2_0 == 6 then
			self.count = 0
			var_0_2.globalTriggerRound[var_2_2] = var_2_3
		end

		if (var_2_0 == 0 or self.count < self.info.trigger_maxtime_value) and self:bingo() then
			self.count = self.count + 1

			if var_2_0 == 3 then
				var_0_2.globalTriggerTimes[var_2_1] = self.count
			elseif var_2_0 == 7 then
				var_0_2.globalTriggerTimes[var_2_2] = self.count
			elseif var_2_0 == 6 then
				var_0_2.globalTriggerTimes[var_2_2] = self.count
			elseif var_2_0 == 4 then
				self.count2 = self.count2 + 1
			end

			return true
		end

		return false
	end

	function var_1_0.reset(arg_3_0)
		arg_3_0.count = 0
		arg_3_0.round = 0
	end

	function var_1_0:bingo()
		local var_4_0 = self.info.trigger_prob

		if self.info.prop_formula == 0 then
			return arg_1_1:bingo(var_4_0)
		end

		if self.info.prop_formula == 1 then
			return arg_1_1:bingo(var_4_0 - self.count * self.info.prop_formula_value_1)
		elseif self.info.prop_formula == 2 then
			local var_4_1 = 0

			for iter_4_0, iter_4_1 in ipairs((arg_1_1:getBattleData():getKnightList(3 - arg_1_3))) do
				if iter_4_1:hasBuffByEffectType(var_0_5.EFFECT_TYPE.BURNING) then
					var_4_1 = var_4_1 + 1
				end
			end

			var_4_0 = var_4_0 + var_4_1 * self.info.prop_formula_value_1

			return arg_1_1:bingo(var_4_0)
		elseif self.info.prop_formula == 3 then
			if self.owner.classical == self.info.prop_formula_value_1 then
				var_4_0 = var_4_0 * 2
			end

			return arg_1_1:bingo(var_4_0)
		end

		return false
	end

	if arg_1_2.passive_skill_type == 4 then
		local var_1_1 = var_0_6.get(arg_1_2.passive_skill_value)

		var_1_0.spEffectInfo = var_1_1
		var_1_0.spEffectRule = var_0_2["_initSpEffectType" .. var_1_1.special_skill_type]({
			knight = arg_1_4,
			identity = arg_1_3,
			spEffectInfo = var_1_1,
			battleField = arg_1_1
		})
	end

	local var_1_2 = var_0_2.triggerTime[arg_1_2.trigger_type] or 0

	if type(var_1_2) == "table" then
		for iter_1_0, iter_1_1 in ipairs(var_1_2) do
			self[iter_1_1] = self[iter_1_1] or {}

			var_0_3(self[iter_1_1], var_1_0)
		end
	else
		self[var_1_2] = self[var_1_2] or {}

		var_0_3(self[var_1_2], var_1_0)
	end
end

function var_0_2.addRule(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if arg_5_4 > 0 then
		local var_5_0 = var_0_4.get(arg_5_4)

		if g and g.core and BATTLE_PLATFORM == CLIENT and not var_5_0 then
			g.core.platform.BuglyProxy:error("值班的同学请注意，存在技能id配置缺失情况，请立刻在群里同步，此问题会导致战斗无法进行，请严肃处理，passive_skillId为" .. arg_5_4)
		end

		assert(var_5_0 ~= nil, " not get passive_skill_info:" .. arg_5_4)
		var_0_2._addRule(arg_5_0, arg_5_1, var_5_0.toObject(), arg_5_2, arg_5_3)
	end
end

function var_0_2.sortRules(arg_6_0)
	local var_6_0 = loadCfg("core.config.cfg.skill_info")

	for iter_6_0, iter_6_1 in pairs(arg_6_0) do
		local var_6_1 = {}

		for iter_6_2, iter_6_3 in ipairs(iter_6_1) do
			local var_6_2 = 0

			if (iter_6_3.info.passive_skill_type == 1 or iter_6_3.info.passive_skill_type == 3) and var_6_0.get(iter_6_3.info.passive_skill_value).skill_type == 7 then
				var_6_2 = 1
			end

			if iter_6_3.info.belong_to_type == 5 then
				var_6_1[iter_6_3.info.id] = 2
			end
		end

		table.sort(iter_6_1, function(arg_7_0, arg_7_1)
			if arg_7_0.info.passive_quality ~= arg_7_1.info.passive_quality then
				return arg_7_0.info.passive_quality > arg_7_1.info.passive_quality
			end

			local var_7_0 = var_6_1[arg_7_0.info.id] or 0
			local var_7_1 = var_6_1[arg_7_1.info.id] or 0

			if var_7_0 ~= var_7_1 then
				return var_7_1 < var_7_0
			else
				return arg_7_0.info.id < arg_7_1.info.id
			end
		end)
	end
end

function var_0_2:initRule(arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = {}

	if self and #self > 0 then
		for iter_8_0 = 1, #self do
			var_0_2.addRule(var_8_0, arg_8_2, arg_8_1, arg_8_3, self[iter_8_0])
		end
	end

	var_0_2.sortRules(var_8_0)

	return var_8_0
end

function var_0_2:isTrigger(arg_9_1)
	local var_9_0 = var_0_2.triggerTime[self.trigger_type] or 0

	if type(var_9_0) == "table" then
		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			if iter_9_1 == arg_9_1 then
				return true
			end
		end
	elseif var_9_0 == arg_9_1 then
		return true
	end

	return false
end

function var_0_2:getCheckFunc(arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_1:getBattleData()
	local var_10_1 = var_10_0:getKnights()
	local var_10_2 = 3 - arg_10_2
	local var_10_3 = self.trigger_type

	if self.trigger_type == 1001 then
		return function(arg_11_0)
			return math.floor(arg_10_3.baseInfo.INITIAL_HP * 1000 / arg_10_3.originInfo.INITIAL_HP) >= arg_11_0.info.trigger_type_value
		end
	elseif self.trigger_type == 1002 then
		return function(arg_12_0)
			return math.floor(arg_10_3.baseInfo.INITIAL_HP * 1000 / arg_10_3.originInfo.INITIAL_HP) <= arg_12_0.info.trigger_type_value
		end
	elseif self.trigger_type == 1003 then
		return function(arg_13_0)
			return math.floor(arg_10_3.baseInfo.INITIAL_HP * 1000 / arg_10_3.originInfo.INITIAL_HP) >= arg_13_0.info.trigger_type_value
		end
	elseif self.trigger_type == 2001 then
		return function(arg_14_0)
			return var_10_1:getAliveKnightCount(var_10_2) <= arg_14_0.info.trigger_type_value
		end
	elseif self.trigger_type == 2002 then
		return function(arg_15_0)
			return var_10_1:getDeathKnightCount(arg_10_2) <= arg_15_0.info.trigger_type_value
		end
	elseif self.trigger_type == 2003 then
		return function(arg_16_0)
			return var_10_1:getDeathKnightCount(arg_10_2) >= arg_16_0.info.trigger_type_value
		end
	elseif self.trigger_type == 2004 then
		return function(arg_17_0)
			return var_10_1:getAliveKnightCount(arg_10_2) <= var_10_1:getAliveKnightCount(var_10_2)
		end
	elseif self.trigger_type == 2005 then
		return function(arg_18_0)
			return var_10_1:getAliveKnightCount(arg_10_2) >= var_10_1:getAliveKnightCount(var_10_2)
		end
	elseif self.trigger_type == 2006 then
		return function(arg_19_0)
			for iter_19_0 = 1, 3 do
				local var_19_0 = var_10_1:getKnightByIdAndPos(arg_10_2, iter_19_0)

				if var_19_0 and not var_19_0.isDead then
					return true
				end
			end

			return false
		end
	elseif self.trigger_type == 2007 then
		return function(arg_20_0)
			if arg_10_1:getRoundCount() == arg_20_0.info.trigger_type_value then
				return var_10_1:getAliveKnightCount(arg_10_2) < var_10_1:getAliveKnightCount(var_10_2)
			end
		end
	elseif self.trigger_type == 2008 then
		return function(arg_21_0)
			if arg_10_1:getRoundCount() == arg_21_0.info.trigger_type_value then
				return var_10_1:getAliveKnightCount(arg_10_2) > var_10_1:getAliveKnightCount(var_10_2)
			end
		end
	elseif self.trigger_type == 2009 then
		return function(arg_22_0)
			if arg_10_1:getRoundCount() == arg_22_0.info.trigger_type_value then
				return var_10_1:getAliveKnightCount(arg_10_2) <= var_10_1:getAliveKnightCount(var_10_2)
			end
		end
	elseif self.trigger_type == 2010 then
		return function(arg_23_0)
			if arg_10_1:getRoundCount() == arg_23_0.info.trigger_type_value then
				return var_10_1:getAliveKnightCount(arg_10_2) >= var_10_1:getAliveKnightCount(var_10_2)
			end
		end
	elseif self.trigger_type == 100001 then
		return function(arg_24_0, arg_24_1)
			if not arg_24_1 then
				return false
			end

			return arg_24_1.cfg.skill_type == 1
		end
	elseif self.trigger_type == 100002 then
		return function(arg_25_0, arg_25_1)
			if not arg_25_1 then
				return false
			end

			return arg_25_1.cfg.skill_type == 2
		end
	elseif self.trigger_type == 100003 then
		return function(arg_26_0, arg_26_1)
			if not arg_26_1 then
				return false
			end

			return arg_26_1.cfg.skill_affect_type_1 == 1
		end
	elseif self.trigger_type == 100004 then
		return function(arg_27_0, arg_27_1)
			if not arg_27_1 then
				return false
			end

			return true
		end
	elseif self.trigger_type == 100005 then
		return function(arg_28_0, arg_28_1)
			if not arg_28_1 then
				return false
			end

			for iter_28_0, iter_28_1 in ipairs(arg_28_1.result) do
				if iter_28_1.crit then
					return true
				end
			end

			return false
		end
	elseif self.trigger_type == 100006 then
		return function(arg_29_0, arg_29_1)
			if not arg_29_1 then
				return false
			end

			return arg_29_1.result.miss
		end
	elseif self.trigger_type == 100007 then
		return function(arg_30_0)
			return math.floor(arg_10_3.baseInfo.INITIAL_HP * 1000 / arg_10_3.originInfo.INITIAL_HP) <= arg_30_0.info.trigger_type_value
		end
	elseif self.trigger_type == 100008 then
		return function(arg_31_0)
			return math.floor(arg_10_3.baseInfo.INITIAL_HP * 1000 / arg_10_3.originInfo.INITIAL_HP) >= arg_31_0.info.trigger_type_value
		end
	elseif self.trigger_type == 100009 then
		return function(arg_32_0)
			return arg_10_1:getRoundCount() == arg_32_0.info.trigger_type_value
		end
	elseif self.trigger_type == 100010 then
		return function(arg_33_0, arg_33_1)
			if not arg_33_1 then
				return false
			end

			return var_10_1:getAliveKnightCount(arg_10_2) <= var_10_1:getAliveKnightCount(var_10_2)
		end
	elseif self.trigger_type == 100011 then
		return function(arg_34_0, arg_34_1)
			if not arg_34_1 then
				return false
			end

			return var_10_1:getAliveKnightCount(arg_10_2) >= var_10_1:getAliveKnightCount(var_10_2) and arg_34_1.cfg.skill_affect_type_1 == 1
		end
	elseif self.trigger_type == 100012 then
		return function(arg_35_0)
			return arg_10_1:getRoundCount() > 1
		end
	elseif self.trigger_type == 100013 then
		return function(arg_36_0)
			return arg_10_1:getRoundCount() % 2 == 0
		end
	elseif self.trigger_type == 100014 then
		return function(arg_37_0)
			local var_37_0 = arg_10_1:getRoundCount()

			return var_37_0 > 1 and var_37_0 % 2 == 1
		end
	elseif self.trigger_type == 100015 then
		return function(arg_38_0, arg_38_1)
			return arg_38_1.victim.identity == arg_10_2
		end
	elseif self.trigger_type == 100016 then
		return function(arg_39_0, arg_39_1)
			return arg_39_1.victim.identity ~= arg_10_2
		end
	elseif self.trigger_type == 100017 then
		return function(arg_40_0, arg_40_1)
			return var_10_0:getHpPer(arg_10_2) < arg_40_0.info.trigger_type_value
		end
	elseif self.trigger_type == 100018 then
		return function(arg_41_0, arg_41_1)
			if arg_41_1 == var_10_2 then
				return var_10_0:getHpPer(var_10_2) < arg_41_0.info.trigger_type_value
			end

			return false
		end
	elseif self.trigger_type == 100019 then
		return function(arg_42_0)
			if arg_10_1:getActionCount(arg_10_2) == arg_42_0.info.trigger_type_value then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100020 then
		return function(arg_43_0)
			return arg_10_3.baseInfo.INITIAL_ANGER >= arg_43_0.info.trigger_type_value
		end
	elseif self.trigger_type == 100021 then
		return function(arg_44_0)
			return arg_10_3.baseInfo.INITIAL_ANGER < arg_44_0.info.trigger_type_value
		end
	elseif self.trigger_type == 100022 then
		return function(arg_45_0)
			return true
		end
	elseif self.trigger_type == 100023 then
		return function(arg_46_0)
			return arg_10_1:getRoundCount() - 1 == arg_46_0.info.trigger_type_value
		end
	elseif self.trigger_type == 100024 then
		return function(arg_47_0, arg_47_1)
			local var_47_0 = loadCfg("core.config.cfg.buff_info")

			for iter_47_0, iter_47_1 in ipairs(arg_47_1) do
				local var_47_1 = var_47_0.get(iter_47_1.buffId)

				if iter_47_1.victim.identity == arg_10_2 and (var_47_1.buff_type == var_0_5.TYPE.ACT_LIMIT or var_47_1.buff_type == var_0_5.TYPE.SKILL_CHOOSE) then
					return true
				end
			end

			return false
		end
	elseif self.trigger_type == 100025 then
		return function(arg_48_0)
			return true
		end
	elseif self.trigger_type == 100026 then
		return function(arg_49_0)
			return true
		end
	elseif self.trigger_type == 100027 then
		return function(arg_50_0, arg_50_1)
			if not arg_50_1.attacker.isPlayer and arg_50_1.attacker.knightCfg.attack_type == 1 then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100028 then
		return function(arg_51_0, arg_51_1)
			if not arg_51_1.attacker.isPlayer and arg_51_1.attacker.knightCfg.attack_type == 2 then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100029 then
		return function(arg_52_0, arg_52_1)
			if not arg_52_1 then
				return false
			end

			if not arg_52_1.attacker then
				return false
			end

			local var_52_0 = arg_52_1.attacker

			if arg_52_1.attacker.isPlayer then
				return false
			end

			if arg_10_1:isExtraAction() then
				return false
			end

			if arg_52_1.isPassive then
				return false
			end

			if arg_52_1.result.affectType ~= 1 then
				return false
			end

			local var_52_1 = var_52_0:doBuff(var_0_5.TYPE.TAUNT)

			if var_52_1 and var_52_1.serialId == arg_10_3.serialId then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100030 then
		return function(arg_53_0)
			return true
		end
	elseif self.trigger_type == 100031 then
		return function(arg_54_0, arg_54_1)
			for iter_54_0, iter_54_1 in ipairs(arg_54_1) do
				if iter_54_1.victim.identity == arg_10_2 and iter_54_1.buffCfg.id == arg_54_0.info.trigger_type_value then
					return true
				end
			end

			return false
		end
	elseif self.trigger_type == 100032 then
		return function(arg_55_0, arg_55_1)
			if arg_55_1.result.affectType == 1 and arg_55_1.result.damage > 0 and not arg_55_1.result.hpLink then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100033 then
		return function(arg_56_0, arg_56_1)
			return (arg_56_1 or 0) >= math.floor(arg_10_3.originInfo.INITIAL_HP * arg_56_0.info.trigger_type_value / 1000)
		end
	elseif self.trigger_type == 100034 then
		return function(arg_57_0, arg_57_1)
			local var_57_0 = arg_57_1.attackId

			if arg_57_1.attacker.isPlayer then
				return var_57_0 == arg_57_0.info.trigger_type_value and arg_57_1.attacker.identity == arg_10_2
			else
				return var_57_0 == arg_57_0.info.trigger_type_value and arg_57_1.attacker.serialId == arg_10_3.serialId
			end
		end
	elseif self.trigger_type == 100035 then
		return function(arg_58_0, arg_58_1)
			return arg_58_1.identity == arg_10_2
		end
	elseif self.trigger_type == 100036 then
		return function(arg_59_0, arg_59_1)
			return arg_59_1.identity == var_10_2
		end
	elseif self.trigger_type == 100037 then
		return function(arg_60_0, arg_60_1)
			if not arg_60_1 then
				return false
			end

			return arg_60_1.cfg.skill_type == 12
		end
	elseif self.trigger_type == 100038 then
		return function(arg_61_0, arg_61_1)
			if arg_61_1.identity ~= arg_10_2 then
				return false
			end

			if arg_10_1:getRoundCount() > 2 then
				return false
			end

			for iter_61_0, iter_61_1 in ipairs((arg_10_1:getBattleData():getKnightList(arg_10_2))) do
				for iter_61_2, iter_61_3 in ipairs((iter_61_1:getBuffs())) do
					if iter_61_3.buffCfg.buff_control_type == 1 then
						return true
					end
				end
			end

			return false
		end
	elseif self.trigger_type == 100039 then
		return function(arg_62_0, arg_62_1)
			if arg_10_1:isExtraAction() then
				return false
			end

			local var_62_0 = arg_62_1.attacker

			if not arg_62_1.attacker then
				return false
			end

			return arg_10_3.serialId == var_62_0.serialId
		end
	elseif self.trigger_type == 100040 then
		return function(arg_63_0)
			return true
		end
	elseif self.trigger_type == 100041 then
		return function(arg_64_0, arg_64_1)
			if arg_64_1.attacker.identity == arg_10_3.identity and arg_64_1.attacker.serialId ~= arg_10_3.serialId and arg_64_1.cfg.skill_type == 2 then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100042 then
		return function()
			return true
		end
	elseif self.trigger_type == 100043 then
		return function(arg_66_0)
			if arg_10_1:getRoundCount() == 1 then
				local var_66_0 = 0

				for iter_66_0, iter_66_1 in ipairs((arg_10_1:getBattleData():getKnightList(arg_10_2))) do
					if iter_66_1.knightCfg.group == 1 then
						var_66_0 = var_66_0 + 1
					end

					for iter_66_2, iter_66_3 in pairs(iter_66_1.spRules or {}) do
						for iter_66_4, iter_66_5 in ipairs(iter_66_3) do
							if iter_66_5.info.trigger_type == var_10_3 and iter_66_5.info.trigger_type_value == arg_66_0.info.trigger_type_value and (iter_66_5.info.id > self.id or iter_66_1.serialId < arg_10_3.serialId and iter_66_5.info.id == self.id) then
								return false
							end
						end
					end
				end

				return var_66_0 >= arg_66_0.info.trigger_type_value
			end

			return false
		end
	elseif self.trigger_type == 100044 then
		return function(arg_67_0)
			if arg_10_1:getRoundCount() == 1 then
				local var_67_0 = 0

				for iter_67_0, iter_67_1 in ipairs((arg_10_1:getBattleData():getKnightList(arg_10_2))) do
					if iter_67_1.knightCfg.group == 2 then
						var_67_0 = var_67_0 + 1
					end

					for iter_67_2, iter_67_3 in pairs(iter_67_1.spRules or {}) do
						for iter_67_4, iter_67_5 in ipairs(iter_67_3) do
							if iter_67_5.info.trigger_type == var_10_3 and iter_67_5.info.trigger_type_value == arg_67_0.info.trigger_type_value and (iter_67_5.info.id > self.id or iter_67_1.serialId < arg_10_3.serialId and iter_67_5.info.id == self.id) then
								return false
							end
						end
					end
				end

				return var_67_0 >= arg_67_0.info.trigger_type_value
			end

			return false
		end
	elseif self.trigger_type == 100045 then
		return function(arg_68_0)
			if arg_10_1:getRoundCount() == 1 then
				local var_68_0 = 0

				for iter_68_0, iter_68_1 in ipairs((arg_10_1:getBattleData():getKnightList(arg_10_2))) do
					if iter_68_1.knightCfg.group == 3 then
						var_68_0 = var_68_0 + 1
					end

					for iter_68_2, iter_68_3 in pairs(iter_68_1.spRules or {}) do
						for iter_68_4, iter_68_5 in ipairs(iter_68_3) do
							if iter_68_5.info.trigger_type == var_10_3 and iter_68_5.info.trigger_type_value == arg_68_0.info.trigger_type_value and (iter_68_5.info.id > self.id or iter_68_1.serialId < arg_10_3.serialId and iter_68_5.info.id == self.id) then
								return false
							end
						end
					end
				end

				return var_68_0 >= arg_68_0.info.trigger_type_value
			end

			return false
		end
	elseif self.trigger_type == 100046 then
		return function(arg_69_0)
			if arg_10_1:getRoundCount() == 1 then
				local var_69_0 = 0

				for iter_69_0, iter_69_1 in ipairs((arg_10_1:getBattleData():getKnightList(arg_10_2))) do
					if iter_69_1.knightCfg.group == 4 then
						var_69_0 = var_69_0 + 1
					end

					for iter_69_2, iter_69_3 in pairs(iter_69_1.spRules or {}) do
						for iter_69_4, iter_69_5 in ipairs(iter_69_3) do
							if iter_69_5.info.trigger_type == var_10_3 and iter_69_5.info.trigger_type_value == arg_69_0.info.trigger_type_value and (iter_69_5.info.id > self.id or iter_69_1.serialId < arg_10_3.serialId and iter_69_5.info.id == self.id) then
								return false
							end
						end
					end
				end

				return var_69_0 >= arg_69_0.info.trigger_type_value
			end

			return false
		end
	elseif self.trigger_type == 100047 then
		return function(arg_70_0, arg_70_1)
			if not arg_70_1 then
				return false
			end

			if arg_70_1.attacker and arg_70_1.attacker.serialId == arg_10_3.serialId then
				return arg_70_1.cfg.skill_type == 1
			end

			return false
		end
	elseif self.trigger_type == 100048 then
		return function(arg_71_0, arg_71_1)
			if not arg_71_1 then
				return false
			end

			if arg_71_1.attacker and arg_71_1.attacker.serialId == arg_10_3.serialId then
				return arg_71_1.cfg.skill_type == 2
			end

			return false
		end
	elseif self.trigger_type == 100049 then
		return function(arg_72_0, arg_72_1)
			if not arg_72_1 then
				return false
			end

			if arg_72_1.attacker and arg_72_1.attacker.serialId == arg_10_3.serialId then
				return arg_72_1.cfg.skill_type == 12
			end

			return false
		end
	elseif self.trigger_type == 100050 then
		return function(arg_73_0, arg_73_1)
			if not arg_73_1 then
				return false
			end

			if arg_73_1.attacker and arg_73_1.attacker.serialId == arg_10_3.serialId then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100051 then
		return function(arg_74_0, arg_74_1)
			if not arg_74_1 then
				return false
			end

			if arg_74_1.result and arg_74_1.result[1] and arg_74_1.result[1].affectType == 1 and #arg_74_1.result < 3 then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100052 then
		return function(arg_75_0, arg_75_1)
			if not arg_75_1 then
				return false
			end

			if arg_75_1.result and arg_75_1.result[1] and arg_75_1.result[1].affectType == 1 and #arg_75_1.result > 3 then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100053 then
		return function(arg_76_0, arg_76_1)
			if not arg_76_1 then
				return false
			end

			return arg_76_1.cfg.skill_type == 12 or arg_76_1.cfg.skill_type == 2
		end
	elseif self.trigger_type == 100054 then
		return function(arg_77_0, arg_77_1)
			if arg_77_1.attackId then
				local var_77_0 = loadCfg("core.config.cfg.skill_info").get(arg_77_1.attackId)

				if var_77_0 and (var_77_0.skill_type == 2 or var_77_0.skill_type == 12) then
					return true
				end
			end

			return false
		end
	elseif self.trigger_type == 100055 then
		return function(arg_78_0, arg_78_1)
			return true
		end
	elseif self.trigger_type == 100056 then
		return function(arg_79_0, arg_79_1)
			return true
		end
	elseif self.trigger_type == 100057 then
		return function(arg_80_0, arg_80_1)
			return true
		end
	elseif self.trigger_type == 100058 then
		return function(arg_81_0, arg_81_1)
			if arg_10_1:isExtraAction() then
				return false
			end

			return arg_81_1.identity == arg_10_2
		end
	elseif self.trigger_type == 100059 then
		return function(arg_82_0, arg_82_1)
			if arg_82_1.identity ~= arg_10_2 then
				return false
			end

			if arg_10_1:getRoundCount() > arg_82_0.info.trigger_type_value then
				return false
			end

			return true
		end
	elseif self.trigger_type == 100060 then
		return function(arg_83_0, arg_83_1)
			return arg_83_1.victim.serialId == arg_10_3.serialId
		end
	elseif self.trigger_type == 100061 then
		return function()
			return true
		end
	elseif self.trigger_type == 100062 then
		return function(arg_85_0, arg_85_1)
			return arg_85_0.info.trigger_type_value == arg_85_1
		end
	elseif self.trigger_type == 100063 then
		return function(arg_86_0)
			if arg_10_1:getRoundCount() == 1 then
				local var_86_0 = math.floor(arg_10_3.originInfo.ATTACK * (1000 + arg_10_3.originInfo.ATTACK_PCT) / 1000)

				for iter_86_0, iter_86_1 in ipairs((arg_10_1:getBattleData():getKnightList(arg_10_2))) do
					if var_86_0 < math.floor(iter_86_1.originInfo.ATTACK * (1000 + iter_86_1.originInfo.ATTACK_PCT) / 1000) then
						return false
					end
				end

				return true
			end

			return false
		end
	elseif self.trigger_type == 100064 then
		return function(arg_87_0)
			if arg_10_1:getRoundCount() == 1 then
				local var_87_0 = math.floor(arg_10_3.originInfo.ATTACK * (1000 + arg_10_3.originInfo.ATTACK_PCT) / 1000)

				for iter_87_0, iter_87_1 in ipairs((arg_10_1:getBattleData():getKnightList(arg_10_2))) do
					if var_87_0 < math.floor(iter_87_1.originInfo.ATTACK * (1000 + iter_87_1.originInfo.ATTACK_PCT) / 1000) then
						return true
					end
				end

				return false
			end

			return false
		end
	elseif self.trigger_type == 100065 then
		return function(arg_88_0, arg_88_1)
			for iter_88_0, iter_88_1 in ipairs(arg_88_1) do
				if iter_88_1.victim.identity == var_10_2 and iter_88_1.buffCfg.buff_effect_type == arg_88_0.info.trigger_type_value then
					return true
				end
			end

			return false
		end
	elseif self.trigger_type == 100066 then
		return function(arg_89_0, arg_89_1)
			local var_89_0 = loadCfg("core.config.cfg.buff_info")
			local var_89_1 = {}

			for iter_89_0, iter_89_1 in ipairs(arg_89_1) do
				if iter_89_1.victim.identity == var_10_2 and var_89_0.get(iter_89_1.buffId).buff_effect_type == var_0_5.EFFECT_TYPE.TREE_BIND then
					var_89_1[iter_89_1.victim.baseInfo.pos] = iter_89_1.victim
				end
			end

			for iter_89_2, iter_89_3 in pairs(var_89_1) do
				for iter_89_4, iter_89_5 in ipairs((var_10_0:getNearKnightList(iter_89_3))) do
					if iter_89_5:hasBuffByEffectType(var_0_5.EFFECT_TYPE.TREE_BIND) or var_89_1[iter_89_5.baseInfo.pos] then
						return true
					end
				end
			end

			return false
		end
	elseif self.trigger_type == 100067 then
		return function(arg_90_0, arg_90_1)
			for iter_90_0, iter_90_1 in ipairs(arg_90_1) do
				local var_90_0 = var_0_7.get(iter_90_1.buff_id).buff_effect_type

				if var_90_0 == var_0_5.EFFECT_TYPE.POISON or var_90_0 == var_0_5.EFFECT_TYPE.DEADLY_POISON then
					return true
				end
			end

			return false
		end
	elseif self.trigger_type == 100068 then
		return function(arg_91_0, arg_91_1)
			local var_91_0 = loadCfg("core.config.cfg.buff_info")

			for iter_91_0, iter_91_1 in ipairs(arg_91_1) do
				if iter_91_1.attacker.identity == arg_10_2 and var_91_0.get(iter_91_1.buffId).buff_increase_type == 2 then
					return true
				end
			end

			return false
		end
	elseif self.trigger_type == 100069 then
		return function(arg_92_0)
			return arg_10_1:getRoundCount() == arg_92_0.info.trigger_type_value
		end
	elseif self.trigger_type == 100070 then
		return function(arg_93_0)
			arg_10_3.inspirationCost = arg_10_3.inspirationCost % arg_93_0.info.trigger_type_value

			if math.floor(arg_10_3.inspirationCost / arg_93_0.info.trigger_type_value) > 0 then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100071 then
		return function(arg_94_0, arg_94_1)
			if arg_94_1.victim:getBuffCount(arg_94_0.info.trigger_type_value) > 0 and arg_94_1.damage > 0 then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100072 then
		return function(arg_95_0)
			return true
		end
	elseif self.trigger_type == 100073 then
		return function(arg_96_0)
			return arg_10_1:getRoundCount() <= arg_96_0.info.trigger_type_value
		end
	elseif self.trigger_type == 100074 then
		return function(arg_97_0)
			if arg_10_1:getRoundCount() ~= 1 and arg_10_3:getMarkLevel(2) == 0 then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100075 then
		return function(arg_98_0, arg_98_1)
			for iter_98_0, iter_98_1 in ipairs(arg_98_1) do
				if iter_98_1.victim.serialId == arg_10_3.serialId and iter_98_1.victim.identity == arg_10_2 and (iter_98_1.buffCfg.buff_effect_type == 1116 or iter_98_1.buffCfg.buff_effect_type == 1117 or iter_98_1.buffCfg.buff_effect_type == 1118) then
					return true
				end
			end

			return false
		end
	elseif self.trigger_type == 100076 then
		return function(arg_99_0)
			return arg_10_3:getMarkLevel(2) >= arg_99_0.info.trigger_type_value
		end
	elseif self.trigger_type == 100077 then
		return function(arg_100_0, arg_100_1)
			local var_100_0 = loadCfg("core.config.cfg.buff_info")

			for iter_100_0, iter_100_1 in ipairs(arg_100_1) do
				local var_100_1 = var_100_0.get(iter_100_1.buffId)

				if arg_10_3.serialId == iter_100_1.victim.serialId and iter_100_1.victim.identity == arg_10_2 and (var_100_1.buff_type == var_0_5.TYPE.ACT_LIMIT or var_100_1.buff_type == var_0_5.TYPE.SKILL_CHOOSE or var_100_1.buff_control_type == 1) then
					return true
				end
			end

			return false
		end
	elseif self.trigger_type == 100078 then
		return function(arg_101_0, arg_101_1)
			local var_101_0 = arg_10_3:getSufferDamage()

			if var_101_0 + arg_101_1 >= arg_10_3.originInfo.INITIAL_HP * arg_101_0.info.trigger_type_value / 1000 then
				arg_10_3:setSufferDamage(var_101_0 + arg_101_1 - arg_10_3.originInfo.INITIAL_HP * arg_101_0.info.trigger_type_value / 1000)

				return true
			else
				arg_10_3:setSufferDamage(var_101_0 + arg_101_1)
			end

			return false
		end
	elseif self.trigger_type == 100079 then
		return function(arg_102_0, arg_102_1)
			if arg_10_3.identity == arg_102_1.identity then
				if arg_102_1.baseInfo.INITIAL_HP / arg_102_1.originInfo.INITIAL_HP * 1000 < arg_102_0.info.trigger_type_value and arg_10_3:getMarkLevel(3) > 0 then
					return true
				end

				return false
			end
		end
	elseif self.trigger_type == 100080 then
		return function(arg_103_0, arg_103_1)
			if arg_103_1 == arg_10_3.identity and arg_10_3:getMarkLevel(arg_103_0.info.trigger_type_value) > 0 then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100081 then
		local var_10_4 = 0

		return function(arg_104_0, arg_104_1)
			if not arg_104_1.attacker then
				return false
			end

			if arg_104_1.cfg.skill_type == 2 then
				var_10_4 = var_10_4 + 1

				if var_10_4 >= arg_104_0.info.trigger_type_value then
					var_10_4 = var_10_4 - arg_104_0.info.trigger_type_value

					return true
				end
			end

			return false
		end
	elseif self.trigger_type == 100082 then
		return function(arg_105_0, arg_105_1)
			if not arg_105_1.attacker then
				return false
			end

			if not arg_105_1.attacker.isPlayer and arg_105_1.attacker.identity ~= arg_10_3.identity and arg_105_1.attacker:getBuffCount(arg_105_0.info.trigger_type_value) > 0 then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100083 then
		return function(arg_106_0, arg_106_1)
			if not arg_106_1.cfg then
				return false
			end

			local var_106_0, var_106_1

			if arg_106_1.cfg.skill_type ~= 2 then
				do return false end

				var_106_0 = 0
				var_106_1 = 0
			end

			for iter_106_0, iter_106_1 in ipairs((var_10_0:getKnightList(arg_10_3.identity))) do
				if iter_106_1:getBuffCount(98, true) > 0 then
					if iter_106_1.baseInfo.INITIAL_HP / iter_106_1.originInfo.INITIAL_HP > 0.5 then
						var_106_0 = var_106_0 + 1
					else
						var_106_1 = var_106_1 + 1
					end
				end
			end

			if (var_106_0 ~= 0 or var_106_1 ~= 0) and var_106_1 <= var_106_0 then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100084 then
		return function(arg_107_0, arg_107_1)
			if not arg_107_1.cfg then
				return false
			end

			local var_107_0, var_107_1

			if arg_107_1.cfg.skill_type ~= 2 then
				do return false end

				var_107_0 = 0
				var_107_1 = 0
			end

			for iter_107_0, iter_107_1 in ipairs((var_10_0:getKnightList(arg_10_3.identity))) do
				if iter_107_1:getBuffCount(98, true) > 0 then
					if iter_107_1.baseInfo.INITIAL_HP / iter_107_1.originInfo.INITIAL_HP >= 0.5 then
						var_107_0 = var_107_0 + 1
					else
						var_107_1 = var_107_1 + 1
					end
				end
			end

			if (var_107_0 ~= 0 or var_107_1 ~= 0) and var_107_0 <= var_107_1 then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100085 then
		return function(arg_108_0, arg_108_1)
			if arg_108_1.attacker and arg_108_1.cfg.skill_type == 2 and arg_108_1.attacker.identity == arg_10_2 then
				var_10_0:addSelfKnightSkillNum(arg_108_1.attacker.identity, arg_108_0.info.id)

				if var_10_0:getSelfKnightSkillNum(arg_108_1.attacker.identity, arg_108_0.info.id) >= arg_108_0.info.trigger_type_value then
					var_10_0:setSelfKnightSkillNum(arg_108_1.attacker.identity, 0, arg_108_0.info.id)

					return true
				end
			end

			return false
		end
	elseif self.trigger_type == 100086 then
		return function(arg_109_0, arg_109_1)
			if arg_109_1.victim.identity == var_10_2 then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100087 then
		return function(arg_110_0, arg_110_1)
			if arg_110_1.attacker and arg_110_1.attacker.identity == arg_10_2 and arg_110_1.cfg.skill_type == 6 and arg_110_1.cfg.belong_advance_id == arg_110_0.info.trigger_type_value then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100088 then
		return function(arg_111_0, arg_111_1)
			if type(arg_111_1) ~= "number" and arg_111_1 and arg_111_1.attacker and arg_111_1.attacker.serialId ~= arg_10_3.serialId then
				return false
			end

			return true
		end
	elseif self.trigger_type == 100089 then
		return function(arg_112_0, arg_112_1)
			if arg_10_1:getRoundCount() == 1 then
				if arg_10_1:getBattleData():getHighIdentity() ~= arg_10_2 or arg_112_0.info.trigger_type_value ~= 1 then
					if arg_10_1:getBattleData():getHighIdentity() ~= arg_10_2 and arg_112_0.info.trigger_type_value == 2 then
						return true
					end
				end
			end

			return false
		end
	elseif self.trigger_type == 100090 then
		return function(arg_113_0, arg_113_1)
			local var_113_0 = loadCfg("core.config.cfg.buff_info")

			for iter_113_0, iter_113_1 in ipairs(arg_113_1) do
				local var_113_1 = var_113_0.get(iter_113_1.buffId)

				if arg_10_3.serialId == iter_113_1.victim.serialId and iter_113_1.victim.identity == arg_10_2 and (var_113_1.buff_type == var_0_5.TYPE.ACT_LIMIT or var_113_1.buff_type == var_0_5.TYPE.SKILL_CHOOSE) then
					if arg_10_3:getBuffCount(var_0_5.COUNT_TYPE.CONTROL) > 1 then
						return true
					end
				end
			end

			return false
		end
	elseif self.trigger_type == 100091 then
		return function(arg_114_0)
			if arg_10_3:getBuffCount(1154) > 0 and arg_10_3.baseInfo.INITIAL_HP <= arg_10_3.bloodPoolValue then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100092 then
		return function(arg_115_0)
			if arg_10_3:getBuffCount(1155) > 0 and arg_10_3.baseInfo.INITIAL_ANGER < arg_115_0.info.trigger_type_value then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100093 then
		return function(arg_116_0, arg_116_1)
			local var_116_0 = loadCfg("core.config.cfg.buff_info")

			for iter_116_0, iter_116_1 in ipairs(arg_116_1) do
				local var_116_1 = var_116_0.get(iter_116_1.buffId)

				if arg_10_3.serialId == iter_116_1.victim.serialId and iter_116_1.victim.identity == arg_10_2 and (var_116_1.buff_type == 72 or var_116_1.buff_attribute_type == 2 and (var_116_1.buff_effect_type == 2 or var_116_1.buff_effect_type == 3 or var_116_1.buff_effect_type == 4)) then
					return true
				end
			end

			return false
		end
	elseif self.trigger_type == 100094 then
		return function(arg_117_0, arg_117_1)
			local var_117_0 = loadCfg("core.config.cfg.buff_info")

			for iter_117_0, iter_117_1 in ipairs(arg_117_1) do
				if arg_10_3.serialId == iter_117_1.victim.serialId and iter_117_1.victim.identity == arg_10_2 and var_117_0.get(iter_117_1.buffId).buff_effect_type == arg_117_0.info.trigger_type_value then
					return true
				end
			end

			return false
		end
	elseif self.trigger_type == 100095 then
		return function(arg_118_0, arg_118_1)
			local var_118_0 = loadCfg("core.config.cfg.buff_info")

			for iter_118_0, iter_118_1 in ipairs(arg_118_1) do
				if arg_10_3.serialId == iter_118_1.victim.serialId and iter_118_1.victim.identity == arg_10_2 and var_118_0.get(iter_118_1.buffId).buff_type == arg_118_0.info.trigger_type_value then
					return true
				end
			end

			return false
		end
	elseif self.trigger_type == 100096 then
		return function(arg_119_0, arg_119_1)
			if not arg_119_1 or not arg_119_1.attacker then
				return false
			end

			if not arg_119_1.cfg then
				return false
			end

			if var_10_0:isKnightFight(arg_119_1.cfg) and arg_119_1.attacker.identity == arg_10_2 and arg_119_1.attacker.originInfo.pos > 3 then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100097 then
		return function(arg_120_0, arg_120_1)
			local var_120_0 = loadCfg("core.config.cfg.buff_info")

			for iter_120_0, iter_120_1 in ipairs(arg_120_1) do
				local var_120_1 = var_120_0.get(iter_120_1.buffId)

				if arg_10_3.serialId == iter_120_1.victim.serialId and iter_120_1.victim.identity == arg_10_2 and (var_120_1.buff_effect_type == 1170 or var_120_1.buff_effect_type == 1171 or var_120_1.buff_effect_type == 1172) then
					return true
				end
			end

			return false
		end
	elseif self.trigger_type == 100098 then
		return function(arg_121_0, arg_121_1)
			if arg_121_1.affectType == 3 or arg_121_1.affectType == 90 then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100099 then
		return function(arg_122_0)
			return var_10_0:getHpPer(arg_10_2) < arg_122_0.info.trigger_type_value
		end
	elseif self.trigger_type == 100100 then
		return function(arg_123_0, arg_123_1)
			local var_123_0 = loadCfg("core.config.cfg.buff_info")

			for iter_123_0, iter_123_1 in ipairs(arg_123_1) do
				if iter_123_1.victim.identity ~= arg_10_2 and var_123_0.get(iter_123_1.buffId).buff_effect_type == arg_123_0.info.trigger_type_value then
					return true
				end
			end

			return false
		end
	elseif self.trigger_type == 100101 then
		return function(arg_124_0, arg_124_1)
			if loadCfg("core.config.cfg.buff_info").get(arg_124_1).buff_control_type == 1 then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100102 then
		return function(arg_125_0, arg_125_1)
			if arg_125_1.attacker and arg_125_1.cfg.skill_type == 2 then
				var_10_0:addSelfKnightSkillNum(arg_10_2, arg_125_0.info.id)

				if var_10_0:getSelfKnightSkillNum(arg_10_2, arg_125_0.info.id) >= arg_125_0.info.trigger_type_value then
					var_10_0:setSelfKnightSkillNum(arg_10_2, 0, arg_125_0.info.id)

					return true
				end
			end

			return false
		end
	elseif self.trigger_type == 100103 then
		return function(arg_126_0, arg_126_1)
			arg_126_1.attacker:setAttackDamage(arg_126_1.attacker:getAttackDamage() + arg_126_1.damage)

			if arg_126_1.attacker:getAttackDamage() >= math.floor(arg_126_1.attacker.advanceInfo.totalAtk * arg_126_0.info.trigger_type_value / 1000) then
				arg_126_1.attacker:setAttackDamage(0)

				return true
			end

			return false
		end
	elseif self.trigger_type == 100104 then
		return function(arg_127_0)
			return true
		end
	elseif self.trigger_type == 100105 then
		return function(arg_128_0)
			return true
		end
	elseif self.trigger_type == 100106 then
		return function(arg_129_0)
			return true
		end
	elseif self.trigger_type == 100107 then
		return function(arg_130_0, arg_130_1)
			if (arg_130_1.affectType == 3 or arg_130_1.affectType == 90) and not arg_130_1.isPassive then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100108 then
		return function(arg_131_0)
			return arg_10_1:getRoundCount() % 2 == 1
		end
	elseif self.trigger_type == 100109 then
		return function(arg_132_0)
			return arg_10_1:getRoundCount() % 2 == 0
		end
	elseif self.trigger_type == 100110 then
		return function(arg_133_0)
			return arg_10_3:getBuffCount(var_0_5.COUNT_TYPE.CONTROL) > 0
		end
	elseif self.trigger_type == 100111 then
		return function(arg_134_0)
			if arg_10_1:getRoundCount() ~= 1 then
				return arg_10_3:getBuffCount(var_0_5.COUNT_TYPE.CONTROL) > 0
			end

			return false
		end
	elseif self.trigger_type == 100112 then
		return function(arg_135_0, arg_135_1)
			if arg_135_1.attacker.isPlayer then
				return false
			end

			local var_135_0 = var_0_8 .. "100112_" .. arg_135_1.attacker.serialId .. "_" .. arg_10_3.serialId

			if arg_135_1.attacker:getKnightTempValue(var_0_8 .. "100112_" .. arg_135_1.attacker.serialId .. "_" .. arg_10_3.serialId) then
				return false
			end

			if arg_135_1.cfg.skill_type == arg_135_0.info.trigger_type_value then
				arg_135_1.attacker:setKnightTempValue(var_135_0, true)

				return true
			end

			return false
		end
	elseif self.trigger_type == 100113 then
		return function(arg_136_0)
			if arg_10_3:getBuffCount(1224) > 0 and arg_10_3:getBuffCount(1225) > 0 then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100114 then
		return function(arg_137_0)
			if arg_10_1:getRoundCount() == 1 then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100115 then
		return function(arg_138_0, arg_138_1)
			if arg_138_1.skillCfg.skill_type == arg_138_0.info.trigger_type_value then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100116 then
		return function(arg_139_0, arg_139_1)
			if arg_139_1.victim.identity == var_10_2 then
				local var_139_0 = 0

				for iter_139_0, iter_139_1 in ipairs((arg_10_1:getBattleData():getKnightList(arg_10_2))) do
					if iter_139_1.isDead then
						var_139_0 = var_139_0 + 1
					end
				end

				if var_139_0 + 1 == arg_139_0.info.trigger_type_value then
					return true
				end
			end

			return false
		end
	elseif self.trigger_type == 100117 then
		return function(arg_140_0, arg_140_1)
			if arg_140_1.victim and arg_140_1.victim:getBuffCount(arg_140_0.info.trigger_type_value) and arg_140_1.attacker.serialId == arg_10_3.serialId then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100118 then
		return function(arg_141_0, arg_141_1)
			if arg_141_1.isPlayer then
				if arg_141_1.attacker.skillCfg.skill_type == 3 then
					if arg_141_1.attacker.skillCfg.compose_id == arg_141_0.info.trigger_type_value then
						return true
					end
				elseif arg_141_1.attacker.skillCfg.skill_type == 6 and arg_141_1.attacker.skillCfg.belong_advance_id == arg_141_0.info.trigger_type_value then
					return true
				end
			elseif arg_141_1.attacker.knightCfg.advance_id == arg_141_0.info.trigger_type_value then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100119 then
		return function(arg_142_0, arg_142_1)
			if #arg_10_1:getBattleData():getKnightList(arg_10_2) >= arg_142_0.info.trigger_type_value then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100120 then
		return function(arg_143_0, arg_143_1)
			return true
		end
	elseif self.trigger_type == 100121 then
		local var_10_5 = 0
		local var_10_6 = 0

		for iter_10_0, iter_10_1 in ipairs((var_10_0:getKnightList(arg_10_2))) do
			var_10_6 = var_10_6 + iter_10_1.originInfo.INITIAL_HP
		end

		return function(arg_144_0, arg_144_1)
			local var_144_0 = math.floor(var_10_6 * arg_144_0.info.trigger_type_value / 1000)

			if arg_144_1.victim.identity == arg_10_2 then
				var_10_5 = var_10_5 + arg_144_1.damage
			end

			if var_144_0 <= var_10_5 then
				var_10_5 = var_10_5 - var_144_0

				return true
			end

			return false
		end
	elseif self.trigger_type == 100122 then
		return function(arg_145_0, arg_145_1)
			if arg_145_1.attacker then
				if arg_10_3.serialId == arg_145_1.attacker.serialId and not arg_145_1.isExAction and not arg_145_1.isActionSucc then
					return true
				end

				return false
			end
		end
	elseif self.trigger_type == 100123 then
		return function(arg_146_0, arg_146_1)
			local var_146_0 = loadCfg("core.config.cfg.buff_info")

			for iter_146_0, iter_146_1 in ipairs(arg_146_1) do
				if arg_146_0.info.trigger_type_value == iter_146_1.buffId then
					return true
				end
			end

			return false
		end
	elseif self.trigger_type == 100125 then
		return function(arg_147_0, arg_147_1)
			if arg_147_1.attacker.identity == var_10_2 and (arg_147_1.skillCfg.skill_type == 1 or arg_147_1.skillCfg.skill_type == 2) then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100124 then
		return function(arg_148_0, arg_148_1)
			if var_10_0:isKnightFight(arg_148_1.cfg) and arg_148_1.result.block then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100126 then
		return function(arg_149_0, arg_149_1)
			if arg_149_1.skillCfg and arg_149_1.skillCfg.skill_type == 2 then
				if arg_149_1.victim and arg_149_1.victim:getBuffCount(arg_149_0.info.trigger_type_value) > 0 and arg_149_1.attacker.serialId == arg_10_3.serialId then
					return true
				end
			end

			return false
		end
	elseif self.trigger_type == 100127 then
		-- block empty
	elseif self.trigger_type == 100128 then
		return function(arg_150_0)
			return arg_10_1:getAttackCountByIdentify(arg_10_2) >= arg_150_0.info.trigger_type_value
		end
	elseif self.trigger_type == 100129 then
		return function(arg_151_0, arg_151_1)
			if not arg_151_1.attacker.isPlayer then
				return arg_151_1.attacker.knightCfg.group == arg_151_0.info.trigger_type_value
			end

			return false
		end
	elseif self.trigger_type == 100130 then
		return function(arg_152_0, arg_152_1)
			if not arg_152_1.attacker.isPlayer then
				return arg_152_1.attacker.knightCfg.advance_id == arg_152_0.info.trigger_type_value
			end

			return false
		end
	elseif self.trigger_type == 100131 then
		return function(arg_153_0)
			for iter_153_0, iter_153_1 in ipairs((arg_10_1:getBattleData():getKnightList(var_10_2, true))) do
				if iter_153_1.knightCfg.advance_id == arg_153_0.info.trigger_type_value then
					return arg_10_3.baseInfo.INITIAL_HP / arg_10_3.originInfo.INITIAL_HP > iter_153_1.baseInfo.INITIAL_HP / iter_153_1.originInfo.INITIAL_HP
				end
			end

			return false
		end
	elseif self.trigger_type == 100132 then
		return function(arg_154_0, arg_154_1)
			for iter_154_0, iter_154_1 in pairs((arg_10_1:getBattleData():getMultiAllShield(arg_10_3.identity))) do
				if iter_154_1 == 0 then
					return true
				end
			end

			return false
		end
	elseif self.trigger_type == 100133 then
		return function(arg_155_0, arg_155_1)
			if not arg_155_1.attacker.isPlayer then
				if arg_10_3:getKnightTempValue(var_0_8 .. "100133_" .. arg_155_1.attacker.knightCfg.advance_id .. "_" .. arg_10_3.serialId) then
					return false
				end

				if arg_155_1.attacker.identity ~= arg_10_3.identity then
					arg_10_3:setKnightTempValue(var_0_8 .. "100133_" .. arg_155_1.attacker.knightCfg.advance_id .. "_" .. arg_10_3.serialId, true)

					return true
				end
			end

			return false
		end
	elseif self.trigger_type == 100135 then
		return function(arg_156_0, arg_156_1)
			if arg_156_1.attacker and not arg_156_1.isExAction then
				if arg_10_3.serialId ~= arg_156_1.attacker.serialId and arg_10_3.identity == arg_156_1.attacker.identity then
					return true
				end

				return false
			end
		end
	elseif self.trigger_type == 100136 then
		return function(arg_157_0, arg_157_1)
			if arg_157_1.isAdd and loadCfg("core.config.cfg.skill_mark_info").get(arg_157_1.markId).type == arg_157_0.info.trigger_type_value then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100137 then
		return function(arg_158_0, arg_158_1)
			for iter_158_0, iter_158_1 in ipairs({
				230,
				231,
				232
			}) do
				if arg_10_1:getBattleData():getMoodBuffTick(3 - arg_10_3.identity, iter_158_1) < arg_158_0.info.trigger_type_value then
					return false
				end
			end

			return true
		end
	elseif self.trigger_type == 100138 then
		return function(arg_159_0, arg_159_1)
			for iter_159_0, iter_159_1 in ipairs(arg_159_1) do
				if iter_159_1.victim.serialId == arg_10_3.serialId and iter_159_1.victim.identity == arg_10_2 and iter_159_1.buffCfg.buff_type == var_0_5.TYPE.HIDE then
					return true
				end
			end

			return false
		end
	elseif self.trigger_type == 100139 then
		return function(arg_160_0, arg_160_1)
			if arg_160_1.exParam == var_0_2.SP_EX_NORMAL_RULE.SUSPICTION_ADD then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100140 then
		local var_10_7 = 0

		return function(arg_161_0, arg_161_1)
			var_10_7 = var_10_7 + 1

			if var_10_7 % arg_161_0.info.trigger_type_value == 0 then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100141 then
		return function(arg_162_0, arg_162_1)
			if arg_162_1 >= math.floor(arg_10_3.originInfo.INITIAL_HP * arg_162_0.info.trigger_type_value / 1000) then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100142 then
		local var_10_8 = 0

		return function(arg_163_0, arg_163_1)
			var_10_8 = var_10_8 + 1

			if var_10_8 >= arg_163_0.info.trigger_type_value then
				return true
			end

			return false
		end
	elseif self.trigger_type == 100143 then
		return function(arg_164_0, arg_164_1)
			for iter_164_0, iter_164_1 in ipairs((arg_10_1:getBattleData():getKnightList(var_10_2))) do
				if not iter_164_1.isDead and var_0_0.getAttackDis(arg_10_3, iter_164_1) >= 4 then
					return true
				end
			end

			return false
		end
	elseif self.trigger_type == 100144 then
		return function(arg_165_0, arg_165_1)
			for iter_165_0, iter_165_1 in ipairs(arg_165_1.buffInfoList) do
				if arg_165_1.knight.identity == var_10_2 and iter_165_1.buff_type == 252 then
					return true
				end
			end

			return false
		end
	elseif var_0_2["_triggerTiming" .. self.trigger_type] then
		return var_0_2["_triggerTiming" .. self.trigger_type](var_10_0, arg_10_2, arg_10_3, arg_10_1)
	else
		return function(arg_166_0)
			return false
		end
	end
end

function var_0_2._triggerTiming100145(arg_167_0, arg_167_1, arg_167_2)
	local var_167_0 = 3 - arg_167_1

	return function(arg_168_0, arg_168_1)
		local var_168_0 = loadCfg("core.config.cfg.buff_info")

		for iter_168_0, iter_168_1 in ipairs(arg_168_1) do
			if iter_168_1.victim.identity == var_167_0 then
				local var_168_1 = var_168_0.get(iter_168_1.buffId)

				if var_168_1.buff_type == var_0_5.TYPE.ACT_LIMIT or var_168_1.buff_type == var_0_5.TYPE.SKILL_CHOOSE or var_168_1.buff_control_type == 1 then
					return true
				end
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100146(arg_169_0, arg_169_1, arg_169_2)
	return function(arg_170_0, arg_170_1)
		for iter_170_0, iter_170_1 in ipairs(arg_170_1) do
			if iter_170_1.victim.serialId == arg_169_2.serialId and iter_170_1.buffCfg.buff_effect_type == 1310 then
				return true
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100147(arg_171_0, arg_171_1, arg_171_2)
	local var_171_0 = 0

	return function(arg_172_0, arg_172_1)
		for iter_172_0, iter_172_1 in ipairs(arg_172_1.buffInfoList or {}) do
			if arg_172_1.knight.serialId == arg_171_2.serialId and iter_172_1.buff_effect_type == 1311 then
				var_171_0 = var_171_0 + 1

				if var_171_0 % arg_172_0.info.trigger_type_value == 0 then
					return true
				end
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100148(arg_173_0, arg_173_1, arg_173_2)
	return function(arg_174_0, arg_174_1)
		if arg_174_1.isAdd then
			return arg_174_0.info.trigger_type_value <= arg_173_2:getMarkLevel(92)
		end

		return false
	end
end

function var_0_2._triggerTiming100149(arg_175_0, arg_175_1, arg_175_2)
	return function(arg_176_0, arg_176_1)
		for iter_176_0, iter_176_1 in ipairs(arg_176_1) do
			if iter_176_1.victim.serialId == arg_175_2.serialId then
				local var_176_0 = var_0_1.get(arg_176_0.info.trigger_type_value, 4)

				if iter_176_1.victim:getMarkLevel(var_176_0.value_1) > 0 and iter_176_1.victim:getMarkLevel(var_176_0.value_2) > 0 then
					return true
				else
					return false
				end
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100150(arg_177_0, arg_177_1, arg_177_2)
	return function(arg_178_0, arg_178_1)
		if arg_178_0.info.trigger_type_value == arg_178_1.markId and arg_178_1.isAdd and arg_178_1.preIsMax then
			return true
		end

		return false
	end
end

function var_0_2:_triggerTiming100151(arg_179_1, arg_179_2)
	local var_179_0 = self:getBattleField()
	local var_179_1 = {}

	return function(arg_180_0, arg_180_1)
		local var_180_0 = var_179_0:getAttackCount()

		if var_179_1[var_180_0] then
			return false
		elseif arg_180_1.victim.identity == arg_179_1 then
			var_179_1[var_180_0] = true

			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100152(arg_181_0, arg_181_1, arg_181_2)
	return function(arg_182_0, arg_182_1)
		if arg_182_1.victim:getBuffCount(264, true) > 0 then
			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100153(arg_183_0, arg_183_1, arg_183_2)
	return function(arg_184_0, arg_184_1)
		if arg_183_1 ~= arg_184_1.identity then
			if arg_184_1.advanceInfo.hpRate < arg_184_0.info.trigger_type_value then
				return true
			end

			return false
		end
	end
end

function var_0_2._triggerTiming100154(arg_185_0, arg_185_1, arg_185_2)
	local var_185_0 = {
		[1326] = true,
		[1325] = true
	}

	return function(arg_186_0, arg_186_1)
		for iter_186_0, iter_186_1 in ipairs(arg_186_1) do
			if iter_186_1.victim.identity == arg_185_1 and var_185_0[var_0_7.get(iter_186_1.buffId).buff_effect_type] and iter_186_1.victim:getBuffCount(1325) > 0 and iter_186_1.victim:getBuffCount(1326) > 0 then
				return true
			end
		end

		return false
	end
end

function var_0_2:_triggerTiming100155(arg_187_1, arg_187_2)
	local var_187_0 = self:getBattleField()

	return function(arg_188_0, arg_188_1)
		for iter_188_0, iter_188_1 in ipairs((var_187_0:getBattleData():getKnightList(3 - arg_187_1, true))) do
			if iter_188_1.isDead then
				return false
			end
		end

		return true
	end
end

function var_0_2._triggerTiming100156(arg_189_0, arg_189_1, arg_189_2)
	local var_189_0 = 0

	return function(arg_190_0, arg_190_1)
		if not arg_190_1.attacker then
			return false
		end

		if arg_189_0:isKnightFight(arg_190_1.cfg) then
			var_189_0 = var_189_0 + 1

			if var_189_0 >= arg_190_0.info.trigger_type_value then
				var_189_0 = var_189_0 - arg_190_0.info.trigger_type_value

				return true
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100157(arg_191_0, arg_191_1, arg_191_2)
	return function(arg_192_0, arg_192_1)
		if arg_192_1.victim then
			if math.abs(arg_192_1.victim.serialId - arg_191_2.serialId) == 3 then
				return true
			end
		elseif arg_192_1.attacker and math.abs(arg_192_1.attacker.serialId - arg_191_2.serialId) == 3 then
			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100158(arg_193_0, arg_193_1, arg_193_2)
	return function(arg_194_0)
		if arg_193_2.advanceInfo.SHIELD > math.floor(arg_193_2.originInfo.INITIAL_HP * arg_194_0.info.trigger_type_value * 0.001) then
			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100159(arg_195_0, arg_195_1, arg_195_2)
	return function(arg_196_0, arg_196_1)
		if not arg_196_1 then
			return true
		elseif not arg_196_1.attacker.isPlayer then
			if arg_195_2:getKnightTempValue(var_0_8 .. "100159_" .. arg_196_1.attacker.knightCfg.advance_id .. "_" .. arg_195_2.serialId) then
				return false
			end

			if arg_196_1.attacker.identity ~= arg_195_2.identity then
				arg_195_2:setKnightTempValue(var_0_8 .. "100159_" .. arg_196_1.attacker.knightCfg.advance_id .. "_" .. arg_195_2.serialId, true)

				return true
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100160(arg_197_0, arg_197_1, arg_197_2)
	return function(arg_198_0, arg_198_1)
		return arg_198_1.victim.serialId == arg_197_2.serialId
	end
end

function var_0_2._triggerTiming100161(arg_199_0, arg_199_1, arg_199_2)
	return function(arg_200_0, arg_200_1)
		return arg_199_2.advanceInfo.SHIELD <= 0
	end
end

function var_0_2._triggerTiming100162(arg_201_0, arg_201_1, arg_201_2)
	return function(arg_202_0, arg_202_1)
		if arg_202_1.attacker.identity == arg_201_1 and arg_202_1.attacker.skillCfg.skill_type == 3 and arg_202_1.attacker.advId == arg_202_0.info.trigger_type_value then
			return true
		end
	end
end

function var_0_2._triggerTiming100163(arg_203_0, arg_203_1, arg_203_2)
	return function(arg_204_0, arg_204_1)
		if not arg_204_1.cfg then
			return false
		end

		if arg_203_0:isKnightFight(arg_204_1.cfg) then
			return true
		end
	end
end

function var_0_2._triggerTiming100164(arg_205_0, arg_205_1, arg_205_2, arg_205_3)
	return function(arg_206_0, arg_206_1)
		if arg_205_3:getRoundCount() > 1 then
			return false
		end

		for iter_206_0, iter_206_1 in ipairs((arg_205_3:getBattleData():getKnightList(arg_205_1))) do
			if iter_206_1.knightCfg.advance_id == arg_206_0.info.trigger_type_value then
				return true
			end
		end
	end
end

function var_0_2._triggerTiming100165(arg_207_0, arg_207_1, arg_207_2)
	return function(arg_208_0, arg_208_1)
		if arg_208_1.knight then
			local var_208_0 = arg_208_1.buffAttackList or {}

			for iter_208_0, iter_208_1 in ipairs(arg_208_1.buffInfoList or {}) do
				if var_208_0[iter_208_0].serialId == arg_207_2.serialId and (iter_208_1.buff_effect_type == 1354 or iter_208_1.buff_effect_type == 1355) then
					return true
				end
			end

			return false
		elseif arg_208_1.skillEffectType and arg_208_1.effectCnt < 1 then
			if arg_208_1.skillEffectType == 121 and arg_208_1.attacker.serialId == arg_207_2.serialId then
				return true
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100166(arg_209_0, arg_209_1, arg_209_2)
	local var_209_0 = 0

	return function(arg_210_0, arg_210_1)
		if arg_210_1.victim.serialId == arg_209_2.serialId then
			var_209_0 = var_209_0 + 1

			if var_209_0 >= arg_210_0.info.trigger_type_value then
				var_209_0 = var_209_0 - arg_210_0.info.trigger_type_value

				return true
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100167(arg_211_0, arg_211_1, arg_211_2)
	return function(arg_212_0, arg_212_1)
		if arg_211_2:getBuffCount(1359) > 0 and arg_211_2:getBuffCount(1360) > 0 and arg_211_2:getBuffCount(1361) > 0 then
			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100168(arg_213_0, arg_213_1, arg_213_2)
	local var_213_0 = 0

	return function(arg_214_0, arg_214_1)
		local var_214_0

		if arg_214_0.info.trigger_type_value <= var_213_0 then
			do return false end

			var_214_0 = ipairs
		end

		for iter_214_0, iter_214_1 in var_214_0(arg_214_1 or {}) do
			local var_214_1 = var_0_7.get(iter_214_1.buffId)

			if var_214_1.buff_type == 2 and var_214_1.buff_increase_type == 2 then
				var_213_0 = var_213_0 + 1

				if arg_214_0.info.trigger_type_value <= var_213_0 then
					return true
				end
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100169(arg_215_0, arg_215_1, arg_215_2)
	return function(arg_216_0, arg_216_1)
		for iter_216_0, iter_216_1 in ipairs(arg_216_1) do
			if iter_216_1.victim.identity == arg_215_1 and iter_216_1.buffCfg.buff_increase_type == arg_216_0.info.trigger_type_value then
				return true
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100170(arg_217_0, arg_217_1, arg_217_2)
	return function(arg_218_0, arg_218_1)
		if arg_218_1.isAdd then
			return arg_218_0.info.trigger_type_value <= arg_217_2:getMarkLevel(110)
		end

		return false
	end
end

function var_0_2._triggerTiming100171(arg_219_0, arg_219_1, arg_219_2)
	return function(arg_220_0, arg_220_1)
		for iter_220_0, iter_220_1 in ipairs(arg_220_1) do
			if iter_220_1.victim.serialId == arg_219_2.serialId and iter_220_1.buffCfg.buff_increase_type == arg_220_0.info.trigger_type_value then
				return true
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100172(arg_221_0, arg_221_1, arg_221_2)
	return function(arg_222_0, arg_222_1)
		if arg_222_1.victim.serialId == arg_221_2.serialId and arg_222_1.damage >= math.floor(arg_222_1.victim.originInfo.INITIAL_HP * (arg_222_0.info.trigger_type_value * 0.001)) then
			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100173(arg_223_0, arg_223_1, arg_223_2)
	local var_223_0 = 3 - arg_223_1

	return function(arg_224_0, arg_224_1)
		if arg_224_1.identity == var_223_0 and arg_224_1.isExAction and arg_224_1.isActionSucc then
			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100174(arg_225_0, arg_225_1, arg_225_2)
	return function(arg_226_0, arg_226_1)
		if arg_225_2.serialId == arg_226_1.attacker.serialId and arg_226_1.isExAction and arg_226_1.isActionSucc then
			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100175(arg_227_0, arg_227_1, arg_227_2)
	return function(arg_228_0, arg_228_1)
		return arg_228_1.victim.identity ~= arg_227_1
	end
end

function var_0_2._triggerTiming100176(arg_229_0, arg_229_1, arg_229_2)
	return function(arg_230_0, arg_230_1)
		return arg_230_1.victim.identity == arg_229_1
	end
end

function var_0_2._triggerTiming100177(arg_231_0, arg_231_1, arg_231_2)
	return function(arg_232_0, arg_232_1)
		if arg_232_1.isAdd and not arg_232_1.preIsMax then
			local var_232_0 = arg_232_1.victim
			local var_232_1 = loadCfg("core.config.cfg.skill_mark_info").get(arg_232_1.markId)

			if var_232_1.type == arg_232_0.info.trigger_type_value then
				return var_232_1.max_num <= var_232_0:getMarkLevel(var_232_1.type)
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100178(arg_233_0, arg_233_1, arg_233_2)
	local var_233_0 = 0

	return function(arg_234_0, arg_234_1)
		if arg_234_1.cfg.skill_type == 12 then
			var_233_0 = var_233_0 + 1

			if var_233_0 >= arg_234_0.info.trigger_type_value then
				var_233_0 = var_233_0 - arg_234_0.info.trigger_type_value

				return true
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100179(arg_235_0, arg_235_1, arg_235_2)
	return function(arg_236_0, arg_236_1)
		if arg_235_1 == arg_236_1.identity then
			if arg_236_1.advanceInfo.hpRate < arg_236_0.info.trigger_type_value then
				return true
			end

			return false
		end
	end
end

function var_0_2._triggerTiming100180(arg_237_0, arg_237_1, arg_237_2)
	return function(arg_238_0, arg_238_1)
		for iter_238_0, iter_238_1 in ipairs(arg_238_1) do
			if iter_238_1.victim.identity == arg_237_1 and iter_238_1.buffCfg.buff_effect_type == arg_238_0.info.trigger_type_value then
				return true
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100181(arg_239_0, arg_239_1, arg_239_2)
	return function(arg_240_0, arg_240_1)
		if arg_239_2.serialId ~= arg_240_1.attacker.serialId then
			return false
		end

		local var_240_0 = arg_240_1.skillInfo

		if (arg_240_1.deadNum or 0) > 0 or not var_240_0 then
			return false
		end

		return var_240_0.skill_type == arg_240_0.info.trigger_type_value
	end
end

function var_0_2._triggerTiming100182(arg_241_0, arg_241_1, arg_241_2)
	local var_241_0 = 0

	return function(arg_242_0, arg_242_1)
		if (arg_242_1.skillInfo or {}).skill_type == 12 then
			var_241_0 = var_241_0 + 1

			if arg_242_0.info.trigger_type_value <= var_241_0 then
				var_241_0 = var_241_0 - arg_242_0.info.trigger_type_value

				return true
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100183(arg_243_0, arg_243_1, arg_243_2)
	return function(arg_244_0, arg_244_1)
		local var_244_0 = loadCfg("core.config.cfg.buff_info")

		for iter_244_0, iter_244_1 in ipairs(arg_244_1) do
			local var_244_1 = var_244_0.get(iter_244_1.buffId)

			if arg_243_2.serialId == iter_244_1.victim.serialId then
				if var_244_1.buff_effect_type == arg_244_0.info.trigger_type_value then
					if arg_243_2:getBuffCount(1349) > 0 then
						return true
					else
						return false
					end
				elseif var_244_1.buff_effect_type == 1349 then
					if arg_243_2:getBuffCount(arg_244_0.info.trigger_type_value) > 0 then
						return true
					else
						return false
					end
				end
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100184(arg_245_0, arg_245_1, arg_245_2)
	return function(arg_246_0, arg_246_1)
		if arg_246_1.attacker and arg_246_1.attacker.serialId == arg_245_2.serialId then
			return arg_246_1.cfg.skill_type == 12 or arg_246_1.cfg.skill_type == 2
		end

		return false
	end
end

function var_0_2._triggerTiming100185(arg_247_0, arg_247_1, arg_247_2)
	local var_247_0 = 0

	return function(arg_248_0, arg_248_1)
		if not arg_248_1.attacker or arg_248_1.attacker.identity ~= arg_247_1 then
			return false
		end

		local var_248_0 = arg_248_0.info.trigger_type_value

		if (arg_248_1.skillInfo or {}).skill_type == 12 then
			var_247_0 = var_247_0 + 1

			if var_248_0 <= var_247_0 then
				var_247_0 = var_247_0 - var_248_0

				return true
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100186(arg_249_0, arg_249_1, arg_249_2)
	local var_249_0 = 0

	return function(arg_250_0, arg_250_1)
		var_249_0 = var_249_0 + math.abs(arg_250_1.changeEnergy or 0)

		if var_249_0 >= arg_250_0.info.trigger_type_value then
			var_249_0 = var_249_0 - arg_250_0.info.trigger_type_value

			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100187(arg_251_0, arg_251_1, arg_251_2)
	local var_251_0 = 0

	return function(arg_252_0, arg_252_1)
		var_251_0 = var_251_0 + math.abs(arg_252_1.changeAnger or 0)

		if var_251_0 >= arg_252_0.info.trigger_type_value then
			var_251_0 = var_251_0 - arg_252_0.info.trigger_type_value

			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100188(arg_253_0, arg_253_1, arg_253_2)
	return function(arg_254_0, arg_254_1)
		if arg_254_1.victim and arg_253_2.serialId == arg_254_1.victim.serialId then
			return arg_254_1.damage > 0
		end

		return false
	end
end

function var_0_2._triggerTiming100189(arg_255_0, arg_255_1, arg_255_2)
	return function(arg_256_0, arg_256_1)
		for iter_256_0, iter_256_1 in ipairs(arg_256_1) do
			if iter_256_1.victim.identity == arg_255_1 and var_0_7.get(iter_256_1.buffId).buff_type == var_0_5.TYPE.DHOT then
				return true
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100190(arg_257_0, arg_257_1, arg_257_2)
	return function(arg_258_0, arg_258_1)
		if arg_258_1.victim then
			return arg_258_1.victim.identity ~= arg_257_1 and arg_258_1.victim:getMarkLevel(130) > 0
		end

		return false
	end
end

function var_0_2._triggerTiming100191(arg_259_0, arg_259_1, arg_259_2)
	return function(arg_260_0, arg_260_1)
		if arg_260_1.markId == 130 and arg_260_1.isAdd then
			local var_260_0 = 0

			for iter_260_0, iter_260_1 in ipairs((arg_259_0:getKnightList(3 - arg_259_1, nil))) do
				if iter_260_1:getMarkLevel(130) > 0 then
					var_260_0 = var_260_0 + 1

					if var_260_0 >= arg_260_0.info.trigger_type_value then
						return true
					end
				end
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100192(arg_261_0, arg_261_1, arg_261_2)
	return function(arg_262_0, arg_262_1)
		if arg_262_1.markId == arg_262_0.info.trigger_type_value and arg_262_1.addValue > 0 and arg_261_2:getMarkLevel(arg_262_0.info.trigger_type_value) <= 0 then
			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100193(arg_263_0, arg_263_1, arg_263_2)
	return function(arg_264_0, arg_264_1)
		local var_264_0 = 0

		for iter_264_0, iter_264_1 in ipairs((arg_263_0:getKnightList(3 - arg_263_1, nil))) do
			if iter_264_1:getBuffCount(1415) > 0 then
				var_264_0 = var_264_0 + 1

				if arg_264_0.info.trigger_type_value <= var_264_0 then
					return true
				end
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100194(arg_265_0, arg_265_1, arg_265_2)
	local var_265_0 = 0

	return function(arg_266_0, arg_266_1)
		if arg_266_1.victim and arg_265_2.serialId == arg_266_1.victim.serialId then
			var_265_0 = arg_266_1.damage + var_265_0

			if math.floor(arg_265_2.originInfo.INITIAL_HP * arg_266_0.info.trigger_type_value * 0.001) <= var_265_0 then
				var_265_0 = 0

				return true
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100195(arg_267_0, arg_267_1, arg_267_2)
	return function(arg_268_0, arg_268_1)
		if arg_267_1 ~= arg_268_1.identity then
			return true
		end
	end
end

function var_0_2._triggerTiming100196(arg_269_0, arg_269_1, arg_269_2)
	return function(arg_270_0, arg_270_1)
		local var_270_0 = var_0_1.get(arg_270_0.info.trigger_type_value, 4)

		if arg_270_1.attacker.advId == var_270_0.value_1 then
			local var_270_1 = 0

			for iter_270_0, iter_270_1 in ipairs((arg_269_0:getKnightList(3 - arg_269_1, nil))) do
				if iter_270_1.baseInfo.SHIELD > 0 then
					var_270_1 = var_270_1 + 1
				end
			end

			return var_270_1 >= var_270_0.value_2
		end

		return false
	end
end

function var_0_2._triggerTiming100197(arg_271_0, arg_271_1, arg_271_2)
	return function(arg_272_0, arg_272_1)
		local var_272_0 = loadCfg("core.config.cfg.buff_info")

		for iter_272_0, iter_272_1 in ipairs(arg_272_1) do
			if arg_271_1 == iter_272_1.victim.identity and var_272_0.get(iter_272_1.buffId).buff_effect_type == arg_272_0.info.trigger_type_value then
				return true
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100198(arg_273_0, arg_273_1, arg_273_2)
	local var_273_0 = 0

	return function(arg_274_0, arg_274_1)
		if arg_274_1.attacker and not arg_274_1.attacker.isPlayer and arg_274_1.attacker.identity == arg_273_1 and arg_274_1.attacker:getMarkLevel(134) > 0 then
			var_273_0 = var_273_0 + 1

			if arg_274_0.info.trigger_type_value <= var_273_0 then
				var_273_0 = 0

				return true
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100199(arg_275_0, arg_275_1, arg_275_2)
	return function(arg_276_0, arg_276_1)
		if arg_276_1.isAdd and (arg_276_1.markId == 135 or arg_276_1.markId == 136 or arg_276_1.markId == 137 or arg_276_1.markId == 138) and arg_275_2:getMarkLevel(loadCfg("core.config.cfg.skill_mark_info").get(arg_276_1.markId).type) == 5 then
			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100200(arg_277_0, arg_277_1, arg_277_2)
	return function(arg_278_0, arg_278_1)
		if not arg_278_1.attacker then
			return false
		end

		if arg_278_1.attacker.identity == arg_277_1 then
			return false
		end

		return arg_278_1.cfg.skill_type == 2 or arg_278_1.cfg.skill_type == 12
	end
end

function var_0_2._triggerTiming100201(arg_279_0, arg_279_1, arg_279_2)
	local var_279_0 = 0

	return function(arg_280_0, arg_280_1)
		if arg_280_0.info.trigger_type_value <= var_279_0 then
			return false
		end

		for iter_280_0, iter_280_1 in ipairs(arg_280_1) do
			if iter_280_1.victim.serialId == arg_279_2.serialId and iter_280_1.buffCfg.id == 26412 then
				var_279_0 = var_279_0 + 1

				return true
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100202(arg_281_0, arg_281_1, arg_281_2)
	local var_281_0 = 0

	return function(arg_282_0, arg_282_1)
		local var_282_0 = arg_282_0.info.trigger_type_value

		for iter_282_0, iter_282_1 in ipairs(arg_282_1) do
			if iter_282_1.victim.serialId == arg_281_2.serialId and iter_282_1.buffCfg.id == 26412 then
				var_281_0 = var_281_0 + 1

				return var_282_0 < var_281_0
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100203(arg_283_0, arg_283_1, arg_283_2)
	return function(arg_284_0, arg_284_1)
		for iter_284_0, iter_284_1 in ipairs(arg_284_1) do
			if iter_284_1.victim.identity == arg_283_1 and iter_284_1.buffId == arg_284_0.info.trigger_type_value then
				return true
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100204(arg_285_0, arg_285_1, arg_285_2)
	return function(arg_286_0, arg_286_1)
		for iter_286_0, iter_286_1 in ipairs((arg_285_0:getKnightList(3 - arg_285_1, nil))) do
			if iter_286_1:getBuffCount(366, true) > 0 then
				return false
			end
		end

		return true
	end
end

function var_0_2._triggerTiming100205(arg_287_0, arg_287_1, arg_287_2)
	return function(arg_288_0, arg_288_1)
		if arg_288_1.attacker.identity == arg_287_2.identity then
			return false
		end

		if arg_288_1.cfg.skill_type == 2 or arg_288_1.cfg.skill_type == 12 then
			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100206(arg_289_0, arg_289_1, arg_289_2)
	return function(arg_290_0, arg_290_1)
		if arg_290_1.victim.identity == arg_289_2.identity then
			return false
		end

		if arg_290_1.victim:getBuffCount(366, true) > 0 then
			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100207(arg_291_0, arg_291_1, arg_291_2)
	return function(arg_292_0, arg_292_1)
		if arg_292_1.victim.identity == arg_291_2.identity then
			return false
		end

		if arg_292_1.victim:getBuffCount(366, true) > 0 then
			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100208(arg_293_0, arg_293_1, arg_293_2)
	return function(arg_294_0, arg_294_1)
		return not arg_293_0:isKnightFight(arg_294_1.cfg)
	end
end

function var_0_2._triggerTiming100209(arg_295_0, arg_295_1, arg_295_2)
	local var_295_0 = 0

	return function(arg_296_0, arg_296_1)
		if arg_296_1.attacker:getBuffCount(1462, nil, nil) > 0 then
			var_295_0 = var_295_0 + 1

			if var_295_0 >= arg_296_0.info.trigger_type_value then
				var_295_0 = var_295_0 - arg_296_0.info.trigger_type_value

				return true
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100210(arg_297_0, arg_297_1, arg_297_2)
	return function(arg_298_0, arg_298_1)
		if arg_298_1.damage <= 0 then
			return false
		end

		if arg_298_1.victim:getBuffCount(1462, nil, nil) > 0 then
			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100211(arg_299_0, arg_299_1, arg_299_2)
	return function(arg_300_0, arg_300_1)
		if arg_300_1.damage <= 0 then
			return false
		end

		if arg_300_1.victim.advanceInfo.hpRate < arg_300_0.info.trigger_type_value and arg_300_1.victim:getBuffCount(1466, nil, nil) > 0 then
			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100212(arg_301_0, arg_301_1, arg_301_2)
	local var_301_0 = 0

	return function(arg_302_0, arg_302_1)
		if arg_302_1.damage <= 0 then
			return false
		end

		if arg_302_1.victim.serialId == arg_301_2.serialId then
			var_301_0 = var_301_0 + 1
		end

		if var_301_0 >= arg_302_0.info.trigger_type_value then
			var_301_0 = var_301_0 - arg_302_0.info.trigger_type_value

			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100213(arg_303_0, arg_303_1, arg_303_2)
	local var_303_0 = 0

	return function(arg_304_0, arg_304_1)
		if arg_304_1.damage <= 0 then
			return false
		end

		if arg_304_1.victim.identity == arg_303_1 and arg_304_1.victim:getBuffCount(1467, nil, nil) > 0 then
			var_303_0 = var_303_0 + 1
		end

		if var_303_0 >= arg_304_0.info.trigger_type_value then
			var_303_0 = var_303_0 - arg_304_0.info.trigger_type_value

			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100214(arg_305_0, arg_305_1, arg_305_2)
	return function(arg_306_0, arg_306_1)
		return arg_306_1.result.affectType == 1 and arg_306_1.result.damage > 0
	end
end

function var_0_2._triggerTiming100215(arg_307_0, arg_307_1, arg_307_2)
	return function(arg_308_0, arg_308_1)
		return arg_307_2:getBuffCount(arg_308_0.info.trigger_type_value) <= 0
	end
end

function var_0_2._triggerTiming100216(arg_309_0, arg_309_1, arg_309_2)
	return function(arg_310_0, arg_310_1)
		return arg_310_1 ~= arg_309_1 and arg_309_2:getBuffCount(arg_310_0.info.trigger_type_value) <= 0
	end
end

function var_0_2._triggerTiming100217(arg_311_0, arg_311_1, arg_311_2)
	return function(arg_312_0, arg_312_1)
		return arg_312_1 == arg_311_1 and arg_311_2:getBuffCount(arg_312_0.info.trigger_type_value) <= 0
	end
end

function var_0_2._triggerTiming100218(arg_313_0, arg_313_1, arg_313_2, arg_313_3)
	return function(arg_314_0, arg_314_1)
		return arg_313_3:getRoundCount() > arg_314_0.info.trigger_type_value
	end
end

function var_0_2._triggerTiming100219(arg_315_0, arg_315_1, arg_315_2, arg_315_3)
	return function(arg_316_0, arg_316_1)
		local var_316_0 = 0

		for iter_316_0, iter_316_1 in ipairs(arg_315_0:getKnightList(3 - arg_315_1, true)) do
			if iter_316_1:getBuffCount(1522) > 0 then
				var_316_0 = var_316_0 + 1
			end

			if arg_316_0.info.trigger_type_value <= var_316_0 then
				return true
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100220(arg_317_0, arg_317_1, arg_317_2, arg_317_3)
	local var_317_0 = 0

	return function(arg_318_0, arg_318_1)
		if arg_318_1.attacker.identity ~= arg_317_1 or arg_318_1.attacker:getBuffCount(2015) <= 0 then
			return false
		end

		var_317_0 = var_317_0 + 1

		if arg_318_0.info.trigger_type_value <= var_317_0 then
			var_317_0 = var_317_0 - arg_318_0.info.trigger_type_value

			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100221(arg_319_0, arg_319_1, arg_319_2, arg_319_3)
	local var_319_0 = 0

	return function(arg_320_0, arg_320_1)
		if arg_320_1.victim.serialId ~= arg_319_2.serialId then
			return false
		end

		var_319_0 = var_319_0 + 1

		if arg_320_0.info.trigger_type_value <= var_319_0 then
			var_319_0 = var_319_0 - arg_320_0.info.trigger_type_value

			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100222(arg_321_0, arg_321_1, arg_321_2, arg_321_3)
	return function(arg_322_0, arg_322_1)
		for iter_322_0, iter_322_1 in ipairs(arg_321_0:getKnightList(arg_321_1)) do
			if iter_322_1:getBuffCount(2023) > 0 or iter_322_1:getBuffCount(2024) > 0 then
				return true
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100223(arg_323_0, arg_323_1, arg_323_2, arg_323_3)
	return function(arg_324_0, arg_324_1)
		if arg_324_1.victim.identity ~= arg_323_1 then
			return false
		end

		return arg_324_1.victim:getBuffCount(2023) > 0 or arg_324_1.victim:getBuffCount(2024) > 0
	end
end

function var_0_2._triggerTiming100224(arg_325_0, arg_325_1, arg_325_2, arg_325_3)
	local var_325_0 = 0

	return function(arg_326_0, arg_326_1)
		if arg_326_1.victim.identity ~= arg_325_1 then
			return false
		end

		if arg_326_1.victim:getBuffCount(2023) <= 0 and arg_326_1.victim:getBuffCount(2024) <= 0 then
			return false
		end

		var_325_0 = var_325_0 + 1

		if arg_326_0.info.trigger_type_value <= var_325_0 then
			var_325_0 = var_325_0 - arg_326_0.info.trigger_type_value

			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100225(arg_327_0, arg_327_1, arg_327_2, arg_327_3)
	return function(arg_328_0, arg_328_1)
		if arg_328_1.attacker.identity ~= arg_327_1 then
			return false
		end

		return arg_328_1.attacker:getBuffCount(2023) > 0 or arg_328_1.attacker:getBuffCount(2024) > 0
	end
end

function var_0_2._triggerTiming100226(arg_329_0, arg_329_1, arg_329_2, arg_329_3)
	local var_329_0 = 0

	return function(arg_330_0, arg_330_1)
		if arg_330_1.attacker.identity ~= arg_329_1 then
			return false
		end

		var_329_0 = var_329_0 + 1

		if arg_330_0.info.trigger_type_value <= var_329_0 then
			var_329_0 = var_329_0 - arg_330_0.info.trigger_type_value

			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100227(arg_331_0, arg_331_1, arg_331_2, arg_331_3)
	return function(arg_332_0, arg_332_1)
		return arg_332_1.result.affectType == 1 and arg_332_1.result.block
	end
end

function var_0_2._triggerTiming100228(arg_333_0, arg_333_1, arg_333_2, arg_333_3)
	local var_333_0 = 0

	return function(arg_334_0, arg_334_1)
		if arg_334_1.victim.identity ~= arg_333_1 or arg_334_1.victim:getBuffCount(2027, nil, nil) <= 0 then
			return false
		end

		var_333_0 = var_333_0 + 1

		if arg_334_0.info.trigger_type_value <= var_333_0 then
			var_333_0 = var_333_0 - arg_334_0.info.trigger_type_value

			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100229(arg_335_0, arg_335_1, arg_335_2, arg_335_3)
	local var_335_0 = 0

	return function(arg_336_0, arg_336_1)
		local var_336_0 = arg_335_3:getAttackCount()

		if var_335_0 == var_336_0 then
			return false
		end

		for iter_336_0, iter_336_1 in ipairs(arg_336_1) do
			if iter_336_1.victim.identity ~= arg_335_1 and var_0_7.get(iter_336_1.buffId).buff_effect_type == 2028 then
				var_335_0 = var_336_0

				return true
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100230(arg_337_0, arg_337_1, arg_337_2, arg_337_3)
	local var_337_0 = 0
	local var_337_1

	return function(arg_338_0, arg_338_1)
		var_337_0 = var_337_0 + arg_338_1.damage
		var_337_1 = var_337_1 or math.floor(arg_338_1.attacker.advanceInfo.INITIAL_HP * arg_338_0.info.trigger_type_value / 1000)

		if var_337_0 >= var_337_1 then
			var_337_0 = var_337_0 - var_337_1

			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100231(arg_339_0, arg_339_1, arg_339_2, arg_339_3)
	local var_339_0 = 0

	return function(arg_340_0, arg_340_1)
		if arg_340_1.attacker.identity == arg_339_1 or arg_340_1.attacker:getBuffCount(2028) <= 0 then
			return false
		end

		var_339_0 = var_339_0 + 1

		if arg_340_0.info.trigger_type_value <= var_339_0 then
			var_339_0 = var_339_0 - arg_340_0.info.trigger_type_value

			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100232(arg_341_0, arg_341_1, arg_341_2, arg_341_3)
	return function(arg_342_0, arg_342_1)
		return arg_342_1.attacker.identity == arg_341_1 and arg_342_1.attacker:getBuffCount(arg_342_0.info.trigger_type_value) > 0
	end
end

function var_0_2._triggerTiming100233(arg_343_0, arg_343_1, arg_343_2, arg_343_3)
	local var_343_0 = 0

	return function(arg_344_0, arg_344_1)
		if arg_344_1.attacker.identity ~= arg_343_1 or arg_344_1.attacker:getBuffCount(2032) <= 0 then
			return false
		end

		var_343_0 = var_343_0 + 1

		if arg_344_0.info.trigger_type_value <= var_343_0 then
			var_343_0 = var_343_0 - arg_344_0.info.trigger_type_value

			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100234(arg_345_0, arg_345_1, arg_345_2, arg_345_3)
	return function(arg_346_0, arg_346_1)
		for iter_346_0, iter_346_1 in ipairs(arg_346_1) do
			if iter_346_1.victim.serialId == arg_345_2.serialId and iter_346_1.victim.identity == arg_345_1 and iter_346_1.buffCfg.buff_effect_type == arg_346_0.info.trigger_type_value then
				return true
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100235(arg_347_0, arg_347_1, arg_347_2, arg_347_3)
	local var_347_0 = 0

	return function(arg_348_0, arg_348_1)
		if arg_348_1.victim.identity ~= arg_347_1 or arg_348_1.victim:getBuffCount(2038, nil, nil) <= 0 then
			return false
		end

		var_347_0 = var_347_0 + 1

		if arg_348_0.info.trigger_type_value <= var_347_0 then
			var_347_0 = var_347_0 - arg_348_0.info.trigger_type_value

			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100236(arg_349_0, arg_349_1, arg_349_2, arg_349_3)
	local var_349_0 = 0

	return function(arg_350_0, arg_350_1)
		if not arg_350_1.isAdd or arg_350_1.markId ~= 145 then
			return
		end

		var_349_0 = var_349_0 + arg_350_1.addValue

		if arg_350_0.info.trigger_type_value <= var_349_0 then
			var_349_0 = var_349_0 - arg_350_0.info.trigger_type_value

			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100237(arg_351_0, arg_351_1, arg_351_2, arg_351_3)
	return function(arg_352_0, arg_352_1)
		if arg_352_1.knight.serialId ~= arg_351_2.serialId then
			return false
		end

		for iter_352_0, iter_352_1 in ipairs(arg_352_1.buffInfoList or {}) do
			if iter_352_1.buff_type == 2 then
				return true
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100240(arg_353_0, arg_353_1, arg_353_2, arg_353_3)
	return function(arg_354_0, arg_354_1)
		return arg_354_1.attacker.serialId == arg_353_2.serialId and arg_354_1.cfg.skill_type == 32
	end
end

function var_0_2._triggerTiming100241(arg_355_0, arg_355_1, arg_355_2, arg_355_3)
	local var_355_0 = 0
	local var_355_1 = 0
	local var_355_2 = false

	return function(arg_356_0, arg_356_1)
		local var_356_0 = arg_355_3:getRoundCount()

		if var_356_0 ~= var_355_1 then
			var_355_1 = var_356_0
			var_355_2 = false
			var_355_0 = 0

			return false
		end

		if var_355_2 then
			return false
		else
			var_355_0 = var_355_0 + arg_356_1

			if math.floor(arg_355_2.originInfo.INITIAL_HP * arg_356_0.info.trigger_type_value * 0.001) <= var_355_0 then
				var_355_2 = true

				return true
			end

			return false
		end
	end
end

function var_0_2._triggerTiming100242(arg_357_0, arg_357_1, arg_357_2, arg_357_3)
	return function(arg_358_0, arg_358_1)
		if arg_358_1.damage == 0 then
			return false
		end

		if arg_358_1.victim.serialId ~= arg_357_2.serialId then
			return false
		end

		return arg_358_1.attacker.classical > 0
	end
end

function var_0_2._triggerTiming100243(arg_359_0, arg_359_1, arg_359_2)
	return function(arg_360_0, arg_360_1)
		if arg_359_1 == arg_360_1.identity then
			if arg_360_1.originInfo.pos >= 1 and arg_360_1.originInfo.pos <= 3 and arg_360_1.advanceInfo.hpRate <= arg_360_0.info.trigger_type_value then
				return true
			end

			return false
		end
	end
end

function var_0_2._triggerTiming100244(arg_361_0, arg_361_1, arg_361_2, arg_361_3)
	local var_361_0 = 0
	local var_361_1 = 3 - arg_361_1

	return function(arg_362_0, arg_362_1)
		for iter_362_0, iter_362_1 in ipairs(arg_362_1) do
			if iter_362_1.victim.identity == var_361_1 and var_0_7.get(iter_362_1.buffId).buff_control_type == 1 then
				var_361_0 = var_361_0 + 1
			end
		end

		if arg_362_0.info.trigger_type_value <= var_361_0 then
			var_361_0 = var_361_0 - arg_362_0.info.trigger_type_value

			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100250(arg_363_0, arg_363_1, arg_363_2, arg_363_3)
	local var_363_0 = 0

	return function(arg_364_0, arg_364_1)
		if var_363_0 == arg_363_3:getAttackCount() then
			return false
		end

		var_363_0 = arg_363_3:getAttackCount()

		return true
	end
end

function var_0_2._triggerTiming100251(arg_365_0, arg_365_1, arg_365_2, arg_365_3)
	return function(arg_366_0, arg_366_1)
		for iter_366_0, iter_366_1 in ipairs(arg_366_1) do
			local var_366_0 = iter_366_1.victim
			local var_366_1 = var_0_7.get(iter_366_1.buffId)

			if iter_366_1.victim.serialId == arg_365_2.serialId then
				if var_366_1.buff_effect_type == 2102 then
					return var_366_0:getBuffCount(2103) > 0 or var_366_0:getBuffCount(2104) > 0
				elseif var_366_1.buff_effect_type == 2103 then
					return var_366_0:getBuffCount(2102) > 0 or var_366_0:getBuffCount(2104) > 0
				elseif var_366_1.buff_effect_type == 2104 then
					return var_366_0:getBuffCount(2102) > 0 or var_366_0:getBuffCount(2103) > 0
				end
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100252(arg_367_0, arg_367_1, arg_367_2, arg_367_3)
	local var_367_0 = 0

	return function(arg_368_0, arg_368_1)
		if arg_368_1.victim.identity ~= arg_367_1 then
			return false
		end

		local var_368_0 = arg_368_0.info.trigger_type_value

		if arg_368_1.effectType == 206 then
			var_367_0 = var_367_0 + arg_368_1.effectValue

			if var_368_0 <= var_367_0 then
				var_367_0 = var_367_0 - var_368_0

				return true
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100255(arg_369_0, arg_369_1, arg_369_2, arg_369_3)
	local var_369_0 = 0

	return function(arg_370_0, arg_370_1)
		if arg_370_1.victim.identity ~= arg_369_1 then
			return false
		end

		var_369_0 = var_369_0 + 1

		if arg_370_0.info.trigger_type_value <= var_369_0 then
			var_369_0 = var_369_0 - arg_370_0.info.trigger_type_value

			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100256(arg_371_0, arg_371_1, arg_371_2, arg_371_3)
	return function(arg_372_0, arg_372_1)
		local var_372_0 = loadCfg("core.config.cfg.buff_info")

		for iter_372_0, iter_372_1 in ipairs(arg_372_1) do
			local var_372_1 = var_372_0.get(iter_372_1.buffId)

			if var_372_1.buff_type == var_0_5.TYPE.ACT_LIMIT or var_372_1.buff_type == var_0_5.TYPE.SKILL_CHOOSE or var_372_1.buff_control_type == 1 then
				return true
			end
		end

		return false
	end
end

function var_0_2:_triggerTiming100257(arg_373_1, arg_373_2, arg_373_3)
	local var_373_0 = 0
	local var_373_1 = 0

	for iter_373_0, iter_373_1 in self:getKnights():ipairs(arg_373_1) do
		var_373_1 = var_373_1 + iter_373_1.originInfo.INITIAL_HP
	end

	return function(arg_374_0, arg_374_1)
		if arg_374_1.victim.identity == arg_373_1 then
			var_373_0 = var_373_0 + arg_374_1.damage
		end

		if math.floor(arg_374_0.info.trigger_type_value * var_373_1 / 1000) <= var_373_0 then
			var_373_0 = 0

			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100258(arg_375_0, arg_375_1, arg_375_2)
	return function(arg_376_0, arg_376_1)
		return arg_376_1.victim.opIdentity == arg_375_1
	end
end

function var_0_2._triggerTiming100259(arg_377_0, arg_377_1, arg_377_2)
	return function(arg_378_0, arg_378_1)
		local var_378_0 = 0

		for iter_378_0, iter_378_1 in ipairs((arg_377_0:getKnightList(3 - arg_377_1, nil))) do
			if iter_378_1:getBuffCount(2221) > 0 then
				var_378_0 = var_378_0 + 1

				if arg_378_0.info.trigger_type_value <= var_378_0 then
					return true
				end
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100260(arg_379_0, arg_379_1, arg_379_2, arg_379_3)
	local var_379_0 = 3 - arg_379_1

	return function(arg_380_0, arg_380_1)
		for iter_380_0, iter_380_1 in ipairs(arg_380_1) do
			if iter_380_1.victim.identity == var_379_0 and (iter_380_1.buffId == 27716 or iter_380_1.buffId == 27717 or iter_380_1.buffId == 27718) then
				return true
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100261(arg_381_0, arg_381_1, arg_381_2)
	return function(arg_382_0, arg_382_1)
		return arg_382_1.victim.identity == arg_381_1 and arg_381_2.classical == arg_382_0.info.trigger_type_value
	end
end

function var_0_2._triggerTiming100262(arg_383_0, arg_383_1, arg_383_2)
	local var_383_0 = 3 - arg_383_1
	local var_383_1 = 0

	return function(arg_384_0, arg_384_1)
		for iter_384_0, iter_384_1 in ipairs(arg_384_1.buffInfoList) do
			if arg_384_1.knight.identity == var_383_0 and iter_384_1.buff_effect_type == 2226 then
				var_383_1 = var_383_1 + 1
			end
		end

		if arg_384_0.info.trigger_type_value <= var_383_1 then
			var_383_1 = var_383_1 - arg_384_0.info.trigger_type_value

			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100263(arg_385_0, arg_385_1, arg_385_2)
	return function(arg_386_0, arg_386_1)
		if arg_386_1.attackId then
			local var_386_0 = loadCfg("core.config.cfg.skill_info").get(arg_386_1.attackId)

			if var_386_0 and (var_386_0.skill_type == 32 or var_386_0.skill_type == 12) then
				return true
			end
		end

		return false
	end
end

function var_0_2:_triggerTiming100264(arg_387_1, arg_387_2)
	local var_387_0 = 0
	local var_387_1 = 0

	for iter_387_0, iter_387_1 in ipairs((self:getKnightList(arg_387_1, nil))) do
		var_387_1 = var_387_1 + iter_387_1.originInfo.INITIAL_HP
	end

	return function(arg_388_0, arg_388_1)
		if arg_388_1.victim.identity == arg_387_1 then
			var_387_0 = var_387_0 + arg_388_1.changeValue

			return math.floor(var_387_1 * arg_388_0.info.trigger_type_value * 0.001) <= var_387_0
		end
	end
end

function var_0_2._triggerTiming100265(arg_389_0, arg_389_1, arg_389_2, arg_389_3)
	local var_389_0 = -1

	return function(arg_390_0, arg_390_1)
		if arg_390_1 and arg_390_1.cfg then
			if arg_390_1.attacker and arg_390_1.attacker.identity == arg_389_1 and arg_390_1.cfg.skill_type == 6 and arg_390_1.cfg.belong_advance_id == 10700570 then
				var_389_0 = arg_389_3:getRoundCount()
			end
		elseif var_389_0 ~= -1 and arg_389_3:getRoundCount() - var_389_0 < arg_390_0.info.trigger_type_value then
			local var_390_0 = {
				0,
				0
			}
			local var_390_1 = {
				0,
				0
			}

			for iter_390_0, iter_390_1 in ipairs((arg_389_0:getKnightList(arg_389_1, nil))) do
				var_390_0[1] = var_390_0[1] + iter_390_1.advanceInfo.SHIELD
				var_390_0[2] = var_390_0[2] + iter_390_1.baseInfo.INITIAL_HP
			end

			for iter_390_2, iter_390_3 in ipairs((arg_389_0:getKnightList(3 - arg_389_1, nil))) do
				var_390_1[1] = var_390_1[1] + iter_390_3.advanceInfo.SHIELD
				var_390_1[2] = var_390_1[2] + iter_390_3.baseInfo.INITIAL_HP
			end

			return var_390_0[1] / var_390_0[2] > var_390_1[1] / var_390_1[2]
		end
	end
end

function var_0_2._triggerTiming100266(arg_391_0, arg_391_1, arg_391_2, arg_391_3)
	local var_391_0 = -1

	return function(arg_392_0, arg_392_1)
		if arg_392_1 and arg_392_1.cfg then
			if arg_392_1.attacker and arg_392_1.attacker.identity == arg_391_1 and arg_392_1.cfg.skill_type == 6 and arg_392_1.cfg.belong_advance_id == 10700570 then
				var_391_0 = arg_391_3:getRoundCount()
			end
		elseif var_391_0 ~= -1 and arg_391_3:getRoundCount() - var_391_0 < arg_392_0.info.trigger_type_value then
			local var_392_0 = {
				0,
				0
			}
			local var_392_1 = {
				0,
				0
			}

			for iter_392_0, iter_392_1 in ipairs((arg_391_0:getKnightList(arg_391_1, nil))) do
				var_392_0[1] = var_392_0[1] + iter_392_1.advanceInfo.SHIELD
				var_392_0[2] = var_392_0[2] + iter_392_1.baseInfo.INITIAL_HP
			end

			for iter_392_2, iter_392_3 in ipairs((arg_391_0:getKnightList(3 - arg_391_1, nil))) do
				var_392_1[1] = var_392_1[1] + iter_392_3.advanceInfo.SHIELD
				var_392_1[2] = var_392_1[2] + iter_392_3.baseInfo.INITIAL_HP
			end

			return var_392_0[1] / var_392_0[2] <= var_392_1[1] / var_392_1[2]
		end
	end
end

function var_0_2._triggerTiming100267(arg_393_0, arg_393_1, arg_393_2)
	return function(arg_394_0, arg_394_1)
		if arg_394_1.attacker.advId == arg_394_0.info.trigger_type_value then
			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100268(arg_395_0, arg_395_1, arg_395_2)
	local var_395_0 = 0

	return function(arg_396_0, arg_396_1)
		for iter_396_0, iter_396_1 in ipairs(arg_396_1) do
			if iter_396_1.victim.identity == arg_395_1 and var_0_7.get(iter_396_1.buffId).buff_type == 1002 then
				var_395_0 = var_395_0 + 1

				if arg_396_0.info.trigger_type_value <= var_395_0 then
					return true
				end
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100269(arg_397_0, arg_397_1, arg_397_2)
	return function(arg_398_0)
		return true
	end
end

function var_0_2._triggerTiming100270(arg_399_0, arg_399_1, arg_399_2, arg_399_3)
	return function(arg_400_0, arg_400_1)
		local var_400_0 = 0

		for iter_400_0, iter_400_1 in ipairs((arg_399_3:getBattleData():getKnightList(arg_399_1, true))) do
			if iter_400_1.isDead then
				var_400_0 = var_400_0 + 1
			end
		end

		if var_400_0 >= arg_400_0.info.trigger_type_value then
			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100271(arg_401_0, arg_401_1, arg_401_2, arg_401_3)
	local var_401_0 = 0

	return function(arg_402_0, arg_402_1)
		if arg_402_1.victim.identity ~= arg_401_1 or arg_402_1.damage == 0 then
			return false
		end

		local var_402_0 = arg_402_0.info.trigger_type_value

		var_401_0 = var_401_0 + 1

		if var_402_0 <= var_401_0 then
			var_401_0 = var_401_0 - var_402_0

			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100272(arg_403_0, arg_403_1, arg_403_2)
	return function(arg_404_0, arg_404_1)
		return arg_404_1.victim.serialId == arg_403_2.serialId and arg_404_1.victim:getHpRate() >= arg_404_0.info.trigger_type_value
	end
end

function var_0_2._triggerTiming100273(arg_405_0, arg_405_1, arg_405_2)
	return function(arg_406_0, arg_406_1)
		return arg_406_1.victim.serialId == arg_405_2.serialId and arg_406_1.victim:getHpRate() < arg_406_0.info.trigger_type_value
	end
end

function var_0_2._triggerTiming100274(arg_407_0, arg_407_1, arg_407_2)
	return function(arg_408_0, arg_408_1)
		if not arg_408_1 then
			return false
		end

		for iter_408_0, iter_408_1 in ipairs(arg_408_1.result) do
			if not iter_408_1.crit then
				return true
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100275(arg_409_0, arg_409_1, arg_409_2)
	local var_409_0 = 0
	local var_409_1 = 3 - arg_409_1

	return function(arg_410_0, arg_410_1)
		for iter_410_0, iter_410_1 in ipairs(arg_410_1.buffInfoList) do
			if arg_410_1.knight.identity == var_409_1 and iter_410_1.buff_effect_type == 10001 then
				var_409_0 = var_409_0 + 1
			end
		end

		if arg_410_0.info.trigger_type_value <= var_409_0 then
			var_409_0 = var_409_0 - arg_410_0.info.trigger_type_value

			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100276(arg_411_0, arg_411_1, arg_411_2)
	return function(arg_412_0)
		return true
	end
end

function var_0_2._triggerTiming100277(arg_413_0, arg_413_1, arg_413_2)
	return function(arg_414_0, arg_414_1)
		return arg_414_1.identity == arg_413_1 and arg_414_1.victim.classical == arg_414_0.info.trigger_type_value
	end
end

function var_0_2._triggerTiming100278(arg_415_0, arg_415_1, arg_415_2)
	return function(arg_416_0, arg_416_1)
		if not arg_416_1.cfg then
			return false
		end

		local var_416_0 = arg_416_1.cfg.skill_type

		if arg_416_1.cfg.skill_type ~= 1 and var_416_0 ~= 2 and var_416_0 ~= 12 then
			return false
		end

		if arg_415_0:isKnightFight(arg_416_1.cfg) and arg_416_0.info.trigger_type_value <= arg_415_2:getMarkLevel(154) then
			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100279(arg_417_0, arg_417_1, arg_417_2, arg_417_3)
	local var_417_0 = -1
	local var_417_1 = 0

	return function(arg_418_0, arg_418_1)
		local var_418_0 = var_0_1.get(arg_418_0.info.trigger_type_value, 4)

		if arg_418_1 and arg_418_1.cfg then
			if arg_418_1.attacker and arg_418_1.attacker.identity == arg_417_1 and arg_418_1.cfg.skill_type == 3 and arg_418_1.attacker.advId == var_418_0.value_1 then
				var_417_0 = arg_417_3:getRoundCount()
				var_417_1 = 0
			end

			return false
		end

		if var_417_0 == -1 then
			return false
		end

		if arg_417_3:getRoundCount() - var_417_0 >= var_418_0.value_2 then
			var_417_0 = -1
			var_417_1 = 0

			return false
		end

		if not arg_418_1.victim or arg_418_1.victim.identity == arg_417_1 then
			return false
		end

		if arg_418_1.effectType == 206 or arg_418_1.effectType == 13 then
			var_417_1 = var_417_1 + ((not arg_418_1.effectValue or nil) and 0)

			if var_417_1 >= var_418_0.value_3 then
				var_417_1 = var_417_1 - var_418_0.value_3

				return true
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100280(arg_419_0, arg_419_1, arg_419_2, arg_419_3)
	return function(arg_420_0, arg_420_1)
		for iter_420_0, iter_420_1 in ipairs(arg_420_1) do
			local var_420_0 = var_0_7.get(iter_420_1.buffId)

			if iter_420_1.victim.identity == arg_419_1 and (var_420_0.buff_type == var_0_5.TYPE.ACT_LIMIT or var_420_0.buff_type == var_0_5.TYPE.SKILL_CHOOSE or var_420_0.buff_control_type == 1) and arg_419_3:bingo(arg_420_0.info.trigger_type_value) then
				return true
			end
		end

		return false
	end
end

function var_0_2._triggerTiming100281(arg_421_0, arg_421_1, arg_421_2, arg_421_3)
	return function(arg_422_0, arg_422_1)
		local var_422_0 = arg_421_0:getKnightList(arg_421_1, nil, arg_421_2)

		if not var_422_0 or #var_422_0 == 0 then
			return false
		end

		for iter_422_0, iter_422_1 in ipairs(var_422_0) do
			if iter_422_1:getBuffCount(10, true) <= 0 then
				return false
			end
		end

		return true
	end
end

function var_0_2._triggerTiming100282(arg_423_0, arg_423_1, arg_423_2, arg_423_3)
	return function(arg_424_0, arg_424_1)
		return arg_423_2:getBuffCount(2380) >= arg_424_0.info.trigger_type_value
	end
end

function var_0_2._triggerTiming100283(arg_425_0, arg_425_1, arg_425_2, arg_425_3)
	local var_425_0 = 0

	return function(arg_426_0, arg_426_1)
		if not arg_426_1.attacker or arg_425_2.serialId ~= arg_426_1.attacker.serialId then
			return false
		end

		local var_426_0 = arg_426_1.skillInfo

		if not arg_426_1.skillInfo then
			return false
		end

		local var_426_1 = var_426_0.skill_type

		if var_426_0.skill_type ~= 1 and var_426_1 ~= 2 and var_426_1 ~= 12 and var_426_1 ~= 32 then
			return false
		end

		local var_426_2 = false

		if arg_426_1.attackInfos then
			for iter_426_0, iter_426_1 in ipairs(arg_426_1.attackInfos) do
				if iter_426_1.victim and iter_426_1.victim.isDead and iter_426_1.victim.identity == arg_426_1.attacker.opIdentity then
					var_426_2 = true

					break
				end
			end
		end

		if var_426_2 then
			return false
		end

		var_425_0 = var_425_0 + 1

		if arg_426_0.info.trigger_type_value <= var_425_0 then
			var_425_0 = var_425_0 - arg_426_0.info.trigger_type_value

			return true
		end

		return false
	end
end

function var_0_2._triggerTiming100284(arg_427_0, arg_427_1, arg_427_2, arg_427_3)
	return function(arg_428_0, arg_428_1)
		if not arg_428_1 then
			return false
		end

		local var_428_0 = arg_428_1.buffInfo

		if not arg_428_1.buffInfo then
			return false
		end

		if var_428_0.buff_effect_type ~= arg_428_0.info.trigger_type_value then
			return false
		end

		return true
	end
end

function var_0_2._triggerTiming100285(arg_429_0, arg_429_1, arg_429_2, arg_429_3)
	return function(arg_430_0, arg_430_1)
		local var_430_0 = arg_430_1 and arg_430_1.victim

		if not (arg_430_1 and arg_430_1.victim) then
			return false
		end

		if var_430_0.identity ~= arg_429_1 then
			return false
		end

		return var_430_0:getBuffCount(arg_430_0.info.trigger_type_value) > 0
	end
end

function var_0_2._triggerTiming100286(arg_431_0, arg_431_1, arg_431_2)
	return function(arg_432_0, arg_432_1)
		if arg_432_1.attacker.identity == arg_431_1 and arg_432_1.attacker.skillCfg.skill_type == 3 then
			return true
		end
	end
end

function var_0_2:_initSpEffectType1()
	local var_433_0 = self.spEffectInfo.special_skill_value_1

	return function(arg_434_0)
		arg_434_0 = arg_434_0 + var_433_0

		return arg_434_0
	end
end

function var_0_2:_initSpEffectType2()
	local var_435_0 = loadCfg("core.config.cfg.skill_enchant_info").get(self.spEffectInfo.special_skill_value_1)

	return function(arg_436_0)
		var_0_3(arg_436_0, var_435_0)

		return arg_436_0
	end
end

function var_0_2:_initSpEffectType1001()
	local var_437_0 = self.spEffectInfo
	local var_437_1 = self.knight
	local var_437_2 = self.spEffectInfo.special_skill_value_1

	return function(arg_438_0)
		local var_438_0 = math.floor(arg_438_0.damage * var_437_2 / 1000)
		local var_438_1

		if var_437_0.special_skill_value_2 > 0 then
			var_438_0 = math.min(var_438_0, math.floor(var_437_0.special_skill_value_2 * var_437_1.originInfo.INITIAL_HP / 1000))
			var_438_1 = {
				affectType = 1,
				damage = var_438_0
			}
		end

		var_438_1.victim = arg_438_0.attacker
		var_438_1.attacker = self.knight

		var_0_3(arg_438_0.hitBackList, var_438_1)

		return arg_438_0
	end
end

function var_0_2:_initSpEffectType1002()
	local var_439_0 = self.spEffectInfo.special_skill_value_1

	return function(arg_440_0)
		var_0_3(arg_440_0.recoverList, {
			affectType = 2,
			damage = math.floor(arg_440_0.damage * var_439_0 / 1000),
			victim = self.knight,
			attacker = self.knight
		})

		return arg_440_0
	end
end

function var_0_2:_initSpEffectType1003()
	local var_441_0 = self.spEffectInfo.special_skill_value_1
	local var_441_1 = self.battleField
	local var_441_2 = math.floor(self.spEffectInfo.special_skill_value_2 * self.knight.originInfo.INITIAL_HP / 1000)
	local var_441_3 = self.knight.identity

	return function(arg_442_0)
		local var_442_0 = var_441_1:getBattleData():getKnightList(3 - var_441_3)
		local var_442_1 = math.min(math.floor(arg_442_0.damage * var_441_0 / 1000), var_441_2)

		var_441_2 = var_441_2 - var_442_1

		if var_442_1 > 0 then
			for iter_442_0, iter_442_1 in ipairs(var_442_0) do
				var_0_3(arg_442_0.hitBackInfo, {
					victim = iter_442_1,
					damage = math.floor(var_442_1 / #var_442_0)
				})
			end
		end

		return arg_442_0
	end
end

function var_0_2:_initSpEffectType1004()
	local var_443_0 = self.spEffectInfo

	return function(arg_444_0, arg_444_1)
		if arg_444_1.buffInfo.buff_effect_type == var_443_0.special_skill_value_2 then
			if arg_444_1.firstResults then
				return arg_444_0 + (6 - #arg_444_1.firstResults) * var_443_0.special_skill_value_1
			end
		end

		return arg_444_0
	end
end

function var_0_2:_initSpEffectType1005()
	local var_445_0 = self.spEffectInfo

	return function(arg_446_0, arg_446_1)
		if arg_446_1.buffInfo.buff_effect_type == var_445_0.special_skill_value_1 then
			return arg_446_0 + var_445_0.special_skill_value_2
		end

		return arg_446_0
	end
end

function var_0_2:_initSpEffectType1006()
	local var_447_0 = self.spEffectInfo

	return function(arg_448_0)
		return arg_448_0 + var_447_0.special_skill_value_1
	end
end

function var_0_2:_initSpEffectType1007()
	local var_449_0 = self.spEffectInfo

	return function(arg_450_0)
		return arg_450_0 + var_449_0.special_skill_value_1
	end
end

function var_0_2:_initSpEffectType1008()
	local var_451_0 = self.spEffectInfo

	return function(arg_452_0, arg_452_1)
		if var_451_0.special_skill_value_2 == arg_452_1.buffInfo.buff_effect_type then
			return arg_452_0 + var_451_0.special_skill_value_1
		end

		return arg_452_0
	end
end

function var_0_2:_initSpEffectType1009()
	local var_453_0 = self.spEffectInfo
	local var_453_1 = self.battleField
	local var_453_2 = 0
	local var_453_3 = self.spEffectInfo.special_skill_value_1

	return function(arg_454_0, arg_454_1)
		local var_454_0 = var_453_1:getAttackCount()

		if var_453_2 ~= var_454_0 then
			var_453_3 = var_453_0.special_skill_value_1
			var_453_2 = var_454_0
		end

		local var_454_1 = math.min(var_453_3, arg_454_1.anger)

		var_453_3 = var_453_3 - var_454_1

		return arg_454_0 + var_454_1
	end
end

function var_0_2:_initSpEffectType1010()
	local var_455_0 = self.battleField
	local var_455_1 = 0
	local var_455_2 = math.floor(self.spEffectInfo.special_skill_value_1 * self.knight.originInfo.INITIAL_HP / 1000)
	local var_455_3 = var_455_2

	return function(arg_456_0)
		local var_456_0 = var_455_0:getRoundCount()

		if var_456_0 ~= var_455_1 then
			var_455_1 = var_456_0
			var_455_3 = var_455_2
		end

		if arg_456_0 < var_455_3 then
			var_455_3 = var_455_3 - arg_456_0
		else
			arg_456_0 = var_455_3
			var_455_3 = 0
		end

		return arg_456_0
	end
end

function var_0_2:_initSpEffectType1011()
	local var_457_0 = self.spEffectInfo

	return function(arg_458_0)
		var_0_3(arg_458_0, {
			num = 1,
			markId = var_457_0.special_skill_value_1
		})

		return arg_458_0
	end
end

function var_0_2:_initSpEffectType1012()
	local var_459_0 = self.spEffectInfo
	local var_459_1 = self.knight

	return function(arg_460_0)
		return arg_460_0 + math.floor(var_459_0.special_skill_value_1 * (var_459_1.advanceInfo.PHY_DEFENCE + var_459_1.advanceInfo.MAG_DEFENCE) / 2000)
	end
end

function var_0_2:_initSpEffectType1013()
	local var_461_0 = self.spEffectInfo

	return function(arg_462_0)
		return arg_462_0 + var_461_0.special_skill_value_1
	end
end

function var_0_2:_initSpEffectType1014()
	local var_463_0 = self.battleField
	local var_463_1 = self.spEffectInfo
	local var_463_2 = self.knight

	return function(arg_464_0)
		local var_464_0 = {}

		for iter_464_0, iter_464_1 in ipairs((var_463_2:getBuffs())) do
			if iter_464_1.buffCfg.buff_type == var_0_5.TYPE.ATTR and iter_464_1.buffCfg.buff_increase_type == 2 and not iter_464_1.buffCheckSkill then
				var_0_3(var_464_0, iter_464_1)
			end
		end

		while var_463_1.special_skill_value_1 < #var_464_0 do
			table.remove(var_464_0, (var_463_0:boundedRandom(1, #var_464_0)))
		end

		return var_464_0
	end
end

function var_0_2:_initSpEffectType1015()
	local var_465_0 = self.spEffectInfo
	local var_465_1 = self.knight

	return function(arg_466_0)
		return arg_466_0 + math.floor(var_465_0.special_skill_value_1 * var_465_1.advanceInfo.ATTACK / 1000)
	end
end

function var_0_2:_initSpEffectType1016()
	local var_467_0 = self.battleField
	local var_467_1 = self.spEffectInfo

	return function(arg_468_0, arg_468_1)
		if arg_468_1.isPlayer then
			return {}
		end

		local var_468_0 = var_467_1.special_skill_value_1
		local var_468_1 = {}

		for iter_468_0, iter_468_1 in ipairs((arg_468_1:getBuffs())) do
			if iter_468_1.buffCfg.buff_type == var_0_5.TYPE.ATTR and iter_468_1.buffCfg.buff_increase_type == 1 and not iter_468_1.buffCheckSkill and iter_468_1.buffCfg.not_clear == 0 and var_467_1.special_skill_value_2 >= iter_468_1.level then
				var_0_3(var_468_1, iter_468_1)
			end
		end

		while var_468_0 < #var_468_1 do
			table.remove(var_468_1, (var_467_0:boundedRandom(1, #var_468_1)))
		end

		return var_468_1
	end
end

function var_0_2:_initSpEffectType1017()
	local var_469_0 = self.spEffectInfo

	return function(arg_470_0)
		table.insert(arg_470_0, {
			id = var_469_0.special_skill_value_1,
			time = var_469_0.special_skill_value_2
		})

		return arg_470_0
	end
end

function var_0_2._triggerTiming200000(arg_471_0, arg_471_1, arg_471_2, arg_471_3)
	local var_471_0 = 0

	return function(arg_472_0, arg_472_1)
		if arg_472_1.victim.identity ~= arg_471_1 or arg_472_1.victim.classical ~= 1 then
			return false
		end

		local var_472_0 = arg_472_0.info.trigger_type_value

		var_471_0 = var_471_0 + 1

		if var_472_0 <= var_471_0 then
			var_471_0 = var_471_0 - var_472_0

			return true
		end

		return false
	end
end

function var_0_2._triggerTiming200001(arg_473_0, arg_473_1, arg_473_2, arg_473_3)
	local var_473_0 = 0

	return function(arg_474_0, arg_474_1)
		if arg_474_1.attacker.identity ~= arg_473_1 or arg_474_1.attacker.classical ~= 2 then
			return false
		end

		local var_474_0 = arg_474_0.info.trigger_type_value

		var_473_0 = var_473_0 + 1

		if var_474_0 <= var_473_0 then
			var_473_0 = var_473_0 - var_474_0

			return true
		end

		return false
	end
end

function var_0_2._triggerTiming200002(arg_475_0, arg_475_1, arg_475_2, arg_475_3)
	local var_475_0 = 0

	return function(arg_476_0, arg_476_1)
		if arg_476_1.attacker.identity ~= arg_475_1 or arg_476_1.attacker.classical ~= 3 then
			return false
		end

		local var_476_0 = arg_476_0.info.trigger_type_value

		var_475_0 = var_475_0 + 1

		if var_476_0 <= var_475_0 then
			var_475_0 = var_475_0 - var_476_0

			return true
		end

		return false
	end
end

function var_0_2._triggerTiming200003(arg_477_0, arg_477_1, arg_477_2, arg_477_3)
	local var_477_0 = 0

	return function(arg_478_0, arg_478_1)
		if arg_478_1.victim.identity ~= arg_477_1 or arg_478_1.victim.classical ~= 5 or arg_478_1.damage == 0 then
			return false
		end

		local var_478_0 = arg_478_0.info.trigger_type_value

		var_477_0 = var_477_0 + 1

		if var_478_0 <= var_477_0 then
			var_477_0 = var_477_0 - var_478_0

			return true
		end

		return false
	end
end

function var_0_2._triggerTiming200004(arg_479_0, arg_479_1, arg_479_2, arg_479_3)
	local var_479_0 = 0

	return function(arg_480_0, arg_480_1)
		if arg_480_1.victim.identity ~= arg_479_1 or arg_480_1.victim.classical ~= 4 then
			return false
		end

		local var_480_0 = arg_480_0.info.trigger_type_value

		if arg_480_1.effectType == 206 then
			var_479_0 = var_479_0 + arg_480_1.effectValue

			if var_480_0 <= var_479_0 then
				var_479_0 = var_479_0 - var_480_0

				return true
			end
		end

		return false
	end
end

function var_0_2._triggerTiming200006(arg_481_0, arg_481_1, arg_481_2, arg_481_3)
	return function(arg_482_0, arg_482_1)
		local var_482_0 = 0

		for iter_482_0, iter_482_1 in arg_481_0:getKnights():ipairs(arg_481_1) do
			if iter_482_1:isValid(arg_481_2) and iter_482_1:getMarkLevel(145) > 0 then
				var_482_0 = var_482_0 + 1
			end
		end

		return var_482_0 >= arg_482_0.info.trigger_type_value
	end
end

function var_0_2._triggerTiming200007(arg_483_0, arg_483_1, arg_483_2, arg_483_3)
	local var_483_0 = 0

	return function(arg_484_0, arg_484_1)
		if arg_484_1.attacker.identity == arg_483_1 then
			return false
		end

		var_483_0 = var_483_0 + 1

		if arg_484_0.info.trigger_type_value <= var_483_0 then
			var_483_0 = var_483_0 - arg_484_0.info.trigger_type_value

			return true
		end

		return false
	end
end

return var_0_2
