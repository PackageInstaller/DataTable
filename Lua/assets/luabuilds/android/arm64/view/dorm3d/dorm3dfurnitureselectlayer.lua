local var_0_0 = class("Dorm3dFurnitureSelectLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "Dorm3dFurnitureSelectUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.zoneList = arg_2_0._tf:Find("ZoneList")

	setActive(arg_2_0.zoneList, false)

	local var_2_0 = arg_2_0._tf:Find("Right/Panel/Container/Furnitures")

	arg_2_0.furnitureScroll = var_2_0:Find("Scroll/Content"):GetComponent("LScrollRect")
	arg_2_0.furnitureEmpty = var_2_0:Find("Empty")
	arg_2_0.lableTrans = arg_2_0._tf:Find("Main/Label")

	setActive(arg_2_0.lableTrans, false)
	setText(arg_2_0.furnitureScroll.prefabItem.transform:Find("Unfit/Icon/Text"), i18n("dorm3d_furniture_unfit"))
	setText(arg_2_0.furnitureScroll.prefabItem.transform:Find("Lack/Icon/Text"), i18n("ryza_tip_control_buff_not_obtain"))

	return
end

function var_0_0.SetSceneRoot(arg_3_0, arg_3_1)
	arg_3_0.scene = arg_3_1

	return
end

function var_0_0.SetRoom(arg_4_0, arg_4_1)
	arg_4_0.room = arg_4_1:clone()

	return
end

function var_0_0.didEnter(arg_5_0)
	arg_5_0.allZones = arg_5_0.room:GetFurnitureZones()
	arg_5_0.globalZones = _.select(arg_5_0.allZones, function(arg_6_0)
		return arg_6_0:IsGlobal()
	end)
	arg_5_0.normalZones = _.select(arg_5_0.allZones, function(arg_7_0)
		return not arg_7_0:IsGlobal()
	end)
	arg_5_0.zoneIndex = 1

	if arg_5_0.scene:GetAttachedFurnitureName() then
		table.Ipairs(arg_5_0.normalZones, function(arg_8_0, arg_8_1)
			if arg_8_1:GetWatchCameraName() == var_0 then
				arg_5_0.zoneIndex = arg_8_0
			end

			return
		end)
	end

	onButton(arg_5_0, arg_5_0._tf:Find("Right/Panel/Container/Zone/ZoneContainer/Switch"), function()
		setActive(arg_5_0.zoneList, true)

		return
	end, SFX_PANEL)
	setActive(arg_5_0._tf:Find("Right/Panel/Container/Zone/ZoneContainer/Switch/New"), false)
	onButton(arg_5_0, arg_5_0.zoneList:Find("Mask"), function()
		setActive(arg_5_0.zoneList, false)

		return
	end)
	onButton(arg_5_0, arg_5_0._tf:Find("Top/Back"), function()
		arg_5_0:onBackPressed()

		return
	end)
	onButton(arg_5_0, arg_5_0._tf:Find("Right/Save"), function()
		arg_5_0:ShowReplaceWindow()

		return
	end, SFX_PANEL)

	local function var_5_0(arg_13_0)
		arg_5_0._tf:Find("Right/Popup"):GetComponent(typeof(Image)).raycastTarget = not arg_13_0
		arg_5_0._tf:Find("Right/Collapse"):GetComponent(typeof(Image)).raycastTarget = arg_13_0

		if arg_13_0 then
			quickPlayAnimation(arg_5_0._tf, "anim_dorm3d_furniture_in")
		else
			quickPlayAnimation(arg_5_0._tf, "anim_dorm3d_furniture_hide")
		end

		return
	end

	arg_5_0._tf:Find("Right/Popup"):GetComponent(typeof(Image)).raycastTarget = false
	arg_5_0._tf:Find("Right/Collapse"):GetComponent(typeof(Image)).raycastTarget = true

	onButton(arg_5_0, arg_5_0._tf:Find("Right/Popup"), function()
		var_5_0(true)

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0._tf:Find("Right/Collapse"), function()
		var_5_0(false)

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0._tf:Find("Right/Auto"), function()
		arg_5_0:AutoReplaceFurniture()

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.lableTrans, function()
		arg_5_0:CleanSlot()

		return
	end, "ui-dorm_furniture_removal")

	arg_5_0.furnitureItems = {}

	function arg_5_0.furnitureScroll.onUpdateItem(arg_18_0, arg_18_1)
		arg_18_0 = arg_18_0 + 1
		arg_5_0.furnitureItems[arg_18_0] = arg_18_1

		arg_5_0:UpdateViewFurnitureItem(arg_18_0)

		return
	end

	function arg_5_0.furnitureScroll.onReturnItem(arg_19_0, arg_19_1)
		if arg_5_0.exited then
			return
		end

		arg_19_0 = arg_19_0 + 1
		arg_5_0.furnitureItems[arg_19_0] = nil

		return
	end

	arg_5_0.replaceFurnitures = {}

	arg_5_0:UpdateDataZone()
	arg_5_0:InitViewZoneList()
	arg_5_0:InitViewTypeList()
	arg_5_0.scene:EnterFurnitureWatchMode()
	arg_5_0.scene:SwitchFurnitureZone(arg_5_0.normalZones[arg_5_0.zoneIndex])
	onNextTick(function()
		arg_5_0.furnitureScroll.enabled = true

		arg_5_0:UpdateView()

		return
	end)

	arg_5_0.updateHandler = UpdateBeat:CreateListener(function()
		xpcall(function()
			arg_5_0:Update()

			return
		end, function(...)
			errorMsg(debug.traceback(...))

			return
		end)

		return
	end)

	UpdateBeat:AddListener(arg_5_0.updateHandler)

	return
end

function var_0_0.Update(arg_24_0)
	if arg_24_0.labelSettings then
		setLocalPosition(arg_24_0.lableTrans, (arg_24_0.scene:GetLocalPosition(arg_24_0.scene:GetScreenPosition(arg_24_0.scene:GetSlotByID(arg_24_0.labelSettings.slotId).position), arg_24_0.lableTrans.parent)))
	end

	return
end

function var_0_0.UpdateDataZone(arg_25_0)
	local var_25_0 = {}

	_.each(_.reduce({
		arg_25_0.normalZones[arg_25_0.zoneIndex],
		unpack(arg_25_0.globalZones)
	}, {}, function(arg_26_0, arg_26_1)
		table.insertto(arg_26_0, arg_26_1:GetSlots())

		return arg_26_0
	end), function(arg_27_0)
		var_25_0[arg_27_0:GetType()] = true

		return
	end)

	;({})[Dorm3dFurniture.TYPE.SPECIAL] = nil
	arg_25_0.activeFurnitureTypes = _.keys({})

	if _.any(arg_25_0:GetDisplayFurnitures(nil), function(arg_28_0)
		return arg_28_0.template:IsSpecial()
	end) then
		table.insert(arg_25_0.activeFurnitureTypes, Dorm3dFurniture.TYPE.SPECIAL)
	end

	arg_25_0.normalZones[arg_25_0.zoneIndex]:SortTypes(arg_25_0.activeFurnitureTypes)

	arg_25_0.furnitureType = arg_25_0.activeFurnitureTypes[1]

	arg_25_0:ResetSelectSetting()
	arg_25_0:UpdateDataDisplayFurnitures()
	arg_25_0:FilterDataFurnitures()

	return
end

function var_0_0.ResetSelectSetting(arg_29_0)
	arg_29_0.selectFurnitureId = nil
	arg_29_0.selectSlotId = nil

	return
end

function var_0_0.GetDisplayFurnitures(arg_30_0, arg_30_1)
	local var_30_0 = _.reduce({
		arg_30_0.normalZones[arg_30_0.zoneIndex],
		unpack(arg_30_0.globalZones)
	}, {}, function(arg_31_0, arg_31_1)
		table.insertto(arg_31_0, arg_31_1:GetSlots())

		return arg_31_0
	end)
	local var_30_1 = {}
	local var_30_2 = {}

	_.each(arg_30_0.room:GetFurnitureIDList(), function(arg_32_0)
		local var_32_0 = Dorm3dFurniture.New({
			configId = arg_32_0
		})

		if arg_30_1 and var_32_0:GetType() ~= arg_30_1 then
			return
		end

		if not _.any(var_30_0, function(arg_33_0)
			return arg_33_0:CanUseFurniture(var_32_0)
		end) then
			return
		end

		table.insert(var_30_2, {
			useable = 0,
			count = 0,
			id = arg_32_0,
			template = var_32_0
		})

		var_30_1[arg_32_0] = #var_30_2

		return
	end)
	_.each(arg_30_0.room:GetFurnitures(), function(arg_34_0)
		if arg_30_1 and arg_34_0:GetType() ~= arg_30_1 then
			return
		end

		if not _.any(var_30_0, function(arg_35_0)
			return arg_35_0:CanUseFurniture(arg_34_0)
		end) then
			return
		end

		local var_34_0 = arg_34_0:GetConfigID()
		local var_34_1 = var_30_2[var_30_1[var_34_0]]

		var_34_1.count = var_30_2[var_30_1[var_34_0]].count + 1

		if arg_34_0:GetSlotID() == 0 then
			var_34_1.useable = var_34_1.useable + 1
		end

		var_34_1.viewedFlag = Dorm3dFurniture.GetViewedFlag(var_34_0) ~= 0

		return
	end)

	var_30_2 = _.filter(var_30_2, function(arg_36_0)
		return arg_36_0.count > 0 or arg_36_0.template:InShopTime()
	end)

	return var_30_2
end

function var_0_0.UpdateDataDisplayFurnitures(arg_37_0)
	arg_37_0.displayFurnitures = arg_37_0.furnitureType == Dorm3dFurniture.TYPE.SPECIAL and _.filter(arg_37_0:GetDisplayFurnitures(nil), function(arg_38_0)
		return arg_38_0.template:IsSpecial()
	end) or arg_37_0:GetDisplayFurnitures(arg_37_0.furnitureType)

	return
end

function var_0_0.FilterDataFurnitures(arg_39_0)
	table.sort(arg_39_0.displayFurnitures, CompareFuncs({
		function(arg_40_0)
			return arg_40_0.useable > 0 and 0 or 1
		end,
		function(arg_41_0)
			return -arg_41_0.template:GetRarity()
		end,
		function(arg_42_0)
			return -arg_42_0.template:GetTargetSlotID()
		end,
		function(arg_43_0)
			return -arg_43_0.id
		end
	}))

	return
end

function var_0_0.InitViewZoneList(arg_44_0)
	UIItemList.StaticAlign(arg_44_0.zoneList:Find("List"), arg_44_0.zoneList:Find("List"):GetChild(0), #arg_44_0.normalZones, function(arg_45_0, arg_45_1, arg_45_2)
		if arg_45_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_45_1 = arg_45_1 + 1

		local var_45_0 = var_0[arg_45_1]

		arg_45_2.name = var_0[arg_45_1]:GetWatchCameraName()

		setText(arg_45_2:Find("Name"), var_0[arg_45_1]:GetName())
		onButton(arg_44_0, arg_45_2, function()
			arg_44_0.zoneIndex = arg_45_1

			arg_44_0:UpdateDataZone()
			arg_44_0.scene:SwitchFurnitureZone(var_45_0)
			arg_44_0:InitViewTypeList()
			arg_44_0:UpdateView()
			quickPlayAnimation(arg_44_0._tf, "anim_dorm3d_furniture_change")
			setActive(arg_44_0.zoneList, false)

			return
		end, SFX_PANEL)
		setActive(arg_45_2:Find("Line"), arg_45_1 < #var_0)
		setActive(arg_45_2:Find("New"), false)

		return
	end)

	return
end

function var_0_0.InitViewTypeList(arg_47_0)
	UIItemList.StaticAlign(arg_47_0._tf:Find("Right/Panel/Container/Types"), arg_47_0._tf:Find("Right/Panel/Container/Types"):GetChild(0), #arg_47_0.activeFurnitureTypes, function(arg_48_0, arg_48_1, arg_48_2)
		if arg_48_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_48_1 = arg_48_1 + 1

		setText(arg_48_2:Find("Name"), i18n(Dorm3dFurniture.TYPE2NAME[arg_47_0.activeFurnitureTypes[arg_48_1]]))
		onButton(arg_47_0, arg_48_2, function()
			if arg_47_0.furnitureType == var_0 then
				return
			end

			arg_47_0.furnitureType = var_0

			arg_47_0:ResetSelectSetting()
			arg_47_0:UpdateDataDisplayFurnitures()
			arg_47_0:FilterDataFurnitures()
			arg_47_0:UpdateView()
			quickPlayAnimation(arg_47_0._tf, "anim_dorm3d_furniture_change")
			setActive(arg_47_0.zoneList, false)

			return
		end, SFX_PANEL)

		return
	end)

	return
end

function var_0_0.UpdateView(arg_50_0)
	local var_50_0 = arg_50_0.normalZones[arg_50_0.zoneIndex]

	setText(arg_50_0._tf:Find("Right/Panel/Container/Zone/ZoneContainer/Name"), arg_50_0.normalZones[arg_50_0.zoneIndex]:GetName())
	UIItemList.StaticAlign(arg_50_0.zoneList:Find("List"), arg_50_0.zoneList:Find("List"):GetChild(0), #arg_50_0.normalZones, function(arg_51_0, arg_51_1, arg_51_2)
		if arg_51_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_51_1 = arg_51_1 + 1

		local var_51_0 = arg_51_2:Find("Name")
		local var_51_1 = arg_50_0.zoneIndex == arg_51_1 and Color.NewHex("39bfff") or Color.white

		var_51_1.a = var_51_0:GetComponent(typeof(Text)).color.a

		setTextColor(arg_51_2:Find("Name"), var_51_1)
		setActive(arg_51_2:Find("New"), false)

		return
	end)

	local var_50_1 = arg_50_0.room:GetFurnitures()

	;(function()
		local var_52_0 = false

		table.Ipairs(arg_50_0.normalZones, function(arg_53_0, arg_53_1)
			local var_53_0 = false

			if arg_53_1 ~= var_50_0 then
				var_53_0 = _.any(arg_53_1:GetSlots(), function(arg_54_0)
					return _.any(var_50_1, function(arg_55_0)
						if not arg_54_0:CanUseFurniture(arg_55_0) then
							return
						end

						return Dorm3dFurniture.GetViewedFlag(arg_55_0:GetConfigID()) == 0
					end)
				end)
			end

			setActive(arg_50_0.zoneList:Find("List"):GetChild(arg_53_0 - 1):Find("New"), var_53_0)

			var_52_0 = var_52_0 or var_53_0

			return
		end)
		setActive(arg_50_0._tf:Find("Right/Panel/Container/Zone/ZoneContainer/Switch/New"), false)

		return
	end)()
	setActive(arg_50_0._tf:Find("Right/Panel/Container/Types"), #arg_50_0.activeFurnitureTypes > 1)
	UIItemList.StaticAlign(arg_50_0._tf:Find("Right/Panel/Container/Types"), arg_50_0._tf:Find("Right/Panel/Container/Types"):GetChild(0), #arg_50_0.activeFurnitureTypes, function(arg_56_0, arg_56_1, arg_56_2)
		if arg_56_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_56_1 = arg_56_1 + 1

		setActive(arg_56_2:Find("Selected"), arg_50_0.furnitureType == arg_50_0.activeFurnitureTypes[arg_56_1])
		setActive(arg_56_2:Find("New"), (_.any(var_50_0:GetSlots(), function(arg_57_0)
			return _.any(var_50_1, function(arg_58_0)
				if arg_58_0:GetType() ~= var_0 then
					return
				end

				if not arg_57_0:CanUseFurniture(arg_58_0) then
					return
				end

				return Dorm3dFurniture.GetViewedFlag(arg_58_0:GetConfigID()) == 0
			end)
		end)))

		return
	end)

	arg_50_0.furnitureItems = {}

	arg_50_0.furnitureScroll:SetTotalCount(#arg_50_0.displayFurnitures)
	setActive(arg_50_0.furnitureEmpty, #arg_50_0.displayFurnitures == 0)

	if arg_50_0.timerRefreshShop then
		arg_50_0.timerRefreshShop:Stop()
	end

	arg_50_0.timerRefreshShop = Timer.New(function()
		table.Foreach(arg_50_0.furnitureItems, function(arg_60_0, arg_60_1)
			arg_50_0:UpdateViewFurnitureItem(arg_60_0)

			return
		end)

		return
	end, 1, -1)

	arg_50_0.timerRefreshShop:Start()

	local var_50_2 = {}
	local var_50_3 = arg_50_0.furnitureType
	local var_50_4 = _.select(_.reduce({
		var_50_0,
		unpack(arg_50_0.globalZones)
	}, {}, function(arg_61_0, arg_61_1)
		table.insertto(arg_61_0, arg_61_1:GetSlots())

		return arg_61_0
	end), function(arg_62_0)
		return arg_62_0:GetType() == var_50_3
	end)

	_.each(var_50_4, function(arg_63_0)
		var_50_2[arg_63_0:GetConfigID()] = 0

		return
	end)

	if arg_50_0.selectSlotId then
		local var_50_5 = Dorm3dFurnitureSlot.New({
			configId = arg_50_0.selectSlotId
		})

		if var_50_5:GetType() ~= Dorm3dFurniture.TYPE.DECORATION then
			if var_50_5:GetType() == Dorm3dFurniture.TYPE.SPECIAL then
				if _.detect(arg_50_0.room:GetFurnitures(), function(arg_64_0)
					return arg_64_0:GetSlotID() == var_50_5:GetConfigID()
				end) then
					arg_50_0:CleanSlot()
				end
			end

			if not false then
				arg_50_0.labelSettings = nil
			end

			setActive(arg_50_0.lableTrans, false)
			arg_50_0.scene:DisplayFurnitureSlots(_.map(var_50_4, function(arg_65_0)
				return arg_65_0:GetConfigID()
			end))
			arg_50_0.scene:UpdateDisplaySlots({})
			arg_50_0.scene:RefreshSlots(arg_50_0.room)

			return
		end
	end
end

function var_0_0.UpdateViewFurnitureItem(arg_66_0, arg_66_1)
	local var_66_0 = arg_66_0.displayFurnitures[arg_66_1]

	if not arg_66_0.furnitureItems[arg_66_1] then
		return
	end

	local var_66_1 = tf(arg_66_0.furnitureItems[arg_66_1])

	var_66_1.name = var_66_0.id

	updateCustomDrop(var_66_1:Find("Item/Dorm3dIconTpl"), Drop.New({
		type = DROP_TYPE_DORM3D_FURNITURE,
		id = var_66_0.id,
		count = var_66_0.count
	}))
	setText(var_66_1:Find("Item/Name"), var_66_0.template:GetName())

	local var_66_2 = i18n("dorm3d_furniture_count", var_66_0.useable .. "/" .. var_66_0.count)

	if var_66_0.useable < var_66_0.count then
		var_66_2 = i18n("dorm3d_furniture_used") .. var_66_2
	elseif var_66_0.count == 0 then
		var_66_2 = i18n("dorm3d_furniture_lack") .. var_66_2
	end

	setText(var_66_1:Find("Item/Count"), var_66_2)
	setActive(var_66_1:Find("Selected"), arg_66_0.selectFurnitureId == var_66_0.id)
	setCanvasGroupAlpha(var_66_1:Find("Item"), 1)

	local var_66_3 = 0

	if var_66_0.template:IsSpecial() then
		var_66_3 = 2
	elseif var_66_0.template:IsValuable() then
		var_66_3 = 1
	end

	setActive(var_66_1:Find("Item/BG/Pro"), var_66_3 == 1)
	setActive(var_66_1:Find("Item/LabelPro"), var_66_3 == 1)
	setActive(var_66_1:Find("Item/BG/SP"), var_66_3 == 2)
	setActive(var_66_1:Find("Item/LabelSP"), var_66_3 == 2)
	setActive(var_66_1:Find("Item/Action"), false)

	local var_66_4 = var_66_0.template:GetEndTime()

	if var_66_0.count == 0 and var_66_4 > 0 then
		local var_66_5 = var_66_4 > pg.TimeMgr.GetInstance():GetServerTime()

		setActive(var_66_1:Find("TimeLimit"), var_66_5)

		if var_66_5 then
			setText(var_66_1:Find("TimeLimit/Text"), skinCommdityTimeStamp(var_66_4))
		end

		onButton(arg_66_0, var_66_1:Find("Item/Tip"), function()
			arg_66_0:emit(Dorm3dFurnitureSelectMediator.SHOW_FURNITURE_ACESSES, {
				showGOBtn = true,
				title = i18n("courtyard_label_detail"),
				drop = {
					type = DROP_TYPE_DORM3D_FURNITURE,
					id = var_66_0.id,
					count = var_66_0.count
				},
				list = var_66_0.template:GetAcesses()
			})

			return
		end, SFX_PANEL)

		local var_66_6 = var_66_0.count > 0 and not var_66_0.viewedFlag

		setActive(var_66_1:Find("Item/New"), var_66_0.count > 0 and not var_66_0.viewedFlag)

		if var_66_6 then
			Dorm3dFurniture.SetViewedFlag(var_66_0.id)
		end

		onButton(arg_66_0, var_66_1, function()
			if var_66_0.count > 0 then
				setActive(var_66_1:Find("Item/New"), false)

				var_66_0.viewedFlag = true
			end

			local var_68_0 = var_66_0.template:GetTargetSlotID()

			arg_66_0.selectSlotId = nil

			if var_66_0.useable > 0 then
				arg_66_0.room:ReplaceFurniture(var_68_0, var_66_0.id)
				table.insert(arg_66_0.replaceFurnitures, {
					slotId = var_68_0,
					furnitureId = var_66_0.id
				})
				arg_66_0:UpdateDataDisplayFurnitures()
				arg_66_0:UpdateView()
				pg.CriMgr.GetInstance():PlaySE_V3("ui-dorm_furniture_placement")
			elseif var_66_0.useable < var_66_0.count then
				arg_66_0.selectSlotId = var_68_0

				arg_66_0:UpdateView()
			end

			return
		end)

		local var_66_7 = var_66_0.count == 0 and var_66_0.template:GetShopID() or 0

		setActive(var_66_1:Find("GO"), var_66_7 ~= 0)

		if var_66_7 ~= 0 then
			local var_66_8 = CommonCommodity.New({
				id = var_66_7
			}, Goods.TYPE_SHOPSTREET)
			local var_66_9, var_66_10, var_66_11 = var_66_8:GetPrice()
			local var_66_12 = Drop.New({
				type = DROP_TYPE_RESOURCE,
				id = var_66_8:GetResType(),
				count = var_66_9
			})

			onButton(arg_66_0, var_66_1:Find("GO"), function()
				arg_66_0:emit(Dorm3dFurnitureSelectMediator.SHOW_SHOPPING_CONFIRM_WINDOW, {
					content = {
						icon = "<icon name=" .. var_66_8:GetResIcon() .. " w=1.1 h=1.1/>",
						off = var_66_10,
						cost = var_66_12.count,
						old = var_66_11,
						name = var_66_0.template:GetName()
					},
					tip = i18n("dorm3d_shop_gift_tip"),
					drop = var_66_0.template,
					endTime = var_66_0.template:GetEndTime(),
					onYes = function()
						if not var_66_0.template:InShopTime() then
							pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_purchase_outtime"))

							return
						end

						arg_66_0:emit(GAME.SHOPPING, {
							silentTip = true,
							count = 1,
							shopId = var_66_7
						})

						return
					end
				})

				return
			end, SFX_PANEL)
		end

		return
	end
end

function var_0_0.CleanSlot(arg_71_0)
	if not arg_71_0.selectSlotId then
		return
	end

	local var_71_0 = arg_71_0.selectSlotId

	arg_71_0.room:ReplaceFurniture(arg_71_0.selectSlotId, 0)
	table.insert(arg_71_0.replaceFurnitures, {
		furnitureId = 0,
		slotId = var_71_0
	})
	arg_71_0:ResetSelectSetting()
	arg_71_0:UpdateDataDisplayFurnitures()
	arg_71_0:UpdateView()

	return
end

function var_0_0.OnReplaceFurnitureDone(arg_72_0)
	arg_72_0.replaceFurnitures = {}

	existCall(arg_72_0.replaceFurnitureCallback)

	arg_72_0.replaceFurnitureCallback = nil

	return
end

function var_0_0.OnReplaceFurnitureError(arg_73_0)
	arg_73_0.replaceFurnitureCallback = nil

	return
end

function var_0_0.AutoReplaceFurniture(arg_74_0)
	_.each(arg_74_0.normalZones[arg_74_0.zoneIndex]:GetSlots(), function(arg_75_0)
		if arg_75_0:GetType() == Dorm3dFurniture.TYPE.FLOOR or arg_75_0:GetType() == Dorm3dFurniture.TYPE.WALLPAPER then
			return
		end

		local var_75_0 = arg_74_0.room:GetFurnitures()
		local var_75_1 = _.detect(var_75_0, function(arg_76_0)
			return arg_76_0:GetSlotID() == arg_75_0:GetConfigID()
		end)

		if var_75_1 and var_75_1:GetConfigID() ~= arg_75_0:GetDefaultFurniture() then
			return
		end

		local var_75_2 = table.shallowCopy(var_75_0)

		table.sort(var_75_2, CompareFuncs({
			function(arg_77_0)
				return arg_77_0:GetSlotID() == 0 and arg_75_0:CanUseFurniture(arg_77_0) and 0 or 1
			end,
			function(arg_78_0)
				return -arg_78_0:GetRarity()
			end,
			function(arg_79_0)
				return -arg_79_0:GetConfigID()
			end
		}))

		if not var_75_2[1] or var_75_2[1]:GetSlotID() ~= 0 or not arg_75_0:CanUseFurniture(var_75_2[1]) then
			return
		end

		arg_74_0.room:ReplaceFurniture(arg_75_0:GetConfigID(), var_75_2[1]:GetConfigID())
		table.insert(arg_74_0.replaceFurnitures, {
			slotId = arg_75_0:GetConfigID(),
			furnitureId = var_75_2[1]:GetConfigID()
		})

		return
	end)
	arg_74_0:ResetSelectSetting()
	arg_74_0:UpdateDataDisplayFurnitures()
	arg_74_0:UpdateView()

	return
end

function var_0_0.ShowReplaceWindow(arg_80_0, arg_80_1, arg_80_2)
	if #arg_80_0.replaceFurnitures == 0 then
		return existCall(arg_80_1)
	end

	arg_80_0:emit(Dorm3dFurnitureSelectMediator.SHOW_CONFIRM_WINDOW, {
		title = i18n("title_info"),
		content = i18n("dorm3d_furniture_sure_save"),
		onYes = function()
			arg_80_0:emit(GAME.APARTMENT_REPLACE_FURNITURE, {
				roomId = arg_80_0.room:GetConfigID(),
				furnitures = var_0
			})

			arg_80_0.replaceFurnitureCallback = arg_80_1

			return
		end,
		onNo = arg_80_2
	})

	return
end

function var_0_0.onBackPressed(arg_82_0)
	seriesAsync({
		function(arg_83_0)
			arg_82_0:ShowReplaceWindow(arg_83_0, arg_83_0)

			return
		end,
		function(arg_84_0)
			GetOrAddComponent(arg_82_0._tf, typeof(CanvasGroup)).alpha = 0

			arg_82_0.scene:ExitFurnitureWatchMode(function()
				var_0_0.super.onBackPressed(arg_82_0)

				return
			end)

			return
		end
	})

	return
end

function var_0_0.willExit(arg_86_0)
	arg_86_0.furnitureScroll.enabled = false

	if arg_86_0.timerRefreshShop then
		arg_86_0.timerRefreshShop:Stop()
	end

	UpdateBeat:RemoveListener(arg_86_0.updateHandler)

	return
end

return var_0_0
