local IslandSeedOpView = class("IslandSeedOpView", import("..IslandBaseOpView"))

function IslandSeedOpView:GetUIName()
	return "IslandSeedOpUI"
end

function IslandSeedOpView:OnInit(arg_2_1)
	self.seedSelectPlane = self._tf:Find("seed_select")
	self.seed_detals = self._tf:Find("seed_detals")
	self.uiSeedItemList = UIItemList.New(self.seedSelectPlane:Find("content"), self.seedSelectPlane:Find("content/itemSeed"))

	onButton(self, self._tf, function()
		setActive(self.seed_detals, false)
		self:ActiveSeedSelect(false)

		return
	end, SFX_PANEL)
	setActive(self.seed_detals, false)
	self:ActiveSeedSelect(false)

	return
end

function IslandSeedOpView:ActiveSeedDetals(arg_4_1)
	setActive(self.seed_detals, arg_4_1)

	return
end

function IslandSeedOpView:ActiveSeedSelect(arg_5_1)
	if arg_5_1 then
		local var_5_0 = GameObject.Find("UICamera"):GetComponent(typeof(Camera))

		self.seedSelectPlane.localPosition = LuaHelper.ScreenToLocal(self._tf, var_5_0:WorldToScreenPoint((self:GetView():GetSubView(IslandOpView):GetSeedBtnWorldPos())), var_5_0)

		self._tf:SetAsLastSibling()
	end

	setActive(self.seedSelectPlane, arg_5_1)
	setActive(self._tf, arg_5_1)

	return
end

function IslandSeedOpView:RefreshSeedPlane(arg_6_1)
	local var_6_0 = pg.island_production_slot[arg_6_1:GetDataVO().slotData.configId].place
	local var_6_1 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()
	local var_6_2 = {}

	for iter_6_0, iter_6_1 in ipairs(pg.island_production_place[var_6_0].seed_list) do
		if var_6_1:GetItemById(pg.island_farm_seed[iter_6_1].itemid) then
			table.insert(var_6_2, iter_6_1)
		end
	end

	local var_6_3 = #var_6_2
	local var_6_4 = self.seedSelectPlane:Find("content"):GetComponent(typeof(GridLayoutGroup))
	local var_6_5 = math.min(#var_6_2, 7)
	local var_6_6 = math.ceil(#var_6_2 / 7)

	self.seedSelectPlane:Find("content").sizeDelta = Vector2(var_6_4.cellSize.x * var_6_5 + var_6_4.spacing.x * (var_6_5 - 1) + var_6_4.padding.right + 40, var_6_4.cellSize.y * var_6_6 + var_6_4.spacing.y * (var_6_6 - 1) + var_6_4.padding.bottom + 30)

	self.uiSeedItemList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			local var_7_0 = var_6_2[arg_7_1 + 1]

			setActive(arg_7_2:Find("select"), self.selectseedItemId == var_6_2[arg_7_1 + 1])

			local var_7_1 = var_6_1:GetItemById(pg.island_farm_seed[var_7_0].itemid)

			updateCustomDrop(arg_7_2, Drop.New({
				type = DROP_TYPE_ISLAND_ITEM,
				id = var_7_1.id,
				count = var_7_1:GetCount()
			}))

			local var_7_2

			onButton(self, arg_7_2, function()
				if var_7_2 then
					var_7_2 = false

					return
				end

				self.selectseedItemId = var_7_0

				PlayerPrefs.SetInt("island_last_selectItemId" .. var_6_0, self.selectseedItemId)
				self.uiSeedItemList:align(var_6_3)
				self:GetView():GetSubView(IslandOpView):RefreshCurrentSlectSeed()
				self:ActiveSeedSelect(false)
				setActive(self.seed_detals, false)

				return
			end, SFX_PANEL)
			GetOrAddComponent(arg_7_2, typeof(UILongPressTrigger)).onLongPressed:AddListener(function()
				var_7_2 = true

				setActive(self.seed_detals, true)

				self.seed_detals.position = arg_7_2.position

				setText(self.seed_detals:Find("bg/itemSeed/icon_bg/count_bg/count"), var_7_1:GetCount())
				GetImageSpriteFromAtlasAsync("island/" .. var_7_1:GetIcon(), "", self.seed_detals:Find("bg/itemSeed/icon_bg/icon"))
				setText(self.seed_detals:Find("bg/detaiView/Viewport/detaiViewText"), var_7_1:GetDesc())
				setText(self.seed_detals:Find("bg/seedName"), var_7_1:GetName())

				return
			end)
		end

		return
	end)
	self.uiSeedItemList:align(#var_6_2)

	return
end

function IslandSeedOpView:CheckSeedEmpty(arg_10_1)
	local var_10_0 = pg.island_production_slot[arg_10_1:GetDataVO().slotData.configId].place
	local var_10_1 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

	self.selectseedItemId = nil

	local var_10_2 = PlayerPrefs.GetInt("island_last_selectItemId" .. var_10_0, 0)

	if var_10_2 ~= 0 and var_10_1:GetOwnCount(pg.island_farm_seed[var_10_2].itemid) > 0 then
		self.selectseedItemId = var_10_2

		return false
	end

	for iter_10_0, iter_10_1 in ipairs(pg.island_production_place[var_10_0].seed_list) do
		local var_10_3 = var_10_1:GetItemById(pg.island_farm_seed[iter_10_1].itemid)

		if var_10_3 and var_10_3:GetCount() ~= 0 then
			self.selectseedItemId = iter_10_1

			return false
		end
	end

	return true
end

return IslandSeedOpView
