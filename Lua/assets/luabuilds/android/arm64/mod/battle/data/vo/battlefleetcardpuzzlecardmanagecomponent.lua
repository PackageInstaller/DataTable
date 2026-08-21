ys = ys or {}

local var_0_2 = ys.Battle.BattleCardPuzzleEvent
local var_0_9 = class("BattleFleetCardPuzzleCardManageComponent")

ys.Battle.BattleFleetCardPuzzleCardManageComponent = var_0_9
var_0_9.__name = "BattleFleetCardPuzzleCardManageComponent"
var_0_9.FUNC_NAME_SHUFFLE = "Shuffle"
var_0_9.FUNC_NAME_POP = "Pop"
var_0_9.FUNC_NAME_ADD = "Add"
var_0_9.FUNC_NAME_BOTTOM = "Bottom"
var_0_9.FUNC_NAME_REMOVE = "Remove"
var_0_9.FUNC_NAME_SEARCH = "Search"
var_0_9.FUNC_NAME_SORT = "Sort"
var_0_9.FUNC_NAME_GET_LENGTH = "GetLength"
var_0_9.SEARCH_BY_ID = "ID"
var_0_9.SEARCH_BY_LABEL = "LABEL"
var_0_9.SEARCH_BY_TYPE = "TYPE"

function var_0_9.AttachCardManager(arg_1_0)
	assert(arg_1_0.GetCardList ~= nil, "该类>>" .. arg_1_0.__name .. "<<使用card puzzle卡牌管理组件需要支持接口>>GetCardList<<，并返回所有的卡牌列表")
	assert(arg_1_0.DispatchEvent ~= nil, "该类>>" .. arg_1_0.__name .. "<<使用card puzzle卡牌管理组件需要事件派发组件")
	var_0_9.New(arg_1_0)

	return
end

function var_0_9.DetachCardManager(arg_2_0)
	if arg_2_0._cardManager_ == nil then
		return
	end

	arg_2_0._cardManager_:_destroy_()

	arg_2_0._cardManager_ = nil

	return
end

function var_0_9.Ctor(arg_3_0, arg_3_1)
	arg_3_0._target_ = arg_3_1

	arg_3_0:_init_()

	return
end

function var_0_9._init_(arg_4_0)
	arg_4_0:_overrideAttachFunc(var_0_9.FUNC_NAME_SHUFFLE, var_0_9._shuffle_)
	arg_4_0:_overrideAttachFunc(var_0_9.FUNC_NAME_POP, var_0_9._pop_)
	arg_4_0:_overrideAttachFunc(var_0_9.FUNC_NAME_ADD, var_0_9._add_)
	arg_4_0:_overrideAttachFunc(var_0_9.FUNC_NAME_BOTTOM, var_0_9._bottom_)
	arg_4_0:_overrideAttachFunc(var_0_9.FUNC_NAME_REMOVE, var_0_9._remove_)
	arg_4_0:_overrideAttachFunc(var_0_9.FUNC_NAME_SEARCH, var_0_9._search_)
	arg_4_0:_overrideAttachFunc(var_0_9.FUNC_NAME_SORT, var_0_9._sort_)
	arg_4_0:_overrideAttachFunc(var_0_9.FUNC_NAME_GET_LENGTH, var_0_9._getLength_)

	return
end

function var_0_9._overrideAttachFunc(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0._target_[arg_5_1] ~= nil then
		local var_5_0 = arg_5_0._target_[arg_5_1]

		arg_5_0._target_[arg_5_1] = function(...)
			var_5_0(...)
			arg_5_2(...)

			return
		end
	else
		arg_5_0._target_[arg_5_1] = arg_5_2
	end

	return
end

function var_0_9._destroy_(arg_7_0)
	arg_7_0._target_ = nil

	return
end

function var_0_9._add_(arg_8_0, arg_8_1)
	table.insert(arg_8_0:GetCardList(), arg_8_1)
	arg_8_1:SetCurrentPile(arg_8_0:GetIndexID())
	arg_8_0:DispatchEvent(var_0.Event.New(var_0_2.UPDATE_CARDS, {
		type = var_0_9.FUNC_NAME_ADD
	}))

	return
end

function var_0_9._bottom_(arg_9_0, arg_9_1)
	table.insert(arg_9_0:GetCardList(), 1, arg_9_1)
	arg_9_0:DispatchEvent(var_0.Event.New(var_0_2.UPDATE_CARDS, {
		type = var_0_9.FUNC_NAME_BOTTOM
	}))

	return
end

function var_0_9._remove_(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:GetCardList()

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if arg_10_1 == iter_10_1 then
			arg_10_1:SetFromPile(arg_10_0:GetIndexID())
			table.remove(var_10_0, iter_10_0)
			arg_10_0:DispatchEvent(var_0.Event.New(var_0_2.UPDATE_CARDS, {
				type = var_0_9.FUNC_NAME_REMOVE
			}))

			return
		end
	end

	return
end

function var_0_9._shuffle_(arg_11_0)
	local var_11_0 = arg_11_0:GetCardList()
	local var_11_1 = arg_11_0:GetLength()

	while var_11_1 > 0 do
		local var_11_2 = math.random(var_11_1)

		var_11_0[var_11_1], var_11_0[var_11_2] = var_11_0[var_11_2], var_11_0[var_11_1]
		var_11_1 = var_11_1 - 1
	end

	arg_11_0:DispatchEvent(var_0.Event.New(var_0_2.UPDATE_CARDS, {
		type = var_0_9.FUNC_NAME_SHUFFLE
	}))

	return
end

function var_0_9._pop_(arg_12_0)
	local var_12_0 = arg_12_0:GetCardList()
	local var_12_1 = table.remove(var_12_0, #var_12_0)

	var_12_1:SetFromPile(arg_12_0:GetIndexID())

	local var_12_3 = arg_12_0:DispatchEvent(var_0.Event.New(var_0_2.UPDATE_CARDS, {
		type = var_0_9.FUNC_NAME_POP
	}))
end

function var_0_9._sort_(arg_13_0, arg_13_1)
	return
end

function var_0_9._search_(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:GetCardList()

	if arg_14_1.type == var_0_9.SEARCH_BY_ID then
		for iter_14_0, iter_14_1 in ipairs(var_14_0) do
			if table.contains(arg_14_1.value, iter_14_1:GetCardID()) then
				table.insert({}, iter_14_1)
			end
		end
	elseif arg_14_1.type == var_0_9.SEARCH_BY_LABEL then
		for iter_14_2, iter_14_3 in ipairs(var_14_0) do
			if iter_14_3:LabelContain(arg_14_1.value) then
				table.insert({}, iter_14_3)
			end
		end
	elseif arg_14_1.type == var_0_9.SEARCH_BY_TYPE then
		for iter_14_4, iter_14_5 in ipairs(var_14_0) do
			if iter_14_5:GetType() == arg_14_1.value then
				table.insert({}, iter_14_5)
			end
		end
	end

	if arg_14_1.total == true then
		return {}
	else
		return {
			({})[math.random(#{})]
		}
	end

	return
end

function var_0_9._getLength_(arg_15_0)
	return #arg_15_0:GetCardList()
end

return
