local var_0_0 = class("DOAPtPage", import(".TemplatePage.PtTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.buffModule = arg_1_0.bg:Find("buff_module")
	arg_1_0.buffPanel = arg_1_0.buffModule:Find("skill")
	arg_1_0.buffLvs = {
		arg_1_0.buffPanel:Find("pow_lv"),
		arg_1_0.buffPanel:Find("tec_lv"),
		arg_1_0.buffPanel:Find("stm_lv"),
		arg_1_0.buffPanel:Find("apl_lv")
	}
	arg_1_0.getGreyBtn = arg_1_0.bg:Find("get_grey_btn")
	arg_1_0.helpBtn = arg_1_0.bg:Find("help_btn")
	arg_1_0.levelPanel = arg_1_0.buffModule:Find("level")
	arg_1_0.f2aPanel = arg_1_0.levelPanel:Find("f_to_a")
	arg_1_0.sPanel = arg_1_0.levelPanel:Find("s_ss")
	arg_1_0.sssPanel = arg_1_0.levelPanel:Find("sss")
	arg_1_0.lvBarImages = arg_1_0.bg:Find("lv_bars")
	arg_1_0.lvTagImages = arg_1_0.bg:Find("lv_tags")
	arg_1_0.shieldEffect = arg_1_0.buffModule:Find("level/shield_effect")
	arg_1_0.starEffect = arg_1_0.buffModule:Find("level/star_effect")
	arg_1_0.mask = arg_1_0.bg:Find("mask")
	arg_1_0.trainWindow = arg_1_0._tf:Find("TrainWindow")
	arg_1_0.trainBtn = arg_1_0.trainWindow:Find("panel/train_btn")
	arg_1_0.trainSkills = arg_1_0.trainWindow:Find("panel/skills")
	arg_1_0.trainSkillBtns = {
		arg_1_0.trainSkills:Find("pow_btn"),
		arg_1_0.trainSkills:Find("tec_btn"),
		arg_1_0.trainSkills:Find("stm_btn"),
		arg_1_0.trainSkills:Find("apl_btn")
	}
	arg_1_0.curInfoPanel = arg_1_0.trainWindow:Find("panel/info_bg")
	arg_1_0.curInfo = arg_1_0.trainWindow:Find("panel/info_bg/cur")
	arg_1_0.nextInfo = arg_1_0.trainWindow:Find("panel/info_bg/next")
	arg_1_0.msgBox = arg_1_0._tf:Find("MsgBox")
	arg_1_0.msgContent = arg_1_0.msgBox:Find("panel/content")
	arg_1_0.msgBoxMask = arg_1_0.msgBox:Find("mengban")
	arg_1_0.cancelBtn = arg_1_0.msgBox:Find("panel/cancel_btn")
	arg_1_0.confirmBtn = arg_1_0.msgBox:Find("panel/confirm_btn")
	arg_1_0.tipPanel = arg_1_0._tf:Find("Tip")
	arg_1_0.buffBox = arg_1_0._tf:Find("BuffBox")
	arg_1_0.buffMask = arg_1_0.buffBox:Find("mask")
	arg_1_0.buffIconParent = arg_1_0.buffBox:Find("window/panel/icon")
	arg_1_0.buffDescContent = arg_1_0.buffBox:Find("window/panel/intro_view/Viewport/Content")
	arg_1_0.buffDescTpl = arg_1_0.buffBox:Find("window/panel/intro_view/buff_desc_tpl")
	arg_1_0.singleBuffBox = arg_1_0._tf:Find("SingleBuffBox")
	arg_1_0.singleBuffMask = arg_1_0.singleBuffBox:Find("bg")
	arg_1_0.singleSureBtn = arg_1_0.singleBuffBox:Find("window/top/btnBack")
	arg_1_0.singleCloseBtn = arg_1_0.singleBuffBox:Find("window/sure_btn")
	arg_1_0.singleIconParent = arg_1_0.singleBuffBox:Find("window/panel/icon")
	arg_1_0.singleDescContent = arg_1_0.singleBuffBox:Find("window/panel/intro_view/Viewport/Content")
	arg_1_0.singleDescTpl = arg_1_0.singleBuffBox:Find("window/panel/intro_view/buff_desc_tpl")

	setText(arg_1_0.singleBuffBox:Find("window/top/bg/infomation/title"), i18n("words_information"))
	setText(arg_1_0.singleBuffBox:Find("window/sure_btn/pic"), i18n("text_confirm"))

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	var_0_0.super.OnFirstFlush(arg_2_0)
	setActive(arg_2_0.bg, true)
	removeOnButton(arg_2_0.getBtn)
	onButton(arg_2_0, arg_2_0.getBtn, function()
		local var_3_0 = arg_2_0.ptData:GetAward()

		if var_3_0.type == DROP_TYPE_RESOURCE and var_3_0.id == PlayerConst.ResGold and getProxy(PlayerProxy):getData():GoldMax(var_3_0.count) then
			table.insert({}, function(arg_4_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("gold_max_tip_title") .. i18n("award_max_warning"),
					onYes = arg_4_0
				})

				return
			end)
		end

		seriesAsync({}, function()
			arg_2_0.isShowEffect = true

			local var_5_0

			if arg_2_0.ptData:CanTrain() then
				var_5_0 = arg_2_0.ptData:isInBuffTime()
			end

			local function var_5_1()
				if var_5_0 then
					arg_2_0:showUpEffect()
				else
					arg_2_0:updateLevelPanel()
				end

				return
			end

			local var_5_2, var_5_3 = arg_2_0.ptData:GetResProgress()

			arg_2_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
				cmd = 1,
				activity_id = arg_2_0.ptData:GetId(),
				arg1 = var_5_3,
				callback = var_5_1
			})

			return
		end)

		return
	end, SFX_PANEL)
	removeOnButton(arg_2_0.battleBtn)
	onButton(arg_2_0, arg_2_0.battleBtn, function()
		local var_7_0
		local var_7_1
		local var_7_2 = arg_2_0.activity:getConfig("config_client")

		if var_7_2 ~= "" then
			var_7_0 = arg_2_0.activity:getConfig("config_client").linkActID

			if var_7_0 then
				var_7_1 = getProxy(ActivityProxy):getActivityById(var_7_0)
			end
		end

		local var_7_3 = var_7_2.fightLinkActID

		if var_7_2.fightLinkActID then
			arg_2_0:emit(ActivityMediator.SKIP_ACTIVITY_MAP, var_7_3)

			return
		end

		if not var_7_0 then
			arg_2_0:emit(ActivityMediator.BATTLE_OPERA)
		elseif var_7_1 and not var_7_1:isEnd() then
			arg_2_0:emit(ActivityMediator.BATTLE_OPERA)
		else
			arg_2_0:showTip(i18n("common_activity_end"))
		end

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("doa_pt_help")
		})

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.buffModule, function()
		arg_2_0:showBuffBox()

		return
	end, SFX_PANEL)

	if arg_2_0.contextData.singleActivity then
		setActive(arg_2_0.bg, false)
		arg_2_0:showSingleBuffBox()
	end

	arg_2_0.starEffect:GetComponent("DftAniEvent"):SetEndEvent(function()
		arg_2_0:updateLevelPanel()
		arg_2_0:managedTween(LeanTween.delayedCall, function()
			arg_2_0:showTrianPanel()
			setActive(arg_2_0.starEffect, false)
			setActive(arg_2_0.mask, false)
			pg.UIMgr.GetInstance():UnOverlayPanel(arg_2_0.mask, arg_2_0.bg)

			return
		end, 0.2, nil)

		return
	end)
	arg_2_0.shieldEffect:GetComponent("DftAniEvent"):SetEndEvent(function()
		arg_2_0:updateLevelPanel()
		arg_2_0:managedTween(LeanTween.delayedCall, function()
			arg_2_0:showTrianPanel()
			setActive(arg_2_0.starEffect, false)
			setActive(arg_2_0.mask, false)
			pg.UIMgr.GetInstance():UnOverlayPanel(arg_2_0.mask, arg_2_0.bg)

			return
		end, 0.2, nil)

		return
	end)

	arg_2_0.isShowEffect = false

	return
end

function var_0_0.showUpEffect(arg_14_0, arg_14_1)
	setSlider(arg_14_0.curPanel, 0, 1, 1)

	local var_14_0 = arg_14_0.ptData:GetBuffLevelProgress()

	if var_14_0 == 8 or var_14_0 == 9 then
		setActive(arg_14_0.starEffect, true)
		arg_14_0.starEffect:GetComponent("Animator"):Play("saoguang_anim", -1, 0)
	else
		setActive(arg_14_0.shieldEffect, true)
		arg_14_0.shieldEffect:GetComponent("Animator"):Play("saoguang_anim", -1, 0)
	end

	setActive(arg_14_0.mask, true)
	pg.UIMgr.GetInstance():OverlayPanel(arg_14_0.mask)

	return
end

function var_0_0.updateLevelPanel(arg_15_0)
	local var_15_0, var_15_1 = arg_15_0.ptData:GetBuffLevelProgress()

	setActive(arg_15_0.f2aPanel, false)
	setActive(arg_15_0.sPanel, false)
	setActive(arg_15_0.sssPanel, false)

	arg_15_0.curPanel = nil
	arg_15_0.curPanel = var_15_0 == 9 and arg_15_0.sssPanel or var_15_0 > 6 and arg_15_0.sPanel or arg_15_0.f2aPanel

	setActive(arg_15_0.curPanel, true)
	setImageSprite(arg_15_0.curPanel:Find("bar"), arg_15_0.lvBarImages:Find(var_15_0):GetComponent(typeof(Image)).sprite)
	setImageSprite(arg_15_0.curPanel:Find("lv_tag"), arg_15_0.lvTagImages:Find(var_15_0):GetComponent(typeof(Image)).sprite, true)
	setSlider(arg_15_0.curPanel, 0, 1, var_15_1)

	return arg_15_0.curPanel
end

function var_0_0.OnUpdateFlush(arg_16_0)
	setActive(arg_16_0.starEffect, false)
	setActive(arg_16_0.shieldEffect, false)

	local var_16_0 = arg_16_0.ptData:CanTrain()

	if var_16_0 and var_16_0 <= arg_16_0.ptData.level and arg_16_0.ptData:isInBuffTime() and not arg_16_0.contextData.singleActivity and not arg_16_0.isShowEffect then
		arg_16_0:showTrianPanel()
	end

	local var_16_1, var_16_2, var_16_3 = arg_16_0.ptData:GetLevelProgress()
	local var_16_4, var_16_5, var_16_6 = arg_16_0.ptData:GetResProgress()

	setText(arg_16_0.step, var_16_1 .. "/" .. var_16_2)

	local var_16_7 = var_16_6 >= 1 and setColorStr(var_16_4, COLOR_GREEN) or var_16_4

	setText(arg_16_0.progress, var_16_7 .. "/" .. var_16_5)
	setSlider(arg_16_0.slider, 0, 1, var_16_6)

	if not arg_16_0.isShowEffect then
		arg_16_0:updateLevelPanel()
	end

	local var_16_8 = arg_16_0.ptData:CanGetAward()
	local var_16_9 = arg_16_0.ptData:CanGetNextAward()
	local var_16_10 = arg_16_0.ptData:CanTrain()

	setActive(arg_16_0.battleBtn, arg_16_0.ptData:CanGetMorePt() and not var_16_8 and var_16_9)
	setActive(arg_16_0.getBtn, var_16_8)
	setActive(arg_16_0.getGreyBtn, not var_16_8)
	setActive(arg_16_0.gotBtn, not var_16_9 and not var_16_10)
	setActive(arg_16_0.buffModule, arg_16_0.ptData:isInBuffTime())
	updateDrop(arg_16_0.awardTF, (arg_16_0.ptData:GetAward()))
	onButton(arg_16_0, arg_16_0.awardTF, function()
		arg_16_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.ptData:GetCurBuffInfos()) do
		local var_16_12 = arg_16_0.buffLvs[iter_16_1.group]

		if iter_16_1.next then
			local var_16_13 = "LV." .. iter_16_1.lv or "MAX"

			var_16_11(var_16_12, var_16_13)
		end
	end

	return
end

function var_0_0.showTrianPanel(arg_18_0)
	setActive(arg_18_0.trainWindow, true)

	local var_18_0 = arg_18_0.ptData:GetCurBuffInfos()

	arg_18_0.selectIndex = nil
	arg_18_0.selectBuffId = nil
	arg_18_0.selectBuffLv = nil
	arg_18_0.selectNewBuffId = nil

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.trainSkillBtns) do
		onButton(arg_18_0, iter_18_1, function()
			for iter_19_0, iter_19_1 in ipairs(var_18_0) do
				if iter_18_0 == iter_19_1.group then
					if iter_19_1.next then
						arg_18_0.selectIndex = iter_18_0
						arg_18_0.selectBuffId = iter_19_1.id
						arg_18_0.selectNewBuffId = iter_19_1.next
						arg_18_0.selectBuffLv = iter_19_1.lv
					else
						arg_18_0.selectIndex = nil
						arg_18_0.selectBuffId = nil
						arg_18_0.selectNewBuffId = nil
						arg_18_0.selectBuffLv = nil
					end
				end
			end

			arg_18_0:flushTrainPanel()

			return
		end, SFX_PANEL)
	end

	onButton(arg_18_0, arg_18_0.trainBtn, function()
		arg_18_0:showMsgBox()

		return
	end, SFX_PANEL)
	;(function()
		for iter_21_0, iter_21_1 in ipairs(var_18_0) do
			if iter_21_1.next then
				arg_18_0.selectIndex = iter_21_1.group
				arg_18_0.selectBuffId = iter_21_1.id
				arg_18_0.selectNewBuffId = iter_21_1.next
				arg_18_0.selectBuffLv = iter_21_1.lv

				return
			end
		end

		return
	end)()
	arg_18_0:flushTrainPanel()

	return
end

function var_0_0.hideTrianPanel(arg_22_0)
	setActive(arg_22_0.trainWindow, false)

	return
end

function var_0_0.flushTrainPanel(arg_23_0)
	local var_23_0 = arg_23_0.ptData:GetCurBuffInfos()

	if var_23_0 then
		for iter_23_0, iter_23_1 in ipairs(var_23_0) do
			local var_23_2 = arg_23_0.trainSkillBtns[iter_23_1.group]:Find("lv_bg/lv")

			if iter_23_1.next then
				local var_23_3 = "LV." .. iter_23_1.lv or "MAX"

				var_23_1(var_23_2, var_23_3)
			end
		end
	end

	for iter_23_2, iter_23_3 in ipairs(arg_23_0.trainSkillBtns) do
		if iter_23_2 == arg_23_0.selectIndex then
			setActive(iter_23_3:Find("selected"), true)
		else
			setActive(iter_23_3:Find("selected"), false)
		end
	end

	if arg_23_0.selectIndex then
		setActive(arg_23_0.curInfoPanel, true)
		setActive(arg_23_0.trainBtn, true)
		setText(arg_23_0.curInfo, pg.benefit_buff_template[arg_23_0.selectBuffId].desc)
		setText(arg_23_0.nextInfo, pg.benefit_buff_template[arg_23_0.selectNewBuffId].desc)
	else
		setActive(arg_23_0.curInfoPanel, false)
		setActive(arg_23_0.trainBtn, false)
	end

	return
end

function var_0_0.getBuffNameIndex(arg_24_0, arg_24_1)
	if arg_24_1 == 35 or arg_24_1 == 36 or arg_24_1 == 37 then
		return 1
	elseif arg_24_1 == 38 or arg_24_1 == 39 or arg_24_1 == 40 then
		return 2
	elseif arg_24_1 == 41 or arg_24_1 == 42 or arg_24_1 == 43 then
		return 3
	elseif arg_24_1 == 44 or arg_24_1 == 45 or arg_24_1 == 46 then
		return 4
	end

	return 1
end

function var_0_0.getTip(arg_25_0, arg_25_1)
	if arg_25_1 == 35 or arg_25_1 == 36 or arg_25_1 == 37 then
		return i18n("doa_liliang")
	elseif arg_25_1 == 38 or arg_25_1 == 39 or arg_25_1 == 40 then
		return i18n("doa_jiqiao")
	elseif arg_25_1 == 41 or arg_25_1 == 42 or arg_25_1 == 43 then
		return i18n("doa_tili")
	elseif arg_25_1 == 44 or arg_25_1 == 45 or arg_25_1 == 46 then
		return i18n("doa_meili")
	end

	return ""
end

function var_0_0.showMsgBox(arg_26_0)
	if arg_26_0.selectBuffId then
		setActive(arg_26_0.msgBox, true)
		setText(arg_26_0.msgContent, i18n("doa_pt_up", arg_26_0:getTip(pg.benefit_buff_template[arg_26_0.selectBuffId].id)))
		onButton(arg_26_0, arg_26_0.msgBoxMask, function()
			arg_26_0:hideMsgBox()

			return
		end, SFX_PANEL)
		onButton(arg_26_0, arg_26_0.cancelBtn, function()
			arg_26_0:hideMsgBox()

			return
		end, SFX_PANEL)
		onButton(arg_26_0, arg_26_0.confirmBtn, function()
			arg_26_0:hideMsgBox()
			arg_26_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
				cmd = 3,
				activity_id = arg_26_0.ptData:GetId(),
				arg1 = arg_26_0.ptData:CanTrain(),
				arg2 = arg_26_0.selectNewBuffId,
				oldBuffId = arg_26_0.selectBuffId
			})
			arg_26_0:hideTrianPanel()
			arg_26_0:showTip(i18n("doa_pt_complete"))

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.hideMsgBox(arg_30_0)
	setActive(arg_30_0.msgBox, false)

	return
end

function var_0_0.showTip(arg_31_0, arg_31_1)
	local var_31_0 = cloneTplTo(arg_31_0.tipPanel, arg_31_0._tf)

	setActive(var_31_0, true)
	setText(var_31_0:Find("Text"), arg_31_1)

	var_31_0.transform.localScale = Vector3(0, 0.1, 1)

	LeanTween.scale(var_31_0, Vector3(1.8, 0.1, 1), 0.1):setUseEstimatedTime(true)
	LeanTween.scale(var_31_0, Vector3(1.1, 1.1, 1), 0.1):setDelay(0.1):setUseEstimatedTime(true)

	local var_31_1 = GetOrAddComponent(var_31_0, "CanvasGroup")

	Timer.New(function()
		if IsNil(var_31_0) then
			return
		end

		LeanTween.scale(var_31_0, Vector3(0.1, 1.5, 1), 0.1):setUseEstimatedTime(true):setOnComplete(System.Action(function()
			LeanTween.scale(var_31_0, Vector3.zero, 0.1):setUseEstimatedTime(true):setOnComplete(System.Action(function()
				Destroy(var_31_0)

				return
			end))

			return
		end))

		return
	end, 3):Start()

	return
end

function var_0_0.showBuffBox(arg_35_0)
	setActive(arg_35_0.buffBox, true)
	removeAllChildren(arg_35_0.buffIconParent)

	local var_35_0 = cloneTplTo(arg_35_0:updateLevelPanel(), arg_35_0.buffIconParent)

	setLocalPosition(var_35_0, Vector3(0, 0, 0))
	setLocalScale(var_35_0, Vector3(1.3, 1.3, 1))

	local var_35_1 = arg_35_0.ptData:GetCurBuffInfos()

	if var_35_1 then
		for iter_35_0, iter_35_1 in ipairs(var_35_1) do
			local var_35_2 = iter_35_0 <= arg_35_0.buffDescContent.childCount and arg_35_0.buffDescContent:GetChild(iter_35_0 - 1) or cloneTplTo(arg_35_0.buffDescTpl, arg_35_0.buffDescContent)

			setText(var_35_2, pg.benefit_buff_template[iter_35_1.id].name .. pg.benefit_buff_template[iter_35_1.id].desc)
		end
	end

	onButton(arg_35_0, arg_35_0.buffMask, function()
		setActive(arg_35_0.buffBox, false)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.showSingleBuffBox(arg_37_0)
	setActive(arg_37_0.singleBuffBox, true)
	pg.UIMgr.GetInstance():BlurPanel(arg_37_0.singleBuffBox)
	removeAllChildren(arg_37_0.singleIconParent)

	local var_37_0 = cloneTplTo(arg_37_0:updateLevelPanel(), arg_37_0.singleIconParent)

	setLocalPosition(var_37_0, Vector3(0, 0, 0))
	setLocalScale(var_37_0, Vector3(1.3, 1.3, 1))

	local var_37_1 = arg_37_0.ptData:GetCurBuffInfos()

	if var_37_1 then
		for iter_37_0, iter_37_1 in ipairs(var_37_1) do
			local var_37_2 = iter_37_0 <= arg_37_0.singleDescContent.childCount and arg_37_0.singleDescContent:GetChild(iter_37_0 - 1) or cloneTplTo(arg_37_0.singleDescTpl, arg_37_0.singleDescContent)

			setText(var_37_2, pg.benefit_buff_template[iter_37_1.id].name .. pg.benefit_buff_template[iter_37_1.id].desc)
		end
	end

	local function var_37_3()
		setActive(arg_37_0.singleBuffBox, false)
		arg_37_0:emit(ActivitySingleScene.EXIT)
		arg_37_0:emit(ActivitySingleScene.ON_CLOSE)
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_37_0.singleBuffBox, arg_37_0._tf)

		return
	end

	onButton(arg_37_0, arg_37_0.singleBuffMask, function()
		var_37_3()

		return
	end, SFX_PANEL)
	onButton(arg_37_0, arg_37_0.singleCloseBtn, function()
		var_37_3()

		return
	end, SFX_PANEL)
	onButton(arg_37_0, arg_37_0.singleSureBtn, function()
		var_37_3()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.onBackPressed(arg_42_0)
	if arg_42_0.contextData.singleActivity then
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_42_0.singleBuffBox, arg_42_0._tf)
	end

	return
end

function var_0_0.willExit(arg_43_0)
	if arg_43_0.contextData.singleActivity then
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_43_0.singleBuffBox, arg_43_0._tf)
	end

	return
end

return var_0_0
