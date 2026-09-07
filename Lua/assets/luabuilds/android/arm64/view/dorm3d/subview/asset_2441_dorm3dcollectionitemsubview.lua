local Dorm3dCollectionItemSubView = class("Dorm3dCollectionItemSubView", import("view.dorm3d.Game.Dorm3dGameBaseSubView"))

function Dorm3dCollectionItemSubView:Init()
	self:OnLoaded()
	self:OnInit()

	return
end

function Dorm3dCollectionItemSubView:OnLoaded()
	local var_2_0 = self._tf:Find("list/container")

	self.itemList = UIItemList.New(var_2_0, var_2_0:Find("tpl"))

	self.itemList:make(function(arg_3_0, arg_3_1, arg_3_2)
		arg_3_1 = arg_3_1 + 1

		if arg_3_0 == UIItemList.EventUpdate then
			local var_3_0 = self.ids[arg_3_1]
			local var_3_1 = self.unlockDic[self.ids[arg_3_1]]
			local var_3_2 = ApartmentProxy.CheckUnlockConfig(pg.dorm3d_collection_template[self.ids[arg_3_1]].unlock)
			local var_3_3 = arg_3_1

			for iter_3_0 = 1, 2 do
				cloneTplTo(self.numContainer:Find("num_" .. arg_3_1 % 10), arg_3_2:Find("num"))

				var_3_3 = math.floor(arg_3_1 / 10)
			end

			setActive(arg_3_2:Find("content/lock"), not var_3_2)
			setActive(arg_3_2:Find("content/mark"), var_3_2 and not self.unlockDic[self.ids[arg_3_1]])

			local var_3_4 = setText
			local var_3_5 = arg_3_2:Find("content/name")
			local var_3_6

			if self.unlockDic[self.ids[arg_3_1]] then
				var_3_6 = pg.dorm3d_collection_template[self.ids[arg_3_1]].name

				if not pg.dorm3d_collection_template[self.ids[arg_3_1]].name then
					if var_3_2 then
						var_3_6 = i18n("dorm3d_collect_not_found", i18n(pg.dorm3d_collection_template[self.ids[arg_3_1]].text)) or i18n("dorm3d_collect_locked", pg.dorm3d_collection_template[self.ids[arg_3_1]].unlock[2])
					end
				end
			end

			var_3_4(var_3_5, var_3_6)

			local function var_3_7(arg_4_0)
				setTextColor(arg_3_2:Find("content/name"), Color.NewHex(not var_3_1 and "a9a9a9" or arg_4_0 and "2d1dfc" or "393a3c"))
				eachChild(arg_3_2:Find("num"), function(arg_5_0)
					setImageColor(arg_5_0, Color.NewHex(arg_4_0 and "2d1dfd" or "393a3c"))

					return
				end)

				return
			end

			onToggle(self, arg_3_2, function(arg_6_0)
				if arg_6_0 then
					self:UpdateDisplay(arg_3_1, var_3_0)
				end

				var_3_7(arg_6_0)

				return
			end, SFX_PANEL)
			var_3_7()
		end

		return
	end)

	self.numContainer = self._tf:Find("list/number")
	self.rtInfo = self._tf:Find("info")

	return
end

function Dorm3dCollectionItemSubView:OnInit()
	self.dorm3dmainscene = pg.m02:retrieveMediator(Dorm3dRoomMediator.__cname):getViewComponent()

	local var_7_0 = getProxy(ApartmentProxy):getRoom(self.contextData.roomId)

	self.unlockDic = var_7_0.collectItemDic
	self.ids = Clone(pg.dorm3d_collection_template.get_id_list_by_room_id[var_7_0:GetConfigID()] or {})

	table.sort(self.ids, CompareFuncs({
		function(arg_8_0)
			return self.unlockDic[arg_8_0] and 0 or 1
		end,
		function(arg_9_0)
			return ApartmentProxy.CheckUnlockConfig(pg.dorm3d_collection_template[arg_9_0].unlock) and 0 or 1
		end,
		function(arg_10_0)
			return arg_10_0
		end
	}))
	setText(self.rtInfo:Find("count"), string.format("<color=#2d1dfc>%d</color>/%d", table.getCount(self.unlockDic), #self.ids))
	self.itemList:align(#self.ids)
	triggerToggle(self.itemList.container:GetChild(0), true)

	return
end

function Dorm3dCollectionItemSubView:UpdateDisplay(arg_11_1, arg_11_2)
	local var_11_0 = pg.dorm3d_collection_template[arg_11_2]

	setActive(self.rtInfo:Find("empty"), not self.unlockDic[arg_11_2])

	if not self.unlockDic[arg_11_2] then
		local var_11_1

		if not _.any(var_11_0.model, function(arg_12_0)
			local var_12_1, var_12_2 = self.dorm3dmainscene:CheckSceneItemActiveByPath(arg_12_0)

			var_11_1 = var_12_2

			return var_12_1
		end) then
			setText(self.rtInfo:Find("empty"), i18n("dorm3d_collect_block_by_furniture", (Dorm3dFurniture.New({
				configId = nil
			}):GetName())))
		else
			setText(self.rtInfo:Find("empty"), i18n("dorm3d_collect_nothing"))
		end
	end

	local var_11_2 = self.rtInfo:Find("content")

	setActive(var_11_2, self.unlockDic[arg_11_2])

	if not self.unlockDic[arg_11_2] then
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

return Dorm3dCollectionItemSubView
