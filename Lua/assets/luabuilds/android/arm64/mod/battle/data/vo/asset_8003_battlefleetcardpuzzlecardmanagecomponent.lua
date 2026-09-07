ys = ys or {}

local var_0_0 = ys
local var_0_3 = ys.Battle.BattleCardPuzzleEvent
local BattleFleetCardPuzzleCardManageComponent = class("BattleFleetCardPuzzleCardManageComponent")

ys.Battle.BattleFleetCardPuzzleCardManageComponent = BattleFleetCardPuzzleCardManageComponent
BattleFleetCardPuzzleCardManageComponent.__name = "BattleFleetCardPuzzleCardManageComponent"
BattleFleetCardPuzzleCardManageComponent.FUNC_NAME_SHUFFLE = "Shuffle"
BattleFleetCardPuzzleCardManageComponent.FUNC_NAME_POP = "Pop"
BattleFleetCardPuzzleCardManageComponent.FUNC_NAME_ADD = "Add"
BattleFleetCardPuzzleCardManageComponent.FUNC_NAME_BOTTOM = "Bottom"
BattleFleetCardPuzzleCardManageComponent.FUNC_NAME_REMOVE = "Remove"
BattleFleetCardPuzzleCardManageComponent.FUNC_NAME_SEARCH = "Search"
BattleFleetCardPuzzleCardManageComponent.FUNC_NAME_SORT = "Sort"
BattleFleetCardPuzzleCardManageComponent.FUNC_NAME_GET_LENGTH = "GetLength"
BattleFleetCardPuzzleCardManageComponent.SEARCH_BY_ID = "ID"
BattleFleetCardPuzzleCardManageComponent.SEARCH_BY_LABEL = "LABEL"
BattleFleetCardPuzzleCardManageComponent.SEARCH_BY_TYPE = "TYPE"

function BattleFleetCardPuzzleCardManageComponent:AttachCardManager()
	assert(self.GetCardList ~= nil, "该类>>" .. self.__name .. "<<使用card puzzle卡牌管理组件需要支持接口>>GetCardList<<，并返回所有的卡牌列表")
	assert(self.DispatchEvent ~= nil, "该类>>" .. self.__name .. "<<使用card puzzle卡牌管理组件需要事件派发组件")
	BattleFleetCardPuzzleCardManageComponent.New(self)

	return
end

function BattleFleetCardPuzzleCardManageComponent:DetachCardManager()
	if self._cardManager_ == nil then
		return
	end

	self._cardManager_:_destroy_()

	self._cardManager_ = nil

	return
end

function BattleFleetCardPuzzleCardManageComponent:Ctor(arg_3_1)
	self._target_ = arg_3_1

	self:_init_()

	return
end

function BattleFleetCardPuzzleCardManageComponent:_init_()
	self:_overrideAttachFunc(BattleFleetCardPuzzleCardManageComponent.FUNC_NAME_SHUFFLE, BattleFleetCardPuzzleCardManageComponent._shuffle_)
	self:_overrideAttachFunc(BattleFleetCardPuzzleCardManageComponent.FUNC_NAME_POP, BattleFleetCardPuzzleCardManageComponent._pop_)
	self:_overrideAttachFunc(BattleFleetCardPuzzleCardManageComponent.FUNC_NAME_ADD, BattleFleetCardPuzzleCardManageComponent._add_)
	self:_overrideAttachFunc(BattleFleetCardPuzzleCardManageComponent.FUNC_NAME_BOTTOM, BattleFleetCardPuzzleCardManageComponent._bottom_)
	self:_overrideAttachFunc(BattleFleetCardPuzzleCardManageComponent.FUNC_NAME_REMOVE, BattleFleetCardPuzzleCardManageComponent._remove_)
	self:_overrideAttachFunc(BattleFleetCardPuzzleCardManageComponent.FUNC_NAME_SEARCH, BattleFleetCardPuzzleCardManageComponent._search_)
	self:_overrideAttachFunc(BattleFleetCardPuzzleCardManageComponent.FUNC_NAME_SORT, BattleFleetCardPuzzleCardManageComponent._sort_)
	self:_overrideAttachFunc(BattleFleetCardPuzzleCardManageComponent.FUNC_NAME_GET_LENGTH, BattleFleetCardPuzzleCardManageComponent._getLength_)

	return
end

function BattleFleetCardPuzzleCardManageComponent:_overrideAttachFunc(arg_5_1, arg_5_2)
	if self._target_[arg_5_1] ~= nil then
		local var_5_0 = self._target_[arg_5_1]

		self._target_[arg_5_1] = function(...)
			var_5_0(...)
			arg_5_2(...)

			return
		end
	else
		self._target_[arg_5_1] = arg_5_2
	end

	return
end

function BattleFleetCardPuzzleCardManageComponent:_destroy_()
	self._target_ = nil

	return
end

function BattleFleetCardPuzzleCardManageComponent:_add_(arg_8_1)
	table.insert(self:GetCardList(), arg_8_1)
	arg_8_1:SetCurrentPile(self:GetIndexID())
	self:DispatchEvent(var_0_0.Event.New(var_0_3.UPDATE_CARDS, {
		type = BattleFleetCardPuzzleCardManageComponent.FUNC_NAME_ADD
	}))

	return
end

function BattleFleetCardPuzzleCardManageComponent:_bottom_(arg_9_1)
	table.insert(self:GetCardList(), 1, arg_9_1)
	self:DispatchEvent(var_0_0.Event.New(var_0_3.UPDATE_CARDS, {
		type = BattleFleetCardPuzzleCardManageComponent.FUNC_NAME_BOTTOM
	}))

	return
end

function BattleFleetCardPuzzleCardManageComponent:_remove_(arg_10_1)
	local var_10_0 = self:GetCardList()

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if arg_10_1 == iter_10_1 then
			arg_10_1:SetFromPile(self:GetIndexID())
			table.remove(var_10_0, iter_10_0)
			self:DispatchEvent(var_0_0.Event.New(var_0_3.UPDATE_CARDS, {
				type = BattleFleetCardPuzzleCardManageComponent.FUNC_NAME_REMOVE
			}))

			return
		end
	end

	return
end

function BattleFleetCardPuzzleCardManageComponent:_shuffle_()
	local var_11_0 = self:GetCardList()
	local var_11_1 = self:GetLength()

	while var_11_1 > 0 do
		local var_11_2 = math.random(var_11_1)

		var_11_0[var_11_1], var_11_0[var_11_2] = var_11_0[var_11_2], var_11_0[var_11_1]
		var_11_1 = var_11_1 - 1
	end

	self:DispatchEvent(var_0_0.Event.New(var_0_3.UPDATE_CARDS, {
		type = BattleFleetCardPuzzleCardManageComponent.FUNC_NAME_SHUFFLE
	}))

	return
end

function BattleFleetCardPuzzleCardManageComponent:_pop_()
	local var_12_0 = self:GetCardList()

	table.remove(var_12_0, #var_12_0):SetFromPile(self:GetIndexID())

	local var_12_3 = self:DispatchEvent(var_0_0.Event.New(var_0_3.UPDATE_CARDS, {
		type = BattleFleetCardPuzzleCardManageComponent.FUNC_NAME_POP
	}))
end

function BattleFleetCardPuzzleCardManageComponent:_sort_(arg_13_1)
	return
end

function BattleFleetCardPuzzleCardManageComponent:_search_(arg_14_1)
	local var_14_0 = {}
	local var_14_1 = self:GetCardList()

	if arg_14_1.type == BattleFleetCardPuzzleCardManageComponent.SEARCH_BY_ID then
		for iter_14_0, iter_14_1 in ipairs(var_14_1) do
			if table.contains(arg_14_1.value, iter_14_1:GetCardID()) then
				table.insert(var_14_0, iter_14_1)
			end
		end
	elseif arg_14_1.type == BattleFleetCardPuzzleCardManageComponent.SEARCH_BY_LABEL then
		for iter_14_2, iter_14_3 in ipairs(var_14_1) do
			if iter_14_3:LabelContain(arg_14_1.value) then
				table.insert(var_14_0, iter_14_3)
			end
		end
	elseif arg_14_1.type == BattleFleetCardPuzzleCardManageComponent.SEARCH_BY_TYPE then
		for iter_14_4, iter_14_5 in ipairs(var_14_1) do
			if iter_14_5:GetType() == arg_14_1.value then
				table.insert(var_14_0, iter_14_5)
			end
		end
	end

	if arg_14_1.total == true then
		return var_14_0
	else
		return {
			var_14_0[math.random(#var_14_0)]
		}
	end

	return
end

function BattleFleetCardPuzzleCardManageComponent:_getLength_()
	return #self:GetCardList()
end

return
