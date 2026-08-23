local var_0_0 = g.core.const.ConstMgr
local ArtifactConst = require("app.view.module.artifact.const.ArtifactConst")
local AbleFragmentData = class("AbleFragmentData")

function AbleFragmentData:ctor()
	self:initData()
end

function AbleFragmentData:initData()
	return
end

function AbleFragmentData:getAbleFragmentKnightList(arg_3_1, arg_3_2)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs((g.core.model.User.bagData:getList(var_0_0.BAG_TYPE.ITEM))) do
		local var_3_1 = g.core.config.item_info.get(iter_3_1.id)

		if var_3_1.item_type == 2 and arg_3_1 == var_3_1.quality then
			table.insert(var_3_0, {
				id = iter_3_1.id,
				num = iter_3_1.num,
				quality = var_3_1.quality,
				rare = var_3_1.rare
			})
		end
	end

	return var_3_0
end

function AbleFragmentData:getAbleFragmentSpaceTimeKnightList(arg_4_1, arg_4_2)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs((g.core.model.User.bagData:getList(var_0_0.BAG_TYPE.ITEM))) do
		local var_4_1 = g.core.config.item_info.get(iter_4_1.id)

		if var_4_1.item_type == 3000002 and arg_4_1 == var_4_1.quality then
			table.insert(var_4_0, {
				id = iter_4_1.id,
				num = iter_4_1.num,
				quality = var_4_1.quality,
				rare = var_4_1.rare
			})
		end
	end

	return var_4_0
end

function AbleFragmentData:getAbleFragmentUniteTokenList(arg_5_1, arg_5_2)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs((g.core.model.User.bagData:getList(var_0_0.BAG_TYPE.ITEM))) do
		local var_5_1 = g.core.config.item_info.get(iter_5_1.id)

		if var_5_1.item_type == 17 and arg_5_1 == var_5_1.quality and arg_5_2 == var_5_1.rare then
			table.insert(var_5_0, {
				id = iter_5_1.id,
				num = iter_5_1.num,
				quality = var_5_1.quality,
				rare = var_5_1.rare
			})
		end
	end

	return var_5_0
end

function AbleFragmentData:isHaveUniteTokenAbleFragment(arg_6_1)
	local var_6_0 = g.core.config.fragment_info.get(arg_6_1)

	if #self:getAbleFragmentUniteTokenList(var_6_0.quality, var_6_0.rare) > 0 then
		return true
	end

	return false
end

function AbleFragmentData:isHaveKnightAbleFragment(arg_7_1)
	local var_7_0 = g.core.config.fragment_info.get(arg_7_1)

	if #self:getAbleFragmentKnightList(var_7_0.quality, var_7_0.rare) > 0 then
		return true
	end

	return false
end

function AbleFragmentData:isHaveSpaceTimeKnightAbleFragment(arg_8_1)
	local var_8_0 = g.core.config.fragment_info.get(arg_8_1)

	if #self:getAbleFragmentSpaceTimeKnightList(var_8_0.quality, var_8_0.rare) > 0 then
		return true
	end

	return false
end

function AbleFragmentData:getAbleFragmentId(arg_9_1, arg_9_2)
	local var_9_0 = g.core.config.fragment_info.get(arg_9_1)

	for iter_9_0 = 1, g.core.config.item_info.getLength() do
		local var_9_2 = g.core.config.item_info.indexOf(iter_9_0)

		if var_9_2.quality == var_9_0.quality and var_9_2.item_type == arg_9_2 then
			return var_9_2.id
		end
	end
end

function AbleFragmentData:getAbleFragmentArtifactList(arg_10_1, arg_10_2)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs((g.core.model.User.bagData:getList(var_0_0.BAG_TYPE.ITEM))) do
		local var_10_1 = g.core.config.item_info.get(iter_10_1.id)

		if var_10_1.item_type == ArtifactConst.ARTIFACT_ABLE_FRAGMENT_TYPE and arg_10_1 == var_10_1.quality and arg_10_2 == var_10_1.rare then
			table.insert(var_10_0, {
				id = iter_10_1.id,
				num = iter_10_1.num,
				quality = var_10_1.quality,
				rare = var_10_1.rare
			})
		end
	end

	return var_10_0
end

function AbleFragmentData:isHaveArtifactAbleFragment(arg_11_1)
	local var_11_0 = g.core.config.fragment_info.get(arg_11_1)

	if #self:getAbleFragmentArtifactList(var_11_0.quality, var_11_0.rare) > 0 then
		return true
	end

	return false
end

function AbleFragmentData:getAbleFragmentPetsList(arg_12_1, arg_12_2)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs((g.core.model.User.bagData:getList(var_0_0.BAG_TYPE.ITEM))) do
		local var_12_1 = g.core.config.item_info.get(iter_12_1.id)

		if var_12_1.item_type == var_0_0.PetConst.PET_ABLE_FRAGMENT_TYPE and arg_12_1 == var_12_1.quality and arg_12_2 == var_12_1.rare then
			table.insert(var_12_0, {
				id = iter_12_1.id,
				num = iter_12_1.num,
				quality = var_12_1.quality,
				rare = var_12_1.rare
			})
		end
	end

	return var_12_0
end

function AbleFragmentData:getAbleFragmentPreciousList(arg_13_1, arg_13_2)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs((g.core.model.User.bagData:getList(var_0_0.BAG_TYPE.ITEM))) do
		local var_13_1 = g.core.config.item_info.get(iter_13_1.id)

		if var_13_1.item_type == var_0_0.PreciousConst.PRECIOUS_ABLE_FRAGMENT_TYPE and arg_13_1 == var_13_1.quality and arg_13_2 == var_13_1.rare then
			table.insert(var_13_0, {
				id = iter_13_1.id,
				num = iter_13_1.num,
				quality = var_13_1.quality,
				rare = var_13_1.rare
			})
		end
	end

	return var_13_0
end

function AbleFragmentData:getAbleFragmentSuccubaList(arg_14_1, arg_14_2)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs((g.core.model.User.bagData:getList(var_0_0.BAG_TYPE.ITEM))) do
		local var_14_1 = g.core.config.item_info.get(iter_14_1.id)

		if var_14_1.item_type == var_0_0.SuccubaConst.ABLE_FRAGMENT_TYPE and arg_14_1 == var_14_1.quality and arg_14_2 == var_14_1.rare then
			table.insert(var_14_0, {
				id = iter_14_1.id,
				num = iter_14_1.num,
				quality = var_14_1.quality,
				rare = var_14_1.rare
			})
		end
	end

	return var_14_0
end

return AbleFragmentData
