local IslandPostProdPanel = class("IslandPostProdPanel", import("view.base.BaseSubView"))

IslandPostProdPanel.ScrollValue = 0

function IslandPostProdPanel:getUIName()
	return "IslandPostProdPanel"
end

function IslandPostProdPanel:OnLoaded()
	setActive(self._tf:Find("tpl"), false)

	self.scrollRect = self._tf:Find("view"):GetComponent("LScrollRect")

	function self.scrollRect.onInitItem(arg_3_0)
		self:OnInitItem(arg_3_0)

		return
	end

	function self.scrollRect.onUpdateItem(arg_4_0, arg_4_1)
		self:OnUpdateItem(arg_4_0, arg_4_1)

		return
	end

	self.selectPanel = IslandDelegationSelectPanel.New(self._tf, self.event, setmetatable({
		isPost = true,
		ShowMsgBox = function(arg_5_0, arg_5_1)
			self.contextData:ShowMsgBox(arg_5_1)

			return
		end
	}, {
		__index = self.contextData
	}))

	return
end

function IslandPostProdPanel:OnInit()
	self.placeIds = pg.island_set.post_manage_produce.key_value_varchar
	self.cards = {}
	self.flushAll = true

	self.scrollRect.onValueChanged:RemoveAllListeners()
	pg.DelegateInfo.Add(self, self.scrollRect.onValueChanged)
	self.scrollRect.onValueChanged:AddListener(function(arg_7_0)
		IslandPostProdPanel.ScrollValue = arg_7_0.y

		return
	end)

	return
end

function IslandPostProdPanel:OnInitItem(arg_8_1)
	self.cards[arg_8_1] = IslandPostPlaceCard.New(arg_8_1)

	return
end

function IslandPostProdPanel:OnUpdateItem(arg_9_1, arg_9_2)
	local var_9_0 = self.cards[arg_9_2]

	if not self.cards[arg_9_2] then
		self:OnInitItem(arg_9_1, arg_9_2)

		var_9_0 = self.cards[arg_9_2]
	end

	if self.placeIds[arg_9_1 + 1] then
		var_9_0:Update(self.placeIds[arg_9_1 + 1], function(arg_10_0)
			self:OpenSelectPanel(arg_10_0)

			return
		end)
	end

	return
end

function IslandPostProdPanel:Show()
	self.super.Show(self)

	if self.flushAll then
		self:Flush()
	end

	self.flushAll = false

	self.scrollRect:ScrollTo(IslandPostProdPanel.ScrollValue)

	return
end

function IslandPostProdPanel:Flush()
	self.buildingAgency = getProxy(IslandProxy):GetIsland():GetBuildingAgency()
	self.buildings = self.buildingAgency:GetBuildings()

	self.scrollRect:SetTotalCount(#self.placeIds, -1)

	if self.selectPanel:isShowing() then
		self.selectPanel:ExecuteAction("Flush")
	end

	return
end

function IslandPostProdPanel:FlushSlot(arg_13_1)
	for iter_13_0, iter_13_1 in pairs(self.cards) do
		if iter_13_1.id == pg.island_production_slot[arg_13_1].place then
			iter_13_1:UpdateSlot(arg_13_1)
		end
	end

	if self.selectPanel:isShowing() then
		self.selectPanel:ExecuteAction("Flush")
	end

	return
end

function IslandPostProdPanel:OpenSelectPanel(arg_14_1)
	self.selectPanel:ExecuteAction("Show", arg_14_1)

	return
end

function IslandPostProdPanel:Hide()
	self.super.Hide(self)
	self.selectPanel:ExecuteAction("Hide")

	return
end

function IslandPostProdPanel:OnDestroy()
	ClearLScrollrect(self.scrollRect)

	if self.selectPanel then
		self.selectPanel:Destroy()

		self.selectPanel = nil
	end

	for iter_16_0, iter_16_1 in pairs(self.cards) do
		iter_16_1:Dispose()
	end

	self.cards = {}

	return
end

return IslandPostProdPanel
