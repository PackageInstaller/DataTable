local var_0_0 = class("IslandUnitVO")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.modelId = arg_1_1.modelId
	arg_1_0.type = arg_1_1.type
	arg_1_0.name = arg_1_1.name
	arg_1_0.index = arg_1_1.index
	arg_1_0.genType = defaultValue(arg_1_1.genType, IslandConst.UNIT_GEN_TYPE_STATIC)
	arg_1_0.isDynamic = arg_1_0.genType == IslandConst.UNIT_GEN_TYPE_DYNAMIC
	arg_1_0.showCondition = defaultValue(arg_1_1.showCondition, {})
	arg_1_0.hideCondition = defaultValue(arg_1_1.hideCondition, {})
	arg_1_0.position = BuildVector3(arg_1_1.position)
	arg_1_0.rotation = BuildVector3(arg_1_1.rotation)
	arg_1_0.scale = BuildVector3(arg_1_1.scale)
	arg_1_0.behaviourTree = arg_1_1.behaviourTree
	arg_1_0.delayTime = arg_1_1.delayTime

	return
end

function var_0_0.GetType(arg_2_0)
	return arg_2_0.type
end

function var_0_0.IsPlayer(arg_3_0)
	return arg_3_0.type == IslandConst.UNIT_TYPE_PLAYER
end

function var_0_0.IsFirstTakePhoto(arg_4_0)
	return arg_4_0.type == IslandConst.UNIT_TYPE_FIRST_TAKE_PHOTO_ITEM and arg_4_0.id == 2
end

function var_0_0.IsThirdTakePhoto(arg_5_0)
	return arg_5_0.type == IslandConst.UNIT_TYPE_FIRST_TAKE_PHOTO_ITEM and arg_5_0.id == 3
end

function var_0_0.IsGift(arg_6_0)
	return arg_6_0.genType == IslandConst.UNIT_GEN_TYPE_GIFT
end

function var_0_0.Interactable(arg_7_0)
	return arg_7_0.type == IslandConst.UNIT_TYPE_ITEM_INTERACT
end

function var_0_0.IsNpcType(arg_8_0)
	return arg_8_0.type == IslandConst.UNIT_TYPE_CHAR or arg_8_0.type == IslandConst.UNIT_TYPE_PLAYER or arg_8_0.type == IslandConst.UNIT_TYPE_VISITOR or arg_8_0.type == IslandConst.UNIT_TYPE_SYSTEM or arg_8_0.type == IslandConst.UNIT_TYPE_STROLL or arg_8_0.type == IslandConst.UNIT_TYPE_MANAGE_CHARA or arg_8_0.type == IslandConst.UNIT_TYPE_MANAGE_CUSTOMER or arg_8_0.type == IslandConst.UNIT_TYPE_SYSTEM_DELEAGTION or arg_8_0.type == IslandConst.UNIT_TYPE_SYSTEM_DELEAGTION_ANIMATION or arg_8_0.type == IslandConst.UNIT_TYPE_FOLLOWER or arg_8_0.type == IslandConst.UNIT_TYPE_DELEGATE_FISH or arg_8_0.type == IslandConst.UNIT_TYPE_CHEATERTAVERN_PLAYER
end

function var_0_0.IsItemType(arg_9_0)
	return arg_9_0.type == IslandConst.UNIT_TYPE_ITEM or arg_9_0.type == IslandConst.UNIT_TYPE_ITEM_HANDLE_COLLECT or arg_9_0.type == IslandConst.UNIT_TYPE_ITEM_HANDLE_PLANTING or arg_9_0.type == IslandConst.UNIT_TYPE_ITEM_PRODUCT_ITEM or arg_9_0.type == IslandConst.UNIT_TYPE_ITEM_GATHER_ITEM or arg_9_0.type == IslandConst.UNIT_TYPE_ITEM_WILD_COLLECT_ITEM or arg_9_0.type == IslandConst.UNIT_TYPE_MANAGE_ITEM or arg_9_0.type == IslandConst.UNIT_TYPE_ITEM_DELAY_RECYCLE or arg_9_0.type == IslandConst.UNIT_TYPE_FIRST_TAKE_PHOTO_ITEM or arg_9_0.type == IslandConst.UNIT_TYPE_CHEATERTAVERN_TABLE or arg_9_0.type == IslandConst.UNIT_TYPE_CHEATERTAVERN_CHAIR or arg_9_0.type == IslandConst.UNIT_TYPE_FISH_POINT
end

function var_0_0.GetPersonality(arg_10_0)
	local var_10_0 = 0
	local var_10_1 = 0

	if arg_10_0:IsNpcType() then
		local var_10_2 = pg.island_unit_character[arg_10_0.modelId].personality or 0

		var_10_1 = pg.island_unit_character[arg_10_0.modelId].is_active or 0
		var_10_0 = var_10_2
	end

	return var_10_0, var_10_1
end

function var_0_0.GetAssetPath(arg_11_0)
	local var_11_0

	if arg_11_0:IsNpcType() then
		warning(arg_11_0.type)
		assert(pg.island_unit_character[arg_11_0.modelId], arg_11_0.modelId)

		var_11_0 = pg.island_unit_character[arg_11_0.modelId].model
	elseif arg_11_0:IsItemType() then
		var_11_0 = pg.island_unit_item[arg_11_0.modelId].model
	elseif arg_11_0:Interactable() then
		var_11_0 = pg.island_unit_interactive_item[arg_11_0.modelId].model
	end

	assert(var_11_0)

	return string.lower(var_11_0)
end

function var_0_0.GetBehaviourTree(arg_12_0)
	return arg_12_0.behaviourTree
end

function var_0_0.GetAnimator(arg_13_0)
	if arg_13_0.type == IslandConst.UNIT_TYPE_PLAYER or arg_13_0.type == IslandConst.UNIT_TYPE_VISITOR or arg_13_0.type == IslandConst.UNIT_TYPE_CHAR or arg_13_0.type == IslandConst.UNIT_TYPE_STROLL or arg_13_0.type == IslandConst.UNIT_TYPE_MANAGE_CHARA or arg_13_0.type == IslandConst.UNIT_TYPE_MANAGE_CUSTOMER or arg_13_0.type == IslandConst.UNIT_TYPE_SYSTEM_DELEAGTION or arg_13_0.type == IslandConst.UNIT_TYPE_SYSTEM_DELEAGTION_ANIMATION or arg_13_0.type == IslandConst.UNIT_TYPE_FOLLOWER or arg_13_0.type == IslandConst.UNIT_TYPE_DELEGATE_FISH then
		return pg.island_unit_character[arg_13_0.modelId].animator
	elseif arg_13_0.type == IslandConst.UNIT_TYPE_SYSTEM then
		return pg.island_unit_character[arg_13_0.modelId].animator
	elseif arg_13_0.type == IslandConst.UNIT_TYPE_CHEATERTAVERN_PLAYER then
		return "island/animator/ani_role_all_cheatertavern_01"
	end

	warning("目前只有角色需要动态获取动画状态机")

	return
end

function var_0_0.GetShowCondition(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.showCondition) do
		table.insert({}, iter_14_1)
	end

	return {}
end

function var_0_0.GetHideCondition(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.hideCondition) do
		table.insert({}, iter_15_1)
	end

	return {}
end

return var_0_0
