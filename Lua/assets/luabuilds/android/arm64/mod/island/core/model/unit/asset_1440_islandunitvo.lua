local IslandUnitVO = class("IslandUnitVO")

function IslandUnitVO:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.modelId = arg_1_1.modelId
	self.type = arg_1_1.type
	self.name = arg_1_1.name
	self.index = arg_1_1.index
	self.genType = defaultValue(arg_1_1.genType, IslandConst.UNIT_GEN_TYPE_STATIC)
	self.isDynamic = self.genType == IslandConst.UNIT_GEN_TYPE_DYNAMIC
	self.showCondition = defaultValue(arg_1_1.showCondition, {})
	self.hideCondition = defaultValue(arg_1_1.hideCondition, {})
	self.position = BuildVector3(arg_1_1.position)
	self.rotation = BuildVector3(arg_1_1.rotation)
	self.scale = BuildVector3(arg_1_1.scale)
	self.behaviourTree = arg_1_1.behaviourTree
	self.delayTime = arg_1_1.delayTime

	return
end

function IslandUnitVO:GetType()
	return self.type
end

function IslandUnitVO:IsPlayer()
	return self.type == IslandConst.UNIT_TYPE_PLAYER
end

function IslandUnitVO:IsFirstTakePhoto()
	return self.type == IslandConst.UNIT_TYPE_FIRST_TAKE_PHOTO_ITEM and self.id == 2
end

function IslandUnitVO:IsThirdTakePhoto()
	return self.type == IslandConst.UNIT_TYPE_FIRST_TAKE_PHOTO_ITEM and self.id == 3
end

function IslandUnitVO:IsGift()
	return self.genType == IslandConst.UNIT_GEN_TYPE_GIFT
end

function IslandUnitVO:Interactable()
	return self.type == IslandConst.UNIT_TYPE_ITEM_INTERACT
end

function IslandUnitVO:IsNpcType()
	return self.type == IslandConst.UNIT_TYPE_CHAR or self.type == IslandConst.UNIT_TYPE_PLAYER or self.type == IslandConst.UNIT_TYPE_VISITOR or self.type == IslandConst.UNIT_TYPE_SYSTEM or self.type == IslandConst.UNIT_TYPE_STROLL or self.type == IslandConst.UNIT_TYPE_MANAGE_CHARA or self.type == IslandConst.UNIT_TYPE_MANAGE_CUSTOMER or self.type == IslandConst.UNIT_TYPE_SYSTEM_DELEAGTION or self.type == IslandConst.UNIT_TYPE_SYSTEM_DELEAGTION_ANIMATION or self.type == IslandConst.UNIT_TYPE_FOLLOWER or self.type == IslandConst.UNIT_TYPE_DELEGATE_FISH or self.type == IslandConst.UNIT_TYPE_CHEATERTAVERN_PLAYER
end

function IslandUnitVO:IsItemType()
	return self.type == IslandConst.UNIT_TYPE_ITEM or self.type == IslandConst.UNIT_TYPE_ITEM_HANDLE_COLLECT or self.type == IslandConst.UNIT_TYPE_ITEM_HANDLE_PLANTING or self.type == IslandConst.UNIT_TYPE_ITEM_PRODUCT_ITEM or self.type == IslandConst.UNIT_TYPE_ITEM_GATHER_ITEM or self.type == IslandConst.UNIT_TYPE_ITEM_WILD_COLLECT_ITEM or self.type == IslandConst.UNIT_TYPE_MANAGE_ITEM or self.type == IslandConst.UNIT_TYPE_ITEM_DELAY_RECYCLE or self.type == IslandConst.UNIT_TYPE_FIRST_TAKE_PHOTO_ITEM or self.type == IslandConst.UNIT_TYPE_CHEATERTAVERN_TABLE or self.type == IslandConst.UNIT_TYPE_CHEATERTAVERN_CHAIR or self.type == IslandConst.UNIT_TYPE_FISH_POINT
end

function IslandUnitVO:GetPersonality()
	local var_10_0 = 0
	local var_10_1 = 0

	if self:IsNpcType() then
		var_10_1 = pg.island_unit_character[self.modelId].is_active or 0
		var_10_0 = pg.island_unit_character[self.modelId].personality or 0
	end

	return var_10_0, var_10_1
end

function IslandUnitVO:GetAssetPath()
	local var_11_0

	if self:IsNpcType() then
		warning(self.type)
		assert(pg.island_unit_character[self.modelId], self.modelId)

		var_11_0 = pg.island_unit_character[self.modelId].model
	elseif self:IsItemType() then
		var_11_0 = pg.island_unit_item[self.modelId].model
	elseif self:Interactable() then
		var_11_0 = pg.island_unit_interactive_item[self.modelId].model
	end

	assert(var_11_0)

	return string.lower(var_11_0)
end

function IslandUnitVO:GetBehaviourTree()
	return self.behaviourTree
end

function IslandUnitVO:GetAnimator()
	if self.type == IslandConst.UNIT_TYPE_PLAYER or self.type == IslandConst.UNIT_TYPE_VISITOR or self.type == IslandConst.UNIT_TYPE_CHAR or self.type == IslandConst.UNIT_TYPE_STROLL or self.type == IslandConst.UNIT_TYPE_MANAGE_CHARA or self.type == IslandConst.UNIT_TYPE_MANAGE_CUSTOMER or self.type == IslandConst.UNIT_TYPE_SYSTEM_DELEAGTION or self.type == IslandConst.UNIT_TYPE_SYSTEM_DELEAGTION_ANIMATION or self.type == IslandConst.UNIT_TYPE_FOLLOWER or self.type == IslandConst.UNIT_TYPE_DELEGATE_FISH then
		return pg.island_unit_character[self.modelId].animator
	elseif self.type == IslandConst.UNIT_TYPE_SYSTEM then
		return pg.island_unit_character[self.modelId].animator
	elseif self.type == IslandConst.UNIT_TYPE_CHEATERTAVERN_PLAYER then
		return "island/animator/ani_role_all_cheatertavern_01"
	end

	warning("目前只有角色需要动态获取动画状态机")

	return
end

function IslandUnitVO:GetShowCondition()
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(self.showCondition) do
		table.insert(var_14_0, iter_14_1)
	end

	return var_14_0
end

function IslandUnitVO:GetHideCondition()
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(self.hideCondition) do
		table.insert(var_15_0, iter_15_1)
	end

	return var_15_0
end

return IslandUnitVO
