local var_0_0 = class("TechnologyTreeNationScene", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "TechnologyTreeCampUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:addListener()
	arg_3_0:updateTecItemList()
	arg_3_0:updateOneStepBtn()
	arg_3_0.nationProxy:setRedPointIgnoreTecCampUpgrade()

	return
end

function var_0_0.willExit(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.timerList) do
		iter_4_1:Stop()
	end

	arg_4_0.nationProxy:refreshRedPoint()

	return
end

function var_0_0.initData(arg_5_0)
	arg_5_0.nationProxy = getProxy(TechnologyNationProxy)
	arg_5_0.nationToPoint = arg_5_0.nationProxy:getNationPointList()
	arg_5_0.tecList = arg_5_0.nationProxy:GetTecList()
	arg_5_0.panelList = {}
	arg_5_0.timerList = {}

	return
end

function var_0_0.calculateCurBuff(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0

	if arg_6_1 == 0 then
		return {}, {}, {}
	else
		var_6_0 = pg.fleet_tech_group[arg_6_2].techs[arg_6_1]
	end

	for iter_6_0, iter_6_1 in ipairs(pg.fleet_tech_template[var_6_0].add) do
		for iter_6_2, iter_6_3 in ipairs(iter_6_1[1]) do
			if ({})[iter_6_3] then
				table.insert(({})[iter_6_3], {
					attr = iter_6_1[2],
					value = iter_6_1[3]
				})
			else
				({})[iter_6_3] = {
					{
						attr = iter_6_1[2],
						value = iter_6_1[3]
					}
				}
				;({})[#{} + 1] = iter_6_3
			end
		end
	end

	for iter_6_4, iter_6_5 in pairs({}) do
		if not ({})[iter_6_4] then
			({})[iter_6_4] = {}
			;({})[iter_6_4] = {}
		end

		for iter_6_6, iter_6_7 in ipairs(iter_6_5) do
			if not ({})[iter_6_4][iter_6_7.attr] then
				({})[iter_6_4][iter_6_7.attr] = iter_6_7.value
				;({})[iter_6_4][#({})[iter_6_4] + 1] = iter_6_7.attr
			else
				({})[iter_6_4][iter_6_7.attr] = ({})[iter_6_4][iter_6_7.attr] + iter_6_7.value
			end
		end
	end

	table.sort({}, function(arg_7_0, arg_7_1)
		return arg_7_0 < arg_7_1
	end)

	for iter_6_8, iter_6_9 in pairs({}) do
		table.sort(iter_6_9, function(arg_8_0, arg_8_1)
			return arg_8_0 < arg_8_1
		end)
	end

	return {}, {}, {}
end

function var_0_0.findUI(arg_9_0)
	arg_9_0.scrollRect = arg_9_0._tf:Find("Scroll View")
	arg_9_0.tecItemContainer = arg_9_0._tf:Find("Scroll View/Viewport/Content")
	arg_9_0.scrollRectCom = GetComponent(arg_9_0.scrollRect, "ScrollRect")
	arg_9_0.tecItemTpl = arg_9_0._tf:Find("CampTecItem")
	arg_9_0.typeItemTpl = arg_9_0._tf:Find("TypeItem")
	arg_9_0.buffItemTpl = arg_9_0._tf:Find("BuffItem")
	arg_9_0.tecItemTplOriginWidth = arg_9_0.tecItemTpl.rect.width
	arg_9_0.oneStepBtn = arg_9_0._tf:Find("OneStepBtn")

	if not LOCK_TEC_NATION_AWARD then
		arg_9_0.awardTpl = arg_9_0._tf:Find("IconTpl").gameObject

		setActive(arg_9_0.awardTpl, false)

		local var_9_0 = arg_9_0.awardTpl:AddComponent(typeof(LayoutElement))

		var_9_0.preferredWidth = 204
		var_9_0.preferredHeight = 206

		setText(arg_9_0._tf:Find("CampTecItem/AwardPanel/FinishBtn/Text"), i18n("tec_nation_award_finish"))
	else
		setActive(arg_9_0.oneStepBtn, false)
	end

	return
end

function var_0_0.onBackPressed(arg_10_0)
	arg_10_0:emit(var_0_0.ON_BACK)

	return
end

function var_0_0.closeMyself(arg_11_0)
	arg_11_0:emit(var_0_0.ON_CLOSE)

	return
end

function var_0_0.addListener(arg_12_0)
	onButton(arg_12_0, arg_12_0.oneStepBtn, function()
		pg.m02:sendNotification(GAME.GET_CAMP_TEC_AWARD_ONESTEP)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updateTecItemList(arg_14_0)
	local var_14_0 = UIItemList.New(arg_14_0.tecItemContainer, arg_14_0.tecItemTpl)

	var_14_0:make(function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventUpdate then
			arg_14_0.panelList[arg_15_1 + 1] = arg_15_2

			arg_14_0:updateTecItem(arg_15_1 + 1)
		end

		return
	end)
	var_14_0:align(#pg.fleet_tech_group.all)
	arg_14_0:updateAllTecItemRp()

	return
end

function var_0_0.updateAllTecItemRp(arg_16_0)
	local var_16_0 = not getProxy(TechnologyNationProxy):getAnyTecCampStudying()

	for iter_16_0, iter_16_1 in pairs(arg_16_0.panelList) do
		local var_16_1 = iter_16_1:Find("BaseInfo"):Find("UpLevelBG"):Find("UpLevelBtn"):Find("RedPoint")
		local var_16_4 = not arg_16_0.tecList[iter_16_0] and 0 or table.indexof(pg.fleet_tech_group[iter_16_0].techs, arg_16_0.tecList[iter_16_0].completeID, 1) or 0
		local var_16_5 = arg_16_0.nationToPoint[pg.fleet_tech_group[iter_16_0].nation[1]]
		local var_16_6
		local var_16_7, var_16_8, var_16_9

		if nil == 0 then
			var_16_6 = pg.fleet_tech_template[pg.fleet_tech_group[iter_16_0].techs[1]].pt
		elseif var_16_4 == #pg.fleet_tech_group[iter_16_0].techs then
			var_16_6 = pg.fleet_tech_template[pg.fleet_tech_group[iter_16_0].techs[var_16_4]].pt
		else
			var_16_6 = pg.fleet_tech_template[pg.fleet_tech_group[iter_16_0].techs[var_16_4 + 1]].pt
			var_16_7 = var_16_4 == #pg.fleet_tech_group[iter_16_0].techs
			var_16_8 = setActive
			var_16_9 = var_16_1
		end

		var_16_8(var_16_1, var_16_6 <= var_16_5 and not var_16_7 and var_16_0)
	end

	return
end

function var_0_0.updateTecItem(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.panelList[arg_17_1]

	arg_17_0:updateTecLevelAward(arg_17_0.panelList[arg_17_1]:Find("AwardPanel"), arg_17_1)

	local var_17_1 = var_17_0:Find("BaseInfo")
	local var_17_2 = var_17_1:Find("BG/UpLevelColor")
	local var_17_3 = var_17_1:Find("Code")
	local var_17_4 = var_17_1:Find("UpLevelBG")
	local var_17_5 = var_17_4:Find("UpLevelBtn")
	local var_17_6 = var_17_4:Find("FinishBtn")
	local var_17_7 = var_17_1:Find("Uping")
	local var_17_8 = var_17_1:Find("Uping"):Find("Text")
	local var_17_9 = var_17_1:Find("ProgressBarBG/Progress")
	local var_17_10 = var_17_1:Find("LevelText/Text")
	local var_17_11 = var_17_1:Find("PointTextBar")
	local var_17_12 = pg.fleet_tech_group[arg_17_1].nation[1]

	setImageSprite(var_17_1:Find("NationBG"), GetSpriteFromAtlas("TecNation", "camptec_nation_bar_" .. pg.fleet_tech_group[arg_17_1].nation[1]))
	setImageSprite(var_17_1:Find("Code"):Find("NationTextImg"), GetSpriteFromAtlas("TecNation", "camptec_nation_text_" .. var_17_12), true)
	setImageSprite(var_17_1:Find("EnglishTextImg"), GetSpriteFromAtlas("TecNation", "camp_tec_english_" .. var_17_12), true)
	setImageSprite(var_17_1:Find("CampLogo"), GetSpriteFromAtlas("TecNation", "camptec_logo_" .. var_17_12))
	setText(var_17_1:Find("BG/Title/Text"), pg.fleet_tech_group[arg_17_1].name)

	local var_17_14
	local var_17_15 = not arg_17_0.tecList[arg_17_1] and 0 or table.indexof(pg.fleet_tech_group[arg_17_1].techs, arg_17_0.tecList[arg_17_1].completeID, 1) or 0
	local var_17_16 = arg_17_0.nationToPoint[var_17_12]
	local var_17_17

	if nil == 0 then
		var_17_14 = pg.fleet_tech_group[arg_17_1].techs[1]
		var_17_17 = pg.fleet_tech_template[pg.fleet_tech_group[arg_17_1].techs[1]].pt
	elseif var_17_15 == #pg.fleet_tech_group[arg_17_1].techs then
		var_17_14 = pg.fleet_tech_group[arg_17_1].techs[var_17_15]
		var_17_17 = pg.fleet_tech_template[pg.fleet_tech_group[arg_17_1].techs[var_17_15]].pt
	else
		var_17_17 = pg.fleet_tech_template[pg.fleet_tech_group[arg_17_1].techs[var_17_15 + 1]].pt
	end

	BaseUI:setImageAmount(var_17_9, 0.1 + 0.8 * var_17_16 / var_17_17)
	setText(var_17_10, var_17_15)
	setText(var_17_11, var_17_16 .. "/" .. var_17_17)

	if not arg_17_0.tecList[arg_17_1] then
		if var_17_17 <= var_17_16 then
			(function(arg_18_0, arg_18_1, arg_18_2)
				setActive(var_17_3, arg_18_0)
				setActive(var_17_4, arg_18_1)
				setActive(var_17_2, arg_18_1)
				setActive(var_17_5, arg_18_1)
				setActive(var_17_7, arg_18_2)

				return
			end)(false, true, false)
		else
			(function(arg_18_0, arg_18_1, arg_18_2)
				setActive(var_17_3, arg_18_0)
				setActive(var_17_4, arg_18_1)
				setActive(var_17_2, arg_18_1)
				setActive(var_17_5, arg_18_1)
				setActive(var_17_7, arg_18_2)

				return
			end)(true, false, false)
		end
	elseif var_17_15 == #pg.fleet_tech_group[arg_17_1].techs then
		(function(arg_18_0, arg_18_1, arg_18_2)
			setActive(var_17_3, arg_18_0)
			setActive(var_17_4, arg_18_1)
			setActive(var_17_2, arg_18_1)
			setActive(var_17_5, arg_18_1)
			setActive(var_17_7, arg_18_2)

			return
		end)(true, false, false)
	elseif arg_17_0.tecList[arg_17_1].studyID ~= 0 then
		(function(arg_18_0, arg_18_1, arg_18_2)
			setActive(var_17_3, arg_18_0)
			setActive(var_17_4, arg_18_1)
			setActive(var_17_2, arg_18_1)
			setActive(var_17_5, arg_18_1)
			setActive(var_17_7, arg_18_2)

			return
		end)(false, false, true)

		if arg_17_0.timerList[arg_17_1] then
			arg_17_0.timerList[arg_17_1]:Stop()
		end

		setText(var_17_8, pg.TimeMgr.GetInstance():DescCDTime((arg_17_0.nationProxy:getLeftTime())))

		arg_17_0.timerList[arg_17_1] = Timer.New(function()
			var_0 = var_0 - 1

			setText(var_17_8, pg.TimeMgr.GetInstance():DescCDTime(var_0))

			if var_0 == 0 then
				arg_17_0.timerList[arg_17_1]:Stop()
			end

			return
		end, 1, -1)

		arg_17_0.timerList[arg_17_1]:Start()
	elseif var_17_17 <= var_17_16 then
		(function(arg_18_0, arg_18_1, arg_18_2)
			setActive(var_17_3, arg_18_0)
			setActive(var_17_4, arg_18_1)
			setActive(var_17_2, arg_18_1)
			setActive(var_17_5, arg_18_1)
			setActive(var_17_7, arg_18_2)

			return
		end)(false, true, false)
	else
		(function(arg_18_0, arg_18_1, arg_18_2)
			setActive(var_17_3, arg_18_0)
			setActive(var_17_4, arg_18_1)
			setActive(var_17_2, arg_18_1)
			setActive(var_17_5, arg_18_1)
			setActive(var_17_7, arg_18_2)

			return
		end)(true, false, false)
	end

	onButton(arg_17_0, var_17_5, function()
		arg_17_0:emit(TechnologyConst.CLICK_UP_TEC_BTN, arg_17_1, var_17_14)

		return
	end, SFX_PANEL)

	local var_17_18 = var_17_0:Find("Mask/DetailPanel")
	local var_17_19 = GetComponent(var_17_0, "LayoutElement")
	local var_17_20 = var_17_18:Find("Toggle")

	arg_17_0:updateDetailPanel(var_17_18, var_17_15, arg_17_1, var_17_12, false)
	onToggle(arg_17_0, var_17_1:Find("BG"), function(arg_21_0)
		if arg_21_0 then
			triggerToggle(var_17_20, false)
			LeanTween.value(go(var_17_0), arg_17_0.tecItemTplOriginWidth, arg_17_0.tecItemTplOriginWidth + var_17_18.rect.width, 0.25):setOnUpdate(System.Action_float(function(arg_22_0)
				var_17_19.preferredWidth = arg_22_0

				if arg_17_1 == #pg.fleet_tech_group.all then
					arg_17_0.scrollRectCom.horizontalNormalizedPosition = 1
				end

				return
			end)):setOnComplete(System.Action(function()
				if arg_17_1 == #pg.fleet_tech_group.all then
					arg_17_0.scrollRectCom.horizontalNormalizedPosition = 1
				end

				return
			end))
		else
			LeanTween.cancel(go(var_17_0))
			LeanTween.value(go(var_17_0), var_17_19.preferredWidth, arg_17_0.tecItemTplOriginWidth, 0.25):setOnUpdate(System.Action_float(function(arg_24_0)
				var_17_19.preferredWidth = arg_24_0

				return
			end))
		end

		return
	end)

	return
end

function var_0_0.updateDetailPanel(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5)
	local var_25_0 = arg_25_1:Find("TypeItemContainer")

	setImageSprite(arg_25_1:Find("BG/Logo"), GetSpriteFromAtlas("TecNation", "camptec_logo_" .. arg_25_4))

	local var_25_1 = arg_25_1:Find("Toggle")

	if arg_25_2 == #pg.fleet_tech_group[arg_25_3].techs and arg_25_5 == false then
		setActive(var_25_1, false)
	end

	local function var_25_2(arg_26_0, arg_26_1, arg_26_2)
		local var_26_0 = UIItemList.New(var_25_0, arg_25_0.typeItemTpl)
		local var_26_1

		if arg_26_0 == 0 then
			var_26_0:align(0)

			return
		else
			var_26_1 = pg.fleet_tech_group[arg_26_1].techs[arg_26_0]
		end

		local var_26_2
		local var_26_3
		local var_26_4
		local var_26_5 = Color.New(1, 0.9333333333333333, 0.19215686274509805)
		local var_26_6, var_26_7

		if arg_26_2 then
			var_26_2, var_26_3, var_26_4 = arg_25_0:calculateCurBuff(arg_26_0 - 1, arg_26_1)
			var_26_6 = {}
			var_26_7 = {}
		end

		for iter_26_0, iter_26_1 in ipairs(pg.fleet_tech_template[var_26_1].add) do
			for iter_26_2, iter_26_3 in ipairs((ShipType.FilterOverQuZhuType(iter_26_1[1]))) do
				local var_26_8 = arg_26_2 and (not table.indexof(var_26_2, iter_26_3, 1) and {
					attr = iter_26_1[2],
					value = iter_26_1[3],
					attrColor = var_26_5,
					valueColor = var_26_5
				} or not table.indexof(var_26_3[iter_26_3], iter_26_1[2], 1) and {
					attr = iter_26_1[2],
					value = iter_26_1[3],
					attrColor = var_26_5,
					valueColor = var_26_5
				} or iter_26_1[3] ~= var_26_4[iter_26_3][iter_26_1[2]] and {
					attr = iter_26_1[2],
					value = iter_26_1[3],
					valueColor = var_26_5
				} or {
					attr = iter_26_1[2],
					value = iter_26_1[3]
				}) or {
					attr = iter_26_1[2],
					value = iter_26_1[3]
				}

				if var_26_6[iter_26_3] then
					table.insert(var_26_6[iter_26_3], var_26_8)
				else
					var_26_6[iter_26_3] = {
						var_26_8
					}
					var_26_7[#var_26_7 + 1] = iter_26_3
				end
			end
		end

		var_26_0:make(function(arg_27_0, arg_27_1, arg_27_2)
			if arg_27_0 == UIItemList.EventUpdate then
				local var_27_0 = arg_27_2:Find("BuffItemContainer")

				setImageSprite(arg_27_2:Find("TypeIcon"), GetSpriteFromAtlas("ShipType", "buffitem_tec_" .. var_26_7[arg_27_1 + 1]))
				arg_25_0:upBuffList(arg_27_2, var_26_6[var_26_7[arg_27_1 + 1]])
			end

			return
		end)
		var_26_0:align(#var_26_7)

		return
	end

	onToggle(arg_25_0, var_25_1, function(arg_28_0)
		if arg_28_0 == true then
			var_25_2(arg_25_2 + 1, arg_25_3, true)
		else
			var_25_2(arg_25_2, arg_25_3)
		end

		return
	end, SFX_PANEL)

	if arg_25_5 == false then
		triggerToggle(var_25_1, false)
	end

	return
end

function var_0_0.upBuffList(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = UIItemList.New(arg_29_1:Find("BuffItemContainer"), arg_29_0.buffItemTpl)

	var_29_0:make(function(arg_30_0, arg_30_1, arg_30_2)
		if arg_30_0 == UIItemList.EventUpdate then
			local var_30_0 = arg_30_2:Find("AttrText")
			local var_30_1 = arg_30_2:Find("ValueText")
			local var_30_2 = arg_29_2[arg_30_1 + 1].valueColor

			setText(var_30_0, AttributeType.Type2Name(pg.attribute_info_by_type[arg_29_2[arg_30_1 + 1].attr].name))
			setText(var_30_1, "+" .. arg_29_2[arg_30_1 + 1].value)

			if arg_29_2[arg_30_1 + 1].attrColor then
				setTextColor(var_30_0, arg_29_2[arg_30_1 + 1].attrColor)
			else
				setTextColor(var_30_0, Color.white)
			end

			if var_30_2 then
				setTextColor(var_30_1, var_30_2)
			else
				setTextColor(var_30_1, Color.green)
			end
		end

		return
	end)
	var_29_0:align(#arg_29_2)

	return
end

function var_0_0.updateTecLevelAward(arg_31_0, arg_31_1, arg_31_2)
	if LOCK_TEC_NATION_AWARD then
		setActive(arg_31_1, false)

		return
	end

	local var_31_0 = arg_31_0._tf:Find("AwardItem")
	local var_31_1 = arg_31_1:Find("ItemContainer")
	local var_31_2 = UIItemList.New(var_31_1, arg_31_0.awardTpl)
	local var_31_3 = arg_31_1:Find("Level")
	local var_31_4 = arg_31_1:Find("Level/Num")
	local var_31_5 = arg_31_1:Find("GetBtn")
	local var_31_6 = arg_31_1:Find("DisGetBtn")
	local var_31_7 = arg_31_1:Find("FinishBtn")
	local var_31_8 = arg_31_0.nationProxy:GetTecItemByGroupID(arg_31_2)
	local var_31_9 = pg.fleet_tech_group[arg_31_2]

	if var_31_8 then
		local var_31_10 = var_31_8.rewardedID or 0

		if var_31_8 then
			local var_31_11 = var_31_8.completeID or 0
			local var_31_12 = table.indexof(var_31_9.techs, var_31_10, 1) or 0
			local var_31_13 = table.indexof(var_31_9.techs, var_31_11, 1) or 0
			local var_31_14 = var_31_12 + 1
			local var_31_15

			var_31_15 = var_31_12 < var_31_13 and var_31_9.techs[var_31_14] or var_31_12 == var_31_13 and var_31_12 < #var_31_9.techs and var_31_9.techs[var_31_14] or var_31_15

			if var_31_15 then
				setActive(var_31_3, true)
				setActive(var_31_1, true)
				setActive(var_31_5, var_31_12 < var_31_13)
				setActive(var_31_6, var_31_12 == var_31_13)
				setActive(var_31_7, false)
				setText(var_31_4, var_31_14)

				local var_31_16 = pg.fleet_tech_template[var_31_15].level_award_display

				var_31_2:make(function(arg_32_0, arg_32_1, arg_32_2)
					if arg_32_0 == UIItemList.EventUpdate then
						arg_32_1 = arg_32_1 + 1

						updateDrop(arg_32_2, {
							type = var_31_16[arg_32_1][1],
							id = var_31_16[arg_32_1][2],
							count = var_31_16[arg_32_1][3]
						})
					end

					return
				end)
				var_31_2:align(#pg.fleet_tech_template[var_31_15].level_award_display)

				if var_31_12 < var_31_13 then
					onButton(arg_31_0, var_31_5, function()
						pg.m02:sendNotification(GAME.GET_CAMP_TEC_AWARD, {
							groupID = arg_31_2,
							tecID = var_31_15
						})

						return
					end, SFX_PANEL)
				end
			else
				setActive(var_31_3, false)
				setActive(var_31_1, false)
				setActive(var_31_5, false)
				setActive(var_31_6, false)
				setActive(var_31_7, true)
			end

			return
		end
	end
end

function var_0_0.updateOneStepBtn(arg_34_0)
	if LOCK_TEC_NATION_AWARD then
		setActive(arg_34_0.oneStepBtn, false)

		return
	end

	setActive(arg_34_0.oneStepBtn, arg_34_0.nationProxy:isAnyTecCampCanGetAward())

	return
end

function var_0_0.updateTecListData(arg_35_0)
	arg_35_0.tecList = getProxy(TechnologyNationProxy):GetTecList()

	return
end

return var_0_0
