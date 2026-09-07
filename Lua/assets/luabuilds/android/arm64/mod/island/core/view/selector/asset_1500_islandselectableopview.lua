local IslandSelectableOpView = class("IslandSelectableOpView", import("Mod.Island.Core.View.IslandASynLoadAndCacheSubView"))

function IslandSelectableOpView:GetUIName()
	return "IslandSelectableOpUI"
end

function IslandSelectableOpView:SetUIParent(arg_2_1)
	return self:GetView().topContainer
end

function IslandSelectableOpView:FirstFlush()
	self.frameTr = self._tf:Find("list")
	self.cotainer = self._tf:Find("list/content")
	self.tpl = self._tf:Find("list/content/item")
	self.gridLayoutGroup = self.cotainer:GetComponent(typeof(GridLayoutGroup))
	self.uiItemList = UIItemList.New(self.cotainer, self.tpl)
	self.descPanle = IslandSelectableDescPanel.New(self._tf:Find("desc"), self:IsShowItemCount())

	onButton(self, self._tf, function()
		if self.descPanle:IsShowing() then
			self.descPanle:Hide()

			return
		end

		self:Dispose()

		return
	end, SFX_PANEL)

	return
end

function IslandSelectableOpView:Filter(arg_5_1)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		assert(isa(iter_5_1, IslandItem), "v is not a IslandItem")

		if iter_5_1:GetCount() > 0 then
			table.insert(var_5_0, iter_5_1)
		end
	end

	self:Sort(var_5_0)

	return var_5_0
end

function IslandSelectableOpView:Sort(arg_6_1)
	table.sort(arg_6_1, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_0:GetRarity()
		local var_7_1 = arg_7_1:GetRarity()

		if var_7_0 == var_7_1 then
			return arg_7_0.id > arg_7_1.id
		else
			return var_7_1 < var_7_0
		end

		return
	end)

	return
end

function IslandSelectableOpView:Flush()
	self.selectedId = self:GetSelectedId()
	self.displays = self:Filter(self:GetDisplayData())

	seriesAsync({
		function(arg_9_0)
			self:PreloadList(arg_9_0)

			return
		end
	}, function()
		self:UpdateLayout()
		self:UpdateList()

		return
	end)

	return
end

function IslandSelectableOpView:PreloadList(arg_11_1)
	if #self.displays <= 5 then
		arg_11_1()

		return
	end

	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(self.displays) do
		table.insert(var_11_0, function(arg_12_0)
			cloneTplTo(self.tpl, self.cotainer)

			if iter_11_0 % 3 == 0 then
				onNextTick(arg_12_0)
			else
				arg_12_0()
			end

			return
		end)
	end

	seriesAsync(var_11_0, arg_11_1)

	return
end

function IslandSelectableOpView:UpdateLayout()
	self.gridLayoutGroup.constraintCount = math.min(#self.displays, (self:GetMaxHrzCnt()))

	local var_13_0 = self:GetTargetTr()

	self.frameTr.position = IslandSelectableOpView.TrPosition2LocalPos(var_13_0.parent, self.frameTr.parent, var_13_0.position)

	return
end

function IslandSelectableOpView:TrPosition2LocalPos(arg_14_1, arg_14_2)
	if self == arg_14_1 then
		return arg_14_2
	else
		local var_14_0 = arg_14_1:InverseTransformPoint((self:TransformPoint(arg_14_2)))

		return Vector3(var_14_0.x, var_14_0.y, 0)
	end

	return
end

function IslandSelectableOpView:UpdateList()
	local var_15_0 = self.displays

	self.uiItemList:make(function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventUpdate then
			self:UpdateItem(arg_16_2, var_15_0[arg_16_1 + 1])
		end

		return
	end)
	self.uiItemList:align(#self.displays)
	self:UpdateSelected()

	return
end

function IslandSelectableOpView:UpdateItem(arg_17_1, arg_17_2)
	assert(isa(arg_17_2, IslandItem), "islandItem is not a IslandItem")
	updateCustomDrop(arg_17_1, Drop.New({
		type = DROP_TYPE_ISLAND_ITEM,
		id = arg_17_2.id,
		count = arg_17_2:GetCount()
	}))
	setActive(arg_17_1:Find("icon_bg/count_bg"), self:IsShowItemCount())

	local var_17_0 = false

	onButton(self, arg_17_1, function()
		if var_17_0 then
			var_17_0 = false

			return
		end

		self.selectedId = arg_17_2.id

		self:UpdateSelected()
		self:OnSelected(arg_17_2.id)
		self:Dispose()

		return
	end, SFX_PANEL)

	local var_17_1 = GetOrAddComponent(arg_17_1, typeof(UILongPressTrigger))

	var_17_1.onLongPressed:RemoveAllListeners()
	var_17_1.onLongPressed:AddListener(function()
		var_17_0 = true

		self.descPanle:Show(arg_17_1.position, arg_17_2)

		return
	end)

	return
end

function IslandSelectableOpView:UpdateSelected()
	local var_20_0 = self.displays

	self.uiItemList:eachActive(function(arg_21_0, arg_21_1)
		setActive(arg_21_1:Find("select"), self.selectedId == var_20_0[arg_21_0 + 1].id)

		return
	end)

	return
end

function IslandSelectableOpView:OnHide()
	self.descPanle:Hide()

	self.selectedId = nil

	self.uiItemList:each(function(arg_23_0, arg_23_1)
		GetOrAddComponent(arg_23_1, typeof(UILongPressTrigger)).onLongPressed:RemoveAllListeners()

		return
	end)

	return
end

function IslandSelectableOpView:OnDestroy()
	if self.descPanle then
		self.descPanle:Dispose()

		self.descPanle = nil
	end

	return
end

function IslandSelectableOpView:GetDisplayData()
	assert(false, "over write me")

	return
end

function IslandSelectableOpView:GetTargetTr()
	assert(false, "over write me")

	return
end

function IslandSelectableOpView:IsShowItemCount()
	return true
end

function IslandSelectableOpView:GetSelectedId()
	return 0
end

function IslandSelectableOpView:OnSelected(arg_29_1)
	return
end

function IslandSelectableOpView:GetMaxHrzCnt()
	return 7
end

return IslandSelectableOpView
