local var_0_0 = class("IslandTechQuickPanel", import("view.base.BaseSubView"))

var_0_0.TOGGLE_STATUS = {
	NORMAL = "normal",
	FINISHED = "finished",
	STUDYING = "studying"
}

function var_0_0.getUIName(arg_1_0)
	return "IslandTechQuickPanel"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.toggle = arg_2_0._tf:Find("adapt/toggle")
	arg_2_0.panel = arg_2_0._tf:Find("adapt/panel")

	local var_2_0 = arg_2_0.panel:Find("content")
	local var_2_1 = var_2_0:Find("tpl")

	setText(var_2_1:Find("lock/content/tip/Text"), i18n("island_tech_lock"))
	setText(var_2_1:Find("empty/content/Text"), i18n("island_tech_empty"))

	arg_2_0.uiList = UIItemList.New(var_2_0, var_2_1)

	setText(var_2_0:Find("tpl/content/get/Image/Text"), i18n("island_tech_can_get"))
	setText(arg_2_0.toggle:Find("normal/Text"), i18n("island_tech_nodev"))
	setText(arg_2_0.toggle:Find("studying/Text"), i18n("island_tech_dev_starting"))
	setText(arg_2_0.toggle:Find("finished/Text"), i18n("island_tech_dev_finish_1"))

	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0.slotIds = IslandTechnologyAgency.GetSlotIds()

	arg_3_0.uiList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			arg_3_0:UpdateItem(arg_4_1, arg_4_2)
		end

		return
	end)

	arg_3_0.timeMgr = pg.TimeMgr.GetInstance()

	onButton(arg_3_0, arg_3_0._tf:Find("off"), function()
		triggerToggle(arg_3_0.toggle, false)

		return
	end, SFX_PANEL)
	onToggle(arg_3_0, arg_3_0.toggle, function(arg_6_0)
		if arg_6_0 then
			arg_3_0:OverlayPanel(arg_3_0._tf, {
				pbList = {
					arg_3_0.panel
				}
			})
		else
			arg_3_0:UnOverlayPanel(arg_3_0._tf, arg_3_0._parentTf)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.buildingData:GetDelegationSlotData(arg_7_0.slotIds[arg_7_1 + 1])
	local var_7_1 = var_7_0 and var_7_0:GetFormulaId()

	setActive(arg_7_2:Find("lock"), not var_7_0)
	setActive(arg_7_2:Find("empty"), var_7_0 and not var_7_1)
	setActive(arg_7_2:Find("content"), var_7_1)

	if var_7_1 then
		local var_7_2 = arg_7_2:Find("content")

		setText(var_7_2:Find("title"), arg_7_0.technologyAgency:GetTechnologyByFormulaId(var_7_1):getConfig("tech_name"))

		local var_7_3 = var_7_0:GetSlotRoleData()

		setActive(var_7_2:Find("icon_bg"), var_7_3)

		if var_7_3 then
			GetImageSpriteFromAtlasAsync("squareicon/" .. IslandShip.StaticGetPrefab(var_7_3.ship_id), "", var_7_2:Find("icon_bg/mask/icon"))

			local var_7_4 = var_7_3:GetFinishTime() - arg_7_0.timeMgr:GetServerTime()

			setSlider(var_7_2:Find("silder"), 0, 1, 1 - var_7_4 / var_7_3:GetAllTime())
			setText(var_7_2:Find("silder/Text"), arg_7_0.timeMgr:DescCDTime(var_7_4))
		end

		local var_7_5 = var_7_0:GetSlotRewardData()

		setActive(var_7_2:Find("get"), var_7_5)
		setActive(var_7_2:Find("silder"), not var_7_5)
	end

	return
end

function var_0_0.Flush(arg_8_0)
	arg_8_0:StopTimer()

	local var_8_0 = getProxy(IslandProxy):GetIsland()

	arg_8_0.technologyAgency = var_8_0:GetTechnologyAgency()
	arg_8_0.buildingData = var_8_0:GetBuildingAgency():GetBuilding(IslandTechnologyAgency.PLACE_ID)

	arg_8_0.uiList:align(#arg_8_0.slotIds)
	arg_8_0:StartTimer()
	arg_8_0:UpdateTime()

	return
end

function var_0_0.GetToggleStatus(arg_9_0)
	if underscore.any(arg_9_0.slotIds, function(arg_10_0)
		local var_10_0 = arg_9_0.buildingData:GetDelegationSlotData(arg_10_0)

		return var_10_0 and var_10_0:GetSlotRewardData()
	end) then
		return var_0_0.TOGGLE_STATUS.FINISHED
	end

	if underscore.any(arg_9_0.slotIds, function(arg_11_0)
		local var_11_0 = arg_9_0.buildingData:GetDelegationSlotData(arg_11_0)

		return var_11_0 and var_11_0:GetSlotRoleData()
	end) then
		return var_0_0.TOGGLE_STATUS.STUDYING
	end

	return var_0_0.TOGGLE_STATUS.NORMAL
end

function var_0_0.UpdateToggleStatus(arg_12_0)
	eachChild(arg_12_0.toggle, function(arg_13_0)
		setActive(arg_13_0, arg_13_0.name == arg_12_0.status)

		return
	end)

	return
end

function var_0_0.QuickGetAward(arg_14_0)
	local var_14_0 = underscore.detect(arg_14_0.slotIds, function(arg_15_0)
		local var_15_0 = arg_14_0.buildingData:GetDelegationSlotData(arg_15_0)

		return var_15_0 and var_15_0:GetSlotRewardData()
	end)
	local var_14_1 = arg_14_0.technologyAgency:GetTechnologyByFormulaId(arg_14_0.buildingData:GetDelegationSlotData(var_14_0):GetSlotRewardData().formula_id).id

	arg_14_0:emit(IslandMediator.GET_DELEGATION_AWARD, IslandTechnologyAgency.PLACE_ID, var_14_0, 2, function()
		existCall(arg_14_0.contextData.onGetAwardDone, var_14_1)

		return
	end)

	return
end

function var_0_0.UpdateTime(arg_17_0)
	arg_17_0.status = arg_17_0:GetToggleStatus()

	arg_17_0.uiList:eachActive(function(arg_18_0, arg_18_1)
		local var_18_0 = arg_17_0.buildingData:GetDelegationSlotData(arg_17_0.slotIds[arg_18_0 + 1])

		if var_18_0 and var_18_0:GetFormulaId() then
			local var_18_1 = arg_18_1:Find("content")
			local var_18_2 = var_18_0:GetSlotRoleData()

			setActive(var_18_1:Find("icon_bg"), var_18_2)

			if var_18_2 then
				local var_18_3 = var_18_2:GetFinishTime() - arg_17_0.timeMgr:GetServerTime()

				setSlider(var_18_1:Find("silder"), 0, 1, 1 - var_18_3 / var_18_2:GetAllTime())

				local var_18_4 = var_18_3 > 0 and arg_17_0.timeMgr:DescCDTime(var_18_3) or "00:00:00"

				setText(var_18_1:Find("silder/Text"), var_18_4)
			end

			local var_18_5 = var_18_0:GetSlotRewardData()

			setActive(var_18_1:Find("get"), var_18_5)
			setActive(var_18_1:Find("silder"), not var_18_5)
			onButton(arg_17_0, arg_18_1, function()
				if not var_18_5 then
					return
				end

				arg_17_0:QuickGetAward()

				return
			end, SFX_PANEL)
		else
			removeOnButton(arg_18_1)
		end

		return
	end)
	arg_17_0:UpdateToggleStatus()

	return
end

function var_0_0.StartTimer(arg_20_0)
	arg_20_0.timer = Timer.New(function()
		arg_20_0:UpdateTime()

		return
	end, 1, -1)

	arg_20_0.timer:Start()

	return
end

function var_0_0.StopTimer(arg_22_0)
	if arg_22_0.timer ~= nil then
		arg_22_0.timer:Stop()

		arg_22_0.timer = nil
	end

	return
end

function var_0_0.OffToggle(arg_23_0)
	triggerToggle(arg_23_0.toggle, false)

	return
end

function var_0_0.Hide(arg_24_0)
	arg_24_0:OffToggle()
	var_0_0.super.Hide(arg_24_0)

	return
end

function var_0_0.OnDestroy(arg_25_0)
	arg_25_0:StopTimer()
	arg_25_0:UnOverlayPanel(arg_25_0._tf, arg_25_0._parentTf)

	return
end

return var_0_0
