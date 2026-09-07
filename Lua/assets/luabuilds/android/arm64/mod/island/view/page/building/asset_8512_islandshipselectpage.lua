local IslandShipSelectPage = class("IslandShipSelectPage", import("...base.IslandBasePage"))

function IslandShipSelectPage:getUIName()
	return "IslandShipSelectUI"
end

function IslandShipSelectPage:OnLoaded()
	self.backBtn = self._tf:Find("top/back")
	self.title = self._tf:Find("top/title/Text")

	setText(self.title, i18n("island_select_ship"))

	self.frameTF = self._tf:Find("frame")
	self.shipRectCom = self.frameTF:Find("ships"):GetComponent("LScrollRect")

	setText(self.frameTF:Find("selected/Text"), i18n("island_select_ship_label_1"))

	self.selectedTextCom = self.frameTF:Find("selected/num"):GetComponent("Text")
	self.benefitsTF = self._tf:Find("benefits")
	self.benefitTipBtn = self.benefitsTF:Find("tip/help")

	setText(self.benefitsTF:Find("tip/Text"), i18n("island_select_ship_overview"))

	self.mainAttrBar = self.benefitsTF:Find("main/slider/bar")

	setText(self.benefitsTF:Find("main/Text"), IslandShipAttr.ATTRS_CH[IslandShipAttr.MANAGE_KEY])

	self.subAttrUIList = UIItemList.New(self.benefitsTF:Find("subs"), self.benefitsTF:Find("subs/tpl"))
	self.infoEmptyTF = self._tf:Find("info/empty")

	setText(self.infoEmptyTF:Find("Image/Text"), i18n("island_select_ship"))

	self.infoEmptyTitleTF = self.infoEmptyTF:Find("name")
	self.infoPanel = self._tf:Find("info/content")
	self.nameTF = self.infoPanel:Find("name")
	self.levelTF = self.infoPanel:Find("name/level")
	self.attrUIList = UIItemList.New(self.infoPanel:Find("attrs"), self.infoPanel:Find("attrs/tpl"))
	self.skillTF = self.infoPanel:Find("skill")
	self.energyTFInfo = self.infoPanel:Find("selectShipEnergyInfo")
	self.energyTF = self.energyTFInfo:Find("energy")
	self.energyCostSilderTF = self.energyTF:Find("energy_bar_cost")
	self.giftBtn = self.energyTFInfo:Find("gift")
	self.statusTF = self.infoPanel:Find("status")
	self.sureBtn = self._tf:Find("sure")

	setText(self.sureBtn:Find("Text"), i18n("island_shipselect_confirm"))

	self.indexBtn = self._tf:Find("frame/filter_panel/IndexIco")
	self.orderBtn = self._tf:Find("frame/filter_panel/index")
	self.orderIco = self._tf:Find("frame/filter_panel/index/content/icon/icon")
	self.orderTxt = self._tf:Find("frame/filter_panel/index/content/Text"):GetComponent(typeof(Text))
	self.shipIconTF = self.energyTFInfo:Find("icon_mask/icon")
	self.energyTimeTextTf = self.energyTFInfo:Find("time_Text")
	self.recoveryTimeTips = self.infoPanel:Find("selectShipEnergyInfo/recoveryTimeTips")
	self.skill = self.infoPanel:Find("skill")
	self.skillEmp = self.infoPanel:Find("skillEmp")
	self.skillEmpDes = self.skillEmp:Find("Text")
	self.skillInuse = self.skill:Find("skill_tab_bg/iconBright")
	self.skillUnuse = self.skill:Find("skill_tab_bg/iconDark")
	self.skillName = self.skill:Find("name"):GetComponent(typeof(Text))
	self.skillDes = self.skill:Find("desc/Text"):GetComponent(typeof(Text))
	self.shipContent = self.frameTF:Find("ships")
	self.shipEmpty = self.frameTF:Find("empShip")
	self.addStutasTF = self._tf:Find("addStutas")
	self.energyStutasTF = self._tf:Find("energyStutas")
	self.energyStutasTFNum = self._tf:Find("energyStutas/num")
	self.addStutasNum = self._tf:Find("addStutas/num")
	self.addStutasBtn = self._tf:Find("addStutas/num/tipbtn")
	self.addStutasInfoPanel = self._tf:Find("addinfo_panel")
	self.buffInfoUIList = UIItemList.New(self.addStutasInfoPanel:Find("effects"), self.addStutasInfoPanel:Find("effects/tpl"))

	setText(self.addStutasInfoPanel:Find("Text"), i18n("island_production_speed_tip2"))

	self.buffInfoEmptyTF = self.addStutasInfoPanel:Find("empty")

	setText(self.buffInfoEmptyTF:Find("Text"), i18n("island_manage_no_addition"))
	self.buffInfoUIList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			setText(arg_3_2:Find("bg/name"), self.buffInfos[arg_3_1 + 1].name)
			setText(arg_3_2:Find("bg/effect"), self.buffInfos[arg_3_1 + 1].effect)
		end

		return
	end)
	setText(self.shipEmpty:Find("Text"), i18n("island_production_selected_tip2"))
	setText(self.recoveryTimeTips, i18n("island_ship_energy_recoverytips"))

	return
end

function IslandShipSelectPage:AddListeners()
	self:AddListener(GAME.ISLAND_FOLLOWER_OP_DONE, self.OnFollowerOp)
	self:AddListener(GAME.ISLAND_GIVE_GIFT_DONE, self.OnUseItem)

	return
end

function IslandShipSelectPage:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_FOLLOWER_OP_DONE, self.OnFollowerOp)
	self:RemoveListener(GAME.ISLAND_GIVE_GIFT_DONE, self.OnUseItem)

	return
end

function IslandShipSelectPage:OnUseItem()
	self:ClosePage(IslandShipStatusBox)
	self:FlushInfo()

	return
end

function IslandShipSelectPage:OnFollowerOp(arg_7_1)
	for iter_7_0, iter_7_1 in pairs(self.cards) do
		if iter_7_1.id == arg_7_1 then
			iter_7_1:UpdateFollowMask()
		end
	end

	return
end

function IslandShipSelectPage:OnInit()
	onButton(self, self.backBtn, function()
		self:Hide()
		existCall(self.cancelFunc)

		return
	end, SFX_PANEL)
	onButton(self, self.addStutasBtn, function()
		if isActive(self.addStutasInfoPanel) then
			setActive(self.addStutasInfoPanel, false)
		else
			setActive(self.addStutasInfoPanel, true)
			self.buffInfoUIList:align(#self.buffInfos)
			setActive(self.buffInfoEmptyTF, #self.buffInfos == 0)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.sureBtn, function()
		local var_11_0 = getProxy(IslandProxy):GetIsland():GetFollowerAgency()
		local var_11_1 = {}

		for iter_11_0, iter_11_1 in ipairs(self.selectedIds) do
			if var_11_0:Following(iter_11_1) then
				table.insert(var_11_1, iter_11_1)
			end
		end

		if #var_11_1 > 0 then
			self:ShowMsgBox({
				type = IslandMsgBox.TYPE_COMMON,
				content = i18n("island_cancel_follow_tip"),
				onYes = function()
					local var_12_0 = {}

					for iter_12_0, iter_12_1 in ipairs(var_11_1) do
						table.insert(var_12_0, function(arg_13_0)
							self:emit(IslandMediator.DEL_FOLLOWER, iter_12_1, arg_13_0)

							return
						end)
					end

					seriesAsync(var_12_0, function()
						self:Hide()
						existCall(self.confirmFunc, self.selectedIds)

						return
					end)

					return
				end
			})

			return
		end

		self:Hide()
		existCall(self.confirmFunc, self.selectedIds)

		return
	end, SFX_PANEL)
	onToggle(self, self.indexBtn, function(arg_15_0)
		if arg_15_0 then
			self:emit(IslandMediator.OPEN_SHIP_INDEX, {
				OnFilter = function(arg_16_0)
					self:OnFilter(arg_16_0)

					return
				end,
				defaultIndex = self.sortData,
				needWorkSpeed = self.needWorkSpeed
			})
		end

		return
	end, SFX_PANEL)
	onButton(self, self.orderBtn, function()
		self.selectAsc = not self.selectAsc

		self:UpdateSortBtn()
		self:FlushShips()

		return
	end, SFX_PANEL)
	onButton(self, self.benefitTipBtn, function()
		self:ShowMsgBox({
			hideNo = true,
			type = IslandMsgBox.TYPE_COMMON,
			content = i18n("island_manage_help_tip")
		})

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("top/title/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.island_help_commission.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.giftBtn, function()
		if not self.showId or self.showId == IslandCharacterAgency.NPC_CONFIG_ID then
			return
		end

		self:OpenPage(IslandShipStatusBox, self.showId)

		return
	end, SFX_PANEL)
	self.subAttrUIList:make(function(arg_21_0, arg_21_1, arg_21_2)
		if arg_21_0 == UIItemList.EventInit then
			arg_21_2.name = IslandShipAttr.ATTRS[arg_21_1 + 1]

			setText(arg_21_2:Find("Text"), IslandShipAttr.ToChinese(IslandShipAttr.ATTRS[arg_21_1 + 1]))
		elseif arg_21_0 == UIItemList.EventUpdate then
			setFillAmount(arg_21_2:Find("slider/bar"), self:GetShipsAttrProgress(IslandShipAttr.ATTRS[arg_21_1 + 1]))
		end

		return
	end)

	function self.shipRectCom.onInitItem(arg_22_0)
		self:OnInitShip(arg_22_0)

		return
	end

	function self.shipRectCom.onUpdateItem(arg_23_0, arg_23_1)
		self:OnUpdateShip(arg_23_0, arg_23_1)

		return
	end

	self.cards = {}
	self.selectAsc = true
	self.sortData = {
		sortIndex = IslandShipIndexLayer.SortLevel,
		campIndex = ShipIndexConst.CampAll,
		rarityIndex = ShipIndexConst.RarityAll,
		extraIndex = IslandShipIndexLayer.ExtraALL
	}

	self:UpdateSortBtn()

	self.timeMgr = pg.TimeMgr.GetInstance()

	return
end

function IslandShipSelectPage:OnFilter(arg_24_1)
	self.sortData = arg_24_1

	self:UpdateSortBtn()
	self:FlushShips()

	return
end

function IslandShipSelectPage:UpdateSortBtn()
	self.orderIco.localScale = self.selectAsc and Vector3(1, 1, 1) or Vector3(1, -1, 1)

	local var_25_0, var_25_1 = IslandShipIndexLayer.getSortFuncAndName(self.sortData.sortIndex, self.selectAsc)

	self.orderTxt.text = i18n(var_25_1)

	return
end

function IslandShipSelectPage:UpdateAttrs(arg_26_1)
	local var_26_0 = IslandShipAttr.ATTRS

	self.attrUIList:make(function(arg_27_0, arg_27_1, arg_27_2)
		if arg_27_0 == UIItemList.EventUpdate then
			self:UpdateAttr(arg_27_2, var_26_0, arg_27_1 + 1, arg_26_1)
		end

		return
	end)
	self.attrUIList:align(#IslandShipAttr.ATTRS)

	return
end

function IslandShipSelectPage:UpdateAttr(arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	local var_28_0 = arg_28_4:GetAttr(arg_28_2[arg_28_3])

	setText(arg_28_1:Find("name"), IslandShipAttr.ToChinese(arg_28_2[arg_28_3]))

	local var_28_1 = IslandProductTimeHelper.GetAttributeAddPercentByAttribute(arg_28_4.id, arg_28_3)

	setTextColor(arg_28_1:Find("value"), Color.NewHex(var_28_1 > 0 and "#00B91E" or var_28_1 < 0 and "#FF6767" or "#393A3C"))

	local var_28_3 = var_28_1 ~= 0 and math.floor(var_28_0 * (1 + 0.01 * var_28_1)) or var_28_0

	setText(arg_28_1:Find("value"), var_28_3)

	if var_28_1 ~= 0 then
		local var_28_4 = _.select(arg_28_4:GetDisplayStatus(), function(arg_29_0)
			return arg_29_0:GetBuffType() == IslandBuffType.SHIP_ATTR
		end)

		onButton(self, arg_28_1, function()
			self:ShowMsgBox({
				hideNo = true,
				type = IslandMsgBox.TYPE_SHIP_OWN_STATUS,
				title = i18n("island_word_ship_buff_desc"),
				statusList = var_28_4
			})

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_28_1)
	end

	local var_28_5 = IslandShipAttr.Grade2Img((arg_28_4:GetAttrGradeByValue(var_28_3)))

	arg_28_1:Find("grade"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/IslandShipUI_atlas", var_28_5[1])
	arg_28_1:Find("grade_bg"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/IslandShipUI_atlas", var_28_5[2])

	setActive(arg_28_1:Find("vx_tpl"), self.attrType == arg_28_3)

	return
end

function IslandShipSelectPage:OnShow(arg_31_1)
	self:BlurPanel()

	self.showType = arg_31_1.showType or IslandSelectShipCard.SHOW_TYPE.PLACE
	self.selectNum = arg_31_1.selectNum or 1
	self.selectedIds = arg_31_1.selectedIds or {}
	self.attrType = arg_31_1.attrType
	self.confirmFunc = arg_31_1.confirmFunc
	self.cancelFunc = arg_31_1.cancelFunc
	self.placeId = arg_31_1.placeId
	self.restId = arg_31_1.restId
	self.showBenefits = arg_31_1.showBenefits
	self.needWorkSpeed = arg_31_1.needWorkSpeed or false
	self.autoCollectionSelectShip = arg_31_1.autoCollectionSelectShip

	setText(self.infoEmptyTitleTF, arg_31_1.emptyInfoTitle or "")

	self.energyCost = arg_31_1.energyCost or 0
	self.characterAgency = getProxy(IslandProxy):GetIsland():GetCharacterAgency()
	self.sortData.sortIndex = self.needWorkSpeed and IslandShipIndexLayer.SortWorkSpeed or IslandShipIndexLayer.SortLevel

	self:UpdateSortBtn()
	self:FlushShips(#self.selectedIds == 0 and self.selectNum == 1)

	return
end

function IslandShipSelectPage:CheckHasSelected(arg_32_1)
	if not self.autoCollectionSelectShip then
		return false
	end

	local var_32_0 = false

	for iter_32_0, iter_32_1 in pairs(self.autoCollectionSelectShip) do
		if arg_32_1 == iter_32_1 then
			var_32_0 = true
		end
	end

	return var_32_0
end

function IslandShipSelectPage:OnInitShip(arg_33_1)
	self.cards[arg_33_1] = IslandSelectShipCard.New(arg_33_1)

	return
end

function IslandShipSelectPage:OnUpdateShip(arg_34_1, arg_34_2)
	local var_34_0 = self.cards[arg_34_2]

	if not self.cards[arg_34_2] then
		self:OnInitItem(arg_34_2)

		var_34_0 = self.cards[arg_34_2]
	end

	local var_34_1 = self.showShips[arg_34_1 + 1]
	local var_34_2 = self.characterAgency:GetShipById(self.showShips[arg_34_1 + 1])

	onButton(self, var_34_0.go, function()
		if self:CheckHasSelected(var_34_1) then
			return
		end

		if getProxy(IslandProxy):GetIsland():GetFollowerAgency():Following(var_34_1) then
			self:ShowMsgBox({
				content = i18n("island_cancel_follow_tip"),
				onYes = function()
					self:emit(IslandMediator.DEL_FOLLOWER, var_34_1)

					return
				end
			})

			return
		end

		if not var_34_2:IsDelegable() then
			return
		end

		if self.showId == var_34_0.id then
			self.showId = nil
		else
			self.showId = var_34_0.id
		end

		if table.contains(self.selectedIds, var_34_0.id) then
			table.removebyvalue(self.selectedIds, var_34_0.id)
		elseif self.selectNum == 1 then
			self.selectedIds = {
				var_34_0.id
			}
		else
			if #self.selectedIds >= self.selectNum then
				return
			end

			table.insert(self.selectedIds, var_34_0.id)
		end

		for iter_35_0, iter_35_1 in pairs(self.cards) do
			iter_35_1:UpdateSelected(self.selectedIds)
		end

		self:FlushInfo()

		return
	end, SFX_PANEL)

	if self.showType == IslandSelectShipCard.SHOW_TYPE.PLACE then
		var_34_0:Update(self.showType, var_34_1, self.attrType, self.placeId, self.selectedIds, self.autoCollectionSelectShip)
	elseif self.showType == IslandSelectShipCard.SHOW_TYPE.RESTAURANT then
		var_34_0:Update(self.showType, var_34_1, self.attrType, self.restId, self.selectedIds, self.autoCollectionSelectShip)
	end

	return
end

function IslandShipSelectPage:FlushShips(arg_37_1)
	self.showShips = self:GetShips()

	if #self.showShips ~= 0 and arg_37_1 then
		local var_37_0 = self:GetFristSelectableShipId()

		if var_37_0 then
			self.showId = var_37_0

			table.insert(self.selectedIds, var_37_0)
		end
	end

	self.showId = self.selectedIds[1]

	setActive(self.shipContent, #self.showShips ~= 0)
	setActive(self.shipEmpty, #self.showShips == 0)
	self.shipRectCom:SetTotalCount(#self.showShips)
	self:FlushInfo()

	return
end

function IslandShipSelectPage:GetFristSelectableShipId()
	for iter_38_0, iter_38_1 in ipairs(self.showShips) do
		if self.characterAgency:GetShipById(iter_38_1):GetState() == IslandShip.STATE_NORMAL and not self:CheckHasSelected(iter_38_1) then
			return iter_38_1
		end
	end

	return nilGetShipsAttrProgress
end

function IslandShipSelectPage:UpdateTimer(arg_39_1)
	setText(self.energyTimeTextTf, self.timeMgr:DescCDTime(arg_39_1 - self.timeMgr:GetServerTime()))

	return
end

function IslandShipSelectPage:StopTimer()
	if self.energyTimer ~= nil then
		self.energyTimer:Stop()

		self.energyTimer = nil
	end

	return
end

function IslandShipSelectPage:FlushInfo()
	self.selectedTextCom.text = #self.selectedIds .. "/" .. self.selectNum

	self:FlushBenefits()
	setActive(self.sureBtn, self.showId)
	setActive(self.infoPanel, self.showId)
	setActive(self.infoEmptyTF, not self.showId)
	self:FlushAddPercent()
	self:FlushEnergyPercent()

	if not self.showId then
		return
	end

	setActive(self.giftBtn, self.showId ~= IslandCharacterAgency.NPC_CONFIG_ID)

	local var_41_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(self.showId)

	setText(self.nameTF, var_41_0:GetName())
	setText(self.levelTF, string.format("-Lv.%d", var_41_0:GetLevel()))
	self:UpdateAttrs(var_41_0)
	GetImageSpriteFromAtlasAsync("ShipYardIcon/" .. IslandShip.StaticGetPrefab(var_41_0.id), "", self.shipIconTF)

	local var_41_1 = var_41_0:GetCurrentEnergy()
	local var_41_2 = var_41_0:GetMaxEnergy()

	setText(self.energyTF:Find("text"), var_41_1 .. "/" .. var_41_2)
	setSlider(self.energyTF:Find("energy_bar"), 0, 1, var_41_1 / var_41_2)

	if var_41_1 ~= var_41_2 then
		setActive(self.recoveryTimeTips, true)
		setActive(self.energyTimeTextTf, true)

		local var_41_3 = var_41_0:GetEnergyMaxTime()

		self:StopTimer()
		self:UpdateTimer(var_41_3)

		self.energyTimer = Timer.New(function()
			self:UpdateTimer(var_41_3)

			return
		end, 1, -1)

		self.energyTimer:Start()
	else
		self:StopTimer()
		setActive(self.recoveryTimeTips, false)
		setActive(self.energyTimeTextTf, false)
	end

	local var_41_4 = var_41_0:GetSkill()
	local var_41_5 = var_41_4:IsUnlock()

	setActive(self.skill, var_41_5)
	setActive(self.skillEmp, not var_41_5)
	setText(self.skillEmpDes, i18n("island_need_star", var_41_0:GetSkillUnlockLevel()))

	local var_41_6 = var_41_5 and IslandSelectShipCard.GetSkillEffective(var_41_0, self.showType, (self.showType == IslandSelectShipCard.SHOW_TYPE.PLACE or nil) and (self.placeId or self.restId))

	setActive(self.skillInuse, var_41_6)
	setActive(self.skillUnuse, not var_41_6)

	self.skillName.text = string.format("%s - %s", var_41_4:GetName(), "[Lv." .. var_41_4:GetLevel() .. "]")
	self.skillDes.text = var_41_4:GetEffectDesc()

	self:FlushAddPercent()
	self:FlushEnergyPercent()
	self:FlushEnergyCostAnim(var_41_0)

	return
end

function IslandShipSelectPage:FlushEnergyCostAnim(arg_43_1)
	self:StopCostTimer()

	local var_43_0 = self.energyCost ~= 0 and self.showType == IslandSelectShipCard.SHOW_TYPE.PLACE

	setActive(self.energyCostSilderTF, self.energyCost ~= 0 and self.showType == IslandSelectShipCard.SHOW_TYPE.PLACE)

	if not var_43_0 then
		return
	end

	if arg_43_1.id == IslandCharacterAgency.NPC_CONFIG_ID then
		local var_43_1 = arg_43_1:GetCurrentEnergy()
		local var_43_2 = arg_43_1:GetMaxEnergy()

		setActive(self.energyCostSilderTF, false)
		setSlider(self.energyTF:Find("energy_bar"), 0, 1, var_43_1 / var_43_2)
		setText(self.energyTF:Find("text"), string.format("%d-<color=#fadfb6>%d</color>/%d", var_43_1, 0, var_43_2))

		return
	end

	local var_43_3 = math.max(math.floor(self.energyCost * (1 - IslandProductCostHelper.GetReducePercentInPlace(arg_43_1.id, self.placeId))), 1)

	self.energyCostTimer = Timer.New(function()
		local var_44_0 = arg_43_1:GetCurrentEnergy()
		local var_44_1 = arg_43_1:GetMaxEnergy()

		setSlider(self.energyTF:Find("energy_bar"), 0, 1, (var_44_0 - var_43_3) / var_44_1)
		setSlider(self.energyCostSilderTF, 0, 1, var_44_0 / var_44_1)
		setText(self.energyTF:Find("text"), string.format("%d-<color=#fadfb6>%d</color>/%d", var_44_0, var_43_3, var_44_1))

		return
	end, 1, -1)

	self.energyCostTimer:Start()
	self.energyCostTimer.func()

	return
end

function IslandShipSelectPage:FlushEnergyPercent()
	if not self.showId or not self.autoCollectionSelectShip then
		setActive(self.energyStutasTF, false)

		return
	end

	setActive(self.energyStutasTF, true)
	setText(self.energyStutasTFNum, i18n("island_chara_gather_skill_effect") .. string.format("<color=#39bfff> -%d%%</color>", (IslandAutoCollectHelper.GetAttributeReducePercent(self.showId))))

	return
end

function IslandShipSelectPage:FlushAddPercent()
	if not self.showId or not self.needWorkSpeed then
		setActive(self.addStutasTF, false)
		setActive(self.addStutasInfoPanel, false)

		return
	end

	local var_46_0, var_46_1, var_46_2, var_46_3 = IslandProductTimeHelper.GetAllAddPercent(self.showId, self.placeId, self.attrType)

	setActive(self.addStutasTF, true)
	setText(self.addStutasNum, i18n("island_production_speed_tip1", var_46_0 + var_46_1 + var_46_2 + var_46_3))

	self.buffInfos = {}

	local var_46_4 = IslandProductTimeHelper.GetAttributeAddPercent(self.showId, self.attrType)

	if var_46_0 > 0 then
		table.insert(self.buffInfos, {
			name = i18n("island_production_speed_addition1", IslandShipAttr.ToChinese((IslandShipAttr.GetAtrrName(self.attrType)))),
			effect = "+" .. var_46_0 .. "%"
		})
	end

	if var_46_1 > 0 then
		table.insert(self.buffInfos, {
			name = i18n("island_production_speed_addition2"),
			effect = "+" .. var_46_1 .. "%"
		})
	end

	if var_46_2 > 0 then
		table.insert(self.buffInfos, {
			name = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(self.showId):GetSkill():GetName(),
			effect = "+" .. var_46_2 .. "%"
		})
	end

	if var_46_3 > 0 then
		table.insert(self.buffInfos, {
			name = i18n("island_production_speed_addition3"),
			effect = "+" .. var_46_3 .. "%"
		})
	end

	self.buffInfoUIList:align(#self.buffInfos)
	setActive(self.buffInfoEmptyTF, #self.buffInfos == 0)

	return
end

function IslandShipSelectPage:FlushBenefits()
	setActive(self.benefitsTF, self.showBenefits)

	if self.showBenefits then
		setFillAmount(self.mainAttrBar, self:GetShipsAttrProgress(IslandShipAttr.ATTRS[1]))
		self.subAttrUIList:align(#IslandShipAttr.ATTRS)
	end

	return
end

function IslandShipSelectPage:GetShipsAttrProgress(arg_48_1)
	local var_48_0 = 0

	for iter_48_0, iter_48_1 in ipairs(self.selectedIds) do
		var_48_0 = var_48_0 + (pg.island_chara_att.all[#pg.island_chara_att.all] - self.characterAgency:GetShipById(iter_48_1):GetAttrGrade(arg_48_1) + 1)
	end

	return var_48_0 / (pg.island_chara_att.all[#pg.island_chara_att.all] * self.selectNum)
end

function IslandShipSelectPage:ToVShip(arg_49_1)
	if not self.vship then
		self.vship = {}

		function self.vship.getNation()
			return self.vship.config.nationality
		end

		function self.vship.getShipType()
			return self.vship.config.type
		end

		function self.vship.getTeamType()
			return ShipType.GetTeamFromShipType(self.vship.config.type)
		end

		function self.vship.getRarity()
			return self.vship.config.rarity
		end
	end

	self.vship.config = arg_49_1

	return self.vship
end

local function var_0_1(arg_54_0, arg_54_1)
	if not arg_54_1 or arg_54_1 == "" then
		return true
	end

	return string.find(string.lower((IslandShip.StaticGetName(arg_54_0))), (string.lower(string.gsub(arg_54_1, "%.", "%%."))))
end

local function var_0_2(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = arg_55_0:ToVShip((ShipGroup.getDefaultShipConfig(arg_55_1)))

	if ShipIndexConst.filterByCamp(var_55_0, arg_55_2.campIndex) and ShipIndexConst.filterByRarity(var_55_0, arg_55_2.rarityIndex) and IslandShipIndexLayer.filterByExtra(arg_55_0.characterAgency:GetShipById(arg_55_1), arg_55_2.extraIndex) then
		return true
	end

	return false
end

function IslandShipSelectPage:GetShips()
	local var_56_0 = {}
	local var_56_1 = {}

	for iter_56_0, iter_56_1 in ipairs((self.characterAgency:GetShipsContainNpc())) do
		if var_0_1(iter_56_1.id, self.searchKey) and var_0_2(self, iter_56_1.id, self.sortData) then
			if self.needWorkSpeed then
				table.insert(var_56_1, (setmetatable({
					GetWorkSpeed = function()
						local var_57_0, var_57_1, var_57_2, var_57_3 = IslandProductTimeHelper.GetAllAddPercent(iter_56_1.id, self.placeId, self.attrType)

						return var_57_0 + var_57_1 + var_57_2 + var_57_3
					end
				}, {
					__index = iter_56_1
				})))
			elseif self.autoCollectionSelectShip then
				if iter_56_1.id ~= 1 then
					table.insert(var_56_1, iter_56_1)
				end
			else
				table.insert(var_56_1, iter_56_1)
			end
		end
	end

	table.sort(var_56_1, CompareFuncs((IslandShipIndexLayer.getSortFuncAndName(self.sortData.sortIndex, self.selectAsc))))

	for iter_56_2, iter_56_3 in ipairs(var_56_1) do
		table.insert(var_56_0, iter_56_3.id)
	end

	return var_56_0
end

function IslandShipSelectPage:StopCostTimer()
	if self.energyCostTimer ~= nil then
		self.energyCostTimer:Stop()

		self.energyCostTimer = nil
	end

	return
end

function IslandShipSelectPage:OnDestroy()
	ClearLScrollrect(self.shipRectCom)
	self:StopTimer()
	self:StopCostTimer()
	self:OnHide()

	return
end

function IslandShipSelectPage:OnHide()
	if isActive(self.addStutasInfoPanel) then
		setActive(self.addStutasInfoPanel, false)
	end

	self:UnBlurPanel()

	return
end

function IslandShipSelectPage:OnDisable()
	self:OnHide()

	return
end

return IslandShipSelectPage
