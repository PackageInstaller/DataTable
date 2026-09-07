local PrayPoolSelectShipView = class("PrayPoolSelectShipView", import("..base.BaseSubView"))

PrayPoolSelectShipView.WIDTH_MIN = 328
PrayPoolSelectShipView.WIDTH_MAX = 438
PrayPoolSelectShipView.FONT_SIZE_MIN = 55
PrayPoolSelectShipView.FONT_SIZE_MID = 44
PrayPoolSelectShipView.FONT_SIZE_MAX = 34

function PrayPoolSelectShipView:getUIName()
	return "PrayPoolSelectShipView"
end

PrayPoolSelectShipView.ShipIndex = {
	typeIndex = ShipIndexConst.TypeAll,
	campIndex = ShipIndexConst.CampAll,
	rarityIndex = ShipIndexConst.RarityAll
}
PrayPoolSelectShipView.ShipIndexData = {
	customPanels = {
		typeIndex = {
			blueSeleted = true,
			mode = CustomIndexLayer.Mode.AND,
			options = ShipIndexConst.TypeIndexs,
			names = ShipIndexConst.TypeNames
		},
		campIndex = {
			blueSeleted = true,
			mode = CustomIndexLayer.Mode.AND,
			options = ShipIndexConst.CampIndexs,
			names = ShipIndexConst.CampNames
		},
		rarityIndex = {
			blueSeleted = true,
			mode = CustomIndexLayer.Mode.AND,
			options = ShipIndexConst.RarityIndexs,
			names = ShipIndexConst.RarityNames
		}
	},
	groupList = {
		{
			dropdown = false,
			titleENTxt = "indexsort_indexeng",
			titleTxt = "indexsort_index",
			tags = {
				"typeIndex"
			}
		},
		{
			dropdown = false,
			titleENTxt = "indexsort_campeng",
			titleTxt = "indexsort_camp",
			tags = {
				"campIndex"
			}
		},
		{
			dropdown = false,
			titleENTxt = "indexsort_rarityeng",
			titleTxt = "indexsort_rarity",
			tags = {
				"rarityIndex"
			}
		}
	}
}

function PrayPoolSelectShipView:OnInit()
	self:initData()
	self:initUI()
	self:updateUI()
	self:Show()

	return
end

function PrayPoolSelectShipView:OnDestroy()
	return
end

function PrayPoolSelectShipView:OnBackPress()
	return
end

function PrayPoolSelectShipView:initData()
	self.prayProxy = getProxy(PrayProxy)
	self.poolType = self.prayProxy:getSelectedPoolType()
	self.selectedCount = self.prayProxy:getSelectedShipCount()
	self.pickUpNum = pg.activity_ship_create[self.poolType].pickup_num
	self.fliteList = Clone(pg.activity_ship_create[self.poolType].pickup_list)

	self:orderIDListByRarity(self.fliteList)

	self.orderFullList = Clone(self.fliteList)

	return
end

function PrayPoolSelectShipView:initUI()
	self.minRaritySpriteMap = {}
	self.maxRaritySpriteMap = {}
	self.ratioSpriteMap = {}

	local var_6_0 = self._tf:Find("MiniRarity")
	local var_6_1 = self._tf:Find("MaxRarity")
	local var_6_2 = self._tf:Find("Ratio")

	for iter_6_0 = 2, 6 do
		local var_6_3 = getImageSprite(var_6_1:Find(tostring(iter_6_0)))
		local var_6_4 = getImageSprite(var_6_2:Find(tostring(iter_6_0)))

		self.minRaritySpriteMap[iter_6_0] = getImageSprite(var_6_0:Find(tostring(iter_6_0)))
		self.maxRaritySpriteMap[iter_6_0] = var_6_3
		self.ratioSpriteMap[iter_6_0] = var_6_4
	end

	self.poolSpriteMap = {}

	local var_6_5 = self._tf:Find("Pool")

	for iter_6_1 = 1, 3 do
		self.poolSpriteMap[iter_6_1] = getImageSprite(var_6_5:Find(tostring(iter_6_1)))
	end

	self.poolNameImg = self._tf:Find("PoolNameImg")
	self.shipCardTpl = self._tf:Find("ShipCardTpl")

	local var_6_6 = self._tf:Find("SelectedShipMax")
	local var_6_7 = self._tf:Find("SelectedShipMini")

	self.selectedShipTFMap = {}
	self.selectedShipTFMap.Max = {
		lightTF = var_6_6:Find("Light"),
		var_6_6:Find("Ship1"),
		(var_6_6:Find("Ship2"))
	}
	self.selectedShipTFMap.Min = {
		lightTF = var_6_7:Find("Light"),
		var_6_7:Find("Ship1"),
		(var_6_7:Find("Ship2"))
	}

	local var_6_8 = self:isMinPrefs()

	setActive(var_6_6, not var_6_8)
	setActive(var_6_7, var_6_8)

	self.shipListArea = self._tf:Find("ShipListArea")
	self.shipListContainer = self.shipListArea:Find("Viewport/Content")
	self.shipListSC = GetComponent(self.shipListArea, "LScrollRect")

	setLocalPosition(self.shipListArea, {
		x = 0,
		y = var_6_8 and -40 or -120
	})

	self.bg2 = self._tf:Find("BG2")

	setLocalPosition(self.bg2, {
		x = 0,
		y = var_6_8 and -62.5 or -174
	})

	self.indexBtn = self._tf:Find("IndexBtn")
	self.preBtn = self._tf:Find("PreBtn")
	self.nextBtn = self._tf:Find("NextBtn")
	self.nextBtnCom = GetComponent(self.nextBtn, "Button")

	self.indexBtn:GetComponent(typeof(Image)):SetNativeSize()

	for iter_6_2, iter_6_3 in ipairs(self.selectedShipTFMap.Max) do
		iter_6_3:Find("Tip/Tip"):GetComponent(typeof(Image)):SetNativeSize()
	end

	for iter_6_4, iter_6_5 in ipairs(self.selectedShipTFMap.Min) do
		iter_6_5:Find("Tip/Tip"):GetComponent(typeof(Image)):SetNativeSize()
	end

	self.nextBtnCom.interactable = false

	setText(self._tf:Find("InstructionText"), i18n("pray_build_select_ship_instruction"))
	onButton(self, self.preBtn, function()
		self.prayProxy:updatePageState(PrayProxy.STATE_SELECT_POOL)
		self:emit(PrayPoolConst.SWITCH_TO_SELECT_POOL_PAGE, PrayProxy.STATE_SELECT_POOL)

		return
	end, SFX_PANEL)
	onButton(self, self.nextBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("warning_pray_build_pool"),
			onYes = function()
				local function var_9_0()
					self:emit(PrayPoolConst.CLICK_BUILD_BTN, {
						pooltype = self.prayProxy:getSelectedPoolType(),
						shipIDList = self.prayProxy:getSelectedShipIDList()
					})

					return
				end

				if not self:isMinPrefs() then
					var_9_0()
				else
					local var_9_1 = {}

					for iter_9_0, iter_9_1 in ipairs((self.prayProxy:getSelectedShipIDList())) do
						PaintingGroupConst.AddPaintingNameByShipConfigID(var_9_1, iter_9_1)
					end

					PaintingGroupConst.PaintingDownload({
						isShowBox = true,
						paintingNameList = var_9_1,
						finishFunc = var_9_0
					})
				end

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.indexBtn, function()
		local var_11_0 = Clone(PrayPoolSelectShipView.ShipIndexData)

		var_11_0.indexDatas = Clone(PrayPoolSelectShipView.ShipIndex)

		function var_11_0:callback()
			PrayPoolSelectShipView.ShipIndex.typeIndex = self.typeIndex
			PrayPoolSelectShipView.ShipIndex.rarityIndex = self.rarityIndex

			if self.campIndex then
				PrayPoolSelectShipView.ShipIndex.campIndex = self.campIndex
			end

			self:fliteShipIDList()
			self:updateShipList(self.fliteList)

			return
		end

		self:emit(PrayPoolConst.CLICK_INDEX_BTN, var_11_0)

		return
	end)

	return
end

function PrayPoolSelectShipView:updateUI()
	setImageSprite(self.poolNameImg, self.poolSpriteMap[self.poolType], true)
	self:updateSelectedShipList()
	self:updateShipList(self.fliteList)

	return
end

function PrayPoolSelectShipView:updateSelectedShipList()
	if self:isMinPrefs() then
		self:updateMin()
	else
		self:updateMax()
	end

	return
end

function PrayPoolSelectShipView:updateMax()
	local var_15_0 = self.prayProxy:getSelectedShipIDList()

	for iter_15_0 = 1, 2 do
		local var_15_1 = var_15_0[iter_15_0]
		local var_15_2 = self.selectedShipTFMap.Max[iter_15_0]:Find("Paint")
		local var_15_3 = self.selectedShipTFMap.Max[iter_15_0]:Find("Tip")
		local var_15_4 = self.selectedShipTFMap.Max[iter_15_0]:Find("Info")
		local var_15_5 = self.selectedShipTFMap.Max[iter_15_0]:Find("Btn")
		local var_15_6 = var_15_4:Find("Name/Text")
		local var_15_7 = self.selectedShipTFMap.Max[iter_15_0]:Find("RarityBG")

		if var_15_0[iter_15_0] then
			setActive(var_15_2, true)
			setPaintingPrefabAsync(var_15_2, Ship.getPaintingName(var_15_1), "biandui")

			if iter_15_0 == 2 then
				setLocalRotation(var_15_2, {
					z = 180
				})
			end

			setActive(var_15_3, false)
			setActive(var_15_4, true)
			setText(var_15_6, pg.ship_data_statistics[var_15_1].name)

			if #pg.ship_data_statistics[var_15_1].name <= 6 then
				var_15_4.sizeDelta = Vector2(PrayPoolSelectShipView.WIDTH_MIN, var_15_4.sizeDelta.y)
				GetComponent(var_15_6, "Text").fontSize = PrayPoolSelectShipView.FONT_SIZE_MIN

				setAnchoredPosition(var_15_6, {
					y = 14
				})
			elseif #pg.ship_data_statistics[var_15_1].name <= 21 then
				var_15_4.sizeDelta = Vector2(PrayPoolSelectShipView.WIDTH_MAX, var_15_4.sizeDelta.y)
				GetComponent(var_15_6, "Text").fontSize = PrayPoolSelectShipView.FONT_SIZE_MID

				setAnchoredPosition(var_15_6, {
					y = 19
				})
			else
				var_15_4.sizeDelta = Vector2(PrayPoolSelectShipView.WIDTH_MAX, var_15_4.sizeDelta.y)
				GetComponent(var_15_6, "Text").fontSize = PrayPoolSelectShipView.FONT_SIZE_MAX

				setAnchoredPosition(var_15_6, {
					y = 25
				})
			end

			local var_15_9 = pg.ship_data_statistics[var_15_1].rarity

			setImageSprite(var_15_4:Find("Ratio/NumImg"), self.ratioSpriteMap[pg.ship_data_statistics[var_15_1].rarity], true)
			setActive(var_15_7, true)
			setImageSprite(var_15_7, self.maxRaritySpriteMap[var_15_9])
		else
			setActive(var_15_2, false)
			setActive(var_15_3, true)
			setActive(var_15_4, false)
			setActive(var_15_7, false)
		end

		onButton(self, var_15_5, function()
			if isActive(var_15_2) then
				self.prayProxy:removeSelectedShipIDList(var_15_1)

				self.selectedCount = self.selectedCount - 1

				self:updateSelectedShipList()
				self:updateShipList(self.fliteList)
			end

			return
		end, SFX_PANEL)
	end

	if #var_15_0 == self.pickUpNum then
		self.nextBtnCom.interactable = true

		setActive(self.selectedShipTFMap.Max.lightTF, true)
	elseif #var_15_0 < self.pickUpNum then
		self.nextBtnCom.interactable = false

		setActive(self.selectedShipTFMap.Max.lightTF, false)
	end

	return
end

function PrayPoolSelectShipView:updateMin()
	local var_17_0 = self.prayProxy:getSelectedShipIDList()

	for iter_17_0 = 1, 2 do
		local var_17_1 = var_17_0[iter_17_0]
		local var_17_2 = self.selectedShipTFMap.Min[iter_17_0]:Find("Mask/Paint")
		local var_17_3 = self.selectedShipTFMap.Min[iter_17_0]:Find("Tip")
		local var_17_4 = self.selectedShipTFMap.Min[iter_17_0]:Find("Info")
		local var_17_5 = self.selectedShipTFMap.Min[iter_17_0]:Find("Btn")
		local var_17_6 = var_17_4:Find("Name/Text")
		local var_17_7 = self.selectedShipTFMap.Min[iter_17_0]:Find("Mask/RarityBG")

		if var_17_0[iter_17_0] then
			setActive(var_17_2, true)
			setImageSprite(var_17_2, LoadSprite("herohrzicon/" .. Ship.getPaintingName(var_17_1)))
			setActive(var_17_3, false)
			setActive(var_17_4, true)
			setText(var_17_6, pg.ship_data_statistics[var_17_1].name)

			if #pg.ship_data_statistics[var_17_1].name <= 6 then
				var_17_4.sizeDelta = Vector2(PrayPoolSelectShipView.WIDTH_MIN, var_17_4.sizeDelta.y)
				GetComponent(var_17_6, "Text").fontSize = PrayPoolSelectShipView.FONT_SIZE_MIN

				setAnchoredPosition(var_17_6, {
					y = 0
				})
			elseif #pg.ship_data_statistics[var_17_1].name <= 21 then
				var_17_4.sizeDelta = Vector2(PrayPoolSelectShipView.WIDTH_MAX, var_17_4.sizeDelta.y)
				GetComponent(var_17_6, "Text").fontSize = PrayPoolSelectShipView.FONT_SIZE_MID

				setAnchoredPosition(var_17_6, {
					y = 5
				})
			else
				var_17_4.sizeDelta = Vector2(PrayPoolSelectShipView.WIDTH_MAX, var_17_4.sizeDelta.y)
				GetComponent(var_17_6, "Text").fontSize = PrayPoolSelectShipView.FONT_SIZE_MAX

				setAnchoredPosition(var_17_6, {
					y = 11
				})
			end

			Canvas.ForceUpdateCanvases()
			setImageSprite(var_17_4:Find("Ratio/NumImg"), self.ratioSpriteMap[pg.ship_data_statistics[var_17_1].rarity], true)
			setActive(var_17_7, true)
			setImageSprite(var_17_7, self.minRaritySpriteMap[pg.ship_data_statistics[var_17_1].rarity])
		else
			setActive(var_17_2, false)
			setActive(var_17_3, true)
			setActive(var_17_4, false)
			setActive(var_17_7, false)
		end

		onButton(self, var_17_5, function()
			if isActive(var_17_2) then
				self.prayProxy:removeSelectedShipIDList(var_17_1)

				self.selectedCount = self.selectedCount - 1

				self:updateSelectedShipList()
				self:updateShipList(self.fliteList)
			end

			return
		end, SFX_PANEL)
	end

	if #var_17_0 == self.pickUpNum then
		self.nextBtnCom.interactable = true

		setActive(self.selectedShipTFMap.Min.lightTF, true)
	elseif #var_17_0 < self.pickUpNum then
		self.nextBtnCom.interactable = false

		setActive(self.selectedShipTFMap.Min.lightTF, false)
	end

	return
end

function PrayPoolSelectShipView:updateShipList(arg_19_1)
	local var_19_0 = self.prayProxy:getSelectedShipIDList()

	function self.shipListSC.onUpdateItem(arg_20_0, arg_20_1)
		local var_20_0 = arg_19_1[arg_20_0 + 1]

		arg_20_1 = tf(arg_20_1)

		GetImageSpriteFromAtlasAsync("SquareIcon/" .. Ship.getPaintingName(arg_19_1[arg_20_0 + 1]), "", (arg_20_1:Find("BG/Icon")))

		local var_20_1 = arg_20_1:Find("BG/GroupLocked")

		if pg.ship_data_template[var_20_0].group_type and pg.ship_data_template[var_20_0].group_type > 0 then
			setActive(var_20_1, not getProxy(CollectionProxy):getShipGroup(pg.ship_data_template[var_20_0].group_type))
		end

		local var_20_3
		local var_20_2

		do
			setActive(var_20_1, false)

			var_20_2 = pg.ship_data_statistics[var_20_0].rarity
			var_20_3 = ShipRarity.Rarity2Print(pg.ship_data_statistics[var_20_0].rarity)
		end

		setFrame(arg_20_1:Find("BG/icon_bg/frame"), var_20_3)
		setIconColorful(arg_20_1:Find("BG"), var_20_2 - 1, {})
		setImageSprite(arg_20_1:Find("BG"), GetSpriteFromAtlas("weaponframes", "bg" .. var_20_3))
		setText(arg_20_1:Find("NameBG/NameText"), shortenString(pg.ship_data_statistics[var_20_0].name, 6))

		local var_20_4 = arg_20_1:Find("BG/SelectedImg")

		if table.indexof(var_19_0, var_20_0, 1) then
			SetActive(var_20_4, true)
		end

		local var_20_5

		do
			SetActive(var_20_4, false)

			var_20_5 = var_20_2 == ShipRarity.SSR and self:isSelectedSSR() and not isActive(var_20_4)
		end

		setBlackMask(tf(arg_20_1), var_20_5, {
			recursive = true,
			color = Color(0, 0, 0, 0.6)
		})
		onButton(self, arg_20_1, function()
			if self.selectedCount < self.pickUpNum then
				if isActive(var_20_4) then
					self.prayProxy:removeSelectedShipIDList(var_20_0)

					self.selectedCount = self.selectedCount - 1

					SetActive(var_20_4, false)
					self:updateSelectedShipList()
					self:updateShipList(self.fliteList)
				elseif var_20_2 == ShipRarity.SSR and self:isSelectedSSR() then
					pg.TipsMgr.GetInstance():ShowTips(i18n("pray_build_UR_warning"))
				else
					self.prayProxy:insertSelectedShipIDList(var_20_0)

					self.selectedCount = self.selectedCount + 1

					SetActive(var_20_4, true)
					self:updateSelectedShipList()
					self:updateShipList(self.fliteList)
				end
			elseif self.selectedCount == self.pickUpNum then
				if isActive(var_20_4) then
					self.prayProxy:removeSelectedShipIDList(var_20_0)

					self.selectedCount = self.selectedCount - 1

					SetActive(var_20_4, false)
					self:updateSelectedShipList()
					self:updateShipList(self.fliteList)
				else
					pg.TipsMgr.GetInstance():ShowTips(i18n("error_pray_select_ship_max"))
				end
			end

			return
		end, SFX_PANEL)

		return
	end

	function self.shipListSC.onReturnItem(arg_22_0, arg_22_1)
		return
	end

	self.shipListSC:SetTotalCount(#arg_19_1)

	return
end

function PrayPoolSelectShipView:orderIDListByRarity(arg_23_1)
	local var_23_0 = getProxy(CollectionProxy)

	table.sort(arg_23_1, function(arg_24_0, arg_24_1)
		local var_24_0 = pg.ship_data_statistics[arg_24_0].rarity
		local var_24_1 = pg.ship_data_statistics[arg_24_1].rarity
		local var_24_2 = var_23_0:getShipGroup(pg.ship_data_template[arg_24_0].group_type) and 1 or 0
		local var_24_3 = var_23_0:getShipGroup(pg.ship_data_template[arg_24_1].group_type) and 1 or 0

		if var_24_2 == var_24_3 then
			return var_24_1 < var_24_0
		else
			return var_24_2 < var_24_3
		end

		return
	end)

	return
end

function PrayPoolSelectShipView:fliteShipIDList()
	local var_25_0 = {}
	local var_25_1 = self.prayProxy:getSelectedShipIDList()

	if var_25_1 and #var_25_1 > 0 then
		for iter_25_0, iter_25_1 in ipairs(var_25_1) do
			table.insert(var_25_0, 1, iter_25_1)
		end
	end

	for iter_25_2, iter_25_3 in ipairs(self.orderFullList) do
		if not table.indexof(var_25_1, iter_25_3, 1) then
			local var_25_2 = ShipGroup.New({
				id = math.modf(iter_25_3 / 10)
			})

			if ShipIndexConst.filterByType(var_25_2, PrayPoolSelectShipView.ShipIndex.typeIndex) and ShipIndexConst.filterByRarity(var_25_2, PrayPoolSelectShipView.ShipIndex.rarityIndex) and ShipIndexConst.filterByCamp(var_25_2, PrayPoolSelectShipView.ShipIndex.campIndex) then
				var_25_0[#var_25_0 + 1] = iter_25_3
			end
		end
	end

	self.fliteList = var_25_0

	return
end

function PrayPoolSelectShipView:isMinPrefs()
	return GroupHelper.GetGroupPrefsByName("PAINTING") == DMFileChecker.Prefs.Min
end

function PrayPoolSelectShipView:isSelectedSSR()
	local var_27_0 = false
	local var_27_1 = self.prayProxy:getSelectedShipIDList()

	if var_27_1 and #var_27_1 > 0 then
		for iter_27_0, iter_27_1 in ipairs(var_27_1) do
			if pg.ship_data_statistics[iter_27_1].rarity == ShipRarity.SSR then
				var_27_0 = true

				break
			end
		end
	end

	return var_27_0
end

return PrayPoolSelectShipView
