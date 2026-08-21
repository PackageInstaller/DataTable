local var_0_0 = class("TechnologyTreeScene", import("..base.BaseUI"))

var_0_0.NationTrige = {
	All = 0,
	Mot = 3,
	Meta = 2,
	Other = 1
}
var_0_0.TypeTrige = {
	All = 0,
	Other = 1
}

function var_0_0.getUIName(arg_1_0)
	return "TechnologyTreeUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:initNationToggleUIList()
	arg_2_0:initTecClassUIList()

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:initTypeToggleUIList()
	arg_3_0:updateTecItemList()
	arg_3_0:addBtnListener()
	setText(arg_3_0.pointNumText, arg_3_0.point)
	arg_3_0:updateRedPoint(getProxy(TechnologyNationProxy):getShowRedPointTag())

	if not PlayerPrefs.HasKey("first_comein_technologytree") then
		triggerButton(arg_3_0.helpBtn)
		PlayerPrefs.SetInt("first_comein_technologytree", 1)
		PlayerPrefs.Save()
	end

	return
end

function var_0_0.updateRedPoint(arg_4_0, arg_4_1)
	setActive(arg_4_0.redPointImg, arg_4_1)

	return
end

function var_0_0.willExit(arg_5_0)
	arg_5_0:UnOverlayPanel(arg_5_0.blurPanel, arg_5_0._tf)

	arg_5_0.rightLSC.onReturnItem = nil

	if arg_5_0.emptyPage then
		arg_5_0.emptyPage:Destroy()

		arg_5_0.emptyPage = nil
	end

	return
end

function var_0_0.initData(arg_6_0)
	TechnologyConst.CreateMetaClassConfig()

	arg_6_0.nationToggleList = {}
	arg_6_0.typeToggleList = {}
	arg_6_0.nationSelectedList = {}
	arg_6_0.typeSelectedList = {}
	arg_6_0.nationSelectedCount = 0
	arg_6_0.typeSelectedCount = 0
	arg_6_0.lastNationTrige = nil
	arg_6_0.lastTypeTrige = nil
	arg_6_0.countInEveryRow = 5
	arg_6_0.collectionProxy = getProxy(CollectionProxy)
	arg_6_0.nationProxy = getProxy(TechnologyNationProxy)
	arg_6_0.curClassIDList = nil
	arg_6_0.groupIDGotList = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_0.collectionProxy.shipGroups) do
		arg_6_0.groupIDGotList[#arg_6_0.groupIDGotList + 1] = iter_6_1.id
	end

	arg_6_0.point = arg_6_0.nationProxy:getPoint()
	arg_6_0.expanded = {}

	return
end

function var_0_0.findUI(arg_7_0)
	arg_7_0.nationAllToggle = nil
	arg_7_0.nationAllToggleCom = nil
	arg_7_0.nationMetaToggle = arg_7_0._tf:Find("Adapt/Left/MetaToggle")
	arg_7_0.nationMetaToggleCom = GetComponent(arg_7_0.nationMetaToggle, "Toggle")
	arg_7_0.nationMotToggle = arg_7_0._tf:Find("Adapt/Left/MotToggle")
	arg_7_0.nationMotToggleCom = GetComponent(arg_7_0.nationMotToggle, "Toggle")
	arg_7_0.typeAllToggle = nil
	arg_7_0.typeAllToggleCom = nil
	arg_7_0.blurPanel = arg_7_0._tf:Find("blur_panel")
	arg_7_0.adapt = arg_7_0.blurPanel:Find("adapt")
	arg_7_0.backBtn = arg_7_0.adapt:Find("top/back")
	arg_7_0.homeBtn = arg_7_0.adapt:Find("top/option")
	arg_7_0.additionDetailBtn = arg_7_0.adapt:Find("AdditionDetailBtn")
	arg_7_0.switchBtn = arg_7_0.adapt:Find("SwitchToggle")
	arg_7_0.pointTF = arg_7_0.adapt:Find("PointCount")
	arg_7_0.pointNumText = arg_7_0.adapt:Find("PointCount/PointNumText")
	arg_7_0.redPointImg = arg_7_0.switchBtn:Find("RedPoint")
	arg_7_0.helpBtn = arg_7_0.adapt:Find("help_btn")
	arg_7_0.leftContainer = arg_7_0._tf:Find("Adapt/Left/Scroll View/Content")
	arg_7_0.selectNationItem = arg_7_0._tf:Find("SelectCampItem")
	arg_7_0.bottomContainer = arg_7_0._tf:Find("Adapt/Bottom/Content")
	arg_7_0.selectTypeItem = arg_7_0._tf:Find("SelectTypeItem")
	arg_7_0.rightContainer = arg_7_0._tf:Find("Adapt/Right/Container")
	arg_7_0.rightLSC = arg_7_0.rightContainer:GetComponent("LScrollRect")
	arg_7_0.rightLayoutGroup = arg_7_0.rightContainer:GetComponent("VerticalLayoutGroup")
	arg_7_0.headItem = arg_7_0._tf:Find("HeadItem")
	arg_7_0.rowHeight = arg_7_0.headItem.rect.height
	arg_7_0.maxRowHeight = 853.5
	arg_7_0.emptyPage = BaseEmptyListPage.New(arg_7_0._tf:Find("Adapt/Right/ViewPort"), arg_7_0.event)

	return
end

function var_0_0.onBackPressed(arg_8_0)
	triggerButton(arg_8_0.backBtn)

	return
end

function var_0_0.addBtnListener(arg_9_0)
	onButton(arg_9_0, arg_9_0.backBtn, function()
		arg_9_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_9_0, arg_9_0.additionDetailBtn, function()
		arg_9_0:emit(TechnologyConst.OPEN_ALL_BUFF_DETAIL)

		return
	end)
	onToggle(arg_9_0, arg_9_0.switchBtn, function(arg_12_0)
		if arg_12_0 then
			setActive(arg_9_0.pointTF, false)
			arg_9_0:OverlayPanel(arg_9_0.blurPanel)
			arg_9_0:emit(TechnologyConst.OPEN_TECHNOLOGY_NATION_LAYER)
		else
			setActive(arg_9_0.pointTF, true)
			arg_9_0:UnOverlayPanel(arg_9_0.blurPanel, arg_9_0._tf)
			arg_9_0:emit(TechnologyConst.CLOSE_TECHNOLOGY_NATION_LAYER)
		end

		return
	end, SFX_PANEL)
	onButton(arg_9_0, arg_9_0.helpBtn, function()
		if pg.gametip.help_technologytree then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_HELP,
				helps = pg.gametip.help_technologytree.tip
			})
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.initNationToggleUIList(arg_14_0)
	arg_14_0.nationAllToggle = nil
	arg_14_0.nationAllToggleCom = nil
	arg_14_0.nationMetaToggle = arg_14_0._tf:Find("Adapt/Left/MetaToggle")
	arg_14_0.nationMetaToggleCom = GetComponent(arg_14_0.nationMetaToggle, "Toggle")
	arg_14_0.nationMotToggle = arg_14_0._tf:Find("Adapt/Left/MotToggle")
	arg_14_0.nationMotToggleCom = GetComponent(arg_14_0.nationMotToggle, "Toggle")

	setActive(arg_14_0.nationMetaToggle, not LOCK_TEC_META)

	if LOCK_TEC_META then
		local var_14_0 = arg_14_0._tf:Find("Adapt/Left/Scroll View")

		var_14_0.offsetMin = Vector2.New(var_14_0.offsetMin.x, 0)
	end

	local var_14_1 = UIItemList.New(arg_14_0.leftContainer, arg_14_0.selectNationItem)

	var_14_1:make(function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventUpdate then
			arg_15_2:Find("UnSelectedImg"):GetComponent("Image").sprite, arg_15_2:Find("SelectedImg"):GetComponent("Image").sprite = TechnologyConst.GetNationSpriteByIndex(arg_15_1 + 1)

			if arg_15_1 == 0 then
				arg_14_0.nationAllToggle = arg_15_2
				arg_14_0.nationAllToggleCom = GetComponent(arg_15_2, "Toggle")
				arg_14_0.nationAllToggleCom.interactable = false

				triggerToggle(arg_15_2, true)
			else
				arg_14_0.nationToggleList[arg_15_1] = arg_15_2

				triggerToggle(arg_15_2, false)
			end

			setActive(arg_15_2, true)
		end

		return
	end)
	var_14_1:align(#TechnologyConst.NationResName)
	setActive(arg_14_0.nationMotToggle, not LOCK_TEC_MOT)

	if not LOCK_TEC_MOT then
		setParent(arg_14_0.nationMotToggle, arg_14_0.leftContainer)
	end

	onToggle(arg_14_0, arg_14_0.nationAllToggle, function(arg_16_0)
		if arg_16_0 == true then
			arg_14_0.lastNationTrige = var_0_0.NationTrige.All
			arg_14_0.nationAllToggleCom.interactable = false
			arg_14_0.nationSelectedCount = 0
			arg_14_0.nationSelectedList = {}

			arg_14_0:updateTecItemList()
			arg_14_0:updateNationToggleUIList()
		else
			arg_14_0.nationAllToggleCom.interactable = true
		end

		return
	end, SFX_PANEL)
	onToggle(arg_14_0, arg_14_0.nationMetaToggle, function(arg_17_0)
		if arg_17_0 == true then
			arg_14_0.lastNationTrige = var_0_0.NationTrige.Meta
			arg_14_0.nationMetaToggleCom.interactable = false
			arg_14_0.nationSelectedCount = 0
			arg_14_0.nationSelectedList = {}

			arg_14_0:updateTecItemList()
			arg_14_0:updateNationToggleUIList()
		else
			arg_14_0.nationMetaToggleCom.interactable = true
		end

		return
	end, SFX_PANEL)
	onToggle(arg_14_0, arg_14_0.nationMotToggle, function(arg_18_0)
		if arg_18_0 == true then
			arg_14_0.lastNationTrige = var_0_0.NationTrige.Mot
			arg_14_0.nationMotToggleCom.interactable = false
			arg_14_0.nationSelectedCount = 0
			arg_14_0.nationSelectedList = {}

			arg_14_0:updateTecItemList()
			arg_14_0:updateNationToggleUIList()
		else
			arg_14_0.nationMotToggleCom.interactable = true
		end

		return
	end, SFX_PANEL)

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.nationToggleList) do
		onToggle(arg_14_0, iter_14_1, function(arg_19_0)
			if arg_19_0 == true then
				arg_14_0.lastNationTrige = var_0_0.NationTrige.Other
				arg_14_0.nationSelectedCount = arg_14_0.nationSelectedCount + 1

				table.insert(arg_14_0.nationSelectedList, TechnologyConst.NationOrder[iter_14_0])

				if arg_14_0.nationSelectedCount < #arg_14_0.nationToggleList then
					arg_14_0:updateNationToggleUIList()
					arg_14_0:updateTecItemList()
				elseif arg_14_0.nationSelectedCount == #arg_14_0.nationToggleList then
					arg_14_0:updateNationToggleUIList()
				end
			elseif arg_14_0.nationSelectedCount > 0 then
				arg_14_0.nationSelectedCount = arg_14_0.nationSelectedCount - 1

				local var_19_0 = table.indexof(arg_14_0.nationSelectedList, TechnologyConst.NationOrder[iter_14_0], 1)

				if var_19_0 then
					table.remove(arg_14_0.nationSelectedList, var_19_0)
				end

				if arg_14_0.nationSelectedCount > 0 then
					arg_14_0:updateNationToggleUIList()
					arg_14_0:updateTecItemList()
				elseif arg_14_0.nationSelectedCount == 0 then
					arg_14_0:updateNationToggleUIList()
				end
			end

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.updateNationToggleUIList(arg_20_0)
	if arg_20_0.lastNationTrige == var_0_0.NationTrige.All then
		_.each(arg_20_0.nationToggleList, function(arg_21_0)
			triggerToggle(arg_21_0, false)
			onNextTick(function()
				setActive(arg_21_0:Find("UnSelectedImg"), true)

				return
			end)

			return
		end)
		triggerToggle(arg_20_0.nationMetaToggle, false)
		triggerToggle(arg_20_0.nationMotToggle, false)
	elseif arg_20_0.lastNationTrige == var_0_0.NationTrige.Meta then
		triggerToggle(arg_20_0.nationAllToggle, false)
		_.each(arg_20_0.nationToggleList, function(arg_23_0)
			triggerToggle(arg_23_0, false)

			return
		end)
		triggerToggle(arg_20_0.nationMotToggle, false)
	elseif arg_20_0.lastNationTrige == var_0_0.NationTrige.Mot then
		triggerToggle(arg_20_0.nationAllToggle, false)
		_.each(arg_20_0.nationToggleList, function(arg_24_0)
			triggerToggle(arg_24_0, false)

			return
		end)
		triggerToggle(arg_20_0.nationMetaToggle, false)
	elseif arg_20_0.lastNationTrige == var_0_0.NationTrige.Other then
		if arg_20_0.nationSelectedCount <= 0 or arg_20_0.nationSelectedCount >= #arg_20_0.nationToggleList then
			triggerToggle(arg_20_0.nationAllToggle, true)
		else
			triggerToggle(arg_20_0.nationAllToggle, false)
			triggerToggle(arg_20_0.nationMetaToggle, false)
			triggerToggle(arg_20_0.nationMotToggle, false)
		end
	end

	return
end

function var_0_0.initTypeToggleUIList(arg_25_0)
	arg_25_0.typeAllToggle = nil
	arg_25_0.typeAllToggleCom = nil

	local var_25_0 = UIItemList.New(arg_25_0.bottomContainer, arg_25_0.selectTypeItem)

	var_25_0:make(function(arg_26_0, arg_26_1, arg_26_2)
		if arg_26_0 == UIItemList.EventUpdate then
			arg_26_2:Find("UnSelectedImg"):GetComponent("Image").sprite, arg_26_2:Find("SelectedImg"):GetComponent("Image").sprite = TechnologyConst.GetTypeSpriteByIndex(arg_26_1 + 1)
			arg_26_1 = arg_26_1 + 1

			if arg_26_1 == #TechnologyConst.TypeResName then
				arg_25_0.typeAllToggle = arg_26_2
				arg_25_0.typeAllToggleCom = GetComponent(arg_26_2, "Toggle")
				arg_25_0.typeAllToggleCom.interactable = false

				triggerToggle(arg_26_2, true)
			else
				arg_25_0.typeToggleList[arg_26_1] = arg_26_2

				triggerToggle(arg_26_2, false)
			end

			setActive(arg_26_2, true)
		end

		return
	end)
	var_25_0:align(#TechnologyConst.TypeResName)
	onToggle(arg_25_0, arg_25_0.typeAllToggle, function(arg_27_0)
		arg_25_0.lastTypeTrige = var_0_0.TypeTrige.All

		if arg_27_0 == true then
			arg_25_0.typeAllToggleCom.interactable = false
			arg_25_0.typeSelectedCount = 0
			arg_25_0.typeSelectedList = {}

			arg_25_0:updateTecItemList()
			arg_25_0:updateTypeToggleUIList()
		else
			arg_25_0.typeAllToggleCom.interactable = true
		end

		return
	end)

	for iter_25_0, iter_25_1 in ipairs(arg_25_0.typeToggleList) do
		onToggle(arg_25_0, iter_25_1, function(arg_28_0)
			arg_25_0.lastTypeTrige = var_0_0.TypeTrige.Other

			if arg_28_0 == true then
				arg_25_0.typeSelectedCount = arg_25_0.typeSelectedCount + 1

				for iter_28_0, iter_28_1 in ipairs(TechnologyConst.TypeOrder[iter_25_0]) do
					table.insert(arg_25_0.typeSelectedList, iter_28_1)
				end

				if arg_25_0.typeSelectedCount < #arg_25_0.typeToggleList then
					arg_25_0:updateTypeToggleUIList()
					arg_25_0:updateTecItemList()
				elseif arg_25_0.typeSelectedCount == #arg_25_0.typeToggleList then
					arg_25_0:updateTypeToggleUIList()
				end
			elseif arg_25_0.typeSelectedCount > 0 then
				arg_25_0.typeSelectedCount = arg_25_0.typeSelectedCount - 1

				for iter_28_2, iter_28_3 in ipairs(TechnologyConst.TypeOrder[iter_25_0]) do
					local var_28_0 = table.indexof(arg_25_0.typeSelectedList, iter_28_3, 1)

					if var_28_0 then
						table.remove(arg_25_0.typeSelectedList, var_28_0)
					end
				end

				if arg_25_0.typeSelectedCount > 0 then
					arg_25_0:updateTypeToggleUIList()
					arg_25_0:updateTecItemList()
				elseif arg_25_0.typeSelectedCount == 0 then
					arg_25_0:updateTypeToggleUIList()
				end
			end

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.updateTypeToggleUIList(arg_29_0)
	if arg_29_0.lastTypeTrige == var_0_0.TypeTrige.All then
		_.each(arg_29_0.typeToggleList, function(arg_30_0)
			triggerToggle(arg_30_0, false)
			onNextTick(function()
				setActive(arg_30_0:Find("UnSelectedImg"), true)

				return
			end)

			return
		end)
	elseif arg_29_0.lastTypeTrige == var_0_0.TypeTrige.Other then
		if arg_29_0.typeSelectedCount <= 0 or arg_29_0.typeSelectedCount >= #arg_29_0.typeToggleList then
			triggerToggle(arg_29_0.typeAllToggle, true)
		else
			triggerToggle(arg_29_0.typeAllToggle, false)
		end
	end

	return
end

function var_0_0.updatePreferredHeight(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = tf(arg_32_1):Find("ShipScrollView/ShipContainer")

	arg_32_0.rightLayoutGroup.padding.bottom = arg_32_0.rightLayoutGroup.padding.bottom + (arg_32_2 + arg_32_0.rowHeight) - GetComponent(arg_32_1, "LayoutElement").preferredHeight
	GetComponent(arg_32_1, "LayoutElement").preferredHeight = arg_32_2 + arg_32_0.rowHeight

	local var_32_1 = tf(arg_32_1)

	setLocalRotation(var_32_1:Find("ClickBtn/ArrowBtn"), {
		z = arg_32_2 > 0 and 0 or 180
	})

	return
end

function var_0_0.onClassItemUpdate(arg_33_0, arg_33_1, arg_33_2)
	local var_33_9002
	local var_33_9001
	local var_33_9000
	local var_33_0 = tf(arg_33_2).Find(var_33_9002, "CampBG")
	local var_33_1 = tf(arg_33_2):Find("Level/LevelImg")
	local var_33_2 = tf(arg_33_2):Find("Level/TypeTextImg")
	local var_33_3 = tf(arg_33_2)
	local var_33_4 = var_33_3.Find(var_33_9001, "ClickBtn")
	local var_33_5 = var_33_4:Find("ArrowBtn")
	local var_33_6 = arg_33_0:getClassConfigForShow(arg_33_1 + 1)
	local var_33_7 = var_33_6.ships
	local var_33_8 = arg_33_0:isMetaOn()
	local var_33_9 = arg_33_0:isMotOn()

	setText(tf(arg_33_2).Find(var_33_9000, "Name/NameText"), var_33_3.name)

	local var_33_10

	if var_33_8 or var_33_9 then
		setActive(var_33_1, false)
		setActive(var_33_2, false)

		if var_33_8 then
			var_33_10 = GetSpriteFromAtlas("TecNation", "bg_nation_meta")
		elseif var_33_9 then
			var_33_10 = GetSpriteFromAtlas("TecNation", "bg_nation_mot")
		end
	else
		setImageSprite(var_33_1, GetSpriteFromAtlas("TecClassLevelIcon", "T" .. var_33_6.t_level), true)
		setImageSprite(var_33_2, GetSpriteFromAtlas("ShipType", "ch_title_" .. var_33_6.shiptype), true)
		setActive(var_33_1, true)
		setActive(var_33_2, true)

		var_33_10 = GetSpriteFromAtlas("TecNation", "bg_nation_" .. var_33_6.nation)
	end

	setImageSprite(var_33_0, var_33_10)
	setLocalRotation(tf(arg_33_2):Find("ClickBtn/ArrowBtn"), {
		z = 180
	})
	arg_33_0:updateShipItemList(var_33_7, (tf(arg_33_2):Find("ShipScrollView/ShipContainer")))

	arg_33_0.expanded[arg_33_1] = 0

	arg_33_0:updatePreferredHeight(arg_33_2, arg_33_0.expanded[arg_33_1])
	setActive(var_33_4, #var_33_7 > 5)
	onButton(arg_33_0, var_33_4, function()
		arg_33_0.expanded[arg_33_1] = defaultValue(arg_33_0.expanded[arg_33_1], 0) > 0 and 0 or var_0.rect.height - arg_33_0.rowHeight

		arg_33_0:updatePreferredHeight(arg_33_2, arg_33_0.expanded[arg_33_1])

		return
	end, SFX_PANEL)

	return
end

function var_0_0.onClassItemReturn(arg_35_0, arg_35_1, arg_35_2)
	if defaultValue(arg_35_0.expanded[arg_35_1], 0) > 0 then
		arg_35_0.expanded[arg_35_1] = 0

		arg_35_0:updatePreferredHeight(arg_35_2, arg_35_0.expanded[arg_35_1])
	end

	return
end

function var_0_0.initTecClassUIList(arg_36_0)
	function arg_36_0.rightLSC.onUpdateItem(arg_37_0, arg_37_1)
		arg_36_0:onClassItemUpdate(arg_37_0, arg_37_1)

		return
	end

	function arg_36_0.rightLSC.onReturnItem(arg_38_0, arg_38_1)
		arg_36_0:onClassItemReturn(arg_38_0, arg_38_1)

		return
	end

	return
end

function var_0_0.updateTecItemList(arg_39_0)
	arg_39_0.expanded = {}

	local var_39_0 = arg_39_0:getClassIDListForShow()

	if arg_39_0.rightLSC.totalCount ~= 0 then
		arg_39_0.rightLSC:SetTotalCount(0)
	end

	arg_39_0.rightLSC:SetTotalCount(#var_39_0)
	arg_39_0.rightLSC:BeginLayout()
	arg_39_0.rightLSC:EndLayout()

	if #var_39_0 <= 0 then
		arg_39_0.emptyPage:ExecuteAction("ShowOrHide", true)
		arg_39_0.emptyPage:ExecuteAction("SetEmptyText", i18n("technology_filter_placeholder"))
	elseif #var_39_0 > 0 and arg_39_0.emptyPage:GetLoaded() then
		arg_39_0.emptyPage:ExecuteAction("ShowOrHide", false)
	end

	return
end

function var_0_0.updateShipItemList(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = UIItemList.New(arg_40_2, arg_40_0.headItem)

	var_40_0:make(function(arg_41_0, arg_41_1, arg_41_2)
		if arg_41_0 == UIItemList.EventUpdate then
			local var_41_0 = arg_41_2:Find("BaseImg/CharImg")
			local var_41_1 = arg_41_2:Find("NameBG")
			local var_41_2 = arg_41_2:Find("Frame")
			local var_41_3 = arg_41_2:Find("Star")
			local var_41_4 = arg_41_2:Find("Star/StarImg")
			local var_41_5 = arg_41_2:Find("Info")
			local var_41_6 = var_41_5:Find("PointText")
			local var_41_7 = var_41_5:Find("BuffGet")
			local var_41_8 = var_41_7:Find("TypeIcon")
			local var_41_9 = var_41_5:Find("Lock")
			local var_41_10 = var_41_5:Find("BuffComplete")
			local var_41_11 = var_41_10:Find("TypeIcon")
			local var_41_12 = arg_41_2:Find("BottomBG")
			local var_41_13 = arg_41_2:Find("BottomBG/StatusUnknow")
			local var_41_14 = arg_41_2:Find("BottomBG/StatusResearching")
			local var_41_15 = arg_41_2:Find("ViewIcon")
			local var_41_16 = arg_41_2:Find("keyansaohguang")
			local var_41_17 = arg_40_1[arg_41_1 + 1]

			setText(var_41_1:Find("NameText"), shortenString(ShipGroup.getDefaultShipNameByGroupID(arg_40_1[arg_41_1 + 1]), 6))
			setImageSprite(arg_41_2:Find("BaseImg"), GetSpriteFromAtlas("shipraritybaseicon", "base_" .. pg.ship_data_statistics[var_41_17 * 10 + 1].rarity))
			LoadSpriteAsync("shipmodels/" .. Ship.getPaintingName(var_41_17 * 10 + 1), function(arg_42_0)
				if arg_42_0 and not arg_40_0.exited then
					setImageSprite(var_41_0, arg_42_0, true)

					rtf(var_41_0).pivot = getSpritePivot(arg_42_0)
				end

				return
			end)

			if table.indexof(arg_40_0.groupIDGotList, var_41_17, 1) then
				setImageSprite(var_41_8, GetSpriteFromAtlas("ui/technologytreeui_atlas", "label_" .. pg.fleet_tech_ship_template[var_41_17].add_get_shiptype[1]))
				setImageSprite(var_41_8:Find("AttrIcon"), GetSpriteFromAtlas("attricon", pg.attribute_info_by_type[pg.fleet_tech_ship_template[var_41_17].add_get_attr].name))
				setText(var_41_8:Find("NumText"), "+" .. pg.fleet_tech_ship_template[var_41_17].add_get_value)
				setActive(var_41_7, true)

				local var_41_18 = arg_40_0.collectionProxy:getShipGroup(var_41_17)

				if var_41_18.maxLV < TechnologyConst.SHIP_LEVEL_FOR_BUFF then
					setActive(var_41_14, true)
					setActive(var_41_13, false)
					setActive(var_41_10, false)
					setImageSprite(var_41_2, GetSpriteFromAtlas("ui/technologytreeui_atlas", "card_bg_normal"))
					setActive(var_41_12, true)
					setActive(var_41_15, true)
					setActive(var_41_9, true)
					setActive(var_41_16, false)

					if var_41_18.star == pg.fleet_tech_ship_template[var_41_17].max_star then
						setText(var_41_6, "+" .. pg.fleet_tech_ship_template[var_41_17].pt_get + pg.fleet_tech_ship_template[var_41_17].pt_upgrage)
					else
						setText(var_41_6, "+" .. pg.fleet_tech_ship_template[var_41_17].pt_get)
					end
				else
					setImageSprite(var_41_11, GetSpriteFromAtlas("ui/technologytreeui_atlas", "label_" .. pg.fleet_tech_ship_template[var_41_17].add_level_shiptype[1]))
					setImageSprite(var_41_11:Find("AttrIcon"), GetSpriteFromAtlas("attricon", pg.attribute_info_by_type[pg.fleet_tech_ship_template[var_41_17].add_level_attr].name))
					setText(var_41_11:Find("NumText"), "+" .. pg.fleet_tech_ship_template[var_41_17].add_level_value)
					setActive(var_41_10, true)

					if var_41_18.star == pg.fleet_tech_ship_template[var_41_17].max_star then
						setText(var_41_6, "+" .. pg.fleet_tech_ship_template[var_41_17].pt_get + pg.fleet_tech_ship_template[var_41_17].pt_level + pg.fleet_tech_ship_template[var_41_17].pt_upgrage)
						setImageSprite(var_41_2, GetSpriteFromAtlas("ui/technologytreeui_atlas", "card_bg_finished"))
						setActive(var_41_12, false)
						setActive(var_41_15, false)
						setActive(var_41_14, false)
						setActive(var_41_13, false)
						setActive(var_41_16, true)
					else
						setText(var_41_6, "+" .. pg.fleet_tech_ship_template[var_41_17].pt_get + pg.fleet_tech_ship_template[var_41_17].pt_level)
						setImageSprite(var_41_2, GetSpriteFromAtlas("ui/technologytreeui_atlas", "card_bg_normal"))
						setActive(var_41_12, true)
						setActive(var_41_15, true)
						setActive(var_41_14, true)
						setActive(var_41_13, false)
						setActive(var_41_16, false)
					end

					setActive(var_41_9, false)
				end

				setImageColor(var_41_0, Color.New(1, 1, 1, 1))
				setActive(var_41_1, true)
				setActive(var_41_5, true)
				setActive(var_41_3, true)

				if var_41_18.star == pg.fleet_tech_ship_template[var_41_17].max_star then
					setActive(var_41_4, true)
				else
					setActive(var_41_4, false)
				end

				onButton(arg_40_0, arg_41_2, function()
					arg_40_0:emit(TechnologyConst.OPEN_SHIP_BUFF_DETAIL, var_41_17, var_41_18.maxLV, var_41_18.star)

					return
				end)
			else
				setImageSprite(var_41_2, GetSpriteFromAtlas("ui/technologytreeui_atlas", "card_bg_normal"))
				setImageColor(var_41_0, Color.New(0, 0, 0, 0.4))
				setActive(var_41_15, false)
				setActive(var_41_1, false)
				setActive(var_41_5, false)
				setActive(var_41_14, false)
				setActive(var_41_13, true)
				setActive(var_41_3, false)
				setActive(var_41_9, false)
				setActive(var_41_16, false)
				removeOnButton(arg_41_2)
			end

			setActive(arg_41_2, true)
		end

		return
	end)
	var_40_0:align(#arg_40_1)

	return
end

function var_0_0.getClassIDListForShow(arg_44_0, arg_44_1, arg_44_2)
	arg_44_1 = arg_44_1 or arg_44_0.nationSelectedList
	arg_44_2 = arg_44_2 or arg_44_0.typeSelectedList

	local var_44_0 = arg_44_0:isMetaOn()
	local var_44_1 = arg_44_0:isMotOn()

	if not var_44_0 and not var_44_1 then
		local var_44_2 = TechnologyConst.GetOrderClassList()
		local var_44_3

		if #arg_44_1 == 0 and #arg_44_2 == 0 then
			var_44_3 = var_44_2
		else
			local var_44_4 = #arg_44_1 == 0 and TechnologyConst.NationOrder or arg_44_1

			var_44_3 = _.select(var_44_2, function(arg_45_0)
				if table.contains(var_44_4, pg.fleet_tech_ship_class[arg_45_0].nation) then
					if #arg_44_0.typeSelectedList == 0 then
						return true
					else
						return table.contains(arg_44_0.typeSelectedList, pg.fleet_tech_ship_class[arg_45_0].shiptype)
					end
				else
					return false
				end

				return
			end)
		end

		arg_44_0.curClassIDList = var_44_3

		return var_44_3
	elseif var_44_0 then
		arg_44_0.curMetaClassIDList = TechnologyConst.GetOrderMetaClassList(arg_44_2)

		return arg_44_0.curMetaClassIDList
	elseif var_44_1 then
		arg_44_0.curMotClassIDList = TechnologyConst.GetOrderMotClassList(arg_44_2)

		return arg_44_0.curMotClassIDList
	end

	return
end

function var_0_0.getClassConfigForShow(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_0:isMetaOn()
	local var_46_1 = arg_46_0:isMotOn()

	if not var_46_0 and not var_46_1 then
		return pg.fleet_tech_ship_class[arg_46_0.curClassIDList[arg_46_1]]
	elseif var_46_0 then
		return TechnologyConst.GetMetaClassConfig(arg_46_0.curMetaClassIDList[arg_46_1], arg_46_0.typeSelectedList)
	elseif var_46_1 then
		return TechnologyConst.GetMotClassConfig(arg_46_0.curMotClassIDList[arg_46_1], arg_46_0.typeSelectedList)
	end

	return
end

function var_0_0.isMetaOn(arg_47_0)
	if arg_47_0.lastNationTrige == var_0_0.NationTrige.All then
		return false
	elseif arg_47_0.lastNationTrige == var_0_0.NationTrige.Mot then
		return false
	end

	return arg_47_0.nationMetaToggleCom.isOn
end

function var_0_0.isMotOn(arg_48_0)
	if arg_48_0.lastNationTrige == var_0_0.NationTrige.All then
		return false
	elseif arg_48_0.lastNationTrige == var_0_0.NationTrige.Meta then
		return false
	end

	return arg_48_0.nationMotToggleCom.isOn
end

return var_0_0
