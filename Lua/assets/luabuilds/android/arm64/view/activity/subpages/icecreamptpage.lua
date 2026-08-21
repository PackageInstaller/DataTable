local var_0_0 = class("IcecreamPTPage", import(".TemplatePage.PtTemplatePage"))

var_0_0.FADE_TIME = 0.5
var_0_0.SHOW_TIME = 1
var_0_0.FADE_OUT_TIME = 0.5
var_0_0.Menu_Ani_Open_Time = 0.5
var_0_0.Menu_Ani_Close_Time = 0.3
var_0_0.PosList = {
	188,
	70,
	-55,
	-178
}
var_0_0.Icecream_Save_Tag_Pre = "Icecream_Tag_"

function var_0_0.OnDataSetting(arg_1_0)
	var_0_0.super.OnDataSetting(arg_1_0)

	arg_1_0.specialPhaseList = arg_1_0.activity:getConfig("config_data")
	arg_1_0.selectedList = arg_1_0:getSelectedList()
	arg_1_0.curSelectOrder = 0
	arg_1_0.curSelectIndex = 0

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	var_0_0.super.OnFirstFlush(arg_2_0)
	arg_2_0:findUI()
	arg_2_0:initMainPanel()
	arg_2_0:addListener()
	arg_2_0:initSD()

	return
end

function var_0_0.OnUpdateFlush(arg_3_0)
	var_0_0.super.OnUpdateFlush(arg_3_0)

	local var_3_0, var_3_1, var_3_2 = arg_3_0.ptData:GetLevelProgress()

	setText(arg_3_0.step, var_3_0)

	if isActive(arg_3_0.specialTF) then
		setActive(arg_3_0.specialTF, false)
	end

	arg_3_0:updateIcecream()
	arg_3_0:updateMainSelectPanel()
	setActive(arg_3_0.openBtn, arg_3_0:isFinished())
	setActive(arg_3_0.shareBtn, arg_3_0:isFinished())

	return
end

function var_0_0.OnDestroy(arg_4_0)
	if arg_4_0.spine then
		arg_4_0.spine.transform.localScale = Vector3.one

		pg.PoolMgr.GetInstance():ReturnSpineChar("salatuojia_8", arg_4_0.spine)

		arg_4_0.spine = nil
	end

	if arg_4_0.shareGo then
		PoolMgr.GetInstance():ReturnUI("IcecreamSharePage", arg_4_0.shareGo)

		arg_4_0.shareGo = nil
	end

	return
end

function var_0_0.findUI(arg_5_0)
	arg_5_0.shareBtn = arg_5_0.bg:Find("Logo/share_btn")
	arg_5_0.icecreamTF = arg_5_0.bg:Find("Icecream")
	arg_5_0.openBtn = arg_5_0.bg:Find("open_btn")
	arg_5_0.helpBtn = arg_5_0.bg:Find("help_btn")
	arg_5_0.specialTF = arg_5_0._tf:Find("Special")
	arg_5_0.backBG = arg_5_0.specialTF:Find("BG")
	arg_5_0.menuTF = arg_5_0.specialTF:Find("Menu")
	arg_5_0.mainPanel = arg_5_0.menuTF:Find("MainPanel")
	arg_5_0.mainToggleTFList = {}

	for iter_5_0 = 1, 4 do
		arg_5_0.mainToggleTFList[iter_5_0] = arg_5_0.mainPanel:GetChild(iter_5_0 - 1)
	end

	arg_5_0.secondPanel = arg_5_0.menuTF:Find("SecondList")
	arg_5_0.selectBtn = arg_5_0.menuTF:Find("SelectBtn")
	arg_5_0.mainPanelCG = GetComponent(arg_5_0.mainPanel, "CanvasGroup")
	arg_5_0.secondPanelCG = GetComponent(arg_5_0.secondPanel, "CanvasGroup")
	arg_5_0.selectBtnImg = GetComponent(arg_5_0.selectBtn, "Image")
	arg_5_0.resTF = arg_5_0._tf:Find("Res")
	arg_5_0.iconTable = {
		["1"] = {
			arg_5_0.resTF:Find("1/1"),
			arg_5_0.resTF:Find("1/2"),
			(arg_5_0.resTF:Find("1/3"))
		},
		["21"] = {
			arg_5_0.resTF:Find("2/1/1"),
			arg_5_0.resTF:Find("2/1/2"),
			(arg_5_0.resTF:Find("2/1/3"))
		},
		["22"] = {
			arg_5_0.resTF:Find("2/2/1"),
			arg_5_0.resTF:Find("2/2/2"),
			(arg_5_0.resTF:Find("2/2/3"))
		},
		["23"] = {
			arg_5_0.resTF:Find("2/3/1"),
			arg_5_0.resTF:Find("2/3/2"),
			(arg_5_0.resTF:Find("2/3/3"))
		},
		["3"] = {
			arg_5_0.resTF:Find("3/1"),
			arg_5_0.resTF:Find("3/2"),
			(arg_5_0.resTF:Find("3/3"))
		},
		["4"] = {
			arg_5_0.resTF:Find("4/1"),
			arg_5_0.resTF:Find("4/2"),
			(arg_5_0.resTF:Find("4/3"))
		}
	}
	arg_5_0.icecreamResTF = arg_5_0._tf:Find("Icecream")
	arg_5_0.mainToggleSelectedTF = {}
	arg_5_0.mainToggleUnlockTF = {}

	for iter_5_1, iter_5_2 in ipairs(arg_5_0.mainToggleTFList) do
		arg_5_0.mainToggleSelectedTF[iter_5_1] = iter_5_2:GetChild(1)
		arg_5_0.mainToggleUnlockTF[iter_5_1] = iter_5_2:GetChild(0)
	end

	return
end

function var_0_0.addListener(arg_6_0)
	if IsUnityEditor then
		onButton(arg_6_0, arg_6_0.bg:Find("Logo"), function()
			for iter_7_0 = 1, 4 do
				PlayerPrefs.SetInt(var_0_0.Icecream_Save_Tag_Pre .. iter_7_0, 0)
			end

			return
		end, SFX_PANEL)
	end

	onButton(arg_6_0, arg_6_0.getBtn, function()
		local var_8_0, var_8_1, var_8_2 = arg_6_0.ptData:GetLevelProgress()
		local var_8_3 = table.indexof(arg_6_0.specialPhaseList, var_8_0, 1)

		if var_8_3 then
			arg_6_0:openMainPanel(var_8_3)
		else
			local var_8_4 = {}
			local var_8_5 = arg_6_0.ptData:GetAward()

			if var_8_5.type == DROP_TYPE_RESOURCE and var_8_5.id == PlayerConst.ResGold and getProxy(PlayerProxy):getData():GoldMax(var_8_5.count) then
				table.insert(var_8_4, function(arg_9_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = i18n("gold_max_tip_title") .. i18n("award_max_warning"),
						onYes = arg_9_0
					})

					return
				end)
			end

			seriesAsync(var_8_4, function()
				local var_10_0, var_10_1 = arg_6_0.ptData:GetResProgress()

				arg_6_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
					cmd = 1,
					activity_id = arg_6_0.ptData:GetId(),
					arg1 = var_10_1
				})

				return
			end)
		end

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.battleBtn, function()
		arg_6_0:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.openBtn, function()
		arg_6_0:openMainPanel()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.icecream_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.shareBtn, function()
		arg_6_0:share()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.initMainPanel(arg_15_0)
	onButton(arg_15_0, arg_15_0.backBG, function()
		arg_15_0:closeSpecial()

		if arg_15_0:isFinished() then
			setActive(arg_15_0.openBtn, true)
		end

		return
	end, SFX_CANCEL)

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.mainToggleTFList) do
		onToggle(arg_15_0, iter_15_1, function(arg_17_0)
			if arg_17_0 == true then
				arg_15_0.curSelectOrder = iter_15_0

				setLocalPosition(arg_15_0.secondPanel, {
					y = var_0_0.PosList[iter_15_0]
				})
				setLocalPosition(arg_15_0.selectBtn, {
					y = var_0_0.PosList[iter_15_0]
				})

				local var_17_0

				if iter_15_0 == 1 then
					var_17_0 = arg_15_0.iconTable["1"]
				elseif iter_15_0 == 2 then
					var_17_0 = arg_15_0.iconTable[2 .. arg_15_0.selectedList[1]]
				elseif iter_15_0 == 3 then
					var_17_0 = arg_15_0.iconTable["3"]
				elseif iter_15_0 == 4 then
					var_17_0 = arg_15_0.iconTable["4"]
				end

				local var_17_1 = {}

				for iter_17_0 = 1, 3 do
					var_17_1[iter_17_0] = arg_15_0.secondPanel:GetChild(iter_17_0)
				end

				for iter_17_1 = 1, 3 do
					setImageSprite(var_17_1[iter_17_1]:Find("icon"), getImageSprite(var_17_0[iter_17_1]), true)
					onToggle(arg_15_0, var_17_1[iter_17_1], function(arg_18_0)
						if arg_18_0 == true then
							local var_18_0 = Clone(arg_15_0.selectedList)

							var_18_0[arg_15_0.curSelectOrder] = iter_17_1

							arg_15_0:updateIcecream(var_18_0)
							arg_15_0:openSelectBtn()

							arg_15_0.curSelectIndex = iter_17_1
						else
							setActive(arg_15_0.selectBtn, false)

							arg_15_0.curSelectIndex = 0
						end

						return
					end, SFX_PANEL)
				end

				for iter_17_2 = 1, 3 do
					triggerToggle(var_17_1[iter_17_2], false)
				end

				arg_15_0:openSecondPanel()
				setActive(arg_15_0.selectBtn, false)
			else
				arg_15_0.curSelectOrder = 0

				setActive(arg_15_0.secondPanel, false)
				setActive(arg_15_0.selectBtn, false)
			end

			arg_15_0:updateMainSelectPanel()

			return
		end, SFX_PANEL)
	end

	onButton(arg_15_0, arg_15_0.selectBtn, function()
		if not arg_15_0:isFinished() then
			if arg_15_0.curSelectIndex then
				local var_19_0, var_19_1 = arg_15_0.ptData:GetResProgress()

				arg_15_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
					cmd = 1,
					activity_id = arg_15_0.ptData:GetId(),
					arg1 = var_19_1,
					arg2 = arg_15_0.curSelectIndex,
					callback = function()
						arg_15_0.selectedList[arg_15_0.curSelectOrder] = arg_15_0.curSelectIndex

						arg_15_0:closeSpecial()

						return
					end
				})
			end
		else
			arg_15_0:changeIndexSelect()
			arg_15_0:updateIcecream()
			arg_15_0:updateMainSelectPanel()
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.openMainPanel(arg_21_0, arg_21_1)
	arg_21_0.selectedList = arg_21_0:getSelectedList()

	setActive(arg_21_0.displayBtn, false)
	setActive(arg_21_0.slider, false)
	setActive(arg_21_0.awardTF, false)
	setActive(arg_21_0.progress, false)

	for iter_21_0 = 1, 4 do
		triggerToggle(arg_21_0.mainToggleTFList[iter_21_0], false)

		GetComponent(arg_21_0.mainToggleTFList[iter_21_0], "Toggle").interactable = arg_21_0:isFinished()
	end

	arg_21_0:updateMainSelectPanel()
	setActive(arg_21_0.specialTF, true)
	LeanTween.value(go(arg_21_0.mainPanel), 0, 1, var_0_0.Menu_Ani_Open_Time):setOnUpdate(System.Action_float(function(arg_22_0)
		arg_21_0.mainPanelCG.alpha = arg_22_0

		return
	end)):setOnComplete(System.Action(function()
		arg_21_0.mainPanelCG.alpha = 1

		return
	end))
	LeanTween.value(go(arg_21_0.mainPanel), -391, -271, var_0_0.Menu_Ani_Open_Time):setOnUpdate(System.Action_float(function(arg_24_0)
		setLocalPosition(arg_21_0.mainPanel, {
			x = arg_24_0
		})

		return
	end)):setOnComplete(System.Action(function()
		setLocalPosition(arg_21_0.mainPanel, {
			x = -271
		})

		if arg_21_1 and arg_21_1 > 0 then
			triggerToggle(arg_21_0.mainToggleTFList[arg_21_1], true)
		end

		return
	end))

	return
end

function var_0_0.closeMainPanel(arg_26_0)
	LeanTween.value(go(arg_26_0.mainPanel), 1, 0, var_0_0.Menu_Ani_Close_Time):setOnUpdate(System.Action_float(function(arg_27_0)
		arg_26_0.mainPanelCG.alpha = arg_27_0

		return
	end)):setOnComplete(System.Action(function()
		arg_26_0.mainPanelCG.alpha = 0

		setActive(arg_26_0.specialTF, false)

		return
	end))
	LeanTween.value(go(arg_26_0.mainPanel), -271, -391, var_0_0.Menu_Ani_Close_Time):setOnUpdate(System.Action_float(function(arg_29_0)
		setLocalPosition(arg_26_0.mainPanel, {
			x = arg_29_0
		})

		return
	end)):setOnComplete(System.Action(function()
		setLocalPosition(arg_26_0.mainPanel, {
			x = -391
		})
		setActive(arg_26_0.specialTF, false)
		arg_26_0:updateIcecream()
		setActive(arg_26_0.displayBtn, true)
		setActive(arg_26_0.slider, true)
		setActive(arg_26_0.awardTF, true)
		setActive(arg_26_0.progress, true)

		return
	end))

	return
end

function var_0_0.openSecondPanel(arg_31_0)
	setActive(arg_31_0.secondPanel, true)
	LeanTween.value(go(arg_31_0.secondPanel), 0, 1, var_0_0.Menu_Ani_Open_Time):setOnUpdate(System.Action_float(function(arg_32_0)
		arg_31_0.secondPanelCG.alpha = arg_32_0

		return
	end)):setOnComplete(System.Action(function()
		arg_31_0.secondPanelCG.alpha = 1

		return
	end))
	LeanTween.value(go(arg_31_0.secondPanel), -646, -213, var_0_0.Menu_Ani_Open_Time):setOnUpdate(System.Action_float(function(arg_34_0)
		setLocalPosition(arg_31_0.secondPanel, {
			x = arg_34_0
		})

		return
	end)):setOnComplete(System.Action(function()
		setLocalPosition(arg_31_0.secondPanel, {
			x = -213
		})

		return
	end))

	return
end

function var_0_0.closeSecondPanel(arg_36_0)
	LeanTween.value(go(arg_36_0.secondPanel), 1, 0, var_0_0.Menu_Ani_Close_Time):setOnUpdate(System.Action_float(function(arg_37_0)
		arg_36_0.secondPanelCG.alpha = arg_37_0

		return
	end)):setOnComplete(System.Action(function()
		arg_36_0.secondPanelCG.alpha = 0

		setActive(arg_36_0.secondPanel, false)

		return
	end))
	LeanTween.value(go(arg_36_0.secondPanel), -213, -646, var_0_0.Menu_Ani_Close_Time):setOnUpdate(System.Action_float(function(arg_39_0)
		setLocalPosition(arg_36_0.secondPanel, {
			x = arg_39_0
		})

		return
	end)):setOnComplete(System.Action(function()
		setLocalPosition(arg_36_0.secondPanel, {
			x = -646
		})
		setActive(arg_36_0.secondPanel, false)
		arg_36_0:closeMainPanel()

		return
	end))

	return
end

function var_0_0.openSelectBtn(arg_41_0)
	setLocalPosition(arg_41_0.selectBtn, {
		x = 287
	})
	setActive(arg_41_0.selectBtn, true)
	LeanTween.value(go(arg_41_0.selectBtn), 0, 1, var_0_0.Menu_Ani_Open_Time):setOnUpdate(System.Action_float(function(arg_42_0)
		setImageAlpha(arg_41_0.selectBtn, arg_42_0)

		return
	end)):setOnComplete(System.Action(function()
		setImageAlpha(arg_41_0.selectBtn, 1)

		return
	end))

	return
end

function var_0_0.closeSelectBtn(arg_44_0)
	LeanTween.value(go(arg_44_0.selectBtn), 1, 0, var_0_0.Menu_Ani_Close_Time):setOnUpdate(System.Action_float(function(arg_45_0)
		setImageAlpha(arg_44_0.selectBtn, arg_45_0)

		return
	end)):setOnComplete(System.Action(function()
		setImageAlpha(arg_44_0.selectBtn, 0)
		setActive(arg_44_0.selectBtn, false)

		return
	end))

	return
end

function var_0_0.closeSpecial(arg_47_0)
	arg_47_0:closeSelectBtn()
	arg_47_0:closeSecondPanel()

	return
end

function var_0_0.updateIcecream(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_1 or arg_48_0.selectedList

	setActive(arg_48_0.icecreamTF, (arg_48_1 or arg_48_0.selectedList)[1] > 0)

	local var_48_1 = arg_48_0.icecreamTF:Find("1")
	local var_48_2 = arg_48_0.icecreamTF:Find("2")
	local var_48_3 = arg_48_0.icecreamTF:Find("3")
	local var_48_4 = arg_48_0.icecreamTF:Find("4")
	local var_48_5 = var_48_0[1] and var_48_0[1] > 0

	if var_48_5 then
		for iter_48_0, iter_48_1 in pairs(var_48_0) do
			if iter_48_1 > 0 and iter_48_0 > 1 then
				var_48_5 = false
			end
		end
	end

	setActive(var_48_1, var_48_5)

	local var_48_6 = var_48_0[2] and var_48_0[2] > 0

	setActive(var_48_2, var_48_6)

	local var_48_7 = var_48_0[3] and var_48_0[3] > 0

	setActive(var_48_3, var_48_7)

	local var_48_8 = var_48_0[4] and var_48_0[4] > 0

	setActive(var_48_4, var_48_8)

	if var_48_5 then
		setImageSprite(var_48_1:Find("Taste"), getImageSprite(arg_48_0.icecreamResTF:Find("1_" .. var_48_0[1])), true)
	end

	if var_48_0[2] and var_48_0[2] > 0 then
		setImageSprite(var_48_2, getImageSprite(arg_48_0.icecreamResTF:Find("2_" .. var_48_0[1] .. var_48_0[2])), true)
	end

	if var_48_0[3] and var_48_0[3] > 0 then
		setImageSprite(var_48_3, getImageSprite(arg_48_0.icecreamResTF:Find("3_" .. var_48_0[3])), true)
	end

	if var_48_0[4] and var_48_0[4] > 0 then
		setImageSprite(var_48_4, getImageSprite(arg_48_0.icecreamResTF:Find("4_" .. var_48_0[4])), true)
	end

	return
end

function var_0_0.updateMainSelectPanel(arg_49_0)
	for iter_49_0 = 1, 4 do
		local var_49_0 = arg_49_0.selectedList[iter_49_0] and arg_49_0.selectedList[iter_49_0] > 0

		setActive(arg_49_0.mainToggleUnlockTF[iter_49_0], var_49_0)
	end

	if arg_49_0.curSelectOrder > 0 then
		setActive(arg_49_0.mainToggleUnlockTF[arg_49_0.curSelectOrder], true)
	end

	if arg_49_0.selectedList[1] and arg_49_0.selectedList[1] > 0 then
		setImageSprite(arg_49_0.mainToggleSelectedTF[1], getImageSprite(arg_49_0.iconTable["1"][arg_49_0.selectedList[1]]), true)
		setActive(arg_49_0.mainToggleSelectedTF[1], true)
	else
		setActive(arg_49_0.mainToggleSelectedTF[1], false)
	end

	if arg_49_0.selectedList[2] and arg_49_0.selectedList[2] > 0 then
		setImageSprite(arg_49_0.mainToggleSelectedTF[2], getImageSprite(arg_49_0.iconTable[2 .. arg_49_0.selectedList[1]][arg_49_0.selectedList[2]]), true)
		setActive(arg_49_0.mainToggleSelectedTF[2], true)
	else
		setActive(arg_49_0.mainToggleSelectedTF[2], false)
	end

	if arg_49_0.selectedList[3] and arg_49_0.selectedList[3] > 0 then
		setImageSprite(arg_49_0.mainToggleSelectedTF[3], getImageSprite(arg_49_0.iconTable["3"][arg_49_0.selectedList[3]]), true)
		setActive(arg_49_0.mainToggleSelectedTF[3], true)
	else
		setActive(arg_49_0.mainToggleSelectedTF[3], false)
	end

	if arg_49_0.selectedList[4] and arg_49_0.selectedList[4] > 0 then
		setImageSprite(arg_49_0.mainToggleSelectedTF[4], getImageSprite(arg_49_0.iconTable["4"][arg_49_0.selectedList[4]]), true)
		setActive(arg_49_0.mainToggleSelectedTF[4], true)
	else
		setActive(arg_49_0.mainToggleSelectedTF[4], false)
	end

	return
end

function var_0_0.isFinished(arg_50_0)
	return #arg_50_0.activity.data2_list == 4
end

function var_0_0.changeIndexSelect(arg_51_0)
	arg_51_0.selectedList[arg_51_0.curSelectOrder] = arg_51_0.curSelectIndex

	PlayerPrefs.SetInt(var_0_0.Icecream_Save_Tag_Pre .. arg_51_0.curSelectOrder, arg_51_0.curSelectIndex)

	return
end

function var_0_0.getSelectedList(arg_52_0)
	arg_52_0.selectedList = {
		0,
		0,
		0,
		0
	}

	for iter_52_0, iter_52_1 in ipairs(arg_52_0.activity.data2_list) do
		arg_52_0.selectedList[iter_52_0] = iter_52_1
	end

	if arg_52_0:isFinished() then
		for iter_52_2 = 1, 4 do
			local var_52_0 = PlayerPrefs.GetInt(var_0_0.Icecream_Save_Tag_Pre .. iter_52_2, 0)

			if var_52_0 > 0 then
				arg_52_0.selectedList[iter_52_2] = var_52_0
			end
		end
	end

	arg_52_0:saveSelectedList()

	return arg_52_0.selectedList
end

function var_0_0.saveSelectedList(arg_53_0)
	for iter_53_0 = 1, 4 do
		PlayerPrefs.SetInt(var_0_0.Icecream_Save_Tag_Pre .. iter_53_0, arg_53_0.selectedList[iter_53_0])
	end

	return
end

function var_0_0.share(arg_54_0)
	PoolMgr.GetInstance():GetUI("IcecreamSharePage", false, function(arg_55_0)
		local var_55_9000

		SetParent(arg_55_0, GameObject.Find("UICamera/Canvas/UIMain"), false)

		arg_54_0.shareGo = arg_55_0

		local var_55_0 = arg_55_0:Find("IcecreamContainer")

		setText(arg_55_0:Find("PlayerName"), i18n("icecream_make_tip", getProxy(PlayerProxy):getData().name))

		local var_55_1 = getProxy(PlayerProxy)
		local var_55_2 = var_55_1.getRawData(var_55_9000)
		local var_55_3 = getProxy(UserProxy):getRawData()
		local var_55_4 = getProxy(ServerProxy).getRawData(var_55_1)

		if var_55_3 then
			local var_55_5 = var_55_3.server or 0
			local var_55_6 = var_55_4[var_55_5]

			if var_55_2 then
				local var_55_7 = var_55_2.name or ""

				if var_55_6 then
					local var_55_8 = var_55_6.name or ""
					local var_55_9 = arg_55_0:Find("deck")

					setText(var_55_9:Find("name/value"), var_55_7)
					setText(var_55_9:Find("server/value"), var_55_8)
					setText(var_55_9:Find("lv/value"), var_55_2.level)

					local var_55_10 = cloneTplTo(arg_54_0.icecreamTF, var_55_0)

					setLocalPosition(tf(var_55_10), {
						x = 0,
						y = 0
					})
					setLocalScale(tf(var_55_10), {
						x = 1.4,
						y = 1.4
					})
					pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeIcecream)

					if arg_54_0.shareGo then
						PoolMgr.GetInstance():ReturnUI("IcecreamSharePage", arg_54_0.shareGo)

						arg_54_0.shareGo = nil
					end

					return
				end
			end
		end
	end)

	return
end

function var_0_0.initSD(arg_56_0)
	arg_56_0.sdContainer = arg_56_0.bg:Find("sdcontainer")
	arg_56_0.spine = nil
	arg_56_0.spineLRQ = GetSpineRequestPackage.New("salatuojia_8", function(arg_57_0)
		SetParent(arg_57_0, arg_56_0.sdContainer)

		arg_56_0.spine = arg_57_0
		arg_56_0.spine.transform.localScale = Vector3.one

		local var_57_0 = arg_56_0.spine:GetComponent("SpineAnimUI")

		if var_57_0 then
			var_57_0:SetAction("stand", 0)
		end

		arg_56_0.spineLRQ = nil

		return
	end):Start()

	setActive(arg_56_0.sdContainer, true)

	return
end

return var_0_0
