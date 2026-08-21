local var_0_0 = class("Dorm3dCollectionItemSubView", import("view.dorm3d.Game.Dorm3dGameBaseSubView"))

function var_0_0.Init(arg_1_0)
	arg_1_0:OnLoaded()
	arg_1_0:OnInit()

	return
end

function var_0_0.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf:Find("list/container")

	arg_2_0.itemList = UIItemList.New(var_2_0, var_2_0:Find("tpl"))

	arg_2_0.itemList:make(function(arg_3_0, arg_3_1, arg_3_2)
		arg_3_1 = arg_3_1 + 1

		if arg_3_0 == UIItemList.EventUpdate then
			local var_3_0 = arg_2_0.unlockDic[arg_2_0.ids[arg_3_1]]
			local var_3_1 = ApartmentProxy.CheckUnlockConfig(pg.dorm3d_collection_template[arg_2_0.ids[arg_3_1]].unlock)
			local var_3_2 = arg_3_1

			for iter_3_0 = 1, 2 do
				cloneTplTo(arg_2_0.numContainer:Find("num_" .. arg_3_1 % 10), arg_3_2:Find("num"))

				var_3_2 = math.floor(arg_3_1 / 10)
			end

			setActive(arg_3_2:Find("content/lock"), not var_3_1)
			setActive(arg_3_2:Find("content/mark"), var_3_1 and not arg_2_0.unlockDic[arg_2_0.ids[arg_3_1]])

			local var_3_4 = arg_3_2:Find("content/name")

			if arg_2_0.unlockDic[arg_2_0.ids[arg_3_1]] then
				local var_3_5 = pg.dorm3d_collection_template[arg_2_0.ids[arg_3_1]].name

				if not pg.dorm3d_collection_template[arg_2_0.ids[arg_3_1]].name then
					if var_3_1 then
						var_3_5 = i18n("dorm3d_collect_not_found", i18n(pg.dorm3d_collection_template[arg_2_0.ids[arg_3_1]].text)) or i18n("dorm3d_collect_locked", pg.dorm3d_collection_template[arg_2_0.ids[arg_3_1]].unlock[2])

						var_3_3(var_3_4, var_3_5)

						local function var_3_6(arg_4_0)
							setTextColor(arg_3_2:Find("content/name"), Color.NewHex(not var_3_0 and "a9a9a9" or arg_4_0 and "2d1dfc" or "393a3c"))
							eachChild(arg_3_2:Find("num"), function(arg_5_0)
								setImageColor(arg_5_0, Color.NewHex(arg_4_0 and "2d1dfd" or "393a3c"))

								return
							end)

							return
						end

						onToggle(arg_2_0, arg_3_2, function(arg_6_0)
							if arg_6_0 then
								arg_2_0:UpdateDisplay(arg_3_1, var_0)
							end

							var_3_6(arg_6_0)

							return
						end, SFX_PANEL)
						;(function(arg_4_0)
							setTextColor(arg_3_2:Find("content/name"), Color.NewHex(not var_3_0 and "a9a9a9" or arg_4_0 and "2d1dfc" or "393a3c"))
							eachChild(arg_3_2:Find("num"), function(arg_5_0)
								setImageColor(arg_5_0, Color.NewHex(arg_4_0 and "2d1dfd" or "393a3c"))

								return
							end)

							return
						end)()

						return
					end
				end
			end
		end
	end)

	arg_2_0.numContainer = arg_2_0._tf:Find("list/number")
	arg_2_0.rtInfo = arg_2_0._tf:Find("info")

	return
end

function var_0_0.OnInit(arg_7_0)
	arg_7_0.dorm3dmainscene = pg.m02:retrieveMediator(Dorm3dRoomMediator.__cname):getViewComponent()

	local var_7_0 = getProxy(ApartmentProxy):getRoom(arg_7_0.contextData.roomId)

	arg_7_0.unlockDic = var_7_0.collectItemDic

	local var_7_1 = pg.dorm3d_collection_template.get_id_list_by_room_id[var_7_0:GetConfigID()] or {}

	arg_7_0.ids = Clone(var_7_1)

	table.sort(arg_7_0.ids, CompareFuncs({
		function(arg_8_0)
			return arg_7_0.unlockDic[arg_8_0] and 0 or 1
		end,
		function(arg_9_0)
			return ApartmentProxy.CheckUnlockConfig(pg.dorm3d_collection_template[arg_9_0].unlock) and 0 or 1
		end,
		function(arg_10_0)
			return arg_10_0
		end
	}))
	setText(arg_7_0.rtInfo:Find("count"), string.format("<color=#2d1dfc>%d</color>/%d", table.getCount(arg_7_0.unlockDic), #arg_7_0.ids))
	arg_7_0.itemList:align(#arg_7_0.ids)
	triggerToggle(arg_7_0.itemList.container:GetChild(0), true)

	return
end

function var_0_0.UpdateDisplay(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = pg.dorm3d_collection_template[arg_11_2]

	setActive(arg_11_0.rtInfo:Find("empty"), not arg_11_0.unlockDic[arg_11_2])

	if not arg_11_0.unlockDic[arg_11_2] then
		local var_11_1

		if not _.any(var_11_0.model, function(arg_12_0)
			local var_12_1, var_12_2 = arg_11_0.dorm3dmainscene:CheckSceneItemActiveByPath(arg_12_0)

			var_11_1 = var_12_2

			return var_12_1
		end) then
			setText(arg_11_0.rtInfo:Find("empty"), i18n("dorm3d_collect_block_by_furniture", (Dorm3dFurniture.New({
				configId = nil
			}):GetName())))
		else
			setText(arg_11_0.rtInfo:Find("empty"), i18n("dorm3d_collect_nothing"))
		end
	end

	local var_11_2 = arg_11_0.rtInfo:Find("content")

	setActive(var_11_2, arg_11_0.unlockDic[arg_11_2])

	if not arg_11_0.unlockDic[arg_11_2] then
		return
	end

	GetImageSpriteFromAtlasAsync("dorm3dcollection/" .. var_11_0.icon, "", var_11_2:Find("icon"), true)
	setText(var_11_2:Find("name/Text"), var_11_0.name)
	setText(var_11_2:Find("desc"), var_11_0.desc)
	setActive(var_11_2:Find("favor"), var_11_0.award > 0)

	if var_11_0.award > 0 then
		setText(var_11_2:Find("favor/Text"), i18n("dorm3d_collect_favor_plus") .. pg.dorm3d_favor_trigger[var_11_0.award].num)
	end

	return
end

return var_0_0
