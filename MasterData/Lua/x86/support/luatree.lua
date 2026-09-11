local LuaTree = class("LuaTree")

function LuaTree:Ctor(arg_1_1)
	self.treeGo_ = arg_1_1

	self:InitUI()
	self:AddListeners()

	if not self.ctored_ then
		ReduxFactory.GetInstance():OnManagedObjCtor(self)
	end

	self.ctored_ = true
end

function LuaTree:InitUI()
	self.tree_ = self.treeGo_:GetComponent("UITree")
end

function LuaTree:AddListeners()
	if self.tree_ ~= nil then
		self.tree_:SetItemRenderer(handler(self, self.ItemRenderer))
		self.tree_:SetGroupRenderer(handler(self, self.GroupRenderer))
		self.tree_:SetGroupSelectHandler(handler(self, self.OnGroupSelect))
		self.tree_:SetItemSelectHandler(handler(self, self.OnItemSelect))
	end
end

function LuaTree:RemoveListeners()
	if self.tree_ ~= nil then
		self.tree_:SetItemRenderer(nil)
		self.tree_:SetGroupRenderer(nil)
		self.tree_:SetGroupSelectHandler(nil)
		self.tree_:SetItemSelectHandler(nil)
	end
end

function LuaTree:SetData(arg_5_1)
	if self.tree_ ~= nil then
		self.tree_:SetData(arg_5_1)
	end
end

function LuaTree:SetRenderer(arg_6_1, arg_6_2)
	self.groupRenderer_ = arg_6_1
	self.itemRenderer_ = arg_6_2
end

function LuaTree:OverrideRenderer(arg_7_1, arg_7_2)
	self:SetRenderer(arg_7_1 or self.groupRenderer_, arg_7_2 or self.itemRenderer_)
end

function LuaTree:SetSelectedHandler(arg_8_1, arg_8_2)
	self.itemSelectedHandler_ = arg_8_2
	self.groupSelectHandler_ = arg_8_1
end

function LuaTree:OnItemSelect(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if self.itemSelectedHandler_ ~= nil then
		self.itemSelectedHandler_(arg_9_1 + 1, arg_9_2, arg_9_3, arg_9_4)
	end
end

function LuaTree:OnGroupSelect(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if self.groupSelectHandler_ ~= nil then
		self.groupSelectHandler_(arg_10_1 + 1, arg_10_2, arg_10_3, arg_10_4)
	end
end

function LuaTree:ItemRenderer(arg_11_1, arg_11_2)
	if self.itemRenderer_ then
		self.itemRenderer_(arg_11_1, arg_11_2)
	end
end

function LuaTree:GroupRenderer(arg_12_1, arg_12_2)
	if self.groupRenderer_ then
		self.groupRenderer_(arg_12_1, arg_12_2)
	end
end

function LuaTree:SelectGroup(arg_13_1)
	self.tree_:SelectGroup(arg_13_1 - 1, false)

	if self.groupSelectHandler_ then
		self.groupSelectHandler_(arg_13_1, self.tree_.data.groupDatas[arg_13_1 - 1].id, self.tree_.data.groupDatas[arg_13_1 - 1].text, self.tree_.data.groupDatas[arg_13_1 - 1].extraData)
	end
end

function LuaTree:GetGroupGameObjectById(arg_14_1)
	return self.tree_:GetGroupGameObjectById(arg_14_1)
end

function LuaTree:SelectItem(arg_15_1, arg_15_2)
	self.tree_:SelectItem(arg_15_1 - 1, arg_15_2 - 1)

	if self.groupSelectHandler_ then
		self.groupSelectHandler_(arg_15_1, self.tree_.data.groupDatas[arg_15_1 - 1].id, self.tree_.data.groupDatas[arg_15_1 - 1].text, self.tree_.data.groupDatas[arg_15_1 - 1].extraData)
	end

	if arg_15_2 - 1 < self.tree_.data.groupDatas[arg_15_1 - 1].itemDatas.Count then
		if self.itemSelectedHandler_ then
			self.itemSelectedHandler_(arg_15_2, self.tree_.data.groupDatas[arg_15_1 - 1].itemDatas[arg_15_2 - 1].id, self.tree_.data.groupDatas[arg_15_1 - 1].itemDatas[arg_15_2 - 1].text, self.tree_.data.groupDatas[arg_15_1 - 1].itemDatas[arg_15_2 - 1].extraData)
		end
	end
end

function LuaTree:GetItemGameObjectById(arg_16_1, arg_16_2)
	return self.tree_:GetItemGameObjectById(arg_16_1, arg_16_2)
end

function LuaTree:GetGroupRedPointContainerById(arg_17_1)
	local var_17_0 = self.tree_:GetGroupGameObjectById(arg_17_1)

	if var_17_0 ~= nil then
		return var_17_0:GetComponent("UITreeGroup").noticeContainer
	end

	return nil
end

function LuaTree:GetItemRedPointContainerById(arg_18_1, arg_18_2)
	local var_18_0 = self.tree_:GetItemGameObjectById(arg_18_1, arg_18_2)

	if var_18_0 ~= nil then
		return var_18_0:GetComponent("UITreeItem").noticeContainer
	end

	return nil
end

function LuaTree:Refresh()
	self.tree_:Refresh()
end

function LuaTree:GetData()
	return self.tree_.data
end

function LuaTree:SetGroupItemOn(arg_21_1, arg_21_2)
	local var_21_0 = self.tree_:GetItemGameObjectById(arg_21_1, arg_21_2)

	if var_21_0 == nil then
		return
	end

	ControllerUtil.GetController(var_21_0.transform, "toggle"):SetSelectedState("on")
end

function LuaTree:RefreshSelectGroupItem(arg_22_1, arg_22_2)
	self.tree_:NotifyItemSelect(arg_22_1 - 1, arg_22_2 - 1)
end

function LuaTree:Dispose()
	self:RemoveListeners()

	if self.tree_ ~= nil then
		self.tree_ = nil
	end

	ReduxFactory.GetInstance():OnManagedObjDisposed(self)
end

local function var_0_1(arg_24_0, arg_24_1, arg_24_2)
	return math.min(math.max(arg_24_0, arg_24_1), arg_24_2)
end

local function var_0_2(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_1:InverseTransformPoint(arg_25_0:TransformPoint(arg_25_0.rect.min))
	local var_25_1 = UnityEngine.Rect.MinMaxRect(arg_25_1.rect.xMin, arg_25_1.rect.yMin, arg_25_1.rect.xMax - arg_25_0.rect.width, arg_25_1.rect.yMax - arg_25_0.rect.height)

	return Vector3(var_0_1(var_25_0.x, var_25_1.xMin, var_25_1.xMax) - var_25_0.x, var_0_1(var_25_0.y, var_25_1.yMin, var_25_1.yMax) - var_25_0.y, 0)
end

function LuaTree:GetItem(arg_26_1, arg_26_2)
	return self.tree_:GetItemGameObjectById(self.tree_.data.groupDatas[arg_26_1 - 1].id, self.tree_.data.groupDatas[arg_26_1 - 1].itemDatas[arg_26_2 - 1].id)
end

function LuaTree:ClampItemInRect(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	arg_27_4.localPosition = arg_27_4.localPosition + arg_27_4:InverseTransformVector(arg_27_3:TransformVector(var_0_2(self:GetItem(arg_27_1, arg_27_2).transform, arg_27_3)))
end

return LuaTree
