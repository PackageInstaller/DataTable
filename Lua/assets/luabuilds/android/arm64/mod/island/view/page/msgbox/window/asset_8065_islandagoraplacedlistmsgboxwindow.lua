local IslandAgoraPlacedListMsgboxWindow = class("IslandAgoraPlacedListMsgboxWindow", import(".IslandCommonMsgboxWindow"))

function IslandAgoraPlacedListMsgboxWindow:getUIName()
	return "IslandAgoraPlacedInfoMsgBox"
end

local function var_0_1(arg_2_0)
	local var_2_0 = {
		go = arg_2_0
	}
	local var_2_1 = arg_2_0.transform:Find("icon")
	local var_2_2 = var_2_1:GetComponent(typeof(Image))
	local var_2_3 = arg_2_0.transform:Find("name")
	local var_2_4 = var_2_3:GetComponent(typeof(Text))
	local var_2_5 = arg_2_0.transform:Find("count").GetComponent(var_2_1, typeof(Text))
	local var_2_6 = arg_2_0.transform:Find("capacity").GetComponent(var_2_3, typeof(Text))

	function var_2_0:Update()
		var_2_4.text = self.name
		var_2_5.text = "X" .. self.count
		var_2_6.text = self.capacity

		LoadSpriteAsync("island/IslandFurnitureIcon/" .. self.icon, function(arg_4_0)
			var_2_2.sprite = arg_4_0

			return
		end)

		return
	end

	return var_2_0
end

function IslandAgoraPlacedListMsgboxWindow:OnLoaded()
	IslandAgoraPlacedListMsgboxWindow.super.OnLoaded(self)
	setText(self._tf:Find("list/titles/1"), i18n("island_label_furniture"))
	setText(self._tf:Find("list/titles/2"), i18n("island_label_furniture_cnt"))
	setText(self._tf:Find("list/titles/3"), i18n("island_label_furniture_capacity"))

	self.capacityTxt = self._tf:Find("capacity"):GetComponent(typeof(Text))
	self.scrollRect = self._tf:Find("list/scrollrect"):GetComponent("LScrollRect")

	function self.scrollRect.onInitItem(arg_6_0)
		self:OnInitItem(arg_6_0)

		return
	end

	function self.scrollRect.onUpdateItem(arg_7_0, arg_7_1)
		self:OnUpdateItem(arg_7_0, arg_7_1)

		return
	end

	self.cards = {}

	return
end

function IslandAgoraPlacedListMsgboxWindow:FlushBtn(arg_8_1)
	return
end

function IslandAgoraPlacedListMsgboxWindow:OnShow()
	self.settings.content = i18n("island_label_furniture_tip")

	IslandAgoraPlacedListMsgboxWindow.super.OnShow(self)
	self:UpdateCapacity(self.settings.list, self.settings.totalCnt)
	self:UpdateList(self.settings.list)

	return
end

function IslandAgoraPlacedListMsgboxWindow:UpdateCapacity(arg_10_1, arg_10_2)
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		var_10_0 = var_10_0 + iter_10_1.capacity
	end

	self.capacityTxt.text = i18n("island_label_furniture_capacity_display") .. var_10_0 .. "/" .. arg_10_2

	return
end

function IslandAgoraPlacedListMsgboxWindow:OnInitItem(arg_11_1)
	self.cards[arg_11_1] = var_0_1(arg_11_1)

	return
end

function IslandAgoraPlacedListMsgboxWindow:OnUpdateItem(arg_12_1, arg_12_2)
	local var_12_0 = self.cards[arg_12_2]

	if not self.cards[arg_12_2] then
		self:OnInitItem(arg_12_2)

		var_12_0 = self.cards[arg_12_2]
	end

	var_12_0.Update(self.settings.list[arg_12_1 + 1])

	return
end

function IslandAgoraPlacedListMsgboxWindow:UpdateList(arg_13_1)
	self.scrollRect:SetTotalCount(#arg_13_1)

	return
end

function IslandAgoraPlacedListMsgboxWindow:OnDestroy()
	IslandAgoraPlacedListMsgboxWindow.super.OnDestroy(self)
	ClearLScrollrect(self.scrollRect)

	return
end

return IslandAgoraPlacedListMsgboxWindow
