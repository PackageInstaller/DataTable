local EducateConst = class("EducateConst")

EducateConst.PLANS_DATA_KEY = "EDUCATE_PLAN_"
EducateConst.SKIP_PLANS_ANIM_KEY = "EDUCATE_PLAN_SKIP"
EducateConst.SKIP_PLANS_EVENT_ANIM_KEY = "SKIP_PLANS_EVENT_ANIM_KEY"
EducateConst.DROP_TYPE_ATTR = 1
EducateConst.DROP_TYPE_RES = 2
EducateConst.DROP_TYPE_ITEM = 3
EducateConst.DROP_TYPE_MEMORY = 4
EducateConst.DROP_TYPE_POLAROID = 5
EducateConst.DROP_TYPE_BUFF = 6
EducateConst.PERFORM_TYPE_ANIM = 1
EducateConst.PERFORM_TYPE_OPTION = 2
EducateConst.PERFORM_TYPE_MINIGAME = 3
EducateConst.PERFORM_TYPE_WORD = 4
EducateConst.PERFORM_TYPE_STORY = 5
EducateConst.PERFORM_TYPE_BUBBLE = 6
EducateConst.PERFORM_TYPE_PICTURE = 7
EducateConst.WORD_TYPE_CHILD = 1
EducateConst.WORD_TYPE_PLAYER = 2
EducateConst.WORD_TYPE_ASIDE = 3
EducateConst.STATUES_PREPARE = 1
EducateConst.STATUES_NORMAL = 2
EducateConst.STATUES_ENDING = 3
EducateConst.STATUES_RESET = 4
EducateConst.GRADE_2_COLOR = {
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
EducateConst.REVIEW_GROUP_ID = 1000
EducateConst.SYSTEM_GO_OUT = "EDUCATE_SYSTEM_GO_OUT"
EducateConst.SYSTEM_MEMORY = "EDUCATE_SYSTEM_MEMORY"
EducateConst.SYSTEM_POLAROID = "EDUCATE_SYSTEM_POLAROID"
EducateConst.SYSTEM_ENDING = "EDUCATE_SYSTEM_ENDING"
EducateConst.SYSTEM_FAVOR_AND_MIND = "EDUCATE_SYSTEM_FAVOR_AND_MIND"
EducateConst.SYSTEM_BUFF = "EDUCATE_SYSTEM_BUFF"
EducateConst.SYSTEM_ATTR_2 = "EDUCATE_SYSTEM_ATTR_2"
EducateConst.SYSTEM_ATTR_3 = "EDUCATE_SYSTEM_ATTR_3"
EducateConst.SYSTEM_BAG = "EDUCATE_SYSTEM_BAG"
EducateConst.SYSTEM_UNLOCK_CONFIG = {
	[EducateConst.SYSTEM_GO_OUT] = {
		"child_out_unlock",
		false
	},
	[EducateConst.SYSTEM_MEMORY] = {
		"child_memory_unlock",
		true
	},
	[EducateConst.SYSTEM_POLAROID] = {
		"child_polaroid_unlock",
		true
	},
	[EducateConst.SYSTEM_ENDING] = {
		"child_ending_unlock",
		true
	},
	[EducateConst.SYSTEM_FAVOR_AND_MIND] = {
		"child_intimacy_unlock",
		true
	},
	[EducateConst.SYSTEM_BUFF] = {
		"child_buff_unlock",
		true
	},
	[EducateConst.SYSTEM_ATTR_2] = {
		"child_attr2_unlock",
		true
	},
	[EducateConst.SYSTEM_ATTR_3] = {
		"child_attr3_unlock",
		true
	},
	[EducateConst.SYSTEM_BAG] = {
		"child_item_unlock",
		true
	}
}
EducateConst.SECRETARY_UNLCOK_TYPE_DEFAULT = 1
EducateConst.SECRETARY_UNLCOK_TYPE_POLAROID = 2
EducateConst.SECRETARY_UNLCOK_TYPE_ENDING = 3
EducateConst.SECRETARY_UNLCOK_TYPE_SHOP = 4
EducateConst.SECRETARY_UNLCOK_TYPE_STORY = 5
EducateConst.FIRST_ENTER_PERFORM_IDS = {
	101,
	102,
	103,
	104,
	105
}
EducateConst.AFTER_SET_CALLNAME_PERFORM_ID = 106
EducateConst.ENTER_NEW_STAGE_PERFORMS = {
	nil,
	111,
	113,
	119
}
EducateConst.FIRST_ENTER_END_PERFORM = 132
EducateConst.AFTER_END_PERFORM = 144
EducateConst.MAIN_TASK_ID_1 = 101
EducateConst.MAIN_TASK_ID_2 = 102
EducateConst.SECRETARY_TYPE_SP = 7

function EducateConst.CheckAllCollectionTrack()
	local var_1_0 = 0
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in ipairs(getProxy(EducateProxy):GetMemories()) do
		var_1_1[iter_1_1] = true
	end

	for iter_1_2, iter_1_3 in ipairs(pg.child_memory.all) do
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

	local var_1_3 = pg.NewStoryMgr.GetInstance()

	for iter_1_4, iter_1_5 in ipairs(pg.child2_memory.all) do
		if not var_1_3:IsPlayed(pg.child2_memory[iter_1_5].lua) then
			var_1_0 = -1

			break
		else
			var_1_0 = var_1_0 + 1
		end
	end

	local var_1_4 = getProxy(PlayerProxy):getRawData().id

	if var_1_0 > PlayerPrefs.GetInt("EDUCATE_ALL_COLLECTION:" .. var_1_4, 0) then
		PlayerPrefs.SetInt("EDUCATE_ALL_COLLECTION:" .. var_1_4, var_1_0)
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildAllCollection(20003, var_1_0))
	end

	return
end

return EducateConst
