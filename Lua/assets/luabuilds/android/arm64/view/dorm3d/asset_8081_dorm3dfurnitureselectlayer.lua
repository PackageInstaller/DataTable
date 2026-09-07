local Dorm3dFurnitureSelectLayer = class("Dorm3dFurnitureSelectLayer", import("view.base.BaseUI"))

function Dorm3dFurnitureSelectLayer:getUIName()
	return "Dorm3dFurnitureSelectUI"
end

function Dorm3dFurnitureSelectLayer:init()
	self.zoneList = self._tf:Find("ZoneList")

	setActive(self.zoneList, false)

	local var_2_0 = self._tf:Find("Right/Panel/Container/Furnitures")

	self.furnitureScroll = var_2_0:Find("Scroll/Content"):GetComponent("LScrollRect")
	self.furnitureEmpty = var_2_0:Find("Empty")
	self.lableTrans = self._tf:Find("Main/Label")

	setActive(self.lableTrans, false)
	setText(self.furnitureScroll.prefabItem.transform:Find("Unfit/Icon/Text"), i18n("dorm3d_furniture_unfit"))
	setText(self.furnitureScroll.prefabItem.transform:Find("Lack/Icon/Text"), i18n("ryza_tip_control_buff_not_obtain"))

	return
end

function Dorm3dFurnitureSelectLayer:SetSceneRoot(arg_3_1)
	self.scene = arg_3_1

	return
end

function Dorm3dFurnitureSelectLayer:SetRoom(arg_4_1)
	self.room = arg_4_1:clone()

	return
end

function Dorm3dFurnitureSelectLayer:didEnter()
	self.allZones = self.room:GetFurnitureZones()
	self.globalZones = _.select(self.allZones, function(arg_6_0)
		return arg_6_0:IsGlobal()
	end)
	self.normalZones = _.select(self.allZones, function(arg_7_0)
		return not arg_7_0:IsGlobal()
	end)
	self.zoneIndex = 1

	local var_5_0 = self.scene:GetAttachedFurnitureName()

	if var_5_0 then
		table.Ipairs(self.normalZones, function(arg_8_0, arg_8_1)
			if arg_8_1:GetWatchCameraName() == var_5_0 then
				self.zoneIndex = arg_8_0
			end

			return
		end)
	end

	onButton(self, self._tf:Find("Right/Panel/Container/Zone/ZoneContainer/Switch"), function()
		setActive(self.zoneList, true)

		return
	end, SFX_PANEL)
	setActive(self._tf:Find("Right/Panel/Container/Zone/ZoneContainer/Switch/New"), false)
	onButton(self, self.zoneList:Find("Mask"), function()
		setActive(self.zoneList, false)

		return
	end)
	onButton(self, self._tf:Find("Top/Back"), function()
		self:onBackPressed()

		return
	end)
	onButton(self, self._tf:Find("Right/Save"), function()
		self:ShowReplaceWindow()

		return
	end, SFX_PANEL)

	local function var_5_1(arg_13_0)
		self._tf:Find("Right/Popup"):GetComponent(typeof(Image)).raycastTarget = not arg_13_0
		self._tf:Find("Right/Collapse"):GetComponent(typeof(Image)).raycastTarget = arg_13_0

		if arg_13_0 then
			quickPlayAnimation(self._tf, "anim_dorm3d_furniture_in")
		else
			quickPlayAnimation(self._tf, "anim_dorm3d_furniture_hide")
		end

		return
	end

	self._tf:Find("Right/Popup"):GetComponent(typeof(Image)).raycastTarget = false
	self._tf:Find("Right/Collapse"):GetComponent(typeof(Image)).raycastTarget = true

	onButton(self, self._tf:Find("Right/Popup"), function()
		var_5_1(true)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("Right/Collapse"), function()
		var_5_1(false)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("Right/Auto"), function()
		self:AutoReplaceFurniture()

		return
	end, SFX_PANEL)
	onButton(self, self.lableTrans, function()
		self:CleanSlot()

		return
	end, "ui-dorm_furniture_removal")

	self.furnitureItems = {}

	function self.furnitureScroll.onUpdateItem(arg_18_0, arg_18_1)
		arg_18_0 = arg_18_0 + 1
		self.furnitureItems[arg_18_0] = arg_18_1

		self:UpdateViewFurnitureItem(arg_18_0)

		return
	end

	function self.furnitureScroll.onReturnItem(arg_19_0, arg_19_1)
		if self.exited then
			return
		end

		arg_19_0 = arg_19_0 + 1
		self.furnitureItems[arg_19_0] = nil

		return
	end

	self.replaceFurnitures = {}

	self:UpdateDataZone()
	self:InitViewZoneList()
	self:InitViewTypeList()
	self.scene:EnterFurnitureWatchMode()
	self.scene:SwitchFurnitureZone(self.normalZones[self.zoneIndex])
	onNextTick(function()
		self.furnitureScroll.enabled = true

		self:UpdateView()

		return
	end)

	self.updateHandler = UpdateBeat:CreateListener(function()
		xpcall(function()
			self:Update()

			return
		end, function(...)
			errorMsg(debug.traceback(...))

			return
		end)

		return
	end)

	UpdateBeat:AddListener(self.updateHandler)

	return
end

function Dorm3dFurnitureSelectLayer:Update()
	if self.labelSettings then
		setLocalPosition(self.lableTrans, (self.scene:GetLocalPosition(self.scene:GetScreenPosition(self.scene:GetSlotByID(self.labelSettings.slotId).position), self.lableTrans.parent)))
	end

	return
end

function Dorm3dFurnitureSelectLayer:UpdateDataZone()
	local var_25_0 = {}

	_.each(_.reduce({
		self.normalZones[self.zoneIndex],
		unpack(self.globalZones)
	}, {}, function(arg_26_0, arg_26_1)
		table.insertto(arg_26_0, arg_26_1:GetSlots())

		return arg_26_0
	end), function(arg_27_0)
		var_25_0[arg_27_0:GetType()] = true

		return
	end)

	var_25_0[Dorm3dFurniture.TYPE.SPECIAL] = nil
	self.activeFurnitureTypes = _.keys(var_25_0)

	if _.any(self:GetDisplayFurnitures(nil), function(arg_28_0)
		return arg_28_0.template:IsSpecial()
	end) then
		table.insert(self.activeFurnitureTypes, Dorm3dFurniture.TYPE.SPECIAL)
	end

	self.normalZones[self.zoneIndex]:SortTypes(self.activeFurnitureTypes)

	self.furnitureType = self.activeFurnitureTypes[1]

	self:ResetSelectSetting()
	self:UpdateDataDisplayFurnitures()
	self:FilterDataFurnitures()

	return
end

function Dorm3dFurnitureSelectLayer:ResetSelectSetting()
	self.selectFurnitureId = nil
	self.selectSlotId = nil

	return
end

function Dorm3dFurnitureSelectLayer:GetDisplayFurnitures(arg_30_1)
	local var_30_0 = _.reduce({
		self.normalZones[self.zoneIndex],
		unpack(self.globalZones)
	}, {}, function(arg_31_0, arg_31_1)
		table.insertto(arg_31_0, arg_31_1:GetSlots())

		return arg_31_0
	end)
	local var_30_1 = {}
	local var_30_2 = {}

	_.each(self.room:GetFurnitureIDList(), function(arg_32_0)
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
	_.each(self.room:GetFurnitures(), function(arg_34_0)
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

function Dorm3dFurnitureSelectLayer:UpdateDataDisplayFurnitures()
	self.displayFurnitures = self.furnitureType == Dorm3dFurniture.TYPE.SPECIAL and _.filter(self:GetDisplayFurnitures(nil), function(arg_38_0)
		return arg_38_0.template:IsSpecial()
	end) or self:GetDisplayFurnitures(self.furnitureType)

	return
end

function Dorm3dFurnitureSelectLayer:FilterDataFurnitures()
	table.sort(self.displayFurnitures, CompareFuncs({
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

function Dorm3dFurnitureSelectLayer:InitViewZoneList()
	local var_44_0 = self.normalZones

	UIItemList.StaticAlign(self.zoneList:Find("List"), self.zoneList:Find("List"):GetChild(0), #self.normalZones, function(arg_45_0, arg_45_1, arg_45_2)
		if arg_45_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_45_1 = arg_45_1 + 1

		local var_45_0 = var_44_0[arg_45_1]

		arg_45_2.name = var_44_0[arg_45_1]:GetWatchCameraName()

		setText(arg_45_2:Find("Name"), var_44_0[arg_45_1]:GetName())
		onButton(self, arg_45_2, function()
			self.zoneIndex = arg_45_1

			self:UpdateDataZone()
			self.scene:SwitchFurnitureZone(var_45_0)
			self:InitViewTypeList()
			self:UpdateView()
			quickPlayAnimation(self._tf, "anim_dorm3d_furniture_change")
			setActive(self.zoneList, false)

			return
		end, SFX_PANEL)
		setActive(arg_45_2:Find("Line"), arg_45_1 < #var_44_0)
		setActive(arg_45_2:Find("New"), false)

		return
	end)

	return
end

function Dorm3dFurnitureSelectLayer:InitViewTypeList()
	UIItemList.StaticAlign(self._tf:Find("Right/Panel/Container/Types"), self._tf:Find("Right/Panel/Container/Types"):GetChild(0), #self.activeFurnitureTypes, function(arg_48_0, arg_48_1, arg_48_2)
		if arg_48_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_48_1 = arg_48_1 + 1

		local var_48_0 = self.activeFurnitureTypes[arg_48_1]

		setText(arg_48_2:Find("Name"), i18n(Dorm3dFurniture.TYPE2NAME[self.activeFurnitureTypes[arg_48_1]]))
		onButton(self, arg_48_2, function()
			if self.furnitureType == var_48_0 then
				return
			end

			self.furnitureType = var_48_0

			self:ResetSelectSetting()
			self:UpdateDataDisplayFurnitures()
			self:FilterDataFurnitures()
			self:UpdateView()
			quickPlayAnimation(self._tf, "anim_dorm3d_furniture_change")
			setActive(self.zoneList, false)

			return
		end, SFX_PANEL)

		return
	end)

	return
end

function Dorm3dFurnitureSelectLayer:UpdateView()
	local var_50_0 = self.normalZones[self.zoneIndex]

	setText(self._tf:Find("Right/Panel/Container/Zone/ZoneContainer/Name"), self.normalZones[self.zoneIndex]:GetName())
	UIItemList.StaticAlign(self.zoneList:Find("List"), self.zoneList:Find("List"):GetChild(0), #self.normalZones, function(arg_51_0, arg_51_1, arg_51_2)
		if arg_51_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_51_1 = arg_51_1 + 1

		local var_51_0 = arg_51_2:Find("Name")
		local var_51_1 = self.zoneIndex == arg_51_1 and Color.NewHex("39bfff") or Color.white

		var_51_1.a = var_51_0:GetComponent(typeof(Text)).color.a

		setTextColor(arg_51_2:Find("Name"), var_51_1)
		setActive(arg_51_2:Find("New"), false)

		return
	end)

	local var_50_1 = self.room:GetFurnitures()

	;(function()
		local var_52_0 = false

		table.Ipairs(self.normalZones, function(arg_53_0, arg_53_1)
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

			setActive(self.zoneList:Find("List"):GetChild(arg_53_0 - 1):Find("New"), var_53_0)

			var_52_0 = var_52_0 or var_53_0

			return
		end)
		setActive(self._tf:Find("Right/Panel/Container/Zone/ZoneContainer/Switch/New"), false)

		return
	end)()
	setActive(self._tf:Find("Right/Panel/Container/Types"), #self.activeFurnitureTypes > 1)
	UIItemList.StaticAlign(self._tf:Find("Right/Panel/Container/Types"), self._tf:Find("Right/Panel/Container/Types"):GetChild(0), #self.activeFurnitureTypes, function(arg_56_0, arg_56_1, arg_56_2)
		if arg_56_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_56_1 = arg_56_1 + 1

		local var_56_0 = self.activeFurnitureTypes[arg_56_1]

		setActive(arg_56_2:Find("Selected"), self.furnitureType == self.activeFurnitureTypes[arg_56_1])
		setActive(arg_56_2:Find("New"), (_.any(var_50_0:GetSlots(), function(arg_57_0)
			return _.any(var_50_1, function(arg_58_0)
				if arg_58_0:GetType() ~= var_56_0 then
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

	self.furnitureItems = {}

	self.furnitureScroll:SetTotalCount(#self.displayFurnitures)
	setActive(self.furnitureEmpty, #self.displayFurnitures == 0)

	if self.timerRefreshShop then
		self.timerRefreshShop:Stop()
	end

	self.timerRefreshShop = Timer.New(function()
		table.Foreach(self.furnitureItems, function(arg_60_0, arg_60_1)
			self:UpdateViewFurnitureItem(arg_60_0)

			return
		end)

		return
	end, 1, -1)

	self.timerRefreshShop:Start()

	local var_50_2 = {}
	local var_50_3 = self.furnitureType
	local var_50_4 = _.select(_.reduce({
		var_50_0,
		unpack(self.globalZones)
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

	if self.selectSlotId then
		local var_50_5 = Dorm3dFurnitureSlot.New({
			configId = self.selectSlotId
		})

		if (var_50_5:GetType() == Dorm3dFurniture.TYPE.DECORATION or var_50_5:GetType() == Dorm3dFurniture.TYPE.SPECIAL) and _.detect(self.room:GetFurnitures(), function(arg_64_0)
			return arg_64_0:GetSlotID() == var_50_5:GetConfigID()
		end) then
			self:CleanSlot()
		end
	end

	if not false then
		self.labelSettings = nil
	end

	setActive(self.lableTrans, false)
	self.scene:DisplayFurnitureSlots(_.map(var_50_4, function(arg_65_0)
		return arg_65_0:GetConfigID()
	end))
	self.scene:UpdateDisplaySlots(var_50_2)
	self.scene:RefreshSlots(self.room)

	return
end

function Dorm3dFurnitureSelectLayer:UpdateViewFurnitureItem(arg_66_1)
	local var_66_0 = self.displayFurnitures[arg_66_1]

	if not self.furnitureItems[arg_66_1] then
		return
	end

	local var_66_1 = tf(self.furnitureItems[arg_66_1])

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
	setActive(var_66_1:Find("Selected"), self.selectFurnitureId == var_66_0.id)
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
		local var_66_5

		if var_66_4 <= pg.TimeMgr.GetInstance():GetServerTime() then
			var_66_5 = false

			goto label_66_0
		end
	end

	var_66_5 = true

	::label_66_0::

	setActive(var_66_1:Find("TimeLimit"), var_66_5)

	if var_66_5 then
		setText(var_66_1:Find("TimeLimit/Text"), skinCommdityTimeStamp(var_66_4))
	end

	onButton(self, var_66_1:Find("Item/Tip"), function()
		self:emit(Dorm3dFurnitureSelectMediator.SHOW_FURNITURE_ACESSES, {
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

	onButton(self, var_66_1, function()
		if var_66_0.count > 0 then
			setActive(var_66_1:Find("Item/New"), false)

			var_66_0.viewedFlag = true
		end

		local var_68_0 = var_66_0.template:GetTargetSlotID()

		self.selectSlotId = nil

		if var_66_0.useable > 0 then
			self.room:ReplaceFurniture(var_68_0, var_66_0.id)
			table.insert(self.replaceFurnitures, {
				slotId = var_68_0,
				furnitureId = var_66_0.id
			})
			self:UpdateDataDisplayFurnitures()
			self:UpdateView()
			pg.CriMgr.GetInstance():PlaySE_V3("ui-dorm_furniture_placement")
		elseif var_66_0.useable < var_66_0.count then
			self.selectSlotId = var_68_0

			self:UpdateView()
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

		onButton(self, var_66_1:Find("GO"), function()
			self:emit(Dorm3dFurnitureSelectMediator.SHOW_SHOPPING_CONFIRM_WINDOW, {
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

					self:emit(GAME.SHOPPING, {
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

function Dorm3dFurnitureSelectLayer:CleanSlot()
	if not self.selectSlotId then
		return
	end

	local var_71_0 = self.selectSlotId

	self.room:ReplaceFurniture(self.selectSlotId, 0)
	table.insert(self.replaceFurnitures, {
		furnitureId = 0,
		slotId = var_71_0
	})
	self:ResetSelectSetting()
	self:UpdateDataDisplayFurnitures()
	self:UpdateView()

	return
end

function Dorm3dFurnitureSelectLayer:OnReplaceFurnitureDone()
	self.replaceFurnitures = {}

	existCall(self.replaceFurnitureCallback)

	self.replaceFurnitureCallback = nil

	return
end

function Dorm3dFurnitureSelectLayer:OnReplaceFurnitureError()
	self.replaceFurnitureCallback = nil

	return
end

function Dorm3dFurnitureSelectLayer:AutoReplaceFurniture()
	_.each(self.normalZones[self.zoneIndex]:GetSlots(), function(arg_75_0)
		if arg_75_0:GetType() == Dorm3dFurniture.TYPE.FLOOR or arg_75_0:GetType() == Dorm3dFurniture.TYPE.WALLPAPER then
			return
		end

		local var_75_0 = self.room:GetFurnitures()
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

		self.room:ReplaceFurniture(arg_75_0:GetConfigID(), var_75_2[1]:GetConfigID())
		table.insert(self.replaceFurnitures, {
			slotId = arg_75_0:GetConfigID(),
			furnitureId = var_75_2[1]:GetConfigID()
		})

		return
	end)
	self:ResetSelectSetting()
	self:UpdateDataDisplayFurnitures()
	self:UpdateView()

	return
end

function Dorm3dFurnitureSelectLayer:ShowReplaceWindow(arg_80_1, arg_80_2)
	local var_80_0 = self.replaceFurnitures

	if #self.replaceFurnitures == 0 then
		return existCall(arg_80_1)
	end

	self:emit(Dorm3dFurnitureSelectMediator.SHOW_CONFIRM_WINDOW, {
		title = i18n("title_info"),
		content = i18n("dorm3d_furniture_sure_save"),
		onYes = function()
			self:emit(GAME.APARTMENT_REPLACE_FURNITURE, {
				roomId = self.room:GetConfigID(),
				furnitures = var_80_0
			})

			self.replaceFurnitureCallback = arg_80_1

			return
		end,
		onNo = arg_80_2
	})

	return
end

function Dorm3dFurnitureSelectLayer:onBackPressed()
	seriesAsync({
		function(arg_83_0)
			self:ShowReplaceWindow(arg_83_0, arg_83_0)

			return
		end,
		function(arg_84_0)
			GetOrAddComponent(self._tf, typeof(CanvasGroup)).alpha = 0

			self.scene:ExitFurnitureWatchMode(function()
				Dorm3dFurnitureSelectLayer.super.onBackPressed(self)

				return
			end)

			return
		end
	})

	return
end

function Dorm3dFurnitureSelectLayer:willExit()
	self.furnitureScroll.enabled = false

	if self.timerRefreshShop then
		self.timerRefreshShop:Stop()
	end

	UpdateBeat:RemoveListener(self.updateHandler)

	return
end

return Dorm3dFurnitureSelectLayer
