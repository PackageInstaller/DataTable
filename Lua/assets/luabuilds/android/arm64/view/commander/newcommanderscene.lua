local var_0_0 = class("NewCommanderScene", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "GetCommanderUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.bgTF = arg_2_0._tf:Find("main/bg")
	arg_2_0.clickTF = arg_2_0._tf:Find("click")
	arg_2_0.paintTF = arg_2_0._tf:Find("main/paint")
	arg_2_0.paintTFCG = arg_2_0.paintTF:GetComponent(typeof(CanvasGroup))
	arg_2_0.infoTF = arg_2_0._tf:Find("main/info")
	arg_2_0.leftPanel = arg_2_0._tf:Find("left_panel")
	arg_2_0.lockBtn = arg_2_0._tf:Find("left_panel/btns/lock")
	arg_2_0.unlockBtn = arg_2_0._tf:Find("left_panel/btns/unlock")
	arg_2_0.shareBtn = arg_2_0._tf:Find("left_panel/btns/share")
	arg_2_0.nameTF = arg_2_0.infoTF:Find("content/name/value"):GetComponent(typeof(Text))
	arg_2_0.nationTF = arg_2_0.infoTF:Find("content/nation/value"):GetComponent(typeof(Text))
	arg_2_0.rarityTF = arg_2_0.infoTF:Find("content/rarity/value"):GetComponent(typeof(Image))
	arg_2_0.skillTF = arg_2_0.infoTF:Find("content/skill/value"):GetComponent(typeof(Text))
	arg_2_0.abilitysTF = arg_2_0.infoTF:Find("content/abilitys/attrs")
	arg_2_0.talentsTF = arg_2_0.infoTF:Find("content/talents")
	arg_2_0.talentsList = UIItemList.New(arg_2_0.talentsTF, arg_2_0.talentsTF:Find("talent"))
	arg_2_0.dateTF = arg_2_0.infoTF:Find("content/copyright/Text")
	arg_2_0.treePanel = CommanderTreePage.New(arg_2_0._tf, arg_2_0.event)
	arg_2_0.msgbox = CommanderMsgBoxPage.New(arg_2_0._tf, arg_2_0.event)
	arg_2_0.antor = arg_2_0._tf:GetComponent(typeof(Animator))
	arg_2_0.skipBtn = arg_2_0._tf:Find("skip")
	arg_2_0.getEffect = arg_2_0._tf:Find("main/effect")
	arg_2_0.skipAnim = true

	if pg.NewGuideMgr.GetInstance():IsBusy() then
		arg_2_0.skipAnim = false
	end

	pg.UIMgr.GetInstance():BlurPanel(arg_2_0._tf)
	setText(arg_2_0._tf:Find("main/info/content/abilitys/attrs/command/name/Text"), i18n("commander_command_ability"))
	setText(arg_2_0._tf:Find("main/info/content/abilitys/attrs/tactic/name/Text"), i18n("commander_tactical_ability"))
	setText(arg_2_0._tf:Find("main/info/content/abilitys/attrs/support/name/Text"), i18n("commander_logistics_ability"))
	setText(arg_2_0._tf:Find("main/info/content/copyright/title"), i18n("commander_get_commander_coptyright"))

	return
end

function var_0_0.openTreePanel(arg_3_0, arg_3_1)
	if arg_3_0.treePanel:GetLoaded() then
		(function()
			arg_3_0.treePanel:ActionInvoke("Show", arg_3_1)

			return
		end)()
	else
		arg_3_0.treePanel:Load()
		arg_3_0.treePanel:CallbackInvoke(function()
			arg_3_0.treePanel:ActionInvoke("Show", arg_3_1)

			return
		end)
	end

	return
end

function var_0_0.closeTreePanel(arg_5_0)
	arg_5_0.treePanel:ActionInvoke("closeTreePanel")

	return
end

function var_0_0.onUIAnimEnd(arg_6_0, arg_6_1)
	arg_6_0.antor:SetBool("play", true)

	arg_6_0.isAnim = true

	setActive(arg_6_0.clickTF, arg_6_0.skipAnim)

	local var_6_0 = arg_6_0._tf:GetComponent(typeof(DftAniEvent))

	var_6_0:SetTriggerEvent(function(arg_7_0)
		if arg_6_0.contextData.commander:isSSR() then
			arg_6_0:playerEffect()
		end

		var_6_0:SetTriggerEvent(nil)

		return
	end)
	var_6_0:SetEndEvent(function()
		arg_6_0.isAnim = false

		setActive(arg_6_0.clickTF, true)
		var_6_0:SetEndEvent(nil)
		arg_6_1()

		return
	end)

	return
end

function var_0_0.playerEffect(arg_9_0)
	PoolMgr.GetInstance():GetUI("AL_zhihuimiao_zhipian", true, function(arg_10_0)
		arg_9_0.effect = arg_10_0

		SetParent(arg_10_0, arg_9_0._tf)
		setActive(arg_10_0, true)

		return
	end)

	return
end

function var_0_0.openMsgBox(arg_11_0, arg_11_1)
	arg_11_0.isShowMsgBox = true

	if arg_11_0.msgbox:GetLoaded() then
		(function()
			arg_11_0.msgbox:ActionInvoke("Show", arg_11_1)

			return
		end)()
	else
		arg_11_0.msgbox:Load()
		arg_11_0.msgbox:CallbackInvoke(function()
			arg_11_0.msgbox:ActionInvoke("Show", arg_11_1)

			return
		end)
	end

	return
end

function var_0_0.closeMsgBox(arg_13_0)
	arg_13_0.isShowMsgBox = nil

	arg_13_0.msgbox:ActionInvoke("Hide")

	return
end

function var_0_0.didEnter(arg_14_0)
	arg_14_0:updateInfo()
	onButton(arg_14_0, arg_14_0.shareBtn, function()
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeCommander, pg.ShareMgr.PANEL_TYPE_PINK)

		return
	end, SFX_PANEL)
	onButton(arg_14_0, arg_14_0.skipBtn, function(arg_16_0)
		if arg_14_0.isAnim then
			return
		end

		getProxy(CommanderProxy).hasSkipFlag = true

		arg_14_0:DoExit()

		return
	end, SFX_CANCEL)
	onButton(arg_14_0, arg_14_0.lockBtn, function()
		arg_14_0:emit(NewCommanderMediator.ON_LOCK, arg_14_0.contextData.commander.id, 1 - getProxy(CommanderProxy):getCommanderById(arg_14_0.contextData.commander.id):getLock())

		return
	end, SFX_PANEL)
	onButton(arg_14_0, arg_14_0.unlockBtn, function()
		arg_14_0:emit(NewCommanderMediator.ON_LOCK, arg_14_0.contextData.commander.id, 1 - getProxy(CommanderProxy):getCommanderById(arg_14_0.contextData.commander.id):getLock())

		return
	end, SFX_PANEL)
	onButton(arg_14_0, arg_14_0.clickTF, function()
		if arg_14_0.isAnim then
			arg_14_0.antor:SetBool("play", false)

			if arg_14_0.contextData.commander:isSSR() and not arg_14_0.effect then
				arg_14_0:playerEffect()
			end

			arg_14_0.isAnim = nil
		else
			arg_14_0:DoExit()
		end

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.DoExit(arg_20_0)
	if arg_20_0.contextData.commander:ShouldTipLock() then
		arg_20_0:openMsgBox({
			content = i18n("commander_lock_tip"),
			onYes = function()
				arg_20_0:emit(NewCommanderMediator.ON_LOCK, arg_20_0.contextData.commander.id, 1)
				arg_20_0:emit(var_0_0.ON_CLOSE)

				return
			end,
			onNo = function()
				arg_20_0:emit(var_0_0.ON_CLOSE)

				return
			end
		})
	else
		arg_20_0:emit(var_0_0.ON_CLOSE)
	end

	return
end

function var_0_0.updateLockState(arg_23_0)
	local var_23_0 = getProxy(CommanderProxy):getCommanderById(arg_23_0.contextData.commander.id):getLock()

	setActive(arg_23_0.lockBtn, var_23_0 ~= 0)
	setActive(arg_23_0.unlockBtn, var_23_0 == 0)

	return
end

function var_0_0.updateInfo(arg_24_0, arg_24_1)
	arg_24_0:updateLockState(arg_24_0.contextData.commander:getLock())

	arg_24_0.nameTF.text = arg_24_0.contextData.commander:getName()
	arg_24_0.nationTF.text = Nation.Nation2Name(arg_24_0.contextData.commander:getConfig("nationality"))
	arg_24_0.skillTF.text = arg_24_0.contextData.commander:getSkills()[1]:getConfig("name")

	LoadImageSpriteAsync("CommanderRarity/" .. Commander.rarity2Print(arg_24_0.contextData.commander:getRarity()), arg_24_0.rarityTF, true)
	setCommanderPaintingPrefab(arg_24_0.paintTF, arg_24_0.contextData.commander:getPainting(), "get")

	arg_24_0.painting = arg_24_0.contextData.commander

	arg_24_0:updateAbilitys()
	arg_24_0:updateTalents()
	setText(arg_24_0.dateTF, pg.TimeMgr.GetInstance():CurrentSTimeDesc("%y%m%d"))

	if arg_24_1 then
		arg_24_1()
	end

	return
end

function var_0_0.updateAbilitys(arg_25_0)
	local var_25_0 = arg_25_0.contextData.commander:getAbilitys()

	eachChild(arg_25_0.abilitysTF, function(arg_26_0)
		local var_26_0 = var_25_0[go(arg_26_0).name]

		setText(arg_26_0:Find("slider/point"), var_26_0.value)

		arg_26_0:Find("slider"):GetComponent(typeof(Slider)).value = var_26_0.value / CommanderConst.MAX_ABILITY

		return
	end)

	return
end

function var_0_0.updateTalents(arg_27_0)
	local var_27_0 = arg_27_0.contextData.commander:getTalents()

	arg_27_0.talentsList:make(function(arg_28_0, arg_28_1, arg_28_2)
		if arg_28_0 == UIItemList.EventUpdate then
			local var_28_0 = var_27_0[arg_28_1 + 1]

			setActive(arg_28_2:Find("empty"), not var_27_0[arg_28_1 + 1])
			setActive(arg_28_2:Find("icon"), var_27_0[arg_28_1 + 1])

			if var_27_0[arg_28_1 + 1] then
				GetImageSpriteFromAtlasAsync("CommanderTalentIcon/" .. var_27_0[arg_28_1 + 1]:getConfig("icon"), "", arg_28_2:Find("icon"))
			end

			onButton(arg_27_0, arg_28_2, function()
				arg_27_0:openTreePanel(var_28_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	arg_27_0.talentsList:align(3)

	return
end

function var_0_0.onBackPressed(arg_30_0)
	if arg_30_0.isShowMsgBox then
		arg_30_0:closeMsgBox()

		return
	end

	return
end

function var_0_0.willExit(arg_31_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_31_0._tf, pg.UIMgr.GetInstance().UIMain)
	arg_31_0.treePanel:Destroy()
	arg_31_0.msgbox:Destroy()
	retCommanderPaintingPrefab(arg_31_0.paintTF, arg_31_0.painting:getPainting())

	if arg_31_0.effect then
		PoolMgr.GetInstance():ReturnUI("AL_zhihuimiao_zhipian", arg_31_0.effect)
	end

	if arg_31_0.contextData.onExit then
		arg_31_0.contextData.onExit()
	end

	return
end

return var_0_0
