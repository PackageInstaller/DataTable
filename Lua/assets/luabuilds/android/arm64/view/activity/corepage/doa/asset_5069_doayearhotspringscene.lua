local DOAYearHotSpringScene = class("DOAYearHotSpringScene", import("view.base.BaseUI"))

function DOAYearHotSpringScene:getUIName()
	return "DOAYearHotSpringUI"
end

local var_0_1 = 0.85

function DOAYearHotSpringScene:init()
	self.scrollRect = self._tf:Find("ScrollRect")
	self.scrollContent = self.scrollRect:GetComponent(typeof(ScrollRect)).content
	self.slotTFs = _.map(_.range(4, 13), function(arg_3_0)
		return self.scrollRect:Find("Pool"):GetChild(arg_3_0 - 1)
	end)
	self.slotOriginalPos = _.map(self.slotTFs, function(arg_4_0)
		return arg_4_0.anchoredPosition
	end)
	self.slotShipPos = Clone(self.slotOriginalPos)

	table.Foreach(self:GetRecordPos(), function(arg_5_0, arg_5_1)
		self.slotShipPos[arg_5_0] = arg_5_1

		return
	end)

	self.poolItems = _.map(_.range(self.scrollRect:Find("Pool").childCount), function(arg_6_0)
		return self.scrollRect:Find("Pool"):GetChild(arg_6_0 - 1)
	end)

	Canvas.ForceUpdateCanvases()

	self.scrollBGs = _.map({
		{
			"1",
			0.5
		},
		{
			"2",
			0.6
		},
		{
			"3",
			var_0_1
		},
		{
			"Pool",
			var_0_1
		},
		{
			"4",
			1
		},
		{
			"5",
			1
		}
	}, function(arg_7_0)
		local var_7_0 = {
			self.scrollRect:Find(arg_7_0[1]),
			arg_7_0[2]
		}

		var_7_0[3] = var_7_0[1].anchoredPosition.x

		self:UpdateScrollContent(0, unpack(var_7_0))

		return var_7_0
	end)
	self.top = self._tf:Find("Top")

	pg.ViewUtils.SetSortingOrder(self._tf, 4)

	self.spineRoles = {}
	self.washMaterial = Material.New(pg.ShaderMgr.GetInstance():GetShader("M02/Unlit_Colored_Semitransparent"))

	self.washMaterial:SetFloat("_Height", 0.5)

	return
end

function DOAYearHotSpringScene:SetActivity(arg_8_1)
	self.activity = arg_8_1

	if not self.activity then
		return
	end

	table.Foreach(self.activity:GetShipIds(), function(arg_9_0, arg_9_1)
		if arg_9_1 > 0 then
			if (arg_8_1:GetShipIds()[arg_9_0] or 0) == 0 then
				self.slotShipPos[arg_9_0] = Clone(self.slotOriginalPos[arg_9_0])
			end
		end

		return
	end)

	return
end

function DOAYearHotSpringScene:didEnter()
	onButton(self, self._tf:Find("Top/Back"), function()
		self:closeView()

		return
	end, SOUND_BACK)
	onButton(self, self._tf:Find("Top/Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.hotspring_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("Top/Manage"), function()
		self:emit(DOAYearHotSpringMediator.OPEN_INFO)

		return
	end, SFX_PANEL)

	local var_10_0 = string.split(i18n("hotspring_buff"), "|")

	assert(var_10_0)
	onButton(self, self._tf:Find("Top/Buff"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideIconBG = true,
			type = MSGBOX_TYPE_DROP_ITEM,
			iconPath = {
				"UI/DOAYearHotSpringUI_atlas",
				"buff_hotspring"
			},
			name = var_10_0[1],
			content = var_10_0[2]
		})

		return
	end, SFX_PANEL)
	onScroll(self, self.scrollRect, function(arg_15_0)
		_.each(self.scrollBGs, function(arg_16_0)
			self:UpdateScrollContent(self.scrollContent.anchoredPosition.x, unpack(arg_16_0))

			return
		end)

		return
	end)
	self:InitSlots()
	self:UpdateView()

	self.timer = FrameTimer.New(function()
		local var_17_0 = _.map(_.range(self.scrollRect:Find("Pool").childCount), function(arg_18_0)
			return self.scrollRect:Find("Pool"):GetChild(arg_18_0 - 1)
		end)

		mergeSort(var_17_0, function(arg_19_0, arg_19_1)
			return arg_19_0.anchoredPosition.y >= arg_19_1.anchoredPosition.y
		end)
		table.Foreach(var_17_0, function(arg_20_0, arg_20_1)
			arg_20_1:SetSiblingIndex(arg_20_0 - 1)

			return
		end)

		return
	end, 1, -1)

	self.timer:Start()
	onNextTick(function()
		local var_21_0 = self.activity:GetSlotCount() + 1

		if var_21_0 <= #self.slotTFs then
			local var_21_1 = self.scrollRect:Find("Pool")
			local var_21_2 = math.clamp((var_21_1.anchoredPosition.x + self.slotTFs[var_21_0].anchoredPosition.x + var_21_1.rect.width * 0.5 - self.scrollRect.rect.width * 0.5) / var_0_1, 0, self.scrollContent.rect.width - self.scrollRect.rect.width)

			setAnchoredPosition(self.scrollContent, {
				x = var_21_2
			})
			_.each(self.scrollBGs, function(arg_22_0)
				self:UpdateScrollContent(-var_21_2, unpack(arg_22_0))

				return
			end)
		end

		return
	end)
	self:OverlayPanel(self.top)

	return
end

function DOAYearHotSpringScene:UpdateScrollContent(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	arg_23_1 = arg_23_1 * arg_23_3

	setAnchoredPosition(arg_23_2, {
		x = arg_23_1 + arg_23_4
	})

	return
end

function DOAYearHotSpringScene:InitSlots()
	self:CleanSpines()
	table.Foreach(self.slotTFs, function(arg_25_0, arg_25_1)
		onButton(self, arg_25_1:Find("Usable"), function()
			self:emit(DOAYearHotSpringMediator.UNLOCK_SLOT, self.activity.id)

			return
		end, SFX_PANEL)

		local function var_25_0()
			local var_27_0 = self.activity:GetShipIds()[arg_25_0] or 0

			self:emit(DOAYearHotSpringMediator.OPEN_CHUANWU, arg_25_0, var_27_0 > 0 and getProxy(BayProxy):RawGetShipById(var_27_0))

			return
		end

		onButton(self, arg_25_1:Find("Enter"), var_25_0, SFX_PANEL)
		onButton(self, arg_25_1:Find("Ship/Click"), function()
			if self._modelDrag then
				return
			end

			var_25_0()

			return
		end, SFX_PANEL)

		local var_25_1 = pg.UIMgr.GetInstance().uiCamera
		local var_25_2 = var_25_1:GetComponent(typeof(Camera))
		local var_25_3 = self.scrollRect:Find("Pool")
		local var_25_4 = GetComponent(arg_25_1:Find("Ship/Click"), "EventTriggerListener")

		var_25_4.AddBeginDragFunc(var_25_1, function()
			if self._modelDrag then
				return
			end

			self._modelDrag = arg_25_1
			self._currentDragDelegate = var_25_4
			self._lastDragBeginPosition = arg_25_1.anchoredPosition

			setParent(arg_25_1, self._tf)
			self.spineRoles[arg_25_0]:RevertMaterial()
			self.spineRoles[arg_25_0]:SetAction("tuozhuai")
			setActive(arg_25_1:Find("wenquan_bowen"), false)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_HOME_DRAG)

			return
		end)
		var_25_4:AddDragFunc(function(arg_30_0, arg_30_1)
			if self._modelDrag ~= arg_25_1 then
				return
			end

			arg_25_1.anchoredPosition = LuaHelper.ScreenToLocal(self._tf, arg_30_1.position, var_25_2)

			return
		end)
		var_25_4:AddDragEndFunc(function(arg_31_0, arg_31_1)
			if self._modelDrag ~= arg_25_1 then
				return
			end

			self._modelDrag = false
			self._forceDropCharacter = nil
			self._currentDragDelegate = nil

			setParent(arg_25_1, var_25_3, true)

			if self._forceDropCharacter then
				(function()
					if self._lastDragBeginPosition ~= nil then
						arg_25_1.anchoredPosition = self._lastDragBeginPosition
					end

					return
				end)()

				return
			end

			local var_31_0 = var_25_3.rect

			var_31_0.center = var_25_3.rect.center + Vector2.New(-var_25_3.rect.size.x * 0.5)

			local var_31_1 = arg_25_1.anchoredPosition

			if not var_31_0:Contains(arg_25_1.anchoredPosition) then
				var_31_1 = Vector2.Min(Vector2.Max(var_31_1, var_31_0.min), var_31_0.max)
				arg_25_1.anchoredPosition = var_31_1
			end

			self.slotShipPos[arg_25_0] = var_31_1

			self:SetSpineWash(self.spineRoles[arg_25_0])
			setActive(arg_25_1:Find("wenquan_bowen"), true)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_HOME_PUT)

			return
		end)

		return
	end)

	return
end

function DOAYearHotSpringScene:UpdateView()
	self:UpdateSlots()
	setText(self.top:Find("Ticket/Text"), self.activity:GetCoins())

	return
end

function DOAYearHotSpringScene:UpdateSlots()
	self:CleanSpines()
	table.Foreach(self.slotTFs, function(arg_35_0, arg_35_1)
		self:UpdateSlot(arg_35_0, arg_35_1)

		return
	end)

	return
end

function DOAYearHotSpringScene:RectContainsRect(arg_36_1)
	return self:Contains(arg_36_1.min) and self:Contains(arg_36_1.max)
end

function DOAYearHotSpringScene:UpdateSlot(arg_37_1, arg_37_2)
	local var_37_0 = math.clamp(arg_37_1 - self.activity:GetSlotCount(), 0, 2)

	setActive(arg_37_2:Find("Lock"), var_37_0 == 2)
	setActive(arg_37_2:Find("Usable"), var_37_0 == 1)

	local var_37_1 = self.activity:GetShipIds()[arg_37_1] or 0
	local var_37_2 = var_37_0 == 0
	local var_37_3 = var_37_1 > 0 and getProxy(BayProxy):RawGetShipById(var_37_1)
	local var_37_4 = arg_37_2:Find("Ship")

	setActive(arg_37_2:Find("Enter"), var_37_2 and not var_37_3)
	setActive(var_37_4, var_37_2 and var_37_3 and true)
	setAnchoredPosition(arg_37_2, ((var_37_3 or nil) and (self.slotShipPos or self.slotOriginalPos))[arg_37_1])

	if var_37_3 then
		local var_37_5 = SpineRole.New()

		var_37_5:SetData(var_37_3:getPrefab())
		self:LoadingOn()
		var_37_5:Load(function()
			var_37_5:SetParent(var_37_4:Find("Model"))
			self:SetSpineWash(var_37_5)
			self:LoadingOff()

			return
		end, true)

		self.spineRoles[arg_37_1] = var_37_5
	end

	return
end

function DOAYearHotSpringScene:SetSpineWash(arg_39_1)
	arg_39_1:SetAction("wash")
	arg_39_1:ChangeMaterial(Object.Instantiate(self.washMaterial))
	arg_39_1:GetSkeletonGraphic().material:SetFloat("_PositionY", arg_39_1:GetRoleModel().transform.position.y + 1.5)

	return
end

function DOAYearHotSpringScene:CleanSpines()
	self:ForceDropChar()
	table.Foreach(self.spineRoles, function(arg_41_0, arg_41_1)
		arg_41_1:Dispose()

		return
	end)

	self.spineRoles = {}

	return
end

function DOAYearHotSpringScene:ForceDropChar()
	if self._currentDragDelegate then
		self._forceDropCharacter = true

		LuaHelper.triggerEndDrag(self._currentDragDelegate)
	end

	return
end

function DOAYearHotSpringScene:GetRecordPos()
	local var_43_0 = _.map(string.split(PlayerPrefs.GetString("hotspring_ship_pos", ""), ";"), function(arg_44_0)
		return tonumber(arg_44_0)
	end)
	local var_43_1 = {}

	for iter_43_0 = 1, #var_43_0, 2 do
		table.insert(var_43_1, Vector2.New(var_43_0[iter_43_0], var_43_0[iter_43_0 + 1]))
	end

	return var_43_1
end

function DOAYearHotSpringScene:RecordPos(arg_45_1)
	if not arg_45_1 then
		return
	end

	PlayerPrefs.SetString("hotspring_ship_pos", (table.concat(_.reduce(arg_45_1, {}, function(arg_46_0, arg_46_1)
		table.insert(arg_46_0, arg_46_1.x)
		table.insert(arg_46_0, arg_46_1.y)

		return arg_46_0
	end), ";")))

	return
end

function DOAYearHotSpringScene:LoadingOn()
	if self.animating then
		return
	end

	self.animating = true

	pg.UIMgr.GetInstance():LoadingOn(false)

	return
end

function DOAYearHotSpringScene:LoadingOff()
	if not self.animating then
		return
	end

	pg.UIMgr.GetInstance():LoadingOff()

	self.animating = false

	return
end

function DOAYearHotSpringScene:willExit()
	self:UnOverlayPanel(self.top, self._tf)
	Object.Destroy(self.washMaterial)
	self:RecordPos(self.slotShipPos)
	self:CleanSpines()
	self.timer:Stop()
	self:LoadingOff()

	return
end

return DOAYearHotSpringScene
