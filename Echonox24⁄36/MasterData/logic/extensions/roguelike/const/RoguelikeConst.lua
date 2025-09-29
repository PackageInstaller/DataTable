-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/const/RoguelikeConst.lua

module("logic.extensions.roguelike.const.RoguelikeConst", package.seeall)

local M = {}

M.IsPreloadScene = true

function M.IsGuildMode()
	return GuideController.instance:isGuiding()
end

function M.IsGuideFinish()
	local stepId = RoguelikeConfig.instance:getConstByName("GuideModelFinishStep").numValue
	local isFinish = GuideModel.instance:isGuideFinish(stepId)

	return isFinish
end

function M.IsAllowStory(storyId)
	if M.ReadPlayedStory() then
		return true
	end

	return not M.GetStoryPlayed(storyId)
end

local kSaveRoguePlot = "kSaveRoguePlot"
local kReadPlayedStory = "kReadPlayedStory"
local kReadedStory = "kReadedStory"
local kEventJudgeQuick = "kEventJudgeQuick"

function M.GetStoryPlayed(storyId)
	if storyId and storyId ~= "" and storyId ~= 0 then
		local key = storyId .. kSaveRoguePlot .. PlayerModel.instance:getId()
		local result = Astral.LocalStorage.Instance:GetInt(key, 0)

		return result == 1
	end

	return false
end

function M.SetStoryPlayed(storyId)
	local key = storyId .. kSaveRoguePlot .. PlayerModel.instance:getId()
	local key2 = kReadedStory .. PlayerModel.instance:getId()

	Astral.LocalStorage.Instance:SetInt(key, 1)
	Astral.LocalStorage.Instance:SetInt(key2, 1)
end

function M.ReadPlayedStory()
	local key = kReadPlayedStory .. PlayerModel.instance:getId()
	local result = Astral.LocalStorage.Instance:GetInt(key, 0)

	return result == 1
end

function M.GetPlayedStory()
	local key = kReadedStory .. PlayerModel.instance:getId()
	local result = Astral.LocalStorage.Instance:GetInt(key, 0)

	return result == 1
end

function M.SetReadPlayedStory(isOn)
	isOn = isOn and M.GetPlayedStory()

	local key = kReadPlayedStory .. PlayerModel.instance:getId()

	Astral.LocalStorage.Instance:SetInt(key, isOn and 1 or 0)
end

function M.GetIsEventJudgeQuick()
	local key = kEventJudgeQuick .. PlayerModel.instance:getId()
	local result = Astral.LocalStorage.Instance:GetInt(key, 0)

	return result == 1
end

function M.SetIsEventJudgeQuick(isQuick)
	local key = kEventJudgeQuick .. PlayerModel.instance:getId()

	Astral.LocalStorage.Instance:SetInt(key, isQuick and 1 or 0)
end

M.SAN_OFFSET = 0
M.DICE_SCALE = 0.5
M.MAP_ITEM_SIZE = 2.6
M.MAP_ROLE_OFFSET_Y = 0
M.MAP_ROLE_OFFSET_Y2 = 0
M.MAP_ROLE_OFFSET_Z = 0
M.MAP_CHANGE_CAMERA_TIME = 0.5
M.CARD_MAX = 6
M.costIcon = 5009001
M.ROLE_PROP = {
	LUCKY = 6,
	AGILE = 2,
	HP = 7,
	KNOWLEDGE = 3,
	POWER = 1,
	COMMUNICATE = 4,
	SAN_MAX = 10,
	HP_MAX = 8,
	SAN = 9,
	INSIGHT = 5
}
M.PROP_LANG_MAP = {
	[M.ROLE_PROP.POWER] = {
		name = "力量"
	},
	[M.ROLE_PROP.AGILE] = {
		name = "敏捷"
	},
	[M.ROLE_PROP.KNOWLEDGE] = {
		name = "知识"
	},
	[M.ROLE_PROP.COMMUNICATE] = {
		name = "沟通"
	},
	[M.ROLE_PROP.INSIGHT] = {
		name = "洞察"
	},
	[M.ROLE_PROP.LUCKY] = {
		name = "幸运"
	}
}
M.ROLE_PROP_LEVEL = {
	E = 1,
	C = 3,
	A = 5,
	D = 2,
	S = 6,
	F = 0,
	B = 4
}
M.ATTR_COLOR = {
	"959595",
	"959595",
	"90be8w",
	"74b9f3",
	"C885EE",
	"D09B56"
}
M.SPECIAL_DICE_TYPE = {
	WHITE = 1,
	BLACK = 2
}
M.DICE_PATTERN = {
	BLEEDING = 11,
	COUNTER = 18,
	NORMAL_4 = 154,
	SACRIFICE_2 = 92,
	REDUCE_WISDOM_4 = 104,
	CURSE = 13,
	KNOWLEDGE = 3,
	SACRIFICE_3 = 93,
	REDUCE_WISDOM_2 = 102,
	NORMAL_6 = 156,
	REDUCE_WISDOM_5 = 105,
	CONTROL = 16,
	REDUCE_WISDOM_6 = 106,
	SACRIFICE_6 = 96,
	REDUCE_WISDOM_3 = 103,
	TECHNOLOGY = 19,
	BLEEDING_6 = 116,
	FATHER = 20,
	WHITE = 7,
	DAUGHTER = 21,
	DICE_WHITE = 22,
	POWER = 1,
	NORMAL = 15,
	COMMUNICATE = 4,
	BLEEDING_2 = 112,
	SACRIFICE = 9,
	BLEEDING_3 = 113,
	DICE_BLACK = 23,
	DICE_ROSE = 24,
	TRANCE_2 = 122,
	BLEEDING_5 = 115,
	CRITICAL_STRIKE = 8,
	DICE_TRUTH = 25,
	AGILE = 2,
	REDUCE_WISDOM = 10,
	LUCKY = 6,
	TRANCE_4 = 124,
	TRANCE_3 = 123,
	BLESSING = 14,
	SACRIFICE_4 = 94,
	SACRIFICE_5 = 95,
	BLEEDING_4 = 114,
	TRANCE_5 = 125,
	NORMAL_3 = 153,
	TRANCE_6 = 126,
	NORMAL_2 = 152,
	DEIFY = 17,
	TRANCE = 12,
	NORMAL_5 = 155,
	INSIGHT = 5
}
M.DICE_PATTERN_ICON = {
	[M.DICE_PATTERN.POWER] = 1,
	[M.DICE_PATTERN.AGILE] = 2,
	[M.DICE_PATTERN.KNOWLEDGE] = 3,
	[M.DICE_PATTERN.COMMUNICATE] = 4,
	[M.DICE_PATTERN.INSIGHT] = 5,
	[M.DICE_PATTERN.LUCKY] = 6,
	[M.DICE_PATTERN.WHITE] = 7,
	[M.DICE_PATTERN.CRITICAL_STRIKE] = 8,
	[M.DICE_PATTERN.SACRIFICE] = 9,
	[M.DICE_PATTERN.SACRIFICE_2] = 9,
	[M.DICE_PATTERN.SACRIFICE_3] = 9,
	[M.DICE_PATTERN.SACRIFICE_4] = 9,
	[M.DICE_PATTERN.SACRIFICE_5] = 9,
	[M.DICE_PATTERN.SACRIFICE_6] = 9,
	[M.DICE_PATTERN.REDUCE_WISDOM] = 10,
	[M.DICE_PATTERN.REDUCE_WISDOM_2] = 10,
	[M.DICE_PATTERN.REDUCE_WISDOM_3] = 10,
	[M.DICE_PATTERN.REDUCE_WISDOM_4] = 10,
	[M.DICE_PATTERN.REDUCE_WISDOM_5] = 10,
	[M.DICE_PATTERN.REDUCE_WISDOM_6] = 10,
	[M.DICE_PATTERN.BLEEDING] = 11,
	[M.DICE_PATTERN.BLEEDING_2] = 11,
	[M.DICE_PATTERN.BLEEDING_3] = 11,
	[M.DICE_PATTERN.BLEEDING_4] = 11,
	[M.DICE_PATTERN.BLEEDING_5] = 11,
	[M.DICE_PATTERN.BLEEDING_6] = 11,
	[M.DICE_PATTERN.TRANCE] = 12,
	[M.DICE_PATTERN.TRANCE_2] = 12,
	[M.DICE_PATTERN.TRANCE_3] = 12,
	[M.DICE_PATTERN.TRANCE_4] = 12,
	[M.DICE_PATTERN.TRANCE_5] = 12,
	[M.DICE_PATTERN.TRANCE_6] = 12,
	[M.DICE_PATTERN.CURSE] = 13,
	[M.DICE_PATTERN.BLESSING] = 14,
	[M.DICE_PATTERN.NORMAL] = 15,
	[M.DICE_PATTERN.NORMAL_2] = 15,
	[M.DICE_PATTERN.NORMAL_3] = 15,
	[M.DICE_PATTERN.NORMAL_4] = 15,
	[M.DICE_PATTERN.NORMAL_5] = 15,
	[M.DICE_PATTERN.NORMAL_6] = 15,
	[M.DICE_PATTERN.CONTROL] = 16,
	[M.DICE_PATTERN.DEIFY] = 17,
	[M.DICE_PATTERN.COUNTER] = 18,
	[M.DICE_PATTERN.TECHNOLOGY] = 19,
	[M.DICE_PATTERN.FATHER] = 20,
	[M.DICE_PATTERN.DAUGHTER] = 21,
	[M.DICE_PATTERN.DICE_WHITE] = 22,
	[M.DICE_PATTERN.DICE_BLACK] = 23,
	[M.DICE_PATTERN.DICE_ROSE] = 24,
	[M.DICE_PATTERN.DICE_TRUTH] = 25
}

function M.GetPatterIcon(pattern)
	return M.DICE_PATTERN_ICON[pattern] or 7
end

M.DICE_PATTERN_LEVEL = {
	[M.DICE_PATTERN.SACRIFICE_2] = 2,
	[M.DICE_PATTERN.SACRIFICE_3] = 3,
	[M.DICE_PATTERN.SACRIFICE_4] = 4,
	[M.DICE_PATTERN.SACRIFICE_5] = 5,
	[M.DICE_PATTERN.SACRIFICE_6] = 6,
	[M.DICE_PATTERN.REDUCE_WISDOM_2] = 2,
	[M.DICE_PATTERN.REDUCE_WISDOM_3] = 3,
	[M.DICE_PATTERN.REDUCE_WISDOM_4] = 4,
	[M.DICE_PATTERN.REDUCE_WISDOM_5] = 5,
	[M.DICE_PATTERN.REDUCE_WISDOM_6] = 6,
	[M.DICE_PATTERN.BLEEDING_2] = 2,
	[M.DICE_PATTERN.BLEEDING_3] = 3,
	[M.DICE_PATTERN.BLEEDING_4] = 4,
	[M.DICE_PATTERN.BLEEDING_5] = 5,
	[M.DICE_PATTERN.BLEEDING_6] = 5,
	[M.DICE_PATTERN.TRANCE_2] = 2,
	[M.DICE_PATTERN.TRANCE_3] = 3,
	[M.DICE_PATTERN.TRANCE_4] = 4,
	[M.DICE_PATTERN.TRANCE_5] = 5,
	[M.DICE_PATTERN.TRANCE_6] = 6,
	[M.DICE_PATTERN.NORMAL_2] = 2,
	[M.DICE_PATTERN.NORMAL_3] = 3,
	[M.DICE_PATTERN.NORMAL_4] = 4,
	[M.DICE_PATTERN.NORMAL_5] = 5,
	[M.DICE_PATTERN.NORMAL_6] = 6
}

function M.GetPatternLevel(pattern)
	return M.DICE_PATTERN_LEVEL[pattern] or 1
end

function M.GetPatternType(pattern)
	local PATTERN = M.DICE_PATTERN

	if pattern == PATTERN.BLEEDING_2 or pattern == PATTERN.BLEEDING_3 or pattern == PATTERN.BLEEDING_4 or pattern == PATTERN.BLEEDING_5 or pattern == PATTERN.BLEEDING_6 then
		return PATTERN.BLEEDING
	end

	if pattern == PATTERN.SACRIFICE_2 or pattern == PATTERN.SACRIFICE_3 or pattern == PATTERN.SACRIFICE_4 or pattern == PATTERN.SACRIFICE_5 or pattern == PATTERN.SACRIFICE_6 then
		return PATTERN.SACRIFICE
	end

	if pattern == PATTERN.REDUCE_WISDOM_2 or pattern == PATTERN.REDUCE_WISDOM_3 or pattern == PATTERN.REDUCE_WISDOM_4 or pattern == PATTERN.REDUCE_WISDOM_5 or pattern == PATTERN.REDUCE_WISDOM_6 then
		return PATTERN.REDUCE_WISDOM
	end

	if pattern == PATTERN.TRANCE_2 or pattern == PATTERN.TRANCE_3 or pattern == PATTERN.TRANCE_4 or pattern == PATTERN.TRANCE_5 or pattern == PATTERN.TRANCE_6 then
		return PATTERN.TRANCE
	end

	if pattern == PATTERN.NORMAL_2 or pattern == PATTERN.NORMAL_3 or pattern == PATTERN.NORMAL_4 or pattern == PATTERN.NORMAL_5 or pattern == PATTERN.NORMAL_6 then
		return PATTERN.NORMAL
	end

	return pattern
end

local attrType = RoguelikeExtension_pb.AttrType

M.AttrType2Name = {
	[attrType.POWER] = "力量",
	[attrType.AGILITY] = "敏捷",
	[attrType.LORE] = "知识",
	[attrType.CHAT] = "沟通",
	[attrType.INSIGHT] = "洞察",
	[attrType.LUCK] = "幸运",
	[attrType.SUCCESS_1] = "",
	[attrType.SUCCESS_2] = "",
	[attrType.SUCCESS_3] = "",
	[attrType.SUCCESS_4] = "",
	[attrType.SUCCESS_5] = "",
	[attrType.SACRIFICE_1] = "献祭面",
	[attrType.SACRIFICE_2] = "献祭面",
	[attrType.SACRIFICE_3] = "献祭面",
	[attrType.SACRIFICE_4] = "献祭面",
	[attrType.SACRIFICE_5] = "献祭面",
	[attrType.ECLIPSE_1] = "蚀智面",
	[attrType.ECLIPSE_2] = "蚀智面",
	[attrType.ECLIPSE_3] = "蚀智面",
	[attrType.ECLIPSE_4] = "蚀智面",
	[attrType.ECLIPSE_5] = "蚀智面",
	[attrType.BLEED_1] = "流血面",
	[attrType.BLEED_2] = "流血面",
	[attrType.BLEED_3] = "流血面",
	[attrType.BLEED_4] = "流血面",
	[attrType.BLEED_5] = "流血面",
	[attrType.TRANCE_1] = "恍惚面",
	[attrType.TRANCE_2] = "恍惚面",
	[attrType.TRANCE_3] = "恍惚面",
	[attrType.TRANCE_4] = "恍惚面",
	[attrType.TRANCE_5] = "恍惚面"
}
M.AttrType2GraphicText = {
	[attrType.POWER] = "[fhdt19|32]",
	[attrType.AGILITY] = "[fhdt20|32]",
	[attrType.LORE] = "[fhdt21|32]",
	[attrType.CHAT] = "[fhdt22|32]",
	[attrType.INSIGHT] = "[fhdt23|32]",
	[attrType.LUCK] = "[fhdt24|32]",
	[attrType.SACRIFICE_1] = "[dice901|32]",
	[attrType.SACRIFICE_2] = "[dice902|32]",
	[attrType.SACRIFICE_3] = "[dice903|32]",
	[attrType.SACRIFICE_4] = "[dice904|32]",
	[attrType.SACRIFICE_5] = "[dice905|32]",
	[attrType.SACRIFICE_6] = "[dice906|32]",
	[attrType.ECLIPSE_1] = "[dice1001|32]",
	[attrType.ECLIPSE_2] = "[dice1002|32]",
	[attrType.ECLIPSE_3] = "[dice1003|32]",
	[attrType.ECLIPSE_4] = "[dice1004|32]",
	[attrType.ECLIPSE_5] = "[dice1005|32]",
	[attrType.ECLIPSE_6] = "[dice1006|32]",
	[attrType.BLEED_1] = "[dice1101|32]",
	[attrType.BLEED_2] = "[dice1102|32]",
	[attrType.BLEED_3] = "[dice1103|32]",
	[attrType.BLEED_4] = "[dice1104|32]",
	[attrType.BLEED_5] = "[dice1105|32]",
	[attrType.BLEED_6] = "[dice1106|32]",
	[attrType.TRANCE_1] = "[dice1201|32]",
	[attrType.TRANCE_2] = "[dice1202|32]",
	[attrType.TRANCE_3] = "[dice1203|32]",
	[attrType.TRANCE_4] = "[dice1204|32]",
	[attrType.TRANCE_5] = "[dice1205|32]",
	[attrType.TRANCE_6] = "[dice1206|32]",
	[attrType.SUCCESS_1] = "[dice701|32]",
	[attrType.SUCCESS_2] = "[dice702|32]",
	[attrType.SUCCESS_3] = "[dice703|32]",
	[attrType.SUCCESS_4] = "[dice704|32]",
	[attrType.SUCCESS_5] = "[dice705|32]",
	[attrType.SUCCESS_6] = "[dice706|32]"
}

function M.GetAttrGraphic(attr, size)
	local size = size or 32
	local result = M.AttrType2GraphicText[attr]

	result = string.gsub(result, "32", size)

	return result
end

M.ROGUE_EVENT_TYPE = {
	PLOT_EVENT = 6,
	RECTIFY_EVENT = 5,
	MULTI_EVENT = 3,
	FIGHT_EVENT = 1,
	SINGLE_EVENT = 2,
	ENCOUNTER_EVENT = 4
}
M.ROGUE_EVENT_TYPE_1 = {
	MONSTER_EVENT = 10,
	REPEAT = 5,
	SECOND_EXIT = 9,
	RESET = 7,
	AT_ONE = 4,
	MULTI_EVENT = 2,
	SECOND_ENTRANCE = 8,
	ENCOUNTER_EVENT = 3,
	PLOT_EVENT = 6,
	SINGLE_EVENT = 1
}
M.ROGUE_EVENT_TYPE_LANG = {
	[M.ROGUE_EVENT_TYPE_1.SINGLE_EVENT] = "tip_r_judge_type_single",
	[M.ROGUE_EVENT_TYPE_1.MULTI_EVENT] = "tip_r_judge_type_mult",
	[M.ROGUE_EVENT_TYPE_1.ENCOUNTER_EVENT] = "tip_r_judge_type_encounter"
}
M.ROGUE_EXTRA_TYPE = {
	BIG_FAIL = 2,
	BIG_SUCCESS = 1
}
M.ROGUE_DICE_TYPE = {
	COMBAT = 2,
	PLAYER = 1,
	TRUTH = 4,
	ROSE = 3
}
M.ROGUE_GAME_STATE = {
	ROLE_CHANGE = 5,
	ROLLING = 3,
	RESULT = 6,
	INIT = 1,
	ROLLING_END = 4,
	BEFORE_JUDGE = 2,
	NONE = 0
}
M.ROGUE_ROOM_TYPE = {
	FIGHT = 3,
	LAST = 5,
	ORIGIN = 1,
	EVENT = 2,
	PROP = 4,
	BET = 6,
	SHOP = 7
}
M.ROGUE_MONSTER_ANI = {
	WIN = "win",
	JUMP = "jump",
	IDLE = "idle",
	SKILL = "skill",
	ATTACK = "attack",
	DIE = "die",
	DEATH = "die",
	HIT = "hit"
}
M.ROGUE_ROLE_ANI = {
	ARISE = "arise",
	IDLE2 = "idle2",
	Run = "run",
	ATTACK = "attack",
	FALL = "fall",
	HIT = "hit",
	JUMP = "jump",
	IDLE = "idle",
	SKILL = "attack",
	DEATH = "die",
	WIN = "win"
}
M.CARD_ENTRY_EFFECT_TIME = {
	DICE_RESULT = 2,
	CREATE_DICE = 1,
	JUDGE_RESULT = 4,
	AFTER_ACTION = 3
}
M.ROGUE_EXPLORE_TYPE = {
	JUDGE = 2,
	MOVE = 1
}
M.SHOW_TIPS_TYPE = {
	SelectProp = 2,
	SelectEndOption = 4,
	SelectCard = 3,
	SelectRole = 1
}
M.DICE_MATCH_TYPE = {
	MONSTER = 2,
	EVENT = 3,
	DICE_WALL = 1
}

return M
