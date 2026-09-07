local PacGameItemController = class("PacGameItemController")
local var_0_2 = 1

function PacGameItemController:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._sceneMask = arg_1_1
	self._event = arg_1_2
	self._runningData = arg_1_3
	self._content = findTF(self._sceneMask, "sceneContainer/scene/content/map")

	return
end

function PacGameItemController:Prepare()
	self._itemConfig = self._runningData:GetMapConfig("item")
	self._gridDic = self._runningData:GetGridDic()
	self._mapTFDic = self._runningData:GetMapTFDic()
	self._player = self._runningData:GetPlayer()

	return
end

function PacGameItemController:Start()
	self._createItemTime = PacGameConst.item_time
	self._items = {}

	return
end

function PacGameItemController:Step(arg_4_1)
	self._deltaTime = arg_4_1

	if self._runningData:GetEditor() then
		return
	end

	if self._createItemTime and self._createItemTime > 0 then
		self._createItemTime = self._createItemTime - arg_4_1

		if self._createItemTime <= 0 then
			self:tryCreateItem()

			self._createItemTime = PacGameConst.item_time
		end
	end

	local var_4_0 = self._player:GetGridIndex()

	for iter_4_0 = #self._items, 1, -1 do
		if self._items[iter_4_0]:GetIndex() == var_4_0 then
			self:SetItemEffect(self._items[iter_4_0]:GetConfig("effect"), (self._items[iter_4_0]:GetConfig("effect_time")))
			self._items[iter_4_0]:Dispose()
			table.remove(self._items, iter_4_0)
		end
	end

	return
end

function PacGameItemController:Clear()
	self._player = nil

	for iter_5_0 = #self._items, 1, -1 do
		self._items[iter_5_0]:Dispose()
	end

	self._items = {}

	return
end

function PacGameItemController:Stop()
	return
end

function PacGameItemController:Resume()
	return
end

function PacGameItemController:Dispose()
	return
end

function PacGameItemController:SetItemEffect(arg_9_1, arg_9_2)
	if not self._player then
		return
	end

	if arg_9_1 == var_0_2 then
		self._player:SetRush(true, arg_9_2)
	end

	return
end

function PacGameItemController:tryCreateItem()
	local var_10_0 = {}
	local var_10_1 = self._player:GetGridIndex()

	for iter_10_0, iter_10_1 in pairs(self._gridDic) do
		if iter_10_1:GetPassAble() and not iter_10_1:GetScoreFlag() and iter_10_1:GetIndex() ~= var_10_1 then
			table.insert(var_10_0, iter_10_1:GetIndex())
		end
	end

	if #self._items <= PacGameConst.max_item_count and #var_10_0 >= 10 and math.random() <= PacGameConst.item_rate then
		local var_10_2 = self._gridDic[var_10_0[math.random(1, #var_10_0)]]
		local var_10_3, var_10_4 = var_10_2:GetVH()
		local var_10_5 = self:createItem(self._itemConfig[math.random(1, #self._itemConfig)], var_10_2:GetIndex(), self._mapTFDic[var_10_3])

		var_10_5:SetPosition((var_10_2:GetPosition()))
		table.insert(self._items, var_10_5)
	end

	return
end

function PacGameItemController:createItem(arg_11_1, arg_11_2, arg_11_3)
	return (PacGameItem.New(self._runningData:GetTplItemFromPool(PacGameConst.item_data[arg_11_1].prefab, arg_11_3), arg_11_2, PacGameConst.item_data[arg_11_1]))
end

return PacGameItemController
