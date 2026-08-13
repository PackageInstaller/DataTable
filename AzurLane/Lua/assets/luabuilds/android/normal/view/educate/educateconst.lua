class = var_0_10000

local var_0_0 = var_0_10000("EducateConst")

var_0_0.PLANS_DATA_KEY = "EDUCATE_PLAN_"
var_0_0.SKIP_PLANS_ANIM_KEY = "EDUCATE_PLAN_SKIP"
var_0_0.SKIP_PLANS_EVENT_ANIM_KEY = "SKIP_PLANS_EVENT_ANIM_KEY"
var_0_0.DROP_TYPE_ATTR = 1
var_0_0.DROP_TYPE_RES = 2
var_0_0.DROP_TYPE_ITEM = 3
var_0_0.DROP_TYPE_MEMORY = 4
var_0_0.DROP_TYPE_POLAROID = 5
var_0_0.DROP_TYPE_BUFF = 6
var_0_0.PERFORM_TYPE_ANIM = 1
var_0_0.PERFORM_TYPE_OPTION = 2
var_0_0.PERFORM_TYPE_MINIGAME = 3
var_0_0.PERFORM_TYPE_WORD = 4
var_0_0.PERFORM_TYPE_STORY = 5
var_0_0.PERFORM_TYPE_BUBBLE = 6
var_0_0.PERFORM_TYPE_PICTURE = 7
var_0_0.WORD_TYPE_CHILD = 1
var_0_0.WORD_TYPE_PLAYER = 2
var_0_0.WORD_TYPE_ASIDE = 3
var_0_0.STATUES_PREPARE = 1
var_0_0.STATUES_NORMAL = 2
var_0_0.STATUES_ENDING = 3
var_0_0.STATUES_RESET = 4
var_0_0.GRADE_2_COLOR = {
	A = {
		"c2e1f1",
		"6cd2ff"
	},
	B = {
		"c5cdff",
		"99bbff"
	},
	C = {
		"d6d7f1",
		"bec0dd"
	},
	D = {
		"dedede",
		"cfcfd3"
	}
}
var_0_0.REVIEW_GROUP_ID = 1000
var_0_0.SYSTEM_GO_OUT = "EDUCATE_SYSTEM_GO_OUT"
var_0_0.SYSTEM_MEMORY = "EDUCATE_SYSTEM_MEMORY"
var_0_0.SYSTEM_POLAROID = "EDUCATE_SYSTEM_POLAROID"
var_0_0.SYSTEM_ENDING = "EDUCATE_SYSTEM_ENDING"
var_0_0.SYSTEM_FAVOR_AND_MIND = "EDUCATE_SYSTEM_FAVOR_AND_MIND"
var_0_0.SYSTEM_BUFF = "EDUCATE_SYSTEM_BUFF"
var_0_0.SYSTEM_ATTR_2 = "EDUCATE_SYSTEM_ATTR_2"
var_0_0.SYSTEM_ATTR_3 = "EDUCATE_SYSTEM_ATTR_3"
var_0_0.SYSTEM_BAG = "EDUCATE_SYSTEM_BAG"
var_0_0.SYSTEM_UNLOCK_CONFIG = {
	[var_0_0.SYSTEM_GO_OUT] = {
		"child_out_unlock",
		false
	},
	[var_0_0.SYSTEM_MEMORY] = {
		"child_memory_unlock",
		true
	},
	[var_0_0.SYSTEM_POLAROID] = {
		"child_polaroid_unlock",
		true
	},
	[var_0_0.SYSTEM_ENDING] = {
		"child_ending_unlock",
		true
	},
	[var_0_0.SYSTEM_FAVOR_AND_MIND] = {
		"child_intimacy_unlock",
		true
	},
	[var_0_0.SYSTEM_BUFF] = {
		"child_buff_unlock",
		true
	},
	[var_0_0.SYSTEM_ATTR_2] = {
		"child_attr2_unlock",
		true
	},
	[var_0_0.SYSTEM_ATTR_3] = {
		"child_attr3_unlock",
		true
	},
	[var_0_0.SYSTEM_BAG] = {
		"child_item_unlock",
		true
	}
}
var_0_0.SECRETARY_UNLCOK_TYPE_DEFAULT = 1
var_0_0.SECRETARY_UNLCOK_TYPE_POLAROID = 2
var_0_0.SECRETARY_UNLCOK_TYPE_ENDING = 3
var_0_0.SECRETARY_UNLCOK_TYPE_SHOP = 4
var_0_0.SECRETARY_UNLCOK_TYPE_STORY = 5
var_0_0.FIRST_ENTER_PERFORM_IDS = {
	101,
	102,
	103,
	104,
	105
}
var_0_0.AFTER_SET_CALLNAME_PERFORM_ID = 106
var_0_0.ENTER_NEW_STAGE_PERFORMS = {
	nil,
	111,
	113,
	119
}
var_0_0.FIRST_ENTER_END_PERFORM = 132
var_0_0.AFTER_END_PERFORM = 144
var_0_0.MAIN_TASK_ID_1 = 101
var_0_0.MAIN_TASK_ID_2 = 102
var_0_0.SECRETARY_TYPE_SP = 7

function var_0_0.CheckAllCollectionTrack()
	local var_1_0 = 0
	local var_1_1 = {}

	ipairs = var_1_10002
	getProxy = var_1_10003
	EducateProxy = var_1_10004

	local var_1_2 = var_1_10003(var_1_10004)

	for iter_1_0, iter_1_1 in var_1_10002(var_3.GetMemories(var_1_2)) do
		var_1_1[iter_1_1] = true
	end

	ipairs = var_2
	pg = var_3

	for iter_1_2, iter_1_3 in var_2(var_3.child_memory.all) do
		pg = var_1_10007
		var_1_10007 = var_1_10007.child_memory[iter_1_3]

		if not var_1_1[iter_1_3] then
			var_1_0 = -1

			break
		else
			var_1_0 = var_1_0 + 1
		end
	end

	if var_1_0 < 0 then
		return
	end

	pg = var_2

	local var_1_3 = var_2.NewStoryMgr.GetInstance()

	ipairs = var_3
	pg = var_4

	for iter_1_4, iter_1_5 in var_3(var_4.child2_memory.all) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.child2_memory[iter_1_5]

		if not var_1_3:IsPlayed(var_1_10008.lua) then
			var_1_0 = -1

			break
		else
			var_1_0 = var_1_0 + 1
		end
	end

	getProxy = var_3
	PlayerProxy = var_4

	local var_1_4 = var_3(var_4)
	local var_1_5 = var_3.getRawData(var_1_4).id

	PlayerPrefs = var_1_4

	if var_1_4.GetInt("EDUCATE_ALL_COLLECTION:" .. var_1_5, 0) < var_1_0 then
		PlayerPrefs = var_4

		var_4.SetInt("EDUCATE_ALL_COLLECTION:" .. var_1_5, var_1_0)

		pg = var_4

		local var_1_6 = var_4.GameTrackerMgr.GetInstance()
		local var_1_7 = var_4.Record

		GameTrackerBuilder = var_6

		var_1_7(var_1_6, var_6.BuildAllCollection(20003, var_1_0))
	end

	return
end

return var_0_0
