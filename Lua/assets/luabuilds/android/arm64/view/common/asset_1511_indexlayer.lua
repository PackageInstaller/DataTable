local IndexLayer = class("IndexLayer", import("..base.BaseUI"))

function IndexLayer:getUIName()
	return "IndexUI"
end

IndexLayer.panelNames = {
	{
		"indexsort_sort",
		"indexsort_sorteng"
	},
	{
		"indexsort_index",
		"indexsort_indexeng"
	},
	{
		"indexsort_camp",
		"indexsort_campeng"
	},
	{
		"indexsort_rarity",
		"indexsort_rarityeng"
	},
	{
		"indexsort_extraindex",
		"indexsort_indexeng"
	}
}

function IndexLayer:init()
	self.panel = self._tf:Find("index_panel")
	self.displayTFs = {
		self.panel:Find("layout/sort"),
		self.panel:Find("layout/index"),
		self.panel:Find("layout/camp"),
		self.panel:Find("layout/rarity"),
		self.panel:Find("layout/extra"),
		self.panel:Find("layout/EquipSkinSort"),
		self.panel:Find("layout/EquipSkinIndex"),
		self.panel:Find("layout/EquipSkinTheme")
	}

	_.each(self.displayTFs, function(arg_3_0)
		setActive(arg_3_0, false)

		return
	end)

	for iter_2_0 = 1, #IndexLayer.panelNames do
		setText(self.displayTFs[iter_2_0]:Find("title1/Image"), i18n(IndexLayer.panelNames[iter_2_0][1]))
		setText(self.displayTFs[iter_2_0]:Find("title1/Image_en"), i18n(IndexLayer.panelNames[iter_2_0][2]))
	end

	self.displayList = {}
	self.typeList = {}
	self.btnConfirm = self.panel:Find("layout/btns/ok")
	self.btnCancel = self.panel:Find("layout/btns/cancel")
	self.greySprite = self.panel:Find("resource/grey"):GetComponent(typeof(Image)).sprite
	self.blueSprite = self.panel:Find("resource/blue"):GetComponent(typeof(Image)).sprite
	self.yellowSprite = self.panel:Find("resource/yellow"):GetComponent(typeof(Image)).sprite

	return
end

function IndexLayer:didEnter()
	onButton(self, self.btnConfirm, function()
		if self.contextData.callback then
			self.contextData.callback({
				sort = Clone(self.contextData.sort),
				index = Clone(self.contextData.index),
				camp = Clone(self.contextData.camp),
				rarity = Clone(self.contextData.rarity),
				extra = Clone(self.contextData.extra),
				equipSkinSort = Clone(self.contextData.equipSkinSort),
				equipSkinIndex = Clone(self.contextData.equipSkinIndex),
				equipSkinTheme = Clone(self.contextData.equipSkinTheme)
			})

			self.contextData.callback = nil
		end

		self:emit(IndexLayer.ON_CLOSE)

		return
	end, SFX_CONFIRM)
	onButton(self, self.btnCancel, function()
		self:emit(IndexLayer.ON_CLOSE)

		return
	end, SFX_CANCEL)
	onButton(self, self.panel:Find("btn"), function()
		self:emit(IndexLayer.ON_CLOSE)

		return
	end, SFX_CANCEL)

	self.panel.localScale = Vector3.zero

	LeanTween.scale(self.panel, Vector3(1, 1, 1), 0.2)
	self:initDisplays()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function IndexLayer:initDisplays()
	local var_8_0 = {
		"sort",
		"index",
		"camp",
		"rarity",
		"extra",
		"equipSkinSort",
		"equipSkinIndex",
		"equipSkinTheme"
	}

	for iter_8_0, iter_8_1 in ipairs(self.displayTFs) do
		local var_8_1 = tobool(self.contextData.display[var_8_0[iter_8_0]])

		setActive(iter_8_1, var_8_1)

		if var_8_1 then
			if iter_8_0 == IndexConst.DisplayEquipSkinSort then
				self:initEquipSkinSort()
				self:updateEquipSkinSort()
			elseif iter_8_0 == IndexConst.DisplayEquipSkinIndex then
				self:initEquipSkinIndex()
				self:updateEquipSkinIndex()
			elseif iter_8_0 == IndexConst.DisplayEquipSkinTheme then
				self:initEquipSkinTheme()
				self:updateEquipSkinTheme()
			end
		end
	end

	return
end

function IndexLayer:initEquipSkinSort()
	local var_9_0 = {}

	_.each(IndexConst.EquipSkinSortTypes, function(arg_10_0)
		if bit.band(self.contextData.display.equipSkinSort, (bit.lshift(1, arg_10_0))) > 0 then
			table.insert(var_9_0, arg_10_0)
		end

		return
	end)

	self.typeList[IndexConst.DisplayEquipSkinSort] = var_9_0

	local var_9_1 = UIItemList.New(self.displayTFs[IndexConst.DisplayEquipSkinSort]:Find("panel"), self.displayTFs[IndexConst.DisplayEquipSkinSort]:Find("panel/tpl"))

	var_9_1:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			local var_11_0 = var_9_0[arg_11_1 + 1]

			setText(findTF(arg_11_2, "Image"), IndexConst.EquipSkinSortNames[table.indexof(IndexConst.EquipSkinSortTypes, var_9_0[arg_11_1 + 1])])
			setImageSprite(arg_11_2, self.greySprite)
			GetOrAddComponent(arg_11_2, typeof(Button))
			onButton(self, arg_11_2, function()
				self.contextData.equipSkinSort = var_11_0

				self:updateEquipSkinSort()

				return
			end, SFX_UI_TAG)
		end

		return
	end)
	var_9_1:align(#var_9_0)

	self.displayList[IndexConst.DisplayEquipSkinSort] = var_9_1

	return
end

function IndexLayer:updateEquipSkinSort()
	local var_13_0 = self.typeList[IndexConst.DisplayEquipSkinSort]

	self.displayList[IndexConst.DisplayEquipSkinSort]:each(function(arg_14_0, arg_14_1)
		local var_14_0 = findTF(arg_14_1, "Image")

		setImageSprite(arg_14_1, (self.contextData.equipSkinSort == var_13_0[arg_14_0 + 1] or nil) and (self.yellowSprite or self.greySprite))

		return
	end)

	return
end

function IndexLayer:initEquipSkinIndex()
	local var_15_0 = {}

	_.each(IndexConst.EquipSkinIndexTypes, function(arg_16_0)
		if bit.band(self.contextData.display.equipSkinIndex, (bit.lshift(1, arg_16_0))) > 0 then
			table.insert(var_15_0, arg_16_0)
		end

		return
	end)

	self.typeList[IndexConst.DisplayEquipSkinIndex] = var_15_0

	local var_15_1 = UIItemList.New(self.displayTFs[IndexConst.DisplayEquipSkinIndex]:Find("panel"), self.displayTFs[IndexConst.DisplayEquipSkinIndex]:Find("panel/tpl"))

	var_15_1:make(function(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_0 == UIItemList.EventUpdate then
			local var_17_0 = var_15_0[arg_17_1 + 1]

			setText(findTF(arg_17_2, "Image"), IndexConst.EquipSkinIndexNames[table.indexof(IndexConst.EquipSkinIndexTypes, var_15_0[arg_17_1 + 1])])
			setImageSprite(arg_17_2, self.greySprite)
			GetOrAddComponent(arg_17_2, typeof(Button))
			onButton(self, arg_17_2, function()
				self.contextData.equipSkinIndex = IndexConst.ToggleBits(self.contextData.equipSkinIndex, var_15_0, IndexConst.EquipSkinIndexAll, var_17_0)

				self:updateEquipSkinIndex()

				return
			end, SFX_UI_TAG)
		end

		return
	end)
	var_15_1:align(#var_15_0)

	self.displayList[IndexConst.DisplayEquipSkinIndex] = var_15_1

	return
end

function IndexLayer:updateEquipSkinIndex()
	local var_19_0 = self.typeList[IndexConst.DisplayEquipSkinIndex]

	self.displayList[IndexConst.DisplayEquipSkinIndex]:each(function(arg_20_0, arg_20_1)
		local var_20_0 = findTF(arg_20_1, "Image")

		setImageSprite(arg_20_1, (bit.band(self.contextData.equipSkinIndex, bit.lshift(1, var_19_0[arg_20_0 + 1])) > 0 or nil) and (self.yellowSprite or self.greySprite))

		return
	end)

	return
end

function IndexLayer:initEquipSkinTheme()
	local var_21_0 = {}

	_.each(IndexConst.EquipSkinThemeTypes, function(arg_22_0)
		if string.find(IndexConst.StrAnd(self.contextData.display.equipSkinTheme, (IndexConst.StrLShift("1", arg_22_0))), "1") ~= nil then
			table.insert(var_21_0, arg_22_0)
		end

		return
	end)

	self.typeList[IndexConst.DisplayEquipSkinTheme] = var_21_0

	local var_21_1 = UIItemList.New(self.displayTFs[IndexConst.DisplayEquipSkinTheme]:Find("bg/panel"), self.displayTFs[IndexConst.DisplayEquipSkinTheme]:Find("bg/panel/tpl"))

	var_21_1:make(function(arg_23_0, arg_23_1, arg_23_2)
		if arg_23_0 == UIItemList.EventUpdate then
			local var_23_0 = var_21_0[arg_23_1 + 1]

			setText(findTF(arg_23_2, "Image"), IndexConst.EquipSkinThemeNames[table.indexof(IndexConst.EquipSkinThemeTypes, var_21_0[arg_23_1 + 1])])
			setImageSprite(arg_23_2, self.greySprite)
			GetOrAddComponent(arg_23_2, typeof(Button))
			onButton(self, arg_23_2, function()
				self.contextData.equipSkinTheme = IndexConst.ToggleStr(self.contextData.equipSkinTheme, var_21_0, IndexConst.EquipSkinThemeAll, var_23_0)

				self:updateEquipSkinTheme()

				return
			end, SFX_UI_TAG)
		end

		return
	end)
	var_21_1:align(#var_21_0)

	self.displayList[IndexConst.DisplayEquipSkinTheme] = var_21_1

	return
end

function IndexLayer:updateEquipSkinTheme()
	local var_25_0 = self.typeList[IndexConst.DisplayEquipSkinTheme]

	self.displayList[IndexConst.DisplayEquipSkinTheme]:each(function(arg_26_0, arg_26_1)
		local var_26_0 = findTF(arg_26_1, "Image")

		setImageSprite(arg_26_1, (string.find(IndexConst.StrAnd(self.contextData.equipSkinTheme, (IndexConst.StrLShift("1", var_25_0[arg_26_0 + 1]))), "1") ~= nil or nil) and (self.yellowSprite or self.greySprite))

		return
	end)

	return
end

function IndexLayer:willExit()
	LeanTween.cancel(go(self.panel))
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return IndexLayer
