ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle.BattleEvent
local var_0_3 = var_0.Battle.BattleCardPuzzleEvent
local var_0_4 = var_0.Battle.BattleFormulas
local var_0_5 = var_0.Battle.BattleConst
local var_0_6 = var_0.Battle.BattleConfig
local var_0_7 = var_0.Battle.BattleAttr
local var_0_8 = var_0.Battle.BattleDataFunction
local var_0_9 = var_0.Battle.BattleAttr

class = var_0_10010

local var_0_10 = var_0_10010("BattleFleetCardPuzzleCardManageComponent")

var_0.Battle.BattleFleetCardPuzzleCardManageComponent = var_0_10
var_0_10.__name = "BattleFleetCardPuzzleCardManageComponent"
var_0_10.FUNC_NAME_SHUFFLE = "Shuffle"
var_0_10.FUNC_NAME_POP = "Pop"
var_0_10.FUNC_NAME_ADD = "Add"
var_0_10.FUNC_NAME_BOTTOM = "Bottom"
var_0_10.FUNC_NAME_REMOVE = "Remove"
var_0_10.FUNC_NAME_SEARCH = "Search"
var_0_10.FUNC_NAME_SORT = "Sort"
var_0_10.FUNC_NAME_GET_LENGTH = "GetLength"
var_0_10.SEARCH_BY_ID = "ID"
var_0_10.SEARCH_BY_LABEL = "LABEL"
var_0_10.SEARCH_BY_TYPE = "TYPE"

function var_0_10.AttachCardManager(arg_1_0)
	assert = var_1_10001

	var_1_10001(arg_1_0.GetCardList ~= nil, "该类>>" .. arg_1_0.__name .. "<<使用card puzzle卡牌管理组件需要支持接口>>GetCardList<<，并返回所有的卡牌列表")

	assert = var_1_10001

	var_1_10001(arg_1_0.DispatchEvent ~= nil, "该类>>" .. arg_1_0.__name .. "<<使用card puzzle卡牌管理组件需要事件派发组件")
	var_0_10.New(arg_1_0)

	return
end

function var_0_10.DetachCardManager(arg_2_0)
	if arg_2_0._cardManager_ == nil then
		return
	end

	local var_2_0 = arg_2_0._cardManager_

	var_1._destroy_(var_2_0)

	arg_2_0._cardManager_ = nil

	return
end

function var_0_10.Ctor(arg_3_0, arg_3_1)
	arg_3_0._target_ = arg_3_1

	arg_3_0:_init_()

	return
end

function var_0_10._init_(arg_4_0)
	arg_4_0:_overrideAttachFunc(var_0_10.FUNC_NAME_SHUFFLE, var_0_10._shuffle_)
	arg_4_0:_overrideAttachFunc(var_0_10.FUNC_NAME_POP, var_0_10._pop_)
	arg_4_0:_overrideAttachFunc(var_0_10.FUNC_NAME_ADD, var_0_10._add_)
	arg_4_0:_overrideAttachFunc(var_0_10.FUNC_NAME_BOTTOM, var_0_10._bottom_)
	arg_4_0:_overrideAttachFunc(var_0_10.FUNC_NAME_REMOVE, var_0_10._remove_)
	arg_4_0:_overrideAttachFunc(var_0_10.FUNC_NAME_SEARCH, var_0_10._search_)
	arg_4_0:_overrideAttachFunc(var_0_10.FUNC_NAME_SORT, var_0_10._sort_)
	arg_4_0:_overrideAttachFunc(var_0_10.FUNC_NAME_GET_LENGTH, var_0_10._getLength_)

	return
end

function var_0_10._overrideAttachFunc(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0._target_[arg_5_1] ~= nil then
		local var_5_0 = arg_5_0._target_[arg_5_1]

		local function var_5_1(...)
			var_5_0(...)
			arg_5_2(...)

			return
		end

		arg_5_0._target_[arg_5_1] = var_5_1
	else
		arg_5_0._target_[arg_5_1] = arg_5_2
	end

	return
end

function var_0_10._destroy_(arg_7_0)
	arg_7_0._target_ = nil

	return
end

function var_0_10._add_(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.GetCardList(var_8_0)

	table = var_8_0

	var_8_0.insert(var_8_1, arg_8_1)
	arg_8_1:SetCurrentPile(arg_8_0:GetIndexID())
	arg_8_0:DispatchEvent(var_0.Event.New(var_0_3.UPDATE_CARDS, {
		type = var_0_10.FUNC_NAME_ADD
	}))

	return
end

function var_0_10._bottom_(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.GetCardList(var_9_0)

	table = var_9_0

	var_9_0.insert(var_9_1, 1, arg_9_1)
	arg_9_0:DispatchEvent(var_0.Event.New(var_0_3.UPDATE_CARDS, {
		type = var_0_10.FUNC_NAME_BOTTOM
	}))

	return
end

function var_0_10._remove_(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.GetCardList(var_10_0)

	ipairs = var_10_0

	for iter_10_0, iter_10_1 in var_10_0(var_10_1) do
		if arg_10_1 == iter_10_1 then
			arg_10_1:SetFromPile(arg_10_0:GetIndexID())

			table = var_8

			var_8.remove(var_10_1, iter_10_0)
			arg_10_0:DispatchEvent(var_0.Event.New(var_0_3.UPDATE_CARDS, {
				type = var_0_10.FUNC_NAME_REMOVE
			}))

			return
		end
	end

	return
end

function var_0_10._shuffle_(arg_11_0)
	local var_11_0 = arg_11_0:GetCardList()
	local var_11_1 = arg_11_0:GetLength()

	while 0 < var_11_1 do
		math = var_3
		var_11_0[var_11_1], var_11_0[var_3] = var_11_0[var_3.random(var_11_1)], var_11_0[var_11_1]
		var_11_1 = var_11_1 - 1
	end

	arg_11_0:DispatchEvent(var_0.Event.New(var_0_3.UPDATE_CARDS, {
		type = var_0_10.FUNC_NAME_SHUFFLE
	}))

	return
end

function var_0_10._pop_(arg_12_0)
	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.GetCardList(var_12_0)

	table = var_12_0

	local var_12_2 = var_12_0.remove(var_12_1, #var_12_1)

	var_2.SetFromPile(var_12_2, arg_12_0:GetIndexID())

	local var_12_3 = var_2
	local var_12_4 = arg_12_0:DispatchEvent(var_0.Event.New(var_0_3.UPDATE_CARDS, {
		type = var_0_10.FUNC_NAME_POP
	}))
end

function var_0_10._sort_(arg_13_0, arg_13_1)
	return
end

function var_0_10._search_(arg_14_0, arg_14_1)
	local var_14_0 = {}
	local var_14_1 = arg_14_0:GetCardList()
	local var_14_2 = arg_14_1.value

	if arg_14_1.type == var_0_10.SEARCH_BY_ID then
		ipairs = var_6

		for iter_14_0, iter_14_1 in var_6(var_14_1) do
			table = var_1_10011

			if var_1_10011.contains(var_14_2, iter_14_1:GetCardID()) then
				table = var_1_10011

				var_1_10011.insert(var_14_0, iter_14_1)
			end
		end
	elseif var_5 == var_0_10.SEARCH_BY_LABEL then
		ipairs = var_6

		for iter_14_2, iter_14_3 in var_6(var_14_1) do
			if iter_14_3:LabelContain(var_14_2) then
				table = var_11

				var_11.insert(var_14_0, iter_14_3)
			end
		end
	elseif var_5 == var_0_10.SEARCH_BY_TYPE then
		ipairs = var_6

		for iter_14_4, iter_14_5 in var_6(var_14_1) do
			if iter_14_5:GetType() == var_14_2 then
				table = var_11

				var_11.insert(var_14_0, iter_14_5)
			end
		end
	end

	if arg_14_1.total == true then
		return var_14_0
	else
		local var_14_3 = {}

		math = var_1_10007
		var_14_3[1] = var_14_0[var_1_10007.random(#var_14_0)]

		return var_14_3
	end

	return
end

function var_0_10._getLength_(arg_15_0)
	return #arg_15_0:GetCardList()
end

return
