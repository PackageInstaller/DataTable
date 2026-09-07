local AnniversaryIslandStoreHouse2023Window = class("AnniversaryIslandStoreHouse2023Window", import("view.base.BaseUI"))

function AnniversaryIslandStoreHouse2023Window:Ctor()
	AnniversaryIslandStoreHouse2023Window.super.Ctor(self)

	self.loader = AutoLoader.New()

	return
end

function AnniversaryIslandStoreHouse2023Window:getUIName()
	return "AnniversaryIslandStoreHouse2023Window"
end

local var_0_1 = "ui/AtelierCommonUI_atlas"

function AnniversaryIslandStoreHouse2023Window:preload(arg_3_1)
	table.ParallelIpairsAsync({
		var_0_1
	}, function(arg_4_0, arg_4_1, arg_4_2)
		self.loader:LoadBundle(arg_4_1, arg_4_2)

		return
	end, arg_3_1)

	return
end

function AnniversaryIslandStoreHouse2023Window:init()
	self.storehouseRect = self._tf:Find("Window/ScrollView"):GetComponent("LScrollRect")

	setActive(self._tf:Find("Window/ScrollView/Item"), false)

	return
end

function AnniversaryIslandStoreHouse2023Window:SetActivity(arg_6_1)
	self.items = arg_6_1:GetAllVitems()
	self.itemList = {}

	table.Foreach(self.items, function(arg_7_0, arg_7_1)
		if arg_7_1 <= 0 then
			return
		end

		table.insert(self.itemList, WorkBenchItem.New({
			configId = arg_7_0,
			count = arg_7_1
		}))

		return
	end)
	table.sort(self.itemList, function(arg_8_0, arg_8_1)
		return arg_8_0:GetConfigID() < arg_8_1:GetConfigID()
	end)

	return
end

function AnniversaryIslandStoreHouse2023Window:didEnter()
	function self.storehouseRect.onUpdateItem(arg_10_0, arg_10_1)
		arg_10_0 = arg_10_0 + 1

		local var_10_0 = tf(arg_10_1)
		local var_10_1 = self.itemList[arg_10_0]

		self:UpdateItem(var_10_0:Find("IconBG"), self.itemList[arg_10_0])
		setScrollText(var_10_0:Find("NameBG/Rect/Name"), self.itemList[arg_10_0]:GetName())
		onButton(self, var_10_0, function()
			self:emit(WorkBenchItemDetailMediator.SHOW_DETAIL, var_10_1)

			return
		end, SFX_PANEL)

		return
	end

	onButton(self, self._tf:Find("Window/Close"), function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("BG"), function()
		self:onBackPressed()

		return
	end)
	self:UpdateView()

	return
end

function AnniversaryIslandStoreHouse2023Window:UpdateView()
	setActive(self._tf:Find("Window/Empty"), #self.itemList == 0)
	setActive(self._tf:Find("Window/ScrollView"), #self.itemList > 0)
	self.storehouseRect:SetTotalCount(#self.itemList)

	return
end

function AnniversaryIslandStoreHouse2023Window:UpdateItem(arg_15_1, arg_15_2)
	self.loader:GetSpriteQuiet(var_0_1, "icon_frame_" .. arg_15_2:GetRarity(), arg_15_1)
	self.loader:GetSpriteQuiet(arg_15_2:GetIconPath(), "", arg_15_1:Find("Icon"))

	if not IsNil(arg_15_1:Find("Text")) then
		setText(arg_15_1:Find("Text"), arg_15_2.count)
	end

	return
end

function AnniversaryIslandStoreHouse2023Window:willExit()
	self.loader:Clear()

	return
end

return AnniversaryIslandStoreHouse2023Window
