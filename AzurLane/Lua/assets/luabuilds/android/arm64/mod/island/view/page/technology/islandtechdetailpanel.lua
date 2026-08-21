local var_0_0 = class("IslandTechDetailPanel", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "IslandTechDetailPanel"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.selectedTF = arg_2_0._tf:Find("selected")
	arg_2_0.panel = arg_2_0._tf:Find("panel")
	arg_2_0.iconTF = arg_2_0.panel:Find("icon_bg/icon")
	arg_2_0.nameTF = arg_2_0.panel:Find("title/Text")
	arg_2_0.descPanel = arg_2_0.panel:Find("desc")
	arg_2_0.descTF = arg_2_0.descPanel:Find("Text")
	arg_2_0.unlockTF = arg_2_0.panel:Find("unlock")

	setText(arg_2_0.unlockTF:Find("title"), i18n("island_tech_unlock_need"))

	arg_2_0.unlockUIList = UIItemList.New(arg_2_0.unlockTF:Find("list"), arg_2_0.unlockTF:Find("list/tpl"))
	arg_2_0.normalTimeTextTF = arg_2_0.panel:Find("status/normal/content/time/Text")
	arg_2_0.timeTextTF = arg_2_0.panel:Find("status/studying/time/Text")

	local var_2_0 = arg_2_0.panel:Find("status")

	setText(var_2_0:Find("lock/content/Text"), i18n("island_tech_unlock_dev"))
	setText(var_2_0:Find("unlock/Text"), i18n("island_tech_unlock_dev"))
	setText(var_2_0:Find("normal/content/Text"), i18n("island_tech_dev_start"))
	setText(var_2_0:Find("normal/cost/title"), i18n("island_tech_dev_cost"))
	setText(var_2_0:Find("studying/Text"), i18n("island_tech_dev_starting"))
	setText(var_2_0:Find("receive/Text"), i18n("island_tech_dev_success"))
	setText(var_2_0:Find("finished/normal/Text"), i18n("island_tech_dev_finish"))

	arg_2_0.noramlFinsh = var_2_0:Find("finished/normal")
	arg_2_0.mapFinsh = var_2_0:Find("finished/map")
	arg_2_0.mapFinshIcon = arg_2_0.mapFinsh:Find("mapicon")
	arg_2_0.mapFinshName = arg_2_0.mapFinsh:Find("maptitle/name")
	arg_2_0.npcTF = arg_2_0.mapFinsh:Find("npc")
	arg_2_0.npcIcon = arg_2_0.npcTF:Find("npcicon")
	arg_2_0.npcName = arg_2_0.npcTF:Find("npcName")
	arg_2_0.statusTFs = {
		[IslandTechnology.STATUS.LOCK] = var_2_0:Find("lock"),
		[IslandTechnology.STATUS.UNLOCK] = var_2_0:Find("unlock"),
		[IslandTechnology.STATUS.NORMAL] = var_2_0:Find("normal"),
		[IslandTechnology.STATUS.STUDYING] = var_2_0:Find("studying"),
		[IslandTechnology.STATUS.RECEIVE] = var_2_0:Find("receive"),
		[IslandTechnology.STATUS.FINISHED] = var_2_0:Find("finished")
	}
	arg_2_0.costTF = arg_2_0.panel:Find("status/normal/cost")
	arg_2_0.costUIList = UIItemList.New(arg_2_0.costTF:Find("list"), arg_2_0.costTF:Find("list/tpl"))

	setText(arg_2_0._tf:Find("panel/unlock/title"), i18n("island_tech_detail_unlocktitle"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("close"), function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	arg_3_0.unlockUIList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			setText(arg_5_2:Find("Text"), IslandTechnology.GetUnlockText(arg_3_0.unlockCondList[arg_5_1 + 1]))

			local var_5_0 = arg_3_0.showTechVO:MatchCondition(arg_3_0.unlockCondList[arg_5_1 + 1]) and "1E90FF" or "F5F5F5"

			setTextColor(arg_5_2:Find("Text"), Color.NewHex(var_5_0))
			setImageColor(arg_5_2:Find("dot"), Color.NewHex(var_5_0))
		end

		return
	end)
	arg_3_0.costUIList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			local var_6_0 = arg_3_0.costList[arg_6_1 + 1]
			local var_6_1 = arg_3_0.inventoryAgency:GetOwnCount(arg_3_0.costList[arg_6_1 + 1].id)

			updateCustomDrop(arg_6_2, arg_3_0.costList[arg_6_1 + 1])

			local var_6_2 = arg_6_2:Find("icon_bg/count_bg/count")
			local var_6_3

			if var_6_0.id == IslandItem.GOLD_ID then
				setText(var_6_2, var_6_1 < var_6_0.count and setColorStr(var_6_0.count, "#FF6767"))

				goto label_6_0

				var_6_3 = var_6_1 < var_6_0.count and setColorStr(var_6_1, "#FF6767") or var_6_1
			end

			setText(var_6_2, var_6_3 .. "/" .. var_6_0.count)

			::label_6_0::

			onButton(arg_3_0, arg_6_2, function()
				arg_3_0.contextData:ShowMsgBox({
					title = i18n("island_word_desc"),
					type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
					dropData = var_6_0
				})

				return
			end)
		end

		return
	end)

	arg_3_0.placeId = IslandTechnologyAgency.PLACE_ID
	arg_3_0.baseEffectSpeed = pg.island_set.base_efficiency.key_value_int

	return
end

function var_0_0.Flush(arg_8_0)
	arg_8_0:StopTimer()

	local var_8_0 = getProxy(IslandProxy):GetIsland()

	arg_8_0.buildingAgency = var_8_0:GetBuildingAgency()
	arg_8_0.techAgency = var_8_0:GetTechnologyAgency()
	arg_8_0.inventoryAgency = var_8_0:GetInventoryAgency()
	arg_8_0.showTechVO = arg_8_0.techAgency:GetTechnology(arg_8_0.configId)

	LoadImageSpriteAsync("island/IslandTechnology/" .. arg_8_0.showTechVO:getConfig("tech_icon"), arg_8_0.iconTF, true)
	setText(arg_8_0.nameTF, arg_8_0.showTechVO:getConfig("tech_name"))
	setText(arg_8_0.descTF, arg_8_0.showTechVO:getConfig("tech_desc"))
	setText(arg_8_0.normalTimeTextTF, arg_8_0.timeMgr:DescCDTime((math.floor(pg.island_formula[arg_8_0.showTechVO:GetFormulaId()].workload / arg_8_0.baseEffectSpeed))))

	arg_8_0.unlockCondList = Clone(arg_8_0.showTechVO:getConfig("sys_unlock"))

	local var_8_1 = arg_8_0.showTechVO:getConfig("island_level")

	if var_8_1 ~= 0 then
		table.insert(arg_8_0.unlockCondList, 1, {
			0,
			var_8_1
		})
	end

	arg_8_0.unlockUIList:align(#arg_8_0.unlockCondList)

	local var_8_2 = arg_8_0.showTechVO:GetStatus()

	for iter_8_0, iter_8_1 in pairs(arg_8_0.statusTFs) do
		setActive(iter_8_1, iter_8_0 == var_8_2)
	end

	local var_8_3 = var_8_2 == IslandTechnology.STATUS.LOCK or var_8_2 == IslandTechnology.STATUS.UNLOCK

	setActive(arg_8_0.unlockTF, var_8_2 == IslandTechnology.STATUS.LOCK or var_8_2 == IslandTechnology.STATUS.UNLOCK)
	setActive(arg_8_0.descPanel, not var_8_3)

	arg_8_0.costList = arg_8_0.showTechVO:GetCostItems()

	arg_8_0.costUIList:align(#arg_8_0.costList)
	setText(arg_8_0._tf:Find("panel/desc/name"), arg_8_0.showTechVO:getConfig("complete_title"))
	switch(var_8_2, {
		[IslandTechnology.STATUS.LOCK] = function()
			onButton(arg_8_0, arg_8_0.statusTFs[var_8_2], function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("island_tech_unlock_tip"))

				return
			end, SFX_PANEL)

			return
		end,
		[IslandTechnology.STATUS.UNLOCK] = function()
			onButton(arg_8_0, arg_8_0.statusTFs[var_8_2], function()
				arg_8_0:emit(IslandMediator.ON_UNLOCK_TECH, arg_8_0.showTechVO.id)

				return
			end, SFX_PANEL)

			return
		end,
		[IslandTechnology.STATUS.NORMAL] = function()
			setGray(arg_8_0.statusTFs[var_8_2], not arg_8_0:CheckCost(), false)
			onButton(arg_8_0, arg_8_0.statusTFs[var_8_2], function()
				if not arg_8_0:CheckCost() then
					pg.TipsMgr.GetInstance():ShowTips(i18n("island_production_cost_notenough"))

					return
				end

				if not arg_8_0.techAgency:GetEmptySlotId() then
					pg.TipsMgr.GetInstance():ShowTips(i18n("island_tech_no_slot"))

					return
				end

				if arg_8_0.showTechVO:IsAutoType() then
					existCall(arg_8_0.contextData.onFinishImmd, arg_8_0.showTechVO.id)
				else
					existCall(arg_8_0.contextData.onSelecteShip, arg_8_0.showTechVO:GetFormulaId())
				end

				return
			end, SFX_PANEL)

			return
		end,
		[IslandTechnology.STATUS.STUDYING] = function()
			onButton(arg_8_0, arg_8_0.statusTFs[var_8_2]:Find("ticket"), function()
				existCall(arg_8_0.contextData.openTicketPage, arg_8_0.showTechVO:GetSlotId())

				return
			end, SFX_PANEL)

			return
		end,
		[IslandTechnology.STATUS.RECEIVE] = function()
			onButton(arg_8_0, arg_8_0.statusTFs[var_8_2], function()
				arg_8_0:emit(IslandMediator.GET_DELEGATION_AWARD, arg_8_0.placeId, arg_8_0.showTechVO:GetSlotId(), 2, function()
					existCall(arg_8_0.contextData.onGetAwardDone, arg_8_0.showTechVO.id)

					return
				end)

				return
			end, SFX_PANEL)

			return
		end,
		[IslandTechnology.STATUS.FINISHED] = function()
			local var_20_0 = arg_8_0.showTechVO:getConfig("complete_map_id")

			if var_20_0 == 0 then
				setActive(arg_8_0.noramlFinsh, true)
				setActive(arg_8_0.mapFinsh, false)

				return
			end

			setActive(arg_8_0.noramlFinsh, false)
			setActive(arg_8_0.mapFinsh, true)
			LoadImageSpriteAtlasAsync("island/IslandMapIcon/" .. var_20_0, "", arg_8_0.mapFinshIcon)
			setText(arg_8_0.mapFinshName, pg.island_map[var_20_0].name)

			local var_20_1 = arg_8_0.showTechVO:getConfig("complete_character_id")

			if var_20_1 == "" or #var_20_1 == 0 then
				setActive(arg_8_0.npcTF, false)

				return
			end

			setActive(arg_8_0.npcTF, true)
			GetImageSpriteFromAtlasAsync("island/IslandShipIcon/" .. pg.island_unit_character[var_20_1[1]].IslandShipIcon, "", arg_8_0.npcIcon)
			setText(arg_8_0.npcName, pg.island_unit_character[var_20_1[1]].name)

			return
		end
	}, function()
		return
	end)
	arg_8_0:StartTimer()
	arg_8_0:UpdateTime()
	setActive(arg_8_0.selectedTF, arg_8_0.selectedItemPos)

	if arg_8_0.selectedItemPos then
		arg_8_0:FlushSelectedItem()
	end

	return
end

function var_0_0.CheckCost(arg_22_0)
	local var_22_0 = arg_22_0.costList or {}

	return underscore.all(var_22_0, function(arg_23_0)
		return arg_22_0.inventoryAgency:GetOwnCount(arg_23_0.id) >= arg_23_0.count
	end)
end

function var_0_0.FlushSelectedItem(arg_24_0)
	setAnchoredPosition(arg_24_0.selectedTF, arg_24_0.selectedItemPos)
	setActive(arg_24_0.selectedTF:Find("selected"), true)

	arg_24_0.selectedTF.name = arg_24_0.configId

	local var_24_0 = arg_24_0.techAgency:GetTechnology(arg_24_0.configId)

	IslandTechTreePanel.SetTechName(arg_24_0.selectedTF:Find("name"), var_24_0:getConfig("tech_name"))

	local var_24_1 = var_24_0:GetStatus()
	local var_24_2 = var_24_1 == IslandTechnology.STATUS.FINISHED

	setTextColor(arg_24_0.selectedTF:Find("name/Text"), Color.NewHex(var_24_1 == IslandTechnology.STATUS.FINISHED and "1b3650" or "ffffff"))
	setTextColor(arg_24_0.selectedTF:Find("name/ScrollText"), Color.NewHex(var_24_2 and "1b3650" or "ffffff"))
	LoadImageSpriteAsync("island/IslandTechnology/" .. var_24_0:getConfig("tech_icon"), arg_24_0.selectedTF:Find("icon"), true)
	setActive(arg_24_0.selectedTF:Find("icon"), var_24_1 ~= IslandTechnology.STATUS.STUDYING and var_24_1 ~= IslandTechnology.STATUS.RECEIVE)
	setImageColor(arg_24_0.selectedTF:Find("icon"), Color.NewHex(var_24_2 and "455a81" or "ffffff"))
	eachChild(arg_24_0.selectedTF:Find("back"), function(arg_25_0)
		setActive(arg_25_0, arg_25_0.name == var_24_1)

		return
	end)
	setActive(arg_24_0.selectedTF:Find("back/normal"), not var_24_2 and var_24_1 ~= IslandTechnology.STATUS.STUDYING)
	eachChild(arg_24_0.selectedTF:Find("front"), function(arg_26_0)
		setActive(arg_26_0, arg_26_0.name == var_24_1)

		return
	end)

	return
end

function var_0_0.Show(arg_27_0, arg_27_1, arg_27_2)
	var_0_0.super.Show(arg_27_0)

	arg_27_0.configId = arg_27_1
	arg_27_0.timeMgr = pg.TimeMgr.GetInstance()
	arg_27_0.selectedItemPos = arg_27_2

	arg_27_0:Flush()
	arg_27_0:OverlayPanel(arg_27_0._tf)

	return
end

function var_0_0.OnShipSelected(arg_28_0, arg_28_1)
	local var_28_9000
	local var_28_0 = getProxy(IslandProxy)

	if math.max(math.floor(pg.island_formula[arg_28_0.showTechVO:GetFormulaId()].stamina_cost * (1 - IslandProductCostHelper.GetReducePercentInPlace(arg_28_1, arg_28_0.placeId))), 1) > var_28_0.GetIsland(var_28_9000):GetCharacterAgency():GetShipById(arg_28_1).GetCurrentEnergy(var_28_0) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_production_cost_notenough"))

		return
	end

	arg_28_0:emit(IslandMediator.START_DELEGATION, arg_28_0.placeId, arg_28_0.techAgency:GetEmptySlotId(), arg_28_1, arg_28_0.showTechVO:GetFormulaId(), 1)

	return
end

function var_0_0.UpdateTime(arg_29_0)
	local var_29_0 = arg_29_0.showTechVO:GetStatus()
	local var_29_1 = arg_29_0.buildingAgency:GetDelegationSlotDataByTechId(arg_29_0.showTechVO.id)

	if var_29_1 then
		if var_29_1:GetSlotRewardData() then
			setText(arg_29_0.timeTextTF, "00:00:00")
		else
			local var_29_2 = var_29_1:GetSlotRoleData()
			local var_29_3 = var_29_2:GetFinishTime() - arg_29_0.timeMgr:GetServerTime()
			local var_29_4 = var_29_3 > 0 and arg_29_0.timeMgr:DescCDTime(var_29_3) or "00:00:00"

			setText(arg_29_0.timeTextTF, var_29_4)
		end
	else
		setText(arg_29_0.timeTextTF, "??:??:??")
	end

	return
end

function var_0_0.StartTimer(arg_30_0)
	arg_30_0.timer = Timer.New(function()
		arg_30_0:UpdateTime()

		return
	end, 1, -1)

	arg_30_0.timer:Start()

	return
end

function var_0_0.StopTimer(arg_32_0)
	if arg_32_0.timer ~= nil then
		arg_32_0.timer:Stop()

		arg_32_0.timer = nil
	end

	return
end

function var_0_0.OnHide(arg_33_0)
	arg_33_0:StopTimer()
	arg_33_0:UnOverlayPanel(arg_33_0._tf, arg_33_0._parentTf)

	return
end

function var_0_0.OnDestroy(arg_34_0)
	arg_34_0:StopTimer()
	arg_34_0:UnOverlayPanel(arg_34_0._tf, arg_34_0._parentTf)

	return
end

return var_0_0
