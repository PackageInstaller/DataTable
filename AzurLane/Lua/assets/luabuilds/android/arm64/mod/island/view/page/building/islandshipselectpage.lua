local var_0_0 = class("IslandShipSelectPage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandShipSelectUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.backBtn = arg_2_0._tf:Find("top/back")
	arg_2_0.title = arg_2_0._tf:Find("top/title/Text")

	setText(arg_2_0.title, i18n("island_select_ship"))

	arg_2_0.frameTF = arg_2_0._tf:Find("frame")
	arg_2_0.shipRectCom = arg_2_0.frameTF:Find("ships"):GetComponent("LScrollRect")

	setText(arg_2_0.frameTF:Find("selected/Text"), i18n("island_select_ship_label_1"))

	arg_2_0.selectedTextCom = arg_2_0.frameTF:Find("selected/num"):GetComponent("Text")
	arg_2_0.benefitsTF = arg_2_0._tf:Find("benefits")
	arg_2_0.benefitTipBtn = arg_2_0.benefitsTF:Find("tip/help")

	setText(arg_2_0.benefitsTF:Find("tip/Text"), i18n("island_select_ship_overview"))

	arg_2_0.mainAttrBar = arg_2_0.benefitsTF:Find("main/slider/bar")

	setText(arg_2_0.benefitsTF:Find("main/Text"), IslandShipAttr.ATTRS_CH[IslandShipAttr.MANAGE_KEY])

	arg_2_0.subAttrUIList = UIItemList.New(arg_2_0.benefitsTF:Find("subs"), arg_2_0.benefitsTF:Find("subs/tpl"))
	arg_2_0.infoEmptyTF = arg_2_0._tf:Find("info/empty")

	setText(arg_2_0.infoEmptyTF:Find("Image/Text"), i18n("island_select_ship"))

	arg_2_0.infoEmptyTitleTF = arg_2_0.infoEmptyTF:Find("name")
	arg_2_0.infoPanel = arg_2_0._tf:Find("info/content")
	arg_2_0.nameTF = arg_2_0.infoPanel:Find("name")
	arg_2_0.levelTF = arg_2_0.infoPanel:Find("name/level")
	arg_2_0.attrUIList = UIItemList.New(arg_2_0.infoPanel:Find("attrs"), arg_2_0.infoPanel:Find("attrs/tpl"))
	arg_2_0.skillTF = arg_2_0.infoPanel:Find("skill")
	arg_2_0.energyTFInfo = arg_2_0.infoPanel:Find("selectShipEnergyInfo")
	arg_2_0.energyTF = arg_2_0.energyTFInfo:Find("energy")
	arg_2_0.energyCostSilderTF = arg_2_0.energyTF:Find("energy_bar_cost")
	arg_2_0.giftBtn = arg_2_0.energyTFInfo:Find("gift")
	arg_2_0.statusTF = arg_2_0.infoPanel:Find("status")
	arg_2_0.sureBtn = arg_2_0._tf:Find("sure")

	setText(arg_2_0.sureBtn:Find("Text"), i18n("island_shipselect_confirm"))

	arg_2_0.indexBtn = arg_2_0._tf:Find("frame/filter_panel/IndexIco")
	arg_2_0.orderBtn = arg_2_0._tf:Find("frame/filter_panel/index")
	arg_2_0.orderIco = arg_2_0._tf:Find("frame/filter_panel/index/content/icon/icon")
	arg_2_0.orderTxt = arg_2_0._tf:Find("frame/filter_panel/index/content/Text"):GetComponent(typeof(Text))
	arg_2_0.shipIconTF = arg_2_0.energyTFInfo:Find("icon_mask/icon")
	arg_2_0.energyTimeTextTf = arg_2_0.energyTFInfo:Find("time_Text")
	arg_2_0.recoveryTimeTips = arg_2_0.infoPanel:Find("selectShipEnergyInfo/recoveryTimeTips")
	arg_2_0.skill = arg_2_0.infoPanel:Find("skill")
	arg_2_0.skillEmp = arg_2_0.infoPanel:Find("skillEmp")
	arg_2_0.skillEmpDes = arg_2_0.skillEmp:Find("Text")
	arg_2_0.skillInuse = arg_2_0.skill:Find("skill_tab_bg/iconBright")
	arg_2_0.skillUnuse = arg_2_0.skill:Find("skill_tab_bg/iconDark")
	arg_2_0.skillName = arg_2_0.skill:Find("name"):GetComponent(typeof(Text))
	arg_2_0.skillDes = arg_2_0.skill:Find("desc/Text"):GetComponent(typeof(Text))
	arg_2_0.shipContent = arg_2_0.frameTF:Find("ships")
	arg_2_0.shipEmpty = arg_2_0.frameTF:Find("empShip")
	arg_2_0.addStutasTF = arg_2_0._tf:Find("addStutas")
	arg_2_0.energyStutasTF = arg_2_0._tf:Find("energyStutas")
	arg_2_0.energyStutasTFNum = arg_2_0._tf:Find("energyStutas/num")
	arg_2_0.addStutasNum = arg_2_0._tf:Find("addStutas/num")
	arg_2_0.addStutasBtn = arg_2_0._tf:Find("addStutas/num/tipbtn")
	arg_2_0.addStutasInfoPanel = arg_2_0._tf:Find("addinfo_panel")
	arg_2_0.buffInfoUIList = UIItemList.New(arg_2_0.addStutasInfoPanel:Find("effects"), arg_2_0.addStutasInfoPanel:Find("effects/tpl"))

	setText(arg_2_0.addStutasInfoPanel:Find("Text"), i18n("island_production_speed_tip2"))

	arg_2_0.buffInfoEmptyTF = arg_2_0.addStutasInfoPanel:Find("empty")

	setText(arg_2_0.buffInfoEmptyTF:Find("Text"), i18n("island_manage_no_addition"))
	arg_2_0.buffInfoUIList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			setText(arg_3_2:Find("bg/name"), arg_2_0.buffInfos[arg_3_1 + 1].name)
			setText(arg_3_2:Find("bg/effect"), arg_2_0.buffInfos[arg_3_1 + 1].effect)
		end

		return
	end)
	setText(arg_2_0.shipEmpty:Find("Text"), i18n("island_production_selected_tip2"))
	setText(arg_2_0.recoveryTimeTips, i18n("island_ship_energy_recoverytips"))

	return
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddListener(GAME.ISLAND_FOLLOWER_OP_DONE, arg_4_0.OnFollowerOp)
	arg_4_0:AddListener(GAME.ISLAND_GIVE_GIFT_DONE, arg_4_0.OnUseItem)

	return
end

function var_0_0.RemoveListeners(arg_5_0)
	arg_5_0:RemoveListener(GAME.ISLAND_FOLLOWER_OP_DONE, arg_5_0.OnFollowerOp)
	arg_5_0:RemoveListener(GAME.ISLAND_GIVE_GIFT_DONE, arg_5_0.OnUseItem)

	return
end

function var_0_0.OnUseItem(arg_6_0)
	arg_6_0:ClosePage(IslandShipStatusBox)
	arg_6_0:FlushInfo()

	return
end

function var_0_0.OnFollowerOp(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.cards) do
		if iter_7_1.id == arg_7_1 then
			iter_7_1:UpdateFollowMask()
		end
	end

	return
end

function var_0_0.OnInit(arg_8_0)
	onButton(arg_8_0, arg_8_0.backBtn, function()
		arg_8_0:Hide()
		existCall(arg_8_0.cancelFunc)

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.addStutasBtn, function()
		if isActive(arg_8_0.addStutasInfoPanel) then
			setActive(arg_8_0.addStutasInfoPanel, false)
		else
			setActive(arg_8_0.addStutasInfoPanel, true)
			arg_8_0.buffInfoUIList:align(#arg_8_0.buffInfos)
			setActive(arg_8_0.buffInfoEmptyTF, #arg_8_0.buffInfos == 0)
		end

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.sureBtn, function()
		local var_11_0 = getProxy(IslandProxy):GetIsland():GetFollowerAgency()
		local var_11_1 = {}

		for iter_11_0, iter_11_1 in ipairs(arg_8_0.selectedIds) do
			if var_11_0:Following(iter_11_1) then
				table.insert({}, iter_11_1)
			end
		end

		if #{} > 0 then
			arg_8_0:ShowMsgBox({
				type = IslandMsgBox.TYPE_COMMON,
				content = i18n("island_cancel_follow_tip"),
				onYes = function()
					for iter_12_0, iter_12_1 in ipairs(var_11_1) do
						table.insert({}, function(arg_13_0)
							arg_8_0:emit(IslandMediator.DEL_FOLLOWER, iter_12_1, arg_13_0)

							return
						end)
					end

					seriesAsync({}, function()
						arg_8_0:Hide()
						existCall(arg_8_0.confirmFunc, arg_8_0.selectedIds)

						return
					end)

					return
				end
			})

			return
		end

		arg_8_0:Hide()
		existCall(arg_8_0.confirmFunc, arg_8_0.selectedIds)

		return
	end, SFX_PANEL)
	onToggle(arg_8_0, arg_8_0.indexBtn, function(arg_15_0)
		if arg_15_0 then
			arg_8_0:emit(IslandMediator.OPEN_SHIP_INDEX, {
				OnFilter = function(arg_16_0)
					arg_8_0:OnFilter(arg_16_0)

					return
				end,
				defaultIndex = arg_8_0.sortData,
				needWorkSpeed = arg_8_0.needWorkSpeed
			})
		end

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.orderBtn, function()
		arg_8_0.selectAsc = not arg_8_0.selectAsc

		arg_8_0:UpdateSortBtn()
		arg_8_0:FlushShips()

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.benefitTipBtn, function()
		arg_8_0:ShowMsgBox({
			hideNo = true,
			type = IslandMsgBox.TYPE_COMMON,
			content = i18n("island_manage_help_tip")
		})

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0._tf:Find("top/title/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.island_help_commission.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.giftBtn, function()
		if not arg_8_0.showId or arg_8_0.showId == IslandCharacterAgency.NPC_CONFIG_ID then
			return
		end

		arg_8_0:OpenPage(IslandShipStatusBox, arg_8_0.showId)

		return
	end, SFX_PANEL)
	arg_8_0.subAttrUIList:make(function(arg_21_0, arg_21_1, arg_21_2)
		if arg_21_0 == UIItemList.EventInit then
			arg_21_2.name = IslandShipAttr.ATTRS[arg_21_1 + 1]

			setText(arg_21_2:Find("Text"), IslandShipAttr.ToChinese(IslandShipAttr.ATTRS[arg_21_1 + 1]))
		elseif arg_21_0 == UIItemList.EventUpdate then
			setFillAmount(arg_21_2:Find("slider/bar"), arg_8_0:GetShipsAttrProgress(IslandShipAttr.ATTRS[arg_21_1 + 1]))
		end

		return
	end)

	function arg_8_0.shipRectCom.onInitItem(arg_22_0)
		arg_8_0:OnInitShip(arg_22_0)

		return
	end

	function arg_8_0.shipRectCom.onUpdateItem(arg_23_0, arg_23_1)
		arg_8_0:OnUpdateShip(arg_23_0, arg_23_1)

		return
	end

	arg_8_0.cards = {}
	arg_8_0.selectAsc = true
	arg_8_0.sortData = {
		sortIndex = IslandShipIndexLayer.SortLevel,
		campIndex = ShipIndexConst.CampAll,
		rarityIndex = ShipIndexConst.RarityAll,
		extraIndex = IslandShipIndexLayer.ExtraALL
	}

	arg_8_0:UpdateSortBtn()

	arg_8_0.timeMgr = pg.TimeMgr.GetInstance()

	return
end

function var_0_0.OnFilter(arg_24_0, arg_24_1)
	arg_24_0.sortData = arg_24_1

	arg_24_0:UpdateSortBtn()
	arg_24_0:FlushShips()

	return
end

function var_0_0.UpdateSortBtn(arg_25_0)
	arg_25_0.orderIco.localScale = arg_25_0.selectAsc and Vector3(1, 1, 1) or Vector3(1, -1, 1)

	local var_25_0, var_25_1 = IslandShipIndexLayer.getSortFuncAndName(arg_25_0.sortData.sortIndex, arg_25_0.selectAsc)

	arg_25_0.orderTxt.text = i18n(var_25_1)

	return
end

function var_0_0.UpdateAttrs(arg_26_0, arg_26_1)
	local var_26_0 = IslandShipAttr.ATTRS

	arg_26_0.attrUIList:make(function(arg_27_0, arg_27_1, arg_27_2)
		if arg_27_0 == UIItemList.EventUpdate then
			arg_26_0:UpdateAttr(arg_27_2, var_26_0, arg_27_1 + 1, arg_26_1)
		end

		return
	end)
	arg_26_0.attrUIList:align(#IslandShipAttr.ATTRS)

	return
end

function var_0_0.UpdateAttr(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4)
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

		onButton(arg_28_0, arg_28_1, function()
			arg_28_0:ShowMsgBox({
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

	setActive(arg_28_1:Find("vx_tpl"), arg_28_0.attrType == arg_28_3)

	return
end

function var_0_0.OnShow(arg_31_0, arg_31_1)
	arg_31_0:BlurPanel()

	arg_31_0.showType = arg_31_1.showType or IslandSelectShipCard.SHOW_TYPE.PLACE
	arg_31_0.selectNum = arg_31_1.selectNum or 1
	arg_31_0.selectedIds = arg_31_1.selectedIds or {}
	arg_31_0.attrType = arg_31_1.attrType
	arg_31_0.confirmFunc = arg_31_1.confirmFunc
	arg_31_0.cancelFunc = arg_31_1.cancelFunc
	arg_31_0.placeId = arg_31_1.placeId
	arg_31_0.restId = arg_31_1.restId
	arg_31_0.showBenefits = arg_31_1.showBenefits
	arg_31_0.needWorkSpeed = arg_31_1.needWorkSpeed or false
	arg_31_0.autoCollectionSelectShip = arg_31_1.autoCollectionSelectShip

	local var_31_0 = arg_31_1.emptyInfoTitle or ""

	setText(arg_31_0.infoEmptyTitleTF, var_31_0)

	arg_31_0.energyCost = arg_31_1.energyCost or 0
	arg_31_0.characterAgency = getProxy(IslandProxy):GetIsland():GetCharacterAgency()
	arg_31_0.sortData.sortIndex = arg_31_0.needWorkSpeed and IslandShipIndexLayer.SortWorkSpeed or IslandShipIndexLayer.SortLevel

	arg_31_0:UpdateSortBtn()
	arg_31_0:FlushShips(#arg_31_0.selectedIds == 0 and arg_31_0.selectNum == 1)

	return
end

function var_0_0.CheckHasSelected(arg_32_0, arg_32_1)
	if not arg_32_0.autoCollectionSelectShip then
		return false
	end

	local var_32_0 = false

	for iter_32_0, iter_32_1 in pairs(arg_32_0.autoCollectionSelectShip) do
		if arg_32_1 == iter_32_1 then
			var_32_0 = true
		end
	end

	return var_32_0
end

function var_0_0.OnInitShip(arg_33_0, arg_33_1)
	arg_33_0.cards[arg_33_1] = IslandSelectShipCard.New(arg_33_1)

	return
end

function var_0_0.OnUpdateShip(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = arg_34_0.cards[arg_34_2]

	if not arg_34_0.cards[arg_34_2] then
		arg_34_0:OnInitItem(arg_34_2)

		var_34_0 = arg_34_0.cards[arg_34_2]
	end

	local var_34_1 = arg_34_0.showShips[arg_34_1 + 1]
	local var_34_2 = arg_34_0.characterAgency:GetShipById(arg_34_0.showShips[arg_34_1 + 1])

	onButton(arg_34_0, var_34_0.go, function()
		if arg_34_0:CheckHasSelected(var_34_1) then
			return
		end

		local var_35_0 = getProxy(IslandProxy):GetIsland():GetFollowerAgency()

		if var_35_0:Following(var_34_1) then
			arg_34_0:ShowMsgBox({
				content = i18n("island_cancel_follow_tip"),
				onYes = function()
					arg_34_0:emit(IslandMediator.DEL_FOLLOWER, var_34_1)

					return
				end
			})

			return
		end

		if not var_34_2:IsDelegable() then
			return
		end

		if arg_34_0.showId == var_34_0.id then
			arg_34_0.showId = nil
		else
			arg_34_0.showId = var_34_0.id
		end

		if table.contains(arg_34_0.selectedIds, var_34_0.id) then
			table.removebyvalue(arg_34_0.selectedIds, var_34_0.id)
		elseif arg_34_0.selectNum == 1 then
			arg_34_0.selectedIds = {
				var_34_0.id
			}
		else
			if #arg_34_0.selectedIds >= arg_34_0.selectNum then
				return
			end

			table.insert(arg_34_0.selectedIds, var_34_0.id)
		end

		for iter_35_0, iter_35_1 in pairs(arg_34_0.cards) do
			iter_35_1:UpdateSelected(arg_34_0.selectedIds)
		end

		arg_34_0:FlushInfo()

		return
	end, SFX_PANEL)

	if arg_34_0.showType == IslandSelectShipCard.SHOW_TYPE.PLACE then
		var_34_0:Update(arg_34_0.showType, var_34_1, arg_34_0.attrType, arg_34_0.placeId, arg_34_0.selectedIds, arg_34_0.autoCollectionSelectShip)
	elseif arg_34_0.showType == IslandSelectShipCard.SHOW_TYPE.RESTAURANT then
		var_34_0:Update(arg_34_0.showType, var_34_1, arg_34_0.attrType, arg_34_0.restId, arg_34_0.selectedIds, arg_34_0.autoCollectionSelectShip)
	end

	return
end

function var_0_0.FlushShips(arg_37_0, arg_37_1)
	arg_37_0.showShips = arg_37_0:GetShips()

	if #arg_37_0.showShips ~= 0 and arg_37_1 then
		local var_37_0 = arg_37_0:GetFristSelectableShipId()

		if var_37_0 then
			arg_37_0.showId = var_37_0

			table.insert(arg_37_0.selectedIds, var_37_0)
		end
	end

	arg_37_0.showId = arg_37_0.selectedIds[1]

	setActive(arg_37_0.shipContent, #arg_37_0.showShips ~= 0)
	setActive(arg_37_0.shipEmpty, #arg_37_0.showShips == 0)
	arg_37_0.shipRectCom:SetTotalCount(#arg_37_0.showShips)
	arg_37_0:FlushInfo()

	return
end

function var_0_0.GetFristSelectableShipId(arg_38_0)
	for iter_38_0, iter_38_1 in ipairs(arg_38_0.showShips) do
		local var_38_0 = arg_38_0.characterAgency:GetShipById(iter_38_1)

		if var_38_0:GetState() == IslandShip.STATE_NORMAL and not arg_38_0:CheckHasSelected(iter_38_1) then
			return iter_38_1
		end
	end

	return nilGetShipsAttrProgress
end

function var_0_0.UpdateTimer(arg_39_0, arg_39_1)
	setText(arg_39_0.energyTimeTextTf, arg_39_0.timeMgr:DescCDTime(arg_39_1 - arg_39_0.timeMgr:GetServerTime()))

	return
end

function var_0_0.StopTimer(arg_40_0)
	if arg_40_0.energyTimer ~= nil then
		arg_40_0.energyTimer:Stop()

		arg_40_0.energyTimer = nil
	end

	return
end

function var_0_0.FlushInfo(arg_41_0)
	arg_41_0.selectedTextCom.text = #arg_41_0.selectedIds .. "/" .. arg_41_0.selectNum

	arg_41_0:FlushBenefits()
	setActive(arg_41_0.sureBtn, arg_41_0.showId)
	setActive(arg_41_0.infoPanel, arg_41_0.showId)
	setActive(arg_41_0.infoEmptyTF, not arg_41_0.showId)
	arg_41_0:FlushAddPercent()
	arg_41_0:FlushEnergyPercent()

	if not arg_41_0.showId then
		return
	end

	setActive(arg_41_0.giftBtn, arg_41_0.showId ~= IslandCharacterAgency.NPC_CONFIG_ID)

	local var_41_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(arg_41_0.showId)

	setText(arg_41_0.nameTF, var_41_0:GetName())
	setText(arg_41_0.levelTF, string.format("-Lv.%d", var_41_0:GetLevel()))
	arg_41_0:UpdateAttrs(var_41_0)
	GetImageSpriteFromAtlasAsync("ShipYardIcon/" .. IslandShip.StaticGetPrefab(var_41_0.id), "", arg_41_0.shipIconTF)

	local var_41_1 = var_41_0:GetCurrentEnergy()
	local var_41_2 = var_41_0:GetMaxEnergy()

	setText(arg_41_0.energyTF:Find("text"), var_41_1 .. "/" .. var_41_2)
	setSlider(arg_41_0.energyTF:Find("energy_bar"), 0, 1, var_41_1 / var_41_2)

	if var_41_1 ~= var_41_2 then
		setActive(arg_41_0.recoveryTimeTips, true)
		setActive(arg_41_0.energyTimeTextTf, true)

		local var_41_3 = var_41_0:GetEnergyMaxTime()

		arg_41_0:StopTimer()
		arg_41_0:UpdateTimer((var_41_0:GetEnergyMaxTime()))

		arg_41_0.energyTimer = Timer.New(function()
			arg_41_0:UpdateTimer(var_41_3)

			return
		end, 1, -1)

		arg_41_0.energyTimer:Start()
	else
		arg_41_0:StopTimer()
		setActive(arg_41_0.recoveryTimeTips, false)
		setActive(arg_41_0.energyTimeTextTf, false)
	end

	local var_41_4 = var_41_0:GetSkill()
	local var_41_5 = var_41_4:IsUnlock()

	setActive(arg_41_0.skill, var_41_5)
	setActive(arg_41_0.skillEmp, not var_41_5)
	setText(arg_41_0.skillEmpDes, i18n("island_need_star", var_41_0:GetSkillUnlockLevel()))

	if arg_41_0.showType == IslandSelectShipCard.SHOW_TYPE.PLACE then
		local var_41_6 = arg_41_0.placeId or arg_41_0.restId
		local var_41_7 = var_41_5 and IslandSelectShipCard.GetSkillEffective(var_41_0, arg_41_0.showType, var_41_6)

		setActive(arg_41_0.skillInuse, var_41_7)
		setActive(arg_41_0.skillUnuse, not var_41_7)

		arg_41_0.skillName.text = string.format("%s - %s", var_41_4:GetName(), "[Lv." .. var_41_4:GetLevel() .. "]")
		arg_41_0.skillDes.text = var_41_4:GetEffectDesc()

		arg_41_0:FlushAddPercent()
		arg_41_0:FlushEnergyPercent()
		arg_41_0:FlushEnergyCostAnim(var_41_0)

		return
	end
end

function var_0_0.FlushEnergyCostAnim(arg_43_0, arg_43_1)
	arg_43_0:StopCostTimer()

	local var_43_0 = arg_43_0.energyCost ~= 0 and arg_43_0.showType == IslandSelectShipCard.SHOW_TYPE.PLACE

	setActive(arg_43_0.energyCostSilderTF, arg_43_0.energyCost ~= 0 and arg_43_0.showType == IslandSelectShipCard.SHOW_TYPE.PLACE)

	if not var_43_0 then
		return
	end

	if arg_43_1.id == IslandCharacterAgency.NPC_CONFIG_ID then
		local var_43_1 = arg_43_1:GetCurrentEnergy()
		local var_43_2 = arg_43_1:GetMaxEnergy()

		setActive(arg_43_0.energyCostSilderTF, false)
		setSlider(arg_43_0.energyTF:Find("energy_bar"), 0, 1, var_43_1 / var_43_2)
		setText(arg_43_0.energyTF:Find("text"), string.format("%d-<color=#fadfb6>%d</color>/%d", var_43_1, 0, var_43_2))

		return
	end

	local var_43_3 = math.max(math.floor(arg_43_0.energyCost * (1 - IslandProductCostHelper.GetReducePercentInPlace(arg_43_1.id, arg_43_0.placeId))), 1)

	arg_43_0.energyCostTimer = Timer.New(function()
		local var_44_0 = arg_43_1:GetCurrentEnergy()
		local var_44_1 = arg_43_1:GetMaxEnergy()

		setSlider(arg_43_0.energyTF:Find("energy_bar"), 0, 1, (var_44_0 - var_43_3) / var_44_1)
		setSlider(arg_43_0.energyCostSilderTF, 0, 1, var_44_0 / var_44_1)
		setText(arg_43_0.energyTF:Find("text"), string.format("%d-<color=#fadfb6>%d</color>/%d", var_44_0, var_43_3, var_44_1))

		return
	end, 1, -1)

	arg_43_0.energyCostTimer:Start()
	arg_43_0.energyCostTimer.func()

	return
end

function var_0_0.FlushEnergyPercent(arg_45_0)
	if not arg_45_0.showId or not arg_45_0.autoCollectionSelectShip then
		setActive(arg_45_0.energyStutasTF, false)

		return
	end

	setActive(arg_45_0.energyStutasTF, true)
	setText(arg_45_0.energyStutasTFNum, i18n("island_chara_gather_skill_effect") .. string.format("<color=#39bfff> -%d%%</color>", (IslandAutoCollectHelper.GetAttributeReducePercent(arg_45_0.showId))))

	return
end

function var_0_0.FlushAddPercent(arg_46_0)
	if not arg_46_0.showId or not arg_46_0.needWorkSpeed then
		setActive(arg_46_0.addStutasTF, false)
		setActive(arg_46_0.addStutasInfoPanel, false)

		return
	end

	local var_46_0, var_46_1, var_46_2, var_46_3 = IslandProductTimeHelper.GetAllAddPercent(arg_46_0.showId, arg_46_0.placeId, arg_46_0.attrType)

	setActive(arg_46_0.addStutasTF, true)
	setText(arg_46_0.addStutasNum, i18n("island_production_speed_tip1", var_46_0 + var_46_1 + var_46_2 + var_46_3))

	arg_46_0.buffInfos = {}

	local var_46_4 = IslandProductTimeHelper.GetAttributeAddPercent(arg_46_0.showId, arg_46_0.attrType)

	if var_46_0 > 0 then
		table.insert(arg_46_0.buffInfos, {
			name = i18n("island_production_speed_addition1", IslandShipAttr.ToChinese((IslandShipAttr.GetAtrrName(arg_46_0.attrType)))),
			effect = "+" .. var_46_0 .. "%"
		})
	end

	if var_46_1 > 0 then
		table.insert(arg_46_0.buffInfos, {
			name = i18n("island_production_speed_addition2"),
			effect = "+" .. var_46_1 .. "%"
		})
	end

	if var_46_2 > 0 then
		table.insert(arg_46_0.buffInfos, {
			name = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(arg_46_0.showId):GetSkill():GetName(),
			effect = "+" .. var_46_2 .. "%"
		})
	end

	if var_46_3 > 0 then
		table.insert(arg_46_0.buffInfos, {
			name = i18n("island_production_speed_addition3"),
			effect = "+" .. var_46_3 .. "%"
		})
	end

	arg_46_0.buffInfoUIList:align(#arg_46_0.buffInfos)
	setActive(arg_46_0.buffInfoEmptyTF, #arg_46_0.buffInfos == 0)

	return
end

function var_0_0.FlushBenefits(arg_47_0)
	setActive(arg_47_0.benefitsTF, arg_47_0.showBenefits)

	if arg_47_0.showBenefits then
		setFillAmount(arg_47_0.mainAttrBar, arg_47_0:GetShipsAttrProgress(IslandShipAttr.ATTRS[1]))
		arg_47_0.subAttrUIList:align(#IslandShipAttr.ATTRS)
	end

	return
end

function var_0_0.GetShipsAttrProgress(arg_48_0, arg_48_1)
	local var_48_0 = 0

	for iter_48_0, iter_48_1 in ipairs(arg_48_0.selectedIds) do
		local var_48_1 = arg_48_0.characterAgency:GetShipById(iter_48_1)

		var_48_0 = var_48_0 + (pg.island_chara_att.all[#pg.island_chara_att.all] - var_48_1:GetAttrGrade(arg_48_1) + 1)
	end

	return var_48_0 / (pg.island_chara_att.all[#pg.island_chara_att.all] * arg_48_0.selectNum)
end

function var_0_0.ToVShip(arg_49_0, arg_49_1)
	if not arg_49_0.vship then
		arg_49_0.vship = {}

		function arg_49_0.vship.getNation()
			return arg_49_0.vship.config.nationality
		end

		function arg_49_0.vship.getShipType()
			return arg_49_0.vship.config.type
		end

		function arg_49_0.vship.getTeamType()
			return ShipType.GetTeamFromShipType(arg_49_0.vship.config.type)
		end

		function arg_49_0.vship.getRarity()
			return arg_49_0.vship.config.rarity
		end
	end

	arg_49_0.vship.config = arg_49_1

	return arg_49_0.vship
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

function var_0_0.GetShips(arg_56_0)
	for iter_56_0, iter_56_1 in ipairs((arg_56_0.characterAgency:GetShipsContainNpc())) do
		if var_0_1(iter_56_1.id, arg_56_0.searchKey) and var_0_2(arg_56_0, iter_56_1.id, arg_56_0.sortData) then
			if arg_56_0.needWorkSpeed then
				table.insert({}, (setmetatable({
					GetWorkSpeed = function()
						local var_57_0, var_57_1, var_57_2, var_57_3 = IslandProductTimeHelper.GetAllAddPercent(iter_56_1.id, arg_56_0.placeId, arg_56_0.attrType)

						return var_57_0 + var_57_1 + var_57_2 + var_57_3
					end
				}, {
					__index = iter_56_1
				})))
			elseif arg_56_0.autoCollectionSelectShip then
				if iter_56_1.id ~= 1 then
					table.insert({}, iter_56_1)
				end
			else
				table.insert({}, iter_56_1)
			end
		end
	end

	table.sort({}, CompareFuncs((IslandShipIndexLayer.getSortFuncAndName(arg_56_0.sortData.sortIndex, arg_56_0.selectAsc))))

	for iter_56_2, iter_56_3 in ipairs({}) do
		table.insert({}, iter_56_3.id)
	end

	return {}
end

function var_0_0.StopCostTimer(arg_58_0)
	if arg_58_0.energyCostTimer ~= nil then
		arg_58_0.energyCostTimer:Stop()

		arg_58_0.energyCostTimer = nil
	end

	return
end

function var_0_0.OnDestroy(arg_59_0)
	ClearLScrollrect(arg_59_0.shipRectCom)
	arg_59_0:StopTimer()
	arg_59_0:StopCostTimer()
	arg_59_0:OnHide()

	return
end

function var_0_0.OnHide(arg_60_0)
	if isActive(arg_60_0.addStutasInfoPanel) then
		setActive(arg_60_0.addStutasInfoPanel, false)
	end

	arg_60_0:UnBlurPanel()

	return
end

function var_0_0.OnDisable(arg_61_0)
	arg_61_0:OnHide()

	return
end

return var_0_0
