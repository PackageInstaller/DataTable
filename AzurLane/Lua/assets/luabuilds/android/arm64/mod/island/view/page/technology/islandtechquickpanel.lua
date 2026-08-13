class = var_0_10000

local var_0_0 = "IslandTechQuickPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

var_0_1.TOGGLE_STATUS = {
	NORMAL = "normal",
	FINISHED = "finished",
	STUDYING = "studying"
}

function var_0_1.getUIName(arg_1_0)
	return "IslandTechQuickPanel"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.toggle = var_1.Find(var_2_0, "adapt/toggle")

	local var_2_1 = arg_2_0._tf

	arg_2_0.panel = var_1.Find(var_2_1, "adapt/panel")

	local var_2_2 = arg_2_0.panel
	local var_2_3 = var_1.Find(var_2_2, "content")
	local var_2_4 = var_1.Find(var_2_3, "tpl")

	setText = var_2_2

	local var_2_5 = var_2_4:Find("lock/content/tip/Text")

	i18n = var_1_10006

	var_2_2(var_2_5, var_1_10006("island_tech_lock"))

	setText = var_2_2

	local var_2_6 = var_2_4:Find("empty/content/Text")

	i18n = var_6

	var_2_2(var_2_6, var_6("island_tech_empty"))

	UIItemList = var_2_2
	arg_2_0.uiList = var_2_2.New(var_1, var_2_4)
	setText = var_3

	local var_2_7 = var_1:Find("tpl/content/get/Image/Text")

	i18n = var_6

	var_3(var_2_7, var_6("island_tech_can_get"))

	setText = var_3

	local var_2_8 = arg_2_0.toggle
	local var_2_9 = var_5.Find(var_2_8, "normal/Text")

	i18n = var_6

	var_3(var_2_9, var_6("island_tech_nodev"))

	setText = var_3

	local var_2_10 = arg_2_0.toggle
	local var_2_11 = var_5.Find(var_2_10, "studying/Text")

	i18n = var_6

	var_3(var_2_11, var_6("island_tech_dev_starting"))

	setText = var_3

	local var_2_12 = arg_2_0.toggle
	local var_2_13 = var_5.Find(var_2_12, "finished/Text")

	i18n = var_6

	var_3(var_2_13, var_6("island_tech_dev_finish_1"))

	return
end

function var_0_1.OnInit(arg_3_0)
	IslandTechnologyAgency = var_1_10001
	arg_3_0.slotIds = var_1_10001.GetSlotIds()

	local var_3_0 = arg_3_0.uiList

	var_1.make(var_3_0, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			local var_4_0 = arg_3_0

			var_3.UpdateItem(var_4_0, arg_4_1, arg_4_2)
		end

		return
	end)

	pg = var_1
	arg_3_0.timeMgr = var_1.TimeMgr.GetInstance()
	onButton = var_1

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0._tf
	local var_3_3 = var_4.Find(var_3_2, "off")

	local function var_3_4()
		triggerToggle = var_2_10000

		var_2_10000(arg_3_0.toggle, false)

		return
	end

	SFX_PANEL = var_3_2

	var_1(var_3_1, var_3_3, var_3_4, var_3_2)

	onToggle = var_1

	local var_3_5 = arg_3_0
	local var_3_6 = arg_3_0.toggle

	local function var_3_7(arg_6_0)
		if arg_6_0 then
			local var_6_0 = arg_3_0

			var_1.OverlayPanel(var_6_0, arg_3_0._tf, {
				pbList = {
					arg_3_0.panel
				}
			})
		else
			local var_6_1 = arg_3_0

			var_1.UnOverlayPanel(var_6_1, arg_3_0._tf, arg_3_0._parentTf)
		end

		return
	end

	SFX_PANEL = var_3_2

	var_1(var_3_5, var_3_6, var_3_7, var_3_2)

	return
end

function var_0_1.UpdateItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.slotIds[arg_7_1 + 1]
	local var_7_1 = arg_7_0.buildingData
	local var_7_2 = var_4.GetDelegationSlotData(var_7_1, var_7_0) and var_4:GetFormulaId()

	setActive = var_7_1

	var_7_1(arg_7_2:Find("lock"), not var_4)

	setActive = var_7_1

	var_7_1(arg_7_2:Find("empty"), var_4 and not var_7_2)

	setActive = var_7_1

	var_7_1(arg_7_2:Find("content"), var_7_2)

	if var_7_2 then
		local var_7_3 = arg_7_2
		local var_7_4 = arg_7_2.Find(var_7_3, "content")
		local var_7_5 = arg_7_0.technologyAgency
		local var_7_6 = var_7.GetTechnologyByFormulaId(var_7_5, var_7_2)

		setText = var_7_3

		var_7_3(var_7_4:Find("title"), var_7_6:getConfig("tech_name"))

		local var_7_7 = var_4
		local var_7_8 = var_4.GetSlotRoleData(var_7_7)

		setActive = var_7_5

		var_7_5(var_7_4:Find("icon_bg"), var_7_8)

		if var_7_8 then
			IslandShip = var_7_5

			local var_7_9 = var_7_5.StaticGetPrefab(var_7_8.ship_id)

			GetImageSpriteFromAtlasAsync = var_7_7

			var_7_7("squareicon/" .. var_7_9, "", var_7_4:Find("icon_bg/mask/icon"))

			var_7_7 = var_7_8:GetFinishTime()

			local var_7_10 = arg_7_0.timeMgr

			var_7_7 = var_7_7 - var_11.GetServerTime(var_7_10)
			setSlider = var_11

			var_11(var_7_4:Find("silder"), 0, 1, 1 - var_7_7 / var_7_8:GetAllTime())

			setText = var_11

			local var_7_11 = var_7_4:Find("silder/Text")
			local var_7_12 = arg_7_0.timeMgr

			var_11(var_7_11, var_14.DescCDTime(var_7_12, var_7_7))
		end

		local var_7_13 = var_4:GetSlotRewardData()

		setActive = var_7_7

		var_7_7(var_7_4:Find("get"), var_7_13)

		setActive = var_7_7

		var_7_7(var_7_4:Find("silder"), not var_7_13)
	end

	return
end

function var_0_1.Flush(arg_8_0)
	local var_8_0 = arg_8_0

	arg_8_0.StopTimer(var_8_0)

	getProxy = var_1
	IslandProxy = var_8_0

	local var_8_1 = var_1(var_8_0)
	local var_8_2 = var_1.GetIsland(var_8_1)

	arg_8_0.technologyAgency = var_1.GetTechnologyAgency(var_8_2)

	local var_8_3 = var_1:GetBuildingAgency()
	local var_8_4 = var_2.GetBuilding

	IslandTechnologyAgency = var_1_10005
	arg_8_0.buildingData = var_8_4(var_8_3, var_1_10005.PLACE_ID)

	local var_8_5 = arg_8_0.uiList

	var_2.align(var_8_5, #arg_8_0.slotIds)
	arg_8_0:StartTimer()
	arg_8_0:UpdateTime()

	return
end

function var_0_1.GetToggleStatus(arg_9_0)
	underscore = var_1_10001

	if var_1_10001.any(arg_9_0.slotIds, function(arg_10_0)
		local var_10_0 = arg_9_0.buildingData

		return var_1.GetDelegationSlotData(var_10_0, arg_10_0) and var_1:GetSlotRewardData()
	end) then
		return var_0_1.TOGGLE_STATUS.FINISHED
	end

	underscore = var_1

	if var_1.any(arg_9_0.slotIds, function(arg_11_0)
		local var_11_0 = arg_9_0.buildingData

		return var_1.GetDelegationSlotData(var_11_0, arg_11_0) and var_1:GetSlotRoleData()
	end) then
		return var_0_1.TOGGLE_STATUS.STUDYING
	end

	return var_0_1.TOGGLE_STATUS.NORMAL
end

function var_0_1.UpdateToggleStatus(arg_12_0)
	eachChild = var_1_10001

	var_1_10001(arg_12_0.toggle, function(arg_13_0)
		setActive = var_2_10001

		var_2_10001(arg_13_0, arg_13_0.name == arg_12_0.status)

		return
	end)

	return
end

function var_0_1.QuickGetAward(arg_14_0)
	underscore = var_1_10001

	local var_14_0 = var_1_10001.detect(arg_14_0.slotIds, function(arg_15_0)
		local var_15_0 = arg_14_0.buildingData

		return var_1.GetDelegationSlotData(var_15_0, arg_15_0) and var_1:GetSlotRewardData()
	end)
	local var_14_1 = arg_14_0.buildingData
	local var_14_2 = var_2.GetDelegationSlotData(var_14_1, var_14_0)
	local var_14_3 = var_2.GetSlotRewardData(var_14_2).formula_id
	local var_14_4 = arg_14_0.technologyAgency
	local var_14_5 = var_3.GetTechnologyByFormulaId(var_14_4, var_14_3).id
	local var_14_6 = arg_14_0
	local var_14_7 = arg_14_0.emit

	IslandMediator = var_1_10007

	local var_14_8 = var_1_10007.GET_DELEGATION_AWARD

	IslandTechnologyAgency = var_1_10008

	var_14_7(var_14_6, var_14_8, var_1_10008.PLACE_ID, var_14_0, 2, function()
		existCall = var_2_10000

		var_2_10000(arg_14_0.contextData.onGetAwardDone, var_14_5)

		return
	end)

	return
end

function var_0_1.UpdateTime(arg_17_0)
	arg_17_0.status = arg_17_0:GetToggleStatus()

	local var_17_0 = arg_17_0.uiList

	var_1.eachActive(var_17_0, function(arg_18_0, arg_18_1)
		local var_18_0 = arg_17_0.slotIds[arg_18_0 + 1]
		local var_18_1 = arg_17_0.buildingData

		if var_3.GetDelegationSlotData(var_18_1, var_18_0) and var_3:GetFormulaId() then
			local var_18_2 = arg_18_1

			var_18_1 = arg_18_1.Find(var_18_2, "content")

			local var_18_3 = var_3
			local var_18_4 = var_3.GetSlotRoleData(var_18_3)

			setActive = var_18_2

			var_18_2(var_18_1:Find("icon_bg"), var_18_4)

			if var_18_4 then
				local var_18_5 = var_18_4:GetFinishTime()
				local var_18_6 = arg_17_0.timeMgr
				local var_18_7 = var_18_5 - var_18_3.GetServerTime(var_18_6)

				setSlider = var_18_3

				var_18_3(var_18_1:Find("silder"), 0, 1, 1 - var_18_7 / var_18_4:GetAllTime())

				setText = var_18_3

				local var_18_8 = var_18_1:Find("silder/Text")

				if var_18_7 > 0 then
					local var_18_9 = arg_17_0.timeMgr
					local var_18_10

					if not var_11.DescCDTime(var_18_9, var_18_7) then
						var_18_10 = "00:00:00"
					end

					var_18_3(var_18_8, var_18_10)

					local var_18_11 = var_3:GetSlotRewardData()

					setActive = var_18_3

					var_18_3(var_18_1:Find("get"), var_18_11)

					setActive = var_18_3

					var_18_3(var_18_1:Find("silder"), not var_18_11)

					onButton = var_18_3

					local var_18_12 = arg_17_0
					local var_18_13 = arg_18_1

					local function var_18_14()
						if not var_18_11 then
							return
						end

						local var_19_0 = arg_17_0

						var_0.QuickGetAward(var_19_0)

						return
					end

					SFX_PANEL = var_13

					var_18_3(var_18_12, var_18_13, var_18_14, var_13)

					goto label_18_0

					removeOnButton = var_18_1

					var_18_1(arg_18_1)

					::label_18_0::

					return
				end
			end
		end
	end)
	arg_17_0:UpdateToggleStatus()

	return
end

function var_0_1.StartTimer(arg_20_0)
	Timer = var_1_10001
	arg_20_0.timer = var_1_10001.New(function()
		local var_21_0 = arg_20_0

		var_0.UpdateTime(var_21_0)

		return
	end, 1, -1)

	local var_20_0 = arg_20_0.timer

	var_1.Start(var_20_0)

	return
end

function var_0_1.StopTimer(arg_22_0)
	if arg_22_0.timer ~= nil then
		local var_22_0 = arg_22_0.timer

		var_1.Stop(var_22_0)

		arg_22_0.timer = nil
	end

	return
end

function var_0_1.OffToggle(arg_23_0)
	triggerToggle = var_1_10001

	var_1_10001(arg_23_0.toggle, false)

	return
end

function var_0_1.Hide(arg_24_0)
	arg_24_0:OffToggle()
	var_0_1.super.Hide(arg_24_0)

	return
end

function var_0_1.OnDestroy(arg_25_0)
	arg_25_0:StopTimer()
	arg_25_0:UnOverlayPanel(arg_25_0._tf, arg_25_0._parentTf)

	return
end

return var_0_1
