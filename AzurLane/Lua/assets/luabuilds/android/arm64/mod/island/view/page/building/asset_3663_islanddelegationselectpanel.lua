class = var_0_10000

local var_0_0 = "IslandDelegationSelectPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandDelegationSelectPanel"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_0, "close")

	local var_2_1 = arg_2_0._tf

	arg_2_0.layoutTF = var_1.Find(var_2_1, "layout")

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.Find(var_2_2, "layout/select_container/selectInfo")

	arg_2_0.slotNameTF = var_1.Find(var_2_3, "slotName")
	arg_2_0.unlockSlot = var_1:Find("unlock")
	arg_2_0.lockSlot = var_1:Find("lock")

	local var_2_4 = arg_2_0.unlockSlot

	arg_2_0.emptyAddShipTF = var_2.Find(var_2_4, "empty")

	local var_2_5 = arg_2_0.unlockSlot

	arg_2_0.quickBtn = var_2.Find(var_2_5, "emptyBtn")

	local var_2_6 = arg_2_0.unlockSlot

	arg_2_0.contentTF = var_2.Find(var_2_6, "content")

	local var_2_7 = arg_2_0.contentTF

	arg_2_0.processTF = var_2.Find(var_2_7, "process")

	local var_2_8 = arg_2_0.processTF

	arg_2_0.selectShipTF = var_2.Find(var_2_8, "ship/selectShip")

	local var_2_9 = arg_2_0.selectShipTF

	arg_2_0.selectShipBtn = var_2.Find(var_2_9, "selectShipButton")

	local var_2_10 = arg_2_0.selectShipTF

	arg_2_0.energySliderTF = var_2.Find(var_2_10, "energy/energy_bar")

	local var_2_11 = arg_2_0.selectShipTF

	arg_2_0.energyTFText = var_2.Find(var_2_11, "energy/Text")

	local var_2_12 = arg_2_0.selectShipTF

	arg_2_0.seletShipName = var_2.Find(var_2_12, "name")

	local var_2_13 = arg_2_0.selectShipTF

	arg_2_0.shipIconTF = var_2.Find(var_2_13, "icon_mask/icon")

	local var_2_14 = arg_2_0.selectShipTF

	arg_2_0.expGetTF = var_2.Find(var_2_14, "exp_get")
	setActive = var_2

	var_2(arg_2_0.expGetTF, false)

	local var_2_15 = arg_2_0.processTF

	arg_2_0.selectFormulaBtn = var_2.Find(var_2_15, "selectFormula")

	local var_2_16 = arg_2_0.processTF

	arg_2_0.inprocessFormulaTF = var_2.Find(var_2_16, "inprocess")

	local var_2_17 = arg_2_0.inprocessFormulaTF

	arg_2_0.inproduction = var_2.Find(var_2_17, "inproduction")

	local var_2_18 = arg_2_0.inproduction

	arg_2_0.speedupBtn = var_2.Find(var_2_18, "quick")

	local var_2_19 = arg_2_0.inproduction

	arg_2_0.timeTF = var_2.Find(var_2_19, "time/Text")

	local var_2_20 = arg_2_0.inproduction

	arg_2_0.roleDelegationSliderTF = var_2.Find(var_2_20, "time/time_bar")

	local var_2_21 = arg_2_0.inprocessFormulaTF

	arg_2_0.currentFormula = var_2.Find(var_2_21, "formulalayout/formula")

	local var_2_22 = arg_2_0.currentFormula

	arg_2_0.currentFormulaIcon = var_2.Find(var_2_22, "curformula")

	local var_2_23 = arg_2_0.currentFormulaIcon

	arg_2_0.currentFormulaNum = var_2.Find(var_2_23, "product_count_bg/product_count")

	local var_2_24 = arg_2_0.currentFormula

	arg_2_0.currentFormulaLastNum = var_2.Find(var_2_24, "tips_num")

	local var_2_25 = arg_2_0.currentFormula
	local var_2_26 = var_2.Find(var_2_25, "process")
	local var_2_27 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_2_0.formulaProcess = var_2_27(var_2_26, var_5(var_1_10007))

	local var_2_28 = arg_2_0.inprocessFormulaTF

	arg_2_0.extraProduct = var_2.Find(var_2_28, "formulalayout/second_formula")

	local var_2_29 = arg_2_0.extraProduct

	arg_2_0.extraProductIcon = var_2.Find(var_2_29, "bg/icon")

	local var_2_30 = arg_2_0.extraProduct

	arg_2_0.extraProductName = var_2.Find(var_2_30, "name")

	local var_2_31 = arg_2_0.extraProductIcon

	arg_2_0.extraProductNum = var_2.Find(var_2_31, "product_count_bg/product_count")

	local var_2_32 = arg_2_0.extraProduct

	arg_2_0.extraProductLastNum = var_2.Find(var_2_32, "name/num")

	local var_2_33 = arg_2_0.inprocessFormulaTF

	arg_2_0.currentExtroFormula = var_2.Find(var_2_33, "formulalayout/second_formula")

	local var_2_34 = arg_2_0.contentTF

	arg_2_0.finishTF = var_2.Find(var_2_34, "finish")

	local var_2_35 = arg_2_0.finishTF

	arg_2_0.finishFurmalaIcon = var_2.Find(var_2_35, "formulalayout/formula/curformula")
	setText = var_2

	local var_2_36 = arg_2_0.finishTF
	local var_2_37 = var_4.Find(var_2_36, "formulalayout/formula/tips")

	i18n = var_5

	var_2(var_2_37, var_5("island_production_finish"))

	local var_2_38 = arg_2_0.contentTF

	arg_2_0.stopBtn = var_2.Find(var_2_38, "btns/stop")

	local var_2_39 = arg_2_0.contentTF

	arg_2_0.getBtn = var_2.Find(var_2_39, "btns/get")

	local var_2_40 = arg_2_0.contentTF

	arg_2_0.addBtn = var_2.Find(var_2_40, "btns/add")

	local var_2_41 = arg_2_0.getBtn

	arg_2_0.canRewardIcon = var_2.Find(var_2_41, "hasicon")

	local var_2_42 = arg_2_0.getBtn

	arg_2_0.canRewardNum = var_2.Find(var_2_42, "num")

	local var_2_43 = arg_2_0.getBtn

	arg_2_0.canExtraRewardIcon = var_2.Find(var_2_43, "extraIcon")

	local var_2_44 = arg_2_0.getBtn

	arg_2_0.canExtraRewardNum = var_2.Find(var_2_44, "extraNum")

	local var_2_45 = arg_2_0.processTF

	arg_2_0.shipDetailsBtn = var_2.Find(var_2_45, "ship/details")

	local var_2_46 = arg_2_0._tf

	arg_2_0.shipDetailsPanel = var_2.Find(var_2_46, "layout/ship_container")

	local var_2_47 = arg_2_0.shipDetailsPanel

	arg_2_0.shipDetailBack = var_2.Find(var_2_47, "back")

	local var_2_48 = arg_2_0.shipDetailsPanel

	arg_2_0.shipSkillEmp = var_2.Find(var_2_48, "skillEmp")

	local var_2_49 = arg_2_0.shipDetailsPanel

	arg_2_0.shipSkillEmpDes = var_2.Find(var_2_49, "skillEmp/Text")

	local var_2_50 = arg_2_0.shipDetailsPanel

	arg_2_0.shipSkillDetails = var_2.Find(var_2_50, "skill")

	local var_2_51 = arg_2_0.shipSkillDetails

	arg_2_0.shipDetailsIcon = var_2.Find(var_2_51, "icon")

	local var_2_52 = arg_2_0.shipSkillDetails
	local var_2_53 = var_2.Find(var_2_52, "name")
	local var_2_54 = var_2.GetComponent

	typeof = var_5
	Text = var_7
	arg_2_0.shipDetailsName = var_2_54(var_2_53, var_5(var_7))

	local var_2_55 = arg_2_0.shipSkillDetails
	local var_2_56 = var_2.Find(var_2_55, "desc/Text")
	local var_2_57 = var_2.GetComponent

	typeof = var_5
	Text = var_7
	arg_2_0.shipDetailsDes = var_2_57(var_2_56, var_5(var_7))
	setText = var_2

	local var_2_58 = arg_2_0.shipDetailsPanel
	local var_2_59 = var_4.Find(var_2_58, "title")

	i18n = var_5

	var_2(var_2_59, var_5("island_production_character_info"))

	setText = var_2

	local var_2_60 = arg_2_0.getBtn
	local var_2_61 = var_4.Find(var_2_60, "Text")

	i18n = var_5

	var_2(var_2_61, var_5("island_production_collect"))

	setText = var_2

	local var_2_62 = arg_2_0.addBtn
	local var_2_63 = var_4.Find(var_2_62, "num")

	i18n = var_5

	var_2(var_2_63, var_5("island_additional_production_tip1"))

	setText = var_2

	local var_2_64 = arg_2_0.currentFormula
	local var_2_65 = var_4.Find(var_2_64, "tips")

	i18n = var_5

	var_2(var_2_65, var_5("island_production_count"))

	setText = var_2

	local var_2_66 = arg_2_0.quickBtn
	local var_2_67 = var_4.Find(var_2_66, "Text")

	i18n = var_5

	var_2(var_2_67, var_5("island_quick_delegation"))
	arg_2_0:ApplyDiff()

	UIItemList = var_2

	local var_2_68 = var_2.New
	local var_2_69 = arg_2_0.extraProduct
	local var_2_70 = var_4.Find(var_2_69, "process")
	local var_2_71 = arg_2_0.extraProduct

	arg_2_0.extraProductList = var_2_68(var_2_70, var_5.Find(var_2_71, "process/item"))

	return
end

function var_0_1.ApplyDiff(arg_3_0)
	if arg_3_0.contextData and arg_3_0.contextData.isPermanent then
		setActive = var_1

		var_1(arg_3_0.closeBtn, false)
	end

	if arg_3_0.contextData and arg_3_0.contextData.alignRight then
		local var_3_0 = arg_3_0.layoutTF

		Vector2 = var_1_10002
		var_3_0.anchorMin = var_1_10002(1, 0.5)

		local var_3_1 = arg_3_0.layoutTF

		Vector2 = var_2
		var_3_1.anchorMax = var_2(1, 0.5)

		local var_3_2 = arg_3_0.layoutTF

		Vector2 = var_2
		var_3_2.pivot = var_2(1, 0.5)
		setAnchoredPosition = var_3_2

		var_3_2(arg_3_0.layoutTF, {
			x = -35,
			y = 0
		})
	end

	return
end

function var_0_1.OnInit(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.closeBtn

	local function var_4_2()
		local var_5_0 = arg_4_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_4_0, var_4_1, var_4_2, var_1_10006)

	onButton = var_1_10001

	var_1_10001(arg_4_0, arg_4_0.shipDetailsBtn, function()
		local var_6_0 = arg_4_0

		var_0.ShowDetailPanel(var_6_0)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_4_0, arg_4_0.shipDetailBack, function()
		local var_7_0 = arg_4_0

		var_0.HideDetailPanel(var_7_0)

		return
	end)

	onButton = var_1_10001

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.emptyAddShipTF

	local function var_4_5()
		local var_8_0 = arg_4_0

		var_0.OpenShipSelectPage(var_8_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_4_3, var_4_4, var_4_5, var_1_10006)

	onButton = var_1_10001

	local var_4_6 = arg_4_0
	local var_4_7 = arg_4_0.selectShipBtn

	local function var_4_8()
		local var_9_0 = arg_4_0

		var_0.OpenShipSelectPage(var_9_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_4_6, var_4_7, var_4_8, var_1_10006)

	onButton = var_1_10001

	local var_4_9 = arg_4_0
	local var_4_10 = arg_4_0.selectFormulaBtn

	local function var_4_11()
		local var_10_0 = arg_4_0

		var_0.OpenFormulaSelectPage(var_10_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_4_9, var_4_10, var_4_11, var_1_10006)

	onButton = var_1_10001

	local var_4_12 = arg_4_0
	local var_4_13 = arg_4_0.getBtn

	local function var_4_14()
		getProxy = var_2_10000
		IslandProxy = var_2_10002

		local var_11_0 = var_2_10000(var_2_10002)
		local var_11_1 = var_0.GetIsland(var_11_0)
		local var_11_2 = var_0.GetBuildingAgency(var_11_1)
		local var_11_3 = var_0.GetBuilding(var_11_2, arg_4_0.placeId)

		if not var_0.GetDelegationSlotData(var_11_3, arg_4_0.slotId) then
			return
		end

		local var_11_4 = not var_1:GetSlotRoleData() and var_1:GetSlotRewardData() and 2 or 1
		local var_11_5 = arg_4_0
		local var_11_6 = var_4.emit

		IslandMediator = var_2_10007

		var_11_6(var_11_5, var_2_10007.GET_DELEGATION_AWARD, arg_4_0.placeId, arg_4_0.slotId, var_11_4, nil, arg_4_0.contextData.isPost)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_4_12, var_4_13, var_4_14, var_1_10006)

	onButton = var_1_10001

	local var_4_15 = arg_4_0
	local var_4_16 = arg_4_0.stopBtn

	local function var_4_17()
		local var_12_0 = arg_4_0
		local var_12_1 = var_0.emit

		IslandMediator = var_2_10003

		var_12_1(var_12_0, var_2_10003.STOP_DELEGATION, arg_4_0.placeId, arg_4_0.slotId)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_4_15, var_4_16, var_4_17, var_1_10006)

	onButton = var_1_10001

	local var_4_18 = arg_4_0
	local var_4_19 = arg_4_0.speedupBtn

	local function var_4_20()
		local var_13_0 = arg_4_0
		local var_13_1 = var_0.emit

		IslandMediator = var_2_10003

		local var_13_2 = var_2_10003.OPEN_PAGE
		local var_13_3 = "IslandTicketUsePage"
		local var_13_4 = {}

		IslandUseTicketCommand = var_2_10006
		var_13_4[1] = var_2_10006.TYPES.APPOINT
		var_13_4[2] = arg_4_0.slotId

		var_13_1(var_13_0, var_13_2, var_13_3, var_13_4)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_4_18, var_4_19, var_4_20, var_1_10006)

	local var_4_21 = arg_4_0.extraProductList

	var_1.make(var_4_21, function(arg_14_0, arg_14_1, arg_14_2)
		UIItemList = var_2_10003

		if arg_14_0 == var_2_10003.EventInit then
			-- block empty
		else
			UIItemList = var_3

			if arg_14_0 == var_3.EventUpdate then
				local var_14_0 = arg_14_1 < arg_4_0.extraProcess

				setActive = var_2_10004

				var_2_10004(arg_14_2:Find("inprocess"), var_14_0)
			end
		end

		return
	end)

	onButton = var_1

	local var_4_22 = arg_4_0
	local var_4_23 = arg_4_0.quickBtn

	local function var_4_24()
		local var_15_0, var_15_1 = (function()
			IslandStartDelegationCommand = var_3_10000

			local var_16_0 = var_3_10000.GetLocalKeyForLastData(arg_4_0.slotId)

			PlayerPrefs = var_3_10001

			local var_16_1 = var_3_10001.GetString(var_16_0, "")

			UnpackIntFromString = var_2

			return var_2(var_16_1)
		end)()

		pg = var_2_10003

		local var_15_2 = var_2_10003.island_formula[var_15_1]

		math = var_2_10004

		local var_15_3 = var_2_10004.floor
		local var_15_4 = var_15_2.stamina_cost

		IslandProductCostHelper = var_2_10007

		local var_15_5 = var_15_3(var_15_4 * (1 - var_2_10007.GetReducePercentInPlace(var_15_0, arg_4_0.placeId)))

		math = var_2_10005

		local var_15_6 = var_2_10005.max(var_15_5, 1)

		getProxy = var_5
		IslandProxy = var_7

		local var_15_7 = var_5(var_7)
		local var_15_8 = var_5.GetIsland(var_15_7)
		local var_15_9 = var_5.GetCharacterAgency(var_15_8)
		local var_15_10 = var_6.GetShipById(var_15_9, var_15_0)

		if not var_6.IsDelegable(var_15_10) then
			pg = var_7

			local var_15_11 = var_7.TipsMgr.GetInstance()
			local var_15_12 = var_7.ShowTips

			i18n = var_10

			var_15_12(var_15_11, var_10("island_quick_delegation_notenough_onduty", var_6:GetName()))

			arg_4_0.selectedShipId = 1
		elseif var_6:GetCurrentEnergy() < var_15_6 then
			pg = var_7

			local var_15_13 = var_7.TipsMgr.GetInstance()
			local var_15_14 = var_7.ShowTips

			i18n = var_10

			var_15_14(var_15_13, var_10("island_quick_delegation_notenough_encourage", var_6:GetName()))

			arg_4_0.selectedShipId = 1
		else
			arg_4_0.selectedShipId = var_15_0
		end

		local var_15_15 = arg_4_0

		var_7.OpenFormulaSelectPage(var_15_15, nil, nil, nil, nil, var_15_1)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_4_22, var_4_23, var_4_24, var_1_10006)

	return
end

function var_0_1.ShowDetailPanel(arg_17_0)
	setActive = var_1_10001

	var_1_10001(arg_17_0.shipDetailsPanel, true)

	local var_17_0 = arg_17_0.showShip
	local var_17_1 = var_1.GetSkill(var_17_0)
	local var_17_2 = var_1.IsUnlock(var_17_1)

	setActive = var_17_0

	var_17_0(arg_17_0.shipSkillDetails, var_17_2)

	setActive = var_17_0

	var_17_0(arg_17_0.shipSkillEmp, not var_17_2)

	setText = var_17_0

	local var_17_3 = arg_17_0.shipSkillEmpDes

	i18n = var_6

	local var_17_4 = "island_need_star"
	local var_17_5 = arg_17_0.showShip

	var_17_0(var_17_3, var_6(var_17_4, var_9.GetSkillUnlockLevel(var_17_5)))

	GetImageSpriteFromAtlasAsync = var_17_0

	var_17_0("island/IslandSkillIcon/" .. var_1:GetIcon(), "", arg_17_0.shipDetailsIcon)

	local var_17_6 = arg_17_0.shipDetailsName

	string = var_17_1
	var_17_6.text = var_17_1.format("%s - %s", var_1:GetName(), "[Lv." .. var_1:GetLevel() .. "]")
	arg_17_0.shipDetailsDes.text = var_1:GetEffectDesc()

	return
end

function var_0_1.HideDetailPanel(arg_18_0)
	setActive = var_1_10001

	var_1_10001(arg_18_0.shipDetailsPanel, false)

	return
end

function var_0_1.Show(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	arg_19_0.super.Show(arg_19_0)

	arg_19_0.loadCharacterFunc = arg_19_3
	arg_19_0.unLoadCharacterFunc = arg_19_4
	arg_19_0.selectedShipId = arg_19_2
	arg_19_0.commissionId = arg_19_1 or arg_19_0.commissionId
	pg = var_5
	arg_19_0.slotId = var_5.island_production_commission[arg_19_0.commissionId].slot
	pg = var_5
	arg_19_0.placeId = var_5.island_production_slot[arg_19_0.slotId].place

	local var_19_0 = arg_19_0.placeId

	IslandProductConst = var_6

	if var_19_0 == var_6.PasturePlaceId then
		IslandGuideChecker = var_19_0

		var_19_0.CheckGuide("ISLAND_GUIDE_24")
	end

	pg = var_19_0
	arg_19_0.timeMgr = var_19_0.TimeMgr.GetInstance()

	arg_19_0:HideDetailPanel()
	arg_19_0:Flush()

	return
end

function var_0_1.Flush(arg_20_0)
	arg_20_0:FlushInfos()
	arg_20_0:StopTimer()
	arg_20_0:StartTimer()

	return
end

function var_0_1.FlushInfos(arg_21_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_21_0 = var_1_10001(var_1_10003)
	local var_21_1 = var_1.GetIsland(var_21_0)
	local var_21_2 = var_1.GetBuildingAgency(var_21_1)
	local var_21_3 = var_1.GetBuilding(var_21_2, arg_21_0.placeId)

	arg_21_0.slotData = var_1.GetDelegationSlotData(var_21_3, arg_21_0.slotId)
	pg = var_2

	local var_21_4 = var_2.island_production_place[arg_21_0.placeId].name

	setText = var_3

	local var_21_5 = arg_21_0.slotNameTF
	local var_21_6 = var_21_4
	local var_21_7 = "-"

	pg = var_1_10008

	var_3(var_21_5, var_21_6 .. var_21_7 .. var_1_10008.island_production_commission[arg_21_0.commissionId].name)

	setActive = var_3

	var_3(arg_21_0.lockSlot, not arg_21_0.slotData)

	setActive = var_3

	var_3(arg_21_0.unlockSlot, arg_21_0.slotData)

	setActive = var_3

	var_3(arg_21_0.addBtn, false)

	setActive = var_3

	var_3(arg_21_0.canExtraRewardIcon, false)

	setActive = var_3

	var_3(arg_21_0.canExtraRewardNum, false)

	if not arg_21_0.slotData then
		return
	end

	local var_21_8 = arg_21_0.slotData
	local var_21_9

	if var_3.CanStartDelegation(var_21_8) then
		setActive = var_21_3

		var_21_3(arg_21_0.finishTF, false)

		setActive = var_21_3

		var_21_3(arg_21_0.emptyAddShipTF, not arg_21_0.selectedShipId)

		setActive = var_21_3

		var_21_3(arg_21_0.contentTF, arg_21_0.selectedShipId)

		IslandStartDelegationCommand = var_21_3
		var_21_3 = var_21_3.GetLocalKeyForLastData(arg_21_0.slotId)
		PlayerPrefs = var_21_8

		if var_21_8.GetString(var_21_3, "") ~= "" then
			setActive = var_6

			var_6(arg_21_0.quickBtn, true)
		else
			setActive = var_6

			var_6(arg_21_0.quickBtn, false)
		end

		setActive = var_6

		var_6(arg_21_0.processTF, arg_21_0.selectedShipId)

		setActive = var_6

		var_6(arg_21_0.selectShipBtn, arg_21_0.selectedShipId)

		setActive = var_6

		var_6(arg_21_0.selectFormulaBtn, arg_21_0.selectedShipId)

		setActive = var_6

		var_6(arg_21_0.inprocessFormulaTF, false)

		local var_21_10

		if arg_21_0.selectedShipId then
			getProxy = var_21_10
			IslandProxy = var_21_9
			var_21_9 = var_21_10(var_21_9)
			var_21_9 = var_21_10.GetIsland(var_21_9)
			var_21_9 = var_21_10.GetCharacterAgency(var_21_9)
			arg_21_0.showShip = var_21_10.GetShipById(var_21_9, arg_21_0.selectedShipId)
			var_21_9 = arg_21_0.showShip
			var_21_10 = var_21_10.GetCurrentEnergy(var_21_9)

			local var_21_11 = arg_21_0.showShip
			local var_21_12 = var_7.GetMaxEnergy(var_21_11)

			setText = var_21_9

			var_21_9(arg_21_0.energyTFText, var_21_10 .. "/" .. var_21_12)

			setSlider = var_21_9

			var_21_9(arg_21_0.energySliderTF, 0, 1, var_21_10 / var_21_12)

			setText = var_21_9

			local var_21_13 = arg_21_0.seletShipName
			local var_21_14 = arg_21_0.showShip

			var_21_9(var_21_13, var_11.GetName(var_21_14))

			IslandShip = var_21_9
			var_21_9 = var_21_9.StaticGetPrefab(arg_21_0.selectedShipId)
			GetImageSpriteFromAtlasAsync = var_21_11

			var_21_11("ShipYardIcon/" .. var_21_9, "", arg_21_0.shipIconTF)
		end

		setActive = var_21_10

		var_21_10(arg_21_0.stopBtn, false)

		setActive = var_21_10

		var_21_10(arg_21_0.getBtn, false)
	else
		setActive = var_21_3

		var_21_3(arg_21_0.contentTF, true)

		setActive = var_21_3

		var_21_3(arg_21_0.emptyAddShipTF, false)

		setActive = var_21_3

		var_21_3(arg_21_0.quickBtn, false)

		setActive = var_21_3

		var_21_3(arg_21_0.selectShipBtn, false)

		setActive = var_21_3

		var_21_3(arg_21_0.selectFormulaBtn, false)

		local var_21_15 = arg_21_0.slotData
		local var_21_16 = var_4.GetSlotRoleData(var_21_15)
		local var_21_17 = arg_21_0.slotData
		local var_21_18 = var_5.GetSlotRewardData(var_21_17)
		local var_21_19 = not var_21_16 and var_21_18

		setActive = var_21_17

		var_21_17(arg_21_0.processTF, not var_21_19)

		setActive = var_21_17

		var_21_17(arg_21_0.finishTF, var_21_19)

		setActive = var_21_17

		var_21_17(arg_21_0.getBtn, var_21_19)

		setActive = var_21_17

		var_21_17(arg_21_0.stopBtn, not var_21_19)

		setActive = var_21_17

		var_21_17(arg_21_0.inprocessFormulaTF, not var_21_19)

		local var_21_20

		if var_21_19 then
			var_21_17 = var_21_18.formula_id
			pg = var_21_9
			var_21_20 = var_21_9.island_formula[var_21_17].commission_product[1][1]

			local var_21_21 = var_21_18.formula_drop_list[1].num * var_8[1][2]

			Drop = var_11

			local var_21_22 = var_11.New
			local var_21_23 = {
				count = 0
			}

			DROP_TYPE_ISLAND_ITEM = var_1_10014
			var_21_23.type = var_1_10014
			var_21_23.id = var_21_20

			local var_21_24 = var_21_22(var_21_23)
			local var_21_25 = var_11.getConfigTable(var_21_24).icon

			GetImageSpriteFromAtlasAsync = var_21_23

			var_21_23("island/" .. var_21_25, "", arg_21_0.canRewardIcon)

			local var_21_26

			if not var_21_18.main_num then
				var_21_26 = 0
			end

			local var_21_27 = "×" .. var_21_21 + var_21_26

			if 0 < var_21_26 then
				setTextColor = var_1_10015

				local var_21_28 = arg_21_0.canRewardNum

				Color = var_1_10018

				var_1_10015(var_21_28, var_1_10018.NewHex("#7df39f"))
			else
				setTextColor = var_1_10015

				local var_21_29 = arg_21_0.canRewardNum

				Color = var_1_10018

				var_1_10015(var_21_29, var_1_10018.NewHex("#FFFFFF"))
			end

			setText = var_1_10015

			var_1_10015(arg_21_0.canRewardNum, var_21_27)

			pg = var_1_10015
			var_1_10015 = var_1_10015.island_formula[var_21_17].item_id
			pg = var_1_10016
			var_1_10016 = var_1_10016.island_item_data_template[var_1_10015]
			GetImageSpriteFromAtlasAsync = var_17

			var_17("island/" .. var_1_10016.icon, "", arg_21_0.finishFurmalaIcon)

			if var_21_18.formula_drop_list[2] then
				setActive = var_17

				var_17(arg_21_0.canExtraRewardIcon, true)

				setActive = var_17

				var_17(arg_21_0.canExtraRewardNum, true)

				pg = var_17

				local var_21_30 = var_17.island_formula[var_21_17].second_product_display[1][1]

				var_1_10018 = var_21_18.formula_drop_list[2].num
				pg = var_19
				var_1_10018 = var_1_10018 * var_19.island_formula[var_21_17].second_product_display[1][2]
				Drop = var_19

				local var_21_31 = var_19.New

				var_1_10021 = {
					count = 0
				}
				DROP_TYPE_ISLAND_ITEM = var_1_10022
				var_1_10021.type = var_1_10022
				var_1_10021.id = var_21_30

				local var_21_32 = var_21_31(var_1_10021)
				local var_21_33 = var_19.getConfigTable(var_21_32).icon

				GetImageSpriteFromAtlasAsync = var_1_10021

				var_1_10021("island/" .. var_21_33, "", arg_21_0.canExtraRewardIcon)

				if not var_21_18.other_num then
					var_1_10021 = 0
				end

				local var_21_34 = "×" .. var_1_10018 + var_1_10021

				if 0 < var_1_10021 then
					setTextColor = var_23

					local var_21_35 = arg_21_0.canExtraRewardNum

					Color = var_1_10026

					var_23(var_21_35, var_1_10026.NewHex("#7df39f"))
				else
					setTextColor = var_23

					local var_21_36 = arg_21_0.canExtraRewardNum

					Color = var_1_10026

					var_23(var_21_36, var_1_10026.NewHex("#FFFFFF"))
				end

				setText = var_23

				var_23(arg_21_0.canExtraRewardNum, var_21_34)
			end
		end

		if var_21_16 then
			getProxy = var_21_17
			IslandProxy = var_21_20

			local var_21_37 = var_21_17(var_21_20)
			local var_21_38 = var_7.GetIsland(var_21_37)
			local var_21_39 = var_7.GetCharacterAgency(var_21_38)

			arg_21_0.showShip = var_7.GetShipById(var_21_39, var_21_16.ship_id)

			local var_21_40 = arg_21_0.showShip
			local var_21_41 = var_7.GetCurrentEnergy(var_21_40)
			local var_21_42 = arg_21_0.showShip
			local var_21_43 = var_8.GetMaxEnergy(var_21_42)

			setText = var_21_40

			var_21_40(arg_21_0.energyTFText, var_21_41 .. "/" .. var_21_43)

			setSlider = var_21_40

			var_21_40(arg_21_0.energySliderTF, 0, 1, var_21_41 / var_21_43)

			setText = var_21_40

			local var_21_44 = arg_21_0.seletShipName
			local var_21_45 = arg_21_0.showShip

			var_21_40(var_21_44, var_12.GetName(var_21_45))

			IslandShip = var_21_40

			local var_21_46 = var_21_40.StaticGetPrefab(var_21_16.ship_id)

			GetImageSpriteFromAtlasAsync = var_21_42

			var_21_42("ShipYardIcon/" .. var_21_46, "", arg_21_0.shipIconTF)

			local var_21_47 = var_21_16.formula_id

			pg = var_11

			local var_21_48 = var_11.island_formula[var_21_47].commission_product[1][1]

			pg = var_14

			local var_21_49 = var_14.island_item_data_template[var_21_48]

			Drop = var_1_10015

			local var_21_50 = var_1_10015.New
			local var_21_51 = {
				count = 0
			}

			DROP_TYPE_ISLAND_ITEM = var_1_10018
			var_21_51.type = var_1_10018
			var_21_51.id = var_21_48

			local var_21_52 = var_21_50(var_21_51)

			onButton = var_1_10016

			var_1_10016(arg_21_0, arg_21_0.currentFormulaIcon, function()
				local var_22_0 = arg_21_0.contextData
				local var_22_1 = var_0.ShowMsgBox
				local var_22_2 = {}

				i18n = var_2_10004
				var_22_2.title = var_2_10004("island_word_desc")
				IslandMsgBox = var_4
				var_22_2.type = var_4.TYPE_COMMON_DROP_DESCRIBE
				var_22_2.dropData = var_21_52

				var_22_1(var_22_0, var_22_2)

				return
			end)

			GetImageSpriteFromAtlasAsync = var_1_10016

			var_1_10016("island/" .. var_21_49.icon, "", arg_21_0.currentFormulaIcon)

			setText = var_1_10016

			var_1_10016(arg_21_0.currentFormulaNum, "×" .. var_11.commission_product[1][2])

			GetImageSpriteFromAtlasAsync = var_1_10016

			var_1_10016("island/" .. var_21_49.icon, "", arg_21_0.canRewardIcon)

			getProxy = var_1_10016
			IslandProxy = var_18

			local var_21_53 = var_1_10016(var_18)
			local var_21_54 = var_16.GetIsland(var_21_53)
			local var_21_55 = var_16.GetAblityAgency(var_21_54)

			if #var_11.second_product == 0 or not var_21_55:IsUnlcokSecondProduct(var_21_47) then
				setActive = var_17

				var_17(arg_21_0.extraProduct, false)

				setActive = var_17

				var_17(arg_21_0.canExtraRewardIcon, false)

				setActive = var_17

				var_17(arg_21_0.canExtraRewardNum, false)
			else
				setActive = var_17

				var_17(arg_21_0.extraProduct, true)

				local var_21_56 = var_11.second_product_display[1][1]

				pg = var_19

				local var_21_57 = var_19.island_item_data_template[var_21_56]

				GetImageSpriteFromAtlasAsync = var_20

				var_20("island/" .. var_21_57.icon, "", arg_21_0.extraProductIcon)

				GetImageSpriteFromAtlasAsync = var_20

				var_20("island/" .. var_21_57.icon, "", arg_21_0.canExtraRewardIcon)

				setText = var_20

				var_20(arg_21_0.extraProductName, var_21_57.name)

				setText = var_20

				var_20(arg_21_0.extraProductNum, "×" .. var_17[1][2])

				Drop = var_20

				local var_21_58 = var_20.New
				local var_21_59 = {
					count = 0
				}

				DROP_TYPE_ISLAND_ITEM = var_23
				var_21_59.type = var_23
				var_21_59.id = var_21_56

				local var_21_60 = var_21_58(var_21_59)

				onButton = var_1_10021

				var_1_10021(arg_21_0, arg_21_0.extraProductIcon, function()
					local var_23_0 = arg_21_0.contextData
					local var_23_1 = var_0.ShowMsgBox
					local var_23_2 = {}

					i18n = var_2_10004
					var_23_2.title = var_2_10004("island_word_desc")
					IslandMsgBox = var_4
					var_23_2.type = var_4.TYPE_COMMON_DROP_DESCRIBE
					var_23_2.dropData = var_21_60

					var_23_1(var_23_0, var_23_2)

					return
				end)
			end
		end
	end

	return
end

function var_0_1.AfterShipSelect(arg_24_0, arg_24_1)
	arg_24_0.selectedShipId = arg_24_1

	arg_24_0:Flush()

	existCall = var_2

	var_2(arg_24_0.loadCharacterFunc, arg_24_0.selectedShipId)
	arg_24_0:OpenFormulaSelectPage()

	return
end

function var_0_1.OpenShipSelectPage(arg_25_0)
	pg = var_1_10001

	local var_25_0 = var_1_10001.island_production_slot[arg_25_0.slotId].attribute
	local var_25_1 = arg_25_0
	local var_25_2 = arg_25_0.emit

	IslandMediator = var_1_10005

	local var_25_3 = var_1_10005.OPEN_PAGE
	local var_25_4 = "IslandShipSelectPage"
	local var_25_5 = {}
	local var_25_6 = {
		needWorkSpeed = true
	}

	IslandSelectShipCard = var_1_10009
	var_25_6.showType = var_1_10009.SHOW_TYPE.PLACE
	var_25_6.attrType = var_25_0

	function var_25_6.confirmFunc(arg_26_0)
		local var_26_0 = arg_25_0

		var_1.AfterShipSelect(var_26_0, arg_26_0[1])

		return
	end

	var_25_6.placeId = arg_25_0.placeId
	var_25_5[1] = var_25_6

	var_25_2(var_25_1, var_25_3, var_25_4, var_25_5)

	return
end

function var_0_1.OpenFormulaSelectPage(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5)
	local var_27_0 = arg_27_0
	local var_27_1 = arg_27_0.emit

	IslandMediator = var_1_10009

	var_27_1(var_27_0, var_1_10009.OPEN_PAGE, "IslandFormulaSelectPage", {
		{
			commissionId = arg_27_0.commissionId,
			selectedShipId = arg_27_4 or arg_27_0.selectedShipId,
			unLoadCharacterFunc = arg_27_0.unLoadCharacterFunc,
			addDelegateFormula = arg_27_1,
			addDelegateFormulaTimes = arg_27_2,
			canRewardTime = arg_27_3,
			selectFormulaId = arg_27_5,
			confirmFunc = function()
				if arg_27_0.contextData and arg_27_0.contextData.isPermanent then
					return
				end

				local var_28_0 = arg_27_0

				var_0.Hide(var_28_0)

				return
			end
		}
	})
	arg_27_0:HideDetailPanel()

	return
end

function var_0_1.UpdateTime(arg_29_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_29_0 = var_1_10001(var_1_10003)
	local var_29_1 = var_1.GetIsland(var_29_0)
	local var_29_2 = var_1.GetBuildingAgency(var_29_1)
	local var_29_3 = var_1.GetBuilding(var_29_2, arg_29_0.placeId)

	if not var_1.GetDelegationSlotData(var_29_3, arg_29_0.slotId) then
		arg_29_0:FlushInfos()

		return
	end

	if not var_2:GetSlotRoleData() then
		arg_29_0:FlushInfos()

		return
	end

	local var_29_4 = var_3:GetFinishTime()
	local var_29_5 = arg_29_0.timeMgr
	local var_29_6 = var_29_4 - var_5.GetServerTime(var_29_5)

	setText = var_5

	local var_29_7 = arg_29_0.timeTF
	local var_29_8 = arg_29_0.timeMgr

	var_5(var_29_7, var_8.DescCDTime(var_29_8, var_29_6))

	setSlider = var_5

	var_5(arg_29_0.roleDelegationSliderTF, 0, 1, 1 - var_29_6 / var_3:GetAllTime())

	local var_29_9 = var_3
	local var_29_10 = var_3.CanRewardTimes(var_29_9)
	local var_29_11 = var_3.formula_id

	pg = var_29_9

	local var_29_12 = var_29_9.island_formula[var_29_11]
	local var_29_13 = var_3
	local var_29_14 = var_3.GetCurrentCanRewardExtraMainNum(var_29_13)
	local var_29_15 = "×"

	tostring = var_29_13

	local var_29_16 = var_29_15 .. var_29_13(var_29_12.commission_product[1][2] * var_29_10 + var_29_14)

	if var_29_14 and 0 < var_29_14 then
		setTextColor = var_10

		local var_29_17 = arg_29_0.canRewardNum

		Color = var_1_10013

		var_10(var_29_17, var_1_10013.NewHex("#7df39f"))
	else
		setTextColor = var_10

		local var_29_18 = arg_29_0.canRewardNum

		Color = var_1_10013

		var_10(var_29_18, var_1_10013.NewHex("#FFFFFF"))
	end

	setText = var_10

	var_10(arg_29_0.canRewardNum, var_29_16)

	local var_29_19 = var_3:InCurrentTime()
	local var_29_20 = arg_29_0.timeMgr
	local var_29_21 = var_11.GetServerTime(var_29_20) - var_3:InCurrentTimeStart(var_29_19)

	arg_29_0.formulaProcess.fillAmount = var_29_21 / var_3:CurrentTimeNeed(var_29_19)

	local var_29_22 = var_3:LastTimes()

	setText = var_13

	var_13(arg_29_0.currentFormulaLastNum, var_29_22)

	local var_29_23 = var_3:GetExtraMainProduct(var_29_19)
	local var_29_24 = "×" .. var_29_12.commission_product[1][2]

	if 0 < var_29_23 then
		string = var_15
		var_29_24 = var_15.format("×(%s<color=#7df39f>+%d</color>)", var_29_12.commission_product[1][2], var_29_23)
	end

	setText = var_15

	local var_29_25 = arg_29_0.currentFormulaNum
	local var_29_26 = var_29_24

	i18n = var_1_10019

	var_15(var_29_25, var_29_26 .. var_1_10019("island_production_tip"))

	if 0 < var_29_10 then
		setActive = var_15

		var_15(arg_29_0.getBtn, true)

		setActive = var_15

		var_15(arg_29_0.addBtn, false)
	else
		local var_29_27

		if not var_29_12.production_limit then
			var_29_27 = 5
		end

		setActive = var_16

		var_16(arg_29_0.addBtn, var_29_22 < var_29_27)

		onButton = var_16

		local var_29_28 = arg_29_0
		local var_29_29 = arg_29_0.addBtn

		local function var_29_30()
			local var_30_0 = arg_29_0

			var_0.OpenFormulaSelectPage(var_30_0, var_29_11, var_29_22, var_29_10, var_0.ship_id)

			return
		end

		SFX_PANEL = var_21

		var_16(var_29_28, var_29_29, var_29_30, var_21)
	end

	if #var_29_12.second_product ~= 0 then
		getProxy = var_15
		IslandProxy = var_29_25

		local var_29_31 = var_15(var_29_25)
		local var_29_32 = var_15.GetIsland(var_29_31)
		local var_29_33 = var_15.GetAblityAgency(var_29_32)

		if not var_15.IsUnlcokSecondProduct(var_29_33, var_29_11) then
			return
		end

		local var_29_34 = var_3:GetExtraExtraProduct(var_29_19)
		local var_29_35 = "×" .. var_29_12.second_product_display[1][2]

		if 0 < var_29_34 then
			string = var_17
			var_29_35 = var_17.format("×(%s<color=#7df39f>+%d</color>)", var_29_12.second_product_display[1][2], var_29_34)
		end

		setText = var_17

		local var_29_36 = arg_29_0.extraProductNum
		local var_29_37 = var_29_35

		i18n = var_21

		var_17(var_29_36, var_29_37 .. var_21("island_production_tip"))

		if (var_2:GetFromulaTatalCount(var_29_12.id) + var_29_10) % var_29_12.second_product[1] ~= arg_29_0.extraProcess then
			arg_29_0.extraProcess = var_20

			local var_29_38 = arg_29_0.extraProductList

			var_21.align(var_29_38, var_19)
		end

		math = var_21

		local var_29_39 = var_21.floor((var_29_22 + var_20) / var_19)

		setText = var_1_10022

		var_1_10022(arg_29_0.extraProductLastNum, "×" .. var_29_39)

		math = var_1_10022

		local var_29_40 = var_1_10022.floor(var_17 / var_19)

		math = var_23

		local var_29_41 = var_23.floor(var_18 / var_19) - var_29_40

		setActive = var_25

		var_25(arg_29_0.canExtraRewardIcon, var_29_41 > 0)

		setActive = var_25

		var_25(arg_29_0.canExtraRewardNum, var_29_41 > 0)

		if var_29_41 > 0 then
			local var_29_42 = var_17 % var_19
			local var_29_43 = 0

			for iter_29_0 = 1, var_29_41 do
				var_1_10031 = var_29_19 - (iter_29_0 - 1) * var_19
				math = var_1_10032
				var_1_10032 = var_1_10032.floor((var_1_10031 + var_29_42) / var_19) * var_19 - var_29_42
				var_29_43 = var_29_43 + var_3:GetExtraExtraProduct(var_1_10032)
			end

			local var_29_44 = "×" .. var_29_12.second_product_display[1][2] * var_29_41 + var_29_43

			if 0 < var_29_43 then
				setTextColor = var_28

				local var_29_45 = arg_29_0.canExtraRewardNum

				Color = var_1_10031

				var_28(var_29_45, var_1_10031.NewHex("#7df39f"))
			else
				setTextColor = var_28

				local var_29_46 = arg_29_0.canExtraRewardNum

				Color = var_1_10031

				var_28(var_29_46, var_1_10031.NewHex("#FFFFFF"))
			end

			setText = var_28

			var_28(arg_29_0.canExtraRewardNum, var_29_44)
		end

		return
	end
end

function var_0_1.StartTimer(arg_31_0)
	Timer = var_1_10001
	arg_31_0.timer = var_1_10001.New(function()
		local var_32_0 = arg_31_0

		var_0.UpdateTime(var_32_0)

		return
	end, 1, -1)

	local var_31_0 = arg_31_0.timer

	var_1.Start(var_31_0)
	arg_31_0:UpdateTime()

	return
end

function var_0_1.StopTimer(arg_33_0)
	if arg_33_0.timer ~= nil then
		local var_33_0 = arg_33_0.timer

		var_1.Stop(var_33_0)

		arg_33_0.timer = nil
	end

	return
end

function var_0_1.Hide(arg_34_0)
	arg_34_0.super.Hide(arg_34_0)
	arg_34_0:OnHide()

	return
end

function var_0_1.OnHide(arg_35_0)
	arg_35_0:StopTimer()

	return
end

function var_0_1.OnDestroy(arg_36_0)
	arg_36_0:OnHide()

	return
end

return var_0_1
