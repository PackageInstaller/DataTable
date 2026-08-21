local var_0_0 = class("IslandSeedOpView", import("..IslandBaseOpView"))

function var_0_0.GetUIName(arg_1_0)
	return "IslandSeedOpUI"
end

function var_0_0.OnInit(arg_2_0, arg_2_1)
	arg_2_0.seedSelectPlane = arg_2_0._tf:Find("seed_select")
	arg_2_0.seed_detals = arg_2_0._tf:Find("seed_detals")
	arg_2_0.uiSeedItemList = UIItemList.New(arg_2_0.seedSelectPlane:Find("content"), arg_2_0.seedSelectPlane:Find("content/itemSeed"))

	onButton(arg_2_0, arg_2_0._tf, function()
		setActive(arg_2_0.seed_detals, false)
		arg_2_0:ActiveSeedSelect(false)

		return
	end, SFX_PANEL)
	setActive(arg_2_0.seed_detals, false)
	arg_2_0:ActiveSeedSelect(false)

	return
end

function var_0_0.ActiveSeedDetals(arg_4_0, arg_4_1)
	setActive(arg_4_0.seed_detals, arg_4_1)

	return
end

function var_0_0.ActiveSeedSelect(arg_5_0, arg_5_1)
	if arg_5_1 then
		local var_5_0 = GameObject.Find("UICamera"):GetComponent(typeof(Camera))

		arg_5_0.seedSelectPlane.localPosition = LuaHelper.ScreenToLocal(arg_5_0._tf, var_5_0:WorldToScreenPoint((arg_5_0:GetView():GetSubView(IslandOpView):GetSeedBtnWorldPos())), var_5_0)

		arg_5_0._tf:SetAsLastSibling()
	end

	setActive(arg_5_0.seedSelectPlane, arg_5_1)
	setActive(arg_5_0._tf, arg_5_1)

	return
end

function var_0_0.RefreshSeedPlane(arg_6_0, arg_6_1)
	local var_6_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in ipairs(pg.island_production_place[pg.island_production_slot[arg_6_1:GetDataVO().slotData.configId].place].seed_list) do
		if var_6_0:GetItemById(pg.island_farm_seed[iter_6_1].itemid) then
			table.insert({}, iter_6_1)
		end
	end

	local var_6_2 = #{}
	local var_6_3 = arg_6_0.seedSelectPlane:Find("content"):GetComponent(typeof(GridLayoutGroup))
	local var_6_4 = math.min(#{}, 7)
	local var_6_5 = math.ceil(#{} / 7)

	arg_6_0.seedSelectPlane:Find("content").sizeDelta = Vector2(var_6_3.cellSize.x * var_6_4 + var_6_3.spacing.x * (var_6_4 - 1) + var_6_3.padding.right + 40, var_6_3.cellSize.y * var_6_5 + var_6_3.spacing.y * (var_6_5 - 1) + var_6_3.padding.bottom + 30)

	arg_6_0.uiSeedItemList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			local var_7_0 = var_6_1[arg_7_1 + 1]

			setActive(arg_7_2:Find("select"), arg_6_0.selectseedItemId == var_6_1[arg_7_1 + 1])

			local var_7_1 = var_6_0:GetItemById(pg.island_farm_seed[var_7_0].itemid)

			updateCustomDrop(arg_7_2, Drop.New({
				type = DROP_TYPE_ISLAND_ITEM,
				id = var_7_1.id,
				count = var_7_1:GetCount()
			}))

			local var_7_2

			onButton(arg_6_0, arg_7_2, function()
				if var_7_2 then
					var_7_2 = false

					return
				end

				arg_6_0.selectseedItemId = var_7_0

				PlayerPrefs.SetInt("island_last_selectItemId" .. var_0, arg_6_0.selectseedItemId)
				arg_6_0.uiSeedItemList:align(var_6_2)
				arg_6_0:GetView():GetSubView(IslandOpView):RefreshCurrentSlectSeed()
				arg_6_0:ActiveSeedSelect(false)
				setActive(arg_6_0.seed_detals, false)

				return
			end, SFX_PANEL)
			GetOrAddComponent(arg_7_2, typeof(UILongPressTrigger)).onLongPressed:AddListener(function()
				var_7_2 = true

				setActive(arg_6_0.seed_detals, true)

				arg_6_0.seed_detals.position = arg_7_2.position

				setText(arg_6_0.seed_detals:Find("bg/itemSeed/icon_bg/count_bg/count"), var_7_1:GetCount())
				GetImageSpriteFromAtlasAsync("island/" .. var_7_1:GetIcon(), "", arg_6_0.seed_detals:Find("bg/itemSeed/icon_bg/icon"))
				setText(arg_6_0.seed_detals:Find("bg/detaiView/Viewport/detaiViewText"), var_7_1:GetDesc())
				setText(arg_6_0.seed_detals:Find("bg/seedName"), var_7_1:GetName())

				return
			end)
		end

		return
	end)
	arg_6_0.uiSeedItemList:align(#{})

	return
end

function var_0_0.CheckSeedEmpty(arg_10_0, arg_10_1)
	local var_10_0 = pg.island_production_slot[arg_10_1:GetDataVO().slotData.configId].place
	local var_10_1 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

	arg_10_0.selectseedItemId = nil

	local var_10_2 = PlayerPrefs.GetInt("island_last_selectItemId" .. var_10_0, 0)

	if var_10_2 ~= 0 and var_10_1:GetOwnCount(pg.island_farm_seed[var_10_2].itemid) > 0 then
		arg_10_0.selectseedItemId = var_10_2

		return false
	end

	for iter_10_0, iter_10_1 in ipairs(pg.island_production_place[var_10_0].seed_list) do
		local var_10_3 = var_10_1:GetItemById(pg.island_farm_seed[iter_10_1].itemid)

		if var_10_3 and var_10_3:GetCount() ~= 0 then
			arg_10_0.selectseedItemId = iter_10_1

			return false
		end
	end

	return true
end

return var_0_0
